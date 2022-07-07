Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E15696FD
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 02:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiGGAlc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 6 Jul 2022 20:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiGGAlb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 20:41:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DBB2BB1E
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 17:41:30 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266L6ojB010607
        for <bpf@vger.kernel.org>; Wed, 6 Jul 2022 17:41:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4ubv2mjr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 17:41:30 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 6 Jul 2022 17:41:28 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 422831BFE360D; Wed,  6 Jul 2022 17:41:22 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH RFC bpf-next 1/3] libbpf: improve and rename BPF_KPROBE_SYSCALL
Date:   Wed, 6 Jul 2022 17:41:16 -0700
Message-ID: <20220707004118.298323-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707004118.298323-1-andrii@kernel.org>
References: <20220707004118.298323-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jmxSqVeVvnX15br5TPQI590vQ3kydpLF
X-Proofpoint-GUID: jmxSqVeVvnX15br5TPQI590vQ3kydpLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Improve BPF_KPROBE_SYSCALL (and rename it to shorter BPF_KSYSCALL to
match libbpf's SEC("ksyscall") section name, added in next patch) to use
__kconfig variable to determine how to properly fetch syscall arguments.

Instead of relying on hard-coded knowledge of whether kernel's
architecture uses syscall wrapper or not (which only reflects the latest
kernel versions, but is not necessarily true for older kernels and won't
necessarily hold for later kernel versions on some particular host
architecture), determine this at runtime through
CONFIG_ARCH_HAS_SYSCALL_WRAPPER __kconfig variable and proceed
accordingly.

If host kernel defines CONFIG_ARCH_HAS_SYSCALL_WRAPPER, syscall kernel
function's first argument is a pointer to struct pt_regs that then
contains syscall arguments. In such case we need to use
bpf_probe_read_kernel() to fetch actual arguments (which we do through
BPF_CORE_READ() macro) from inner pt_regs.

But if the kernel doesn't use syscall wrapper approach, input
arguments can be read from struct pt_regs directly with no probe reading.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 44 +++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 01ce121c302d..948bedbfd24e 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -2,6 +2,8 @@
 #ifndef __BPF_TRACING_H__
 #define __BPF_TRACING_H__
 
+#include <bpf/bpf_helpers.h>
+
 /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
 #if defined(__TARGET_ARCH_x86)
 	#define bpf_target_x86
@@ -140,7 +142,7 @@ struct pt_regs___s390 {
 #define __PT_RC_REG gprs[2]
 #define __PT_SP_REG gprs[15]
 #define __PT_IP_REG psw.addr
-#define PT_REGS_PARM1_SYSCALL(x) ({ _Pragma("GCC error \"use PT_REGS_PARM1_CORE_SYSCALL() instead\""); 0l; })
+#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
 #define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ((const struct pt_regs___s390 *)(x), orig_gpr2)
 
 #elif defined(bpf_target_arm)
@@ -174,7 +176,7 @@ struct pt_regs___arm64 {
 #define __PT_RC_REG regs[0]
 #define __PT_SP_REG sp
 #define __PT_IP_REG pc
-#define PT_REGS_PARM1_SYSCALL(x) ({ _Pragma("GCC error \"use PT_REGS_PARM1_CORE_SYSCALL() instead\""); 0l; })
+#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
 #define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ((const struct pt_regs___arm64 *)(x), orig_x0)
 
 #elif defined(bpf_target_mips)
@@ -493,16 +495,26 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 }									    \
 static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 
+/* if CONFIG_ARCH_HAS_SYSCALL_WRAPPER IS NOT defined, read pt_regs directly */
 #define ___bpf_syscall_args0()           ctx
-#define ___bpf_syscall_args1(x)          ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
-#define ___bpf_syscall_args2(x, args...) ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
-#define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
-#define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
-#define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args1(x)          ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_SYSCALL(regs)
+#define ___bpf_syscall_args2(x, args...) ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_SYSCALL(regs)
+#define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_SYSCALL(regs)
+#define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_SYSCALL(regs)
+#define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_SYSCALL(regs)
 #define ___bpf_syscall_args(args...)     ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
 
+/* if CONFIG_ARCH_HAS_SYSCALL_WRAPPER IS defined, we have to BPF_CORE_READ from pt_regs */
+#define ___bpf_syswrap_args0()           ctx
+#define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args3(x, args...) ___bpf_syswrap_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args4(x, args...) ___bpf_syswrap_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args5(x, args...) ___bpf_syswrap_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args(args...)     ___bpf_apply(___bpf_syswrap_args, ___bpf_narg(args))(args)
+
 /*
- * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
+ * BPF_KSYSCALL is a variant of BPF_KPROBE, which is intended for
  * tracing syscall functions, like __x64_sys_close. It hides the underlying
  * platform-specific low-level way of getting syscall input arguments from
  * struct pt_regs, and provides a familiar typed and named function arguments
@@ -511,21 +523,29 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
  * Original struct pt_regs* context is preserved as 'ctx' argument. This might
  * be necessary when using BPF helpers like bpf_perf_event_output().
  *
- * This macro relies on BPF CO-RE support.
+ * This macro relies on BPF CO-RE support and __kconfig externs.
  */
-#define BPF_KPROBE_SYSCALL(name, args...)				    \
+#define BPF_KSYSCALL(name, args...)					    \
 name(struct pt_regs *ctx);						    \
+extern _Bool CONFIG_ARCH_HAS_SYSCALL_WRAPPER __kconfig __weak;		    \
 static __attribute__((always_inline)) typeof(name(0))			    \
 ____##name(struct pt_regs *ctx, ##args);				    \
 typeof(name(0)) name(struct pt_regs *ctx)				    \
 {									    \
-	struct pt_regs *regs = PT_REGS_SYSCALL_REGS(ctx);		    \
+	struct pt_regs *regs = CONFIG_ARCH_HAS_SYSCALL_WRAPPER		    \
+			       ? (struct pt_regs *)PT_REGS_PARM1(ctx)	    \
+			       : ctx;					    \
 	_Pragma("GCC diagnostic push")					    \
 	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")		    \
-	return ____##name(___bpf_syscall_args(args));			    \
+	if (CONFIG_ARCH_HAS_SYSCALL_WRAPPER)				    \
+		return ____##name(___bpf_syswrap_args(args));		    \
+	else								    \
+		return ____##name(___bpf_syscall_args(args));		    \
 	_Pragma("GCC diagnostic pop")					    \
 }									    \
 static __attribute__((always_inline)) typeof(name(0))			    \
 ____##name(struct pt_regs *ctx, ##args)
 
+#define BPF_KPROBE_SYSCALL BPF_KSYSCALL
+
 #endif
-- 
2.30.2


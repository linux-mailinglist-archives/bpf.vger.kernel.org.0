Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB2857457C
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 09:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiGNHIU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 14 Jul 2022 03:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiGNHIT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 03:08:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C592CDDA
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 00:08:18 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E6xta0021546
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 00:08:18 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5f9bfe-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 00:08:18 -0700
Received: from twshared18443.03.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 00:08:14 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A5C681C50A1D9; Thu, 14 Jul 2022 00:08:02 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 3/5] libbpf: improve BPF_KPROBE_SYSCALL macro and rename it to BPF_KSYSCALL
Date:   Thu, 14 Jul 2022 00:07:53 -0700
Message-ID: <20220714070755.3235561-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714070755.3235561-1-andrii@kernel.org>
References: <20220714070755.3235561-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vlull-Lmaw_EkPdC849bF4m5XfoGeaLb
X-Proofpoint-GUID: vlull-Lmaw_EkPdC849bF4m5XfoGeaLb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_04,2022-07-13_03,2022-06-22_01
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
architecture), determine this at runtime by attempting to create
perf_event (with fallback to kprobe event creation through tracefs on
legacy kernels, just like kprobe attachment code is doing) for kernel
function that would correspond to bpf() syscall on a system that has
CONFIG_ARCH_HAS_SYSCALL_WRAPPER set (e.g., for x86-64 it would try
'__x64_sys_bpf').

If host kernel uses syscall wrapper, syscall kernel function's first
argument is a pointer to struct pt_regs that then contains syscall
arguments. In such case we need to use bpf_probe_read_kernel() to fetch
actual arguments (which we do through BPF_CORE_READ() macro) from inner
pt_regs.

But if the kernel doesn't use syscall wrapper approach, input
arguments can be read from struct pt_regs directly with no probe reading.

All this feature detection is done without requiring /proc/config.gz
existence and parsing, and BPF-side helper code uses newly added
LINUX_HAS_SYSCALL_WRAPPER virtual __kconfig extern to keep in sync with
user-side feature detection of libbpf.

BPF_KSYSCALL() macro can be used both with SEC("kprobe") programs that
define syscall function explicitly (e.g., SEC("kprobe/__x64_sys_bpf"))
and SEC("ksyscall") program added in the next patch (which are the same
kprobe program with added benefit of libbpf determining correct kernel
function name automatically).

Kretprobe and kretsyscall (added in next patch) programs don't need
BPF_KSYSCALL as they don't provide access to input arguments. Normal
BPF_KRETPROBE is completely sufficient and is recommended.

Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 51 +++++++++++++++++++++++++++----------
 tools/lib/bpf/libbpf.c      |  2 ++
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 11f9096407fc..f4d3e1e2abe2 100644
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
@@ -493,39 +495,62 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 }									    \
 static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 
+/* If kernel has CONFIG_ARCH_HAS_SYSCALL_WRAPPER, read pt_regs directly */
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
 
+/* If kernel doesn't have CONFIG_ARCH_HAS_SYSCALL_WRAPPER, we have to BPF_CORE_READ from pt_regs */
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
  * syntax and semantics of accessing syscall input parameters.
  *
- * Original struct pt_regs* context is preserved as 'ctx' argument. This might
+ * Original struct pt_regs * context is preserved as 'ctx' argument. This might
  * be necessary when using BPF helpers like bpf_perf_event_output().
  *
- * This macro relies on BPF CO-RE support.
+ * At the moment BPF_KSYSCALL does not handle all the calling convention
+ * quirks for mmap(), clone() and compat syscalls transparrently. This may or
+ * may not change in the future. User needs to take extra measures to handle
+ * such quirks explicitly, if necessary.
+ *
+ * This macro relies on BPF CO-RE support and virtual __kconfig externs.
  */
-#define BPF_KPROBE_SYSCALL(name, args...)				    \
+#define BPF_KSYSCALL(name, args...)					    \
 name(struct pt_regs *ctx);						    \
+extern _Bool LINUX_HAS_SYSCALL_WRAPPER __kconfig;			    \
 static __attribute__((always_inline)) typeof(name(0))			    \
 ____##name(struct pt_regs *ctx, ##args);				    \
 typeof(name(0)) name(struct pt_regs *ctx)				    \
 {									    \
-	struct pt_regs *regs = PT_REGS_SYSCALL_REGS(ctx);		    \
+	struct pt_regs *regs = LINUX_HAS_SYSCALL_WRAPPER		    \
+			       ? (struct pt_regs *)PT_REGS_PARM1(ctx)	    \
+			       : ctx;					    \
 	_Pragma("GCC diagnostic push")					    \
 	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")		    \
-	return ____##name(___bpf_syscall_args(args));			    \
+	if (LINUX_HAS_SYSCALL_WRAPPER)					    \
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
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ee3176859e76..eb35a20a33f6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7534,6 +7534,8 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 				}
 			} else if (strcmp(ext->name, "LINUX_HAS_BPF_COOKIE") == 0) {
 				value = kernel_supports(obj, FEAT_BPF_COOKIE);
+			} else if (strcmp(ext->name, "LINUX_HAS_SYSCALL_WRAPPER") == 0) {
+				value = kernel_supports(obj, FEAT_SYSCALL_WRAPPER);
 			} else if (!str_has_pfx(ext->name, "LINUX_") || !ext->is_weak) {
 				/* Currently libbpf supports only CONFIG_ and LINUX_ prefixed
 				 * __kconfig externs, where LINUX_ ones are virtual and filled out
-- 
2.30.2


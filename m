Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AC8675E91
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjATUJ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjATUJZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:25 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D2C668
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:24 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KDiY4m023390
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:23 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n6vy6vfyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:23 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:21 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B7B2325B4AFCA; Fri, 20 Jan 2023 12:09:17 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next 01/25] libbpf: add support for fetching up to 8 arguments in kprobes
Date:   Fri, 20 Jan 2023 12:08:50 -0800
Message-ID: <20230120200914.3008030-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8nTzS0yBGxUKUqwQxa7X-A06C9gBgKXo
X-Proofpoint-GUID: 8nTzS0yBGxUKUqwQxa7X-A06C9gBgKXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BPF_KPROBE() and PT_REGS_PARMx() support for up to 8 arguments, if
target architecture supports this. Currently all architectures are
limited to only 5 register-placed arguments, which is limiting even on
x86-64.

This patch adds generic macro machinery to support up to 8 arguments
both when explicitly fetching it from pt_regs through PT_REGS_PARMx()
macros, as well as more ergonomic access in BPF_KPROBE().

Also, for i386 architecture we now don't have to define fake PARM4 and
PARM5 definitions, they will be generically substituted, just like for
PARM6 through PARM8.

Subsequent patches will fill out architecture-specific definitions,
where appropriate.

Tested-by: Alan Maguire <alan.maguire@oracle.com> # arm64
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com> # s390x
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 41 +++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index bdb0f6b5be84..ef17d8fdd9d6 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -98,12 +98,10 @@
 
 #ifdef __i386__
 
+/* i386 kernel is built with -mregparm=3 */
 #define __PT_PARM1_REG eax
 #define __PT_PARM2_REG edx
 #define __PT_PARM3_REG ecx
-/* i386 kernel is built with -mregparm=3 */
-#define __PT_PARM4_REG __unsupported__
-#define __PT_PARM5_REG __unsupported__
 #define __PT_RET_REG esp
 #define __PT_FP_REG ebp
 #define __PT_RC_REG eax
@@ -287,16 +285,39 @@ struct pt_regs___arm64 {
 
 struct pt_regs;
 
-/* allow some architecutres to override `struct pt_regs` */
+/* allow some architectures to override `struct pt_regs` */
 #ifndef __PT_REGS_CAST
 #define __PT_REGS_CAST(x) (x)
 #endif
 
+/*
+ * Different architectures support different number of arguments passed
+ * through registers. i386 supports just 3, some arches support up to 8.
+ */
+#ifndef __PT_PARM4_REG
+#define __PT_PARM4_REG __unsupported__
+#endif
+#ifndef __PT_PARM5_REG
+#define __PT_PARM5_REG __unsupported__
+#endif
+#ifndef __PT_PARM6_REG
+#define __PT_PARM6_REG __unsupported__
+#endif
+#ifndef __PT_PARM7_REG
+#define __PT_PARM7_REG __unsupported__
+#endif
+#ifndef __PT_PARM8_REG
+#define __PT_PARM8_REG __unsupported__
+#endif
+
 #define PT_REGS_PARM1(x) (__PT_REGS_CAST(x)->__PT_PARM1_REG)
 #define PT_REGS_PARM2(x) (__PT_REGS_CAST(x)->__PT_PARM2_REG)
 #define PT_REGS_PARM3(x) (__PT_REGS_CAST(x)->__PT_PARM3_REG)
 #define PT_REGS_PARM4(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG)
 #define PT_REGS_PARM5(x) (__PT_REGS_CAST(x)->__PT_PARM5_REG)
+#define PT_REGS_PARM6(x) (__PT_REGS_CAST(x)->__PT_PARM6_REG)
+#define PT_REGS_PARM7(x) (__PT_REGS_CAST(x)->__PT_PARM7_REG)
+#define PT_REGS_PARM8(x) (__PT_REGS_CAST(x)->__PT_PARM8_REG)
 #define PT_REGS_RET(x) (__PT_REGS_CAST(x)->__PT_RET_REG)
 #define PT_REGS_FP(x) (__PT_REGS_CAST(x)->__PT_FP_REG)
 #define PT_REGS_RC(x) (__PT_REGS_CAST(x)->__PT_RC_REG)
@@ -308,6 +329,9 @@ struct pt_regs;
 #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_REG)
 #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG)
 #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_REG)
+#define PT_REGS_PARM6_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM6_REG)
+#define PT_REGS_PARM7_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM7_REG)
+#define PT_REGS_PARM8_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM8_REG)
 #define PT_REGS_RET_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_RET_REG)
 #define PT_REGS_FP_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_FP_REG)
 #define PT_REGS_RC_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_RC_REG)
@@ -360,6 +384,9 @@ struct pt_regs;
 #define PT_REGS_PARM3(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM4(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM5(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM6(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM7(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM8(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_RET(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_FP(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_RC(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
@@ -371,6 +398,9 @@ struct pt_regs;
 #define PT_REGS_PARM3_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM4_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM5_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM6_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM7_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM8_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_RET_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_FP_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_RC_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
@@ -576,6 +606,9 @@ struct pt_regs;
 #define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args), (void *)PT_REGS_PARM3(ctx)
 #define ___bpf_kprobe_args4(x, args...) ___bpf_kprobe_args3(args), (void *)PT_REGS_PARM4(ctx)
 #define ___bpf_kprobe_args5(x, args...) ___bpf_kprobe_args4(args), (void *)PT_REGS_PARM5(ctx)
+#define ___bpf_kprobe_args6(x, args...) ___bpf_kprobe_args5(args), (void *)PT_REGS_PARM6(ctx)
+#define ___bpf_kprobe_args7(x, args...) ___bpf_kprobe_args6(args), (void *)PT_REGS_PARM7(ctx)
+#define ___bpf_kprobe_args8(x, args...) ___bpf_kprobe_args7(args), (void *)PT_REGS_PARM8(ctx)
 #define ___bpf_kprobe_args(args...)     ___bpf_apply(___bpf_kprobe_args, ___bpf_narg(args))(args)
 
 /*
-- 
2.30.2


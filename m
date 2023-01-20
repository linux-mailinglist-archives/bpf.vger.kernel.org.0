Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC53E675EA1
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjATUKB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjATUJx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:53 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87248AA7E0
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:51 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KDb3aY019632
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:50 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7gdede80-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:50 -0800
Received: from twshared16837.02.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4F87F25B4B0F0; Fri, 20 Jan 2023 12:09:40 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 12/25] libbpf: improve syscall tracing support in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:09:01 -0800
Message-ID: <20230120200914.3008030-13-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jU2DvNwwCvxOs2IQw7XeBfKwaYVsl81-
X-Proofpoint-ORIG-GUID: jU2DvNwwCvxOs2IQw7XeBfKwaYVsl81-
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

Set up generic support in bpf_tracing.h for up to 7 syscall arguments
tracing with BPF_KSYSCALL, which seems to be the limit according to
syscall(2) manpage. Also change the way that syscall convention is
specified to be more explicit. Subsequent patches will adjust and define
proper per-architecture syscall conventions.

__PT_PARM1_SYSCALL_REG through __PT_PARM6_SYSCALL_REG is added
temporarily to keep everything working before each architecture has
syscall reg tables defined. They will be removed afterwards.

Tested-by: Alan Maguire <alan.maguire@oracle.com> # arm64
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 71 ++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 9c4246fe8799..e3bf510e1e55 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -367,6 +367,34 @@ struct pt_regs;
 #ifndef __PT_PARM8_REG
 #define __PT_PARM8_REG __unsupported__
 #endif
+/*
+ * Similarly, syscall-specific conventions might differ between function call
+ * conventions within each architecutre. All supported architectures pass
+ * either 6 or 7 syscall arguments in registers.
+ *
+ * See syscall(2) manpage for succinct table with information on each arch.
+ */
+#ifndef __PT_PARM1_SYSCALL_REG
+#define __PT_PARM1_SYSCALL_REG __PT_PARM1_REG
+#endif
+#ifndef __PT_PARM2_SYSCALL_REG
+#define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
+#endif
+#ifndef __PT_PARM3_SYSCALL_REG
+#define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
+#endif
+#ifndef __PT_PARM4_SYSCALL_REG
+#define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
+#endif
+#ifndef __PT_PARM5_SYSCALL_REG
+#define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
+#endif
+#ifndef __PT_PARM6_SYSCALL_REG
+#define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
+#endif
+#ifndef __PT_PARM7_SYSCALL_REG
+#define __PT_PARM7_SYSCALL_REG __unsupported__
+#endif
 
 #define PT_REGS_PARM1(x) (__PT_REGS_CAST(x)->__PT_PARM1_REG)
 #define PT_REGS_PARM2(x) (__PT_REGS_CAST(x)->__PT_PARM2_REG)
@@ -416,24 +444,33 @@ struct pt_regs;
 #endif
 
 #ifndef PT_REGS_PARM1_SYSCALL
-#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
+#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM1_SYSCALL_REG)
+#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM1_SYSCALL_REG)
+#endif
+#ifndef PT_REGS_PARM2_SYSCALL
+#define PT_REGS_PARM2_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM2_SYSCALL_REG)
+#define PT_REGS_PARM2_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM2_SYSCALL_REG)
+#endif
+#ifndef PT_REGS_PARM3_SYSCALL
+#define PT_REGS_PARM3_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM3_SYSCALL_REG)
+#define PT_REGS_PARM3_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_SYSCALL_REG)
 #endif
-#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
-#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
 #ifndef PT_REGS_PARM4_SYSCALL
-#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
+#define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_SYSCALL_REG)
+#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_SYSCALL_REG)
 #endif
-#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
-
-#ifndef PT_REGS_PARM1_CORE_SYSCALL
-#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
+#ifndef PT_REGS_PARM5_SYSCALL
+#define PT_REGS_PARM5_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM5_SYSCALL_REG)
+#define PT_REGS_PARM5_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_SYSCALL_REG)
+#endif
+#ifndef PT_REGS_PARM6_SYSCALL
+#define PT_REGS_PARM6_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM6_SYSCALL_REG)
+#define PT_REGS_PARM6_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM6_SYSCALL_REG)
 #endif
-#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
-#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
-#ifndef PT_REGS_PARM4_CORE_SYSCALL
-#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
+#ifndef PT_REGS_PARM7_SYSCALL
+#define PT_REGS_PARM7_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM7_SYSCALL_REG)
+#define PT_REGS_PARM7_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM7_SYSCALL_REG)
 #endif
-#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
 
 #else /* defined(bpf_target_defined) */
 
@@ -473,12 +510,16 @@ struct pt_regs;
 #define PT_REGS_PARM3_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM4_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM5_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM6_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM7_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 
 #define PT_REGS_PARM1_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM2_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM3_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM4_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM5_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM6_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM7_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 
 #endif /* defined(bpf_target_defined) */
 
@@ -723,6 +764,8 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 #define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_SYSCALL(regs)
 #define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_SYSCALL(regs)
 #define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_SYSCALL(regs)
+#define ___bpf_syscall_args6(x, args...) ___bpf_syscall_args5(args), (void *)PT_REGS_PARM6_SYSCALL(regs)
+#define ___bpf_syscall_args7(x, args...) ___bpf_syscall_args6(args), (void *)PT_REGS_PARM7_SYSCALL(regs)
 #define ___bpf_syscall_args(args...)     ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
 
 /* If kernel doesn't have CONFIG_ARCH_HAS_SYSCALL_WRAPPER, we have to BPF_CORE_READ from pt_regs */
@@ -732,6 +775,8 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 #define ___bpf_syswrap_args3(x, args...) ___bpf_syswrap_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
 #define ___bpf_syswrap_args4(x, args...) ___bpf_syswrap_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
 #define ___bpf_syswrap_args5(x, args...) ___bpf_syswrap_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args6(x, args...) ___bpf_syswrap_args5(args), (void *)PT_REGS_PARM6_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args7(x, args...) ___bpf_syswrap_args6(args), (void *)PT_REGS_PARM7_CORE_SYSCALL(regs)
 #define ___bpf_syswrap_args(args...)     ___bpf_apply(___bpf_syswrap_args, ___bpf_narg(args))(args)
 
 /*
-- 
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2356447D8E2
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 22:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbhLVVjj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Dec 2021 16:39:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11124 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237184AbhLVVje (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 16:39:34 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMHx0Yg006592
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 13:39:33 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d47tm1rfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 13:39:33 -0800
Received: from twshared25651.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 13:39:32 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 860FFDE5B0E3; Wed, 22 Dec 2021 13:39:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/2] libbpf: use 100-character limit to make bpf_tracing.h easier to read
Date:   Wed, 22 Dec 2021 13:39:24 -0800
Message-ID: <20211222213924.1869758-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211222213924.1869758-1-andrii@kernel.org>
References: <20211222213924.1869758-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RlqVYYgzQdJhLQESuPG31yPwQsNavr9N
X-Proofpoint-GUID: RlqVYYgzQdJhLQESuPG31yPwQsNavr9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 adultscore=0 clxscore=1034 mlxlogscore=753 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Improve bpf_tracing.h's macro definition readability by keeping them
single-line and better aligned. This makes it easier to follow all those
variadic patterns.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 54 +++++++++++++++----------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 20fe06d0acd9..90f56b0f585f 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -302,25 +302,23 @@ struct pt_regs;
 #define ___bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, N, ...) N
 #endif
 #ifndef ___bpf_narg
-#define ___bpf_narg(...) \
-	___bpf_nth(_, ##__VA_ARGS__, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+#define ___bpf_narg(...) ___bpf_nth(_, ##__VA_ARGS__, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
 #endif
 
-#define ___bpf_ctx_cast0() ctx
-#define ___bpf_ctx_cast1(x) ___bpf_ctx_cast0(), (void *)ctx[0]
-#define ___bpf_ctx_cast2(x, args...) ___bpf_ctx_cast1(args), (void *)ctx[1]
-#define ___bpf_ctx_cast3(x, args...) ___bpf_ctx_cast2(args), (void *)ctx[2]
-#define ___bpf_ctx_cast4(x, args...) ___bpf_ctx_cast3(args), (void *)ctx[3]
-#define ___bpf_ctx_cast5(x, args...) ___bpf_ctx_cast4(args), (void *)ctx[4]
-#define ___bpf_ctx_cast6(x, args...) ___bpf_ctx_cast5(args), (void *)ctx[5]
-#define ___bpf_ctx_cast7(x, args...) ___bpf_ctx_cast6(args), (void *)ctx[6]
-#define ___bpf_ctx_cast8(x, args...) ___bpf_ctx_cast7(args), (void *)ctx[7]
-#define ___bpf_ctx_cast9(x, args...) ___bpf_ctx_cast8(args), (void *)ctx[8]
+#define ___bpf_ctx_cast0()            ctx
+#define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0]
+#define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)ctx[1]
+#define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
+#define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), (void *)ctx[3]
+#define ___bpf_ctx_cast5(x, args...)  ___bpf_ctx_cast4(args), (void *)ctx[4]
+#define ___bpf_ctx_cast6(x, args...)  ___bpf_ctx_cast5(args), (void *)ctx[5]
+#define ___bpf_ctx_cast7(x, args...)  ___bpf_ctx_cast6(args), (void *)ctx[6]
+#define ___bpf_ctx_cast8(x, args...)  ___bpf_ctx_cast7(args), (void *)ctx[7]
+#define ___bpf_ctx_cast9(x, args...)  ___bpf_ctx_cast8(args), (void *)ctx[8]
 #define ___bpf_ctx_cast10(x, args...) ___bpf_ctx_cast9(args), (void *)ctx[9]
 #define ___bpf_ctx_cast11(x, args...) ___bpf_ctx_cast10(args), (void *)ctx[10]
 #define ___bpf_ctx_cast12(x, args...) ___bpf_ctx_cast11(args), (void *)ctx[11]
-#define ___bpf_ctx_cast(args...) \
-	___bpf_apply(___bpf_ctx_cast, ___bpf_narg(args))(args)
+#define ___bpf_ctx_cast(args...)      ___bpf_apply(___bpf_ctx_cast, ___bpf_narg(args))(args)
 
 /*
  * BPF_PROG is a convenience wrapper for generic tp_btf/fentry/fexit and
@@ -353,19 +351,13 @@ ____##name(unsigned long long *ctx, ##args)
 
 struct pt_regs;
 
-#define ___bpf_kprobe_args0() ctx
-#define ___bpf_kprobe_args1(x) \
-	___bpf_kprobe_args0(), (void *)PT_REGS_PARM1(ctx)
-#define ___bpf_kprobe_args2(x, args...) \
-	___bpf_kprobe_args1(args), (void *)PT_REGS_PARM2(ctx)
-#define ___bpf_kprobe_args3(x, args...) \
-	___bpf_kprobe_args2(args), (void *)PT_REGS_PARM3(ctx)
-#define ___bpf_kprobe_args4(x, args...) \
-	___bpf_kprobe_args3(args), (void *)PT_REGS_PARM4(ctx)
-#define ___bpf_kprobe_args5(x, args...) \
-	___bpf_kprobe_args4(args), (void *)PT_REGS_PARM5(ctx)
-#define ___bpf_kprobe_args(args...) \
-	___bpf_apply(___bpf_kprobe_args, ___bpf_narg(args))(args)
+#define ___bpf_kprobe_args0()           ctx
+#define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(), (void *)PT_REGS_PARM1(ctx)
+#define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args), (void *)PT_REGS_PARM2(ctx)
+#define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args), (void *)PT_REGS_PARM3(ctx)
+#define ___bpf_kprobe_args4(x, args...) ___bpf_kprobe_args3(args), (void *)PT_REGS_PARM4(ctx)
+#define ___bpf_kprobe_args5(x, args...) ___bpf_kprobe_args4(args), (void *)PT_REGS_PARM5(ctx)
+#define ___bpf_kprobe_args(args...)     ___bpf_apply(___bpf_kprobe_args, ___bpf_narg(args))(args)
 
 /*
  * BPF_KPROBE serves the same purpose for kprobes as BPF_PROG for
@@ -391,11 +383,9 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 static __attribute__((always_inline)) typeof(name(0))			    \
 ____##name(struct pt_regs *ctx, ##args)
 
-#define ___bpf_kretprobe_args0() ctx
-#define ___bpf_kretprobe_args1(x) \
-	___bpf_kretprobe_args0(), (void *)PT_REGS_RC(ctx)
-#define ___bpf_kretprobe_args(args...) \
-	___bpf_apply(___bpf_kretprobe_args, ___bpf_narg(args))(args)
+#define ___bpf_kretprobe_args0()       ctx
+#define ___bpf_kretprobe_args1(x)      ___bpf_kretprobe_args0(), (void *)PT_REGS_RC(ctx)
+#define ___bpf_kretprobe_args(args...) ___bpf_apply(___bpf_kretprobe_args, ___bpf_narg(args))(args)
 
 /*
  * BPF_KRETPROBE is similar to BPF_KPROBE, except, it only provides optional
-- 
2.30.2


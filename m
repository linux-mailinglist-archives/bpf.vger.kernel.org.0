Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAC5B43C6
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 04:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIJCw3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 22:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIJCw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 22:52:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36243B0B36
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 19:52:27 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289LdCEN023834
        for <bpf@vger.kernel.org>; Fri, 9 Sep 2022 19:52:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=RoaLEKNvxDxyf0sBDZZipn3slXYMqOCQZSu62kNc4l4=;
 b=CBc+X1TJH3BH3YPWDDhHrySXZ0kUllww2Nq4Xj2+7Lo/pGFv/WaGFMuJzRUp7/Drze37
 sE/ufGUH/m1q6/5T7/j74ueldKHhviukUmrz81O6P+PdXXq5HDb7f+68VITsyXsRGqXM
 d/TAet6VKscQNHlkj02ZzKGhG4xdu85jNNs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jgc7ksygm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 19:52:26 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 19:52:25 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 826C0F3389D3; Fri,  9 Sep 2022 19:52:14 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: Improve BPF_PROG2 macro code quality and description
Date:   Fri, 9 Sep 2022 19:52:14 -0700
Message-ID: <20220910025214.1536510-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dCCpTn74NdigS53PvMn2zLOz1u6vInpH
X-Proofpoint-GUID: dCCpTn74NdigS53PvMn2zLOz1u6vInpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_12,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 34586d29f8df ("libbpf: Add new BPF_PROG2 macro") added BPF_PROG2
macro for trampoline based programs with struct arguments. Andrii
made a few suggestions to improve code quality and description.
This patch implemented these suggestions including better internal
macro name, consistent usage pattern for __builtin_choose_expr(),
simpler macro definition for always-inline func arguments and
better macro description.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/bpf_tracing.h | 77 ++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 8d4bdd18cb3d..a71ca48ea479 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -438,39 +438,45 @@ typeof(name(0)) name(unsigned long long *ctx)				  =
  \
 static __always_inline typeof(name(0))					    \
 ____##name(unsigned long long *ctx, ##args)
=20
-#ifndef ____bpf_nth
-#define ____bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12=
, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, N, ...) N
+#ifndef ___bpf_nth2
+#define ___bpf_nth2(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12=
, _13,	\
+		    _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, N, ...) N
 #endif
-#ifndef ____bpf_narg
-#define ____bpf_narg(...) ____bpf_nth(_, ##__VA_ARGS__, 12, 12, 11, 11, =
10, 10, 9, 9, 8, 8, 7, 7, 6, 6, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1, 0)
+#ifndef ___bpf_narg2
+#define ___bpf_narg2(...)	\
+	___bpf_nth2(_, ##__VA_ARGS__, 12, 12, 11, 11, 10, 10, 9, 9, 8, 8, 7, 7,=
	\
+		    6, 6, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1, 0)
 #endif
=20
-#define BPF_REG_CNT(t) \
-	(__builtin_choose_expr(sizeof(t) =3D=3D 1 || sizeof(t) =3D=3D 2 || size=
of(t) =3D=3D 4 || sizeof(t) =3D=3D 8, 1,	\
-	 __builtin_choose_expr(sizeof(t) =3D=3D 16, 2,							\
-			       (void)0)))
+#define ___bpf_reg_cnt(t) \
+	__builtin_choose_expr(sizeof(t) =3D=3D 1, 1,	\
+	__builtin_choose_expr(sizeof(t) =3D=3D 2, 1,	\
+	__builtin_choose_expr(sizeof(t) =3D=3D 4, 1,	\
+	__builtin_choose_expr(sizeof(t) =3D=3D 8, 1,	\
+	__builtin_choose_expr(sizeof(t) =3D=3D 16, 2,	\
+			      (void)0)))))
=20
 #define ____bpf_reg_cnt0()			(0)
-#define ____bpf_reg_cnt1(t, x)			(____bpf_reg_cnt0() + BPF_REG_CNT(t))
-#define ____bpf_reg_cnt2(t, x, args...)		(____bpf_reg_cnt1(args) + BPF_R=
EG_CNT(t))
-#define ____bpf_reg_cnt3(t, x, args...)		(____bpf_reg_cnt2(args) + BPF_R=
EG_CNT(t))
-#define ____bpf_reg_cnt4(t, x, args...)		(____bpf_reg_cnt3(args) + BPF_R=
EG_CNT(t))
-#define ____bpf_reg_cnt5(t, x, args...)		(____bpf_reg_cnt4(args) + BPF_R=
EG_CNT(t))
-#define ____bpf_reg_cnt6(t, x, args...)		(____bpf_reg_cnt5(args) + BPF_R=
EG_CNT(t))
-#define ____bpf_reg_cnt7(t, x, args...)		(____bpf_reg_cnt6(args) + BPF_R=
EG_CNT(t))
-#define ____bpf_reg_cnt8(t, x, args...)		(____bpf_reg_cnt7(args) + BPF_R=
EG_CNT(t))
-#define ____bpf_reg_cnt9(t, x, args...)		(____bpf_reg_cnt8(args) + BPF_R=
EG_CNT(t))
-#define ____bpf_reg_cnt10(t, x, args...)	(____bpf_reg_cnt9(args) + BPF_R=
EG_CNT(t))
-#define ____bpf_reg_cnt11(t, x, args...)	(____bpf_reg_cnt10(args) + BPF_=
REG_CNT(t))
-#define ____bpf_reg_cnt12(t, x, args...)	(____bpf_reg_cnt11(args) + BPF_=
REG_CNT(t))
-#define ____bpf_reg_cnt(args...)	 ___bpf_apply(____bpf_reg_cnt, ____bpf_=
narg(args))(args)
+#define ____bpf_reg_cnt1(t, x)			(____bpf_reg_cnt0() + ___bpf_reg_cnt(t)=
)
+#define ____bpf_reg_cnt2(t, x, args...)		(____bpf_reg_cnt1(args) + ___bp=
f_reg_cnt(t))
+#define ____bpf_reg_cnt3(t, x, args...)		(____bpf_reg_cnt2(args) + ___bp=
f_reg_cnt(t))
+#define ____bpf_reg_cnt4(t, x, args...)		(____bpf_reg_cnt3(args) + ___bp=
f_reg_cnt(t))
+#define ____bpf_reg_cnt5(t, x, args...)		(____bpf_reg_cnt4(args) + ___bp=
f_reg_cnt(t))
+#define ____bpf_reg_cnt6(t, x, args...)		(____bpf_reg_cnt5(args) + ___bp=
f_reg_cnt(t))
+#define ____bpf_reg_cnt7(t, x, args...)		(____bpf_reg_cnt6(args) + ___bp=
f_reg_cnt(t))
+#define ____bpf_reg_cnt8(t, x, args...)		(____bpf_reg_cnt7(args) + ___bp=
f_reg_cnt(t))
+#define ____bpf_reg_cnt9(t, x, args...)		(____bpf_reg_cnt8(args) + ___bp=
f_reg_cnt(t))
+#define ____bpf_reg_cnt10(t, x, args...)	(____bpf_reg_cnt9(args) + ___bp=
f_reg_cnt(t))
+#define ____bpf_reg_cnt11(t, x, args...)	(____bpf_reg_cnt10(args) + ___b=
pf_reg_cnt(t))
+#define ____bpf_reg_cnt12(t, x, args...)	(____bpf_reg_cnt11(args) + ___b=
pf_reg_cnt(t))
+#define ____bpf_reg_cnt(args...)	 ___bpf_apply(____bpf_reg_cnt, ___bpf_n=
arg2(args))(args)
=20
 #define ____bpf_union_arg(t, x, n) \
-	__builtin_choose_expr(sizeof(t) =3D=3D 1, ({ union { struct { __u8 x; }=
 ___z; t x; } ___tmp =3D { .___z =3D {ctx[n]}}; ___tmp.x; }), \
-	__builtin_choose_expr(sizeof(t) =3D=3D 2, ({ union { struct { __u16 x; =
} ___z; t x; } ___tmp =3D { .___z =3D {ctx[n]} }; ___tmp.x; }), \
-	__builtin_choose_expr(sizeof(t) =3D=3D 4, ({ union { struct { __u32 x; =
} ___z; t x; } ___tmp =3D { .___z =3D {ctx[n]} }; ___tmp.x; }), \
-	__builtin_choose_expr(sizeof(t) =3D=3D 8, ({ union { struct { __u64 x; =
} ___z; t x; } ___tmp =3D {.___z =3D {ctx[n]} }; ___tmp.x; }), \
-	__builtin_choose_expr(sizeof(t) =3D=3D 16, ({ union { struct { __u64 x,=
 y; } ___z; t x; } ___tmp =3D {.___z =3D {ctx[n], ctx[n + 1]} }; ___tmp.x=
; }), \
+	__builtin_choose_expr(sizeof(t) =3D=3D 1, ({ union { __u8 ___z[1]; t x;=
 } ___tmp =3D { .___z =3D {ctx[n]}}; ___tmp.x; }), \
+	__builtin_choose_expr(sizeof(t) =3D=3D 2, ({ union { __u16 ___z[1]; t x=
; } ___tmp =3D { .___z =3D {ctx[n]} }; ___tmp.x; }), \
+	__builtin_choose_expr(sizeof(t) =3D=3D 4, ({ union { __u32 ___z[1]; t x=
; } ___tmp =3D { .___z =3D {ctx[n]} }; ___tmp.x; }), \
+	__builtin_choose_expr(sizeof(t) =3D=3D 8, ({ union { __u64 ___z[1]; t x=
; } ___tmp =3D {.___z =3D {ctx[n]} }; ___tmp.x; }), \
+	__builtin_choose_expr(sizeof(t) =3D=3D 16, ({ union { __u64 ___z[2]; t =
x; } ___tmp =3D {.___z =3D {ctx[n], ctx[n + 1]} }; ___tmp.x; }), \
 			      (void)0)))))
=20
 #define ____bpf_ctx_arg0(n, args...)
@@ -486,7 +492,7 @@ ____##name(unsigned long long *ctx, ##args)
 #define ____bpf_ctx_arg10(n, t, x, args...)	, ____bpf_union_arg(t, x, n =
- ____bpf_reg_cnt10(t, x, args)) ____bpf_ctx_arg9(n, args)
 #define ____bpf_ctx_arg11(n, t, x, args...)	, ____bpf_union_arg(t, x, n =
- ____bpf_reg_cnt11(t, x, args)) ____bpf_ctx_arg10(n, args)
 #define ____bpf_ctx_arg12(n, t, x, args...)	, ____bpf_union_arg(t, x, n =
- ____bpf_reg_cnt12(t, x, args)) ____bpf_ctx_arg11(n, args)
-#define ____bpf_ctx_arg(n, args...)	___bpf_apply(____bpf_ctx_arg, ____bp=
f_narg(args))(n, args)
+#define ____bpf_ctx_arg(args...)	___bpf_apply(____bpf_ctx_arg, ___bpf_na=
rg2(args))(____bpf_reg_cnt(args), args)
=20
 #define ____bpf_ctx_decl0()
 #define ____bpf_ctx_decl1(t, x)			, t x
@@ -501,10 +507,21 @@ ____##name(unsigned long long *ctx, ##args)
 #define ____bpf_ctx_decl10(t, x, args...)	, t x ____bpf_ctx_decl9(args)
 #define ____bpf_ctx_decl11(t, x, args...)	, t x ____bpf_ctx_decl10(args)
 #define ____bpf_ctx_decl12(t, x, args...)	, t x ____bpf_ctx_decl11(args)
-#define ____bpf_ctx_decl(args...)	___bpf_apply(____bpf_ctx_decl, ____bpf=
_narg(args))(args)
+#define ____bpf_ctx_decl(args...)	___bpf_apply(____bpf_ctx_decl, ___bpf_=
narg2(args))(args)
=20
 /*
- * BPF_PROG2 can handle struct arguments.
+ * BPF_PROG2 is an enhanced version of BPF_PROG in order to handle struc=
t
+ * arguments. Since each struct argument might take one or two u64 value=
s
+ * in the trampoline stack, argument type size is needed to place proper=
 number
+ * of u64 values for each argument. Therefore, BPF_PROG2 has different
+ * syntax from BPF_PROG. For example, for the following BPF_PROG syntax,
+ *   int BPF_PROG(test2, int a, int b)
+ * the corresponding BPF_PROG2 synx is,
+ *   int BPF_PROG2(test2, int, a, int, b)
+ * where type and the corresponding argument name are separated by comma=
.
+ * If one or more argument is of struct type, BPF_PROG2 macro should be =
used,
+ *   int BPF_PROG2(test_struct_arg, struct bpf_testmod_struct_arg_1, a, =
int, b,
+ *		   int, c, int, d, struct bpf_testmod_struct_arg_2, e, int, ret)
  */
 #define BPF_PROG2(name, args...)						\
 name(unsigned long long *ctx);							\
@@ -512,7 +529,7 @@ static __always_inline typeof(name(0))						\
 ____##name(unsigned long long *ctx ____bpf_ctx_decl(args));			\
 typeof(name(0)) name(unsigned long long *ctx)					\
 {										\
-	return ____##name(ctx ____bpf_ctx_arg(____bpf_reg_cnt(args), args));	\
+	return ____##name(ctx ____bpf_ctx_arg(args));				\
 }										\
 static __always_inline typeof(name(0))						\
 ____##name(unsigned long long *ctx ____bpf_ctx_decl(args))
--=20
2.30.2


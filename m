Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A9C5A8132
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiHaP1W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiHaP1N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 11:27:13 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798DD7D3D
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:12 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEh3YZ005204
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=aSPJH4PfRfZIUVIya1Yu+6J8yQ3dyT0KsPY5SACrh8o=;
 b=ogGmarR2zfREDpa8HYWlj118BkVxz6OKnHrkS0aSOqCw+P2zUSbAV0AtdzxV6P6jIXa2
 1QQJ+2VoeD8YpUuevGWbq7ILOmeDI5nRaO9B5Pup0fGNZTvYG2Urqb7VcQJDgIBod2oS
 4r2hXtwZgmmWB4YsmTiqONDDqYBM1kagYtc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ja8n38t42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:11 -0700
Received: from twshared3888.09.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 08:27:09 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D468BECDED0D; Wed, 31 Aug 2022 08:27:07 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 5/8] libbpf: Add new BPF_PROG2 macro
Date:   Wed, 31 Aug 2022 08:27:07 -0700
Message-ID: <20220831152707.2079473-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831152641.2077476-1-yhs@fb.com>
References: <20220831152641.2077476-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: XVkpjTOkX5XgTDAXDWlF-X5RRlRZssZw
X-Proofpoint-ORIG-GUID: XVkpjTOkX5XgTDAXDWlF-X5RRlRZssZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To support struct arguments in trampoline based programs,
existing BPF_PROG doesn't work any more since
the type size is needed to find whether a parameter
takes one or two registers. So this patch added a new
BPF_PROG2 macro to support such trampoline programs.

The idea is suggested by Andrii. For example, if the
to-be-traced function has signature like
  typedef struct {
       void *x;
       int t;
  } sockptr;
  int blah(sockptr x, char y);

In the new BPF_PROG2 macro, the argument can be
represented as
  __bpf_prog_call(
     ({ union {
          struct { __u64 x, y; } ___z;
          sockptr x;
        } ___tmp =3D { .___z =3D { ctx[0], ctx[1] }};
        ___tmp.x;
     }),
     ({ union {
          struct { __u8 x; } ___z;
          char y;
        } ___tmp =3D { .___z =3D { ctx[2] }};
        ___tmp.y;
     }));
In the above, the values stored on the stack are properly
assigned to the actual argument type value by using 'union'
magic. Note that the macro also works even if no arguments
are with struct types.

Note that new BPF_PROG2 works for both llvm16 and pre-llvm16
compilers where llvm16 supports bpf target passing value
with struct up to 16 byte size and pre-llvm16 will pass
by reference by storing values on the stack. With static functions
with struct argument as always inline, the compiler is able
to optimize and remove additional stack saving of struct values.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/bpf_tracing.h | 79 +++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 5fdb93da423b..8d4bdd18cb3d 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -438,6 +438,85 @@ typeof(name(0)) name(unsigned long long *ctx)				   =
 \
 static __always_inline typeof(name(0))					    \
 ____##name(unsigned long long *ctx, ##args)
=20
+#ifndef ____bpf_nth
+#define ____bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12=
, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, N, ...) N
+#endif
+#ifndef ____bpf_narg
+#define ____bpf_narg(...) ____bpf_nth(_, ##__VA_ARGS__, 12, 12, 11, 11, =
10, 10, 9, 9, 8, 8, 7, 7, 6, 6, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1, 0)
+#endif
+
+#define BPF_REG_CNT(t) \
+	(__builtin_choose_expr(sizeof(t) =3D=3D 1 || sizeof(t) =3D=3D 2 || size=
of(t) =3D=3D 4 || sizeof(t) =3D=3D 8, 1,	\
+	 __builtin_choose_expr(sizeof(t) =3D=3D 16, 2,							\
+			       (void)0)))
+
+#define ____bpf_reg_cnt0()			(0)
+#define ____bpf_reg_cnt1(t, x)			(____bpf_reg_cnt0() + BPF_REG_CNT(t))
+#define ____bpf_reg_cnt2(t, x, args...)		(____bpf_reg_cnt1(args) + BPF_R=
EG_CNT(t))
+#define ____bpf_reg_cnt3(t, x, args...)		(____bpf_reg_cnt2(args) + BPF_R=
EG_CNT(t))
+#define ____bpf_reg_cnt4(t, x, args...)		(____bpf_reg_cnt3(args) + BPF_R=
EG_CNT(t))
+#define ____bpf_reg_cnt5(t, x, args...)		(____bpf_reg_cnt4(args) + BPF_R=
EG_CNT(t))
+#define ____bpf_reg_cnt6(t, x, args...)		(____bpf_reg_cnt5(args) + BPF_R=
EG_CNT(t))
+#define ____bpf_reg_cnt7(t, x, args...)		(____bpf_reg_cnt6(args) + BPF_R=
EG_CNT(t))
+#define ____bpf_reg_cnt8(t, x, args...)		(____bpf_reg_cnt7(args) + BPF_R=
EG_CNT(t))
+#define ____bpf_reg_cnt9(t, x, args...)		(____bpf_reg_cnt8(args) + BPF_R=
EG_CNT(t))
+#define ____bpf_reg_cnt10(t, x, args...)	(____bpf_reg_cnt9(args) + BPF_R=
EG_CNT(t))
+#define ____bpf_reg_cnt11(t, x, args...)	(____bpf_reg_cnt10(args) + BPF_=
REG_CNT(t))
+#define ____bpf_reg_cnt12(t, x, args...)	(____bpf_reg_cnt11(args) + BPF_=
REG_CNT(t))
+#define ____bpf_reg_cnt(args...)	 ___bpf_apply(____bpf_reg_cnt, ____bpf_=
narg(args))(args)
+
+#define ____bpf_union_arg(t, x, n) \
+	__builtin_choose_expr(sizeof(t) =3D=3D 1, ({ union { struct { __u8 x; }=
 ___z; t x; } ___tmp =3D { .___z =3D {ctx[n]}}; ___tmp.x; }), \
+	__builtin_choose_expr(sizeof(t) =3D=3D 2, ({ union { struct { __u16 x; =
} ___z; t x; } ___tmp =3D { .___z =3D {ctx[n]} }; ___tmp.x; }), \
+	__builtin_choose_expr(sizeof(t) =3D=3D 4, ({ union { struct { __u32 x; =
} ___z; t x; } ___tmp =3D { .___z =3D {ctx[n]} }; ___tmp.x; }), \
+	__builtin_choose_expr(sizeof(t) =3D=3D 8, ({ union { struct { __u64 x; =
} ___z; t x; } ___tmp =3D {.___z =3D {ctx[n]} }; ___tmp.x; }), \
+	__builtin_choose_expr(sizeof(t) =3D=3D 16, ({ union { struct { __u64 x,=
 y; } ___z; t x; } ___tmp =3D {.___z =3D {ctx[n], ctx[n + 1]} }; ___tmp.x=
; }), \
+			      (void)0)))))
+
+#define ____bpf_ctx_arg0(n, args...)
+#define ____bpf_ctx_arg1(n, t, x)		, ____bpf_union_arg(t, x, n - ____bpf=
_reg_cnt1(t, x))
+#define ____bpf_ctx_arg2(n, t, x, args...)	, ____bpf_union_arg(t, x, n -=
 ____bpf_reg_cnt2(t, x, args)) ____bpf_ctx_arg1(n, args)
+#define ____bpf_ctx_arg3(n, t, x, args...)	, ____bpf_union_arg(t, x, n -=
 ____bpf_reg_cnt3(t, x, args)) ____bpf_ctx_arg2(n, args)
+#define ____bpf_ctx_arg4(n, t, x, args...)	, ____bpf_union_arg(t, x, n -=
 ____bpf_reg_cnt4(t, x, args)) ____bpf_ctx_arg3(n, args)
+#define ____bpf_ctx_arg5(n, t, x, args...)	, ____bpf_union_arg(t, x, n -=
 ____bpf_reg_cnt5(t, x, args)) ____bpf_ctx_arg4(n, args)
+#define ____bpf_ctx_arg6(n, t, x, args...)	, ____bpf_union_arg(t, x, n -=
 ____bpf_reg_cnt6(t, x, args)) ____bpf_ctx_arg5(n, args)
+#define ____bpf_ctx_arg7(n, t, x, args...)	, ____bpf_union_arg(t, x, n -=
 ____bpf_reg_cnt7(t, x, args)) ____bpf_ctx_arg6(n, args)
+#define ____bpf_ctx_arg8(n, t, x, args...)	, ____bpf_union_arg(t, x, n -=
 ____bpf_reg_cnt8(t, x, args)) ____bpf_ctx_arg7(n, args)
+#define ____bpf_ctx_arg9(n, t, x, args...)	, ____bpf_union_arg(t, x, n -=
 ____bpf_reg_cnt9(t, x, args)) ____bpf_ctx_arg8(n, args)
+#define ____bpf_ctx_arg10(n, t, x, args...)	, ____bpf_union_arg(t, x, n =
- ____bpf_reg_cnt10(t, x, args)) ____bpf_ctx_arg9(n, args)
+#define ____bpf_ctx_arg11(n, t, x, args...)	, ____bpf_union_arg(t, x, n =
- ____bpf_reg_cnt11(t, x, args)) ____bpf_ctx_arg10(n, args)
+#define ____bpf_ctx_arg12(n, t, x, args...)	, ____bpf_union_arg(t, x, n =
- ____bpf_reg_cnt12(t, x, args)) ____bpf_ctx_arg11(n, args)
+#define ____bpf_ctx_arg(n, args...)	___bpf_apply(____bpf_ctx_arg, ____bp=
f_narg(args))(n, args)
+
+#define ____bpf_ctx_decl0()
+#define ____bpf_ctx_decl1(t, x)			, t x
+#define ____bpf_ctx_decl2(t, x, args...)	, t x ____bpf_ctx_decl1(args)
+#define ____bpf_ctx_decl3(t, x, args...)	, t x ____bpf_ctx_decl2(args)
+#define ____bpf_ctx_decl4(t, x, args...)	, t x ____bpf_ctx_decl3(args)
+#define ____bpf_ctx_decl5(t, x, args...)	, t x ____bpf_ctx_decl4(args)
+#define ____bpf_ctx_decl6(t, x, args...)	, t x ____bpf_ctx_decl5(args)
+#define ____bpf_ctx_decl7(t, x, args...)	, t x ____bpf_ctx_decl6(args)
+#define ____bpf_ctx_decl8(t, x, args...)	, t x ____bpf_ctx_decl7(args)
+#define ____bpf_ctx_decl9(t, x, args...)	, t x ____bpf_ctx_decl8(args)
+#define ____bpf_ctx_decl10(t, x, args...)	, t x ____bpf_ctx_decl9(args)
+#define ____bpf_ctx_decl11(t, x, args...)	, t x ____bpf_ctx_decl10(args)
+#define ____bpf_ctx_decl12(t, x, args...)	, t x ____bpf_ctx_decl11(args)
+#define ____bpf_ctx_decl(args...)	___bpf_apply(____bpf_ctx_decl, ____bpf=
_narg(args))(args)
+
+/*
+ * BPF_PROG2 can handle struct arguments.
+ */
+#define BPF_PROG2(name, args...)						\
+name(unsigned long long *ctx);							\
+static __always_inline typeof(name(0))						\
+____##name(unsigned long long *ctx ____bpf_ctx_decl(args));			\
+typeof(name(0)) name(unsigned long long *ctx)					\
+{										\
+	return ____##name(ctx ____bpf_ctx_arg(____bpf_reg_cnt(args), args));	\
+}										\
+static __always_inline typeof(name(0))						\
+____##name(unsigned long long *ctx ____bpf_ctx_decl(args))
+
 struct pt_regs;
=20
 #define ___bpf_kprobe_args0()           ctx
--=20
2.30.2


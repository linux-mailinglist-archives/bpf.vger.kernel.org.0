Return-Path: <bpf+bounces-13454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE3B7D9FAD
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB376B2160E
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5883F3C083;
	Fri, 27 Oct 2023 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404BB3C06B
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:16:58 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C6129
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:56 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5aBI006235
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u0c4pu37t-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:56 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:16:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 77A5F3A796714; Fri, 27 Oct 2023 11:14:32 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 19/23] bpf: generalize is_scalar_branch_taken() logic
Date: Fri, 27 Oct 2023 11:13:42 -0700
Message-ID: <20231027181346.4019398-20-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027181346.4019398-1-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: a10222eiWZMVFjFyLSVobrgjnwTQoMtP
X-Proofpoint-ORIG-GUID: a10222eiWZMVFjFyLSVobrgjnwTQoMtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

Generalize is_branch_taken logic for SCALAR_VALUE register to handle
cases when both registers are not constants. Previously supported
<range> vs <scalar> cases are a natural subset of more generic <range>
vs <range> set of cases.

Generalized logic relies on straightforward segment intersection checks.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 104 ++++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4c974296127b..f18a8247e5e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14189,82 +14189,105 @@ static int is_scalar_branch_taken(struct bpf_r=
eg_state *reg1, struct bpf_reg_sta
 				  u8 opcode, bool is_jmp32)
 {
 	struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->var_of=
f;
+	struct tnum t2 =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2->var_of=
f;
 	u64 umin1 =3D is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_value;
 	u64 umax1 =3D is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_value;
 	s64 smin1 =3D is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_value;
 	s64 smax1 =3D is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_value;
-	u64 val =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : reg2->va=
r_off.value;
-	s64 sval =3D is_jmp32 ? (s32)val : (s64)val;
+	u64 umin2 =3D is_jmp32 ? (u64)reg2->u32_min_value : reg2->umin_value;
+	u64 umax2 =3D is_jmp32 ? (u64)reg2->u32_max_value : reg2->umax_value;
+	s64 smin2 =3D is_jmp32 ? (s64)reg2->s32_min_value : reg2->smin_value;
+	s64 smax2 =3D is_jmp32 ? (s64)reg2->s32_max_value : reg2->smax_value;
=20
 	switch (opcode) {
 	case BPF_JEQ:
-		if (tnum_is_const(t1))
-			return !!tnum_equals_const(t1, val);
-		else if (val < umin1 || val > umax1)
+		/* const tnums */
+		if (tnum_is_const(t1) && tnum_is_const(t2))
+			return t1.value =3D=3D t2.value;
+		/* const ranges */
+		if (umin1 =3D=3D umax1 && umin2 =3D=3D umax2)
+			return umin1 =3D=3D umin2;
+		if (smin1 =3D=3D smax1 && smin2 =3D=3D smax2)
+			return umin1 =3D=3D umin2;
+		/* non-overlapping ranges */
+		if (umin1 > umax2 || umax1 < umin2)
 			return 0;
-		else if (sval < smin1 || sval > smax1)
+		if (smin1 > smax2 || smax1 < smin2)
 			return 0;
 		break;
 	case BPF_JNE:
-		if (tnum_is_const(t1))
-			return !tnum_equals_const(t1, val);
-		else if (val < umin1 || val > umax1)
+		/* const tnums */
+		if (tnum_is_const(t1) && tnum_is_const(t2))
+			return t1.value !=3D t2.value;
+		/* const ranges */
+		if (umin1 =3D=3D umax1 && umin2 =3D=3D umax2)
+			return umin1 !=3D umin2;
+		if (smin1 =3D=3D smax1 && smin2 =3D=3D smax2)
+			return umin1 !=3D umin2;
+		/* non-overlapping ranges */
+		if (umin1 > umax2 || umax1 < umin2)
 			return 1;
-		else if (sval < smin1 || sval > smax1)
+		if (smin1 > smax2 || smax1 < smin2)
 			return 1;
 		break;
 	case BPF_JSET:
-		if ((~t1.mask & t1.value) & val)
+		if (!is_reg_const(reg2, is_jmp32)) {
+			swap(reg1, reg2);
+			swap(t1, t2);
+		}
+		if (!is_reg_const(reg2, is_jmp32))
+			return -1;
+		if ((~t1.mask & t1.value) & t2.value)
 			return 1;
-		if (!((t1.mask | t1.value) & val))
+		if (!((t1.mask | t1.value) & t2.value))
 			return 0;
 		break;
 	case BPF_JGT:
-		if (umin1 > val )
+		if (umin1 > umax2)
 			return 1;
-		else if (umax1 <=3D val)
+		else if (umax1 <=3D umin2)
 			return 0;
 		break;
 	case BPF_JSGT:
-		if (smin1 > sval)
+		if (smin1 > smax2)
 			return 1;
-		else if (smax1 <=3D sval)
+		else if (smax1 <=3D smin2)
 			return 0;
 		break;
 	case BPF_JLT:
-		if (umax1 < val)
+		if (umax1 < umin2)
 			return 1;
-		else if (umin1 >=3D val)
+		else if (umin1 >=3D umax2)
 			return 0;
 		break;
 	case BPF_JSLT:
-		if (smax1 < sval)
+		if (smax1 < smin2)
 			return 1;
-		else if (smin1 >=3D sval)
+		else if (smin1 >=3D smax2)
 			return 0;
 		break;
 	case BPF_JGE:
-		if (umin1 >=3D val)
+		if (umin1 >=3D umax2)
 			return 1;
-		else if (umax1 < val)
+		else if (umax1 < umin2)
 			return 0;
 		break;
 	case BPF_JSGE:
-		if (smin1 >=3D sval)
+		if (smin1 >=3D smax2)
 			return 1;
-		else if (smax1 < sval)
+		else if (smax1 < smin2)
 			return 0;
 		break;
 	case BPF_JLE:
-		if (umax1 <=3D val)
+		if (umax1 <=3D umin2)
 			return 1;
-		else if (umin1 > val)
+		else if (umin1 > umax2)
 			return 0;
 		break;
 	case BPF_JSLE:
-		if (smax1 <=3D sval)
+		if (smax1 <=3D smin2)
 			return 1;
-		else if (smin1 > sval)
+		else if (smin1 > smax2)
 			return 0;
 		break;
 	}
@@ -14343,28 +14366,28 @@ static int is_pkt_ptr_branch_taken(struct bpf_r=
eg_state *dst_reg,
 static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_st=
ate *reg2,
 			   u8 opcode, bool is_jmp32)
 {
-	u64 val;
-
 	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2) && !is=
_jmp32)
 		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
=20
-	/* try to make sure reg2 is a constant SCALAR_VALUE */
-	if (!is_reg_const(reg2, is_jmp32)) {
-		opcode =3D flip_opcode(opcode);
-		swap(reg1, reg2);
-	}
-	/* for now we expect reg2 to be a constant to make any useful decisions=
 */
-	if (!is_reg_const(reg2, is_jmp32))
-		return -1;
-	val =3D reg_const_value(reg2, is_jmp32);
+	if (__is_pointer_value(false, reg1) || __is_pointer_value(false, reg2))=
 {
+		u64 val;
+
+		/* arrange that reg2 is a scalar, and reg1 is a pointer */
+		if (!is_reg_const(reg2, is_jmp32)) {
+			opcode =3D flip_opcode(opcode);
+			swap(reg1, reg2);
+		}
+		/* and ensure that reg2 is a constant */
+		if (!is_reg_const(reg2, is_jmp32))
+			return -1;
=20
-	if (__is_pointer_value(false, reg1)) {
 		if (!reg_not_null(reg1))
 			return -1;
=20
 		/* If pointer is valid tests against zero will fail so we can
 		 * use this to direct branch taken.
 		 */
+		val =3D reg_const_value(reg2, is_jmp32);
 		if (val !=3D 0)
 			return -1;
=20
@@ -14378,6 +14401,7 @@ static int is_branch_taken(struct bpf_reg_state *=
reg1, struct bpf_reg_state *reg
 		}
 	}
=20
+	/* now deal with two scalars, but not necessarily constants */
 	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
 }
=20
--=20
2.34.1



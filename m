Return-Path: <bpf+bounces-14897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D27E8DD0
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8174280D40
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1D217FC;
	Sun, 12 Nov 2023 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B50117ED
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:06:31 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A36B30F9
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:28 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AC0jxxJ032597
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:28 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua6hsjy2j-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:28 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:22 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id C89143B5D5192; Sat, 11 Nov 2023 17:06:14 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 02/13] bpf: generalize is_scalar_branch_taken() logic
Date: Sat, 11 Nov 2023 17:05:58 -0800
Message-ID: <20231112010609.848406-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112010609.848406-1-andrii@kernel.org>
References: <20231112010609.848406-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KjqvzPw2_MNRYXsjTJ9O3L-7Ed5TQba2
X-Proofpoint-ORIG-GUID: KjqvzPw2_MNRYXsjTJ9O3L-7Ed5TQba2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

Generalize is_branch_taken logic for SCALAR_VALUE register to handle
cases when both registers are not constants. Previously supported
<range> vs <scalar> cases are a natural subset of more generic <range>
vs <range> set of cases.

Generalized logic relies on straightforward segment intersection checks.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 98 +++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 39ce141c55d3..f459ad99256e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14261,82 +14261,99 @@ static int is_scalar_branch_taken(struct bpf_re=
g_state *reg1, struct bpf_reg_sta
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
-	u64 uval =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : reg2->v=
ar_off.value;
-	s64 sval =3D is_jmp32 ? (s32)uval : (s64)uval;
+	u64 umin2 =3D is_jmp32 ? (u64)reg2->u32_min_value : reg2->umin_value;
+	u64 umax2 =3D is_jmp32 ? (u64)reg2->u32_max_value : reg2->umax_value;
+	s64 smin2 =3D is_jmp32 ? (s64)reg2->s32_min_value : reg2->smin_value;
+	s64 smax2 =3D is_jmp32 ? (s64)reg2->s32_max_value : reg2->smax_value;
=20
 	switch (opcode) {
 	case BPF_JEQ:
-		if (tnum_is_const(t1))
-			return !!tnum_equals_const(t1, uval);
-		else if (uval < umin1 || uval > umax1)
+		/* constants, umin/umax and smin/smax checks would be
+		 * redundant in this case because they all should match
+		 */
+		if (tnum_is_const(t1) && tnum_is_const(t2))
+			return t1.value =3D=3D t2.value;
+		/* non-overlapping ranges */
+		if (umin1 > umax2 || umax1 < umin2)
 			return 0;
-		else if (sval < smin1 || sval > smax1)
+		if (smin1 > smax2 || smax1 < smin2)
 			return 0;
 		break;
 	case BPF_JNE:
-		if (tnum_is_const(t1))
-			return !tnum_equals_const(t1, uval);
-		else if (uval < umin1 || uval > umax1)
+		/* constants, umin/umax and smin/smax checks would be
+		 * redundant in this case because they all should match
+		 */
+		if (tnum_is_const(t1) && tnum_is_const(t2))
+			return t1.value !=3D t2.value;
+		/* non-overlapping ranges */
+		if (umin1 > umax2 || umax1 < umin2)
 			return 1;
-		else if (sval < smin1 || sval > smax1)
+		if (smin1 > smax2 || smax1 < smin2)
 			return 1;
 		break;
 	case BPF_JSET:
-		if ((~t1.mask & t1.value) & uval)
+		if (!is_reg_const(reg2, is_jmp32)) {
+			swap(reg1, reg2);
+			swap(t1, t2);
+		}
+		if (!is_reg_const(reg2, is_jmp32))
+			return -1;
+		if ((~t1.mask & t1.value) & t2.value)
 			return 1;
-		if (!((t1.mask | t1.value) & uval))
+		if (!((t1.mask | t1.value) & t2.value))
 			return 0;
 		break;
 	case BPF_JGT:
-		if (umin1 > uval )
+		if (umin1 > umax2)
 			return 1;
-		else if (umax1 <=3D uval)
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
-		if (umax1 < uval)
+		if (umax1 < umin2)
 			return 1;
-		else if (umin1 >=3D uval)
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
-		if (umin1 >=3D uval)
+		if (umin1 >=3D umax2)
 			return 1;
-		else if (umax1 < uval)
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
-		if (umax1 <=3D uval)
+		if (umax1 <=3D umin2)
 			return 1;
-		else if (umin1 > uval)
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
@@ -14415,28 +14432,28 @@ static int is_pkt_ptr_branch_taken(struct bpf_r=
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
@@ -14450,6 +14467,7 @@ static int is_branch_taken(struct bpf_reg_state *=
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



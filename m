Return-Path: <bpf+bounces-13898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B8E7DEB7F
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE60B20CEF
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239BD1860;
	Thu,  2 Nov 2023 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE611865
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F66E8
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:34 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A21f1IJ018820
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:34 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u3sftwemb-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:34 -0700
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:33 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 3CCAB3AC97F7E; Wed,  1 Nov 2023 20:38:32 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v6 bpf-next 15/17] bpf: unify 32-bit and 64-bit is_branch_taken logic
Date: Wed, 1 Nov 2023 20:37:57 -0700
Message-ID: <20231102033759.2541186-16-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102033759.2541186-1-andrii@kernel.org>
References: <20231102033759.2541186-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Bz6UXB7oRb3G_tN1MOx4tMZBU5asXJW2
X-Proofpoint-GUID: Bz6UXB7oRb3G_tN1MOx4tMZBU5asXJW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

Combine 32-bit and 64-bit is_branch_taken logic for SCALAR_VALUE
registers. It makes it easier to see parallels between two domains
(32-bit and 64-bit), and makes subsequent refactoring more
straightforward.

No functional changes.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 200 +++++++++++++-----------------------------
 1 file changed, 59 insertions(+), 141 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5213cef5389..b077dd99b159 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14183,166 +14183,86 @@ static u64 reg_const_value(struct bpf_reg_stat=
e *reg, bool subreg32)
 /*
  * <reg1> <op> <reg2>, currently assuming reg2 is a constant
  */
-static int is_branch32_taken(struct bpf_reg_state *reg1, struct bpf_reg_=
state *reg2, u8 opcode)
+static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf=
_reg_state *reg2,
+				  u8 opcode, bool is_jmp32)
 {
-	struct tnum subreg =3D tnum_subreg(reg1->var_off);
-	u32 val =3D (u32)tnum_subreg(reg2->var_off).value;
-	s32 sval =3D (s32)val;
+	struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->var_of=
f;
+	u64 umin1 =3D is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_value;
+	u64 umax1 =3D is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_value;
+	s64 smin1 =3D is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_value;
+	s64 smax1 =3D is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_value;
+	u64 uval =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : reg2->v=
ar_off.value;
+	s64 sval =3D is_jmp32 ? (s32)uval : (s64)uval;
=20
 	switch (opcode) {
 	case BPF_JEQ:
-		if (tnum_is_const(subreg))
-			return !!tnum_equals_const(subreg, val);
-		else if (val < reg1->u32_min_value || val > reg1->u32_max_value)
+		if (tnum_is_const(t1))
+			return !!tnum_equals_const(t1, uval);
+		else if (uval < umin1 || uval > umax1)
 			return 0;
-		else if (sval < reg1->s32_min_value || sval > reg1->s32_max_value)
+		else if (sval < smin1 || sval > smax1)
 			return 0;
 		break;
 	case BPF_JNE:
-		if (tnum_is_const(subreg))
-			return !tnum_equals_const(subreg, val);
-		else if (val < reg1->u32_min_value || val > reg1->u32_max_value)
+		if (tnum_is_const(t1))
+			return !tnum_equals_const(t1, uval);
+		else if (uval < umin1 || uval > umax1)
 			return 1;
-		else if (sval < reg1->s32_min_value || sval > reg1->s32_max_value)
+		else if (sval < smin1 || sval > smax1)
 			return 1;
 		break;
 	case BPF_JSET:
-		if ((~subreg.mask & subreg.value) & val)
+		if ((~t1.mask & t1.value) & uval)
 			return 1;
-		if (!((subreg.mask | subreg.value) & val))
+		if (!((t1.mask | t1.value) & uval))
 			return 0;
 		break;
 	case BPF_JGT:
-		if (reg1->u32_min_value > val)
+		if (umin1 > uval )
 			return 1;
-		else if (reg1->u32_max_value <=3D val)
+		else if (umax1 <=3D uval)
 			return 0;
 		break;
 	case BPF_JSGT:
-		if (reg1->s32_min_value > sval)
+		if (smin1 > sval)
 			return 1;
-		else if (reg1->s32_max_value <=3D sval)
+		else if (smax1 <=3D sval)
 			return 0;
 		break;
 	case BPF_JLT:
-		if (reg1->u32_max_value < val)
+		if (umax1 < uval)
 			return 1;
-		else if (reg1->u32_min_value >=3D val)
+		else if (umin1 >=3D uval)
 			return 0;
 		break;
 	case BPF_JSLT:
-		if (reg1->s32_max_value < sval)
+		if (smax1 < sval)
 			return 1;
-		else if (reg1->s32_min_value >=3D sval)
+		else if (smin1 >=3D sval)
 			return 0;
 		break;
 	case BPF_JGE:
-		if (reg1->u32_min_value >=3D val)
+		if (umin1 >=3D uval)
 			return 1;
-		else if (reg1->u32_max_value < val)
+		else if (umax1 < uval)
 			return 0;
 		break;
 	case BPF_JSGE:
-		if (reg1->s32_min_value >=3D sval)
+		if (smin1 >=3D sval)
 			return 1;
-		else if (reg1->s32_max_value < sval)
+		else if (smax1 < sval)
 			return 0;
 		break;
 	case BPF_JLE:
-		if (reg1->u32_max_value <=3D val)
+		if (umax1 <=3D uval)
 			return 1;
-		else if (reg1->u32_min_value > val)
+		else if (umin1 > uval)
 			return 0;
 		break;
 	case BPF_JSLE:
-		if (reg1->s32_max_value <=3D sval)
+		if (smax1 <=3D sval)
 			return 1;
-		else if (reg1->s32_min_value > sval)
-			return 0;
-		break;
-	}
-
-	return -1;
-}
-
-
-/*
- * <reg1> <op> <reg2>, currently assuming reg2 is a constant
- */
-static int is_branch64_taken(struct bpf_reg_state *reg1, struct bpf_reg_=
state *reg2, u8 opcode)
-{
-	u64 val =3D reg2->var_off.value;
-	s64 sval =3D (s64)val;
-
-	switch (opcode) {
-	case BPF_JEQ:
-		if (tnum_is_const(reg1->var_off))
-			return !!tnum_equals_const(reg1->var_off, val);
-		else if (val < reg1->umin_value || val > reg1->umax_value)
-			return 0;
-		else if (sval < reg1->smin_value || sval > reg1->smax_value)
-			return 0;
-		break;
-	case BPF_JNE:
-		if (tnum_is_const(reg1->var_off))
-			return !tnum_equals_const(reg1->var_off, val);
-		else if (val < reg1->umin_value || val > reg1->umax_value)
-			return 1;
-		else if (sval < reg1->smin_value || sval > reg1->smax_value)
-			return 1;
-		break;
-	case BPF_JSET:
-		if ((~reg1->var_off.mask & reg1->var_off.value) & val)
-			return 1;
-		if (!((reg1->var_off.mask | reg1->var_off.value) & val))
-			return 0;
-		break;
-	case BPF_JGT:
-		if (reg1->umin_value > val)
-			return 1;
-		else if (reg1->umax_value <=3D val)
-			return 0;
-		break;
-	case BPF_JSGT:
-		if (reg1->smin_value > sval)
-			return 1;
-		else if (reg1->smax_value <=3D sval)
-			return 0;
-		break;
-	case BPF_JLT:
-		if (reg1->umax_value < val)
-			return 1;
-		else if (reg1->umin_value >=3D val)
-			return 0;
-		break;
-	case BPF_JSLT:
-		if (reg1->smax_value < sval)
-			return 1;
-		else if (reg1->smin_value >=3D sval)
-			return 0;
-		break;
-	case BPF_JGE:
-		if (reg1->umin_value >=3D val)
-			return 1;
-		else if (reg1->umax_value < val)
-			return 0;
-		break;
-	case BPF_JSGE:
-		if (reg1->smin_value >=3D sval)
-			return 1;
-		else if (reg1->smax_value < sval)
-			return 0;
-		break;
-	case BPF_JLE:
-		if (reg1->umax_value <=3D val)
-			return 1;
-		else if (reg1->umin_value > val)
-			return 0;
-		break;
-	case BPF_JSLE:
-		if (reg1->smax_value <=3D sval)
-			return 1;
-		else if (reg1->smin_value > sval)
+		else if (smin1 > sval)
 			return 0;
 		break;
 	}
@@ -14456,9 +14376,7 @@ static int is_branch_taken(struct bpf_reg_state *=
reg1, struct bpf_reg_state *reg
 		}
 	}
=20
-	if (is_jmp32)
-		return is_branch32_taken(reg1, reg2, opcode);
-	return is_branch64_taken(reg1, reg2, opcode);
+	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
 }
=20
 /* Adjusts the register min/max values in the case that the dst_reg is t=
he
@@ -14468,15 +14386,15 @@ static int is_branch_taken(struct bpf_reg_state=
 *reg1, struct bpf_reg_state *reg
  */
 static void reg_set_min_max(struct bpf_reg_state *true_reg,
 			    struct bpf_reg_state *false_reg,
-			    u64 val, u32 val32,
+			    u64 uval, u32 uval32,
 			    u8 opcode, bool is_jmp32)
 {
 	struct tnum false_32off =3D tnum_subreg(false_reg->var_off);
 	struct tnum false_64off =3D false_reg->var_off;
 	struct tnum true_32off =3D tnum_subreg(true_reg->var_off);
 	struct tnum true_64off =3D true_reg->var_off;
-	s64 sval =3D (s64)val;
-	s32 sval32 =3D (s32)val32;
+	s64 sval =3D (s64)uval;
+	s32 sval32 =3D (s32)uval32;
=20
 	/* If the dst_reg is a pointer, we can't learn anything about its
 	 * variable offset from the compare (unless src_reg were a pointer into
@@ -14499,49 +14417,49 @@ static void reg_set_min_max(struct bpf_reg_stat=
e *true_reg,
 	 */
 	case BPF_JEQ:
 		if (is_jmp32) {
-			__mark_reg32_known(true_reg, val32);
+			__mark_reg32_known(true_reg, uval32);
 			true_32off =3D tnum_subreg(true_reg->var_off);
 		} else {
-			___mark_reg_known(true_reg, val);
+			___mark_reg_known(true_reg, uval);
 			true_64off =3D true_reg->var_off;
 		}
 		break;
 	case BPF_JNE:
 		if (is_jmp32) {
-			__mark_reg32_known(false_reg, val32);
+			__mark_reg32_known(false_reg, uval32);
 			false_32off =3D tnum_subreg(false_reg->var_off);
 		} else {
-			___mark_reg_known(false_reg, val);
+			___mark_reg_known(false_reg, uval);
 			false_64off =3D false_reg->var_off;
 		}
 		break;
 	case BPF_JSET:
 		if (is_jmp32) {
-			false_32off =3D tnum_and(false_32off, tnum_const(~val32));
-			if (is_power_of_2(val32))
+			false_32off =3D tnum_and(false_32off, tnum_const(~uval32));
+			if (is_power_of_2(uval32))
 				true_32off =3D tnum_or(true_32off,
-						     tnum_const(val32));
+						     tnum_const(uval32));
 		} else {
-			false_64off =3D tnum_and(false_64off, tnum_const(~val));
-			if (is_power_of_2(val))
+			false_64off =3D tnum_and(false_64off, tnum_const(~uval));
+			if (is_power_of_2(uval))
 				true_64off =3D tnum_or(true_64off,
-						     tnum_const(val));
+						     tnum_const(uval));
 		}
 		break;
 	case BPF_JGE:
 	case BPF_JGT:
 	{
 		if (is_jmp32) {
-			u32 false_umax =3D opcode =3D=3D BPF_JGT ? val32  : val32 - 1;
-			u32 true_umin =3D opcode =3D=3D BPF_JGT ? val32 + 1 : val32;
+			u32 false_umax =3D opcode =3D=3D BPF_JGT ? uval32  : uval32 - 1;
+			u32 true_umin =3D opcode =3D=3D BPF_JGT ? uval32 + 1 : uval32;
=20
 			false_reg->u32_max_value =3D min(false_reg->u32_max_value,
 						       false_umax);
 			true_reg->u32_min_value =3D max(true_reg->u32_min_value,
 						      true_umin);
 		} else {
-			u64 false_umax =3D opcode =3D=3D BPF_JGT ? val    : val - 1;
-			u64 true_umin =3D opcode =3D=3D BPF_JGT ? val + 1 : val;
+			u64 false_umax =3D opcode =3D=3D BPF_JGT ? uval    : uval - 1;
+			u64 true_umin =3D opcode =3D=3D BPF_JGT ? uval + 1 : uval;
=20
 			false_reg->umax_value =3D min(false_reg->umax_value, false_umax);
 			true_reg->umin_value =3D max(true_reg->umin_value, true_umin);
@@ -14570,16 +14488,16 @@ static void reg_set_min_max(struct bpf_reg_stat=
e *true_reg,
 	case BPF_JLT:
 	{
 		if (is_jmp32) {
-			u32 false_umin =3D opcode =3D=3D BPF_JLT ? val32  : val32 + 1;
-			u32 true_umax =3D opcode =3D=3D BPF_JLT ? val32 - 1 : val32;
+			u32 false_umin =3D opcode =3D=3D BPF_JLT ? uval32  : uval32 + 1;
+			u32 true_umax =3D opcode =3D=3D BPF_JLT ? uval32 - 1 : uval32;
=20
 			false_reg->u32_min_value =3D max(false_reg->u32_min_value,
 						       false_umin);
 			true_reg->u32_max_value =3D min(true_reg->u32_max_value,
 						      true_umax);
 		} else {
-			u64 false_umin =3D opcode =3D=3D BPF_JLT ? val    : val + 1;
-			u64 true_umax =3D opcode =3D=3D BPF_JLT ? val - 1 : val;
+			u64 false_umin =3D opcode =3D=3D BPF_JLT ? uval    : uval + 1;
+			u64 true_umax =3D opcode =3D=3D BPF_JLT ? uval - 1 : uval;
=20
 			false_reg->umin_value =3D max(false_reg->umin_value, false_umin);
 			true_reg->umax_value =3D min(true_reg->umax_value, true_umax);
@@ -14628,7 +14546,7 @@ static void reg_set_min_max(struct bpf_reg_state =
*true_reg,
  */
 static void reg_set_min_max_inv(struct bpf_reg_state *true_reg,
 				struct bpf_reg_state *false_reg,
-				u64 val, u32 val32,
+				u64 uval, u32 uval32,
 				u8 opcode, bool is_jmp32)
 {
 	opcode =3D flip_opcode(opcode);
@@ -14636,7 +14554,7 @@ static void reg_set_min_max_inv(struct bpf_reg_st=
ate *true_reg,
 	 * BPF_JA, can't get here.
 	 */
 	if (opcode)
-		reg_set_min_max(true_reg, false_reg, val, val32, opcode, is_jmp32);
+		reg_set_min_max(true_reg, false_reg, uval, uval32, opcode, is_jmp32);
 }
=20
 /* Regs are known to be equal, so intersect their min/max/var_off */
--=20
2.34.1



Return-Path: <bpf+bounces-13456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C17D9FAE
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA8028252D
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC933D3AD;
	Fri, 27 Oct 2023 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F993C06B
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:17:00 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835FFC1
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:59 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5aBM006235
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:58 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u0c4pu37t-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:58 -0700
Received: from twshared9518.03.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:16:51 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 422473A7966CC; Fri, 27 Oct 2023 11:14:24 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 15/23] bpf: unify 32-bit and 64-bit is_branch_taken logic
Date: Fri, 27 Oct 2023 11:13:38 -0700
Message-ID: <20231027181346.4019398-16-andrii@kernel.org>
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
X-Proofpoint-GUID: LiKayJKHC9WsR0gKFRsogf7YtnbDAFG7
X-Proofpoint-ORIG-GUID: LiKayJKHC9WsR0gKFRsogf7YtnbDAFG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

Combine 32-bit and 64-bit is_branch_taken logic for SCALAR_VALUE
registers. It makes it easier to see parallels between two domains
(32-bit and 64-bit), and makes subsequent refactoring more
straightforward.

No functional changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 154 ++++++++++--------------------------------
 1 file changed, 36 insertions(+), 118 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fedd6d0e76e5..b911d1111fad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14185,166 +14185,86 @@ static u64 reg_const_value(struct bpf_reg_stat=
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
+	u64 val =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : reg2->va=
r_off.value;
+	s64 sval =3D is_jmp32 ? (s32)val : (s64)val;
=20
 	switch (opcode) {
 	case BPF_JEQ:
-		if (tnum_is_const(subreg))
-			return !!tnum_equals_const(subreg, val);
-		else if (val < reg1->u32_min_value || val > reg1->u32_max_value)
+		if (tnum_is_const(t1))
+			return !!tnum_equals_const(t1, val);
+		else if (val < umin1 || val > umax1)
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
+			return !tnum_equals_const(t1, val);
+		else if (val < umin1 || val > umax1)
 			return 1;
-		else if (sval < reg1->s32_min_value || sval > reg1->s32_max_value)
+		else if (sval < smin1 || sval > smax1)
 			return 1;
 		break;
 	case BPF_JSET:
-		if ((~subreg.mask & subreg.value) & val)
+		if ((~t1.mask & t1.value) & val)
 			return 1;
-		if (!((subreg.mask | subreg.value) & val))
+		if (!((t1.mask | t1.value) & val))
 			return 0;
 		break;
 	case BPF_JGT:
-		if (reg1->u32_min_value > val)
+		if (umin1 > val )
 			return 1;
-		else if (reg1->u32_max_value <=3D val)
+		else if (umax1 <=3D val)
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
+		if (umax1 < val)
 			return 1;
-		else if (reg1->u32_min_value >=3D val)
+		else if (umin1 >=3D val)
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
+		if (umin1 >=3D val)
 			return 1;
-		else if (reg1->u32_max_value < val)
+		else if (umax1 < val)
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
+		if (umax1 <=3D val)
 			return 1;
-		else if (reg1->u32_min_value > val)
+		else if (umin1 > val)
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
@@ -14458,9 +14378,7 @@ static int is_branch_taken(struct bpf_reg_state *=
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
--=20
2.34.1



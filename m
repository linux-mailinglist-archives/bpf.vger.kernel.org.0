Return-Path: <bpf+bounces-13895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E8B7DEB7A
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7D71C20E5A
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668021863;
	Thu,  2 Nov 2023 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6EE1FA1
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:29 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9283A9F
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:27 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A21WNEj018928
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:27 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u3sftwesb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:27 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:26 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id EF48A3AC97F40; Wed,  1 Nov 2023 20:38:23 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v6 bpf-next 11/17] bpf: rename is_branch_taken reg arguments to prepare for the second one
Date: Wed, 1 Nov 2023 20:37:53 -0700
Message-ID: <20231102033759.2541186-12-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: Iq10sH6X494MI-bFjAqiEvxYmfUkq4WX
X-Proofpoint-GUID: Iq10sH6X494MI-bFjAqiEvxYmfUkq4WX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

Just taking mundane refactoring bits out into a separate patch. No
functional changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 108 +++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8802172fe8c9..725f327ce5eb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14167,26 +14167,26 @@ static void find_good_pkt_pointers(struct bpf_v=
erifier_state *vstate,
 	}));
 }
=20
-static int is_branch32_taken(struct bpf_reg_state *reg, u32 val, u8 opco=
de)
+static int is_branch32_taken(struct bpf_reg_state *reg1, u32 val, u8 opc=
ode)
 {
-	struct tnum subreg =3D tnum_subreg(reg->var_off);
+	struct tnum subreg =3D tnum_subreg(reg1->var_off);
 	s32 sval =3D (s32)val;
=20
 	switch (opcode) {
 	case BPF_JEQ:
 		if (tnum_is_const(subreg))
 			return !!tnum_equals_const(subreg, val);
-		else if (val < reg->u32_min_value || val > reg->u32_max_value)
+		else if (val < reg1->u32_min_value || val > reg1->u32_max_value)
 			return 0;
-		else if (sval < reg->s32_min_value || sval > reg->s32_max_value)
+		else if (sval < reg1->s32_min_value || sval > reg1->s32_max_value)
 			return 0;
 		break;
 	case BPF_JNE:
 		if (tnum_is_const(subreg))
 			return !tnum_equals_const(subreg, val);
-		else if (val < reg->u32_min_value || val > reg->u32_max_value)
+		else if (val < reg1->u32_min_value || val > reg1->u32_max_value)
 			return 1;
-		else if (sval < reg->s32_min_value || sval > reg->s32_max_value)
+		else if (sval < reg1->s32_min_value || sval > reg1->s32_max_value)
 			return 1;
 		break;
 	case BPF_JSET:
@@ -14196,51 +14196,51 @@ static int is_branch32_taken(struct bpf_reg_sta=
te *reg, u32 val, u8 opcode)
 			return 0;
 		break;
 	case BPF_JGT:
-		if (reg->u32_min_value > val)
+		if (reg1->u32_min_value > val)
 			return 1;
-		else if (reg->u32_max_value <=3D val)
+		else if (reg1->u32_max_value <=3D val)
 			return 0;
 		break;
 	case BPF_JSGT:
-		if (reg->s32_min_value > sval)
+		if (reg1->s32_min_value > sval)
 			return 1;
-		else if (reg->s32_max_value <=3D sval)
+		else if (reg1->s32_max_value <=3D sval)
 			return 0;
 		break;
 	case BPF_JLT:
-		if (reg->u32_max_value < val)
+		if (reg1->u32_max_value < val)
 			return 1;
-		else if (reg->u32_min_value >=3D val)
+		else if (reg1->u32_min_value >=3D val)
 			return 0;
 		break;
 	case BPF_JSLT:
-		if (reg->s32_max_value < sval)
+		if (reg1->s32_max_value < sval)
 			return 1;
-		else if (reg->s32_min_value >=3D sval)
+		else if (reg1->s32_min_value >=3D sval)
 			return 0;
 		break;
 	case BPF_JGE:
-		if (reg->u32_min_value >=3D val)
+		if (reg1->u32_min_value >=3D val)
 			return 1;
-		else if (reg->u32_max_value < val)
+		else if (reg1->u32_max_value < val)
 			return 0;
 		break;
 	case BPF_JSGE:
-		if (reg->s32_min_value >=3D sval)
+		if (reg1->s32_min_value >=3D sval)
 			return 1;
-		else if (reg->s32_max_value < sval)
+		else if (reg1->s32_max_value < sval)
 			return 0;
 		break;
 	case BPF_JLE:
-		if (reg->u32_max_value <=3D val)
+		if (reg1->u32_max_value <=3D val)
 			return 1;
-		else if (reg->u32_min_value > val)
+		else if (reg1->u32_min_value > val)
 			return 0;
 		break;
 	case BPF_JSLE:
-		if (reg->s32_max_value <=3D sval)
+		if (reg1->s32_max_value <=3D sval)
 			return 1;
-		else if (reg->s32_min_value > sval)
+		else if (reg1->s32_min_value > sval)
 			return 0;
 		break;
 	}
@@ -14249,79 +14249,79 @@ static int is_branch32_taken(struct bpf_reg_sta=
te *reg, u32 val, u8 opcode)
 }
=20
=20
-static int is_branch64_taken(struct bpf_reg_state *reg, u64 val, u8 opco=
de)
+static int is_branch64_taken(struct bpf_reg_state *reg1, u64 val, u8 opc=
ode)
 {
 	s64 sval =3D (s64)val;
=20
 	switch (opcode) {
 	case BPF_JEQ:
-		if (tnum_is_const(reg->var_off))
-			return !!tnum_equals_const(reg->var_off, val);
-		else if (val < reg->umin_value || val > reg->umax_value)
+		if (tnum_is_const(reg1->var_off))
+			return !!tnum_equals_const(reg1->var_off, val);
+		else if (val < reg1->umin_value || val > reg1->umax_value)
 			return 0;
-		else if (sval < reg->smin_value || sval > reg->smax_value)
+		else if (sval < reg1->smin_value || sval > reg1->smax_value)
 			return 0;
 		break;
 	case BPF_JNE:
-		if (tnum_is_const(reg->var_off))
-			return !tnum_equals_const(reg->var_off, val);
-		else if (val < reg->umin_value || val > reg->umax_value)
+		if (tnum_is_const(reg1->var_off))
+			return !tnum_equals_const(reg1->var_off, val);
+		else if (val < reg1->umin_value || val > reg1->umax_value)
 			return 1;
-		else if (sval < reg->smin_value || sval > reg->smax_value)
+		else if (sval < reg1->smin_value || sval > reg1->smax_value)
 			return 1;
 		break;
 	case BPF_JSET:
-		if ((~reg->var_off.mask & reg->var_off.value) & val)
+		if ((~reg1->var_off.mask & reg1->var_off.value) & val)
 			return 1;
-		if (!((reg->var_off.mask | reg->var_off.value) & val))
+		if (!((reg1->var_off.mask | reg1->var_off.value) & val))
 			return 0;
 		break;
 	case BPF_JGT:
-		if (reg->umin_value > val)
+		if (reg1->umin_value > val)
 			return 1;
-		else if (reg->umax_value <=3D val)
+		else if (reg1->umax_value <=3D val)
 			return 0;
 		break;
 	case BPF_JSGT:
-		if (reg->smin_value > sval)
+		if (reg1->smin_value > sval)
 			return 1;
-		else if (reg->smax_value <=3D sval)
+		else if (reg1->smax_value <=3D sval)
 			return 0;
 		break;
 	case BPF_JLT:
-		if (reg->umax_value < val)
+		if (reg1->umax_value < val)
 			return 1;
-		else if (reg->umin_value >=3D val)
+		else if (reg1->umin_value >=3D val)
 			return 0;
 		break;
 	case BPF_JSLT:
-		if (reg->smax_value < sval)
+		if (reg1->smax_value < sval)
 			return 1;
-		else if (reg->smin_value >=3D sval)
+		else if (reg1->smin_value >=3D sval)
 			return 0;
 		break;
 	case BPF_JGE:
-		if (reg->umin_value >=3D val)
+		if (reg1->umin_value >=3D val)
 			return 1;
-		else if (reg->umax_value < val)
+		else if (reg1->umax_value < val)
 			return 0;
 		break;
 	case BPF_JSGE:
-		if (reg->smin_value >=3D sval)
+		if (reg1->smin_value >=3D sval)
 			return 1;
-		else if (reg->smax_value < sval)
+		else if (reg1->smax_value < sval)
 			return 0;
 		break;
 	case BPF_JLE:
-		if (reg->umax_value <=3D val)
+		if (reg1->umax_value <=3D val)
 			return 1;
-		else if (reg->umin_value > val)
+		else if (reg1->umin_value > val)
 			return 0;
 		break;
 	case BPF_JSLE:
-		if (reg->smax_value <=3D sval)
+		if (reg1->smax_value <=3D sval)
 			return 1;
-		else if (reg->smin_value > sval)
+		else if (reg1->smin_value > sval)
 			return 0;
 		break;
 	}
@@ -14336,11 +14336,11 @@ static int is_branch64_taken(struct bpf_reg_sta=
te *reg, u64 val, u8 opcode)
  * -1 - unknown. Example: "if (reg < 5)" is unknown when register value
  *      range [0,10]
  */
-static int is_branch_taken(struct bpf_reg_state *reg, u64 val, u8 opcode=
,
+static int is_branch_taken(struct bpf_reg_state *reg1, u64 val, u8 opcod=
e,
 			   bool is_jmp32)
 {
-	if (__is_pointer_value(false, reg)) {
-		if (!reg_not_null(reg))
+	if (__is_pointer_value(false, reg1)) {
+		if (!reg_not_null(reg1))
 			return -1;
=20
 		/* If pointer is valid tests against zero will fail so we can
@@ -14360,8 +14360,8 @@ static int is_branch_taken(struct bpf_reg_state *=
reg, u64 val, u8 opcode,
 	}
=20
 	if (is_jmp32)
-		return is_branch32_taken(reg, val, opcode);
-	return is_branch64_taken(reg, val, opcode);
+		return is_branch32_taken(reg1, val, opcode);
+	return is_branch64_taken(reg1, val, opcode);
 }
=20
 static int flip_opcode(u32 opcode)
--=20
2.34.1



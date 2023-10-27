Return-Path: <bpf+bounces-13449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5537D9FA7
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9E71F23797
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39D33C6A9;
	Fri, 27 Oct 2023 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3121D3C066
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:16:54 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16FCC1
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:52 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39RE53c9003192
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:52 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u089achyn-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:52 -0700
Received: from twshared9518.03.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:16:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 12C423A796680; Fri, 27 Oct 2023 11:14:16 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 11/23] bpf: rename is_branch_taken reg arguments to prepare for the second one
Date: Fri, 27 Oct 2023 11:13:34 -0700
Message-ID: <20231027181346.4019398-12-andrii@kernel.org>
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
X-Proofpoint-GUID: QtIV1G5f_KfZ9YGTj-bBuElIGLiMu90H
X-Proofpoint-ORIG-GUID: QtIV1G5f_KfZ9YGTj-bBuElIGLiMu90H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

Just taking mundane refactoring bits out into a separate patch. No
functional changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 107 +++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f5fcb7fb2c67..aa13f32751a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14169,26 +14169,25 @@ static void find_good_pkt_pointers(struct bpf_v=
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
@@ -14198,51 +14197,51 @@ static int is_branch32_taken(struct bpf_reg_sta=
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
@@ -14251,79 +14250,79 @@ static int is_branch32_taken(struct bpf_reg_sta=
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
@@ -14338,11 +14337,11 @@ static int is_branch64_taken(struct bpf_reg_sta=
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
@@ -14362,8 +14361,8 @@ static int is_branch_taken(struct bpf_reg_state *=
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



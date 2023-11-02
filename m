Return-Path: <bpf+bounces-13899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A42E7DEB7E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA08A1C20E69
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE151FA5;
	Thu,  2 Nov 2023 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624361FA3
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:38 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15165ED
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:37 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A21WNEx018928
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:36 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u3sftwesb-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:36 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 264B93AC97F72; Wed,  1 Nov 2023 20:38:30 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v6 bpf-next 14/17] bpf: generalize is_branch_taken to handle all conditional jumps in one place
Date: Wed, 1 Nov 2023 20:37:56 -0700
Message-ID: <20231102033759.2541186-15-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: hwpUCUpfeaKmjOyjD6CjICBSoBozZtyd
X-Proofpoint-GUID: hwpUCUpfeaKmjOyjD6CjICBSoBozZtyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

Make is_branch_taken() a single entry point for branch pruning decision
making, handling both pointer vs pointer, pointer vs scalar, and scalar
vs scalar cases in one place. This also nicely cleans up check_cond_jmp_o=
p().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 49 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c5d187d43fa1..d5213cef5389 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14167,6 +14167,19 @@ static void find_good_pkt_pointers(struct bpf_ve=
rifier_state *vstate,
 	}));
 }
=20
+/* check if register is a constant scalar value */
+static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
+{
+	return reg->type =3D=3D SCALAR_VALUE &&
+	       tnum_is_const(subreg32 ? tnum_subreg(reg->var_off) : reg->var_of=
f);
+}
+
+/* assuming is_reg_const() is true, return constant value of a register =
*/
+static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
+{
+	return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.value;
+}
+
 /*
  * <reg1> <op> <reg2>, currently assuming reg2 is a constant
  */
@@ -14408,12 +14421,20 @@ static int is_pkt_ptr_branch_taken(struct bpf_r=
eg_state *dst_reg,
 static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_st=
ate *reg2,
 			   u8 opcode, bool is_jmp32)
 {
-	struct tnum reg2_tnum =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2-=
>var_off;
 	u64 val;
=20
-	if (!tnum_is_const(reg2_tnum))
+	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2) && !is=
_jmp32)
+		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
+
+	/* try to make sure reg2 is a constant SCALAR_VALUE */
+	if (!is_reg_const(reg2, is_jmp32)) {
+		opcode =3D flip_opcode(opcode);
+		swap(reg1, reg2);
+	}
+	/* for now we expect reg2 to be a constant to make any useful decisions=
 */
+	if (!is_reg_const(reg2, is_jmp32))
 		return -1;
-	val =3D reg2_tnum.value;
+	val =3D reg_const_value(reg2, is_jmp32);
=20
 	if (__is_pointer_value(false, reg1)) {
 		if (!reg_not_null(reg1))
@@ -14894,27 +14915,7 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
 	}
=20
 	is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
-
-	if (BPF_SRC(insn->code) =3D=3D BPF_K) {
-		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
-	} else if (src_reg->type =3D=3D SCALAR_VALUE &&
-		   is_jmp32 && tnum_is_const(tnum_subreg(src_reg->var_off))) {
-		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
-	} else if (src_reg->type =3D=3D SCALAR_VALUE &&
-		   !is_jmp32 && tnum_is_const(src_reg->var_off)) {
-		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
-	} else if (dst_reg->type =3D=3D SCALAR_VALUE &&
-		   is_jmp32 && tnum_is_const(tnum_subreg(dst_reg->var_off))) {
-		pred =3D is_branch_taken(src_reg, dst_reg, flip_opcode(opcode), is_jmp=
32);
-	} else if (dst_reg->type =3D=3D SCALAR_VALUE &&
-		   !is_jmp32 && tnum_is_const(dst_reg->var_off)) {
-		pred =3D is_branch_taken(src_reg, dst_reg, flip_opcode(opcode), is_jmp=
32);
-	} else if (reg_is_pkt_pointer_any(dst_reg) &&
-		   reg_is_pkt_pointer_any(src_reg) &&
-		   !is_jmp32) {
-		pred =3D is_pkt_ptr_branch_taken(dst_reg, src_reg, opcode);
-	}
-
+	pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
 	if (pred >=3D 0) {
 		/* If we get here with a dst_reg pointer type it is because
 		 * above is_branch_taken() special cased the 0 comparison.
--=20
2.34.1



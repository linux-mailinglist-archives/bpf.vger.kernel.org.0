Return-Path: <bpf+bounces-13902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4147DEB81
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E97281A60
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD11C03;
	Thu,  2 Nov 2023 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A36185B
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6BA113
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:44 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A21cU3g030354
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:44 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u3vb43rsy-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:44 -0700
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5595F3AC97F8C; Wed,  1 Nov 2023 20:38:36 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v6 bpf-next 17/17] bpf: generalize reg_set_min_max() to handle two sets of two registers
Date: Wed, 1 Nov 2023 20:37:59 -0700
Message-ID: <20231102033759.2541186-18-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: RH5XO0ybBiXVk1EvI9-MIUx5CmzUTDYs
X-Proofpoint-GUID: RH5XO0ybBiXVk1EvI9-MIUx5CmzUTDYs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

Change reg_set_min_max() to take FALSE/TRUE sets of two registers each,
instead of assuming that we are always comparing to a constant. For now
we still assume that right-hand side registers are constants (and make
sure that's the case by swapping src/dst regs, if necessary), but
subsequent patches will remove this limitation.

reg_set_min_max() is now called unconditionally for any register
comparison, so that might include pointer vs pointer. This makes it
consistent with is_branch_taken() generality. But we currently only
support adjustments based on SCALAR vs SCALAR comparisons, so
reg_set_min_max() has to guard itself againts pointers.

Taking two by two registers allows to further unify and simplify
check_cond_jmp_op() logic. We utilize fake register for BPF_K
conditional jump case, just like with is_branch_taken() part.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 131 ++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 75 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 438bf96b1c2d..2197385d91dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14379,32 +14379,50 @@ static int is_branch_taken(struct bpf_reg_state=
 *reg1, struct bpf_reg_state *reg
 	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
 }
=20
-/* Adjusts the register min/max values in the case that the dst_reg is t=
he
- * variable register that we are working on, and src_reg is a constant o=
r we're
- * simply doing a BPF_K check.
- * In JEQ/JNE cases we also adjust the var_off values.
+/* Adjusts the register min/max values in the case that the dst_reg and
+ * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF=
_K
+ * check, in which case we havea fake SCALAR_VALUE representing insn->im=
m).
+ * Technically we can do similar adjustments for pointers to the same ob=
ject,
+ * but we don't support that right now.
  */
 static void reg_set_min_max(struct bpf_reg_state *true_reg1,
+			    struct bpf_reg_state *true_reg2,
 			    struct bpf_reg_state *false_reg1,
-			    u64 uval, u32 uval32,
+			    struct bpf_reg_state *false_reg2,
 			    u8 opcode, bool is_jmp32)
 {
-	struct tnum false_32off =3D tnum_subreg(false_reg1->var_off);
-	struct tnum false_64off =3D false_reg1->var_off;
-	struct tnum true_32off =3D tnum_subreg(true_reg1->var_off);
-	struct tnum true_64off =3D true_reg1->var_off;
-	s64 sval =3D (s64)uval;
-	s32 sval32 =3D (s32)uval32;
-
-	/* If the dst_reg is a pointer, we can't learn anything about its
-	 * variable offset from the compare (unless src_reg were a pointer into
-	 * the same object, but we don't bother with that.
-	 * Since false_reg1 and true_reg1 have the same type by construction, w=
e
-	 * only need to check one of them for pointerness.
+	struct tnum false_32off, false_64off;
+	struct tnum true_32off, true_64off;
+	u64 uval;
+	u32 uval32;
+	s64 sval;
+	s32 sval32;
+
+	/* If either register is a pointer, we can't learn anything about its
+	 * variable offset from the compare (unless they were a pointer into
+	 * the same object, but we don't bother with that).
 	 */
-	if (__is_pointer_value(false, false_reg1))
+	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE)
+		return;
+
+	/* we expect right-hand registers (src ones) to be constants, for now *=
/
+	if (!is_reg_const(false_reg2, is_jmp32)) {
+		opcode =3D flip_opcode(opcode);
+		swap(true_reg1, true_reg2);
+		swap(false_reg1, false_reg2);
+	}
+	if (!is_reg_const(false_reg2, is_jmp32))
 		return;
=20
+	false_32off =3D tnum_subreg(false_reg1->var_off);
+	false_64off =3D false_reg1->var_off;
+	true_32off =3D tnum_subreg(true_reg1->var_off);
+	true_64off =3D true_reg1->var_off;
+	uval =3D false_reg2->var_off.value;
+	uval32 =3D (u32)tnum_subreg(false_reg2->var_off).value;
+	sval =3D (s64)uval;
+	sval32 =3D (s32)uval32;
+
 	switch (opcode) {
 	/* JEQ/JNE comparison doesn't change the register equivalence.
 	 *
@@ -14541,22 +14559,6 @@ static void reg_set_min_max(struct bpf_reg_state=
 *true_reg1,
 	}
 }
=20
-/* Same as above, but for the case that dst_reg holds a constant and src=
_reg is
- * the variable reg.
- */
-static void reg_set_min_max_inv(struct bpf_reg_state *true_reg,
-				struct bpf_reg_state *false_reg,
-				u64 uval, u32 uval32,
-				u8 opcode, bool is_jmp32)
-{
-	opcode =3D flip_opcode(opcode);
-	/* This uses zero as "not present in table"; luckily the zero opcode,
-	 * BPF_JA, can't get here.
-	 */
-	if (opcode)
-		reg_set_min_max(true_reg, false_reg, uval, uval32, opcode, is_jmp32);
-}
-
 /* Regs are known to be equal, so intersect their min/max/var_off */
 static void __reg_combine_min_max(struct bpf_reg_state *src_reg,
 				  struct bpf_reg_state *dst_reg)
@@ -14881,53 +14883,32 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
 		return -EFAULT;
 	other_branch_regs =3D other_branch->frame[other_branch->curframe]->regs=
;
=20
-	/* detect if we are comparing against a constant value so we can adjust
-	 * our min/max values for our dst register.
-	 * this is only legit if both are scalars (or pointers to the same
-	 * object, I suppose, see the PTR_MAYBE_NULL related if block below),
-	 * because otherwise the different base pointers mean the offsets aren'=
t
-	 * comparable.
-	 */
 	if (BPF_SRC(insn->code) =3D=3D BPF_X) {
-		struct bpf_reg_state *src_reg =3D &regs[insn->src_reg];
+		reg_set_min_max(&other_branch_regs[insn->dst_reg],
+				&other_branch_regs[insn->src_reg],
+				dst_reg, src_reg, opcode, is_jmp32);
=20
 		if (dst_reg->type =3D=3D SCALAR_VALUE &&
-		    src_reg->type =3D=3D SCALAR_VALUE) {
-			if (tnum_is_const(src_reg->var_off) ||
-			    (is_jmp32 &&
-			     tnum_is_const(tnum_subreg(src_reg->var_off))))
-				reg_set_min_max(&other_branch_regs[insn->dst_reg],
-						dst_reg,
-						src_reg->var_off.value,
-						tnum_subreg(src_reg->var_off).value,
-						opcode, is_jmp32);
-			else if (tnum_is_const(dst_reg->var_off) ||
-				 (is_jmp32 &&
-				  tnum_is_const(tnum_subreg(dst_reg->var_off))))
-				reg_set_min_max_inv(&other_branch_regs[insn->src_reg],
-						    src_reg,
-						    dst_reg->var_off.value,
-						    tnum_subreg(dst_reg->var_off).value,
-						    opcode, is_jmp32);
-			else if (!is_jmp32 &&
-				 (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE))
-				/* Comparing for equality, we can combine knowledge */
-				reg_combine_min_max(&other_branch_regs[insn->src_reg],
-						    &other_branch_regs[insn->dst_reg],
-						    src_reg, dst_reg, opcode);
-			if (src_reg->id &&
-			    !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_reg].i=
d)) {
-				find_equal_scalars(this_branch, src_reg);
-				find_equal_scalars(other_branch, &other_branch_regs[insn->src_reg]);
-			}
-
-		}
-	} else if (dst_reg->type =3D=3D SCALAR_VALUE) {
+		    src_reg->type =3D=3D SCALAR_VALUE &&
+		    !is_jmp32 && (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE)) {
+			/* Comparing for equality, we can combine knowledge */
+			reg_combine_min_max(&other_branch_regs[insn->src_reg],
+					    &other_branch_regs[insn->dst_reg],
+					    src_reg, dst_reg, opcode);
+		}
+	} else /* BPF_SRC(insn->code) =3D=3D BPF_K */ {
 		reg_set_min_max(&other_branch_regs[insn->dst_reg],
-					dst_reg, insn->imm, (u32)insn->imm,
-					opcode, is_jmp32);
+				src_reg /* fake one */,
+				dst_reg, src_reg /* same fake one */,
+				opcode, is_jmp32);
 	}
=20
+	if (BPF_SRC(insn->code) =3D=3D BPF_X &&
+	    src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
+	    !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_reg].id)=
) {
+		find_equal_scalars(this_branch, src_reg);
+		find_equal_scalars(other_branch, &other_branch_regs[insn->src_reg]);
+	}
 	if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id &&
 	    !WARN_ON_ONCE(dst_reg->id !=3D other_branch_regs[insn->dst_reg].id)=
) {
 		find_equal_scalars(this_branch, dst_reg);
--=20
2.34.1



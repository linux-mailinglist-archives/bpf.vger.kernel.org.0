Return-Path: <bpf+bounces-13452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0F47D9FAB
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AED2B21424
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801E93B7B3;
	Fri, 27 Oct 2023 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AE3C091
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:16:56 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FB410A
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:55 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39RE5R2k031877
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:54 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3u08vevbgn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:54 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:16:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5EECA3A7966F2; Fri, 27 Oct 2023 11:14:28 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 17/23] bpf: generalize reg_set_min_max() to handle two sets of two registers
Date: Fri, 27 Oct 2023 11:13:40 -0700
Message-ID: <20231027181346.4019398-18-andrii@kernel.org>
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
X-Proofpoint-GUID: dxGibWYO8DLtFqp0W77eF5DZE24VosVT
X-Proofpoint-ORIG-GUID: dxGibWYO8DLtFqp0W77eF5DZE24VosVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

Change reg_set_min_max() to take FALSE/TRUE sets of two registers each,
instead of assuming that we are always comparing to a constant. For now
we still assume that right-hand side registers are constants (and make
sure that's the case by swapping src/dst regs, if necessary), but
subsequent patches will remove this limitation.

Taking two by two registers allows to further unify and simplify
check_cond_jmp_op() logic. We utilize fake register for BPF_K
conditional jump case, just like with is_branch_taken() part.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 112 ++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 63 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dde04b17c3a3..522566699fbe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14387,26 +14387,43 @@ static int is_branch_taken(struct bpf_reg_state=
 *reg1, struct bpf_reg_state *reg
  * In JEQ/JNE cases we also adjust the var_off values.
  */
 static void reg_set_min_max(struct bpf_reg_state *true_reg1,
+			    struct bpf_reg_state *true_reg2,
 			    struct bpf_reg_state *false_reg1,
-			    u64 val, u32 val32,
+			    struct bpf_reg_state *false_reg2,
 			    u8 opcode, bool is_jmp32)
 {
-	struct tnum false_32off =3D tnum_subreg(false_reg1->var_off);
-	struct tnum false_64off =3D false_reg1->var_off;
-	struct tnum true_32off =3D tnum_subreg(true_reg1->var_off);
-	struct tnum true_64off =3D true_reg1->var_off;
-	s64 sval =3D (s64)val;
-	s32 sval32 =3D (s32)val32;
-
-	/* If the dst_reg is a pointer, we can't learn anything about its
-	 * variable offset from the compare (unless src_reg were a pointer into
-	 * the same object, but we don't bother with that.
-	 * Since false_reg1 and true_reg1 have the same type by construction, w=
e
-	 * only need to check one of them for pointerness.
+	struct tnum false_32off, false_64off;
+	struct tnum true_32off, true_64off;
+	u64 val;
+	u32 val32;
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
+	val =3D false_reg2->var_off.value;
+	val32 =3D (u32)tnum_subreg(false_reg2->var_off).value;
+	sval =3D (s64)val;
+	sval32 =3D (s32)val32;
+
 	switch (opcode) {
 	/* JEQ/JNE comparison doesn't change the register equivalence.
 	 *
@@ -14543,22 +14560,6 @@ static void reg_set_min_max(struct bpf_reg_state=
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
-				u64 val, u32 val32,
-				u8 opcode, bool is_jmp32)
-{
-	opcode =3D flip_opcode(opcode);
-	/* This uses zero as "not present in table"; luckily the zero opcode,
-	 * BPF_JA, can't get here.
-	 */
-	if (opcode)
-		reg_set_min_max(true_reg, false_reg, val, val32, opcode, is_jmp32);
-}
-
 /* Regs are known to be equal, so intersect their min/max/var_off */
 static void __reg_combine_min_max(struct bpf_reg_state *src_reg,
 				  struct bpf_reg_state *dst_reg)
@@ -14891,45 +14892,30 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
 	 * comparable.
 	 */
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
+		    src_reg->type =3D=3D SCALAR_VALUE &&
+		    !is_jmp32 && (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE)) {
+			/* Comparing for equality, we can combine knowledge */
+			reg_combine_min_max(&other_branch_regs[insn->src_reg],
+					    &other_branch_regs[insn->dst_reg],
+					    src_reg, dst_reg, opcode);
 		}
 	} else if (dst_reg->type =3D=3D SCALAR_VALUE) {
-		reg_set_min_max(&other_branch_regs[insn->dst_reg],
-					dst_reg, insn->imm, (u32)insn->imm,
-					opcode, is_jmp32);
+		reg_set_min_max(&other_branch_regs[insn->dst_reg], src_reg, /* fake on=
e */
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



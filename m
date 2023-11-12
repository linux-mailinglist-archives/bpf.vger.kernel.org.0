Return-Path: <bpf+bounces-14898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3437E8DD1
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F5E280CF7
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECAA1872;
	Sun, 12 Nov 2023 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338917C6
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:06:31 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64C9324A
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:29 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABLPU4t026788
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:29 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua5tqb5as-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:29 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:24 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B999F3B5D516D; Sat, 11 Nov 2023 17:06:12 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 01/13] bpf: generalize reg_set_min_max() to handle non-const register comparisons
Date: Sat, 11 Nov 2023 17:05:57 -0800
Message-ID: <20231112010609.848406-2-andrii@kernel.org>
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
X-Proofpoint-GUID: _0zYRxan7H316BQBlDunCGTnf1nDk-pO
X-Proofpoint-ORIG-GUID: _0zYRxan7H316BQBlDunCGTnf1nDk-pO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

Generalize bounds adjustment logic of reg_set_min_max() to handle not
just register vs constant case, but in general any register vs any
register cases. For most of the operations it's trivial extension based
on range vs range comparison logic, we just need to properly pick
min/max of a range to compare against min/max of the other range.

For BPF_JSET we keep the original capabilities, just make sure JSET is
integrated in the common framework. This is manifested in the
internal-only BPF_JSET + BPF_X "opcode" to allow for simpler and more
uniform rev_opcode() handling. See the code for details. This allows to
reuse the same code exactly both for TRUE and FALSE branches without
explicitly handling both conditions with custom code.

Note also that now we don't need a special handling of BPF_JEQ/BPF_JNE
case none of the registers are constants. This is now just a normal
generic case handled by reg_set_min_max().

To make tnum handling cleaner, tnum_with_subreg() helper is added, as
that's a common operator when dealing with 32-bit subregister bounds.
This keeps the overall logic much less noisy when it comes to tnums.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/tnum.h  |   4 +
 kernel/bpf/tnum.c     |   7 +-
 kernel/bpf/verifier.c | 314 ++++++++++++++++++------------------------
 3 files changed, 146 insertions(+), 179 deletions(-)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index 1c3948a1d6ad..3c13240077b8 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -106,6 +106,10 @@ int tnum_sbin(char *str, size_t size, struct tnum a)=
;
 struct tnum tnum_subreg(struct tnum a);
 /* Returns the tnum with the lower 32-bit subreg cleared */
 struct tnum tnum_clear_subreg(struct tnum a);
+/* Returns the tnum with the lower 32-bit subreg in *reg* set to the low=
er
+ * 32-bit subreg in *subreg*
+ */
+struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg);
 /* Returns the tnum with the lower 32-bit subreg set to value */
 struct tnum tnum_const_subreg(struct tnum a, u32 value);
 /* Returns true if 32-bit subreg @a is a known constant*/
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index 3d7127f439a1..f4c91c9b27d7 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -208,7 +208,12 @@ struct tnum tnum_clear_subreg(struct tnum a)
 	return tnum_lshift(tnum_rshift(a, 32), 32);
 }
=20
+struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg)
+{
+	return tnum_or(tnum_clear_subreg(reg), tnum_subreg(subreg));
+}
+
 struct tnum tnum_const_subreg(struct tnum a, u32 value)
 {
-	return tnum_or(tnum_clear_subreg(a), tnum_const(value));
+	return tnum_with_subreg(a, tnum_const(value));
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9ae6eae13471..39ce141c55d3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14453,218 +14453,186 @@ static int is_branch_taken(struct bpf_reg_sta=
te *reg1, struct bpf_reg_state *reg
 	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
 }
=20
-/* Adjusts the register min/max values in the case that the dst_reg and
- * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF=
_K
- * check, in which case we havea fake SCALAR_VALUE representing insn->im=
m).
- * Technically we can do similar adjustments for pointers to the same ob=
ject,
- * but we don't support that right now.
+/* Opcode that corresponds to a *false* branch condition.
+ * E.g., if r1 < r2, then reverse (false) condition is r1 >=3D r2
  */
-static void reg_set_min_max(struct bpf_reg_state *true_reg1,
-			    struct bpf_reg_state *true_reg2,
-			    struct bpf_reg_state *false_reg1,
-			    struct bpf_reg_state *false_reg2,
-			    u8 opcode, bool is_jmp32)
+static u8 rev_opcode(u8 opcode)
 {
-	struct tnum false_32off, false_64off;
-	struct tnum true_32off, true_64off;
-	u64 uval;
-	u32 uval32;
-	s64 sval;
-	s32 sval32;
-
-	/* If either register is a pointer, we can't learn anything about its
-	 * variable offset from the compare (unless they were a pointer into
-	 * the same object, but we don't bother with that).
+	switch (opcode) {
+	case BPF_JEQ:		return BPF_JNE;
+	case BPF_JNE:		return BPF_JEQ;
+	/* JSET doesn't have it's reverse opcode in BPF, so add
+	 * BPF_X flag to denote the reverse of that operation
 	 */
-	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE)
-		return;
-
-	/* we expect right-hand registers (src ones) to be constants, for now *=
/
-	if (!is_reg_const(false_reg2, is_jmp32)) {
-		opcode =3D flip_opcode(opcode);
-		swap(true_reg1, true_reg2);
-		swap(false_reg1, false_reg2);
+	case BPF_JSET:		return BPF_JSET | BPF_X;
+	case BPF_JSET | BPF_X:	return BPF_JSET;
+	case BPF_JGE:		return BPF_JLT;
+	case BPF_JGT:		return BPF_JLE;
+	case BPF_JLE:		return BPF_JGT;
+	case BPF_JLT:		return BPF_JGE;
+	case BPF_JSGE:		return BPF_JSLT;
+	case BPF_JSGT:		return BPF_JSLE;
+	case BPF_JSLE:		return BPF_JSGT;
+	case BPF_JSLT:		return BPF_JSGE;
+	default:		return 0;
 	}
-	if (!is_reg_const(false_reg2, is_jmp32))
-		return;
+}
=20
-	false_32off =3D tnum_subreg(false_reg1->var_off);
-	false_64off =3D false_reg1->var_off;
-	true_32off =3D tnum_subreg(true_reg1->var_off);
-	true_64off =3D true_reg1->var_off;
-	uval =3D false_reg2->var_off.value;
-	uval32 =3D (u32)tnum_subreg(false_reg2->var_off).value;
-	sval =3D (s64)uval;
-	sval32 =3D (s32)uval32;
+/* Refine range knowledge for <reg1> <op> <reg>2 conditional operation. =
*/
+static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_r=
eg_state *reg2,
+				u8 opcode, bool is_jmp32)
+{
+	struct tnum t;
+	u64 val;
=20
+again:
 	switch (opcode) {
-	/* JEQ/JNE comparison doesn't change the register equivalence.
-	 *
-	 * r1 =3D r2;
-	 * if (r1 =3D=3D 42) goto label;
-	 * ...
-	 * label: // here both r1 and r2 are known to be 42.
-	 *
-	 * Hence when marking register as known preserve it's ID.
-	 */
 	case BPF_JEQ:
 		if (is_jmp32) {
-			__mark_reg32_known(true_reg1, uval32);
-			true_32off =3D tnum_subreg(true_reg1->var_off);
+			reg1->u32_min_value =3D max(reg1->u32_min_value, reg2->u32_min_value)=
;
+			reg1->u32_max_value =3D min(reg1->u32_max_value, reg2->u32_max_value)=
;
+			reg1->s32_min_value =3D max(reg1->s32_min_value, reg2->s32_min_value)=
;
+			reg1->s32_max_value =3D min(reg1->s32_max_value, reg2->s32_max_value)=
;
+			reg2->u32_min_value =3D reg1->u32_min_value;
+			reg2->u32_max_value =3D reg1->u32_max_value;
+			reg2->s32_min_value =3D reg1->s32_min_value;
+			reg2->s32_max_value =3D reg1->s32_max_value;
+
+			t =3D tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->va=
r_off));
+			reg1->var_off =3D tnum_with_subreg(reg1->var_off, t);
+			reg2->var_off =3D tnum_with_subreg(reg2->var_off, t);
 		} else {
-			___mark_reg_known(true_reg1, uval);
-			true_64off =3D true_reg1->var_off;
+			reg1->umin_value =3D max(reg1->umin_value, reg2->umin_value);
+			reg1->umax_value =3D min(reg1->umax_value, reg2->umax_value);
+			reg1->smin_value =3D max(reg1->smin_value, reg2->smin_value);
+			reg1->smax_value =3D min(reg1->smax_value, reg2->smax_value);
+			reg2->umin_value =3D reg1->umin_value;
+			reg2->umax_value =3D reg1->umax_value;
+			reg2->smin_value =3D reg1->smin_value;
+			reg2->smax_value =3D reg1->smax_value;
+
+			reg1->var_off =3D tnum_intersect(reg1->var_off, reg2->var_off);
+			reg2->var_off =3D reg1->var_off;
 		}
 		break;
 	case BPF_JNE:
-		if (is_jmp32) {
-			__mark_reg32_known(false_reg1, uval32);
-			false_32off =3D tnum_subreg(false_reg1->var_off);
-		} else {
-			___mark_reg_known(false_reg1, uval);
-			false_64off =3D false_reg1->var_off;
-		}
+		/* we don't derive any new information for inequality yet */
 		break;
 	case BPF_JSET:
+		if (!is_reg_const(reg2, is_jmp32))
+			swap(reg1, reg2);
+		if (!is_reg_const(reg2, is_jmp32))
+			break;
+		val =3D reg_const_value(reg2, is_jmp32);
+		/* BPF_JSET (i.e., TRUE branch, *not* BPF_JSET | BPF_X)
+		 * requires single bit to learn something useful. E.g., if we
+		 * know that `r1 & 0x3` is true, then which bits (0, 1, or both)
+		 * are actually set? We can learn something definite only if
+		 * it's a single-bit value to begin with.
+		 *
+		 * BPF_JSET | BPF_X (i.e., negation of BPF_JSET) doesn't have
+		 * this restriction. I.e., !(r1 & 0x3) means neither bit 0 nor
+		 * bit 1 is set, which we can readily use in adjustments.
+		 */
+		if (!is_power_of_2(val))
+			break;
 		if (is_jmp32) {
-			false_32off =3D tnum_and(false_32off, tnum_const(~uval32));
-			if (is_power_of_2(uval32))
-				true_32off =3D tnum_or(true_32off,
-						     tnum_const(uval32));
+			t =3D tnum_or(tnum_subreg(reg1->var_off), tnum_const(val));
+			reg1->var_off =3D tnum_with_subreg(reg1->var_off, t);
 		} else {
-			false_64off =3D tnum_and(false_64off, tnum_const(~uval));
-			if (is_power_of_2(uval))
-				true_64off =3D tnum_or(true_64off,
-						     tnum_const(uval));
+			reg1->var_off =3D tnum_or(reg1->var_off, tnum_const(val));
 		}
 		break;
-	case BPF_JGE:
-	case BPF_JGT:
-	{
+	case BPF_JSET | BPF_X: /* reverse of BPF_JSET, see rev_opcode() */
+		if (!is_reg_const(reg2, is_jmp32))
+			swap(reg1, reg2);
+		if (!is_reg_const(reg2, is_jmp32))
+			break;
+		val =3D reg_const_value(reg2, is_jmp32);
 		if (is_jmp32) {
-			u32 false_umax =3D opcode =3D=3D BPF_JGT ? uval32  : uval32 - 1;
-			u32 true_umin =3D opcode =3D=3D BPF_JGT ? uval32 + 1 : uval32;
-
-			false_reg1->u32_max_value =3D min(false_reg1->u32_max_value,
-						       false_umax);
-			true_reg1->u32_min_value =3D max(true_reg1->u32_min_value,
-						      true_umin);
+			t =3D tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
+			reg1->var_off =3D tnum_with_subreg(reg1->var_off, t);
 		} else {
-			u64 false_umax =3D opcode =3D=3D BPF_JGT ? uval    : uval - 1;
-			u64 true_umin =3D opcode =3D=3D BPF_JGT ? uval + 1 : uval;
-
-			false_reg1->umax_value =3D min(false_reg1->umax_value, false_umax);
-			true_reg1->umin_value =3D max(true_reg1->umin_value, true_umin);
+			reg1->var_off =3D tnum_and(reg1->var_off, tnum_const(~val));
 		}
 		break;
-	}
-	case BPF_JSGE:
-	case BPF_JSGT:
-	{
+	case BPF_JLE:
 		if (is_jmp32) {
-			s32 false_smax =3D opcode =3D=3D BPF_JSGT ? sval32    : sval32 - 1;
-			s32 true_smin =3D opcode =3D=3D BPF_JSGT ? sval32 + 1 : sval32;
-
-			false_reg1->s32_max_value =3D min(false_reg1->s32_max_value, false_sm=
ax);
-			true_reg1->s32_min_value =3D max(true_reg1->s32_min_value, true_smin)=
;
+			reg1->u32_max_value =3D min(reg1->u32_max_value, reg2->u32_max_value)=
;
+			reg2->u32_min_value =3D max(reg1->u32_min_value, reg2->u32_min_value)=
;
 		} else {
-			s64 false_smax =3D opcode =3D=3D BPF_JSGT ? sval    : sval - 1;
-			s64 true_smin =3D opcode =3D=3D BPF_JSGT ? sval + 1 : sval;
-
-			false_reg1->smax_value =3D min(false_reg1->smax_value, false_smax);
-			true_reg1->smin_value =3D max(true_reg1->smin_value, true_smin);
+			reg1->umax_value =3D min(reg1->umax_value, reg2->umax_value);
+			reg2->umin_value =3D max(reg1->umin_value, reg2->umin_value);
 		}
 		break;
-	}
-	case BPF_JLE:
 	case BPF_JLT:
-	{
 		if (is_jmp32) {
-			u32 false_umin =3D opcode =3D=3D BPF_JLT ? uval32  : uval32 + 1;
-			u32 true_umax =3D opcode =3D=3D BPF_JLT ? uval32 - 1 : uval32;
-
-			false_reg1->u32_min_value =3D max(false_reg1->u32_min_value,
-						       false_umin);
-			true_reg1->u32_max_value =3D min(true_reg1->u32_max_value,
-						      true_umax);
+			reg1->u32_max_value =3D min(reg1->u32_max_value, reg2->u32_max_value =
- 1);
+			reg2->u32_min_value =3D max(reg1->u32_min_value + 1, reg2->u32_min_va=
lue);
 		} else {
-			u64 false_umin =3D opcode =3D=3D BPF_JLT ? uval    : uval + 1;
-			u64 true_umax =3D opcode =3D=3D BPF_JLT ? uval - 1 : uval;
-
-			false_reg1->umin_value =3D max(false_reg1->umin_value, false_umin);
-			true_reg1->umax_value =3D min(true_reg1->umax_value, true_umax);
+			reg1->umax_value =3D min(reg1->umax_value, reg2->umax_value - 1);
+			reg2->umin_value =3D max(reg1->umin_value + 1, reg2->umin_value);
 		}
 		break;
-	}
 	case BPF_JSLE:
+		if (is_jmp32) {
+			reg1->s32_max_value =3D min(reg1->s32_max_value, reg2->s32_max_value)=
;
+			reg2->s32_min_value =3D max(reg1->s32_min_value, reg2->s32_min_value)=
;
+		} else {
+			reg1->smax_value =3D min(reg1->smax_value, reg2->smax_value);
+			reg2->smin_value =3D max(reg1->smin_value, reg2->smin_value);
+		}
+		break;
 	case BPF_JSLT:
-	{
 		if (is_jmp32) {
-			s32 false_smin =3D opcode =3D=3D BPF_JSLT ? sval32    : sval32 + 1;
-			s32 true_smax =3D opcode =3D=3D BPF_JSLT ? sval32 - 1 : sval32;
-
-			false_reg1->s32_min_value =3D max(false_reg1->s32_min_value, false_sm=
in);
-			true_reg1->s32_max_value =3D min(true_reg1->s32_max_value, true_smax)=
;
+			reg1->s32_max_value =3D min(reg1->s32_max_value, reg2->s32_max_value =
- 1);
+			reg2->s32_min_value =3D max(reg1->s32_min_value + 1, reg2->s32_min_va=
lue);
 		} else {
-			s64 false_smin =3D opcode =3D=3D BPF_JSLT ? sval    : sval + 1;
-			s64 true_smax =3D opcode =3D=3D BPF_JSLT ? sval - 1 : sval;
-
-			false_reg1->smin_value =3D max(false_reg1->smin_value, false_smin);
-			true_reg1->smax_value =3D min(true_reg1->smax_value, true_smax);
+			reg1->smax_value =3D min(reg1->smax_value, reg2->smax_value - 1);
+			reg2->smin_value =3D max(reg1->smin_value + 1, reg2->smin_value);
 		}
 		break;
-	}
+	case BPF_JGE:
+	case BPF_JGT:
+	case BPF_JSGE:
+	case BPF_JSGT:
+		/* just reuse LE/LT logic above */
+		opcode =3D flip_opcode(opcode);
+		swap(reg1, reg2);
+		goto again;
 	default:
 		return;
 	}
-
-	if (is_jmp32) {
-		false_reg1->var_off =3D tnum_or(tnum_clear_subreg(false_64off),
-					     tnum_subreg(false_32off));
-		true_reg1->var_off =3D tnum_or(tnum_clear_subreg(true_64off),
-					    tnum_subreg(true_32off));
-		reg_bounds_sync(false_reg1);
-		reg_bounds_sync(true_reg1);
-	} else {
-		false_reg1->var_off =3D false_64off;
-		true_reg1->var_off =3D true_64off;
-		reg_bounds_sync(false_reg1);
-		reg_bounds_sync(true_reg1);
-	}
-}
-
-/* Regs are known to be equal, so intersect their min/max/var_off */
-static void __reg_combine_min_max(struct bpf_reg_state *src_reg,
-				  struct bpf_reg_state *dst_reg)
-{
-	src_reg->umin_value =3D dst_reg->umin_value =3D max(src_reg->umin_value=
,
-							dst_reg->umin_value);
-	src_reg->umax_value =3D dst_reg->umax_value =3D min(src_reg->umax_value=
,
-							dst_reg->umax_value);
-	src_reg->smin_value =3D dst_reg->smin_value =3D max(src_reg->smin_value=
,
-							dst_reg->smin_value);
-	src_reg->smax_value =3D dst_reg->smax_value =3D min(src_reg->smax_value=
,
-							dst_reg->smax_value);
-	src_reg->var_off =3D dst_reg->var_off =3D tnum_intersect(src_reg->var_o=
ff,
-							     dst_reg->var_off);
-	reg_bounds_sync(src_reg);
-	reg_bounds_sync(dst_reg);
 }
=20
-static void reg_combine_min_max(struct bpf_reg_state *true_src,
-				struct bpf_reg_state *true_dst,
-				struct bpf_reg_state *false_src,
-				struct bpf_reg_state *false_dst,
-				u8 opcode)
+/* Adjusts the register min/max values in the case that the dst_reg and
+ * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF=
_K
+ * check, in which case we havea fake SCALAR_VALUE representing insn->im=
m).
+ * Technically we can do similar adjustments for pointers to the same ob=
ject,
+ * but we don't support that right now.
+ */
+static void reg_set_min_max(struct bpf_reg_state *true_reg1,
+			    struct bpf_reg_state *true_reg2,
+			    struct bpf_reg_state *false_reg1,
+			    struct bpf_reg_state *false_reg2,
+			    u8 opcode, bool is_jmp32)
 {
-	switch (opcode) {
-	case BPF_JEQ:
-		__reg_combine_min_max(true_src, true_dst);
-		break;
-	case BPF_JNE:
-		__reg_combine_min_max(false_src, false_dst);
-		break;
-	}
+	/* If either register is a pointer, we can't learn anything about its
+	 * variable offset from the compare (unless they were a pointer into
+	 * the same object, but we don't bother with that).
+	 */
+	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE)
+		return;
+
+	/* fallthrough (FALSE) branch */
+	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp3=
2);
+	reg_bounds_sync(false_reg1);
+	reg_bounds_sync(false_reg2);
+
+	/* jump (TRUE) branch */
+	regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
+	reg_bounds_sync(true_reg1);
+	reg_bounds_sync(true_reg2);
 }
=20
 static void mark_ptr_or_null_reg(struct bpf_func_state *state,
@@ -14961,22 +14929,12 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
 		reg_set_min_max(&other_branch_regs[insn->dst_reg],
 				&other_branch_regs[insn->src_reg],
 				dst_reg, src_reg, opcode, is_jmp32);
-
-		if (dst_reg->type =3D=3D SCALAR_VALUE &&
-		    src_reg->type =3D=3D SCALAR_VALUE &&
-		    !is_jmp32 && (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE)) {
-			/* Comparing for equality, we can combine knowledge */
-			reg_combine_min_max(&other_branch_regs[insn->src_reg],
-					    &other_branch_regs[insn->dst_reg],
-					    src_reg, dst_reg, opcode);
-		}
 	} else /* BPF_SRC(insn->code) =3D=3D BPF_K */ {
 		reg_set_min_max(&other_branch_regs[insn->dst_reg],
 				src_reg /* fake one */,
 				dst_reg, src_reg /* same fake one */,
 				opcode, is_jmp32);
 	}
-
 	if (BPF_SRC(insn->code) =3D=3D BPF_X &&
 	    src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
 	    !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_reg].id)=
) {
--=20
2.34.1



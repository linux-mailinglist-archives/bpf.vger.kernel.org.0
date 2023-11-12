Return-Path: <bpf+bounces-14895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052947E8DCE
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FCA280DD9
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F09717EC;
	Sun, 12 Nov 2023 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51D17C6
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:06:29 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5A30CF
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:27 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABN7Ahf025612
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:27 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua86tajk3-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:26 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:21 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4F1BB3B5D51BB; Sat, 11 Nov 2023 17:06:18 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 04/13] bpf: add register bounds sanity checks and sanitization
Date: Sat, 11 Nov 2023 17:06:00 -0800
Message-ID: <20231112010609.848406-5-andrii@kernel.org>
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
X-Proofpoint-GUID: HjhEEjUAgOIPLhgCvjEmrB1MM9ypNLRZ
X-Proofpoint-ORIG-GUID: HjhEEjUAgOIPLhgCvjEmrB1MM9ypNLRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

Add simple sanity checks that validate well-formed ranges (min <=3D max)
across u64, s64, u32, and s32 ranges. Also for cases when the value is
constant (either 64-bit or 32-bit), we validate that ranges and tnums
are in agreement.

These bounds checks are performed at the end of BPF_ALU/BPF_ALU64
operations, on conditional jumps, and for LDX instructions (where subreg
zero/sign extension is probably the most important to check). This
covers most of the interesting cases.

Also, we validate the sanity of the return register when manually
adjusting it for some special helpers.

By default, sanity violation will trigger a warning in verifier log and
resetting register bounds to "unbounded" ones. But to aid development
and debugging, BPF_F_TEST_SANITY_STRICT flag is added, which will
trigger hard failure of verification with -EFAULT on register bounds
violations. This allows selftests to catch such issues. veristat will
also gain a CLI option to enable this behavior.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h   |   1 +
 include/uapi/linux/bpf.h       |   3 +
 kernel/bpf/syscall.c           |   3 +-
 kernel/bpf/verifier.c          | 117 ++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h |   3 +
 5 files changed, 101 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 24213a99cc79..402b6bc44a1b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -602,6 +602,7 @@ struct bpf_verifier_env {
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	bool test_state_freq;		/* test verifier with different pruning frequenc=
y */
+	bool test_sanity_strict;	/* fail verification on sanity violations */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	struct bpf_verifier_state_list **explored_states; /* search pruning opt=
imization */
 	struct bpf_verifier_state_list *free_list;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7cf8bcf9f6a2..8a5855fcee69 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1200,6 +1200,9 @@ enum bpf_perf_event_type {
  */
 #define BPF_F_XDP_DEV_BOUND_ONLY	(1U << 6)
=20
+/* The verifier internal test flag. Behavior is undefined */
+#define BPF_F_TEST_SANITY_STRICT	(1U << 7)
+
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ed286b8a0f0..f266e03ba342 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2573,7 +2573,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
 				 BPF_F_SLEEPABLE |
 				 BPF_F_TEST_RND_HI32 |
 				 BPF_F_XDP_HAS_FRAGS |
-				 BPF_F_XDP_DEV_BOUND_ONLY))
+				 BPF_F_XDP_DEV_BOUND_ONLY |
+				 BPF_F_TEST_SANITY_STRICT))
 		return -EINVAL;
=20
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 65570eedfe88..e7edacf86e0f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2615,6 +2615,56 @@ static void reg_bounds_sync(struct bpf_reg_state *=
reg)
 	__update_reg_bounds(reg);
 }
=20
+static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *reg, const char *ctx)
+{
+	const char *msg;
+
+	if (reg->umin_value > reg->umax_value ||
+	    reg->smin_value > reg->smax_value ||
+	    reg->u32_min_value > reg->u32_max_value ||
+	    reg->s32_min_value > reg->s32_max_value) {
+		    msg =3D "range bounds violation";
+		    goto out;
+	}
+
+	if (tnum_is_const(reg->var_off)) {
+		u64 uval =3D reg->var_off.value;
+		s64 sval =3D (s64)uval;
+
+		if (reg->umin_value !=3D uval || reg->umax_value !=3D uval ||
+		    reg->smin_value !=3D sval || reg->smax_value !=3D sval) {
+			msg =3D "const tnum out of sync with range bounds";
+			goto out;
+		}
+	}
+
+	if (tnum_subreg_is_const(reg->var_off)) {
+		u32 uval32 =3D tnum_subreg(reg->var_off).value;
+		s32 sval32 =3D (s32)uval32;
+
+		if (reg->u32_min_value !=3D uval32 || reg->u32_max_value !=3D uval32 |=
|
+		    reg->s32_min_value !=3D sval32 || reg->s32_max_value !=3D sval32) =
{
+			msg =3D "const subreg tnum out of sync with range bounds";
+			goto out;
+		}
+	}
+
+	return 0;
+out:
+	verbose(env, "REG SANITY VIOLATION (%s): %s u64=3D[%#llx, %#llx] "
+		"s64=3D[%#llx, %#llx] u32=3D[%#x, %#x] s32=3D[%#x, %#x] var_off=3D(%#l=
lx, %#llx)\n",
+		ctx, msg, reg->umin_value, reg->umax_value,
+		reg->smin_value, reg->smax_value,
+		reg->u32_min_value, reg->u32_max_value,
+		reg->s32_min_value, reg->s32_max_value,
+		reg->var_off.value, reg->var_off.mask);
+	if (env->test_sanity_strict)
+		return -EFAULT;
+	__mark_reg_unbounded(reg);
+	return 0;
+}
+
 static bool __reg32_bound_s64(s32 a)
 {
 	return a >=3D 0 && a <=3D S32_MAX;
@@ -9982,14 +10032,15 @@ static int prepare_func_exit(struct bpf_verifier=
_env *env, int *insn_idx)
 	return 0;
 }
=20
-static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_t=
ype,
-				   int func_id,
-				   struct bpf_call_arg_meta *meta)
+static int do_refine_retval_range(struct bpf_verifier_env *env,
+				  struct bpf_reg_state *regs, int ret_type,
+				  int func_id,
+				  struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *ret_reg =3D &regs[BPF_REG_0];
=20
 	if (ret_type !=3D RET_INTEGER)
-		return;
+		return 0;
=20
 	switch (func_id) {
 	case BPF_FUNC_get_stack:
@@ -10015,6 +10066,8 @@ static void do_refine_retval_range(struct bpf_reg=
_state *regs, int ret_type,
 		reg_bounds_sync(ret_reg);
 		break;
 	}
+
+	return reg_bounds_sanity_check(env, ret_reg, "retval");
 }
=20
 static int
@@ -10666,7 +10719,9 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].ref_obj_id =3D id;
 	}
=20
-	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
+	err =3D do_refine_retval_range(env, regs, fn->ret_type, func_id, &meta)=
;
+	if (err)
+		return err;
=20
 	err =3D check_map_func_compatibility(env, meta.map_ptr, func_id);
 	if (err)
@@ -14166,13 +14221,12 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
=20
 		/* check dest operand */
 		err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+		err =3D err ?: adjust_reg_min_max_vals(env, insn);
 		if (err)
 			return err;
-
-		return adjust_reg_min_max_vals(env, insn);
 	}
=20
-	return 0;
+	return reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
 }
=20
 static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
@@ -14653,18 +14707,21 @@ static void regs_refine_cond_op(struct bpf_reg_=
state *reg1, struct bpf_reg_state
  * Technically we can do similar adjustments for pointers to the same ob=
ject,
  * but we don't support that right now.
  */
-static void reg_set_min_max(struct bpf_reg_state *true_reg1,
-			    struct bpf_reg_state *true_reg2,
-			    struct bpf_reg_state *false_reg1,
-			    struct bpf_reg_state *false_reg2,
-			    u8 opcode, bool is_jmp32)
+static int reg_set_min_max(struct bpf_verifier_env *env,
+			   struct bpf_reg_state *true_reg1,
+			   struct bpf_reg_state *true_reg2,
+			   struct bpf_reg_state *false_reg1,
+			   struct bpf_reg_state *false_reg2,
+			   u8 opcode, bool is_jmp32)
 {
+	int err;
+
 	/* If either register is a pointer, we can't learn anything about its
 	 * variable offset from the compare (unless they were a pointer into
 	 * the same object, but we don't bother with that).
 	 */
 	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE)
-		return;
+		return 0;
=20
 	/* fallthrough (FALSE) branch */
 	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp3=
2);
@@ -14675,6 +14732,12 @@ static void reg_set_min_max(struct bpf_reg_state=
 *true_reg1,
 	regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
 	reg_bounds_sync(true_reg1);
 	reg_bounds_sync(true_reg2);
+
+	err =3D reg_bounds_sanity_check(env, true_reg1, "true_reg1");
+	err =3D err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2");
+	err =3D err ?: reg_bounds_sanity_check(env, false_reg1, "false_reg1");
+	err =3D err ?: reg_bounds_sanity_check(env, false_reg2, "false_reg2");
+	return err;
 }
=20
 static void mark_ptr_or_null_reg(struct bpf_func_state *state,
@@ -14968,15 +15031,20 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
 	other_branch_regs =3D other_branch->frame[other_branch->curframe]->regs=
;
=20
 	if (BPF_SRC(insn->code) =3D=3D BPF_X) {
-		reg_set_min_max(&other_branch_regs[insn->dst_reg],
-				&other_branch_regs[insn->src_reg],
-				dst_reg, src_reg, opcode, is_jmp32);
+		err =3D reg_set_min_max(env,
+				      &other_branch_regs[insn->dst_reg],
+				      &other_branch_regs[insn->src_reg],
+				      dst_reg, src_reg, opcode, is_jmp32);
 	} else /* BPF_SRC(insn->code) =3D=3D BPF_K */ {
-		reg_set_min_max(&other_branch_regs[insn->dst_reg],
-				src_reg /* fake one */,
-				dst_reg, src_reg /* same fake one */,
-				opcode, is_jmp32);
+		err =3D reg_set_min_max(env,
+				      &other_branch_regs[insn->dst_reg],
+				      src_reg /* fake one */,
+				      dst_reg, src_reg /* same fake one */,
+				      opcode, is_jmp32);
 	}
+	if (err)
+		return err;
+
 	if (BPF_SRC(insn->code) =3D=3D BPF_X &&
 	    src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
 	    !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_reg].id)=
) {
@@ -17479,10 +17547,8 @@ static int do_check(struct bpf_verifier_env *env=
)
 					       insn->off, BPF_SIZE(insn->code),
 					       BPF_READ, insn->dst_reg, false,
 					       BPF_MODE(insn->code) =3D=3D BPF_MEMSX);
-			if (err)
-				return err;
-
-			err =3D save_aux_ptr_type(env, src_reg_type, true);
+			err =3D err ?: save_aux_ptr_type(env, src_reg_type, true);
+			err =3D err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], "ld=
x");
 			if (err)
 				return err;
 		} else if (class =3D=3D BPF_STX) {
@@ -20769,6 +20835,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
=20
 	if (is_priv)
 		env->test_state_freq =3D attr->prog_flags & BPF_F_TEST_STATE_FREQ;
+	env->test_sanity_strict =3D attr->prog_flags & BPF_F_TEST_SANITY_STRICT=
;
=20
 	env->explored_states =3D kvcalloc(state_htab_size(env),
 				       sizeof(struct bpf_verifier_state_list *),
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 7cf8bcf9f6a2..8a5855fcee69 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1200,6 +1200,9 @@ enum bpf_perf_event_type {
  */
 #define BPF_F_XDP_DEV_BOUND_ONLY	(1U << 6)
=20
+/* The verifier internal test flag. Behavior is undefined */
+#define BPF_F_TEST_SANITY_STRICT	(1U << 7)
+
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
--=20
2.34.1



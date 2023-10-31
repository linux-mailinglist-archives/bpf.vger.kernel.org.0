Return-Path: <bpf+bounces-13663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4237DC59C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29DABB20F42
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F59D27D;
	Tue, 31 Oct 2023 05:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B796D22
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:03:48 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B16E4
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:45 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UIuZEV028789
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:45 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u2j6vtumd-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:44 -0700
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 22:03:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 73BE33AA9B6C5; Mon, 30 Oct 2023 22:03:30 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH bpf-next 2/7] bpf: support non-r10 register spill/fill to/from stack in precision tracking
Date: Mon, 30 Oct 2023 22:03:19 -0700
Message-ID: <20231031050324.1107444-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031050324.1107444-1-andrii@kernel.org>
References: <20231031050324.1107444-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: szKDEdQo2YnbJ58XMruzJOMRWRrQAcFD
X-Proofpoint-GUID: szKDEdQo2YnbJ58XMruzJOMRWRrQAcFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02

Use newly optimized instruction history to record instructions that
performed register spill/fill to/from stack, regardless if this was done
through read-only r10 register, or any other register after copying r10
into it *and* potentially adjusting offset.

To make this work reliably, we push extra per-instruction flags into
instruction history, encoding stack slot index (spi) and stack frame
number in extra 10 bit flags we take away from prev_idx in instruction
history. We don't touch idx field for maximum performance, as it's
checked most frequently during backtracking.

This change removes basically the last remaining practical limitation of
precision backtracking logic in BPF verifier. It fixes known
deficiencies, but also opens up new opportunities to reduce number of
verified states, explored in the next patch.

There are only three differences in selftests' BPF object files
according to veristat, all in the positive direction (less states).

File                                    Program        Insns (A)  Insns (=
B)  Insns  (DIFF)  States (A)  States (B)  States (DIFF)
--------------------------------------  -------------  ---------  -------=
--  -------------  ----------  ----------  -------------
test_cls_redirect_dynptr.bpf.linked3.o  cls_redirect        2987       28=
64  -123 (-4.12%)         240         231    -9 (-3.75%)
xdp_synproxy_kern.bpf.linked3.o         syncookie_tc       82848      826=
61  -187 (-0.23%)        5107        5073   -34 (-0.67%)
xdp_synproxy_kern.bpf.linked3.o         syncookie_xdp      85116      849=
64  -152 (-0.18%)        5162        5130   -32 (-0.62%)

Reported-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h                  |  26 +++-
 kernel/bpf/verifier.c                         | 145 +++++++++---------
 .../bpf/progs/verifier_subprog_precision.c    |  83 +++++++++-
 .../testing/selftests/bpf/verifier/precise.c  |  38 +++--
 4 files changed, 197 insertions(+), 95 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b57696145111..7940c0861198 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -309,12 +309,34 @@ struct bpf_func_state {
 	struct bpf_stack_state *stack;
 };
=20
+#define MAX_CALL_FRAMES 8
+
+/* instruction history flags, used in bpf_insn_hist_entry.flags field */
+enum {
+	/* instruction references stack slot through PTR_TO_STACK register;
+	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES =
is 8)
+	 * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512=
,
+	 * 8 bytes per slot, so slot index (spi) is [0, 63])
+	 */
+	INSN_F_FRAMENO_MASK =3D 0x7, /* 3 bits */
+
+	INSN_F_SPI_MASK =3D 0x3f, /* 6 bits */
+	INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
+
+	INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */
+};
+
+static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
+static_assert(INSN_F_SPI_MASK + 1 >=3D MAX_BPF_STACK / 8);
+
 struct bpf_insn_hist_entry {
-	u32 prev_idx;
 	u32 idx;
+	/* insn idx can't be bigger than 1 million */
+	u32 prev_idx : 22;
+	/* special flags, e.g., whether insn is doing register stack spill/load=
 */
+	u32 flags : 10;
 };
=20
-#define MAX_CALL_FRAMES 8
 /* Maximum number of register states that can exist at once */
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * =
MAX_CALL_FRAMES)
 struct bpf_verifier_state {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2905ce2e8b34..fbb779583d52 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3479,14 +3479,20 @@ static bool is_jmp_point(struct bpf_verifier_env =
*env, int insn_idx)
 }
=20
 /* for any branch, call, exit record the history of jmps in the given st=
ate */
-static int push_jmp_history(struct bpf_verifier_env *env,
-			    struct bpf_verifier_state *cur)
+static int push_insn_history(struct bpf_verifier_env *env, struct bpf_ve=
rifier_state *cur,
+			     int insn_flags)
 {
 	struct bpf_insn_hist_entry *p;
 	size_t alloc_size;
=20
-	if (!is_jmp_point(env, env->insn_idx))
+	/* combine instruction flags if we already recorded this instruction */
+	if (cur->insn_hist_end > cur->insn_hist_start &&
+	    (p =3D &env->insn_hist[cur->insn_hist_end - 1]) &&
+	    p->idx =3D=3D env->insn_idx &&
+	    p->prev_idx =3D=3D env->prev_insn_idx) {
+		p->flags |=3D insn_flags;
 		return 0;
+	}
=20
 	if (cur->insn_hist_end + 1 > env->insn_hist_cap) {
 		alloc_size =3D size_mul(cur->insn_hist_end + 1, sizeof(*p));
@@ -3501,14 +3507,23 @@ static int push_jmp_history(struct bpf_verifier_e=
nv *env,
 	p =3D &env->insn_hist[cur->insn_hist_end];
 	p->idx =3D env->insn_idx;
 	p->prev_idx =3D env->prev_insn_idx;
+	p->flags =3D insn_flags;
 	cur->insn_hist_end++;
 	return 0;
 }
=20
+static struct bpf_insn_hist_entry *get_hist_insn_entry(struct bpf_verifi=
er_env *env,
+						       u32 hist_start, u32 hist_end, int insn_idx)
+{
+	if (hist_end > hist_start && env->insn_hist[hist_end - 1].idx =3D=3D in=
sn_idx)
+		return &env->insn_hist[hist_end - 1];
+	return NULL;
+}
+
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
  */
-static int get_prev_insn_idx(const struct bpf_verifier_env *env, int ins=
n_idx,
+static int get_prev_insn_idx(struct bpf_verifier_env *env, int insn_idx,
 			     u32 hist_start, u32 *hist_endp)
 {
 	u32 hist_end =3D *hist_endp;
@@ -3649,9 +3664,14 @@ static inline bool bt_is_reg_set(struct backtrack_=
state *bt, u32 reg)
 	return bt->reg_masks[bt->frame] & (1 << reg);
 }
=20
+static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 =
frame, u32 slot)
+{
+	return bt->stack_masks[frame] & (1ull << slot);
+}
+
 static inline bool bt_is_slot_set(struct backtrack_state *bt, u32 slot)
 {
-	return bt->stack_masks[bt->frame] & (1ull << slot);
+	return bt_is_frame_slot_set(bt, bt->frame, slot);
 }
=20
 /* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
@@ -3703,7 +3723,7 @@ static void fmt_stack_mask(char *buf, ssize_t buf_s=
z, u64 stack_mask)
  *   - *was* processed previously during backtracking.
  */
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int sub=
seq_idx,
-			  struct backtrack_state *bt)
+			  struct bpf_insn_hist_entry *hist, struct backtrack_state *bt)
 {
 	const struct bpf_insn_cbs cbs =3D {
 		.cb_call	=3D disasm_kfunc_name,
@@ -3716,7 +3736,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
 	u8 mode =3D BPF_MODE(insn->code);
 	u32 dreg =3D insn->dst_reg;
 	u32 sreg =3D insn->src_reg;
-	u32 spi, i;
+	u32 spi, i, fr;
=20
 	if (insn->code =3D=3D 0)
 		return 0;
@@ -3772,20 +3792,15 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
 		 * by 'precise' mark in corresponding register of this state.
 		 * No further tracking necessary.
 		 */
-		if (insn->src_reg !=3D BPF_REG_FP)
+		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
 			return 0;
-
 		/* dreg =3D *(u64 *)[fp - off] was a fill from the stack.
 		 * that [fp - off] slot contains scalar that needs to be
 		 * tracked with precision
 		 */
-		spi =3D (-insn->off - 1) / BPF_REG_SIZE;
-		if (spi >=3D 64) {
-			verbose(env, "BUG spi %d\n", spi);
-			WARN_ONCE(1, "verifier backtracking bug");
-			return -EFAULT;
-		}
-		bt_set_slot(bt, spi);
+		spi =3D (hist->flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK;
+		fr =3D hist->flags & INSN_F_FRAMENO_MASK;
+		bt_set_frame_slot(bt, fr, spi);
 	} else if (class =3D=3D BPF_STX || class =3D=3D BPF_ST) {
 		if (bt_is_reg_set(bt, dreg))
 			/* stx & st shouldn't be using _scalar_ dst_reg
@@ -3794,17 +3809,13 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
 			 */
 			return -ENOTSUPP;
 		/* scalars can only be spilled into stack */
-		if (insn->dst_reg !=3D BPF_REG_FP)
+		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
 			return 0;
-		spi =3D (-insn->off - 1) / BPF_REG_SIZE;
-		if (spi >=3D 64) {
-			verbose(env, "BUG spi %d\n", spi);
-			WARN_ONCE(1, "verifier backtracking bug");
-			return -EFAULT;
-		}
-		if (!bt_is_slot_set(bt, spi))
+		spi =3D (hist->flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK;
+		fr =3D hist->flags & INSN_F_FRAMENO_MASK;
+		if (!bt_is_frame_slot_set(bt, fr, spi))
 			return 0;
-		bt_clear_slot(bt, spi);
+		bt_clear_frame_slot(bt, fr, spi);
 		if (class =3D=3D BPF_STX)
 			bt_set_reg(bt, sreg);
 	} else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
@@ -3848,10 +3859,14 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
 					WARN_ONCE(1, "verifier backtracking bug");
 					return -EFAULT;
 				}
-				/* we don't track register spills perfectly,
-				 * so fallback to force-precise instead of failing */
-				if (bt_stack_mask(bt) !=3D 0)
-					return -ENOTSUPP;
+				/* we are now tracking register spills correctly,
+				 * so any instance of leftover slots is a bug
+				 */
+				if (bt_stack_mask(bt) !=3D 0) {
+					verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
+					WARN_ONCE(1, "verifier backtracking bug (subprog leftover stack slo=
ts)");
+					return -EFAULT;
+				}
 				/* propagate r1-r5 to the caller */
 				for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
 					if (bt_is_reg_set(bt, i)) {
@@ -3879,8 +3894,11 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
 				WARN_ONCE(1, "verifier backtracking bug");
 				return -EFAULT;
 			}
-			if (bt_stack_mask(bt) !=3D 0)
-				return -ENOTSUPP;
+			if (bt_stack_mask(bt) !=3D 0) {
+				verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
+				WARN_ONCE(1, "verifier backtracking bug (callback leftover stack slo=
ts)");
+				return -EFAULT;
+			}
 			/* clear r1-r5 in callback subprog's mask */
 			for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
 				bt_clear_reg(bt, i);
@@ -4308,7 +4326,8 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
=20
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
-		u32 hist_end =3D st->insn_hist_end;
+		u32 hist_start =3D st->insn_hist_start, hist_end =3D st->insn_hist_end=
;
+		struct bpf_insn_hist_entry *hist;
=20
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_=
idx %d \n",
@@ -4372,7 +4391,8 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 				err =3D 0;
 				skip_first =3D false;
 			} else {
-				err =3D backtrack_insn(env, i, subseq_idx, bt);
+				hist =3D get_hist_insn_entry(env, hist_start, hist_end, i);
+				err =3D backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err =3D=3D -ENOTSUPP) {
 				mark_all_scalars_precise(env, env->cur_state);
@@ -4390,7 +4410,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 			if (i =3D=3D first_idx)
 				break;
 			subseq_idx =3D i;
-			i =3D get_prev_insn_idx(env, i, st->insn_hist_start, &hist_end);
+			i =3D get_prev_insn_idx(env, i, hist_start, &hist_end);
 			if (i >=3D env->prog->len) {
 				/* This can happen if backtracking reached insn 0
 				 * and there are still reg_mask or stack_mask
@@ -4425,22 +4445,10 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int regno)
 			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
 			for_each_set_bit(i, mask, 64) {
 				if (i >=3D func->allocated_stack / BPF_REG_SIZE) {
-					/* the sequence of instructions:
-					 * 2: (bf) r3 =3D r10
-					 * 3: (7b) *(u64 *)(r3 -8) =3D r0
-					 * 4: (79) r4 =3D *(u64 *)(r10 -8)
-					 * doesn't contain jmps. It's backtracked
-					 * as a single block.
-					 * During backtracking insn 3 is not recognized as
-					 * stack access, so at the end of backtracking
-					 * stack slot fp-8 is still marked in stack_mask.
-					 * However the parent state may not have accessed
-					 * fp-8 and it's "unallocated" stack space.
-					 * In such case fallback to conservative.
-					 */
-					mark_all_scalars_precise(env, env->cur_state);
-					bt_reset(bt);
-					return 0;
+					verbose(env, "BUG backtracking (stack slot %d, total slots %d)\n",
+						i, func->allocated_stack / BPF_REG_SIZE);
+					WARN_ONCE(1, "verifier backtracking bug (stack slot out of bounds)"=
);
+					return -EFAULT;
 				}
=20
 				if (!is_spilled_scalar_reg(&func->stack[i])) {
@@ -4605,7 +4613,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE, err;
 	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg =3D NULL;
-	u32 dst_reg =3D insn->dst_reg;
+	int insn_flags =3D INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | st=
ate->frameno;
=20
 	err =3D grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
 	if (err)
@@ -4646,17 +4654,6 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
-		if (dst_reg !=3D BPF_REG_FP) {
-			/* The backtracking logic can only recognize explicit
-			 * stack slot address like [fp - 8]. Other spill of
-			 * scalar via different register has to be conservative.
-			 * Backtrack from here and mark all registers as precise
-			 * that contributed into 'reg' being a constant.
-			 */
-			err =3D mark_chain_precision(env, value_regno);
-			if (err)
-				return err;
-		}
 		save_register_state(state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
@@ -4668,6 +4665,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 		__mark_reg_known(&fake_reg, (u32)insn->imm);
 		fake_reg.type =3D SCALAR_VALUE;
 		save_register_state(state, spi, &fake_reg, size);
+		insn_flags =3D 0; /* not a register spill */
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size !=3D BPF_REG_SIZE) {
@@ -4713,9 +4711,12 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
=20
 		/* Mark slots affected by this stack write. */
 		for (i =3D 0; i < size; i++)
-			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] =3D
-				type;
+			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] =3D type;
+		insn_flags =3D 0; /* not a register spill */
 	}
+
+	if (insn_flags)
+		return push_insn_history(env, env->cur_state, insn_flags);
 	return 0;
 }
=20
@@ -4908,6 +4909,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE;
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
+	int insn_flags =3D INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | re=
g_state->frameno;
=20
 	stype =3D reg_state->stack[spi].slot_type;
 	reg =3D &reg_state->stack[spi].spilled_ptr;
@@ -4953,12 +4955,10 @@ static int check_stack_read_fixed_off(struct bpf_=
verifier_env *env,
 					return -EACCES;
 				}
 				mark_reg_unknown(env, state->regs, dst_regno);
+				insn_flags =3D 0; /* not restoring original register state */
 			}
 			state->regs[dst_regno].live |=3D REG_LIVE_WRITTEN;
-			return 0;
-		}
-
-		if (dst_regno >=3D 0) {
+		} else if (dst_regno >=3D 0) {
 			/* restore register state from stack */
 			copy_register_state(&state->regs[dst_regno], reg);
 			/* mark reg as written since spilled pointer state likely
@@ -4994,7 +4994,10 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
 		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 		if (dst_regno >=3D 0)
 			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
+		insn_flags =3D 0; /* we are not restoring spilled register */
 	}
+	if (insn_flags)
+		return push_insn_history(env, env->cur_state, insn_flags);
 	return 0;
 }
=20
@@ -7125,7 +7128,6 @@ static int check_atomic(struct bpf_verifier_env *en=
v, int insn_idx, struct bpf_i
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
-
 	return 0;
 }
=20
@@ -17001,7 +17003,8 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
 			 * the precision needs to be propagated back in
 			 * the current state.
 			 */
-			err =3D err ? : push_jmp_history(env, cur);
+			if (is_jmp_point(env, env->insn_idx))
+				err =3D err ? : push_insn_history(env, cur, 0);
 			err =3D err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -17265,7 +17268,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
=20
 		if (is_jmp_point(env, env->insn_idx)) {
-			err =3D push_jmp_history(env, state);
+			err =3D push_insn_history(env, state, 0);
 			if (err)
 				return err;
 		}
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision=
.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index db6b3143338b..88c4207c6b4c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -487,7 +487,24 @@ __success __log_level(2)
  * so we won't be able to mark stack slot fp-8 as precise, and so will
  * fallback to forcing all as precise
  */
-__msg("mark_precise: frame0: falling back to forcing all scalars precise=
")
+__msg("10: (0f) r1 +=3D r7")
+__msg("mark_precise: frame0: last_idx 10 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr7 stack=3D before 9: (bf) r1 =3D r8=
")
+__msg("mark_precise: frame0: regs=3Dr7 stack=3D before 8: (27) r7 *=3D 4=
")
+__msg("mark_precise: frame0: regs=3Dr7 stack=3D before 7: (79) r7 =3D *(=
u64 *)(r10 -8)")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D-8:  R0_w=3D2 =
R6_w=3D1 R8_rw=3Dmap_value(off=3D0,ks=3D4,vs=3D16,imm=3D0) R10=3Dfp0 fp-8=
_rw=3DP1")
+__msg("mark_precise: frame0: last_idx 18 first_idx 0 subseq_idx 7")
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 18: (95) exit")
+__msg("mark_precise: frame1: regs=3D stack=3D before 17: (0f) r0 +=3D r2=
")
+__msg("mark_precise: frame1: regs=3D stack=3D before 16: (79) r2 =3D *(u=
64 *)(r1 +0)")
+__msg("mark_precise: frame1: regs=3D stack=3D before 15: (79) r0 =3D *(u=
64 *)(r10 -16)")
+__msg("mark_precise: frame1: regs=3D stack=3D before 14: (7b) *(u64 *)(r=
10 -16) =3D r2")
+__msg("mark_precise: frame1: regs=3D stack=3D before 13: (7b) *(u64 *)(r=
1 +0) =3D r2")
+__msg("mark_precise: frame1: regs=3Dr2 stack=3D before 6: (85) call pc+6=
")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 5: (bf) r2 =3D r6=
")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 4: (07) r1 +=3D -=
8")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 3: (bf) r1 =3D r1=
0")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 2: (b7) r6 =3D 1"=
)
 __naked int subprog_spill_into_parent_stack_slot_precise(void)
 {
 	asm volatile (
@@ -522,14 +539,68 @@ __naked int subprog_spill_into_parent_stack_slot_pr=
ecise(void)
 	);
 }
=20
-__naked __noinline __used
-static __u64 subprog_with_checkpoint(void)
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("17: (0f) r1 +=3D r0")
+__msg("mark_precise: frame0: last_idx 17 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 16: (bf) r1 =3D r=
7")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 15: (27) r0 *=3D =
4")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 14: (79) r0 =3D *=
(u64 *)(r10 -16)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 13: (7b) *(u64 *=
)(r7 -8) =3D r0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 12: (79) r0 =3D *=
(u64 *)(r8 +16)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 11: (7b) *(u64 *=
)(r8 +16) =3D r0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 10: (79) r0 =3D *=
(u64 *)(r7 -8)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 9: (7b) *(u64 *)=
(r10 -16) =3D r0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 8: (07) r8 +=3D -=
32")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 7: (bf) r8 =3D r1=
0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 6: (07) r7 +=3D -=
8")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 5: (bf) r7 =3D r1=
0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 21: (95) exit")
+__msg("mark_precise: frame1: regs=3Dr0 stack=3D before 20: (bf) r0 =3D r=
1")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 4: (85) call pc+1=
5")
+__msg("mark_precise: frame0: regs=3Dr1 stack=3D before 3: (bf) r1 =3D r6=
")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 2: (b7) r6 =3D 1"=
)
+__naked int stack_slot_aliases_precision(void)
 {
 	asm volatile (
-		"r0 =3D 0;"
-		/* guaranteed checkpoint if BPF_F_TEST_STATE_FREQ is used */
-		"goto +0;"
+		"r6 =3D 1;"
+		/* pass r6 through r1 into subprog to get it back as r0;
+		 * this whole chain will have to be marked as precise later
+		 */
+		"r1 =3D r6;"
+		"call identity_subprog;"
+		/* let's setup two registers that are aliased to r10 */
+		"r7 =3D r10;"
+		"r7 +=3D -8;"			/* r7 =3D r10 - 8 */
+		"r8 =3D r10;"
+		"r8 +=3D -32;"			/* r8 =3D r10 - 32 */
+		/* now spill subprog's return value (a r6 -> r1 -> r0 chain)
+		 * a few times through different stack pointer regs, making
+		 * sure to use r10, r7, and r8 both in LDX and STX insns, and
+		 * *importantly* also using a combination of const var_off and
+		 * insn->off to validate that we record final stack slot
+		 * correctly, instead of relying on just insn->off derivation,
+		 * which is only valid for r10-based stack offset
+		 */
+		"*(u64 *)(r10 - 16) =3D r0;"
+		"r0 =3D *(u64 *)(r7 - 8);"	/* r7 - 8 =3D=3D r10 - 16 */
+		"*(u64 *)(r8 + 16) =3D r0;"	/* r8 + 16 =3D r10 - 16 */
+		"r0 =3D *(u64 *)(r8 + 16);"
+		"*(u64 *)(r7 - 8) =3D r0;"
+		"r0 =3D *(u64 *)(r10 - 16);"
+		/* get ready to use r0 as an index into array to force precision */
+		"r0 *=3D 4;"
+		"r1 =3D %[vals];"
+		/* here r0->r1->r6 chain is forced to be precise and has to be
+		 * propagated back to the beginning, including through the
+		 * subprog call and all the stack spills and loads
+		 */
+		"r1 +=3D r0;"
+		"r0 =3D *(u32 *)(r1 + 0);"
 		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common, "r6"
 	);
 }
=20
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testi=
ng/selftests/bpf/verifier/precise.c
index 0d84dd1f38b6..8a2ff81d8350 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -140,10 +140,11 @@
 	.result =3D REJECT,
 },
 {
-	"precise: ST insn causing spi > allocated_stack",
+	"precise: ST zero to stack insn is supported",
 	.insns =3D {
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
+	/* not a register spill, so we stop precision propagation for R4 here *=
/
 	BPF_ST_MEM(BPF_DW, BPF_REG_3, -8, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_MOV64_IMM(BPF_REG_0, -1),
@@ -157,11 +158,11 @@
 	mark_precise: frame0: last_idx 4 first_idx 2\
 	mark_precise: frame0: regs=3Dr4 stack=3D before 4\
 	mark_precise: frame0: regs=3Dr4 stack=3D before 3\
-	mark_precise: frame0: regs=3D stack=3D-8 before 2\
-	mark_precise: frame0: falling back to forcing all scalars precise\
-	force_precise: frame0: forcing r0 to be precise\
 	mark_precise: frame0: last_idx 5 first_idx 5\
-	mark_precise: frame0: parent state regs=3D stack=3D:",
+	mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
+	mark_precise: frame0: last_idx 4 first_idx 2\
+	mark_precise: frame0: regs=3Dr0 stack=3D before 4\
+	5: R0=3D-1 R4=3D0",
 	.result =3D VERBOSE_ACCEPT,
 	.retval =3D -1,
 },
@@ -169,6 +170,8 @@
 	"precise: STX insn causing spi > allocated_stack",
 	.insns =3D {
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	/* make later reg spill more interesting by having somewhat known scala=
r */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xff),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, -8),
@@ -179,18 +182,21 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_XDP,
 	.flags =3D BPF_F_TEST_STATE_FREQ,
-	.errstr =3D "mark_precise: frame0: last_idx 6 first_idx 6\
+	.errstr =3D "mark_precise: frame0: last_idx 7 first_idx 7\
 	mark_precise: frame0: parent state regs=3Dr4 stack=3D:\
-	mark_precise: frame0: last_idx 5 first_idx 3\
-	mark_precise: frame0: regs=3Dr4 stack=3D before 5\
-	mark_precise: frame0: regs=3Dr4 stack=3D before 4\
-	mark_precise: frame0: regs=3D stack=3D-8 before 3\
-	mark_precise: frame0: falling back to forcing all scalars precise\
-	force_precise: frame0: forcing r0 to be precise\
-	force_precise: frame0: forcing r0 to be precise\
-	force_precise: frame0: forcing r0 to be precise\
-	force_precise: frame0: forcing r0 to be precise\
-	mark_precise: frame0: last_idx 6 first_idx 6\
+	mark_precise: frame0: last_idx 6 first_idx 4\
+	mark_precise: frame0: regs=3Dr4 stack=3D before 6: (b7) r0 =3D -1\
+	mark_precise: frame0: regs=3Dr4 stack=3D before 5: (79) r4 =3D *(u64 *)=
(r10 -8)\
+	mark_precise: frame0: regs=3D stack=3D-8 before 4: (7b) *(u64 *)(r3 -8)=
 =3D r0\
+	mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
+	mark_precise: frame0: last_idx 3 first_idx 3\
+	mark_precise: frame0: regs=3Dr0 stack=3D before 3: (55) if r3 !=3D 0x7b=
 goto pc+0\
+	mark_precise: frame0: regs=3Dr0 stack=3D before 2: (bf) r3 =3D r10\
+	mark_precise: frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255\
+	mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
+	mark_precise: frame0: last_idx 0 first_idx 0\
+	mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_pr=
andom_u32#7\
+	mark_precise: frame0: last_idx 7 first_idx 7\
 	mark_precise: frame0: parent state regs=3D stack=3D:",
 	.result =3D VERBOSE_ACCEPT,
 	.retval =3D -1,
--=20
2.34.1



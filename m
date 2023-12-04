Return-Path: <bpf+bounces-16624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD98803E5C
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F13B20A97
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF32D3175E;
	Mon,  4 Dec 2023 19:26:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF1FA
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 11:26:35 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3B4JQSjs024219
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 11:26:34 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3us9fbw31f-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 11:26:34 -0800
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 11:26:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 479673C94B7C1; Mon,  4 Dec 2023 11:26:04 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH v3 bpf-next 01/10] bpf: support non-r10 register spill/fill to/from stack in precision tracking
Date: Mon, 4 Dec 2023 11:25:52 -0800
Message-ID: <20231204192601.2672497-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204192601.2672497-1-andrii@kernel.org>
References: <20231204192601.2672497-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ReZELA19x0OfEIH6bW6jnqbRUPa_Ts68
X-Proofpoint-GUID: ReZELA19x0OfEIH6bW6jnqbRUPa_Ts68
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02

Use instruction (jump) history to record instructions that performed
register spill/fill to/from stack, regardless if this was done through
read-only r10 register, or any other register after copying r10 into it
*and* potentially adjusting offset.

To make this work reliably, we push extra per-instruction flags into
instruction history, encoding stack slot index (spi) and stack frame
number in extra 10 bit flags we take away from prev_idx in instruction
history. We don't touch idx field for maximum performance, as it's
checked most frequently during backtracking.

This change removes basically the last remaining practical limitation of
precision backtracking logic in BPF verifier. It fixes known
deficiencies, but also opens up new opportunities to reduce number of
verified states, explored in the subsequent patches.

There are only three differences in selftests' BPF object files
according to veristat, all in the positive direction (less states).

File                                    Program        Insns (A)  Insns (B)=
  Insns  (DIFF)  States (A)  States (B)  States (DIFF)
--------------------------------------  -------------  ---------  ---------=
  -------------  ----------  ----------  -------------
test_cls_redirect_dynptr.bpf.linked3.o  cls_redirect        2987       2864=
  -123 (-4.12%)         240         231    -9 (-3.75%)
xdp_synproxy_kern.bpf.linked3.o         syncookie_tc       82848      82661=
  -187 (-0.23%)        5107        5073   -34 (-0.67%)
xdp_synproxy_kern.bpf.linked3.o         syncookie_xdp      85116      84964=
  -152 (-0.18%)        5162        5130   -32 (-0.62%)

Note, I avoided renaming jmp_history to more generic insn_hist to
minimize number of lines changed and potential merge conflicts between
bpf and bpf-next trees.

Notice also cur_hist_entry pointer reset to NULL at the beginning of
instruction verification loop. This pointer avoids the problem of
relying on last jump history entry's insn_idx to determine whether we
already have entry for current instruction or not. It can happen that we
added jump history entry because current instruction is_jmp_point(), but
also we need to add instruction flags for stack access. In this case, we
don't want to entries, so we need to reuse last added entry, if it is
present.

Relying on insn_idx comparison has the same ambiguity problem as the one
that was fixed recently in [0], so we avoid that.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231110002638.4=
168352-3-andrii@kernel.org/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h                  |  31 +++-
 kernel/bpf/verifier.c                         | 175 ++++++++++--------
 .../bpf/progs/verifier_subprog_precision.c    |  23 ++-
 .../testing/selftests/bpf/verifier/precise.c  |  38 ++--
 4 files changed, 169 insertions(+), 98 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3378cc753061..bada59812e00 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -325,12 +325,34 @@ struct bpf_func_state {
 	int allocated_stack;
 };
=20
-struct bpf_idx_pair {
-	u32 prev_idx;
+#define MAX_CALL_FRAMES 8
+
+/* instruction history flags, used in bpf_jmp_history_entry.flags field */
+enum {
+	/* instruction references stack slot through PTR_TO_STACK register;
+	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES is=
 8)
+	 * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512,
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
+struct bpf_jmp_history_entry {
 	u32 idx;
+	/* insn idx can't be bigger than 1 million */
+	u32 prev_idx : 22;
+	/* special flags, e.g., whether insn is doing register stack spill/load */
+	u32 flags : 10;
 };
=20
-#define MAX_CALL_FRAMES 8
 /* Maximum number of register states that can exist at once */
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MA=
X_CALL_FRAMES)
 struct bpf_verifier_state {
@@ -413,7 +435,7 @@ struct bpf_verifier_state {
 	 * For most states jmp_history_cnt is [0-3].
 	 * For loops can go up to ~40.
 	 */
-	struct bpf_idx_pair *jmp_history;
+	struct bpf_jmp_history_entry *jmp_history;
 	u32 jmp_history_cnt;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
@@ -656,6 +678,7 @@ struct bpf_verifier_env {
 		int cur_stack;
 	} cfg;
 	struct backtrack_state bt;
+	struct bpf_jmp_history_entry *cur_hist_ent;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cdb4f5f0ba79..4f8a3c77eb80 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1355,8 +1355,8 @@ static int copy_verifier_state(struct bpf_verifier_st=
ate *dst_state,
 	int i, err;
=20
 	dst_state->jmp_history =3D copy_array(dst_state->jmp_history, src->jmp_hi=
story,
-					    src->jmp_history_cnt, sizeof(struct bpf_idx_pair),
-					    GFP_USER);
+					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
+					  GFP_USER);
 	if (!dst_state->jmp_history)
 		return -ENOMEM;
 	dst_state->jmp_history_cnt =3D src->jmp_history_cnt;
@@ -3221,6 +3221,21 @@ static int check_reg_arg(struct bpf_verifier_env *en=
v, u32 regno,
 	return __check_reg_arg(env, state->regs, regno, t);
 }
=20
+static int insn_stack_access_flags(int frameno, int spi)
+{
+	return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
+}
+
+static int insn_stack_access_spi(int insn_flags)
+{
+	return (insn_flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK;
+}
+
+static int insn_stack_access_frameno(int insn_flags)
+{
+	return insn_flags & INSN_F_FRAMENO_MASK;
+}
+
 static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].jmp_point =3D true;
@@ -3232,28 +3247,51 @@ static bool is_jmp_point(struct bpf_verifier_env *e=
nv, int insn_idx)
 }
=20
 /* for any branch, call, exit record the history of jmps in the given stat=
e */
-static int push_jmp_history(struct bpf_verifier_env *env,
-			    struct bpf_verifier_state *cur)
+static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verif=
ier_state *cur,
+			    int insn_flags)
 {
 	u32 cnt =3D cur->jmp_history_cnt;
-	struct bpf_idx_pair *p;
+	struct bpf_jmp_history_entry *p;
 	size_t alloc_size;
=20
-	if (!is_jmp_point(env, env->insn_idx))
+	/* combine instruction flags if we already recorded this instruction */
+	if (env->cur_hist_ent) {
+		/* atomic instructions push insn_flags twice, for READ and
+		 * WRITE sides, but they should agree on stack slot
+		 */
+		WARN_ONCE((env->cur_hist_ent->flags & insn_flags) &&
+			  (env->cur_hist_ent->flags & insn_flags) !=3D insn_flags,
+			  "verifier insn history bug: insn_idx %d cur flags %x new flags %x\n",
+			  env->insn_idx, env->cur_hist_ent->flags, insn_flags);
+		env->cur_hist_ent->flags |=3D insn_flags;
 		return 0;
+	}
=20
 	cnt++;
 	alloc_size =3D kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
 	p =3D krealloc(cur->jmp_history, alloc_size, GFP_USER);
 	if (!p)
 		return -ENOMEM;
-	p[cnt - 1].idx =3D env->insn_idx;
-	p[cnt - 1].prev_idx =3D env->prev_insn_idx;
 	cur->jmp_history =3D p;
+
+	p =3D &cur->jmp_history[cnt - 1];
+	p->idx =3D env->insn_idx;
+	p->prev_idx =3D env->prev_insn_idx;
+	p->flags =3D insn_flags;
 	cur->jmp_history_cnt =3D cnt;
+	env->cur_hist_ent =3D p;
+
 	return 0;
 }
=20
+static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifie=
r_state *st,
+						        u32 hist_end, int insn_idx)
+{
+	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx =3D=3D insn_idx)
+		return &st->jmp_history[hist_end - 1];
+	return NULL;
+}
+
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
  * Return -ENOENT if we exhausted all instructions within given state.
@@ -3415,9 +3453,14 @@ static inline bool bt_is_reg_set(struct backtrack_st=
ate *bt, u32 reg)
 	return bt->reg_masks[bt->frame] & (1 << reg);
 }
=20
+static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 fr=
ame, u32 slot)
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
@@ -3471,7 +3514,7 @@ static bool calls_callback(struct bpf_verifier_env *e=
nv, int insn_idx);
  *   - *was* processed previously during backtracking.
  */
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subse=
q_idx,
-			  struct backtrack_state *bt)
+			  struct bpf_jmp_history_entry *hist, struct backtrack_state *bt)
 {
 	const struct bpf_insn_cbs cbs =3D {
 		.cb_call	=3D disasm_kfunc_name,
@@ -3484,7 +3527,7 @@ static int backtrack_insn(struct bpf_verifier_env *en=
v, int idx, int subseq_idx,
 	u8 mode =3D BPF_MODE(insn->code);
 	u32 dreg =3D insn->dst_reg;
 	u32 sreg =3D insn->src_reg;
-	u32 spi, i;
+	u32 spi, i, fr;
=20
 	if (insn->code =3D=3D 0)
 		return 0;
@@ -3545,20 +3588,15 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
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
+		spi =3D insn_stack_access_spi(hist->flags);
+		fr =3D insn_stack_access_frameno(hist->flags);
+		bt_set_frame_slot(bt, fr, spi);
 	} else if (class =3D=3D BPF_STX || class =3D=3D BPF_ST) {
 		if (bt_is_reg_set(bt, dreg))
 			/* stx & st shouldn't be using _scalar_ dst_reg
@@ -3567,17 +3605,13 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
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
+		spi =3D insn_stack_access_spi(hist->flags);
+		fr =3D insn_stack_access_frameno(hist->flags);
+		if (!bt_is_frame_slot_set(bt, fr, spi))
 			return 0;
-		bt_clear_slot(bt, spi);
+		bt_clear_frame_slot(bt, fr, spi);
 		if (class =3D=3D BPF_STX)
 			bt_set_reg(bt, sreg);
 	} else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
@@ -3621,10 +3655,14 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
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
+					WARN_ONCE(1, "verifier backtracking bug (subprog leftover stack slots=
)");
+					return -EFAULT;
+				}
 				/* propagate r1-r5 to the caller */
 				for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
 					if (bt_is_reg_set(bt, i)) {
@@ -3649,8 +3687,11 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 				WARN_ONCE(1, "verifier backtracking bug");
 				return -EFAULT;
 			}
-			if (bt_stack_mask(bt) !=3D 0)
-				return -ENOTSUPP;
+			if (bt_stack_mask(bt) !=3D 0) {
+				verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
+				WARN_ONCE(1, "verifier backtracking bug (callback leftover stack slots=
)");
+				return -EFAULT;
+			}
 			/* clear r1-r5 in callback subprog's mask */
 			for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
 				bt_clear_reg(bt, i);
@@ -4087,6 +4128,7 @@ static int __mark_chain_precision(struct bpf_verifier=
_env *env, int regno)
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
 		u32 history =3D st->jmp_history_cnt;
+		struct bpf_jmp_history_entry *hist;
=20
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_id=
x %d \n",
@@ -4150,7 +4192,8 @@ static int __mark_chain_precision(struct bpf_verifier=
_env *env, int regno)
 				err =3D 0;
 				skip_first =3D false;
 			} else {
-				err =3D backtrack_insn(env, i, subseq_idx, bt);
+				hist =3D get_jmp_hist_entry(st, history, i);
+				err =3D backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err =3D=3D -ENOTSUPP) {
 				mark_all_scalars_precise(env, env->cur_state);
@@ -4203,22 +4246,10 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
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
+					WARN_ONCE(1, "verifier backtracking bug (stack slot out of bounds)");
+					return -EFAULT;
 				}
=20
 				if (!is_spilled_scalar_reg(&func->stack[i])) {
@@ -4391,7 +4422,7 @@ static int check_stack_write_fixed_off(struct bpf_ver=
ifier_env *env,
 	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE, err;
 	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg =3D NULL;
-	u32 dst_reg =3D insn->dst_reg;
+	int insn_flags =3D insn_stack_access_flags(state->frameno, spi);
=20
 	err =3D grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
 	if (err)
@@ -4432,17 +4463,6 @@ static int check_stack_write_fixed_off(struct bpf_ve=
rifier_env *env,
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
@@ -4454,6 +4474,7 @@ static int check_stack_write_fixed_off(struct bpf_ver=
ifier_env *env,
 		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type =3D SCALAR_VALUE;
 		save_register_state(state, spi, &fake_reg, size);
+		insn_flags =3D 0; /* not a register spill */
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size !=3D BPF_REG_SIZE) {
@@ -4499,9 +4520,12 @@ static int check_stack_write_fixed_off(struct bpf_ve=
rifier_env *env,
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
+		return push_jmp_history(env, env->cur_state, insn_flags);
 	return 0;
 }
=20
@@ -4694,6 +4718,7 @@ static int check_stack_read_fixed_off(struct bpf_veri=
fier_env *env,
 	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE;
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
+	int insn_flags =3D insn_stack_access_flags(reg_state->frameno, spi);
=20
 	stype =3D reg_state->stack[spi].slot_type;
 	reg =3D &reg_state->stack[spi].spilled_ptr;
@@ -4739,12 +4764,10 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
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
@@ -4780,7 +4803,10 @@ static int check_stack_read_fixed_off(struct bpf_ver=
ifier_env *env,
 		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 		if (dst_regno >=3D 0)
 			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
+		insn_flags =3D 0; /* we are not restoring spilled register */
 	}
+	if (insn_flags)
+		return push_jmp_history(env, env->cur_state, insn_flags);
 	return 0;
 }
=20
@@ -6940,7 +6966,6 @@ static int check_atomic(struct bpf_verifier_env *env,=
 int insn_idx, struct bpf_i
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
-
 	return 0;
 }
=20
@@ -16910,7 +16935,8 @@ static int is_state_visited(struct bpf_verifier_env=
 *env, int insn_idx)
 			 * the precision needs to be propagated back in
 			 * the current state.
 			 */
-			err =3D err ? : push_jmp_history(env, cur);
+			if (is_jmp_point(env, env->insn_idx))
+				err =3D err ? : push_jmp_history(env, cur, 0);
 			err =3D err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -17135,6 +17161,9 @@ static int do_check(struct bpf_verifier_env *env)
 		u8 class;
 		int err;
=20
+		/* reset current history entry on each new instruction */
+		env->cur_hist_ent =3D NULL;
+
 		env->prev_insn_idx =3D prev_insn_idx;
 		if (env->insn_idx >=3D insn_cnt) {
 			verbose(env, "invalid insn idx %d insn_cnt %d\n",
@@ -17174,7 +17203,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
=20
 		if (is_jmp_point(env, env->insn_idx)) {
-			err =3D push_jmp_history(env, state);
+			err =3D push_jmp_history(env, state, 0);
 			if (err)
 				return err;
 		}
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c=
 b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 0dfe3f8b69ac..eba98fab2f54 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -589,11 +589,24 @@ static __u64 subprog_spill_reg_precise(void)
=20
 SEC("?raw_tp")
 __success __log_level(2)
-/* precision backtracking can't currently handle stack access not through =
r10,
- * so we won't be able to mark stack slot fp-8 as precise, and so will
- * fallback to forcing all as precise
- */
-__msg("mark_precise: frame0: falling back to forcing all scalars precise")
+__msg("10: (0f) r1 +=3D r7")
+__msg("mark_precise: frame0: last_idx 10 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr7 stack=3D before 9: (bf) r1 =3D r8")
+__msg("mark_precise: frame0: regs=3Dr7 stack=3D before 8: (27) r7 *=3D 4")
+__msg("mark_precise: frame0: regs=3Dr7 stack=3D before 7: (79) r7 =3D *(u6=
4 *)(r10 -8)")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D-8:  R0_w=3D2 R6=
_w=3D1 R8_rw=3Dmap_value(map=3D.data.vals,ks=3D4,vs=3D16) R10=3Dfp0 fp-8_rw=
=3DP1")
+__msg("mark_precise: frame0: last_idx 18 first_idx 0 subseq_idx 7")
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 18: (95) exit")
+__msg("mark_precise: frame1: regs=3D stack=3D before 17: (0f) r0 +=3D r2")
+__msg("mark_precise: frame1: regs=3D stack=3D before 16: (79) r2 =3D *(u64=
 *)(r1 +0)")
+__msg("mark_precise: frame1: regs=3D stack=3D before 15: (79) r0 =3D *(u64=
 *)(r10 -16)")
+__msg("mark_precise: frame1: regs=3D stack=3D before 14: (7b) *(u64 *)(r10=
 -16) =3D r2")
+__msg("mark_precise: frame1: regs=3D stack=3D before 13: (7b) *(u64 *)(r1 =
+0) =3D r2")
+__msg("mark_precise: frame1: regs=3Dr2 stack=3D before 6: (85) call pc+6")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 5: (bf) r2 =3D r6")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 4: (07) r1 +=3D -8")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 3: (bf) r1 =3D r10")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 2: (b7) r6 =3D 1")
 __naked int subprog_spill_into_parent_stack_slot_precise(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing=
/selftests/bpf/verifier/precise.c
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
+	/* not a register spill, so we stop precision propagation for R4 here */
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
+	/* make later reg spill more interesting by having somewhat known scalar =
*/
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
+	mark_precise: frame0: regs=3Dr4 stack=3D before 5: (79) r4 =3D *(u64 *)(r=
10 -8)\
+	mark_precise: frame0: regs=3D stack=3D-8 before 4: (7b) *(u64 *)(r3 -8) =
=3D r0\
+	mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
+	mark_precise: frame0: last_idx 3 first_idx 3\
+	mark_precise: frame0: regs=3Dr0 stack=3D before 3: (55) if r3 !=3D 0x7b g=
oto pc+0\
+	mark_precise: frame0: regs=3Dr0 stack=3D before 2: (bf) r3 =3D r10\
+	mark_precise: frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255\
+	mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
+	mark_precise: frame0: last_idx 0 first_idx 0\
+	mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_pran=
dom_u32#7\
+	mark_precise: frame0: last_idx 7 first_idx 7\
 	mark_precise: frame0: parent state regs=3D stack=3D:",
 	.result =3D VERBOSE_ACCEPT,
 	.retval =3D -1,
--=20
2.34.1



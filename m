Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1CE6EEB15
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbjDYXtf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Apr 2023 19:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbjDYXte (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:49:34 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974DB219
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:31 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEVPb028549
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:31 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6ek7mqpc-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:31 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:49:27 -0700
Received: from twshared13785.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:49:26 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id DD9EB2F2D8347; Tue, 25 Apr 2023 16:49:20 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 03/10] bpf: encapsulate precision backtracking bookkeeping
Date:   Tue, 25 Apr 2023 16:49:04 -0700
Message-ID: <20230425234911.2113352-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425234911.2113352-1-andrii@kernel.org>
References: <20230425234911.2113352-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UnL1G-sy3cdcqyCThSOJp5kQuNphz9dU
X-Proofpoint-GUID: UnL1G-sy3cdcqyCThSOJp5kQuNphz9dU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_10,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add struct backtrack_state and straightforward API around it to keep
track of register and stack masks used and maintained during precision
backtracking process. Having this logic separately allow to keep
high-level backtracking algorithm cleaner, but also it sets us up to
cleanly keep track of register and stack masks per frame, allowing (with
some further logic adjustments) to perform precision backpropagation
across multiple frames (i.e., subprog calls).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  15 ++
 kernel/bpf/verifier.c        | 258 ++++++++++++++++++++++++++---------
 2 files changed, 206 insertions(+), 67 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3dd29a53b711..185bfaf0ec6b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -238,6 +238,10 @@ enum bpf_stack_slot_type {
 
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
 
+#define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
+			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
+			  (1 << BPF_REG_5))
+
 #define BPF_DYNPTR_SIZE		sizeof(struct bpf_dynptr_kern)
 #define BPF_DYNPTR_NR_SLOTS		(BPF_DYNPTR_SIZE / BPF_REG_SIZE)
 
@@ -541,6 +545,16 @@ struct bpf_subprog_info {
 	bool is_async_cb;
 };
 
+struct bpf_verifier_env;
+
+struct backtrack_state {
+	struct bpf_verifier_env *env;
+	u32 frame;
+	u32 bitcnt;
+	u32 reg_masks[MAX_CALL_FRAMES];
+	u64 stack_masks[MAX_CALL_FRAMES];
+};
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -578,6 +592,7 @@ struct bpf_verifier_env {
 		int *insn_stack;
 		int cur_stack;
 	} cfg;
+	struct backtrack_state bt;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fea6fe4acba2..1cb89fe00507 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1254,6 +1254,12 @@ static bool is_spilled_reg(const struct bpf_stack_state *stack)
 	return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL;
 }
 
+static bool is_spilled_scalar_reg(const struct bpf_stack_state *stack)
+{
+	return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL &&
+	       stack->spilled_ptr.type == SCALAR_VALUE;
+}
+
 static void scrub_spilled_slot(u8 *stype)
 {
 	if (*stype != STACK_INVALID)
@@ -3144,12 +3150,137 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 	return btf_name_by_offset(desc_btf, func->name_off);
 }
 
+static inline void bt_init(struct backtrack_state *bt, u32 frame)
+{
+	bt->frame = frame;
+}
+
+static inline void bt_reset(struct backtrack_state *bt)
+{
+	struct bpf_verifier_env *env = bt->env;
+	memset(bt, 0, sizeof(*bt));
+	bt->env = env;
+}
+
+static inline u32 bt_bitcnt(struct backtrack_state *bt)
+{
+	return bt->bitcnt;
+}
+
+static inline int bt_subprog_enter(struct backtrack_state *bt)
+{
+	if (bt->frame == MAX_CALL_FRAMES - 1) {
+		verbose(bt->env, "BUG subprog enter from frame %d\n", bt->frame);
+		WARN_ONCE(1, "verifier backtracking bug");
+		return -EFAULT;
+	}
+	bt->frame++;
+	return 0;
+}
+
+static inline int bt_subprog_exit(struct backtrack_state *bt)
+{
+	if (bt->frame == 0) {
+		verbose(bt->env, "BUG subprog exit from frame 0\n");
+		WARN_ONCE(1, "verifier backtracking bug");
+		return -EFAULT;
+	}
+	bt->frame--;
+	return 0;
+}
+
+static inline void bt_set_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
+{
+	if (bt->reg_masks[frame] & (1 << reg))
+		return;
+
+	bt->reg_masks[frame] |= 1 << reg;
+	bt->bitcnt++;
+}
+
+static inline void bt_clear_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
+{
+	if (!(bt->reg_masks[frame] & (1 << reg)))
+		return;
+
+	bt->reg_masks[frame] &= ~(1 << reg);
+	bt->bitcnt--;
+}
+
+static inline void bt_set_reg(struct backtrack_state *bt, u32 reg)
+{
+	bt_set_frame_reg(bt, bt->frame, reg);
+}
+
+static inline void bt_clear_reg(struct backtrack_state *bt, u32 reg)
+{
+	bt_clear_frame_reg(bt, bt->frame, reg);
+}
+
+static inline void bt_set_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
+{
+	if (bt->stack_masks[frame] & (1ull << slot))
+		return;
+
+	bt->stack_masks[frame] |= 1ull << slot;
+	bt->bitcnt++;
+}
+
+static inline void bt_clear_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
+{
+	if (!(bt->stack_masks[frame] & (1ull << slot)))
+		return;
+
+	bt->stack_masks[frame] &= ~(1ull << slot);
+	bt->bitcnt--;
+}
+
+static inline void bt_set_slot(struct backtrack_state *bt, u32 slot)
+{
+	bt_set_frame_slot(bt, bt->frame, slot);
+}
+
+static inline void bt_clear_slot(struct backtrack_state *bt, u32 slot)
+{
+	bt_clear_frame_slot(bt, bt->frame, slot);
+}
+
+static inline u32 bt_frame_reg_mask(struct backtrack_state *bt, u32 frame)
+{
+	return bt->reg_masks[frame];
+}
+
+static inline u32 bt_reg_mask(struct backtrack_state *bt)
+{
+	return bt->reg_masks[bt->frame];
+}
+
+static inline u64 bt_frame_stack_mask(struct backtrack_state *bt, u32 frame)
+{
+	return bt->stack_masks[frame];
+}
+
+static inline u64 bt_stack_mask(struct backtrack_state *bt)
+{
+	return bt->stack_masks[bt->frame];
+}
+
+static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
+{
+	return bt->reg_masks[bt->frame] & (1 << reg);
+}
+
+static inline bool bt_is_slot_set(struct backtrack_state *bt, u32 slot)
+{
+	return bt->stack_masks[bt->frame] & (1ull << slot);
+}
+
 /* For given verifier state backtrack_insn() is called from the last insn to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
  */
 static int backtrack_insn(struct bpf_verifier_env *env, int idx,
-			  u32 *reg_mask, u64 *stack_mask)
+			  struct backtrack_state *bt)
 {
 	const struct bpf_insn_cbs cbs = {
 		.cb_call	= disasm_kfunc_name,
@@ -3160,20 +3291,20 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 	u8 class = BPF_CLASS(insn->code);
 	u8 opcode = BPF_OP(insn->code);
 	u8 mode = BPF_MODE(insn->code);
-	u32 dreg = 1u << insn->dst_reg;
-	u32 sreg = 1u << insn->src_reg;
+	u32 dreg = insn->dst_reg;
+	u32 sreg = insn->src_reg;
 	u32 spi;
 
 	if (insn->code == 0)
 		return 0;
 	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "regs=%x stack=%llx before ", *reg_mask, *stack_mask);
+		verbose(env, "regs=%x stack=%llx before ", bt_reg_mask(bt), bt_stack_mask(bt));
 		verbose(env, "%d: ", idx);
 		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 	}
 
 	if (class == BPF_ALU || class == BPF_ALU64) {
-		if (!(*reg_mask & dreg))
+		if (!bt_is_reg_set(bt, dreg))
 			return 0;
 		if (opcode == BPF_MOV) {
 			if (BPF_SRC(insn->code) == BPF_X) {
@@ -3181,8 +3312,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 				 * dreg needs precision after this insn
 				 * sreg needs precision before this insn
 				 */
-				*reg_mask &= ~dreg;
-				*reg_mask |= sreg;
+				bt_clear_reg(bt, dreg);
+				bt_set_reg(bt, sreg);
 			} else {
 				/* dreg = K
 				 * dreg needs precision after this insn.
@@ -3190,7 +3321,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 				 * as precise=true in this verifier state.
 				 * No further markings in parent are necessary
 				 */
-				*reg_mask &= ~dreg;
+				bt_clear_reg(bt, dreg);
 			}
 		} else {
 			if (BPF_SRC(insn->code) == BPF_X) {
@@ -3198,15 +3329,15 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 				 * both dreg and sreg need precision
 				 * before this insn
 				 */
-				*reg_mask |= sreg;
+				bt_set_reg(bt, sreg);
 			} /* else dreg += K
 			   * dreg still needs precision before this insn
 			   */
 		}
 	} else if (class == BPF_LDX) {
-		if (!(*reg_mask & dreg))
+		if (!bt_is_reg_set(bt, dreg))
 			return 0;
-		*reg_mask &= ~dreg;
+		bt_clear_reg(bt, dreg);
 
 		/* scalars can only be spilled into stack w/o losing precision.
 		 * Load from any other memory can be zero extended.
@@ -3227,9 +3358,9 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 			WARN_ONCE(1, "verifier backtracking bug");
 			return -EFAULT;
 		}
-		*stack_mask |= 1ull << spi;
+		bt_set_slot(bt, spi);
 	} else if (class == BPF_STX || class == BPF_ST) {
-		if (*reg_mask & dreg)
+		if (bt_is_reg_set(bt, dreg))
 			/* stx & st shouldn't be using _scalar_ dst_reg
 			 * to access memory. It means backtracking
 			 * encountered a case of pointer subtraction.
@@ -3244,11 +3375,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 			WARN_ONCE(1, "verifier backtracking bug");
 			return -EFAULT;
 		}
-		if (!(*stack_mask & (1ull << spi)))
+		if (!bt_is_slot_set(bt, spi))
 			return 0;
-		*stack_mask &= ~(1ull << spi);
+		bt_clear_slot(bt, spi);
 		if (class == BPF_STX)
-			*reg_mask |= sreg;
+			bt_set_reg(bt, sreg);
 	} else if (class == BPF_JMP || class == BPF_JMP32) {
 		if (opcode == BPF_CALL) {
 			if (insn->src_reg == BPF_PSEUDO_CALL)
@@ -3265,19 +3396,19 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && insn->imm == 0)
 				return -ENOTSUPP;
 			/* regular helper call sets R0 */
-			*reg_mask &= ~1;
-			if (*reg_mask & 0x3f) {
+			bt_clear_reg(bt, BPF_REG_0);
+			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
 				/* if backtracing was looking for registers R1-R5
 				 * they should have been found already.
 				 */
-				verbose(env, "BUG regs %x\n", *reg_mask);
+				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
 				WARN_ONCE(1, "verifier backtracking bug");
 				return -EFAULT;
 			}
 		} else if (opcode == BPF_EXIT) {
 			return -ENOTSUPP;
 		} else if (BPF_SRC(insn->code) == BPF_X) {
-			if (!(*reg_mask & (dreg | sreg)))
+			if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt, sreg))
 				return 0;
 			/* dreg <cond> sreg
 			 * Both dreg and sreg need precision before
@@ -3285,7 +3416,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 			 * before it would be equally necessary to
 			 * propagate it to dreg.
 			 */
-			*reg_mask |= (sreg | dreg);
+			bt_set_reg(bt, dreg);
+			bt_set_reg(bt, sreg);
 			 /* else dreg <cond> K
 			  * Only dreg still needs precision before
 			  * this insn, so for the K-based conditional
@@ -3293,9 +3425,9 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 			  */
 		}
 	} else if (class == BPF_LD) {
-		if (!(*reg_mask & dreg))
+		if (!bt_is_reg_set(bt, dreg))
 			return 0;
-		*reg_mask &= ~dreg;
+		bt_clear_reg(bt, dreg);
 		/* It's ld_imm64 or ld_abs or ld_ind.
 		 * For ld_imm64 no further tracking of precision
 		 * into parent is necessary
@@ -3508,20 +3640,21 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int regno,
 				  int spi)
 {
+	struct backtrack_state *bt = &env->bt;
 	struct bpf_verifier_state *st = env->cur_state;
 	int first_idx = st->first_insn_idx;
 	int last_idx = env->insn_idx;
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
-	u32 reg_mask = regno >= 0 ? 1u << regno : 0;
-	u64 stack_mask = spi >= 0 ? 1ull << spi : 0;
 	bool skip_first = true;
-	bool new_marks = false;
 	int i, err;
 
 	if (!env->bpf_capable)
 		return 0;
 
+	/* set frame number from which we are starting to backtrack */
+	bt_init(bt, frame);
+
 	/* Do sanity checks against current state of register and/or stack
 	 * slot, but don't set precise flag in current state, as precision
 	 * tracking in the current state is unnecessary.
@@ -3533,26 +3666,17 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 			WARN_ONCE(1, "backtracing misuse");
 			return -EFAULT;
 		}
-		new_marks = true;
+		bt_set_reg(bt, regno);
 	}
 
 	while (spi >= 0) {
-		if (!is_spilled_reg(&func->stack[spi])) {
-			stack_mask = 0;
-			break;
-		}
-		reg = &func->stack[spi].spilled_ptr;
-		if (reg->type != SCALAR_VALUE) {
-			stack_mask = 0;
+		if (!is_spilled_scalar_reg(&func->stack[spi]))
 			break;
-		}
-		new_marks = true;
+		bt_set_slot(bt, spi);
 		break;
 	}
 
-	if (!new_marks)
-		return 0;
-	if (!reg_mask && !stack_mask)
+	if (bt_bitcnt(bt) == 0)
 		return 0;
 
 	for (;;) {
@@ -3571,12 +3695,13 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 			if (st->curframe == 0 &&
 			    st->frame[0]->subprogno > 0 &&
 			    st->frame[0]->callsite == BPF_MAIN_FUNC &&
-			    stack_mask == 0 && (reg_mask & ~0x3e) == 0) {
-				bitmap_from_u64(mask, reg_mask);
+			    bt_stack_mask(bt) == 0 &&
+			    (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) == 0) {
+				bitmap_from_u64(mask, bt_reg_mask(bt));
 				for_each_set_bit(i, mask, 32) {
 					reg = &st->frame[0]->regs[i];
 					if (reg->type != SCALAR_VALUE) {
-						reg_mask &= ~(1u << i);
+						bt_clear_reg(bt, i);
 						continue;
 					}
 					reg->precise = true;
@@ -3584,8 +3709,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 				return 0;
 			}
 
-			verbose(env, "BUG backtracing func entry subprog %d reg_mask %x stack_mask %llx\n",
-				st->frame[0]->subprogno, reg_mask, stack_mask);
+			verbose(env, "BUG backtracking func entry subprog %d reg_mask %x stack_mask %llx\n",
+				st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
 			WARN_ONCE(1, "verifier backtracking bug");
 			return -EFAULT;
 		}
@@ -3595,15 +3720,16 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 				err = 0;
 				skip_first = false;
 			} else {
-				err = backtrack_insn(env, i, &reg_mask, &stack_mask);
+				err = backtrack_insn(env, i, bt);
 			}
 			if (err == -ENOTSUPP) {
 				mark_all_scalars_precise(env, st);
+				bt_reset(bt);
 				return 0;
 			} else if (err) {
 				return err;
 			}
-			if (!reg_mask && !stack_mask)
+			if (bt_bitcnt(bt) == 0)
 				/* Found assignment(s) into tracked register in this state.
 				 * Since this state is already marked, just return.
 				 * Nothing to be tracked further in the parent state.
@@ -3628,21 +3754,21 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		if (!st)
 			break;
 
-		new_marks = false;
 		func = st->frame[frame];
-		bitmap_from_u64(mask, reg_mask);
+		bitmap_from_u64(mask, bt_reg_mask(bt));
 		for_each_set_bit(i, mask, 32) {
 			reg = &func->regs[i];
 			if (reg->type != SCALAR_VALUE) {
-				reg_mask &= ~(1u << i);
+				bt_clear_reg(bt, i);
 				continue;
 			}
-			if (!reg->precise)
-				new_marks = true;
-			reg->precise = true;
+			if (reg->precise)
+				bt_clear_reg(bt, i);
+			else
+				reg->precise = true;
 		}
 
-		bitmap_from_u64(mask, stack_mask);
+		bitmap_from_u64(mask, bt_stack_mask(bt));
 		for_each_set_bit(i, mask, 64) {
 			if (i >= func->allocated_stack / BPF_REG_SIZE) {
 				/* the sequence of instructions:
@@ -3659,32 +3785,28 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 				 * In such case fallback to conservative.
 				 */
 				mark_all_scalars_precise(env, st);
+				bt_reset(bt);
 				return 0;
 			}
 
-			if (!is_spilled_reg(&func->stack[i])) {
-				stack_mask &= ~(1ull << i);
+			if (!is_spilled_scalar_reg(&func->stack[i])) {
+				bt_clear_slot(bt, i);
 				continue;
 			}
 			reg = &func->stack[i].spilled_ptr;
-			if (reg->type != SCALAR_VALUE) {
-				stack_mask &= ~(1ull << i);
-				continue;
-			}
-			if (!reg->precise)
-				new_marks = true;
-			reg->precise = true;
+			if (reg->precise)
+				bt_clear_slot(bt, i);
+			else
+				reg->precise = true;
 		}
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "parent %s regs=%x stack=%llx marks:",
-				new_marks ? "didn't have" : "already had",
-				reg_mask, stack_mask);
+				bt_bitcnt(bt) ? "didn't have" : "already had",
+				bt_reg_mask(bt), bt_stack_mask(bt));
 			print_verifier_state(env, func, true);
 		}
 
-		if (!reg_mask && !stack_mask)
-			break;
-		if (!new_marks)
+		if (bt_bitcnt(bt) == 0)
 			break;
 
 		last_idx = st->last_insn_idx;
@@ -18809,6 +18931,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (!env)
 		return -ENOMEM;
 
+	env->bt.env = env;
+
 	len = (*prog)->len;
 	env->insn_aux_data =
 		vzalloc(array_size(sizeof(struct bpf_insn_aux_data), len));
-- 
2.34.1


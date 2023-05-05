Return-Path: <bpf+bounces-64-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C626F79F5
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F4B280F5F
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D1F10F5;
	Fri,  5 May 2023 00:10:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAD621
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:10:04 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989B54215
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 17:10:02 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 344JKZgG013476
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 17:10:01 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qccq04mav-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 17:10:00 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 17:09:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 681BA3002F9B4; Thu,  4 May 2023 17:09:22 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 03/10] bpf: encapsulate precision backtracking bookkeeping
Date: Thu, 4 May 2023 17:09:01 -0700
Message-ID: <20230505000908.1265044-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505000908.1265044-1-andrii@kernel.org>
References: <20230505000908.1265044-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZHv9cklSEsq6NfTW-hiXy1iMYZmzOgg3
X-Proofpoint-GUID: ZHv9cklSEsq6NfTW-hiXy1iMYZmzOgg3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 kernel/bpf/verifier.c        | 265 ++++++++++++++++++++++++++---------
 2 files changed, 213 insertions(+), 67 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3dd29a53b711..185bfaf0ec6b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -238,6 +238,10 @@ enum bpf_stack_slot_type {
=20
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
=20
+#define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
+			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
+			  (1 << BPF_REG_5))
+
 #define BPF_DYNPTR_SIZE		sizeof(struct bpf_dynptr_kern)
 #define BPF_DYNPTR_NR_SLOTS		(BPF_DYNPTR_SIZE / BPF_REG_SIZE)
=20
@@ -541,6 +545,16 @@ struct bpf_subprog_info {
 	bool is_async_cb;
 };
=20
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
index da8a5834f2ca..3aa8ec9f1f7c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1296,6 +1296,12 @@ static bool is_spilled_reg(const struct bpf_stack_=
state *stack)
 	return stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL;
 }
=20
+static bool is_spilled_scalar_reg(const struct bpf_stack_state *stack)
+{
+	return stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL &&
+	       stack->spilled_ptr.type =3D=3D SCALAR_VALUE;
+}
+
 static void scrub_spilled_slot(u8 *stype)
 {
 	if (*stype !=3D STACK_INVALID)
@@ -3186,12 +3192,144 @@ static const char *disasm_kfunc_name(void *data,=
 const struct bpf_insn *insn)
 	return btf_name_by_offset(desc_btf, func->name_off);
 }
=20
+static inline void bt_init(struct backtrack_state *bt, u32 frame)
+{
+	bt->frame =3D frame;
+}
+
+static inline void bt_reset(struct backtrack_state *bt)
+{
+	struct bpf_verifier_env *env =3D bt->env;
+
+	memset(bt, 0, sizeof(*bt));
+	bt->env =3D env;
+}
+
+static inline u32 bt_empty(struct backtrack_state *bt)
+{
+	u64 mask =3D 0;
+	int i;
+
+	for (i =3D 0; i < MAX_CALL_FRAMES; i++)
+		mask |=3D bt->reg_masks[i] | bt->stack_masks[i];
+
+	return mask =3D=3D 0;
+}
+
+static inline int bt_subprog_enter(struct backtrack_state *bt)
+{
+	if (bt->frame =3D=3D MAX_CALL_FRAMES - 1) {
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
+	if (bt->frame =3D=3D 0) {
+		verbose(bt->env, "BUG subprog exit from frame 0\n");
+		WARN_ONCE(1, "verifier backtracking bug");
+		return -EFAULT;
+	}
+	bt->frame--;
+	return 0;
+}
+
+static inline void bt_set_frame_reg(struct backtrack_state *bt, u32 fram=
e, u32 reg)
+{
+	if (bt->reg_masks[frame] & (1 << reg))
+		return;
+
+	bt->reg_masks[frame] |=3D 1 << reg;
+	bt->bitcnt++;
+}
+
+static inline void bt_clear_frame_reg(struct backtrack_state *bt, u32 fr=
ame, u32 reg)
+{
+	if (!(bt->reg_masks[frame] & (1 << reg)))
+		return;
+
+	bt->reg_masks[frame] &=3D ~(1 << reg);
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
+static inline void bt_set_frame_slot(struct backtrack_state *bt, u32 fra=
me, u32 slot)
+{
+	if (bt->stack_masks[frame] & (1ull << slot))
+		return;
+
+	bt->stack_masks[frame] |=3D 1ull << slot;
+	bt->bitcnt++;
+}
+
+static inline void bt_clear_frame_slot(struct backtrack_state *bt, u32 f=
rame, u32 slot)
+{
+	if (!(bt->stack_masks[frame] & (1ull << slot)))
+		return;
+
+	bt->stack_masks[frame] &=3D ~(1ull << slot);
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
+static inline u32 bt_frame_reg_mask(struct backtrack_state *bt, u32 fram=
e)
+{
+	return bt->reg_masks[frame];
+}
+
+static inline u32 bt_reg_mask(struct backtrack_state *bt)
+{
+	return bt->reg_masks[bt->frame];
+}
+
+static inline u64 bt_frame_stack_mask(struct backtrack_state *bt, u32 fr=
ame)
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
 /* For given verifier state backtrack_insn() is called from the last ins=
n to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
  */
 static int backtrack_insn(struct bpf_verifier_env *env, int idx,
-			  u32 *reg_mask, u64 *stack_mask)
+			  struct backtrack_state *bt)
 {
 	const struct bpf_insn_cbs cbs =3D {
 		.cb_call	=3D disasm_kfunc_name,
@@ -3202,20 +3340,20 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx,
 	u8 class =3D BPF_CLASS(insn->code);
 	u8 opcode =3D BPF_OP(insn->code);
 	u8 mode =3D BPF_MODE(insn->code);
-	u32 dreg =3D 1u << insn->dst_reg;
-	u32 sreg =3D 1u << insn->src_reg;
+	u32 dreg =3D insn->dst_reg;
+	u32 sreg =3D insn->src_reg;
 	u32 spi;
=20
 	if (insn->code =3D=3D 0)
 		return 0;
 	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "regs=3D%x stack=3D%llx before ", *reg_mask, *stack_mask)=
;
+		verbose(env, "regs=3D%x stack=3D%llx before ", bt_reg_mask(bt), bt_sta=
ck_mask(bt));
 		verbose(env, "%d: ", idx);
 		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 	}
=20
 	if (class =3D=3D BPF_ALU || class =3D=3D BPF_ALU64) {
-		if (!(*reg_mask & dreg))
+		if (!bt_is_reg_set(bt, dreg))
 			return 0;
 		if (opcode =3D=3D BPF_MOV) {
 			if (BPF_SRC(insn->code) =3D=3D BPF_X) {
@@ -3223,8 +3361,8 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx,
 				 * dreg needs precision after this insn
 				 * sreg needs precision before this insn
 				 */
-				*reg_mask &=3D ~dreg;
-				*reg_mask |=3D sreg;
+				bt_clear_reg(bt, dreg);
+				bt_set_reg(bt, sreg);
 			} else {
 				/* dreg =3D K
 				 * dreg needs precision after this insn.
@@ -3232,7 +3370,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx,
 				 * as precise=3Dtrue in this verifier state.
 				 * No further markings in parent are necessary
 				 */
-				*reg_mask &=3D ~dreg;
+				bt_clear_reg(bt, dreg);
 			}
 		} else {
 			if (BPF_SRC(insn->code) =3D=3D BPF_X) {
@@ -3240,15 +3378,15 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx,
 				 * both dreg and sreg need precision
 				 * before this insn
 				 */
-				*reg_mask |=3D sreg;
+				bt_set_reg(bt, sreg);
 			} /* else dreg +=3D K
 			   * dreg still needs precision before this insn
 			   */
 		}
 	} else if (class =3D=3D BPF_LDX) {
-		if (!(*reg_mask & dreg))
+		if (!bt_is_reg_set(bt, dreg))
 			return 0;
-		*reg_mask &=3D ~dreg;
+		bt_clear_reg(bt, dreg);
=20
 		/* scalars can only be spilled into stack w/o losing precision.
 		 * Load from any other memory can be zero extended.
@@ -3269,9 +3407,9 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx,
 			WARN_ONCE(1, "verifier backtracking bug");
 			return -EFAULT;
 		}
-		*stack_mask |=3D 1ull << spi;
+		bt_set_slot(bt, spi);
 	} else if (class =3D=3D BPF_STX || class =3D=3D BPF_ST) {
-		if (*reg_mask & dreg)
+		if (bt_is_reg_set(bt, dreg))
 			/* stx & st shouldn't be using _scalar_ dst_reg
 			 * to access memory. It means backtracking
 			 * encountered a case of pointer subtraction.
@@ -3286,11 +3424,11 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx,
 			WARN_ONCE(1, "verifier backtracking bug");
 			return -EFAULT;
 		}
-		if (!(*stack_mask & (1ull << spi)))
+		if (!bt_is_slot_set(bt, spi))
 			return 0;
-		*stack_mask &=3D ~(1ull << spi);
+		bt_clear_slot(bt, spi);
 		if (class =3D=3D BPF_STX)
-			*reg_mask |=3D sreg;
+			bt_set_reg(bt, sreg);
 	} else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
 		if (opcode =3D=3D BPF_CALL) {
 			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
@@ -3307,19 +3445,19 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx,
 			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL && insn->imm =3D=3D 0)
 				return -ENOTSUPP;
 			/* regular helper call sets R0 */
-			*reg_mask &=3D ~1;
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
 		} else if (opcode =3D=3D BPF_EXIT) {
 			return -ENOTSUPP;
 		} else if (BPF_SRC(insn->code) =3D=3D BPF_X) {
-			if (!(*reg_mask & (dreg | sreg)))
+			if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt, sreg))
 				return 0;
 			/* dreg <cond> sreg
 			 * Both dreg and sreg need precision before
@@ -3327,7 +3465,8 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx,
 			 * before it would be equally necessary to
 			 * propagate it to dreg.
 			 */
-			*reg_mask |=3D (sreg | dreg);
+			bt_set_reg(bt, dreg);
+			bt_set_reg(bt, sreg);
 			 /* else dreg <cond> K
 			  * Only dreg still needs precision before
 			  * this insn, so for the K-based conditional
@@ -3335,9 +3474,9 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx,
 			  */
 		}
 	} else if (class =3D=3D BPF_LD) {
-		if (!(*reg_mask & dreg))
+		if (!bt_is_reg_set(bt, dreg))
 			return 0;
-		*reg_mask &=3D ~dreg;
+		bt_clear_reg(bt, dreg);
 		/* It's ld_imm64 or ld_abs or ld_ind.
 		 * For ld_imm64 no further tracking of precision
 		 * into parent is necessary
@@ -3550,20 +3689,21 @@ static void mark_all_scalars_imprecise(struct bpf=
_verifier_env *env, struct bpf_
 static int __mark_chain_precision(struct bpf_verifier_env *env, int fram=
e, int regno,
 				  int spi)
 {
+	struct backtrack_state *bt =3D &env->bt;
 	struct bpf_verifier_state *st =3D env->cur_state;
 	int first_idx =3D st->first_insn_idx;
 	int last_idx =3D env->insn_idx;
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
-	u32 reg_mask =3D regno >=3D 0 ? 1u << regno : 0;
-	u64 stack_mask =3D spi >=3D 0 ? 1ull << spi : 0;
 	bool skip_first =3D true;
-	bool new_marks =3D false;
 	int i, err;
=20
 	if (!env->bpf_capable)
 		return 0;
=20
+	/* set frame number from which we are starting to backtrack */
+	bt_init(bt, frame);
+
 	/* Do sanity checks against current state of register and/or stack
 	 * slot, but don't set precise flag in current state, as precision
 	 * tracking in the current state is unnecessary.
@@ -3575,26 +3715,17 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
 			WARN_ONCE(1, "backtracing misuse");
 			return -EFAULT;
 		}
-		new_marks =3D true;
+		bt_set_reg(bt, regno);
 	}
=20
 	while (spi >=3D 0) {
-		if (!is_spilled_reg(&func->stack[spi])) {
-			stack_mask =3D 0;
-			break;
-		}
-		reg =3D &func->stack[spi].spilled_ptr;
-		if (reg->type !=3D SCALAR_VALUE) {
-			stack_mask =3D 0;
+		if (!is_spilled_scalar_reg(&func->stack[spi]))
 			break;
-		}
-		new_marks =3D true;
+		bt_set_slot(bt, spi);
 		break;
 	}
=20
-	if (!new_marks)
-		return 0;
-	if (!reg_mask && !stack_mask)
+	if (bt_empty(bt))
 		return 0;
=20
 	for (;;) {
@@ -3613,12 +3744,13 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
 			if (st->curframe =3D=3D 0 &&
 			    st->frame[0]->subprogno > 0 &&
 			    st->frame[0]->callsite =3D=3D BPF_MAIN_FUNC &&
-			    stack_mask =3D=3D 0 && (reg_mask & ~0x3e) =3D=3D 0) {
-				bitmap_from_u64(mask, reg_mask);
+			    bt_stack_mask(bt) =3D=3D 0 &&
+			    (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) =3D=3D 0) {
+				bitmap_from_u64(mask, bt_reg_mask(bt));
 				for_each_set_bit(i, mask, 32) {
 					reg =3D &st->frame[0]->regs[i];
 					if (reg->type !=3D SCALAR_VALUE) {
-						reg_mask &=3D ~(1u << i);
+						bt_clear_reg(bt, i);
 						continue;
 					}
 					reg->precise =3D true;
@@ -3626,8 +3758,8 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int frame, int r
 				return 0;
 			}
=20
-			verbose(env, "BUG backtracing func entry subprog %d reg_mask %x stack=
_mask %llx\n",
-				st->frame[0]->subprogno, reg_mask, stack_mask);
+			verbose(env, "BUG backtracking func entry subprog %d reg_mask %x stac=
k_mask %llx\n",
+				st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
 			WARN_ONCE(1, "verifier backtracking bug");
 			return -EFAULT;
 		}
@@ -3637,15 +3769,16 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
 				err =3D 0;
 				skip_first =3D false;
 			} else {
-				err =3D backtrack_insn(env, i, &reg_mask, &stack_mask);
+				err =3D backtrack_insn(env, i, bt);
 			}
 			if (err =3D=3D -ENOTSUPP) {
 				mark_all_scalars_precise(env, st);
+				bt_reset(bt);
 				return 0;
 			} else if (err) {
 				return err;
 			}
-			if (!reg_mask && !stack_mask)
+			if (bt_empty(bt))
 				/* Found assignment(s) into tracked register in this state.
 				 * Since this state is already marked, just return.
 				 * Nothing to be tracked further in the parent state.
@@ -3670,21 +3803,21 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
 		if (!st)
 			break;
=20
-		new_marks =3D false;
 		func =3D st->frame[frame];
-		bitmap_from_u64(mask, reg_mask);
+		bitmap_from_u64(mask, bt_reg_mask(bt));
 		for_each_set_bit(i, mask, 32) {
 			reg =3D &func->regs[i];
 			if (reg->type !=3D SCALAR_VALUE) {
-				reg_mask &=3D ~(1u << i);
+				bt_clear_reg(bt, i);
 				continue;
 			}
-			if (!reg->precise)
-				new_marks =3D true;
-			reg->precise =3D true;
+			if (reg->precise)
+				bt_clear_reg(bt, i);
+			else
+				reg->precise =3D true;
 		}
=20
-		bitmap_from_u64(mask, stack_mask);
+		bitmap_from_u64(mask, bt_stack_mask(bt));
 		for_each_set_bit(i, mask, 64) {
 			if (i >=3D func->allocated_stack / BPF_REG_SIZE) {
 				/* the sequence of instructions:
@@ -3701,32 +3834,28 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
 				 * In such case fallback to conservative.
 				 */
 				mark_all_scalars_precise(env, st);
+				bt_reset(bt);
 				return 0;
 			}
=20
-			if (!is_spilled_reg(&func->stack[i])) {
-				stack_mask &=3D ~(1ull << i);
+			if (!is_spilled_scalar_reg(&func->stack[i])) {
+				bt_clear_slot(bt, i);
 				continue;
 			}
 			reg =3D &func->stack[i].spilled_ptr;
-			if (reg->type !=3D SCALAR_VALUE) {
-				stack_mask &=3D ~(1ull << i);
-				continue;
-			}
-			if (!reg->precise)
-				new_marks =3D true;
-			reg->precise =3D true;
+			if (reg->precise)
+				bt_clear_slot(bt, i);
+			else
+				reg->precise =3D true;
 		}
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "parent %s regs=3D%x stack=3D%llx marks:",
-				new_marks ? "didn't have" : "already had",
-				reg_mask, stack_mask);
+				!bt_empty(bt) ? "didn't have" : "already had",
+				bt_reg_mask(bt), bt_stack_mask(bt));
 			print_verifier_state(env, func, true);
 		}
=20
-		if (!reg_mask && !stack_mask)
-			break;
-		if (!new_marks)
+		if (bt_empty(bt))
 			break;
=20
 		last_idx =3D st->last_insn_idx;
@@ -18872,6 +19001,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
 	if (!env)
 		return -ENOMEM;
=20
+	env->bt.env =3D env;
+
 	len =3D (*prog)->len;
 	env->insn_aux_data =3D
 		vzalloc(array_size(sizeof(struct bpf_insn_aux_data), len));
--=20
2.34.1



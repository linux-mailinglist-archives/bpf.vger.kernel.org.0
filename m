Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A675372CE
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 00:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiE2Wh4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 May 2022 18:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiE2Why (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 May 2022 18:37:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB605250C
        for <bpf@vger.kernel.org>; Sun, 29 May 2022 15:37:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id l30so9111191lfj.3
        for <bpf@vger.kernel.org>; Sun, 29 May 2022 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CoOQCW7agpu53rzTKcvj7tju6jZRhspj1KOX5ud/QGw=;
        b=Km8NHIfd0Z/sTNLsntr6O0gsWj082SZ/IhjxL5hLYetqlXcdPPHB/yyQXrOvfVb+1k
         /IWudIlEctQ9xrUqTK9q5JWtNiGZvmn3pp3gTUYBebwAWxGZa36UzWHzpZcKIeWsx6uH
         2oJUp0S3/TB3L9N4hOYw2IE0112ZNAtdU9KhdwUCJvCjBqx33H29QKq41/7ktd9Twnh/
         v8O94e+Y1kpTuFSC2tSwFbHoMVS9ZQTL6QPXuajIA9pMhFTRUqVQFZBZm6DDXYoanycZ
         62s2T9I1CmcExslp1JXAtqYrXYuate1hzdE9CDKK2vYmZcgJjmqAAFbL82P87cqbDSwf
         X1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CoOQCW7agpu53rzTKcvj7tju6jZRhspj1KOX5ud/QGw=;
        b=LDQ2U+f1pP3IeRRF+vgHnmb31qXqYqfoet57mKuLI0IlEBMScfuNrzT6OE9iZ32Mic
         /RvYKGtkozejXG79XWEdV83h7/nK8I16ZyDMdE2rEqy0Qr1D/ZddjxVqH2+lu8UbLvvC
         e8N9+jE7PoSnmqXCpV6eiLmiY0SQU7mV+w33QaRkSxUD4Rype/Ix67cZTs9c7rcItgGc
         MhwSkmCpCaw9s9nMlzd+ZefICwbLnJGv+iOVlTnk55qVmJZ/eoQ9MyfMd7svTPfGAouS
         KDJXO6b65XY2N+Bokapd29B1hHe/6i/e+jshzNLE03F2EUNWaP3Zq+izqnusUlcV0pOw
         6uPw==
X-Gm-Message-State: AOAM530dgENYM0ivNzhRhjS7nbpIkpdsuqjRLq8hNJ0qxnaT8Dc6oP4P
        E1Bq7mbCIVUevWylHitLxT0JrNq/PFw=
X-Google-Smtp-Source: ABdhPJxuj6OkMt/hgfCSyN8Ys26+LrbkcSWoisLNEn9EhJvNhToy+3dg0uW9IaLhS8vlFZkgvZrBfw==
X-Received: by 2002:a05:6512:4002:b0:477:c454:fd5 with SMTP id br2-20020a056512400200b00477c4540fd5mr35479822lfb.568.1653863870155;
        Sun, 29 May 2022 15:37:50 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d8-20020ac24c88000000b0047255d211a7sm1962861lfl.214.2022.05.29.15.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 15:37:49 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v2 3/3] bpf: Inline calls to bpf_loop when callback is known
Date:   Mon, 30 May 2022 01:36:46 +0300
Message-Id: <20220529223646.862464-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529223646.862464-1-eddyz87@gmail.com>
References: <20220529223646.862464-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Calls to `bpf_loop` are replaced with direct loops to avoid
indirection. E.g. the following:

  bpf_loop(10, foo, NULL, 0);

Is replaced by equivalent of the following:

  for (int i = 0; i < 10; ++i)
    foo(i, NULL);

This transformation could be applied when:
- callback is known and does not change during program execution;
- flags passed to `bpf_loop` are always zero.

Inlining logic works as follows:

- During execution simulation function `update_loop_inline_state`
  tracks the following information for each `bpf_loop` call
  instruction:
  - is callback known and constant?
  - are flags constant and zero?
- Function `adjust_stack_depth_for_loop_inlining` increases stack
  depth for functions where `bpf_loop` calls could be inlined. This is
  needed to spill registers R6, R7 and R8. These registers are used as
  loop counter, loop maximal bound and callback context parameter;
- Function `inline_bpf_loop` called from `do_misc_fixups` replaces
  `bpf_loop` calls fit for inlining with corresponding loop
  instructions.

Measurements using `benchs/run_bench_bpf_loop.sh` inside QEMU / KVM on
i7-4710HQ CPU show a drop in latency from 14 ns/op to 2 ns/op.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  |  16 ++
 kernel/bpf/bpf_iter.c                         |   9 +-
 kernel/bpf/verifier.c                         | 184 ++++++++++++-
 .../selftests/bpf/prog_tests/bpf_loop.c       |  62 +++++
 tools/testing/selftests/bpf/progs/bpf_loop.c  | 122 +++++++++
 .../selftests/bpf/verifier/bpf_loop_inline.c  | 244 ++++++++++++++++++
 6 files changed, 628 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e8439f6cbe57..80279616a76b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -20,6 +20,8 @@
 #define BPF_MAX_VAR_SIZ	(1 << 29)
 /* size of type_str_buf in bpf_verifier. */
 #define TYPE_STR_BUF_LEN 64
+/* Maximum number of loops for bpf_loop */
+#define BPF_MAX_LOOPS	BIT(23)
 
 /* Liveness marks, used for registers and spilled-regs (in stack slots).
  * Read marks propagate upwards until they find a write mark; they record that
@@ -344,6 +346,16 @@ struct bpf_verifier_state_list {
 	int miss_cnt, hit_cnt;
 };
 
+struct bpf_loop_inline_state {
+	u32 initialized:1; /* set to true upon first entry */
+	u32 callback_is_constant:1; /* true if callback function
+				     * is the same at each call
+				     */
+	u32 flags_is_zero:1; /* true if flags register is zero at each call */
+	u32 callback_subprogno; /* valid when callback_is_constant == 1 */
+	s32 stack_base; /* stack offset for loop vars */
+};
+
 /* Possible states for alu_state member. */
 #define BPF_ALU_SANITIZE_SRC		(1U << 0)
 #define BPF_ALU_SANITIZE_DST		(1U << 1)
@@ -380,6 +392,10 @@ struct bpf_insn_aux_data {
 	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
 	bool zext_dst; /* this insn zero extends dst reg */
 	u8 alu_state; /* used in combination with alu_limit */
+	/* if instruction is a call to bpf_loop this field tracks
+	 * the state of the relevant registers to take decision about inlining
+	 */
+	struct bpf_loop_inline_state loop_inline_state;
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index d5d96ceca105..cdb898fce118 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -6,6 +6,7 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/bpf_verifier.h>
 
 struct bpf_iter_target_info {
 	struct list_head list;
@@ -723,9 +724,6 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
-/* maximum number of loops */
-#define MAX_LOOPS	BIT(23)
-
 BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
 	   u64, flags)
 {
@@ -733,9 +731,12 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
 	u64 ret;
 	u32 i;
 
+	/* note: these safety checks are also verified when bpf_loop is inlined,
+	 * be careful to modify this code in sync
+	 */
 	if (flags)
 		return -EINVAL;
-	if (nr_loops > MAX_LOOPS)
+	if (nr_loops > BPF_MAX_LOOPS)
 		return -E2BIG;
 
 	for (i = 0; i < nr_loops; i++) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aedac2ac02b9..9bae1f301f77 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7103,6 +7103,78 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 	return -ENOTSUPP;
 }
 
+static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
+{
+	return &env->insn_aux_data[env->insn_idx];
+}
+
+static bool fit_for_bpf_loop_inline(struct bpf_insn_aux_data *insn_aux)
+{
+	return insn_aux->loop_inline_state.initialized &&
+		insn_aux->loop_inline_state.flags_is_zero &&
+		insn_aux->loop_inline_state.callback_is_constant;
+}
+
+/* For all sub-programs in the program (including main) checks
+ * insn_aux_data to see if there are bpf_loop calls that require
+ * inlining. If such calls are found subprog stack_depth is increased
+ * by the size of 3 registers. Reserved space would be used in the
+ * do_misc_fixups to spill values of the R6, R7, R8 to use these
+ * registers for loop iteration.
+ */
+static void adjust_stack_depth_for_loop_inlining(struct bpf_verifier_env *env)
+{
+	int i, subprog_end, cur_subprog = 0;
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	int insn_cnt = env->prog->len;
+	bool proc_updated = false;
+	s32 stack_base;
+
+	subprog_end = (env->subprog_cnt > 1
+		       ? subprogs[cur_subprog + 1].start
+		       : insn_cnt);
+	for (i = 0; i < insn_cnt; i++) {
+		struct bpf_insn_aux_data *aux = &env->insn_aux_data[i];
+
+		if (fit_for_bpf_loop_inline(aux)) {
+			if (!proc_updated) {
+				proc_updated = true;
+				subprogs[cur_subprog].stack_depth += BPF_REG_SIZE * 3;
+				stack_base = -subprogs[cur_subprog].stack_depth;
+			}
+			aux->loop_inline_state.stack_base = stack_base;
+		}
+		if (i == subprog_end - 1) {
+			proc_updated = false;
+			cur_subprog++;
+			if (cur_subprog < env->subprog_cnt)
+				subprog_end = subprogs[cur_subprog + 1].start;
+		}
+	}
+
+	env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
+}
+
+static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
+{
+	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
+	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
+
+	int flags_is_zero =
+		register_is_const(flags_reg) && flags_reg->var_off.value == 0;
+
+	if (state->initialized) {
+		state->flags_is_zero &= flags_is_zero;
+		state->callback_is_constant &= state->callback_subprogno == subprogno;
+	} else {
+		state->initialized = 1;
+		state->callback_is_constant = 1;
+		state->flags_is_zero = flags_is_zero;
+		state->callback_subprogno = subprogno;
+	}
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -7255,6 +7327,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = check_bpf_snprintf_call(env, regs);
 		break;
 	case BPF_FUNC_loop:
+		update_loop_inline_state(env, meta.subprogno);
 		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_loop_callback_state);
 		break;
@@ -7661,11 +7734,6 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
 	return true;
 }
 
-static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
-{
-	return &env->insn_aux_data[env->insn_idx];
-}
-
 enum {
 	REASON_BOUNDS	= -1,
 	REASON_TYPE	= -2,
@@ -12920,6 +12988,22 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	return new_prog;
 }
 
+static void adjust_loop_inline_subprogno(struct bpf_verifier_env *env,
+					 u32 first_removed,
+					 u32 first_remaining)
+{
+	int delta = first_remaining - first_removed;
+
+	for (int i = 0; i < env->prog->len; ++i) {
+		struct bpf_loop_inline_state *state =
+			&env->insn_aux_data[i].loop_inline_state;
+
+		if (state->initialized &&
+		    state->callback_subprogno >= first_remaining)
+			state->callback_subprogno -= delta;
+	}
+}
+
 static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 					      u32 off, u32 cnt)
 {
@@ -12963,6 +13047,8 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 			 * in adjust_btf_func() - no need to adjust
 			 */
 		}
+
+		adjust_loop_inline_subprogno(env, i, j);
 	} else {
 		/* convert i from "first prog to remove" to "first to adjust" */
 		if (env->subprog_info[i].start == off)
@@ -13773,6 +13859,79 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
+					int position, u32 *cnt)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[position];
+	s32 stack_base = aux->loop_inline_state.stack_base;
+	s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
+	s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
+	s32 r8_offset = stack_base + 2 * BPF_REG_SIZE;
+	int reg_loop_max = BPF_REG_6;
+	int reg_loop_cnt = BPF_REG_7;
+	int reg_loop_ctx = BPF_REG_8;
+
+	struct bpf_prog *new_prog;
+	u32 callback_subprogno = aux->loop_inline_state.callback_subprogno;
+	u32 callback_start;
+	u32 call_insn_offset;
+	s32 callback_offset;
+
+	struct bpf_insn insn_buf[] = {
+		/* Return error and jump to the end of the patch if
+		 * expected number of iterations is too big.  This
+		 * repeats the check done in bpf_loop helper function,
+		 * be careful to modify this code in sync.
+		 */
+		BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2),
+		BPF_MOV32_IMM(BPF_REG_0, -E2BIG),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 16),
+		/* spill R6, R7, R8 to use these as loop vars */
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset),
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset),
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset),
+		/* initialize loop vars */
+		BPF_MOV64_REG(reg_loop_max, BPF_REG_1),
+		BPF_MOV32_IMM(reg_loop_cnt, 0),
+		BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3),
+		/* loop header,
+		 * if reg_loop_cnt >= reg_loop_max skip the loop body
+		 */
+		BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5),
+		/* callback call,
+		 * correct callback offset would be set after patching
+		 */
+		BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt),
+		BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx),
+		BPF_CALL_REL(0),
+		/* increment loop counter */
+		BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1),
+		/* jump to loop header if callback returned 0 */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -6),
+		/* return value of bpf_loop,
+		 * set R0 to the number of iterations
+		 */
+		BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt),
+		/* restore original values of R6, R7, R8 */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset),
+	};
+
+	*cnt = ARRAY_SIZE(insn_buf);
+	new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);
+	if (!new_prog)
+		return new_prog;
+
+	/* callback start is known only after patching */
+	callback_start = env->subprog_info[callback_subprogno].start;
+	call_insn_offset = position + 12;
+	callback_offset = callback_start - call_insn_offset - 1;
+	env->prog->insnsi[call_insn_offset].imm = callback_offset;
+
+	return new_prog;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -14258,6 +14417,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
+		if (insn->imm == BPF_FUNC_loop &&
+		    fit_for_bpf_loop_inline(&env->insn_aux_data[i + delta])) {
+			new_prog = inline_bpf_loop(env, i + delta, &cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
+
 patch_call_imm:
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
@@ -15030,6 +15201,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
 
+	if (ret == 0)
+		adjust_stack_depth_for_loop_inlining(env);
+
 	/* instruction rewrites happen after this point */
 	if (is_priv) {
 		if (ret == 0)
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_loop.c b/tools/testing/selftests/bpf/prog_tests/bpf_loop.c
index 380d7a2072e3..1caa495be48c 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_loop.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_loop.c
@@ -120,6 +120,64 @@ static void check_nested_calls(struct bpf_loop *skel)
 	bpf_link__destroy(link);
 }
 
+static void check_non_constant_callback(struct bpf_loop *skel)
+{
+	struct bpf_link *link =
+		bpf_program__attach(skel->progs.prog_non_constant_callback);
+
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	skel->bss->callback_selector = 0x0F;
+	usleep(1);
+	ASSERT_EQ(skel->bss->g_output, 0x0F, "g_output #1");
+
+	skel->bss->callback_selector = 0xF0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->g_output, 0xF0, "g_output #2");
+
+	bpf_link__destroy(link);
+}
+
+static void check_stack(struct bpf_loop *skel)
+{
+	struct bpf_link *link =
+		bpf_program__attach(skel->progs.stack_check);
+
+	if (!ASSERT_OK_PTR(link, "link"))
+		goto out;
+
+	int map_fd = bpf_map__fd(skel->maps.map1);
+
+	if (!ASSERT_GE(map_fd, 0, "bpf_map__fd"))
+		goto out;
+
+	for (int key = 1; key <= 16; ++key) {
+		int val = key;
+		int err = bpf_map_update_elem(map_fd, &key, &val, BPF_NOEXIST);
+
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto out;
+	}
+
+	usleep(1);
+
+	for (int key = 1; key <= 16; ++key) {
+		int val;
+		int err = bpf_map_lookup_elem(map_fd, &key, &val);
+
+		if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+			goto out;
+		ASSERT_EQ(val, key + 1, "bad value in the map");
+	}
+
+out:
+	if (map_fd >= 0)
+		close(map_fd);
+	if (link)
+		bpf_link__destroy(link);
+}
+
 void test_bpf_loop(void)
 {
 	struct bpf_loop *skel;
@@ -140,6 +198,10 @@ void test_bpf_loop(void)
 		check_invalid_flags(skel);
 	if (test__start_subtest("check_nested_calls"))
 		check_nested_calls(skel);
+	if (test__start_subtest("check_non_constant_callback"))
+		check_non_constant_callback(skel);
+	if (test__start_subtest("check_stack"))
+		check_stack(skel);
 
 	bpf_loop__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_loop.c b/tools/testing/selftests/bpf/progs/bpf_loop.c
index e08565282759..9344428a833b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_loop.c
+++ b/tools/testing/selftests/bpf/progs/bpf_loop.c
@@ -11,11 +11,19 @@ struct callback_ctx {
 	int output;
 };
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 32);
+	__type(key, int);
+	__type(value, int);
+} map1 SEC(".maps");
+
 /* These should be set by the user program */
 u32 nested_callback_nr_loops;
 u32 stop_index = -1;
 u32 nr_loops;
 int pid;
+int callback_selector;
 
 /* Making these global variables so that the userspace program
  * can verify the output through the skeleton
@@ -111,3 +119,117 @@ int prog_nested_calls(void *ctx)
 
 	return 0;
 }
+
+static int callback_set_f0(int i, void *ctx)
+{
+	g_output = 0xF0;
+	return 0;
+}
+
+static int callback_set_0f(int i, void *ctx)
+{
+	g_output = 0x0F;
+	return 0;
+}
+
+/*
+ * non-constant callback is a corner case for bpf_loop inline logic
+ */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int prog_non_constant_callback(void *ctx)
+{
+	struct callback_ctx data = {};
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	int (*callback)(int i, void *ctx);
+
+	g_output = 0;
+
+	if (callback_selector == 0x0F)
+		callback = callback_set_0f;
+	else
+		callback = callback_set_f0;
+
+	bpf_loop(1, callback, NULL, 0);
+
+	return 0;
+}
+
+static int stack_check_inner_callback(void *ctx)
+{
+	return 0;
+}
+
+static int map1_lookup_elem(int key)
+{
+	int *val = bpf_map_lookup_elem(&map1, &key);
+
+	return val ? *val : -1;
+}
+
+static void map1_update_elem(int key, int val)
+{
+	bpf_map_update_elem(&map1, &key, &val, BPF_ANY);
+}
+
+static int stack_check_outer_callback(void *ctx)
+{
+	int a = map1_lookup_elem(1);
+	int b = map1_lookup_elem(2);
+	int c = map1_lookup_elem(3);
+	int d = map1_lookup_elem(4);
+	int e = map1_lookup_elem(5);
+	int f = map1_lookup_elem(6);
+	int g = map1_lookup_elem(7);
+	int h = map1_lookup_elem(8);
+
+	bpf_loop(1, stack_check_inner_callback, NULL, 0);
+
+	map1_update_elem(1, a + 1);
+	map1_update_elem(2, b + 1);
+	map1_update_elem(3, c + 1);
+	map1_update_elem(4, d + 1);
+	map1_update_elem(5, e + 1);
+	map1_update_elem(6, f + 1);
+	map1_update_elem(7, g + 1);
+	map1_update_elem(8, h + 1);
+
+	return 0;
+}
+
+/* Some of the local variables in stack_check and
+ * stack_check_outer_callback would be allocated on stack by
+ * compiler. This test should verify that stack content for these
+ * variables is preserved between calls to bpf_loop (might be an issue
+ * if loop inlining allocates stack slots incorrectly).
+ */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int stack_check(void *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	int a = map1_lookup_elem(9);
+	int b = map1_lookup_elem(10);
+	int c = map1_lookup_elem(11);
+	int d = map1_lookup_elem(12);
+	int e = map1_lookup_elem(13);
+	int f = map1_lookup_elem(14);
+	int g = map1_lookup_elem(15);
+	int h = map1_lookup_elem(16);
+
+	bpf_loop(1, stack_check_outer_callback, NULL, 0);
+
+	map1_update_elem(9,  a + 1);
+	map1_update_elem(10, b + 1);
+	map1_update_elem(11, c + 1);
+	map1_update_elem(12, d + 1);
+	map1_update_elem(13, e + 1);
+	map1_update_elem(14, f + 1);
+	map1_update_elem(15, g + 1);
+	map1_update_elem(16, h + 1);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
new file mode 100644
index 000000000000..d1fbcfef69f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
@@ -0,0 +1,244 @@
+#define BTF_TYPES \
+	.btf_strings = "\0int\0i\0ctx\0callback\0main\0", \
+	.btf_types = { \
+	/* 1: int   */ BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4), \
+	/* 2: int*  */ BTF_PTR_ENC(1), \
+	/* 3: void* */ BTF_PTR_ENC(0), \
+	/* 4: int __(void*) */ BTF_FUNC_PROTO_ENC(1, 1), \
+		BTF_FUNC_PROTO_ARG_ENC(7, 3), \
+	/* 5: int __(int, int*) */ BTF_FUNC_PROTO_ENC(1, 2), \
+		BTF_FUNC_PROTO_ARG_ENC(5, 1), \
+		BTF_FUNC_PROTO_ARG_ENC(7, 2), \
+	/* 6: main      */ BTF_FUNC_ENC(20, 4), \
+	/* 7: callback  */ BTF_FUNC_ENC(11, 5), \
+	BTF_END_RAW \
+	}
+
+#define MAIN_TYPE	6
+#define CALLBACK_TYPE	7
+
+/* can't use BPF_CALL_REL, jit_subprogs adjusts IMM & OFF
+ * fields for pseudo calls
+ */
+#define PSEUDO_CALL_INSN() \
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, \
+		     INSN_OFF_MASK, INSN_IMM_MASK)
+
+/* can't use BPF_FUNC_loop constant,
+ * do_mix_fixups adjusts the IMM field
+ */
+#define HELPER_CALL_INSN() \
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, INSN_OFF_MASK, INSN_IMM_MASK)
+
+{
+	"inline simple bpf_loop call",
+	.insns = {
+	/* main */
+	/* force verifier state branching to verify logic on first and
+	 * subsequent bpf_loop insn processing steps
+	 */
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 777, 2),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
+
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 6),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = { PSEUDO_CALL_INSN() },
+	.unexpected_insns = { HELPER_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.runs = 0,
+	.func_info = { { 0, MAIN_TYPE }, { 12, CALLBACK_TYPE } },
+	.func_info_cnt = 2,
+	BTF_TYPES
+},
+{
+	"don't inline bpf_loop call, flags non-zero",
+	.insns = {
+	/* main */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 6),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 1),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = { HELPER_CALL_INSN() },
+	.unexpected_insns = { PSEUDO_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.runs = 0,
+	.func_info = { { 0, MAIN_TYPE }, { 8, CALLBACK_TYPE } },
+	.func_info_cnt = 2,
+	BTF_TYPES
+},
+{
+	"don't inline bpf_loop call, callback non-constant",
+	.insns = {
+	/* main */
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 777, 4), /* pick a random callback */
+
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 10),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 8),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	/* callback #2 */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = { HELPER_CALL_INSN() },
+	.unexpected_insns = { PSEUDO_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.runs = 0,
+	.func_info = {
+		{ 0, MAIN_TYPE },
+		{ 14, CALLBACK_TYPE },
+		{ 16, CALLBACK_TYPE }
+	},
+	.func_info_cnt = 3,
+	BTF_TYPES
+},
+{
+	"bpf_loop_inline and a dead func",
+	.insns = {
+	/* main */
+
+	/* A reference to callback #1 to make verifier count it as a func.
+	 * This reference is overwritten below and callback #1 is dead.
+	 */
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 9),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 8),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	/* callback #2 */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = { PSEUDO_CALL_INSN() },
+	.unexpected_insns = { HELPER_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.runs = 0,
+	.func_info = {
+		{ 0, MAIN_TYPE },
+		{ 10, CALLBACK_TYPE },
+		{ 12, CALLBACK_TYPE }
+	},
+	.func_info_cnt = 3,
+	BTF_TYPES
+},
+{
+	"bpf_loop_inline stack locations for loop vars",
+	.insns = {
+	/* main */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0x77),
+	/* bpf_loop call #1 */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 22),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	/* bpf_loop call #2 */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 16),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	/* call func and exit */
+	BPF_CALL_REL(2),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* func */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -32, 0x55),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 6),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0x77),
+	SKIP_INSNS(),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -40),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, -32),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, -24),
+	SKIP_INSNS(),
+	/* offsets are the same as in the first call */
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -40),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, -32),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, -24),
+	SKIP_INSNS(),
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -32, 0x55),
+	SKIP_INSNS(),
+	/* offsets differ from main because of different offset
+	 * in BPF_ST_MEM instruction
+	 */
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -56),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, -48),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, -40),
+	},
+	.unexpected_insns = { HELPER_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.func_info = {
+		{ 0, MAIN_TYPE },
+		{ 16, MAIN_TYPE },
+		{ 25, CALLBACK_TYPE },
+	},
+	.func_info_cnt = 3,
+	BTF_TYPES
+},
+
+#undef HELPER_CALL_INSN
+#undef PSEUDO_CALL_INSN
+#undef CALLBACK_TYPE
+#undef MAIN_TYPE
+#undef BTF_TYPES
-- 
2.25.1


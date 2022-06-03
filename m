Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF9B53CB5C
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbiFCOL4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244758AbiFCOLz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 10:11:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C52AF9
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 07:11:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a15so2038245wrh.2
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJx4VUXzUsvJKdZ7cPXGF7tCaOYRsl5lBrWov5briK8=;
        b=ZW5U0rQnIlAp0vjEzyp/te2JAdVQIhmXiGmxRCClOmDdc3b7xjf5lsEmmlxsJOUvjy
         HnaQSimXbefMzNHW+8J0PwmGY+83QWCStg6z2h5Wac8QC8PD8fwvSXdImr1cAA7UEs+K
         Wx3qHITUkDT7yU5M1eWxuRA+d5POV7zj3M86AT/ykX1ngLUEW7h6CzKLqc9TmBHJ0N1k
         0zAhLh+8IdVwkXuWETV9zaIc777sKZaL9Q8sLcp7S/gUtduxs+kdKd5Y0sFXLN56M1dR
         uiGqchIk6xR0TzLSC3uDANCrzFLCVEq63iWLdW2al9j4Z6KuLSrI/lbNAjU/zG7QmNqo
         npDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJx4VUXzUsvJKdZ7cPXGF7tCaOYRsl5lBrWov5briK8=;
        b=CoKsL1cCOghR6VBed5f0YnjQX3Ramrx4mSlh3cTeQpWstMuG0D0M5TC2QUyJu4nXBB
         AsTYF75wLM1AaiseAqiZV0t1klza2GHLOCkB1AUQWDDNz+HdE6+/D8JVOf6kK8/PRXXB
         zY97lxHz7MJI46laXnwu5GO+hFRVpL/7qv7jPkSfb/wG73qUOQKG+RQ25o8gAvNv8tnp
         NgfqCWidOimWfyWDgMk0soDd/N132f0C1/6vjd24xKfvjNdCfC4pium/xKWKradi5WLg
         sYQhhyN8eWN+HgVjEUoVnMc6TtbSks+7+/JCc76Dr5ercCoG2vjHw9+Oo8zo47CNznfY
         lv7g==
X-Gm-Message-State: AOAM530ixO6MtX7y58k7QzwVjy9LOBQbc7P4zD6W3d37w0xQjUFYZPh8
        Y1+eIbbaj0+fNh0cxWjxUQVF032oJ3y5tg==
X-Google-Smtp-Source: ABdhPJw1rKj3LW462N0X15N6XCIKno/zBQrU0IQQcL3VM3xUC849zYFyXKiSbSG9jDoCPRWHa60Vig==
X-Received: by 2002:a05:6000:1685:b0:20f:e86d:2c96 with SMTP id y5-20020a056000168500b0020fe86d2c96mr8321849wrd.587.1654265511406;
        Fri, 03 Jun 2022 07:11:51 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x8-20020adff0c8000000b00210a6bd8019sm7163633wro.8.2022.06.03.07.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 07:11:50 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v3 3/5] bpf: Inline calls to bpf_loop when callback is known
Date:   Fri,  3 Jun 2022 17:10:45 +0300
Message-Id: <20220603141047.2163170-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603141047.2163170-1-eddyz87@gmail.com>
References: <20220603141047.2163170-1-eddyz87@gmail.com>
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
 include/linux/bpf_verifier.h |  16 +++
 kernel/bpf/bpf_iter.c        |   9 +-
 kernel/bpf/verifier.c        | 199 ++++++++++++++++++++++++++++++++++-
 3 files changed, 215 insertions(+), 9 deletions(-)

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
index aedac2ac02b9..27d78fe6c3f9 100644
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
+	bool subprog_updated = false;
+	s32 stack_base;
+
+	subprog_end = (env->subprog_cnt > 1
+		       ? subprogs[cur_subprog + 1].start
+		       : insn_cnt);
+	for (i = 0; i < insn_cnt; i++) {
+		struct bpf_insn_aux_data *aux = &env->insn_aux_data[i];
+
+		if (fit_for_bpf_loop_inline(aux)) {
+			if (!subprog_updated) {
+				subprog_updated = true;
+				subprogs[cur_subprog].stack_depth += BPF_REG_SIZE * 3;
+				stack_base = -subprogs[cur_subprog].stack_depth;
+			}
+			aux->loop_inline_state.stack_base = stack_base;
+		}
+		if (i == subprog_end - 1) {
+			subprog_updated = false;
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
@@ -13773,6 +13859,94 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
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
+	struct bpf_insn insn_buf[19];
+	struct bpf_insn *next = insn_buf;
+	struct bpf_insn *call, *jump_to_end, *loop_header;
+	struct bpf_insn *jump_to_header, *loop_exit;
+
+	/* Return error and jump to the end of the patch if
+	 * expected number of iterations is too big.  This
+	 * repeats the check done in bpf_loop helper function,
+	 * be careful to modify this code in sync.
+	 */
+	(*next++) = BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
+	(*next++) = BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
+	jump_to_end = next;
+	(*next++) = BPF_JMP_IMM(BPF_JA, 0, 0, 0 /* set below */);
+	/* spill R6, R7, R8 to use these as loop vars */
+	(*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset);
+	(*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset);
+	(*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset);
+	/* initialize loop vars */
+	(*next++) = BPF_MOV64_REG(reg_loop_max, BPF_REG_1);
+	(*next++) = BPF_MOV32_IMM(reg_loop_cnt, 0);
+	(*next++) = BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3);
+	/* loop header;
+	 * if reg_loop_cnt >= reg_loop_max skip the loop body
+	 */
+	loop_header = next;
+	(*next++) = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max,
+				0 /* set below */);
+	/* callback call */
+	(*next++) = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
+	(*next++) = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
+	call = next;
+	(*next++) = BPF_CALL_REL(0 /* set below after patching */);
+	/* increment loop counter */
+	(*next++) = BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
+	/* jump to loop header if callback returned 0 */
+	jump_to_header = next;
+	(*next++) = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 0 /* set below */);
+	/* return value of bpf_loop;
+	 * set R0 to the number of iterations
+	 */
+	loop_exit = next;
+	(*next++) = BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt);
+	/* restore original values of R6, R7, R8 */
+	(*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset);
+	(*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
+	(*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
+
+	*cnt = next - insn_buf;
+	if (*cnt > ARRAY_SIZE(insn_buf)) {
+		WARN_ONCE(1, "BUG %s: 'next' exceeds bounds for 'insn_buf'\n",
+			  __func__);
+		return NULL;
+	}
+	jump_to_end->off = next - jump_to_end - 1;
+	loop_header->off = loop_exit - loop_header - 1;
+	jump_to_header->off = loop_header - jump_to_header - 1;
+
+	new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);
+	if (!new_prog)
+		return new_prog;
+
+	/* callback start is known only after patching */
+	callback_start = env->subprog_info[callback_subprogno].start;
+	call_insn_offset = position + (call - insn_buf);
+	callback_offset = callback_start - call_insn_offset - 1;
+	env->prog->insnsi[call_insn_offset].imm = callback_offset;
+
+	return new_prog;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -14258,6 +14432,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -15030,6 +15216,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
 
+	if (ret == 0)
+		adjust_stack_depth_for_loop_inlining(env);
+
 	/* instruction rewrites happen after this point */
 	if (is_priv) {
 		if (ret == 0)
-- 
2.25.1


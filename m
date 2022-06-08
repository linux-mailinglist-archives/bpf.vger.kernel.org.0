Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0932543CD4
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 21:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiFHT1o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 15:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiFHT1o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 15:27:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E56150B40
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 12:27:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x62so28414686ede.10
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 12:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Txb6dN7YkFtlvn2bZsLeVIaKIx7k7JZyPXg2oYzPjrQ=;
        b=DvjZ3wp/iH9Lqmm8sd0Zhr3x8u/ilFPIbYHU47FHoer8r8jGG1sl3un/a0DfYa0nr2
         nO5/0Icy5a+DNvAPPabl76hUBxJKrXSXn6V8EgMN2B+x1shYS2mC9ndbjCpF99f2MgCy
         o0Nx7FtSbRoaU9N5vjeWiNNNXJdLl54DOdchNrEABiWFtOpGemCfpp4KGE9Ag5ns+oWN
         l9mpy6EuDrfucFdw09SkyM8GEQ4XZZ/9ptgwYVAweP98w16WKJ7Qa2P+6VWwAkJMs7+Y
         YmgdyjByHuZOjpxJBgjSQN0lDLyJWF/Wjj5JUgTHW+8fhgM1XmQ7QrTp5p7ocg9JUc5+
         P0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Txb6dN7YkFtlvn2bZsLeVIaKIx7k7JZyPXg2oYzPjrQ=;
        b=Kd2y9HFsMFHeEO32IatC3KM6hn8/2KNI9FXZM44ujgeVigoHEehqAiumfC9+/ncTD7
         xYlmkM8jY0y063tAyrPR0U03EDWkGTvx4u5J6UF8xlITi9uliDqEgo4nqeGgyb7FKMr2
         g1+QhxaMEoScarGhnQZ1bXhR7nQvFPtT2A2CQLRXbg+EvntOCzFLbvlWjqswT/Nv8+iE
         /hP59IQfMD3pjy0npGjN5l+hS7hfxEvx2NU+97d8DOPdNfvzKAqzJicNYdgwSVECNeu7
         VaU8LetVKcbzq8UmAjL5JqWieHCovOZZCFu3WgHarN6NbACPhiJueKe6ExOEufQu2y4L
         u7fg==
X-Gm-Message-State: AOAM530OxYwV53Iobkfso4+RBRSIOjiiQWdfhBnujx55lLw/a04lw+bb
        qaVrok5fNfUYhCOHKRQ//PcnrLgVM18zvA==
X-Google-Smtp-Source: ABdhPJwXRVvhSDl5Q16DQw1PlYq/cACKZpm1J2svxuf+67tx3YSjKu9Ew4K6BVi5sDnKnYgBN7gaBg==
X-Received: by 2002:a05:6402:3546:b0:42e:2f58:2c90 with SMTP id f6-20020a056402354600b0042e2f582c90mr33990625edd.84.1654716460692;
        Wed, 08 Jun 2022 12:27:40 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906600900b006fec8e5b8a9sm9596730ejj.152.2022.06.08.12.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 12:27:40 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v4 3/5] bpf: Inline calls to bpf_loop when callback is known
Date:   Wed,  8 Jun 2022 22:26:28 +0300
Message-Id: <20220608192630.3710333-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608192630.3710333-1-eddyz87@gmail.com>
References: <20220608192630.3710333-1-eddyz87@gmail.com>
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
- Function `optimize_bpf_loop` increases stack depth for functions
  where `bpf_loop` calls can be inlined and invokes `inline_bpf_loop`
  to apply the inlining. The additional stack space is used to spill
  registers R6, R7 and R8. These registers are used as loop counter,
  loop maximal bound and callback context parameter;

Measurements using `benchs/run_bench_bpf_loop.sh` inside QEMU / KVM on
i7-4710HQ CPU show a drop in latency from 14 ns/op to 2 ns/op.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h          |   3 +
 include/linux/bpf_verifier.h |  12 +++
 kernel/bpf/bpf_iter.c        |   9 +-
 kernel/bpf/verifier.c        | 168 +++++++++++++++++++++++++++++++++--
 4 files changed, 183 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8e6092d0ea95..3c75ede138b5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1236,6 +1236,9 @@ struct bpf_array {
 #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
 #define MAX_TAIL_CALL_CNT 33
 
+/* Maximum number of loops for bpf_loop */
+#define BPF_MAX_LOOPS	BIT(23)
+
 #define BPF_F_ACCESS_MASK	(BPF_F_RDONLY |		\
 				 BPF_F_RDONLY_PROG |	\
 				 BPF_F_WRONLY |		\
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e8439f6cbe57..5df09fc46043 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -344,6 +344,14 @@ struct bpf_verifier_state_list {
 	int miss_cnt, hit_cnt;
 };
 
+struct bpf_loop_inline_state {
+	bool initialized; /* set to true upon first entry */
+	bool fit_for_inline; /* true if callback function is the same
+			      * at each call and flags are always zero
+			      */
+	u32 callback_subprogno; /* valid when fit_for_inline is true */
+};
+
 /* Possible states for alu_state member. */
 #define BPF_ALU_SANITIZE_SRC		(1U << 0)
 #define BPF_ALU_SANITIZE_DST		(1U << 1)
@@ -373,6 +381,10 @@ struct bpf_insn_aux_data {
 				u32 mem_size;	/* mem_size for non-struct typed var */
 			};
 		} btf_var;
+		/* if instruction is a call to bpf_loop this field tracks
+		 * the state of the relevant registers to make decision about inlining
+		 */
+		struct bpf_loop_inline_state loop_inline_state;
 	};
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index d5d96ceca105..7e8fd49406f6 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -723,9 +723,6 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
-/* maximum number of loops */
-#define MAX_LOOPS	BIT(23)
-
 BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
 	   u64, flags)
 {
@@ -733,9 +730,13 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
 	u64 ret;
 	u32 i;
 
+	/* Note: these safety checks are also verified when bpf_loop
+	 * is inlined, be careful to modify this code in sync. See
+	 * function verifier.c:inline_bpf_loop.
+	 */
 	if (flags)
 		return -EINVAL;
-	if (nr_loops > MAX_LOOPS)
+	if (nr_loops > BPF_MAX_LOOPS)
 		return -E2BIG;
 
 	for (i = 0; i < nr_loops; i++) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2d2872682278..81291dfa63cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7103,6 +7103,31 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 	return -ENOTSUPP;
 }
 
+static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
+{
+	return &env->insn_aux_data[env->insn_idx];
+}
+
+void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
+{
+	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
+	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
+
+	int flags_is_zero =
+		register_is_const(flags_reg) && flags_reg->var_off.value == 0;
+
+	if (state->initialized) {
+		state->fit_for_inline &=
+			flags_is_zero &&
+			state->callback_subprogno == subprogno;
+	} else {
+		state->initialized = 1;
+		state->fit_for_inline = flags_is_zero;
+		state->callback_subprogno = subprogno;
+	}
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -7255,6 +7280,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = check_bpf_snprintf_call(env, regs);
 		break;
 	case BPF_FUNC_loop:
+		update_loop_inline_state(env, meta.subprogno);
 		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_loop_callback_state);
 		break;
@@ -7661,11 +7687,6 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
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
@@ -14294,6 +14315,140 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	return 0;
 }
 
+struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
+				 int position,
+				 s32 stack_base,
+				 u32 callback_subprogno,
+				 u32 *cnt)
+{
+	s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
+	s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
+	s32 r8_offset = stack_base + 2 * BPF_REG_SIZE;
+	int reg_loop_max = BPF_REG_6;
+	int reg_loop_cnt = BPF_REG_7;
+	int reg_loop_ctx = BPF_REG_8;
+
+	struct bpf_prog *new_prog;
+	u32 callback_start;
+	u32 call_insn_offset;
+	s32 callback_offset;
+
+	/* This represents an inlined version of bpf_iter.c:bpf_loop,
+	 * be careful to modify this code in sync.
+	 */
+	struct bpf_insn insn_buf[] = {
+		/* Return error and jump to the end of the patch if
+		 * expected number of iterations is too big.
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
+	/* Note: insn_buf[12] is an offset of BPF_CALL_REL instruction */
+	call_insn_offset = position + 12;
+	callback_offset = callback_start - call_insn_offset - 1;
+	env->prog->insnsi[call_insn_offset].imm = callback_offset;
+
+	return new_prog;
+}
+
+static bool is_bpf_loop_call(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+		insn->src_reg == 0 &&
+		insn->imm == BPF_FUNC_loop;
+}
+
+/* For all sub-programs in the program (including main) check
+ * insn_aux_data to see if there are bpf_loop calls that require
+ * inlining. If such calls are found the calls are replaced with a
+ * sequence of instructions produced by `inline_bpf_loop` function and
+ * subprog stack_depth is increased by the size of 3 registers.
+ * This stack space is used to spill values of the R6, R7, R8.  These
+ * registers are used to store the loop bound, counter and context
+ * variables.
+ */
+static int optimize_bpf_loop(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	int i, cur_subprog = 0, cnt, delta = 0;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+	u16 stack_depth = subprogs[cur_subprog].stack_depth;
+	u16 stack_depth_extra = 0;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		struct bpf_loop_inline_state *inline_state =
+			&env->insn_aux_data[i + delta].loop_inline_state;
+
+		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) {
+			struct bpf_prog *new_prog;
+
+			stack_depth_extra = BPF_REG_SIZE * 3;
+			new_prog = inline_bpf_loop(env,
+						   i + delta,
+						   -(stack_depth + stack_depth_extra),
+						   inline_state->callback_subprogno,
+						   &cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta     += cnt - 1;
+			env->prog  = new_prog;
+			insn       = new_prog->insnsi + i + delta;
+		}
+
+		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
+			subprogs[cur_subprog].stack_depth += stack_depth_extra;
+			cur_subprog++;
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			stack_depth_extra = 0;
+		}
+	}
+
+	env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
+
+	return 0;
+}
+
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl, *sln;
@@ -15030,6 +15185,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
 
+	if (ret == 0)
+		optimize_bpf_loop(env);
+
 	/* instruction rewrites happen after this point */
 	if (is_priv) {
 		if (ret == 0)
-- 
2.25.1


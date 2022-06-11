Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED01547459
	for <lists+bpf@lfdr.de>; Sat, 11 Jun 2022 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiFKLmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Jun 2022 07:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiFKLmi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Jun 2022 07:42:38 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81491205C5
        for <bpf@vger.kernel.org>; Sat, 11 Jun 2022 04:42:33 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j20so1617308ljg.8
        for <bpf@vger.kernel.org>; Sat, 11 Jun 2022 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jqfB+8HaEQPVA9Cj6RobNbD04p1T+iC8Ci3+hRLH6c=;
        b=FqiM2pteq4UHP3p2W6uDvuG1SC764Z2wNGcM6anxpza7/22Mx1AYJ5NUdPISsyb9T4
         wUjyGnmv3N5ymg7m82iygz+lr6z9Wy8YoaIMjqoUfh5SFicOZze5IZwie+RfCttyJKx1
         zMZ0CeFsxvKZw6D45e+QUNE3Za51AqKJjyFEU+pnI67xMue4jNbgjGXQsbJCIn8cVoY4
         pwUhzjDN3+ZMVGgtYC3P/nBXp7410FL1DeEX4XudhIBFGIKqPtEF9kv58S9cI7hN2sRl
         bqBo0993h6ErCoSqxeoyA/m8CkrQi7A78IFVwQwKe1TrmZ7mqwTO0y6bzrSp0WuXXBwQ
         PliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jqfB+8HaEQPVA9Cj6RobNbD04p1T+iC8Ci3+hRLH6c=;
        b=rGlByCZgKILFE7wAfDh26u0aWTW6aK60O7rUo6kc1kMeOI+kE0PP4h4E/E1ydsKQ0W
         WT+pQgHHHMSJ90LTPEkTsd3D+1dmoqKXg0tVkSz8H9tgvpx/8UfPe/QTJ7bq8xjdoioW
         B+4sNxk4kLaILOb7JnSFhAi1RdvEEyal1pwB2fWuDnK30iynsMN5Yal0f5MW8/hFvr0Z
         yKUetcmfbfyI+Jhhlrich1WgtUXAvhzsGwZQ8m1k8FMWroR9B2Qom5d6LUFWFI4D27DW
         LrUXXJbdC4DY0oCXXBFB8f6j3aMmx+toROFDAD99sSLvOnTWi54Im5bp5VI0yiyozWeT
         1ORA==
X-Gm-Message-State: AOAM531Q/ZaHdQP+2OaqnBRgi2lVVfWGh5NoBW73BaryF6x9wH/RvSVT
        ae/1k1qw1AGHRfR8gGqF6CIyZYKw94aGIVLN
X-Google-Smtp-Source: ABdhPJw3JmdtxoYQFNqdmzYyy1Hf2uxBDRbxyokVzOOiM/J1TfBVsldoOAdSZogf88n8wVgFpVZUSg==
X-Received: by 2002:a2e:6e15:0:b0:255:8944:bd5b with SMTP id j21-20020a2e6e15000000b002558944bd5bmr19589097ljc.34.1654947751514;
        Sat, 11 Jun 2022 04:42:31 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u18-20020ac25bd2000000b004795d64f37dsm229303lfn.105.2022.06.11.04.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 04:42:31 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v5 3/5] bpf: Inline calls to bpf_loop when callback is known
Date:   Sat, 11 Jun 2022 14:40:19 +0300
Message-Id: <20220611114021.484408-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611114021.484408-1-eddyz87@gmail.com>
References: <20220611114021.484408-1-eddyz87@gmail.com>
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
 kernel/bpf/verifier.c        | 171 ++++++++++++++++++++++++++++++++++-
 4 files changed, 186 insertions(+), 9 deletions(-)

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
index e8439f6cbe57..5cf152b0a53e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -344,6 +344,14 @@ struct bpf_verifier_state_list {
 	int miss_cnt, hit_cnt;
 };
 
+struct bpf_loop_inline_state {
+	int initialized:1; /* set to true upon first entry */
+	int fit_for_inline:1; /* true if callback function is the same
+			       * at each call and flags are always zero
+			       */
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
index 2d2872682278..9206c73e15f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7103,6 +7103,34 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 	return -ENOTSUPP;
 }
 
+static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
+{
+	return &env->insn_aux_data[env->insn_idx];
+}
+
+static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
+{
+	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
+	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
+	int flags_is_zero =
+		register_is_const(flags_reg) && flags_reg->var_off.value == 0;
+
+	if (!state->initialized) {
+		state->initialized = 1;
+		state->fit_for_inline = flags_is_zero;
+		state->callback_subprogno = subprogno;
+		return;
+	}
+
+	if (!state->fit_for_inline)
+		return;
+
+	state->fit_for_inline =
+		flags_is_zero &&
+		state->callback_subprogno == subprogno;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -7255,6 +7283,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = check_bpf_snprintf_call(env, regs);
 		break;
 	case BPF_FUNC_loop:
+		update_loop_inline_state(env, meta.subprogno);
 		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_loop_callback_state);
 		break;
@@ -7661,11 +7690,6 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
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
@@ -14294,6 +14318,140 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
+					int position,
+					s32 stack_base,
+					u32 callback_subprogno,
+					u32 *cnt)
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
@@ -15030,6 +15188,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
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


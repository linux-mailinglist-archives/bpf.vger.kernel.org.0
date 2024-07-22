Return-Path: <bpf+bounces-35280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B742939709
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C3D1F2228D
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551AB5B1E8;
	Mon, 22 Jul 2024 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baBNT5V8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A64965D
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691550; cv=none; b=EsMbCDwp0L1jvKZtWfcfe5EUTKVWLWB0NAQQi4FIFehD0MXgEU2z18pzwAPioCW66SHx3aJVUcH5EIqyHH7ozT9PN29FE3ERUpHFrwpVqcfSFaRyLQ6bLEOLX1F5FUPANTD9vjOQnswpV5ssWC1ckQ9PrvUiy+Tm7Q6jNI2EaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691550; c=relaxed/simple;
	bh=DqGRUrPRaOIu0CNyZcqcUc5NGfvGwMrfzTuBCCqoXyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4XCK8o5cyS9NZQws0XGx/EK1xEmTfO7f9JVdMrEqTLMfr11PKFJhDRd/ukmoP1KIdGEnzMWN0c0fBjsEVUVL5gHsqT6fX+KsSDzMt4o6Hcd/Ht7gCLeihBuCKchp+RDk2o6hTISl8mVoAPytbXckYsgvYCpq1HnC9MUKLODJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baBNT5V8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d399da0b5so507538b3a.3
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721691548; x=1722296348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZFdH5VnT7q0+mKboceIOfLKFfCZ0wrXWhMhoqK4UH4=;
        b=baBNT5V8LX1umyF6Qs+8E1edAps9sXItzd7aNfz2vUDqjhBe1e/7bp1e5TKsqL9YJ2
         ryQtsHEw7wQdaqi+TVRXkn6Njcy8DFdnjZxrHLx2cNFjqPZ35KdDxgnOb1eNYZ5F1J7j
         zNoOlowwLVdiYcHuuKwYzxmvFHEcSY4c4HC+hRSrRY9zamY2lkQGS+u89iFojIa3iUlL
         6Q1kM8ZIIQzGC7UN+cuD5h2ZfWcmn/ZAqQNWPnCqcEdOPDWYw+zYEN8Z0KCbojmXmeOK
         5AkPtkEBBwULwNiuoVPYAmb0ntaaJTrdYdc68qhFcHKFj02DQV9E2lhKqF7Z5HQD37oi
         RiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721691548; x=1722296348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZFdH5VnT7q0+mKboceIOfLKFfCZ0wrXWhMhoqK4UH4=;
        b=YO8wzifcjhMGxAhR/L/WNv6bBjPKyPjkfknf2mDiaZ6vjv19GPc7Hu5x6F6hQ5aXiQ
         StPmm6vA+0R8j1eyw30ZAcsk6V98wL/+t7vUIsPfMcN7IypIj/uTRXFPUCVZXpoe/Pn+
         9uVg1bosH8mlfweuf8gWTWG3JAIWs/cALzxEx6jHxx7o4otsSLH8gXlY6EfXCzwLilZE
         6aVGobU9CSF3+NF51kkdh2cKCwqi1L5ZGYQMNK6+fqPEBSZbh9WdcKnHURKIAXgawpbF
         D6ULxuE7mJavH8R6hMSujdwtVJ7B0fzXx0TUSZsWXXuK4BLoU2VFdg2zSTFOEEBPpTVk
         G3Wg==
X-Gm-Message-State: AOJu0YwONYk0zNu0BpnJfZm7/hzEkywsMt9HzRdmrcUOGl5a/BK2y/RW
	RPjYPejKTAOF3o2x0pjCAtD4okwoiFkVhPlwW1d8Uy7yqTX7Urqs0DcjG3Y2p40=
X-Google-Smtp-Source: AGHT+IHcjDNMTuwS4RJ+QKM0RWG/adj5KnFI6PQJFdKsaIFpFda69F/uUyRFw+ZbxRYAiP1fET03Kw==
X-Received: by 2002:a05:6a00:391c:b0:70d:14d1:1bb7 with SMTP id d2e1a72fcca58-70d14d11facmr9840745b3a.28.1721691547849;
        Mon, 22 Jul 2024 16:39:07 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2707fe14sm2479500b3a.163.2024.07.22.16.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:39:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v4 02/10] bpf: no_caller_saved_registers attribute for helper calls
Date: Mon, 22 Jul 2024 16:38:36 -0700
Message-ID: <20240722233844.1406874-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC and LLVM define a no_caller_saved_registers function attribute.
This attribute means that function scratches only some of
the caller saved registers defined by ABI.
For BPF the set of such registers could be defined as follows:
- R0 is scratched only if function is non-void;
- R1-R5 are scratched only if corresponding parameter type is defined
  in the function prototype.

This commit introduces flag bpf_func_prot->allow_nocsr.
If this flag is set for some helper function, verifier assumes that
it follows no_caller_saved_registers calling convention.

The contract between kernel and clang allows to simultaneously use
such functions and maintain backwards compatibility with old
kernels that don't understand no_caller_saved_registers calls
(nocsr for short):

- clang generates a simple pattern for nocsr calls, e.g.:

    r1 = 1;
    r2 = 2;
    *(u64 *)(r10 - 8)  = r1;
    *(u64 *)(r10 - 16) = r2;
    call %[to_be_inlined]
    r2 = *(u64 *)(r10 - 16);
    r1 = *(u64 *)(r10 - 8);
    r0 = r1;
    r0 += r2;
    exit;

- kernel removes unnecessary spills and fills, if called function is
  inlined by verifier or current JIT (with assumption that patch
  inserted by verifier or JIT honors nocsr contract, e.g. does not
  scratch r3-r5 for the example above), e.g. the code above would be
  transformed to:

    r1 = 1;
    r2 = 2;
    call %[to_be_inlined]
    r0 = r1;
    r0 += r2;
    exit;

Technically, the transformation is split into the following phases:
- function mark_nocsr_patterns(), called from bpf_check()
  searches and marks potential patterns in instruction auxiliary data;
- upon stack read or write access,
  function check_nocsr_stack_contract() is used to verify if
  stack offsets, presumably reserved for nocsr patterns, are used
  only from those patterns;
- function remove_nocsr_spills_fills(), called from bpf_check(),
  applies the rewrite for valid patterns.

See comment in mark_nocsr_pattern_for_call() for more details.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h          |   6 +
 include/linux/bpf_verifier.h |  14 ++
 kernel/bpf/verifier.c        | 317 ++++++++++++++++++++++++++++++++++-
 3 files changed, 334 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f1d4a97b9d1..7640ab047188 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -807,6 +807,12 @@ struct bpf_func_proto {
 	bool gpl_only;
 	bool pkt_access;
 	bool might_sleep;
+	/* set to true if helper follows contract for gcc/llvm
+	 * attribute no_caller_saved_registers:
+	 * - void functions do not scratch r0
+	 * - functions taking N arguments scratch only registers r1-rN
+	 */
+	bool allow_nocsr;
 	enum bpf_return_type ret_type;
 	union {
 		struct {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 731a0a4ac13c..5cea15c81b8a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -576,6 +576,14 @@ struct bpf_insn_aux_data {
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	u8 alu_state; /* used in combination with alu_limit */
+	/* true if STX or LDX instruction is a part of a spill/fill
+	 * pattern for a no_caller_saved_registers call.
+	 */
+	u8 nocsr_pattern:1;
+	/* for CALL instructions, a number of spill/fill pairs in the
+	 * no_caller_saved_registers pattern.
+	 */
+	u8 nocsr_spills_num:3;
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
@@ -645,6 +653,10 @@ struct bpf_subprog_info {
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
+	/* offsets in range [stack_depth .. nocsr_stack_off)
+	 * are used for no_caller_saved_registers spills and fills.
+	 */
+	s16 nocsr_stack_off;
 	bool has_tail_call: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
@@ -652,6 +664,8 @@ struct bpf_subprog_info {
 	bool is_async_cb: 1;
 	bool is_exception_cb: 1;
 	bool args_cached: 1;
+	/* true if nocsr stack region is used by functions that can't be inlined */
+	bool keep_nocsr_stack: 1;
 
 	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a799b97634c9..1b2845eca539 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4522,6 +4522,31 @@ static int get_reg_width(struct bpf_reg_state *reg)
 	return fls64(reg->umax_value);
 }
 
+/* See comment for mark_nocsr_pattern_for_call() */
+static void check_nocsr_stack_contract(struct bpf_verifier_env *env, struct bpf_func_state *state,
+				       int insn_idx, int off)
+{
+	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int i;
+
+	if (subprog->nocsr_stack_off <= off || aux[insn_idx].nocsr_pattern)
+		return;
+	/* access to the region [max_stack_depth .. nocsr_stack_off)
+	 * from something that is not a part of the nocsr pattern,
+	 * disable nocsr rewrites for current subprogram by setting
+	 * nocsr_stack_off to a value smaller than any possible offset.
+	 */
+	subprog->nocsr_stack_off = S16_MIN;
+	/* reset nocsr aux flags within subprogram,
+	 * happens at most once per subprogram
+	 */
+	for (i = subprog->start; i < (subprog + 1)->start; ++i) {
+		aux[i].nocsr_spills_num = 0;
+		aux[i].nocsr_pattern = 0;
+	}
+}
+
 /* check_stack_{read,write}_fixed_off functions track spill/fill of registers,
  * stack boundary and alignment are checked in check_mem_access()
  */
@@ -4570,6 +4595,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
+	check_nocsr_stack_contract(env, state, insn_idx, off);
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
 		bool reg_value_fits;
@@ -4704,6 +4730,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 			return err;
 	}
 
+	check_nocsr_stack_contract(env, state, insn_idx, min_off);
 	/* Variable offset writes destroy any spilled pointers in range. */
 	for (i = min_off; i < max_off; i++) {
 		u8 new_type, *stype;
@@ -4842,6 +4869,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	reg = &reg_state->stack[spi].spilled_ptr;
 
 	mark_stack_slot_scratched(env, spi);
+	check_nocsr_stack_contract(env, state, env->insn_idx, off);
 
 	if (is_spilled_reg(&reg_state->stack[spi])) {
 		u8 spill_size = 1;
@@ -5002,6 +5030,7 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
 	min_off = reg->smin_value + off;
 	max_off = reg->smax_value + off;
 	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
+	check_nocsr_stack_contract(env, ptr_state, env->insn_idx, min_off);
 	return 0;
 }
 
@@ -6712,10 +6741,20 @@ static int check_stack_slot_within_bounds(struct bpf_verifier_env *env,
                                           struct bpf_func_state *state,
                                           enum bpf_access_type t)
 {
-	int min_valid_off;
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
+	int min_valid_off, max_bpf_stack;
+
+	/* If accessing instruction is a spill/fill from nocsr pattern,
+	 * add room for all caller saved registers below MAX_BPF_STACK.
+	 * In case if nocsr rewrite won't happen maximal stack depth
+	 * would be checked by check_max_stack_depth_subprog().
+	 */
+	max_bpf_stack = MAX_BPF_STACK;
+	if (aux->nocsr_pattern)
+		max_bpf_stack += CALLER_SAVED_REGS * BPF_REG_SIZE;
 
 	if (t == BPF_WRITE || env->allow_uninit_stack)
-		min_valid_off = -MAX_BPF_STACK;
+		min_valid_off = -max_bpf_stack;
 	else
 		min_valid_off = -state->allocated_stack;
 
@@ -15974,6 +16013,232 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 	return ret;
 }
 
+/* Bitmask with 1s for all caller saved registers */
+#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
+
+/* Return a bitmask specifying which caller saved registers are
+ * clobbered by a call to a helper *as if* this helper follows
+ * no_caller_saved_registers contract:
+ * - includes R0 if function is non-void;
+ * - includes R1-R5 if corresponding parameter has is described
+ *   in the function prototype.
+ */
+static u32 helper_nocsr_clobber_mask(const struct bpf_func_proto *fn)
+{
+	u8 mask;
+	int i;
+
+	mask = 0;
+	if (fn->ret_type != RET_VOID)
+		mask |= BIT(BPF_REG_0);
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); ++i)
+		if (fn->arg_type[i] != ARG_DONTCARE)
+			mask |= BIT(BPF_REG_1 + i);
+	return mask;
+}
+
+/* True if do_misc_fixups() replaces calls to helper number 'imm',
+ * replacement patch is presumed to follow no_caller_saved_registers contract
+ * (see mark_nocsr_pattern_for_call() below).
+ */
+static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
+{
+	return false;
+}
+
+/* GCC and LLVM define a no_caller_saved_registers function attribute.
+ * This attribute means that function scratches only some of
+ * the caller saved registers defined by ABI.
+ * For BPF the set of such registers could be defined as follows:
+ * - R0 is scratched only if function is non-void;
+ * - R1-R5 are scratched only if corresponding parameter type is defined
+ *   in the function prototype.
+ *
+ * The contract between kernel and clang allows to simultaneously use
+ * such functions and maintain backwards compatibility with old
+ * kernels that don't understand no_caller_saved_registers calls
+ * (nocsr for short):
+ *
+ * - for nocsr calls clang allocates registers as-if relevant r0-r5
+ *   registers are not scratched by the call;
+ *
+ * - as a post-processing step, clang visits each nocsr call and adds
+ *   spill/fill for every live r0-r5;
+ *
+ * - stack offsets used for the spill/fill are allocated as lowest
+ *   stack offsets in whole function and are not used for any other
+ *   purposes;
+ *
+ * - when kernel loads a program, it looks for such patterns
+ *   (nocsr function surrounded by spills/fills) and checks if
+ *   spill/fill stack offsets are used exclusively in nocsr patterns;
+ *
+ * - if so, and if verifier or current JIT inlines the call to the
+ *   nocsr function (e.g. a helper call), kernel removes unnecessary
+ *   spill/fill pairs;
+ *
+ * - when old kernel loads a program, presence of spill/fill pairs
+ *   keeps BPF program valid, albeit slightly less efficient.
+ *
+ * For example:
+ *
+ *   r1 = 1;
+ *   r2 = 2;
+ *   *(u64 *)(r10 - 8)  = r1;            r1 = 1;
+ *   *(u64 *)(r10 - 16) = r2;            r2 = 2;
+ *   call %[to_be_inlined]         -->   call %[to_be_inlined]
+ *   r2 = *(u64 *)(r10 - 16);            r0 = r1;
+ *   r1 = *(u64 *)(r10 - 8);             r0 += r2;
+ *   r0 = r1;                            exit;
+ *   r0 += r2;
+ *   exit;
+ *
+ * The purpose of mark_nocsr_pattern_for_call is to:
+ * - look for such patterns;
+ * - mark spill and fill instructions in env->insn_aux_data[*].nocsr_pattern;
+ * - mark set env->insn_aux_data[*].nocsr_spills_num for call instruction;
+ * - update env->subprog_info[*]->nocsr_stack_off to find an offset
+ *   at which nocsr spill/fill stack slots start;
+ * - update env->subprog_info[*]->keep_nocsr_stack.
+ *
+ * The .nocsr_pattern and .nocsr_stack_off are used by
+ * check_nocsr_stack_contract() to check if every stack access to
+ * nocsr spill/fill stack slot originates from spill/fill
+ * instructions, members of nocsr patterns.
+ *
+ * If such condition holds true for a subprogram, nocsr patterns could
+ * be rewritten by remove_nocsr_spills_fills().
+ * Otherwise nocsr patterns are not changed in the subprogram
+ * (code, presumably, generated by an older clang version).
+ *
+ * For example, it is *not* safe to remove spill/fill below:
+ *
+ *   r1 = 1;
+ *   *(u64 *)(r10 - 8)  = r1;            r1 = 1;
+ *   call %[to_be_inlined]         -->   call %[to_be_inlined]
+ *   r1 = *(u64 *)(r10 - 8);             r0 = *(u64 *)(r10 - 8);  <---- wrong !!!
+ *   r0 = *(u64 *)(r10 - 8);             r0 += r1;
+ *   r0 += r1;                           exit;
+ *   exit;
+ */
+static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env,
+					struct bpf_subprog_info *subprog,
+					int insn_idx, s16 lowest_off)
+{
+	struct bpf_insn *insns = env->prog->insnsi, *stx, *ldx;
+	struct bpf_insn *call = &env->prog->insnsi[insn_idx];
+	const struct bpf_func_proto *fn;
+	u32 clobbered_regs_mask = ALL_CALLER_SAVED_REGS;
+	u32 expected_regs_mask;
+	bool can_be_inlined = false;
+	s16 off;
+	int i;
+
+	if (bpf_helper_call(call)) {
+		if (get_helper_proto(env, call->imm, &fn) < 0)
+			/* error would be reported later */
+			return;
+		clobbered_regs_mask = helper_nocsr_clobber_mask(fn);
+		can_be_inlined = fn->allow_nocsr &&
+				 (verifier_inlines_helper_call(env, call->imm) ||
+				  bpf_jit_inlines_helper_call(call->imm));
+	}
+
+	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
+		return;
+
+	/* e.g. if helper call clobbers r{0,1}, expect r{2,3,4,5} in the pattern */
+	expected_regs_mask = ~clobbered_regs_mask & ALL_CALLER_SAVED_REGS;
+
+	/* match pairs of form:
+	 *
+	 * *(u64 *)(r10 - Y) = rX   (where Y % 8 == 0)
+	 * ...
+	 * call %[to_be_inlined]
+	 * ...
+	 * rX = *(u64 *)(r10 - Y)
+	 */
+	for (i = 1, off = lowest_off; i <= ARRAY_SIZE(caller_saved); ++i, off += BPF_REG_SIZE) {
+		if (insn_idx - i < 0 || insn_idx + i >= env->prog->len)
+			break;
+		stx = &insns[insn_idx - i];
+		ldx = &insns[insn_idx + i];
+		/* must be a stack spill/fill pair */
+		if (stx->code != (BPF_STX | BPF_MEM | BPF_DW) ||
+		    ldx->code != (BPF_LDX | BPF_MEM | BPF_DW) ||
+		    stx->dst_reg != BPF_REG_10 ||
+		    ldx->src_reg != BPF_REG_10)
+			break;
+		/* must be a spill/fill for the same reg */
+		if (stx->src_reg != ldx->dst_reg)
+			break;
+		/* must be one of the previously unseen registers */
+		if ((BIT(stx->src_reg) & expected_regs_mask) == 0)
+			break;
+		/* must be a spill/fill for the same expected offset,
+		 * no need to check offset alignment, BPF_DW stack access
+		 * is always 8-byte aligned.
+		 */
+		if (stx->off != off || ldx->off != off)
+			break;
+		expected_regs_mask &= ~BIT(stx->src_reg);
+		env->insn_aux_data[insn_idx - i].nocsr_pattern = 1;
+		env->insn_aux_data[insn_idx + i].nocsr_pattern = 1;
+	}
+	if (i == 1)
+		return;
+
+	/* Conditionally set 'nocsr_spills_num' to allow forward
+	 * compatibility when more helper functions are marked as
+	 * nocsr at compile time than current kernel supports, e.g:
+	 *
+	 *   1: *(u64 *)(r10 - 8) = r1
+	 *   2: call A                  ;; assume A is nocsr for current kernel
+	 *   3: r1 = *(u64 *)(r10 - 8)
+	 *   4: *(u64 *)(r10 - 8) = r1
+	 *   5: call B                  ;; assume B is not nocsr for current kernel
+	 *   6: r1 = *(u64 *)(r10 - 8)
+	 *
+	 * There is no need to block nocsr rewrite for such program.
+	 * Set 'nocsr_pattern' for both calls to keep check_nocsr_stack_contract() happy,
+	 * don't set 'nocsr_spills_num' for call B so that remove_nocsr_spills_fills()
+	 * does not remove spill/fill pair {4,6}.
+	 */
+	if (can_be_inlined)
+		env->insn_aux_data[insn_idx].nocsr_spills_num = i - 1;
+	else
+		subprog->keep_nocsr_stack = 1;
+	subprog->nocsr_stack_off = min(subprog->nocsr_stack_off, off);
+}
+
+static int mark_nocsr_patterns(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprog = env->subprog_info;
+	struct bpf_insn *insn;
+	s16 lowest_off;
+	int s, i;
+
+	for (s = 0; s < env->subprog_cnt; ++s, ++subprog) {
+		/* find lowest stack spill offset used in this subprog */
+		lowest_off = 0;
+		for (i = subprog->start; i < (subprog + 1)->start; ++i) {
+			insn = env->prog->insnsi + i;
+			if (insn->code != (BPF_STX | BPF_MEM | BPF_DW) ||
+			    insn->dst_reg != BPF_REG_10)
+				continue;
+			lowest_off = min(lowest_off, insn->off);
+		}
+		/* use this offset to find nocsr patterns */
+		for (i = subprog->start; i < (subprog + 1)->start; ++i) {
+			insn = env->prog->insnsi + i;
+			if (insn->code != (BPF_JMP | BPF_CALL))
+				continue;
+			mark_nocsr_pattern_for_call(env, subprog, i, lowest_off);
+		}
+	}
+	return 0;
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -19122,9 +19387,11 @@ static int opt_remove_dead_code(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static const struct bpf_insn NOP = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+
 static int opt_remove_nops(struct bpf_verifier_env *env)
 {
-	const struct bpf_insn ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+	const struct bpf_insn ja = NOP;
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	int i, err;
@@ -20870,6 +21137,40 @@ static int optimize_bpf_loop(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/* Remove unnecessary spill/fill pairs, members of nocsr pattern,
+ * adjust subprograms stack depth when possible.
+ */
+static int remove_nocsr_spills_fills(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprog = env->subprog_info;
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+	u32 spills_num;
+	bool modified = false;
+	int i, j;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (aux[i].nocsr_spills_num > 0) {
+			spills_num = aux[i].nocsr_spills_num;
+			/* NOPs would be removed by opt_remove_nops() */
+			for (j = 1; j <= spills_num; ++j) {
+				*(insn - j) = NOP;
+				*(insn + j) = NOP;
+			}
+			modified = true;
+		}
+		if ((subprog + 1)->start == i + 1) {
+			if (modified && !subprog->keep_nocsr_stack)
+				subprog->stack_depth = -subprog->nocsr_stack_off;
+			subprog++;
+			modified = false;
+		}
+	}
+
+	return 0;
+}
+
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl, *sln;
@@ -21772,6 +22073,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = mark_nocsr_patterns(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = do_check_main(env);
 	ret = ret ?: do_check_subprogs(env);
 
@@ -21781,6 +22086,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 skip_full_check:
 	kvfree(env->explored_states);
 
+	/* might decrease stack depth, keep it before passes that
+	 * allocate additional slots.
+	 */
+	if (ret == 0)
+		ret = remove_nocsr_spills_fills(env);
+
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
 
-- 
2.45.2



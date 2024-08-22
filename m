Return-Path: <bpf+bounces-37834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0F95B0B9
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B051C22C85
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C2171088;
	Thu, 22 Aug 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhROKeS7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAFE16D4EF
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316092; cv=none; b=NoSadHSzQ16JZYuwxqKTuTyvQc5xWFAuch3YW68GDQbhGcFTdZPqf0nXLfbsSD0ZfhLgW6MVoERhS8yuzRoZ4jS011TQe+5xZG77iYYd6EBfYlExjwR9uo+ylHPv+X5ZuSsxNDTuu7xp6uKgFaplLJrxsxxphSizfe7Ky5CKm8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316092; c=relaxed/simple;
	bh=rS41QssJvEE6T6iwFs/Juv4ViM5z0cgFGuY7+BRm27I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssE/CdFSR2+EoWxqNZJA0B5PsthkxVoTmH6f5vhAsFL3lEBSA1hOTawT4XXxPseFano0VxCbLmrHYJWTIFkjxgmbav2j1TSL+YyBpGE3PvHuM0WaGkRlGF+ouFIMjo+2p9/lz9hm8lSrLt2XrP0VWxAItpVPj2Wq6bybTmYR+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhROKeS7; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-27051f63018so331806fac.3
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724316089; x=1724920889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqyi4HV9gkoWxB0/SsFiubHnJXBJnZD+pNJohc7bIHk=;
        b=DhROKeS7SHGcoKK7qbjDhomyDlf1LpZLJEn84OFDuqeMLKD48kkdxvQGgustoIv1or
         iNaJpxmTgMuPNuog7gCsEcQX4qseaDPgY88YSvqto+T/Km6CGE7DS3er8eSKQVQbYs9c
         Z7JOzZgwTYdYMkoUQ5wImY3VLIhu+eg7xI5Jg5DSG23Q1Utm+NYXYnCaH9K3Z64Af9Q8
         AX4KzxlZ/Oi8GTi4GiM7kHQThXUXzEqlOLp64lK7Wy5ApB2pEGxJ0pEFuaGgCGHWO0gE
         Rdq3Hm3kWCOvPhyjF39bk4+Yu4VB7I/yl6CLLhYm2Z8nJl+fX8u4w04JoosgunmW/Tuv
         dkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316089; x=1724920889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqyi4HV9gkoWxB0/SsFiubHnJXBJnZD+pNJohc7bIHk=;
        b=LYvLN2BnMZEdhokjRuKhMz77+4GuzDl5G+9ug+46IGM8wuQtR1dsV03f+Ev82mGPvm
         5ug3rzqECFrZXB50liLDKWydgm95EnpBlDORLMsOi2Kbo7Ckk8/KiOMu6lhI7OFNMHeF
         x1Hl8n3idkjxvTRAcY1kYEjQdOGU/SZw4T0tD6Sn5piqcnuaeMF0D9Nc2GpCI8Wl8C6X
         UtCBUDWtXmGvQ40dkDzmDortCLIVStkz8q6p9tCg16gkqGXzl4gODVxdBjxSywV0UjHQ
         HpKa6v/VHH47tEKMC+dbz3/zNmteMGHEg/xDiM3lha1i8vIkYp2SEVOj5MPWwnV7MrlH
         6biw==
X-Gm-Message-State: AOJu0YzFrsRG/ylEs9PcDpm2lCAKB/RGSViBTtxWpouzGAzh3pwRrp5L
	6dKXP8dvK7dPKAU7VURi0hOuCzYgTbiFvQKyybZp0hiDCJHtNdnQYVhQMGyR
X-Google-Smtp-Source: AGHT+IE3dZNSMQv6HTcAEvm8oQKUj84CzaS49duvxlg+bKdGwe4zXOC3szXHoET/Mqakc+G78ncDJA==
X-Received: by 2002:a05:6871:7419:b0:260:ebf7:d0e7 with SMTP id 586e51a60fabf-273cfc09e56mr1546135fac.15.1724316089009;
        Thu, 22 Aug 2024 01:41:29 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434340449sm881692b3a.218.2024.08.22.01.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:41:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 1/6] bpf: rename nocsr -> bpf_fastcall in verifier
Date: Thu, 22 Aug 2024 01:41:07 -0700
Message-ID: <20240822084112.3257995-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822084112.3257995-1-eddyz87@gmail.com>
References: <20240822084112.3257995-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attribute used by LLVM implementation of the feature had been changed
from no_caller_saved_registers to bpf_fastcall (see [1]).
This commit replaces references to nocsr by references to bpf_fastcall
to keep LLVM and Kernel parts in sync.

[1] https://github.com/llvm/llvm-project/pull/105417

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h          |   6 +-
 include/linux/bpf_verifier.h |  18 ++---
 kernel/bpf/helpers.c         |   2 +-
 kernel/bpf/verifier.c        | 143 +++++++++++++++++------------------
 4 files changed, 84 insertions(+), 85 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f0192c173ed8..00dc4dd28cbd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -808,12 +808,12 @@ struct bpf_func_proto {
 	bool gpl_only;
 	bool pkt_access;
 	bool might_sleep;
-	/* set to true if helper follows contract for gcc/llvm
-	 * attribute no_caller_saved_registers:
+	/* set to true if helper follows contract for llvm
+	 * attribute bpf_fastcall:
 	 * - void functions do not scratch r0
 	 * - functions taking N arguments scratch only registers r1-rN
 	 */
-	bool allow_nocsr;
+	bool allow_fastcall;
 	enum bpf_return_type ret_type;
 	union {
 		struct {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5cea15c81b8a..634a302a39e3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -577,13 +577,13 @@ struct bpf_insn_aux_data {
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
-	 * pattern for a no_caller_saved_registers call.
+	 * pattern for a bpf_fastcall call.
 	 */
-	u8 nocsr_pattern:1;
+	u8 fastcall_pattern:1;
 	/* for CALL instructions, a number of spill/fill pairs in the
-	 * no_caller_saved_registers pattern.
+	 * bpf_fastcall pattern.
 	 */
-	u8 nocsr_spills_num:3;
+	u8 fastcall_spills_num:3;
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
@@ -653,10 +653,10 @@ struct bpf_subprog_info {
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
-	/* offsets in range [stack_depth .. nocsr_stack_off)
-	 * are used for no_caller_saved_registers spills and fills.
+	/* offsets in range [stack_depth .. fastcall_stack_off)
+	 * are used for bpf_fastcall spills and fills.
 	 */
-	s16 nocsr_stack_off;
+	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
@@ -664,8 +664,8 @@ struct bpf_subprog_info {
 	bool is_async_cb: 1;
 	bool is_exception_cb: 1;
 	bool args_cached: 1;
-	/* true if nocsr stack region is used by functions that can't be inlined */
-	bool keep_nocsr_stack: 1;
+	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
+	bool keep_fastcall_stack: 1;
 
 	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 12e3aa40b180..369f3d2d1a1d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -158,7 +158,7 @@ const struct bpf_func_proto bpf_get_smp_processor_id_proto = {
 	.func		= bpf_get_smp_processor_id,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.allow_nocsr	= true,
+	.allow_fastcall	= true,
 };
 
 BPF_CALL_0(bpf_get_numa_node_id)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 920d7c5fe944..0dfd91f36417 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4579,28 +4579,28 @@ static int get_reg_width(struct bpf_reg_state *reg)
 	return fls64(reg->umax_value);
 }
 
-/* See comment for mark_nocsr_pattern_for_call() */
-static void check_nocsr_stack_contract(struct bpf_verifier_env *env, struct bpf_func_state *state,
-				       int insn_idx, int off)
+/* See comment for mark_fastcall_pattern_for_call() */
+static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
+					  struct bpf_func_state *state, int insn_idx, int off)
 {
 	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	int i;
 
-	if (subprog->nocsr_stack_off <= off || aux[insn_idx].nocsr_pattern)
+	if (subprog->fastcall_stack_off <= off || aux[insn_idx].fastcall_pattern)
 		return;
-	/* access to the region [max_stack_depth .. nocsr_stack_off)
-	 * from something that is not a part of the nocsr pattern,
-	 * disable nocsr rewrites for current subprogram by setting
-	 * nocsr_stack_off to a value smaller than any possible offset.
+	/* access to the region [max_stack_depth .. fastcall_stack_off)
+	 * from something that is not a part of the fastcall pattern,
+	 * disable fastcall rewrites for current subprogram by setting
+	 * fastcall_stack_off to a value smaller than any possible offset.
 	 */
-	subprog->nocsr_stack_off = S16_MIN;
-	/* reset nocsr aux flags within subprogram,
+	subprog->fastcall_stack_off = S16_MIN;
+	/* reset fastcall aux flags within subprogram,
 	 * happens at most once per subprogram
 	 */
 	for (i = subprog->start; i < (subprog + 1)->start; ++i) {
-		aux[i].nocsr_spills_num = 0;
-		aux[i].nocsr_pattern = 0;
+		aux[i].fastcall_spills_num = 0;
+		aux[i].fastcall_pattern = 0;
 	}
 }
 
@@ -4652,7 +4652,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	check_nocsr_stack_contract(env, state, insn_idx, off);
+	check_fastcall_stack_contract(env, state, insn_idx, off);
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
 		bool reg_value_fits;
@@ -4787,7 +4787,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 			return err;
 	}
 
-	check_nocsr_stack_contract(env, state, insn_idx, min_off);
+	check_fastcall_stack_contract(env, state, insn_idx, min_off);
 	/* Variable offset writes destroy any spilled pointers in range. */
 	for (i = min_off; i < max_off; i++) {
 		u8 new_type, *stype;
@@ -4926,7 +4926,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	reg = &reg_state->stack[spi].spilled_ptr;
 
 	mark_stack_slot_scratched(env, spi);
-	check_nocsr_stack_contract(env, state, env->insn_idx, off);
+	check_fastcall_stack_contract(env, state, env->insn_idx, off);
 
 	if (is_spilled_reg(&reg_state->stack[spi])) {
 		u8 spill_size = 1;
@@ -5087,7 +5087,7 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
 	min_off = reg->smin_value + off;
 	max_off = reg->smax_value + off;
 	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
-	check_nocsr_stack_contract(env, ptr_state, env->insn_idx, min_off);
+	check_fastcall_stack_contract(env, ptr_state, env->insn_idx, min_off);
 	return 0;
 }
 
@@ -6804,13 +6804,13 @@ static int check_stack_slot_within_bounds(struct bpf_verifier_env *env,
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
 	int min_valid_off, max_bpf_stack;
 
-	/* If accessing instruction is a spill/fill from nocsr pattern,
+	/* If accessing instruction is a spill/fill from bpf_fastcall pattern,
 	 * add room for all caller saved registers below MAX_BPF_STACK.
-	 * In case if nocsr rewrite won't happen maximal stack depth
+	 * In case if bpf_fastcall rewrite won't happen maximal stack depth
 	 * would be checked by check_max_stack_depth_subprog().
 	 */
 	max_bpf_stack = MAX_BPF_STACK;
-	if (aux->nocsr_pattern)
+	if (aux->fastcall_pattern)
 		max_bpf_stack += CALLER_SAVED_REGS * BPF_REG_SIZE;
 
 	if (t == BPF_WRITE || env->allow_uninit_stack)
@@ -16118,12 +16118,12 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 
 /* Return a bitmask specifying which caller saved registers are
  * clobbered by a call to a helper *as if* this helper follows
- * no_caller_saved_registers contract:
+ * bpf_fastcall contract:
  * - includes R0 if function is non-void;
  * - includes R1-R5 if corresponding parameter has is described
  *   in the function prototype.
  */
-static u32 helper_nocsr_clobber_mask(const struct bpf_func_proto *fn)
+static u32 helper_fastcall_clobber_mask(const struct bpf_func_proto *fn)
 {
 	u8 mask;
 	int i;
@@ -16138,8 +16138,8 @@ static u32 helper_nocsr_clobber_mask(const struct bpf_func_proto *fn)
 }
 
 /* True if do_misc_fixups() replaces calls to helper number 'imm',
- * replacement patch is presumed to follow no_caller_saved_registers contract
- * (see mark_nocsr_pattern_for_call() below).
+ * replacement patch is presumed to follow bpf_fastcall contract
+ * (see mark_fastcall_pattern_for_call() below).
  */
 static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 {
@@ -16153,7 +16153,7 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
-/* GCC and LLVM define a no_caller_saved_registers function attribute.
+/* LLVM define a bpf_fastcall function attribute.
  * This attribute means that function scratches only some of
  * the caller saved registers defined by ABI.
  * For BPF the set of such registers could be defined as follows:
@@ -16163,13 +16163,12 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
  *
  * The contract between kernel and clang allows to simultaneously use
  * such functions and maintain backwards compatibility with old
- * kernels that don't understand no_caller_saved_registers calls
- * (nocsr for short):
+ * kernels that don't understand bpf_fastcall calls:
  *
- * - for nocsr calls clang allocates registers as-if relevant r0-r5
+ * - for bpf_fastcall calls clang allocates registers as-if relevant r0-r5
  *   registers are not scratched by the call;
  *
- * - as a post-processing step, clang visits each nocsr call and adds
+ * - as a post-processing step, clang visits each bpf_fastcall call and adds
  *   spill/fill for every live r0-r5;
  *
  * - stack offsets used for the spill/fill are allocated as lowest
@@ -16177,11 +16176,11 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
  *   purposes;
  *
  * - when kernel loads a program, it looks for such patterns
- *   (nocsr function surrounded by spills/fills) and checks if
- *   spill/fill stack offsets are used exclusively in nocsr patterns;
+ *   (bpf_fastcall function surrounded by spills/fills) and checks if
+ *   spill/fill stack offsets are used exclusively in fastcall patterns;
  *
  * - if so, and if verifier or current JIT inlines the call to the
- *   nocsr function (e.g. a helper call), kernel removes unnecessary
+ *   bpf_fastcall function (e.g. a helper call), kernel removes unnecessary
  *   spill/fill pairs;
  *
  * - when old kernel loads a program, presence of spill/fill pairs
@@ -16200,22 +16199,22 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
  *   r0 += r2;
  *   exit;
  *
- * The purpose of mark_nocsr_pattern_for_call is to:
+ * The purpose of mark_fastcall_pattern_for_call is to:
  * - look for such patterns;
- * - mark spill and fill instructions in env->insn_aux_data[*].nocsr_pattern;
- * - mark set env->insn_aux_data[*].nocsr_spills_num for call instruction;
- * - update env->subprog_info[*]->nocsr_stack_off to find an offset
- *   at which nocsr spill/fill stack slots start;
- * - update env->subprog_info[*]->keep_nocsr_stack.
+ * - mark spill and fill instructions in env->insn_aux_data[*].fastcall_pattern;
+ * - mark set env->insn_aux_data[*].fastcall_spills_num for call instruction;
+ * - update env->subprog_info[*]->fastcall_stack_off to find an offset
+ *   at which bpf_fastcall spill/fill stack slots start;
+ * - update env->subprog_info[*]->keep_fastcall_stack.
  *
- * The .nocsr_pattern and .nocsr_stack_off are used by
- * check_nocsr_stack_contract() to check if every stack access to
- * nocsr spill/fill stack slot originates from spill/fill
- * instructions, members of nocsr patterns.
+ * The .fastcall_pattern and .fastcall_stack_off are used by
+ * check_fastcall_stack_contract() to check if every stack access to
+ * fastcall spill/fill stack slot originates from spill/fill
+ * instructions, members of fastcall patterns.
  *
- * If such condition holds true for a subprogram, nocsr patterns could
- * be rewritten by remove_nocsr_spills_fills().
- * Otherwise nocsr patterns are not changed in the subprogram
+ * If such condition holds true for a subprogram, fastcall patterns could
+ * be rewritten by remove_fastcall_spills_fills().
+ * Otherwise bpf_fastcall patterns are not changed in the subprogram
  * (code, presumably, generated by an older clang version).
  *
  * For example, it is *not* safe to remove spill/fill below:
@@ -16228,9 +16227,9 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
  *   r0 += r1;                           exit;
  *   exit;
  */
-static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env,
-					struct bpf_subprog_info *subprog,
-					int insn_idx, s16 lowest_off)
+static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
+					   struct bpf_subprog_info *subprog,
+					   int insn_idx, s16 lowest_off)
 {
 	struct bpf_insn *insns = env->prog->insnsi, *stx, *ldx;
 	struct bpf_insn *call = &env->prog->insnsi[insn_idx];
@@ -16245,8 +16244,8 @@ static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env,
 		if (get_helper_proto(env, call->imm, &fn) < 0)
 			/* error would be reported later */
 			return;
-		clobbered_regs_mask = helper_nocsr_clobber_mask(fn);
-		can_be_inlined = fn->allow_nocsr &&
+		clobbered_regs_mask = helper_fastcall_clobber_mask(fn);
+		can_be_inlined = fn->allow_fastcall &&
 				 (verifier_inlines_helper_call(env, call->imm) ||
 				  bpf_jit_inlines_helper_call(call->imm));
 	}
@@ -16289,36 +16288,36 @@ static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env,
 		if (stx->off != off || ldx->off != off)
 			break;
 		expected_regs_mask &= ~BIT(stx->src_reg);
-		env->insn_aux_data[insn_idx - i].nocsr_pattern = 1;
-		env->insn_aux_data[insn_idx + i].nocsr_pattern = 1;
+		env->insn_aux_data[insn_idx - i].fastcall_pattern = 1;
+		env->insn_aux_data[insn_idx + i].fastcall_pattern = 1;
 	}
 	if (i == 1)
 		return;
 
-	/* Conditionally set 'nocsr_spills_num' to allow forward
+	/* Conditionally set 'fastcall_spills_num' to allow forward
 	 * compatibility when more helper functions are marked as
-	 * nocsr at compile time than current kernel supports, e.g:
+	 * bpf_fastcall at compile time than current kernel supports, e.g:
 	 *
 	 *   1: *(u64 *)(r10 - 8) = r1
-	 *   2: call A                  ;; assume A is nocsr for current kernel
+	 *   2: call A                  ;; assume A is bpf_fastcall for current kernel
 	 *   3: r1 = *(u64 *)(r10 - 8)
 	 *   4: *(u64 *)(r10 - 8) = r1
-	 *   5: call B                  ;; assume B is not nocsr for current kernel
+	 *   5: call B                  ;; assume B is not bpf_fastcall for current kernel
 	 *   6: r1 = *(u64 *)(r10 - 8)
 	 *
-	 * There is no need to block nocsr rewrite for such program.
-	 * Set 'nocsr_pattern' for both calls to keep check_nocsr_stack_contract() happy,
-	 * don't set 'nocsr_spills_num' for call B so that remove_nocsr_spills_fills()
+	 * There is no need to block bpf_fastcall rewrite for such program.
+	 * Set 'fastcall_pattern' for both calls to keep check_fastcall_stack_contract() happy,
+	 * don't set 'fastcall_spills_num' for call B so that remove_fastcall_spills_fills()
 	 * does not remove spill/fill pair {4,6}.
 	 */
 	if (can_be_inlined)
-		env->insn_aux_data[insn_idx].nocsr_spills_num = i - 1;
+		env->insn_aux_data[insn_idx].fastcall_spills_num = i - 1;
 	else
-		subprog->keep_nocsr_stack = 1;
-	subprog->nocsr_stack_off = min(subprog->nocsr_stack_off, off);
+		subprog->keep_fastcall_stack = 1;
+	subprog->fastcall_stack_off = min(subprog->fastcall_stack_off, off);
 }
 
-static int mark_nocsr_patterns(struct bpf_verifier_env *env)
+static int mark_fastcall_patterns(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn;
@@ -16335,12 +16334,12 @@ static int mark_nocsr_patterns(struct bpf_verifier_env *env)
 				continue;
 			lowest_off = min(lowest_off, insn->off);
 		}
-		/* use this offset to find nocsr patterns */
+		/* use this offset to find fastcall patterns */
 		for (i = subprog->start; i < (subprog + 1)->start; ++i) {
 			insn = env->prog->insnsi + i;
 			if (insn->code != (BPF_JMP | BPF_CALL))
 				continue;
-			mark_nocsr_pattern_for_call(env, subprog, i, lowest_off);
+			mark_fastcall_pattern_for_call(env, subprog, i, lowest_off);
 		}
 	}
 	return 0;
@@ -21244,10 +21243,10 @@ static int optimize_bpf_loop(struct bpf_verifier_env *env)
 	return 0;
 }
 
-/* Remove unnecessary spill/fill pairs, members of nocsr pattern,
+/* Remove unnecessary spill/fill pairs, members of fastcall pattern,
  * adjust subprograms stack depth when possible.
  */
-static int remove_nocsr_spills_fills(struct bpf_verifier_env *env)
+static int remove_fastcall_spills_fills(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
@@ -21258,8 +21257,8 @@ static int remove_nocsr_spills_fills(struct bpf_verifier_env *env)
 	int i, j;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
-		if (aux[i].nocsr_spills_num > 0) {
-			spills_num = aux[i].nocsr_spills_num;
+		if (aux[i].fastcall_spills_num > 0) {
+			spills_num = aux[i].fastcall_spills_num;
 			/* NOPs would be removed by opt_remove_nops() */
 			for (j = 1; j <= spills_num; ++j) {
 				*(insn - j) = NOP;
@@ -21268,8 +21267,8 @@ static int remove_nocsr_spills_fills(struct bpf_verifier_env *env)
 			modified = true;
 		}
 		if ((subprog + 1)->start == i + 1) {
-			if (modified && !subprog->keep_nocsr_stack)
-				subprog->stack_depth = -subprog->nocsr_stack_off;
+			if (modified && !subprog->keep_fastcall_stack)
+				subprog->stack_depth = -subprog->fastcall_stack_off;
 			subprog++;
 			modified = false;
 		}
@@ -22192,7 +22191,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = mark_nocsr_patterns(env);
+	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
 
@@ -22209,7 +22208,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	 * allocate additional slots.
 	 */
 	if (ret == 0)
-		ret = remove_nocsr_spills_fills(env);
+		ret = remove_fastcall_spills_fills(env);
 
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
-- 
2.45.2



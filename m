Return-Path: <bpf+bounces-33417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C919E91CBEF
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 11:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5447E1F22493
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 09:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59EA3D3BF;
	Sat, 29 Jun 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9o99T6R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5229F3BBEB
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654491; cv=none; b=q/Q/lluJy/ejn2LN3DRAkF4iYturz8gs68jTJxbX772Y0MdS7c32UUoGnWfn14BOJL88M/dhLf/2fo6TAO8hh56B9CtSi+8ej9HgUegE90EX6BVjAi/17/CLDMx4YDqZXijtrpVgeHx7M5Ok4aAgXO4FNc+JXdvby9tX+dU5+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654491; c=relaxed/simple;
	bh=88t31omqelfZrG+7VgU81QVbocnRtC9afxZdpBzA+1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXrVBkmzU0/B6miPia/udau/IqvpAVTYlY3XxGv0ef6eNaNTaOz1BKr05o6bYj86HhOiSju1RtuPe+l8H5PrEH+qmF3ZJcByGrWFxw4iRsiFCYFJVEviE1A5Oknro5re2ZCNSvJNwFqonKuuahWRKma+lnv/ySumtRjYZWRRUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9o99T6R; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7041053c0fdso802868b3a.3
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719654488; x=1720259288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oQkEOWKTyU+VvhBseK2bV41vKgqu0GApcClQiOuF64=;
        b=m9o99T6RJeOvzC/MxfKiVMw4PwhuBFilZH5BgngJCPkrtnog1U6W5R8/t07hX7KRil
         eu+I8t9oM9Vm0pJZGzFTJxBloYiZCBGwDhrbxiR3fPvtOx8Nb4s0c32a7I14q2Xlctc/
         yeMEjKFQjKYWnxGjFpYG2s/n190nFuTANr8+E7faoCFnRbszp7UFAWwcbWQJXRV21JQj
         aKEcT2xgQF10FPdbO8S5Q9YE1lKu40mjvXIIczdJPZMEMZwnbrFTLdp5Ye/iliU5Z9cH
         C/+p7jQODqg6K9/hAUIprdPFmKSS4iPxULjhzqUiviLAd/P8qsNfRFkzMzSsbdI3wVGI
         NcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654488; x=1720259288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oQkEOWKTyU+VvhBseK2bV41vKgqu0GApcClQiOuF64=;
        b=D7NwdF8XIlqeALHkLSI+HywSqPSheKf+vnOr6YDOg3Lw/Xe1cYystWCY2Jc0PuA2Vd
         oEuAAWDXCRq6PD5xaxFYAGMHP528q6Ii2ICtvz++ey26dGShMw1K0V29XNRXoiLtQK58
         lxHoJtkFu1nF8XN93o6n/BMl9usnyCatpCIQM0TKVwdcdoOTddPas8JwepEZ11qXt7N1
         GHcsIVMmhjg0zfvra2Vkg8CyKFMD8Wk05hFjrr5HQdXAy4aNiz0mYaB4WUnqeki1Ub7R
         PCWkaxCnv2dgQSbSo1u7rGvscGi9bKGv/QYZDUH5BD6hctyT5BIfwx+HF66K4P9OInep
         0u+g==
X-Gm-Message-State: AOJu0YywvOgKbHEolq49+xEUay7cmBBB05b3Zaj1Drb8yMlbuAwpBcUX
	mn9bmCQ9bFbil4WJeMdzb8ELj/sS36TSJjCsIazsDh29LMGVJZnWKZW5JA==
X-Google-Smtp-Source: AGHT+IEszEmBjNODGZU8jQMSXnRMtpkV9y1hmz4bHyclfXxlE+DQITKcO1UTeHdzi2dwRyY2XW8j/g==
X-Received: by 2002:a05:6a00:8d6:b0:704:2bdd:82fe with SMTP id d2e1a72fcca58-70aaad5ca44mr585266b3a.15.1719654488009;
        Sat, 29 Jun 2024 02:48:08 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f5asm2948932b3a.195.2024.06.29.02.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 02:48:07 -0700 (PDT)
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
Subject: [RFC bpf-next v1 2/8] bpf: no_caller_saved_registers attribute for helper calls
Date: Sat, 29 Jun 2024 02:47:27 -0700
Message-ID: <20240629094733.3863850-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240629094733.3863850-1-eddyz87@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
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

This commit introduces flag bpf_func_prot->nocsr.
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
    call %[to_be_inlined_by_jit]
    r2 = *(u64 *)(r10 - 16);
    r1 = *(u64 *)(r10 - 8);
    r0 = r1;
    r0 += r2;
    exit;

- kernel removes unnecessary spills and fills, if called function is
  inlined by current JIT (with assumption that patch inserted by JIT
  honors nocsr contract, e.g. does not scratch r3-r5 for the example
  above), e.g. the code above would be transformed to:

    r1 = 1;
    r2 = 2;
    call %[to_be_inlined_by_jit]
    r0 = r1;
    r0 += r2;
    exit;

Technically, the transformation is split into the following phases:
- during check_cfg() function update_nocsr_pattern_marks() is used to
  find potential patterns;
- upon stack read or write access,
  function check_nocsr_stack_contract() is used to verify if
  stack offsets, presumably reserved for nocsr patterns, are used
  only from those patterns;
- function remove_nocsr_spills_fills(), called from bpf_check(),
  applies the rewrite for valid patterns.

See comment in match_and_mark_nocsr_pattern() for more details.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h          |   6 +
 include/linux/bpf_verifier.h |   9 ++
 kernel/bpf/verifier.c        | 300 ++++++++++++++++++++++++++++++++++-
 3 files changed, 307 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 960780ef04e1..f4faa6b8cb5b 100644
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
+	bool nocsr;
 	enum bpf_return_type ret_type;
 	union {
 		struct {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2b54e25d2364..67dbe4cb1529 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -585,6 +585,10 @@ struct bpf_insn_aux_data {
 	 * accepts callback function as a parameter.
 	 */
 	bool calls_callback;
+	/* true if STX or LDX instruction is a part of a spill/fill
+	 * pattern for a no_caller_saved_registers call.
+	 */
+	bool nocsr_pattern;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
@@ -641,6 +645,11 @@ struct bpf_subprog_info {
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
+	/* stack depth after which slots reserved for
+	 * no_caller_saved_registers spills/fills start,
+	 * value <= nocsr_stack_off belongs to the spill/fill area.
+	 */
+	s16 nocsr_stack_off;
 	bool has_tail_call: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8dd3385cf925..1340d3e60d30 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2471,16 +2471,41 @@ static int cmp_subprogs(const void *a, const void *b)
 	       ((struct bpf_subprog_info *)b)->start;
 }
 
-static int find_subprog(struct bpf_verifier_env *env, int off)
+/* Find subprogram that contains instruction at 'off' */
+static int find_containing_subprog(struct bpf_verifier_env *env, int off)
 {
-	struct bpf_subprog_info *p;
+	struct bpf_subprog_info *vals = env->subprog_info;
+	int high = env->subprog_cnt - 1;
+	int low = 0, ret = -ENOENT;
 
-	p = bsearch(&off, env->subprog_info, env->subprog_cnt,
-		    sizeof(env->subprog_info[0]), cmp_subprogs);
-	if (!p)
+	if (off >= env->prog->len || off < 0)
 		return -ENOENT;
-	return p - env->subprog_info;
 
+	while (low <= high) {
+		int mid = (low + high)/2;
+		struct bpf_subprog_info *val = &vals[mid];
+		int diff = off - val->start;
+
+		if (diff < 0) {
+			high = mid - 1;
+		} else {
+			low = mid + 1;
+			/* remember last time mid.start <= off */
+			ret = mid;
+		}
+	}
+	return ret;
+}
+
+/* Find subprogram that starts exactly at 'off' */
+static int find_subprog(struct bpf_verifier_env *env, int off)
+{
+	int idx;
+
+	idx = find_containing_subprog(env, off);
+	if (idx < 0 || env->subprog_info[idx].start != off)
+		return -ENOENT;
+	return idx;
 }
 
 static int add_subprog(struct bpf_verifier_env *env, int off)
@@ -4501,6 +4526,23 @@ static int get_reg_width(struct bpf_reg_state *reg)
 	return fls64(reg->umax_value);
 }
 
+/* See comment for match_and_mark_nocsr_pattern() */
+static void check_nocsr_stack_contract(struct bpf_verifier_env *env, struct bpf_func_state *state,
+				       int insn_idx, int off)
+{
+	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+
+	if (subprog->nocsr_stack_off <= off || aux->nocsr_pattern)
+		return;
+	/* access to the region [max_stack_depth .. nocsr_stack_off]
+	 * from something that is not a part of the nocsr pattern,
+	 * disable nocsr rewrites for current subprogram by setting
+	 * nocsr_stack_off to a value smaller than any possible offset.
+	 */
+	subprog->nocsr_stack_off = S16_MIN;
+}
+
 /* check_stack_{read,write}_fixed_off functions track spill/fill of registers,
  * stack boundary and alignment are checked in check_mem_access()
  */
@@ -4549,6 +4591,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
+	check_nocsr_stack_contract(env, state, insn_idx, off);
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
 		bool reg_value_fits;
@@ -4682,6 +4725,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 			return err;
 	}
 
+	check_nocsr_stack_contract(env, state, insn_idx, min_off);
 	/* Variable offset writes destroy any spilled pointers in range. */
 	for (i = min_off; i < max_off; i++) {
 		u8 new_type, *stype;
@@ -4820,6 +4864,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	reg = &reg_state->stack[spi].spilled_ptr;
 
 	mark_stack_slot_scratched(env, spi);
+	check_nocsr_stack_contract(env, state, env->insn_idx, off);
 
 	if (is_spilled_reg(&reg_state->stack[spi])) {
 		u8 spill_size = 1;
@@ -4980,6 +5025,7 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
 	min_off = reg->smin_value + off;
 	max_off = reg->smax_value + off;
 	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
+	check_nocsr_stack_contract(env, ptr_state, env->insn_idx, min_off);
 	return 0;
 }
 
@@ -15950,6 +15996,205 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 	return ret;
 }
 
+/* Bitmask with 1s for all caller saved registers */
+#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
+
+/* Return a bitmask specifying which caller saved registers are
+ * modified by a call to a helper.
+ * (Either as a return value or as scratch registers).
+ *
+ * For normal helpers registers R0-R5 are scratched.
+ * For helpers marked as no_csr:
+ * - scratch R0 if function is non-void;
+ * - scratch R1-R5 if corresponding parameter type is set
+ *   in the function prototype.
+ */
+static u8 get_helper_reg_mask(const struct bpf_func_proto *fn)
+{
+	u8 mask;
+	int i;
+
+	if (!fn->nocsr)
+		return ALL_CALLER_SAVED_REGS;
+
+	mask = 0;
+	mask |= fn->ret_type == RET_VOID ? 0 : BIT(BPF_REG_0);
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); ++i)
+		mask |= fn->arg_type[i] == ARG_DONTCARE ? 0 : BIT(BPF_REG_1 + i);
+	return mask;
+}
+
+/* True if do_misc_fixups() replaces calls to helper number 'imm',
+ * replacement patch is presumed to follow no_caller_saved_registers contract
+ * (see match_and_mark_nocsr_pattern() below).
+ */
+static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
+{
+	return false;
+}
+
+/* If 'insn' is a call that follows no_caller_saved_registers contract
+ * and called function is inlined by current jit, return a mask with
+ * 1s corresponding to registers that are scratched by this call
+ * (depends on return type and number of return parameters).
+ * Otherwise return ALL_CALLER_SAVED_REGS mask.
+ */
+static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	const struct bpf_func_proto *fn;
+
+	if (bpf_helper_call(insn) &&
+	    verifier_inlines_helper_call(env, insn->imm) &&
+	    get_helper_proto(env, insn->imm, &fn) == 0 &&
+	    fn->nocsr)
+		return ~get_helper_reg_mask(fn);
+
+	return ALL_CALLER_SAVED_REGS;
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
+ * - stack offsets used for the spill/fill are allocated as minimal
+ *   stack offsets in whole function and are not used for any other
+ *   purposes;
+ *
+ * - when kernel loads a program, it looks for such patterns
+ *   (nocsr function surrounded by spills/fills) and checks if
+ *   spill/fill stack offsets are used exclusively in nocsr patterns;
+ *
+ * - if so, and if current JIT inlines the call to the nocsr function
+ *   (e.g. a helper call), kernel removes unnecessary spill/fill pairs;
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
+ *   call %[to_be_inlined_by_jit]  -->   call %[to_be_inlined_by_jit]
+ *   r2 = *(u64 *)(r10 - 16);            r0 = r1;
+ *   r1 = *(u64 *)(r10 - 8);             r0 += r2;
+ *   r0 = r1;                            exit;
+ *   r0 += r2;
+ *   exit;
+ *
+ * The purpose of match_and_mark_nocsr_pattern is to:
+ * - look for such patterns;
+ * - mark spill and fill instructions in env->insn_aux_data[*].nocsr_pattern;
+ * - update env->subprog_info[*]->nocsr_stack_off to find an offset
+ *   at which nocsr spill/fill stack slots start.
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
+ *   call %[to_be_inlined_by_jit]  -->   call %[to_be_inlined_by_jit]
+ *   r1 = *(u64 *)(r10 - 8);             r0 = *(u64 *)(r10 - 8);  <---- wrong !!!
+ *   r0 = *(u64 *)(r10 - 8);             r0 += r1;
+ *   r0 += r1;                           exit;
+ *   exit;
+ */
+static int match_and_mark_nocsr_pattern(struct bpf_verifier_env *env, int t, bool mark)
+{
+	struct bpf_insn *insns = env->prog->insnsi, *stx, *ldx;
+	struct bpf_subprog_info *subprog;
+	u32 csr_mask = call_csr_mask(env, &insns[t]);
+	u32 reg_mask = ~csr_mask | ~ALL_CALLER_SAVED_REGS;
+	int s, i;
+	s16 off;
+
+	if (csr_mask == ALL_CALLER_SAVED_REGS)
+		return false;
+
+	for (i = 1, off = 0; i <= ARRAY_SIZE(caller_saved); ++i, off += BPF_REG_SIZE) {
+		if (t - i < 0 || t + i >= env->prog->len)
+			break;
+		stx = &insns[t - i];
+		ldx = &insns[t + i];
+		if (off == 0) {
+			off = stx->off;
+			if (off % BPF_REG_SIZE != 0)
+				break;
+		}
+		if (/* *(u64 *)(r10 - off) = r[0-5]? */
+		    stx->code != (BPF_STX | BPF_MEM | BPF_DW) ||
+		    stx->dst_reg != BPF_REG_10 ||
+		    /* r[0-5] = *(u64 *)(r10 - off)? */
+		    ldx->code != (BPF_LDX | BPF_MEM | BPF_DW) ||
+		    ldx->src_reg != BPF_REG_10 ||
+		    /* check spill/fill for the same reg and offset */
+		    stx->src_reg != ldx->dst_reg ||
+		    stx->off != ldx->off ||
+		    stx->off != off ||
+		    /* this should be a previously unseen register */
+		    BIT(stx->src_reg) & reg_mask)
+			break;
+		reg_mask |= BIT(stx->src_reg);
+		if (mark) {
+			env->insn_aux_data[t - i].nocsr_pattern = true;
+			env->insn_aux_data[t + i].nocsr_pattern = true;
+		}
+	}
+	if (i == 1)
+		return 0;
+	if (mark) {
+		s = find_containing_subprog(env, t);
+		/* can't happen */
+		if (WARN_ON_ONCE(s < 0))
+			return 0;
+		subprog = &env->subprog_info[s];
+		subprog->nocsr_stack_off = min(subprog->nocsr_stack_off, off);
+	}
+	return i - 1;
+}
+
+/* If instruction 't' is a nocsr call surrounded by spill/fill pairs,
+ * update env->subprog_info[_]->nocsr_stack_off and
+ * env->insn_aux_data[_].nocsr_pattern fields.
+ */
+static void update_nocsr_pattern_marks(struct bpf_verifier_env *env, int t)
+{
+	match_and_mark_nocsr_pattern(env, t, true);
+}
+
+/* If instruction 't' is a nocsr call surrounded by spill/fill pairs,
+ * return the number of such pairs.
+ */
+static int match_nocsr_pattern(struct bpf_verifier_env *env, int t)
+{
+	return match_and_mark_nocsr_pattern(env, t, false);
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -16017,6 +16262,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 				mark_force_checkpoint(env, t);
 			}
 		}
+		if (insn->src_reg == 0)
+			update_nocsr_pattern_marks(env, t);
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
 	case BPF_JA:
@@ -19063,15 +19310,16 @@ static int opt_remove_dead_code(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static const struct bpf_insn NOP = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+
 static int opt_remove_nops(struct bpf_verifier_env *env)
 {
-	const struct bpf_insn ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	int i, err;
 
 	for (i = 0; i < insn_cnt; i++) {
-		if (memcmp(&insn[i], &ja, sizeof(ja)))
+		if (memcmp(&insn[i], &NOP, sizeof(NOP)))
 			continue;
 
 		err = verifier_remove_insns(env, i, 1);
@@ -20801,6 +21049,39 @@ static int optimize_bpf_loop(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/* Remove unnecessary spill/fill pairs, members of nocsr pattern.
+ * Do this as a separate pass to avoid interfering with helper/kfunc
+ * inlining logic in do_misc_fixups().
+ * See comment for match_and_mark_nocsr_pattern().
+ */
+static int remove_nocsr_spills_fills(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	int i, j, spills_num, cur_subprog = 0;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		spills_num = match_nocsr_pattern(env, i);
+		if (spills_num == 0)
+			goto next_insn;
+		for (j = 1; j <= spills_num; ++j)
+			if ((insn - j)->off >= subprogs[cur_subprog].nocsr_stack_off ||
+			    (insn + j)->off >= subprogs[cur_subprog].nocsr_stack_off)
+				goto next_insn;
+		/* NOPs are removed by opt_remove_nops() later */
+		for (j = 1; j <= spills_num; ++j) {
+			*(insn - j) = NOP;
+			*(insn + j) = NOP;
+		}
+
+next_insn:
+		if (subprogs[cur_subprog + 1].start == i + 1)
+			cur_subprog++;
+	}
+	return 0;
+}
+
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl, *sln;
@@ -21719,6 +22000,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret == 0)
 		ret = optimize_bpf_loop(env);
 
+	if (ret == 0)
+		ret = remove_nocsr_spills_fills(env);
+
 	if (is_priv) {
 		if (ret == 0)
 			opt_hard_wire_dead_code_branches(env);
-- 
2.45.2



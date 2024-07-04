Return-Path: <bpf+bounces-33877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF41E9273F1
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 12:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35E21C210E4
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED991AB908;
	Thu,  4 Jul 2024 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6hOmqgo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719613C8FF
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088664; cv=none; b=ZlTH7RduBg76V52JPA4U2RJMs+NdUEesM045bUIspWTFh/FvwED0a3ZivURqYK3+zUdw9Nt5gH4jZiMoOLiF1uNEsw3xGc/X8cb/MJg/rUnWLNyWGxrZtd62LcLATAUwJyIvVXmlctmYbL9oqw+5VpFyVEvTcek06iwfDRA5VAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088664; c=relaxed/simple;
	bh=NQ3zqU4xyVDoo6gWb2RXiW3R5jzlGZsaz7A+Ub7KWIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MB1K9XroU08oSYY7F0PAoaZV/sujqCgB1LvExTfX6FC/p9Go7/RW1tdaGrVg7el5NNXcm2zRNlvU55f1H0RNeP1IxlxykLKYP13dYCciYLD/zC/bdEO/GS63AmTyaehWHIp4Oz2TDIhzhQNZn5TTx/s7hF3l9lqTlybkyeFkRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6hOmqgo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fa9f540f45so2533705ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 03:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088661; x=1720693461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oOSvEjG6UckfqElOwQLGR5+LxYpNUGP9vxbbl382do=;
        b=c6hOmqgotOfPFDhHbpIRppYacdLNxGhjC8nVwOepty0VUptoT0lNQWZ/iJWXF5S1e7
         IYvvmlLZtuVEE31vf6zo2yd8pNrMRLDKsrXUx/1Ja+/fGuOpqiF3xGdd9dLXVhZdaW+I
         0YQsc146vLspVsOxTzXK+A2uRZA+NpTmdHW0Es18oeeOCo71pDuzNxCo0T2v7qvpzv/j
         Yo2iYebTjcdc+VFiza24Cx5WpFQ2w48JHpmbK01PnGVO9WJoRLT34Vt88kOrqnvD2tSW
         kIhJJ703cVQaU5Ba2M4JZdCX0ykLWVMqLjG8WvP2oq/ePB2knYjY46nGGVV7NsxycpQH
         ucDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088661; x=1720693461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oOSvEjG6UckfqElOwQLGR5+LxYpNUGP9vxbbl382do=;
        b=V/42aRxR905JI1kPSBq6Z05jN2RuRcGfN4G+fH7kM7fSwrQ+7MJckhgNIrCKz0SqUX
         VW/qz4qwBXjv0cEwW3lNmerq0WT5G6UER3z8WMf8ukCcwFFiYFoTvVDYUnxOoKP+/IWS
         7xzFv7XD+6gQuS3guDVP6lHxQkPC8WDj4k598U0q7c3BfGNL6Wd0I+Y0CK+xWllNuqbB
         rwS6K148Y3BXhcPOtEGsjp75Kzk4dyjToSngv6LVbrlbd6JyQLW0z3l3dfOD7JqVtNkg
         JiiGaCHEozCVbNoWiqGheqCFzjs5n0DH5NaDafSPqoTnwAWdgpODkQHHCkE93ZHxnGkS
         CKiw==
X-Gm-Message-State: AOJu0YySXPe3whwEZcysXeHtfqS5DwfnSHAdd6l2cQrhh72n1ATcAZXw
	/Lc8npQYqzAJygPGhPOF0g16Fi66jvRFFSbFMo7PCh9uHbSBhTny4QO5KA==
X-Google-Smtp-Source: AGHT+IGPy0w9sAKNEgWDl0jnWiNky2N8lV+Wb0H9AHfvMOmvelJbjIav5uq3MTXY9zXLIgmU/3lDvg==
X-Received: by 2002:a17:90b:4ac4:b0:2c9:9fdf:f72e with SMTP id 98e67ed59e1d1-2c99fdffb19mr629060a91.26.1720088660856;
        Thu, 04 Jul 2024 03:24:20 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9a4c0fe8dsm216693a91.0.2024.07.04.03.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:24:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute for helper calls
Date: Thu,  4 Jul 2024 03:23:54 -0700
Message-ID: <20240704102402.1644916-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102402.1644916-1-eddyz87@gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
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
- function mark_nocsr_pattern_patterns(), called from bpf_check()
  searches and marks potential patterns in instruction auxiliary data;
- upon stack read or write access,
  function check_nocsr_stack_contract() is used to verify if
  stack offsets, presumably reserved for nocsr patterns, are used
  only from those patterns;
- function do_misc_fixups(), called from bpf_check(),
  applies the rewrite for valid patterns.

See comment in mark_nocsr_pattern_for_call() for more details.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h          |   6 +
 include/linux/bpf_verifier.h |  14 ++
 kernel/bpf/verifier.c        | 300 ++++++++++++++++++++++++++++++++++-
 3 files changed, 314 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 960780ef04e1..391e19c5cd68 100644
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
index 2b54e25d2364..735ae0901b3d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -585,6 +585,15 @@ struct bpf_insn_aux_data {
 	 * accepts callback function as a parameter.
 	 */
 	bool calls_callback;
+	/* true if STX or LDX instruction is a part of a spill/fill
+	 * pattern for a no_caller_saved_registers call.
+	 */
+	u8 nocsr_pattern:1;
+	/* for CALL instructions, a number of spill/fill pairs in the
+	 * no_caller_saved_registers pattern.
+	 */
+	u8 nocsr_spills_num:3;
+
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
@@ -641,6 +650,11 @@ struct bpf_subprog_info {
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
index 4869f1fb0a42..d16a249b59ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2471,16 +2471,37 @@ static int cmp_subprogs(const void *a, const void *b)
 	       ((struct bpf_subprog_info *)b)->start;
 }
 
-static int find_subprog(struct bpf_verifier_env *env, int off)
+/* Find subprogram that contains instruction at 'off' */
+static int find_containing_subprog(struct bpf_verifier_env *env, int off)
 {
-	struct bpf_subprog_info *p;
+	struct bpf_subprog_info *vals = env->subprog_info;
+	int l, r, m;
 
-	p = bsearch(&off, env->subprog_info, env->subprog_cnt,
-		    sizeof(env->subprog_info[0]), cmp_subprogs);
-	if (!p)
+	if (off >= env->prog->len || off < 0 || env->subprog_cnt == 0)
 		return -ENOENT;
-	return p - env->subprog_info;
 
+	l = 0;
+	m = 0;
+	r = env->subprog_cnt - 1;
+	while (l < r) {
+		m = l + (r - l + 1) / 2;
+		if (vals[m].start <= off)
+			l = m;
+		else
+			r = m - 1;
+	}
+	return l;
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
@@ -4501,6 +4522,23 @@ static int get_reg_width(struct bpf_reg_state *reg)
 	return fls64(reg->umax_value);
 }
 
+/* See comment for mark_nocsr_pattern_for_call() */
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
@@ -4549,6 +4587,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
+	check_nocsr_stack_contract(env, state, insn_idx, off);
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
 		bool reg_value_fits;
@@ -4682,6 +4721,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 			return err;
 	}
 
+	check_nocsr_stack_contract(env, state, insn_idx, min_off);
 	/* Variable offset writes destroy any spilled pointers in range. */
 	for (i = min_off; i < max_off; i++) {
 		u8 new_type, *stype;
@@ -4820,6 +4860,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	reg = &reg_state->stack[spi].spilled_ptr;
 
 	mark_stack_slot_scratched(env, spi);
+	check_nocsr_stack_contract(env, state, env->insn_idx, off);
 
 	if (is_spilled_reg(&reg_state->stack[spi])) {
 		u8 spill_size = 1;
@@ -4980,6 +5021,7 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
 	min_off = reg->smin_value + off;
 	max_off = reg->smax_value + off;
 	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
+	check_nocsr_stack_contract(env, ptr_state, env->insn_idx, min_off);
 	return 0;
 }
 
@@ -15951,6 +15993,206 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
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
+	if (!fn->allow_nocsr)
+		return ALL_CALLER_SAVED_REGS;
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
+/* If 'insn' is a call that follows no_caller_saved_registers contract
+ * and called function is inlined by current jit or verifier,
+ * return a mask with 1s corresponding to registers that are scratched
+ * by this call (depends on return type and number of return parameters).
+ * Otherwise return ALL_CALLER_SAVED_REGS mask.
+ */
+static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	const struct bpf_func_proto *fn;
+
+	if (bpf_helper_call(insn) &&
+	    (verifier_inlines_helper_call(env, insn->imm) || bpf_jit_inlines_helper_call(insn->imm)) &&
+	    get_helper_proto(env, insn->imm, &fn) == 0 &&
+	    fn->allow_nocsr)
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
+ *   at which nocsr spill/fill stack slots start.
+ *
+ * The .nocsr_pattern and .nocsr_stack_off are used by
+ * check_nocsr_stack_contract() to check if every stack access to
+ * nocsr spill/fill stack slot originates from spill/fill
+ * instructions, members of nocsr patterns.
+ *
+ * If such condition holds true for a subprogram, nocsr patterns could
+ * be rewritten by do_misc_fixups().
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
+static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env, int t)
+{
+	struct bpf_insn *insns = env->prog->insnsi, *stx, *ldx;
+	struct bpf_subprog_info *subprog;
+	u32 csr_mask = call_csr_mask(env, &insns[t]);
+	u32 reg_mask = ~csr_mask | ~ALL_CALLER_SAVED_REGS;
+	int s, i;
+	s16 off;
+
+	if (csr_mask == ALL_CALLER_SAVED_REGS)
+		return;
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
+		env->insn_aux_data[t - i].nocsr_pattern = 1;
+		env->insn_aux_data[t + i].nocsr_pattern = 1;
+	}
+	if (i == 1)
+		return;
+	env->insn_aux_data[t].nocsr_spills_num = i - 1;
+	s = find_containing_subprog(env, t);
+	/* can't happen */
+	if (WARN_ON_ONCE(s < 0))
+		return;
+	subprog = &env->subprog_info[s];
+	subprog->nocsr_stack_off = min(subprog->nocsr_stack_off, off);
+}
+
+/* Update the following fields when appropriate:
+ * - env->insn_aux_data[*].nocsr_pattern
+ * - env->insn_aux_data[*].spills_num and
+ * - env->subprog_info[*].nocsr_stack_off
+ * See mark_nocsr_pattern_for_call().
+ */
+static int mark_nocsr_patterns(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insn = env->prog->insnsi;
+	int i, insn_cnt = env->prog->len;
+
+	for (i = 0; i < insn_cnt; i++, insn++)
+		/* might be extended to handle kfuncs as well */
+		if (bpf_helper_call(insn))
+			mark_nocsr_pattern_for_call(env, i);
+	return 0;
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -20119,6 +20361,48 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			goto next_insn;
+		/* Remove unnecessary spill/fill pairs, members of nocsr pattern */
+		if (env->insn_aux_data[i + delta].nocsr_spills_num > 0) {
+			u32 j, spills_num = env->insn_aux_data[i + delta].nocsr_spills_num;
+			int err;
+
+			/* don't apply this on a second visit */
+			env->insn_aux_data[i + delta].nocsr_spills_num = 0;
+
+			/* check if spill/fill stack access is in expected offset range */
+			for (j = 1; j <= spills_num; ++j) {
+				if ((insn - j)->off >= subprogs[cur_subprog].nocsr_stack_off ||
+				    (insn + j)->off >= subprogs[cur_subprog].nocsr_stack_off) {
+					/* do a second visit of this instruction,
+					 * so that verifier can inline it
+					 */
+					i -= 1;
+					insn -= 1;
+					goto next_insn;
+				}
+			}
+
+			/* apply the rewrite:
+			 *   *(u64 *)(r10 - X) = rY ; num-times
+			 *   call()                               -> call()
+			 *   rY = *(u64 *)(r10 - X) ; num-times
+			 */
+			err = verifier_remove_insns(env, i + delta - spills_num, spills_num);
+			if (err)
+				return err;
+			err = verifier_remove_insns(env, i + delta - spills_num + 1, spills_num);
+			if (err)
+				return err;
+
+			i += spills_num - 1;
+			/*   ^            ^   do a second visit of this instruction,
+			 *   |            '-- so that verifier can inline it
+			 *   '--------------- jump over deleted fills
+			 */
+			delta -= 2 * spills_num;
+			insn = env->prog->insnsi + i + delta;
+			goto next_insn;
+		}
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
 			if (ret)
@@ -21704,6 +21988,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = mark_nocsr_patterns(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = do_check_main(env);
 	ret = ret ?: do_check_subprogs(env);
 
-- 
2.45.2



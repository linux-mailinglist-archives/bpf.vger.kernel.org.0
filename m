Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC1674A4F
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjATDn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjATDnZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:43:25 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DE8B1ECB
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:24 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id lp10so990849pjb.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbfmok1bo7nEVSKUA385ZnbR9z6ipfMuo+sDIvn1aHs=;
        b=BAxhM1kHH1vD6kmS3jNy4BO8RKxnGEl0+UtmkSovJausohrZnSidVS9ITwnckn7tfJ
         m3iiYLTe3hgQV1Gw6+vz7sXOcdnLfcMPmPvEN2eGX/jnUFr8DuncBTL36ROw74eldmIf
         74KmeBI/+mJWQc10ciHDMAiNBXlXpklMfADDCzc5yeWDb7I5preGU1mXwmYnWqo0YfUg
         BaL1iWWrh3ZVcKc6JdhD8Hzw8+o2kXHJl0sXpt6jH8z1tpQAtsoTh7hOW7OpYdJm6YgN
         IzHCM2sWhZMJb+NNkJADVx7YMl8LV9ci2YQdIeOP0YvZuUZ4GxtJC+ZVQIpC5VTRjHVV
         ZvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbfmok1bo7nEVSKUA385ZnbR9z6ipfMuo+sDIvn1aHs=;
        b=SaXtaDTCkBMk0vkX0z3GD6AwMcAx7uFzlixhKIXp0h0coVy7AbmjwEM/TgO2cVXOFo
         eJx4BXpjUmfqlSOW2B4YhrH/FUAhJR4dFMQvwLQ5hv8bccYycifNMda4tyTY3SfSsSmy
         UHHXnGsPD6uDLtMd6M3uLxzi62wbylq+h+aSx4UsZ769bfm9+ccb075v0w5yINK16qYq
         dYNi3LBPVszt7tFZY2Si1gMNxaIt120CR7njgBwHGWkLU+6QrNVBML5yEONuTdcho2AC
         pn8Q+Ey1eSZQ+R7xDaNCDM3Qm4okq3kdIVlpdtmzF8pR/WmgQeNYl61Mpv01B73c1xNT
         xOXQ==
X-Gm-Message-State: AFqh2koUTVSgybJRfni488RnwBKK/uNRFuna7YMhy+RFyLRKVhUFgPbo
        IrnHcAJXdv4sEQCj2cDTrqEdUsxinCk=
X-Google-Smtp-Source: AMrXdXt1sctt6qie7d7vaUaQC58L6F3X7IsEnFH4siEAK1tdpVCaaG3XikKtUu/xpzL1W/0mbR2h+Q==
X-Received: by 2002:a05:6a20:438a:b0:b8:6583:b654 with SMTP id i10-20020a056a20438a00b000b86583b654mr15858487pzl.28.1674186203484;
        Thu, 19 Jan 2023 19:43:23 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id k9-20020a6555c9000000b004a052e93b77sm21702171pgs.7.2023.01.19.19.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:43:23 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 02/12] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
Date:   Fri, 20 Jan 2023 09:13:04 +0530
Message-Id: <20230120034314.1921848-3-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120034314.1921848-1-memxor@gmail.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9553; i=memxor@gmail.com; h=from:subject; bh=2s1pBDiiXTIV1BB1rUUx54yULFT49RyHEefJ0HCSxfo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyg28l2cE3exe3tS2y0dU5xdJr1Vgd0s+vbl8nS4L rp+xG4SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8oNvAAKCRBM4MiGSL8Rylm1D/ 0TU0oD7Cj0kgfNhHEtdwVDQXqOJk6pyf/REiEhyrEngkm0V0Iz5DZjNpNKrCdHRmTvGoeuQ/30ArIv ZXYfYKyL735YuasVwbGqVGuNdxriNUgDO7O3ApgTSgOiYkjyPPI3fIFkLc1AA2gEdOrBLVcIuHcd1I pTVq/D5xp3MTBIyfLaQtKG+a/N9Sr2krXruLQqQdzptOrrBvGgJRmwlOhVig9nLhoUwEWEdC2Qe5A4 y45gunT2NtVcPsdOu1VHf0TuxtAbTWegVfdpLq8v86fKkLt2gf4J8Uh6YKaAoy/vCkEnmNw4VkzTlj pzsirQXW/rAajtihhfjcw+ZRUBYKYJPCqhxppDAGZmPSBFbxa72TTC9fJ9VUKFi+/US1eJYe5kPp22 j0L8UGXsfpSzYmlkOW6r+YFwYune5FgDPyhY80x2Ih6OfG50HE2ppt4ovXJL6tkxCZarAsXMRtvzgS OacLyk2SBuIYecCxbHO8q1BU2FM8HB7RQHSj5+6Aqb9ghN6L7yD5JHMu0fDj3ikAOi3uimqlwDGw12 Ii/AsOWH2Bpa5dDF/nawMaKtmW6AUnbMggy4q5yEuXnN7B4CkWO+zjgy11S4jiLno8q5YHpC3TZldr inAkl2NYGdfU7iBkg3JGDevUq4duZhMke+izI8tco1trdeGUSRL0quWAK9aw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the dynptr function is not checking the variable offset part
of PTR_TO_STACK that it needs to check. The fixed offset is considered
when computing the stack pointer index, but if the variable offset was
not a constant (such that it could not be accumulated in reg->off), we
will end up a discrepency where runtime pointer does not point to the
actual stack slot we mark as STACK_DYNPTR.

It is impossible to precisely track dynptr state when variable offset is
not constant, hence, just like bpf_timer, kptr, bpf_spin_lock, etc.
simply reject the case where reg->var_off is not constant. Then,
consider both reg->off and reg->var_off.value when computing the stack
pointer index.

A new helper dynptr_get_spi is introduced to hide over these details
since the dynptr needs to be located in multiple places outside the
process_dynptr_func checks, hence once we know it's a PTR_TO_STACK, we
need to enforce these checks in all places.

Note that it is disallowed for unprivileged users to have a non-constant
var_off, so this problem should only be possible to trigger from
programs having CAP_PERFMON. However, its effects can vary.

Without the fix, it is possible to replace the contents of the dynptr
arbitrarily by making verifier mark different stack slots than actual
location and then doing writes to the actual stack address of dynptr at
runtime.

Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 84 +++++++++++++++----
 .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
 3 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 39d8ee38c338..76afdbea425a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -638,11 +638,34 @@ static void print_liveness(struct bpf_verifier_env *env,
 		verbose(env, "D");
 }
 
-static int get_spi(s32 off)
+static int __get_spi(s32 off)
 {
 	return (-off - 1) / BPF_REG_SIZE;
 }
 
+static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	int off, spi;
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env, "dynptr has to be at a constant offset\n");
+		return -EINVAL;
+	}
+
+	off = reg->off + reg->var_off.value;
+	if (off % BPF_REG_SIZE) {
+		verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
+		return -EINVAL;
+	}
+
+	spi = __get_spi(off);
+	if (spi < 1) {
+		verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
+		return -EINVAL;
+	}
+	return spi;
+}
+
 static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
 {
 	int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
@@ -754,7 +777,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	enum bpf_dynptr_type type;
 	int spi, i, id;
 
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
 
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return -EINVAL;
@@ -792,7 +817,9 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	struct bpf_func_state *state = func(env, reg);
 	int spi, i;
 
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
 
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return -EINVAL;
@@ -844,7 +871,11 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return false;
 
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return false;
+
+	/* We will do check_mem_access to check and update stack bounds later */
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return true;
 
@@ -860,14 +891,15 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi;
-	int i;
+	int spi, i;
 
 	/* This already represents first slot of initialized bpf_dynptr */
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return true;
 
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return false;
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
 	    !state->stack[spi].spilled_ptr.dynptr.first_slot)
 		return false;
@@ -896,7 +928,9 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
 	if (reg->type == CONST_PTR_TO_DYNPTR) {
 		return reg->dynptr.type == dynptr_type;
 	} else {
-		spi = get_spi(reg->off);
+		spi = dynptr_get_spi(env, reg);
+		if (spi < 0)
+			return false;
 		return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
 	}
 }
@@ -2429,7 +2463,9 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
 	 */
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return 0;
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
 	/* Caller ensures dynptr is valid and initialized, which means spi is in
 	 * bounds and spi is the first dynptr slot. Simply mark stack slot as
 	 * read.
@@ -5992,12 +6028,15 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	}
 	/* CONST_PTR_TO_DYNPTR already has fixed and var_off as 0 due to
 	 * check_func_arg_reg_off's logic. We only need to check offset
-	 * alignment for PTR_TO_STACK.
+	 * and its alignment for PTR_TO_STACK.
 	 */
-	if (reg->type == PTR_TO_STACK && (reg->off % BPF_REG_SIZE)) {
-		verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
-		return -EINVAL;
+	if (reg->type == PTR_TO_STACK) {
+		int err = dynptr_get_spi(env, reg);
+
+		if (err < 0)
+			return err;
 	}
+
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
 	 *		 constructing a mutable bpf_dynptr object.
 	 *
@@ -6405,15 +6444,16 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	}
 }
 
-static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
 	int spi;
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return reg->ref_obj_id;
-
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
 	return state->stack[spi].spilled_ptr.ref_obj_id;
 }
 
@@ -6487,7 +6527,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 * PTR_TO_STACK.
 			 */
 			if (reg->type == PTR_TO_STACK) {
-				spi = get_spi(reg->off);
+				spi = dynptr_get_spi(env, reg);
+				if (spi < 0)
+					return spi;
 				if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
 				    !state->stack[spi].spilled_ptr.ref_obj_id) {
 					verbose(env, "arg %d is an unacquired reference\n", regno);
@@ -7977,13 +8019,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 			if (arg_type_is_dynptr(fn->arg_type[i])) {
 				struct bpf_reg_state *reg = &regs[BPF_REG_1 + i];
+				int ref_obj_id;
 
 				if (meta.ref_obj_id) {
 					verbose(env, "verifier internal error: meta.ref_obj_id already set\n");
 					return -EFAULT;
 				}
 
-				meta.ref_obj_id = dynptr_ref_obj_id(env, reg);
+				ref_obj_id = dynptr_ref_obj_id(env, reg);
+				if (ref_obj_id < 0) {
+					verbose(env, "verifier internal error: failed to obtain dynptr ref_obj_id\n");
+					return ref_obj_id;
+				}
+				meta.ref_obj_id = ref_obj_id;
 				break;
 			}
 		}
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
index a9229260a6ce..72800b1e8395 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
@@ -18,7 +18,7 @@ static struct {
 	const char *expected_verifier_err_msg;
 	int expected_runtime_err;
 } kfunc_dynptr_tests[] = {
-	{"not_valid_dynptr", "Expected an initialized dynptr as arg #1", 0},
+	{"not_valid_dynptr", "cannot pass in dynptr at an offset=-8", 0},
 	{"not_ptr_to_stack", "arg#0 expected pointer to stack or dynptr_ptr", 0},
 	{"dynptr_data_null", NULL, -EBADMSG},
 };
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 78debc1b3820..02d57b95cf6e 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -382,7 +382,7 @@ int invalid_helper1(void *ctx)
 
 /* A dynptr can't be passed into a helper function at a non-zero offset */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #3")
+__failure __msg("cannot pass in dynptr at an offset=-8")
 int invalid_helper2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -584,7 +584,7 @@ int invalid_read4(void *ctx)
 
 /* Initializing a dynptr on an offset should fail */
 SEC("?raw_tp")
-__failure __msg("invalid write to stack")
+__failure __msg("cannot pass in dynptr at an offset=0")
 int invalid_offset(void *ctx)
 {
 	struct bpf_dynptr ptr;
-- 
2.39.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2465A949
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 09:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjAAIeQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 03:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAAIeP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 03:34:15 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB462C9
        for <bpf@vger.kernel.org>; Sun,  1 Jan 2023 00:34:14 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id jl4so20045350plb.8
        for <bpf@vger.kernel.org>; Sun, 01 Jan 2023 00:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLkWU14WmaVOIV0tqxiIFoeAF1xV5RkRbjjIO40C4iY=;
        b=l10qKzG4Up4bb9yQ3I14MRAxHRx3jMDoey51I4dl3wVnbY8NHba9kbi6RzLO2yYVp4
         t6seaygZpxQknMPIeGOR+sh/SY5rirw3Rhh2K0xtOlX+YTpahdrUXh37qVHKqrkLZhkj
         cqeETVeEHXcN+mxPaWICx2nZWiad+PvM5JhPqdowoj14eLqBtALXrT5ZUgStgDPnNW2c
         M3qC09A7QKLVvrbUgHYs3TaWJimnzZxPUksgmrO+f3KGe8p5PDwp79hOkKr9g+KdJdh/
         n7VO/mMMZD6vgq5YmKLHQ4A0VxfrfDlwnZCzlo4ZBoEOaxzZctM+PcILfXnvMGQYaUik
         Eq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLkWU14WmaVOIV0tqxiIFoeAF1xV5RkRbjjIO40C4iY=;
        b=d063MVX4UXUi26gNP3egsfOH9O2fq4q+o7iEPF7R57US7FQBPjFrA0E9h1/0W+4FRv
         9Pk4b7ep43qeCFO6ysOA+jfEoE9LO6LITiaO8b7+fFF9Mptcb3BtWZ1b4SfqmeQHWkPY
         W5/D4u4uHRlCNHLIsANVokpYpiQnBP6Gpx4JFwKZuuw17jWmELiVTofW4Det8nQgjVo6
         3/uRIdYStxLXqBMuFUauXgvv8ryCEUDGoYo17rJXd8P96ooV5y5hYgv7HeDmdX41yYS0
         ArzEzpaLnlnAgs3YppneqLfrDhgPZv+2lhm+ox2343n2P0s0hnWNjEw7g4b/LinOPskE
         x/rw==
X-Gm-Message-State: AFqh2kqlPbgLWwmLtpNE5mb7VK/Ok/ZJUxFCdfBoImyBT99kpfkiMbiW
        VeQlp99ES3om2sVnaMlOEwsdt7xQ7Iq5OqJt
X-Google-Smtp-Source: AMrXdXu6qjkZw+S9hUxa/ml51vzi4kfrD7nrjSB4JXGp98+wrYTvtEjQ0AlcvaF0atyRzUWpluxcoQ==
X-Received: by 2002:a17:90a:348d:b0:223:d8c3:c714 with SMTP id p13-20020a17090a348d00b00223d8c3c714mr39124252pjb.37.1672562053582;
        Sun, 01 Jan 2023 00:34:13 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id x14-20020a63fe4e000000b004a281fb63c3sm344326pgj.87.2023.01.01.00.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 00:34:13 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/8] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
Date:   Sun,  1 Jan 2023 14:03:56 +0530
Message-Id: <20230101083403.332783-3-memxor@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101083403.332783-1-memxor@gmail.com>
References: <20230101083403.332783-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9589; i=memxor@gmail.com; h=from:subject; bh=7eS+FfjKMNjLuzgV/2TcTA00hQwDINQ+MVG3xTyYlxo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjsUV0sdEDUpGefJ6GxRdyBvdJfHo05NhYPHU1/6Zl N30f8CuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY7FFdAAKCRBM4MiGSL8Ryh2VD/ 9MDJCs1kKaHratXkiwlQcN3pq7RfD6Ypwdv58wZFg/PAkcN4dYke8GPCq6Bvth3Ii/a86pn8I6q62r Dykn9SvYom6OegZbsFvKQKgYnFV+79taFNQ6CLNrilKUXRoYCQ67kYEHOlS2NrB5z6HPWdhCASy/wd YH5af43shVmLbXZMwuCTbJI+CIQCxKuD2Gv3x95fISFSql+psTbF71fX449rcqlpWPavYpp2PeJ6f8 Xa3P9KNZLRIF0HOw6dKAhJ+DZMS/XcVRNyp7Q6jH16BvkdHfhq4B4cLsMVHNnOfIsTcj7OvWcDalAa FbMlgxfuaI4QIOmeIk98KZ5nqOeB/5AexG/NiciGINDORbUPwghhsbQSufK1EuN/xin+1+aMlNMvCt R61eXJqOR3MQF3mNtf/m/bCOSE7SVcoKrPAwRRJtD2PIGoMiTGUFd+4jRaqkcjPHAgdDyskMUupZHY T0unfezCyjMX/ISvcjQG3B8mdwnXnriG0KvuDI/uPw3q63R42d6Q6wwOxLniS8uAwLgii4HMlYy3hF XMIpaV99QwOz2jU6lkCxK72Y+2Nn5jtVMDT0JHkMjyhWT+G9N68LF+07DnB9LJ+ish8b24+e+WLVA5 ZQw0ACc0j25hBEUq274i3QAq2L3PIQBED3OEdYCgxjBf4CaNFWPT1rslueMQ==
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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 83 ++++++++++++++-----
 .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  6 +-
 3 files changed, 66 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f7248235e119..ca970f80e395 100644
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
+		verbose(env, "dynptr has to be at the constant offset\n");
+		return -EINVAL;
+	}
+
+	off = reg->off + reg->var_off.value;
+	if (off % BPF_REG_SIZE) {
+		verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
+		return -EINVAL;
+	}
+
+	spi = __get_spi(off);
+	if (spi < 1) {
+		verbose(env, "cannot pass in dynptr at an offset=%d\n", (int)(off + reg->var_off.value));
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
@@ -839,7 +866,11 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return false;
 
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
+
+	/* We will do check_mem_access to check and update stack bounds later */
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return true;
 
@@ -855,14 +886,15 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
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
@@ -891,7 +923,9 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
 	if (reg->type == CONST_PTR_TO_DYNPTR) {
 		return reg->dynptr.type == dynptr_type;
 	} else {
-		spi = get_spi(reg->off);
+		spi = dynptr_get_spi(env, reg);
+		if (WARN_ON_ONCE(spi < 0))
+			return false;
 		return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
 	}
 }
@@ -2422,7 +2456,9 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
 	 */
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return 0;
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (WARN_ON_ONCE(spi < 0))
+		return spi;
 	/* Caller ensures dynptr is valid and initialized, which means spi is in
 	 * bounds and spi is the first dynptr slot. Simply mark stack slot as
 	 * read.
@@ -5946,6 +5982,11 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+static bool arg_type_is_release(enum bpf_arg_type type)
+{
+	return type & OBJ_RELEASE;
+}
+
 /* There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
  * which points to a stack slot, and the other is CONST_PTR_TO_DYNPTR.
  *
@@ -5986,12 +6027,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
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
+		err = dynptr_get_spi(env, reg);
+		if (err < 0)
+			return err;
 	}
+
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
 	 *		 constructing a mutable bpf_dynptr object.
 	 *
@@ -6070,11 +6113,6 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
 	       type == ARG_CONST_SIZE_OR_ZERO;
 }
 
-static bool arg_type_is_release(enum bpf_arg_type type)
-{
-	return type & OBJ_RELEASE;
-}
-
 static bool arg_type_is_dynptr(enum bpf_arg_type type)
 {
 	return base_type(type) == ARG_PTR_TO_DYNPTR;
@@ -6404,8 +6442,9 @@ static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return reg->ref_obj_id;
-
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (WARN_ON_ONCE(spi < 0))
+		return U32_MAX;
 	return state->stack[spi].spilled_ptr.ref_obj_id;
 }
 
@@ -6479,7 +6518,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
index 78debc1b3820..32df3647b794 100644
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
@@ -444,7 +444,7 @@ int invalid_write2(void *ctx)
  * non-const offset
  */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #1")
+__failure __msg("arg 1 is an unacquired reference")
 int invalid_write3(void *ctx)
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
2.39.0


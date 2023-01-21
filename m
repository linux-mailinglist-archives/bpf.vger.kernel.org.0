Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4367625C
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjAUAZg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjAUAZf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:25:35 -0500
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE47E13511
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:25:04 -0800 (PST)
Received: by mail-pj1-f68.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso6429175pjf.1
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbfmok1bo7nEVSKUA385ZnbR9z6ipfMuo+sDIvn1aHs=;
        b=ZhxyBSygKIMnQajII8HjjdJmdOc4O2Nis31eLblQSYlcVXVXEdmcccG+QGH0RsxrNx
         Fn5zNYRbuJVpk5t1x2bUF02WB6zU7FwxsvOLXY0TF2SEM5EjOgmh8XZxUmejxcnVS+QS
         eE5/jCUEW2JlJiXEK8nxflMQRrVBq2mhDzD3EqDSsB2VLBzNBK4r186NETY/LrVVqt5C
         Ss+A4BxhDFDDsFLclfSN/q35KQb0CTk7v4CPaS8Wq5h7WlIotr8xL2ulubwlLujDAO+y
         nyyNepLhowxyj+9SfMlYGbtYiaz8bKyz8OV1NoVHGybM62hj9UYuNMsyx3EW5sm2PCPC
         97hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbfmok1bo7nEVSKUA385ZnbR9z6ipfMuo+sDIvn1aHs=;
        b=qinsONzByXLyB1yQNY+ra1o0TQCsf86Fx6Tli9lp/EwD2kMN6GDiQj/v9zI33xEQSI
         lQxqPSS1XZDR91GjG+/3dfNUY2IxyPUnjmrd71rs9KFGQsmm5xOpASPmV0zqfwYFA1Dt
         P/izcTSlkezODe1RBCeabYcC1pAaYBovbC7F2hcGVTugz+I1YUfkO2jlNgqfwGItKKWz
         x+tURAY1IG5Vo7YUNDoShXQoEcXPmz+R8y1BiEArNtsam3cAVA/VPsylWNWx2+wDfRHW
         5eoPFi4+XP6bPWrz31siRCaa9AhU/vwJLVxi4bkTxd9MHBrrqkmVr9/e0KoRbljk3GF5
         DL/w==
X-Gm-Message-State: AFqh2kpu9YYdoTDJnrMbkvj1/A82PZjpw3I6+daCN5GFIiGf+ru6uvve
        m2/PJkF+PhzHWq9G9BAGkM9Xb8oDMkc=
X-Google-Smtp-Source: AMrXdXuaDIJ4l0VzoEWkp33C6HmRyLbXCchXJa0g0i1UpWQcCyCopE+/6ul6/J8RJNDLQVeXqnNfMQ==
X-Received: by 2002:a17:90a:30d:b0:225:f901:ebf8 with SMTP id 13-20020a17090a030d00b00225f901ebf8mr16927319pje.18.1674260572893;
        Fri, 20 Jan 2023 16:22:52 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090a394400b0022698aa22d9sm2096980pjf.31.2023.01.20.16.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:22:52 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 02/12] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
Date:   Sat, 21 Jan 2023 05:52:31 +0530
Message-Id: <20230121002241.2113993-3-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
References: <20230121002241.2113993-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9553; i=memxor@gmail.com; h=from:subject; bh=2s1pBDiiXTIV1BB1rUUx54yULFT49RyHEefJ0HCSxfo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyzAjl2cE3exe3tS2y0dU5xdJr1Vgd0s+vbl8nS4L rp+xG4SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8swIwAKCRBM4MiGSL8Ryuv4EA CH/EiO4/PCPaAVauR1vQJQ5KOEMVNvFwBYVtQl8T59gjRtYfTQDIb1EUBqFkDiGtK9ZdpLrYCGmvad GoOUvVu4/RiAx1+W/iyzwPRYBceG0lai35ibybMr9FTTlv3hj6Go6P0inGzSJr++lHuhebjMzGfb/q vk4LMIIbas5KJOlGnH706wXeHnIWPAANKBQuAhZP7rEqY03UzFSZc2emTEi2l7fY8kK8Z40m6+AGoO /TKNSpK5uM0m9FDmC0uy80YpHuuQfeGsjH54F5GcYLBCN2BsZe9ulOAnpVFCM9KDSdG9tSYF176ufp hFtXCotwHE25MfGRNDOacjZTozYs6jT2QF0jW/JNQ5aWEOnpRO0XkyMXorw4fWmShCP2SW6ctkuPKP mMv6jYt9NGheBRJ7B5/gynlbPLfAzf3y2rVVIloDHMnr/LId+UVnfPW9UDNl2YdRpRmfiSmFMN31DG 6bjbZNrSb+jKFI12jYvyRiJuj5+Kp7GtE1u2LgNUENqo2bvzzOY3ElNFYY/2p1eCX3kT/KfCHYd8Qs 0+f+ye92l9wfoysohoQJ6r8fs29ZvxXEo9rV23TFyGsqBC3jGySvSdWDHUtc1ycu17XQU4OGtqztv4 1laB5wRfTm9UJkns6wEc8e70CVDzxnOpvL8niRuFA1+kGJGJqdyADnhanm/Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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


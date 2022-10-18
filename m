Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC2602DB6
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiJROAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJRN74 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 09:59:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF03ECE9
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p14so14168448pfq.5
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cHKgfMxfRcBLnSN/RhbiQD5k8u+SrqxjXlNV53Xio4=;
        b=WFHb42vw3HzG0YWxgVjeO7IWyQZ7vOI+ygUYphNhp+T2tH/sc/kdAXH3OVGjrXPZbV
         ql4GS9YPUOmW88KNIckigq7YsNggo9dnyknTGHbm3ibSBhb90dcWvgyWoUq/KDShrZ2B
         NtsOOPyKf2yEPa3y4ee2CHEFMKcIHbbhfZD/kMxhx+Zz36cdAtB27zo8WUksJ7nDacu4
         pU4c86uy2O5m6Nl1rbdUM5Bo7kHb/0pasFavftOMoaxWdE+lM5bTwwfuv8HTRf8dBnoT
         71XIWtKcHsljq9JLch+poFCZ1OVrLlYL2PNrh6XhjcWfkhbJiVqaRsV1UH1GZ3lNH/s4
         2xHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cHKgfMxfRcBLnSN/RhbiQD5k8u+SrqxjXlNV53Xio4=;
        b=cL+P747MkkMMVPpAkXAugVpntNevcwWliUTJgRrXIqY3dsEziOB4XUuViqKz2QNXmv
         LbLzs2ktI1JyOoXiyjmLGsjqTKstn16q6oLRzxMzNluKCYqihe3X5E7SkCuXCG+8hbup
         h4AYdO7WdtPTTF3hzQioMWAhKGlDCEJ/ixMvSh+0HyfV4WxYOazjn6GDU3tGu6vDj1kD
         CG4sE5rMrSrXSRewESnaeqtsUEMbFIFPlQEydAlwUflnnzeRIye258zgkSOQkzNb68kB
         eRZj3wZnHwfCRFnYYoM/oFF+k+M9hFIThqrfT1zKo4qBZPZTbSDpHJSPfCiR/ur1tzjL
         uPzg==
X-Gm-Message-State: ACrzQf0B2TuANfjXtGRdvQK6EEFX1fpcG3tXrvxSltK0s7y/MygGmrlm
        DzN/2gX8LuX5C38NS45dj0d3Nfhi+9ZfKg==
X-Google-Smtp-Source: AMsMyM6rXgNMJ4NZ3TTPanLF/bsEENTrpZIWtMLVAj5A3hifUMEjVYp4/ktG4HdGXCYWl4o3WdLD1A==
X-Received: by 2002:a05:6a00:21c6:b0:563:9169:3a4c with SMTP id t6-20020a056a0021c600b0056391693a4cmr3464056pfj.56.1666101589012;
        Tue, 18 Oct 2022 06:59:49 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id a188-20020a6366c5000000b00460ea630c1bsm8160387pgc.46.2022.10.18.06.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:59:48 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 06/13] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
Date:   Tue, 18 Oct 2022 19:29:13 +0530
Message-Id: <20221018135920.726360-7-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9846; i=memxor@gmail.com; h=from:subject; bh=HP2s1vl4++9YP8xLPS535iwMoswch8EjwABHeVDtj3Q=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEi6cwODdyDzmVuM4xhVFKgMSxvT7vFYpH1MoSa dIUucxuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8RygHlEA CCdgwaouAYKU8ko/gGj9NM2lsKSgJVn/1inhwywE0RTO/fkxaCZjITDnKSMD2MoVnR3iogpqOJlbXR FJhgHmLoV2nGTFmqjaDfgqeK3NcCQrlr/9EbvHQ8inGvZxgpovrbYW6F7/vCVhYFTn07bm70hyjmQy wUUxeEJ2oWBOZx+LIfwbXaFn+n/OA+URRwB2roenNSub2ITetCVYpPj5jdjGa7XjqN+ATrhYShGZyt Tfy8MYntGadmvuGg3kbcs5RjBumVYSNlSKjb46hzPQA/DFflCEkugQ9F/sMSyJ4SPwFDGhNxFgbvtm eKA8V2f2Max1JRZFUCZUd0vrZzf8o2ZOqSgM1A5PDORj+rWQ7BqxtY41s20CijPvZY37/0RxEhNj+3 wJE54CvQTu2eo6yfjMQ+XBJ6NsHbyLAGL8M65n+CiZMWGx18RTyWlRN0EFgOHDXGhlcR+RgM/6TrEb C/KKdJ6rI5r35YjeRjnZ6k7YKNN/9hr9ShJirAP63JrUWxkT7RuKiNhr+5auFEmSqUjL6IMILfAGF9 ZtrFJWQBLn8+uzEd2Cuu6UXaWlfqXioXarBhQOm+rBBaFzc6lsJcifGx1tFwxict6oHODIHP3EmFHz K5ZJJ12JJrv24gNhVc1vhpoV7e6ZdVESWouvrnqIzk9yTh3ic9llss/L97AA==
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
 kernel/bpf/verifier.c                         | 80 +++++++++++++++----
 .../testing/selftests/bpf/prog_tests/dynptr.c |  6 +-
 .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
 3 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f667180f70f..0fd73f96c5e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -610,11 +610,34 @@ static void print_liveness(struct bpf_verifier_env *env,
 		verbose(env, "D");
 }
 
-static int get_spi(s32 off)
+static int __get_spi(s32 off)
 {
 	return (-off - 1) / BPF_REG_SIZE;
 }
 
+static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	int spi;
+
+	if (reg->off % BPF_REG_SIZE) {
+		verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
+		return -EINVAL;
+	}
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env, "dynptr has to be at the constant offset\n");
+		return -EINVAL;
+	}
+
+	spi = __get_spi(reg->off + reg->var_off.value);
+	if (spi < 1) {
+		verbose(env, "cannot pass in dynptr at an offset=%d\n",
+			(int)(reg->off + reg->var_off.value));
+		return -EINVAL;
+	}
+	return spi;
+}
+
 static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
 {
 	int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
@@ -725,7 +748,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	enum bpf_dynptr_type type;
 	int spi, i, id;
 
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
 
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return -EINVAL;
@@ -763,7 +788,9 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	struct bpf_func_state *state = func(env, reg);
 	int spi, i;
 
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
 
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return -EINVAL;
@@ -810,7 +837,11 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
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
 
@@ -826,14 +857,15 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
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
@@ -864,7 +896,9 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
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
@@ -2388,7 +2422,9 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
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
@@ -5663,6 +5699,11 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+static bool arg_type_is_release(enum bpf_arg_type type)
+{
+	return type & OBJ_RELEASE;
+}
+
 /* Implementation details:
  *
  * There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
@@ -5710,6 +5751,13 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 		return -EINVAL;
 	}
 
+	/* Additional check for PTR_TO_STACK offset */
+	if (reg->type == PTR_TO_STACK) {
+		err = dynptr_get_spi(env, reg);
+		if (err < 0)
+			return err;
+	}
+
 	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
 	 *
@@ -5728,7 +5776,6 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 *		 destroyed, including mutation of the memory it points
 	 *		 to.
 	 */
-
 	if (arg_type & MEM_UNINIT) {
 		if (!is_dynptr_reg_valid_uninit(env, reg)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
@@ -5791,11 +5838,6 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
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
@@ -6122,7 +6164,9 @@ static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return reg->ref_obj_id;
-	spi = get_spi(reg->off);
+	spi = dynptr_get_spi(env, reg);
+	if (WARN_ON_ONCE(spi < 0))
+		return U32_MAX;
 	return state->stack[spi].spilled_ptr.ref_obj_id;
 }
 
@@ -6190,7 +6234,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			int spi;
 
 			if (reg->type == PTR_TO_STACK) {
-				spi = get_spi(reg->off);
+				spi = dynptr_get_spi(env, reg);
+				if (spi < 0)
+					return spi;
 				if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
 				    !state->stack[spi].spilled_ptr.ref_obj_id) {
 					verbose(env, "arg %d is an unacquired reference\n", regno);
diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 8fc4e6c02bfd..947126d217bd 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -27,16 +27,16 @@ static struct {
 	{"data_slice_missing_null_check1", "invalid mem access 'mem_or_null'"},
 	{"data_slice_missing_null_check2", "invalid mem access 'mem_or_null'"},
 	{"invalid_helper1", "invalid indirect read from stack"},
-	{"invalid_helper2", "Expected an initialized dynptr as arg #3"},
+	{"invalid_helper2", "cannot pass in dynptr at an offset=-8"},
 	{"invalid_write1", "Expected an initialized dynptr as arg #1"},
 	{"invalid_write2", "Expected an initialized dynptr as arg #3"},
-	{"invalid_write3", "Expected an initialized dynptr as arg #1"},
+	{"invalid_write3", "arg 1 is an unacquired reference"},
 	{"invalid_write4", "arg 1 is an unacquired reference"},
 	{"invalid_read1", "invalid read from stack"},
 	{"invalid_read2", "cannot pass in dynptr at an offset"},
 	{"invalid_read3", "invalid read from stack"},
 	{"invalid_read4", "invalid read from stack"},
-	{"invalid_offset", "invalid write to stack"},
+	{"invalid_offset", "cannot pass in dynptr at an offset=0"},
 	{"global", "type=map_value expected=fp"},
 	{"release_twice", "arg 1 is an unacquired reference"},
 	{"release_twice_callback", "arg 1 is an unacquired reference"},
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
index fc562e863e79..e4b970bc2d3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
@@ -18,7 +18,7 @@ static struct {
 	const char *expected_verifier_err_msg;
 	int expected_runtime_err;
 } kfunc_dynptr_tests[] = {
-	{"not_valid_dynptr", "Expected an initialized dynptr as arg #1", 0},
+	{"not_valid_dynptr", "cannot pass in dynptr at an offset=-8", 0},
 	{"not_ptr_to_stack", "arg#0 pointer type STRUCT bpf_dynptr_kern not to stack", 0},
 	{"dynptr_data_null", NULL, -EBADMSG},
 };
-- 
2.38.0


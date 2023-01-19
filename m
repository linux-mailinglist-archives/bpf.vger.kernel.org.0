Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FF1672EB2
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjASCO7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjASCO6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:14:58 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A424E45BE4
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:14:56 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v23so992221plo.1
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ6M0fYb+kKSjua9KImxru1Mcnu2oPYISTytAcNabI8=;
        b=Q2vXGr7mIO7Agys0E9m7pRqTYLsZQ1WpzVY5X8BvptxrdtxIn0gCRDt2ZMYeq0PjcU
         DPcU9FCb6B4ZqykkPlq3e+JoO/XQ0PdwCyq2yC0RL67fUwd6icaV8mwd9rwPuJiLes0f
         nM9JuZdIPHTZGFmWl+4e7CahGFEYVEKG/Ik0og2XlYRqawYRG03AgaUGE2Y8SOgDAqI0
         eBRsNAJ4HeBwKEMxZzilEhMEXtczkFA54P2XCe/5YKHpzEs1ZtVhs8mvGPVvp0R3plhl
         EemiHNJuWL7ooVUSWEW0QLoQyrxaPndm3alIkprtUacHOVJOZO4QqCaEVDjXorQIAsh5
         2mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ6M0fYb+kKSjua9KImxru1Mcnu2oPYISTytAcNabI8=;
        b=hkA02JqE6iSxYvLcZ8q5taT73O1KqUZ/8b4AcBLeIm8Zif1WkR8pLtghgeXJZntmU4
         Y62K0HTZiTXHivmLMMXRiCaWZ52tHONFlB5gT7akHV7Uu9w9boyu+clbBk5+7wwoCulM
         8+D02N3YfrLlPzouIgVgMQnNwkp/L+WIQj01OnqIr+9mh3B15TyABQcUn1IbVMvz91PJ
         Lp2AIyxuwetSK21Tbkwh12lsz0fJ8QswckeySs9qEbh0l4beXBml6EbdiVux7QBu8AdV
         kwp1KpYxlcF9nDyjDKxaWcE4KiMhZ6joDgbaIg7rginN32PEYlqsBn8l6j9XXEyqYsYj
         eTSw==
X-Gm-Message-State: AFqh2kqACZTxrJDBBNR3O3uRz0yc6puNWkhMRJi7k2HeUgTwJ44H9N/r
        g2UxScMvHw3Zxz1iy0/RB9LVQWoXpbE=
X-Google-Smtp-Source: AMrXdXuN0MYrxl10rxkSEHHIa6J3pOB7KV/CtOtmjNX+LPzMbpvhj9WLiPU9NXcmmt/SbNAgWNf5ug==
X-Received: by 2002:a17:902:f304:b0:194:6e8d:89af with SMTP id c4-20020a170902f30400b001946e8d89afmr8445839ple.27.1674094495822;
        Wed, 18 Jan 2023 18:14:55 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b00192f7f8db8esm10611676plr.297.2023.01.18.18.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:14:55 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 03/11] bpf: Fix partial dynptr stack slot reads/writes
Date:   Thu, 19 Jan 2023 07:44:34 +0530
Message-Id: <20230119021442.1465269-4-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119021442.1465269-1-memxor@gmail.com>
References: <20230119021442.1465269-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9385; i=memxor@gmail.com; h=from:subject; bh=Cepeq0DQIm/49c5PYR07xlZ5eiGiFAAUzkDv0sGQ9oM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyKc/NZG7jF+/PcTgBNnX5rOifEQuhXLO4xkXapxO s7PW0SuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8inPwAKCRBM4MiGSL8Ryr0zD/ 9Ji9DlyHOW06DyOovxJ7ESTGhVDgPkG24oucwFFmcrU4xEkq1Rn5AvdjvJUcWEl4rJ666tLTgcXN5u +1Yw3Fkz7qrRH+XUjoBWlvI7Hb3IovxX1/dYEdAnh6bBYb6YDdF+NHDzSWugBZ/A9+xMRNLmRHfTMl g+KcE9PE1VaqEAv9MTRz6ZxHswT40/yskbNa4dZsrlqY98smoKL98UIZDj7Mzha0BL7oNoB08/aJ10 b6bO0mlrBhWfJd1at20uffdW6L1rRJlnkh4CVZnOoUeu85Aun2gd18y3a9upKdUmGapMnnbv4FjglD MJPvc5lgii7+LfQX6nygbZF5QDVUX1B7/gEm8D4ehaTsoDBVX/Zq7GmwmF6PGBUTljFQXl+VhZlpsZ 4UouUk1aEsMg8OtvSCDQArCVJ+bP4q3Cvbb4u92GsIV8xJnbV2grEUiTLY40f/VfAWP4AxVU/u7ouY EVLTNxpfScyjtE0elC6lx0kQJm2u5hb1UOD0C1n6/AcBgQ/QQD7Cj7qHb3DBvFJ0ADkVyLTVp+zSuO Xyz6IVFjZzuel8frXcp2EyiymGWXjQDAvRZnRC5b1oLzOsPXBu/wg9Io3XiBENtgMaX7TFZsZzMSFP LTrm2Y23jESyZLaLALxDfOkhLXQlHcUaeRQKELIJO34OKokOnDXXALP7YwDQ==
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

Currently, while reads are disallowed for dynptr stack slots, writes are
not. Reads don't work from both direct access and helpers, while writes
do work in both cases, but have the effect of overwriting the slot_type.

While this is fine, handling for a few edge cases is missing. Firstly,
a user can overwrite the stack slots of dynptr partially.

Consider the following layout:
spi: [d][d][?]
      2  1  0

First slot is at spi 2, second at spi 1.
Now, do a write of 1 to 8 bytes for spi 1.

This will essentially either write STACK_MISC for all slot_types or
STACK_MISC and STACK_ZERO (in case of size < BPF_REG_SIZE partial write
of zeroes). The end result is that slot is scrubbed.

Now, the layout is:
spi: [d][m][?]
      2  1  0

Suppose if user initializes spi = 1 as dynptr.
We get:
spi: [d][d][d]
      2  1  0

But this time, both spi 2 and spi 1 have first_slot = true.

Now, when passing spi 2 to dynptr helper, it will consider it as
initialized as it does not check whether second slot has first_slot ==
false. And spi 1 should already work as normal.

This effectively replaced size + offset of first dynptr, hence allowing
invalid OOB reads and writes.

Make a few changes to protect against this:
When writing to PTR_TO_STACK using BPF insns, when we touch spi of a
STACK_DYNPTR type, mark both first and second slot (regardless of which
slot we touch) as STACK_INVALID. Reads are already prevented.

Second, prevent writing	to stack memory from helpers if the range may
contain any STACK_DYNPTR slots. Reads are already prevented.

For helpers, we cannot allow it to destroy dynptrs from the writes as
depending on arguments, helper may take uninit_mem and dynptr both at
the same time. This would mean that helper may write to uninit_mem
before it reads the dynptr, which would be bad.

PTR_TO_MEM: [?????dd]

Depending on the code inside the helper, it may end up overwriting the
dynptr contents first and then read those as the dynptr argument.

Verifier would only simulate destruction when it does byte by byte
access simulation in check_helper_call for meta.access_size, and
fail to catch this case, as it happens after argument checks.

The same would need to be done for any other non-trivial objects created
on the stack in the future, such as bpf_list_head on stack, or
bpf_rb_root on stack.

A common misunderstanding in the current code is that MEM_UNINIT means
writes, but note that writes may also be performed even without
MEM_UNINIT in case of helpers, in that case the code after handling meta
&& meta->raw_mode will complain when it sees STACK_DYNPTR. So that
invalid read case also covers writes to potential STACK_DYNPTR slots.
The only loophole was in case of meta->raw_mode which simulated writes
through instructions which could overwrite them.

A future series sequenced after this will focus on the clean up of
helper access checks and bugs around that.

Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 102 ++++++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 2 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eeb6f1b2bd60..09c09d9bfd89 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -769,6 +769,8 @@ static void mark_dynptr_cb_reg(struct bpf_reg_state *reg,
 	__mark_dynptr_reg(reg, type, true);
 }
 
+static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
+				        struct bpf_func_state *state, int spi);
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   enum bpf_arg_type arg_type, int insn_idx)
@@ -863,6 +865,69 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	return 0;
 }
 
+static void __mark_reg_unknown(const struct bpf_verifier_env *env,
+			       struct bpf_reg_state *reg);
+
+static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
+				        struct bpf_func_state *state, int spi)
+{
+	int i;
+
+	/* We always ensure that STACK_DYNPTR is never set partially,
+	 * hence just checking for slot_type[0] is enough. This is
+	 * different for STACK_SPILL, where it may be only set for
+	 * 1 byte, so code has to use is_spilled_reg.
+	 */
+	if (state->stack[spi].slot_type[0] != STACK_DYNPTR)
+		return 0;
+
+	/* Reposition spi to first slot */
+	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
+		spi = spi + 1;
+
+	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
+		verbose(env, "cannot overwrite referenced dynptr\n");
+		return -EINVAL;
+	}
+
+	mark_stack_slot_scratched(env, spi);
+	mark_stack_slot_scratched(env, spi - 1);
+
+	/* Writing partially to one dynptr stack slot destroys both. */
+	for (i = 0; i < BPF_REG_SIZE; i++) {
+		state->stack[spi].slot_type[i] = STACK_INVALID;
+		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
+	}
+
+	/* Invalidate any slices associated with this dynptr */
+	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
+		int ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
+		struct bpf_func_state *fstate;
+		struct bpf_reg_state *reg;
+
+		bpf_for_each_reg_in_vstate(env->cur_state, fstate, reg, ({
+			if (reg->ref_obj_id == ref_obj_id) {
+				if (!env->allow_ptr_leaks)
+					__mark_reg_not_init(env, reg);
+				else
+					__mark_reg_unknown(env, reg);
+			}
+		}));
+	}
+
+	/* Do not release reference state, we are destroying dynptr on stack,
+	 * not using some helper to release it. Just reset register.
+	 */
+	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
+	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
+
+	/* Same reason as unmark_stack_slots_dynptr above */
+	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
+	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
+
+	return 0;
+}
+
 static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
@@ -3391,6 +3456,10 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			env->insn_aux_data[insn_idx].sanitize_stack_spill = true;
 	}
 
+	err = destroy_if_dynptr_stack_slot(env, state, spi);
+	if (err)
+		return err;
+
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
@@ -3504,6 +3573,14 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
+	for (i = min_off; i < max_off; i++) {
+		int spi;
+
+		spi = __get_spi(i);
+		err = destroy_if_dynptr_stack_slot(env, state, spi);
+		if (err)
+			return err;
+	}
 
 	/* Variable offset writes destroy any spilled pointers in range. */
 	for (i = min_off; i < max_off; i++) {
@@ -5531,6 +5608,31 @@ static int check_stack_range_initialized(
 	}
 
 	if (meta && meta->raw_mode) {
+		/* Ensure we won't be overwriting dynptrs when simulating byte
+		 * by byte access in check_helper_call using meta.access_size.
+		 * This would be a problem if we have a helper in the future
+		 * which takes:
+		 *
+		 *	helper(uninit_mem, len, dynptr)
+		 *
+		 * Now, uninint_mem may overlap with dynptr pointer. Hence, it
+		 * may end up writing to dynptr itself when touching memory from
+		 * arg 1. This can be relaxed on a case by case basis for known
+		 * safe cases, but reject due to the possibilitiy of aliasing by
+		 * default.
+		 */
+		for (i = min_off; i < max_off + access_size; i++) {
+			int stack_off = -i - 1;
+
+			spi = __get_spi(i);
+			/* raw_mode may write past allocated_stack */
+			if (state->allocated_stack <= stack_off)
+				continue;
+			if (state->stack[spi].slot_type[stack_off % BPF_REG_SIZE] == STACK_DYNPTR) {
+				verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
+				return -EACCES;
+			}
+		}
 		meta->access_size = access_size;
 		meta->regno = regno;
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 02d57b95cf6e..9dc3f23a8270 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -420,7 +420,7 @@ int invalid_write1(void *ctx)
  * offset
  */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #3")
+__failure __msg("cannot overwrite referenced dynptr")
 int invalid_write2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -444,7 +444,7 @@ int invalid_write2(void *ctx)
  * non-const offset
  */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #1")
+__failure __msg("cannot overwrite referenced dynptr")
 int invalid_write3(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -476,7 +476,7 @@ static int invalid_write4_callback(__u32 index, void *data)
  * be invalidated as a dynptr
  */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("cannot overwrite referenced dynptr")
 int invalid_write4(void *ctx)
 {
 	struct bpf_dynptr ptr;
-- 
2.39.1


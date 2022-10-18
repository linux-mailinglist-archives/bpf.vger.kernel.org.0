Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01752602DB7
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiJROAC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiJRN75 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 09:59:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF3558C4
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso17418345pja.5
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEas3sHBE0VIucB962Ttze9x3m2xbgs7+/0A1P4FfmI=;
        b=P3pV10JyNUT3/Isn+Vhb93GBZ1yRJAMXRzfCEyOgcJe/tQJXmAesq64oy7MZPPZEB8
         bK/mebiozuuYI4W7POy+hlvKFoK7K0AKBt8bNIVX4xznWv+/Lv+TSPrwg0LVhQnG1aDa
         CSREr9JUYqBJXbxAUwWbsh9d0bhyFbktcKmGMbRQkjZwG5Md1Ih2IdCaZ0pV29/x7hWK
         /OqgPImMW+yqPVdNmVl75xvvm5kbBL4dWiFZnaupr11Ig+RZgPtRXb2CQHDAb2Nm23NL
         mymf5smdrsLUJo5FjdEl+s5FaOYMC9tLfKnEgBHeSs8Z74tsv3NOi7LC01X2n0tQwg5S
         iF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEas3sHBE0VIucB962Ttze9x3m2xbgs7+/0A1P4FfmI=;
        b=5DepkpC9ygbfsYmdFDckeiKjxTIV+YcLnPfaE9fyBBn9itpjsugXFWYDO6+DIxBwlr
         sQjstJnDgtOsmgApJsg/+JQe/fYeVh9Gy9RQTPH0UCbz/G6R7gCdKYO4vxWSe7OUIeuv
         Wh+L0B2VX87usOJn5X4/catjGG9egAdb9/DeKWt+fBiWXi19k4ZGFvGrlFHWH5GaQuZA
         gdjDKjlL0HTZU2hinYCB8DNcA4S6Lr8uweu8XjKNRDgy0uVPJ2fRgwNC7tT9GRLWGORs
         BmKkWDVI6DZcMq4dfAA1MWuJxmJCCjWufSzDRtEIIvJpN6/fb6/VgIPhqWERUce9b7Bo
         J1ag==
X-Gm-Message-State: ACrzQf2Fbl8U5QLyQDY7pUPHTk2gmHlwCMxVprfS4gTGIXApVsC7+u7x
        1pfQCBK0mjQPsk6JBrsQ7pEkzJo8SfsMjQ==
X-Google-Smtp-Source: AMsMyM7ON8iZwf1/1fIQpd42FhlCKOLQbLhCBhL7syha7Z5m2+xq4QKTL8suxS8xxLqEWb4hRJqc8w==
X-Received: by 2002:a17:903:2307:b0:17f:78a5:5484 with SMTP id d7-20020a170903230700b0017f78a55484mr3240136plh.15.1666101592799;
        Tue, 18 Oct 2022 06:59:52 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id i6-20020a628706000000b00553b37c7732sm9218888pfe.105.2022.10.18.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:59:52 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 07/13] bpf: Fix partial dynptr stack slot reads/writes
Date:   Tue, 18 Oct 2022 19:29:14 +0530
Message-Id: <20221018135920.726360-8-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7778; i=memxor@gmail.com; h=from:subject; bh=RJRVR1fT/oS1JF7iDoYDuwVKzXdYOHNg/YrQkETwO1Q=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEidPPx4svIURqVZQdU2pvTS+nRVXs10MVGhkn4 nz802m+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8RysClEA CjGxB4JARJLDCziUOf1Q5/ON3o4hsvYB6V8V6LDWw8cHrY75PYTsPmFPJSYi0+B9Fq9fT9eZtCteGn JLQOPHAM7mD1wi1Qwg297cL2nuMLFnk/THvkpC6IIYNn5ITAg4K0pqyFPmgeALWB5bNWmJ/5kwN1Ur OdWnbOXe00/hqWGyk1Wh1mH9pMbQ3JSpRarzrVjBEwsz0bUrM1ygVT6zX4fD0iF7akQ5upWGPRc25C 1NOFu8DK0mqdWDbS+9t+L0c/1q2m0cnBUMCpsZClPoovzx0VnsSgPYWHdROJHHIiUjASX2o+QsA1DG 1b0Cse5XwFCoEJ7qz3lNgmiKw4cR9PTGLuxpPtRSPE1SMIPx0dpEsZWy28HqqD09gKAFDMhq9MH2w9 rfyTNGZzJ//AyKox7xgfAED9TlFiUBoCPiRqs/ABjHuD8xfZxy7ldwcJLMTeTOle/iF9nVsDokWuJV 5nUXqUyK9jBMTLOPa4k7XrBJ5MgSz7U+SyW5STLRINRQcKB3HlEwdbKZOBZeSzNiRyuT9Uj84JiUrU B2HlcD0q28E7iIFp+doiQ5sxrlRIKxs2iolMVGePMpY2kDixWICN+CmjnUkilKTY6QwOQIhgVx+ppu ATTvpJ79hSmeoefvqLWEPBJ9zEZIR0tA3mEVJmPuPoUWqfaJLrUOuaqN+/Rg==
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
 kernel/bpf/verifier.c | 76 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0fd73f96c5e2..89ae384ea6a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -740,6 +740,8 @@ static void mark_dynptr_cb_reg(struct bpf_reg_state *reg1,
 	__mark_dynptr_regs(reg1, NULL, type);
 }
 
+static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
+				       struct bpf_func_state *state, int spi);
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   enum bpf_arg_type arg_type, int insn_idx)
@@ -755,6 +757,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return -EINVAL;
 
+	destroy_stack_slots_dynptr(env, state, spi);
+	destroy_stack_slots_dynptr(env, state, spi - 1);
+
 	for (i = 0; i < BPF_REG_SIZE; i++) {
 		state->stack[spi].slot_type[i] = STACK_DYNPTR;
 		state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
@@ -829,6 +834,44 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	return 0;
 }
 
+static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
+				       struct bpf_func_state *state, int spi)
+{
+	int i;
+
+	/* We always ensure that STACK_DYNPTR is never set partially,
+	 * hence just checking for slot_type[0] is enough. This is
+	 * different for STACK_SPILL, where it may be only set for
+	 * 1 byte, so code has to use is_spilled_reg.
+	 */
+	if (state->stack[spi].slot_type[0] != STACK_DYNPTR)
+		return;
+	/* Reposition spi to first slot */
+	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
+		spi = spi + 1;
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
+	return;
+}
+
 static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
@@ -3183,6 +3226,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			env->insn_aux_data[insn_idx].sanitize_stack_spill = true;
 	}
 
+	destroy_stack_slots_dynptr(env, state, spi);
+
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
@@ -3296,6 +3341,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
+	for (i = min_off; i < max_off; i++) {
+		int slot, spi;
+
+		slot = -i - 1;
+		spi = slot / BPF_REG_SIZE;
+		destroy_stack_slots_dynptr(env, state, spi);
+	}
 
 	/* Variable offset writes destroy any spilled pointers in range. */
 	for (i = min_off; i < max_off; i++) {
@@ -5257,6 +5309,30 @@ static int check_stack_range_initialized(
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
+			slot = -i - 1;
+			spi = slot / BPF_REG_SIZE;
+			/* raw_mode may write past allocated_stack */
+			if (state->allocated_stack <= slot)
+				continue;
+			if (state->stack[spi].slot_type[slot % BPF_REG_SIZE] == STACK_DYNPTR) {
+				verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
+				return -EACCES;
+			}
+		}
 		meta->access_size = access_size;
 		meta->regno = regno;
 		return 0;
-- 
2.38.0


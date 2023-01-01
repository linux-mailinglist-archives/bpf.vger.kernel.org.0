Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D56365A94A
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 09:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAAIeU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 03:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAAIeT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 03:34:19 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306EB2AC5
        for <bpf@vger.kernel.org>; Sun,  1 Jan 2023 00:34:18 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z7so11297105pfq.13
        for <bpf@vger.kernel.org>; Sun, 01 Jan 2023 00:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrujwH51Ce0LjiV0lKl9NSqEeF9GoNHU8d2fm/eTaQY=;
        b=pzYXsgt1O4WgyDzxJ7X3b8F/CShjrLvaW1lIg8aifLw91XXvxwUszbGgHFJjCv9Eja
         s/dT6mluiLdaRAVe23DZlIjgz+wIqtsIzDzqZl+upBkKhKmDt9djip1si9cnHX7utLS7
         dyIe4tyI1PzbwpkpQyF4KdpVf0lVdia23RpV1WNzY0CG5kpOSajOFUjdB6e9lwpY4AHz
         wk2LOqQsVBFLjgKs606RE6jRYafXpMuLtGz0cII2w7lTjGUXVfHgyfy/GOKlFi69Fw1N
         mZaghIwbESooZZviFlrNXv3xwGfhzyQQmL+vgTy53Vd70G55angYZRQhiBJYZgApuyUX
         yRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrujwH51Ce0LjiV0lKl9NSqEeF9GoNHU8d2fm/eTaQY=;
        b=r61/RQ5WltR/fYtguzdDKFkuD71LTbx2rMnItpPG5rD7UZ122UQsTn7LN3oFiro8ly
         ZyY9cdkGnxVLNzEXHCCKHsJcoobtiFvq9sfdnmmeTdGMgYNcxiJtLKaZJyce+QRQgVoU
         BV5vD11XmzZOSK5t6bzSAARrwg0zA9zqPDZGmpAMKvqnM0WIsSwnMijPB/RCiAI4SGmm
         2ky6tAUvqxlQjzvoF0V2oyWRizmUOW4SbMqMGf2KgyhWE4sBLp7jkHepyXINJvILN0UQ
         8MZj2qbwuf6s0ckWMpR3E5Algl/0bs/RFjwH+EB4ltW8plABMFARwiGakMPDeVDCuJUH
         d1dA==
X-Gm-Message-State: AFqh2kq5ywyMpb+7Qgctu7cHJH47V4ZriuQcEOgTcqUDy1c/+4XztoxJ
        85udFxaBVD3Nc0jkiy9m7Unq9VT/WOVrObTz
X-Google-Smtp-Source: AMrXdXuerJz4xEOA7q7qM0dkPfn730fd7+0Kc5eFPnSqrm5lSbM3i36lBfF1RCnN7RUQ1G77ii5ZQg==
X-Received: by 2002:a05:6a00:99d:b0:581:38bc:b5bc with SMTP id u29-20020a056a00099d00b0058138bcb5bcmr30457952pfg.1.1672562057373;
        Sun, 01 Jan 2023 00:34:17 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id 68-20020a620647000000b005756a67e227sm16831954pfg.90.2023.01.01.00.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 00:34:17 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 3/8] bpf: Fix partial dynptr stack slot reads/writes
Date:   Sun,  1 Jan 2023 14:03:57 +0530
Message-Id: <20230101083403.332783-4-memxor@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101083403.332783-1-memxor@gmail.com>
References: <20230101083403.332783-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7339; i=memxor@gmail.com; h=from:subject; bh=p7RBaq+OXA6AXW4qlo40pbLXIWP1c21AGKhBd1Hitpc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjsUV0turUjdqE/u1VgUR/z4OjyX0/cUy8QBrXV8vQ LNSsKh+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY7FFdAAKCRBM4MiGSL8RyhwND/ 4gRN1TyvC7ypwkrROwlrBHvzAbKxIP2bW8XRhkG9EBzZLffqGiRmjZpgVPfJJWgWMNSkVqPHDM0/cP 0vp6SkC+9ueJJjtpAfCKGpAaCH4+ULyfQfHAHuIPFnsNTLu5gPxqBEGHJoc9SBUqj3K91UVBG7UI0v jHzrUq92d01c8AeQhaw19gaWCoIXHl2orkkbXl+qBQ06C/98PesDEacJiEviDmFUbH8Hqf8JVyAjXA zaRtUUyZ8PJ7cJRQ/7PF6qujKM7fRM9ONIErBRJD6UXDvbcdmmCP3kwliGvycuQimzRFdZBPybX7ft cfbLjhX36TZeGSEvWNvzkp4DOpRDAo++eWZkR5+VaU/1RxpjFfw560aCwkK5z3KMNNn6dCCaVBAyuC N/2RXmJFpMgm0QwyfZhTJuhDIvbZGsh/XYwOMsagTImOWTUYybmoKtBCDgMm/RiGrwXv0Yri1Taegm 4WRIY8dspbunBqUf5TkPOq3K5WOZzv7xm+glvM+mViAGPxDcyzty0rntIjL5N3/MXxwRgzoVJQKIdX 9NvM+anKU7j2BKXbhyKkUI4VacJA6XYyeAQYNrpB5GxS3ePAAtl0IHKurFgjS4vYdsvrBiDsxSEgzV JXbKqZAi0tfRv+lqCxuQGzTxh/EAZTOt2Y2mJCteM+o39ceDTabq7Ls6nKKQ==
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
 kernel/bpf/verifier.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca970f80e395..b985d90505cc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -769,6 +769,8 @@ static void mark_dynptr_cb_reg(struct bpf_reg_state *reg,
 	__mark_dynptr_reg(reg, type, true);
 }
 
+static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
+				       struct bpf_func_state *state, int spi);
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   enum bpf_arg_type arg_type, int insn_idx)
@@ -858,6 +860,44 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
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
@@ -3384,6 +3424,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			env->insn_aux_data[insn_idx].sanitize_stack_spill = true;
 	}
 
+	destroy_stack_slots_dynptr(env, state, spi);
+
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
@@ -3497,6 +3539,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
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
@@ -5524,6 +5573,30 @@ static int check_stack_range_initialized(
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
2.39.0


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B465A947
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 09:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjAAIeM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 03:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAAIeL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 03:34:11 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49B02AC5
        for <bpf@vger.kernel.org>; Sun,  1 Jan 2023 00:34:10 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 17so26377049pll.0
        for <bpf@vger.kernel.org>; Sun, 01 Jan 2023 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AuazTYNUQzO6gNY2IBgLBRjTazTtk639oaSsMmfaPo=;
        b=YrijGSKGXeYCvO3EnYwPMTzmOcLN2pVJM/7udPmQd1Re2lY8+WIWReggvq4F4W/Yr6
         H2TP8qzCoOmEtk5grVpJ4RvxbGYFf7ZIOEitLQVjCOQ5ObCyuD2OeMqHu21d/+39GkVj
         mFCI5GFL8w8o7K78CIGPL7EQkFV7si/8xuVZjv75LspGGqg+cXjsAxlmqbtrVQlxws6k
         jMGH5HD/xanbMcN8nfxL/55+dQw0oqutmdEoPHT+uI2NX2g910bLovSxHz2jdP3iNPn1
         wR4w8HjeWvbshsT0AYXlWRj5b0evEDGmCAS/XcvOy9KrtDlK0lhIXuT2w07AEESaaqCC
         Sbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AuazTYNUQzO6gNY2IBgLBRjTazTtk639oaSsMmfaPo=;
        b=lxOphggFVNHeOiH8cPOQR6lO6CZiZrNovr/JVxAxNZCU0deRdF7InyG1/xUIHDO+VX
         nkf07X9pFcJNeKaOuRo6O084Lht7Nto1IubTl9pWI8bAyulwguYpGayW4oYBeRNL/gwc
         RNsY5gonCunZwIqUOIVsydnyhnn5MMpTz6mVhCmlNcA1xKHrmcNzYUBQ9a1t3JfSb3v7
         EoLwmnMQrg2m7qo8Omj0Jj91u/h64HzY1BQy+c7v31Wi2J3CBEyNUOUqIg00ZzkodvnT
         NZknK8R2LnA+STN5+2uBEMtQTWpxCviYq+Ds6zH13q/0lFNX2qtK/OrHIx+Ll09aR6zh
         W5rw==
X-Gm-Message-State: AFqh2kqdl+6IB3Nz/ZyHeMSxsPKaSgRpzND4z6DZ3TZiMeihfLf4y6RA
        vBkgtpDphiRjzM0nm07zpuh6A1R6HWbauOLk
X-Google-Smtp-Source: AMrXdXsGn4wuuOT6uv1Fju7xPi/o3l0cdqRJmskd0Mp2mHPeVmiqPiMPGJJQKryjdIL3nyYffEeuLw==
X-Received: by 2002:a05:6a20:3c93:b0:b0:c30:5819 with SMTP id b19-20020a056a203c9300b000b00c305819mr60533604pzj.1.1672562050073;
        Sun, 01 Jan 2023 00:34:10 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id x10-20020aa79a4a000000b0058200ef9caesm3786220pfj.39.2023.01.01.00.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 00:34:09 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/8] bpf: Fix state pruning for STACK_DYNPTR stack slots
Date:   Sun,  1 Jan 2023 14:03:55 +0530
Message-Id: <20230101083403.332783-2-memxor@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101083403.332783-1-memxor@gmail.com>
References: <20230101083403.332783-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9155; i=memxor@gmail.com; h=from:subject; bh=fAx0a+r4415F16CuZnPL0MS/ZRZjqQ6wTRacGUUpIgQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjsUV0venLasCZnXFe+9oorY7PwfWDqVJctG6hQ46T yQAodZuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY7FFdAAKCRBM4MiGSL8RyvdaEA CquIH4y/P5n25EAEU3H0PcDagTr8xapeXUERtbbhBvzH5hkq/rAGs5EFi5XDgutkKuw5QzLViSACiW OM/aQA6YHCkVMGFR183jV0RyUQwjQDiD7dfMYjjNVu8ZFaOQgJBFgfPuC5AhAPUW1JeqM/mOQf8FFu vsTwq/tDrPYWdFKqdO8N1Ap1PKZIcEuj48El5i5gKD+5FXuHR+2+au7ec3UGRkmrgcSb95RBjN6Dma +ClANuQYxL8+SrnUbicu6H0TiqPjMax1lAKB5ROCvfW3u35qFGZOtsCh8nriY2wENqvLytIaKTutck vEi4IsO4CEnMKFB9MHHZTo+UyeRUzaDmQ564KEm2F2ucLo9HHbncTgn26PKeSy1xb1qEGOGRka/OpR oDJjwBBF1n2QypPxm3SJiR/KcWdb7v5JDDyR92+xWV5L8OA2AbF55oDcg+/SLHscZChXaq17dtRDUM NieDmFDES8zC+KSqOcoVqx/F5U52d10KEns3rrV/3ucd4MruK1OaNwwJgcKJD1nchZ6/xYrgvThZY7 0bWFvlGbBYmYifxS7FcPuU9pz0qeqio5xFohqWqPSltUkVeZlPGin8zshTCQtDXc5kagCoLjskImHb OkTaUZHWHKvnN8dmagcEImqC2Xe65aLbZDTVMq2f4n/r7lgERcKXcCkRb2YQ==
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

The root of the problem is missing liveness marking for STACK_DYNPTR
slots. This leads to all kinds of problems inside stacksafe.

The verifier by default inside stacksafe ignores spilled_ptr in stack
slots which do not have REG_LIVE_READ marks. Since this is being checked
in the 'old' explored state, it must have already done clean_live_states
for this old bpf_func_state. Hence, it won't be receiving any more
liveness marks from to be explored insns (it has received REG_LIVE_DONE
marking from liveness point of view).

What this means is that verifier considers that it's safe to not compare
the stack slot if was never read by children states. While liveness
marks are usually propagated correctly following the parentage chain for
spilled registers (SCALAR_VALUE and PTR_* types), the same is not the
case for STACK_DYNPTR.

clean_live_states hence simply rewrites these stack slots to the type
STACK_INVALID since it sees no REG_LIVE_READ marks.

The end result is that we will never see STACK_DYNPTR slots in explored
state. Even if verifier was conservatively matching !REG_LIVE_READ
slots, very next check continuing the stacksafe loop on seeing
STACK_INVALID would again prevent further checks.

Now as long as verifier stores an explored state which we can compare to
when reaching a pruning point, we can abuse this bug to make verifier
prune search for obviously unsafe paths using STACK_DYNPTR slots
thinking they are never used hence safe.

Doing this in unprivileged mode is a bit challenging. add_new_state is
only set when seeing BPF_F_TEST_STATE_FREQ (which requires privileges)
or when jmps_processed difference is >= 2 and insn_processed difference
is >= 8. So coming up with the unprivileged case requires a little more
work, but it is still totally possible. The test case being discussed
below triggers the heuristic even in unprivileged mode.

However, it no longer works since commit
8addbfc7b308 ("bpf: Gate dynptr API behind CAP_BPF").

Let's try to study the test step by step.

Consider the following program (C style BPF ASM):

0  r0 = 0;
1  r6 = &ringbuf_map;
3  r1 = r6;
4  r2 = 8;
5  r3 = 0;
6  r4 = r10;
7  r4 -= -16;
8  call bpf_ringbuf_reserve_dynptr;
9  if r0 == 0 goto pc+1;
10 goto pc+1;
11 *(r10 - 16) = 0xeB9F;
12 r1 = r10;
13 r1 -= -16;
14 r2 = 0;
15 call bpf_ringbuf_discard_dynptr;
16 r0 = 0;
17 exit;

We know that insn 12 will be a pruning point, hence if we force
add_new_state for it, it will first verify the following path as
safe in straight line exploration:
0 1 3 4 5 6 7 8 9 -> 10 -> (12) 13 14 15 16 17

Then, when we arrive at insn 12 from the following path:
0 1 3 4 5 6 7 8 9 -> 11 (12)

We will find a state that has been verified as safe already at insn 12.
Since register state is same at this point, regsafe will pass. Next, in
stacksafe, for spi = 0 and spi = 1 (location of our dynptr) is skipped
seeing !REG_LIVE_READ. The rest matches, so stacksafe returns true.
Next, refsafe is also true as reference state is unchanged in both
states.

The states are considered equivalent and search is pruned.

Hence, we are able to construct a dynptr with arbitrary contents and use
the dynptr API to operate on this arbitrary pointer and arbitrary size +
offset.

To fix this, first define a mark_dynptr_read function that propagates
liveness marks whenever a valid initialized dynptr is accessed by dynptr
helpers. REG_LIVE_WRITTEN is marked whenever we initialize an
uninitialized dynptr. This is done in mark_stack_slots_dynptr. It allows
screening off mark_reg_read and not propagating marks upwards from that
point.

This ensures that we either set REG_LIVE_READ64 on both dynptr slots, or
none, so clean_live_states either sets both slots to STACK_INVALID or
none of them. This is the invariant the checks inside stacksafe rely on.

Next, do a complete comparison of both stack slots whenever they have
STACK_DYNPTR. Compare the dynptr type stored in the spilled_ptr, and
also whether both form the same first_slot. Only then is the later path
safe.

Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4a25375ebb0d..f7248235e119 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -781,6 +781,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
 	}
 
+	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
+	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
+
 	return 0;
 }
 
@@ -805,6 +808,26 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 
 	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
 	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
+
+	/* Why do we need to set REG_LIVE_WRITTEN for STACK_INVALID slot?
+	 *
+	 * While we don't allow reading STACK_INVALID, it is still possible to
+	 * do <8 byte writes marking some but not all slots as STACK_MISC. Then,
+	 * helpers or insns can do partial read of that part without failing,
+	 * but check_stack_range_initialized, check_stack_read_var_off, and
+	 * check_stack_read_fixed_off will do mark_reg_read for all 8-bytes of
+	 * the slot conservatively. Hence we need to screen off those liveness
+	 * marking walks.
+	 *
+	 * This was not a problem before because STACK_INVALID is only set by
+	 * default, or in clean_live_states after REG_LIVE_DONE, not randomly
+	 * during verifier state exploration. Hence, for this case parentage
+	 * chain will still be live, while earlier reg->parent was NULL, so we
+	 * need REG_LIVE_WRITTEN to screen off read marker propagation.
+	 */
+	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
+	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
+
 	return 0;
 }
 
@@ -2388,6 +2411,30 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int spi, ret;
+
+	/* For CONST_PTR_TO_DYNPTR, it must have already been done by
+	 * check_reg_arg in check_helper_call and mark_btf_func_reg_size in
+	 * check_kfunc_call.
+	 */
+	if (reg->type == CONST_PTR_TO_DYNPTR)
+		return 0;
+	spi = get_spi(reg->off);
+	/* Caller ensures dynptr is valid and initialized, which means spi is in
+	 * bounds and spi is the first dynptr slot. Simply mark stack slot as
+	 * read.
+	 */
+	ret = mark_reg_read(env, &state->stack[spi].spilled_ptr,
+			    state->stack[spi].spilled_ptr.parent, REG_LIVE_READ64);
+	if (ret)
+		return ret;
+	return mark_reg_read(env, &state->stack[spi - 1].spilled_ptr,
+			     state->stack[spi - 1].spilled_ptr.parent, REG_LIVE_READ64);
+}
+
 /* This function is supposed to be used by the following 32-bit optimization
  * code only. It returns TRUE if the source or destination register operates
  * on 64-bit, otherwise return FALSE.
@@ -5928,6 +5975,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int err;
 
 	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
@@ -6008,6 +6056,10 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 				err_extra, regno);
 			return -EINVAL;
 		}
+
+		err = mark_dynptr_read(env, reg);
+		if (err)
+			return err;
 	}
 	return 0;
 }
@@ -13204,6 +13256,27 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * return false to continue verification of this path
 			 */
 			return false;
+		/* Both are same slot_type, but STACK_DYNPTR requires more
+		 * checks before it can considered safe.
+		 */
+		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_DYNPTR) {
+			/* If both are STACK_DYNPTR, type must be same */
+			if (old->stack[spi].spilled_ptr.dynptr.type != cur->stack[spi].spilled_ptr.dynptr.type)
+				return false;
+			/* Both should also have first slot at same spi */
+			if (old->stack[spi].spilled_ptr.dynptr.first_slot != cur->stack[spi].spilled_ptr.dynptr.first_slot)
+				return false;
+			/* ids should be same */
+			if (!!old->stack[spi].spilled_ptr.ref_obj_id != !!cur->stack[spi].spilled_ptr.ref_obj_id)
+				return false;
+			if (old->stack[spi].spilled_ptr.ref_obj_id &&
+			    !check_ids(old->stack[spi].spilled_ptr.ref_obj_id,
+				       cur->stack[spi].spilled_ptr.ref_obj_id, idmap))
+				return false;
+			WARN_ON_ONCE(i % BPF_REG_SIZE);
+			i += BPF_REG_SIZE - 1;
+			continue;
+		}
 		if (i % BPF_REG_SIZE != BPF_REG_SIZE - 1)
 			continue;
 		if (!is_spilled_reg(&old->stack[spi]))
-- 
2.39.0


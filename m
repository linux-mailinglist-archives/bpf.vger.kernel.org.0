Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D326B674DA4
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjATHEF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATHEF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:04:05 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43481683F8
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:03 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 36so3422205pgp.10
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaLkm+F26DdGfFgA0j+DUYDbXVbQ5FuBOQ58rlSnxCU=;
        b=CDPYdIkDNbtOh52S6seOMbfSHkCUj9SoWMug3lglu1a9V+ZhixqHw4shLqV2TjBJWm
         4RyW2Tku2b+Q8YTXxmSlYhLvNOs+oXCFgwbkHSbl6w2v0WL3eHX8J3aPcbDpgzg/7Wzp
         L3o6euzjFFHpQZizOPaPve43VncUx2X43BfrmwiMP6n6qtGtqEZC2ui78O3X3eIX23Z+
         ehgtIzZNiAXLgtfw4hk8ciJ4UFAXxNJAyKyl+anwaBy2G20/iurwG1tAWHmnD55+D2cT
         ofJHR7PyJfQbUFJeGHla6F50zX8EsgpwRGfAC9ja2/752uOsOZ21CrieheQRtKPNFY5M
         3HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaLkm+F26DdGfFgA0j+DUYDbXVbQ5FuBOQ58rlSnxCU=;
        b=lWPlyIBJPxgClf+zkme6KcKpYqTAtbJkGNP+angLrvfBfg/tXedyOCgRo6sTnLtieK
         wKXeUKsKQnxvpiYFKzdf3pKM6OZmV0S+xS8VX7x4uUWNgX9M8S8JBMHsI98CV3MSy0Cb
         kFtu6UxWBG8/09bvXawXhx5T1PMJOk1R2hZl9dNsCDYp7SqwoAcd7le6hci2sg3J7LCQ
         HAENx1kt3jmW6siuMJ8JtV79nc7h7Ezi+xEINnYfPZ8Vpxg8bKItPxEHw4z/Gjy0z3eX
         wlYyh5khZG8ptAH1RHS7TyrDtiJNJpCfsr6HoOibfd9nN+I8x22MAQpdlLuck+fwq4A4
         z1LQ==
X-Gm-Message-State: AFqh2ko46lgH3bFu0oQVPGT/mskJOElZKjW1B2orDs/tcgytoBCBEfUf
        0rkgQOqAV9xMb4FHyEeIdwe7kR2gsSM=
X-Google-Smtp-Source: AMrXdXv9255mmLSN3ArlqQAem19kx5w8zYBbLTK/KUBevFw5h2cPMnTVZfM74V9rzoXkPrEymaeeIA==
X-Received: by 2002:aa7:96f7:0:b0:580:c223:90e9 with SMTP id i23-20020aa796f7000000b00580c22390e9mr15921725pfq.6.1674198242378;
        Thu, 19 Jan 2023 23:04:02 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id a6-20020aa79706000000b0058d9e915891sm9330402pfg.57.2023.01.19.23.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:04:01 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v4 01/12] bpf: Fix state pruning for STACK_DYNPTR stack slots
Date:   Fri, 20 Jan 2023 12:33:44 +0530
Message-Id: <20230120070355.1983560-2-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120070355.1983560-1-memxor@gmail.com>
References: <20230120070355.1983560-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9951; i=memxor@gmail.com; h=from:subject; bh=NYNbdfps9+kYMJ335GtKo6Xc0a43rfZyUOa/oudRbNc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyjzLL83VYouCKa4i4kZhtgc+y/4A2p1iM42Byfm9 YpAPpFSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8o8ywAKCRBM4MiGSL8RysUxD/ 48/vyP7/KB3g69npSdMaXOxec9SSj/6Tt4pL1dWI/Re7roadzapP6ztLyxPwtTVZvwZdd+uuLcdw1Q HOpx5nec79RjTlNvF7u1WdQ9sosfRZLSaZLLcsDWwQ1Fyw/aQaR5geCkxW8VS/K/EayRyRPhBWTqTx n4TYzYXo+biYZyKYJgCS08VrwMmMTJ0x6gTUNqgc0lTN2gf/NkRJVJPb0W2jmUFuJhEdNSmnhhwmJL cg2geJQfcSoXYdHYfKeup8Oq1s/k0diZx6++Ti3ceUV4XCYD7FTU8oavUxPIlU2ZCe4Zy8Y7MZD1tH ETAmoN6YtrgSEMevbCTdXK7kcqlWeF+9LYHvnNDI6ZsfJp6AOSu8xNibACWGALFusDP80a3XShKOY8 np65+gSkpK4Y4n3AJqYTPkjwTq2XOREodItsuCyc8Spw//qSV9cGq0ieMVxfliyyyhxg0yHLk177i1 F1DwyVqhHSY4Daggo5gOZVYzqSj2NST2NjNGEbJD/jENuKHizekH1diomXOFCKGDYP31O8YA+3QOEu TG9zlu2+kCWo1uobF2cnf000PYdlNzf4/ankqvW3eiwMbgE3jUQNh37xqvgSZ6DFX0ViOIZ/g7QKKB F9o6DhM71pKeMA8g1h6qLJOCuPwdAbuvg32qGT3RtQVfh0Bgu2Yr2ynBY5hQ==
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 88 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca7db2ce70b9..39d8ee38c338 100644
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
 
@@ -805,6 +808,31 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 
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
+	 * the slot conservatively. Hence we need to prevent those liveness
+	 * marking walks.
+	 *
+	 * This was not a problem before because STACK_INVALID is only set by
+	 * default (where the default reg state has its reg->parent as NULL), or
+	 * in clean_live_states after REG_LIVE_DONE (at which point
+	 * mark_reg_read won't walk reg->parent chain), but not randomly during
+	 * verifier state exploration (like we did above). Hence, for our case
+	 * parentage chain will still be live (i.e. reg->parent may be
+	 * non-NULL), while earlier reg->parent was NULL, so we need
+	 * REG_LIVE_WRITTEN to screen off read marker propagation when it is
+	 * done later on reads or by mark_dynptr_read as well to unnecessary
+	 * mark registers in verifier state.
+	 */
+	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
+	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
+
 	return 0;
 }
 
@@ -2390,6 +2418,30 @@ static int mark_reg_read(struct bpf_verifier_env *env,
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
@@ -5977,6 +6029,8 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 
 		meta->uninit_dynptr_regno = regno;
 	} else /* MEM_RDONLY and None case from above */ {
+		int err;
+
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
 			verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
@@ -6010,6 +6064,10 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
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
@@ -13215,10 +13273,9 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			return false;
 		if (i % BPF_REG_SIZE != BPF_REG_SIZE - 1)
 			continue;
-		if (!is_spilled_reg(&old->stack[spi]))
-			continue;
-		if (!regsafe(env, &old->stack[spi].spilled_ptr,
-			     &cur->stack[spi].spilled_ptr, idmap))
+		/* Both old and cur are having same slot_type */
+		switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
+		case STACK_SPILL:
 			/* when explored and current stack slot are both storing
 			 * spilled registers, check that stored pointers types
 			 * are the same as well.
@@ -13229,7 +13286,30 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * such verifier states are not equivalent.
 			 * return false to continue verification of this path
 			 */
+			if (!regsafe(env, &old->stack[spi].spilled_ptr,
+				     &cur->stack[spi].spilled_ptr, idmap))
+				return false;
+			break;
+		case STACK_DYNPTR:
+		{
+			const struct bpf_reg_state *old_reg, *cur_reg;
+
+			old_reg = &old->stack[spi].spilled_ptr;
+			cur_reg = &cur->stack[spi].spilled_ptr;
+			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
+			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
+			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+				return false;
+			break;
+		}
+		case STACK_MISC:
+		case STACK_ZERO:
+		case STACK_INVALID:
+			continue;
+		/* Ensure that new unhandled slot types return false by default */
+		default:
 			return false;
+		}
 	}
 	return true;
 }
-- 
2.39.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FDA602DB4
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 15:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJRN7y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 09:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJRN7v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 09:59:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D595231343
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 70so14056138pjo.4
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXRgOgNBUr5iOiUQ7IQEqWKoapMJ63yhRh4wTj6vkOk=;
        b=qw+DyjjwOfI/3SD2dvboNm9gr/rIp/HBYbWpREJduYOaRTwg/+AThs8Pu4H74qxxti
         iWFUcEnzWYN/s5YEK46F2ULjSpmw9V8fxATFn4ZO55PI8pz9HoH/48sh10DXPw79sQkw
         XBM9QQiQuWtinOcEt8rqv5LTvq2I3TugAD0/fgWYCfI2+eh2fOjgIRuxTMNLs15rFOFH
         OpbT2xfJBnav1IadtkH5y1g1czmJBgtfujU+YUn+EytuI6AFtrBDz8HNcafe1Ilg6mP5
         4U0kJMtyEpgoNSgMgC3lTRlaZeGg+AHVPVc+zxE9Mjjb3ko0HLgL8BscUR5Upcuo9HP9
         P6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXRgOgNBUr5iOiUQ7IQEqWKoapMJ63yhRh4wTj6vkOk=;
        b=nJApVy/S5XKlHWbut0Z8CXJeU8YR46jY8idHFVxPP38UCX2ZTSFDXhUfaZaQ25vkRW
         uaQZIuI/1yA4bcVYGcGA93JJqR3nuSsJIjHkg/9hrL+KiJGf9Fp3VgsakUz+Sl0oLZ19
         VStJPMRAPaFxYwQue+8LINbOasR2y0iFCAY5Wk9wLr4u0B+mGts7NAaqlD6pxfMhD0MX
         u5XqAR8YtX5bj4HnCSg4aHg14BV/8mNlVuh9keRlTBrQetC+pkKEEq2mP4XB1cXTup08
         OqeEgKITSQh8/d3/5tl4+ubU8uLxC/c9Yksr6KcNL930/KaO4kKNHuGHjl8AdmNHQUOF
         Rspw==
X-Gm-Message-State: ACrzQf1poAutwPSKj8oxYNAlEDsSrql8JkWw/ivXvjDf7bBuLlsDfzmx
        Q+gG/zB22GPfga5VgTKksWgUJyqASOR5Zg==
X-Google-Smtp-Source: AMsMyM7qCejzuvITG0pspG1DV/qO+ShHmQ07vJRqjA5BqrzBULNNfRGZ9veNhEXkkxMjXA8BevpmPQ==
X-Received: by 2002:a17:90a:e7ce:b0:20a:cb3f:faf0 with SMTP id kb14-20020a17090ae7ce00b0020acb3ffaf0mr38805962pjb.148.1666101585254;
        Tue, 18 Oct 2022 06:59:45 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id r16-20020a63ec50000000b0045ccc30e469sm8029511pgj.25.2022.10.18.06.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:59:44 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 05/13] bpf: Fix state pruning for STACK_DYNPTR stack slots
Date:   Tue, 18 Oct 2022 19:29:12 +0530
Message-Id: <20221018135920.726360-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9159; i=memxor@gmail.com; h=from:subject; bh=78q+shD1c9FVwOu63DoS5Gf+7vZBOe5czpymXzjEIQo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEiuuOfo2rIN5czdU7t52wfU5pZKA3DsB65kIfL WhXP0YWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8Rylu/EA DAq11CLLfNp6pmAjSCpmZ6uMqrb63hAIiH32JFFaduGplUk/q0e2xDXcBoz28oi6iW+l7d90UjfHyl 8eVsxjNFDhW8t4t8yUOjwjquGvsdvi0SVYzoOq/976YJa6ZHZ58XJtgwQvvJ52lxw7Q+cAvDgJ7hnJ 9y0k7mTHaTzkdzb9WArw4m+r0XtW30kWUu6Y4P0yquRYd4BT74Pva3HwqfzRnrpRUeC+lIwZL8CK1W e1EzMlPFE5oqgD/eGVjY2XB5OcvcCHU9CgrR7b/YbJK+fFaJgKkKkAHtERikovSdBeCjGWsPqZKEi0 LNE+jRsk1jzH4rmS68KRX5x/ozmbXRqEocanhMfiKQhRH6sRoI+wCmoVdei/PY7asjmbs9PQUdVxmL FVgI+CDw4cJTjqOQ7iSxDsUgy4OTRlPlZLO/WTzV82/N/7DfHI7QKRKVPkLBSuz8PI61+DC2trBICk AHMUVvj7ZhbhKNrPTw3iA4T8b6oVQ+YZOzgMrdpahSi3OfzWZeTJpAKApR1hakzkiuf+tq5nEl2KrA +WARRe3hNim8z0PVfKbNiCcSv12k6gMcEBOaWb6tAjTY0tLBfYxJMP5M9x84z6ZKnSrlBCHZyf2a5R 3Nzax77diPRQe57dY+UDvNaGyOig8YZGHXolvQe2LX2AjSflneSD9odJuqUA==
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
index a8c277e51d63..8f667180f70f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -752,6 +752,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
 	}
 
+	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
+	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
+
 	return 0;
 }
 
@@ -776,6 +779,26 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 
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
 
@@ -2354,6 +2377,30 @@ static int mark_reg_read(struct bpf_verifier_env *env,
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
@@ -5648,6 +5695,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			u8 *uninit_dynptr_regno)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int err;
 
 	if ((arg_type & (MEM_UNINIT | MEM_RDONLY)) == (MEM_UNINIT | MEM_RDONLY)) {
 		verbose(env, "verifier internal error: misconfigured dynptr helper type flags\n");
@@ -5729,6 +5777,10 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 				err_extra, argno + 1);
 			return -EINVAL;
 		}
+
+		err = mark_dynptr_read(env, reg);
+		if (err)
+			return err;
 	}
 	return 0;
 }
@@ -11793,6 +11845,27 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
2.38.0


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B182A620369
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiKGXLF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiKGXKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:51 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B34021255
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:45 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 78so11834735pgb.13
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSeAsJCiRcKWXcAZhLXAJihCbepa9Qc8ZsK5curifAA=;
        b=gubcaWjmzgDH6nGunEyPf7GtmZMW40kD3fIfCaGQvedoSbKLM4GX8GHnPP68Riq+v4
         rehAogchqZUpcqaSh/34CIxnH6ZZKazBqTc8IZWy6mkY3ws60AfUu0rWm542YHympUi3
         uw0PQIeJ6NcdCw5x44roLXOkXMJ1XV76MDaLNViAYIK5TWKBYn6q4K2C7wpxUOMkXUOG
         O9+KE0qwrqz5ME+XkZGWZw7SbUVzwmVRO46hHBYqb+vY5M92L9HuKrtDf0aVIyYTNjb6
         0p8fgCpjw1Pbo8RQj5gRPVxkeRKSLr9WrXm+UCB2/ncP8xy7x4qSy58XZlAsHiQuQAN3
         MbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSeAsJCiRcKWXcAZhLXAJihCbepa9Qc8ZsK5curifAA=;
        b=bx0KJpGHFS1qqJjrTGP5Hr7Z92Q2ERyR9D9YZRzyuwAFNWFpEYsPpvG6bGOKkNdSZ7
         PfoncTR1fa5917+Kni9oq46kppb0ctD4yQ5j8GhnEwD4zZLSR1emA5G+DrkkMIoVYX95
         W83avS+YC9v35Eu9JK4OGBSdIR9JJbVuyee04Um+kLF0KJY3vc6WzY3EqtAyoT0G527+
         6hfPAhIUo/21J/yEXY1G0+sq3Wx5DmXUFRc9UPUSFlhcZ8rmDVPkjxJmmLg8KkAqWx+M
         UXi/BJ9NriExza9ofRkvZhvX1gMzroDL9HwI7qtM5znuM5Pbz0CTE/uWIMv3MCmdYf9K
         xdfw==
X-Gm-Message-State: ACrzQf3YmMCVMOcLDJAIAcwnLiAFSdMCSGpjNt8ODODpVBlRDls2UulH
        KBFAsNswi57PlAziLliWG1gH7gyifBF2UA==
X-Google-Smtp-Source: AMsMyM6D0SfWQK1zfc5soZFf0T2BCtR8dGtSXBOtMtoSMshk9bqHAeTF9qJqR4H25wxYxq7arvSFwA==
X-Received: by 2002:a63:5c08:0:b0:46e:e211:5694 with SMTP id q8-20020a635c08000000b0046ee2115694mr45366517pgb.441.1667862644648;
        Mon, 07 Nov 2022 15:10:44 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id a16-20020a17090a6d9000b001f559e00473sm6602804pjk.43.2022.11.07.15.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:44 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 15/25] bpf: Teach verifier about non-size constant arguments
Date:   Tue,  8 Nov 2022 04:39:40 +0530
Message-Id: <20221107230950.7117-16-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17169; i=memxor@gmail.com; h=from:subject; bh=hqrkxs8kovv9OVcVUqMt1Typw5KaY/iVu+kPRoR7rUU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+3oZ11spkHSgv0AKOqNt3QZGbKZXgOhJ6otP8n RibXJSSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtwAKCRBM4MiGSL8RyjSjD/ 400DPhlJx/D3RlPEYg2PTzSsV7hzpLxZVzeT8PBTpjip70nApFS0Q+RLmJprjizJuybmsEyfGwuk8M p/a3c9oI1qizeEAs+AyFQw7JGohhcdbPfj1wE8p7AC7HI6a0zU38mvHUXTcQRZ+joulqereETgNRhK FkzsB5plF8CXt3VaJ4Rw8Kh2CO4gv2BGB6rKLiQ/Q1UfJ6jNQ/LvBvxJBX+yuRwxDe7QD7rrbcBpuB kk7ZT5cFMf2dtwlV2PIlG/Nq2jix01lSq/Z0VUR2/Wec3W883kyRHGFDBNGG2pE08dB9k+Sz/aNHkV hmmChVhe7Vlhm8cfQTLBRCM7U0mZNApzNvHSYRsvYXKPi12VzwHsdBhwSBrI4U9BKaV8r8OOr3dWth KaELKgVu5HOJkK17Dgc/M1DCW4Tjq1dMbwsxXJwoIonMFapwM5GVqp1WgRf8O7LIO185NJYzBt1dZL 4+BezRMPMaD/TWapnalFR+DtciYQ6GU3jU7BbkkiOULwI2ocmBN8KZXcgziYytm0bW+N+ZNTH9vUg0 JEh1r33tkWIJYCaC8wr9H5M8gbegRfRz+6YnVPmYnxFYj0LsV1dH9xvNMNRZSOnv1DqpqHebJHy+FE EGRwnXaShsdCJt23pvj7onmbxHEqCH2l1vRu4lSC0A1GZ9PryBwyQ78ch78g==
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

Currently, the verifier has support for various arguments that either
describe the size of the memory being passed in to a helper, or describe
the size of the memory being returned. When a constant is passed in like
this, it is assumed for the purposes of precision tracking that if the
value in the already explored safe state is within the value in current
state, it would fine to prune the search.

While this holds well for size arguments, arguments where each value may
denote a distinct meaning and needs to be verified separately needs more
work. Search can only be pruned if both are equivalent values. In all
other cases, it would be incorrect to treat those two precise registers
as equivalent if the new value satisfies the old one (i.e. old <= cur).

Hence, make the register precision marker tri-state. There are now three
values that reg->precise takes: NOT_PRECISE, PRECISE, EXACT.

Both PRECISE and EXACT are 'true' values. EXACT affects how regsafe
decides whether both registers are equivalent for the purposes of
verifier state equivalence. When it sees that old state register has
reg->precise == EXACT, unless both are equivalent, it will return false.
Otherwise, for PRECISE case it falls back to the default check that is
present now (i.e. thinking that we're talking about sizes).

This is required as a future patch introduces a BPF memory allocator
interface, where we take the program BTF's type ID as an argument. Each
distinct type ID may result in the returned pointer obtaining a
different size, hence precision tracking is needed, and pruning cannot
just happen when the old value is within the current value. It must only
happen when the type ID is equal. The type ID will always correspond to
prog->aux->btf hence actual type match is not required.

Finally, change mark_chain_precision precision argument to EXACT for
kfuncs constant non-size scalar arguments (tagged with __k suffix).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  10 +++-
 kernel/bpf/verifier.c        | 111 ++++++++++++++++++++++-------------
 2 files changed, 76 insertions(+), 45 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f3a601d33fb3..1e246ec2ff37 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -43,6 +43,12 @@ enum bpf_reg_liveness {
 	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
 };
 
+enum bpf_reg_precise {
+	NOT_PRECISE,
+	PRECISE,
+	EXACT,
+};
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
@@ -180,7 +186,7 @@ struct bpf_reg_state {
 	s32 subreg_def;
 	enum bpf_reg_liveness live;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
-	bool precise;
+	enum bpf_reg_precise precise;
 };
 
 enum bpf_stack_slot_type {
@@ -626,8 +632,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    struct bpf_attach_target_info *tgt_info);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
-int mark_chain_precision(struct bpf_verifier_env *env, int regno);
-
 #define BPF_BASE_TYPE_MASK	GENMASK(BPF_BASE_TYPE_BITS - 1, 0)
 
 /* extract base type from bpf_{arg, return, reg}_type. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7515b31d2c40..5bfc151711b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -864,7 +864,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 		print_liveness(env, reg->live);
 		verbose(env, "=");
 		if (t == SCALAR_VALUE && reg->precise)
-			verbose(env, "P");
+			verbose(env, reg->precise == EXACT ? "E" : "P");
 		if ((t == SCALAR_VALUE || t == PTR_TO_STACK) &&
 		    tnum_is_const(reg->var_off)) {
 			/* reg->off should be 0 for SCALAR_VALUE */
@@ -961,7 +961,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 			t = reg->type;
 			verbose(env, "=%s", t == SCALAR_VALUE ? "" : reg_type_str(env, t));
 			if (t == SCALAR_VALUE && reg->precise)
-				verbose(env, "P");
+				verbose(env, reg->precise == EXACT ? "E" : "P");
 			if (t == SCALAR_VALUE && tnum_is_const(reg->var_off))
 				verbose(env, "%lld", reg->var_off.value + reg->off);
 		} else {
@@ -1695,7 +1695,16 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
-	reg->precise = !env->bpf_capable;
+	/* Helpers requiring EXACT for constant arguments cannot be called from
+	 * programs without CAP_BPF. This is because we don't propagate
+	 * precision markers when CAP_BPF is missing. If we allowed calling such
+	 * heleprs in those programs, the default would have to be EXACT for
+	 * them, which would be too aggresive, or we'd have to propagate it.
+	 *
+	 * Currently, only bpf_obj_new kfunc requires EXACT precision for its
+	 * scalar argument, which is a kfunc (and thus behind CAP_BPF).
+	 */
+	reg->precise = !env->bpf_capable ? PRECISE : NOT_PRECISE;
 	__mark_reg_unbounded(reg);
 }
 
@@ -2750,7 +2759,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
  * For now backtracking falls back into conservative marking.
  */
 static void mark_all_scalars_precise(struct bpf_verifier_env *env,
-				     struct bpf_verifier_state *st)
+				     struct bpf_verifier_state *st,
+				     enum bpf_reg_precise precise)
 {
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
@@ -2769,7 +2779,7 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 				reg = &func->regs[j];
 				if (reg->type != SCALAR_VALUE)
 					continue;
-				reg->precise = true;
+				reg->precise = precise;
 			}
 			for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
 				if (!is_spilled_reg(&func->stack[j]))
@@ -2777,7 +2787,7 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 				reg = &func->stack[j].spilled_ptr;
 				if (reg->type != SCALAR_VALUE)
 					continue;
-				reg->precise = true;
+				reg->precise = precise;
 			}
 		}
 	}
@@ -2795,7 +2805,7 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 			reg = &func->regs[j];
 			if (reg->type != SCALAR_VALUE)
 				continue;
-			reg->precise = false;
+			reg->precise = NOT_PRECISE;
 		}
 		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
 			if (!is_spilled_reg(&func->stack[j]))
@@ -2803,7 +2813,7 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 			reg = &func->stack[j].spilled_ptr;
 			if (reg->type != SCALAR_VALUE)
 				continue;
-			reg->precise = false;
+			reg->precise = NOT_PRECISE;
 		}
 	}
 }
@@ -2896,7 +2906,7 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
  * finalized states which help in short circuiting more future states.
  */
 static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int regno,
-				  int spi)
+				  int spi, enum bpf_reg_precise precise)
 {
 	struct bpf_verifier_state *st = env->cur_state;
 	int first_idx = st->first_insn_idx;
@@ -2909,8 +2919,11 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 	bool new_marks = false;
 	int i, err;
 
-	if (!env->bpf_capable)
+	if (!env->bpf_capable) {
+		/* EXACT precision should only be used with CAP_BPF */
+		WARN_ON_ONCE(precise == EXACT);
 		return 0;
+	}
 
 	/* Do sanity checks against current state of register and/or stack
 	 * slot, but don't set precise flag in current state, as precision
@@ -2969,7 +2982,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 						reg_mask &= ~(1u << i);
 						continue;
 					}
-					reg->precise = true;
+					reg->precise = precise;
 				}
 				return 0;
 			}
@@ -2988,7 +3001,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 				err = backtrack_insn(env, i, &reg_mask, &stack_mask);
 			}
 			if (err == -ENOTSUPP) {
-				mark_all_scalars_precise(env, st);
+				mark_all_scalars_precise(env, st, precise);
 				return 0;
 			} else if (err) {
 				return err;
@@ -3029,7 +3042,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 			}
 			if (!reg->precise)
 				new_marks = true;
-			reg->precise = true;
+			reg->precise = precise;
 		}
 
 		bitmap_from_u64(mask, stack_mask);
@@ -3048,7 +3061,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 				 * fp-8 and it's "unallocated" stack space.
 				 * In such case fallback to conservative.
 				 */
-				mark_all_scalars_precise(env, st);
+				mark_all_scalars_precise(env, st, precise);
 				return 0;
 			}
 
@@ -3063,7 +3076,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 			}
 			if (!reg->precise)
 				new_marks = true;
-			reg->precise = true;
+			reg->precise = precise;
 		}
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "parent %s regs=%x stack=%llx marks:",
@@ -3083,19 +3096,22 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 	return 0;
 }
 
-int mark_chain_precision(struct bpf_verifier_env *env, int regno)
+static int mark_chain_precision(struct bpf_verifier_env *env, int regno,
+				enum bpf_reg_precise precise)
 {
-	return __mark_chain_precision(env, env->cur_state->curframe, regno, -1);
+	return __mark_chain_precision(env, env->cur_state->curframe, regno, -1, precise);
 }
 
-static int mark_chain_precision_frame(struct bpf_verifier_env *env, int frame, int regno)
+static int mark_chain_precision_frame(struct bpf_verifier_env *env, int frame, int regno,
+				     enum bpf_reg_precise precise)
 {
-	return __mark_chain_precision(env, frame, regno, -1);
+	return __mark_chain_precision(env, frame, regno, -1, precise);
 }
 
-static int mark_chain_precision_stack_frame(struct bpf_verifier_env *env, int frame, int spi)
+static int mark_chain_precision_stack_frame(struct bpf_verifier_env *env, int frame, int spi,
+					    enum bpf_reg_precise precise)
 {
-	return __mark_chain_precision(env, frame, -1, spi);
+	return __mark_chain_precision(env, frame, -1, spi, precise);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -3230,7 +3246,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			 * Backtrack from here and mark all registers as precise
 			 * that contributed into 'reg' being a constant.
 			 */
-			err = mark_chain_precision(env, value_regno);
+			err = mark_chain_precision(env, value_regno, PRECISE);
 			if (err)
 				return err;
 		}
@@ -3271,7 +3287,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		/* when we zero initialize stack slots mark them as such */
 		if (reg && register_is_null(reg)) {
 			/* backtracking doesn't work for STACK_ZERO yet. */
-			err = mark_chain_precision(env, value_regno);
+			err = mark_chain_precision(env, value_regno, PRECISE);
 			if (err)
 				return err;
 			type = STACK_ZERO;
@@ -3387,7 +3403,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	}
 	if (zero_used) {
 		/* backtracking doesn't work for STACK_ZERO yet. */
-		err = mark_chain_precision(env, value_regno);
+		err = mark_chain_precision(env, value_regno, PRECISE);
 		if (err)
 			return err;
 	}
@@ -3436,7 +3452,7 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
 		 * backtracking. Any register that contributed
 		 * to const 0 was marked precise before spill.
 		 */
-		state->regs[dst_regno].precise = true;
+		state->regs[dst_regno].precise = PRECISE;
 	} else {
 		/* have read misc data from the stack */
 		mark_reg_unknown(env, state->regs, dst_regno);
@@ -5503,7 +5519,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 				      reg->umax_value,
 				      zero_size_allowed, meta);
 	if (!err)
-		err = mark_chain_precision(env, regno);
+		err = mark_chain_precision(env, regno, PRECISE);
 	return err;
 }
 
@@ -6311,7 +6327,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->mem_size = reg->var_off.value;
-		err = mark_chain_precision(env, regno);
+		err = mark_chain_precision(env, regno, PRECISE);
 		if (err)
 			return err;
 		break;
@@ -7303,7 +7319,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return 0;
 	}
 
-	err = mark_chain_precision(env, BPF_REG_3);
+	err = mark_chain_precision(env, BPF_REG_3, PRECISE);
 	if (err)
 		return err;
 	if (bpf_map_key_unseen(aux))
@@ -7403,7 +7419,7 @@ static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 	bool reg_is_null = register_is_null(reg);
 
 	if (reg_is_null)
-		mark_chain_precision(env, BPF_REG_4);
+		mark_chain_precision(env, BPF_REG_4, PRECISE);
 
 	return reg_is_null;
 }
@@ -8224,7 +8240,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					verbose(env, "R%d must be a known constant\n", regno);
 					return -EINVAL;
 				}
-				ret = mark_chain_precision(env, regno);
+				ret = mark_chain_precision(env, regno, EXACT);
 				if (ret < 0)
 					return ret;
 				meta->arg_constant.found = true;
@@ -8248,7 +8264,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 
 				meta->r0_size = reg->var_off.value;
-				ret = mark_chain_precision(env, regno);
+				ret = mark_chain_precision(env, regno, PRECISE);
 				if (ret)
 					return ret;
 			}
@@ -9929,7 +9945,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				 * This is legal, but we have to reverse our
 				 * src/dest handling in computing the range
 				 */
-				err = mark_chain_precision(env, insn->dst_reg);
+				err = mark_chain_precision(env, insn->dst_reg, PRECISE);
 				if (err)
 					return err;
 				return adjust_ptr_min_max_vals(env, insn,
@@ -9937,14 +9953,16 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			}
 		} else if (ptr_reg) {
 			/* pointer += scalar */
-			err = mark_chain_precision(env, insn->src_reg);
+			err = mark_chain_precision(env, insn->src_reg, PRECISE);
 			if (err)
 				return err;
 			return adjust_ptr_min_max_vals(env, insn,
 						       dst_reg, src_reg);
 		} else if (dst_reg->precise) {
-			/* if dst_reg is precise, src_reg should be precise as well */
-			err = mark_chain_precision(env, insn->src_reg);
+			/* If dst_reg is precise, src_reg should be precise as well.
+			 * Propagate EXACT if it is exact, PRECISE if precise.
+			 */
+			err = mark_chain_precision(env, insn->src_reg, dst_reg->precise);
 			if (err)
 				return err;
 		}
@@ -10938,10 +10956,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * above is_branch_taken() special cased the 0 comparison.
 		 */
 		if (!__is_pointer_value(false, dst_reg))
-			err = mark_chain_precision(env, insn->dst_reg);
+			err = mark_chain_precision(env, insn->dst_reg, PRECISE);
 		if (BPF_SRC(insn->code) == BPF_X && !err &&
 		    !__is_pointer_value(false, src_reg))
-			err = mark_chain_precision(env, insn->src_reg);
+			err = mark_chain_precision(env, insn->src_reg, PRECISE);
 		if (err)
 			return err;
 	}
@@ -12262,9 +12280,18 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		if (rcur->type == SCALAR_VALUE) {
 			if (!rold->precise)
 				return true;
-			/* new val must satisfy old val knowledge */
-			return range_within(rold, rcur) &&
-			       tnum_in(rold->var_off, rcur->var_off);
+			/* For EXACT, we need values to match exactly, so simply
+			 * return false as the memcmp above failed already,
+			 * otherwise current being within the old value
+			 * suffices.
+			 */
+			if (rold->precise == EXACT) {
+				return false;
+			} else /* PRECISE */ {
+				/* new val must satisfy old val knowledge */
+				return range_within(rold, rcur) &&
+				       tnum_in(rold->var_off, rcur->var_off);
+			}
 		} else {
 			/* We're trying to use a pointer in place of a scalar.
 			 * Even if the scalar was unbounded, this could lead to
@@ -12595,7 +12622,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2)
 				verbose(env, "frame %d: propagating r%d\n", i, fr);
-			err = mark_chain_precision_frame(env, fr, i);
+			err = mark_chain_precision_frame(env, fr, i, state_reg->precise);
 			if (err < 0)
 				return err;
 		}
@@ -12610,7 +12637,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			if (env->log.level & BPF_LOG_LEVEL2)
 				verbose(env, "frame %d: propagating fp%d\n",
 					(-i - 1) * BPF_REG_SIZE, fr);
-			err = mark_chain_precision_stack_frame(env, fr, i);
+			err = mark_chain_precision_stack_frame(env, fr, i, state_reg->precise);
 			if (err < 0)
 				return err;
 		}
-- 
2.38.1


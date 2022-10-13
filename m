Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24015FD4BE
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJMGY2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJMGY1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD0512D821
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l6so766885pgu.7
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrRx5/BklT85p3DSbmvBb6z8bn+3+nVNyzOBaYtTefU=;
        b=L6PxZ7XxNijprpjxnKLm7jgh39yD4TnHbgSAjo0igIUaV/5hFdECCaV5IiBtrhJ0+B
         Ow/lDsfhdckm6Dlm+niMqQzExcA7lhwGtUqEjMy1ApbHCbZBXhKv1sD922Dp92ytq3Yl
         kePsXLl4Yl0gZiNqjxtlgIq+Lsf6DCgP2jqzwnashew7CkeHtmA/LQxxb5woM06rggtw
         nC6J1UML+ZH8qK3JwMvY1A3STzcUWGn3/33AchzkidJMGUN03AGezDfVSJ4xM7LOQrKg
         Dr3ascrsKxZF1WNnmz/CGsyvMby3Ri2DYwNvG4b2rNMVTEuRkSXNkquhOslF0EiO+wES
         J2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrRx5/BklT85p3DSbmvBb6z8bn+3+nVNyzOBaYtTefU=;
        b=KSwk7EgM7qePy2YHrciEpJHp1uazMWdxqp6du2vyhkuEu0121EcREBvGF4JvhWP87q
         J/mB6S25zX+TL2WXbG72pHL0X3fCihYTkhrwl8/Mhlyudub1oK+MxdfDBmuSoI7eAO3q
         WJsxvFKuUZGZ9zzuTnKi3rCwFSikyjZXdimpfehopD4j6/YnsMMWRFnokN4POOvYFBMb
         b3osiTussJm2lV5KqxDIbaTk2nn8avm1DRCK8N2n0spsy65CSpGw4Q8jvMT3LtF7R/y1
         4pD8H8QggJaZpSmzA8bOT2eEUbd5jJqfT0TO5J7JowOK7f0KvdguDXvkZqDiKwRullIA
         MtXw==
X-Gm-Message-State: ACrzQf1VV6Z7DcnptmrtK2na3OVZh/2CCddd1nMOTYNFi0glGs3zhtoa
        HFzObTtVqhDMn6Lav7w3t+M4K6jsXCM=
X-Google-Smtp-Source: AMsMyM5I62/ZcVuX8piCdFu/josM2VkgtCKDmibYct57av9+49It14Sd6qRFNK6TtijSLhpkpo+Q3g==
X-Received: by 2002:a63:494e:0:b0:448:5163:4788 with SMTP id y14-20020a63494e000000b0044851634788mr27793421pgk.507.1665642264907;
        Wed, 12 Oct 2022 23:24:24 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id i125-20020a628783000000b00562a0c8a195sm1008589pfe.69.2022.10.12.23.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:24 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 18/25] bpf: Teach verifier about non-size constant arguments
Date:   Thu, 13 Oct 2022 11:52:56 +0530
Message-Id: <20221013062303.896469-19-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15606; i=memxor@gmail.com; h=from:subject; bh=pcJ/Qf6gNnbRXiKlp1ESOMNrjI9OaWy/KIgZ1Gd+4kM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67EtBo6AaibBpC6MNs1ZXigWHtpzj81LMKZwfQK q21CedmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euxAAKCRBM4MiGSL8RyrdpD/ 0TkNmmHyKFPr9iCsRAZ6EzX4aMZloYV+S7SP3nO/uXQQferXRA9rRF5oaiwT1Tq83R1B0d248fMOzR 2xkcl7Exxr1dW1RkikAmqbkG0H+3kmn098Jl/zPBdd5Rj6BhhRhARFWSKPxrVnbc7PjcEO1bG15V09 89Rcbhr1WAIbLttWsDrNkK+wTixd0oZOQg0WNuGsKE0eSeu3+Kn5qoqSjdCnUCI0i6mW7KIhNp/Wt4 tve+5xekAQKGUMo6c8rdRs+gHoUALXDZ0G9qyQeGvDP8j0IKfipuZw9o4jZNSUKKM7JXufi/PqNGGJ BWKgNWPTV9KPiz2tU1KM5X6I+r/kUm7t9uUJQXoiJA27riH7wnL3I1XyX/qsgPDK3hhEnEPdAS3duO vnNyz3qmEGerfFOUaYrPMS1iiQhe3yCHrO5+fZxG49Mr/CW+dn+dv2xInmCtv4mtyLGogyrauag/aL zAIvX/Wu5Lt23JRizUQSSCOJAOGBu+yY95DHQ/gGxwxHBjsN8n4f2dOO+HAacmToJ38+fDNo88GS1q QSFRknXQt6UuyoCcg+P0nYwfUiKL469Vw7RsEFsBM8xb80sAl8Lkf+fHbCvdjsNww8v91719u1FwfU Wu39IjjcLNq6b7cBFWKqmVKTC3dMmtUchOoI4ElqIuwzDGuhfVFjZcnaoo2Q==
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
work. Search can only be pruned if both are constant values and both are
equal. In all other cases, it would be incorrect to treat those two
precise registers as equivalent if the new value satisfies the old one
(i.e. old <= cur).

Hence, make the register precision marker tri-state. There are now three
values that reg->precise takes: NOT_PRECISE, PRECISE, EXACT.

Both PRECISE and EXACT are 'true' values. EXACT affects how regsafe
decides whether both registers are equivalent for the purposes of
verifier state equivalence. When it sees that one register has
reg->precise == EXACT, unless both are absolute, it will return false.
When both are, it returns true only when both are const and both have
the same value. Otherwise, for PRECISE case it falls back to the default
check that is present now (i.e. thinking that we're talking about
sizes).

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
 include/linux/bpf_verifier.h |  10 ++--
 kernel/bpf/verifier.c        | 101 ++++++++++++++++++++++-------------
 2 files changed, 70 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4585de45ad1c..8b09c3f82071 100644
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
@@ -624,8 +630,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    struct bpf_attach_target_info *tgt_info);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
-int mark_chain_precision(struct bpf_verifier_env *env, int regno);
-
 #define BPF_BASE_TYPE_MASK	GENMASK(BPF_BASE_TYPE_BITS - 1, 0)
 
 /* extract base type from bpf_{arg, return, reg}_type. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7c3d7d07773f..b324c1042fb8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -855,7 +855,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 		print_liveness(env, reg->live);
 		verbose(env, "=");
 		if (t == SCALAR_VALUE && reg->precise)
-			verbose(env, "P");
+			verbose(env, reg->precise == EXACT ? "E" : "P");
 		if ((t == SCALAR_VALUE || t == PTR_TO_STACK) &&
 		    tnum_is_const(reg->var_off)) {
 			/* reg->off should be 0 for SCALAR_VALUE */
@@ -952,7 +952,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 			t = reg->type;
 			verbose(env, "=%s", t == SCALAR_VALUE ? "" : reg_type_str(env, t));
 			if (t == SCALAR_VALUE && reg->precise)
-				verbose(env, "P");
+				verbose(env, reg->precise == EXACT ? "E" : "P");
 			if (t == SCALAR_VALUE && tnum_is_const(reg->var_off))
 				verbose(env, "%lld", reg->var_off.value + reg->off);
 		} else {
@@ -1686,7 +1686,17 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
-	reg->precise = env->subprog_cnt > 1 || !env->bpf_capable;
+	/* Helpers requiring EXACT for constant arguments cannot be called from
+	 * programs without CAP_BPF. This is because we don't propagate
+	 * precision markers for when CAP_BPF is missing. If we allowed calling
+	 * such heleprs in those programs, the default would have to be EXACT
+	 * for them, which would be too aggresive.
+	 *
+	 * We still propagate EXACT when subprog_cnt > 1, hence those cases
+	 * would still override the default PRECISE value when we propagate the
+	 * precision markers.
+	 */
+	reg->precise = (env->subprog_cnt > 1 || !env->bpf_capable) ? PRECISE : NOT_PRECISE;
 	__mark_reg_unbounded(reg);
 }
 
@@ -2736,7 +2746,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
  * For now backtracking falls back into conservative marking.
  */
 static void mark_all_scalars_precise(struct bpf_verifier_env *env,
-				     struct bpf_verifier_state *st)
+				     struct bpf_verifier_state *st,
+				     enum bpf_reg_precise precise)
 {
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
@@ -2752,7 +2763,7 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 				reg = &func->regs[j];
 				if (reg->type != SCALAR_VALUE)
 					continue;
-				reg->precise = true;
+				reg->precise = precise;
 			}
 			for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
 				if (!is_spilled_reg(&func->stack[j]))
@@ -2760,13 +2771,13 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 				reg = &func->stack[j].spilled_ptr;
 				if (reg->type != SCALAR_VALUE)
 					continue;
-				reg->precise = true;
+				reg->precise = precise;
 			}
 		}
 }
 
 static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
-				  int spi)
+				  int spi, enum bpf_reg_precise precise)
 {
 	struct bpf_verifier_state *st = env->cur_state;
 	int first_idx = st->first_insn_idx;
@@ -2793,7 +2804,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 			new_marks = true;
 		else
 			reg_mask = 0;
-		reg->precise = true;
+		reg->precise = precise;
 	}
 
 	while (spi >= 0) {
@@ -2810,7 +2821,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 			new_marks = true;
 		else
 			stack_mask = 0;
-		reg->precise = true;
+		reg->precise = precise;
 		break;
 	}
 
@@ -2832,7 +2843,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 				err = backtrack_insn(env, i, &reg_mask, &stack_mask);
 			}
 			if (err == -ENOTSUPP) {
-				mark_all_scalars_precise(env, st);
+				mark_all_scalars_precise(env, st, precise);
 				return 0;
 			} else if (err) {
 				return err;
@@ -2873,7 +2884,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 			}
 			if (!reg->precise)
 				new_marks = true;
-			reg->precise = true;
+			reg->precise = precise;
 		}
 
 		bitmap_from_u64(mask, stack_mask);
@@ -2892,7 +2903,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 				 * fp-8 and it's "unallocated" stack space.
 				 * In such case fallback to conservative.
 				 */
-				mark_all_scalars_precise(env, st);
+				mark_all_scalars_precise(env, st, precise);
 				return 0;
 			}
 
@@ -2907,7 +2918,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 			}
 			if (!reg->precise)
 				new_marks = true;
-			reg->precise = true;
+			reg->precise = precise;
 		}
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "parent %s regs=%x stack=%llx marks:",
@@ -2927,14 +2938,16 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
-int mark_chain_precision(struct bpf_verifier_env *env, int regno)
+static int mark_chain_precision(struct bpf_verifier_env *env, int regno,
+				enum bpf_reg_precise precise)
 {
-	return __mark_chain_precision(env, regno, -1);
+	return __mark_chain_precision(env, regno, -1, precise);
 }
 
-static int mark_chain_precision_stack(struct bpf_verifier_env *env, int spi)
+static int mark_chain_precision_stack(struct bpf_verifier_env *env, int spi,
+				      enum bpf_reg_precise precise)
 {
-	return __mark_chain_precision(env, -1, spi);
+	return __mark_chain_precision(env, -1, spi, precise);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -3069,7 +3082,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			 * Backtrack from here and mark all registers as precise
 			 * that contributed into 'reg' being a constant.
 			 */
-			err = mark_chain_precision(env, value_regno);
+			err = mark_chain_precision(env, value_regno, PRECISE);
 			if (err)
 				return err;
 		}
@@ -3110,7 +3123,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		/* when we zero initialize stack slots mark them as such */
 		if (reg && register_is_null(reg)) {
 			/* backtracking doesn't work for STACK_ZERO yet. */
-			err = mark_chain_precision(env, value_regno);
+			err = mark_chain_precision(env, value_regno, PRECISE);
 			if (err)
 				return err;
 			type = STACK_ZERO;
@@ -3226,7 +3239,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	}
 	if (zero_used) {
 		/* backtracking doesn't work for STACK_ZERO yet. */
-		err = mark_chain_precision(env, value_regno);
+		err = mark_chain_precision(env, value_regno, PRECISE);
 		if (err)
 			return err;
 	}
@@ -3275,7 +3288,7 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
 		 * backtracking. Any register that contributed
 		 * to const 0 was marked precise before spill.
 		 */
-		state->regs[dst_regno].precise = true;
+		state->regs[dst_regno].precise = PRECISE;
 	} else {
 		/* have read misc data from the stack */
 		mark_reg_unknown(env, state->regs, dst_regno);
@@ -5332,7 +5345,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 				      reg->umax_value,
 				      zero_size_allowed, meta);
 	if (!err)
-		err = mark_chain_precision(env, regno);
+		err = mark_chain_precision(env, regno, PRECISE);
 	return err;
 }
 
@@ -6150,7 +6163,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->mem_size = reg->var_off.value;
-		err = mark_chain_precision(env, regno);
+		err = mark_chain_precision(env, regno, PRECISE);
 		if (err)
 			return err;
 		break;
@@ -7117,7 +7130,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return 0;
 	}
 
-	err = mark_chain_precision(env, BPF_REG_3);
+	err = mark_chain_precision(env, BPF_REG_3, PRECISE);
 	if (err)
 		return err;
 	if (bpf_map_key_unseen(aux))
@@ -7217,7 +7230,7 @@ static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 	bool reg_is_null = register_is_null(reg);
 
 	if (reg_is_null)
-		mark_chain_precision(env, BPF_REG_4);
+		mark_chain_precision(env, BPF_REG_4, PRECISE);
 
 	return reg_is_null;
 }
@@ -8039,7 +8052,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					verbose(env, "R%d must be a known constant\n", regno);
 					return -EINVAL;
 				}
-				ret = mark_chain_precision(env, regno);
+				ret = mark_chain_precision(env, regno, EXACT);
 				if (ret < 0)
 					return ret;
 				meta->arg_constant.found = true;
@@ -8063,7 +8076,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 
 				meta->r0_size = reg->var_off.value;
-				ret = mark_chain_precision(env, regno);
+				ret = mark_chain_precision(env, regno, PRECISE);
 				if (ret)
 					return ret;
 			}
@@ -9742,7 +9755,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				 * This is legal, but we have to reverse our
 				 * src/dest handling in computing the range
 				 */
-				err = mark_chain_precision(env, insn->dst_reg);
+				err = mark_chain_precision(env, insn->dst_reg, PRECISE);
 				if (err)
 					return err;
 				return adjust_ptr_min_max_vals(env, insn,
@@ -9750,7 +9763,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			}
 		} else if (ptr_reg) {
 			/* pointer += scalar */
-			err = mark_chain_precision(env, insn->src_reg);
+			err = mark_chain_precision(env, insn->src_reg, PRECISE);
 			if (err)
 				return err;
 			return adjust_ptr_min_max_vals(env, insn,
@@ -10746,10 +10759,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -12070,9 +12083,19 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		if (rcur->type == SCALAR_VALUE) {
 			if (!rold->precise && !rcur->precise)
 				return true;
-			/* new val must satisfy old val knowledge */
-			return range_within(rold, rcur) &&
-			       tnum_in(rold->var_off, rcur->var_off);
+			/* We can only determine safety when type of precision
+			 * needed is same. For EXACT, we need values to match
+			 * exactly, so simply return false as the memcmp above
+			 * failed already, otherwise current being within the
+			 * old value suffices.
+			 */
+			if (rold->precise == EXACT || rcur->precise == EXACT) {
+				return false;
+			} else {
+				/* new val must satisfy old val knowledge */
+				return range_within(rold, rcur) &&
+				       tnum_in(rold->var_off, rcur->var_off);
+			}
 		} else {
 			/* We're trying to use a pointer in place of a scalar.
 			 * Even if the scalar was unbounded, this could lead to
@@ -12401,8 +12424,9 @@ static int propagate_precision(struct bpf_verifier_env *env,
 		    !state_reg->precise)
 			continue;
 		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "propagating r%d\n", i);
-		err = mark_chain_precision(env, i);
+			verbose(env, "propagating %sr%d\n",
+				state_reg->precise == EXACT ? "exact " : "", i);
+		err = mark_chain_precision(env, i, state_reg->precise);
 		if (err < 0)
 			return err;
 	}
@@ -12415,9 +12439,10 @@ static int propagate_precision(struct bpf_verifier_env *env,
 		    !state_reg->precise)
 			continue;
 		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "propagating fp%d\n",
+			verbose(env, "propagating %sfp%d\n",
+				state_reg->precise == EXACT ? "exact " : "",
 				(-i - 1) * BPF_REG_SIZE);
-		err = mark_chain_precision_stack(env, i);
+		err = mark_chain_precision_stack(env, i, state_reg->precise);
 		if (err < 0)
 			return err;
 	}
-- 
2.38.0


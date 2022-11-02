Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95D5616EB4
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiKBU2P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiKBU2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:28:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7791017
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:28:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id io19so17667754plb.8
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ifA8X7m6S/x1p1DCauFZxal/zrev76a9tfwgxrSaGM=;
        b=CNmHPd5jz4GbWgt2hh2Io3jZLm96XfHqaS5JLm2prc8uqQ9IocirzOWp5fXHEW5ego
         5GngGfW4/qaE3vzR80CAzJGxo+z89NjTfyeyRF4/FMSj5JebKAL0cCGKesX38UXYzd1M
         CidPWaqIz8MtKlOi4MNZBZ7a8eTmJAnw0i8PO1yTpFGmeys+3+ZZIFejmCv1sDjhe4DY
         LVAKVqAKH3r/lcAbLOPtrQB9HqDdUiL1qiRzyHxZPHYR4iBf3N1HrSPwchxX01atjHtc
         xG6G593i/zZj0rhGZOIr9toEcfSJ8vEWHO35ZXfAOwApSq3oNPcTLQ5gh42eERv/uO8H
         4SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ifA8X7m6S/x1p1DCauFZxal/zrev76a9tfwgxrSaGM=;
        b=wOgckDxRfs7R3KRdv5XmjtQY4T7fmt4JcJg2BXUfQ4mHsOqkhmPRKtGTsALP7MDArg
         F5k9KHEQzEgdAIkWcaaYXidWsf8/QccT79Qz/iOK5+mo4RBFeZb9rCGqwan7iyzQuS7l
         Iwreg7i/hb1I8ThbXELHuz8sP3BALIggeNbQyoAr4bRDMe5qYbzudCghuNJY8hHEtNoz
         mMw6JLR44iapHNlOpVuqalholJMcrAnN4B2KDylmyK2+Wy7R7WUm1sCE3XoZUjsqFxO+
         ONqdZCJQNAMb0yQCg/PF+lvgckpa2wM3cnwWKe8KMOiwrDWkHCFe1Sjw1HyxjgvrOhfQ
         9l8w==
X-Gm-Message-State: ACrzQf2SUTw5NxErj4ekCSW45PuhMUbdYLAJtMWLUQx+37VVi5blWEAD
        ZdodeG2lJjAn6AWHHj2rp9/IoT5u2GUn+A==
X-Google-Smtp-Source: AMsMyM6TrNpDnpwInqOlDr2a3cv3M+MlxzSbEwgvo5d2HqcHlDynQTlvbX6YwSdCLuF6qlutwpccdA==
X-Received: by 2002:a17:902:b20a:b0:178:6f5b:f903 with SMTP id t10-20020a170902b20a00b001786f5bf903mr27240570plr.39.1667420886949;
        Wed, 02 Nov 2022 13:28:06 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id w141-20020a627b93000000b00560bb4a57f7sm9121736pfc.179.2022.11.02.13.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:28:06 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 18/24] bpf: Teach verifier about non-size constant arguments
Date:   Thu,  3 Nov 2022 01:56:52 +0530
Message-Id: <20221102202658.963008-19-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15606; i=memxor@gmail.com; h=from:subject; bh=mhkLUBCQwrjcQQGvt65x7laAC4HpnUE7wiGfp7p/4qA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtIEyj+ygt9C5JLfEA7tkZCmJ9/xjvKIll05/EUX uzqjO1SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSBAAKCRBM4MiGSL8RylU0D/ 0QAb65XKQGTbCqC87lCFbt8OBmR6HrT91moWn5WUn7lo4uhvIU50VZ7+k6eXoERSusVEzJ3LpgCsiH Nw6GbAnBpP4JtuQ++0GqprIWDw2GgGSYPPbDssp/61MuU1lu4sahiwZi7AWjIaivxMPkSSo0nD9RIF 5N1n3h1UDdTNCOthbEQVzUTGB7g1B1gXmDcmGjiCPmkCl6O+yGkZEnSmvnqc+cQgEtHt7i71Vvp9XP Uf37DzaxNQfEoe41ZZwxbKV31oTPWPPGNaYtXDqBQxPQxcFP69Pj+jJj3E9StOU5ug144SnNBDj9hE LUn8CGGpasE+rrOKkXwBNxww++5dCoa9/hwfERPCcMcDxnbYyL1jE8BL9kGtPtZfmmmA4s2X8W/U0F 3FOlt7g389xi/X7G/e9MJ8CEaYbyXFBoSXKChAARDkYqlmkWanYTSpmg7tARNxqbMwAURsp3+JI8Pg LUdNmGCkLMgH2wrzQ2AWsH/RT+dqcbCAzjvXw4hkNOM+a7FBHFBSvrBaEuGadBoesbZQ2K2zZ5Z3vO gj/fTEl508d7kuzCBptp4/K4YkRY+XfShk+Yf9Hlh33M/wbfhTHfhAInwZe+07XcBgJX0M6ODheOVV JBaC4Mc6UO0vTQnf85M0aCu8LbvmDB0aZRhhInPtbHyPPrgxTAvdoKLRjwBA==
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
index 8dad74432677..2614892ca063 100644
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
index b92725f54496..074070e7a105 100644
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
@@ -5342,7 +5355,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
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
@@ -7127,7 +7140,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return 0;
 	}
 
-	err = mark_chain_precision(env, BPF_REG_3);
+	err = mark_chain_precision(env, BPF_REG_3, PRECISE);
 	if (err)
 		return err;
 	if (bpf_map_key_unseen(aux))
@@ -7227,7 +7240,7 @@ static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 	bool reg_is_null = register_is_null(reg);
 
 	if (reg_is_null)
-		mark_chain_precision(env, BPF_REG_4);
+		mark_chain_precision(env, BPF_REG_4, PRECISE);
 
 	return reg_is_null;
 }
@@ -8048,7 +8061,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					verbose(env, "R%d must be a known constant\n", regno);
 					return -EINVAL;
 				}
-				ret = mark_chain_precision(env, regno);
+				ret = mark_chain_precision(env, regno, EXACT);
 				if (ret < 0)
 					return ret;
 				meta->arg_constant.found = true;
@@ -8072,7 +8085,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 
 				meta->r0_size = reg->var_off.value;
-				ret = mark_chain_precision(env, regno);
+				ret = mark_chain_precision(env, regno, PRECISE);
 				if (ret)
 					return ret;
 			}
@@ -9751,7 +9764,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				 * This is legal, but we have to reverse our
 				 * src/dest handling in computing the range
 				 */
-				err = mark_chain_precision(env, insn->dst_reg);
+				err = mark_chain_precision(env, insn->dst_reg, PRECISE);
 				if (err)
 					return err;
 				return adjust_ptr_min_max_vals(env, insn,
@@ -9759,7 +9772,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			}
 		} else if (ptr_reg) {
 			/* pointer += scalar */
-			err = mark_chain_precision(env, insn->src_reg);
+			err = mark_chain_precision(env, insn->src_reg, PRECISE);
 			if (err)
 				return err;
 			return adjust_ptr_min_max_vals(env, insn,
@@ -10755,10 +10768,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -12079,9 +12092,19 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
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
@@ -12410,8 +12433,9 @@ static int propagate_precision(struct bpf_verifier_env *env,
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
@@ -12424,9 +12448,10 @@ static int propagate_precision(struct bpf_verifier_env *env,
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
2.38.1


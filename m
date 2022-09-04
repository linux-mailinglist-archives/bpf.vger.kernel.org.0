Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2205AC66E
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiIDUmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiIDUmM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430862CE2B
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 29so3957485edv.2
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fhbqFkSvXgib6zhrMKHWugAZasrZRoUaieiKXqcLjJQ=;
        b=Owpnn9DuDzsCQ3NiAFvPRx74DOohlslj5fFLUrqEK73blTGKD6FIbHGp9/6NN4Myay
         +UecuYITpbqKAqtwHnc+xbdUl7hG9OOrfaeTqwkgrQ8xUJM/9hZoqgzOkNOF/yK+1nRq
         ifgD8ASF6yrCwAaCd9ZcDVJQ1GIyqdhbKDKi7XClaJEDq8EQSR8h99hqjsR62ZTAudlo
         1ZyG92poz5tbK6InthkGewD/BUX/GKVDV3K1JPFWCFLCHo0ibsBbrnxOipdr5Gn57sJh
         Jt+7mUKPVUSZ8eJRyAw+/D3NFKNxJ+hG2lxJgILQuXrzZ9HoOqgZWf7qjiYVr0EcIn/e
         SF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fhbqFkSvXgib6zhrMKHWugAZasrZRoUaieiKXqcLjJQ=;
        b=mm+uaKgQ9g6bEYSlsbUjtUunMWfwNgh4jd4f5DlSKk8ryYHa4sbacTHLF9OvodKB8R
         vwHZQKQSFpQHnk7c6bp792mRCwLhXqsIn3IFWCZgfHuJQIC6Nz+rgaivkwDP+5HcaqBd
         CT9GiinmG3dNQLKgtWBgnEopPNDVYojZk5jgfNjTEdj2DhSn2d7x/Pb1eg1zkmt6ZTFi
         b2g8PT4a5aBD9abrVQPJF+WUYRqG3dKrGCdfUuKe7udtCUcbucjUuhPHkNr2gRLPO2tk
         mr9HSwrVjO8VE4iC/tsupXk4yQuhuBJ7THeNj/RiNnu4VgAxFm5WQXNKDrUNUWfWQ+6G
         kE9Q==
X-Gm-Message-State: ACgBeo0P9T5rICwvC3kHwbgNTerjpFLfSrcUS+MfEsbVUtk/luQvwwwu
        ZIgeVCPRfdgn8j2W4VgVefubTyW7UnX8IA==
X-Google-Smtp-Source: AA6agR7M6G+6e9ovQMg/RzrRdbR60x130uPSQxvy1UH2E++TUdKFUqMco5O4OdHPbmH5I9/R/m2rQA==
X-Received: by 2002:a05:6402:35c7:b0:448:95be:380 with SMTP id z7-20020a05640235c700b0044895be0380mr26778332edc.393.1662324121922;
        Sun, 04 Sep 2022 13:42:01 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906539600b0072b85a735afsm4075955ejo.113.2022.09.04.13.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:01 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 12/32] bpf: Teach verifier about non-size constant arguments
Date:   Sun,  4 Sep 2022 22:41:25 +0200
Message-Id: <20220904204145.3089-13-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12186; i=memxor@gmail.com; h=from:subject; bh=vPdGmL/y4feiYKyVO8hH+LwICkGb/Y5HVe9jKnwB+2w=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wkv5g5OQJF/csyOCuArS+xsnEUUI1AgX13CcV jYfAPH6JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8RytQnD/ 9IiHY6+AXLAa1MjHqEYRn7zTMwhlFqfCwJM1brQxxmvKZ62n2UZ1UW14TdpmrzdjVQKgGv8Z7qFv6C WYM4PrkyyLW1V4uXZ1kZCuPJQStzkTMtDGtTsUVUX54PlRGf1WRt81ls8DKAjInQDdk7lSY7oH/XI1 I1P0F/7VQjyNYn2Vsfg77llIk8gRKerlWpCk3zWfKfMv1LqKfQVOmIBNJuxDZaOP1RXrWEthYcNGYN Q4x8hxqU9kuXzVMr8AHFdf2XykiunEfT0Rq0jcf5YTccBZO+uzcM06aqmDe/kL987p+FlNEUVBK4/y MrE60oqyGDo9HG0jsfl5A042rLmvxd1nNrnxxDIvARfDHWxMGh1JG0o+OSRYe5LwPoOskMeVMBnxz3 rr1OFz0AvO6ZeAmzhYrTCvOTfDqABbnho5H2MvuAVVwVk7Al71TcnmBf4e2OenaWG2MrITpaFH7upi cFtfrEICB4av6a7LU5ZWhshx+lzeezY77rjgYk9PdTr8DP+MWizYcIO3bj7GE5r5PECL2PcDyOJIdE WwvTy1qYpia0FZM7LU1MZmzV/BxxoRz2oc9V/uvDOUxPbi4m4MdVxQWjs3HgRvJ6XDzlISd90FWNRy fZMqzRgru5gHEzIXy3itvXUVoD8RSyzcrlNKXWuxTyOrXy+7Lg8ybsBxc1HA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
values that reg->precise takes: NOT_PRECISE, PRECISE, PRECISE_ABSOLUTE.

Both PRECISE and PRECISE_ABSOLUTE are 'true' values. PRECISE_ABSOLUTE
affects how regsafe decides whether both registers are equivalent for
the purposes of verifier state equivalence. When it sees that one
register has reg->precise == PRECISE_ABSOLUTE, unless both are absolute,
it will return false. When both are, it returns true only when both are
const and both have the same value. Otherwise, for PRECISE case it falls
back to the default check that is present now (i.e. thinking that we're
talking about sizes).

This is required as a future patch introduces a BPF memory allocator
interface, where we take the program BTF's type ID as an argument. Each
distinct type ID may result in the returned pointer obtaining a
different size, hence precision tracking is needed, and pruning cannot
just happen when the old value is within the current value. It must only
happen when the type ID is equal. The type ID will always correspond to
prog->aux->btf hence actual type match is not required.

Finally, change mark_chain_precision to mark_chain_precision_absolute
for kfuncs constant non-size scalar arguments (tagged with __k suffix).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  8 +++-
 kernel/bpf/verifier.c        | 93 ++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b4a11ff56054..c4d21568d192 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -43,6 +43,12 @@ enum bpf_reg_liveness {
 	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
 };
 
+enum bpf_reg_precise {
+	NOT_PRECISE,
+	PRECISE,
+	PRECISE_ABSOLUTE,
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b28e88d6fabd..571790ac58d4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -838,7 +838,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 		print_liveness(env, reg->live);
 		verbose(env, "=");
 		if (t == SCALAR_VALUE && reg->precise)
-			verbose(env, "P");
+			verbose(env, reg->precise == PRECISE_ABSOLUTE ? "PA" : "P");
 		if ((t == SCALAR_VALUE || t == PTR_TO_STACK) &&
 		    tnum_is_const(reg->var_off)) {
 			/* reg->off should be 0 for SCALAR_VALUE */
@@ -935,7 +935,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 			t = reg->type;
 			verbose(env, "=%s", t == SCALAR_VALUE ? "" : reg_type_str(env, t));
 			if (t == SCALAR_VALUE && reg->precise)
-				verbose(env, "P");
+				verbose(env, reg->precise == PRECISE_ABSOLUTE ? "PA" : "P");
 			if (t == SCALAR_VALUE && tnum_is_const(reg->var_off))
 				verbose(env, "%lld", reg->var_off.value + reg->off);
 		} else {
@@ -1668,7 +1668,17 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
-	reg->precise = env->subprog_cnt > 1 || !env->bpf_capable;
+	/* Helpers requiring PRECISE_ABSOLUTE for constant arguments cannot be
+	 * called from programs without CAP_BPF. This is because we don't
+	 * propagate precision markers for when CAP_BPF is missing. If we
+	 * allowed calling such heleprs in those programs, the default would
+	 * have to be PRECISE_ABSOLUTE for them, which would be too aggresive.
+	 *
+	 * We still propagate PRECISE_ABSOLUTE when subprog_cnt > 1, hence
+	 * those cases would still override the default PRECISE value when
+	 * we propagate the precision markers.
+	 */
+	reg->precise = (env->subprog_cnt > 1 || !env->bpf_capable) ? PRECISE : NOT_PRECISE;
 	__mark_reg_unbounded(reg);
 }
 
@@ -2717,7 +2727,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
  * For now backtracking falls back into conservative marking.
  */
 static void mark_all_scalars_precise(struct bpf_verifier_env *env,
-				     struct bpf_verifier_state *st)
+				     struct bpf_verifier_state *st,
+				     bool absolute)
 {
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
@@ -2733,7 +2744,7 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 				reg = &func->regs[j];
 				if (reg->type != SCALAR_VALUE)
 					continue;
-				reg->precise = true;
+				reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
 			}
 			for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
 				if (!is_spilled_reg(&func->stack[j]))
@@ -2741,13 +2752,13 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 				reg = &func->stack[j].spilled_ptr;
 				if (reg->type != SCALAR_VALUE)
 					continue;
-				reg->precise = true;
+				reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
 			}
 		}
 }
 
 static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
-				  int spi)
+				  int spi, bool absolute)
 {
 	struct bpf_verifier_state *st = env->cur_state;
 	int first_idx = st->first_insn_idx;
@@ -2774,7 +2785,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 			new_marks = true;
 		else
 			reg_mask = 0;
-		reg->precise = true;
+		reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
 	}
 
 	while (spi >= 0) {
@@ -2791,7 +2802,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 			new_marks = true;
 		else
 			stack_mask = 0;
-		reg->precise = true;
+		reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
 		break;
 	}
 
@@ -2813,7 +2824,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 				err = backtrack_insn(env, i, &reg_mask, &stack_mask);
 			}
 			if (err == -ENOTSUPP) {
-				mark_all_scalars_precise(env, st);
+				mark_all_scalars_precise(env, st, absolute);
 				return 0;
 			} else if (err) {
 				return err;
@@ -2854,7 +2865,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 			}
 			if (!reg->precise)
 				new_marks = true;
-			reg->precise = true;
+			reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
 		}
 
 		bitmap_from_u64(mask, stack_mask);
@@ -2873,7 +2884,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 				 * fp-8 and it's "unallocated" stack space.
 				 * In such case fallback to conservative.
 				 */
-				mark_all_scalars_precise(env, st);
+				mark_all_scalars_precise(env, st, absolute);
 				return 0;
 			}
 
@@ -2888,7 +2899,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 			}
 			if (!reg->precise)
 				new_marks = true;
-			reg->precise = true;
+			reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
 		}
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "parent %s regs=%x stack=%llx marks:",
@@ -2910,12 +2921,24 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 
 static int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
-	return __mark_chain_precision(env, regno, -1);
+	return __mark_chain_precision(env, regno, -1, false);
+}
+
+static int mark_chain_precision_absolute(struct bpf_verifier_env *env, int regno)
+{
+	WARN_ON_ONCE(!env->bpf_capable);
+	return __mark_chain_precision(env, regno, -1, true);
 }
 
 static int mark_chain_precision_stack(struct bpf_verifier_env *env, int spi)
 {
-	return __mark_chain_precision(env, -1, spi);
+	return __mark_chain_precision(env, -1, spi, false);
+}
+
+static int mark_chain_precision_absolute_stack(struct bpf_verifier_env *env, int spi)
+{
+	WARN_ON_ONCE(!env->bpf_capable);
+	return __mark_chain_precision(env, -1, spi, true);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -3253,7 +3276,7 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
 		 * backtracking. Any register that contributed
 		 * to const 0 was marked precise before spill.
 		 */
-		state->regs[dst_regno].precise = true;
+		state->regs[dst_regno].precise = PRECISE;
 	} else {
 		/* have read misc data from the stack */
 		mark_reg_unknown(env, state->regs, dst_regno);
@@ -7903,7 +7926,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_arg_m
 					verbose(env, "R%d must be a known constant\n", regno);
 					return -EINVAL;
 				}
-				ret = mark_chain_precision(env, regno);
+				ret = mark_chain_precision_absolute(env, regno);
 				if (ret < 0)
 					return ret;
 				meta->arg_constant.found = true;
@@ -11899,9 +11922,23 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		if (rcur->type == SCALAR_VALUE) {
 			if (!rold->precise && !rcur->precise)
 				return true;
-			/* new val must satisfy old val knowledge */
-			return range_within(rold, rcur) &&
-			       tnum_in(rold->var_off, rcur->var_off);
+			/* We can only determine safety when type of precision
+			 * needed is same. For absolute, we must compare actual
+			 * value, otherwise old being within the current value
+			 * suffices.
+			 */
+			if (rold->precise == PRECISE_ABSOLUTE || rcur->precise == PRECISE_ABSOLUTE) {
+				/* Both should be PRECISE_ABSOLUTE for a comparison */
+				if (rold->precise != rcur->precise)
+					return false;
+				if (!tnum_is_const(rold->var_off) || !tnum_is_const(rcur->var_off))
+					return false;
+				return rold->var_off.value == rcur->var_off.value;
+			} else {
+				/* new val must satisfy old val knowledge */
+				return range_within(rold, rcur) &&
+				       tnum_in(rold->var_off, rcur->var_off);
+			}
 		} else {
 			/* We're trying to use a pointer in place of a scalar.
 			 * Even if the scalar was unbounded, this could lead to
@@ -12229,8 +12266,12 @@ static int propagate_precision(struct bpf_verifier_env *env,
 		    !state_reg->precise)
 			continue;
 		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "propagating r%d\n", i);
-		err = mark_chain_precision(env, i);
+			verbose(env, "propagating %sr%d\n",
+				state_reg->precise == PRECISE_ABSOLUTE ? "abs " : "", i);
+		if (state_reg->precise == PRECISE_ABSOLUTE)
+			err = mark_chain_precision_absolute(env, i);
+		else
+			err = mark_chain_precision(env, i);
 		if (err < 0)
 			return err;
 	}
@@ -12243,9 +12284,13 @@ static int propagate_precision(struct bpf_verifier_env *env,
 		    !state_reg->precise)
 			continue;
 		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "propagating fp%d\n",
+			verbose(env, "propagating %sfp%d\n",
+				state_reg->precise == PRECISE_ABSOLUTE ? "abs " : "",
 				(-i - 1) * BPF_REG_SIZE);
-		err = mark_chain_precision_stack(env, i);
+		if (state_reg->precise == PRECISE_ABSOLUTE)
+			err = mark_chain_precision_absolute_stack(env, i);
+		else
+			err = mark_chain_precision_stack(env, i);
 		if (err < 0)
 			return err;
 	}
-- 
2.34.1


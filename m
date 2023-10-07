Return-Path: <bpf+bounces-11610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51417BC7C5
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 14:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86A61C20A6B
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3C1F5EA;
	Sat,  7 Oct 2023 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EfYcZO4h"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E51F95A
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 12:45:55 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39860BC
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 05:45:50 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3af957bd7e9so2034309b6e.3
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696682749; x=1697287549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkf4aFTYieuomZtbAueKFY0zfv3YFReRX1NNzLDp4Cw=;
        b=EfYcZO4h2KMU8ACPVIX+PuGltMfvRrpkaJWp2zs6aE2iH1o5AjsZdDucDlxy3mnDCi
         x8YBHCSLKU5dyJJopc3Yac6CqTKyp8z7vtQad4Ll4keuYdz74DoLCufWGAhkCRcQ3noO
         9g7l49PHEQ/7QW0ULMhVKXPqXx9ymuMUfA4aePNe5prydBaJKNSOzj2KxSwJjhGg9Kwf
         pKrEM7H3KygdLLiD/a9Qc6KQkdp+VmiMOdAmwufz89kGJqvxG6dUvpNRNuIwN6fkpgHK
         PEAmA+TbXaUFGxvbE9RDs1QxUFThQIAY3ehIq+QI2YiyoRQRq9n8GB3OSl39UxrdakJa
         BHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696682749; x=1697287549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkf4aFTYieuomZtbAueKFY0zfv3YFReRX1NNzLDp4Cw=;
        b=Z8O0y6BsQsDpbnT7NHTKfmxN1sLp82zJ78+DSGh8NsszyixqCYU6sEfb34PxsrrkMh
         5uM8lnsOXhDpBIKKfo7wefod3+71WD16Hvup2EoCPZWMdlQs6uv486q7CCfWSDBMKZkV
         10FN4DxhVNffavN6LOmDtYc9PyuicDw+0UGajkVximAQhYUV6AIio2pIywCIPXKVqImr
         IVehtBbDntiZetKxjhxVbynQVVQkerpc1T0V0cRr/Fa3yiwe8vrpm1qFF1aEk9ZWYDLa
         +bs1dUASG9ELMBStQ5x2344/0FLqaZ356rBuFTdr7kZEdOSjTNxGpEx6oFOXZYDpGDmh
         ilLQ==
X-Gm-Message-State: AOJu0Yw8iTelmZRXmmusEZ0O80VsdYFm/sDHz8FTvAC1MKCC/JLXCP25
	g7/Q2sOxOvCPEz5znoXrzSmAW55qCUPEdFUSe1o=
X-Google-Smtp-Source: AGHT+IG1pdY11NUk012PPK1kfsvjHF16Pwv3+8Iu2nvsbBE2FYYhvOUjZTZhhwSjNhxIDusCxZucXg==
X-Received: by 2002:a05:6358:91c:b0:134:c8cb:6a00 with SMTP id r28-20020a056358091c00b00134c8cb6a00mr12564883rwi.12.1696682748715;
        Sat, 07 Oct 2023 05:45:48 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b00256799877ffsm5095388pjw.47.2023.10.07.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:45:48 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v4 5/8] bpf: teach the verifier to enforce css_iter and task_iter in RCU CS
Date: Sat,  7 Oct 2023 20:45:19 +0800
Message-Id: <20231007124522.34834-6-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231007124522.34834-1-zhouchuyi@bytedance.com>
References: <20231007124522.34834-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

css_iter and task_iter should be used in rcu section. Specifically, in
sleepable progs explicit bpf_rcu_read_lock() is needed before use these
iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK to
use them directly.

This patch adds a new a KF flag KF_RCU_PROTECTED for bpf_iter_task_new and
bpf_iter_css_new. It means the kfunc should be used in RCU CS. We check
whether we are in rcu cs before we want to invoke this kfunc. If the rcu
protection is guaranteed, we would let st->type = PTR_TO_STACK | MEM_RCU.
Once user do rcu_unlock during the iteration, state MEM_RCU of regs would
be cleared. is_iter_reg_valid_init() will reject if reg->type is UNTRUSTED.

It is worth noting that currently, bpf_rcu_read_unlock does not
clear the state of the STACK_ITER reg, since bpf_for_each_spilled_reg
only considers STACK_SPILL. This patch also let bpf_for_each_spilled_reg
search STACK_ITER.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/linux/bpf_verifier.h | 19 ++++++++------
 include/linux/btf.h          |  1 +
 kernel/bpf/helpers.c         |  4 +--
 kernel/bpf/verifier.c        | 50 ++++++++++++++++++++++++++++--------
 4 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 94ec766432f5..e67cd45a85be 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -386,19 +386,18 @@ struct bpf_verifier_state {
 	u32 jmp_history_cnt;
 };
 
-#define bpf_get_spilled_reg(slot, frame)				\
+#define bpf_get_spilled_reg(slot, frame, mask)				\
 	(((slot < frame->allocated_stack / BPF_REG_SIZE) &&		\
-	  (frame->stack[slot].slot_type[0] == STACK_SPILL))		\
+	  ((1 << frame->stack[slot].slot_type[0]) & (mask))) \
 	 ? &frame->stack[slot].spilled_ptr : NULL)
 
 /* Iterate over 'frame', setting 'reg' to either NULL or a spilled register. */
-#define bpf_for_each_spilled_reg(iter, frame, reg)			\
-	for (iter = 0, reg = bpf_get_spilled_reg(iter, frame);		\
+#define bpf_for_each_spilled_reg(iter, frame, reg, mask)			\
+	for (iter = 0, reg = bpf_get_spilled_reg(iter, frame, mask);		\
 	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
-	     iter++, reg = bpf_get_spilled_reg(iter, frame))
+	     iter++, reg = bpf_get_spilled_reg(iter, frame, mask))
 
-/* Invoke __expr over regsiters in __vst, setting __state and __reg */
-#define bpf_for_each_reg_in_vstate(__vst, __state, __reg, __expr)   \
+#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, __expr)   \
 	({                                                               \
 		struct bpf_verifier_state *___vstate = __vst;            \
 		int ___i, ___j;                                          \
@@ -410,7 +409,7 @@ struct bpf_verifier_state {
 				__reg = &___regs[___j];                  \
 				(void)(__expr);                          \
 			}                                                \
-			bpf_for_each_spilled_reg(___j, __state, __reg) { \
+			bpf_for_each_spilled_reg(___j, __state, __reg, __mask) { \
 				if (!__reg)                              \
 					continue;                        \
 				(void)(__expr);                          \
@@ -418,6 +417,10 @@ struct bpf_verifier_state {
 		}                                                        \
 	})
 
+/* Invoke __expr over regsiters in __vst, setting __state and __reg */
+#define bpf_for_each_reg_in_vstate(__vst, __state, __reg, __expr) \
+	bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, 1 << STACK_SPILL, __expr)
+
 /* linked list of verifier states used to prune search */
 struct bpf_verifier_state_list {
 	struct bpf_verifier_state state;
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 928113a80a95..c2231c64d60b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -74,6 +74,7 @@
 #define KF_ITER_NEW     (1 << 8) /* kfunc implements BPF iter constructor */
 #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
 #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
+#define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7596e83d6715..fb345507b12b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2552,10 +2552,10 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 528d375c17ee..3a60cc87520e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1173,7 +1173,12 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
 
 static void __mark_reg_known_zero(struct bpf_reg_state *reg);
 
+static bool in_rcu_cs(struct bpf_verifier_env *env);
+
+static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta);
+
 static int mark_stack_slots_iter(struct bpf_verifier_env *env,
+				 struct bpf_kfunc_call_arg_meta *meta,
 				 struct bpf_reg_state *reg, int insn_idx,
 				 struct btf *btf, u32 btf_id, int nr_slots)
 {
@@ -1194,6 +1199,12 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 
 		__mark_reg_known_zero(st);
 		st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
+		if (is_kfunc_rcu_protected(meta)) {
+			if (in_rcu_cs(env))
+				st->type |= MEM_RCU;
+			else
+				st->type |= PTR_UNTRUSTED;
+		}
 		st->live |= REG_LIVE_WRITTEN;
 		st->ref_obj_id = i == 0 ? id : 0;
 		st->iter.btf = btf;
@@ -1268,7 +1279,7 @@ static bool is_iter_reg_valid_uninit(struct bpf_verifier_env *env,
 	return true;
 }
 
-static bool is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   struct btf *btf, u32 btf_id, int nr_slots)
 {
 	struct bpf_func_state *state = func(env, reg);
@@ -1276,26 +1287,28 @@ static bool is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_
 
 	spi = iter_get_spi(env, reg, nr_slots);
 	if (spi < 0)
-		return false;
+		return -EINVAL;
 
 	for (i = 0; i < nr_slots; i++) {
 		struct bpf_stack_state *slot = &state->stack[spi - i];
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
+		if (st->type & PTR_UNTRUSTED)
+			return -EPROTO;
 		/* only main (first) slot has ref_obj_id set */
 		if (i == 0 && !st->ref_obj_id)
-			return false;
+			return -EINVAL;
 		if (i != 0 && st->ref_obj_id)
-			return false;
+			return -EINVAL;
 		if (st->iter.btf != btf || st->iter.btf_id != btf_id)
-			return false;
+			return -EINVAL;
 
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			if (slot->slot_type[j] != STACK_ITER)
-				return false;
+				return -EINVAL;
 	}
 
-	return true;
+	return 0;
 }
 
 /* Check if given stack slot is "special":
@@ -7618,15 +7631,24 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 				return err;
 		}
 
-		err = mark_stack_slots_iter(env, reg, insn_idx, meta->btf, btf_id, nr_slots);
+		err = mark_stack_slots_iter(env, meta, reg, insn_idx, meta->btf, btf_id, nr_slots);
 		if (err)
 			return err;
 	} else {
 		/* iter_next() or iter_destroy() expect initialized iter state*/
-		if (!is_iter_reg_valid_init(env, reg, meta->btf, btf_id, nr_slots)) {
+		err = is_iter_reg_valid_init(env, reg, meta->btf, btf_id, nr_slots);
+		switch (err) {
+		case 0:
+			break;
+		case -EINVAL:
 			verbose(env, "expected an initialized iter_%s as arg #%d\n",
 				iter_type_str(meta->btf, btf_id), regno);
-			return -EINVAL;
+			return err;
+		case -EPROTO:
+			verbose(env, "expected an RCU CS when using %s\n", meta->func_name);
+			return err;
+		default:
+			return err;
 		}
 
 		spi = iter_get_spi(env, reg, nr_slots);
@@ -10209,6 +10231,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RCU;
 }
 
+static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_RCU_PROTECTED;
+}
+
 static bool __kfunc_param_match_suffix(const struct btf *btf,
 				       const struct btf_param *arg,
 				       const char *suffix)
@@ -11560,6 +11587,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (env->cur_state->active_rcu_lock) {
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
+		u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
 
 		if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
 			verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
@@ -11570,7 +11598,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
 			return -EINVAL;
 		} else if (rcu_unlock) {
-			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+			bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
 				if (reg->type & MEM_RCU) {
 					reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
 					reg->type |= PTR_UNTRUSTED;
-- 
2.20.1



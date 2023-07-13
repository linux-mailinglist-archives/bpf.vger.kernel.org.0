Return-Path: <bpf+bounces-4903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368E975165B
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F6D1C20ADA
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83058EDF;
	Thu, 13 Jul 2023 02:33:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FFE7C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:33:12 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E6E7E
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:33:09 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 5614622812f47-3a04e5baffcso219267b6e.3
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215588; x=1691807588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQe0J58NWoZhAitZmCsyDVCzP91pOflb24L84mzbhP8=;
        b=aJsfUAMdUH03tv7akJBo1G/BWXkdOvl+m9fdOTX7sVHVqym5QMw/FkNdAYqRPoo0OP
         HJzrCv9sHOhSfzzvNr//uBtBuP2Knghz2IqX1+YQj1/gMaPNR16peH1kCYPXwgqYyABB
         evQqcAHaxjZexzxZhmwiIlU9Jo+AAEooufKLxMQEZ5X7dtqARBFD9gQ6IivnPQ4QUJ5j
         rhGhrKOprwa0Y0NmL8ILEkeP+fEC1HC2MiRX2uGAsBMqAMck4p4Qr5X25GlZIwqkCiuF
         Zd5k8sIUEUsI9l2jmimgq8M1mRpDovMCOyuXzMKcNgg7C9HltfnGbrPk1TlkbwVZEfsb
         frdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215588; x=1691807588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQe0J58NWoZhAitZmCsyDVCzP91pOflb24L84mzbhP8=;
        b=ilR7r1H7/pycIu1L3Cambl+VlsbhNZrPc0KWbqhTM3hVr/dO9K0WUk4VBhl9LCY1zo
         UeivzkCMPJrTpgy58iH8SPLTyStjuTBPJ0dpIij95of0BAMfVznrQq4GzrGuqHpzVYfj
         MsCe1mbNOqLRQM5CO2cjKLRxFn8Yvl91VEGNxocxaqnQqAoVCUpwHpwW7pMIbGfx/MAz
         WQnZGqAJMDq8nT1Z+AKpwxgxxjzjic8T1FdhhT3Gme47RU1C9/imfIZX8K9dLJRXJ3pb
         nrxAjiAXpH6KF8FxIm8i8481ysOICyajPCzesJbnTjxwI6eWqUHBqIu9tPnHO+CQyOuI
         L3WQ==
X-Gm-Message-State: ABy/qLYkEstuVo72P4Arbz+3H9SQOOEAnw1kwLMRI6H8d7xXJucRODe2
	ML7s6ol66R1VIMd08yaas975JPBd0JCR9g==
X-Google-Smtp-Source: APBJJlFXoQU2czbktkZDzoxPmZE9kEIJQ6PDuAhFvueATKHwcG/nolSaz047Xe6TuC8PDkUqqDuztQ==
X-Received: by 2002:aca:f104:0:b0:3a1:eee6:774f with SMTP id p4-20020acaf104000000b003a1eee6774fmr261106oih.50.1689215587856;
        Wed, 12 Jul 2023 19:33:07 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b00682a27905b9sm4409762pff.13.2023.07.12.19.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:33:07 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 08/10] bpf: Introduce bpf_set_exception_callback
Date: Thu, 13 Jul 2023 08:02:30 +0530
Message-Id: <20230713023232.1411523-9-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713023232.1411523-1-memxor@gmail.com>
References: <20230713023232.1411523-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12213; i=memxor@gmail.com; h=from:subject; bh=LGFTtA4ljIw84HxvWm9tBatHmSxIelNhpB7DiPy50yc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr2HIWB0tiHnSCjpFB+Lo+DWEYfbloHyqbxPRJ Of69v4yZO2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9hyAAKCRBM4MiGSL8R yolgD/42ppQJhEftXRQPlNm7b0MR0Se1QJGxVAfcPfj1zzbm95NEOX/vI0p1li84t101tFz5GI2 ZAnbl+OzVNRzih03qMGq6qRHOU1GbZ2IdHW9Jg+PBLV1r47tf5UgBxuFF/yXsJYdJ8X0z77oBHq Wl+0R+zteIf5QW9dTQpSO0tWmyqKykHsLihxY+0hmKgxk025J3j89+viwNWyhgSGfDPRsGCS7XF Evt+NAV4RXxJC/xOOQ/aVqnUzPYK8vGMFutJ8EQN0j5fHzHxAkNg/ZR4KJERBAOq71p40GcJAoz dr4oqedX/sMzCkDXWHMhFymIwTWBrrg7D0V1ldchLvT+PdJPUYNnAzaH9M3PLENkaxOUfj+NJaN oYwwus3M6YFswVVRrfb8ZsW9gzh8efEVHulg2eHYMIIeXvtLU5qfDpHhotl+f96buhGJNmixmg0 lxgvGHB3JKoTEgD49W5Si5eg1aTSaqMV4sRFg3UiJq1cYne1G3HV0WjLBMUqCcy+82XrieXXkf0 HD46PK05I6VdiJvfu77YJ9dnAxlDDJikh2T+VT1f0T5ua/njXM6BrQBkWgdIiqhfGArupzTxIUj aj7YnclGLE5uwgtpCzLyjQ1H4w5xzZk6o/Odf35FBx0L/kqEN+rwkckgwAM6XYb7yWfgfMKtr5W tTOaF/opWUVw31A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

By default, the subprog generated by the verifier to handle a thrown
exception hardcodes a return value of 0. To allow user-defined logic
and modification of the return value when an exception is thrown,
introduce the bpf_set_exception_callback kfunc, which installs a
callback as the default exception handler for the program.

Compared to runtime kfuncs, this kfunc acts a built-in, i.e. it only
takes semantic effect during verification, and is erased from the
program at runtime.

This kfunc can only be called once within a program, and always sets the
global exception handler, regardless of whether it was invoked in all
paths of the program or not. The kfunc is idempotent, and the default
exception callback cannot be modified at runtime.

Allowing modification of the callback for the current program execution
at runtime leads to issues when the programs begin to nest, as any
per-CPU state maintaing this information will have to be saved and
restored. We don't want it to stay in bpf_prog_aux as this takes a
global effect for all programs. An alternative solution is spilling
the callback pointer at a known location on the program stack on entry,
and then passing this location to bpf_throw as a parameter.

However, since exceptions are geared more towards a use case where they
are ideally never invoked, optimizing for this use case and adding to
the complexity has diminishing returns.

In the future, a variant of bpf_throw which allows supplying a callback
can also be introduced, to modify the callback for a certain throw
statement. For now, bpf_set_exception_callback is meant to serve as a
way to set statically set a subprog as the exception handler of a BPF
program.

TODO: Should we change default behavior to just return whatever cookie
value was passed to bpf_throw? That might allow people to avoid
installing a callback in case they just want to manipulate the return
value.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/helpers.c                          |  6 ++
 kernel/bpf/verifier.c                         | 97 +++++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  2 +
 4 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e28386fa462f..bd9d73b0647e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -300,6 +300,7 @@ struct bpf_func_state {
 	bool in_callback_fn;
 	struct tnum callback_ret_range;
 	bool in_async_callback_fn;
+	bool in_exception_callback_fn;
 
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index da1493a1da25..a2cb7ebf3d99 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2439,6 +2439,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
 }
 
+__bpf_kfunc void bpf_set_exception_callback(int (*cb)(u64))
+{
+	WARN_ON_ONCE(1);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -2467,6 +2472,7 @@ BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_set_exception_callback)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61101a87d96b..9bdb3c7d3926 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -544,6 +544,8 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_forbidden_exception_kfunc_in_cb(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
+static bool is_async_callback_calling_kfunc(u32 btf_id);
+static bool is_exception_cb_kfunc(struct bpf_insn *insn);
 
 static bool is_callback_calling_function(enum bpf_func_id func_id)
 {
@@ -3555,7 +3557,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		} else if ((bpf_helper_call(insn) &&
 			    is_callback_calling_function(insn->imm) &&
 			    !is_async_callback_calling_function(insn->imm)) ||
-			   (bpf_pseudo_kfunc_call(insn) && is_callback_calling_kfunc(insn->imm))) {
+			   (bpf_pseudo_kfunc_call(insn) && is_callback_calling_kfunc(insn->imm) &&
+			    !is_async_callback_calling_kfunc(insn->imm))) {
 			/* callback-calling helper or kfunc call, which means
 			 * we are exiting from subprog, but unlike the subprog
 			 * call handling above, we shouldn't propagate
@@ -5665,6 +5668,14 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 			if (subprog[sidx].has_tail_call) {
 				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
 				return -EFAULT;
+			}
+			if (subprog[sidx].is_exception_cb && bpf_pseudo_call(insn + i)) {
+				verbose(env, "insn %d cannot call exception cb directly\n", i);
+				return -EINVAL;
+			}
+			if (subprog[sidx].is_exception_cb && subprog[sidx].has_tail_call) {
+				verbose(env, "insn %d cannot tail call within exception cb\n", i);
+				return -EINVAL;
 			}
 			 /* async callbacks don't increase bpf prog stack size */
 			continue;
@@ -5689,8 +5700,13 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 	 * tail call counter throughout bpf2bpf calls combined with tailcalls
 	 */
 	if (tail_call_reachable)
-		for (j = 0; j < frame; j++)
+		for (j = 0; j < frame; j++) {
+			if (subprog[ret_prog[j]].is_exception_cb) {
+				verbose(env, "cannot tail call within exception cb\n");
+				return -EINVAL;
+			}
 			subprog[ret_prog[j]].tail_call_reachable = true;
+		}
 	if (subprog[0].tail_call_reachable)
 		env->prog->aux->tail_call_reachable = true;
 
@@ -8770,13 +8786,16 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 	}
 
-	if (insn->code == (BPF_JMP | BPF_CALL) &&
+	if ((insn->code == (BPF_JMP | BPF_CALL) &&
 	    insn->src_reg == 0 &&
-	    insn->imm == BPF_FUNC_timer_set_callback) {
+	    insn->imm == BPF_FUNC_timer_set_callback) ||
+	    is_exception_cb_kfunc(insn)) {
 		struct bpf_verifier_state *async_cb;
 
 		/* there is no real recursion here. timer callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
+		if (is_exception_cb_kfunc(insn))
+			env->subprog_info[subprog].is_exception_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 *insn_idx, subprog);
 		if (!async_cb)
@@ -9032,6 +9051,22 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int set_exception_callback_state(struct bpf_verifier_env *env,
+					struct bpf_func_state *caller,
+					struct bpf_func_state *callee,
+					int insn_idx)
+{
+	__mark_reg_unknown(env, &callee->regs[BPF_REG_1]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_2]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	callee->in_exception_callback_fn = true;
+	callee->callback_ret_range = tnum_range(0, 0);
+	return 0;
+
+}
+
 static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 					 struct bpf_func_state *caller,
 					 struct bpf_func_state *callee,
@@ -10133,6 +10168,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
 	KF_bpf_throw,
+	KF_bpf_set_exception_callback,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10154,6 +10190,7 @@ BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_set_exception_callback)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10177,6 +10214,7 @@ BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_set_exception_callback)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10487,7 +10525,19 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
 
 static bool is_callback_calling_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
+	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
+	       btf_id == special_kfunc_list[KF_bpf_set_exception_callback];
+}
+
+static bool is_async_callback_calling_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_set_exception_callback];
+}
+
+static bool is_exception_cb_kfunc(struct bpf_insn *insn)
+{
+	return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
+	       insn->imm == special_kfunc_list[KF_bpf_set_exception_callback];
 }
 
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
@@ -10498,7 +10548,8 @@ static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
 
 static bool is_forbidden_exception_kfunc_in_cb(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_throw];
+	return btf_id == special_kfunc_list[KF_bpf_throw] ||
+	       btf_id == special_kfunc_list[KF_bpf_set_exception_callback];
 }
 
 static bool is_rbtree_lock_required_kfunc(u32 btf_id)
@@ -11290,6 +11341,33 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		throw = true;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_set_exception_callback]) {
+		if (!bpf_jit_supports_exceptions()) {
+			verbose(env, "JIT does not support calling kfunc %s#%d\n",
+				func_name, meta.func_id);
+			return -EINVAL;
+		}
+
+		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_exception_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, meta.func_id);
+			return err;
+		}
+		if (env->cur_state->frame[0]->subprogno) {
+			verbose(env, "kfunc %s#%d can only be called from main prog\n",
+				func_name, meta.func_id);
+			return -EINVAL;
+		}
+		if (env->exception_callback_subprog) {
+			verbose(env, "kfunc %s#%d can only be called once to set exception callback\n",
+				func_name, meta.func_id);
+			return -EINVAL;
+		}
+		env->exception_callback_subprog = meta.subprogno;
+	}
+
 	for (i = 0; i < CALLER_SAVED_REGS; i++)
 		mark_reg_not_init(env, regs, caller_saved[i]);
 
@@ -14320,7 +14398,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	const bool is_subprog = frame->subprogno;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
-	if (!is_subprog) {
+	if (!is_subprog || frame->in_exception_callback_fn) {
 		switch (prog_type) {
 		case BPF_PROG_TYPE_LSM:
 			if (prog->expected_attach_type == BPF_LSM_CGROUP)
@@ -14368,7 +14446,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 		return 0;
 	}
 
-	if (is_subprog) {
+	if (is_subprog && !frame->in_exception_callback_fn) {
 		if (reg->type != SCALAR_VALUE) {
 			verbose(env, "At subprogram exit the register R0 is not a scalar value (%s)\n",
 				reg_type_str(env, reg->type));
@@ -18147,6 +18225,9 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_set_exception_callback]) {
+		insn_buf[0] = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+		*cnt = 1;
 	}
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index f1d7de1349bc..d27e694392a7 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -137,4 +137,6 @@ extern void bpf_throw(u64 cookie) __ksym;
 #define throw bpf_throw(0)
 #define throw_value(cookie) bpf_throw(cookie)
 
+extern void bpf_set_exception_callback(int (*cb)(u64)) __ksym;
+
 #endif
-- 
2.40.1



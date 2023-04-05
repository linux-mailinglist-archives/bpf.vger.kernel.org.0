Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D176D7196
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbjDEAnD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbjDEAnD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:43:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5738944BA
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:42:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q19so31476362wrc.5
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/2gok4ZYNnw4ha5LbLeSVFL1gfKUZ0QgMNLTly7xMQ=;
        b=GI5dRT5O+PRngKj5MkhR4L18slHa8D7+toRmb6AQlx6zEKihrDLhI20prjmBrTPqOA
         E7J2hpjCc3dyEFyWSkkfQ855pL7SGoqvI5qZx8JQ40NOSJh1KTUTfswwVpiU+mLkjIDF
         r56VCKwF43K1BqIUa6eLyQtJr6FTITODq+OjLkx8pdEDHmUjdaBKTskiXm1YDO7XF4Ul
         j/kmDJ9OhpcaL0yOGOK7O9Y+Rn6CeJlwtUSNXcCl/H+w3tBcwfOHX1bAxAj7EWLQw2kz
         TJWhXKOvZgscz8mVqZyy9EuSiTmLv0GG0HgqZIQdI4Sc8TalJoqo42pwCV5Di/6Rfrhx
         WjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/2gok4ZYNnw4ha5LbLeSVFL1gfKUZ0QgMNLTly7xMQ=;
        b=CvXuEDQDRBe7mpAkY1+fviQ/Q5gFIYdr/WUntui/5PM5+f1JUdwwgtqOF6YDFu8cY6
         xy25BAHVnFrhrufwzsiJEvtl2jhgsq9aLIbyzENiNmKzYellQKYzm//SQfkDhMvkxEKP
         33gSwj/NLjInJkS5opPGwkJdqtfMpfJtvG79Cd0E4/2EbCQi1eFBFh7x5y2sWVPd9dqa
         IEdn+JHrhLQLBTPuBhEFoUPvQaJwqvDaoVlXvsWtKYD+G0LRzEO+NLV0IEufJqk9ONBK
         HgU7eZoolo6XBfb+7u0qOHWvCOfmBwdt/l87bJYzyU7kmmlfGg/32Lm5B2HU+ILKzkP0
         h1yg==
X-Gm-Message-State: AAQBX9c2SxNbD4489eeoM82GT09KFyoySQY6ElvbqNm8C1mabSjCWWFy
        UBYbcVXRWx0HmRblwGX5CzMpxN8yeTXSpg==
X-Google-Smtp-Source: AKy350YzYV0wmuhSARCPovP70ICdnCRqGc9HokbJ3FGAAUgGKL3429CHl+0WLoOivQC5Q5cUxzyjVA==
X-Received: by 2002:a5d:678e:0:b0:2ce:a9e9:5da2 with SMTP id v14-20020a5d678e000000b002cea9e95da2mr2672209wru.6.1680655372055;
        Tue, 04 Apr 2023 17:42:52 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4e48000000b002c70e60abd4sm13689930wrt.2.2023.04.04.17.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:42:51 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH RFC bpf-next v1 7/9] bpf: Introduce bpf_set_exception_callback kfunc
Date:   Wed,  5 Apr 2023 02:42:37 +0200
Message-Id: <20230405004239.1375399-8-memxor@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405004239.1375399-1-memxor@gmail.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19576; i=memxor@gmail.com; h=from:subject; bh=/aS+fddSNWpXHR6p+P2u0Sh7R59bvq37oRK00iHzJow=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBkLMPwgLZneVVr0tpeqK/zME+BiJ68iLSv1Gpz5 AiKj15UCy+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZCzD8AAKCRBM4MiGSL8R ygKtD/9KIV9kj0Y57B5rX0pjkacri8D14tUPQgshp5ti1GjhjzTLGMDh/kcsD+1cTSLNG0Rjr6r R4XvEPfJKtWEBdspchbOYjHN68GT9+9JTj4O/0uy51Y1l/W0QrgLR1pVX3IHT5oMoRWItNnhjJq wh+TXjYG6DGuyMs40aG/U31IZyBFi/+KzgJMVDtR0zWuPSbyUGuExJzb0AmlxmqMK5Nzr+tZrPo +e88IXZ4c6UY5dZGif0A3W4USHTEaaeR/yM9cEqLBBVscorMebr1BWpRu2Pi/Ln+e6rhd08tRJw VT8x5NGcROxbHxVJ86AAo8xNE2QNrJnIcbE4TzRSQlY1OEMYrxSc96hlRskBbQPNCkSAO72pEJc W87+/LSX72yX6pwXvHo9hkaEnJmPe5rTGFBO/2q11Bq1CReT19ck9tpqYf5Qjv5cMg04zRzLv3f wrcDNKk0BepfSvTva82yLFyjD9K7giZX5W8XAjaE2O/9P6+srVx63ersa7yuaInZd7b1vLm6pXo JxHn0n9IDlyzQyg7sqqRuMjyUTJGmR595nbqxC88tqfVlKZdOB3DUzU+8MSSs//pLQfkzEtUELe tC6p4U61a5eSc2m4dgbMyFCepS8kshWQRPLKTfAxi5r0ZC73hIqCBAL9DVQk8EhexAb17l+Dpwv WZ8GeCOE7Epn8/Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch allows the BPF program to queue the invocation of a callback
after an exception has been thrown and the BPF runtime has completed the
unwinding of the program stack. This is the last past point before the
program returns control back to the kernel.

In the earlier patches, by default, whenever an exception is thrown, we
return 0 to the kernel context. However, this is not always desirable
and the program may want to customize the default return code or perform
some program specific action when an exception is thrown. This commit
sets up the infrastructure to allow this. The semantics and
implementation notes are as follows.

- The program may use bpf_set_exception_callback to set up the exception
  callback only once.
- Since this callback is invoked during unwinding, it cannot throw
  itself.
- The exception state has been reset before it is invoked, hence any
  program attachments (fentry/fexit) are allowed as usual. The check to
  disallow throwing FEXIT for throwing program is relaxed at the level
  of subprog it is attaching to.
- Exception callbacks are disallowed to call bpf_set_exception_callback.
- bpf_set_exception_callback may not be called in global functions or
  BPF_PROG_TYPE_EXT (because they propagate exception outwards and do
  not perform the final exit back to the kernel, which is where the
  callback call is inserted). This can be supported in the future (by
  verifying that all paths which throw have the same callback set, and
  remember this in the global subprog/ext prog summary in func_info_aux,
  but is skipped for simplicity).
- For a given outermost throwing instruction, it cannot see different
  exception callbacks from different paths, since it has to hardcode one
  during the rewrite phase.
- From stack depth check point of view, async and exception callbacks
  are similar in the sense that they don't contribute to current
  callchain's stack_depth, but they need to be tested against the main
  subprog's stack depth and the exception callback's stack depth being
  within MAX_BPF_STACK. The variable in subprog_info is named to reflect
  this combined meaning, and appropriate handling is introduced.
- frame->in_exception_callback_fn is used to subject the exception
  callback to the same return code checks as the BPF program's main
  exit, so that it can return a meaningful return code based on the
  program type and is not limited to some fixed callback return range.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  |   6 +-
 kernel/bpf/helpers.c                          |   6 +
 kernel/bpf/verifier.c                         | 184 ++++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  11 ++
 4 files changed, 188 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a5346a2b7e68..301318ed04f5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -293,6 +293,7 @@ struct bpf_func_state {
 	bool in_callback_fn;
 	struct tnum callback_ret_range;
 	bool in_async_callback_fn;
+	bool in_exception_callback_fn;
 
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
@@ -370,6 +371,7 @@ struct bpf_verifier_state {
 	struct bpf_active_lock active_lock;
 	bool speculative;
 	bool active_rcu_lock;
+	s32 exception_callback_subprog;
 
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
@@ -439,6 +441,7 @@ enum {
 struct bpf_throw_state {
 	int type;
 	bool check_helper_ret_code;
+	s32 subprog;
 };
 
 /* Possible states for alu_state member. */
@@ -549,7 +552,8 @@ struct bpf_subprog_info {
 	bool has_tail_call;
 	bool tail_call_reachable;
 	bool has_ld_abs;
-	bool is_async_cb;
+	bool is_async_or_exception_cb;
+	bool is_exception_cb;
 	bool can_throw;
 };
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 82db3a64fa3f..e6f15da8f154 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2322,6 +2322,11 @@ __bpf_kfunc notrace void bpf_throw(void)
 	current->bpf_exception_thrown[i] = true;
 }
 
+__bpf_kfunc notrace void bpf_set_exception_callback(int (*cb)(void))
+{
+	WARN_ON_ONCE(1);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -2349,6 +2354,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_set_exception_callback)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9f4b1849647..5015abf246b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1736,6 +1736,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->active_rcu_lock = src->active_rcu_lock;
+	dst_state->exception_callback_subprog = src->exception_callback_subprog;
 	dst_state->curframe = src->curframe;
 	dst_state->active_lock.ptr = src->active_lock.ptr;
 	dst_state->active_lock.id = src->active_lock.id;
@@ -5178,10 +5179,16 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 				  next_insn);
 			return -EFAULT;
 		}
-		if (subprog[idx].is_async_cb) {
+		if (subprog[idx].is_async_or_exception_cb) {
 			if (subprog[idx].has_tail_call) {
-				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
+				verbose(env, "verifier bug. subprog has tail_call and async or exception cb\n");
 				return -EFAULT;
+			}
+			if (subprog[idx].is_exception_cb) {
+				if (subprog[0].stack_depth + subprog[idx].stack_depth > MAX_BPF_STACK) {
+					verbose(env, "combined stack size of main and exception calls is %d. Too large\n", depth);
+					return -EACCES;
+				}
 			}
 			 /* async callbacks don't increase bpf prog stack size */
 			continue;
@@ -8203,6 +8210,7 @@ static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *callee, int insn_idx);
 
 static bool is_callback_calling_kfunc(u32 btf_id);
+static bool is_set_exception_cb_kfunc(struct bpf_insn *insn);
 static int mark_chain_throw(struct bpf_verifier_env *env, int insn_idx);
 
 static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
@@ -8279,13 +8287,16 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 	}
 
-	if (insn->code == (BPF_JMP | BPF_CALL) &&
-	    insn->src_reg == 0 &&
-	    insn->imm == BPF_FUNC_timer_set_callback) {
+	if ((insn->code == (BPF_JMP | BPF_CALL) &&
+	     insn->src_reg == 0 &&
+	     insn->imm == BPF_FUNC_timer_set_callback) ||
+	     is_set_exception_cb_kfunc(insn)) {
 		struct bpf_verifier_state *async_cb;
 
 		/* there is no real recursion here. timer callbacks are async */
-		env->subprog_info[subprog].is_async_cb = true;
+		env->subprog_info[subprog].is_async_or_exception_cb = true;
+		if (is_set_exception_cb_kfunc(insn))
+			env->subprog_info[subprog].is_exception_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 *insn_idx, subprog);
 		if (!async_cb)
@@ -8396,12 +8407,15 @@ static int set_throw_state_type(struct bpf_verifier_env *env, int insn_idx,
 				int frame, int subprog)
 {
 	struct bpf_throw_state *ts = &env->insn_aux_data[insn_idx].throw_state;
-	int type;
+	int exception_subprog, type;
 
-	if (!frame && !subprog && env->prog->type != BPF_PROG_TYPE_EXT)
+	if (!frame && !subprog && env->prog->type != BPF_PROG_TYPE_EXT) {
 		type = BPF_THROW_OUTER;
-	else
+		exception_subprog = env->cur_state->exception_callback_subprog;
+	} else {
 		type = BPF_THROW_INNER;
+		exception_subprog = -1;
+	}
 	if (ts->type != BPF_THROW_NONE) {
 		if (ts->type != type) {
 			verbose(env,
@@ -8409,8 +8423,14 @@ static int set_throw_state_type(struct bpf_verifier_env *env, int insn_idx,
 				insn_idx, ts->type, type);
 			return -EINVAL;
 		}
+		if (ts->subprog != exception_subprog) {
+			verbose(env, "different exception callback subprogs for same insn %d: %d and %d\n",
+				insn_idx, ts->subprog, exception_subprog);
+			return -EINVAL;
+		}
 	}
 	ts->type = type;
+	ts->subprog = exception_subprog;
 	return 0;
 }
 
@@ -8432,9 +8452,23 @@ static int mark_chain_throw(struct bpf_verifier_env *env, int insn_idx) {
 		ret = set_throw_state_type(env, frame[i]->callsite, i - 1, subprogno);
 		if (ret < 0)
 			return ret;
+		/* Have we seen this being used as exception cb? Reject! */
+		if (subprog[subprogno].is_exception_cb) {
+			verbose(env,
+				"subprog %d (at insn %d) is used as exception callback, cannot throw\n",
+				subprogno, subprog[subprogno].start);
+			return -EACCES;
+		}
 	}
 	/* Now mark actual instruction which caused the throw */
 	cur_subprogno = frame[state->curframe]->subprogno;
+	/* Have we seen this being used as exception cb? Reject! */
+	if (subprog[cur_subprogno].is_exception_cb) {
+		verbose(env,
+			"subprog %d (at insn %d) is used as exception callback, cannot throw\n",
+			cur_subprogno, subprog[cur_subprogno].start);
+		return -EACCES;
+	}
 	func_info_aux[cur_subprogno].throws_exception = subprog[cur_subprogno].can_throw = true;
 	return set_throw_state_type(env, insn_idx, state->curframe, cur_subprogno);
 }
@@ -8619,6 +8653,23 @@ static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int set_exception_callback_state(struct bpf_verifier_env *env,
+					struct bpf_func_state *caller,
+					struct bpf_func_state *callee,
+					int insn_idx)
+{
+	/* void bpf_exception_callback(int (*cb)(void)); */
+
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_1]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_2]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	callee->in_exception_callback_fn = true;
+	callee->callback_ret_range = tnum_range(0, 0);
+	return 0;
+}
+
 static bool is_rbtree_lock_required_kfunc(u32 btf_id);
 
 /* Are we currently verifying the callback for a rbtree helper that must
@@ -9695,6 +9746,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_throw,
+	KF_bpf_set_exception_callback,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -9714,6 +9766,7 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_set_exception_callback)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -9735,6 +9788,7 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_set_exception_callback)
 
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10080,7 +10134,14 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
 
 static bool is_callback_calling_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_rbtree_add];
+	return btf_id == special_kfunc_list[KF_bpf_rbtree_add] ||
+	       btf_id == special_kfunc_list[KF_bpf_set_exception_callback];
+}
+
+static bool is_set_exception_cb_kfunc(struct bpf_insn *insn)
+{
+	return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
+	       insn->imm == special_kfunc_list[KF_bpf_set_exception_callback];
 }
 
 static bool is_rbtree_lock_required_kfunc(u32 btf_id)
@@ -10704,6 +10765,9 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	return 0;
 }
 
+#define BPF_EXCEPTION_CB_CAN_SET (-1)
+#define BPF_EXCEPTION_CB_CANNOT_SET (-2)
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -10818,6 +10882,33 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (meta.btf == btf_vmlinux && meta.func_id == special_kfunc_list[KF_bpf_set_exception_callback]) {
+		if (env->cur_state->exception_callback_subprog == BPF_EXCEPTION_CB_CANNOT_SET) {
+			verbose(env, "exception callback cannot be set within global function or extension program\n");
+			return -EINVAL;
+		}
+		if (env->cur_state->frame[env->cur_state->curframe]->in_exception_callback_fn) {
+			verbose(env, "exception callback cannot be set from within exception callback\n");
+			return -EINVAL;
+		}
+		/* If we didn't explore and mark can_throw yet, we will see it
+		 * when we pop_stack for the pushed async cb which gets the
+		 * is_exception_cb marking and is caught in mark_chain_throw.
+		 */
+		if (env->subprog_info[meta.subprogno].can_throw) {
+			verbose(env, "exception callback can throw, which is not allowed\n");
+			return -EINVAL;
+		}
+		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_exception_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, meta.func_id);
+			return err;
+		}
+		env->cur_state->exception_callback_subprog = meta.subprogno;
+	}
+
 	if (is_kfunc_throwing(&meta) ||
 	    (meta.btf == btf_vmlinux && meta.func_id == special_kfunc_list[KF_bpf_throw])) {
 		err = mark_chain_throw(env, insn_idx);
@@ -13829,7 +13920,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	const bool is_subprog = frame->subprogno;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
-	if (!is_subprog) {
+	if (!is_subprog || frame->in_exception_callback_fn) {
 		switch (prog_type) {
 		case BPF_PROG_TYPE_LSM:
 			if (prog->expected_attach_type == BPF_LSM_CGROUP)
@@ -13877,7 +13968,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 		return 0;
 	}
 
-	if (is_subprog) {
+	if (is_subprog && !frame->in_exception_callback_fn) {
 		if (reg->type != SCALAR_VALUE) {
 			verbose(env, "At subprogram exit the register R0 is not a scalar value (%s)\n",
 				reg_type_str(env, reg->type));
@@ -15134,6 +15225,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (old->exception_callback_subprog != cur->exception_callback_subprog)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
@@ -17538,6 +17632,9 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		 * may_access_direct_pkt_data mutates it
 		 */
 		env->seen_direct_write = seen_direct_write;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_set_exception_callback]) {
+		insn_buf[0] = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+		*cnt = 1;
 	}
 	return 0;
 }
@@ -18194,15 +18291,35 @@ static struct bpf_prog *rewrite_bpf_throw_call(struct bpf_verifier_env *env,
 {
 	struct bpf_insn insn_buf[] = {
 		env->prog->insnsi[position],
-		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
+	struct bpf_prog *new_prog;
+	u32 callback_start;
+	u32 call_insn_offset;
+	s32 callback_offset;
+	int type, esubprog;
 
+	type = tstate->type;
+	esubprog = tstate->subprog;
 	*cnt = ARRAY_SIZE(insn_buf);
 	/* We don't need the call instruction for throws in frame 0 */
-	if (tstate->type == BPF_THROW_OUTER)
-		return bpf_patch_insn_data(env, position, insn_buf + 1, *cnt - 1);
-	return bpf_patch_insn_data(env, position, insn_buf, *cnt);
+	if (type == BPF_THROW_OUTER) {
+		/* We need to return r0 of exception callback from outermost frame */
+		if (esubprog != -1)
+			insn_buf[0] = BPF_CALL_REL(0);
+		else
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	}
+	new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);
+	if (!new_prog || esubprog == -1)
+		return new_prog;
+
+	callback_start = env->subprog_info[esubprog].start;
+	/* Note: insn_buf[0] is an offset of BPF_CALL_REL instruction */
+	call_insn_offset = position + 0;
+	callback_offset = callback_start - call_insn_offset - 1;
+	new_prog->insnsi[call_insn_offset].imm = callback_offset;
+	return new_prog;
 }
 
 static bool is_bpf_throw_call(struct bpf_insn *insn)
@@ -18234,17 +18351,25 @@ static struct bpf_prog *rewrite_bpf_call(struct bpf_verifier_env *env,
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
+	int type, tsubprog = -1, esubprog;
 	struct bpf_prog *new_prog;
-	int type, tsubprog = -1;
 	u32 callback_start;
 	u32 call_insn_offset;
 	s32 callback_offset;
 	bool ret_code;
 
 	type = tstate->type;
+	esubprog = tstate->subprog;
 	ret_code = tstate->check_helper_ret_code;
-	if (type == BPF_THROW_OUTER)
+	if (type == BPF_THROW_OUTER) {
 		insn_buf[4] = insn_buf[9] = BPF_EMIT_CALL(bpf_reset_exception);
+		/* Note that we allow progs to attach to exception callbacks,
+		 * even if they do, they won't clobber any exception state that
+		 * we care about at this point.
+		 */
+		if (esubprog != -1)
+			insn_buf[5] = insn_buf[10] = BPF_CALL_REL(0);
+	}
 	if (type == BPF_THROW_INNER)
 		insn_buf[9] = BPF_EMIT_CALL(bpf_throw);
 
@@ -18285,6 +18410,25 @@ static struct bpf_prog *rewrite_bpf_call(struct bpf_verifier_env *env,
 	/* Note: For BPF_THROW_OUTER, we already patched in call at insn_buf[4] */
 	if (type == BPF_THROW_OUTER)
 		aux_data[position + 4].skip_patch_call_imm = true;
+
+	/* Fixups for exception callback begin here */
+	if (esubprog == -1)
+		return new_prog;
+	callback_start = env->subprog_info[esubprog].start;
+
+	/* Note: insn_buf[5] is an offset of BPF_CALL_REL instruction */
+	call_insn_offset = position + 5;
+	callback_offset = callback_start - call_insn_offset - 1;
+	new_prog->insnsi[call_insn_offset].imm = callback_offset;
+
+	if (!ret_code)
+		return new_prog;
+
+	/* Note: insn_buf[10] is an offset of BPF_CALL_REL instruction */
+	call_insn_offset = position + 10;
+	callback_offset = callback_start - call_insn_offset - 1;
+	new_prog->insnsi[call_insn_offset].imm = callback_offset;
+
 	return new_prog;
 }
 
@@ -18439,6 +18583,10 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 		return -ENOMEM;
 	state->curframe = 0;
 	state->speculative = false;
+	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT)
+		state->exception_callback_subprog = BPF_EXCEPTION_CB_CANNOT_SET;
+	else
+		state->exception_callback_subprog = BPF_EXCEPTION_CB_CAN_SET;
 	state->branches = 1;
 	state->frame[0] = kzalloc(sizeof(struct bpf_func_state), GFP_KERNEL);
 	if (!state->frame[0]) {
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index d5de9251e775..a9c75270e49b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -98,4 +98,15 @@ extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
  */
 extern void bpf_throw(void) __attribute__((noreturn)) __ksym;
 
+/*
+ * Description
+ *  Set the callback which will be invoked after an exception is thrown and the
+ *  eBPF runtime has completely unwinded the program stack. The return value of
+ *  this callback is treated as the return value of the program when the
+ *  exception is thrown.
+ * Returns
+ *  Void
+ */
+extern void bpf_set_exception_callback(int (*)(void)) __ksym;
+
 #endif
-- 
2.40.0


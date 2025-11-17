Return-Path: <bpf+bounces-74794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BAEC660F1
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 21:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B035DCCE
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C993531A561;
	Mon, 17 Nov 2025 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD5EPeSa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAC283FCF
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409906; cv=none; b=sHSKM5STpvW/9dL1gHXwJf3srhs0IIGiVUUGtqYvj3BBobf7HOFTru7O+Eccr6aJvuArXn2tY1CROyuhFLkjrOC5Fsc8CmMhg29vCx/FhHwvqwu2oxSEnQzPOYzlGcMZ9xavj6JNGpY5tT4NIG5fG9941SgXlkzSTLO6GgShZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409906; c=relaxed/simple;
	bh=mYgad76W2LXBD+19f6Rf2gHPudWnJFaQdOVHHLBJDZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOAXhkQ1NmPlLjPLWTfW/J9HizfvOQ5sYrvCSPBzB70u/IXHTWQuBEaBWFHfO4BRcrasqk4RdnDHh6iq/x7xV7hv428VayOnnhit3DTLo2FEi/16qjINcpM6cfO1ADGJLUFLX8bac7EDJ/W/YeXx55RVJ0muxOzm967vBXTtQ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD5EPeSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C114C4CEF5;
	Mon, 17 Nov 2025 20:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763409906;
	bh=mYgad76W2LXBD+19f6Rf2gHPudWnJFaQdOVHHLBJDZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LD5EPeSa++OVcArzZ6ZxBbAw5X612wmqjspvJGiwpiXvEtsesNp5Zt04OZ06Kwszo
	 pTKsQtyuVRLRzwdNjTwy5LmxavCWJIf2aFF99pHL+nYopwoSZbRBSSkwel2SKskGgu
	 G3s3DlGRtDaUkkexbYohqe/dpySwIVVEHwq0fwocmPphX9myJGnMvX39zWIWQtj8AB
	 pYfQOjcsP6QyxI94ZbHI0x+QICUJlXXGMy9FmtoOuAgd+Wc6Yg0SuSoctNH4lF47Zm
	 YFuRadZ0ogs5mXro+Tr7BBvMpF9tRTxMN/8CfPpjro5n1ZCppyxAyL41J9CwT5RhCr
	 8pjgyBhroybdw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 1/2] bpf: support nested rcu critical sections
Date: Mon, 17 Nov 2025 20:04:09 +0000
Message-ID: <20251117200411.25563-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117200411.25563-1-puranjay@kernel.org>
References: <20251117200411.25563-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, nested rcu critical sections are rejected by the verifier and
rcu_lock state is managed by a boolean variable. Add support for nested
rcu critical sections by make active_rcu_locks a counter similar to
active_preempt_locks. bpf_rcu_read_lock() increments this counter and
bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
happens when active_rcu_locks drops to 0.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf_verifier.h                  |  2 +-
 kernel/bpf/verifier.c                         | 47 +++++++++----------
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  2 +-
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5441341f1ab9..9f9f539b99bd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -416,7 +416,7 @@ struct bpf_verifier_state {
 	u32 active_irq_id;
 	u32 active_lock_id;
 	void *active_lock_ptr;
-	bool active_rcu_lock;
+	u32 active_rcu_locks;
 
 	bool speculative;
 	bool in_sleepable;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 098dd7f21c89..624aefb3103d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1437,7 +1437,7 @@ static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf
 	dst->acquired_refs = src->acquired_refs;
 	dst->active_locks = src->active_locks;
 	dst->active_preempt_locks = src->active_preempt_locks;
-	dst->active_rcu_lock = src->active_rcu_lock;
+	dst->active_rcu_locks = src->active_rcu_locks;
 	dst->active_irq_id = src->active_irq_id;
 	dst->active_lock_id = src->active_lock_id;
 	dst->active_lock_ptr = src->active_lock_ptr;
@@ -5880,7 +5880,7 @@ static bool in_sleepable(struct bpf_verifier_env *env)
  */
 static bool in_rcu_cs(struct bpf_verifier_env *env)
 {
-	return env->cur_state->active_rcu_lock ||
+	return env->cur_state->active_rcu_locks ||
 	       env->cur_state->active_locks ||
 	       !in_sleepable(env);
 }
@@ -10735,7 +10735,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 
 		if (env->subprog_info[subprog].might_sleep &&
-		    (env->cur_state->active_rcu_lock || env->cur_state->active_preempt_locks ||
+		    (env->cur_state->active_rcu_locks || env->cur_state->active_preempt_locks ||
 		     env->cur_state->active_irq_id || !in_sleepable(env))) {
 			verbose(env, "global functions that may sleep are not allowed in non-sleepable context,\n"
 				     "i.e., in a RCU/IRQ/preempt-disabled section, or in\n"
@@ -11314,7 +11314,7 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 		return -EINVAL;
 	}
 
-	if (check_lock && env->cur_state->active_rcu_lock) {
+	if (check_lock && env->cur_state->active_rcu_locks) {
 		verbose(env, "%s cannot be used inside bpf_rcu_read_lock-ed region\n", prefix);
 		return -EINVAL;
 	}
@@ -11452,7 +11452,7 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 /* Check if we're in a sleepable context. */
 static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 {
-	return !env->cur_state->active_rcu_lock &&
+	return !env->cur_state->active_rcu_locks &&
 	       !env->cur_state->active_preempt_locks &&
 	       !env->cur_state->active_irq_id &&
 	       in_sleepable(env);
@@ -11518,7 +11518,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
-	if (env->cur_state->active_rcu_lock) {
+	if (env->cur_state->active_rcu_locks) {
 		if (fn->might_sleep) {
 			verbose(env, "sleepable helper %s#%d in rcu_read_lock region\n",
 				func_id_name(func_id), func_id);
@@ -14006,36 +14006,33 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	preempt_disable = is_kfunc_bpf_preempt_disable(&meta);
 	preempt_enable = is_kfunc_bpf_preempt_enable(&meta);
 
-	if (env->cur_state->active_rcu_lock) {
+	if (rcu_lock) {
+		env->cur_state->active_rcu_locks++;
+	} else if (rcu_unlock) {
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
 		u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
 
-		if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
-			verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
-			return -EACCES;
-		}
-
-		if (rcu_lock) {
-			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
+		if (env->cur_state->active_rcu_locks == 0) {
+			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
 			return -EINVAL;
-		} else if (rcu_unlock) {
+		}
+		if (--env->cur_state->active_rcu_locks == 0) {
 			bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
 				if (reg->type & MEM_RCU) {
 					reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
 					reg->type |= PTR_UNTRUSTED;
 				}
 			}));
-			env->cur_state->active_rcu_lock = false;
-		} else if (sleepable) {
-			verbose(env, "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
-			return -EACCES;
 		}
-	} else if (rcu_lock) {
-		env->cur_state->active_rcu_lock = true;
-	} else if (rcu_unlock) {
-		verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
-		return -EINVAL;
+	} else if (sleepable && env->cur_state->active_rcu_locks) {
+		verbose(env, "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
+		return -EACCES;
+	}
+
+	if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
+		verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
+		return -EACCES;
 	}
 
 	if (env->cur_state->active_preempt_locks) {
@@ -19328,7 +19325,7 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 	if (old->active_preempt_locks != cur->active_preempt_locks)
 		return false;
 
-	if (old->active_rcu_lock != cur->active_rcu_lock)
+	if (old->active_rcu_locks != cur->active_rcu_locks)
 		return false;
 
 	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index c9f855e5da24..451a5d9ff4cb 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -28,6 +28,7 @@ static void test_success(void)
 	bpf_program__set_autoload(skel->progs.two_regions, true);
 	bpf_program__set_autoload(skel->progs.non_sleepable_1, true);
 	bpf_program__set_autoload(skel->progs.non_sleepable_2, true);
+	bpf_program__set_autoload(skel->progs.nested_rcu_region, true);
 	bpf_program__set_autoload(skel->progs.task_trusted_non_rcuptr, true);
 	bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog, true);
 	bpf_program__set_autoload(skel->progs.rcu_read_lock_global_subprog, true);
@@ -78,7 +79,6 @@ static const char * const inproper_region_tests[] = {
 	"non_sleepable_rcu_mismatch",
 	"inproper_sleepable_helper",
 	"inproper_sleepable_kfunc",
-	"nested_rcu_region",
 	"rcu_read_lock_global_subprog_lock",
 	"rcu_read_lock_global_subprog_unlock",
 	"rcu_read_lock_sleepable_helper_global_subprog",
-- 
2.47.1



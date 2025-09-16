Return-Path: <bpf+bounces-68494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13E5B59553
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 13:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EFD3ADA7A
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4310A2D73B6;
	Tue, 16 Sep 2025 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfqmH6sk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE112BE7B8
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022587; cv=none; b=gcPG7H8GNkhEA1emeA86BzoTLN7c2/XIQRySh7iWwQ4gUHZ88fNqMtHE4Q3eMkD6kqKroSjSIlHM630Eq1Re0g+thOLlgTD9G3qEKbPZKd/RlCBWCnvY4jeAQySTJGLOH2UAaqxL99JGZxA//B3soiIdVyMlUy4BL6r/AbAYxyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022587; c=relaxed/simple;
	bh=1FTIYSNepHUS6LNiK6nVtjDsDEky+nQf+4HKEj6Yqqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKAkj2LfFjBS6Fuhf3nx27QmzfoI/1E+L4kB1sw8m/hwyXpeu9OSaUCIgBEO5tA/FKcbDTaK1lGqscXLJfTHUH8Dr8lNjJeMy69MLokLD0kCVX+LxWbydRlRMmv5uMMU/czqWVR6JTGNV9ZBbgu56h0xOjaxAXfKYZ0PjlWGu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfqmH6sk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B6BC4CEEB;
	Tue, 16 Sep 2025 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758022587;
	bh=1FTIYSNepHUS6LNiK6nVtjDsDEky+nQf+4HKEj6Yqqw=;
	h=From:To:Cc:Subject:Date:From;
	b=nfqmH6skkTGVohkrTvhoLPD9PJutJSjnxRRYFiOvD8aD0RcsejjcDooDWSZHSyYxD
	 WN/MBayAk61wEjRVCWswXuJoWNwuQqR9j8lTr2RB8o3xYx/uaNUQQwO0/Q13Kns+gB
	 CLNdMxzy8w0tAGR/FhK6/dX5kRLa+hxX17WkdnY03yM8foDrDRc5xcksHVxJcZZYuS
	 4n9yaGQFW4rFXhdgN/uFyYKtGQHwpj/QuXFl29MrDl87RRALjjY2ccTOF3CthWfkNv
	 kappCbaAJlnCI9QQ6hQs+FqiEUlvjajFfgUDvIxc/2r9ZlZHuwIdamqa062Pwa4StP
	 4K990UfpKi6yw==
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
Subject: [PATCH bpf-next] bpf: support nested rcu critical sections
Date: Tue, 16 Sep 2025 11:36:20 +0000
Message-ID: <20250916113622.19540-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
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
 kernel/bpf/verifier.c                         | 34 ++++++++--------
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  4 +-
 .../selftests/bpf/progs/rcu_read_lock.c       | 40 +++++++++++++++++++
 4 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 020de62bd09c..3fb4632d5eed 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -441,7 +441,7 @@ struct bpf_verifier_state {
 	u32 active_irq_id;
 	u32 active_lock_id;
 	void *active_lock_ptr;
-	bool active_rcu_lock;
+	u32 active_rcu_locks;
 
 	bool speculative;
 	bool in_sleepable;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1029380f84db..645af66e29ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1438,7 +1438,7 @@ static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf
 	dst->acquired_refs = src->acquired_refs;
 	dst->active_locks = src->active_locks;
 	dst->active_preempt_locks = src->active_preempt_locks;
-	dst->active_rcu_lock = src->active_rcu_lock;
+	dst->active_rcu_locks = src->active_rcu_locks;
 	dst->active_irq_id = src->active_irq_id;
 	dst->active_lock_id = src->active_lock_id;
 	dst->active_lock_ptr = src->active_lock_ptr;
@@ -5924,7 +5924,7 @@ static bool in_sleepable(struct bpf_verifier_env *env)
  */
 static bool in_rcu_cs(struct bpf_verifier_env *env)
 {
-	return env->cur_state->active_rcu_lock ||
+	return env->cur_state->active_rcu_locks ||
 	       env->cur_state->active_locks ||
 	       !in_sleepable(env);
 }
@@ -10684,7 +10684,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 
 		if (env->subprog_info[subprog].might_sleep &&
-		    (env->cur_state->active_rcu_lock || env->cur_state->active_preempt_locks ||
+		    (env->cur_state->active_rcu_locks || env->cur_state->active_preempt_locks ||
 		     env->cur_state->active_irq_id || !in_sleepable(env))) {
 			verbose(env, "global functions that may sleep are not allowed in non-sleepable context,\n"
 				     "i.e., in a RCU/IRQ/preempt-disabled section, or in\n"
@@ -11231,7 +11231,7 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 		return -EINVAL;
 	}
 
-	if (check_lock && env->cur_state->active_rcu_lock) {
+	if (check_lock && env->cur_state->active_rcu_locks) {
 		verbose(env, "%s cannot be used inside bpf_rcu_read_lock-ed region\n", prefix);
 		return -EINVAL;
 	}
@@ -11426,7 +11426,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
-	if (env->cur_state->active_rcu_lock) {
+	if (env->cur_state->active_rcu_locks) {
 		if (fn->might_sleep) {
 			verbose(env, "sleepable helper %s#%d in rcu_read_lock region\n",
 				func_id_name(func_id), func_id);
@@ -13863,7 +13863,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	preempt_disable = is_kfunc_bpf_preempt_disable(&meta);
 	preempt_enable = is_kfunc_bpf_preempt_enable(&meta);
 
-	if (env->cur_state->active_rcu_lock) {
+	if (env->cur_state->active_rcu_locks) {
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
 		u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
@@ -13874,22 +13874,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 
 		if (rcu_lock) {
-			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
-			return -EINVAL;
+			env->cur_state->active_rcu_locks++;
 		} else if (rcu_unlock) {
-			bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
-				if (reg->type & MEM_RCU) {
-					reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
-					reg->type |= PTR_UNTRUSTED;
-				}
-			}));
-			env->cur_state->active_rcu_lock = false;
+			if (--env->cur_state->active_rcu_locks == 0) {
+				bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
+					if (reg->type & MEM_RCU) {
+						reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
+						reg->type |= PTR_UNTRUSTED;
+					}
+				}));
+			}
 		} else if (sleepable) {
 			verbose(env, "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
 			return -EACCES;
 		}
 	} else if (rcu_lock) {
-		env->cur_state->active_rcu_lock = true;
+		env->cur_state->active_rcu_locks++;
 	} else if (rcu_unlock) {
 		verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
 		return -EINVAL;
@@ -18887,7 +18887,7 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 	if (old->active_preempt_locks != cur->active_preempt_locks)
 		return false;
 
-	if (old->active_rcu_lock != cur->active_rcu_lock)
+	if (old->active_rcu_locks != cur->active_rcu_locks)
 		return false;
 
 	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index c9f855e5da24..246eb259c08a 100644
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
@@ -78,7 +79,8 @@ static const char * const inproper_region_tests[] = {
 	"non_sleepable_rcu_mismatch",
 	"inproper_sleepable_helper",
 	"inproper_sleepable_kfunc",
-	"nested_rcu_region",
+	"nested_rcu_region_unbalanced_1",
+	"nested_rcu_region_unbalanced_2",
 	"rcu_read_lock_global_subprog_lock",
 	"rcu_read_lock_global_subprog_unlock",
 	"rcu_read_lock_sleepable_helper_global_subprog",
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index 3a868a199349..d70c28824bbe 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -278,6 +278,46 @@ int nested_rcu_region(void *ctx)
 	return 0;
 }
 
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int nested_rcu_region_unbalanced_1(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	/* nested rcu read lock regions */
+	task = bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	bpf_rcu_read_lock();
+	real_parent = task->real_parent;
+	if (!real_parent)
+		goto out;
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+out:
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int nested_rcu_region_unbalanced_2(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	/* nested rcu read lock regions */
+	task = bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	bpf_rcu_read_lock();
+	bpf_rcu_read_lock();
+	real_parent = task->real_parent;
+	if (!real_parent)
+		goto out;
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+out:
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 int task_trusted_non_rcuptr(void *ctx)
 {
-- 
2.47.3



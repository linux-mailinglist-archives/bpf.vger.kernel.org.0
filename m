Return-Path: <bpf+bounces-69072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 907DAB8BC63
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5173A1885C17
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180882E543E;
	Sat, 20 Sep 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDxlo68j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE32E2EE4;
	Sat, 20 Sep 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330015; cv=none; b=Zj5LKHjOojT/xPwV3MXrBCmPRbZmyu+JQSme8Z+ggK9qIjzSeNnifCsI4rW0uJsoksPfitNmYVghSTfi0eR71WQOExKYv5JPZnwOJDy54inPI/IiZXKVkU9u2jZDQAsbOtOWv0IaMEmKtWwOuMEqrs2fzHqD9xK3rv0QpKfXmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330015; c=relaxed/simple;
	bh=nDwxlQ/VWRnh1gYFUOYk+Wryle09FJlPXMgq+fZYZdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf+7C1QqxePECB3i+eVoJ03bwtryWcPoQCbCbY5StTnNagzWnuT48LCiUopBvvO0bz38r89tcLcy9rTi7UE0+DDJGx70B1e2LSCJXhqwfZ9Weo5HKqg/VVpBpg+xoNYaLe48pWejfdg2OpPNs2pmf5nWoz2R9Ek+kC2S1p28TRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDxlo68j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD9FC4CEF5;
	Sat, 20 Sep 2025 01:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330014;
	bh=nDwxlQ/VWRnh1gYFUOYk+Wryle09FJlPXMgq+fZYZdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDxlo68jaSTNOTUeLYb/eaWG651hGAhXpqEeUi8ruRCPxGEQ0avRkexc2XuQ+xSS3
	 qOd8nWlyA7DGJG4jUwTkI/eAghq+XPJ8FPKeKtdA/oEPBCitzrXFNC83JDgfaPl9ym
	 P+szxs4PIvj4WispOwoVS+UwTCaaFBNKY6JUwpSSLOcOGUyqB+Z7S8nWTGx+8ZJHjH
	 R7Kqn+EEUKiPO+Hug8Kw7GNGJW5fr4kNOm7xm0s/ymbzesBNMYK923LaA6+VzhZrpx
	 HG5hNDhc1sSyaPFMHqeTDFFAayqvX8CXnT65gteQ0IAMbvajzk8hqmeYKxi1b2SuDi
	 cUgSuOmnaBDRQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 37/46] sched_ext: Make watchdog sub-sched aware
Date: Fri, 19 Sep 2025 14:59:00 -1000
Message-ID: <20250920005931.2753828-38-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the watchdog checks all tasks as if they are all on scx_root.
Move scx_watchdog_timeout inside scx_sched and make check_rq_for_timeouts()
use the timeout from the scx_sched associated with each task.
refresh_watchdog() is added, which determines the timer interval as half of
the shortest watchdog timeouts of all scheds and arms or disarms it as
necessary. Every scx_sched instance has equivalent or better detection
latency while sharing the same timer.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 74 ++++++++++++++++++++++++-------------
 kernel/sched/ext_internal.h |  7 ++++
 2 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3fcf6cd7fa00..4dc82afb7016 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -66,11 +66,10 @@ static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_enable_seq = ATOMIC_LONG_INIT(0);
 
 /*
- * The maximum amount of time in jiffies that a task may be runnable without
- * being scheduled on a CPU. If this timeout is exceeded, it will trigger
- * scx_error().
+ * Watchdog interval. All scx_sched's share a single watchdog timer and the
+ * interval is half of the shortest sch->watchdog_timeout.
  */
-static unsigned long scx_watchdog_timeout;
+static unsigned long scx_watchdog_interval;
 
 /*
  * The last time the delayed work was run. This delayed work relies on
@@ -2761,10 +2760,11 @@ static bool check_rq_for_timeouts(struct rq *rq)
 		goto out_unlock;
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node) {
+		struct scx_sched *sch = scx_task_sched(p);
 		unsigned long last_runnable = p->scx.runnable_at;
 
 		if (unlikely(time_after(jiffies,
-					last_runnable + scx_watchdog_timeout))) {
+					last_runnable + sch->watchdog_timeout))) {
 			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
 
 			scx_exit(sch, SCX_EXIT_ERROR_STALL, 0,
@@ -2781,6 +2781,7 @@ static bool check_rq_for_timeouts(struct rq *rq)
 
 static void scx_watchdog_workfn(struct work_struct *work)
 {
+	unsigned long intv;
 	int cpu;
 
 	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
@@ -2791,28 +2792,31 @@ static void scx_watchdog_workfn(struct work_struct *work)
 
 		cond_resched();
 	}
-	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
-			   scx_watchdog_timeout / 2);
+
+	intv = READ_ONCE(scx_watchdog_interval);
+	if (intv < ULONG_MAX)
+		queue_delayed_work(system_unbound_wq, to_delayed_work(work),
+				   intv);
 }
 
 void scx_tick(struct rq *rq)
 {
-	struct scx_sched *sch;
+	struct scx_sched *root;
 	unsigned long last_check;
 
 	if (!scx_enabled())
 		return;
 
-	sch = rcu_dereference_bh(scx_root);
-	if (unlikely(!sch))
+	root = rcu_dereference_bh(scx_root);
+	if (unlikely(!root))
 		return;
 
 	last_check = READ_ONCE(scx_watchdog_timestamp);
 	if (unlikely(time_after(jiffies,
-				last_check + READ_ONCE(scx_watchdog_timeout)))) {
+				last_check + READ_ONCE(root->watchdog_timeout)))) {
 		u32 dur_ms = jiffies_to_msecs(jiffies - last_check);
 
-		scx_exit(sch, SCX_EXIT_ERROR_STALL, 0,
+		scx_exit(root, SCX_EXIT_ERROR_STALL, 0,
 			 "watchdog failed to check in for %u.%03us",
 			 dur_ms / 1000, dur_ms % 1000);
 	}
@@ -4108,6 +4112,26 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 	}
 }
 
+static void refresh_watchdog(void)
+{
+	struct scx_sched *sch;
+	unsigned long intv = ULONG_MAX;
+
+	/* take the shortest timeout and use its half for watchdog interval */
+	rcu_read_lock();
+	list_for_each_entry_rcu(sch, &scx_sched_all, all)
+		intv = max(min(intv, sch->watchdog_timeout / 2), 1);
+	rcu_read_unlock();
+
+	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
+	WRITE_ONCE(scx_watchdog_interval, intv);
+
+	if (intv < ULONG_MAX)
+		mod_delayed_work(system_unbound_wq, &scx_watchdog_work, intv);
+	else
+		cancel_delayed_work_sync(&scx_watchdog_work);
+}
+
 #ifdef CONFIG_EXT_SUB_SCHED
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
@@ -4159,6 +4183,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 	list_del_rcu(&sch->all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	mutex_unlock(&scx_enable_mutex);
 
 	/*
@@ -4316,12 +4342,12 @@ static void scx_root_disable(struct scx_sched *sch)
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, exit, NULL, ei);
 
-	cancel_delayed_work_sync(&scx_watchdog_work);
-
 	raw_spin_lock_irq(&scx_sched_lock);
 	list_del_rcu(&sch->all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	/*
 	 * scx_root clearing must be inside cpus_read_lock(). See
 	 * handle_hotplug().
@@ -4780,6 +4806,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	sch->ancestors[level] = sch;
 	sch->level = level;
 
+	if (ops->timeout_ms)
+		sch->watchdog_timeout = msecs_to_jiffies(ops->timeout_ms);
+	else
+		sch->watchdog_timeout = SCX_WATCHDOG_MAX_TIMEOUT;
+
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
 	init_irq_work(&sch->error_irq_work, scx_error_irq_workfn);
 	kthread_init_work(&sch->disable_work, scx_disable_workfn);
@@ -4899,7 +4930,6 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	struct scx_sched *sch;
 	struct scx_task_iter sti;
 	struct task_struct *p;
-	unsigned long timeout;
 	int i, cpu, ret;
 
 	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
@@ -4953,6 +4983,8 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	list_add_tail_rcu(&sch->all, &scx_sched_all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	scx_idle_enable(ops);
 
 	if (sch->ops.init) {
@@ -4979,16 +5011,6 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret)
 		goto err_disable;
 
-	if (ops->timeout_ms)
-		timeout = msecs_to_jiffies(ops->timeout_ms);
-	else
-		timeout = SCX_WATCHDOG_MAX_TIMEOUT;
-
-	WRITE_ONCE(scx_watchdog_timeout, timeout);
-	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
-	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
-			   scx_watchdog_timeout / 2);
-
 	/*
 	 * Once __scx_enabled is set, %current can be switched to SCX anytime.
 	 * This can lead to stalls as some BPF schedulers (e.g. userspace
@@ -5215,6 +5237,8 @@ static int scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	list_add_tail_rcu(&sch->all, &scx_sched_all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
 			  SCX_SUB_MAX_DEPTH);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 8dbdae910564..4399c003c15f 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -974,6 +974,13 @@ struct scx_sched {
 	struct kset		*sub_kset;
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
+	/*
+	 * The maximum amount of time in jiffies that a task may be runnable
+	 * without being scheduled on a CPU. If this timeout is exceeded, it
+	 * will trigger scx_error().
+	 */
+	unsigned long		watchdog_timeout;
+
 	atomic_t		exit_kind;
 	struct scx_exit_info	*exit_info;
 
-- 
2.51.0



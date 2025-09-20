Return-Path: <bpf+bounces-69054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D642B8BC38
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7317AAA7C
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D76E212566;
	Sat, 20 Sep 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCl9dVrH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3A29E0E7;
	Sat, 20 Sep 2025 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329996; cv=none; b=X/NyODdSOmJb4dkqicyAfEPVy4sbhI9pUrZxv41XkFlib5Hnu35zxG2GzwcLVbKW9RKfyEC/DXyDHB0WCjm9PgnnWCS/uRVz+t1dwUwOQNBzc0ua3ovnYDdE9wWhWUEiZv9aCK+TRB5yAzaTRiB/uUeCGLSd2MFTVmTzbR/Xhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329996; c=relaxed/simple;
	bh=7sQ1fkcc+qgQeE3eG8/hVzks21NicPfu4GUI9mIepjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeHs9HsiMdvnU5kEk4ChP7zIZtIvvCh8rkRJMUdixqh1y5p8I/af3YjVoQeNA4w4HCBAuSZzpFY1hIyDM9dv4uZ0FwMGdvJKvF3f2F9DLf1ZWHXUGF33DFnV0QXGGirOw6IZbAUbL7nw5ptrySPcW4F+xH8F6z5YGLzYiPlJVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCl9dVrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B57C4CEF0;
	Sat, 20 Sep 2025 00:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329995;
	bh=7sQ1fkcc+qgQeE3eG8/hVzks21NicPfu4GUI9mIepjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCl9dVrHknEABH+oTYymPBHB+7GkmS8sigrVSTEONAKkStfk29S1LZU5LWAJeYh7u
	 2Zar6SIIqWn0//5OsKh6VosLOt0gnNX5hKMPRa3ij+nI14OYbqy595YoqCo3KhrmpC
	 1xVQxEwZ507erjUrPEiyUOX5VoNe2GPJNc5EKyqm3X3/wRHWf7nFX8ZOQncUgq4tSY
	 NwpOSdAO4rxOEJe3j5yk2CcNQLYBRPpcLTGvBnaN9DmgD+Pe3Wo/qPVZdoZhxUChIv
	 eh2ImvJvu98D3TOapzEBkqHz94ZKHv6DQW/+M7NjbKHfHSmG/zXXYjWQHqTz8UjcOZ
	 6p0U+7rSQTukA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 21/46] sched_ext: Minor reorganization of enable/disable path
Date: Fri, 19 Sep 2025 14:58:44 -1000
Message-ID: <20250920005931.2753828-22-tj@kernel.org>
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

- Separate out scx_root_disable() from scx_disable_workfn().

- Rename scx_enable() to scx_root_enable().

- Add @sch to scx_disable(). The callers are now responsible for providing
  the scx_sched to disable.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 70 ++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0ee716ff4dab..54f65a196d94 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3018,8 +3018,8 @@ void sched_ext_free(struct task_struct *p)
 	spin_unlock_irqrestore(&scx_tasks_lock, flags);
 
 	/*
-	 * @p is off scx_tasks and wholly ours. scx_enable()'s READY -> ENABLED
-	 * transitions can't race us. Disable ops for @p.
+	 * @p is off scx_tasks and wholly ours. scx_root_enable()'s READY ->
+	 * ENABLED transitions can't race us. Disable ops for @p.
 	 */
 	if (scx_get_task_state(p) != SCX_TASK_NONE) {
 		struct rq_flags rf;
@@ -3933,24 +3933,12 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 	}
 }
 
-static void scx_disable_workfn(struct kthread_work *work)
+static void scx_root_disable(struct scx_sched *sch)
 {
-	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
 	struct scx_exit_info *ei = sch->exit_info;
 	struct scx_task_iter sti;
 	struct task_struct *p;
-	int kind, cpu;
-
-	kind = atomic_read(&sch->exit_kind);
-	while (true) {
-		if (kind == SCX_EXIT_DONE)	/* already disabled? */
-			return;
-		WARN_ON_ONCE(kind == SCX_EXIT_NONE);
-		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
-			break;
-	}
-	ei->kind = kind;
-	ei->reason = scx_exit_reason(ei->kind);
+	int cpu;
 
 	/* guarantee forward progress by bypassing scx_ops */
 	scx_bypass(true);
@@ -4078,21 +4066,35 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_bypass(false);
 }
 
-static void scx_disable(enum scx_exit_kind kind)
+static void scx_disable_workfn(struct kthread_work *work)
+{
+	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
+	struct scx_exit_info *ei = sch->exit_info;
+	int kind;
+
+	kind = atomic_read(&sch->exit_kind);
+	while (true) {
+		if (kind == SCX_EXIT_DONE)	/* already disabled? */
+			return;
+		WARN_ON_ONCE(kind == SCX_EXIT_NONE);
+		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
+			break;
+	}
+	ei->kind = kind;
+	ei->reason = scx_exit_reason(ei->kind);
+
+	scx_root_disable(sch);
+}
+
+static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
 {
 	int none = SCX_EXIT_NONE;
-	struct scx_sched *sch;
 
 	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
 		kind = SCX_EXIT_ERROR;
 
-	rcu_read_lock();
-	sch = rcu_dereference(scx_root);
-	if (sch) {
-		atomic_try_cmpxchg(&sch->exit_kind, &none, kind);
-		kthread_queue_work(sch->helper, &sch->disable_work);
-	}
-	rcu_read_unlock();
+	atomic_try_cmpxchg(&sch->exit_kind, &none, kind);
+	kthread_queue_work(sch->helper, &sch->disable_work);
 }
 
 static void dump_newline(struct seq_buf *s)
@@ -4558,7 +4560,7 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 	return 0;
 }
 
-static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
+static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 {
 	struct scx_sched *sch;
 	struct scx_task_iter sti;
@@ -4808,7 +4810,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * Flush scx_disable_work to ensure that error is reported before init
 	 * completion. sch's base reference will be put by bpf_scx_unreg().
 	 */
-	scx_error(sch, "scx_enable() failed (%d)", ret);
+	scx_error(sch, "scx_root_enable() failed (%d)", ret);
 	kthread_flush_work(&sch->disable_work);
 	return 0;
 }
@@ -4940,7 +4942,7 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
 static int bpf_scx_reg(void *kdata, struct bpf_link *link)
 {
-	return scx_enable(kdata, link);
+	return scx_root_enable(kdata, link);
 }
 
 static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
@@ -4948,7 +4950,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 	struct sched_ext_ops *ops = kdata;
 	struct scx_sched *sch = ops->priv;
 
-	scx_disable(SCX_EXIT_UNREG);
+	scx_disable(sch, SCX_EXIT_UNREG);
 	kthread_flush_work(&sch->disable_work);
 	kobject_put(&sch->kobj);
 }
@@ -5074,7 +5076,15 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
 
 static void sysrq_handle_sched_ext_reset(u8 key)
 {
-	scx_disable(SCX_EXIT_SYSRQ);
+	struct scx_sched *sch;
+
+	rcu_read_lock();
+	sch = rcu_dereference(scx_root);
+	if (likely(sch))
+		scx_disable(sch, SCX_EXIT_SYSRQ);
+	else
+		pr_info("sched_ext: BPF schedulers not loaded\n");
+	rcu_read_unlock();
 }
 
 static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
-- 
2.51.0



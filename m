Return-Path: <bpf+bounces-69063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3EB8BC20
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6131C2258B
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9632D9EFB;
	Sat, 20 Sep 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxrusEcW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FF2D8384;
	Sat, 20 Sep 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330006; cv=none; b=LxvZLGXwGmhLG7QHJi+5sB01pJGFo8OjrhzQkbhRfIKXsifii87I7SECq8hKLJtU9fpIBH9jGSdJbZ0GDReGKg8YeHmJVhGb6Ly8cq0kiyRGCFvScOYkwnVhf7BVtCtMaAE12Uqkt7tYR8yZgMtEh9R1PLX4KRgvhqWAqjiBn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330006; c=relaxed/simple;
	bh=RV2lKnbKasLL8XBa1/urB9OQioreYAEazKM1P/oyQMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYdIoWY9PG3wYUfnJLjto3W29cpBaqkHVOpsHabfe8dS74YwtcKU4EUiBZXZNUSGtbaZ2uCkvn3bk9xno0bvIdYA8ao8d9R7mphIuisDkvalzT9OzE1R0Gjf3R4HQZT+aWHApQg0kPBFXP/KBqVycN2q0xQsRcEbd8nSH20aWFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxrusEcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC748C4CEF5;
	Sat, 20 Sep 2025 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330005;
	bh=RV2lKnbKasLL8XBa1/urB9OQioreYAEazKM1P/oyQMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxrusEcWdaUkt/JKrKK2owyEdTQUC3Qvw6EeCj0A4GLU6+sMxUG0YMeSh17+5agqh
	 UyW6BgdhVMkWnv4a5rNsUmw1WnabOINNr27Q/Idqit6LZ6xJhDo5IWe+MY2z+VTOB6
	 V8jX/yTxtXuQD7wWl4qdhBnqhHAyMe73hSMga6rYzKdChIOrumaI0dBqIDVKawbZEg
	 /0EveV0uERDAnX2ya++Jwmx8qDVXvhxGujPbZpGmnsR+2c+rKTRmEt1BFgbjMVxqM6
	 kWGyX9ZKO/bcmsGE+4SDMO0+gqjCjFt23Ln9LsniCYvbrSmZ0Lmj34rbGcJkFDwbGb
	 pre0rc80ZxMRQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 29/46] sched_ext: Refactor task init/exit helpers
Date: Fri, 19 Sep 2025 14:58:52 -1000
Message-ID: <20250920005931.2753828-30-tj@kernel.org>
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

- Add the @sch parameter to scx_init_task() and drop @tg as it can be
  obtained from @p. Separate out __scx_init_task() which does everything
  except for the task state transition.

- Add the @sch parameter to scx_enable_task(). Separate out
  __scx_enable_task() which does everything except for the task state
  transition.

- Add the @sch parameter to scx_disable_task().

- Rename scx_exit_task() to scx_disable_and_exit_task() and separate out
  __scx_disable_and_exit_task() which does everything except for the task
  state transition.

While some task state transitions are relocated, no meaningful behavior
changes are expected.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 60 ++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c60b58341d24..5b02903ba3bb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2901,9 +2901,9 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
 	p->scx.flags |= state << SCX_TASK_STATE_SHIFT;
 }
 
-static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork)
+static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
 {
-	struct scx_sched *sch = scx_root;
+	struct task_group *tg = task_group(p);
 	int ret;
 
 	p->scx.disallow = false;
@@ -2922,8 +2922,6 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 		}
 	}
 
-	scx_set_task_state(p, SCX_TASK_INIT);
-
 	if (p->scx.disallow) {
 		if (unlikely(scx_parent(sch))) {
 			scx_error(sch, "non-root ops.init_task() set task->scx.disallow for %s[%d]",
@@ -2957,9 +2955,18 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 	return 0;
 }
 
-static void scx_enable_task(struct task_struct *p)
+static int scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
+{
+	int ret;
+
+	ret = __scx_init_task(sch, p, fork);
+	if (!ret)
+		scx_set_task_state(p, SCX_TASK_INIT);
+	return ret;
+}
+
+static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
 	struct rq *rq = task_rq(p);
 	u32 weight;
 
@@ -2978,16 +2985,20 @@ static void scx_enable_task(struct task_struct *p)
 
 	if (SCX_HAS_OP(sch, enable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, enable, rq, p);
-	scx_set_task_state(p, SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(sch, set_weight))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_weight, rq,
 				 p, p->scx.weight);
 }
 
-static void scx_disable_task(struct task_struct *p)
+static void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
+{
+	__scx_enable_task(sch, p);
+	scx_set_task_state(p, SCX_TASK_ENABLED);
+}
+
+static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
 	struct rq *rq = task_rq(p);
 
 	lockdep_assert_rq_held(rq);
@@ -2998,9 +3009,9 @@ static void scx_disable_task(struct task_struct *p)
 	scx_set_task_state(p, SCX_TASK_READY);
 }
 
-static void scx_exit_task(struct task_struct *p)
+static void __scx_disable_and_exit_task(struct scx_sched *sch,
+					struct task_struct *p)
 {
-	struct scx_sched *sch = scx_task_sched(p);
 	struct scx_exit_task_args args = {
 		.cancelled = false,
 	};
@@ -3017,7 +3028,7 @@ static void scx_exit_task(struct task_struct *p)
 	case SCX_TASK_READY:
 		break;
 	case SCX_TASK_ENABLED:
-		scx_disable_task(p);
+		scx_disable_task(sch, p);
 		break;
 	default:
 		WARN_ON_ONCE(true);
@@ -3027,6 +3038,13 @@ static void scx_exit_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, exit_task))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, exit_task, task_rq(p),
 				 p, &args);
+}
+
+static void scx_disable_and_exit_task(struct scx_sched *sch,
+				      struct task_struct *p)
+{
+	__scx_disable_and_exit_task(sch, p);
+
 	scx_set_task_sched(p, NULL);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
@@ -3062,7 +3080,7 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
 	if (scx_init_task_enabled) {
-		ret = scx_init_task(p, task_group(p), true);
+		ret = scx_init_task(scx_root, p, true);
 		if (!ret)
 			scx_set_task_sched(p, scx_root);
 		return ret;
@@ -3086,7 +3104,7 @@ void scx_post_fork(struct task_struct *p)
 			struct rq *rq;
 
 			rq = task_rq_lock(p, &rf);
-			scx_enable_task(p);
+			scx_enable_task(scx_task_sched(p), p);
 			task_rq_unlock(rq, p, &rf);
 		}
 	}
@@ -3106,7 +3124,7 @@ void scx_cancel_fork(struct task_struct *p)
 
 		rq = task_rq_lock(p, &rf);
 		WARN_ON_ONCE(scx_get_task_state(p) >= SCX_TASK_READY);
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 		task_rq_unlock(rq, p, &rf);
 	}
 
@@ -3137,7 +3155,7 @@ void sched_ext_free(struct task_struct *p)
 		struct rq *rq;
 
 		rq = task_rq_lock(p, &rf);
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 		task_rq_unlock(rq, p, &rf);
 	}
 }
@@ -3163,7 +3181,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
-	scx_enable_task(p);
+	scx_enable_task(sch, p);
 
 	/*
 	 * set_cpus_allowed_scx() is not called while @p is associated with a
@@ -3176,7 +3194,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
-	scx_disable_task(p);
+	scx_disable_task(scx_task_sched(p), p);
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
@@ -4201,7 +4219,7 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	/*
 	 * Shut down cgroup support before tasks so that the cgroup attach path
-	 * doesn't race against scx_exit_task().
+	 * doesn't race against scx_disable_and_exit_task().
 	 */
 	scx_cgroup_lock();
 	scx_cgroup_exit(sch);
@@ -4234,7 +4252,7 @@ static void scx_root_disable(struct scx_sched *sch)
 		sched_enq_and_set_task(&ctx);
 
 		check_class_changed(task_rq(p), p, old_class, p->prio);
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 	}
 	scx_task_iter_stop(&sti);
 
@@ -5022,7 +5040,7 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 		scx_task_iter_unlock(&sti);
 
-		ret = scx_init_task(p, task_group(p), false);
+		ret = scx_init_task(sch, p, false);
 		if (ret) {
 			put_task_struct(p);
 			scx_task_iter_stop(&sti);
-- 
2.51.0



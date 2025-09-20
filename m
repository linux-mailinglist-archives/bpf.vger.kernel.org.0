Return-Path: <bpf+bounces-69047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586BEB8BBC3
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6F71729EB
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69939262FDC;
	Sat, 20 Sep 2025 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5qxgEsF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94725DB0A;
	Sat, 20 Sep 2025 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329989; cv=none; b=NpI7xZgOd/lcgmQbujgZ0MWZtAw+QMSVKg/Q8058xDTpz0f7G2jXbszoGFQN9hFrQutKV6oNF3CtZKqS8zjiCgq89Qc3FIsGseQqviG15LtQqpPPHZMyXKXFLNhnf5O1IUJmhuEmol/oUHE1TqNX8Bt9IwzXmDC5lHl6HOZrS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329989; c=relaxed/simple;
	bh=fjF/wzE63+fDOVGjbw4C2GjQY6O0hB6fbYPYd6ttus0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+9KVbqf0hKRcPMAjU4vvT0a3WV1rDBS9FAln6sci3fvLuY6q8ZRbYn7eCGpC8SHQZzUKsBpmdKKzy+zvX9UkBXpzKYngaR/eGni/FuHlwYbC1M2sSF5U83MYSWrs3wOMwyt9IW/3l2pbREbZ6/3Bm0wLVEPMQya8BuB/CkL9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5qxgEsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99207C4CEF5;
	Sat, 20 Sep 2025 00:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329988;
	bh=fjF/wzE63+fDOVGjbw4C2GjQY6O0hB6fbYPYd6ttus0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5qxgEsFqOvx99vqKFUK4TobXSBdRohz3OvXdpX2RU/mZxtc4r1Bz/DuLploIGFY6
	 UtCUxY0YsAH1Zh1PUCUNXkgHlYhqfprNZZBgUzXSxqvzzGJ2glbGqQsSECWwJlfQWY
	 wGkHo1m0+BA48o8gr6N1txdN/rsqnveU7QSINcO8Oe1qvH9+ItBds60dGNVww0HRb6
	 yHfUbg4yLWSXkFVhUUUTgEnGRPThuFgm4IXGeuZI86glpKMt4xvhqga8FpM/hhxgKP
	 gBdxobrMjLPUdspgBf/zHIbx77KzQRP+hZqNFamRz7oBpN6oqH7XwuUVmb0tFNdh2D
	 LymJ31ZsIFSwg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/46] sched_ext: Misc updates around scx_sched instance pointer
Date: Fri, 19 Sep 2025 14:58:37 -1000
Message-ID: <20250920005931.2753828-15-tj@kernel.org>
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

In preparation for multiple scheduler support:

- Add the @sch parameter to find_global_dsq() and refill_task_slice_dfl().

- Restructure scx_allow_ttwu_queue() and make it read scx_root into $sch.

- Make RCU protection in scx_dsq_move() and scx_bpf_dsq_move_to_local()
  explicit.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 62 ++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0c99a55f199b..32306203fba5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -181,10 +181,9 @@ static bool u32_before(u32 a, u32 b)
 	return (s32)(a - b) < 0;
 }
 
-static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
+static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch,
+					      struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
-
 	return sch->global_dsqs[cpu_to_node(task_cpu(p))];
 }
 
@@ -880,10 +879,10 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 	WRITE_ONCE(dsq->nr, dsq->nr + delta);
 }
 
-static void refill_task_slice_dfl(struct task_struct *p)
+static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
 	p->scx.slice = SCX_SLICE_DFL;
-	__scx_add_event(scx_root, SCX_EV_REFILL_SLICE_DFL, 1);
+	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
 static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
@@ -901,7 +900,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			scx_error(sch, "attempting to dispatch to a destroyed dsq");
 			/* fall back to the global dsq */
 			raw_spin_unlock(&dsq->lock);
-			dsq = find_global_dsq(p);
+			dsq = find_global_dsq(sch, p);
 			raw_spin_lock(&dsq->lock);
 		}
 	}
@@ -1080,20 +1079,20 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
 		if (!ops_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
-			return find_global_dsq(p);
+			return find_global_dsq(sch, p);
 
 		return &cpu_rq(cpu)->scx.local_dsq;
 	}
 
 	if (dsq_id == SCX_DSQ_GLOBAL)
-		dsq = find_global_dsq(p);
+		dsq = find_global_dsq(sch, p);
 	else
 		dsq = find_user_dsq(sch, dsq_id);
 
 	if (unlikely(!dsq)) {
 		scx_error(sch, "non-existent DSQ 0x%llx for %s[%d]",
 			  dsq_id, p->comm, p->pid);
-		return find_global_dsq(p);
+		return find_global_dsq(sch, p);
 	}
 
 	return dsq;
@@ -1272,15 +1271,15 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 * higher priority it becomes from scx_prio_less()'s POV.
 	 */
 	touch_core_sched(rq, p);
-	refill_task_slice_dfl(p);
+	refill_task_slice_dfl(sch, p);
 local_norefill:
 	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
 	return;
 
 global:
 	touch_core_sched(rq, p);	/* see the comment in local: */
-	refill_task_slice_dfl(p);
-	dispatch_enqueue(sch, find_global_dsq(p), p, enq_flags);
+	refill_task_slice_dfl(sch, p);
+	dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -1692,7 +1691,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			dst_dsq = find_global_dsq(p);
+			dst_dsq = find_global_dsq(sch, p);
 			dst_rq = src_rq;
 		}
 	} else {
@@ -1848,7 +1847,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 
 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, find_global_dsq(p), p,
+		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
@@ -2380,7 +2379,7 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 	if (keep_prev) {
 		p = prev;
 		if (!p->scx.slice)
-			refill_task_slice_dfl(p);
+			refill_task_slice_dfl(rcu_dereference_sched(scx_root), p);
 	} else {
 		p = first_local_task(rq);
 		if (!p) {
@@ -2391,14 +2390,14 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 		}
 
 		if (unlikely(!p->scx.slice)) {
-			struct scx_sched *sch = scx_root;
+			struct scx_sched *sch = rcu_dereference_sched(scx_root);
 
 			if (!scx_rq_bypassing(rq) && !sch->warned_zero_slice) {
 				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in %s()\n",
 						p->comm, p->pid, __func__);
 				sch->warned_zero_slice = true;
 			}
-			refill_task_slice_dfl(p);
+			refill_task_slice_dfl(sch, p);
 		}
 	}
 
@@ -2487,7 +2486,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, NULL, 0);
 		if (cpu >= 0) {
-			refill_task_slice_dfl(p);
+			refill_task_slice_dfl(sch, p);
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
 		} else {
 			cpu = prev_cpu;
@@ -3572,9 +3571,22 @@ bool task_should_scx(int policy)
 
 bool scx_allow_ttwu_queue(const struct task_struct *p)
 {
-	return !scx_enabled() ||
-		(scx_root->ops.flags & SCX_OPS_ALLOW_QUEUED_WAKEUP) ||
-		p->sched_class != &ext_sched_class;
+	struct scx_sched *sch;
+
+	if (!scx_enabled())
+		return true;
+
+	sch = rcu_dereference_sched(scx_root);
+	if (unlikely(!sch))
+		return true;
+
+	if (scx_root->ops.flags & SCX_OPS_ALLOW_QUEUED_WAKEUP)
+		return true;
+
+	if (unlikely(p->sched_class != &ext_sched_class))
+		return true;
+
+	return false;
 }
 
 /**
@@ -5537,9 +5549,15 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(void)
  */
 __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 {
-	struct scx_sched *sch = scx_root;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return false;
 
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
-- 
2.51.0



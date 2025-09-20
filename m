Return-Path: <bpf+bounces-69077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B71B8BC7B
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5AC17EB4A
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D8D233711;
	Sat, 20 Sep 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOY2/hHr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB72248B0;
	Sat, 20 Sep 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330020; cv=none; b=NxQpGxG5UFWh4qOBwV3EJ2dIU+z/mh9KC8K5GyjFwCPrbumMhyn+KHGfKLX5ocxXTEAInzUn7P4FwAXjGjOFWAu98VWV4YYCMesWOjnnqb4o6bLGnrRg9db75XAjrwjWLo4V203sT4ZjYMChKuUpjuurwVH3NvtJbe1BzuqiJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330020; c=relaxed/simple;
	bh=DsTlGgohcj9mbn41+jLZqmYNTWn3+KJLjfNKgVrU3J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwXUjRej4/cXV8muchRUvXhd/Pz1uGzBSMgBFk04hFKcZPzr2Tzzh/FJNwjvQv5vuAG1szX6ollpoTXvqQJCp9zQZj/0UaFkWtaIMN5ZuWmXWZRz3XnVFw+tdQFLyxFUdURFlgaOPyaVbxAADi9hi23picsa9Smz6qw4S7QAcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOY2/hHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B97EC4CEF0;
	Sat, 20 Sep 2025 01:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330020;
	bh=DsTlGgohcj9mbn41+jLZqmYNTWn3+KJLjfNKgVrU3J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOY2/hHrT5OBQ1iq/zqvxVFtRG6BNNJFzUtoQ0l9n2sem1gMAC+T+aVcAMHBI0rfq
	 As3lxCJYo5uEm1l9DpPOwrEY6JzY95mHygmOXtNETjZeJ89jsjqBlCIknnoOP52B6h
	 iHbYhXncRwqN+sp1esVNtMsye81b0U9QBKb10AtsZpGE3XkueSN858UjqY6pzl9Dot
	 3OjWFWjvVa8q0W2yOph2r0le2JMxRFC4pC0KGMM7WwEWDYwlnepRD0wmmC6nVEwCKI
	 Z7x063+U8MEOhFB/nOcKyiqqt5ca1hpe+QKXg5HKej7xPShfwPQb5hZa2Tqla7nrhs
	 qsbCCCJWfDA5A==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 43/46] sched_ext: Add bypass DSQ for sub-schedulers
Date: Fri, 19 Sep 2025 14:59:06 -1000
Message-ID: <20250920005931.2753828-44-tj@kernel.org>
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

When sub-schedulers bypass, we want to isolate their impact on the
system while ensuring forward progress. Add a bypass DSQ to route tasks
from bypassing sub-schedulers to their nearest non-bypassing ancestor.

Each per-node structure gets a bypass DSQ (SCX_DSQ_SUB_BYPASS). Tasks
from bypassing descendants are collected there and consumed with a
simple alternating policy between regular dispatch and bypass DSQ.

Add SCX_EV_SUB_BYPASS_DISPATCH event counter to track bypass DSQ usage
for observability.

In the future, we can add ops flags and kfuncs to allow BPF schedulers
to control bypass scheduling if needed.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h   |  2 +
 kernel/sched/ext.c          | 91 +++++++++++++++++++++++++++++++++----
 kernel/sched/ext_internal.h |  9 ++++
 kernel/sched/sched.h        |  3 ++
 4 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index df1111d245bc..2f46de38966d 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -48,6 +48,8 @@ enum scx_dsq_id_flags {
 	SCX_DSQ_LOCAL		= SCX_DSQ_FLAG_BUILTIN | 2,
 	SCX_DSQ_LOCAL_ON	= SCX_DSQ_FLAG_BUILTIN | SCX_DSQ_FLAG_LOCAL_ON,
 	SCX_DSQ_LOCAL_CPU_MASK	= 0xffffffffLLU,
+
+	SCX_DSQ_SUB_BYPASS	= SCX_DSQ_FLAG_BUILTIN | 3,
 };
 
 /*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a74ae955c489..4558bec72508 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -282,6 +282,42 @@ static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
 	return rhashtable_lookup(&sch->dsq_hash, &dsq_id, dsq_hash_params);
 }
 
+static struct scx_dispatch_q *find_bypass_dsq(struct scx_sched *sch,
+					      struct rq *rq,
+					      struct task_struct *p)
+{
+#ifdef CONFIG_EXT_SUB_SCHED
+	struct scx_sched *pos;
+
+	/*
+	 * If @sch is a sub-sched which is bypassing, its tasks should go into
+	 * the bypass_dsq of the nearest ancestor which is not bypassing. The
+	 * not-bypassing sched is responsible for scheduling all tasks from
+	 * bypassing sub-trees. If all ancestors including root are bypassing,
+	 * there is no one home and @p should go to the root's global_dsq.
+	 *
+	 * Whenever a sched starts bypassing, all runnable tasks in its subtree
+	 * are re-enqueued after scx_bypassing() is turned on, guaranteeing that
+	 * all tasks are transferred to the right DSQ.
+	 */
+	pos = scx_parent(sch);
+	if (pos) {
+		while (true) {
+			if (!scx_bypassing(pos, cpu_of(rq))) {
+				int node = cpu_to_node(task_cpu(p));
+				return &pos->pnode[node]->sub_bypass_dsq;
+			}
+			if (pos->level == 0) {
+				sch = pos;
+				break;
+			}
+			pos = scx_parent(pos);
+		}
+	}
+#endif
+	return find_global_dsq(sch, p);
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -1353,6 +1389,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			    int sticky_cpu)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	struct scx_dispatch_q *fallback_dsq;
 	struct task_struct **ddsp_taskp;
 	unsigned long qseq;
 
@@ -1372,7 +1409,8 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 
 	if (scx_bypassing(sch, cpu_of(rq))) {
 		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
-		goto global;
+		fallback_dsq = find_bypass_dsq(sch, rq, p);
+		goto fallback;
 	}
 
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -1392,8 +1430,10 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 		goto local;
 	}
 
-	if (unlikely(!SCX_HAS_OP(sch, enqueue)))
-		goto global;
+	if (unlikely(!SCX_HAS_OP(sch, enqueue))) {
+		fallback_dsq = find_global_dsq(sch, p);
+		goto fallback;
+	}
 
 	/* DSQ bypass didn't trigger, enqueue on the BPF scheduler */
 	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
@@ -1434,10 +1474,10 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
 	return;
 
-global:
+fallback:
 	touch_core_sched(rq, p);	/* see the comment in local: */
 	refill_task_slice_dfl(sch, p);
-	dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
+	dispatch_enqueue(sch, fallback_dsq, p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -1961,11 +2001,36 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 	return false;
 }
 
-static bool consume_global_dsq(struct scx_sched *sch, struct rq *rq)
+static bool consume_fallback_dsqs(struct scx_sched *sch, struct rq *rq)
 {
-	int node = cpu_to_node(cpu_of(rq));
+	struct scx_sched_pnode *pnode = sch->pnode[cpu_to_node(cpu_of(rq))];
 
-	return consume_dispatch_q(sch, rq, &sch->pnode[node]->global_dsq);
+	if (consume_dispatch_q(sch, rq, &pnode->global_dsq))
+		return true;
+
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * @sch must ensure forward progress of its bypassing descendants that
+	 * dump their tasks into @sch's bypass DSQs. The following implements a
+	 * simple built-in behavior - let each CPU toggle between regular
+	 * dispatch and the bypass DSQ.
+	 *
+	 * Later, if necessary, we can add an ops flag to suppress the
+	 * auto-consumption and a kfunc to consume the bypass DSQ and, so that
+	 * the BPF scheduler can fully control scheduling of bypassed tasks.
+	 */
+	if (rq->scx.dsp_sub_bypass_toggle) {
+		if (consume_dispatch_q(sch, rq, &pnode->sub_bypass_dsq)) {
+			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
+			rq->scx.dsp_sub_bypass_toggle = false;
+			return true;
+		}
+	} else {
+		rq->scx.dsp_sub_bypass_toggle = true;
+	}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
+	return false;
 }
 
 /**
@@ -2175,7 +2240,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
 		sch == rcu_access_pointer(prev->scx.sched);
 
-	if (consume_global_dsq(sch, rq))
+	if (consume_fallback_dsqs(sch, rq))
 		return true;
 
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
@@ -2205,7 +2270,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		}
 		if (rq->scx.local_dsq.nr)
 			return true;
-		if (consume_global_dsq(sch, rq))
+		if (consume_fallback_dsqs(sch, rq))
 			return true;
 
 		/*
@@ -3789,6 +3854,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_SUB_BYPASS_DISPATCH);
 	return at;
 }
 SCX_ATTR(events);
@@ -4870,6 +4936,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
 	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
+	scx_dump_event(s, &events, SCX_EV_SUB_BYPASS_DISPATCH);
 
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
@@ -4951,6 +5018,9 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		}
 
 		init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch);
+#ifdef CONFIG_EXT_SUB_SCHED
+		init_dsq(&pnode->sub_bypass_dsq, SCX_DSQ_SUB_BYPASS, sch);
+#endif	/* CONFIG_EXT_SUB_SCHED */
 		sch->pnode[node] = pnode;
 	}
 
@@ -7623,6 +7693,7 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DISPATCH);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_ACTIVATE);
 		scx_agg_event(events, e_cpu, SCX_EV_INSERT_NOT_OWNED);
+		scx_agg_event(events, e_cpu, SCX_EV_SUB_BYPASS_DISPATCH);
 	}
 }
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 846855ea5948..f6d5867230bd 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -907,6 +907,12 @@ struct scx_event_stats {
 	 * scheduler.
 	 */
 	s64		SCX_EV_INSERT_NOT_OWNED;
+
+	/*
+	 * The number of times tasks from bypassing descendants are scheduled
+	 * from sub_bypass_dsq's.
+	 */
+	s64		SCX_EV_SUB_BYPASS_DISPATCH;
 };
 
 enum scx_sched_pcpu_flags {
@@ -943,6 +949,9 @@ struct scx_sched_pcpu {
 
 struct scx_sched_pnode {
 	struct scx_dispatch_q	global_dsq;
+#ifdef CONFIG_EXT_SUB_SCHED
+	struct scx_dispatch_q	sub_bypass_dsq;
+#endif	/* CONFIG_EXT_SUB_SCHED */
 };
 
 struct scx_sched {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index add7c0c218d4..cd6bdcdf9314 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -780,6 +780,9 @@ struct scx_rq {
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
+#ifdef CONFIG_EXT_SUB_SCHED
+	bool			dsp_sub_bypass_toggle;
+#endif	/* CONFIG_EXT_SUB_SCHED */
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
 
-- 
2.51.0



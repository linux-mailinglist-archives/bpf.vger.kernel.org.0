Return-Path: <bpf+bounces-14856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9367E88AC
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745CC281355
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51435258;
	Sat, 11 Nov 2023 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l96nHJex"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E21184F
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:52:13 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177E849F4;
	Fri, 10 Nov 2023 18:49:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bd73395bceso2178287b3a.0;
        Fri, 10 Nov 2023 18:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670995; x=1700275795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8VKZDa1nahLi0N4v1t35mHsasrmPUaq6jgx2mqzKDo=;
        b=l96nHJexGWEEnDmQpkeX66ArNnCqQvfmewfV07wedYmATKoDklUFE2wfYQi687+cBl
         LqRuDQUD7Ky48FGfg9+nSk7m7O23LHjXhF7s1lqQcPslHr4u4G3tyH1aM7x1WMy7/aeZ
         nviScHnteWx+Ly2qHh/OMDwZ/HQDA3II+qhZ9Xmryx+4RwbsiKLYWKwRELyHrjYSJJBo
         LHjnU+k549998px4eluOx5tPWBuhGedehHEC/JSAJFQhijHkS3waPgnGF1itCq8UQB6g
         AXO6+Z3EtNWTvo0TiaEOe9yxPOQoIePvobvZLfOYdEKl/mkQSAnyVNPxsVZDXkUYEsA2
         E2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670995; x=1700275795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g8VKZDa1nahLi0N4v1t35mHsasrmPUaq6jgx2mqzKDo=;
        b=Wory9pNh6/wnlVKSsvcvlPyEKc7ux9q+dkp7MaxV5k6bzzFHs1V2WRN4+7RI04uiwo
         uhUF9DN37qbrY8qSMsYgJPtkrtDel/Xg4dCSLCmVxPP1fRkQAfHKxAu/p0qLoNyb0m0M
         HSo6jDm22pF/MEj7RaAJXfi7DcExSZ8HhRXmjDYuwsf4oviBEYUfit14VhvxaIriljHX
         YAGOr9XaXneetdPDareqek7pk81MYthPHBKNILaFD6Y6Xv3qwz9jS/c8MsfCk2WVhInG
         pgrXqUk3jlya49xueI6F21dP0rlgkOqgiOW8zcQ3Inx620DbU3AKBINPEKY/k+1HD8VA
         R5zg==
X-Gm-Message-State: AOJu0Yx0lB8Fb7kgz/V2EM9aUtai0tiwSXaXgDCizYtVXC4vYY1FMu6C
	xcMMjP0bJHAz9/3Y8eluGis=
X-Google-Smtp-Source: AGHT+IHmRUTvjhJizR+rVPDRrR+qndTc3DB+n/QKOaMSg6rkG22vq1dsS3HcwkvIuDzyxRUEbVpG0g==
X-Received: by 2002:a05:6a20:e11c:b0:128:ffb7:dcfe with SMTP id kr28-20020a056a20e11c00b00128ffb7dcfemr1503563pzb.1.1699670995230;
        Fri, 10 Nov 2023 18:49:55 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78108000000b006babcf86b84sm406810pfi.34.2023.11.10.18.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH 31/36] sched_ext: Implement core-sched support
Date: Fri, 10 Nov 2023 16:47:57 -1000
Message-ID: <20231111024835.2164816-32-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core-sched support is composed of the following parts:

* task_struct->scx.core_sched_at is added. This is a timestamp which can be
  used to order tasks. Depending on whether the BPF scheduler implements
  custom ordering, it tracks either global FIFO ordering of all tasks or
  local-DSQ ordering within the dispatched tasks on a CPU.

* prio_less() is updated to call scx_prio_less() when comparing SCX tasks.
  scx_prio_less() calls ops.core_sched_before() if available or uses the
  core_sched_at timestamp. For global FIFO ordering, the BPF scheduler
  doesn't need to do anything. Otherwise, it should implement
  ops.core_sched_before() which reflects the ordering.

* When core-sched is enabled, balance_scx() balances all SMT siblings so
  that they all have tasks dispatched if necessary before pick_task_scx() is
  called. pick_task_scx() picks between the current task and the first
  dispatched task on the local DSQ based on availability and the
  core_sched_at timestamps. Note that FIFO ordering is expected among the
  already dispatched tasks whether running or on the local DSQ, so this path
  always compares core_sched_at instead of calling into
  ops.core_sched_before().

qmap_core_sched_before() is added to scx_qmap. It scales the
distances from the heads of the queues to compare the tasks across different
priority queues and seems to behave as expected.

v3: * Fixed build error when !CONFIG_SCHED_SMT reported by Andrea Righi.

v2: * Sched core added the const qualifiers to prio_less task arguments.
      Explicitly drop them for ops.core_sched_before() task arguments. BPF
      enforces access control through the verifier, so the qualifier isn't
      actually operative and only gets in the way when interacting with
      various helpers.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Reviewed-by: Josh Don <joshdon@google.com>
Cc: Andrea Righi <andrea.righi@canonical.com>
---
 include/linux/sched/ext.h      |  21 ++++
 kernel/Kconfig.preempt         |   2 +-
 kernel/sched/core.c            |  10 +-
 kernel/sched/ext.c             | 220 +++++++++++++++++++++++++++++++--
 kernel/sched/ext.h             |  13 ++
 tools/sched_ext/scx_qmap.bpf.c |  87 ++++++++++++-
 tools/sched_ext/scx_qmap.c     |   5 +-
 7 files changed, 341 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 98b0f20a7c1d..1ce5d131e97b 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -316,6 +316,24 @@ struct sched_ext_ops {
 	 */
 	bool (*yield)(struct task_struct *from, struct task_struct *to);
 
+	/**
+	 * core_sched_before - Task ordering for core-sched
+	 * @a: task A
+	 * @b: task B
+	 *
+	 * Used by core-sched to determine the ordering between two tasks. See
+	 * Documentation/admin-guide/hw-vuln/core-scheduling.rst for details on
+	 * core-sched.
+	 *
+	 * Both @a and @b are runnable and may or may not currently be queued on
+	 * the BPF scheduler. Should return %true if @a should run before @b.
+	 * %false if there's no required ordering or @b should run before @a.
+	 *
+	 * If not specified, the default is ordering them according to when they
+	 * became runnable.
+	 */
+	bool (*core_sched_before)(struct task_struct *a,struct task_struct *b);
+
 	/**
 	 * set_weight - Set task weight
 	 * @p: task to set weight for
@@ -628,6 +646,9 @@ struct sched_ext_entity {
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 	atomic_long_t		ops_state;
 	unsigned long		runnable_at;
+#ifdef CONFIG_SCHED_CORE
+	u64			core_sched_at;	/* see scx_prio_less() */
+#endif
 
 	/* BPF scheduler modifiable fields */
 
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 0afcda19bc50..e12a057ead7b 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -135,7 +135,7 @@ config SCHED_CORE
 
 config SCHED_CLASS_EXT
 	bool "Extensible Scheduling Class"
-	depends on BPF_SYSCALL && BPF_JIT && !SCHED_CORE
+	depends on BPF_SYSCALL && BPF_JIT
 	help
 	  This option enables a new scheduler class sched_ext (SCX), which
 	  allows scheduling policies to be implemented as BPF programs to
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9fe1a224c888..8ef96acecef1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -167,7 +167,10 @@ static inline int __task_prio(const struct task_struct *p)
 	if (p->sched_class == &idle_sched_class)
 		return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
 
-	return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
+	if (task_on_scx(p))
+		return MAX_RT_PRIO + MAX_NICE + 1; /* 120, squash ext */
+
+	return MAX_RT_PRIO + MAX_NICE; /* 119, squash fair */
 }
 
 /*
@@ -196,6 +199,11 @@ static inline bool prio_less(const struct task_struct *a,
 	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
 		return cfs_prio_less(a, b, in_fi);
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (pa == MAX_RT_PRIO + MAX_NICE + 1)	/* ext */
+		return scx_prio_less(a, b, in_fi);
+#endif
+
 	return false;
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 51078fab6df3..6ba5cef20803 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -540,6 +540,49 @@ static int ops_sanitize_err(const char *ops_name, s32 err)
 	return -EPROTO;
 }
 
+/**
+ * touch_core_sched - Update timestamp used for core-sched task ordering
+ * @rq: rq to read clock from, must be locked
+ * @p: task to update the timestamp for
+ *
+ * Update @p->scx.core_sched_at timestamp. This is used by scx_prio_less() to
+ * implement global or local-DSQ FIFO ordering for core-sched. Should be called
+ * when a task becomes runnable and its turn on the CPU ends (e.g. slice
+ * exhaustion).
+ */
+static void touch_core_sched(struct rq *rq, struct task_struct *p)
+{
+#ifdef CONFIG_SCHED_CORE
+	/*
+	 * It's okay to update the timestamp spuriously. Use
+	 * sched_core_disabled() which is cheaper than enabled().
+	 */
+	if (!sched_core_disabled())
+		p->scx.core_sched_at = rq_clock_task(rq);
+#endif
+}
+
+/**
+ * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
+ * @rq: rq to read clock from, must be locked
+ * @p: task being dispatched
+ *
+ * If the BPF scheduler implements custom core-sched ordering via
+ * ops.core_sched_before(), @p->scx.core_sched_at is used to implement FIFO
+ * ordering within each local DSQ. This function is called from dispatch paths
+ * and updates @p->scx.core_sched_at if custom core-sched ordering is in effect.
+ */
+static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
+{
+	lockdep_assert_rq_held(rq);
+	assert_clock_updated(rq);
+
+#ifdef CONFIG_SCHED_CORE
+	if (SCX_HAS_OP(core_sched_before))
+		touch_core_sched(rq, p);
+#endif
+}
+
 static void update_curr_scx(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
@@ -555,8 +598,11 @@ static void update_curr_scx(struct rq *rq)
 	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
 
-	if (curr->scx.slice != SCX_SLICE_INF)
+	if (curr->scx.slice != SCX_SLICE_INF) {
 		curr->scx.slice -= min(curr->scx.slice, delta_exec);
+		if (!curr->scx.slice)
+			touch_core_sched(rq, curr);
+	}
 }
 
 static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
@@ -712,6 +758,8 @@ static void direct_dispatch(struct task_struct *ddsp_task, struct task_struct *p
 		return;
 	}
 
+	touch_core_sched_dispatch(task_rq(p), p);
+
 	dsq = find_dsq_for_dispatch(task_rq(p), dsq_id, p);
 	dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 
@@ -795,12 +843,19 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	return;
 
 local:
+	/*
+	 * For task-ordering, slice refill must be treated as implying the end
+	 * of the current slice. Otherwise, the longer @p stays on the CPU, the
+	 * higher priority it becomes from scx_prio_less()'s POV.
+	 */
+	touch_core_sched(rq, p);
 	p->scx.slice = SCX_SLICE_DFL;
 local_norefill:
 	dispatch_enqueue(&rq->scx.local_dsq, p, enq_flags);
 	return;
 
 global:
+	touch_core_sched(rq, p);	/* see the comment in local: */
 	p->scx.slice = SCX_SLICE_DFL;
 	dispatch_enqueue(&scx_dsq_global, p, enq_flags);
 }
@@ -857,6 +912,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (SCX_HAS_OP(runnable))
 		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
 
+	if (enq_flags & SCX_ENQ_WAKEUP)
+		touch_core_sched(rq, p);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 }
 
@@ -1308,6 +1366,7 @@ static void finish_dispatch(struct rq *rq, struct rq_flags *rf,
 	struct scx_dispatch_q *dsq;
 	unsigned long opss;
 
+	touch_core_sched_dispatch(rq, p);
 retry:
 	/*
 	 * No need for _acquire here. @p is accessed only after a successful
@@ -1385,8 +1444,8 @@ static void flush_dispatch_buf(struct rq *rq, struct rq_flags *rf)
 	dspc->buf_cursor = 0;
 }
 
-static int balance_scx(struct rq *rq, struct task_struct *prev,
-		       struct rq_flags *rf)
+static int balance_one(struct rq *rq, struct task_struct *prev,
+		       struct rq_flags *rf, bool local)
 {
 	struct scx_rq *scx_rq = &rq->scx;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
@@ -1410,7 +1469,7 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	}
 
 	if (prev_on_scx) {
-		WARN_ON_ONCE(prev->scx.flags & SCX_TASK_BAL_KEEP);
+		WARN_ON_ONCE(local && (prev->scx.flags & SCX_TASK_BAL_KEEP));
 		update_curr_scx(rq);
 
 		/*
@@ -1422,10 +1481,16 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 		 *
 		 * See scx_ops_disable_workfn() for the explanation on the
 		 * disabling() test.
+		 *
+		 * When balancing a remote CPU for core-sched, there won't be a
+		 * following put_prev_task_scx() call and we don't own
+		 * %SCX_TASK_BAL_KEEP. Instead, pick_task_scx() will test the
+		 * same conditions later and pick @rq->curr accordingly.
 		 */
 		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 		    prev->scx.slice && !scx_ops_disabling()) {
-			prev->scx.flags |= SCX_TASK_BAL_KEEP;
+			if (local)
+				prev->scx.flags |= SCX_TASK_BAL_KEEP;
 			return 1;
 		}
 	}
@@ -1481,10 +1546,56 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	return 0;
 }
 
+static int balance_scx(struct rq *rq, struct task_struct *prev,
+		       struct rq_flags *rf)
+{
+	int ret;
+
+	ret = balance_one(rq, prev, rf, true);
+
+#ifdef CONFIG_SCHED_SMT
+	/*
+	 * When core-sched is enabled, this ops.balance() call will be followed
+	 * by put_prev_scx() and pick_task_scx() on this CPU and pick_task_scx()
+	 * on the SMT siblings. Balance the siblings too.
+	 */
+	if (sched_core_enabled(rq)) {
+		const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
+		int scpu;
+
+		for_each_cpu_andnot(scpu, smt_mask, cpumask_of(cpu_of(rq))) {
+			struct rq *srq = cpu_rq(scpu);
+			struct rq_flags srf;
+			struct task_struct *sprev = srq->curr;
+
+			/*
+			 * While core-scheduling, rq lock is shared among
+			 * siblings but the debug annotations and rq clock
+			 * aren't. Do pinning dance to transfer the ownership.
+			 */
+			WARN_ON_ONCE(__rq_lockp(rq) != __rq_lockp(srq));
+			rq_unpin_lock(rq, rf);
+			rq_pin_lock(srq, &srf);
+
+			update_rq_clock(srq);
+			balance_one(srq, sprev, &srf, false);
+
+			rq_unpin_lock(srq, &srf);
+			rq_repin_lock(rq, rf);
+		}
+	}
+#endif
+	return ret;
+}
+
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	if (p->scx.flags & SCX_TASK_QUEUED) {
-		WARN_ON_ONCE(atomic64_read(&p->scx.ops_state) != SCX_OPSS_NONE);
+		/*
+		 * Core-sched might decide to execute @p before it is
+		 * dispatched. Call ops_dequeue() to notify the BPF scheduler.
+		 */
+		ops_dequeue(p, SCX_DEQ_CORE_SCHED_EXEC);
 		dispatch_dequeue(&rq->scx, p);
 	}
 
@@ -1567,7 +1678,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 		/*
 		 * If @p has slice left and balance_scx() didn't tag it for
 		 * keeping, @p is getting preempted by a higher priority
-		 * scheduler class. Leave it at the head of the local DSQ.
+		 * scheduler class or core-sched forcing a different task. Leave
+		 * it at the head of the local DSQ.
 		 */
 		if (p->scx.slice && !scx_ops_disabling()) {
 			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
@@ -1624,6 +1736,84 @@ static struct task_struct *pick_next_task_scx(struct rq *rq)
 	return p;
 }
 
+#ifdef CONFIG_SCHED_CORE
+/**
+ * scx_prio_less - Task ordering for core-sched
+ * @a: task A
+ * @b: task B
+ *
+ * Core-sched is implemented as an additional scheduling layer on top of the
+ * usual sched_class'es and needs to find out the expected task ordering. For
+ * SCX, core-sched calls this function to interrogate the task ordering.
+ *
+ * Unless overridden by ops.core_sched_before(), @p->scx.core_sched_at is used
+ * to implement the default task ordering. The older the timestamp, the higher
+ * prority the task - the global FIFO ordering matching the default scheduling
+ * behavior.
+ *
+ * When ops.core_sched_before() is enabled, @p->scx.core_sched_at is used to
+ * implement FIFO ordering within each local DSQ. See pick_task_scx().
+ */
+bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
+		   bool in_fi)
+{
+	/*
+	 * The const qualifiers are dropped from task_struct pointers when
+	 * calling ops.core_sched_before(). Accesses are controlled by the
+	 * verifier.
+	 */
+	if (SCX_HAS_OP(core_sched_before) && !scx_ops_disabling())
+		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, core_sched_before,
+					      (struct task_struct *)a,
+					      (struct task_struct *)b);
+	else
+		return time_after64(a->scx.core_sched_at, b->scx.core_sched_at);
+}
+
+/**
+ * pick_task_scx - Pick a candidate task for core-sched
+ * @rq: rq to pick the candidate task from
+ *
+ * Core-sched calls this function on each SMT sibling to determine the next
+ * tasks to run on the SMT siblings. balance_one() has been called on all
+ * siblings and put_prev_task_scx() has been called only for the current CPU.
+ *
+ * As put_prev_task_scx() hasn't been called on remote CPUs, we can't just look
+ * at the first task in the local dsq. @rq->curr has to be considered explicitly
+ * to mimic %SCX_TASK_BAL_KEEP.
+ */
+static struct task_struct *pick_task_scx(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	struct task_struct *first = first_local_task(rq);
+
+	if (curr->scx.flags & SCX_TASK_QUEUED) {
+		/* is curr the only runnable task? */
+		if (!first)
+			return curr;
+
+		/*
+		 * Does curr trump first? We can always go by core_sched_at for
+		 * this comparison as it represents global FIFO ordering when
+		 * the default core-sched ordering is used and local-DSQ FIFO
+		 * ordering otherwise.
+		 *
+		 * We can have a task with an earlier timestamp on the DSQ. For
+		 * example, when a current task is preempted by a sibling
+		 * picking a different cookie, the task would be requeued at the
+		 * head of the local DSQ with an earlier timestamp than the
+		 * core-sched picked next task. Besides, the BPF scheduler may
+		 * dispatch any tasks to the local DSQ anytime.
+		 */
+		if (curr->scx.slice && time_before64(curr->scx.core_sched_at,
+						     first->scx.core_sched_at))
+			return curr;
+	}
+
+	return first;	/* this may be %NULL */
+}
+#endif	/* CONFIG_SCHED_CORE */
+
 static enum scx_cpu_preempt_reason
 preempt_reason_from_class(const struct sched_class *class)
 {
@@ -1933,11 +2123,13 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	update_curr_scx(rq);
 
 	/*
-	 * While disabling, always resched as we can't trust the slice
-	 * management.
+	 * While disabling, always resched and refresh core-sched timestamp as
+	 * we can't trust the slice management or ops.core_sched_before().
 	 */
-	if (scx_ops_disabling())
+	if (scx_ops_disabling()) {
 		curr->scx.slice = 0;
+		touch_core_sched(rq, curr);
+	}
 
 	if (!curr->scx.slice)
 		resched_curr(rq);
@@ -2399,6 +2591,10 @@ DEFINE_SCHED_CLASS(ext) = {
 	.rq_offline		= rq_offline_scx,
 #endif
 
+#ifdef CONFIG_SCHED_CORE
+	.pick_task		= pick_task_scx,
+#endif
+
 	.task_tick		= task_tick_scx,
 
 	.switching_to		= switching_to_scx,
@@ -2727,9 +2923,11 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	 *
 	 * b. balance_scx() never sets %SCX_TASK_BAL_KEEP as the slice value
 	 *    can't be trusted. Whenever a tick triggers, the running task is
-	 *    rotated to the tail of the queue.
+	 *    rotated to the tail of the queue with core_sched_at touched.
 	 *
 	 * c. pick_next_task() suppresses zero slice warning.
+	 *
+	 * d. scx_prio_less() reverts to the default core_sched_at order.
 	 */
 	scx_ops.enqueue = scx_ops_fallback_enqueue;
 	scx_ops.dispatch = scx_ops_fallback_dispatch;
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 9b8918be5fd4..422aaec9a6dd 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -68,6 +68,14 @@ enum scx_enq_flags {
 enum scx_deq_flags {
 	/* expose select DEQUEUE_* flags as enums */
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
+
+	/* high 32bits are SCX specific */
+
+	/*
+	 * The generic core-sched layer decided to execute the task even though
+	 * it hasn't been dispatched yet. Dequeue from the BPF side.
+	 */
+	SCX_DEQ_CORE_SCHED_EXEC	= 1LLU << 32,
 };
 
 enum scx_pick_idle_cpu_flags {
@@ -193,6 +201,11 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 	for_active_class_range(class, (prev_class) > &ext_sched_class ?		\
 			       &ext_sched_class : (prev_class), (end_class))
 
+#ifdef CONFIG_SCHED_CORE
+bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
+		   bool in_fi);
+#endif
+
 #else	/* CONFIG_SCHED_CLASS_EXT */
 
 #define scx_enabled()		false
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index bfffbfd3368b..b6365df0fb64 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -13,6 +13,7 @@
  * - Sleepable per-task storage allocation using ops.prep_enable().
  * - Using ops.cpu_release() to handle a higher priority scheduling class taking
  *   the CPU away.
+ * - Core-sched support.
  *
  * This scheduler is primarily for demonstration and testing of sched_ext
  * features and unlikely to be useful for actual workloads.
@@ -62,9 +63,21 @@ struct {
 	},
 };
 
+/*
+ * Per-queue sequence numbers to implement core-sched ordering.
+ *
+ * Tail seq is assigned to each queued task and incremented. Head seq tracks the
+ * sequence number of the latest dispatched task. The distance between the a
+ * task's seq and the associated queue's head seq is called the queue distance
+ * and used when comparing two tasks for ordering. See qmap_core_sched_before().
+ */
+static u64 core_sched_head_seqs[5];
+static u64 core_sched_tail_seqs[5];
+
 /* Per-task scheduling context */
 struct task_ctx {
 	bool	force_local;	/* Dispatch directly to local_dsq */
+	u64	core_sched_seq;
 };
 
 struct {
@@ -84,6 +97,7 @@ struct {
 
 /* Statistics */
 unsigned long nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
+unsigned long nr_core_sched_execed;
 
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
@@ -150,8 +164,18 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
-	/* Is select_cpu() is telling us to enqueue locally? */
-	if (tctx->force_local) {
+	/*
+	 * All enqueued tasks must have their core_sched_seq updated for correct
+	 * core-sched ordering, which is why %SCX_OPS_ENQ_LAST is specified in
+	 * qmap_ops.flags.
+	 */
+	tctx->core_sched_seq = core_sched_tail_seqs[idx]++;
+
+	/*
+	 * If qmap_select_cpu() is telling us to or this is the last runnable
+	 * task on the CPU, enqueue locally.
+	 */
+	if (tctx->force_local || (enq_flags & SCX_ENQ_LAST)) {
 		tctx->force_local = false;
 		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
 		return;
@@ -195,6 +219,19 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags)
 {
 	__sync_fetch_and_add(&nr_dequeued, 1);
+	if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC)
+		__sync_fetch_and_add(&nr_core_sched_execed, 1);
+}
+
+static void update_core_sched_head_seq(struct task_struct *p)
+{
+	struct task_ctx *tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	int idx = weight_to_idx(p->scx.weight);
+
+	if (tctx)
+		core_sched_head_seqs[idx] = tctx->core_sched_seq;
+	else
+		scx_bpf_error("task_ctx lookup failed");
 }
 
 void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
@@ -247,6 +284,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 
 			p = bpf_task_from_pid(pid);
 			if (p) {
+				update_core_sched_head_seq(p);
 				__sync_fetch_and_add(&nr_dispatched, 1);
 				scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, slice_ns, 0);
 				bpf_task_release(p);
@@ -258,6 +296,49 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	}
 }
 
+/*
+ * The distance from the head of the queue scaled by the weight of the queue.
+ * The lower the number, the older the task and the higher the priority.
+ */
+static s64 task_qdist(struct task_struct *p)
+{
+	int idx = weight_to_idx(p->scx.weight);
+	struct task_ctx *tctx;
+	s64 qdist;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (!tctx) {
+		scx_bpf_error("task_ctx lookup failed");
+		return 0;
+	}
+
+	qdist = tctx->core_sched_seq - core_sched_head_seqs[idx];
+
+	/*
+	 * As queue index increments, the priority doubles. The queue w/ index 3
+	 * is dispatched twice more frequently than 2. Reflect the difference by
+	 * scaling qdists accordingly. Note that the shift amount needs to be
+	 * flipped depending on the sign to avoid flipping priority direction.
+	 */
+	if (qdist >= 0)
+		return qdist << (4 - idx);
+	else
+		return qdist << idx;
+}
+
+/*
+ * This is called to determine the task ordering when core-sched is picking
+ * tasks to execute on SMT siblings and should encode about the same ordering as
+ * the regular scheduling path. Use the priority-scaled distances from the head
+ * of the queues to compare the two tasks which should be consistent with the
+ * dispatch path behavior.
+ */
+bool BPF_STRUCT_OPS(qmap_core_sched_before,
+		    struct task_struct *a, struct task_struct *b)
+{
+	return task_qdist(a) > task_qdist(b);
+}
+
 void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
 {
 	u32 cnt;
@@ -309,10 +390,12 @@ struct sched_ext_ops qmap_ops = {
 	.enqueue		= (void *)qmap_enqueue,
 	.dequeue		= (void *)qmap_dequeue,
 	.dispatch		= (void *)qmap_dispatch,
+	.core_sched_before	= (void *)qmap_core_sched_before,
 	.cpu_release		= (void *)qmap_cpu_release,
 	.prep_enable		= (void *)qmap_prep_enable,
 	.init			= (void *)qmap_init,
 	.exit			= (void *)qmap_exit,
+	.flags			= SCX_OPS_ENQ_LAST,
 	.timeout_ms		= 5000U,
 	.name			= "qmap",
 };
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index f72a4a5b1dd7..edc3d0a4e800 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -90,9 +90,10 @@ int main(int argc, char **argv)
 		long nr_enqueued = skel->bss->nr_enqueued;
 		long nr_dispatched = skel->bss->nr_dispatched;
 
-		printf("enq=%lu, dsp=%lu, delta=%ld, reenq=%lu, deq=%lu\n",
+		printf("enq=%lu, dsp=%lu, delta=%ld, reenq=%lu, deq=%lu, core=%lu\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
-		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued);
+		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
+		       skel->bss->nr_core_sched_execed);
 		fflush(stdout);
 		sleep(1);
 	}
-- 
2.42.0



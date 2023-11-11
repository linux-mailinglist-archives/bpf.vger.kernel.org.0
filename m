Return-Path: <bpf+bounces-14842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A557E888F
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1121C209A9
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388914414;
	Sat, 11 Nov 2023 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9lBH5JD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F55667
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:50:24 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0945C55A4;
	Fri, 10 Nov 2023 18:49:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc2fc281cdso22992845ad.0;
        Fri, 10 Nov 2023 18:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670997; x=1700275797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Msh4xoutKdHw6wKRyxlar54GGxvyjuIwojsW2bLq1iA=;
        b=Y9lBH5JD8YB6/k299VBZcm8GP8qK99FndqrOk5HLDGfC6J4rGMZ90paGoMYvmz2AyP
         JBgPoBIsRjQN7+3T2EwmBMxY+HXDl24aFzRnwrN1RCmGYF7sxEdGYaRdgTGi6C1jj328
         wZ6+y7sOntxnUrrkUawze+fEzi1Y49883GHnAV/nncRwbMScVrZu7X0TVuwiZw09NI0r
         KmfHI1K03HcMmBK0L7R0EFzrSLfHpunENCiH0q+t07QmY/zghf2o6xGFMwaN0rmJST8E
         cX8NGdltDinR99Ne9xrU/KEH5rj48cL5PouM8r7LTBV9N1dsKewHRgCzOnci/jxIN4ad
         hhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670997; x=1700275797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Msh4xoutKdHw6wKRyxlar54GGxvyjuIwojsW2bLq1iA=;
        b=Z1FDWXIjFv02sBcFBVFBxpmfweoDoU9meMLaF8LCtUefeGHv8frhqJjuTy32xcqzo6
         DKCO2EorxaZEOW1Ky1uqHiQaBW1866TUHtOpcZfe/FahDO4Ib8Py1InWoIsgj5Je0dsF
         hVePVMdQBQiChKRoGgPo3Iwkv4NSMJ5i4pEHqjqrHe31jxtg8chk+yTSpW3kq1etR7Lo
         vvAlvDGsh7FuWS/H2M7YrrA2fR5f5oFP2FaltJXCnzdSvtHr7YOUwpmb24BEUAVrhrJI
         QVGYaq2LUPb3508gOSFfzlUhTSF5Gi1y4701kvMRcivtFccZZjRnejTFSuWHibv/AgZe
         1Fqw==
X-Gm-Message-State: AOJu0YxbBvWnLAaGAmbe5Y+8CEvH1xXGwE23zONIwdhtIlTBm1cWDpgw
	NSfdyiINZdPoeDdpay/HiEA=
X-Google-Smtp-Source: AGHT+IHA+/lx+eQpG1jLC2rNa1yJ98LSWuno9b9MhMxVzscYb+ZOT1jvRBLa09bpo1i9AyvnGRTnKg==
X-Received: by 2002:a17:902:aa08:b0:1cc:6dd5:59e8 with SMTP id be8-20020a170902aa0800b001cc6dd559e8mr970382plb.26.1699670997202;
        Fri, 10 Nov 2023 18:49:57 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id je12-20020a170903264c00b001bde6fa0a39sm351748plb.167.2023.11.10.18.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:56 -0800 (PST)
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
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 32/36] sched_ext: Add vtime-ordered priority queue to dispatch_q's
Date: Fri, 10 Nov 2023 16:47:58 -1000
Message-ID: <20231111024835.2164816-33-tj@kernel.org>
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

Currently, a dsq is always a FIFO. A task which is dispatched earlier gets
consumed or executed earlier. While this is sufficient when dsq's are used
for simple staging areas for tasks which are ready to execute, it'd make
dsq's a lot more useful if they can implement custom ordering.

This patch adds a vtime-ordered priority queue to dsq's. When the BPF
scheduler dispatches a task with the new scx_bpf_dispatch_vtime() helper, it
can specify the vtime tha the task should be inserted at and the task is
inserted into the priority queue in the dsq which is ordered according to
time_before64() comparison of the vtime values. When executing or consuming
the dsq, the FIFO is always processed first and the priority queue is
processed iff the FIFO is empty.

The design decision was made to allow both FIFO and priority queue to be
available at the same timeq for all dsq's for three reasons. First, the new
priority queue is useful for the local dsq's too but they also need the FIFO
when consuming tasks from other dsq's as the vtimes may not be comparable
across them. Second, the interface surface is smaller this way - the only
additional interface necessary is scx_bpf_dispsatch_vtime(). Third, the
overhead isn't meaningfully different whether they're available at the same
time or not.

This makes it very easy for the BPF schedulers to implement proper vtime
based scheduling within each dsq very easy and efficient at a negligible
cost in terms of code complexity and overhead.

scx_simple and scx_example_flatcg are updated to default to weighted
vtime scheduling (the latter within each cgroup). FIFO scheduling can be
selected with -f option.

v3: * SCX_TASK_DSQ_ON_PRIQ flag is moved from p->scx.flags into its own
      p->scx.dsq_flags. The flag is protected with the dsq lock unlike other
      flags in p->scx.flags. This led to flag corruption in some cases.

    * Add comments explaining the interaction between using consumption of
      p->scx.slice to determine vtime progress and yielding.

v2: * p->scx.dsq_vtime was not initialized on load or across cgroup
      migrations leading to some tasks being stalled for extended period of
      time depending on how saturated the machine is. Fixed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 include/linux/sched/ext.h        |  21 ++++-
 init/init_task.c                 |   2 +-
 kernel/sched/core.c              |   3 +-
 kernel/sched/ext.c               | 137 +++++++++++++++++++++++++++----
 kernel/sched/ext.h               |   1 +
 tools/sched_ext/scx_common.bpf.h |   1 +
 tools/sched_ext/scx_flatcg.bpf.c |  80 +++++++++++++++++-
 tools/sched_ext/scx_flatcg.c     |   6 +-
 tools/sched_ext/scx_simple.bpf.c |  81 +++++++++++++++++-
 tools/sched_ext/scx_simple.c     |   8 +-
 10 files changed, 314 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1ce5d131e97b..cdc7a05208da 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -583,6 +583,7 @@ struct sched_ext_ops {
 struct scx_dispatch_q {
 	raw_spinlock_t		lock;
 	struct list_head	fifo;	/* processed in dispatching order */
+	struct rb_root_cached	priq;	/* processed in p->scx.dsq_vtime order */
 	u32			nr;
 	u64			id;
 	struct rhash_head	hash_node;
@@ -605,6 +606,11 @@ enum scx_ent_flags {
 	SCX_TASK_CURSOR		= 1 << 31, /* iteration cursor, not a task */
 };
 
+/* scx_entity.dsq_flags */
+enum scx_ent_dsq_flags {
+	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
+};
+
 /*
  * Mask bits for scx_entity.kf_mask. Not all kfuncs can be called from
  * everywhere and the following bits track which kfunc sets are currently
@@ -636,9 +642,13 @@ enum scx_kf_mask {
  */
 struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
-	struct list_head	dsq_node;
+	struct {
+		struct list_head	fifo;	/* dispatch order */
+		struct rb_node		priq;	/* p->scx.dsq_vtime order */
+	} dsq_node;
 	struct list_head	watchdog_node;
 	u32			flags;		/* protected by rq lock */
+	u32			dsq_flags;	/* protected by dsq lock */
 	u32			weight;
 	s32			sticky_cpu;
 	s32			holding_cpu;
@@ -664,6 +674,15 @@ struct sched_ext_entity {
 	 */
 	u64			slice;
 
+	/*
+	 * Used to order tasks when dispatching to the vtime-ordered priority
+	 * queue of a dsq. This is usually set through scx_bpf_dispatch_vtime()
+	 * but can also be modified directly by the BPF scheduler. Modifying it
+	 * while a task is queued on a dsq may mangle the ordering and is not
+	 * recommended.
+	 */
+	u64			dsq_vtime;
+
 	/*
 	 * If set, reject future sched_setscheduler(2) calls updating the policy
 	 * to %SCHED_EXT with -%EACCES.
diff --git a/init/init_task.c b/init/init_task.c
index aedce50b363d..20fa6efc07f2 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -106,7 +106,7 @@ struct task_struct init_task
 #endif
 #ifdef CONFIG_SCHED_CLASS_EXT
 	.scx		= {
-		.dsq_node	= LIST_HEAD_INIT(init_task.scx.dsq_node),
+		.dsq_node.fifo	= LIST_HEAD_INIT(init_task.scx.dsq_node.fifo),
 		.watchdog_node	= LIST_HEAD_INIT(init_task.scx.watchdog_node),
 		.sticky_cpu	= -1,
 		.holding_cpu	= -1,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8ef96acecef1..e02e4e8c171c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4553,7 +4553,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 	p->scx.dsq		= NULL;
-	INIT_LIST_HEAD(&p->scx.dsq_node);
+	INIT_LIST_HEAD(&p->scx.dsq_node.fifo);
+	RB_CLEAR_NODE(&p->scx.dsq_node.priq);
 	INIT_LIST_HEAD(&p->scx.watchdog_node);
 	p->scx.flags		= 0;
 	p->scx.weight		= 0;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6ba5cef20803..460310fcfbbb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -605,12 +605,25 @@ static void update_curr_scx(struct rq *rq)
 	}
 }
 
+static bool scx_dsq_priq_less(struct rb_node *node_a,
+			      const struct rb_node *node_b)
+{
+	const struct task_struct *a =
+		container_of(node_a, struct task_struct, scx.dsq_node.priq);
+	const struct task_struct *b =
+		container_of(node_b, struct task_struct, scx.dsq_node.priq);
+
+	return time_before64(a->scx.dsq_vtime, b->scx.dsq_vtime);
+}
+
 static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 			     u64 enq_flags)
 {
 	bool is_local = dsq->id == SCX_DSQ_LOCAL;
 
-	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_node));
+	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_node.fifo));
+	WARN_ON_ONCE((p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) ||
+		     !RB_EMPTY_NODE(&p->scx.dsq_node.priq));
 
 	if (!is_local) {
 		raw_spin_lock(&dsq->lock);
@@ -623,10 +636,16 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 		}
 	}
 
-	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
-		list_add(&p->scx.dsq_node, &dsq->fifo);
-	else
-		list_add_tail(&p->scx.dsq_node, &dsq->fifo);
+	if (enq_flags & SCX_ENQ_DSQ_PRIQ) {
+		p->scx.dsq_flags |= SCX_TASK_DSQ_ON_PRIQ;
+		rb_add_cached(&p->scx.dsq_node.priq, &dsq->priq,
+			      scx_dsq_priq_less);
+	} else {
+		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+			list_add(&p->scx.dsq_node.fifo, &dsq->fifo);
+		else
+			list_add_tail(&p->scx.dsq_node.fifo, &dsq->fifo);
+	}
 	dsq->nr++;
 	p->scx.dsq = dsq;
 
@@ -655,13 +674,31 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 	}
 }
 
+static void task_unlink_from_dsq(struct task_struct *p,
+				 struct scx_dispatch_q *dsq)
+{
+	if (p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) {
+		rb_erase_cached(&p->scx.dsq_node.priq, &dsq->priq);
+		RB_CLEAR_NODE(&p->scx.dsq_node.priq);
+		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
+	} else {
+		list_del_init(&p->scx.dsq_node.fifo);
+	}
+}
+
+static bool task_linked_on_dsq(struct task_struct *p)
+{
+	return !list_empty(&p->scx.dsq_node.fifo) ||
+		!RB_EMPTY_NODE(&p->scx.dsq_node.priq);
+}
+
 static void dispatch_dequeue(struct scx_rq *scx_rq, struct task_struct *p)
 {
 	struct scx_dispatch_q *dsq = p->scx.dsq;
 	bool is_local = dsq == &scx_rq->local_dsq;
 
 	if (!dsq) {
-		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
+		WARN_ON_ONCE(task_linked_on_dsq(p));
 		/*
 		 * When dispatching directly from the BPF scheduler to a local
 		 * DSQ, the task isn't associated with any DSQ but
@@ -682,8 +719,8 @@ static void dispatch_dequeue(struct scx_rq *scx_rq, struct task_struct *p)
 	*/
 	if (p->scx.holding_cpu < 0) {
 		/* @p must still be on @dsq, dequeue */
-		WARN_ON_ONCE(list_empty(&p->scx.dsq_node));
-		list_del_init(&p->scx.dsq_node);
+		WARN_ON_ONCE(!task_linked_on_dsq(p));
+		task_unlink_from_dsq(p, dsq);
 		dsq->nr--;
 	} else {
 		/*
@@ -692,7 +729,7 @@ static void dispatch_dequeue(struct scx_rq *scx_rq, struct task_struct *p)
 		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
 		 * the race.
 		 */
-		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
+		WARN_ON_ONCE(task_linked_on_dsq(p));
 		p->scx.holding_cpu = -1;
 	}
 	p->scx.dsq = NULL;
@@ -1156,33 +1193,52 @@ static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq_flags *rf,
 #endif	/* CONFIG_SMP */
 
 
+static bool task_can_run_on_rq(struct task_struct *p, struct rq *rq)
+{
+	return likely(test_rq_online(rq)) && !is_migration_disabled(p) &&
+		cpumask_test_cpu(cpu_of(rq), p->cpus_ptr);
+}
+
 static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
 			       struct scx_dispatch_q *dsq)
 {
 	struct scx_rq *scx_rq = &rq->scx;
 	struct task_struct *p;
+	struct rb_node *rb_node;
 	struct rq *task_rq;
 	bool moved = false;
 retry:
-	if (list_empty(&dsq->fifo))
+	if (list_empty(&dsq->fifo) && !rb_first_cached(&dsq->priq))
 		return false;
 
 	raw_spin_lock(&dsq->lock);
-	list_for_each_entry(p, &dsq->fifo, scx.dsq_node) {
+
+	list_for_each_entry(p, &dsq->fifo, scx.dsq_node.fifo) {
+		task_rq = task_rq(p);
+		if (rq == task_rq)
+			goto this_rq;
+		if (task_can_run_on_rq(p, rq))
+			goto remote_rq;
+	}
+
+	for (rb_node = rb_first_cached(&dsq->priq); rb_node;
+	     rb_node = rb_next(rb_node)) {
+		p = container_of(rb_node, struct task_struct, scx.dsq_node.priq);
 		task_rq = task_rq(p);
 		if (rq == task_rq)
 			goto this_rq;
-		if (likely(test_rq_online(rq)) && !is_migration_disabled(p) &&
-		    cpumask_test_cpu(cpu_of(rq), p->cpus_ptr))
+		if (task_can_run_on_rq(p, rq))
 			goto remote_rq;
 	}
+
 	raw_spin_unlock(&dsq->lock);
 	return false;
 
 this_rq:
 	/* @dsq is locked and @p is on this rq */
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	list_move_tail(&p->scx.dsq_node, &scx_rq->local_dsq.fifo);
+	task_unlink_from_dsq(p, dsq);
+	list_add_tail(&p->scx.dsq_node.fifo, &scx_rq->local_dsq.fifo);
 	dsq->nr--;
 	scx_rq->local_dsq.nr++;
 	p->scx.dsq = &scx_rq->local_dsq;
@@ -1199,7 +1255,7 @@ static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
 	 * move_task_to_local_dsq().
 	 */
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	list_del_init(&p->scx.dsq_node);
+	task_unlink_from_dsq(p, dsq);
 	dsq->nr--;
 	p->scx.holding_cpu = raw_smp_processor_id();
 	raw_spin_unlock(&dsq->lock);
@@ -1704,8 +1760,18 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 
 static struct task_struct *first_local_task(struct rq *rq)
 {
-	return list_first_entry_or_null(&rq->scx.local_dsq.fifo,
-					struct task_struct, scx.dsq_node);
+	struct rb_node *rb_node;
+
+	if (!list_empty(&rq->scx.local_dsq.fifo))
+		return list_first_entry(&rq->scx.local_dsq.fifo,
+					struct task_struct, scx.dsq_node.fifo);
+
+	rb_node = rb_first_cached(&rq->scx.local_dsq.priq);
+	if (rb_node)
+		return container_of(rb_node,
+				    struct task_struct, scx.dsq_node.priq);
+
+	return NULL;
 }
 
 static struct task_struct *pick_next_task_scx(struct rq *rq)
@@ -3412,6 +3478,9 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		if (off >= offsetof(struct task_struct, scx.slice) &&
 		    off + size <= offsetofend(struct task_struct, scx.slice))
 			return SCALAR_VALUE;
+		if (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
+		    off + size <= offsetofend(struct task_struct, scx.dsq_vtime))
+			return SCALAR_VALUE;
 		if (off >= offsetof(struct task_struct, scx.disallow) &&
 		    off + size <= offsetofend(struct task_struct, scx.disallow))
 			return SCALAR_VALUE;
@@ -3854,8 +3923,42 @@ void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
 	scx_dispatch_commit(p, dsq_id, enq_flags);
 }
 
+/**
+ * scx_bpf_dispatch_vtime - Dispatch a task into the vtime priority queue of a DSQ
+ * @p: task_struct to dispatch
+ * @dsq_id: DSQ to dispatch to
+ * @slice: duration @p can run for in nsecs
+ * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
+ * @enq_flags: SCX_ENQ_*
+ *
+ * Dispatch @p into the vtime priority queue of the DSQ identified by @dsq_id.
+ * Tasks queued into the priority queue are ordered by @vtime and always
+ * consumed after the tasks in the FIFO queue. All other aspects are identical
+ * to scx_bpf_dispatch().
+ *
+ * @vtime ordering is according to time_before64() which considers wrapping. A
+ * numerically larger vtime may indicate an earlier position in the ordering and
+ * vice-versa.
+ */
+void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice,
+			    u64 vtime, u64 enq_flags)
+{
+	if (!scx_dispatch_preamble(p, enq_flags))
+		return;
+
+	if (slice)
+		p->scx.slice = slice;
+	else
+		p->scx.slice = p->scx.slice ?: 1;
+
+	p->scx.dsq_vtime = vtime;
+
+	scx_dispatch_commit(p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+}
+
 BTF_SET8_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
 BTF_SET8_END(scx_kfunc_ids_enqueue_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 422aaec9a6dd..0dea72f25a37 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -63,6 +63,7 @@ enum scx_enq_flags {
 	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
 
 	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
+	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
 };
 
 enum scx_deq_flags {
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index 59362d05110f..5c503c235836 100644
--- a/tools/sched_ext/scx_common.bpf.h
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -58,6 +58,7 @@ s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym;
+void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index ab7cff4da7da..2db3d8d45e68 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -38,6 +38,10 @@
  * this isn't a real concern especially given the performance gain. Also, there
  * are ways to mitigate the problem further by e.g. introducing an extra
  * scheduling layer on cgroup delegation boundaries.
+ *
+ * The scheduler first picks the cgroup to run and then schedule the tasks
+ * within by using nested weighted vtime scheduling by default. The
+ * cgroup-internal scheduling can be switched to FIFO with the -f option.
  */
 #include "scx_common.bpf.h"
 #include "user_exit_info.h"
@@ -47,6 +51,7 @@ char _license[] SEC("license") = "GPL";
 
 const volatile u32 nr_cpus = 32;	/* !0 for veristat, set during init */
 const volatile u64 cgrp_slice_ns = SCX_SLICE_DFL;
+const volatile bool fifo_sched;
 const volatile bool switch_partial;
 
 u64 cvtime_now;
@@ -350,7 +355,21 @@ void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
 	if (!cgc)
 		goto out_release;
 
-	scx_bpf_dispatch(p, cgrp->kn->id, SCX_SLICE_DFL, enq_flags);
+	if (fifo_sched) {
+		scx_bpf_dispatch(p, cgrp->kn->id, SCX_SLICE_DFL, enq_flags);
+	} else {
+		u64 tvtime = p->scx.dsq_vtime;
+
+		/*
+		 * Limit the amount of budget that an idling task can accumulate
+		 * to one slice.
+		 */
+		if (vtime_before(tvtime, cgc->tvtime_now - SCX_SLICE_DFL))
+			tvtime = cgc->tvtime_now - SCX_SLICE_DFL;
+
+		scx_bpf_dispatch_vtime(p, cgrp->kn->id, SCX_SLICE_DFL,
+				       tvtime, enq_flags);
+	}
 
 	cgrp_enqueued(cgrp, cgc);
 out_release:
@@ -462,12 +481,48 @@ void BPF_STRUCT_OPS(fcg_runnable, struct task_struct *p, u64 enq_flags)
 	bpf_cgroup_release(cgrp);
 }
 
+void BPF_STRUCT_OPS(fcg_running, struct task_struct *p)
+{
+	struct cgroup *cgrp;
+	struct fcg_cgrp_ctx *cgc;
+
+	if (fifo_sched)
+		return;
+
+	cgrp = scx_bpf_task_cgroup(p);
+	cgc = find_cgrp_ctx(cgrp);
+	if (cgc) {
+		/*
+		 * @cgc->tvtime_now always progresses forward as tasks start
+		 * executing. The test and update can be performed concurrently
+		 * from multiple CPUs and thus racy. Any error should be
+		 * contained and temporary. Let's just live with it.
+		 */
+		if (vtime_before(cgc->tvtime_now, p->scx.dsq_vtime))
+			cgc->tvtime_now = p->scx.dsq_vtime;
+	}
+	bpf_cgroup_release(cgrp);
+}
+
 void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
 {
 	struct fcg_task_ctx *taskc;
 	struct cgroup *cgrp;
 	struct fcg_cgrp_ctx *cgc;
 
+	/*
+	 * Scale the execution time by the inverse of the weight and charge.
+	 *
+	 * Note that the default yield implementation yields by setting
+	 * @p->scx.slice to zero and the following would treat the yielding task
+	 * as if it has consumed all its slice. If this penalizes yielding tasks
+	 * too much, determine the execution time by taking explicit timestamps
+	 * instead of depending on @p->scx.slice.
+	 */
+	if (!fifo_sched)
+		p->scx.dsq_vtime +=
+			(SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+
 	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
 	if (!taskc) {
 		scx_bpf_error("task_ctx lookup failed");
@@ -706,6 +761,7 @@ s32 BPF_STRUCT_OPS(fcg_prep_enable, struct task_struct *p,
 		   struct scx_enable_args *args)
 {
 	struct fcg_task_ctx *taskc;
+	struct fcg_cgrp_ctx *cgc;
 
 	/*
 	 * @p is new. Let's ensure that its task_ctx is available. We can sleep
@@ -717,6 +773,12 @@ s32 BPF_STRUCT_OPS(fcg_prep_enable, struct task_struct *p,
 		return -ENOMEM;
 
 	taskc->bypassed_at = 0;
+
+	if (!(cgc = find_cgrp_ctx(args->cgroup)))
+		return -ENOENT;
+
+	p->scx.dsq_vtime = cgc->tvtime_now;
+
 	return 0;
 }
 
@@ -804,6 +866,20 @@ void BPF_STRUCT_OPS(fcg_cgroup_exit, struct cgroup *cgrp)
 	scx_bpf_destroy_dsq(cgid);
 }
 
+void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
+		    struct cgroup *from, struct cgroup *to)
+{
+	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
+	s64 vtime_delta;
+
+	/* find_cgrp_ctx() triggers scx_ops_error() on lookup failures */
+	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
+		return;
+
+	vtime_delta = p->scx.dsq_vtime - from_cgc->tvtime_now;
+	p->scx.dsq_vtime = to_cgc->tvtime_now + vtime_delta;
+}
+
 s32 BPF_STRUCT_OPS(fcg_init)
 {
 	if (!switch_partial)
@@ -821,12 +897,14 @@ struct sched_ext_ops flatcg_ops = {
 	.enqueue		= (void *)fcg_enqueue,
 	.dispatch		= (void *)fcg_dispatch,
 	.runnable		= (void *)fcg_runnable,
+	.running		= (void *)fcg_running,
 	.stopping		= (void *)fcg_stopping,
 	.quiescent		= (void *)fcg_quiescent,
 	.prep_enable		= (void *)fcg_prep_enable,
 	.cgroup_set_weight	= (void *)fcg_cgroup_set_weight,
 	.cgroup_init		= (void *)fcg_cgroup_init,
 	.cgroup_exit		= (void *)fcg_cgroup_exit,
+	.cgroup_move		= (void *)fcg_cgroup_move,
 	.init			= (void *)fcg_init,
 	.exit			= (void *)fcg_exit,
 	.flags			= SCX_OPS_CGROUP_KNOB_WEIGHT | SCX_OPS_ENQ_EXITING,
diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index f771b14b4e2a..f824c4b3444a 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -25,10 +25,11 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-i INTERVAL] [-p]\n"
+"Usage: %s [-s SLICE_US] [-i INTERVAL] [-f] [-p]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -i INTERVAL   Report interval\n"
+"  -f            Use FIFO scheduling instead of weighted vtime scheduling\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -h            Display this help and exit\n";
 
@@ -145,6 +146,9 @@ int main(int argc, char **argv)
 		case 'd':
 			dump_cgrps = true;
 			break;
+		case 'f':
+			skel->rodata->fifo_sched = true;
+			break;
 		case 'p':
 			skel->rodata->switch_partial = true;
 			break;
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index 6302a4ea9ea5..56b589d7f663 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -2,11 +2,20 @@
 /*
  * A simple scheduler.
  *
- * A simple global FIFO scheduler. It also demonstrates the following niceties.
+ * By default, it operates as a simple global weighted vtime scheduler and can
+ * be switched to FIFO scheduling. It also demonstrates the following niceties.
  *
  * - Statistics tracking how many tasks are queued to local and global dsq's.
  * - Termination notification for userspace.
  *
+ * While very simple, this scheduler should work reasonably well on CPUs with a
+ * uniform L3 cache topology. While preemption is not implemented, the fact that
+ * the scheduling queue is shared across all CPUs means that whatever is at the
+ * front of the queue is likely to be executed fairly quickly given enough
+ * number of CPUs. The FIFO scheduling mode may be beneficial to some workloads
+ * but comes with the usual problems with FIFO scheduling where saturating
+ * threads can easily drown out interactive ones.
+ *
  * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
@@ -15,8 +24,10 @@
 
 char _license[] SEC("license") = "GPL";
 
+const volatile bool fifo_sched;
 const volatile bool switch_partial;
 
+static u64 vtime_now;
 struct user_exit_info uei;
 
 struct {
@@ -33,8 +44,18 @@ static void stat_inc(u32 idx)
 		(*cnt_p)++;
 }
 
+static inline bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
 void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
 {
+	/*
+	 * If scx_select_cpu_dfl() is setting %SCX_ENQ_LOCAL, it indicates that
+	 * running @p on its CPU directly shouldn't affect fairness. Just queue
+	 * it on the local FIFO.
+	 */
 	if (enq_flags & SCX_ENQ_LOCAL) {
 		stat_inc(0);	/* count local queueing */
 		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
@@ -42,7 +63,60 @@ void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
 	}
 
 	stat_inc(1);	/* count global queueing */
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+
+	if (fifo_sched) {
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	} else {
+		u64 vtime = p->scx.dsq_vtime;
+
+		/*
+		 * Limit the amount of budget that an idling task can accumulate
+		 * to one slice.
+		 */
+		if (vtime_before(vtime, vtime_now - SCX_SLICE_DFL))
+			vtime = vtime_now - SCX_SLICE_DFL;
+
+		scx_bpf_dispatch_vtime(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, vtime,
+				       enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(simple_running, struct task_struct *p)
+{
+	if (fifo_sched)
+		return;
+
+	/*
+	 * Global vtime always progresses forward as tasks start executing. The
+	 * test and update can be performed concurrently from multiple CPUs and
+	 * thus racy. Any error should be contained and temporary. Let's just
+	 * live with it.
+	 */
+	if (vtime_before(vtime_now, p->scx.dsq_vtime))
+		vtime_now = p->scx.dsq_vtime;
+}
+
+void BPF_STRUCT_OPS(simple_stopping, struct task_struct *p, bool runnable)
+{
+	if (fifo_sched)
+		return;
+
+	/*
+	 * Scale the execution time by the inverse of the weight and charge.
+	 *
+	 * Note that the default yield implementation yields by setting
+	 * @p->scx.slice to zero and the following would treat the yielding task
+	 * as if it has consumed all its slice. If this penalizes yielding tasks
+	 * too much, determine the execution time by taking explicit timestamps
+	 * instead of depending on @p->scx.slice.
+	 */
+	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+}
+
+void BPF_STRUCT_OPS(simple_enable, struct task_struct *p,
+		    struct scx_enable_args *args)
+{
+	p->scx.dsq_vtime = vtime_now;
 }
 
 s32 BPF_STRUCT_OPS(simple_init)
@@ -60,6 +134,9 @@ void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
 SEC(".struct_ops.link")
 struct sched_ext_ops simple_ops = {
 	.enqueue		= (void *)simple_enqueue,
+	.running		= (void *)simple_running,
+	.stopping		= (void *)simple_stopping,
+	.enable			= (void *)simple_enable,
 	.init			= (void *)simple_init,
 	.exit			= (void *)simple_exit,
 	.name			= "simple",
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index 6116b13d8cff..900f1c3e74ab 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -17,8 +17,9 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-p]\n"
+"Usage: %s [-f] [-p]\n"
 "\n"
+"  -f            Use FIFO scheduling instead of weighted vtime scheduling\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -h            Display this help and exit\n";
 
@@ -63,8 +64,11 @@ int main(int argc, char **argv)
 	skel = scx_simple__open();
 	SCX_BUG_ON(!skel, "Failed to open skel");
 
-	while ((opt = getopt(argc, argv, "ph")) != -1) {
+	while ((opt = getopt(argc, argv, "fph")) != -1) {
 		switch (opt) {
+		case 'f':
+			skel->rodata->fifo_sched = true;
+			break;
 		case 'p':
 			skel->rodata->switch_partial = true;
 			break;
-- 
2.42.0



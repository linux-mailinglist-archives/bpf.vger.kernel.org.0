Return-Path: <bpf+bounces-32462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662090DE54
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E684287847
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692619E7D2;
	Tue, 18 Jun 2024 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar0pDe2U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7B19DF9C;
	Tue, 18 Jun 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745723; cv=none; b=umFGD6F3ZmAaz28b8Vrxm8UGmT3ujs+ZlI5b1an6jIDxLRkvHEWLoZjum49vh8oHhFT1BJsWDto57+ksVFFL2S9ClgrwcddWBHZGxtdl0CRYHlwrX/PpMQyxNQMqpv0fO5tXwBs7hxgyKZmD4Jc/u7U24Xjo4UBYQVZgoRqQXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745723; c=relaxed/simple;
	bh=s2nTD3+8tvk7C/YcjenoQsIjgotJTyupTbAaum9pzy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRn30ZHtzXA0MhtbC+EkSktRp1cwNQPyXvvvvlc8ysCLzqwZ+m5kjuz/pEwgVV6c9bsH3jxtMPvRhUn4keCw/7aplElJ1qO6NtKgy9aMVPRZsL3+o2YRVFd0vaTqGzGsILkWI21BgmkdvPrqjpVxHeVjqXIFNwl68Gu33VnhunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar0pDe2U; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f6a045d476so4635539b3a.1;
        Tue, 18 Jun 2024 14:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745720; x=1719350520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juVrJjLKsirLH4GyAgiqjLIKz9HWxb2Gvk1Ucr/6f2o=;
        b=ar0pDe2U9z7IYTMNrcjwR+/2PZYwxAJI9QXQtqXiRER4wpXQ8Z0/bBBM2dzFgiFGPc
         FafH7GaVlsu18XL4DjrHzzgtSOYomkBV2Dby6NXILEBmWyhkLGobU1C/hvwotKSvBKT5
         Q2HgIcxm61lkRafuFhAHqq3ozyPHFVKMp1lL0RAapQNzYALkI1WVFFZLkjJBAXKTYK4w
         okL7YvH8Vd1QIH32Cv0aaMRklOpmr4DVOfBHw2p4umS+hjfVaVFS9/mI318RA/3IlQ9c
         WZG1+S0PU5tHV0oUSh/Ixkboipyv0+XlonllQe0ophZQiB4l4g3zENRhYK9LpadJwkO2
         Nmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745720; x=1719350520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=juVrJjLKsirLH4GyAgiqjLIKz9HWxb2Gvk1Ucr/6f2o=;
        b=ZessWFKPabsqgeKkbvJqVgKqiN6Fmswi1VUbrt1ME9T6VxUH/0qn734S/ekzr2T4Hw
         xypKrod/9dlSDrj9NLghLqW4Rc3X3eLgHpE2hfHsgSfvlvlIGyfuCLxzt4INCS5n/Ca0
         nmHwX/rjJVLLF4E4DWJ1mzx8Z39xbC0/R+PFd3/ItScJx6wGC370CxYTPtMO64decXNo
         hrfAzugNKdcQvms1ULS6q2DK6L1qn2HvN5OvmzmptxJMIsYhwDmnyjOgpqwwNkijzmG2
         NmLvMdJ4iB2Pzd1W8qfCLPVUWRkFzwFnYf7ojDhYftUktKtRIAX3J/A5LIndrNzVt1kZ
         1E8A==
X-Forwarded-Encrypted: i=1; AJvYcCXbjS463q5lto4LyfmyzkLMOhB8a56UndK+5MrecZ3vC/06NNGuWymc+jE0oBVwIIfRpQwr1vccDr4L7w1LEfOFYBAh
X-Gm-Message-State: AOJu0YwH520pXTPqZ0G4Jl6gDbfPEIbW0g4UddCUK2lCKL6+XSUSRhmN
	n0Eb/AaS41Ag/tcr4uV9GWBpw7XmpXAo4uYgkztvacY/O/AxIM7w
X-Google-Smtp-Source: AGHT+IHVEWuVJ6+NNWTf5L1s9rOLIx2fy7H6vDo6F74aqGjmlM1PJgsI1USQOPVXStajlEgWbIvcqA==
X-Received: by 2002:a05:6a20:3ca8:b0:1af:f8bd:1e4e with SMTP id adf61e73a8af0-1bcbb621263mr827078637.62.1718745719790;
        Tue, 18 Jun 2024 14:21:59 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45ac5f3sm11506733a91.12.2024.06.18.14.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:59 -0700 (PDT)
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
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 28/30] sched_ext: Add vtime-ordered priority queue to dispatch_q's
Date: Tue, 18 Jun 2024 11:17:43 -1000
Message-ID: <20240618212056.2833381-29-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
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
time_before64() comparison of the vtime values.

A DSQ can either be a FIFO or priority queue and automatically switches
between the two depending on whether scx_bpf_dispatch() or
scx_bpf_dispatch_vtime() is used. Using the wrong variant while the DSQ
already has the other type queued is not allowed and triggers an ops error.
Built-in DSQs must always be FIFOs.

This makes it very easy for the BPF schedulers to implement proper vtime
based scheduling within each dsq very easy and efficient at a negligible
cost in terms of code complexity and overhead.

scx_simple and scx_example_flatcg are updated to default to weighted
vtime scheduling (the latter within each cgroup). FIFO scheduling can be
selected with -f option.

v4: - As allowing mixing priority queue and FIFO on the same DSQ sometimes
      led to unexpected starvations, DSQs now error out if both modes are
      used at the same time and the built-in DSQs are no longer allowed to
      be priority queues.

    - Explicit type struct scx_dsq_node added to contain fields needed to be
      linked on DSQs. This will be used to implement stateful iterator.

    - Tasks are now always linked on dsq->list whether the DSQ is in FIFO or
      PRIQ mode. This confines PRIQ related complexities to the enqueue and
      dequeue paths. Other paths only need to look at dsq->list. This will
      also ease implementing BPF iterator.

    - Print p->scx.dsq_flags in debug dump.

v3: - SCX_TASK_DSQ_ON_PRIQ flag is moved from p->scx.flags into its own
      p->scx.dsq_flags. The flag is protected with the dsq lock unlike other
      flags in p->scx.flags. This led to flag corruption in some cases.

    - Add comments explaining the interaction between using consumption of
      p->scx.slice to determine vtime progress and yielding.

v2: - p->scx.dsq_vtime was not initialized on load or across cgroup
      migrations leading to some tasks being stalled for extended period of
      time depending on how saturated the machine is. Fixed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 include/linux/sched/ext.h                |  29 ++++-
 init/init_task.c                         |   2 +-
 kernel/sched/ext.c                       | 156 ++++++++++++++++++++---
 tools/sched_ext/include/scx/common.bpf.h |   1 +
 tools/sched_ext/scx_simple.bpf.c         |  97 +++++++++++++-
 tools/sched_ext/scx_simple.c             |   8 +-
 6 files changed, 267 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 3db7b32b2d1d..9cee193dab19 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -49,12 +49,15 @@ enum scx_dsq_id_flags {
 };
 
 /*
- * Dispatch queue (dsq) is a simple FIFO which is used to buffer between the
- * scheduler core and the BPF scheduler. See the documentation for more details.
+ * A dispatch queue (DSQ) can be either a FIFO or p->scx.dsq_vtime ordered
+ * queue. A built-in DSQ is always a FIFO. The built-in local DSQs are used to
+ * buffer between the scheduler core and the BPF scheduler. See the
+ * documentation for more details.
  */
 struct scx_dispatch_q {
 	raw_spinlock_t		lock;
 	struct list_head	list;	/* tasks in dispatch order */
+	struct rb_root		priq;	/* used to order by p->scx.dsq_vtime */
 	u32			nr;
 	u64			id;
 	struct rhash_head	hash_node;
@@ -86,6 +89,11 @@ enum scx_task_state {
 	SCX_TASK_NR_STATES,
 };
 
+/* scx_entity.dsq_flags */
+enum scx_ent_dsq_flags {
+	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
+};
+
 /*
  * Mask bits for scx_entity.kf_mask. Not all kfuncs can be called from
  * everywhere and the following bits track which kfunc sets are currently
@@ -111,13 +119,19 @@ enum scx_kf_mask {
 	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
 };
 
+struct scx_dsq_node {
+	struct list_head	list;		/* dispatch order */
+	struct rb_node		priq;		/* p->scx.dsq_vtime order */
+	u32			flags;		/* SCX_TASK_DSQ_* flags */
+};
+
 /*
  * The following is embedded in task_struct and contains all fields necessary
  * for a task to be scheduled by SCX.
  */
 struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
-	struct list_head	dsq_node;
+	struct scx_dsq_node	dsq_node;	/* protected by dsq lock */
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
 	s32			sticky_cpu;
@@ -149,6 +163,15 @@ struct sched_ext_entity {
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
index 8a44c932d10f..5726b3a0eea9 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -102,7 +102,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #endif
 #ifdef CONFIG_SCHED_CLASS_EXT
 	.scx		= {
-		.dsq_node	= LIST_HEAD_INIT(init_task.scx.dsq_node),
+		.dsq_node.list	= LIST_HEAD_INIT(init_task.scx.dsq_node.list),
 		.sticky_cpu	= -1,
 		.holding_cpu	= -1,
 		.runnable_node	= LIST_HEAD_INIT(init_task.scx.runnable_node),
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1feb690be9d8..f186c576e7d9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -638,6 +638,7 @@ enum scx_enq_flags {
 	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
 
 	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
+	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
 };
 
 enum scx_deq_flags {
@@ -1351,6 +1352,17 @@ static void update_curr_scx(struct rq *rq)
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
 static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 {
 	/* scx_bpf_dsq_nr_queued() reads ->nr without locking, use WRITE_ONCE() */
@@ -1362,7 +1374,9 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 {
 	bool is_local = dsq->id == SCX_DSQ_LOCAL;
 
-	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_node));
+	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_node.list));
+	WARN_ON_ONCE((p->scx.dsq_node.flags & SCX_TASK_DSQ_ON_PRIQ) ||
+		     !RB_EMPTY_NODE(&p->scx.dsq_node.priq));
 
 	if (!is_local) {
 		raw_spin_lock(&dsq->lock);
@@ -1375,10 +1389,59 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 		}
 	}
 
-	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
-		list_add(&p->scx.dsq_node, &dsq->list);
-	else
-		list_add_tail(&p->scx.dsq_node, &dsq->list);
+	if (unlikely((dsq->id & SCX_DSQ_FLAG_BUILTIN) &&
+		     (enq_flags & SCX_ENQ_DSQ_PRIQ))) {
+		/*
+		 * SCX_DSQ_LOCAL and SCX_DSQ_GLOBAL DSQs always consume from
+		 * their FIFO queues. To avoid confusion and accidentally
+		 * starving vtime-dispatched tasks by FIFO-dispatched tasks, we
+		 * disallow any internal DSQ from doing vtime ordering of
+		 * tasks.
+		 */
+		scx_ops_error("cannot use vtime ordering for built-in DSQs");
+		enq_flags &= ~SCX_ENQ_DSQ_PRIQ;
+	}
+
+	if (enq_flags & SCX_ENQ_DSQ_PRIQ) {
+		struct rb_node *rbp;
+
+		/*
+		 * A PRIQ DSQ shouldn't be using FIFO enqueueing. As tasks are
+		 * linked to both the rbtree and list on PRIQs, this can only be
+		 * tested easily when adding the first task.
+		 */
+		if (unlikely(RB_EMPTY_ROOT(&dsq->priq) &&
+			     !list_empty(&dsq->list)))
+			scx_ops_error("DSQ ID 0x%016llx already had FIFO-enqueued tasks",
+				      dsq->id);
+
+		p->scx.dsq_node.flags |= SCX_TASK_DSQ_ON_PRIQ;
+		rb_add(&p->scx.dsq_node.priq, &dsq->priq, scx_dsq_priq_less);
+
+		/*
+		 * Find the previous task and insert after it on the list so
+		 * that @dsq->list is vtime ordered.
+		 */
+		rbp = rb_prev(&p->scx.dsq_node.priq);
+		if (rbp) {
+			struct task_struct *prev =
+				container_of(rbp, struct task_struct,
+					     scx.dsq_node.priq);
+			list_add(&p->scx.dsq_node.list, &prev->scx.dsq_node.list);
+		} else {
+			list_add(&p->scx.dsq_node.list, &dsq->list);
+		}
+	} else {
+		/* a FIFO DSQ shouldn't be using PRIQ enqueuing */
+		if (unlikely(!RB_EMPTY_ROOT(&dsq->priq)))
+			scx_ops_error("DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
+				      dsq->id);
+
+		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+			list_add(&p->scx.dsq_node.list, &dsq->list);
+		else
+			list_add_tail(&p->scx.dsq_node.list, &dsq->list);
+	}
 
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
@@ -1417,13 +1480,30 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 	}
 }
 
+static void task_unlink_from_dsq(struct task_struct *p,
+				 struct scx_dispatch_q *dsq)
+{
+	if (p->scx.dsq_node.flags & SCX_TASK_DSQ_ON_PRIQ) {
+		rb_erase(&p->scx.dsq_node.priq, &dsq->priq);
+		RB_CLEAR_NODE(&p->scx.dsq_node.priq);
+		p->scx.dsq_node.flags &= ~SCX_TASK_DSQ_ON_PRIQ;
+	}
+
+	list_del_init(&p->scx.dsq_node.list);
+}
+
+static bool task_linked_on_dsq(struct task_struct *p)
+{
+	return !list_empty(&p->scx.dsq_node.list);
+}
+
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 {
 	struct scx_dispatch_q *dsq = p->scx.dsq;
 	bool is_local = dsq == &rq->scx.local_dsq;
 
 	if (!dsq) {
-		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
+		WARN_ON_ONCE(task_linked_on_dsq(p));
 		/*
 		 * When dispatching directly from the BPF scheduler to a local
 		 * DSQ, the task isn't associated with any DSQ but
@@ -1444,8 +1524,8 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	*/
 	if (p->scx.holding_cpu < 0) {
 		/* @p must still be on @dsq, dequeue */
-		WARN_ON_ONCE(list_empty(&p->scx.dsq_node));
-		list_del_init(&p->scx.dsq_node);
+		WARN_ON_ONCE(!task_linked_on_dsq(p));
+		task_unlink_from_dsq(p, dsq);
 		dsq_mod_nr(dsq, -1);
 	} else {
 		/*
@@ -1454,7 +1534,7 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
 		 * the race.
 		 */
-		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
+		WARN_ON_ONCE(task_linked_on_dsq(p));
 		p->scx.holding_cpu = -1;
 	}
 	p->scx.dsq = NULL;
@@ -1949,7 +2029,8 @@ static void consume_local_task(struct rq *rq, struct scx_dispatch_q *dsq,
 
 	/* @dsq is locked and @p is on this rq */
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	list_move_tail(&p->scx.dsq_node, &rq->scx.local_dsq.list);
+	task_unlink_from_dsq(p, dsq);
+	list_add_tail(&p->scx.dsq_node.list, &rq->scx.local_dsq.list);
 	dsq_mod_nr(dsq, -1);
 	dsq_mod_nr(&rq->scx.local_dsq, 1);
 	p->scx.dsq = &rq->scx.local_dsq;
@@ -1992,7 +2073,7 @@ static bool consume_remote_task(struct rq *rq, struct rq_flags *rf,
 	 * move_task_to_local_dsq().
 	 */
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	list_del_init(&p->scx.dsq_node);
+	task_unlink_from_dsq(p, dsq);
 	dsq_mod_nr(dsq, -1);
 	p->scx.holding_cpu = raw_smp_processor_id();
 	raw_spin_unlock(&dsq->lock);
@@ -2024,7 +2105,7 @@ static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
 
 	raw_spin_lock(&dsq->lock);
 
-	list_for_each_entry(p, &dsq->list, scx.dsq_node) {
+	list_for_each_entry(p, &dsq->list, scx.dsq_node.list) {
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
@@ -2543,7 +2624,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 static struct task_struct *first_local_task(struct rq *rq)
 {
 	return list_first_entry_or_null(&rq->scx.local_dsq.list,
-					struct task_struct, scx.dsq_node);
+					struct task_struct, scx.dsq_node.list);
 }
 
 static struct task_struct *pick_next_task_scx(struct rq *rq)
@@ -3225,7 +3306,8 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	 */
 	memset(scx, 0, offsetof(struct sched_ext_entity, tasks_node));
 
-	INIT_LIST_HEAD(&scx->dsq_node);
+	INIT_LIST_HEAD(&scx->dsq_node.list);
+	RB_CLEAR_NODE(&scx->dsq_node.priq);
 	scx->sticky_cpu = -1;
 	scx->holding_cpu = -1;
 	INIT_LIST_HEAD(&scx->runnable_node);
@@ -4070,12 +4152,13 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 	dump_line(s, " %c%c %s[%d] %+ldms",
 		  marker, task_state_to_char(p), p->comm, p->pid,
 		  jiffies_delta_msecs(p->scx.runnable_at, dctx->at_jiffies));
-	dump_line(s, "      scx_state/flags=%u/0x%x ops_state/qseq=%lu/%lu",
+	dump_line(s, "      scx_state/flags=%u/0x%x dsq_flags=0x%x ops_state/qseq=%lu/%lu",
 		  scx_get_task_state(p), p->scx.flags & ~SCX_TASK_STATE_MASK,
-		  ops_state & SCX_OPSS_STATE_MASK,
+		  p->scx.dsq_node.flags, ops_state & SCX_OPSS_STATE_MASK,
 		  ops_state >> SCX_OPSS_QSEQ_SHIFT);
-	dump_line(s, "      sticky/holding_cpu=%d/%d dsq_id=%s",
-		  p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf);
+	dump_line(s, "      sticky/holding_cpu=%d/%d dsq_id=%s dsq_vtime=%llu",
+		  p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf,
+		  p->scx.dsq_vtime);
 	dump_line(s, "      cpus=%*pb", cpumask_pr_args(p->cpus_ptr));
 
 	if (SCX_HAS_OP(dump_task)) {
@@ -4663,6 +4746,9 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		if (off >= offsetof(struct task_struct, scx.slice) &&
 		    off + size <= offsetofend(struct task_struct, scx.slice))
 			return SCALAR_VALUE;
+		if (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
+		    off + size <= offsetofend(struct task_struct, scx.dsq_vtime))
+			return SCALAR_VALUE;
 		if (off >= offsetof(struct task_struct, scx.disallow) &&
 		    off + size <= offsetofend(struct task_struct, scx.disallow))
 			return SCALAR_VALUE;
@@ -5298,10 +5384,44 @@ __bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
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
+__bpf_kfunc void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id,
+					u64 slice, u64 vtime, u64 enq_flags)
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
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 8686f84497db..3fa87084cf17 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -31,6 +31,7 @@ static inline void ___vmlinux_h_sanity_check___(void)
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
 void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym;
+void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index 6bb13a3c801b..ed7e8d535fc5 100644
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
@@ -15,8 +24,20 @@
 
 char _license[] SEC("license") = "GPL";
 
+const volatile bool fifo_sched;
+
+static u64 vtime_now;
 UEI_DEFINE(uei);
 
+/*
+ * Built-in DSQs such as SCX_DSQ_GLOBAL cannot be used as priority queues
+ * (meaning, cannot be dispatched to with scx_bpf_dispatch_vtime()). We
+ * therefore create a separate DSQ with ID 0 that we dispatch to and consume
+ * from. If scx_simple only supported global FIFO scheduling, then we could
+ * just use SCX_DSQ_GLOBAL.
+ */
+#define SHARED_DSQ 0
+
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(u32));
@@ -31,6 +52,11 @@ static void stat_inc(u32 idx)
 		(*cnt_p)++;
 }
 
+static inline bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
 s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
 	bool is_idle = false;
@@ -48,7 +74,69 @@ s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p, s32 prev_cpu, u64 w
 void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
 {
 	stat_inc(1);	/* count global queueing */
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+
+	if (fifo_sched) {
+		scx_bpf_dispatch(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
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
+		scx_bpf_dispatch_vtime(p, SHARED_DSQ, SCX_SLICE_DFL, vtime,
+				       enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(simple_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_consume(SHARED_DSQ);
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
+void BPF_STRUCT_OPS(simple_enable, struct task_struct *p)
+{
+	p->scx.dsq_vtime = vtime_now;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(simple_init)
+{
+	return scx_bpf_create_dsq(SHARED_DSQ, -1);
 }
 
 void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
@@ -59,5 +147,10 @@ void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
 SCX_OPS_DEFINE(simple_ops,
 	       .select_cpu		= (void *)simple_select_cpu,
 	       .enqueue			= (void *)simple_enqueue,
+	       .dispatch		= (void *)simple_dispatch,
+	       .running			= (void *)simple_running,
+	       .stopping		= (void *)simple_stopping,
+	       .enable			= (void *)simple_enable,
+	       .init			= (void *)simple_init,
 	       .exit			= (void *)simple_exit,
 	       .name			= "simple");
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index bead482e1383..76d83199545c 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -17,8 +17,9 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-v]\n"
+"Usage: %s [-f] [-v]\n"
 "\n"
+"  -f            Use FIFO scheduling instead of weighted vtime scheduling\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
 
@@ -70,8 +71,11 @@ int main(int argc, char **argv)
 restart:
 	skel = SCX_OPS_OPEN(simple_ops, scx_simple);
 
-	while ((opt = getopt(argc, argv, "vh")) != -1) {
+	while ((opt = getopt(argc, argv, "fvh")) != -1) {
 		switch (opt) {
+		case 'f':
+			skel->rodata->fifo_sched = true;
+			break;
 		case 'v':
 			verbose = true;
 			break;
-- 
2.45.2



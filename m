Return-Path: <bpf+bounces-14853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CB87E88A7
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BDA1F20F9B
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0975B4414;
	Sat, 11 Nov 2023 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlnhuYeo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607FD5689
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:51:54 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F94EE9;
	Fri, 10 Nov 2023 18:49:32 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc3388621cso28682165ad.1;
        Fri, 10 Nov 2023 18:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670972; x=1700275772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfV1SwPlNPVEaFqeyrr800vsWsGCqz1Q5V4iidPCQ6Q=;
        b=nlnhuYeoFhJbNm6mmOcW68lRG36SJskmWxl4+TKnDBKTaRj1yo6bflGJw3QwBY1QHq
         8VI+0yV7Ni6ojeBW990t5J7U4zKlTJIbKE3aGrN6/2FeQg0EzfPkHi8oLaUgFh7hVBRy
         LByhSrtGk2qG52FeWw31oWIpPQZX0/0hJTJQpkg6NixYwYHDnQrPCnH5uES3n+mAuAQ8
         sO3KvbZZL0NAwqOj4BLwf0jdtuXXeXx4+gsv3Gvz2mukPgP4KmVeSLhztSoqsKo/kHHh
         x6jOybb4gU8CoTI5ckbPCXY+dnDshpk1uN5270vy/CV72fmqghfm51qoYflweGru5fKh
         O1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670972; x=1700275772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BfV1SwPlNPVEaFqeyrr800vsWsGCqz1Q5V4iidPCQ6Q=;
        b=nCJ5Eh1inQripelKbm8+10VjYI3TMov3zibZWZ9xqm4hhdLzEkhvLpq5kXVervEeet
         slt0uabdEbVxO9lgFgqYjGJa4TVuxsIYOwUK1rCAGhrs1YF6ocVVQ+8C4rHr7zPmCfsJ
         rIRYo/Y2k5MNc6ztg7Uh5ERFqHFcFR7Fp2KdjZvw1l0qoi4yClwuuXUWp2jZuptg3Cxe
         lp+FqC2lpHYy9kI/UU7hgI5I4cGd7LKH8ngizneOX6QUyLURe8QCWtlatNIKrey63CrI
         9oh3m6TVwxwyd/e7ayvfhLfPjv+5FQ7PKm5U5efK+QoCS5Cd20Rxm8nLOs/OAc5Arl2a
         7VSA==
X-Gm-Message-State: AOJu0Yz659LUp5hZwJ6qbO63yAb118oLBcZIwiyDwn+7xmnZdmslb3ql
	+jyvJlL0mXMgf628sxO4suM=
X-Google-Smtp-Source: AGHT+IE76Xxdm3XH/zswx538Yu109s1v7uFK/IxXRT98fuGi2W+0zkqLW5mzWKxrkLd8IgfJmQ4gMg==
X-Received: by 2002:a17:902:d4ce:b0:1cc:52b5:8df8 with SMTP id o14-20020a170902d4ce00b001cc52b58df8mr6932707plg.26.1699670971827;
        Fri, 10 Nov 2023 18:49:31 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id y21-20020a1709027c9500b001c5f77e23a8sm355936pll.73.2023.11.10.18.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:31 -0800 (PST)
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
Subject: [PATCH 19/36] sched_ext: Implement scx_bpf_kick_cpu() and task preemption support
Date: Fri, 10 Nov 2023 16:47:45 -1000
Message-ID: <20231111024835.2164816-20-tj@kernel.org>
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

It's often useful to wake up and/or trigger reschedule on other CPUs. This
patch adds scx_bpf_kick_cpu() kfunc helper that BPF scheduler can call to
kick the target CPU into the scheduling path.

As a sched_ext task relinquishes its CPU only after its slice is depleted,
this patch also adds SCX_KICK_PREEMPT and SCX_ENQ_PREEMPT which clears the
slice of the target CPU's current task to guarantee that sched_ext's
scheduling path runs on the CPU.

v4: * Move example scheduler to its own patch.

v3: * Make scx_example_central switch all tasks by default.

    * Convert to BPF inline iterators.

v2: * Julia Lawall reported that scx_example_central can overflow the
      dispatch buffer and malfunction. As scheduling for other CPUs can't be
      handled by the automatic retry mechanism, fix by implementing an
      explicit overflow and retry handling.

    * Updated to use generic BPF cpumask helpers.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h        |  4 ++
 kernel/sched/ext.c               | 81 ++++++++++++++++++++++++++++++--
 kernel/sched/ext.h               | 12 +++++
 kernel/sched/sched.h             |  3 ++
 tools/sched_ext/scx_common.bpf.h |  1 +
 5 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 55f649bd065c..d6ebfa6163a1 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -408,6 +408,10 @@ struct sched_ext_entity {
 	 * scx_bpf_dispatch() but can also be modified directly by the BPF
 	 * scheduler. Automatically decreased by SCX as the task executes. On
 	 * depletion, a scheduling event is triggered.
+	 *
+	 * This value is cleared to zero if the task is preempted by
+	 * %SCX_KICK_PREEMPT and shouldn't be used to determine how long the
+	 * task ran. Use p->se.sum_exec_runtime instead.
 	 */
 	u64			slice;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 65ee99ea111b..c18a67791bc7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -507,7 +507,7 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 		}
 	}
 
-	if (enq_flags & SCX_ENQ_HEAD)
+	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_node, &dsq->fifo);
 	else
 		list_add_tail(&p->scx.dsq_node, &dsq->fifo);
@@ -523,8 +523,16 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 
 	if (is_local) {
 		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+		bool preempt = false;
 
-		if (sched_class_above(&ext_sched_class, rq->curr->sched_class))
+		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
+		    rq->curr->sched_class == &ext_sched_class) {
+			rq->curr->scx.slice = 0;
+			preempt = true;
+		}
+
+		if (preempt || sched_class_above(&ext_sched_class,
+						 rq->curr->sched_class))
 			resched_curr(rq);
 	} else {
 		raw_spin_unlock(&dsq->lock);
@@ -1941,7 +1949,8 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
  * Omitted operations:
  *
  * - wakeup_preempt: NOOP as it isn't useful in the wakeup path because the task
- *   isn't tied to the CPU at that point.
+ *   isn't tied to the CPU at that point. Preemption is implemented by resetting
+ *   the victim task's slice to 0 and triggering reschedule on the target CPU.
  *
  * - migrate_task_rq: Unncessary as task to cpu mapping is transient.
  *
@@ -2787,6 +2796,32 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+static void kick_cpus_irq_workfn(struct irq_work *irq_work)
+{
+	struct rq *this_rq = this_rq();
+	int this_cpu = cpu_of(this_rq);
+	int cpu;
+
+	for_each_cpu(cpu, this_rq->scx.cpus_to_kick) {
+		struct rq *rq = cpu_rq(cpu);
+		unsigned long flags;
+
+		raw_spin_rq_lock_irqsave(rq, flags);
+
+		if (cpu_online(cpu) || cpu == this_cpu) {
+			if (cpumask_test_cpu(cpu, this_rq->scx.cpus_to_preempt) &&
+			    rq->curr->sched_class == &ext_sched_class)
+				rq->curr->scx.slice = 0;
+			resched_curr(rq);
+		}
+
+		raw_spin_rq_unlock_irqrestore(rq, flags);
+	}
+
+	cpumask_clear(this_rq->scx.cpus_to_kick);
+	cpumask_clear(this_rq->scx.cpus_to_preempt);
+}
+
 /**
  * print_scx_info - print out sched_ext scheduler state
  * @log_lvl: the log level to use when printing
@@ -2855,6 +2890,10 @@ void __init init_sched_ext_class(void)
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 		INIT_LIST_HEAD(&rq->scx.watchdog_list);
+
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
@@ -3089,6 +3128,41 @@ static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
 	.set			= &scx_kfunc_ids_dispatch,
 };
 
+/**
+ * scx_bpf_kick_cpu - Trigger reschedule on a CPU
+ * @cpu: cpu to kick
+ * @flags: %SCX_KICK_* flags
+ *
+ * Kick @cpu into rescheduling. This can be used to wake up an idle CPU or
+ * trigger rescheduling on a busy CPU. This can be called from any online
+ * scx_ops operation and the actual kicking is performed asynchronously through
+ * an irq work.
+ */
+void scx_bpf_kick_cpu(s32 cpu, u64 flags)
+{
+	struct rq *rq;
+
+	if (!ops_cpu_valid(cpu)) {
+		scx_ops_error("invalid cpu %d", cpu);
+		return;
+	}
+
+	preempt_disable();
+	rq = this_rq();
+
+	/*
+	 * Actual kicking is bounced to kick_cpus_irq_workfn() to avoid nesting
+	 * rq locks. We can probably be smarter and avoid bouncing if called
+	 * from ops which don't hold a rq lock.
+	 */
+	cpumask_set_cpu(cpu, rq->scx.cpus_to_kick);
+	if (flags & SCX_KICK_PREEMPT)
+		cpumask_set_cpu(cpu, rq->scx.cpus_to_preempt);
+
+	irq_work_queue(&rq->scx.kick_cpus_irq_work);
+	preempt_enable();
+}
+
 /**
  * scx_bpf_dsq_nr_queued - Return the number of queued tasks
  * @dsq_id: id of the DSQ
@@ -3353,6 +3427,7 @@ s32 scx_bpf_task_cpu(const struct task_struct *p)
 }
 
 BTF_SET8_START(scx_kfunc_ids_ops_only)
+BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 1cdef69a6855..d246e5c2d3c7 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -19,6 +19,14 @@ enum scx_enq_flags {
 
 	/* high 32bits are SCX specific */
 
+	/*
+	 * Set the following to trigger preemption when calling
+	 * scx_bpf_dispatch() with a local dsq as the target. The slice of the
+	 * current task is cleared to zero and the CPU is kicked into the
+	 * scheduling path. Implies %SCX_ENQ_HEAD.
+	 */
+	SCX_ENQ_PREEMPT		= 1LLU << 32,
+
 	/*
 	 * The task being enqueued is the only task available for the cpu. By
 	 * default, ext core keeps executing such tasks but when
@@ -55,6 +63,10 @@ enum scx_pick_idle_cpu_flags {
 	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
 };
 
+enum scx_kick_flags {
+	SCX_KICK_PREEMPT	= 1LLU << 0,	/* force scheduling on the CPU */
+};
+
 #ifdef CONFIG_SCHED_CLASS_EXT
 
 struct sched_enq_and_set_ctx {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aec09e99cdb0..fc8e23f94e0a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -679,6 +679,9 @@ struct scx_rq {
 	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
+	cpumask_var_t		cpus_to_kick;
+	cpumask_var_t		cpus_to_preempt;
+	struct irq_work		kick_cpus_irq_work;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
 
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index 81e484defd9b..590c84ac602d 100644
--- a/tools/sched_ext/scx_common.bpf.h
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -58,6 +58,7 @@ s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym;
+void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
 s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
-- 
2.42.0



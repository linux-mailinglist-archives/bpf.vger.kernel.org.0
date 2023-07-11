Return-Path: <bpf+bounces-4681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21574E34A
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272311C20CE2
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E341A2597;
	Tue, 11 Jul 2023 01:15:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3023A5
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:15:47 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7725710F0;
	Mon, 10 Jul 2023 18:15:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b895a06484so25285075ad.1;
        Mon, 10 Jul 2023 18:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038093; x=1691630093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ6g0CqUaeiF/DvmFEk0zakuqo0mdJf8Z5+tOon3y3c=;
        b=U2OC0q3P7GUlKtukUkLpS1Lxeg1K04Gfvh1iddj3Hmalw1qWySuBqaTSYC67TYE6fq
         zaHF7MSjLF1Lpwju1klJS+GpHJQ5gsnNq/cX0Hjm5MaMgOsJjQRtMk08di8PWZh2ptfh
         JINCGB/QuN96ROnR+RHBuw8GUP51wqN7mmzkiPP7R8t9vmA7lBXXF+z9v3APJSAdVkKr
         ZOtJ3+OItC/wZU+LksuT3dZevc/keyTfdlOfwLfTYaYvGeQ6b5ympiJXMe+VDr+YhPLF
         s6QPWeIhJtSUwqiJYnZnGbTRaibdhkg0Gv5TGJghYoYXpSUANVtPbn6ehPcmoOujJLy6
         T7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038093; x=1691630093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GJ6g0CqUaeiF/DvmFEk0zakuqo0mdJf8Z5+tOon3y3c=;
        b=lig/jx+tEH46ifxKaU3s3+HXuxVBaQ4kygJ/9sOTFK/AJJNiKSVCMhpmXELR0Aau0v
         6zKHOsQ51UJvG5CLNErfq8bOx/K0IQsHfZl7L6ph/r8a8iv+9b7UjaRsHqRGBArp69M0
         UR3JCi2jM/E4AXUCOsGLUrjusibfbFRr3UGnQX/UJnDyJouWgPcj1kjJxvHxHxxI5Gao
         aMU3uOxcZaG4PVdBMtwDL9ml3GapParNV7cO3qxF/k6Qk6teaLD9JnN2ykuAhBuODU7s
         9suFUHUXIbqiFi9SKx59Sjtk10ONbNLhhbpOadTuL4g9c1rk89kxZUD2rBN4XiNtEeKQ
         +/EA==
X-Gm-Message-State: ABy/qLYE6ZSMQI6VKgM7PtRtwFAg2gunf706ZpMhOInUPs7bdRZany1N
	K4UvJzNtuARP3FQF+vrTrls=
X-Google-Smtp-Source: APBJJlGSa9UOBYDvJTRgAegm8krm74K6D/iTIoDOHhSVIojBm7qyIWXx0BkAXpyBe+qeOrWECgXz9w==
X-Received: by 2002:a17:903:244e:b0:1b5:edd:e3c7 with SMTP id l14-20020a170903244e00b001b50edde3c7mr14324189pls.16.1689038092594;
        Mon, 10 Jul 2023 18:14:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id jc17-20020a17090325d100b001b9dfa946b4sm518550plb.49.2023.07.10.18.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:52 -0700 (PDT)
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
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 18/34] sched_ext: Implement scx_bpf_kick_cpu() and task preemption support
Date: Mon, 10 Jul 2023 15:13:36 -1000
Message-ID: <20230711011412.100319-19-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 kernel/sched/ext.c               | 82 ++++++++++++++++++++++++++++++--
 kernel/sched/ext.h               | 12 +++++
 kernel/sched/sched.h             |  3 ++
 tools/sched_ext/scx_common.bpf.h |  1 +
 5 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 772d84033155..5c2df7ccc0a6 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -407,6 +407,10 @@ struct sched_ext_entity {
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
index 6cb3412cee9f..9e8f9f9fcb3d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -496,7 +496,7 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 		}
 	}
 
-	if (enq_flags & SCX_ENQ_HEAD)
+	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_node, &dsq->fifo);
 	else
 		list_add_tail(&p->scx.dsq_node, &dsq->fifo);
@@ -512,8 +512,16 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 
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
@@ -1929,7 +1937,9 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
  * Omitted operations:
  *
  * - check_preempt_curr: NOOP as it isn't useful in the wakeup path because the
- *   task isn't tied to the CPU at that point.
+ *   task isn't tied to the CPU at that point. Preemption is implemented by
+ *   resetting the victim task's slice to 0 and triggering reschedule on the
+ *   target CPU.
  *
  * - migrate_task_rq: Unncessary as task to cpu mapping is transient.
  *
@@ -2775,6 +2785,32 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
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
 void __init init_sched_ext_class(void)
 {
 	int cpu;
@@ -2798,6 +2834,10 @@ void __init init_sched_ext_class(void)
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 		INIT_LIST_HEAD(&rq->scx.watchdog_list);
+
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
@@ -3032,6 +3072,41 @@ static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
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
@@ -3296,6 +3371,7 @@ s32 scx_bpf_task_cpu(const struct task_struct *p)
 }
 
 BTF_SET8_START(scx_kfunc_ids_any)
+BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index c32f14bb981c..f535ec39e660 100644
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
index c77fefae1694..ed544ed5ecd6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -692,6 +692,9 @@ struct scx_rq {
 	u64			ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
+	cpumask_var_t		cpus_to_kick;
+	cpumask_var_t		cpus_to_preempt;
+	struct irq_work		kick_cpus_irq_work;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
 
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index 0e6d7d3e2d27..1a0184024eaf 100644
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
2.41.0



Return-Path: <bpf+bounces-4690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8424A74E358
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A25280DD5
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80494421;
	Tue, 11 Jul 2023 01:16:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844EC3FFA
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:16:07 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CF1735;
	Mon, 10 Jul 2023 18:15:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-66c729f5618so4463851b3a.1;
        Mon, 10 Jul 2023 18:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038111; x=1691630111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVjeLtARNad5J1bPKF5HrYQ+HanLkv7ypO13jcRCNto=;
        b=sd/f0T/u5gGvdxpjlrjmKTdL+BF/vlQLOHWIqx2p3sV9GH1MgDhLColFgj2iNQh3Vw
         uc+YpnSGW1OmX+4t8DCKDt7vrx9duDAp4lOIuPpB/M1wnazX9LzyI/MzHluxDs6oSW/t
         XMb5dA/beaLmvXmoImdisiS/OAoM/Z2v2zktJfTU160P+HNOh91voqEMUwiHt7hhWmGp
         W7wgVq32+E24/0GaiAFJwO9eZ85R+8e9SRWejM3G37MZfvtBmhShtTdHmxEsj+gPr/xx
         ApGCfx79jYFYFbqobZLwIqfB4TS+1w+qJB/UHcvCGa3MbwPmgYYt20k/R0h1IhOTdlS8
         /zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038111; x=1691630111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVjeLtARNad5J1bPKF5HrYQ+HanLkv7ypO13jcRCNto=;
        b=OC3jKvTwHADEYrgCRjUkIxM85PhCA1/YThzNrnh7UQWg+7k56QD31IJm4C+sl7lFrO
         afczcFZuZjvF4V1KaCcTtiTrVDKVcuQrwnCxFf1lo9936M7GQ68WGhQkscN1M8RvV20n
         lTBuJ0bspkvrd/PAN0MDu0sCWfqRmQ9fBUbgv2VW3fEPp5vGhaTf599b/jbQdvWXTTtS
         XD79B6sfj2a9feK8W1ioM/tNEnBTEfV2LgQ6Kb5afz4+/OgMoXiCul9tcjn0OgN2/QLT
         6Khl1ave2R0ovMXM31frYmvXMNsPMRXKXJNZJS1jHH51+ciS7CKxQ6KYW8uzAnr5bUI5
         tcww==
X-Gm-Message-State: ABy/qLbDCUl72kkN/dy6gvIiXZIRDxA41md1PjvFoQHpxRsb5MRNZD1U
	vUlWb/qzEuGy6utF9HKX0M4=
X-Google-Smtp-Source: APBJJlGiFEmiQuQeCKe9IV0v6c4BU11DgMJXxpek8dIyDdzpMnRMyh1cgLwtBsdoDfDbkutnL+WgwA==
X-Received: by 2002:a05:6a20:104f:b0:12e:c481:7072 with SMTP id gt15-20020a056a20104f00b0012ec4817072mr13936148pzc.37.1689038110551;
        Mon, 10 Jul 2023 18:15:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id j13-20020a62b60d000000b0064928cb5f03sm405656pff.69.2023.07.10.18.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:10 -0700 (PDT)
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
Subject: [PATCH 27/34] sched_ext: Implement SCX_KICK_WAIT
Date: Mon, 10 Jul 2023 15:13:45 -1000
Message-ID: <20230711011412.100319-28-tj@kernel.org>
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

From: David Vernet <dvernet@meta.com>

If set when calling scx_bpf_kick_cpu(), the invoking CPU will busy wait for
the kicked cpu to enter the scheduler. This will be used to improve the
exclusion guarantees in scx_pair.

Signed-off-by: David Vernet <dvernet@meta.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  |  4 +++-
 kernel/sched/ext.c   | 33 ++++++++++++++++++++++++++++++++-
 kernel/sched/ext.h   | 20 ++++++++++++++++++++
 kernel/sched/sched.h |  2 ++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 77eb4ee4f759..878e84694a6e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6052,8 +6052,10 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	for_each_active_class(class) {
 		p = class->pick_next_task(rq);
-		if (p)
+		if (p) {
+			scx_notify_pick_next_task(rq, p, class);
 			return p;
+		}
 	}
 
 	BUG(); /* The idle class should always have a runnable task. */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5862e8290207..48a8881ff01f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -125,6 +125,9 @@ static struct {
 
 #endif	/* CONFIG_SMP */
 
+/* for %SCX_KICK_WAIT */
+static u64 __percpu *scx_kick_cpus_pnt_seqs;
+
 /*
  * Direct dispatch marker.
  *
@@ -3269,6 +3272,7 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 {
 	struct rq *this_rq = this_rq();
+	u64 *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
 	int this_cpu = cpu_of(this_rq);
 	int cpu;
 
@@ -3282,14 +3286,32 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 			if (cpumask_test_cpu(cpu, this_rq->scx.cpus_to_preempt) &&
 			    rq->curr->sched_class == &ext_sched_class)
 				rq->curr->scx.slice = 0;
+			pseqs[cpu] = rq->scx.pnt_seq;
 			resched_curr(rq);
+		} else {
+			cpumask_clear_cpu(cpu, this_rq->scx.cpus_to_wait);
 		}
 
 		raw_spin_rq_unlock_irqrestore(rq, flags);
 	}
 
+	for_each_cpu_andnot(cpu, this_rq->scx.cpus_to_wait,
+			    cpumask_of(this_cpu)) {
+		/*
+		 * Pairs with smp_store_release() issued by this CPU in
+		 * scx_notify_pick_next_task() on the resched path.
+		 *
+		 * We busy-wait here to guarantee that no other task can be
+		 * scheduled on our core before the target CPU has entered the
+		 * resched path.
+		 */
+		while (smp_load_acquire(&cpu_rq(cpu)->scx.pnt_seq) == pseqs[cpu])
+			cpu_relax();
+	}
+
 	cpumask_clear(this_rq->scx.cpus_to_kick);
 	cpumask_clear(this_rq->scx.cpus_to_preempt);
+	cpumask_clear(this_rq->scx.cpus_to_wait);
 }
 
 void __init init_sched_ext_class(void)
@@ -3303,7 +3325,7 @@ void __init init_sched_ext_class(void)
 	 * through the generated vmlinux.h.
 	 */
 	WRITE_ONCE(v, SCX_WAKE_EXEC | SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP |
-		   SCX_TG_ONLINE);
+		   SCX_TG_ONLINE | SCX_KICK_PREEMPT);
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
@@ -3311,6 +3333,12 @@ void __init init_sched_ext_class(void)
 	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
 #endif
+	scx_kick_cpus_pnt_seqs =
+		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) *
+			       num_possible_cpus(),
+			       __alignof__(scx_kick_cpus_pnt_seqs[0]));
+	BUG_ON(!scx_kick_cpus_pnt_seqs);
+
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
 
@@ -3319,6 +3347,7 @@ void __init init_sched_ext_class(void)
 
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_wait, GFP_KERNEL));
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 	}
 
@@ -3585,6 +3614,8 @@ void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 	cpumask_set_cpu(cpu, rq->scx.cpus_to_kick);
 	if (flags & SCX_KICK_PREEMPT)
 		cpumask_set_cpu(cpu, rq->scx.cpus_to_preempt);
+	if (flags & SCX_KICK_WAIT)
+		cpumask_set_cpu(cpu, rq->scx.cpus_to_wait);
 
 	irq_work_queue(&rq->scx.kick_cpus_irq_work);
 	preempt_enable();
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index c3404a0a7637..abb283ac3bc7 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -65,6 +65,7 @@ enum scx_pick_idle_cpu_flags {
 
 enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 0,	/* force scheduling on the CPU */
+	SCX_KICK_WAIT		= 1LLU << 1,	/* wait for the CPU to be rescheduled */
 };
 
 enum scx_tg_flags {
@@ -115,6 +116,22 @@ __printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
 #define scx_ops_error(fmt, args...)						\
 	scx_ops_error_type(SCX_EXIT_ERROR, fmt, ##args)
 
+static inline void scx_notify_pick_next_task(struct rq *rq,
+					     const struct task_struct *p,
+					     const struct sched_class *active)
+{
+#ifdef CONFIG_SMP
+	if (!scx_enabled())
+		return;
+	/*
+	 * Pairs with the smp_load_acquire() issued by a CPU in
+	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
+	 * resched.
+	 */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+#endif
+}
+
 static inline void scx_notify_sched_tick(void)
 {
 	unsigned long last_check;
@@ -170,6 +187,9 @@ static inline int scx_check_setscheduler(struct task_struct *p,
 					 int policy) { return 0; }
 static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void init_sched_ext_class(void) {}
+static inline void scx_notify_pick_next_task(struct rq *rq,
+					     const struct task_struct *p,
+					     const struct sched_class *active) {}
 static inline void scx_notify_sched_tick(void) {}
 
 #define for_each_active_class		for_each_class
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 00bf33fdbd64..ce6e0a73135b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -710,6 +710,8 @@ struct scx_rq {
 	u32			flags;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_wait;
+	u64			pnt_seq;
 	struct irq_work		kick_cpus_irq_work;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
-- 
2.41.0



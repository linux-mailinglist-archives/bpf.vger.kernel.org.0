Return-Path: <bpf+bounces-14855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B8E7E88AB
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21988B20BFB
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75A5258;
	Sat, 11 Nov 2023 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtK6JhxG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B41860
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:52:07 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52C25583;
	Fri, 10 Nov 2023 18:49:51 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-58441865ffaso1509379eaf.1;
        Fri, 10 Nov 2023 18:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670991; x=1700275791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZeI9725myAVZqLqZVa1czCaq5DHZFEpHH3TfTd4WoI=;
        b=ZtK6JhxGTIcsu7awOLLGDg77MejbNd/tfpfGwHKBZ1VhvShdiq2UVav1O/EXreA8iw
         umcsj67I/Xj+NcbcPYXigKusEPYz8is/t1ge0RnF/5oiOn9AHtWq6XdgvoLGbLn+1Ntg
         cOJ7vXh/eA4lbgkVztEvpeTJC2B9XJne2ffJF3UZlk9LDHr4dG5ABNQYXOz3h0aXs2/k
         GyNC6cQz10IMcWqO7iPz/rl9B+8EtMaqeXZyUrhN8gyNEgxrYt7gnnuRqnmIgAtCrF1m
         d72wfKBwaScFR57CpY77UmHQhms+nleDkNEOurwdtWv2m5RjlaSrTUEs7bzaIdyB+kdx
         KuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670991; x=1700275791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CZeI9725myAVZqLqZVa1czCaq5DHZFEpHH3TfTd4WoI=;
        b=BMdLF0tAF7brzd0Px9chTdTEvEsZ7aDyu7+slW6w3KdsRYhjtxCHnFzefGhOag10V8
         hLBvJ50tHGSQYUTa+SX4a4EIGY9OhS7xON3Kp1aW2IQ27jg7fsxxl7QXuRvWSt0Q+V+X
         fi+zk/DTQGUBsLCiA071J2YZvwgH3qidZDYrsGPv/X2t/1cHJJdUjH3qVivF2cO7rbb7
         V7Pd+ZmJElRp/ReJDDRggS2Mv1zFGnp8pEIY2W9m/jD+bPQqbZIvd4awImvA3Ptu8JRO
         J/MFgiJrlXah2ZXmqHFaf9uyIp0h6+8AWSDO5N8WOAZWc1io7Qrd7nsJVLZmya0q1w+U
         0Dzg==
X-Gm-Message-State: AOJu0Yxox9wRLiGKSaImVdqgplL0jcSkGWgOkmTUQdQAe3Ra6Hls8iQJ
	bD2wYXYWjCl2Qq1XP0pdzCs=
X-Google-Smtp-Source: AGHT+IHnKWzQFwWjncnq+LJF9uTpmTGhQ5MOlEolE2p/d6tyeSEeoFso6zN4m8vhXGlIoVjp1dnATQ==
X-Received: by 2002:a05:6359:d06:b0:16b:c63d:5dfe with SMTP id gp6-20020a0563590d0600b0016bc63d5dfemr318506rwb.16.1699670989378;
        Fri, 10 Nov 2023 18:49:49 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id u5-20020a656705000000b00584aff3060dsm327335pgf.59.2023.11.10.18.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:48 -0800 (PST)
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
Subject: [PATCH 28/36] sched_ext: Implement SCX_KICK_WAIT
Date: Fri, 10 Nov 2023 16:47:54 -1000
Message-ID: <20231111024835.2164816-29-tj@kernel.org>
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
index 2dea64a52157..9fe1a224c888 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6077,8 +6077,10 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
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
index e4aa935006bc..76a90b2c1662 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -132,6 +132,9 @@ static struct {
 
 #endif	/* CONFIG_SMP */
 
+/* for %SCX_KICK_WAIT */
+static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
+
 /*
  * Direct dispatch marker.
  *
@@ -3280,6 +3283,7 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 {
 	struct rq *this_rq = this_rq();
+	unsigned long *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
 	int this_cpu = cpu_of(this_rq);
 	int cpu;
 
@@ -3293,14 +3297,32 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
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
 
 /**
@@ -3359,7 +3381,7 @@ void __init init_sched_ext_class(void)
 	 * through the generated vmlinux.h.
 	 */
 	WRITE_ONCE(v, SCX_WAKE_EXEC | SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP |
-		   SCX_TG_ONLINE);
+		   SCX_TG_ONLINE | SCX_KICK_PREEMPT);
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
@@ -3367,6 +3389,12 @@ void __init init_sched_ext_class(void)
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
 
@@ -3375,6 +3403,7 @@ void __init init_sched_ext_class(void)
 
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_wait, GFP_KERNEL));
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 	}
 
@@ -3641,6 +3670,8 @@ void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 	cpumask_set_cpu(cpu, rq->scx.cpus_to_kick);
 	if (flags & SCX_KICK_PREEMPT)
 		cpumask_set_cpu(cpu, rq->scx.cpus_to_preempt);
+	if (flags & SCX_KICK_WAIT)
+		cpumask_set_cpu(cpu, rq->scx.cpus_to_wait);
 
 	irq_work_queue(&rq->scx.kick_cpus_irq_work);
 	preempt_enable();
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 94e788ab56d9..00218d43d887 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -65,6 +65,7 @@ enum scx_pick_idle_cpu_flags {
 
 enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 0,	/* force scheduling on the CPU */
+	SCX_KICK_WAIT		= 1LLU << 1,	/* wait for the CPU to be rescheduled */
 };
 
 enum scx_tg_flags {
@@ -115,6 +116,22 @@ __printf(2, 3) void scx_ops_error_kind(enum scx_exit_kind kind,
 #define scx_ops_error(fmt, args...)						\
 	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
 
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
index 9f1f2e778683..f889833371a2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -697,6 +697,8 @@ struct scx_rq {
 	u32			flags;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_wait;
+	unsigned long		pnt_seq;
 	struct irq_work		kick_cpus_irq_work;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
-- 
2.42.0



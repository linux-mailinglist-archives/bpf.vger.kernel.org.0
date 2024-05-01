Return-Path: <bpf+bounces-28360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6A98B8CBB
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4723283B2D
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4FC13848E;
	Wed,  1 May 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbvTTYye"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A8137C3B;
	Wed,  1 May 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576462; cv=none; b=Pcy+rsJKFAjXYw+G2m0oMYRs/cDAS8Is9fAln9fIOVKRX/6+6+K+4i0fS3DFd1SPeUNqBgFombYuoxSUkjzB+ij6UmaXRvVtCTyjO/94PTzyTAaFUuW2fNXHITt0Jm0wGYbJBt/GNN66dlEu16BUuckp3VnT37PFALaYHIvcoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576462; c=relaxed/simple;
	bh=OmAbVskWHJXdzd6bo+Oq6i5LhKduiBs8hcccwAzacPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KX+JWJthEo5sOnsbhs9h1/FwkZhQEJ0pdj9U/kpxUM96U3sPERzNgZOaAD9WR/E8K6/mGsTYLjBYgKcRbQJh+YOJGS/EONSU9Mnw/14wKHxXrpYFJGueV2ay45fK3cIs+RhbJ2zaoy/Dv9w/NQOPcpOXawD1SHPRayyCjsGifik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbvTTYye; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36b30909b01so27236405ab.2;
        Wed, 01 May 2024 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576460; x=1715181260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32MT8BpIth0xVDkqzONWNxtle8Qf/PzSWYuUV747AcA=;
        b=AbvTTYyehSTda5CdNOQ/wR0ABn51NarkBA1a+UUHYs2auXf9MLUmQoorqYRlvT5oUU
         w/QPUoTLpSLJYOzJdSzqmIaZgqOTQbug3JrsaIqDqSanJp3Npy1K7pnBKhCuDYtczwgs
         CiRvkfxQh1TOCFyUrDb0mWSrihF2y8toMx7feVa4HJO+3bSWFizbu8BL0e4DWmV5as+R
         jn9IkofRbroOWL9oy4ZU6Ggs2ky1x92CYKb0iIxpSLN1bVC77h0OC9mRZjvlBn4LqU6c
         X2JGsnXX9KyJk/fS1xMC6PGgwyy1m9BBTCqiInbp7UPiiAYIxptDLpeq66lv1W/hYkE7
         QRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576460; x=1715181260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32MT8BpIth0xVDkqzONWNxtle8Qf/PzSWYuUV747AcA=;
        b=NqckcsWUibvpL/1Lca2p85eG7R838tBa8hP66nXC3sIGO18XhDaH9sFclRFIO14HIX
         c5aAgbC+LDHnXH3G1ox0RuCU/s0godB9pU3c8RBur4t5u9P2iIBnu/F9LjeLvvs09spZ
         4y1k0BFBb0Lx3ypKEkyt//dZikvL3wql5xpkSrYU0vMsbAlGKLH8vuknxWicNop5Lb5o
         qGGsq0IS3o6BookRU/4mUUJMkXorHlOm9FxGEJK14uUuvL2RsPASDtiAE+7OkGTHImWT
         7123D1N0HOoxemFNO1JFM0oFpkvYunaDLoVLrOqzAqW58W/DOqFT6U9xsM9ty7w8cFLk
         1aBA==
X-Forwarded-Encrypted: i=1; AJvYcCV85hpxShRoUgMbz312hQxmSVTL38ZKp3TnbdtGBLfV93p/Prs7ZmIGegfG3BcjTt+5pC6SUYnT/macF30OZYTOPFPx
X-Gm-Message-State: AOJu0Yyf8YKkNEPJLVNNdCraxbTOe6zx6cocpe4EjxpNERuWuBydksnQ
	WMhGpqsN84H7bpEOkXKZ9wLm1qbSFVs+Z27J866Jl7TIztXbJRr5
X-Google-Smtp-Source: AGHT+IFcAEdwpRn+SiCMJpQ2vwzgm8h3aHIQMPDvoiMGkVBU6zd4ugNuHGCUb3OOR7ZnQpYUOqSYpQ==
X-Received: by 2002:a05:6e02:1c4b:b0:36b:fffc:73bb with SMTP id d11-20020a056e021c4b00b0036bfffc73bbmr3636802ilg.7.1714576459692;
        Wed, 01 May 2024 08:14:19 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id h191-20020a6383c8000000b006034c56d597sm14790544pge.22.2024.05.01.08.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:14:19 -0700 (PDT)
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
Subject: [PATCH 30/39] sched_ext: Implement SCX_KICK_WAIT
Date: Wed,  1 May 2024 05:10:05 -1000
Message-ID: <20240501151312.635565-31-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Vernet <dvernet@meta.com>

If set when calling scx_bpf_kick_cpu(), the invoking CPU will busy wait for
the kicked cpu to enter the scheduler. See the following for example usage:

  https://github.com/sched-ext/scx/blob/main/scheds/c/scx_pair.bpf.c

v2: - Updated to fit the updated kick_cpus_irq_workfn() implementation.

    - Include SCX_KICK_WAIT related information in debug dump.

Signed-off-by: David Vernet <dvernet@meta.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  |  4 ++-
 kernel/sched/ext.c   | 82 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/ext.h   |  4 +++
 kernel/sched/sched.h |  2 ++
 4 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index de49b94844a9..d940c17dfe8a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6115,8 +6115,10 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	for_each_active_class(class) {
 		p = class->pick_next_task(rq);
-		if (p)
+		if (p) {
+			scx_next_task_picked(rq, p, class);
 			return p;
+		}
 	}
 
 	BUG(); /* The idle class should always have a runnable task. */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 80c313a56958..91c3d1851b45 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -579,6 +579,12 @@ enum scx_kick_flags {
 	 * task expires and the dispatch path is invoked.
 	 */
 	SCX_KICK_PREEMPT	= 1LLU << 1,
+
+	/*
+	 * Wait for the CPU to be rescheduled. The scx_bpf_kick_cpu() call will
+	 * return after the target CPU finishes picking the next task.
+	 */
+	SCX_KICK_WAIT		= 1LLU << 2,
 };
 
 enum scx_tg_flags {
@@ -713,6 +719,9 @@ static struct {
 
 #endif	/* CONFIG_SMP */
 
+/* for %SCX_KICK_WAIT */
+static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
+
 /*
  * Direct dispatch marker.
  *
@@ -2315,6 +2324,23 @@ static struct task_struct *pick_next_task_scx(struct rq *rq)
 	return p;
 }
 
+void scx_next_task_picked(struct rq *rq, struct task_struct *p,
+			  const struct sched_class *active)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (!scx_enabled())
+		return;
+#ifdef CONFIG_SMP
+	/*
+	 * Pairs with the smp_load_acquire() issued by a CPU in
+	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
+	 * resched.
+	 */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+#endif
+}
+
 #ifdef CONFIG_SMP
 
 static bool test_and_clear_cpu_idle(int cpu)
@@ -3868,9 +3894,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		    rq->curr->sched_class == &idle_sched_class)
 			goto next;
 
-		seq_buf_printf(&s, "\nCPU %-4d: nr_run=%u flags=0x%x ops_qseq=%lu\n",
+		seq_buf_printf(&s, "\nCPU %-4d: nr_run=%u flags=0x%x ops_qseq=%lu pnt_seq=%lu\n",
 			       cpu, rq->scx.nr_running, rq->scx.flags,
-			       rq->scx.ops_qseq);
+			       rq->scx.ops_qseq, rq->scx.pnt_seq);
 		seq_buf_printf(&s, "          curr=%s[%d] class=%ps\n",
 			       rq->curr->comm, rq->curr->pid,
 			       rq->curr->sched_class);
@@ -3883,6 +3909,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		if (!cpumask_empty(rq->scx.cpus_to_preempt))
 			seq_buf_printf(&s, "  cpus_to_preempt: %*pb\n",
 				       cpumask_pr_args(rq->scx.cpus_to_preempt));
+		if (!cpumask_empty(rq->scx.cpus_to_wait))
+			seq_buf_printf(&s, "  cpus_to_wait   : %*pb\n",
+				       cpumask_pr_args(rq->scx.cpus_to_wait));
 
 		if (rq->curr->sched_class == &ext_sched_class)
 			scx_dump_task(&s, rq->curr, '*', now);
@@ -4578,10 +4607,11 @@ static bool can_skip_idle_kick(struct rq *rq)
 	return !is_idle_task(rq->curr) && !(rq->scx.flags & SCX_RQ_BALANCING);
 }
 
-static void kick_one_cpu(s32 cpu, struct rq *this_rq)
+static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *pseqs)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct scx_rq *this_scx = &this_rq->scx;
+	bool should_wait = false;
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
@@ -4597,12 +4627,20 @@ static void kick_one_cpu(s32 cpu, struct rq *this_rq)
 			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
 		}
 
+		if (cpumask_test_cpu(cpu, this_scx->cpus_to_wait)) {
+			pseqs[cpu] = rq->scx.pnt_seq;
+			should_wait = true;
+		}
+
 		resched_curr(rq);
 	} else {
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
+		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
 	}
 
 	raw_spin_rq_unlock_irqrestore(rq, flags);
+
+	return should_wait;
 }
 
 static void kick_one_cpu_if_idle(s32 cpu, struct rq *this_rq)
@@ -4623,10 +4661,12 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 {
 	struct rq *this_rq = this_rq();
 	struct scx_rq *this_scx = &this_rq->scx;
+	unsigned long *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
+	bool should_wait = false;
 	s32 cpu;
 
 	for_each_cpu(cpu, this_scx->cpus_to_kick) {
-		kick_one_cpu(cpu, this_rq);
+		should_wait |= kick_one_cpu(cpu, this_rq, pseqs);
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
 	}
@@ -4635,6 +4675,28 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 		kick_one_cpu_if_idle(cpu, this_rq);
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
 	}
+
+	if (!should_wait)
+		return;
+
+	for_each_cpu(cpu, this_scx->cpus_to_wait) {
+		unsigned long *wait_pnt_seq = &cpu_rq(cpu)->scx.pnt_seq;
+
+		if (cpu != cpu_of(this_rq)) {
+			/*
+			 * Pairs with smp_store_release() issued by this CPU in
+			 * scx_next_task_picked() on the resched path.
+			 *
+			 * We busy-wait here to guarantee that no other task can
+			 * be scheduled on our core before the target CPU has
+			 * entered the resched path.
+			 */
+			while (smp_load_acquire(wait_pnt_seq) == pseqs[cpu])
+				cpu_relax();
+		}
+
+		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
+	}
 }
 
 /**
@@ -4700,6 +4762,11 @@ void __init init_sched_ext_class(void)
 	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
 #endif
+	scx_kick_cpus_pnt_seqs =
+		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
+			       __alignof__(scx_kick_cpus_pnt_seqs[0]));
+	BUG_ON(!scx_kick_cpus_pnt_seqs);
+
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
 
@@ -4709,6 +4776,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_wait, GFP_KERNEL));
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 	}
 
@@ -5038,8 +5106,8 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 	if (flags & SCX_KICK_IDLE) {
 		struct rq *target_rq = cpu_rq(cpu);
 
-		if (unlikely(flags & SCX_KICK_PREEMPT))
-			scx_ops_error("PREEMPT cannot be used with SCX_KICK_IDLE");
+		if (unlikely(flags & (SCX_KICK_PREEMPT | SCX_KICK_WAIT)))
+			scx_ops_error("PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
 
 		if (raw_spin_rq_trylock(target_rq)) {
 			if (can_skip_idle_kick(target_rq)) {
@@ -5054,6 +5122,8 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 
 		if (flags & SCX_KICK_PREEMPT)
 			cpumask_set_cpu(cpu, this_rq->scx.cpus_to_preempt);
+		if (flags & SCX_KICK_WAIT)
+			cpumask_set_cpu(cpu, this_rq->scx.cpus_to_wait);
 	}
 
 	irq_work_queue(&this_rq->scx.kick_cpus_irq_work);
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 1017439dcc00..5db35f627ea3 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -29,6 +29,8 @@ static inline bool task_on_scx(const struct task_struct *p)
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
+void scx_next_task_picked(struct rq *rq, struct task_struct *p,
+			  const struct sched_class *active);
 void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
@@ -78,6 +80,8 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 #define scx_enabled()		false
 #define scx_switched_all()	false
 
+static inline void scx_next_task_picked(struct rq *rq, struct task_struct *p,
+					const struct sched_class *active) {}
 static inline void scx_tick(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0ca2378bb252..c8cf6fbaed07 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -735,6 +735,8 @@ struct scx_rq {
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_wait;
+	unsigned long		pnt_seq;
 	struct irq_work		kick_cpus_irq_work;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
-- 
2.44.0



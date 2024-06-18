Return-Path: <bpf+bounces-32457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B690DE49
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365A81C219ED
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FC19CCED;
	Tue, 18 Jun 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaA3ccW/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4678E19B3E1;
	Tue, 18 Jun 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745712; cv=none; b=qZYz0fo2yv3pJEP1Vr233WHR4+uHXH7EQbOnEyaD6lP6gnm5zR3/pwp7qtLfSy35FwDwY4LZswMMB4o7xel9hAc6vF6Vi7Xkdw1T0fi0IOBk6SxivRhpPBhHGRRCyj9POJ2VPwKbppF8UWdpYYGYYE8qtCrsywDWD6ZC6z3K+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745712; c=relaxed/simple;
	bh=b0hECenmxKvb2l7SIzoA3XK2HRQNBHApsrqi6d82LnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ae71fMYFm5ueOA7wLnxRgYPyiQMUo1w4aRKJOjwpwzGKJuXjxp5hYkJuxXYZYwRasqPMs99/gIbpD9fI+wi0X9CEbvdE975cbOORAPfeBmFHlh3jbCipe6oEhngKIjutLD6/10Rvjk0mE7c2It4DNV452SbInb5WW9JDp0tg4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaA3ccW/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f99fe4dc5aso8305015ad.0;
        Tue, 18 Jun 2024 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745710; x=1719350510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPBr69l1360dXgQhS0s51QY8Zea9iQ78bkJtXyeGpfM=;
        b=AaA3ccW/FeM2EY5RzNTp8EQnbdChfMyStng5pbwHHGT0ZYJZvGG6hKgnictQMBFXpQ
         +LlAoNm/tnm85mVJdT2TLbBOLF6CiLN7Rprz6Gob6m0b1sZAXJxDmYvWqTIjheVcDi+D
         T3X92Ssggxr+/JF4k2vCz/h9McoBj3BA3U+4OwvvLdKDMlpoQCS+Oo0xHMEABMHwIaDO
         H5IuT/3gfLMPfW9+5LXMNOEXKtgrS1rByfIDLu2Ac7rDo8YYRGw6MbaisoXpVMsj+7Cb
         hGsVW7CDpzK8D8CGo4yN6s4pKb1rpUThr/jsZ/Tm4v0wYzEex9aLHG+dJ4Q0IW/zTa8n
         zJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745710; x=1719350510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPBr69l1360dXgQhS0s51QY8Zea9iQ78bkJtXyeGpfM=;
        b=n16wdyiGKmY3sOdNL6GxcKv+2g79ErQyGKfKw3D4iXEECX3wrk2k3AYNuNksHZQrix
         vguLanNPL63PqC9cL7JKzc52y/uWdV4sm8Ch39g/NzUJnAIgZbsm5ZudFNpDdTPgPgMD
         e1Z3R2P0v8JSVRZKwsQ9/AU0BtMaRw2bwUmdT9uvjZadPQxZasK381a67d/fQL7SEX1S
         uB0oL5+O/Nmj51pRxCrAK6/IaXjpWrANM/8K3zRbIvtb+0JXvk85gugYccgEG7ButyV6
         ONLJL+rGfI7+l+IEfcnlSC0ebICrXfx116DsihPqNXQjWATJmf4dps0uN9YUeJFj4qzc
         MjhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn7sHeVPxal1jol9TcSChxxcBWwoygxtrdW6WfqnlUVC4b3WWNpTXumTLtLlxaRqB90GwbpkAYEDEyD/PbwLCI08mp
X-Gm-Message-State: AOJu0YxlElGSS2fxMqpBJIauyRAmHRAvpIYJHAgSuDAaEz5XVgv4UsoR
	ahmpqu+o+p6hLT17neBI1KyKo5KfHOr2TxcxaeZOoZruDJCmSs0+
X-Google-Smtp-Source: AGHT+IHuWJuZ8Z417npF27O5U3PkB5CaNkFcKj5G051y6pk6+vUoc0f8DgZuEfRKa/5P3rXSBTGhyg==
X-Received: by 2002:a17:902:da8e:b0:1f7:6ed:7389 with SMTP id d9443c01a7336-1f9aa4802a7mr10532015ad.66.1718745710459;
        Tue, 18 Jun 2024 14:21:50 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f01a05sm102362915ad.196.2024.06.18.14.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:50 -0700 (PDT)
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
Subject: [PATCH 23/30] sched_ext: Implement SCX_KICK_WAIT
Date: Tue, 18 Jun 2024 11:17:38 -1000
Message-ID: <20240618212056.2833381-24-tj@kernel.org>
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
index d5eff4036be7..0e6ff33f34e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5898,8 +5898,10 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
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
index 838a96cb10ea..1ca3067b4e0a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -532,6 +532,12 @@ enum scx_kick_flags {
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
 
 enum scx_ops_enable_state {
@@ -661,6 +667,9 @@ static struct {
 
 #endif	/* CONFIG_SMP */
 
+/* for %SCX_KICK_WAIT */
+static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
+
 /*
  * Direct dispatch marker.
  *
@@ -2288,6 +2297,23 @@ static struct task_struct *pick_next_task_scx(struct rq *rq)
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
@@ -3673,9 +3699,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		seq_buf_init(&ns, buf, avail);
 
 		dump_newline(&ns);
-		dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x ops_qseq=%lu",
+		dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x ops_qseq=%lu pnt_seq=%lu",
 			  cpu, rq->scx.nr_running, rq->scx.flags,
-			  rq->scx.ops_qseq);
+			  rq->scx.ops_qseq, rq->scx.pnt_seq);
 		dump_line(&ns, "          curr=%s[%d] class=%ps",
 			  rq->curr->comm, rq->curr->pid,
 			  rq->curr->sched_class);
@@ -3688,6 +3714,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		if (!cpumask_empty(rq->scx.cpus_to_preempt))
 			dump_line(&ns, "  cpus_to_preempt: %*pb",
 				  cpumask_pr_args(rq->scx.cpus_to_preempt));
+		if (!cpumask_empty(rq->scx.cpus_to_wait))
+			dump_line(&ns, "  cpus_to_wait   : %*pb",
+				  cpumask_pr_args(rq->scx.cpus_to_wait));
 
 		used = seq_buf_used(&ns);
 		if (SCX_HAS_OP(dump_cpu)) {
@@ -4383,10 +4412,11 @@ static bool can_skip_idle_kick(struct rq *rq)
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
@@ -4402,12 +4432,20 @@ static void kick_one_cpu(s32 cpu, struct rq *this_rq)
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
@@ -4428,10 +4466,12 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
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
@@ -4440,6 +4480,28 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
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
@@ -4504,6 +4566,11 @@ void __init init_sched_ext_class(void)
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
 
@@ -4513,6 +4580,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_wait, GFP_KERNEL));
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 	}
 
@@ -4840,8 +4908,8 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 	if (flags & SCX_KICK_IDLE) {
 		struct rq *target_rq = cpu_rq(cpu);
 
-		if (unlikely(flags & SCX_KICK_PREEMPT))
-			scx_ops_error("PREEMPT cannot be used with SCX_KICK_IDLE");
+		if (unlikely(flags & (SCX_KICK_PREEMPT | SCX_KICK_WAIT)))
+			scx_ops_error("PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
 
 		if (raw_spin_rq_trylock(target_rq)) {
 			if (can_skip_idle_kick(target_rq)) {
@@ -4856,6 +4924,8 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 
 		if (flags & SCX_KICK_PREEMPT)
 			cpumask_set_cpu(cpu, this_rq->scx.cpus_to_preempt);
+		if (flags & SCX_KICK_WAIT)
+			cpumask_set_cpu(cpu, this_rq->scx.cpus_to_wait);
 	}
 
 	irq_work_queue(&this_rq->scx.kick_cpus_irq_work);
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 6ed946f72489..0aeb1fda1794 100644
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
@@ -69,6 +71,8 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 #define scx_enabled()		false
 #define scx_switched_all()	false
 
+static inline void scx_next_task_picked(struct rq *rq, struct task_struct *p,
+					const struct sched_class *active) {}
 static inline void scx_tick(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b3c578cb43cd..734206e13897 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -740,6 +740,8 @@ struct scx_rq {
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_wait;
+	unsigned long		pnt_seq;
 	struct irq_work		kick_cpus_irq_work;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
-- 
2.45.2



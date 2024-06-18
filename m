Return-Path: <bpf+bounces-32451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83990DE3D
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DD81C21CA1
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822EE17BB00;
	Tue, 18 Jun 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuxnJdsK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC04A1991A5;
	Tue, 18 Jun 2024 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745701; cv=none; b=RFFDP07CjuFINx9/vv2mStyJokUTASWEP60w9y+M7emt+aK2MHPP6MJd/GvE0mOaZutZjJxwJ95/DdumxtREgVXTHS+wR8G/P55I9vkWxL6xjD0AT7ntIlMkfA2po8sse/XJXbb4xp/ENmCqTv+v6XLS7KD3z0Iqh0v086JUt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745701; c=relaxed/simple;
	bh=V20Ey94k8P4XKhtHW+sl/a+/V+5d5eW6eOddXqMuuo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ow8fUzn1DYgfBH8TfLQqZa6eVXZmCTYHA9wMVlcEnobAY4vi3lxRRhiLaTEfDkCAAio/1T1NgJg/Jresv818jaGWsfzKrS4+5bcgcZd+JEtygyP2LaBrJwkkk79nNYMVu6cB0qTgRtNfcE1WwP9PPLfpflQFFVcG+zrWO8ei+jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuxnJdsK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6b0a40721so43194445ad.2;
        Tue, 18 Jun 2024 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745698; x=1719350498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxUBSCfmbZ8sQtywXazFucYZlMUFu5s6Z4ZpQKMQAts=;
        b=FuxnJdsKHdeOFS1+cFxr4EHcM7do2jQT38v29Z+SBKTbqCEpUJaIr9pyKGYE/sYNSS
         su4ScdUi6ekC3bRZ/u1tESxfHrt4i9HZl3fvYWllfvoLfBzSFBttJvH64bVl08jS/msq
         Tn2C4OU7E4XDQ5RhOBjwxUp0qXmuxTUoMwLwP46rfAB6K5OeFCc1Xj86g2J6gpJ0dWce
         GeZKOwPxEROrkThlsNdQrqY9FCtYRQsgy3W33S62nPhomN9Yl0qoIxxIra3m7+eLUA5M
         ftvuyI6mE5AyZ34xtNCeaTI8P1NaxfkEkIZcLXSP6T1JZJ1LrEeHHKY4ei0TWk9bVe3+
         COCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745698; x=1719350498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZxUBSCfmbZ8sQtywXazFucYZlMUFu5s6Z4ZpQKMQAts=;
        b=dEEUr1GgFVnFd9KeMKFPom30g9BxCXQt4LA2oZJO2bvlr7C/GQRhR0Ec4TynYmanXN
         qfc09QIppMqA7x7fVvtLMErWHob5fd4q7WC4oXh39+Tneych5CpTVMcLSgKleDO12ihd
         S1W4+9AmhX0MP9kkR3wIlW6q9FVAAKFYASFK0I7bbjzj9hKS58WwT/44JU86z3iGlV/y
         KP2n559AgiTwREt9KGnPxlY2kIsgK5NTUVx4Oez9DOwaTyHQaZUHJBNNNeD2mS9gq3sa
         3wdjM5j5CaGY3n4FoWCpmCuwrusJj1N9hscD56mOTVvOliqD9UtQF0rKy0UR2SzGSvoa
         TCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGC4ZT+AwiBOPb56j2bFCzy91sG43N0SZ/2pnJ3uXRPzVc01TKacoHzWW5UkUP6fObleNoC+w3aChpqrCeAK0JvJXk
X-Gm-Message-State: AOJu0YxvCtkTQ5sc2YZt5BgOMtSJw3KnGyjxzhiS11izrl2N5XJEQYMp
	v6CmnZXBa+18SFGhpkoUL94PFOWbCYtMNaeNcI/lPSGws1WJdEvI
X-Google-Smtp-Source: AGHT+IHOlxQkixU6SI1wTaJohGz8q1M40hoQuucHYYlQF5dLnzScVjGyjWwc94bE5z6iXeSKeflBUg==
X-Received: by 2002:a17:903:250:b0:1f7:167d:e291 with SMTP id d9443c01a7336-1f9aa4632d5mr9147055ad.47.1718745697942;
        Tue, 18 Jun 2024 14:21:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e3csm102596495ad.1.2024.06.18.14.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:37 -0700 (PDT)
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
Subject: [PATCH 17/30] sched_ext: Implement scx_bpf_kick_cpu() and task preemption support
Date: Tue, 18 Jun 2024 11:17:32 -1000
Message-ID: <20240618212056.2833381-18-tj@kernel.org>
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

It's often useful to wake up and/or trigger reschedule on other CPUs. This
patch adds scx_bpf_kick_cpu() kfunc helper that BPF scheduler can call to
kick the target CPU into the scheduling path.

As a sched_ext task relinquishes its CPU only after its slice is depleted,
this patch also adds SCX_KICK_PREEMPT and SCX_ENQ_PREEMPT which clears the
slice of the target CPU's current task to guarantee that sched_ext's
scheduling path runs on the CPU.

If SCX_KICK_IDLE is specified, the target CPU is kicked iff the CPU is idle
to guarantee that the target CPU will go through at least one full sched_ext
scheduling cycle after the kicking. This can be used to wake up idle CPUs
without incurring unnecessary overhead if it isn't currently idle.

As a demonstration of how backward compatibility can be supported using BPF
CO-RE, tools/sched_ext/include/scx/compat.bpf.h is added. It provides
__COMPAT_scx_bpf_kick_cpu_IDLE() which uses SCX_KICK_IDLE if available or
becomes a regular kicking otherwise. This allows schedulers to use the new
SCX_KICK_IDLE while maintaining support for older kernels. The plan is to
temporarily use compat helpers to ease API updates and drop them after a few
kernel releases.

v5: - SCX_KICK_IDLE added. Note that this also adds a compat mechanism for
      schedulers so that they can support kernels without SCX_KICK_IDLE.
      This is useful as a demonstration of how new feature flags can be
      added in a backward compatible way.

    - kick_cpus_irq_workfn() reimplemented so that it touches the pending
      cpumasks only as necessary to reduce kicking overhead on machines with
      a lot of CPUs.

    - tools/sched_ext/include/scx/compat.bpf.h added.

v4: - Move example scheduler to its own patch.

v3: - Make scx_example_central switch all tasks by default.

    - Convert to BPF inline iterators.

v2: - Julia Lawall reported that scx_example_central can overflow the
      dispatch buffer and malfunction. As scheduling for other CPUs can't be
      handled by the automatic retry mechanism, fix by implementing an
      explicit overflow and retry handling.

    - Updated to use generic BPF cpumask helpers.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h                |   4 +
 kernel/sched/ext.c                       | 225 +++++++++++++++++++++--
 kernel/sched/sched.h                     |  10 +
 tools/sched_ext/include/scx/common.bpf.h |   1 +
 4 files changed, 227 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 85fb5dc725ef..3b2809b980ac 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -134,6 +134,10 @@ struct sched_ext_entity {
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
index 66bb9cf075f0..213793d086d7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -412,6 +412,14 @@ enum scx_enq_flags {
 
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
@@ -441,6 +449,24 @@ enum scx_pick_idle_cpu_flags {
 	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
 };
 
+enum scx_kick_flags {
+	/*
+	 * Kick the target CPU if idle. Guarantees that the target CPU goes
+	 * through at least one full scheduling cycle before going idle. If the
+	 * target CPU can be determined to be currently not idle and going to go
+	 * through a scheduling cycle before going idle, noop.
+	 */
+	SCX_KICK_IDLE		= 1LLU << 0,
+
+	/*
+	 * Preempt the current task and execute the dispatch path. If the
+	 * current task of the target CPU is an SCX task, its ->scx.slice is
+	 * cleared to zero before the scheduling path is invoked so that the
+	 * task expires and the dispatch path is invoked.
+	 */
+	SCX_KICK_PREEMPT	= 1LLU << 1,
+};
+
 enum scx_ops_enable_state {
 	SCX_OPS_PREPPING,
 	SCX_OPS_ENABLING,
@@ -1019,7 +1045,7 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 		}
 	}
 
-	if (enq_flags & SCX_ENQ_HEAD)
+	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_node, &dsq->list);
 	else
 		list_add_tail(&p->scx.dsq_node, &dsq->list);
@@ -1045,8 +1071,16 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 
 	if (is_local) {
 		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+		bool preempt = false;
+
+		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
+		    rq->curr->sched_class == &ext_sched_class) {
+			rq->curr->scx.slice = 0;
+			preempt = true;
+		}
 
-		if (sched_class_above(&ext_sched_class, rq->curr->sched_class))
+		if (preempt || sched_class_above(&ext_sched_class,
+						 rq->curr->sched_class))
 			resched_curr(rq);
 	} else {
 		raw_spin_unlock(&dsq->lock);
@@ -1872,8 +1906,10 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	bool has_tasks = false;
 
 	lockdep_assert_rq_held(rq);
+	rq->scx.flags |= SCX_RQ_BALANCING;
 
 	if (prev_on_scx) {
 		WARN_ON_ONCE(prev->scx.flags & SCX_TASK_BAL_KEEP);
@@ -1890,19 +1926,19 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 		    prev->scx.slice && !scx_ops_bypassing()) {
 			prev->scx.flags |= SCX_TASK_BAL_KEEP;
-			return 1;
+			goto has_tasks;
 		}
 	}
 
 	/* if there already are tasks to run, nothing to do */
 	if (rq->scx.local_dsq.nr)
-		return 1;
+		goto has_tasks;
 
 	if (consume_dispatch_q(rq, rf, &scx_dsq_global))
-		return 1;
+		goto has_tasks;
 
 	if (!SCX_HAS_OP(dispatch) || scx_ops_bypassing() || !scx_rq_online(rq))
-		return 0;
+		goto out;
 
 	dspc->rq = rq;
 	dspc->rf = rf;
@@ -1923,12 +1959,18 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 		flush_dispatch_buf(rq, rf);
 
 		if (rq->scx.local_dsq.nr)
-			return 1;
+			goto has_tasks;
 		if (consume_dispatch_q(rq, rf, &scx_dsq_global))
-			return 1;
+			goto has_tasks;
 	} while (dspc->nr_tasks);
 
-	return 0;
+	goto out;
+
+has_tasks:
+	has_tasks = true;
+out:
+	rq->scx.flags &= ~SCX_RQ_BALANCING;
+	return has_tasks;
 }
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
@@ -2666,7 +2708,8 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
  * Omitted operations:
  *
  * - wakeup_preempt: NOOP as it isn't useful in the wakeup path because the task
- *   isn't tied to the CPU at that point.
+ *   isn't tied to the CPU at that point. Preemption is implemented by resetting
+ *   the victim task's slice to 0 and triggering reschedule on the target CPU.
  *
  * - migrate_task_rq: Unnecessary as task to cpu mapping is transient.
  *
@@ -2902,6 +2945,9 @@ bool task_should_scx(struct task_struct *p)
  *    of the queue.
  *
  * d. pick_next_task() suppresses zero slice warning.
+ *
+ * e. scx_bpf_kick_cpu() is disabled to avoid irq_work malfunction during PM
+ *    operations.
  */
 static void scx_ops_bypass(bool bypass)
 {
@@ -3410,11 +3456,21 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		seq_buf_init(&ns, buf, avail);
 
 		dump_newline(&ns);
-		dump_line(&ns, "CPU %-4d: nr_run=%u ops_qseq=%lu",
-			  cpu, rq->scx.nr_running, rq->scx.ops_qseq);
+		dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x ops_qseq=%lu",
+			  cpu, rq->scx.nr_running, rq->scx.flags,
+			  rq->scx.ops_qseq);
 		dump_line(&ns, "          curr=%s[%d] class=%ps",
 			  rq->curr->comm, rq->curr->pid,
 			  rq->curr->sched_class);
+		if (!cpumask_empty(rq->scx.cpus_to_kick))
+			dump_line(&ns, "  cpus_to_kick   : %*pb",
+				  cpumask_pr_args(rq->scx.cpus_to_kick));
+		if (!cpumask_empty(rq->scx.cpus_to_kick_if_idle))
+			dump_line(&ns, "  idle_to_kick   : %*pb",
+				  cpumask_pr_args(rq->scx.cpus_to_kick_if_idle));
+		if (!cpumask_empty(rq->scx.cpus_to_preempt))
+			dump_line(&ns, "  cpus_to_preempt: %*pb",
+				  cpumask_pr_args(rq->scx.cpus_to_preempt));
 
 		used = seq_buf_used(&ns);
 		if (SCX_HAS_OP(dump_cpu)) {
@@ -4085,6 +4141,82 @@ static const struct sysrq_key_op sysrq_sched_ext_dump_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+static bool can_skip_idle_kick(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * We can skip idle kicking if @rq is going to go through at least one
+	 * full SCX scheduling cycle before going idle. Just checking whether
+	 * curr is not idle is insufficient because we could be racing
+	 * balance_one() trying to pull the next task from a remote rq, which
+	 * may fail, and @rq may become idle afterwards.
+	 *
+	 * The race window is small and we don't and can't guarantee that @rq is
+	 * only kicked while idle anyway. Skip only when sure.
+	 */
+	return !is_idle_task(rq->curr) && !(rq->scx.flags & SCX_RQ_BALANCING);
+}
+
+static void kick_one_cpu(s32 cpu, struct rq *this_rq)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct scx_rq *this_scx = &this_rq->scx;
+	unsigned long flags;
+
+	raw_spin_rq_lock_irqsave(rq, flags);
+
+	/*
+	 * During CPU hotplug, a CPU may depend on kicking itself to make
+	 * forward progress. Allow kicking self regardless of online state.
+	 */
+	if (cpu_online(cpu) || cpu == cpu_of(this_rq)) {
+		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
+			if (rq->curr->sched_class == &ext_sched_class)
+				rq->curr->scx.slice = 0;
+			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
+		}
+
+		resched_curr(rq);
+	} else {
+		cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
+	}
+
+	raw_spin_rq_unlock_irqrestore(rq, flags);
+}
+
+static void kick_one_cpu_if_idle(s32 cpu, struct rq *this_rq)
+{
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long flags;
+
+	raw_spin_rq_lock_irqsave(rq, flags);
+
+	if (!can_skip_idle_kick(rq) &&
+	    (cpu_online(cpu) || cpu == cpu_of(this_rq)))
+		resched_curr(rq);
+
+	raw_spin_rq_unlock_irqrestore(rq, flags);
+}
+
+static void kick_cpus_irq_workfn(struct irq_work *irq_work)
+{
+	struct rq *this_rq = this_rq();
+	struct scx_rq *this_scx = &this_rq->scx;
+	s32 cpu;
+
+	for_each_cpu(cpu, this_scx->cpus_to_kick) {
+		kick_one_cpu(cpu, this_rq);
+		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
+		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
+	}
+
+	for_each_cpu(cpu, this_scx->cpus_to_kick_if_idle) {
+		kick_one_cpu_if_idle(cpu, this_rq);
+		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
+	}
+}
+
 /**
  * print_scx_info - print out sched_ext scheduler state
  * @log_lvl: the log level to use when printing
@@ -4139,7 +4271,7 @@ void __init init_sched_ext_class(void)
 	 * definitions so that BPF scheduler implementations can use them
 	 * through the generated vmlinux.h.
 	 */
-	WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP);
+	WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP | SCX_KICK_PREEMPT);
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
@@ -4152,6 +4284,11 @@ void __init init_sched_ext_class(void)
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
+
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
@@ -4438,6 +4575,67 @@ static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
 
 __bpf_kfunc_start_defs();
 
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
+__bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
+{
+	struct rq *this_rq;
+	unsigned long irq_flags;
+
+	if (!ops_cpu_valid(cpu, NULL))
+		return;
+
+	/*
+	 * While bypassing for PM ops, IRQ handling may not be online which can
+	 * lead to irq_work_queue() malfunction such as infinite busy wait for
+	 * IRQ status update. Suppress kicking.
+	 */
+	if (scx_ops_bypassing())
+		return;
+
+	local_irq_save(irq_flags);
+
+	this_rq = this_rq();
+
+	/*
+	 * Actual kicking is bounced to kick_cpus_irq_workfn() to avoid nesting
+	 * rq locks. We can probably be smarter and avoid bouncing if called
+	 * from ops which don't hold a rq lock.
+	 */
+	if (flags & SCX_KICK_IDLE) {
+		struct rq *target_rq = cpu_rq(cpu);
+
+		if (unlikely(flags & SCX_KICK_PREEMPT))
+			scx_ops_error("PREEMPT cannot be used with SCX_KICK_IDLE");
+
+		if (raw_spin_rq_trylock(target_rq)) {
+			if (can_skip_idle_kick(target_rq)) {
+				raw_spin_rq_unlock(target_rq);
+				goto out;
+			}
+			raw_spin_rq_unlock(target_rq);
+		}
+		cpumask_set_cpu(cpu, this_rq->scx.cpus_to_kick_if_idle);
+	} else {
+		cpumask_set_cpu(cpu, this_rq->scx.cpus_to_kick);
+
+		if (flags & SCX_KICK_PREEMPT)
+			cpumask_set_cpu(cpu, this_rq->scx.cpus_to_preempt);
+	}
+
+	irq_work_queue(&this_rq->scx.kick_cpus_irq_work);
+out:
+	local_irq_restore(irq_flags);
+}
+
 /**
  * scx_bpf_dsq_nr_queued - Return the number of queued tasks
  * @dsq_id: id of the DSQ
@@ -4836,6 +5034,7 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
+BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2960e153c3a7..d9054eb4ba82 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -724,12 +724,22 @@ struct cfs_rq {
 };
 
 #ifdef CONFIG_SCHED_CLASS_EXT
+/* scx_rq->flags, protected by the rq lock */
+enum scx_rq_flags {
+	SCX_RQ_BALANCING	= 1 << 1,
+};
+
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
+	u32			flags;
+	cpumask_var_t		cpus_to_kick;
+	cpumask_var_t		cpus_to_kick_if_idle;
+	cpumask_var_t		cpus_to_preempt;
+	struct irq_work		kick_cpus_irq_work;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
 
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 3ea5cdf58bc7..421118bc56ff 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -34,6 +34,7 @@ void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flag
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
+void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
 void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
-- 
2.45.2



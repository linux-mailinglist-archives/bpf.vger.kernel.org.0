Return-Path: <bpf+bounces-28361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7675F8B8CBE
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F241F21A62
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2A21386A5;
	Wed,  1 May 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce4UMnsj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4118F137C2D;
	Wed,  1 May 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576464; cv=none; b=ApIUwT22g26ZaRYv4Q/M+V0u1FQBbecZR97H8SITTyjwIfToIGwmL5Mkug5TXr6u85WQMNwuGGedROFFumNsqDyrQSuqrBp/wHYuT5P+4GvBNyQ39TBG19nJmUYfZhISGgbjzkrg8HPP7LCosbe/F730md6Vy2Cj+Tq8cCmaB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576464; c=relaxed/simple;
	bh=/kWH+N9xmCh61LnCDruQP5XYz2s7cScXsbdYShAU0zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxjMJVO6PLXLcv4qr8FPb+zBX+OgxxJlGG71UOiYcVKVnOKwfKMFNz9aosVg48YyZGbrUTbT3UTQPE3+dJkOWtzYkBr9Y3TbpapxOynqdKb0l9tTB+kxGoZioe1fJfmcEZkbe+Yq2TU/Nklxll/nilErJlQZNImspS0GuWZsxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce4UMnsj; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ac16b59fbeso5778927a91.2;
        Wed, 01 May 2024 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576461; x=1715181261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=766b5bClntbBxqoKi1dHB4ZDApJIXfDdY9Swg4OphH0=;
        b=ce4UMnsj2jFkURGr2wtyuGmdsSttgv3vUrGv99NgqcSoKRy1ZKSlXZKKXKffPlE/uT
         jAb0xVcB/MmTd2bO7wtKwr/rovWr3NYNkUrVqjvuKQ7WxCMYWS4yJ8FIFE0CiRlhW7Yj
         +7BQUUr4JEggNnBeeEBfiK+w7cd7Sf1E+aDErIkSgMJ+N0gIiymeikt4QiI24TH0b+6J
         ROLCOx85W8y05zG3TRm5lGRBXyS9birkWe3Fz0sDiQtW1sKwGqPzS5xuE8qrgBLgYy4T
         YxsOPcSbiO0+vK8j0m3h5T5tut2hJ73s5tQatNJZK89sRV8fbQnnacr4wxNnFdaH01az
         mAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576461; x=1715181261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=766b5bClntbBxqoKi1dHB4ZDApJIXfDdY9Swg4OphH0=;
        b=VGX+f9TUKdV3QmzqfB6DEb1NLFLl4zxOJldfsy2mFIl0PTfmwlI2G48y/KHHqVeWCk
         h1XzjKPjPq52MjYLcXoUPoTF55BOpF17Th9gcq0DduuDKuKTOvCBtUbn8a7uRot9Qjtt
         V2HY5n8CYQqQZi/022CHKBBYcikumbYKJ8EWJLnr3j2LOy1oz0xWhCCbExT/jJFl2LRs
         KB+YsoQ8hwvGcisuMLa+TW5wUSa5ofQjW86D+z4cAZeP5aMgNzta0cmtpQqk2hd8DWxG
         9neCqGC9H2My56WIvcAnOiMgluXZd56cG7oMBUP/ZlruqWlIAzjM56GZ9C1QrmRxVQhN
         d6hg==
X-Forwarded-Encrypted: i=1; AJvYcCX2SP1SiWxQat9HLN347t71ZwucIi9fP6H7pQL2jBjEDMVOr2UnXfnYFBWj86JYU9lIXNQfKF45Njqwp3KtjV0Hx569
X-Gm-Message-State: AOJu0YzPJPj5hNgOC+8jBP7QzrRcQT0Ls8lbVvfj4S3XX6tlAEvTZ8Nl
	5ZFlJisTtx8IrMt3RIR0J93LAH2Ayk1g+p15FQCNVUP3TYyQrGlP
X-Google-Smtp-Source: AGHT+IE5Zuj8NNdRdBKenkFK0j46IkRQeUfX/UBHpxWBiflH0XCucimFEYEECacJx8DwxXvlAFwynA==
X-Received: by 2002:a17:90a:d44c:b0:2a5:badb:30ea with SMTP id cz12-20020a17090ad44c00b002a5badb30eamr2609182pjb.36.1714576461373;
        Wed, 01 May 2024 08:14:21 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090ace1600b002a67079c3absm1437217pju.42.2024.05.01.08.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:14:21 -0700 (PDT)
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
Subject: [PATCH 31/39] sched_ext: Implement sched_ext_ops.cpu_acquire/release()
Date: Wed,  1 May 2024 05:10:06 -1000
Message-ID: <20240501151312.635565-32-tj@kernel.org>
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

Scheduler classes are strictly ordered and when a higher priority class has
tasks to run, the lower priority ones lose access to the CPU. Being able to
monitor and act on these events are necessary for use cases includling
strict core-scheduling and latency management.

This patch adds two operations ops.cpu_acquire() and .cpu_release(). The
former is invoked when a CPU becomes available to the BPF scheduler and the
opposite for the latter. This patch also implements
scx_bpf_reenqueue_local() which can be called from .cpu_release() to trigger
requeueing of all tasks in the local dsq of the CPU so that the tasks can be
reassigned to other available CPUs.

scx_pair is updated to use .cpu_acquire/release() along with
%SCX_KICK_WAIT to make the pair scheduling guarantee strict even when a CPU
is preempted by a higher priority scheduler class.

scx_qmap is updated to use .cpu_acquire/release() to empty the local
dsq of a preempted CPU. A similar approach can be adopted by BPF schedulers
that want to have a tight control over latency.

v4: Use the new SCX_KICK_IDLE to wake up a CPU after re-enqueueing.

v3: Drop the const qualifier from scx_cpu_release_args.task. BPF enforces
    access control through the verifier, so the qualifier isn't actually
    operative and only gets in the way when interacting with various
    helpers.

v2: Add p->scx.kf_mask annotation to allow calling scx_bpf_reenqueue_local()
    from ops.cpu_release() nested inside ops.init() and other sleepable
    operations.

Signed-off-by: David Vernet <dvernet@meta.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h                |   4 +-
 kernel/sched/ext.c                       | 200 ++++++++++++++++++++++-
 kernel/sched/ext.h                       |   2 +
 kernel/sched/sched.h                     |   1 +
 tools/sched_ext/include/scx/common.bpf.h |   1 +
 tools/sched_ext/scx_qmap.bpf.c           |  37 ++++-
 tools/sched_ext/scx_qmap.c               |   4 +-
 7 files changed, 242 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 0a9f8e5a46af..1dc0182fb1c8 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -98,13 +98,15 @@ enum scx_kf_mask {
 	SCX_KF_UNLOCKED		= 0,	  /* not sleepable, not rq locked */
 	/* all non-sleepables may be nested inside SLEEPABLE */
 	SCX_KF_SLEEPABLE	= 1 << 0, /* sleepable init operations */
+	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
+	SCX_KF_CPU_RELEASE	= 1 << 1, /* ops.cpu_release() */
 	/* ops.dequeue (in REST) may be nested inside DISPATCH */
 	SCX_KF_DISPATCH		= 1 << 2, /* ops.dispatch() */
 	SCX_KF_ENQUEUE		= 1 << 3, /* ops.enqueue() and ops.select_cpu() */
 	SCX_KF_SELECT_CPU	= 1 << 4, /* ops.select_cpu() */
 	SCX_KF_REST		= 1 << 5, /* other rq-locked operations */
 
-	__SCX_KF_RQ_LOCKED	= SCX_KF_DISPATCH |
+	__SCX_KF_RQ_LOCKED	= SCX_KF_CPU_RELEASE | SCX_KF_DISPATCH |
 				  SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
 	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
 };
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 91c3d1851b45..9bc03533cf5e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -126,6 +126,32 @@ struct scx_cgroup_init_args {
 	u32			weight;
 };
 
+enum scx_cpu_preempt_reason {
+	/* next task is being scheduled by &sched_class_rt */
+	SCX_CPU_PREEMPT_RT,
+	/* next task is being scheduled by &sched_class_dl */
+	SCX_CPU_PREEMPT_DL,
+	/* next task is being scheduled by &sched_class_stop */
+	SCX_CPU_PREEMPT_STOP,
+	/* unknown reason for SCX being preempted */
+	SCX_CPU_PREEMPT_UNKNOWN,
+};
+
+/*
+ * Argument container for ops->cpu_acquire(). Currently empty, but may be
+ * expanded in the future.
+ */
+struct scx_cpu_acquire_args {};
+
+/* argument container for ops->cpu_release() */
+struct scx_cpu_release_args {
+	/* the reason the CPU was preempted */
+	enum scx_cpu_preempt_reason reason;
+
+	/* the task that's going to be scheduled on the CPU */
+	struct task_struct *task;
+};
+
 /**
  * struct sched_ext_ops - Operation table for BPF scheduler implementation
  *
@@ -339,6 +365,28 @@ struct sched_ext_ops {
 	 */
 	void (*update_idle)(s32 cpu, bool idle);
 
+	/**
+	 * cpu_acquire - A CPU is becoming available to the BPF scheduler
+	 * @cpu: The CPU being acquired by the BPF scheduler.
+	 * @args: Acquire arguments, see the struct definition.
+	 *
+	 * A CPU that was previously released from the BPF scheduler is now once
+	 * again under its control.
+	 */
+	void (*cpu_acquire)(s32 cpu, struct scx_cpu_acquire_args *args);
+
+	/**
+	 * cpu_release - A CPU is taken away from the BPF scheduler
+	 * @cpu: The CPU being released by the BPF scheduler.
+	 * @args: Release arguments, see the struct definition.
+	 *
+	 * The specified CPU is no longer under the control of the BPF
+	 * scheduler. This could be because it was preempted by a higher
+	 * priority sched_class, though there may be other reasons as well. The
+	 * caller should consult @args->reason to determine the cause.
+	 */
+	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
+
 	/**
 	 * init_task - Initialize a task to run in a BPF scheduler
 	 * @p: task to initialize for BPF scheduling
@@ -534,6 +582,17 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_PREEMPT		= 1LLU << 32,
 
+	/*
+	 * The task being enqueued was previously enqueued on the current CPU's
+	 * %SCX_DSQ_LOCAL, but was removed from it in a call to the
+	 * bpf_scx_reenqueue_local() kfunc. If bpf_scx_reenqueue_local() was
+	 * invoked in a ->cpu_release() callback, and the task is again
+	 * dispatched back to %SCX_LOCAL_DSQ by this current ->enqueue(), the
+	 * task will not be scheduled on the CPU until at least the next invocation
+	 * of the ->cpu_acquire() callback.
+	 */
+	SCX_ENQ_REENQ		= 1LLU << 40,
+
 	/*
 	 * The task being enqueued is the only task available for the cpu. By
 	 * default, ext core keeps executing such tasks but when
@@ -677,6 +736,7 @@ static bool scx_warned_zero_slice;
 
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
+DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 struct static_key_false scx_has_op[SCX_OPI_END] =
@@ -913,6 +973,12 @@ static __always_inline bool scx_kf_allowed(u32 mask)
 	 * inside ops.dispatch(). We don't need to check the SCX_KF_SLEEPABLE
 	 * boundary thanks to the above in_interrupt() check.
 	 */
+	if (unlikely(highest_bit(mask) == SCX_KF_CPU_RELEASE &&
+		     (current->scx.kf_mask & higher_bits(SCX_KF_CPU_RELEASE)))) {
+		scx_ops_error("cpu_release kfunc called from a nested operation");
+		return false;
+	}
+
 	if (unlikely(highest_bit(mask) == SCX_KF_DISPATCH &&
 		     (current->scx.kf_mask & higher_bits(SCX_KF_DISPATCH)))) {
 		scx_ops_error("dispatch kfunc called from a nested operation");
@@ -2097,6 +2163,19 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	lockdep_assert_rq_held(rq);
 	scx_rq->flags |= SCX_RQ_BALANCING;
 
+	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
+	    unlikely(rq->scx.cpu_released)) {
+		/*
+		 * If the previous sched_class for the current CPU was not SCX,
+		 * notify the BPF scheduler that it again has control of the
+		 * core. This callback complements ->cpu_release(), which is
+		 * emitted in scx_next_task_picked().
+		 */
+		if (SCX_HAS_OP(cpu_acquire))
+			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
+		rq->scx.cpu_released = false;
+	}
+
 	if (prev_on_scx) {
 		WARN_ON_ONCE(prev->scx.flags & SCX_TASK_BAL_KEEP);
 		update_curr_scx(rq);
@@ -2104,7 +2183,9 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 		/*
 		 * If @prev is runnable & has slice left, it has priority and
 		 * fetching more just increases latency for the fetched tasks.
-		 * Tell put_prev_task_scx() to put @prev on local_dsq.
+		 * Tell put_prev_task_scx() to put @prev on local_dsq. If the
+		 * BPF scheduler wants to handle this explicitly, it should
+		 * implement ->cpu_released().
 		 *
 		 * See scx_ops_disable_workfn() for the explanation on the
 		 * bypassing test.
@@ -2324,6 +2405,20 @@ static struct task_struct *pick_next_task_scx(struct rq *rq)
 	return p;
 }
 
+static enum scx_cpu_preempt_reason
+preempt_reason_from_class(const struct sched_class *class)
+{
+#ifdef CONFIG_SMP
+	if (class == &stop_sched_class)
+		return SCX_CPU_PREEMPT_STOP;
+#endif
+	if (class == &dl_sched_class)
+		return SCX_CPU_PREEMPT_DL;
+	if (class == &rt_sched_class)
+		return SCX_CPU_PREEMPT_RT;
+	return SCX_CPU_PREEMPT_UNKNOWN;
+}
+
 void scx_next_task_picked(struct rq *rq, struct task_struct *p,
 			  const struct sched_class *active)
 {
@@ -2339,6 +2434,40 @@ void scx_next_task_picked(struct rq *rq, struct task_struct *p,
 	 */
 	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
 #endif
+	if (!static_branch_unlikely(&scx_ops_cpu_preempt))
+		return;
+
+	/*
+	 * The callback is conceptually meant to convey that the CPU is no
+	 * longer under the control of SCX. Therefore, don't invoke the
+	 * callback if the CPU is is staying on SCX, or going idle (in which
+	 * case the SCX scheduler has actively decided not to schedule any
+	 * tasks on the CPU).
+	 */
+	if (likely(active >= &ext_sched_class))
+		return;
+
+	/*
+	 * At this point we know that SCX was preempted by a higher priority
+	 * sched_class, so invoke the ->cpu_release() callback if we have not
+	 * done so already. We only send the callback once between SCX being
+	 * preempted, and it regaining control of the CPU.
+	 *
+	 * ->cpu_release() complements ->cpu_acquire(), which is emitted the
+	 *  next time that balance_scx() is invoked.
+	 */
+	if (!rq->scx.cpu_released) {
+		if (SCX_HAS_OP(cpu_release)) {
+			struct scx_cpu_release_args args = {
+				.reason = preempt_reason_from_class(active),
+				.task = p,
+			};
+
+			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
+				    cpu_release, cpu_of(rq), &args);
+		}
+		rq->scx.cpu_released = true;
+	}
 }
 
 #ifdef CONFIG_SMP
@@ -3735,6 +3864,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 		static_branch_disable_cpuslocked(&scx_has_op[i]);
 	static_branch_disable_cpuslocked(&scx_ops_enq_last);
 	static_branch_disable_cpuslocked(&scx_ops_enq_exiting);
+	static_branch_disable_cpuslocked(&scx_ops_cpu_preempt);
 	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	synchronize_rcu();
 
@@ -3894,9 +4024,10 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		    rq->curr->sched_class == &idle_sched_class)
 			goto next;
 
-		seq_buf_printf(&s, "\nCPU %-4d: nr_run=%u flags=0x%x ops_qseq=%lu pnt_seq=%lu\n",
+		seq_buf_printf(&s, "\nCPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu pnt_seq=%lu\n",
 			       cpu, rq->scx.nr_running, rq->scx.flags,
-			       rq->scx.ops_qseq, rq->scx.pnt_seq);
+			       rq->scx.cpu_released, rq->scx.ops_qseq,
+			       rq->scx.pnt_seq);
 		seq_buf_printf(&s, "          curr=%s[%d] class=%ps\n",
 			       rq->curr->comm, rq->curr->pid,
 			       rq->curr->sched_class);
@@ -4117,6 +4248,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 
 	if (ops->flags & SCX_OPS_ENQ_EXITING)
 		static_branch_enable_cpuslocked(&scx_ops_enq_exiting);
+	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
+		static_branch_enable_cpuslocked(&scx_ops_cpu_preempt);
 
 	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
 		reset_idle_masks();
@@ -4512,6 +4645,8 @@ static bool yield_stub(struct task_struct *from, struct task_struct *to) { retur
 static void set_weight_stub(struct task_struct *p, u32 weight) {}
 static void set_cpumask_stub(struct task_struct *p, const struct cpumask *mask) {}
 static void update_idle_stub(s32 cpu, bool idle) {}
+static void cpu_acquire_stub(s32 cpu, struct scx_cpu_acquire_args *args) {}
+static void cpu_release_stub(s32 cpu, struct scx_cpu_release_args *args) {}
 static s32 init_task_stub(struct task_struct *p, struct scx_init_task_args *args) { return -EINVAL; }
 static void exit_task_stub(struct task_struct *p, struct scx_exit_task_args *args) {}
 static void enable_stub(struct task_struct *p) {}
@@ -4540,6 +4675,8 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.set_weight = set_weight_stub,
 	.set_cpumask = set_cpumask_stub,
 	.update_idle = update_idle_stub,
+	.cpu_acquire = cpu_acquire_stub,
+	.cpu_release = cpu_release_stub,
 	.init_task = init_task_stub,
 	.exit_task = exit_task_stub,
 	.enable = enable_stub,
@@ -5068,6 +5205,61 @@ static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
 
 __bpf_kfunc_start_defs();
 
+/**
+ * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
+ *
+ * Iterate over all of the tasks currently enqueued on the local DSQ of the
+ * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the number of
+ * processed tasks. Can only be called from ops.cpu_release().
+ */
+__bpf_kfunc u32 scx_bpf_reenqueue_local(void)
+{
+	u32 nr_enqueued, i;
+	struct rq *rq;
+	struct scx_rq *scx_rq;
+
+	if (!scx_kf_allowed(SCX_KF_CPU_RELEASE))
+		return 0;
+
+	rq = cpu_rq(smp_processor_id());
+	lockdep_assert_rq_held(rq);
+	scx_rq = &rq->scx;
+
+	/*
+	 * Get the number of tasks on the local DSQ before iterating over it to
+	 * pull off tasks. The enqueue callback below can signal that it wants
+	 * the task to stay on the local DSQ, and we want to prevent the BPF
+	 * scheduler from causing us to loop indefinitely.
+	 */
+	nr_enqueued = scx_rq->local_dsq.nr;
+	for (i = 0; i < nr_enqueued; i++) {
+		struct task_struct *p;
+
+		p = first_local_task(rq);
+		WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) !=
+			     SCX_OPSS_NONE);
+		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
+		WARN_ON_ONCE(p->scx.holding_cpu != -1);
+		dispatch_dequeue(scx_rq, p);
+		do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
+	}
+
+	return nr_enqueued;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_cpu_release)
+BTF_ID_FLAGS(func, scx_bpf_reenqueue_local)
+BTF_KFUNCS_END(scx_kfunc_ids_cpu_release)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_cpu_release = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_cpu_release,
+};
+
+__bpf_kfunc_start_defs();
+
 /**
  * scx_bpf_kick_cpu - Trigger reschedule on a CPU
  * @cpu: cpu to kick
@@ -5563,6 +5755,8 @@ static int __init scx_init(void)
 					     &scx_kfunc_set_enqueue_dispatch)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_dispatch)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_cpu_release)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_any)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 5db35f627ea3..10f4717839c0 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -24,6 +24,8 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
 #define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
 
+DECLARE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
+
 static inline bool task_on_scx(const struct task_struct *p)
 {
 	return scx_enabled() && p->sched_class == &ext_sched_class;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8cf6fbaed07..e8ef7309f347 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -732,6 +732,7 @@ struct scx_rq {
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
 	u32			flags;
+	bool			cpu_released;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index f0dbaa1826a7..a3979e13aade 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -34,6 +34,7 @@ void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flag
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
+u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 812004bf027a..7c3b0dcae1e0 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -11,6 +11,8 @@
  *
  * - BPF-side queueing using PIDs.
  * - Sleepable per-task storage allocation using ops.prep_enable().
+ * - Using ops.cpu_release() to handle a higher priority scheduling class taking
+ *   the CPU away.
  *
  * This scheduler is primarily for demonstration and testing of sched_ext
  * features and unlikely to be useful for actual workloads.
@@ -90,7 +92,7 @@ struct {
 } cpu_ctx_stor SEC(".maps");
 
 /* Statistics */
-u64 nr_enqueued, nr_dispatched, nr_dequeued;
+u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
 
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
@@ -164,6 +166,22 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
+	/*
+	 * If the task was re-enqueued due to the CPU being preempted by a
+	 * higher priority scheduling class, just re-enqueue the task directly
+	 * on the global DSQ. As we want another CPU to pick it up, find and
+	 * kick an idle CPU.
+	 */
+	if (enq_flags & SCX_ENQ_REENQ) {
+		s32 cpu;
+
+		scx_bpf_dispatch(p, SHARED_DSQ, 0, enq_flags);
+		cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+		if (cpu >= 0)
+			scx_bpf_kick_cpu(cpu, __COMPAT_SCX_KICK_IDLE);
+		return;
+	}
+
 	ring = bpf_map_lookup_elem(&queue_arr, &idx);
 	if (!ring) {
 		scx_bpf_error("failed to find ring %d", idx);
@@ -257,6 +275,22 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	}
 }
 
+void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
+{
+	u32 cnt;
+
+	/*
+	 * Called when @cpu is taken by a higher priority scheduling class. This
+	 * makes @cpu no longer available for executing sched_ext tasks. As we
+	 * don't want the tasks in @cpu's local dsq to sit there until @cpu
+	 * becomes available again, re-enqueue them into the global dsq. See
+	 * %SCX_ENQ_REENQ handling in qmap_enqueue().
+	 */
+	cnt = scx_bpf_reenqueue_local();
+	if (cnt)
+		__sync_fetch_and_add(&nr_reenqueued, cnt);
+}
+
 s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
 		   struct scx_init_task_args *args)
 {
@@ -292,6 +326,7 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .enqueue			= (void *)qmap_enqueue,
 	       .dequeue			= (void *)qmap_dequeue,
 	       .dispatch		= (void *)qmap_dispatch,
+	       .cpu_release		= (void *)qmap_cpu_release,
 	       .init_task		= (void *)qmap_init_task,
 	       .init			= (void *)qmap_init,
 	       .exit			= (void *)qmap_exit,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 36254631589e..048b31eed17d 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -109,9 +109,9 @@ int main(int argc, char **argv)
 		long nr_enqueued = skel->bss->nr_enqueued;
 		long nr_dispatched = skel->bss->nr_dispatched;
 
-		printf("stats  : enq=%lu dsp=%lu delta=%ld deq=%"PRIu64"\n",
+		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq=%"PRIu64" deq=%"PRIu64"\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
-		       skel->bss->nr_dequeued);
+		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued);
 		fflush(stdout);
 		sleep(1);
 	}
-- 
2.44.0



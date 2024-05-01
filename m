Return-Path: <bpf+bounces-28346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC798B8C9C
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E47283D6F
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37286132C3D;
	Wed,  1 May 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhXTzZ9v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09B13280B;
	Wed,  1 May 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576434; cv=none; b=aoLI5Jg+ilXyLG/I5VM2UxvL4gE/fjjI6y8HiKaEjsEFX/w3rgrUlkftyy0Mkb+Oks0GvKEiCvQWuDiqVh1xlxlQxhbOJ3RKusvDu8HwfIuSWuPTshsPkizzgIQ1E6tk4ZnTpFLf5hc72eVMN6eSnkLRjx+Au9QQ7xDJraaHY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576434; c=relaxed/simple;
	bh=hTWGMwnLNbolY65jm7WaoXjz0KMEIKy2EGrvugZxnUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFKbrHIcH9RSS8dJ6koi3LtgJ3NwqsgvZR5COlFN0whx4cZDxAHoAd4l2bFGk0U7AV9r8TIvD8IlWLcVRji2YqBEj3AQ4E5HqyqyujfCl/732ajwQVugvESa/1uvCfq+nHCNJh6fNyu2BYSZrZMIVOOzDeheGFfArmPRPArsUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhXTzZ9v; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso4673125b3a.1;
        Wed, 01 May 2024 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576432; x=1715181232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIV+8Ils3ou4osXH2rvIVqHVP+SWwSxOwG9mYE7onJc=;
        b=nhXTzZ9vzi4N+XomuR5iUvdvKA/gcfi1FtKyqNlAGCKUeVsieBUdEtphU/+j6Z1CWJ
         NGka407g2GmyWQRL9/slyAsWcgi2dKhp0fjR/PuEOosSo3WdMUB5b7y92t+IUHSpx6o2
         nuPB70Hm/vD4GcVluw39tFrOL2VrMrwW0yuz/djGez23Fi5yhmFmFOmQ4OX4CmuQCJTb
         Dr34DXS2QKAbFpXN3azx5BBC08DGTqrt5FZFHyBqO6FkrgQhbvLnQYzFZRAxyGWOgcMJ
         OBE61SFE5ocezJpqMZ7e2rXFpOOCrwezPE2x4TxUece6Shgi2h0ase9vsFdff8VYi3/N
         nIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576432; x=1715181232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIV+8Ils3ou4osXH2rvIVqHVP+SWwSxOwG9mYE7onJc=;
        b=IlqEgiBYBsE1AE9iOgrWJtUMRd0YkdG8tpPAaeky8Jo/BwcbNXPlsJ//Ih3HoEnuIe
         JHGKNxynAT4P7x9wlefprjgfAKKzUMPs3r6UskUAROjGoRRAEMsuf4HHGMcF0cIjc5jr
         hXdUbg7wxXB5jWhDgOiLKPY6ieuMr+WjoPlvPlap/UNLnCcrTWu0McwgAML8g7duOeDS
         XfBrGr+dqyrWT5Nlb1RXT3VAnlNjvOy1LkCW+XBF4UlUZUZZzmzuf8jlQIwnhs+cqv68
         ZTbTmUd6XB6TxEpuzNufG68DSsGpRjLk5HmuGPMri+R0JAgyLVkDoWt+0yAqabZsnwCZ
         6oqw==
X-Forwarded-Encrypted: i=1; AJvYcCUPD9KKKxvEj1m1lz3TFsLYcS995sxszPP6+cKo5lniFn35iRVHEppLFlqUoefSknoATzXBw7bFaz1MNK4M0A8ntccd
X-Gm-Message-State: AOJu0YwWpfJU8gqf0M9Mk1DPIAeFcsY/3LyHc0RzjLp0OXa4TTABE0TZ
	Y7z0UTEGEQougR92STodop4vXkjvFFzdUyFVxaMG2CGLwr3sHVVL
X-Google-Smtp-Source: AGHT+IEmw1ODbWcjyYXCOq5j7ictGfQYDIYgx1XE1L2dWpaT19alO5ozfmTAVHuZIUxlygzvQuKvfw==
X-Received: by 2002:a05:6a00:1acb:b0:6ea:f444:341b with SMTP id f11-20020a056a001acb00b006eaf444341bmr3462761pfv.1.1714576431713;
        Wed, 01 May 2024 08:13:51 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id fv7-20020a056a00618700b006f3f5d3595fsm6797777pfb.80.2024.05.01.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:51 -0700 (PDT)
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
	Tejun Heo <tj@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH 17/39] sched_ext: Implement runnable task stall watchdog
Date: Wed,  1 May 2024 05:09:52 -1000
Message-ID: <20240501151312.635565-18-tj@kernel.org>
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

The most common and critical way that a BPF scheduler can misbehave is by
failing to run runnable tasks for too long. This patch implements a
watchdog.

* All tasks record when they become runnable.

* A watchdog work periodically scans all runnable tasks. If any task has
  stayed runnable for too long, the BPF scheduler is aborted.

* scheduler_tick() monitors whether the watchdog itself is stuck. If so, the
  BPF scheduler is aborted.

Because the watchdog only scans the tasks which are currently runnable and
usually very infrequently, the overhead should be negligible.
scx_qmap is updated so that it can be told to stall user and/or
kernel tasks.

A detected task stall looks like the following:

 sched_ext: BPF scheduler "qmap" errored, disabling
 sched_ext: runnable task stall (dbus-daemon[953] failed to run for 6.478s)
    scx_check_timeout_workfn+0x10e/0x1b0
    process_one_work+0x287/0x560
    worker_thread+0x234/0x420
    kthread+0xe9/0x100
    ret_from_fork+0x1f/0x30

A detected watchdog stall:

 sched_ext: BPF scheduler "qmap" errored, disabling
 sched_ext: runnable task stall (watchdog failed to check in for 5.001s)
    scheduler_tick+0x2eb/0x340
    update_process_times+0x7a/0x90
    tick_sched_timer+0xd8/0x130
    __hrtimer_run_queues+0x178/0x3b0
    hrtimer_interrupt+0xfc/0x390
    __sysvec_apic_timer_interrupt+0xb7/0x2b0
    sysvec_apic_timer_interrupt+0x90/0xb0
    asm_sysvec_apic_timer_interrupt+0x1b/0x20
    default_idle+0x14/0x20
    arch_cpu_idle+0xf/0x20
    default_idle_call+0x50/0x90
    do_idle+0xe8/0x240
    cpu_startup_entry+0x1d/0x20
    kernel_init+0x0/0x190
    start_kernel+0x0/0x392
    start_kernel+0x324/0x392
    x86_64_start_reservations+0x2a/0x2c
    x86_64_start_kernel+0x104/0x109
    secondary_startup_64_no_verify+0xce/0xdb

Note that this patch exposes scx_ops_error[_type]() in kernel/sched/ext.h to
inline scx_notify_sched_tick().

v4: - While disabling, cancel_delayed_work_sync(&scx_watchdog_work) was
      being called before forward progress was guaranteed and thus could
      lead to system lockup. Relocated.

    - While enabling, it was comparing msecs against jiffies without
      conversion leading to spurious load failures on lower HZ kernels.
      Fixed.

    - runnable list management is now used by core bypass logic and moved to
      the patch implementing sched_ext core.

v3: - bpf_scx_init_member() was incorrectly comparing ops->timeout_ms
      against SCX_WATCHDOG_MAX_TIMEOUT which is in jiffies without
      conversion leading to spurious load failures in lower HZ kernels.
      Fixed.

v2: - Julia Lawall noticed that the watchdog code was mixing msecs and
      jiffies. Fix by using jiffies for everything.

Signed-off-by: David Vernet <dvernet@meta.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
---
 include/linux/sched/ext.h      |   1 +
 init/init_task.c               |   1 +
 kernel/sched/core.c            |   1 +
 kernel/sched/ext.c             | 130 ++++++++++++++++++++++++++++++++-
 kernel/sched/ext.h             |   2 +
 tools/sched_ext/scx_qmap.bpf.c |  12 +++
 tools/sched_ext/scx_qmap.c     |  12 ++-
 7 files changed, 153 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 65b1740a9a07..6a5a10092fb3 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -122,6 +122,7 @@ struct sched_ext_entity {
 	atomic_long_t		ops_state;
 
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
+	unsigned long		runnable_at;
 
 	u64			ddsp_dsq_id;
 	u64			ddsp_enq_flags;
diff --git a/init/init_task.c b/init/init_task.c
index ef349ebe52f8..b85635b7eed0 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -105,6 +105,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 		.sticky_cpu	= -1,
 		.holding_cpu	= -1,
 		.runnable_node	= LIST_HEAD_INIT(init_task.scx.runnable_node),
+		.runnable_at	= INITIAL_JIFFIES,
 		.ddsp_dsq_id	= SCX_DSQ_INVALID,
 		.slice		= SCX_SLICE_DFL,
 	},
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ef8fa67c58de..5b921725e6b2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5733,6 +5733,7 @@ void scheduler_tick(void)
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
 	task_tick_mm_cid(rq, curr);
+	scx_tick(rq);
 
 	rq_unlock(rq, &rf);
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e017b79aa1e7..63f47a9e1262 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8,6 +8,7 @@
 
 enum scx_consts {
 	SCX_DSP_DFL_MAX_BATCH		= 32,
+	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
 
 	SCX_EXIT_BT_LEN			= 64,
 	SCX_EXIT_MSG_LEN		= 1024,
@@ -24,6 +25,7 @@ enum scx_exit_kind {
 
 	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
 	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
+	SCX_EXIT_ERROR_STALL,	/* watchdog detected stalled runnable tasks */
 };
 
 /*
@@ -319,6 +321,15 @@ struct sched_ext_ops {
 	 */
 	u64 flags;
 
+	/**
+	 * timeout_ms - The maximum amount of time, in milliseconds, that a
+	 * runnable task should be able to wait before being scheduled. The
+	 * maximum timeout may not exceed the default timeout of 30 seconds.
+	 *
+	 * Defaults to the maximum allowed timeout value of 30 seconds.
+	 */
+	u32 timeout_ms;
+
 	/**
 	 * name - BPF scheduler's name
 	 *
@@ -472,6 +483,23 @@ struct static_key_false scx_has_op[SCX_OPI_END] =
 static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
 static struct scx_exit_info *scx_exit_info;
 
+/*
+ * The maximum amount of time in jiffies that a task may be runnable without
+ * being scheduled on a CPU. If this timeout is exceeded, it will trigger
+ * scx_ops_error().
+ */
+static unsigned long scx_watchdog_timeout;
+
+/*
+ * The last time the delayed work was run. This delayed work relies on
+ * ksoftirqd being able to run to service timer interrupts, so it's possible
+ * that this work itself could get wedged. To account for this, we check that
+ * it's not stalled in the timer tick, and trigger an error if it is.
+ */
+static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
+
+static struct delayed_work scx_watchdog_work;
+
 /* idle tracking */
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
@@ -1158,6 +1186,11 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 {
 	lockdep_assert_rq_held(rq);
 
+	if (p->scx.flags & SCX_TASK_RESET_RUNNABLE_AT) {
+		p->scx.runnable_at = jiffies;
+		p->scx.flags &= ~SCX_TASK_RESET_RUNNABLE_AT;
+	}
+
 	/*
 	 * list_add_tail() must be used. scx_ops_bypass() depends on tasks being
 	 * appened to the runnable_list.
@@ -1165,9 +1198,11 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
 }
 
-static void clr_task_runnable(struct task_struct *p)
+static void clr_task_runnable(struct task_struct *p, bool reset_runnable_at)
 {
 	list_del_init(&p->scx.runnable_node);
+	if (reset_runnable_at)
+		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 }
 
 static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
@@ -1205,7 +1240,8 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 {
 	unsigned long opss;
 
-	clr_task_runnable(p);
+	/* dequeue is always temporary, don't reset runnable_at */
+	clr_task_runnable(p, false);
 
 	/* acquire ensures that we see the preceding updates on QUEUED */
 	opss = atomic_long_read_acquire(&p->scx.ops_state);
@@ -1818,7 +1854,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	clr_task_runnable(p);
+	clr_task_runnable(p, true);
 }
 
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
@@ -2168,9 +2204,71 @@ static void reset_idle_masks(void) {}
 
 #endif	/* CONFIG_SMP */
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static bool check_rq_for_timeouts(struct rq *rq)
+{
+	struct task_struct *p;
+	struct rq_flags rf;
+	bool timed_out = false;
+
+	rq_lock_irqsave(rq, &rf);
+	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node) {
+		unsigned long last_runnable = p->scx.runnable_at;
+
+		if (unlikely(time_after(jiffies,
+					last_runnable + scx_watchdog_timeout))) {
+			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
+
+			scx_ops_error_kind(SCX_EXIT_ERROR_STALL,
+					   "%s[%d] failed to run for %u.%03us",
+					   p->comm, p->pid,
+					   dur_ms / 1000, dur_ms % 1000);
+			timed_out = true;
+			break;
+		}
+	}
+	rq_unlock_irqrestore(rq, &rf);
+
+	return timed_out;
+}
+
+static void scx_watchdog_workfn(struct work_struct *work)
+{
+	int cpu;
+
+	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
+
+	for_each_online_cpu(cpu) {
+		if (unlikely(check_rq_for_timeouts(cpu_rq(cpu))))
+			break;
+
+		cond_resched();
+	}
+	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
+			   scx_watchdog_timeout / 2);
+}
+
+void scx_tick(struct rq *rq)
 {
+	unsigned long last_check;
+
+	if (!scx_enabled())
+		return;
+
+	last_check = READ_ONCE(scx_watchdog_timestamp);
+	if (unlikely(time_after(jiffies,
+				last_check + READ_ONCE(scx_watchdog_timeout)))) {
+		u32 dur_ms = jiffies_to_msecs(jiffies - last_check);
+
+		scx_ops_error_kind(SCX_EXIT_ERROR_STALL,
+				   "watchdog failed to check in for %u.%03us",
+				   dur_ms / 1000, dur_ms % 1000);
+	}
+
 	update_other_load_avgs(rq);
+}
+
+static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+{
 	update_curr_scx(rq);
 
 	/*
@@ -2240,6 +2338,7 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 
 	scx_set_task_state(p, SCX_TASK_INIT);
 
+	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 	return 0;
 }
 
@@ -2318,6 +2417,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	scx->sticky_cpu = -1;
 	scx->holding_cpu = -1;
 	INIT_LIST_HEAD(&scx->runnable_node);
+	scx->runnable_at = jiffies;
 	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
 	scx->slice = SCX_SLICE_DFL;
 }
@@ -2774,6 +2874,8 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 		return "runtime error";
 	case SCX_EXIT_ERROR_BPF:
 		return "scx_bpf_error";
+	case SCX_EXIT_ERROR_STALL:
+		return "runnable task stall";
 	default:
 		return "<UNKNOWN>";
 	}
@@ -2883,6 +2985,8 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	if (scx_ops.exit)
 		SCX_CALL_OP(SCX_KF_UNLOCKED, exit, ei);
 
+	cancel_delayed_work_sync(&scx_watchdog_work);
+
 	/*
 	 * Delete the kobject from the hierarchy eagerly in addition to just
 	 * dropping a reference. Otherwise, if the object is deleted
@@ -3005,6 +3109,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 {
 	struct scx_task_iter sti;
 	struct task_struct *p;
+	unsigned long timeout;
 	int i, ret;
 
 	mutex_lock(&scx_ops_enable_mutex);
@@ -3081,6 +3186,16 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		goto err_disable;
 	}
 
+	if (ops->timeout_ms)
+		timeout = msecs_to_jiffies(ops->timeout_ms);
+	else
+		timeout = SCX_WATCHDOG_MAX_TIMEOUT;
+
+	WRITE_ONCE(scx_watchdog_timeout, timeout);
+	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
+	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
+			   scx_watchdog_timeout / 2);
+
 	/*
 	 * Lock out forks before opening the floodgate so that they don't wander
 	 * into the operations prematurely.
@@ -3393,6 +3508,12 @@ static int bpf_scx_init_member(const struct btf_type *t,
 		if (ret == 0)
 			return -EINVAL;
 		return 1;
+	case offsetof(struct sched_ext_ops, timeout_ms):
+		if (msecs_to_jiffies(*(u32 *)(udata + moff)) >
+		    SCX_WATCHDOG_MAX_TIMEOUT)
+			return -E2BIG;
+		ops->timeout_ms = *(u32 *)(udata + moff);
+		return 1;
 	}
 
 	return 0;
@@ -3549,6 +3670,7 @@ void __init init_sched_ext_class(void)
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
+	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
 }
 
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 328abf5445b1..0a8717b306ba 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -29,6 +29,7 @@ static inline bool task_on_scx(const struct task_struct *p)
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
+void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
 int scx_fork(struct task_struct *p);
@@ -75,6 +76,7 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 #define scx_enabled()		false
 #define scx_switched_all()	false
 
+static inline void scx_tick(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index ad0328bb3c6a..927c4cd8b218 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -29,6 +29,8 @@ enum consts {
 char _license[] SEC("license") = "GPL";
 
 const volatile u64 slice_ns = SCX_SLICE_DFL;
+const volatile u32 stall_user_nth;
+const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_batch;
 const volatile bool switch_partial;
 
@@ -130,11 +132,20 @@ static int weight_to_idx(u32 weight)
 
 void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 {
+	static u32 user_cnt, kernel_cnt;
 	struct task_ctx *tctx;
 	u32 pid = p->pid;
 	int idx = weight_to_idx(p->scx.weight);
 	void *ring;
 
+	if (p->flags & PF_KTHREAD) {
+		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
+			return;
+	} else {
+		if (stall_user_nth && !(++user_cnt % stall_user_nth))
+			return;
+	}
+
 	if (test_error_cnt && !--test_error_cnt)
 		scx_bpf_error("test triggering error");
 
@@ -265,4 +276,5 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .init_task		= (void *)qmap_init_task,
 	       .init			= (void *)qmap_init,
 	       .exit			= (void *)qmap_exit,
+	       .timeout_ms		= 5000U,
 	       .name			= "qmap");
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 1c0455c64f64..bce3f826cd6f 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -19,10 +19,12 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT] [-b COUNT] [-p] [-v]\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-b COUNT] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
+"  -t COUNT      Stall every COUNT'th user thread\n"
+"  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -v            Print libbpf debug messages\n"
@@ -55,7 +57,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:b:pvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:b:pvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -63,6 +65,12 @@ int main(int argc, char **argv)
 		case 'e':
 			skel->bss->test_error_cnt = strtoul(optarg, NULL, 0);
 			break;
+		case 't':
+			skel->rodata->stall_user_nth = strtoul(optarg, NULL, 0);
+			break;
+		case 'T':
+			skel->rodata->stall_kernel_nth = strtoul(optarg, NULL, 0);
+			break;
 		case 'b':
 			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
 			break;
-- 
2.44.0



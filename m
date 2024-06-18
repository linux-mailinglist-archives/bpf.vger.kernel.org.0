Return-Path: <bpf+bounces-32446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8BE90DE30
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7D92863A6
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8E418E77F;
	Tue, 18 Jun 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQG1fyuo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8818E751;
	Tue, 18 Jun 2024 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745690; cv=none; b=Ya3ODJmasshgHA7uZAdObhTyNK1lDv56NvCCGYMhlTyQqNI46y58L/biU5mvN4PtYIjmIKmAV9KuVY8a6Hksy2ZZSMa7CaC6pSJiK9TUGbmaC7tTZfZJBTcwc3gGZD3UroxcHE4Pon/LtwPnBzu4XonLXN+Te4q5MYBYTM39Csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745690; c=relaxed/simple;
	bh=isPgjGCj5VYkz8kph0fDAf8QGlImi3qrAKr2bOn5Mw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5xC3AfIluf/duuQ4CekKnkH5wtu4jytk6XB+HM7U0ctxRLeBrjVTiSbSpwR+gBxlYiLZlwUgGobEGMp50iysaZTi1cHohQe5cYrnoZPXlXqfOPkmq20QVlUpgQ4Tdc+8YZzYQPW2xM82V8tvLA6lB/Hn8AAMF69JmvaSbVT+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQG1fyuo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c7b3c513f9so352988a91.3;
        Tue, 18 Jun 2024 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745688; x=1719350488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOFAkzKC0puX6BIl4C+hN/L4RbIVfW4dE2cuXneFTqQ=;
        b=kQG1fyuoA0wrmi/ytjhrr1+8ypDqOrMFlYteMrSeWRkO9auzctkz6TZwHPaWnU/V9b
         1KvE/jFMgqcC0iUSwe9ZKbBysSV84teqyGqTsaG2iWaecA3o4705CrWfO3r6tXQHgw6K
         UsFPwIUQfZ5c2lu8d2WqhYao1dpINgM+nbzKd3xjpWBqwkmlpiEds1eTPctSsCIZO7zd
         T66VP0zGRlKIzOyvUKutA+PdDUTkwSeQFOUiwh9iUT+5t8r0FXex3NPVJuQSslESv7Zm
         xF9lEb0P0eaVBCmH5nkWTyZ6ae84I4AKFEeQpPyWVVhdJUuGhiSyGZOFCWPffsYOvIzy
         Ro5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745688; x=1719350488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOFAkzKC0puX6BIl4C+hN/L4RbIVfW4dE2cuXneFTqQ=;
        b=swZC6QbW1ody6Prf/kkdVF5zdzGLiBEh8dxGN/Ue5A88fWzlkaUAX5NW/853IhY4CE
         ZgBrV32VAzPFH7GCxG387iUyQr5d9oQt/+4bn/Z/8T+EJjNdI/9yKOSx9K63dnLAVeM6
         /VgWk58Plaj+m5GPYcBfce92tKTyg2FJdf2mIYlNlqmsnDluEqvF5Tgx0s1GZUB0NmHy
         OidUuGYeK4IOd77D3cGcrtvjMwKQUhx1BG0nbULmu8cu5cqSjemyUZVJmEDUbTKw61lU
         Ia1C4hfqnk5SHCkrcyyK8vatgwzzUSIX7hqveSFs6fQzlvzzA5qLGqeqXC90ai1UY8W9
         uIaw==
X-Forwarded-Encrypted: i=1; AJvYcCVTClZ3T80Hgtf5NAE0annFEUnMSBOHEVjRHLkJWaU7jiuhOv1ficXkGSBFffXeyq5Qc04vjAkZxlZZqsa3KrShMtm9
X-Gm-Message-State: AOJu0YwTcZvfl9yFnWhL2vcuX7vVzNJKgiMXsL5irprWSomthn4ImKw6
	/XlQrcHQfpbvXa4dNxl2m+VxXQaBzcOHlQb24auFtar3p7eLjOzf
X-Google-Smtp-Source: AGHT+IHhECxNjxY3MuUeaQfDNgwMOMAbh1KW+wo9V7wXEl43G8DJRohFRaD7uYWVWddJ7rO2eRddOQ==
X-Received: by 2002:a17:90a:12cf:b0:2c2:deda:8561 with SMTP id 98e67ed59e1d1-2c7b5dc9665mr844324a91.41.1718745687952;
        Tue, 18 Jun 2024 14:21:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c4671099sm11336457a91.38.2024.06.18.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:27 -0700 (PDT)
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
Subject: [PATCH 12/30] sched_ext: Implement runnable task stall watchdog
Date: Tue, 18 Jun 2024 11:17:27 -1000
Message-ID: <20240618212056.2833381-13-tj@kernel.org>
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
index c1530a7992cc..96031252436f 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -122,6 +122,7 @@ struct sched_ext_entity {
 	atomic_long_t		ops_state;
 
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
+	unsigned long		runnable_at;
 
 	u64			ddsp_dsq_id;
 	u64			ddsp_enq_flags;
diff --git a/init/init_task.c b/init/init_task.c
index c6804396fe12..8a44c932d10f 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -106,6 +106,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 		.sticky_cpu	= -1,
 		.holding_cpu	= -1,
 		.runnable_node	= LIST_HEAD_INIT(init_task.scx.runnable_node),
+		.runnable_at	= INITIAL_JIFFIES,
 		.ddsp_dsq_id	= SCX_DSQ_INVALID,
 		.slice		= SCX_SLICE_DFL,
 	},
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6042ce3bfee0..f4365becdc13 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5516,6 +5516,7 @@ void sched_tick(void)
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
 	task_tick_mm_cid(rq, curr);
+	scx_tick(rq);
 
 	rq_unlock(rq, &rf);
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1f5d80df263a..3dc515b3351f 100644
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
@@ -1170,6 +1198,11 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
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
@@ -1177,9 +1210,11 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
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
@@ -1217,7 +1252,8 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 {
 	unsigned long opss;
 
-	clr_task_runnable(p);
+	/* dequeue is always temporary, don't reset runnable_at */
+	clr_task_runnable(p, false);
 
 	/* acquire ensures that we see the preceding updates on QUEUED */
 	opss = atomic_long_read_acquire(&p->scx.ops_state);
@@ -1826,7 +1862,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	clr_task_runnable(p);
+	clr_task_runnable(p, true);
 }
 
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
@@ -2176,9 +2212,71 @@ static void reset_idle_masks(void) {}
 
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
@@ -2248,6 +2346,7 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 
 	scx_set_task_state(p, SCX_TASK_INIT);
 
+	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 	return 0;
 }
 
@@ -2326,6 +2425,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	scx->sticky_cpu = -1;
 	scx->holding_cpu = -1;
 	INIT_LIST_HEAD(&scx->runnable_node);
+	scx->runnable_at = jiffies;
 	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
 	scx->slice = SCX_SLICE_DFL;
 }
@@ -2783,6 +2883,8 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 		return "runtime error";
 	case SCX_EXIT_ERROR_BPF:
 		return "scx_bpf_error";
+	case SCX_EXIT_ERROR_STALL:
+		return "runnable task stall";
 	default:
 		return "<UNKNOWN>";
 	}
@@ -2904,6 +3006,8 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	if (scx_ops.exit)
 		SCX_CALL_OP(SCX_KF_UNLOCKED, exit, ei);
 
+	cancel_delayed_work_sync(&scx_watchdog_work);
+
 	/*
 	 * Delete the kobject from the hierarchy eagerly in addition to just
 	 * dropping a reference. Otherwise, if the object is deleted
@@ -3026,6 +3130,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 {
 	struct scx_task_iter sti;
 	struct task_struct *p;
+	unsigned long timeout;
 	int i, ret;
 
 	mutex_lock(&scx_ops_enable_mutex);
@@ -3103,6 +3208,16 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
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
@@ -3413,6 +3528,12 @@ static int bpf_scx_init_member(const struct btf_type *t,
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
@@ -3569,6 +3690,7 @@ void __init init_sched_ext_class(void)
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
+	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
 }
 
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 9c5a2d928281..56fcdb0b2c05 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -29,6 +29,7 @@ static inline bool task_on_scx(const struct task_struct *p)
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
+void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
 int scx_fork(struct task_struct *p);
@@ -66,6 +67,7 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 #define scx_enabled()		false
 #define scx_switched_all()	false
 
+static inline void scx_tick(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 976a2693da71..8beae08dfdc7 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -29,6 +29,8 @@ enum consts {
 char _license[] SEC("license") = "GPL";
 
 const volatile u64 slice_ns = SCX_SLICE_DFL;
+const volatile u32 stall_user_nth;
+const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_batch;
 
 u32 test_error_cnt;
@@ -129,11 +131,20 @@ static int weight_to_idx(u32 weight)
 
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
 
@@ -261,4 +272,5 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .init_task		= (void *)qmap_init_task,
 	       .init			= (void *)qmap_init,
 	       .exit			= (void *)qmap_exit,
+	       .timeout_ms		= 5000U,
 	       .name			= "qmap");
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 7c84ade7ecfb..6e9e9726cd62 100644
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
2.45.2



Return-Path: <bpf+bounces-32455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFD590DE45
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619111F234C7
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEF619B583;
	Tue, 18 Jun 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr2dRHAz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2B19ADAD;
	Tue, 18 Jun 2024 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745711; cv=none; b=S7N/W0ZwKaeYAI9kTZFqRVg6l2KyPfztYVIR0bXGDMDZ17+smSka7maQn1Li1RiYrDN0SSz1rS0L6jMvgsDT368/Dea2NjDIBwgIWZQny5Wk8Zq2O/fsUtIe58ao81AdxTIvYjKyDVtd8RIX1UqFAgaeGCpBE1bi+RtLHjaTlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745711; c=relaxed/simple;
	bh=NooeCUoa/ee8CcD3JGgwy5XSso7E//SYAuBXo9FGM2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/KAmcEJG7EjmrmBJEF2pDseZfjCE1XsI0M/LOoQOcMwLvL9QJxfoF0qDoJKaEKpdu0/LGwNDs2/ZhW5GJTZb7oLERVTAwTPEMUcVoRw1dAtcELsxyD6IccMPOLVERoifXJXoK6HturSyiOX/ObQLEi4iF8lvtg72+vmRALe9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr2dRHAz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70625e8860cso677703b3a.2;
        Tue, 18 Jun 2024 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745707; x=1719350507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAV6xU7UWJptEyT2Vy2EavHP70MR9/DY8DIDRC+N5aQ=;
        b=lr2dRHAzCCf2CId5AfD0r1oyQ6310ofjvUuBVUCAKzS+JWtDbjf9CQrIgfeKNKlvzy
         zteaXRgX8cUguC/DxmdHDIK11nyV5slLUoRExNDhox9+pUIHHMNY46aZrYcMjq9J2cvD
         F8OzGj0yf6EXOzQw7IzJ+TJ/SQahPjp4FVIWWu8Y95UCubAj1t+/sQ0zquAYfwkWu8lE
         22p98fBiTEKCt5fBxkqJ/eGWdjUtY/Ue+n4tsuFC4TLUSYcNdnJ3GAZXo+fPxWu6fNsT
         2uFoFk8C3dA2a+VRyuQjsQ1B8YUmFboNyDtuVvvw0lyI9jUmdUWaMvGCc8ZJYyV5BHaO
         MkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745707; x=1719350507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OAV6xU7UWJptEyT2Vy2EavHP70MR9/DY8DIDRC+N5aQ=;
        b=hAN++8D694xi5lrznvZAhVzBGpldKB7k9FYOl5qtxFSCb3NTntU3ae3zZLVDsO2Vzz
         mAXFL8GARBO0Dcc+SGoK+DzQae3yeda2s9bjV4/4kvs+u1PG58pTIRpm6wOUfIhtgH9x
         UitQoGK5LH7c8eJl2ASCMvuYbW+Mk4QxkVSc93QqAkgcs6954ulLhdD1qqKNlNh8qSnC
         /o8gwP/c8ATaF/lx1A7dq8WwjuIIFZd/jOQupVoISayTuDJc9EbPy5e6lYDE33W/UGdC
         wWhwZ8OZE9TZ7cg3iNFU7aUUzp7uMbQeceYbwb1oxquCEphmnkRCbdgPRU0h0w169h+L
         BLlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZJTAN27dfqC97eu4IifmmPoEhoVK3v7IrFBl8/FhWNQbNUqmIPOmT1QiZK6bRQBq0+9GdMYg115OBkal1HophBpjH
X-Gm-Message-State: AOJu0YzhO0lslD1rqxxnZ4UB7Co/FHlR+ua+elwero6R3I5lUuA1vfyC
	GFd7FEnghvDi1ya4lsurDTW1sYpC6cgXZpvhW2dx9+3GUj1BOd78svVI7g==
X-Google-Smtp-Source: AGHT+IGIpd/gy7RI2kKf7NVPSKo9P+Xpocu11ox9obbNpIMrgmLGfda6+bf9z//3gHagh2ok5qOveQ==
X-Received: by 2002:a05:6a20:6d13:b0:1b5:3d24:7342 with SMTP id adf61e73a8af0-1bcbb3a81abmr813821637.9.1718745706838;
        Tue, 18 Jun 2024 14:21:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f2e281sm102309585ad.254.2024.06.18.14.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:46 -0700 (PDT)
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
Subject: [PATCH 21/30] sched_ext: Implement tickless support
Date: Tue, 18 Jun 2024 11:17:36 -1000
Message-ID: <20240618212056.2833381-22-tj@kernel.org>
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

Allow BPF schedulers to indicate tickless operation by setting p->scx.slice
to SCX_SLICE_INF. A CPU whose current task has infinte slice goes into
tickless operation.

scx_central is updated to use tickless operations for all tasks and
instead use a BPF timer to expire slices. This also uses the SCX_ENQ_PREEMPT
and task state tracking added by the previous patches.

Currently, there is no way to pin the timer on the central CPU, so it may
end up on one of the worker CPUs; however, outside of that, the worker CPUs
can go tickless both while running sched_ext tasks and idling.

With schbench running, scx_central shows:

  root@test ~# grep ^LOC /proc/interrupts; sleep 10; grep ^LOC /proc/interrupts
  LOC:     142024        656        664        449   Local timer interrupts
  LOC:     161663        663        665        449   Local timer interrupts

Without it:

  root@test ~ [SIGINT]# grep ^LOC /proc/interrupts; sleep 10; grep ^LOC /proc/interrupts
  LOC:     188778       3142       3793       3993   Local timer interrupts
  LOC:     198993       5314       6323       6438   Local timer interrupts

While scx_central itself is too barebone to be useful as a
production scheduler, a more featureful central scheduler can be built using
the same approach. Google's experience shows that such an approach can have
significant benefits for certain applications such as VM hosting.

v4: Allow operation even if BPF_F_TIMER_CPU_PIN is not available.

v3: Pin the central scheduler's timer on the central_cpu using
    BPF_F_TIMER_CPU_PIN.

v2: Convert to BPF inline iterators.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h         |   1 +
 kernel/sched/core.c               |  11 ++-
 kernel/sched/ext.c                |  52 +++++++++-
 kernel/sched/ext.h                |   2 +
 kernel/sched/sched.h              |   1 +
 tools/sched_ext/scx_central.bpf.c | 159 ++++++++++++++++++++++++++++--
 tools/sched_ext/scx_central.c     |  29 +++++-
 7 files changed, 242 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 3b2809b980ac..6f1a4977e9f8 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -16,6 +16,7 @@ enum scx_public_consts {
 	SCX_OPS_NAME_LEN	= 128,
 
 	SCX_SLICE_DFL		= 20 * 1000000,	/* 20ms */
+	SCX_SLICE_INF		= U64_MAX,	/* infinite, implies nohz */
 };
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a3144c80af8..d5eff4036be7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1256,11 +1256,14 @@ bool sched_can_stop_tick(struct rq *rq)
 		return true;
 
 	/*
-	 * If there are no DL,RR/FIFO tasks, there must only be CFS tasks left;
-	 * if there's more than one we need the tick for involuntary
-	 * preemption.
+	 * If there are no DL,RR/FIFO tasks, there must only be CFS or SCX tasks
+	 * left. For CFS, if there's more than one we need the tick for
+	 * involuntary preemption. For SCX, ask.
 	 */
-	if (rq->nr_running > 1)
+	if (!scx_switched_all() && rq->nr_running > 1)
+		return false;
+
+	if (scx_enabled() && !scx_can_stop_tick(rq))
 		return false;
 
 	/*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2e652f7b8f54..ce32fc6b05cd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1086,7 +1086,8 @@ static void update_curr_scx(struct rq *rq)
 	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
 
-	curr->scx.slice -= min(curr->scx.slice, delta_exec);
+	if (curr->scx.slice != SCX_SLICE_INF)
+		curr->scx.slice -= min(curr->scx.slice, delta_exec);
 }
 
 static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
@@ -2093,6 +2094,28 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 		SCX_CALL_OP(SCX_KF_REST, running, p);
 
 	clr_task_runnable(p, true);
+
+	/*
+	 * @p is getting newly scheduled or got kicked after someone updated its
+	 * slice. Refresh whether tick can be stopped. See scx_can_stop_tick().
+	 */
+	if ((p->scx.slice == SCX_SLICE_INF) !=
+	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
+		if (p->scx.slice == SCX_SLICE_INF)
+			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
+		else
+			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
+
+		sched_update_tick_dependency(rq);
+
+		/*
+		 * For now, let's refresh the load_avgs just when transitioning
+		 * in and out of nohz. In the future, we might want to add a
+		 * mechanism which calls the following periodically on
+		 * tick-stopped CPUs.
+		 */
+		update_other_load_avgs(rq);
+	}
 }
 
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
@@ -2818,6 +2841,26 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 	return 0;
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+bool scx_can_stop_tick(struct rq *rq)
+{
+	struct task_struct *p = rq->curr;
+
+	if (scx_ops_bypassing())
+		return false;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	/*
+	 * @rq can dispatch from different DSQs, so we can't tell whether it
+	 * needs the tick or not by looking at nr_running. Allow stopping ticks
+	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 */
+	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
+}
+#endif
+
 /*
  * Omitted operations:
  *
@@ -3120,6 +3163,9 @@ static void scx_ops_bypass(bool bypass)
 		}
 
 		rq_unlock_irqrestore(rq, &rf);
+
+		/* kick to restore ticks */
+		resched_cpu(cpu);
 	}
 }
 
@@ -4576,7 +4622,9 @@ __bpf_kfunc_start_defs();
  * BPF locks (in the future when BPF introduces more flexible locking).
  *
  * @p is allowed to run for @slice. The scheduling path is triggered on slice
- * exhaustion. If zero, the current residual slice is maintained.
+ * exhaustion. If zero, the current residual slice is maintained. If
+ * %SCX_SLICE_INF, @p never expires and the BPF scheduler must kick the CPU with
+ * scx_bpf_kick_cpu() to trigger scheduling.
  */
 __bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
 				  u64 enq_flags)
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 33a9f7fe5832..6ed946f72489 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -35,6 +35,7 @@ void scx_pre_fork(struct task_struct *p);
 int scx_fork(struct task_struct *p);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
+bool scx_can_stop_tick(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(struct task_struct *p);
 void init_sched_ext_class(void);
@@ -73,6 +74,7 @@ static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
+static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline void init_sched_ext_class(void) {}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d9054eb4ba82..b3c578cb43cd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -727,6 +727,7 @@ struct cfs_rq {
 /* scx_rq->flags, protected by the rq lock */
 enum scx_rq_flags {
 	SCX_RQ_BALANCING	= 1 << 1,
+	SCX_RQ_CAN_STOP_TICK	= 1 << 2,
 };
 
 struct scx_rq {
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 428b2262faa3..1d8fd570eaa7 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -13,7 +13,26 @@
  *    through per-CPU BPF queues. The current design is chosen to maximally
  *    utilize and verify various SCX mechanisms such as LOCAL_ON dispatching.
  *
- * b. Preemption
+ * b. Tickless operation
+ *
+ *    All tasks are dispatched with the infinite slice which allows stopping the
+ *    ticks on CONFIG_NO_HZ_FULL kernels running with the proper nohz_full
+ *    parameter. The tickless operation can be observed through
+ *    /proc/interrupts.
+ *
+ *    Periodic switching is enforced by a periodic timer checking all CPUs and
+ *    preempting them as necessary. Unfortunately, BPF timer currently doesn't
+ *    have a way to pin to a specific CPU, so the periodic timer isn't pinned to
+ *    the central CPU.
+ *
+ * c. Preemption
+ *
+ *    Kthreads are unconditionally queued to the head of a matching local dsq
+ *    and dispatched with SCX_DSQ_PREEMPT. This ensures that a kthread is always
+ *    prioritized over user threads, which is required for ensuring forward
+ *    progress as e.g. the periodic timer may run on a ksoftirqd and if the
+ *    ksoftirqd gets starved by a user thread, there may not be anything else to
+ *    vacate that user thread.
  *
  *    SCX_KICK_PREEMPT is used to trigger scheduling and CPUs to move to the
  *    next tasks.
@@ -32,14 +51,17 @@ char _license[] SEC("license") = "GPL";
 
 enum {
 	FALLBACK_DSQ_ID		= 0,
+	MS_TO_NS		= 1000LLU * 1000,
+	TIMER_INTERVAL_NS	= 1 * MS_TO_NS,
 };
 
 const volatile s32 central_cpu;
 const volatile u32 nr_cpu_ids = 1;	/* !0 for veristat, set during init */
 const volatile u64 slice_ns = SCX_SLICE_DFL;
 
+bool timer_pinned = true;
 u64 nr_total, nr_locals, nr_queued, nr_lost_pids;
-u64 nr_dispatches, nr_mismatches, nr_retries;
+u64 nr_timers, nr_dispatches, nr_mismatches, nr_retries;
 u64 nr_overflows;
 
 UEI_DEFINE(uei);
@@ -52,6 +74,23 @@ struct {
 
 /* can't use percpu map due to bad lookups */
 bool RESIZABLE_ARRAY(data, cpu_gimme_task);
+u64 RESIZABLE_ARRAY(data, cpu_started_at);
+
+struct central_timer {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct central_timer);
+} central_timer SEC(".maps");
+
+static bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
 
 s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
@@ -71,9 +110,22 @@ void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
 
 	__sync_fetch_and_add(&nr_total, 1);
 
+	/*
+	 * Push per-cpu kthreads at the head of local dsq's and preempt the
+	 * corresponding CPU. This ensures that e.g. ksoftirqd isn't blocked
+	 * behind other threads which is necessary for forward progress
+	 * guarantee as we depend on the BPF timer which may run from ksoftirqd.
+	 */
+	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
+		__sync_fetch_and_add(&nr_locals, 1);
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_INF,
+				 enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
 	if (bpf_map_push_elem(&central_q, &pid, 0)) {
 		__sync_fetch_and_add(&nr_overflows, 1);
-		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, enq_flags);
+		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, enq_flags);
 		return;
 	}
 
@@ -106,7 +158,7 @@ static bool dispatch_to_cpu(s32 cpu)
 		 */
 		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
 			__sync_fetch_and_add(&nr_mismatches, 1);
-			scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, 0);
+			scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, 0);
 			bpf_task_release(p);
 			/*
 			 * We might run out of dispatch buffer slots if we continue dispatching
@@ -120,7 +172,7 @@ static bool dispatch_to_cpu(s32 cpu)
 		}
 
 		/* dispatch to local and mark that @cpu doesn't need more */
-		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_INF, 0);
 
 		if (cpu != central_cpu)
 			scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
@@ -188,9 +240,102 @@ void BPF_STRUCT_OPS(central_dispatch, s32 cpu, struct task_struct *prev)
 	}
 }
 
+void BPF_STRUCT_OPS(central_running, struct task_struct *p)
+{
+	s32 cpu = scx_bpf_task_cpu(p);
+	u64 *started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
+	if (started_at)
+		*started_at = bpf_ktime_get_ns() ?: 1;	/* 0 indicates idle */
+}
+
+void BPF_STRUCT_OPS(central_stopping, struct task_struct *p, bool runnable)
+{
+	s32 cpu = scx_bpf_task_cpu(p);
+	u64 *started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
+	if (started_at)
+		*started_at = 0;
+}
+
+static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
+{
+	u64 now = bpf_ktime_get_ns();
+	u64 nr_to_kick = nr_queued;
+	s32 i, curr_cpu;
+
+	curr_cpu = bpf_get_smp_processor_id();
+	if (timer_pinned && (curr_cpu != central_cpu)) {
+		scx_bpf_error("Central timer ran on CPU %d, not central CPU %d",
+			      curr_cpu, central_cpu);
+		return 0;
+	}
+
+	bpf_for(i, 0, nr_cpu_ids) {
+		s32 cpu = (nr_timers + i) % nr_cpu_ids;
+		u64 *started_at;
+
+		if (cpu == central_cpu)
+			continue;
+
+		/* kick iff the current one exhausted its slice */
+		started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
+		if (started_at && *started_at &&
+		    vtime_before(now, *started_at + slice_ns))
+			continue;
+
+		/* and there's something pending */
+		if (scx_bpf_dsq_nr_queued(FALLBACK_DSQ_ID) ||
+		    scx_bpf_dsq_nr_queued(SCX_DSQ_LOCAL_ON | cpu))
+			;
+		else if (nr_to_kick)
+			nr_to_kick--;
+		else
+			continue;
+
+		scx_bpf_kick_cpu(cpu, SCX_KICK_PREEMPT);
+	}
+
+	bpf_timer_start(timer, TIMER_INTERVAL_NS, BPF_F_TIMER_CPU_PIN);
+	__sync_fetch_and_add(&nr_timers, 1);
+	return 0;
+}
+
 int BPF_STRUCT_OPS_SLEEPABLE(central_init)
 {
-	return scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
+	u32 key = 0;
+	struct bpf_timer *timer;
+	int ret;
+
+	ret = scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
+	if (ret)
+		return ret;
+
+	timer = bpf_map_lookup_elem(&central_timer, &key);
+	if (!timer)
+		return -ESRCH;
+
+	if (bpf_get_smp_processor_id() != central_cpu) {
+		scx_bpf_error("init from non-central CPU");
+		return -EINVAL;
+	}
+
+	bpf_timer_init(timer, &central_timer, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, central_timerfn);
+
+	ret = bpf_timer_start(timer, TIMER_INTERVAL_NS, BPF_F_TIMER_CPU_PIN);
+	/*
+	 * BPF_F_TIMER_CPU_PIN is pretty new (>=6.7). If we're running in a
+	 * kernel which doesn't have it, bpf_timer_start() will return -EINVAL.
+	 * Retry without the PIN. This would be the perfect use case for
+	 * bpf_core_enum_value_exists() but the enum type doesn't have a name
+	 * and can't be used with bpf_core_enum_value_exists(). Oh well...
+	 */
+	if (ret == -EINVAL) {
+		timer_pinned = false;
+		ret = bpf_timer_start(timer, TIMER_INTERVAL_NS, 0);
+	}
+	if (ret)
+		scx_bpf_error("bpf_timer_start failed (%d)", ret);
+	return ret;
 }
 
 void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
@@ -209,6 +354,8 @@ SCX_OPS_DEFINE(central_ops,
 	       .select_cpu		= (void *)central_select_cpu,
 	       .enqueue			= (void *)central_enqueue,
 	       .dispatch		= (void *)central_dispatch,
+	       .running			= (void *)central_running,
+	       .stopping		= (void *)central_stopping,
 	       .init			= (void *)central_init,
 	       .exit			= (void *)central_exit,
 	       .name			= "central");
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 5f09fc666a63..fb3f50886552 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -48,6 +48,7 @@ int main(int argc, char **argv)
 	struct bpf_link *link;
 	__u64 seq = 0;
 	__s32 opt;
+	cpu_set_t *cpuset;
 
 	libbpf_set_print(libbpf_print_fn);
 	signal(SIGINT, sigint_handler);
@@ -77,10 +78,35 @@ int main(int argc, char **argv)
 
 	/* Resize arrays so their element count is equal to cpu count. */
 	RESIZE_ARRAY(skel, data, cpu_gimme_task, skel->rodata->nr_cpu_ids);
+	RESIZE_ARRAY(skel, data, cpu_started_at, skel->rodata->nr_cpu_ids);
 
 	SCX_OPS_LOAD(skel, central_ops, scx_central, uei);
+
+	/*
+	 * Affinitize the loading thread to the central CPU, as:
+	 * - That's where the BPF timer is first invoked in the BPF program.
+	 * - We probably don't want this user space component to take up a core
+	 *   from a task that would benefit from avoiding preemption on one of
+	 *   the tickless cores.
+	 *
+	 * Until BPF supports pinning the timer, it's not guaranteed that it
+	 * will always be invoked on the central CPU. In practice, this
+	 * suffices the majority of the time.
+	 */
+	cpuset = CPU_ALLOC(skel->rodata->nr_cpu_ids);
+	SCX_BUG_ON(!cpuset, "Failed to allocate cpuset");
+	CPU_ZERO(cpuset);
+	CPU_SET(skel->rodata->central_cpu, cpuset);
+	SCX_BUG_ON(sched_setaffinity(0, sizeof(cpuset), cpuset),
+		   "Failed to affinitize to central CPU %d (max %d)",
+		   skel->rodata->central_cpu, skel->rodata->nr_cpu_ids - 1);
+	CPU_FREE(cpuset);
+
 	link = SCX_OPS_ATTACH(skel, central_ops, scx_central);
 
+	if (!skel->data->timer_pinned)
+		printf("WARNING : BPF_F_TIMER_CPU_PIN not available, timer not pinned to central\n");
+
 	while (!exit_req && !UEI_EXITED(skel, uei)) {
 		printf("[SEQ %llu]\n", seq++);
 		printf("total   :%10" PRIu64 "    local:%10" PRIu64 "   queued:%10" PRIu64 "  lost:%10" PRIu64 "\n",
@@ -88,7 +114,8 @@ int main(int argc, char **argv)
 		       skel->bss->nr_locals,
 		       skel->bss->nr_queued,
 		       skel->bss->nr_lost_pids);
-		printf("                    dispatch:%10" PRIu64 " mismatch:%10" PRIu64 " retry:%10" PRIu64 "\n",
+		printf("timer   :%10" PRIu64 " dispatch:%10" PRIu64 " mismatch:%10" PRIu64 " retry:%10" PRIu64 "\n",
+		       skel->bss->nr_timers,
 		       skel->bss->nr_dispatches,
 		       skel->bss->nr_mismatches,
 		       skel->bss->nr_retries);
-- 
2.45.2



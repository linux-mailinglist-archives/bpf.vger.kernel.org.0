Return-Path: <bpf+bounces-32456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7321690DE46
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D7A2845DA
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A157019B587;
	Tue, 18 Jun 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN2aahbX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E319AD68;
	Tue, 18 Jun 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745711; cv=none; b=gMMu9yH1mSEIledpGsIgb2LUuHH9VRYsmTippF59EnO0t/lqUKjCDiL7s/di5g74TaoOwhc0NuVgTnh7RcyjCz7B81TJ/baZorcRZgSIbLLn0wIQ/jiWvcJ4z4vb99mht5uopqyrqzP3umVmwloMAH4ZSI8Bn2dTt7nQ/ZyWQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745711; c=relaxed/simple;
	bh=58U4h5TvzpK9GyaOZyC21EzQWydQb6rgsW7YLSKVzUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muWhGKm9jp3m387szQVyeOjJQoOQJJUeNkROO9QbLB10feHy/9DeLa2By+Q6Yi42BbpY6vdHK/qYCPGQ0PLYS5cJ+k040Ku0y7OpPPmIoN7yMK9JPbkAv7lYX0v/FFMvCvSW5/BwuGuTxKrYYjdCbTCYZDq1Eb5QicoK9nzEY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN2aahbX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c70c37287fso963297a91.0;
        Tue, 18 Jun 2024 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745709; x=1719350509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNfAsVr7bZCKbsnaAQVsvTCbSibHEWFF3sNqKD/L05A=;
        b=aN2aahbXOt2nWk8I1f4UNUNASdY2sy6u9uf5NXq3rGdtivr+UnsGAe9MCiysnUw6TR
         ZxPGEyO4zjkYddtPbVdnKbC2RomQue9b+hf3kvOIRwtT6ICzPAT3FmaA6I1gB4VXVB+d
         i1jCvU7F/AcU7hnx1L3ku1lwAIt+xm7+LEGk8GobxvKow75EXIqQrHWrS77YQFNoyh13
         y2xeKdzyXcipObl7i0lZe8BzOaWkUTPv8jMLcitvxhUuyMi+F4OpOQD9EpXflQhtwgqn
         sk5boAcfohIGhB69z0y3xTla0Y+lEow1U4Co9jyZjzgDtssMy5LHEXunSqoIBbbcb8rU
         92WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745709; x=1719350509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNfAsVr7bZCKbsnaAQVsvTCbSibHEWFF3sNqKD/L05A=;
        b=Sb/ig56cA4AvZMuub+bhNTRloP/MDWqA3fsbIBGwQ+sDigHU6G3krYHG9w4skbMllY
         nk8IpsNNN1XRepD98hKUi8ODeq/y9vn4wELz8bfIfaRnuTw6kNG1gEr+ku87QO81jvSv
         gd8dp2XpNZY/Xyn7yglXbrqZSHzcK0LT8Hg97aehvhZET/uurCnXf4I6bthC7IcYWz71
         OSoajF8+3riEczdMn7dv04lmJW4yNneBx00GKstTbJsYj1Yj6/iEG/x7yd0AtTdjFDCY
         HM3uBCWXOISG9ucCTJN2B4FRzjx6HEYt5pGo2jV1hE4BLQhKAMR5MXH2WjR5MpjBEiPR
         skfw==
X-Forwarded-Encrypted: i=1; AJvYcCXrHawkls7kzvteE7agn0hdRYayYFHcbw04vfFSerwpbMpqPSF5mbLYrojkYK06KImn5KzqZg8GpWu3yiKpqMhs6/oP
X-Gm-Message-State: AOJu0YxiJG8q/+wE3KWElrpHLlyK5+0SKVt71nuEM9WItEkxQBI/c3Zm
	Ey/wrEdaYBbdgTgFiSTVVsTwxkxoneVi0goDk6E8mFCYv643W0mS
X-Google-Smtp-Source: AGHT+IGGSgnV9hIgrSdjQFPqU+M8SpJbV/i2knlowJS0U6dGKLq7+qnR4LAy6YLK7vVFMl18Alv+Dg==
X-Received: by 2002:a17:90b:97:b0:2c4:aa3d:f1e8 with SMTP id 98e67ed59e1d1-2c7b5b06d60mr968737a91.14.1718745708528;
        Tue, 18 Jun 2024 14:21:48 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4dc5f7e0esm9452881a91.48.2024.06.18.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:48 -0700 (PDT)
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
Subject: [PATCH 22/30] sched_ext: Track tasks that are subjects of the in-flight SCX operation
Date: Tue, 18 Jun 2024 11:17:37 -1000
Message-ID: <20240618212056.2833381-23-tj@kernel.org>
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

When some SCX operations are in flight, it is known that the subject task's
rq lock is held throughout which makes it safe to access certain fields of
the task - e.g. its current task_group. We want to add SCX kfunc helpers
that can make use of this guarantee - e.g. to help determining the currently
associated CPU cgroup from the task's current task_group.

As it'd be dangerous call such a helper on a task which isn't rq lock
protected, the helper should be able to verify the input task and reject
accordingly. This patch adds sched_ext_entity.kf_tasks[] that track the
tasks which are currently being operated on by a terminal SCX operation. The
new SCX_CALL_OP_[2]TASK[_RET]() can be used when invoking SCX operations
which take tasks as arguments and the scx_kf_allowed_on_arg_tasks() can be
used by kfunc helpers to verify the input task status.

Note that as sched_ext_entity.kf_tasks[] can't handle nesting, the tracking
is currently only limited to terminal SCX operations. If needed in the
future, this restriction can be removed by moving the tracking to the task
side with a couple per-task counters.

v2: Updated to reflect the addition of SCX_KF_SELECT_CPU.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 include/linux/sched/ext.h |  2 +
 kernel/sched/ext.c        | 91 +++++++++++++++++++++++++++++++--------
 2 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 6f1a4977e9f8..74341dbc6a19 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -106,6 +106,7 @@ enum scx_kf_mask {
 
 	__SCX_KF_RQ_LOCKED	= SCX_KF_DISPATCH |
 				  SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
+	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
 };
 
 /*
@@ -120,6 +121,7 @@ struct sched_ext_entity {
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	u32			kf_mask;	/* see scx_kf_mask above */
+	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 	atomic_long_t		ops_state;
 
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ce32fc6b05cd..838a96cb10ea 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -817,6 +817,47 @@ do {										\
 	__ret;									\
 })
 
+/*
+ * Some kfuncs are allowed only on the tasks that are subjects of the
+ * in-progress scx_ops operation for, e.g., locking guarantees. To enforce such
+ * restrictions, the following SCX_CALL_OP_*() variants should be used when
+ * invoking scx_ops operations that take task arguments. These can only be used
+ * for non-nesting operations due to the way the tasks are tracked.
+ *
+ * kfuncs which can only operate on such tasks can in turn use
+ * scx_kf_allowed_on_arg_tasks() to test whether the invocation is allowed on
+ * the specific task.
+ */
+#define SCX_CALL_OP_TASK(mask, op, task, args...)				\
+do {										\
+	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
+	current->scx.kf_tasks[0] = task;					\
+	SCX_CALL_OP(mask, op, task, ##args);					\
+	current->scx.kf_tasks[0] = NULL;					\
+} while (0)
+
+#define SCX_CALL_OP_TASK_RET(mask, op, task, args...)				\
+({										\
+	__typeof__(scx_ops.op(task, ##args)) __ret;				\
+	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
+	current->scx.kf_tasks[0] = task;					\
+	__ret = SCX_CALL_OP_RET(mask, op, task, ##args);			\
+	current->scx.kf_tasks[0] = NULL;					\
+	__ret;									\
+})
+
+#define SCX_CALL_OP_2TASKS_RET(mask, op, task0, task1, args...)			\
+({										\
+	__typeof__(scx_ops.op(task0, task1, ##args)) __ret;			\
+	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
+	current->scx.kf_tasks[0] = task0;					\
+	current->scx.kf_tasks[1] = task1;					\
+	__ret = SCX_CALL_OP_RET(mask, op, task0, task1, ##args);		\
+	current->scx.kf_tasks[0] = NULL;					\
+	current->scx.kf_tasks[1] = NULL;					\
+	__ret;									\
+})
+
 /* @mask is constant, always inline to cull unnecessary branches */
 static __always_inline bool scx_kf_allowed(u32 mask)
 {
@@ -846,6 +887,22 @@ static __always_inline bool scx_kf_allowed(u32 mask)
 	return true;
 }
 
+/* see SCX_CALL_OP_TASK() */
+static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
+							struct task_struct *p)
+{
+	if (!scx_kf_allowed(mask))
+		return false;
+
+	if (unlikely((p != current->scx.kf_tasks[0] &&
+		      p != current->scx.kf_tasks[1]))) {
+		scx_ops_error("called on a task not being operated on");
+		return false;
+	}
+
+	return true;
+}
+
 
 /*
  * SCX task iterator.
@@ -1342,7 +1399,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
 
-	SCX_CALL_OP(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
+	SCX_CALL_OP_TASK(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
 
 	*ddsp_taskp = NULL;
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -1427,7 +1484,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	add_nr_running(rq, 1);
 
 	if (SCX_HAS_OP(runnable))
-		SCX_CALL_OP(SCX_KF_REST, runnable, p, enq_flags);
+		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
 
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 }
@@ -1453,7 +1510,7 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 		BUG();
 	case SCX_OPSS_QUEUED:
 		if (SCX_HAS_OP(dequeue))
-			SCX_CALL_OP(SCX_KF_REST, dequeue, p, deq_flags);
+			SCX_CALL_OP_TASK(SCX_KF_REST, dequeue, p, deq_flags);
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -1502,11 +1559,11 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	 */
 	if (SCX_HAS_OP(stopping) && task_current(rq, p)) {
 		update_curr_scx(rq);
-		SCX_CALL_OP(SCX_KF_REST, stopping, p, false);
+		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, false);
 	}
 
 	if (SCX_HAS_OP(quiescent))
-		SCX_CALL_OP(SCX_KF_REST, quiescent, p, deq_flags);
+		SCX_CALL_OP_TASK(SCX_KF_REST, quiescent, p, deq_flags);
 
 	if (deq_flags & SCX_DEQ_SLEEP)
 		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
@@ -1525,7 +1582,7 @@ static void yield_task_scx(struct rq *rq)
 	struct task_struct *p = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		SCX_CALL_OP_RET(SCX_KF_REST, yield, p, NULL);
+		SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, p, NULL);
 	else
 		p->scx.slice = 0;
 }
@@ -1535,7 +1592,7 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 	struct task_struct *from = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		return SCX_CALL_OP_RET(SCX_KF_REST, yield, from, to);
+		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, from, to);
 	else
 		return false;
 }
@@ -2091,7 +2148,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP(SCX_KF_REST, running, p);
+		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
 
 	clr_task_runnable(p, true);
 
@@ -2155,7 +2212,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP(SCX_KF_REST, stopping, p, true);
+		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, true);
 
 	/*
 	 * If we're being called from put_prev_task_balance(), balance_scx() may
@@ -2377,8 +2434,8 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		WARN_ON_ONCE(*ddsp_taskp);
 		*ddsp_taskp = p;
 
-		cpu = SCX_CALL_OP_RET(SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
-				      select_cpu, p, prev_cpu, wake_flags);
+		cpu = SCX_CALL_OP_TASK_RET(SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
+					   select_cpu, p, prev_cpu, wake_flags);
 		*ddsp_taskp = NULL;
 		if (ops_cpu_valid(cpu, "from ops.select_cpu()"))
 			return cpu;
@@ -2411,8 +2468,8 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 	 * designation pointless. Cast it away when calling the operation.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP(SCX_KF_REST, set_cpumask, p,
-			    (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
+				 (struct cpumask *)p->cpus_ptr);
 }
 
 static void reset_idle_masks(void)
@@ -2647,7 +2704,7 @@ static void scx_ops_enable_task(struct task_struct *p)
 	 */
 	set_task_scx_weight(p);
 	if (SCX_HAS_OP(enable))
-		SCX_CALL_OP(SCX_KF_REST, enable, p);
+		SCX_CALL_OP_TASK(SCX_KF_REST, enable, p);
 	scx_set_task_state(p, SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(set_weight))
@@ -2801,7 +2858,7 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p, int newprio)
 
 	set_task_scx_weight(p);
 	if (SCX_HAS_OP(set_weight))
-		SCX_CALL_OP(SCX_KF_REST, set_weight, p, p->scx.weight);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
 }
 
 static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldprio)
@@ -2817,8 +2874,8 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 * different scheduler class. Keep the BPF scheduler up-to-date.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP(SCX_KF_REST, set_cpumask, p,
-			    (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
+				 (struct cpumask *)p->cpus_ptr);
 }
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
-- 
2.45.2



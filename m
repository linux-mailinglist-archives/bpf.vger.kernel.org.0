Return-Path: <bpf+bounces-28355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331518B8CB1
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDFB281D1A
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20748137766;
	Wed,  1 May 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGRCeHDz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E20136E0A;
	Wed,  1 May 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576452; cv=none; b=OQ1loGYuKIm3eB7G1sVy3sBycGo23yplxQCTj00+EgOHdYzCYggzkrOA7ps92It37hhidwCwhvLunNQWzp5d97hqWUZAGMnOEKG2Pn0HizDsh1oxQMcbgi24/ClteBHnb2Us/fshBMVkBvuFQ7oe7Cia8k3Sq7hgR1Vmw8z/Awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576452; c=relaxed/simple;
	bh=nKsfPnNf1/f+r7yS9XrDvd001MXDKBdPw5j4ItPh8EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OR2JCdP5odXLDf8ko31gRqurlJTrmSZhYY3kQGvkPyH0kbh/2oTxStqQ5SLDx0OQdN/EL6WP+SSyfwu5/UzzF8tak60giuY52Llg8T5BXnO6rBA3PjHgIauiMYdcIYJfmpa98QvSRKJVyF3Zjahjt5DAOYv7sIqqtx8l6CK/n1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGRCeHDz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso5814986b3a.0;
        Wed, 01 May 2024 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576448; x=1715181248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Elh+Ww+E/hilwMnGp0VkzVJ20vAuGkrlMdN1xrb0VwU=;
        b=gGRCeHDz1sQrGbGLrGYJcPAoy9flsQmRoUqnN1mdsuUKcYnmqM7iR9zfagyD9WcjE+
         WL+uMP0tetR4wvEDbTIePNguRW4r+kjVC4YnsirW8dAzPMp3dXrYw2OIJaDwsss275Ns
         z1SKoU+9W9TDOLKuONFdeVjeK0lON2XC5/n+sb9Q4HO5pyB3G75sLVP3CjTJZd0B+Uc4
         jGxGqY6Pr59xPNfsrwZQ/Kd8kbN2RGeyH8cZgUSTnoAujy8tY7r2HYRCkf1nzYWPQs87
         pHTvy4o6juJaM8KSR8sR+sBHW6DSR+1yGViE4yfHBawxJN6lToVCahfDeP+tohetbwGX
         mvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576448; x=1715181248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Elh+Ww+E/hilwMnGp0VkzVJ20vAuGkrlMdN1xrb0VwU=;
        b=NSuS0tgNfqiLPYWZ7uLKSk6X6RE+vhUvnLiR+KPhIBFGHaZgN5q9ia50XpSWxLzGMW
         pqxSwXot3K/LZNwJIeegewEwQ+slHROkXsb6vCFy76tTViFJ7C6L/7gSt7t1o6gG8I5E
         uGZ57R/OL0jJ6cbdyJLtufTL2Jqp+KijKrZuGIpZqy5KxoxjirrbtFO0Q+kfq8Le8+0L
         zfzFG0xPd+atgB+abYkA+DRMkKCUlyKcrWXjJ+b3uQ+S9QnFTXtVPVC1UwziPnp/WL0P
         hXJ035RuaDk2o0XetDy80YUhdmWe85S613s4BnqOvimV4G4m1O+QBE7cAfkdOQGYYphM
         3+7g==
X-Forwarded-Encrypted: i=1; AJvYcCXnCvphaflBz+V2mvQQDftNLbzzL5EZ7LbXBN5Y8sI0k3JOONtY8BldTAHPe1qLoY9bThemFTVpmBtAW//Z4pWSI+Qa
X-Gm-Message-State: AOJu0Yy5JElA1QI1uAgcCfCKU7/UQbbs8pRUM5w2zzzNN9hw9bsFMbHd
	HwfvbbdXj0hLk7bsQ8FV1oucYs/u3ODhfb9b/ZQyGe6uXZwADKIr
X-Google-Smtp-Source: AGHT+IHVn4/ICgrwzKXMYhPHv4HvJeHEh+3CGad0msqme0Vm39Lsg4kQBW6b4ItjtBatFUP0wRpkZQ==
X-Received: by 2002:a05:6a21:8189:b0:1af:63f2:bc62 with SMTP id pd9-20020a056a21818900b001af63f2bc62mr2721244pzb.15.1714576448382;
        Wed, 01 May 2024 08:14:08 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id r8-20020aa78448000000b006e724ccdc3esm22739824pfn.55.2024.05.01.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:14:08 -0700 (PDT)
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
Subject: [PATCH 25/39] sched_ext: Add task state tracking operations
Date: Wed,  1 May 2024 05:10:00 -1000
Message-ID: <20240501151312.635565-26-tj@kernel.org>
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

Being able to track the task runnable and running state transitions are
useful for a variety of purposes including latency tracking and load factor
calculation.

Currently, BPF schedulers don't have a good way of tracking these
transitions. Becoming runnable can be determined from ops.enqueue() but
becoming quiescent can only be inferred from the lack of subsequent enqueue.
Also, as the local dsq can have multiple tasks and some events are handled
in the sched_ext core, it's difficult to determine when a given task starts
and stops executing.

This patch adds sched_ext_ops.runnable(), .running(), .stopping() and
.quiescent() operations to track the task runnable and running state
transitions. They're mostly self explanatory; however, we want to ensure
that running <-> stopping transitions are always contained within runnable
<-> quiescent transitions which is a bit different from how the scheduler
core behaves. This adds a bit of complication. See the comment in
dequeue_task_scx().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/ext.c | 104 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 495210cd12f9..8f10fb228a45 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -203,6 +203,71 @@ struct sched_ext_ops {
 	 */
 	void (*tick)(struct task_struct *p);
 
+	/**
+	 * runnable - A task is becoming runnable on its associated CPU
+	 * @p: task becoming runnable
+	 * @enq_flags: %SCX_ENQ_*
+	 *
+	 * This and the following three functions can be used to track a task's
+	 * execution state transitions. A task becomes ->runnable() on a CPU,
+	 * and then goes through one or more ->running() and ->stopping() pairs
+	 * as it runs on the CPU, and eventually becomes ->quiescent() when it's
+	 * done running on the CPU.
+	 *
+	 * @p is becoming runnable on the CPU because it's
+	 *
+	 * - waking up (%SCX_ENQ_WAKEUP)
+	 * - being moved from another CPU
+	 * - being restored after temporarily taken off the queue for an
+	 *   attribute change.
+	 *
+	 * This and ->enqueue() are related but not coupled. This operation
+	 * notifies @p's state transition and may not be followed by ->enqueue()
+	 * e.g. when @p is being dispatched to a remote CPU. Likewise, a task
+	 * may be ->enqueue()'d without being preceded by this operation e.g.
+	 * after exhausting its slice.
+	 */
+	void (*runnable)(struct task_struct *p, u64 enq_flags);
+
+	/**
+	 * running - A task is starting to run on its associated CPU
+	 * @p: task starting to run
+	 *
+	 * See ->runnable() for explanation on the task state notifiers.
+	 */
+	void (*running)(struct task_struct *p);
+
+	/**
+	 * stopping - A task is stopping execution
+	 * @p: task stopping to run
+	 * @runnable: is task @p still runnable?
+	 *
+	 * See ->runnable() for explanation on the task state notifiers. If
+	 * !@runnable, ->quiescent() will be invoked after this operation
+	 * returns.
+	 */
+	void (*stopping)(struct task_struct *p, bool runnable);
+
+	/**
+	 * quiescent - A task is becoming not runnable on its associated CPU
+	 * @p: task becoming not runnable
+	 * @deq_flags: %SCX_DEQ_*
+	 *
+	 * See ->runnable() for explanation on the task state notifiers.
+	 *
+	 * @p is becoming quiescent on the CPU because it's
+	 *
+	 * - sleeping (%SCX_DEQ_SLEEP)
+	 * - being moved to another CPU
+	 * - being temporarily taken off the queue for an attribute change
+	 *   (%SCX_DEQ_SAVE)
+	 *
+	 * This and ->dequeue() are related but not coupled. This operation
+	 * notifies @p's state transition and may not be preceded by ->dequeue()
+	 * e.g. when @p is being dispatched to a remote CPU.
+	 */
+	void (*quiescent)(struct task_struct *p, u64 deq_flags);
+
 	/**
 	 * yield - Yield CPU
 	 * @from: yielding task
@@ -1289,6 +1354,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
+	if (SCX_HAS_OP(runnable))
+		SCX_CALL_OP(SCX_KF_REST, runnable, p, enq_flags);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 }
 
@@ -1350,6 +1418,26 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 
 	ops_dequeue(p, deq_flags);
 
+	/*
+	 * A currently running task which is going off @rq first gets dequeued
+	 * and then stops running. As we want running <-> stopping transitions
+	 * to be contained within runnable <-> quiescent transitions, trigger
+	 * ->stopping() early here instead of in put_prev_task_scx().
+	 *
+	 * @p may go through multiple stopping <-> running transitions between
+	 * here and put_prev_task_scx() if task attribute changes occur while
+	 * balance_scx() leaves @rq unlocked. However, they don't contain any
+	 * information meaningful to the BPF scheduler and can be suppressed by
+	 * skipping the callbacks if the task is !QUEUED.
+	 */
+	if (SCX_HAS_OP(stopping) && task_current(rq, p)) {
+		update_curr_scx(rq);
+		SCX_CALL_OP(SCX_KF_REST, stopping, p, false);
+	}
+
+	if (SCX_HAS_OP(quiescent))
+		SCX_CALL_OP(SCX_KF_REST, quiescent, p, deq_flags);
+
 	if (deq_flags & SCX_DEQ_SLEEP)
 		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
 	else
@@ -1933,6 +2021,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
+	/* see dequeue_task_scx() on why we skip when !QUEUED */
+	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
+		SCX_CALL_OP(SCX_KF_REST, running, p);
+
 	clr_task_runnable(p, true);
 }
 
@@ -1971,6 +2063,10 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 
 	update_curr_scx(rq);
 
+	/* see dequeue_task_scx() on why we skip when !QUEUED */
+	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
+		SCX_CALL_OP(SCX_KF_REST, stopping, p, true);
+
 	/*
 	 * If we're being called from put_prev_task_balance(), balance_scx() may
 	 * have decided that @p should keep running.
@@ -3830,6 +3926,10 @@ static s32 select_cpu_stub(struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 static void enqueue_stub(struct task_struct *p, u64 enq_flags) {}
 static void dequeue_stub(struct task_struct *p, u64 enq_flags) {}
 static void dispatch_stub(s32 prev_cpu, struct task_struct *p) {}
+static void runnable_stub(struct task_struct *p, u64 enq_flags) {}
+static void running_stub(struct task_struct *p) {}
+static void stopping_stub(struct task_struct *p, bool runnable) {}
+static void quiescent_stub(struct task_struct *p, u64 deq_flags) {}
 static bool yield_stub(struct task_struct *from, struct task_struct *to) { return false; }
 static void set_weight_stub(struct task_struct *p, u32 weight) {}
 static void set_cpumask_stub(struct task_struct *p, const struct cpumask *mask) {}
@@ -3846,6 +3946,10 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.enqueue = enqueue_stub,
 	.dequeue = dequeue_stub,
 	.dispatch = dispatch_stub,
+	.runnable = runnable_stub,
+	.running = running_stub,
+	.stopping = stopping_stub,
+	.quiescent = quiescent_stub,
 	.yield = yield_stub,
 	.set_weight = set_weight_stub,
 	.set_cpumask = set_cpumask_stub,
-- 
2.44.0



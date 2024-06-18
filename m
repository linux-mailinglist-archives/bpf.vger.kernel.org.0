Return-Path: <bpf+bounces-32454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4A690DE43
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425D71F2348E
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B119AD86;
	Tue, 18 Jun 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei3xOg/2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77C17E44E;
	Tue, 18 Jun 2024 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745707; cv=none; b=MaWzsVq8haW4Bxm3bem66TjjsMULG5BhIXMLnb0GiS0M7XtPyBpwrGqsMuLJ18iUjPqWYCRgSETIXDb5STHmcpV+UmheHtLtWjmu/Pya8JcZzrWFVJ5gIi2kY7NnEGdGl0hk2slq/FwkVcrLGEobCAYIeEmL9UqogzOLBSGNknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745707; c=relaxed/simple;
	bh=M3RhCpDUWR7CKBdadQeTcnoOuYEeC/Nq8M7iBQ5A6hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIVuYN3tUlzgu/2QNbrX+I339vfHi++5JeCr+ZOi1p4S/+rBzmMuebdQMgYFhtZhOklK5ueEIYbG0OnzWgovum+crbIUzJNjYizEzbjUeuoCESm5bSqiBvCLzZERrae9RjoQkuR8DO9eYB0hivl8jNz1huQk54Q7qkVMoC1+kIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei3xOg/2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so140603b3a.0;
        Tue, 18 Jun 2024 14:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745705; x=1719350505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8uN0nkCinHv/Lfh5hjGOyRQI5I9W9K2FBF8PajGCKs=;
        b=Ei3xOg/2QPbZ6MBAYArElTUZz0Ch921ia6df7pJLRYehsL9WjjPbacxwgh1JFzvkXe
         YMnNZgInQSiLj8FeWtQfmFF/BFxqBKlo3WdylzwI1xpmffGhSUrfREtV5iIUMlXcbMKP
         1PT2q0HPVF3Oz3csZnr6ksWg/JLxx16XA3zgLh0EFO4HayLGiKIE1ORyeFTRhliNuTkw
         5Ztv1UWU2ODsmPrCBnkJpUQJKi6ZTxxSdlwAgcnlwAeM/OmlCDse7zn/CYnJxJe3ITwZ
         IGiM9u2Lamy60eaX+J6tMCqYHlxAw3zoCS3JaEK2n4xpezYdWbVlMpbVQ4GyJIfblHuK
         mXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745705; x=1719350505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C8uN0nkCinHv/Lfh5hjGOyRQI5I9W9K2FBF8PajGCKs=;
        b=q/uC37/G+MiK0XLBXBVCgw4uLUIispWxjaZxjCPmwzc2+k7OyY2+n/sURSeB9CtmZx
         5koMZ5jiUYmagu0GQjsGvgc1xFUbUAnrS0lPVBzeLw/pFe9iBGKpAZmK5Kz+7SYRAvxq
         EgPW5Jz+5hW6EKi2BkJqAyxLzi4MBv1qjE0CwWGJqo8DL3ELDQ1RHTl3yy131+tW+XTN
         jI6Vp2Vbp7TKwg6Ozgpnh7PQ8EDfOH4tFzRl2CSJUGqrMzc2X+BAtwxYHeZ90TjUHftt
         0CYpy24RyanSj2NAZhX25eOVvvtFYZlAA9hDL1XdiunbJ6wB4hMGcmtEbEX1c/tQMiAo
         LZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpXWTToQ7IcI7E8ZwH84PLu+fDqZq+MwzBp30JOakXqh8ZHmvuY0LOMr8Pe3YuztMpFPgSHv+xExOYtph0uwfxw1q8
X-Gm-Message-State: AOJu0Ywyu69OxstmDurvKseMR+xvyE1ouLIRAmMOAAo8/yz829kEqy8L
	M6zrizR+jwogJuIY1y1+tOGBLz2HN0tLRpZWWByqZWi8QoAbIcKq
X-Google-Smtp-Source: AGHT+IGbZsF+vCoBRfXfJYXtYpbN4F3rNOX6125S3INQSR3DEgP1KuoD8tHJc9nTdgBCBdoutZje4w==
X-Received: by 2002:a17:90a:34c9:b0:2c2:d6ca:3960 with SMTP id 98e67ed59e1d1-2c7b3ba80b8mr1327615a91.17.1718745704970;
        Tue, 18 Jun 2024 14:21:44 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c501cbb841sm6810352a91.51.2024.06.18.14.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:44 -0700 (PDT)
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
Subject: [PATCH 20/30] sched_ext: Add task state tracking operations
Date: Tue, 18 Jun 2024 11:17:35 -1000
Message-ID: <20240618212056.2833381-21-tj@kernel.org>
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
 kernel/sched/ext.c | 105 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 89bcca84d6b5..2e652f7b8f54 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -214,6 +214,72 @@ struct sched_ext_ops {
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
+	 * e.g. when @p is being dispatched to a remote CPU, or when @p is
+	 * being enqueued on a CPU experiencing a hotplug event. Likewise, a
+	 * task may be ->enqueue()'d without being preceded by this operation
+	 * e.g. after exhausting its slice.
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
@@ -1359,6 +1425,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
+	if (SCX_HAS_OP(runnable))
+		SCX_CALL_OP(SCX_KF_REST, runnable, p, enq_flags);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 }
 
@@ -1418,6 +1487,26 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 
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
@@ -1999,6 +2088,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
+	/* see dequeue_task_scx() on why we skip when !QUEUED */
+	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
+		SCX_CALL_OP(SCX_KF_REST, running, p);
+
 	clr_task_runnable(p, true);
 }
 
@@ -2037,6 +2130,10 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 
 	update_curr_scx(rq);
 
+	/* see dequeue_task_scx() on why we skip when !QUEUED */
+	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
+		SCX_CALL_OP(SCX_KF_REST, stopping, p, true);
+
 	/*
 	 * If we're being called from put_prev_task_balance(), balance_scx() may
 	 * have decided that @p should keep running.
@@ -4081,6 +4178,10 @@ static s32 select_cpu_stub(struct task_struct *p, s32 prev_cpu, u64 wake_flags)
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
@@ -4097,6 +4198,10 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
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
2.45.2



Return-Path: <bpf+bounces-71637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F088BF8E2A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 23:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C96564622
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2204283CB5;
	Tue, 21 Oct 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBSdOj8V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1353128640F;
	Tue, 21 Oct 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080638; cv=none; b=hUxhA9oGxDjlyk9E1aZKe9Mh7wvtOek7DNbQ1JcI+HkRWt3y1wH0x50FK4YoVgRQQswQ6NLllI5jp+JbJQLGI/qkPL/ylAasfqhfUMdtJSKp4vl3xzocpvOhNxm0WcR3amDaGnrhUsrnmd2fnZ0CVR9S/PspUodvksT/WAWOYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080638; c=relaxed/simple;
	bh=nO4XYAYdsd9fcLoPnd9+7c7/knhsLnXNsxHYoVP5GZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtPHyVkfvGbX4chz9yPg/0Muj3WMei1XEW1oGeScnKSDEjSIgKOMUVNoO1aHH2ZvrXKMm5xdZesMpWvArUThyb9LVoBzNESyOkNZdgDt6mEH75yR9We+Uugvqt8AYS0ofTX/nKRNYiMfor3MsYjIFwKqDEenxevknNFqC6RSj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBSdOj8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B28DC4CEFD;
	Tue, 21 Oct 2025 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761080637;
	bh=nO4XYAYdsd9fcLoPnd9+7c7/knhsLnXNsxHYoVP5GZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBSdOj8Vk7QssjyIoe/Jaq8UtDwUQ3aQ/lm129jpzaSmTVVd4rD+fzZ6QqNoTzjRN
	 G0dbVBKF/z9I7uFS8ipjsK+SBpRX2/0pldbkwPAah1pkcVFWWttPVtjSkpYkyM/7nm
	 tcV5DJZMXmhiC0s202JSOdM79+8v4CNxdRsJrt98meocLEuT50+zGhBXwqf8ZvjfrV
	 EvG5Fnv6FXcRABt7JnJVB1yIa6NrvG6o1O5DTd0OuGflBU7gX0NFNPL8dpVT8bRSvv
	 MElo3w5T5VAyLmjqc+XQZWWs+n+OBIE9OUmSN+4wFQ8aa+Nc/6RSH/34XxM+8xDe6X
	 okD5dv+Z3kBWw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: sched_ext: Fix SCX_KICK_WAIT to work reliably
Date: Tue, 21 Oct 2025 11:03:54 -1000
Message-ID: <20251021210354.89570-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021210354.89570-1-tj@kernel.org>
References: <20251021210354.89570-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_KICK_WAIT is used to synchronously wait for the target CPU to complete
a reschedule and can be used to implement operations like core scheduling.

This used to be implemented by scx_next_task_picked() incrementing pnt_seq,
which was always called when a CPU picks the next task to run, allowing
SCX_KICK_WAIT to reliably wait for the target CPU to enter the scheduler and
pick the next task.

However, commit b999e365c298 ("sched_ext: Replace scx_next_task_picked()
with switch_class()") replaced scx_next_task_picked() with the
switch_class() callback, which is only called when switching between sched
classes. This broke SCX_KICK_WAIT because pnt_seq would no longer be
reliably incremented unless the previous task was SCX and the next task was
not.

This fix leverages commit 4c95380701f5 ("sched/ext: Fold balance_scx() into
pick_task_scx()") which refactored the pick path making put_prev_task_scx()
the natural place to track task switches for SCX_KICK_WAIT. The fix moves
pnt_seq increment to put_prev_task_scx() and refines the semantics: If the
current task on the target CPU is SCX, SCX_KICK_WAIT waits until that task
switches out. This provides sufficient guarantee for use cases like core
scheduling while keeping the operation self-contained within SCX.

Reported-by: Wen-Fang Liu <liuwenfang@honor.com>
Link: http://lkml.kernel.org/r/228ebd9e6ed3437996dffe15735a9caa@honor.com
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          |   31 ++++++++++++++++++-------------
 kernel/sched/ext_internal.h |    6 ++++--
 2 files changed, 22 insertions(+), 15 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2260,12 +2260,6 @@ static void switch_class(struct rq *rq,
 	struct scx_sched *sch = scx_root;
 	const struct sched_class *next_class = next->sched_class;
 
-	/*
-	 * Pairs with the smp_load_acquire() issued by a CPU in
-	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
-	 * resched.
-	 */
-	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
 	if (!(sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT))
 		return;
 
@@ -2305,6 +2299,14 @@ static void put_prev_task_scx(struct rq
 			      struct task_struct *next)
 {
 	struct scx_sched *sch = scx_root;
+
+	/*
+	 * Pairs with the smp_load_acquire() issued by a CPU in
+	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
+	 * resched.
+	 */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
@@ -5144,8 +5146,12 @@ static bool kick_one_cpu(s32 cpu, struct
 		}
 
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_wait)) {
-			pseqs[cpu] = rq->scx.pnt_seq;
-			should_wait = true;
+			if (cur_class == &ext_sched_class) {
+				pseqs[cpu] = rq->scx.pnt_seq;
+				should_wait = true;
+			} else {
+				cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
+			}
 		}
 
 		resched_curr(rq);
@@ -5208,12 +5214,11 @@ static void kick_cpus_irq_workfn(struct
 
 		if (cpu != cpu_of(this_rq)) {
 			/*
-			 * Pairs with smp_store_release() issued by this CPU in
-			 * switch_class() on the resched path.
+			 * Pairs with store_release in put_prev_task_scx().
 			 *
-			 * We busy-wait here to guarantee that no other task can
-			 * be scheduled on our core before the target CPU has
-			 * entered the resched path.
+			 * We busy-wait here to guarantee that the task running
+			 * at the time of kicking is no longer running. This can
+			 * be used to implement e.g. core scheduling.
 			 */
 			while (smp_load_acquire(wait_pnt_seq) == pseqs[cpu])
 				cpu_relax();
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -997,8 +997,10 @@ enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 1,
 
 	/*
-	 * Wait for the CPU to be rescheduled. The scx_bpf_kick_cpu() call will
-	 * return after the target CPU finishes picking the next task.
+	 * The scx_bpf_kick_cpu() call will return after the current SCX task of
+	 * the target CPU switches out. This can be used to implement e.g. core
+	 * scheduling. This has no effect if the current task on the target CPU
+	 * is not on SCX.
 	 */
 	SCX_KICK_WAIT		= 1LLU << 2,
 };


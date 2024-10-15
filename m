Return-Path: <bpf+bounces-41968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 437ED99DE2B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 08:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6850B22727
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 06:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFFE18A6DB;
	Tue, 15 Oct 2024 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dJPBkla0"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A36189BB9
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973381; cv=none; b=meX39ytLKX49A80qg9Gn1Bwwwd0qaQrwa35o69UYEPm33LXUMF5EUKnIZC644tPVP0X6h+xNvbWWnRR+4nnAiFbUux9E3f5sbaCiT38E4HJF7aGaKjJU66ve8QnlezlU0e9F/23sH0hkKooorOwTkOsRKKumxTAD/EP/onFBoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973381; c=relaxed/simple;
	bh=WhJWhAbq0UVdVTbBtMSmvTKOy1yBEbfuRj6REU2MJ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oz8oFIUhdoKCvN2Wa8w1Op7dTIwU8jq6fMqBMXEhmZsJtjYwhEKEGRX/jxvMsmG+HopreE2d3i4/bqw80x8miHi3wrKAk2dywi9iU4g2ppy8HGioAwzIX+BJspTSkSErL+FOwacUL5flT7L2zYmUy9VfmdqVbcTRFX0pXszSZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dJPBkla0; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728973374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xV2Yn9Bz9oRhnkXtJemv6T7ztjEHIIDMEfp++wcVRdY=;
	b=dJPBkla0CzIQt1/oCLTl+pyBwsupuDADTe3AMaNaRjSbkYP42m30f4ofdFd5LRYo9NRlmI
	AiJiV7ef9EpEWCpe55/OYaVyye+0s06QQXtww2oGxuAR5qko658/weME0PXIKGBiuJnJLz
	FpJN01awZym+VFUgSI0s7Tvjo4WOxIU=
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3] sched_ext: Trigger ops.update_idle() from pick_task_idle()
Date: Tue, 15 Oct 2024 08:22:50 +0200
Message-ID: <20241015062250.55350-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

With the consolidation of put_prev_task/set_next_task(), see
commit 436f3eed5c69 ("sched: Combine the last put_prev_task() and the
first set_next_task()"), we are now skipping the transition between
these two functions when the previous and the next tasks are the same.

As a result, ops.update_idle() is now called only once when the CPU
transitions to the idle class. If the CPU stays active (e.g., through a
call to scx_bpf_kick_cpu()), ops.update_idle() will not be triggered
again since the task remains unchanged (rq->idle).

While this behavior seems generally correct, it can cause issues in
certain sched_ext scenarios.

For example, a BPF scheduler might use logic like the following to keep
the CPU active under specific conditions:

void BPF_STRUCT_OPS(sched_update_idle, s32 cpu, bool idle)
{
	if (!idle)
		return;
	if (condition)
		scx_bpf_kick_cpu(cpu, 0);
}

A call to scx_bpf_kick_cpu() wakes up the CPU, so in theory,
ops.update_idle() should be triggered again until the condition becomes
false. However, this doesn't happen, and scx_bpf_kick_cpu() doesn't
produce the expected effect.

In practice, this change badly impacts performance in user-space
schedulers that rely on ops.update_idle() to activate user-space
components.

For instance, in the case of scx_rustland, performance drops
significantly (e.g., gaming benchmarks fall from ~60fps to ~10fps).

To address this, trigger ops.update_idle() from pick_task_idle() rather
than set_next_task_idle(). This restores the correct behavior of
ops.update_idle() and it allows to fix the performance regression in
scx_rustland.

Fixes: 7c65ae81ea86 ("sched_ext: Don't call put_prev_task_scx() before picking the next task")
Signed-off-by: Andrea Righi <andrea.righi@linux.dev>
---
 kernel/sched/idle.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

ChangeLog v2 -> v3:
  - add a comment to clarify why we need to update the scx idle state in
    pick_task()

ChangeLog v1 -> v2:
  - move the logic from put_prev_set_next_task() to scx_update_idle()

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d2f096bb274c..d336a05a6006 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -459,13 +459,26 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
 	update_idle_core(rq);
-	scx_update_idle(rq, true);
 	schedstat_inc(rq->sched_goidle);
 	next->se.exec_start = rq_clock_task(rq);
 }
 
 struct task_struct *pick_task_idle(struct rq *rq)
 {
+	/*
+	 * When switching from a non-idle to the idle class, .set_next_task()
+	 * is called only once during the transition.
+	 *
+	 * However, the CPU may remain active for multiple rounds (e.g., by
+	 * calling scx_bpf_kick_cpu() from the ops.update_idle() callback).
+	 *
+	 * In such cases, we need to keep updating the scx idle state to
+	 * properly re-trigger the ops.update_idle() callback.
+	 *
+	 * Updating the state in .pick_task(), instead of .set_next_task(),
+	 * ensures correct handling of scx idle state transitions.
+	 */
+	scx_update_idle(rq, true);
 	return rq->idle;
 }
 
-- 
2.47.0



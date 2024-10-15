Return-Path: <bpf+bounces-42011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF399E557
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6941C21D1C
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8CA1CF295;
	Tue, 15 Oct 2024 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hwE0CfQ6"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DC146588
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990946; cv=none; b=fbIooOVNI9tM58p0ZHMXo0PKXHpjFMryuDyXfpRSzxVIBXURlJifW09Dn/jifBCDxWOD3X07pG59jS65zmmLSz9fQl/Ca5Noj6+TbjT8hazcHpUaWi07psfgZHKSyjZsAvIdD+FtaWs5OkR+Ltzl2w9BRurMC4Ar38NbM/dc1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990946; c=relaxed/simple;
	bh=ssmqsWWS81Vg0uTaEuJJktUUR/hioVtLY2g+nX1p7M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ha2Md3QMIQ/zJ/wJHUyw10aXW1pTdJ6aHNT4CXS+d7sLZ1nMAJO05drfbroUJ8LvHM1oy0BanVfYOFUR8vN34HuGlXypbUStOzthzOh1sMF9LMPis+rACdyBVWvRwg6jMx5o+T019eVJrMWQhMeRfPyO4ePdDcs/l1k7dB5vZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hwE0CfQ6; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728990942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ucQtvznDemSDFD+kG00/HvX/vw51G6Sc6n843ys325E=;
	b=hwE0CfQ6zx5RuK8fo0dhqMPrV6DJKqfw01P+l6q1t/dOTG+tcASPg4MJRgpNPZn1TUXss9
	iUYoJrknU87/9Cy/XIxRrHNxfysegb3M1fRNJ/HpSadnin1HDRLKzfrnsyvb6CB/JmoCo+
	lsgbqfDDgAVEbhdHFEbtPevoTIB+k/w=
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
Subject: [PATCH v4] sched_ext: Trigger ops.update_idle() from pick_task_idle()
Date: Tue, 15 Oct 2024 13:15:39 +0200
Message-ID: <20241015111539.12136-1-andrea.righi@linux.dev>
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

To address this, trigger ops.update_idle() also from pick_task_idle()
when the idle task keeps running on the CPU. This restores the correct
behavior of ops.update_idle() and it allows to fix the performance
regression in scx_rustland.

Fixes: 7c65ae81ea86 ("sched_ext: Don't call put_prev_task_scx() before picking the next task")
Signed-off-by: Andrea Righi <andrea.righi@linux.dev>
---
 kernel/sched/idle.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

ChangeLog v3 -> v4:
  - handle the core-sched case that may ignore the result of
    pick_task(), triggering spurious ops.update_idle() events

ChangeLog v2 -> v3:
  - add a comment to clarify why we need to update the scx idle state in
    pick_task()

ChangeLog v1 -> v2:
  - move the logic from put_prev_set_next_task() to scx_update_idle()

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d2f096bb274c..3e76b11237a9 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -466,6 +466,20 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 
 struct task_struct *pick_task_idle(struct rq *rq)
 {
+	/*
+	 * When switching from a non-idle to the idle class, .set_next_task()
+	 * is called only once during the transition.
+	 *
+	 * However, the CPU may remain active for multiple rounds running the
+	 * idle task (e.g., by calling scx_bpf_kick_cpu() from the
+	 * ops.update_idle() callback).
+	 *
+	 * In such cases, we need to keep updating the scx idle state to
+	 * properly re-trigger the ops.update_idle() callback and ensure
+	 * correct handling of scx idle state transitions.
+	 */
+	if (rq->curr == rq->idle)
+		scx_update_idle(rq, true);
 	return rq->idle;
 }
 
-- 
2.47.0



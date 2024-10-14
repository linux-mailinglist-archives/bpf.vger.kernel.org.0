Return-Path: <bpf+bounces-41889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142599D99F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E96283287
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD4713BC02;
	Mon, 14 Oct 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aa6rcK+U"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E21D12FE
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943573; cv=none; b=Be+SqJOkQNfgviqVNQMD9jr6TdfTsnGN3hSLOtnutr3DUrKeYTaV/4WF05a3JQ4zlPgVhhdOXrgZRF2RHirnP8X7Ek2kA5wQk9PSKBYF4oHtF7RNimmlO6FbUB1C/GJrm9p7/DZf1e5V9uzIxXB8HYk6r1uuH8cM3oyLd6F7l0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943573; c=relaxed/simple;
	bh=5qTbAz9HdW7boogj3+5WSD1OI0ME1rdWeb8QLX1Yb74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqVpKZznyqIIo4AjaBc4QW8FfleaFPS698KvlBd8n3sXghfBYNpWajv57HdRFuATlEvA4ij6ZOVBZ+DWUP0rTNk4u1QubuPxF6vw37P/SMQrwIxmvVkPVPN/p06UNaenz2K9aLzzOFEszANZmZQ2I0sOzMP/MtPJLi3LUUqxbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aa6rcK+U; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728943568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Eg2qUencFOdUUjQJy4th10S6VBboP5vdfVxJHTHFD0=;
	b=aa6rcK+U1YP9YjIK5G4PEjvZs7EnQMeWXMiS4sqxEEPElCLAwmxVnRT2J5DfqsrnpBGILb
	DuPHa6/zzLIFJga72ibL5HIdDlE4qOqM4JvYN10f70G25eVVw6mX5oOhUD9ipR+N+yeDpB
	9l4pbldTC+kBRHc7Of7R7jZ2W1ChPoQ=
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
Subject: [PATCH v2] sched_ext: Trigger ops.update_idle() from pick_task_idle()
Date: Tue, 15 Oct 2024 00:06:03 +0200
Message-ID: <20241014220603.35280-1-andrea.righi@linux.dev>
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
 kernel/sched/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

ChangeLog v1 -> v2:
  - move the logic from put_prev_set_next_task() to scx_update_idle()

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d2f096bb274c..5a10cbc7e9df 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -459,13 +459,13 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
 	update_idle_core(rq);
-	scx_update_idle(rq, true);
 	schedstat_inc(rq->sched_goidle);
 	next->se.exec_start = rq_clock_task(rq);
 }
 
 struct task_struct *pick_task_idle(struct rq *rq)
 {
+	scx_update_idle(rq, true);
 	return rq->idle;
 }
 
-- 
2.47.0



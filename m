Return-Path: <bpf+bounces-69066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF5B8BC2F
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5341C225D7
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13691F3B8A;
	Sat, 20 Sep 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSD1gwIO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A21F237A;
	Sat, 20 Sep 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330009; cv=none; b=a8xaF95MHkETt1cic50iE0uM5CicIPYIdP7zrf/vTygocQBdVl5eojP/NmQbfrV+rrfBi6vjAAm5wIwlGzTZuNoyG3UdYZ0fXQdFECZbAKiuONprYg8D43eMFEXs/yUTyDYpvnQPL6NjgLtZDBHHuxDBFIafcjiMi26N6j+GO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330009; c=relaxed/simple;
	bh=pqKKnI+GnxavUkovO5oohp4tN6H60dKv8Yup83odcVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgaJY7SzloKrO7vIscnP6nLkrBfzn9OiP3EkS+gG1zDl/p8fJkOacWmZzbMNhC60VUsL88+wiVyQZQDFO/zJ0LPe865fXMZuRvHVm0WLOLUz9w+lbFERQqWW3Em5mfOM+SUimao2xCqm05rn9IIqijeR78jeG7D/3U1cIjEr1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSD1gwIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1AFC4CEF9;
	Sat, 20 Sep 2025 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330009;
	bh=pqKKnI+GnxavUkovO5oohp4tN6H60dKv8Yup83odcVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSD1gwIOPiT1WgOYbE9cEFO9Wr8V+sauyCWwfaSpTK7CgBgjwYBaiaSrbosHFi6cf
	 laCMjnsWro/08P0Q0ACbCw9vWq6XrWSgWmOp6SbKi4y2n4AaSi2lKJ+TqOjBxxPFrh
	 B/PHalnQSgNegpW6n7g23EU0/TjwocDCxHYcSOE3ZLBl3ajTaGYqpxIJzqEY5LJSMc
	 t1IS0ihyLpE2XBwj6hGOTu6BkYD87v0Blanatqqe9un/U1VIWMNAwmqFqICAmo60yY
	 xss6y78ZzzlRvcxFCsZ3Di0Mphe31q7mtcFdcyDmG+1pPOsd7ZBZ1Wm4gQ15YfP2sA
	 X39OcSzyRWqFQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 32/46] sched_ext: Make bypass mode sub-sched aware
Date: Fri, 19 Sep 2025 14:58:55 -1000
Message-ID: <20250920005931.2753828-33-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bypass mode is used to simplify enable and disable paths and guarantee
forward progress when something goes wrong. When enabled, all tasks skip
BPF scheduling and fall back to simple in-kernel FIFO scheduling. While
this global behavior can be used as-is when dealing with sub-scheds, that
would allow any sub-sched instance to affect the whole system in a
significantly disruptive manner.

Make bypass mode hierarchical instead. An scx_sched bypasses if itself or
any of its ancestors are in the bypass mode.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5f22a79e19ec..44f9cc7f0915 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3949,6 +3949,7 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 {
 	static DEFINE_RAW_SPINLOCK(bypass_lock);
 	static unsigned long bypass_timestamp;
+	struct scx_sched *pos;
 	unsigned long flags;
 	int cpu;
 
@@ -3970,6 +3971,24 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 			      ktime_get_ns() - bypass_timestamp);
 	}
 
+	/*
+	 * Bypass state is propagated to all descendants - an scx_sched bypasses
+	 * if itself or any of its ancestors are in bypass mode.
+	 */
+	raw_spin_lock(&scx_sched_lock);
+	scx_for_each_descendant_pre(pos, sch) {
+		if (pos == sch)
+			continue;
+		if (bypass) {
+			pos->bypass_depth++;
+			WARN_ON_ONCE(pos->bypass_depth <= 0);
+		} else {
+			pos->bypass_depth--;
+			WARN_ON_ONCE(pos->bypass_depth < 0);
+		}
+	}
+	raw_spin_unlock(&scx_sched_lock);
+
 	if (!scx_parent(sch))
 		atomic_inc(&scx_breather_depth);
 
@@ -3984,18 +4003,20 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
-		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 		struct task_struct *p, *n;
 
 		raw_spin_rq_lock(rq);
 
-		if (bypass) {
-			WARN_ON_ONCE(pcpu->flags & SCX_SCHED_PCPU_BYPASSING);
-			pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
-		} else {
-			WARN_ON_ONCE(!(pcpu->flags & SCX_SCHED_PCPU_BYPASSING));
-			pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
+		raw_spin_lock(&scx_sched_lock);
+		scx_for_each_descendant_pre(pos, sch) {
+			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
+
+			if (pos->bypass_depth)
+				pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
+			else
+				pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
 		}
+		raw_spin_unlock(&scx_sched_lock);
 
 		/*
 		 * We need to guarantee that no tasks are on the BPF scheduler
@@ -4018,6 +4039,9 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 						 scx.runnable_node) {
 			struct sched_enq_and_set_ctx ctx;
 
+			if (!scx_is_descendant(scx_task_sched(p), sch))
+				continue;
+
 			/* cycling deq/enq is enough, see the function comment */
 			sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 			sched_enq_and_set_task(&ctx);
-- 
2.51.0



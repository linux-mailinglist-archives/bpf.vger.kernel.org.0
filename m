Return-Path: <bpf+bounces-69067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDDFB8BC44
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267C3170AE5
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D002DF15D;
	Sat, 20 Sep 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCLjl855"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B42DC79C;
	Sat, 20 Sep 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330010; cv=none; b=JnPd32dRR2Aeo/H4Wuk0rQ2w2osWL+6n4UkvSQUClScla3OmpWgL4pZ2nATIyyBYZp2IlwOB7pOyR/YXo3h3zG49QiS/M1fcxm1Fp9wBIbUNrJ6EKtMvAP6nT+0y0oGwVBK+aPNQH66YJUFJJ2svjnrLlc5pvYo8Fao2BXOXITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330010; c=relaxed/simple;
	bh=KVRvG8gDgAbbcY2HntqFPr37LrmGnP57PFz+/38SPO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGGb0LSfgeaFiEHsnlO+DHO3q/cfd2urUoZJx20/oBgJa78OA4Mgyf5dW9DWJzecFkn8oS2eEsfNgQG/nLBz0296LmI9WHB76Z3qCXKwp64fUhfMcP5TV2/LiaLjf9dZTfJSX8fFDIZQsbOSzW3hyJ+rkoPTxtlC94HZwy0MGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCLjl855; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6C1C4CEF0;
	Sat, 20 Sep 2025 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330010;
	bh=KVRvG8gDgAbbcY2HntqFPr37LrmGnP57PFz+/38SPO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCLjl855aeJDAaiCuuW13rsdOIe3Y+VA5TNB2F2rcpZ9oZuXU/eTYELGbAqZH0ZVO
	 mNPkW9UxBBm41vGKC1iq4u7ajSiijn1+1QHoiCkSanYzXmjdLhg9Ijp5qcB7n+fxpK
	 K71WxgGqr3WJjTGwPjOrkhd6ATjw+umveORGjv86OOgk4yns7eMi2YnkIs4r0TOCmU
	 ngaxTPLWu9j+i8neLfQCe9+WujLMCA/v/lMgEDjT/moubiM+FsXEnV+PhqUAKVh/kW
	 Ym7j+UroRB72hzq2HS/M0xOa0/9KeKW+NMMBt+dIr2NGdV1FNx4EhqIKrR/ZGUK5VA
	 mO/V+KFjHPBug==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 33/46] sched_ext: Factor out scx_dispatch_sched()
Date: Fri, 19 Sep 2025 14:58:56 -1000
Message-ID: <20250920005931.2753828-34-tj@kernel.org>
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

In preparation of multiple scheduler support, factor out
scx_dispatch_sched() from balance_one(). The function boundary makes
remembering $prev_on_scx and $prev_on_rq less useful. Open code $prev_on_scx
in balance_one() and $prev_on_rq in both balance_one() and
scx_dispatch_sched().

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 115 ++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 53 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 44f9cc7f0915..efe01ba84e2d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2178,14 +2178,68 @@ static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
 	dspc->cursor = 0;
 }
 
-static int balance_one(struct rq *rq, struct task_struct *prev)
+static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
+			       struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
-	bool prev_on_rq = prev->scx.flags & SCX_TASK_QUEUED;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 
+	if (consume_global_dsq(sch, rq))
+		return true;
+
+	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
+	    scx_bypassing(sch, cpu_of(rq)) || !scx_rq_online(rq))
+		return false;
+
+	dspc->rq = rq;
+
+	/*
+	 * The dispatch loop. Because flush_dispatch_buf() may drop the rq lock,
+	 * the local DSQ might still end up empty after a successful
+	 * ops.dispatch(). If the local DSQ is empty even after ops.dispatch()
+	 * produced some tasks, retry. The BPF scheduler may depend on this
+	 * looping behavior to simplify its implementation.
+	 */
+	do {
+		dspc->nr_tasks = 0;
+
+		SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq,
+			    cpu_of(rq), prev_on_scx ? prev : NULL);
+
+		flush_dispatch_buf(sch, rq);
+
+		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice) {
+			rq->scx.flags |= SCX_RQ_BAL_KEEP;
+			return true;
+		}
+		if (rq->scx.local_dsq.nr)
+			return true;
+		if (consume_global_dsq(sch, rq))
+			return true;
+
+		/*
+		 * ops.dispatch() can trap us in this loop by repeatedly
+		 * dispatching ineligible tasks. Break out once in a while to
+		 * allow the watchdog to run. As IRQ can't be enabled in
+		 * balance(), we want to complete this scheduling cycle and then
+		 * start a new one. IOW, we want to call resched_curr() on the
+		 * next, most likely idle, task, not the current one. Use
+		 * __scx_bpf_kick_cpu() for deferred kicking.
+		 */
+		if (unlikely(!--nr_loops)) {
+			scx_kick_cpu(sch, cpu_of(rq), 0);
+			break;
+		}
+	} while (dspc->nr_tasks);
+
+	return false;
+}
+
+static int balance_one(struct rq *rq, struct task_struct *prev)
+{
+	struct scx_sched *sch = scx_root;
+
 	lockdep_assert_rq_held(rq);
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
 	rq->scx.flags &= ~(SCX_RQ_BAL_PENDING | SCX_RQ_BAL_KEEP);
@@ -2204,7 +2258,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		rq->scx.cpu_released = false;
 	}
 
-	if (prev_on_scx) {
+	if (prev->sched_class == &ext_sched_class) {
 		update_curr_scx(rq);
 
 		/*
@@ -2217,7 +2271,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * See scx_disable_workfn() for the explanation on the bypassing
 		 * test.
 		 */
-		if (prev_on_rq && prev->scx.slice &&
+		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice &&
 		    !scx_bypassing(sch, cpu_of(rq))) {
 			rq->scx.flags |= SCX_RQ_BAL_KEEP;
 			goto has_tasks;
@@ -2228,60 +2282,15 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (rq->scx.local_dsq.nr)
 		goto has_tasks;
 
-	if (consume_global_dsq(sch, rq))
+	/* dispatch @sch */
+	if (scx_dispatch_sched(sch, rq, prev))
 		goto has_tasks;
 
-	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
-	    scx_bypassing(sch, cpu_of(rq)) || !scx_rq_online(rq))
-		goto no_tasks;
-
-	dspc->rq = rq;
-
-	/*
-	 * The dispatch loop. Because flush_dispatch_buf() may drop the rq lock,
-	 * the local DSQ might still end up empty after a successful
-	 * ops.dispatch(). If the local DSQ is empty even after ops.dispatch()
-	 * produced some tasks, retry. The BPF scheduler may depend on this
-	 * looping behavior to simplify its implementation.
-	 */
-	do {
-		dspc->nr_tasks = 0;
-
-		SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq,
-			    cpu_of(rq), prev_on_scx ? prev : NULL);
-
-		flush_dispatch_buf(sch, rq);
-
-		if (prev_on_rq && prev->scx.slice) {
-			rq->scx.flags |= SCX_RQ_BAL_KEEP;
-			goto has_tasks;
-		}
-		if (rq->scx.local_dsq.nr)
-			goto has_tasks;
-		if (consume_global_dsq(sch, rq))
-			goto has_tasks;
-
-		/*
-		 * ops.dispatch() can trap us in this loop by repeatedly
-		 * dispatching ineligible tasks. Break out once in a while to
-		 * allow the watchdog to run. As IRQ can't be enabled in
-		 * balance(), we want to complete this scheduling cycle and then
-		 * start a new one. IOW, we want to call resched_curr() on the
-		 * next, most likely idle, task, not the current one. Use
-		 * scx_kick_cpu() for deferred kicking.
-		 */
-		if (unlikely(!--nr_loops)) {
-			scx_kick_cpu(sch, cpu_of(rq), 0);
-			break;
-		}
-	} while (dspc->nr_tasks);
-
-no_tasks:
 	/*
 	 * Didn't find another task to run. Keep running @prev unless
 	 * %SCX_OPS_ENQ_LAST is in effect.
 	 */
-	if (prev_on_rq &&
+	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) ||
 	     scx_bypassing(sch, cpu_of(rq)))) {
 		rq->scx.flags |= SCX_RQ_BAL_KEEP;
-- 
2.51.0



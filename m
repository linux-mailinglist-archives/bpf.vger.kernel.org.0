Return-Path: <bpf+bounces-56219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4925A930C4
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 05:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF88A46B4
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C21D268698;
	Fri, 18 Apr 2025 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="QMKeyD2x"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8BE1DAC81;
	Fri, 18 Apr 2025 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744946842; cv=none; b=ua/p+udniLWQWxRoEc9qXzPZ1vy1fm77CKOf+iEMP3PMcIbBMzKtpEUGP/PPR/Vve/pmcwwwPN4IKU3SgQBjJA5CrLmSNlqmi3PQIPjYLTmY8/eIg4O47T5pfZrLo3rX+b9FbVzhLBidm6hePjYz3yxvCwWpVKFbgeh6I1NqosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744946842; c=relaxed/simple;
	bh=EkaPxG0GHnoemmotLyW6dmFrJma2k7EB4KK2UrrPSds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NgJx8lULJFQUNQbqpbmUx4MTR6KkIYV2ek32RrvzjHZBwU8C25W3hncEv5cbab+IeIrhuDNr7m4RYh5Fu9NEcIkRA5PpgQCODwuFEWMQJX9WKi8z2CtNIgh0qFMgqFb679Lpp3jEuP9OjhjpqVMMsBaDLMuEvACkiXM8ZZdCols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=QMKeyD2x; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LfMB4
	/ZZZnzaabPKTMQe0oEWWhOGgmuyjQA6Yi6xzcE=; b=QMKeyD2x+bUlvciJ87MVS
	xqUbbjctXWOOvLkqe2I00pW1SObzUbbzPliL8E2q0TZDaKiFkAQCckGQlievyae7
	UyRKXRo989dM0OEC9XKNv5ciMI6fjjYmx6wR5EvPbpLl/Ji/pa7Dfac3iXZG2dym
	HvM1FqSpYw7YgtMSnoDIns=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3l2pNxgFodOZBDA--.38467S4;
	Fri, 18 Apr 2025 11:26:10 +0800 (CST)
From: Honglei Wang <jameshongleiwang@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	joshdon@google.com,
	brho@google.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	jameshongleiwang@126.com
Subject: [PATCH v2 2/2] sched_ext: add helper for refill task with default slice
Date: Fri, 18 Apr 2025 11:26:03 +0800
Message-Id: <20250418032603.61803-3-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250418032603.61803-1-jameshongleiwang@126.com>
References: <20250418032603.61803-1-jameshongleiwang@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3l2pNxgFodOZBDA--.38467S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1xZFyDWFy5Aw1rCrWxWFg_yoW5Jr18p3
	Zaya45XF48J3W2vay0qrWkC3Wa9ws3A34UCrZ5J397trsrtwnYvFyrJw43try5Xr9093Wx
	tF4j9F13tr1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UwVysUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiJBIzrWgBwvdNFAAAst

Add helper for refilling task with default slice and event
statistics accordingly.

Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
---
 kernel/sched/ext.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2a091ea23328..579dc0e9443a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1815,6 +1815,12 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 	WRITE_ONCE(dsq->nr, dsq->nr + delta);
 }
 
+static void refill_task_slice_dfl(struct task_struct *p)
+{
+	p->scx.slice = SCX_SLICE_DFL;
+	__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
+}
+
 static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 			     u64 enq_flags)
 {
@@ -2196,16 +2202,14 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 * higher priority it becomes from scx_prio_less()'s POV.
 	 */
 	touch_core_sched(rq, p);
-	p->scx.slice = SCX_SLICE_DFL;
-	__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
+	refill_task_slice_dfl(p);
 local_norefill:
 	dispatch_enqueue(&rq->scx.local_dsq, p, enq_flags);
 	return;
 
 global:
 	touch_core_sched(rq, p);	/* see the comment in local: */
-	p->scx.slice = SCX_SLICE_DFL;
-	__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
+	refill_task_slice_dfl(p);
 	dispatch_enqueue(find_global_dsq(p), p, enq_flags);
 }
 
@@ -3294,10 +3298,8 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 	 */
 	if (keep_prev) {
 		p = prev;
-		if (!p->scx.slice) {
-			p->scx.slice = SCX_SLICE_DFL;
-			__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
-		}
+		if (!p->scx.slice)
+			refill_task_slice_dfl(p);
 	} else {
 		p = first_local_task(rq);
 		if (!p) {
@@ -3312,8 +3314,7 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 						p->comm, p->pid, __func__);
 				scx_warned_zero_slice = true;
 			}
-			p->scx.slice = SCX_SLICE_DFL;
-			__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
+			refill_task_slice_dfl(p);
 		}
 	}
 
@@ -3397,9 +3398,8 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
 		if (cpu >= 0) {
-			p->scx.slice = SCX_SLICE_DFL;
+			refill_task_slice_dfl(p);
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
-			__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
 		} else {
 			cpu = prev_cpu;
 		}
-- 
2.45.2



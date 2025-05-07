Return-Path: <bpf+bounces-57600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4D7AAD293
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AF1504E17
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5313C9C4;
	Wed,  7 May 2025 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="cd6F0zMO"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C0C8F5E;
	Wed,  7 May 2025 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580677; cv=none; b=sZbxijmt/Z9/soU65QZp8a7tGZgsCIrpDCkC9d+ZGBVUgCtETINibXgDN/6fpsbV4xzDdHJyPEQlmgscNo5Ut/DYZVBdrN3zuUZe6bmT/GLrydE6TV2iG5aesYPE/6iNwdEnLk92pBppONFikGYHexL2cMa6HKNfn/nE3hB31qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580677; c=relaxed/simple;
	bh=EkaPxG0GHnoemmotLyW6dmFrJma2k7EB4KK2UrrPSds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kEfkK7ycP/GPs3JsgOnFP4gWxIkJ/wITNMr+9w2hUt1kpE7r7jBubHiyyI05ojzyJ9uolM+vjbCM9VfUcT9uv2gqZMxPQF2OoAwdFn4WWVVamq+7Cpy0u1fSNWRAZkU6tWiFgKqqOWtzYHGplJ6Ll78l6uUFE4R880R+X0Sbix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=cd6F0zMO; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LfMB4
	/ZZZnzaabPKTMQe0oEWWhOGgmuyjQA6Yi6xzcE=; b=cd6F0zMO912YBQ2gNr9nK
	cEuyJhKvh6HQVAezI7pBG6oXmzx/yIveFLsUMYT2lu0KSBE7+defy+gOf/u337+G
	9r0f/z2gh5/d6Wxz2X14FAGV+bEp2SPBB4D83SPAt9X0iQmSKLRgpYZeF/YBvgTV
	Q86cbhj2+FUJsQfe5g/pV8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3P8x2tBpocz5dBw--.62210S4;
	Wed, 07 May 2025 09:16:43 +0800 (CST)
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
Subject: [RESEND PATCH v2 2/2] sched_ext: add helper for refill task with default slice
Date: Wed,  7 May 2025 09:16:37 +0800
Message-Id: <20250507011637.77589-3-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250507011637.77589-1-jameshongleiwang@126.com>
References: <20250507011637.77589-1-jameshongleiwang@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P8x2tBpocz5dBw--.62210S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1xZFyDWFy5Aw1rCrWxWFg_yoW5Jr18p3
	Zaya45XF48J3W2vay0qrWkC3Wa9ws3A34UCrZ5J397trsrtwnYvFyrJw43try5Xr9093Wx
	tF4j9F13tr1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzmhrUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbirxhGrWgas84VaQAAsv

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



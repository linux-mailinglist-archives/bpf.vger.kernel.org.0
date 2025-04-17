Return-Path: <bpf+bounces-56112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE70FA9165E
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 10:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6F017EE2E
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 08:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4730622DFBC;
	Thu, 17 Apr 2025 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="SUs8xg1q"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5B91E32C6;
	Thu, 17 Apr 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878242; cv=none; b=c9csnkG8MOAow+nvwczqsY/Kh9Lnf/cKbAk98vCWXvvC4smJzQSze5YGZoawuSH6ztiw0pNRNPJsc9k6/jsHnzdzBaWXpPfpkm0xKRlcTwdLn2pijuOiEmi0ZZ69AN7tZA9WJCw0Y3K+v9iiBD6Cpe9E3C2rog/SOA078ixk4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878242; c=relaxed/simple;
	bh=Y6Z4afIZtGTgRIsjZPTRPzfVIH3uURQDQpZm5viEsCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NloojBohwjkM+ZqZCnwRoQtTdLJNo7SpkckBE/InU9W7SQ3bBuYcjIdwDLq3Gu6XRKs2FCYLBYGQ/Xl3cOh1OEFXjr0ysYbL0ceeuQHgq7ACbLVKMoQuI/yXHinO1Dd3L90HBz36+UItqAs+QjojFwC3nPbUuzdX7OvEKEl3TvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=SUs8xg1q; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9Zbu0
	Bn8ucZxU/MoGWQXy6dhCsJ9+kls++yzpY7XwdA=; b=SUs8xg1qSBitQTO1b/43C
	zYm/dMLDzAfbE50tcs32Nhl1jS5gxcdL6T6/xTO193NOPcYyWZXoe1d57JwRH9jd
	+YshmTteLtq4nq35LHMdQfFSEM2cL3JTxEC2t8SsUw+9o0vCrkqhOvPKiWis4yOU
	5YS/7clPJ09Fb3xTmIzbNA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3BxOttgBoy+aUBA--.4732S4;
	Thu, 17 Apr 2025 16:07:14 +0800 (CST)
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
Subject: [PATCH 2/2] sched_ext: add helper for refill task with default slice
Date: Thu, 17 Apr 2025 16:07:08 +0800
Message-Id: <20250417080708.1333-3-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250417080708.1333-1-jameshongleiwang@126.com>
References: <20250417080708.1333-1-jameshongleiwang@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3BxOttgBoy+aUBA--.4732S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1xZFyDWFy5Aw1rCrWxWFg_yoW5Jr18p3
	Zaya45XF48Ja12vayIqrWkC3Wa9ws3A34UCrZ5t397trsrtwnYvFyrJw43try5Xr909a1x
	tF4jgF13Jr4DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UwVysUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbirwUyrWgArS3H+wAEsl

Add helper for refilling task with default slice and event
statistics accordingly.

Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
---
 kernel/sched/ext.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 594087ac4c9e..df7319bd9079 100644
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



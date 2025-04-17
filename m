Return-Path: <bpf+bounces-56111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1FA91628
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 10:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A5419082DA
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 08:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D8322FF22;
	Thu, 17 Apr 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="dRjKZ2jz"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AB22FDEF;
	Thu, 17 Apr 2025 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877319; cv=none; b=R9cPz+yHCYgbYhka+cNi+JfXsF4qD4X8xThCTR3KkzLY+ZlaH3tUiTbrOZvJXV7E6a3ddDWzVeOMt1yseb8LWc8YN9yhlnxdYRumsXEfxUmYzdXE/a3PUOBgrW5QI0+/MMO6iCXxZZiv+lkZ7s9j6QMA4DqKnxkWiR30pGjNxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877319; c=relaxed/simple;
	bh=oAkNIcTrbsDjg2rCO20P27VhVYo/dVZFJ2QIK1NQ5hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3atIN9ZuHwcLZt6F/ZcvO3zUB7K9TOwlBVg2N0Br4ndhITVCHlSvNR0c5GoFVgI83g1EKVO0jkMIQz5OCR6u5HE9aVCR0cDnlx+X9q39uje4jUbVOy3Xr5wAhgISjnNAwG2JDKAwJT/lQaGUT3APqrNS04wot24PubQk6yox0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=dRjKZ2jz; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5zMWL
	w2oBotcMAyoCNuk8WRvwhj38gyFAUUeStJrHxg=; b=dRjKZ2jz7rRhF23qlb7mp
	fFw0MqW0BKwbwsV0nVwkZSfr7wE+aUfahDTsn2aat5E7hGHbnbLTyBdtAtWwasIw
	7SzgP1X+zOB6j/Z5s5QX8blhuVu+kItffFulRumLQBgYlKc4pPnxL/BPqgx1h+8J
	Zg6NUFcfepBb2ZWax9plAA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3BxOttgBoy+aUBA--.4732S3;
	Thu, 17 Apr 2025 16:07:12 +0800 (CST)
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
Subject: [PATCH 1/2] sched_ext: change the variable name for slice refill event
Date: Thu, 17 Apr 2025 16:07:07 +0800
Message-Id: <20250417080708.1333-2-jameshongleiwang@126.com>
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
X-CM-TRANSID:_____wD3BxOttgBoy+aUBA--.4732S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr4DXrW8Aw4Dtw4fAF1rtFb_yoW7CF48p3
	W5G345tr48t3y2vrWFqF4ku3WaqrWFqw1qkF95W393ZF1jgwn0yFyYyrWaqFyYgrs5CF1S
	kw4UKF43ArZY9rDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRRRRiUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbirwUyrWgArS3H+wACsj

SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
when the tasks were enqueued, which seems not accurate. What it actually
means is the refilling with defalt slice, and this can occur either when
enqueue or pick_task. Let's change the variable to
SCX_EV_REFILL_SLICE_DFL.

Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
---
 kernel/sched/ext.c             | 22 +++++++++++-----------
 tools/sched_ext/scx_qmap.bpf.c |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 66bcd40a28ca..594087ac4c9e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1517,10 +1517,10 @@ struct scx_event_stats {
 	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
 
 	/*
-	 * The total number of tasks enqueued (or pick_task-ed) with a
-	 * default time slice (SCX_SLICE_DFL).
+	 * The total number of tasks slice refill with default time slice
+	 * (SCX_SLICE_DFL).
 	 */
-	s64		SCX_EV_ENQ_SLICE_DFL;
+	s64		SCX_EV_REFILL_SLICE_DFL;
 
 	/*
 	 * The total duration of bypass modes in nanoseconds.
@@ -2197,7 +2197,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	p->scx.slice = SCX_SLICE_DFL;
-	__scx_add_event(SCX_EV_ENQ_SLICE_DFL, 1);
+	__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
 local_norefill:
 	dispatch_enqueue(&rq->scx.local_dsq, p, enq_flags);
 	return;
@@ -2205,7 +2205,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 global:
 	touch_core_sched(rq, p);	/* see the comment in local: */
 	p->scx.slice = SCX_SLICE_DFL;
-	__scx_add_event(SCX_EV_ENQ_SLICE_DFL, 1);
+	__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
 	dispatch_enqueue(find_global_dsq(p), p, enq_flags);
 }
 
@@ -3296,7 +3296,7 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 		p = prev;
 		if (!p->scx.slice) {
 			p->scx.slice = SCX_SLICE_DFL;
-			__scx_add_event(SCX_EV_ENQ_SLICE_DFL, 1);
+			__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
 		}
 	} else {
 		p = first_local_task(rq);
@@ -3313,7 +3313,7 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 				scx_warned_zero_slice = true;
 			}
 			p->scx.slice = SCX_SLICE_DFL;
-			__scx_add_event(SCX_EV_ENQ_SLICE_DFL, 1);
+			__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
 		}
 	}
 
@@ -3399,7 +3399,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		if (cpu >= 0) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
-			__scx_add_event(SCX_EV_ENQ_SLICE_DFL, 1);
+			__scx_add_event(SCX_EV_REFILL_SLICE_DFL, 1);
 		} else {
 			cpu = prev_cpu;
 		}
@@ -4413,7 +4413,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_DISPATCH_KEEP_LAST);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_EXITING);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SLICE_DFL);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_REFILL_SLICE_DFL);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DURATION);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
@@ -5148,7 +5148,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	scx_dump_event(s, &events, SCX_EV_DISPATCH_KEEP_LAST);
 	scx_dump_event(s, &events, SCX_EV_ENQ_SKIP_EXITING);
 	scx_dump_event(s, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
-	scx_dump_event(s, &events, SCX_EV_ENQ_SLICE_DFL);
+	scx_dump_event(s, &events, SCX_EV_REFILL_SLICE_DFL);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DURATION);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
@@ -7313,7 +7313,7 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
 		scx_agg_event(&e_sys, e_cpu, SCX_EV_DISPATCH_KEEP_LAST);
 		scx_agg_event(&e_sys, e_cpu, SCX_EV_ENQ_SKIP_EXITING);
 		scx_agg_event(&e_sys, e_cpu, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
-		scx_agg_event(&e_sys, e_cpu, SCX_EV_ENQ_SLICE_DFL);
+		scx_agg_event(&e_sys, e_cpu, SCX_EV_REFILL_SLICE_DFL);
 		scx_agg_event(&e_sys, e_cpu, SCX_EV_BYPASS_DURATION);
 		scx_agg_event(&e_sys, e_cpu, SCX_EV_BYPASS_DISPATCH);
 		scx_agg_event(&e_sys, e_cpu, SCX_EV_BYPASS_ACTIVATE);
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 26c40ca4f36c..c3cd9a17d48e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -784,8 +784,8 @@ static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 		   scx_read_event(&events, SCX_EV_DISPATCH_KEEP_LAST));
 	bpf_printk("%35s: %lld", "SCX_EV_ENQ_SKIP_EXITING",
 		   scx_read_event(&events, SCX_EV_ENQ_SKIP_EXITING));
-	bpf_printk("%35s: %lld", "SCX_EV_ENQ_SLICE_DFL",
-		   scx_read_event(&events, SCX_EV_ENQ_SLICE_DFL));
+	bpf_printk("%35s: %lld", "SCX_EV_REFILL_SLICE_DFL",
+		   scx_read_event(&events, SCX_EV_REFILL_SLICE_DFL));
 	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DURATION",
 		   scx_read_event(&events, SCX_EV_BYPASS_DURATION));
 	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DISPATCH",
-- 
2.45.2



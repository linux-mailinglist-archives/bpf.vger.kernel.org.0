Return-Path: <bpf+bounces-57601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F34AAD295
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749167B5B04
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD181482F2;
	Wed,  7 May 2025 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BwjSrewc"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5878F5D;
	Wed,  7 May 2025 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580678; cv=none; b=ZVDVj+WqetCDyzrUN+PcjHmDXwHbFAZqnl8TK6P0lmbRCMmccuOiqWCX8g3/sE+5DTWN9KCE1p+eLR5i1qtU6jaOtb3FG4J9Z8okUgfIKgdgneEiSUOlaBxCbNsv7izx+88iZ9wy6nBNdwn5m1Ls/MJ/3Os676feuUSaaxQBSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580678; c=relaxed/simple;
	bh=sRTYYXi+q6YFmn2CM84PAr5Xq+GZZ+uf1kwrPa8hsxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qr5QcBLFxR5QF4GKLu1MdXBBSFdDPpqzDi6tIkm2WgLSnrqOQZqbqEw6bdtZjQgTSgVroXiPLZquXpQ1FbsedHIj0XBxXWOtcPVHdI6cCDa7jfcwxOIlTAUDzU0ge8vu/enZSmQDyR921cA97qs8i5yqOWurJXFiizVSppuNPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BwjSrewc; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dfDAl
	NI7Mtaa7Np1mFi7q1dvflRvIlHpBBi3IZLBURw=; b=BwjSrewc35f/WCXjZKAg/
	iHn2LToVJW6fdPOUw1ijtdxCl4pS3E+1oMZDM0JyY9M6QqG4PU82CioSyI82+2Lo
	Xad0avGIBAoq6vlT2JNJD3RKEn36uWaJECQhoPab+9HZiWiC5sHr9276AreI/3mu
	Cgw2lxPkN1vIXQjJl6yyvc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3P8x2tBpocz5dBw--.62210S3;
	Wed, 07 May 2025 09:16:41 +0800 (CST)
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
Subject: [RESEND PATCH v2 1/2] sched_ext: change the variable name for slice refill event
Date: Wed,  7 May 2025 09:16:36 +0800
Message-Id: <20250507011637.77589-2-jameshongleiwang@126.com>
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
X-CM-TRANSID:_____wD3P8x2tBpocz5dBw--.62210S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr4DXrW8Aw4Dtw4fAF1rtFb_yoW7Zr45p3
	W5G345tr48t3y2vrWFqF4ku3WaqrWFqw1qkF95W393ZF1jgwnYyFyYyr4aqFyYgrsYkF1S
	kw4UKF43ArZY9rDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UjYLkUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiYBVGrWgatD0D8gAEsQ

SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
when the tasks were enqueued, which seems not accurate. What it actually
means is the refilling with defalt slice, and this can occur either when
enqueue or pick_task. Let's change the variable to
SCX_EV_REFILL_SLICE_DFL.

Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
---
v2:
- refine the comments base on Andrea's suggestion.
---
 kernel/sched/ext.c             | 22 +++++++++++-----------
 tools/sched_ext/scx_qmap.bpf.c |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 66bcd40a28ca..2a091ea23328 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1517,10 +1517,10 @@ struct scx_event_stats {
 	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
 
 	/*
-	 * The total number of tasks enqueued (or pick_task-ed) with a
-	 * default time slice (SCX_SLICE_DFL).
+	 * Total number of times a task's time slice was refilled with the
+	 * default value (SCX_SLICE_DFL).
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



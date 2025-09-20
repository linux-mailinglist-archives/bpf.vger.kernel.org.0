Return-Path: <bpf+bounces-69062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D3CB8BC7E
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CDD6B62656
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D72D94AF;
	Sat, 20 Sep 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpP+bp5N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C32D8790;
	Sat, 20 Sep 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330005; cv=none; b=PK8Bt1CKykx4La9MiQMQa/Ma3f3gpgPVkkzPqcNVqbarv+zJrKkj8i0AVuthuAx972N/v2SbRT52VfI69clvIzAs84YWyF5LyOTQEJVA/Y/ufmC9Ri/PS+pcbpAv/qyJ7ioa++bWzwoHRGWhEPE0qBgMgLx8nAY0H8zsJ8Qt3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330005; c=relaxed/simple;
	bh=89c9zAH/+dHZlxw6LPDCO/c2nhxHQ/d377ubuJKjUBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCMIG3vWHVNwpxNDyzPTNlZwMtFMBZCU3lPLDe2CZ6T5S2SLvHvPOp6KV3iasop9E54AqS8jjNI396tc66BRfEnKh7cN0BZDeyxEkem9cEt63Kq4GKvmdx1fHSXs9C3J0TFvxCqBTfEpMkQLWlTrzjrkRwUH0eIYZG8sKjU1msk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpP+bp5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF55C4CEF0;
	Sat, 20 Sep 2025 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330003;
	bh=89c9zAH/+dHZlxw6LPDCO/c2nhxHQ/d377ubuJKjUBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpP+bp5N8RXGMVWPa+mKZEKOJAA7vit4PFUZ6jHyYEnr+DQzwmy8+gaSJgC1H/Gfh
	 a1GOl4Zu0zmszNDo/q3PwrhEu9/OXaxL1+3HN76m0YYGMuqpwb7J8khePDzmrAiXO3
	 9R0tjilruKrko9WMUb03ZDiGPI4TqC8TUZrlfJwe5VcVE2b7f2RMT5zcSkFuKt15Wz
	 3mI/gGBfeR6z2a5y3f5qkmVVckxFmV3AI7gjEWvzE+M46/BiKDs6WMsS/fznsdJf2L
	 2CxXKQvRnGAOfAxx1XWnZmg7ujclZJi/9RKG+Z4BbQFklLM6tlO7IBnfdz7gjHxz5d
	 o95UkP52iOXxQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 27/46] sched_ext: Ignore insertions of not-owned tasks into DSQs
Date: Fri, 19 Sep 2025 14:58:50 -1000
Message-ID: <20250920005931.2753828-28-tj@kernel.org>
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

As BPF schedulers are allowed to ignore dequeues, after a sub-sched
enabling moved tasks out of the parent scheduler, the parent scheduler may
try to dispatch an already moved task. As this doesn't necessarily
indicate a malfunction, ignore and count such attempts.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          |  9 +++++++++
 kernel/sched/ext_internal.h | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b5f5106ddbf8..891b956a92b6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2125,6 +2125,12 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 		if ((opss & SCX_OPSS_QSEQ_MASK) != qseq_at_dispatch)
 			return;
 
+		/* see SCX_EV_INSERT_NOT_OWNED definition */
+		if (unlikely(sch != rcu_access_pointer(p->scx.sched))) {
+			__scx_add_event(sch, SCX_EV_INSERT_NOT_OWNED, 1);
+			return;
+		}
+
 		/*
 		 * While we know @p is accessible, we don't yet have a claim on
 		 * it - the BPF scheduler is allowed to dispatch tasks
@@ -3739,6 +3745,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DURATION);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
 	return at;
 }
 SCX_ATTR(events);
@@ -4631,6 +4638,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DURATION);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
+	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
 
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
@@ -7247,6 +7255,7 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DURATION);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DISPATCH);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_ACTIVATE);
+		scx_agg_event(events, e_cpu, SCX_EV_INSERT_NOT_OWNED);
 	}
 }
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 64d0f0787c8e..154993921c38 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -895,6 +895,18 @@ struct scx_event_stats {
 	 * The number of times the bypassing mode has been activated.
 	 */
 	s64		SCX_EV_BYPASS_ACTIVATE;
+
+	/*
+	 * The number of times the scheduler attempted to insert a task that it
+	 * doesn't own into a DSQ. Such attempts are ignored.
+	 *
+	 * As BPF schedulers are allowed to ignore dequeues, it's difficult to
+	 * tell whether such an attempt is from a scheduler malfunction or an
+	 * ignored dequeue around sub-sched enabling. If this count keeps going
+	 * up regardless of sub-sched enabling, it likely indicates a bug in the
+	 * scheduler.
+	 */
+	s64		SCX_EV_INSERT_NOT_OWNED;
 };
 
 struct scx_sched_pcpu {
-- 
2.51.0



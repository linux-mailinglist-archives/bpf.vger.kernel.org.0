Return-Path: <bpf+bounces-79036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B2D24717
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 13:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDD2A30549BC
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34082395252;
	Thu, 15 Jan 2026 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJ4uEcSQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605838A9AB;
	Thu, 15 Jan 2026 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479792; cv=none; b=RhCMkof2++KouQ2nNUGGa2xvNgSuX22b7C4t9WmArpkkdh9xT0/V/fkjc7t1SouD+bUb2z6STokKwmmjI6C/UHFaGSPHV4F5GajBEa0pXFAoMo9wxRr9kSl0nL/I4KGsFdK6VO9OGzNeTrrXDNE5GLRSxOGmlvMl7zgFH7KGshY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479792; c=relaxed/simple;
	bh=ZMEYK47BrOyJGKV5630tH7EVWhmlchg1ygi5vcWhQfo=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=IA48K5+OaXAM2WuBTi/7zHQjWBwByKipBdY8isBoVyfBpuzPAvN2pB1lUtSp5GK665ELD6SfKMx1jjOftmQAAJRxAysOM3Sj7pyTg4tCr9DZuQL4lG73tOiajQfEZEV22hmwYqUeOf7XnhvUaH7KCX2XD1lFZ+zywThQS7wfk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJ4uEcSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A93C116D0;
	Thu, 15 Jan 2026 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768479792;
	bh=ZMEYK47BrOyJGKV5630tH7EVWhmlchg1ygi5vcWhQfo=;
	h=Subject:From:To:Cc:Date:From;
	b=dJ4uEcSQwshSKla8C7v9CFLU/Y3Ve5YWg59pfX/APy7foMLST1tHc6Eb01szMpxjK
	 jWfDde/7Fsh4ceYiVazDO78bFUgGsyILBnXPy+GLp4Ft4EbmZRIzglfiIHyopyr9TN
	 g4bWgSuC71rMI9bDta+gPWPD/h4N2FMYROilt0m4FzwtGgA2MwEC3QB5ej9KGXeM7y
	 W92o3NKoFysDwZm7UA2FYqIxo3HS3NEbRicic87V5W/K0Ns3FgdCnFTesWK7rnaixL
	 kx1Mkhh0u4tdXue+f+lTYi74FVmlGvHd4c+lJ9YjW9ivID8F/ZARRRbec6RgvPN98N
	 S7nWGhVaEEKuw==
Subject: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons for
 monitoring
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 carges@cloudflare.com, kernel-team@cloudflare.com
Date: Thu, 15 Jan 2026 13:23:07 +0100
Message-ID: <176847978787.939583.16722243649193888625.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add specific drop reasons to SFQ qdisc to improve packet drop observability
and monitoring capabilities. This change replaces generic qdisc_drop()
calls with qdisc_drop_reason() to provide granular metrics about different
drop scenarios in production environments.

Two new drop reasons are introduced:

- SKB_DROP_REASON_QDISC_MAXFLOWS: Used when a new flow cannot be created
  because the maximum number of flows (flows parameter) has been
  reached and no free flow slots are available.

- SKB_DROP_REASON_QDISC_MAXDEPTH: Used when a flow's queue length exceeds
  the per-flow depth limit (depth parameter), triggering either tail drop
  or head drop depending on headdrop configuration.

The existing SKB_DROP_REASON_QDISC_OVERLIMIT is used in sfq_drop() when
the overall qdisc limit is exceeded and packets are dropped from the
longest queue.

These detailed drop reasons enable production monitoring systems to
distinguish between different SFQ drop scenarios and generate specific
metrics for:
- Flow table exhaustion (flows exceeded)
- Per-flow congestion (depth limit exceeded)
- Global qdisc congestion (overall limit exceeded)

This granular visibility allows operators to identify issues related
to traffic patterns, and optimize SFQ configuration based on
real-world drop patterns.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/net/dropreason-core.h |   12 ++++++++++++
 net/sched/sch_sfq.c           |    8 ++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 58d91ccc56e0..e395d0ff9904 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -69,6 +69,8 @@
 	FN(QDISC_DROP)			\
 	FN(QDISC_OVERLIMIT)		\
 	FN(QDISC_CONGESTED)		\
+	FN(QDISC_MAXFLOWS)		\
+	FN(QDISC_MAXDEPTH)		\
 	FN(CAKE_FLOOD)			\
 	FN(FQ_BAND_LIMIT)		\
 	FN(FQ_HORIZON_LIMIT)		\
@@ -384,6 +386,16 @@ enum skb_drop_reason {
 	 * due to congestion.
 	 */
 	SKB_DROP_REASON_QDISC_CONGESTED,
+	/**
+	 * @SKB_DROP_REASON_QDISC_MAXFLOWS: dropped by qdisc when the maximum
+	 * number of flows is exceeded.
+	 */
+	SKB_DROP_REASON_QDISC_MAXFLOWS,
+	/**
+	 * @SKB_DROP_REASON_QDISC_MAXDEPTH: dropped by qdisc when a flow
+	 * exceeds its maximum queue depth limit.
+	 */
+	SKB_DROP_REASON_QDISC_MAXDEPTH,
 	/**
 	 * @SKB_DROP_REASON_CAKE_FLOOD: dropped by the flood protection part of
 	 * CAKE qdisc AQM algorithm (BLUE).
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 96eb2f122973..e91d74127600 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -302,7 +302,7 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
 		sfq_dec(q, x);
 		sch->q.qlen--;
 		qdisc_qstats_backlog_dec(sch, skb);
-		qdisc_drop(skb, sch, to_free);
+		qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
 		return len;
 	}
 
@@ -363,7 +363,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	if (x == SFQ_EMPTY_SLOT) {
 		x = q->dep[0].next; /* get a free slot */
 		if (x >= SFQ_MAX_FLOWS)
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_MAXFLOWS);
 		q->ht[hash] = x;
 		slot = &q->slots[x];
 		slot->hash = hash;
@@ -420,14 +420,14 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	if (slot->qlen >= q->maxdepth) {
 congestion_drop:
 		if (!sfq_headdrop(q))
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_MAXDEPTH);
 
 		/* We know we have at least one packet in queue */
 		head = slot_dequeue_head(slot);
 		delta = qdisc_pkt_len(head) - qdisc_pkt_len(skb);
 		sch->qstats.backlog -= delta;
 		slot->backlog -= delta;
-		qdisc_drop(head, sch, to_free);
+		qdisc_drop_reason(head, sch, to_free, SKB_DROP_REASON_QDISC_MAXDEPTH);
 
 		slot_queue_add(slot, skb);
 		qdisc_tree_reduce_backlog(sch, 0, delta);




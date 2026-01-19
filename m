Return-Path: <bpf+bounces-79507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2921D3B79D
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 20:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 885693040A6C
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D4C296BD6;
	Mon, 19 Jan 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pin5nyTa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD588261593;
	Mon, 19 Jan 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852135; cv=none; b=FjrcQ4kDlL6sGlBVcOrhQS/UQfaoVxZIoU0YOL2UYAYWzB60YJXMaS8Xzf3VGk8vMVQKiu0oUWUffzXrOmAa9U+XQcHh7PxQVFzOFePyf+OglFM06YyBEz/YOjWc7pt13l4dljCRyGmO4M9ifPe33lF6OeKK7je3W6MEircYlk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852135; c=relaxed/simple;
	bh=8/kws0cEGE1DELOMhSSI4eVNBlaQCXKn9aTMoTDbJ54=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=hmEgEL+506xfZgxmCvKyXkReU6eUn8zay4TLRu1s7AtfQkvYOMbG0MtU0N1bpA7hysH97EcuTbQaNFOxNLAIDpJuSFeuo68cxj7fuXqtMhXtoo5Rf/nx0eK7OizdmTIsvrMJjRhVLgZf0j8+yPjAxpVWv8XZEneXHrNKYj5H8cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pin5nyTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEE5C116C6;
	Mon, 19 Jan 2026 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768852135;
	bh=8/kws0cEGE1DELOMhSSI4eVNBlaQCXKn9aTMoTDbJ54=;
	h=Subject:From:To:Cc:Date:From;
	b=pin5nyTaG7E5tp4FFLLPxOjMNvYj8chaniQ+YjGfPPB2r04viP8G1FAhRrX2O2v88
	 FlzOoXM+bAvshjSsnL5nedh7CpVVrNJFXF6Jo1RVaNCYbZytKYckv5MfQ+Kl26jXtV
	 +npx79N4iKhuwPNlIKE6lIqqNvpbdJ+WgeGopWKr7abXVkc2k5Uhc5Xk65udx1LHA7
	 mlkJllOcq5rR0Nyy4CN5VFAqw6qDOjDl1K9CJD8z7DuAqzcb85zx7jmZbFIEojm1Oh
	 U/4vCCzvomfXqcW18QyHTBZjtUho+Mb3WXxl+CJNz7m2qHwovEkchJ3RrtAQGGy9u9
	 y6wYg/zgzAbFQ==
Subject: [PATCH net-next v2] net: sched: sfq: add detailed drop reasons for
 monitoring
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 horms@kernel.org, jiri@resnulli.us, edumazet@google.com,
 xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
Date: Mon, 19 Jan 2026 20:48:50 +0100
Message-ID: <176885213069.1172320.14270453855073120526.stgit@firesoul>
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

- SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS: Used when a new flow cannot be created
  because the maximum number of flows (flows parameter) has been
  reached and no free flow slots are available.

- SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH: Used when a flow's queue length exceeds
  the per-flow depth limit (depth parameter), triggering either tail drop
  or head drop depending on headdrop configuration.

The existing SKB_DROP_REASON_QDISC_OVERLIMIT is used in sfq_drop() when
the overall qdisc limit is exceeded and packets are dropped from the
longest queue.

The naming uses a hierarchical QDISC_SFQ_* scheme to provide benefits for
userspace consumers. The QDISC_ prefix enables pattern matching for
qdisc-related drops, allowing monitoring tools to apply consistent sampling
rates or filtering across qdisc subsystems. The SFQ component makes the drop
reason self-documenting, eliminating the need for userspace to decode the
net_device to identify which qdisc generated the drop. This follows the
approach where drop reason enum names become effective UAPI, as they are
resolved via BTF and consumed by production monitoring systems.

These detailed drop reasons enable production monitoring systems to
distinguish between different SFQ drop scenarios and generate specific
metrics for:
- Flow table exhaustion (flows exceeded)
- Per-flow congestion (depth limit exceeded)
- Global qdisc congestion (overall limit exceeded)

This granular visibility allows operators to identify capacity planning
needs, detect traffic patterns, and optimize SFQ configuration based on
real-world drop patterns.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/net/dropreason-core.h |   12 ++++++++++++
 net/sched/sch_sfq.c           |   11 +++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a7b7abd66e21..92c99169bb97 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -70,6 +70,8 @@
 	FN(QDISC_BURST_DROP)		\
 	FN(QDISC_OVERLIMIT)		\
 	FN(QDISC_CONGESTED)		\
+	FN(QDISC_SFQ_MAXFLOWS)		\
+	FN(QDISC_SFQ_MAXDEPTH)		\
 	FN(CAKE_FLOOD)			\
 	FN(FQ_BAND_LIMIT)		\
 	FN(FQ_HORIZON_LIMIT)		\
@@ -390,6 +392,16 @@ enum skb_drop_reason {
 	 * due to congestion.
 	 */
 	SKB_DROP_REASON_QDISC_CONGESTED,
+	/**
+	 * @SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS: dropped by SFQ qdisc when the
+	 * maximum number of flows is exceeded.
+	 */
+	SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS,
+	/**
+	 * @SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH: dropped by SFQ qdisc when a flow
+	 * exceeds its maximum queue depth limit.
+	 */
+	SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH,
 	/**
 	 * @SKB_DROP_REASON_CAKE_FLOOD: dropped by the flood protection part of
 	 * CAKE qdisc AQM algorithm (BLUE).
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 96eb2f122973..3a6de2fe3344 100644
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
 
@@ -338,6 +338,8 @@ static int sfq_headdrop(const struct sfq_sched_data *q)
 	return q->headdrop;
 }
 
+#define SFQ_DR(reason) SKB_DROP_REASON_QDISC_SFQ_##reason
+
 static int
 sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 {
@@ -363,7 +365,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	if (x == SFQ_EMPTY_SLOT) {
 		x = q->dep[0].next; /* get a free slot */
 		if (x >= SFQ_MAX_FLOWS)
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free, SFQ_DR(MAXFLOWS));
 		q->ht[hash] = x;
 		slot = &q->slots[x];
 		slot->hash = hash;
@@ -420,14 +422,14 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	if (slot->qlen >= q->maxdepth) {
 congestion_drop:
 		if (!sfq_headdrop(q))
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free, SFQ_DR(MAXDEPTH));
 
 		/* We know we have at least one packet in queue */
 		head = slot_dequeue_head(slot);
 		delta = qdisc_pkt_len(head) - qdisc_pkt_len(skb);
 		sch->qstats.backlog -= delta;
 		slot->backlog -= delta;
-		qdisc_drop(head, sch, to_free);
+		qdisc_drop_reason(head, sch, to_free, SFQ_DR(MAXDEPTH));
 
 		slot_queue_add(slot, skb);
 		qdisc_tree_reduce_backlog(sch, 0, delta);
@@ -471,6 +473,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	qdisc_tree_reduce_backlog(sch, 1, dropped);
 	return NET_XMIT_SUCCESS;
 }
+#undef SFQ_DR
 
 static struct sk_buff *
 sfq_dequeue(struct Qdisc *sch)




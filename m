Return-Path: <bpf+bounces-71937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F6C01F5C
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEBE1A62AAF
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C0338915;
	Thu, 23 Oct 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6d8xsXj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447A330D34;
	Thu, 23 Oct 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231590; cv=none; b=rkgu5CYZQ9W8ehnEG3weY0nW//1O3AJJR6S+EjGPKU0Wpizv8aa4Fz9OejecVpm4uMsInQRh0vGp+4XKtsIGUhHoqlSy99OkGR0oqU95EzHnMp0dLpaSgQDGwqRJvhhjBA6kxFf0npKk6rcRh9HhVYCSPzFZ5S7vlFw+SBs3A0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231590; c=relaxed/simple;
	bh=cXZ5FzyudK+Ly7PkDe/gmfBGxOLTQi1YvUaQvOnWpu0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBUkekU+zF9h8oxwdkDrfYOHvVE+RuvNNlolIUgxAsp0w85fXLLYtlyygW7NY0gNJVQoURleW8fBwzDZjIP5VknkVnjXtWDDdiwKuWZBXt4UfFN/gAvDC5Tcq8aQN6CLWYqtIZAtobahwvGCA/476XyttKPE2OhmxdEUBossrVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6d8xsXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C770C4CEE7;
	Thu, 23 Oct 2025 14:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761231589;
	bh=cXZ5FzyudK+Ly7PkDe/gmfBGxOLTQi1YvUaQvOnWpu0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U6d8xsXjRjSS47t571oe1/ZnaeeWoHx9XGxaWBr5xPWhVIfSSSUVZaVYXRkNoK9Ir
	 My5WbSTlGMIhq1LD7gpHXJYg1S6nXBp6PS+wQNpFYiDU6v8BYCJOsejGPhr44Incv5
	 v1fMEpr0bfG4VTO0LHi2paGDXC3yuUsmkTcQFryQi31ULsIke+au5NdMIQqbnn/G70
	 zayvrLbRRssm3HTtPg6r23rECEal5WIGaKpgxhDt30PZUlyRvY4kTe0q9osXrymj49
	 Uyg49UmH3z60XeAnWc0lx83rJiJ4XZvGXz0SKTLURYntuBDs/5rApIecL373J3KPli
	 cqy+ncC6WD55Q==
Subject: [PATCH net V1 3/3] veth: more robust handing of race to avoid txq
 getting stuck
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, makita.toshiaki@lab.ntt.co.jp
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Date: Thu, 23 Oct 2025 16:59:44 +0200
Message-ID: <176123158453.2281302.11061466460805684097.stgit@firesoul>
In-Reply-To: <176123150256.2281302.7000617032469740443.stgit@firesoul>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
reduce TX drops") introduced a race condition that can lead to a permanently
stalled TXQ. This was observed in production on ARM64 systems (Ampere Altra
Max).

The race occurs in veth_xmit(). The producer observes a full ptr_ring and
stops the queue (netif_tx_stop_queue()). The subsequent conditional logic,
intended to re-wake the queue if the consumer had just emptied it (if
(__ptr_ring_empty(...)) netif_tx_wake_queue()), can fail. This leads to a
"lost wakeup" where the TXQ remains stopped (QUEUE_STATE_DRV_XOFF) and
traffic halts.

This failure is caused by an incorrect use of the __ptr_ring_empty() API
from the producer side. As noted in kernel comments, this check is not
guaranteed to be correct if a consumer is operating on another CPU. The
empty test is based on ptr_ring->consumer_head, making it reliable only for
the consumer. Using this check from the producer side is fundamentally racy.

This patch fixes the race by adopting the more robust logic from an earlier
version V4 of the patchset, which always flushed the peer:

(1) In veth_xmit(), the racy conditional wake-up logic and its memory barrier
are removed. Instead, after stopping the queue, we unconditionally call
__veth_xdp_flush(rq). This guarantees that the NAPI consumer is scheduled,
making it solely responsible for re-waking the TXQ.

(2) On the consumer side, the logic for waking the peer TXQ is centralized.
It is moved out of veth_xdp_rcv() (which processes a batch) and placed at
the end of the veth_poll() function. This ensures netif_tx_wake_queue() is
called once per complete NAPI poll cycle.

(3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
about to complete (napi_complete_done), it now also checks if the peer TXQ
is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
reschedule itself. This prevents a new race where the producer stops the
queue just as the consumer is finishing its poll, ensuring the wakeup is not
missed.

Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 3976ddda5fb8..1d70377481eb 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -392,14 +392,12 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
 		__skb_push(skb, ETH_HLEN);
-		/* Depend on prior success packets started NAPI consumer via
-		 * __veth_xdp_flush(). Cancel TXQ stop if consumer stopped,
-		 * paired with empty check in veth_poll().
-		 */
 		netif_tx_stop_queue(txq);
-		smp_mb__after_atomic();
-		if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
-			netif_tx_wake_queue(txq);
+		/* Handle race: Makes sure NAPI peer consumer runs. Consumer is
+		 * responsible for starting txq again, until then ndo_start_xmit
+		 * (this function) will not be invoked by the netstack again.
+		 */
+		__veth_xdp_flush(rq);
 		break;
 	case NET_RX_DROP: /* same as NET_XMIT_DROP */
 drop:
@@ -900,17 +898,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct veth_xdp_tx_bq *bq,
 			struct veth_stats *stats)
 {
-	struct veth_priv *priv = netdev_priv(rq->dev);
-	int queue_idx = rq->xdp_rxq.queue_index;
-	struct netdev_queue *peer_txq;
-	struct net_device *peer_dev;
 	int i, done = 0, n_xdpf = 0;
 	void *xdpf[VETH_XDP_BATCH];
 
-	/* NAPI functions as RCU section */
-	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
-	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
-
 	for (i = 0; i < budget; i++) {
 		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
 
@@ -959,11 +949,6 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 	rq->stats.vs.xdp_packets += done;
 	u64_stats_update_end(&rq->stats.syncp);
 
-	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq))) {
-		txq_trans_cond_update(peer_txq);
-		netif_tx_wake_queue(peer_txq);
-	}
-
 	return done;
 }
 
@@ -971,12 +956,20 @@ static int veth_poll(struct napi_struct *napi, int budget)
 {
 	struct veth_rq *rq =
 		container_of(napi, struct veth_rq, xdp_napi);
+	struct veth_priv *priv = netdev_priv(rq->dev);
+	int queue_idx = rq->xdp_rxq.queue_index;
+	struct netdev_queue *peer_txq;
 	struct veth_stats stats = {};
+	struct net_device *peer_dev;
 	struct veth_xdp_tx_bq bq;
 	int done;
 
 	bq.count = 0;
 
+	/* NAPI functions as RCU section */
+	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
+	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
+
 	xdp_set_return_frame_no_direct();
 	done = veth_xdp_rcv(rq, budget, &bq, &stats);
 
@@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
 	if (done < budget && napi_complete_done(napi, done)) {
 		/* Write rx_notify_masked before reading ptr_ring */
 		smp_store_mb(rq->rx_notify_masked, false);
-		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
+		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
+			     (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
 			if (napi_schedule_prep(&rq->xdp_napi)) {
 				WRITE_ONCE(rq->rx_notify_masked, true);
 				__napi_schedule(&rq->xdp_napi);
@@ -998,6 +992,12 @@ static int veth_poll(struct napi_struct *napi, int budget)
 		veth_xdp_flush(rq, &bq);
 	xdp_clear_return_frame_no_direct();
 
+	/* Release backpressure per NAPI poll */
+	if (peer_txq && netif_tx_queue_stopped(peer_txq)) {
+		txq_trans_cond_update(peer_txq);
+		netif_tx_wake_queue(peer_txq);
+	}
+
 	return done;
 }
 




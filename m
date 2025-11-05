Return-Path: <bpf+bounces-73676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA9C371FF
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 18:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5545B506F3D
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1609822157B;
	Wed,  5 Nov 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKwF4yxa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE42874FF;
	Wed,  5 Nov 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363705; cv=none; b=lhUmHhK8xPVvC/5E6+pmo8hewBZ677mgsoF1c8abUyc8KgpAnYCW5CB3VQvLQcw2AbOJ2nHFnWzhgSFGxqcL7+50bWRiLNZ07kfQRBO4JaYZyC6LSe+lrLrqnyaMoCyrwBM8q3Teafx7vmLcSttNNEfw8HqUH+mW6J2EPYd429Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363705; c=relaxed/simple;
	bh=WWE2CREpUzxVd4OeFKJZqcU5pHWBrpeeWrzbApa8odI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LANLwoqddASX9VBMHDa/Zw3Z/ojOchimQqUU8T7pV7aCZcGgPC9WX9+nrB4LzMQKO4BFUbVSjqAxHVgddIznxXLWRmVGvdc2vNmGgZB5UEW/LLLc/cZX/758dXFYOZYA3n2Mi5lvRCgRUu0B8bdkvd5dW2DZcN35yCK3EfcLqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKwF4yxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8162C4CEF5;
	Wed,  5 Nov 2025 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762363704;
	bh=WWE2CREpUzxVd4OeFKJZqcU5pHWBrpeeWrzbApa8odI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uKwF4yxaIv4QWdphUhmGifSGdXZBIih2SHH2a5iWmRJtly/l7sfYy+RQqrIDljc6X
	 DtzEOjKsEQdYDhLm1xg5mVZ34slmu6iONSYbNl+bNJ7iOpcVbPC8UnZy1vlEH4wp8d
	 DpACOVww4l+67On3PVkaJEkzW+8Bk9RVRrhkugFArDp3qt26GWPlC3lXO5ZNseg5M/
	 jYIE4vcAQZbijTc3UG6+z4M4slB7M8p/RharMBF+ElW+GETuysURTRYH2KIlapGTa3
	 DoX0TikPCRMGCWrVieRifoWZfT46N2gGW2eWH3AC0Z1wMQSlA6ElzpKd+5zdwQoObc
	 aXrjKs4hqGWeQ==
Subject: [PATCH net V3 2/2] veth: more robust handing of race to avoid txq
 getting stuck
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-team@cloudflare.com
Date: Wed, 05 Nov 2025 18:28:19 +0100
Message-ID: <176236369968.30034.1538535221816777531.stgit@firesoul>
In-Reply-To: <176236363962.30034.10275956147958212569.stgit@firesoul>
References: <176236363962.30034.10275956147958212569.stgit@firesoul>
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
  This handles the race where veth_poll() consumes all packets and completes
NAPI *before* veth_xmit() on the producer side has called netif_tx_stop_queue.
The __veth_xdp_flush(rq) will observe rx_notify_masked is false and schedule
NAPI.

(2) On the consumer side, the logic for waking the peer TXQ is moved out of
veth_xdp_rcv() and placed at the end of the veth_poll() function. This
placement is part of fixing the race, as the netif_tx_queue_stopped() check
must occur after rx_notify_masked is potentially set to false during NAPI
completion.
  This handles the race where veth_poll() consumes all packets, but haven't
finished (rx_notify_masked is still true). The producer veth_xmit() stops the
TXQ and __veth_xdp_flush(rq) will observe rx_notify_masked is true, meaning
not starting NAPI.  Then veth_poll() change rx_notify_masked to false and
stops NAPI.  Before exiting veth_poll() will observe TXQ is stopped and wake
it up.

Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 7b1a9805b270..127dab275896 100644
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
+		/* Makes sure NAPI peer consumer runs. Consumer is responsible
+		 * for starting txq again, until then ndo_start_xmit (this
+		 * function) will not be invoked by the netstack again.
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
 
@@ -998,6 +991,13 @@ static int veth_poll(struct napi_struct *napi, int budget)
 		veth_xdp_flush(rq, &bq);
 	xdp_clear_return_frame_no_direct();
 
+	/* Release backpressure per NAPI poll */
+	smp_rmb(); /* Paired with netif_tx_stop_queue set_bit */
+	if (peer_txq && netif_tx_queue_stopped(peer_txq)) {
+		txq_trans_cond_update(peer_txq);
+		netif_tx_wake_queue(peer_txq);
+	}
+
 	return done;
 }
 




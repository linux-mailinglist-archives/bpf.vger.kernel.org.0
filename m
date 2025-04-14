Return-Path: <bpf+bounces-55863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C100A887AB
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 17:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0873D1778A5
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB027B513;
	Mon, 14 Apr 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUpp3fz0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B627B4F5;
	Mon, 14 Apr 2025 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645561; cv=none; b=Z72jhUvqr19WxWcusWsKkDpnUFEgA3BP4zd+/11Uoga3eCCF26dJjVAf2Is+J/mIdY3BhdN+WO4q9LSJkMBVA/gbHR3Sp+ICVTWTbfnRvMRtdPX9eDFJf1a8AGhx7VgAJbhmezGTT9YQkFSW6JIE/ja4tA8mneogLNPOcmj8G0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645561; c=relaxed/simple;
	bh=BYdAOPIOmHl00ROk7DBXfagd2ii1yuYrUiKx/6Sxkio=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRFBQ8c8pfYbT/vBUYZsGlahKcxbJ9B2NvRiDifX5jV6iAR2UonjYBnb0pFgbhOgs91YnKVP5AcVmYv/+sGOxruRvNAZ6q3lyWqeSb3B0lCJGFEqHubRG16SyVtj78XApaWpuB7nULRUfJHkGs5HA8vKKXmIrBJbYfVliiIZBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUpp3fz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6433AC4CEE2;
	Mon, 14 Apr 2025 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744645560;
	bh=BYdAOPIOmHl00ROk7DBXfagd2ii1yuYrUiKx/6Sxkio=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WUpp3fz0KnfvWA8gkonln9I2U5lGMoY73p8VykmTXDlp6dfNfKU8fY0huHtSLXKB8
	 A3FB80m383w4fYiWERc+XaUHnaU3NZ/jzFEMzMawOfqFSQYGpUvU/5ZSU/rXdWLGv/
	 dnesR3CpSUgx+70S7hjoeBX1K565eX3YgOG61XmN+9aWOuVa57fw5p1yK9qYrnpnP9
	 QfPal6ku4AHtqJzZ+J4a9a9FG0rF8ASroTycDPMsvxH4neeoXpC08aK3wXpnNbKWQb
	 skMZ7YjoFGfjaVhnJNNn9N30a8UKQgLxsRt+c4SyzdIO0okMtmKzA/lZCg39Y0FJHx
	 dE3GdSzsbSVuA==
Subject: [PATCH net-next RFC V3 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com
Date: Mon, 14 Apr 2025 17:45:56 +0200
Message-ID: <174464555655.20396.15783804183694533537.stgit@firesoul>
In-Reply-To: <174464549885.20396.6987653753122223942.stgit@firesoul>
References: <174464549885.20396.6987653753122223942.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In production, we're seeing TX drops on veth devices when the ptr_ring
fills up. This can occur when NAPI mode is enabled, though it's
relatively rare. However, with threaded NAPI - which we use in
production - the drops become significantly more frequent.

The underlying issue is that with threaded NAPI, the consumer often runs
on a different CPU than the producer. This increases the likelihood of
the ring filling up before the consumer gets scheduled, especially under
load, leading to drops in veth_xmit() (ndo_start_xmit()).

This patch introduces backpressure by returning NETDEV_TX_BUSY when the
ring is full, signaling the qdisc layer to requeue the packet. The txq
(netdev queue) is stopped in this condition and restarted once
veth_poll() drains entries from the ring, ensuring coordination between
NAPI and qdisc.

Backpressure is only enabled when a qdisc is attached. Without a qdisc,
the driver retains its original behavior - dropping packets immediately
when the ring is full. This avoids unexpected behavior changes in setups
without a configured qdisc.

With a qdisc in place (e.g. fq, sfq) this allows Active Queue Management
(AQM) to fairly schedule packets across flows and reduce collateral
damage from elephant flows.

A known limitation of this approach is that the full ring sits in front
of the qdisc layer, effectively forming a FIFO buffer that introduces
base latency. While AQM still improves fairness and mitigates flow
dominance, the latency impact is measurable.

In hardware drivers, this issue is typically addressed using BQL (Byte
Queue Limits), which tracks in-flight bytes needed based on physical link
rate. However, for virtual drivers like veth, there is no fixed bandwidth
constraint - the bottleneck is CPU availability and the scheduler's ability
to run the NAPI thread. It is unclear how effective BQL would be in this
context.

This patch serves as a first step toward addressing TX drops. Future work
may explore adapting a BQL-like mechanism to better suit virtual devices
like veth.

Reported-by: Yan Zhai <yan@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c |   49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 7bb53961c0ea..3455fca2f2af 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -308,11 +308,10 @@ static void __veth_xdp_flush(struct veth_rq *rq)
 static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
 {
 	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb))) {
-		dev_kfree_skb_any(skb);
-		return NET_RX_DROP;
+		return NETDEV_TX_BUSY; /* signal qdisc layer */
 	}
 
-	return NET_RX_SUCCESS;
+	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
 }
 
 static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
@@ -346,11 +345,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
 	struct veth_rq *rq = NULL;
-	int ret = NETDEV_TX_OK;
+	struct netdev_queue *txq;
 	struct net_device *rcv;
 	int length = skb->len;
 	bool use_napi = false;
-	int rxq;
+	int ret, rxq;
 
 	rcu_read_lock();
 	rcv = rcu_dereference(priv->peer);
@@ -373,17 +372,41 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	skb_tx_timestamp(skb);
-	if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == NET_RX_SUCCESS)) {
+
+	ret = veth_forward_skb(rcv, skb, rq, use_napi);
+	switch(ret) {
+	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
 		if (!use_napi)
 			dev_sw_netstats_tx_add(dev, 1, length);
 		else
 			__veth_xdp_flush(rq);
-	} else {
+		break;
+	case NETDEV_TX_BUSY:
+		/* If a qdisc is attached to our virtual device, returning
+		 * NETDEV_TX_BUSY is allowed.
+		 */
+		txq = netdev_get_tx_queue(dev, rxq);
+
+		if (qdisc_txq_is_noop(txq)) {
+			dev_kfree_skb_any(skb);
+			goto drop;
+		}
+		netif_tx_stop_queue(txq);
+		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
+		__skb_push(skb, ETH_HLEN);
+		if (use_napi)
+			__veth_xdp_flush(rq);
+
+		break;
+	case NET_RX_DROP: /* same as NET_XMIT_DROP */
 drop:
 		atomic64_inc(&priv->dropped);
 		ret = NET_XMIT_DROP;
+		break;
+	default:
+		net_crit_ratelimited("veth_xmit(%s): Invalid return code(%d)",
+				     dev->name, ret);
 	}
-
 	rcu_read_unlock();
 
 	return ret;
@@ -874,9 +897,16 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct veth_xdp_tx_bq *bq,
 			struct veth_stats *stats)
 {
+	struct veth_priv *priv = netdev_priv(rq->dev);
+	int queue_idx = rq->xdp_rxq.queue_index;
+	struct netdev_queue *peer_txq;
+	struct net_device *peer_dev;
 	int i, done = 0, n_xdpf = 0;
 	void *xdpf[VETH_XDP_BATCH];
 
+	peer_dev = rcu_dereference(priv->peer);
+	peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
+
 	for (i = 0; i < budget; i++) {
 		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
 
@@ -925,6 +955,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 	rq->stats.vs.xdp_packets += done;
 	u64_stats_update_end(&rq->stats.syncp);
 
+	if (unlikely(netif_tx_queue_stopped(peer_txq)))
+		netif_tx_wake_queue(peer_txq);
+
 	return done;
 }
 




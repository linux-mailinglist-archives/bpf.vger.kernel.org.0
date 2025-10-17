Return-Path: <bpf+bounces-71224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978DBEA858
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A772D19A0581
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8542773E3;
	Fri, 17 Oct 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jELdT4hZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4481275B06;
	Fri, 17 Oct 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717408; cv=none; b=cNiR+1n2+oilZwayFypQtOq20cChMdyt7mgiGGIEQmw282dTVbE5kN5NFLe11GTIZ45NLDgcVMC4L6MVIiyHo6iOXwMacLnwqsKWwN1XxDFR4G2VraHD2nbtaelJh9pQczGpYQG16GbfR5+wNmxAbP3ONKVg9AbaJf+qvYSNuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717408; c=relaxed/simple;
	bh=sR4wT6ql2A/OkkHX38+xs03NATFvPBEQGacjohvzTGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfFROx80XJiv5si+j4d52ff7+totnIYThj3YO5hWK2wQIYluUnbnBIm+FncqWC2b17yjMBml9rUwOdNOeA+KJv6+M2n5loN6t8t5X6PQexIL528uFOQdK7Tk4oZfUJFsLTmhxbv9cr7t1/Mj9v6VhxwVDYNq84BWj9Tm9IwqDmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jELdT4hZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F358C4CEE7;
	Fri, 17 Oct 2025 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760717405;
	bh=sR4wT6ql2A/OkkHX38+xs03NATFvPBEQGacjohvzTGE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jELdT4hZVfXXfDAwQ/NNM9ef6ok7dY7chwQqzT8HM9tHScr+oJ+I85oypKbVRtRr+
	 wQhua5iRIXsQ5oo5Ykk4FD2gViUYUUeWZ5aALG78PEgzEUHyLXVJ1pOkS+cYY0Ist8
	 n3kKLTEujA/fX8zEEOEIOukJmooopoF7sjXpBdz8YNLJh70eJE7dsf43Mph1eIuuLK
	 jGGVT+rJGgXEcnWeV0cUvWM8oZuyiuRRNgTh+ZDZ1c4vl+n0OAUDQEVHB0VZ0FhdkR
	 5Opfmi3nLqgqYW9rrqJoM0+/lWrUjoIE3hij1vgVbq7ipeoc1S8yT52GAAw1ThvzqA
	 qHugr+uX1OZRA==
Message-ID: <44ebd8b7-605c-4e0f-8c3f-966b8a35ff02@kernel.org>
Date: Fri, 17 Oct 2025 18:09:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V7 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc, Chris Arges
 <carges@cloudflare.com>, Yan Zhai <yan@cloudflare.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <174559288731.827981.8748257839971869213.stgit@firesoul>
 <174559294022.827981.1282809941662942189.stgit@firesoul>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <174559294022.827981.1282809941662942189.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Heads-up.

We have been running this patchset in production for approx 2.5 months.
The race-condition we tried to handled (below) in NETDEV_TX_BUSY case,
isn't avoided 100% of the time.  We end-up in a situation where a TXQ
remains stopped (and cannot recover) and this results in the attached
qdisc cannot dequeue packets resulting in backlog getting full.  The
stalled TXQ state (QUEUE_STATE_DRV_XOFF) was confirmed on one server via
bpftrace and drgn.

We cannot recover from this state because we didn't add appropiate txq
resets in down/up (ndo_stop/ndo_open), and driver doesn't enable
dev_watchdog checking.  I have patches ready for this, such that the
device can recover again.

The observed race-condition BUG seems to only occur on our ARM64
(aarch64) servers. Looking at metrics we beleive it have happened 6
times over the period and these servers were all the same ARM CPU type
Ampere(R) Altra(R) Max Processor model name Neoverse-N1.  Thus, this
might be a memory barrier issue.

Marked the location below, I think the bug occured.  Looking for input
on how we can improve the code to avoid this race on ARM.  I think the
patch [V4] didn't have this race, because it always calls
__veth_xdp_flush(rq).

  [V4] 
https://lore.kernel.org/all/174472470529.274639.17026526070544068280.stgit@firesoul/#Z31drivers:net:veth.c


On 25/04/2025 16.55, Jesper Dangaard Brouer wrote:
> In production, we're seeing TX drops on veth devices when the ptr_ring
> fills up. This can occur when NAPI mode is enabled, though it's
> relatively rare. However, with threaded NAPI - which we use in
> production - the drops become significantly more frequent.
> 
> The underlying issue is that with threaded NAPI, the consumer often runs
> on a different CPU than the producer. This increases the likelihood of
> the ring filling up before the consumer gets scheduled, especially under
> load, leading to drops in veth_xmit() (ndo_start_xmit()).
> 
> This patch introduces backpressure by returning NETDEV_TX_BUSY when the
> ring is full, signaling the qdisc layer to requeue the packet. The txq
> (netdev queue) is stopped in this condition and restarted once
> veth_poll() drains entries from the ring, ensuring coordination between
> NAPI and qdisc.
> 
> Backpressure is only enabled when a qdisc is attached. Without a qdisc,
> the driver retains its original behavior - dropping packets immediately
> when the ring is full. This avoids unexpected behavior changes in setups
> without a configured qdisc.
> 
> With a qdisc in place (e.g. fq, sfq) this allows Active Queue Management
> (AQM) to fairly schedule packets across flows and reduce collateral
> damage from elephant flows.
> 
> A known limitation of this approach is that the full ring sits in front
> of the qdisc layer, effectively forming a FIFO buffer that introduces
> base latency. While AQM still improves fairness and mitigates flow
> dominance, the latency impact is measurable.
> 
> In hardware drivers, this issue is typically addressed using BQL (Byte
> Queue Limits), which tracks in-flight bytes needed based on physical link
> rate. However, for virtual drivers like veth, there is no fixed bandwidth
> constraint - the bottleneck is CPU availability and the scheduler's ability
> to run the NAPI thread. It is unclear how effective BQL would be in this
> context.
> 
> This patch serves as a first step toward addressing TX drops. Future work
> may explore adapting a BQL-like mechanism to better suit virtual devices
> like veth.
> 
> Reported-by: Yan Zhai <yan@cloudflare.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>   drivers/net/veth.c |   57 +++++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 7bb53961c0ea..e58a0f1b5c5b 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -307,12 +307,10 @@ static void __veth_xdp_flush(struct veth_rq *rq)
>   
>   static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
>   {
> -	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb))) {
> -		dev_kfree_skb_any(skb);
> -		return NET_RX_DROP;
> -	}
> +	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
> +		return NETDEV_TX_BUSY; /* signal qdisc layer */
>   
> -	return NET_RX_SUCCESS;
> +	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
>   }
>   
>   static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
> @@ -346,11 +344,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
>   	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>   	struct veth_rq *rq = NULL;
> -	int ret = NETDEV_TX_OK;
> +	struct netdev_queue *txq;
>   	struct net_device *rcv;
>   	int length = skb->len;
>   	bool use_napi = false;
> -	int rxq;
> +	int ret, rxq;
>   
>   	rcu_read_lock();
>   	rcv = rcu_dereference(priv->peer);
> @@ -373,17 +371,45 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>   	}
>   
>   	skb_tx_timestamp(skb);
> -	if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == NET_RX_SUCCESS)) {
> +
> +	ret = veth_forward_skb(rcv, skb, rq, use_napi);
> +	switch (ret) {
> +	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
>   		if (!use_napi)
>   			dev_sw_netstats_tx_add(dev, 1, length);
>   		else
>   			__veth_xdp_flush(rq);
> -	} else {
> +		break;
> +	case NETDEV_TX_BUSY:
> +		/* If a qdisc is attached to our virtual device, returning
> +		 * NETDEV_TX_BUSY is allowed.
> +		 */
> +		txq = netdev_get_tx_queue(dev, rxq);
> +
> +		if (qdisc_txq_has_no_queue(txq)) {
> +			dev_kfree_skb_any(skb);
> +			goto drop;
> +		}
> +		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
> +		__skb_push(skb, ETH_HLEN);
> +		/* Depend on prior success packets started NAPI consumer via
> +		 * __veth_xdp_flush(). Cancel TXQ stop if consumer stopped,
> +		 * paired with empty check in veth_poll().
> +		 */
> +		netif_tx_stop_queue(txq);
> +		smp_mb__after_atomic();

Maybe this memory barrier isn't enough on ARM?

I tried to follow the code, and AFAICT the smp_mb__after_atomic() on ARM
result in __smp_mb(), which on ARM is[1] an actual DMB (Data Memory
Barrier) instruction.

[1] 
https://elixir.bootlin.com/linux/v6.17.1/source/arch/arm/include/asm/barrier.h#L77

-Jesper

> +		if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
> +			netif_tx_wake_queue(txq);
> +		break;
> +	case NET_RX_DROP: /* same as NET_XMIT_DROP */
>   drop:
>   		atomic64_inc(&priv->dropped);
>   		ret = NET_XMIT_DROP;
> +		break;
> +	default:
> +		net_crit_ratelimited("%s(%s): Invalid return code(%d)",
> +				     __func__, dev->name, ret);
>   	}
> -
>   	rcu_read_unlock();
>   
>   	return ret;
> @@ -874,9 +900,17 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>   			struct veth_xdp_tx_bq *bq,
>   			struct veth_stats *stats)
>   {
> +	struct veth_priv *priv = netdev_priv(rq->dev);
> +	int queue_idx = rq->xdp_rxq.queue_index;
> +	struct netdev_queue *peer_txq;
> +	struct net_device *peer_dev;
>   	int i, done = 0, n_xdpf = 0;
>   	void *xdpf[VETH_XDP_BATCH];
>   
> +	/* NAPI functions as RCU section */
> +	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
> +	peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
> +
>   	for (i = 0; i < budget; i++) {
>   		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>   
> @@ -925,6 +959,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>   	rq->stats.vs.xdp_packets += done;
>   	u64_stats_update_end(&rq->stats.syncp);
>   
> +	if (unlikely(netif_tx_queue_stopped(peer_txq)))
> +		netif_tx_wake_queue(peer_txq);
> +
>   	return done;
>   }
>   
> 



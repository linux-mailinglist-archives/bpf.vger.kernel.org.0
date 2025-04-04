Return-Path: <bpf+bounces-55351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBCBA7C432
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 21:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2973B4111
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1725EF87;
	Fri,  4 Apr 2025 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDS71LQn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA325E815;
	Fri,  4 Apr 2025 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743796275; cv=none; b=NIWukNOFnvgtMd+CJ46SEL+3GsYNkhQO2GLW/FXg3f7U+PITG71roHKZ8mYgZ3alAH55YLF2owQXdAYCwiFHToVWFxxdfi41KUp8SKHGCsmlzQQ2VpksDJgB6IyPHQ26zMF7qk7Nc7SyqmT8cQLfTBQd8c7asVUCNN2hzN3zSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743796275; c=relaxed/simple;
	bh=kOr+EGTekftgoaz4VXSPNyinCBvwKujNyUxGSfOVZv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjIIGzc6CD7WMmsnIwyW/zH+Y8F0aPuo64rAcjszzPxs0OvflC9jnlglZGy8dWDMgfQEhvLCzMd8RwlKz/TEXjMwd415nBGxahgJelBdJmvSTcnNHwxK68iq4x351MfhRA+IizgiXXJxdqJW7BjsBKExZcb5EzPMbTRF1o0+5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDS71LQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C143CC4CEDD;
	Fri,  4 Apr 2025 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743796274;
	bh=kOr+EGTekftgoaz4VXSPNyinCBvwKujNyUxGSfOVZv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EDS71LQnXwn8d7lz9hTGSvSxS/bcsZAAzYuQD20g+MhAvBixPHGHs8+DuvsCTUL7K
	 CHaWepYBlU/8KNM1D326PA4c12LJRwq3rfwLYmfdLs+XJB8RpyKzM8mD1/mBXW3qFg
	 T3EpkFlPegJwTB1RNUy50oGdeLfgu73w8v7Bp3c4kw9EvzlInFSX+5RKnFQvI0Z4rt
	 j9LAcwjLOD8rXmVHy4rC8XtTtDuUddZnSrk5R+x6jgrLOgAOC21HZZHeR3YzBJsu1o
	 IOxPSuyRMeTuHcakhxVlm06obAK5yXNX35ENielEfoUOi8CM34hnnb9DYf0mMESc5N
	 1xNZk6Ypfixcw==
Message-ID: <be490131-5f47-41c8-9262-5dc19bc65fb6@kernel.org>
Date: Fri, 4 Apr 2025 21:51:10 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 kernel-team@cloudflare.com
References: <174377814192.3376479.16481605648460889310.stgit@firesoul>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <174377814192.3376479.16481605648460889310.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/04/2025 16.49, Jesper Dangaard Brouer wrote:
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
>   drivers/net/veth.c |   58 +++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 7bb53961c0ea..fff2b615781e 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -308,11 +308,10 @@ static void __veth_xdp_flush(struct veth_rq *rq)
>   static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
>   {
>   	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb))) {
> -		dev_kfree_skb_any(skb);
> -		return NET_RX_DROP;
> +		return NETDEV_TX_BUSY; /* signal qdisc layer */
>   	}
>   
> -	return NET_RX_SUCCESS;
> +	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
>   }
>   
>   static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
> @@ -342,15 +341,26 @@ static bool veth_skb_is_eligible_for_gro(const struct net_device *dev,
>   		 rcv->features & (NETIF_F_GRO_FRAGLIST | NETIF_F_GRO_UDP_FWD));
>   }
>   
> +/* Does specific txq have a real qdisc attached? - see noqueue_init() */
> +static inline bool txq_has_qdisc(struct netdev_queue *txq)
> +{
> +	struct Qdisc *q;
> +
> +	q = rcu_dereference(txq->qdisc);
> +	if (q->enqueue)
> +		return true;
> +	else
> +		return false;
> +}
> +
>   static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
>   	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>   	struct veth_rq *rq = NULL;
> -	int ret = NETDEV_TX_OK;
>   	struct net_device *rcv;
>   	int length = skb->len;
>   	bool use_napi = false;
> -	int rxq;
> +	int ret, rxq;
>   
>   	rcu_read_lock();
>   	rcv = rcu_dereference(priv->peer);
> @@ -373,17 +383,39 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>   	}
>   
>   	skb_tx_timestamp(skb);
> -	if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == NET_RX_SUCCESS)) {
> +
> +	ret = veth_forward_skb(rcv, skb, rq, use_napi);
> +	switch(ret) {
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
> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, rxq);
> +
> +		if (!txq_has_qdisc(txq)) {
> +			dev_kfree_skb_any(skb);
> +			goto drop;
> +		}
> +		netif_tx_stop_queue(txq); /* Unconditional netif_txq_try_stop */
> +		if (use_napi)
> +			__veth_xdp_flush(rq);
> +

Found a bug here... I need to skb_push back Ethernet header, because
__dev_forward_skb() via eth_type_trans() pulled it off.

Code fix:
		__skb_push(skb, ETH_HLEN)


> +		break;
> +	case NET_RX_DROP: /* same as NET_XMIT_DROP */
>   drop:
>   		atomic64_inc(&priv->dropped);
>   		ret = NET_XMIT_DROP;
> +		break;
> +	default:
> +		net_crit_ratelimited("veth_xmit(%s): Invalid return code(%d)",
> +				     dev->name, ret);
>   	}
> -
>   	rcu_read_unlock();
>   
>   	return ret;
> @@ -874,9 +906,16 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
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
> +	peer_dev = priv->peer;
> +	peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
> +
>   	for (i = 0; i < budget; i++) {
>   		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>   
> @@ -925,6 +964,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
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
> 


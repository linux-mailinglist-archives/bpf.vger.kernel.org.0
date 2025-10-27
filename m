Return-Path: <bpf+bounces-72314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E0C0D780
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C13144F07F3
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 12:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B782D2F60A1;
	Mon, 27 Oct 2025 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze39u2ZI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAB4A1A;
	Mon, 27 Oct 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567577; cv=none; b=uHwcWtXfNe8UFLgBy15fv8ECiOo4PO0gjOwC2/9hM7Ar9ytqWSOvkRpwjZ3cIz3tU9/NQGboxquS7YAzSIchDF1fuvVc8hk4m04DQvBideE07SKV6RCSpVO1T4XU8DvwFd1nrraeBRuetE8sO4vZiTI/hmYXlDATL7EJAfiAGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567577; c=relaxed/simple;
	bh=dukrLhMfXoRux/Hbo3C10fR6iaX8YS1a5MOGby1Gct8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ub5587cowUUKM1TMHCgYxK7t9dQdRoPOKd7XBYTxpZOQli/UyZXLfXqWBIzmgLxjAGGpCJjQpkw6llVmYG2C82J8AdAcnOvQoSGrdn9eSGEgyEe+fYTja9iFgAowTH49Y4fyzkMx2/zVchee4x0QAYJtKYuis23k77VHMDf+Hq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze39u2ZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C92FC4CEF1;
	Mon, 27 Oct 2025 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761567576;
	bh=dukrLhMfXoRux/Hbo3C10fR6iaX8YS1a5MOGby1Gct8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ze39u2ZIcxUg4nT/SjtW+RDWKkfU60OrULoBamXUnwD9EbQYO0QjzyGAUtHxyEflc
	 MyUREs0vJzftopk+OWBL1KAhdT4knSHblJiyTByzFfpMZ7JajddQOFIZ5niMRsrlc8
	 uF8X599sJYVxaO5aDQxK6Rf97yU1n5nBUFenPnpPLrYKELwb3r/O/5/34YIGJt9QIm
	 Od57ylV9/0sKHbeh4hV55y0RO1MqHC3WfdAUGEhkUFzM4bNp314x6PJeD9NICEvZ4k
	 vbxEX1JNOLZKe+MwzWyBUTcz3WEVwLnvKT1QBjjpJp3SMu5eCd0A4aC5mUDo1c1bOr
	 hCMiHhr/Zk4mw==
Message-ID: <b021f5c3-5105-445d-b919-8282363a19fc@kernel.org>
Date: Mon, 27 Oct 2025 13:19:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V1 3/3] veth: more robust handing of race to avoid txq
 getting stuck
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org, makita.toshiaki@lab.ntt.co.jp
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123158453.2281302.11061466460805684097.stgit@firesoul>
 <871pmsfjye.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <871pmsfjye.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 24/10/2025 16.33, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
>> Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
>> reduce TX drops") introduced a race condition that can lead to a permanently
>> stalled TXQ. This was observed in production on ARM64 systems (Ampere Altra
>> Max).
>>
>> The race occurs in veth_xmit(). The producer observes a full ptr_ring and
>> stops the queue (netif_tx_stop_queue()). The subsequent conditional logic,
>> intended to re-wake the queue if the consumer had just emptied it (if
>> (__ptr_ring_empty(...)) netif_tx_wake_queue()), can fail. This leads to a
>> "lost wakeup" where the TXQ remains stopped (QUEUE_STATE_DRV_XOFF) and
>> traffic halts.
>>
>> This failure is caused by an incorrect use of the __ptr_ring_empty() API
>> from the producer side. As noted in kernel comments, this check is not
>> guaranteed to be correct if a consumer is operating on another CPU. The
>> empty test is based on ptr_ring->consumer_head, making it reliable only for
>> the consumer. Using this check from the producer side is fundamentally racy.
>>
>> This patch fixes the race by adopting the more robust logic from an earlier
>> version V4 of the patchset, which always flushed the peer:
>>
>> (1) In veth_xmit(), the racy conditional wake-up logic and its memory barrier
>> are removed. Instead, after stopping the queue, we unconditionally call
>> __veth_xdp_flush(rq). This guarantees that the NAPI consumer is scheduled,
>> making it solely responsible for re-waking the TXQ.
> 
> This makes sense.
> 
>> (2) On the consumer side, the logic for waking the peer TXQ is centralized.
>> It is moved out of veth_xdp_rcv() (which processes a batch) and placed at
>> the end of the veth_poll() function. This ensures netif_tx_wake_queue() is
>> called once per complete NAPI poll cycle.
> 
> So is this second point strictly necessary to fix the race, or is it
> more of an optimisation?
> 

IMHO it is strictly necessary to fix the race.  The wakeup check
netif_tx_queue_stopped() in veth_poll() needs to be after the code that
(potentially) writes rx_notify_masked.

This handles the race where veth_xmit() haven't called
netif_tx_stop_queue() yet, but veth_poll() manage to consume all packets
and stopped NAPI.  Then we know that __veth_xdp_flush(rq) in veth_xmit()
will see rx_notify_masked==false and start NAPI/veth_poll() again, and
even-though there is no packets left to process we still hit the check
netif_tx_queue_stopped() which start txq and will allow veth_xmit() to
run again.

I'll see if I can improve the description for (2).

>> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
>> about to complete (napi_complete_done), it now also checks if the peer TXQ
>> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
>> reschedule itself. This prevents a new race where the producer stops the
>> queue just as the consumer is finishing its poll, ensuring the wakeup is not
>> missed.
> 
> Also makes sense...
> 
>> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   drivers/net/veth.c |   42 +++++++++++++++++++++---------------------
>>   1 file changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index 3976ddda5fb8..1d70377481eb 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -392,14 +392,12 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>>   		}
>>   		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
>>   		__skb_push(skb, ETH_HLEN);
>> -		/* Depend on prior success packets started NAPI consumer via
>> -		 * __veth_xdp_flush(). Cancel TXQ stop if consumer stopped,
>> -		 * paired with empty check in veth_poll().
>> -		 */
>>   		netif_tx_stop_queue(txq);
>> -		smp_mb__after_atomic();
>> -		if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
>> -			netif_tx_wake_queue(txq);
>> +		/* Handle race: Makes sure NAPI peer consumer runs. Consumer is
>> +		 * responsible for starting txq again, until then ndo_start_xmit
>> +		 * (this function) will not be invoked by the netstack again.
>> +		 */
>> +		__veth_xdp_flush(rq);
> 
> Nit: I'd lose the "Handle race:" prefix from the comment; the rest of
> the comment is clear enough without it, and since there's no explanation
> of *which* race is being handled, it is just confusing, IMO.

Good point, I will remove prefix.

>>   		break;
>>   	case NET_RX_DROP: /* same as NET_XMIT_DROP */
>>   drop:
>> @@ -900,17 +898,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>   			struct veth_xdp_tx_bq *bq,
>>   			struct veth_stats *stats)
>>   {
>> -	struct veth_priv *priv = netdev_priv(rq->dev);
>> -	int queue_idx = rq->xdp_rxq.queue_index;
>> -	struct netdev_queue *peer_txq;
>> -	struct net_device *peer_dev;
>>   	int i, done = 0, n_xdpf = 0;
>>   	void *xdpf[VETH_XDP_BATCH];
>>   
>> -	/* NAPI functions as RCU section */
>> -	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
>> -	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
>> -
>>   	for (i = 0; i < budget; i++) {
>>   		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>>   
>> @@ -959,11 +949,6 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>   	rq->stats.vs.xdp_packets += done;
>>   	u64_stats_update_end(&rq->stats.syncp);
>>   
>> -	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq))) {
>> -		txq_trans_cond_update(peer_txq);
>> -		netif_tx_wake_queue(peer_txq);
>> -	}
>> -
>>   	return done;
>>   }
>>   
>> @@ -971,12 +956,20 @@ static int veth_poll(struct napi_struct *napi, int budget)
>>   {
>>   	struct veth_rq *rq =
>>   		container_of(napi, struct veth_rq, xdp_napi);
>> +	struct veth_priv *priv = netdev_priv(rq->dev);
>> +	int queue_idx = rq->xdp_rxq.queue_index;
>> +	struct netdev_queue *peer_txq;
>>   	struct veth_stats stats = {};
>> +	struct net_device *peer_dev;
>>   	struct veth_xdp_tx_bq bq;
>>   	int done;
>>   
>>   	bq.count = 0;
>>   
>> +	/* NAPI functions as RCU section */
>> +	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
>> +	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
>> +
>>   	xdp_set_return_frame_no_direct();
>>   	done = veth_xdp_rcv(rq, budget, &bq, &stats);
>>   
>> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
>>   	if (done < budget && napi_complete_done(napi, done)) {
>>   		/* Write rx_notify_masked before reading ptr_ring */
>>   		smp_store_mb(rq->rx_notify_masked, false);
>> -		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
>> +		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
>> +			     (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
>>   			if (napi_schedule_prep(&rq->xdp_napi)) {
>>   				WRITE_ONCE(rq->rx_notify_masked, true);
>>   				__napi_schedule(&rq->xdp_napi);
>> @@ -998,6 +992,12 @@ static int veth_poll(struct napi_struct *napi, int budget)
>>   		veth_xdp_flush(rq, &bq);
>>   	xdp_clear_return_frame_no_direct();
>>   
>> +	/* Release backpressure per NAPI poll */
>> +	if (peer_txq && netif_tx_queue_stopped(peer_txq)) {
>> +		txq_trans_cond_update(peer_txq);
>> +		netif_tx_wake_queue(peer_txq);
>> +	}
>> +
>>   	return done;
>>   }
>>   
> 



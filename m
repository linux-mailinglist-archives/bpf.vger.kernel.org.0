Return-Path: <bpf+bounces-56133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E68AA91D1E
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 15:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B870F19E6835
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56B017A2E3;
	Thu, 17 Apr 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqIQnUAX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399F219ED;
	Thu, 17 Apr 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894833; cv=none; b=UFow5QyEDXfxF9KciQFgwzWDQ9O+/cgGgW45jKYBdPu8YEtJlnq7YNXt9siwu/Hvz+gA7pa46kpSw0ZuYk5Wod/c0qyLMaTA7UGXvYK8DzoXd7n7rSh0M/mp4wa7aZsegAdMrID4RQZLwyB5augvupFOEABXHkPZIk5a4SV64qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894833; c=relaxed/simple;
	bh=tN6VlwhVY6GBDMPbwg6AndCI7gOWs6KugYPq9CK+uXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dvzgk++ShpgVAVFnMOaGPdnYvEIB1HvOnX0DpEab8JXZ+0iVyy/WHRZoHY0/p2bhKkMwIlVPv5PCVZQiHALekDKff16vGkCns7bJERJLabsSgFHYReLiUk1Vh52bBj8GdthofiE6lry8ln5QFqLqUUxtqV/F4HW2sriXGxqVxAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqIQnUAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B652DC4CEE4;
	Thu, 17 Apr 2025 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744894832;
	bh=tN6VlwhVY6GBDMPbwg6AndCI7gOWs6KugYPq9CK+uXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sqIQnUAXbunEI71xsjgRpLF2/CBTQPBCebxfpCc2yvzlnXCyEZiI3hocb+oIvVWuL
	 o5YHKilGWLAZoEEdLG1ntJVOffQtNPm/KACZiHF9F2pr/oJQrBjO1hWntDa+GV+cEF
	 PMwZdyoz5ZZAA4oT09q8NLXDvucjilg5223kEUpfGE0uLBEFGsAvYKmVYA4s75ArbP
	 FOfY7ug1G06I7o5Pa+6WiyqqgZL4scIlpqKAp2qY8P8qMkEdkFp7/kTs0vgORoFHQL
	 2j5TIqwNrMLopLDfnfyf8Zqi7Z0yPvig+Ept/d8Nu+7cnOZzM4IznebdRoVDPMMjS6
	 RC5W81WW7Kb+g==
Message-ID: <12d6fe78-6638-4340-83a1-70b6e77b4d38@kernel.org>
Date: Thu, 17 Apr 2025 15:00:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Toshiaki Makita <toshiaki.makita1@gmail.com>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472470529.274639.17026526070544068280.stgit@firesoul>
 <882f14f9-99e7-44ac-a325-ad809bf0ccff@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <882f14f9-99e7-44ac-a325-ad809bf0ccff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/04/2025 14.44, Toshiaki Makita wrote:
> On 2025/04/15 22:45, Jesper Dangaard Brouer wrote:
>> In production, we're seeing TX drops on veth devices when the ptr_ring
>> fills up. This can occur when NAPI mode is enabled, though it's
>> relatively rare. However, with threaded NAPI - which we use in
>> production - the drops become significantly more frequent.
>>
>> The underlying issue is that with threaded NAPI, the consumer often runs
>> on a different CPU than the producer. This increases the likelihood of
>> the ring filling up before the consumer gets scheduled, especially under
>> load, leading to drops in veth_xmit() (ndo_start_xmit()).
>>
>> This patch introduces backpressure by returning NETDEV_TX_BUSY when the
>> ring is full, signaling the qdisc layer to requeue the packet. The txq
>> (netdev queue) is stopped in this condition and restarted once
>> veth_poll() drains entries from the ring, ensuring coordination between
>> NAPI and qdisc.
>>
>> Backpressure is only enabled when a qdisc is attached. Without a qdisc,
>> the driver retains its original behavior - dropping packets immediately
>> when the ring is full. This avoids unexpected behavior changes in setups
>> without a configured qdisc.
>>
>> With a qdisc in place (e.g. fq, sfq) this allows Active Queue Management
>> (AQM) to fairly schedule packets across flows and reduce collateral
>> damage from elephant flows.
>>
>> A known limitation of this approach is that the full ring sits in front
>> of the qdisc layer, effectively forming a FIFO buffer that introduces
>> base latency. While AQM still improves fairness and mitigates flow
>> dominance, the latency impact is measurable.
>>
>> In hardware drivers, this issue is typically addressed using BQL (Byte
>> Queue Limits), which tracks in-flight bytes needed based on physical link
>> rate. However, for virtual drivers like veth, there is no fixed bandwidth
>> constraint - the bottleneck is CPU availability and the scheduler's 
>> ability
>> to run the NAPI thread. It is unclear how effective BQL would be in this
>> context.
>>
>> This patch serves as a first step toward addressing TX drops. Future work
>> may explore adapting a BQL-like mechanism to better suit virtual devices
>> like veth.
> 
> Thank you for the patch.
> 
>> Reported-by: Yan Zhai <yan@cloudflare.com>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   drivers/net/veth.c |   49 
>> +++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 41 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index 7bb53961c0ea..a419d5e198d8 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -308,11 +308,10 @@ static void __veth_xdp_flush(struct veth_rq *rq)
>>   static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
>>   {
>>       if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb))) {
>> -        dev_kfree_skb_any(skb);
>> -        return NET_RX_DROP;
>> +        return NETDEV_TX_BUSY; /* signal qdisc layer */
>>       }
> 
> You don't need this braces any more?
> 
> if (...)
>      return ...;
> 

Correct, fixed for V5.

>> -    return NET_RX_SUCCESS;
>> +    return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
>>   }
>>   static int veth_forward_skb(struct net_device *dev, struct sk_buff 
>> *skb,
>> @@ -346,11 +345,11 @@ static netdev_tx_t veth_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>   {
>>       struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>>       struct veth_rq *rq = NULL;
>> -    int ret = NETDEV_TX_OK;
>> +    struct netdev_queue *txq;
>>       struct net_device *rcv;
>>       int length = skb->len;
>>       bool use_napi = false;
>> -    int rxq;
>> +    int ret, rxq;
>>       rcu_read_lock();
>>       rcv = rcu_dereference(priv->peer);
>> @@ -373,17 +372,41 @@ static netdev_tx_t veth_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>       }
>>       skb_tx_timestamp(skb);
>> -    if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == 
>> NET_RX_SUCCESS)) {
>> +
>> +    ret = veth_forward_skb(rcv, skb, rq, use_napi);
>> +    switch(ret) {
>> +    case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
>>           if (!use_napi)
>>               dev_sw_netstats_tx_add(dev, 1, length);
>>           else
>>               __veth_xdp_flush(rq);
>> -    } else {
>> +        break;
>> +    case NETDEV_TX_BUSY:
>> +        /* If a qdisc is attached to our virtual device, returning
>> +         * NETDEV_TX_BUSY is allowed.
>> +         */
>> +        txq = netdev_get_tx_queue(dev, rxq);
>> +
>> +        if (qdisc_txq_has_no_queue(txq)) {
>> +            dev_kfree_skb_any(skb);
>> +            goto drop;
>> +        }
>> +        netif_tx_stop_queue(txq);
>> +        /* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
>> +        __skb_push(skb, ETH_HLEN);
>> +        if (use_napi)
>> +            __veth_xdp_flush(rq);
> 
> You did not add a packet to the ring.
> No need for flush here?

IMHO we do need a flush here.
This is related to the netif_tx_stop_queue(txq) call, that stops the
TXQ, and that need to be started again by NAPI side.

This is need to handle a very unlikely race, but if the race happens
then it can cause the TXQ to stay stopped (blocking all traffic).

Given we arrive at NETDEV_TX_BUSY, when ptr_ring is full, it is very
likely that someone else have called flush and NAPI veth_poll is
running.  Thus, the extra flush will likely be a no-op as
rx_notify_masked is true.

The race is that before calling netif_tx_stop_queue(txq) the other CPU
running NAPI veth_poll manages to NAPI complete and empty the ptr_ring.
In this case, the flush will avoid race, as it will have an effect as
rx_notify_masked will be false.

Looking closer at code: There is still a possible race, in veth_poll,
after calling veth_xdp_rcv() and until rq->rx_notify_masked is set to
false (via smp_store_mb).  If netif_tx_stop_queue(txq) is executed in
this window, then we still have the race, where TXQ stays stopped
forever. (There is a optional call to xdp_do_flush that can increase
race window).

I'll add something in V5 that also handles the second race window.

--Jesper


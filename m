Return-Path: <bpf+bounces-60148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030AAAD3540
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E48D27A88E3
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3437228DF5D;
	Tue, 10 Jun 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZO3MZDf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D3F1FC11F;
	Tue, 10 Jun 2025 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555814; cv=none; b=egGXZDKOID1HGK/89T1bByiXwoOXpVbqy6YIXAPIo3lKlixNObwujXTLqaNGidcHhXLVK4vFiOeVRcg1DtvUj7K8+LLUlGIYDtZfIG+t40PyAI+mEvRuuL+7h3XXlRNqG+j5iDyCfc6ycBt+lSsNMaTsa8HF57oIPSQlDHZvOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555814; c=relaxed/simple;
	bh=PDy2DKknaciUDyuqZoVc2ijlR0jqVrQviQ1Sx1M+ah0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XP9xSeuD7yPGFXLPABHm0+Dh3Xwd5gczxzqUnTek5+Z2JEtrn694Cdb1U+V2c/pHcdNVN6Y/rLkZn7dhFn9E05xydrp/5OxPUW90NGyK4gJP44APAphbr4nWz19npxHDmK9Ai3AFt2d5oqZccacYQDQhnlMuqTmaqAIUjZHTEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZO3MZDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4DEC4CEED;
	Tue, 10 Jun 2025 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749555814;
	bh=PDy2DKknaciUDyuqZoVc2ijlR0jqVrQviQ1Sx1M+ah0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XZO3MZDf9rvY6vzzaIrO7Go3Mo27+Np3t0A8e51yhbrRVtPaDQvJaTr3sXwuq5rWa
	 vhnp1eI8Ga+TYqs3SDNZOVqougzr4uyM8HvGfg3+cExMUWlW9WhZh25bTqZtJY39lm
	 tggSvZAqQLuivXkLKy+HIJZ0PmBQbCbBkJZ6zkH7FOGwE8jiedQMRY62mcq2X/WjRc
	 oJ/q9Q8qrynamhndtv/hU4K0H8VBeGZjUaLScgNz/6sxB0hhgJRtUYCxiVlNQpsc0f
	 Aflx1vze0E9IhZ0VENTiqRhlmC09oUd4baYaoLrPzMtOGCSmFhtGQWsHBr4MKqUAPp
	 sysmN+FoISuOQ==
Message-ID: <b158cffc-582b-4a2f-bb13-a27c8f58b6fc@kernel.org>
Date: Tue, 10 Jun 2025 13:43:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V7 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
References: <174559288731.827981.8748257839971869213.stgit@firesoul>
 <174559294022.827981.1282809941662942189.stgit@firesoul>
 <fecfcad0-7a16-42b8-bff2-66ee83a6e5c4@linux.dev>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <fecfcad0-7a16-42b8-bff2-66ee83a6e5c4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/06/2025 00.09, Ihor Solodrai wrote:
> On 4/25/25 7:55 AM, Jesper Dangaard Brouer wrote:
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
>>
>> Reported-by: Yan Zhai <yan@cloudflare.com>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   drivers/net/veth.c |   57 
>> +++++++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 47 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index 7bb53961c0ea..e58a0f1b5c5b 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -307,12 +307,10 @@ static void __veth_xdp_flush(struct veth_rq *rq)
>>   static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
>>   {
>> -    if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb))) {
>> -        dev_kfree_skb_any(skb);
>> -        return NET_RX_DROP;
>> -    }
>> +    if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
>> +        return NETDEV_TX_BUSY; /* signal qdisc layer */
>> -    return NET_RX_SUCCESS;
>> +    return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
>>   }
>>   static int veth_forward_skb(struct net_device *dev, struct sk_buff 
>> *skb,
>> @@ -346,11 +344,11 @@ static netdev_tx_t veth_xmit(struct sk_buff 
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
>> @@ -373,17 +371,45 @@ static netdev_tx_t veth_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>       }
>>       skb_tx_timestamp(skb);
>> -    if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == 
>> NET_RX_SUCCESS)) {
>> +
>> +    ret = veth_forward_skb(rcv, skb, rq, use_napi);
>> +    switch (ret) {
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
>> +        /* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
>> +        __skb_push(skb, ETH_HLEN);
>> +        /* Depend on prior success packets started NAPI consumer via
>> +         * __veth_xdp_flush(). Cancel TXQ stop if consumer stopped,
>> +         * paired with empty check in veth_poll().
>> +         */
>> +        netif_tx_stop_queue(txq);
>> +        smp_mb__after_atomic();
>> +        if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
>> +            netif_tx_wake_queue(txq);
>> +        break;
>> +    case NET_RX_DROP: /* same as NET_XMIT_DROP */
>>   drop:
>>           atomic64_inc(&priv->dropped);
>>           ret = NET_XMIT_DROP;
>> +        break;
>> +    default:
>> +        net_crit_ratelimited("%s(%s): Invalid return code(%d)",
>> +                     __func__, dev->name, ret);
>>       }
>> -
>>       rcu_read_unlock();
>>       return ret;
>> @@ -874,9 +900,17 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
>> budget,
>>               struct veth_xdp_tx_bq *bq,
>>               struct veth_stats *stats)
>>   {
>> +    struct veth_priv *priv = netdev_priv(rq->dev);
>> +    int queue_idx = rq->xdp_rxq.queue_index;
>> +    struct netdev_queue *peer_txq;
>> +    struct net_device *peer_dev;
>>       int i, done = 0, n_xdpf = 0;
>>       void *xdpf[VETH_XDP_BATCH];
>> +    /* NAPI functions as RCU section */
>> +    peer_dev = rcu_dereference_check(priv->peer, 
>> rcu_read_lock_bh_held());
>> +    peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
>> +
>>       for (i = 0; i < budget; i++) {
>>           void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>>
> 
> Hi Jesper.
> 
> Could you please take a look at the reported call traces and help
> understand whether this patch may have introduced a null dereference?

I'm investigating... thanks for reporting.
(more below)

> Pasting a snippet, for full logs (2 examples) see the link:
> https://lore.kernel.org/bpf/6fd7a5b5-ee26-4cc5-8eb0-449c4e326ccc@linux.dev/
> 
> [  343.217465] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [  343.218173] #PF: supervisor read access in kernel mode
> [  343.218644] #PF: error_code(0x0000) - not-present page
> [  343.219128] PGD 0 P4D 0
> [  343.219379] Oops: Oops: 0000 [#1] SMP NOPTI
> [  343.219768] CPU: 1 UID: 0 PID: 7635 Comm: kworker/1:11 Tainted: G
>      W  OE       6.15.0-g2b36f2252b0a-dirty #7 PREEMPT(full)
> [  343.220844] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  343.221436] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  343.222356] Workqueue: mld mld_dad_work
> [  343.222730] RIP: 0010:veth_xdp_rcv.constprop.0+0x6b/0x380
> 

Can you give me the output from below command (on your compiled kernel):

  ./scripts/faddr2line drivers/net/veth.o veth_xdp_rcv.constprop.0+0x6b

>      [...]
> 
> [  343.231061] Call Trace:
> [  343.231306]  <IRQ>
> [  343.231522]  veth_poll+0x7b/0x3a0
> [  343.231856]  __napi_poll.constprop.0+0x28/0x1d0
> [  343.232297]  net_rx_action+0x199/0x350
> [  343.232682]  handle_softirqs+0xd3/0x400
> [  343.233057]  ? __dev_queue_xmit+0x27b/0x1250
> [  343.233473]  do_softirq+0x43/0x90
> [  343.233804]  </IRQ>
> [  343.234016]  <TASK>
> [  343.234226]  __local_bh_enable_ip+0xb5/0xd0
> [  343.234622]  ? __dev_queue_xmit+0x27b/0x1250
> [  343.235035]  __dev_queue_xmit+0x290/0x1250
> [  343.235431]  ? lock_acquire+0xbe/0x2c0
> [  343.235797]  ? ip6_finish_output+0x25e/0x540
> [  343.236210]  ? mark_held_locks+0x40/0x70
> [  343.236583]  ip6_finish_output2+0x38f/0xb80
> [  343.237002]  ? lock_release+0xc6/0x290
> [  343.237364]  ip6_finish_output+0x25e/0x540
> [  343.237761]  mld_sendpack+0x1c1/0x3a0
> [  343.238123]  mld_dad_work+0x3e/0x150
> [  343.238473]  process_one_work+0x1f8/0x580
> [  343.238859]  worker_thread+0x1ce/0x3c0
> [  343.239224]  ? __pfx_worker_thread+0x10/0x10
> [  343.239638]  kthread+0x128/0x250
> [  343.239954]  ? __pfx_kthread+0x10/0x10
> [  343.240320]  ? __pfx_kthread+0x10/0x10
> [  343.240691]  ret_from_fork+0x15c/0x1b0
> [  343.241056]  ? __pfx_kthread+0x10/0x10
> [  343.241418]  ret_from_fork_asm+0x1a/0x30
> [  343.241800]  </TASK>
> [  343.242021] Modules linked in: bpf_testmod(OE) [last unloaded:
> est_no_cfi(OE)]
> [  343.242737] CR2: 0000000000000018
> [  343.243064] ---[ end trace 0000000000000000 ]---
> 
> 
> Thank you.
> 
> 
>> @@ -925,6 +959,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
>> budget,
>>       rq->stats.vs.xdp_packets += done;
>>       u64_stats_update_end(&rq->stats.syncp);
>> +    if (unlikely(netif_tx_queue_stopped(peer_txq)))
>> +        netif_tx_wake_queue(peer_txq);
>> +
>>       return done;
>>   }
>>
>>
> 


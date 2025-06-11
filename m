Return-Path: <bpf+bounces-60261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5CCAD477B
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 02:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC633A8C00
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 00:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0579DA;
	Wed, 11 Jun 2025 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l5JDaIli"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72AB15E97
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749601550; cv=none; b=BgDDXb6LxpboMwpyhfM74DxkofYG2rkpuL6AMERkvYjqxPdnGLWvtXGRrBZoaqtf20M2fEuS3THp4DjhYd0LflYjqbfScskF3L3kKuNVrT7wP6yWKx0w9pliw4mDHQUqWEq0BjC/K9eRC8MLSaxWyY/lEr0BTfxjMxrE+N1VFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749601550; c=relaxed/simple;
	bh=mFag4hz+lv7bx3Z8BEnZDowZA4eQdv8p3Ld0WnRSmX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQFD7HIzq1I9CYQsjk2xapaCh3QLY/1nmFG0FkIR49YAFfVxcZi/Ed9uo9Jv8y+s44dirlB/dg0b4jkG5jNBuyKghHhN8u4kCrowc+NLWPkIdFjirtYS9b/EA3KVEbf0xLmX5AHskXvQLKh1GRFXCzw1h6Bxyrh/ig35BKZIBBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l5JDaIli; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <68106010-f34b-45a8-aaf5-003f5c925c01@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749601536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OH4ApGYmn/DMBgrAa1vHydYXZRuq4f/WNOze5miWktY=;
	b=l5JDaIliqGax9nCiNWoNNyi6hrwme+E9qfvM4NE+RsJJRlu5WXkURDmC6mSALN3pvWi2fT
	KB7lFOOEFR33expXmQ8uf9HaXAtdb/Y0IiimPuL7R+vl9UBPpYxqMFvhBfws5hyhjqd9eo
	n+AUEuKPTVtDEYA5GI3fj6j0xfp2boo=
Date: Tue, 10 Jun 2025 17:25:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next V7 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <174559288731.827981.8748257839971869213.stgit@firesoul>
 <174559294022.827981.1282809941662942189.stgit@firesoul>
 <fecfcad0-7a16-42b8-bff2-66ee83a6e5c4@linux.dev>
 <b158cffc-582b-4a2f-bb13-a27c8f58b6fc@kernel.org>
 <46a47776-dcd9-4c6f-8d71-f94b22b077e2@kernel.org>
 <6812c58a-4f33-46b5-8886-1198e36823ed@linux.dev>
 <cba926c1-66b9-45fb-a203-13ff646567f9@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <cba926c1-66b9-45fb-a203-13ff646567f9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/10/25 2:40 PM, Jesper Dangaard Brouer wrote:
> 
> 
> On 10/06/2025 20.26, Ihor Solodrai wrote:
>> On 6/10/25 8:56 AM, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 10/06/2025 13.43, Jesper Dangaard Brouer wrote:
>>>>
>>>> On 10/06/2025 00.09, Ihor Solodrai wrote:
>>> [...]
>>>>
>>>> Can you give me the output from below command (on your compiled 
>>>> kernel):
>>>>
>>>>   ./scripts/faddr2line drivers/net/veth.o veth_xdp_rcv.constprop.0+0x6b
>>>>
>>>
>>> Still need above data/info please.
>>
>> root@devvm7589:/ci/workspace# ./scripts/faddr2line ./kout.gcc/drivers/ 
>> net/veth.o veth_xdp_rcv.constprop.0+0x6b
>> veth_xdp_rcv.constprop.0+0x6b/0x390:
>> netdev_get_tx_queue at /ci/workspace/kout.gcc/../include/linux/ 
>> netdevice.h:2637
>> (inlined by) veth_xdp_rcv at /ci/workspace/kout.gcc/../drivers/net/ 
>> veth.c:912
>>
>> Which is:
>>
>> veth.c:912
>>      struct veth_priv *priv = netdev_priv(rq->dev);
>>      int queue_idx = rq->xdp_rxq.queue_index;
>>      struct netdev_queue *peer_txq;
>>      struct net_device *peer_dev;
>>      int i, done = 0, n_xdpf = 0;
>>      void *xdpf[VETH_XDP_BATCH];
>>
>>      /* NAPI functions as RCU section */
>>      peer_dev = rcu_dereference_check(priv->peer, 
>> rcu_read_lock_bh_held());
>>   --->    peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
>>
>> netdevice.h:2637
>>      static inline
>>      struct netdev_queue *netdev_get_tx_queue(const struct net_device 
>> *dev,
>>                       unsigned int index)
>>      {
>>          DEBUG_NET_WARN_ON_ONCE(index >= dev->num_tx_queues);
>>   --->        return &dev->_tx[index];
>>      }
>>
>> So the suspect is peer_dev (priv->peer)?
> 
> Yes, this is the problem!
> 
> So, it seems that peer_dev (priv->peer) can become a NULL pointer.
> 
> Managed to reproduce - via manually deleting the peer device:
>   - ip link delete dev veth42
>   - while overloading veth41 via XDP redirecting packets into it.
> 
> Managed to trigger concurrent crashes on two CPUs (C0 + C3)
>   - so below output gets interlaced a bit:
> 
> [...]
> 
> A fix could look like this:
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index e58a0f1b5c5b..a3046142cb8e 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -909,7 +909,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
> 
>          /* NAPI functions as RCU section */
>          peer_dev = rcu_dereference_check(priv->peer, 
> rcu_read_lock_bh_held());
> -       peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
> +       peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : 
> NULL;
> 
>          for (i = 0; i < budget; i++) {
>                  void *ptr = __ptr_ring_consume(&rq->xdp_ring);
> @@ -959,7 +959,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>          rq->stats.vs.xdp_packets += done;
>          u64_stats_update_end(&rq->stats.syncp);
> 
> -       if (unlikely(netif_tx_queue_stopped(peer_txq)))
> +       if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
>                  netif_tx_wake_queue(peer_txq);
> 

Great! I presume you will send a patch separately?

> 
> 
> 
> --Jesper
> 
> 



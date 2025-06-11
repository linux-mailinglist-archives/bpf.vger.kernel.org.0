Return-Path: <bpf+bounces-60305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25715AD4D59
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 09:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7067ABB4A
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 07:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E52367A4;
	Wed, 11 Jun 2025 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txg7FG+E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3662206BE;
	Wed, 11 Jun 2025 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627656; cv=none; b=Ui2lYBRA8rmFBSq81OoR2mGlsCRGakwZbFhZYRZFexQhiAo9nrMiEH05IjJwIHo1xrMeTuEOxMe3Btn5u2shSKuw2duz1ztRM+yuELgORVTxFfv3dJNR4YX8EJSohT0dgcYtSYVkMXb4sKBw7UmFivAkhEPQkNawgZBGWs7LVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627656; c=relaxed/simple;
	bh=f0kjirpReolxShcc+9FUMC/yR29IE/CXkhCKm2mADLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsbmt93bROTLJoNqCUEHymoPMsaHlnDkngWgzCa8qAmoeQpQ2oTWSneHyXEdkwqX2u72oOSjZETaoNacW6j8DSr0wtqCeh1oI1krqhQ+3e3u4g5htAzeuVvETCfHKyIu5rVELs64aqcert18YN+JyYHsUwOeSzhv0jV5G8X0Q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txg7FG+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D1C4CEEF;
	Wed, 11 Jun 2025 07:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749627655;
	bh=f0kjirpReolxShcc+9FUMC/yR29IE/CXkhCKm2mADLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Txg7FG+EluNb03Oo6wkDLo9bia0nlRDlU0OxlwEaUnCGE5TB02Z49zGOAXsx6WcYV
	 7Q+NHbey7k97TqH8Cu82cVyC8m05an7TBxypLtAksLBZPv1zGTeLTzNUZFClx9QBCp
	 t4pMDA0Z1DXGwBtWMEusWCj/k+AhlCsGajK76LKL5AA0gHsXzDKbGLXi0KSjCmftbq
	 gzK7YI9EBIs+Q7k3LCtbp5ieDr8EXaPBKzI3nQxt7tfUMGA50e/h7mk0J4CXuOhBft
	 EFBHC9elQwpjUvPHYSnuKOhAPU51FVLCZMk2+QLRQJjcHkTJ8YXX+lyebIFes8hZLB
	 vWMHICojUA6zg==
Message-ID: <da1f2506-5cb0-446c-b623-dc8f74c53462@kernel.org>
Date: Wed, 11 Jun 2025 09:40:49 +0200
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
 <68106010-f34b-45a8-aaf5-003f5c925c01@linux.dev>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <68106010-f34b-45a8-aaf5-003f5c925c01@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/06/2025 02.25, Ihor Solodrai wrote:
> On 6/10/25 2:40 PM, Jesper Dangaard Brouer wrote:
>>
>>
>> On 10/06/2025 20.26, Ihor Solodrai wrote:
>>> On 6/10/25 8:56 AM, Jesper Dangaard Brouer wrote:
>>>>
>>>>
>>>> On 10/06/2025 13.43, Jesper Dangaard Brouer wrote:
>>>>>
>>>>> On 10/06/2025 00.09, Ihor Solodrai wrote:
>>>> [...]
>>>>>
>>>>> Can you give me the output from below command (on your compiled 
>>>>> kernel):
>>>>>
>>>>>   ./scripts/faddr2line drivers/net/veth.o 
>>>>> veth_xdp_rcv.constprop.0+0x6b
>>>>>
>>>>
>>>> Still need above data/info please.
>>>
>>> root@devvm7589:/ci/workspace# ./scripts/faddr2line 
>>> ./kout.gcc/drivers/ net/veth.o veth_xdp_rcv.constprop.0+0x6b
>>> veth_xdp_rcv.constprop.0+0x6b/0x390:
>>> netdev_get_tx_queue at /ci/workspace/kout.gcc/../include/linux/ 
>>> netdevice.h:2637
>>> (inlined by) veth_xdp_rcv at /ci/workspace/kout.gcc/../drivers/net/ 
>>> veth.c:912
>>>
>>> Which is:
>>>
>>> veth.c:912
>>>      struct veth_priv *priv = netdev_priv(rq->dev);
>>>      int queue_idx = rq->xdp_rxq.queue_index;
>>>      struct netdev_queue *peer_txq;
>>>      struct net_device *peer_dev;
>>>      int i, done = 0, n_xdpf = 0;
>>>      void *xdpf[VETH_XDP_BATCH];
>>>
>>>      /* NAPI functions as RCU section */
>>>      peer_dev = rcu_dereference_check(priv->peer, 
>>> rcu_read_lock_bh_held());
>>>   --->    peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
>>>
>>> netdevice.h:2637
>>>      static inline
>>>      struct netdev_queue *netdev_get_tx_queue(const struct net_device 
>>> *dev,
>>>                       unsigned int index)
>>>      {
>>>          DEBUG_NET_WARN_ON_ONCE(index >= dev->num_tx_queues);
>>>   --->        return &dev->_tx[index];
>>>      }
>>>
>>> So the suspect is peer_dev (priv->peer)?
>>
>> Yes, this is the problem!
>>
>> So, it seems that peer_dev (priv->peer) can become a NULL pointer.
>>
>> Managed to reproduce - via manually deleting the peer device:
>>   - ip link delete dev veth42
>>   - while overloading veth41 via XDP redirecting packets into it.
>>
>> Managed to trigger concurrent crashes on two CPUs (C0 + C3)
>>   - so below output gets interlaced a bit:
>>
>> [...]
>>
>> A fix could look like this:
>>
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index e58a0f1b5c5b..a3046142cb8e 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -909,7 +909,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
>> budget,
>>
>>          /* NAPI functions as RCU section */
>>          peer_dev = rcu_dereference_check(priv->peer, 
>> rcu_read_lock_bh_held());
>> -       peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
>> +       peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) 
>> : NULL;
>>
>>          for (i = 0; i < budget; i++) {
>>                  void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>> @@ -959,7 +959,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
>> budget,
>>          rq->stats.vs.xdp_packets += done;
>>          u64_stats_update_end(&rq->stats.syncp);
>>
>> -       if (unlikely(netif_tx_queue_stopped(peer_txq)))
>> +       if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
>>                  netif_tx_wake_queue(peer_txq);
>>
> 
> Great! I presume you will send a patch separately?

Yes, I will send this as a separate patch.  In a couple of hours (first 
some breakfast and a walk with the dog ;-)).

--Jesper


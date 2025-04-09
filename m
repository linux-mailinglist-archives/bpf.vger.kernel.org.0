Return-Path: <bpf+bounces-55528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05029A82643
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FA37ABE1F
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2137A25F7B2;
	Wed,  9 Apr 2025 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaW8AaeG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0052561CC;
	Wed,  9 Apr 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205342; cv=none; b=hw8NGdObODfSsODDSQiM3Rsb5RGpbOxtKbM6UrPG/1DbDqhISJhFUrNxeWcizIZWRO9FmsBePEifRvHfYXyanb3Edehme5TGPhKSE1HWBzoBa/glNZRroSpPIj2S1SNfttJpEhc3++zIJGM2qUGJjj/PZqW3JfiV/l3r7LMnKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205342; c=relaxed/simple;
	bh=Km9/FVRC6jO0f5L6lMq0Nqd/ym5VEVLjWSFCAHLpB/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUAdlBOwHkdNL4pzUV7Ld4A7TvqGJRQP7sMiCjXMNNszYmXGOD39J2jQWAaWqHdjBNWSzyYS5tjiGnmSRFRt2tpCYwlG8jPH5ZLeYpmZEnEPwxVKI/dz9CtueqIw0u/FjiMgiTHwyYe33ldF5tTbBPs27Kae498XMrKcg+t32Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaW8AaeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBC2C4CEE3;
	Wed,  9 Apr 2025 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744205342;
	bh=Km9/FVRC6jO0f5L6lMq0Nqd/ym5VEVLjWSFCAHLpB/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JaW8AaeGbE+zWk56+4oZKbLWDEWr5CDoMzsezn52H5jB1+ZmyvcmVxlX7AaUpoRzD
	 9H49ajkehX5m44qaEY9zQA2csv4ElqHv9DXhIvnBSWTclMAbJVci6hYD5xC5bm/ucH
	 ss6zHFcLZe/eBFir+Moq0F87UgCwRRAqy78tW165dK3Cr7tYZBlOd5z/CQA2MkvMPo
	 7GgfSU38I8tt66CWw9M0p+50F4Zqb/pTsMSSE89GOhGzkIaz6Nt7Lj3CV0b/4zb/T1
	 /9y8txxqMmzKMi1IpWjD+bsCziskEXiYSDnvXtXuZ2RNGov53zt5MRlqfZ/ulSCw58
	 p/oKcvHYry7JQ==
Message-ID: <e40c4f92-cc4f-49d2-9d7f-e2d88aeba873@kernel.org>
Date: Wed, 9 Apr 2025 15:28:55 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 2/2] net: sched: generalize check for no-op
 qdisc
To: Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, edumazet@google.com
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com
References: <174412623473.3702169.4235683143719614624.stgit@firesoul>
 <174412628464.3702169.81132659219041209.stgit@firesoul>
 <1ad134d3-4173-4d43-b2ad-0b2c5165bbc1@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <1ad134d3-4173-4d43-b2ad-0b2c5165bbc1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/04/2025 17.47, Eric Dumazet wrote:
> 
> On 4/8/25 5:31 PM, Jesper Dangaard Brouer wrote:
>> Several drivers (e.g., veth, vrf) contain open-coded checks to determine
>> whether a TX queue has a real qdisc attached - typically by testing if
>> qdisc->enqueue is non-NULL.
>>
>> These checks are functionally equivalent to comparing the queue's qdisc
>> pointer against &noop_qdisc (qdisc named "noqueue"). This equivalence
>> stems from noqueue_init(), which explicitly clears the enqueue pointer
>> for the "noqueue" qdisc. As a result, __dev_queue_xmit() treats the qdisc
>> as a no-op only when enqueue == NULL.
>>
>> This patch introduces a common helper, qdisc_txq_is_noop() to standardize
>> this check. The helper is added in sch_generic.h and replaces open-coded
>> logic in both the veth and vrf drivers.
>>
>> This is a non-functional change.
>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   drivers/net/veth.c        |   14 +-------------
>>   drivers/net/vrf.c         |    3 +--
>>   include/net/sch_generic.h |    7 ++++++-
>>   3 files changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index f29a0db2ba36..83c7758534da 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -341,18 +341,6 @@ static bool veth_skb_is_eligible_for_gro(const 
>> struct net_device *dev,
>>            rcv->features & (NETIF_F_GRO_FRAGLIST | NETIF_F_GRO_UDP_FWD));
>>   }
>> -/* Does specific txq have a real qdisc attached? - see noqueue_init() */
>> -static inline bool txq_has_qdisc(struct netdev_queue *txq)
>> -{
>> -    struct Qdisc *q;
>> -
>> -    q = rcu_dereference(txq->qdisc);
>> -    if (q->enqueue)
>> -        return true;
>> -    else
>> -        return false;
>> -}
>> -
>>   static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device 
>> *dev)
>>   {
>>       struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>> @@ -399,7 +387,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, 
>> struct net_device *dev)
>>            */
>>           txq = netdev_get_tx_queue(dev, rxq);
>> -        if (!txq_has_qdisc(txq)) {
>> +        if (qdisc_txq_is_noop(txq)) {
>>               dev_kfree_skb_any(skb);
>>               goto drop;
>>           }
>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>> index 7168b33adadb..d4fe36c55f29 100644
>> --- a/drivers/net/vrf.c
>> +++ b/drivers/net/vrf.c
>> @@ -349,9 +349,8 @@ static bool qdisc_tx_is_default(const struct 
>> net_device *dev)
>>           return false;
>>       txq = netdev_get_tx_queue(dev, 0);
>> -    qdisc = rcu_access_pointer(txq->qdisc);
>> -    return !qdisc->enqueue;
>> +    return qdisc_txq_is_noop(txq);
>>   }
>>   /* Local traffic destined to local address. Reinsert the packet to rx
>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> index d48c657191cd..eb90d5103371 100644
>> --- a/include/net/sch_generic.h
>> +++ b/include/net/sch_generic.h
>> @@ -803,6 +803,11 @@ static inline bool qdisc_tx_changing(const struct 
>> net_device *dev)
>>       return false;
>>   }
>> +static inline bool qdisc_txq_is_noop(const struct netdev_queue *txq)
>> +{
>> +    return (rcu_access_pointer(txq->qdisc) == &noop_qdisc);
> 
> 
> return (expression);
> 
> ->
> 
> return expression;
> 
> 
> return rcu_access_pointer(txq->qdisc) == &noop_qdisc;

Will fix in next iteration.

> I also feel this patch should come first in the series ?
> 

To me it looks/feels wrong doing this before there are two users.
With only the vrf driver, the changed looked unnecessary.
The diff stats looks/feels wrong, when it's patch-1.

As I have to respin anyhow, I will let you decide.
Please let me know, if you prefer this to be patch-1 ?

--Jesper


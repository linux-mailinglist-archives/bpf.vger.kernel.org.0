Return-Path: <bpf+bounces-73068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D814BC21DAB
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 20:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D00188AA4B
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D96E350D60;
	Thu, 30 Oct 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNIzBf2d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7827B2FC030;
	Thu, 30 Oct 2025 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851185; cv=none; b=tvRVqC4ynUIrQ6pAPG9HQ2V8dvlosVWNj+lxtg67ccK/Xp3RMCRH9npsYCTFrpIZCSC1tX4t+0A0VKnck3LnlI18QenFe2Izzw5nI99IL/IiPAE2EjnObCcwNd+hsw63bQlZWCzOCzmEEvySm1zd2r+908PBptmXMe1HEWMzTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851185; c=relaxed/simple;
	bh=v8FQqTUg+Nt8i5VWhtx46IW0ZcboKKiKlIr0lZaJEXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzbT+bLBqiyVfXHZSN7WZT/jUQ5BWZAeAo+812wih0KkvNVdEWDZuQehhJoidfliY4WGeTOsA3DLk1LDGoyKgDj1J2obF+vm/ltr8aevu9D4dxAQyY4fm4nJXNhQwZDa6LYbrrqbaWR0wyw47f8rw728WTKz3XRRWOr5KSd4igI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNIzBf2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B77C4CEFD;
	Thu, 30 Oct 2025 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761851185;
	bh=v8FQqTUg+Nt8i5VWhtx46IW0ZcboKKiKlIr0lZaJEXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QNIzBf2df2ob42+FAYkoqWOQD/8Ooxsw5WCOeMfJ00wfguWLLixv/Bk00HOdROVYL
	 XUEV1G1rPGsHNo94hBYIit4p0J8FpztL4NMNo8X4LXytOeCWV5KVCjkN4YHU4k1nGN
	 7YmLfaDBwdszUJ5mNmhnQyUKZHJlwotnBGawdPE5qvD0K1nz/rjR1wZzTM96WWZIgM
	 V/L8JcolF1ZqvyZ8joehI73SqE+t/YhP0R7ov0dxLFkMbmlMkvflMLpLtxdyQUFgyh
	 eaEJxFqcUuryG51oJA5fhuoDzEGseEjyTxcIWzXn923ZFQYjXziFWOmhBuTMiX52IY
	 BUlu5FKZEL4mA==
Message-ID: <e3abd249-f348-4504-b1d9-4b5cd3df5822@kernel.org>
Date: Thu, 30 Oct 2025 20:06:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Toshiaki Makita <toshiaki.makita1@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com,
 netdev@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553930.5396.4492315010562655785.stgit@firesoul>
 <aacc9c56-bea9-44eb-90fd-726d41b418dd@gmail.com>
 <27e74aeb-89f5-4547-8ecc-232570e2644c@kernel.org>
 <4aa74767-082c-4407-8677-70508eb53a5d@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <4aa74767-082c-4407-8677-70508eb53a5d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29/10/2025 16.00, Toshiaki Makita wrote:
> On 2025/10/29 19:33, Jesper Dangaard Brouer wrote:
>> On 28/10/2025 15.56, Toshiaki Makita wrote:
>>> On 2025/10/28 5:05, Jesper Dangaard Brouer wrote:
>>>> (3) Finally, the NAPI completion check in veth_poll() is updated. If 
>>>> NAPI is
>>>> about to complete (napi_complete_done), it now also checks if the 
>>>> peer TXQ
>>>> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
>>>> reschedule itself. This prevents a new race where the producer stops 
>>>> the
>>>> queue just as the consumer is finishing its poll, ensuring the 
>>>> wakeup is not missed.
>>> ...
>>>
>>>> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, 
>>>> int budget)
>>>>       if (done < budget && napi_complete_done(napi, done)) {
>>>>           /* Write rx_notify_masked before reading ptr_ring */
>>>>           smp_store_mb(rq->rx_notify_masked, false);
>>>> -        if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
>>>> +        if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
>>>> +                 (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
>>>
>>> Not sure if this is necessary.
>>
>> How sure are you that this isn't necessary?
>>
>>>  From commitlog, your intention seems to be making sure to wake up 
>>> the queue,
>>> but you wake up the queue immediately after this hunk in the same 
>>> function,
>>> so isn't it guaranteed without scheduling another napi?
>>>
>>
>> The above code catches the case, where the ptr_ring is empty and the
>> tx_queue is stopped.  It feels wrong not to reach in this case, but you
>> *might* be right that it isn't strictly necessary, because below code
>> will also call netif_tx_wake_queue() which *should* have a SKB stored
>> that will *indirectly* trigger a restart of the NAPI.
> 
> I'm a bit confused.
> Wrt (3), what you want is waking up the queue, right?
> Or, what you want is actually NAPI reschedule itself?

I want NAPI to reschedule itself, the queue it woken up later close to
the exit of the function.  Maybe it is unnecessary to for NAPI to
reschedule itself here... and that is what you are objecting to?

> My understanding was the former (wake up the queue).
> If it's correct, (3) seems not necessary because you have already woken 
> up the queue in the same function.
> 
> First NAPI
>   veth_poll()
>     // ptr_ring_empty() and queue_stopped()
>    __napi_schedule() ... schedule second NAPI
>    netif_tx_wake_queue() ... wake up the queue if queue_stopped()
> 
> Second NAPI
>   veth_poll()
>    netif_tx_wake_queue() ... this is what you want,
>                              but the queue has been woken up in the 
> first NAPI
>                              What's the point?
> 

So, yes I agree that there is a potential for restarting NAPI one time
too many.  But only *potential* because if NAPI is already/still running
then the producer will not actually start NAPI.

I guess this is a kind of optimization, to avoid the time it takes to
restart NAPI. When we see that TXQ is stopped and ptr_ring is empty,
then we know that a packet will be sitting in the qdisc requeue queue,
and netif_tx_wake_queue() will very soon fill "produce" a packet into
ptr_ring (via calling ndo_start_xmit/veth_xmit).

As this is a fixes patch I can drop this optimization. It seems both
Paolo and you thinks this isn't necessary.

--Jesper


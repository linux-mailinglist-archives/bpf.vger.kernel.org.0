Return-Path: <bpf+bounces-73662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A7C369FA
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 17:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117121A41765
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADA3333440;
	Wed,  5 Nov 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhPg/B8V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E326CE0F;
	Wed,  5 Nov 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358090; cv=none; b=ZkDspg96n13dGYvDezgf41bSwQnYuj59Woht+zIp1YRQAC0f+8rX06W3xhfzNLf44DKQmRTQ27tpgBmRACq970KANL2TnBwJ+U3SE1Qh9Hinf/PEoRSRR3y5d/m+JfjM6XDbPaUkOwZnQ9lPdP3Abw4v1UZNWRG/IEderjlMVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358090; c=relaxed/simple;
	bh=bDmEE2pN81Z2g2YR6bc8i2bpngqkwZUwaRFhJlKpZyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yi0hFwUeJjDsMIRyinHLQi4ZABzGcb1qRQbtaGpIH8wxS2ETZr4PdC8wfaTOzLRTPiYS2BQnJ8QHrpxXsHLxgpnyyIabeneL9l9Bz2JZrxzp77HdxcHHFDXtNa484gnlnbAdJC08Or1K+OmPa8PxTAdFDv4vsh8JVaqzJWqpac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhPg/B8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193C3C4CEF5;
	Wed,  5 Nov 2025 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762358090;
	bh=bDmEE2pN81Z2g2YR6bc8i2bpngqkwZUwaRFhJlKpZyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AhPg/B8VjNxHnaY9m3hnZIhVsfN/3ger3hDaKJ9juGhQPT7Q31FIKz1GfEfLm9lBa
	 wrAPYeNff06W8A4sFdAO2lNwEpLpU2ajxjJ9dUcwuY7m+SscGOKuC5fdhsbPghxw74
	 zSGTeyl4KBT41Udl3hjxU4mDyLdsKUAgFuNDFVCS8iiV9ISY9HTyt6CmPEaFPFnZGx
	 QAon7Q7JSmhdpin7RYleSsDcCrNAmrM8ZAI8nmv/Z8dDncdspGea3eRv71ydSLjWyK
	 0NxQojLJ76Y7QBH+SFUUgf3k5GPK/BjpWc7DYQ28wGu7ZTgORMYRsfITRpaiAuNk/F
	 eweO4CzhLS7Ug==
Message-ID: <11b93504-c0a1-4a2a-9061-034e92f84bb4@kernel.org>
Date: Wed, 5 Nov 2025 16:54:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 ihor.solodrai@linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553930.5396.4492315010562655785.stgit@firesoul>
 <154ebe12-6e3c-4b16-9f55-e10a30f5c989@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <154ebe12-6e3c-4b16-9f55-e10a30f5c989@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/10/2025 13.28, Paolo Abeni wrote:
> On 10/27/25 9:05 PM, Jesper Dangaard Brouer wrote:
>> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
>> about to complete (napi_complete_done), it now also checks if the peer TXQ
>> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
>> reschedule itself. This prevents a new race where the producer stops the
>> queue just as the consumer is finishing its poll, ensuring the wakeup is not
>> missed.
> 
> [...]
> 
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
> 
> Double checking I'm read the code correctly. The above is supposed to
> trigger when something alike the following happens
> 
> [producer]				[consumer]
> 					veth_poll()
> 					[ring empty]
> veth_xmit
>    veth_forward_skb
>    [NETDEV_TX_BUSY]		
> 					napi_complete_done()
> 					
>    netif_tx_stop_queue
>    __veth_xdp_flush()
>    rq->rx_notify_masked == true
> 					WRITE_ONCE(rq->rx_notify_masked,
> 						   false);
> 
> ?
> 
> I think the above can't happen, the producer should need to fill the
> whole ring in-between the ring check and napi_complete_done().

The race I can see is slightly different.  It is centered around the
consumer manage to empty the ring after [NETDEV_TX_BUSY].
We have 256 packets in queue and I observe NAPI packet processing time
of 7.64 usec on a given ARM64 metal. This means it takes 1956 usec or
1.96 ms to empty the queue (which is the time needed for the race to
occur in below during "(something interrupts)").

It would look like this:

  [producer]			[consumer]
				veth_poll() - already running
  veth_xmit
   veth_forward_skb
   [ring full]
   [NETDEV_TX_BUSY]
   (something interrupts)
				veth_poll()
				manage to [empty ring]
				napi_complete_done()
   netif_tx_stop_queue
   __veth_xdp_flush()
    - No effect of flush as:
    - rq->rx_notify_masked == true
				WRITE_ONCE(rq->rx_notify_masked, false)
				[empty ring] don't restart NAPI
				Observe netif_tx_queue_stopped == true


Notice: at end (the consumer) do observe netif_tx_queue_stopped is true.
This is leveraged in the patch by moving the netif_tx_queue_stopped
check to the end of veth_poll(). This now happens after rx_notify_masked
is changed to false, which is the race fix.

Other cases where veth_poll() stop NAPI and exits, is recovered by
__veth_xdp_flush() in producer.

--Jesper



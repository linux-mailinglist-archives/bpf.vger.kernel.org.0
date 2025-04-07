Return-Path: <bpf+bounces-55398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D757A7DDF5
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2FBE7A2CD8
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA7248896;
	Mon,  7 Apr 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBXkHIqn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40908F5A;
	Mon,  7 Apr 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029763; cv=none; b=e8Ag9GDFss+29ki5m/9Gfxy8on28p/6V7oU8YLdl1InuepDHLp8TOrKns0/kG6PCMPKDYalSrXztI56XCT/4j3jSXsNGB+xDHV1M4Jaa+CWANM4EBoxAvxC+cE2LdkhQ2syYdPqzze9YxjZXHtd4X+13qpmzK4oE54wxsvq1tZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029763; c=relaxed/simple;
	bh=ZEqSqfTVwx6g78qMbC8XHcLkPQv0COK6D+JuKLHvpvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpI8wwEOLhfEOwZYgsPKAHHQA2doJ6Wb1LG8VqeKB2BxacBMmon4HhDOV3Fnh3ODYeqi2tieQxHvyMFcSD+nRTKlLi6YjFr6IdX7SHPbq7QCK9aNHItjrJenTVG2mq0puTeHfvZDJJAOHAxBtjDwlsiNYhc27slHnGQgpdXU6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBXkHIqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DBFC4CEE7;
	Mon,  7 Apr 2025 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744029763;
	bh=ZEqSqfTVwx6g78qMbC8XHcLkPQv0COK6D+JuKLHvpvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FBXkHIqnyrB9PRMGn6D2VOUtRvkl1Lhg6q3MHN3zIAWxJEOi7Jvulh+DQEaFAnjKf
	 xn4giljXufYa1QL1EXR5pnFa6TmftwYXqsT2ewTKH2JO+XRt3Rh6HTLqkJdNOiFkqs
	 5eLsZoJLWnCLG9LaQnz1ywy+U6uqrylt90lVDjduRNMBNl8nCAXoSA/6pTRyRJfbRi
	 O926lCSfBOjS86Z/QrAGjJdnsK5j8hQ5S6qPN/TQqIuPYvsoyurjOxykaa555DL56+
	 oqto2gQNYRR1zecrUKsR430Llf+LybUFUVXaL802X2D/1uCcw8oU869BwlRBmAxVqx
	 c4OS2p+i9r82g==
Message-ID: <7e67776b-84d7-4976-8a97-82473cd63b06@kernel.org>
Date: Mon, 7 Apr 2025 14:42:37 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@cloudflare.com, makita.toshiaki@lab.ntt.co.jp,
 Yan Zhai <yan@cloudflare.com>, Jesse Brandeburg
 <jbrandeburg@cloudflare.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <174377814192.3376479.16481605648460889310.stgit@firesoul>
 <87a58sxrhn.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87a58sxrhn.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/04/2025 11.15, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
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
> 
> Right, I definitely agree that this is the right solution; having no
> backpressure and a fixed-size ringbuffer is obviously not ideal.
> 
>> Backpressure is only enabled when a qdisc is attached. Without a qdisc,
>> the driver retains its original behavior - dropping packets immediately
>> when the ring is full. This avoids unexpected behavior changes in setups
>> without a configured qdisc.
> 
> Not sure I like this bit, though; see below.
> 

I agree, but the reason for being chicken here is my prod deployment plan.
I'm about to roll this change out to production, and it is practical
that we can do a roll-back based on removing the qdisc.

In the future, we (netdev community) should consider changing veth to
automatically get the default qdisc attached, when enabling NAPI mode.
I will propose this when I have more data from production.

The ptr_ring overflow case is very easy to reproduce, even on testlab
servers without any competing traffic.
Together with Yan (Cc) we/I have a reproducer script available here:

 
https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_setup01_NAPI_TX_drops.sh


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
>> constraint - the bottleneck is CPU availability and the scheduler's ability
>> to run the NAPI thread. It is unclear how effective BQL would be in this
>> context.
> 
> So the BQL algorithm tries to tune the maximum number of outstanding
> bytes to be ~twice the maximum that can be completed in one batch. Since
> we're not really limited by bytes in the same sense here (as you point
> out), an approximate equivalent would be the NAPI budget, I guess? I.e.,
> as a first approximation, we could have veth stop the queue once the
> ringbuffer has 2x the NAPI budget packets in it?
> 

I like the idea. (Note: The current ptr_ring size is 256.)

To implement this, we could simply reduce the ptr_ring size to 128 
(2*64), right?
IMHO would be cooler to have a larger queue, but dynamically stop it
once the ringbuffer has 2x the NAPI budget. but...

There are two subtle issue with the ptr_ring (Cc MST). (So, perhaps we
need choose another ring buffer API for veth?)

(1) We don't have a counter for how many elements are in the queue.
Most hardware drivers tried to stop the TXQ *before* their ring buffer
runs full, such that it avoids returning NETDEV_TX_BUSY.
(This is why it is hard to implement BQL for veth.)

(2) ptr_ring consumer delays making the slots available to the producer,
to avoiding bouncing cache-lines, in the ring-full case.  Thus, we
cannot make ptr_ring too small.  And I'm unsure how this interacts with
the idea of having two NAPI budgets available.


>> This patch serves as a first step toward addressing TX drops. Future work
>> may explore adapting a BQL-like mechanism to better suit virtual devices
>> like veth.
>>
>> Reported-by: Yan Zhai <yan@cloudflare.com>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> [...]
> 
>> +/* Does specific txq have a real qdisc attached? - see noqueue_init() */
>> +static inline bool txq_has_qdisc(struct netdev_queue *txq)
>> +{
>> +	struct Qdisc *q;
>> +
>> +	q = rcu_dereference(txq->qdisc);
>> +	if (q->enqueue)
>> +		return true;
>> +	else
>> +		return false;
>> +}
> 
> This seems like a pretty ugly layering violation, inspecting the qdisc
> like this in the driver?
> 

I agree. (as minimum it should be moved to include/net/sch_generic.h.)

I did considered using qdisc_tx_is_noop() defined in
include/net/sch_generic.h, but IMHO it is too slow for data-(fast)path
code as it walks all the TXQs.

(more below)

> AFAICT, __dev_queue_xmit() turns a stopped queue into drops anyway, but
> emits a warning (looks like this, around line 4640 in dev.c):
> 
> 			net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
> 					     dev->name);
> 
> As this patch shows, it can clearly be appropriate for a virtual device
> to stop the queue even if there's no qdisc, so how about we just get rid
> of that warning? Then this logic won't be needed at all in the driver..
> 

Yes, the real reason for the layer violation is to avoid this warning in
_dev_queue_xmit().

The NETDEV_TX_BUSY is (correctly) converted into a drop, when the
net_device TXQ doesn't have a qdisc attached.   Thus, we don't need the
driver layer violation, if we can remove this warning.

Does anyone object to removing this net_crit_ratelimited?

--Jesper


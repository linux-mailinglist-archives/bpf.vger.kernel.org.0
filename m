Return-Path: <bpf+bounces-76106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F0DCA7BD2
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 14:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC25D3034100
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E36332EC3;
	Fri,  5 Dec 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y34QAvM/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56D3148C8;
	Fri,  5 Dec 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940917; cv=none; b=bQVUYxL/PwxWwAO15pdexr+AI10d3bR5ycJ4JLNLh8v60jcru8pAzBCy+f2S+yAkFK6oFcZxj09q5wN1gITvoKGLrRQNk4FAHXX9wuFt2QvfVz2ijlowhq/jv5FgJvoTzcaBLTP59iCZyWHc5Z9BilmNGd9HAO4bRZQAheW47KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940917; c=relaxed/simple;
	bh=F4G2ALAFTX74mjT8Mnsa8PAikqRo6bnZ3MjRvVzVAl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMl6MUsNm1mxVCrsSMsdePGSl4ydL4CdxbdPnxVuZIiOjT4RNodhx1m44fPxePDeUiINyK7U8VbbBjyVNjEQ8eG3tS/mJtHPg1PsPuQiqA46bT8Nmh8WlCT+nSA7LGCh/3Z1hqF2XRUL/bzmN8UDt27NBG5gyj6iYkYzICnr9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y34QAvM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A750AC4CEF1;
	Fri,  5 Dec 2025 13:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764940917;
	bh=F4G2ALAFTX74mjT8Mnsa8PAikqRo6bnZ3MjRvVzVAl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y34QAvM/tsXlzuWqm3qmgnj1otltWMGL79GebBkGGC09sd4uI7u3e/Gn80pIovhn7
	 KEMRLwPbsCpG9zotiBi2hf/jTPOsLIkaBWjtrq6lsTXzy8lprHvbedfz9aIp7SXubP
	 FHAEtQA0BWxNO+1dgS9DkyNd/A9cTLYaka1eHi1HiY9ZMja68/s77lEARhTPQHtHhK
	 xujE+fT2VV2apQk++1cFY/YRdh+uTlyCTmIuX1W5dnf9b+cmsw3H0elBgH0Q4bgKlP
	 0tBewWgx9/X1L0cHVGu7no9quXDSxhDPfjqlYaMawbgp/XnMWlAGC39y8D8Vg7kGBJ
	 NT9zVxMzEwpXg==
Message-ID: <3c1dac33-424f-4eda-83a9-60fb7f4b6c52@kernel.org>
Date: Fri, 5 Dec 2025 14:21:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 open list <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
 <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
 <20251203084708.FKvfWWxW@linutronix.de>
 <CA37D267-2A2F-47FD-8BAF-184891FE1B7E@nutanix.com>
 <20251205075805.vW4ShQvN@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251205075805.vW4ShQvN@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/12/2025 08.58, Sebastian Andrzej Siewior wrote:
> On 2025-12-03 15:35:24 [+0000], Jon Kohler wrote:
>> Thanks, Sebastian - so if I’m reading this correct, it *is* fine to do
>> the two following patterns, outside of NAPI:
>>
>>     local_bh_disable();
>>     skb = napi_build_skb(buf, len);
>>     local_bh_enable();
>>
>>     local_bh_disable();
>>     napi_consume_skb(skb, 1);
>>     local_bh_enable();
>>
>> If so, I wonder if it would be cleaner to have something like
>>     build_skb_bh(buf, len);
>>
>>     consume_skb_bh(skb, 1);
>>
>> Then have those methods handle the local_bh enable/disable, so that
>> the toggle was a property of a call, not a requirement of the call?
> 
> Having budget = 0 would be for non-NAPI users. So passing the 1 is
> superfluous. You goal seems to be to re-use napi_alloc_cache. Right? And
> this is better than skb_pool?
> 
> There is already napi_alloc_skb() which expects BH to be disabled and
> netdev_alloc_skb() (and friends) which do disable BH if needed. I don't
> see an equivalent for non-NAPI users. Haven't checked if any of these
> could replace your napi_build_skb().
> 
> Historically non-NAPI users would be IRQ users and those can't do
> local_bh_disable(). Therefore there is dev_kfree_skb_irq_reason() for
> them. You need to delay the free for two reasons.
> It seems pure software implementations didn't bother so far.
> 
> It might make sense to do napi_consume_skb() similar to
> __netdev_alloc_skb() so that also budget=0 users fill the pool if this
> is really a benefit.

I'm not convinced that this "optimization" will be an actual benefit on
a busy system.  Let me explain the side-effect of local_bh_enable().

Calling local_bh_enable() is adding a re-scheduling opportunity, e.g.
for processing softirq.  For a benchmark this might not be noticeable as
this is the main workload.  If there isn't any pending softirq this is
also not noticeable.  In a more mixed workload (or packet storm) this
re-scheduling will allow others to "steal" CPU cycles from you.

Thus, you might not actually save any cycles via this short BH-disable
section.  I remember that I was saving around 19ns / 68cycles on a
3.6GHz E5-1650 CPU, by using this SKB recycle cache.  The cost of a re-
scheduling event is like more.

My advice is to use the napi_* function when already running within a
  BH-disabled section, as it makes sense to save those cycles
(essentially reducing the time spend with BH-disabled).  Wrapping these
napi_* function with BH-disabled just to use them outside NAPI feels
wrong in so many ways.

The another reason why these napi_* functions belongs with NAPI is that
netstack NIC drivers will (almost) always do TX completion first, that
will free/consume some SKBs, and afterwards do RX processing that need
to allocate SKBs for the incoming data frames.  Thus, keeping a cache of
SKBs just released/consumed makes sense.  (p.s. in the past we always
bulk free'ed all SKBs in the napi cache when exiting NAPI, as they would
not be cache hot for next round).

--Jesper


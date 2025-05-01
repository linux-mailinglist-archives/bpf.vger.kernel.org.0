Return-Path: <bpf+bounces-57127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9355BAA5F9B
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 16:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8980160C15
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 14:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ABA1AB6F1;
	Thu,  1 May 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZKyVb3m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B6125D6;
	Thu,  1 May 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746108229; cv=none; b=FPmqSATbkTKD/iUgVRZsMp+m8oe9ec9zNYPESewqywTci8fJWIG904HYTZFVn/nif3mOZP6hwa4h9cwnBmQkQf2wrO7CTU0hx3vWS2ZyQa2WV4v8c2HoJzLnopAZg+CSXe6l9mYdOZZy9BJboIxxBefZr92HDS62tuFr/Owueww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746108229; c=relaxed/simple;
	bh=ASqMs7e2Y/Mk5kJgBINzZHrrIIkGdIRr7KIE6MVNo6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=km2triISzV2yVsCj4WtrebkIg1RNC2iwiHI+x7F9FPbO8tjI2Pfu122CT+Sg4fkHtjBclN1KBa7TASXrfMyVC8ztkRuZc6wBJh5Vj0TgFT3W8aQhNiRbtGF41uP1lrUkpoU4WFQswxtWs1Fyk4EPjvTyNBobm/f8Ujs7nrGAPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZKyVb3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414CCC4CEE3;
	Thu,  1 May 2025 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746108228;
	bh=ASqMs7e2Y/Mk5kJgBINzZHrrIIkGdIRr7KIE6MVNo6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fZKyVb3m9lH+GgDRYSV91DEVZMm2zgUmE1XtIoDqCW+AS/3l9IStOm+DVyNlDGmmk
	 p1G4ObcOWMowIeuwt2cMld2BeWp0a3OlhZLEwo3SorvsluR7/q0EcsgwC0SO3iDbKv
	 2t6TxB+pjaub2qqisPMGB9HW09gTFFU2e3WdPomCEcw50DV9JvJ+53z3U4IVywMZNn
	 Ig97hiKeSTebrl4pUZyO4CcuP1hY07bqd2RQ9NXR/SPSqZIdTlFfEdWOuHydm2tcPh
	 yGBqMfk7Ilh3Hp30tAYdLiRb1mJDG5GqcXFDrmatzmbOrmfzC9y9n5HAb4WA4fv6mu
	 uzQZmS+om1WrQ==
Message-ID: <1c96bbf3-0edd-40f1-91a2-db7800a47f0d@kernel.org>
Date: Thu, 1 May 2025 16:03:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for packet
 metadata
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Arthur Fabre <arthur@arthurfabre.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Yan Zhai <yan@cloudflare.com>, jbrandeburg@cloudflare.com,
 lbiancon@redhat.com, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 kernel-team@cloudflare.com
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
 <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
 <D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
 <CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
 <87frhqnh0e.fsf@toke.dk> <87ikmle9t4.fsf@cloudflare.com>
 <875xik7gsk.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <875xik7gsk.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/05/2025 12.43, Toke Høiland-Jørgensen wrote:
> Jakub Sitnicki <jakub@cloudflare.com> writes:
> 
>> On Wed, Apr 30, 2025 at 11:19 AM +02, Toke Høiland-Jørgensen wrote:
>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>>
>>>> On Fri, Apr 25, 2025 at 12:27 PM Arthur Fabre <arthur@arthurfabre.com> wrote:
>>>>>
>>>>> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
>>>>>> On Tue, Apr 22, 2025 at 6:23 AM Arthur Fabre <arthur@arthurfabre.com> wrote:
>>
>> [...]
>>
>>>>> * Hardware metadata: metadata exposed from NICs (like the receive
>>>>>    timestamp, 4 tuple hash...) is currently only exposed to XDP programs
>>>>>    (via kfuncs).
>>>>>    But that doesn't expose them to the rest of the stack.
>>>>>    Storing them in traits would allow XDP, other BPF programs, and the
>>>>>    kernel to access and modify them (for example to into account
>>>>>    decapsulating a packet).
>>>>
>>>> Sure. If traits == existing metadata bpf prog in xdp can communicate
>>>> with bpf prog in skb layer via that "trait" format.
>>>> xdp can take tuple hash and store it as key==0 in the trait.
>>>> The kernel doesn't need to know how to parse that format.
>>>
>>> Yes it does, to propagate it to the skb later. I.e.,
>>>
>>> XDP prog on NIC: get HW hash, store in traits, redirect to CPUMAP
>>> CPUMAP: build skb, read hash from traits, populate skb hash
>>>
>>> Same thing for (at least) timestamps and checksums.
>>>
>>> Longer term, with traits available we could move more skb fields into
>>> traits to make struct sk_buff smaller (by moving optional fields to
>>> traits that don't take up any space if they're not set).

Above paragraph is very significant IMHO.  Netstack have many fields in
the SKB that are only used in corner cases.  There is a huge opportunity
for making these fields optional, without taking a performance hit (via
SKB extensions). To me the traits area is simply a new dynamic struct
type available for the *kernel*.

INCEPTION: Giving NIC drivers a writable memory area before SKB
allocation opens up the possibility of avoiding SKB allocation in the
driver entirely. Hardware offload metadata can be written directly into
the traits area. Later, when the core netstack allocates the SKB, it can
extract this data from traits.

The performance implications here are significant: this effectively
brings XDP-style pre-SKB processing into the netstack core. The largest
benefits are likely to appear in packet forwarding workloads, where
avoiding early SKB allocation can yield substantial gains.


>>
>> Perhaps we can have the cake and eat it too.
>>
>> We could leave the traits encoding/decoding out of the kernel and, at
>> the same time, *expose it* to the network stack through BPF struct_ops
>> programs. At a high level, for example ->get_rx_hash(), not the
>> individual K/V access. The traits_ops vtable could grow as needed to
>> support new use cases.
>>
>> If you think about it, it's not so different from BPF-powered congestion
>> algorithms and scheduler extensions. They also expose some state, kept in
>> maps, that only the loaded BPF code knows how to operate on.
> 
> Right, the difference being that the kernel works perfectly well without
> an eBPF congestion control algorithm loaded because it has its own
> internal implementation that is used by default.

Good point.

> Having a hard dependency on BPF for in-kernel functionality is a
> different matter, and limits the cases it can be used for.

I agree.

> Besides, I don't really see the point of leaving the encoding out of the
> kernel? We keep the encoding kernel-internal anyway, and just expose a
> get/set API, so there's no constraint on changing it later (that's kinda
> the whole point of doing that). And with bulk get/set there's not an
> efficiency argument either. So what's the point, other than doing things
> in BPF for its own sake?

I agree - we should keep the traits encoding kernel-internal. The traits
area is best understood as a dynamic struct type available to the kernel.

We shouldn't expose the traits format as UAPI to BPF on day one. It's
likely we'll need to adjust key/value sizing or representation as new
use cases arise. BPF programs can still access traits via a get/set API,
like other consumers. Later on, we could consider translating BPF kfunc
calls into inline BPF instructions (when extending BPF with features
like the popcnt instruction).

--Jesper


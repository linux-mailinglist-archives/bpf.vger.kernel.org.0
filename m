Return-Path: <bpf+bounces-16327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E0C7FFC9D
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 21:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329F51C2121B
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 20:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9377059144;
	Thu, 30 Nov 2023 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maO0WLRr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F95674E;
	Thu, 30 Nov 2023 20:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CA8C433C8;
	Thu, 30 Nov 2023 20:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701376507;
	bh=TMbxkVXhSMNls7arGzXSGdcXn5cA3ZdLWLsa3WgMvsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=maO0WLRrf6UG7/RQiYC1WqanCdVjCwlFVybtsufUe13lzOPxLM7bflV0XP65Ryv09
	 Ox1WXDYJWLLFehrmtADKcpw2/qI1rU00LW6/u00uRCIc4DQPxS+gbBskTqiWMlg79Y
	 B3fS/o/vKRiUz4TGGjWq2l65adtBOO1cfllh5Myybw4aOlUVBv0wnPDhE9iV0XJ3ev
	 56rdhlSjXqGORxxswNy7kRz33uDTynVSnNUgL04EEEWMp2ymVCe3VYIkBgWqeJK5E7
	 DWBNTrbDfIEb6MXFdFxDQwU5EyfL4Bm/UWiOOcCYkY/XQZzcKsrOiz1Ge0Ks5aSmvX
	 qYHEJvxvNMsGw==
Message-ID: <e3402045-a36f-461f-8eab-bbc51735492d@kernel.org>
Date: Thu, 30 Nov 2023 21:35:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Edward Cree <ecree.xilinx@gmail.com>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, kernel-team
 <kernel-team@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
 <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net> <87fs0qj61x.fsf@toke.dk>
 <0b0c6538-92a5-3041-bc48-d7286f1b873b@gmail.com> <87plzsi5wj.fsf@toke.dk>
 <1ff5c528-79a8-fbb7-8083-668ca5086ecf@iogearbox.net> <871qc72vmh.fsf@toke.dk>
 <8677db3e-5662-7ebe-5af0-e5a3ca60587f@iogearbox.net>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <8677db3e-5662-7ebe-5af0-e5a3ca60587f@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/30/23 17:32, Daniel Borkmann wrote:
> On 11/30/23 2:55 PM, Toke Høiland-Jørgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes
>>> On 11/29/23 10:52 PM, Toke Høiland-Jørgensen wrote:
>>>> Edward Cree <ecree.xilinx@gmail.com> writes:
>>>>> On 28/11/2023 14:39, Toke Høiland-Jørgensen wrote:
>>>>>> I'm not quite sure what should be the semantics of that, though. 
>>>>>> I.e.,
>>>>>> if you are trying to aggregate two packets that have the flag set, 
>>>>>> which
>>>>>> packet do you take the value from? What if only one packet has the 
>>>>>> flag
>>>
>>> It would probably make sense if both packets have it set.
>>
>> Right, so "aggregate only if both packets have the flag set, keeping the
>> metadata area from the first packet", then?
> 
> Yes, sgtm.
> 

Seems like a good default behavior: "keeping the metadata area from the 
first packet".
(Please object if someone sees a issue for their use-case with this 
default.)


>>>>>> set? Or should we instead have a "metadata_xdp_only" flag that just
>>>>>> prevents the skb metadata field from being set entirely?
>>>
>>> What would be the use case compared to resetting meta data right before
>>> we return with XDP_PASS?
>>
>> I was thinking it could save a call to xdp_adjust_meta() to reset it
>> back to zero before PASSing the packet. But okay, that may be of
>> marginal utility.
> 
> Agree, feels too marginal.
>

I should explain our use-case(s) a bit more.
We do want the information to survive XDP_PASS into the SKB.
Its the hole point, as we want to transfer information from XDP layer to
TC-layer and perhaps further all the way to BPF socket filters (I even
heard someone asked for).

I'm trying to get an overview, as I now have multiple product teams that
want to store information across/into differ layer, and they have other
teams that consume this information.

We are exploring more options than only XDP metadata area to store
information.  I have suggested that once an SKB have a socket
associated, then we can switch into using BPF local socket storage
tricks. (The lifetime of XDP metadata is not 100% clear as e.g.
pskb_expand_head clears it via skb_metadata_clear).
All ideas are welcome, e.g. I'm also looking at ability to store
auxiliary/metadata data associated with a dst_entry. And SKB->mark is
already used for other use-cases and isn't big enough. (and then there
is fun crossing a netns boundry).

Let me explain *one* of the concrete use-cases.  As described in [1],
the CF XDP L4 load-balancer Unimog have been extended to a product
called Plurimog that does load-balancing across data-centers "colo's".
When Plurimog redirects to another colo, the original "landing" colo's
ID is carried across (in some encap header) to a Unimog instance.  Thus,
the original landing Colo ID is known to Unimog running in another colo,
but that header is popped, so this info need to be transferred somehow.
I'm told that even the webserver/Nginx need to know the orig/foreign
landing colo ID (here there should be socket associated). For TCP SYN
packets, the layered DOS protecting also need to know foreign landing
colo ID. Other teams/products needs this for accounting, e.g. Traffic
Manager[1], Radar[2] and Capacity planning.


  [1] https://blog.cloudflare.com/meet-traffic-manager/
  [2] https://radar.cloudflare.com/



>>>>> Sounds like what's actually needed is bpf progs inside the GRO engine
>>>>>    to implement the metadata "protocol" prepare and coalesce 
>>>>> callbacks?
>>>>
>>>> Hmm, yes, I guess that would be the most general solution :)
>>>
>>> Feels like a potential good fit, agree, although for just solving the
>>> above sth not requiring extra BPF might be nice as well.
>>
>> Yeah, I agree that just the flag makes sense on its own.

I've mentioned before (e.g. at NetConf) I would really like to see BPF
progs inside the GRO engine, but that is a larger project on its own.
I think it is worth doing eventually, but I likely need a solution to
unblock the "tracing"/debugging use-case, where someone added a
timestamp to XDP metadata and discovered GRO was not working.

I guess, we can do the Plurimog use-case now, as it should be stable for
packets belonging to the same (GRO) flow.

--Jesper


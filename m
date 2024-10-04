Return-Path: <bpf+bounces-40930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30CA990179
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 12:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E371F22CC2
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B348155C8A;
	Fri,  4 Oct 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqf5FRMQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98891369BB;
	Fri,  4 Oct 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038314; cv=none; b=dy3EBXM/n+K2IB566NCyunsWW/rjh86o2o+7Xy1goausI+RLEjgkopWx3IQqqidDZISeXC+Hvdj9ez3G5z9cl+7tUcVgPKGew3szjzWl8t96KoHGaqNZCYGiL3a1XMlG2VA0/mEYuh4If9dHMqcsZ52BOkIXsn9kZMG0xpFoV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038314; c=relaxed/simple;
	bh=4NhyK6ur41OWwYFgCUliG9il2Pu9u7J+H4trUY9V6SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUtV27AJ2uBarECqy77c5anBCs+R7wJupBBj3m4GvsLiDZrU40JjWWwgmYphJF16Hhrt7EJvCfxGqqPMkZpaUHnnOZ9+k9cyAd+6MDTCpfWjxkyOnVwGaGbLjHjLlYreWB1v1mssmUkw5Dz0bamI3F0jQPo6jtmy5aUlPa8QlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqf5FRMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F82C4CECC;
	Fri,  4 Oct 2024 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728038314;
	bh=4NhyK6ur41OWwYFgCUliG9il2Pu9u7J+H4trUY9V6SY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qqf5FRMQd0WX9FX8ShYhKEglsBlhWlvyeW1DMwZVuy/ezCMWNx0Gn+NLvjRfRY0Ad
	 BJ/uUuP4YKV6+Ofua6XlNWfDoyNyTgu054GHOaEwZlusXlESj7MtdztvBSU76eSpRc
	 Z2CWXiKK8qvTSaHq0zVHrNmZ77xR4uY3yqQlU6Ue5gEqwfs/bb53njuqgEt1Vho0Lc
	 tkDfubUQm35EnNgkIkdOutAKmd3rckNYa9/LTiE6Vde8OL1k3f2xT9bA2/XRMaSkO3
	 aKU5mA4KbR6H3hTVonXdC8xTz1wKUJ8D44ulnkVtGrKSbkbhbJKz8NsjBPwpoNDWJK
	 XUpjtjZhYGxVg==
Message-ID: <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
Date: Fri, 4 Oct 2024 12:38:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
To: Daniel Xu <dxu@dxuuu.xyz>, Stanislav Fomichev <stfomichev@gmail.com>
Cc: Arthur Fabre <afabre@cloudflare.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, john.fastabend@gmail.com,
 edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me, tariqt@nvidia.com,
 saeedm@nvidia.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, mst@redhat.com, jasowang@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 kernel-team <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
References: <871q11s91e.fsf@toke.dk> <ZvqQOpqnK9hBmXNn@lore-desk>
 <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby> <ZvwNQqN4gez1Ksfn@lore-desk>
 <87zfnnq2hs.fsf@toke.dk> <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk> <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby> <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/10/2024 04.13, Daniel Xu wrote:
> On Thu, Oct 03, 2024 at 01:26:08PM GMT, Stanislav Fomichev wrote:
>> On 10/03, Arthur Fabre wrote:
>>> On Thu Oct 3, 2024 at 12:49 AM CEST, Stanislav Fomichev wrote:
>>>> On 10/02, Toke Høiland-Jørgensen wrote:
>>>>> Stanislav Fomichev <stfomichev@gmail.com> writes:
>>>>>
>>>>>> On 10/01, Toke Høiland-Jørgensen wrote:
>>>>>>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>>>>>>
>>>>>>>>> On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
>>>>>>>>>>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>>>>>>>>>>
[...]
>>>>>>>>>>>>
>>>>>>>>>>>> I like this 'fast' KV approach but I guess we should really evaluate its
>>>>>>>>>>>> impact on performances (especially for xdp) since, based on the kfunc calls
>>>>>>>>>>>> order in the ebpf program, we can have one or multiple memmove/memcpy for
>>>>>>>>>>>> each packet, right?
>>>>>>>>>>>
>>>>>>>>>>> Yes, with Arthur's scheme, performance will be ordering dependent. Using

I really like the *compact* Key-Value (KV) store idea from Arthur.
  - The question is it is fast enough?

I've promised Arthur to XDP micro-benchmark this, if he codes this up to
be usable in the XDP code path.  Listening to the LPC recording I heard
that Alexei also saw potential and other use-case for this kind of
fast-and-compact KV approach.

I have high hopes for the performance, as Arthur uses POPCNT instruction
which is *very* fast[1]. I checked[2] AMD Zen 3 and 4 have Ops/Latency=1
and Reciprocal throughput 0.25.

  [1] https://www.agner.org/optimize/blog/read.php?i=853#848
  [2] https://www.agner.org/optimize/instruction_tables.pdf

[...]
>>> There are two different use-cases for the metadata:
>>>
>>> * "Hardware" metadata (like the hash, rx_timestamp...). There are only a
>>>    few well known fields, and only XDP can access them to set them as
>>>    metadata, so storing them in a struct somewhere could make sense.
>>>
>>> * Arbitrary metadata used by services. Eg a TC filter could set a field
>>>    describing which service a packet is for, and that could be reused for
>>>    iptables, routing, socket dispatch...
>>>    Similarly we could set a "packet_id" field that uniquely identifies a
>>>    packet so we can trace it throughout the network stack (through
>>>    clones, encap, decap, userspace services...).
>>>    The skb->mark, but with more room, and better support for sharing it.
>>>
>>> We can only know the layout ahead of time for the first one. And they're
>>> similar enough in their requirements (need to be stored somewhere in the
>>> SKB, have a way of retrieving each one individually, that it seems to
>>> make sense to use a common API).
>>
>> Why not have the following layout then?
>>
>> +---------------+-------------------+----------------------------------------+------+
>> | more headroom | user-defined meta | hw-meta (potentially fixed skb format) | data |
>> +---------------+-------------------+----------------------------------------+------+
>>                  ^                                                            ^
>>              data_meta                                                      data
>>
>> You obviously still have a problem of communicating the layout if you
>> have some redirects in between, but you, in theory still have this
>> problem with user-defined metadata anyway (unless I'm missing
>> something).
>>

Hmm, I think you are missing something... As far as I'm concerned we are
discussing placing the KV data after the xdp_frame, and not in the XDP
data_meta area (as your drawing suggests).  The xdp_frame is stored at
the very top of the headroom.  Lorenzo's patchset is extending struct
xdp_frame and now we are discussing to we can make a more flexible API
for extending this. I understand that Toke confirmed this here [3].  Let
me know if I missed something :-)

  [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/

As part of designing this flexible API, we/Toke are trying hard not to
tie this to a specific data area.  This is a good API design, keeping it
flexible enough that we can move things around should the need arise.

I don't think it is viable to store this KV data in XDP data_meta area,
because existing BPF-prog's already have direct memory (write) access
and can change size of area, which creates too much headache with
(existing) BPF-progs creating unintentional breakage for the KV store,
which would then need extensive checks to handle random corruptions
(slowing down KV-store code).

--Jesper


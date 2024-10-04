Return-Path: <bpf+bounces-40941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01999905BB
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B0285339
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD72141D3;
	Fri,  4 Oct 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpcoFps6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3B212EEA;
	Fri,  4 Oct 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051283; cv=none; b=XNXuIoPKKDLGFd/rzhF6YX4+2kWAO42yOXsHr1ny+QLWNmlK4RW8UbYDncOEnsWuctW66Uw2DLfJJySfhQLtMg4p6nVxiYwIYa9U0kJJxlDqASEdVpo1LPYjkZEO5a+QT2NYLDx6Ch5r+J828NXBDlkCyQ8VZeWKooUY2KAo2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051283; c=relaxed/simple;
	bh=a0FW3Un9oocR9lC9J0t0H1CeCWGgStzo+JYKJIbrt5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/Yrv4K8dcsCBjSE4DSFbD6nGNT8m3B3k6G2fIZccraYBgC16s1JBlKvviU4sEDcFQYnMzajiRpqU/SNn7TNCH1LDTGWg1PhVzbU+tqvBF3C3dHsOgfxLR8qPTvyVv9noCo6HJEVo/tz0k+h+psXsnz0sfhuzkGFfWsWz/JDZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpcoFps6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77342C4CEC6;
	Fri,  4 Oct 2024 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728051282;
	bh=a0FW3Un9oocR9lC9J0t0H1CeCWGgStzo+JYKJIbrt5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cpcoFps6/hDg0PoAmKcH01HCVor4KZ63LJwLDfaewkNIY89u6Gw8LQ9s9hbZ3c8vs
	 GOPXzoUGqf4iTEZ1Cnw7dhnfG+HA0xqqZ73RYE2Vw6nJiOSX3d0FmHbSBwMhjX796F
	 Mf/PdG7lc2pEJ8ebH3CAf2vx2yss1aIUpK08x0vcwdXNgwrmt4GHwu2AJqa3OJCo9D
	 qnmS1ycP3OgbEyaYyCIMZ7twcfA7KHMgOJ+hPFuwXbgCCuUqOLqc5w+JqIvG9C9Eri
	 qlc/8eJVjt/7ftVZnbeiFGhdELG4FqWpHJFg98w+aw+aePBYE4EJkHJsI34HvgAQLW
	 kR6j16Vo+yOyA==
Message-ID: <75fb1dd3-fe14-426c-bc59-9a582c4b0e8d@kernel.org>
Date: Fri, 4 Oct 2024 16:14:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
To: Arthur Fabre <afabre@cloudflare.com>, Daniel Xu <dxu@dxuuu.xyz>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
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
 <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
 <D4N2N1YKKI54.1WAGONIYZH0Y4@bobby>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <D4N2N1YKKI54.1WAGONIYZH0Y4@bobby>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/10/2024 15.55, Arthur Fabre wrote:
> On Fri Oct 4, 2024 at 12:38 PM CEST, Jesper Dangaard Brouer wrote:
>> [...]
>>>>> There are two different use-cases for the metadata:
>>>>>
>>>>> * "Hardware" metadata (like the hash, rx_timestamp...). There are only a
>>>>>     few well known fields, and only XDP can access them to set them as
>>>>>     metadata, so storing them in a struct somewhere could make sense.
>>>>>
>>>>> * Arbitrary metadata used by services. Eg a TC filter could set a field
>>>>>     describing which service a packet is for, and that could be reused for
>>>>>     iptables, routing, socket dispatch...
>>>>>     Similarly we could set a "packet_id" field that uniquely identifies a
>>>>>     packet so we can trace it throughout the network stack (through
>>>>>     clones, encap, decap, userspace services...).
>>>>>     The skb->mark, but with more room, and better support for sharing it.
>>>>>
>>>>> We can only know the layout ahead of time for the first one. And they're
>>>>> similar enough in their requirements (need to be stored somewhere in the
>>>>> SKB, have a way of retrieving each one individually, that it seems to
>>>>> make sense to use a common API).
>>>>
>>>> Why not have the following layout then?
>>>>
>>>> +---------------+-------------------+----------------------------------------+------+
>>>> | more headroom | user-defined meta | hw-meta (potentially fixed skb format) | data |
>>>> +---------------+-------------------+----------------------------------------+------+
>>>>                   ^                                                            ^
>>>>               data_meta                                                      data
>>>>
>>>> You obviously still have a problem of communicating the layout if you
>>>> have some redirects in between, but you, in theory still have this
>>>> problem with user-defined metadata anyway (unless I'm missing
>>>> something).
>>>>
>>
>> Hmm, I think you are missing something... As far as I'm concerned we are
>> discussing placing the KV data after the xdp_frame, and not in the XDP
>> data_meta area (as your drawing suggests).  The xdp_frame is stored at
>> the very top of the headroom.  Lorenzo's patchset is extending struct
>> xdp_frame and now we are discussing to we can make a more flexible API
>> for extending this. I understand that Toke confirmed this here [3].  Let
>> me know if I missed something :-)
>>
>>    [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/
>>
>> As part of designing this flexible API, we/Toke are trying hard not to
>> tie this to a specific data area.  This is a good API design, keeping it
>> flexible enough that we can move things around should the need arise.
> 
> +1. And if we have an API for doing this for user-defined metadata, it
> seems like we might as well use it for hardware metadata too.
> 
> With something roughly like:
> 
>      *val get(id)
> 
>      set(id, *val)
> 
> with pre-defined ids for hardware metadata, consumers don't need to know
> the layout, or where / how the data is stored.
> 
> Under the hood we can implement it however we want, and change it in the
> future.
> 
> I was initially thinking we could store hardware metadata the same way
> as user defined metadata, but Toke and Lorenzo seem to prefer storing it
> in a fixed struct.

If the API hide the actual location then we can always move things
around, later.  If your popcnt approach is fast enough, then IMO we
don't need a fixed struct for hardware metadata.

--Jesper


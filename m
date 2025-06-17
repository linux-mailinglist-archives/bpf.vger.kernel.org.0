Return-Path: <bpf+bounces-60818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC0ADD069
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A21016EBCD
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E0221FC8;
	Tue, 17 Jun 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEv04ID9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059CC20E31B;
	Tue, 17 Jun 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171645; cv=none; b=WwUSiIp+y93XRjY8CMuI1i42CcrGNt/GFuvOaO6WnaDUGMCGlQIKYQrNtnznSooFe+R3XJ+eQ4MiXiO5R0+K0VV6N9rD9FwhVDezNJvR64pGVq5bwHcTSizvHrt3eT8Nx0kymQobOZjVpVN7hCAS7qzl/Pk2ERyhzUZ2ZfIvUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171645; c=relaxed/simple;
	bh=EP3AmJUQi/Br2LcUuN8Nq94JPv31ghb621rcoWf0hIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odMdSi/0Gd6FGetuHZp9seMpmPN/qASqlQd36odYHqMAbP7/OELBMsTivnWN2GNKCg8IgfvaRhxxjxclRO+h57Pu9bHzO9HS0mZm/rC+4EOuxWVZQ5Au5dV8CSAa6+veRzb3tBlEH21PfLLdalk7uVIUUH6QZWO7Q0XzA8kasZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEv04ID9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD72C4CEE3;
	Tue, 17 Jun 2025 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750171644;
	bh=EP3AmJUQi/Br2LcUuN8Nq94JPv31ghb621rcoWf0hIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WEv04ID9wkfnkrVqihSRMZAN6avZJmFK00rfBo4S/QayA5t8uJLFYENxCDrDlXCXH
	 l0bBy2iZ4W5Qz8EGMdO/Yig4rU/MP0VlO4BseDmgpCKJHgYyoiiBvJveJb58LIez1c
	 j/Dt9GQf1QzHbUIuoA5uQNBxYcQCJs6iWqYbNsUNDZtyZu1JEmapwoZ/ZjldYXupNE
	 Jh4amdsTGEe8KF/dn5D3UfrxYU8YciAdgTT9cbtrtL5YOqxe3c/wvojbhnxKyxAEwi
	 RleXRekeIMzoTkK+o4m4J+3Wk7WP/oBOveztYFcFhp3/j7Yvv6e5nEtNFj1kPbfZuY
	 L/dVXxNinG07w==
Message-ID: <76a5330e-dc52-41ea-89c2-ddcde4b414bd@kernel.org>
Date: Tue, 17 Jun 2025 16:47:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <borkmann@iogearbox.net>, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net> <87plfbcq4m.fsf@toke.dk>
 <aEixEV-nZxb1yjyk@lore-rh-laptop> <aEj6nqH85uBe2IlW@mini-arch>
 <aFAQJKQ5wM-htTWN@lore-desk> <aFA8BzkbzHDQgDVD@mini-arch>
 <aFBI6msJQn4-LZsH@lore-desk> <87h60e4meo.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87h60e4meo.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/06/2025 13.50, Toke Høiland-Jørgensen wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> 
>>> On 06/16, Lorenzo Bianconi wrote:
>>>> On Jun 10, Stanislav Fomichev wrote:
>>>>> On 06/11, Lorenzo Bianconi wrote:
>>>>>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>>>>>
>>>>>> [...]
>>>>>>>>>
>>>>>>>>> Why not have a new flag for bpf_redirect that transparently stores all
>>>>>>>>> available metadata? If you care only about the redirect -> skb case.
>>>>>>>>> Might give us more wiggle room in the future to make it work with
>>>>>>>>> traits.
>>>>>>>>
>>>>>>>> Also q from my side: If I understand the proposal correctly, in order to fully
>>>>>>>> populate an skb at some point, you have to call all the bpf_xdp_metadata_* kfuncs
>>>>>>>> to collect the data from the driver descriptors (indirect call), and then yet
>>>>>>>> again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data in struct
>>>>>>>> xdp_rx_meta again. This seems rather costly and once you add more kfuncs with
>>>>>>>> meta data aren't you better off switching to tc(x) directly so the driver can
>>>>>>>> do all this natively? :/
>>>>>>>
>>>>>>> I agree that the "one kfunc per metadata item" scales poorly. IIRC, the
>>>>>>> hope was (back when we added the initial HW metadata support) that we
>>>>>>> would be able to inline them to avoid the function call overhead.
>>>>>>>
>>>>>>> That being said, even with half a dozen function calls, that's still a
>>>>>>> lot less overhead from going all the way to TC(x). The goal of the use
>>>>>>> case here is to do as little work as possible on the CPU that initially
>>>>>>> receives the packet, instead moving the network stack processing (and
>>>>>>> skb allocation) to a different CPU with cpumap.
>>>>>>>
>>>>>>> So even if the *total* amount of work being done is a bit higher because
>>>>>>> of the kfunc overhead, that can still be beneficial because it's split
>>>>>>> between two (or more) CPUs.
>>>>>>>
>>>>>>> I'm sure Jesper has some concrete benchmarks for this lying around
>>>>>>> somewhere, hopefully he can share those :)
>>>>>>
>>>>>> Another possible approach would be to have some utility functions (not kfuncs)
>>>>>> used to 'store' the hw metadata in the xdp_frame that are executed in each
>>>>>> driver codebase before performing XDP_REDIRECT. The downside of this approach
>>>>>> is we need to parse the hw metadata twice if the eBPF program that is bounded
>>>>>> to the NIC is consuming these info. What do you think?
>>>>>
>>>>> That's the option I was asking about. I'm assuming we should be able
>>>>> to reuse existing xmo metadata callbacks for this. We should be able
>>>>> to hide it from the drivers also hopefully.
>>>>
>>>> If we move the hw metadata 'store' operations to the driver codebase (running
>>>> xmo metadata callbacks before performing XDP_REDIRECT), we will parse the hw
>>>> metadata twice if we attach to the NIC an AF_XDP program consuming the hw
>>>> metadata, right? One parsing is done by the AF_XDP hw metadata kfunc, and the
>>>> second one would be performed by the native driver codebase.
>>>
>>> The native driver codebase will parse the hw metadata only if the
>>> bpf_redirect set some flag, so unless I'm missing something, there
>>> should not be double parsing. (but it's all user controlled, so doesn't
>>> sound like a problem?)
>>
>> I do not have a strong opinion about it, I guess it is fine, but I am not
>> 100% sure if it fits in Jesper's use case.
>> @Jesper: any input on it?
> 
> FWIW, one of the selling points of XDP is (IMO) that it allows you to
> basically override any processing the stack does. I think this should
> apply to hardware metadata as well (for instance, if the HW metadata
> indicates that a packet is TCP, and XDP performs encapsulation before
> PASSing it, the metadata should be overridden to reflect this).

I fully agree :-)

> So if the driver populates these fields natively, I think this should
> either happen before the XDP program is run (so it can be overridden),
> or it should check if the XDP program already set the values and leave
> them be if so. Both of those obviously incur overhead; not sure which
> would be more expensive, though...
> 

Yes, if the XDP BPF-prog choose to override a field, then it's value
should "win". As I explained in [0], this is our first main production
use-case.  To override the RX-hash with the tunnel inner-headers.

  [0] 
https://lore.kernel.org/all/ca38f2ed-999f-4ce1-8035-8ee9247f27f2@kernel.org/

Later we will look at using the vlan tag. Today we have disabled HW
vlan-offloading, because XDP originally didn't support accessing HW vlan
tags.  Next hurdle for us is our usage of tail-calls, which cannot
access the HW RX-metadata via the "get" kfuncs.  Not part of this
patchset, but we have considered if someone calls the "store" kfunc, if
tail-calls invoking the "get" kfunc could return the stored value
(even-though it is not device bound).

The last field is the HW timestamp, which we also don't currently use.
Notice that this patchset stores the timestamp in skb_shared_info area.
Storing in this area will likely cause a cache-miss. Thus, "if the
driver populates these fields natively" and automatically then it will
be a performance concern.

For now, I just need to override the RX-hash and have this survive to
CPUMAP (+veth).  Adding some flag that stores all three HW metadata
natively in the driver is something that we can add later IMHO.

--Jesper




Return-Path: <bpf+bounces-60827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD6ADD62C
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 18:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E895A0729
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5B22E8DE1;
	Tue, 17 Jun 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvlNmAsV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CB2E8DE7;
	Tue, 17 Jun 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176941; cv=none; b=n7RfJrRrkTKa+p9OGpp6lXp8YCPNtLbn3k8Qm18hu75x2H03nj2NtG0AEXlkZGYyeJbD33gFL8T8kBLjYHgcaUiIkFkVf8zJvU0GAoGx5z6Pz7N6Jh2TJcjGdVj2xLKEWYkj11J/5FAM3NvG9RwFc5vSahSxaM9IAsuqPrvJhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176941; c=relaxed/simple;
	bh=eTJA3M+r9FzFmCsCGg0wA/hZcR8eO+gyr9ekfhT2wKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aToyFcMl0oHCQNdpJ49UXy087K70WKS/Rv1MUFqnNou9nQQGYNsY0qG2z2M0sWi2TZGhzV7p5yQedyESY4K4xyfhhDkzs+Ls36hVOeNW4A4QuhwUtR9HO20fLMT8R1bLBQMrGqmvtnhlJorzQJKO80iXn2oNNsWycoMJsCD/Al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvlNmAsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983D1C4CEE3;
	Tue, 17 Jun 2025 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176940;
	bh=eTJA3M+r9FzFmCsCGg0wA/hZcR8eO+gyr9ekfhT2wKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gvlNmAsV3grAMl60+4PsyLWDgf0rtuUHR5QQyg/yuPBJ1Vw/7G90JLCvGCYeQog0j
	 J2/PgW/u4in9zvftBbOlVxxxDi5bwzd6fwg1SdWdRnWVs/ttb38shjte2GjDJ0IUoF
	 FTPN11m2ciQaYlxjGT/zwzJKk0vAwKPapNa2XYxwF2rHDPcZsnleTRk9IHA8GgoRBL
	 xrQki2I1A48QBALASeqk9WHUY7Z7F4zujqQZG1JHvPDbfiNqIxVGD3kNh/AE2zxqsX
	 3FvCiIU/89lQCexKTMBfSt75wHdUV70FMHyPtSUeMgYoWA2dCXR/Nm4hF7YurnjA9/
	 hpkZ3twuJfimg==
Message-ID: <1221e418-a9b8-41e8-a940-4e7a25288fe0@kernel.org>
Date: Tue, 17 Jun 2025 18:15:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <borkmann@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, arzeznik@cloudflare.com,
 Yan Zhai <yan@cloudflare.com>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net> <87plfbcq4m.fsf@toke.dk>
 <aEixEV-nZxb1yjyk@lore-rh-laptop> <aEj6nqH85uBe2IlW@mini-arch>
 <ca38f2ed-999f-4ce1-8035-8ee9247f27f2@kernel.org>
 <aFA5hxzOkxVMB_eZ@mini-arch>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <aFA5hxzOkxVMB_eZ@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2025 17.34, Stanislav Fomichev wrote:
> On 06/13, Jesper Dangaard Brouer wrote:
>>
>> On 11/06/2025 05.40, Stanislav Fomichev wrote:
>>> On 06/11, Lorenzo Bianconi wrote:
>>>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>>>
>>>> [...]
>>>>>>>
>>>>>>> Why not have a new flag for bpf_redirect that transparently stores all
>>>>>>> available metadata? If you care only about the redirect -> skb case.
>>>>>>> Might give us more wiggle room in the future to make it work with
>>>>>>> traits.
>>>>>>
>>>>>> Also q from my side: If I understand the proposal correctly, in order to fully
>>>>>> populate an skb at some point, you have to call all the bpf_xdp_metadata_* kfuncs
>>>>>> to collect the data from the driver descriptors (indirect call), and then yet
>>>>>> again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data in struct
>>>>>> xdp_rx_meta again. This seems rather costly and once you add more kfuncs with
>>>>>> meta data aren't you better off switching to tc(x) directly so the driver can
>>>>>> do all this natively? :/
>>>>>
>>>>> I agree that the "one kfunc per metadata item" scales poorly. IIRC, the
>>>>> hope was (back when we added the initial HW metadata support) that we
>>>>> would be able to inline them to avoid the function call overhead.
>>>>>
>>>>> That being said, even with half a dozen function calls, that's still a
>>>>> lot less overhead from going all the way to TC(x). The goal of the use
>>>>> case here is to do as little work as possible on the CPU that initially
>>>>> receives the packet, instead moving the network stack processing (and
>>>>> skb allocation) to a different CPU with cpumap.
>>>>>
>>>>> So even if the *total* amount of work being done is a bit higher because
>>>>> of the kfunc overhead, that can still be beneficial because it's split
>>>>> between two (or more) CPUs.
>>>>>
>>>>> I'm sure Jesper has some concrete benchmarks for this lying around
>>>>> somewhere, hopefully he can share those :)
>>>>
>>>> Another possible approach would be to have some utility functions (not kfuncs)
>>>> used to 'store' the hw metadata in the xdp_frame that are executed in each
>>>> driver codebase before performing XDP_REDIRECT. The downside of this approach
>>>> is we need to parse the hw metadata twice if the eBPF program that is bounded
>>>> to the NIC is consuming these info. What do you think?
>>>
>>> That's the option I was asking about. I'm assuming we should be able
>>> to reuse existing xmo metadata callbacks for this. We should be able
>>> to hide it from the drivers also hopefully.
>>
>> I'm not against this idea of transparently stores all available metadata
>> into the xdp_frame (via some flag/config), but it does not fit our
>> production use-case.  I also think that this can be added later.
>>
>> We need the ability to overwrite the RX-hash value, before redirecting
>> packet to CPUMAP (remember as cover-letter describe RX-hash needed
>> *before* the GRO engine processes the packet in CPUMAP. This is before
>> TC/BPF).
> 
> Make sense. Can we make GRO not flush a bucket for same_flow=0 instead?
> This will also make it work better for other regular tunneled traffic.
> Setting hash in BPF to make GRO go fast seems too implementation specific :-(

I feel misunderstood here.  This was a GRO side-note to remind reviewers
that netstack expect that RX-hash isn't zero at napi_gro_receive().
This is not a make GRO faster, but a lets comply with netstack.

The important BPF optimization is the part that you forgot to quote in
the reply, so let me reproduce what I wrote below.  TL;DR: RX-hash
needed to be the tunnel inner-headers else outer-headers SW hash calc
will land everything on same veth RX-queue.

On 13/06/2025 12.59, Jesper Dangaard Brouer wrote:
 >
>> Our use-case for overwriting the RX-hash value is load-balancing
>> IPSEC encapsulated tunnel traffic at XDP stage via CPUMAP redirects.
>> This is generally applicable to tunneling in that we want the store
>> the RX-hash of the tunnels inner-headers.  Our IPSEC use-case have a
>> variation that we only decrypt[1] the first 32 bytes to calc a LB
>> hash over inner-headers, and then redirect the original packet to
>> CPUMAP.  The IPSEC packets travel into a veth device, which we
>> discovered will send everything on a single RX-queue... because
>> RX-hash (calc by netstack) will obviously use the outer-headers,
>> meaning this LB doesn't scale. >>
>> I hope this makes it clear, why we need BPF-prog ability to
>> explicitly "store" the RX-hash in the xdp-frame.


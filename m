Return-Path: <bpf+bounces-63602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F7FB08DE0
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CE0188B020
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F092D77E9;
	Thu, 17 Jul 2025 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Roreyz6l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B172063E7;
	Thu, 17 Jul 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757737; cv=none; b=APj0LdmA0i6IrRrJQlSZmgQIROHWTqwdxmuI9GKBtsAmKU33Ke12DEgz0wA3DdqPC3Dtn3n5Uvjjgom2IXq922+sq2igy8G7kSeeI1FTGW4ntK0dDqrejRlyzvr3+QeOtTM0aJrtySGHz0HQOKpBSJrnz8FduwmvSmMRc99xW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757737; c=relaxed/simple;
	bh=Gxdr3RZXteWorE0Y2DFq5UsYlM8TYBwQDD2qhb2K7q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1rxk8vqf62pmH6JYnBkoVjT3MDHg4uMRqr+4tr2kg+vgR7KKim/hMA9p16zA423rKINyRwqdjDgqZzx81osfbC/3BJKegO3aRfzQDYqkyv3b6PvRq2qCi3a3RD+l+SlkXwYLEYgQ4XSwGaDLmaHJNzDd2k11AB6rwMZIO6LqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Roreyz6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFDBC4CEE3;
	Thu, 17 Jul 2025 13:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752757735;
	bh=Gxdr3RZXteWorE0Y2DFq5UsYlM8TYBwQDD2qhb2K7q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Roreyz6l6LFUeMrm8RCdb5RnOBvxEudhN7Xa+JoGReCxC+FX1N2jcQ9z7IDwIazyT
	 +F6yKOG8MKX5baGpAi0ynF1llNZLhig/xtp/vKidJQcTB+h+J+omKqN4TX+Jio2gBq
	 70SPGTN+CAcfVZ7FjLTnyOwvajwzCJDKQ2ox/XcYK++ou4WRt1523WvqmmIf7rWvy+
	 c+V5BIS409g0ZtSCSkOCDG2ZPUUdRaIvV/XhWnCz8CNl+xTBRgU96ysEmvebVDkYye
	 CLa91tRqavtSNML1T5vUEjSwVwHzRn40YwEdQ5zixaCdw6YlKp12WGPE2haJl1SMR0
	 Z0jSbFONExiSQ==
Message-ID: <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
Date: Thu, 17 Jul 2025 15:08:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
To: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
 <aGVY2MQ18BWOisWa@mini-arch>
 <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
 <aGvcb53APFXR8eJb@mini-arch> <aG427EcHHn9yxaDv@lore-desk>
 <aHE2F1FJlYc37eIz@mini-arch> <aHeKYZY7l2i1xwel@lore-desk>
 <20250716142015.0b309c71@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250716142015.0b309c71@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/07/2025 23.20, Jakub Kicinski wrote:
> On Wed, 16 Jul 2025 13:17:53 +0200 Lorenzo Bianconi wrote:
>>>> I can't see what the non-redirected use-case could be. Can you please provide
>>>> more details?
>>>> Moreover, can it be solved without storing the rx_hash (or the other
>>>> hw-metadata) in a non-driver specific format?
>>>
>>> Having setters feels more generic than narrowly solving only the redirect,
>>> but I don't have a good use-case in mind.
>>>    
>>>> Storing the hw-metadata in some of hw-specific format in xdp_frame will not
>>>> allow to consume them directly building the skb and we will require to decode
>>>> them again. What is the upside/use-case of this approach? (not considering the
>>>> orthogonality with the get method).
>>>
>>> If we add the store kfuncs to regular drivers, the metadata  won't be stored
>>> in the xdp_frame; it will go into the rx descriptors so regular path that
>>> builds skbs will use it.
>>
>> IIUC, the described use-case would be to modify the hw metadata via a
>> 'setter' kfunc executed by an eBPF program bounded to the NIC and to store
>> the new metadata in the DMA descriptor in order to be consumed by the driver
>> codebase building the skb, right?
>> If so:
>> - we can get the same result just storing (running a kfunc) the modified hw
>>    metadata in the xdp_buff struct using a well-known/generic layout and
>>    consume it in the driver codebase (e.g. if the bounded eBPF program
>>    returns XDP_PASS) using a generic xdp utility routine. This part is not in
>>    the current series.
>> - Using this approach we are still not preserving the hw metadata if we pass
>>    the xdp_frame to a remote CPU returning XDP_REDIRCT (we need to add more
>>    code)
>> - I am not completely sure if can always modify the DMA descriptor directly
>>    since it is DMA mapped.

Let me explain why it is a bad idea of writing into the RX descriptors.
The DMA descriptors are allocated as coherent DMA (dma_alloc_coherent).
This is memory that is shared with the NIC hardware device, which
implies cache-line coherence.  NIC performance is tightly coupled to
limiting cache misses for descriptors.  One common trick is to pack more
descriptors into a single cache-line.  Thus, if we start to write into
the current RX-descriptor, then we invalidate that cache-line seen from
the device, and next RX-descriptor (from this cache-line) will be in an
unfortunate coherent state.  Behind the scene this might lead to some
extra PCIe transactions.

By writing to the xdp_frame, we don't have to modify the DMA descriptors
directly and risk invalidating cache lines for the NIC.

>>
>> What do you think?
> 
> FWIW I commented on an earlier revision to similar effect as Stanislav.
> To me the main concern is that we're adding another adhoc scheme, and
> are making xdp_frame grow into a para-skb. We added XDP to make raw
> packet access fast, now we're making drivers convert metadata twice :/

Thanks for the feedback. I can see why you'd be concerned about adding
another adhoc scheme or making xdp_frame grow into a "para-skb".

However, I'd like to frame this as part of a long-term plan we've been
calling the "mini-SKB" concept. This isn't a new idea, but a
continuation of architectural discussions from as far back as [2016].

The long-term goal, described in these presentations from [2018] and
[2019], has always been to evolve the xdp_frame to handle more hardware
offloads, with the ultimate vision of moving SKB allocation out of NIC
drivers entirely. In the future, the netstack could perform L3
forwarding (and L2 bridging) directly on these enhanced xdp_frames
[2019-slide20]. The main blocker for this vision has been the lack of
hardware metadata in the xdp_frame.

This patchset is a small but necessary first step towards that goal. It
focuses on the concrete XDP_REDIRECT use-case where we can immediately
benefit for our production use-case. Storing this metadata in the
xdp_frame is fundamental to the plan. It's no coincidence the fields are
compatible with the SKB; they need to be.

I'm certainly open to debating the bigger picture, but I hope we can
agree that it shouldn't hold up this first step, which solves an
immediate need. Perhaps we can evaluate the merits of this specific
change first, and discuss the overall architecture in parallel?

--Jesper


Links:
------
[2019] XDP closer integration with network stack
  - 
https://people.netfilter.org/hawk/presentations/KernelRecipes2019/xdp-netstack-concert.pdf
  - 
https://github.com/xdp-project/xdp-project/blob/main/conference/KernelRecipes2019/xdp-netstack-concert.org#slide-move-skb-allocations-out-of-nic-drivers
  - [2019-slide20] 
https://github.com/xdp-project/xdp-project/blob/main/conference/KernelRecipes2019/xdp-netstack-concert.org#slide-fun-with-xdp_frame-before-skb-alloc

[2018] LPC Networking Track: XDP - challenges and future work
  - https://people.netfilter.org/hawk/presentations/LinuxPlumbers2018/
  - 
https://github.com/xdp-project/xdp-project/blob/main/conference/LinuxPlumbers2018/presentation-lpc2018-xdp-future.org#topic-moving-skb-allocation-out-of-driver

[2016] Network Performance Workshop
  - 
https://people.netfilter.org/hawk/presentations/NetDev1.2_2016/net_performance_workshop_netdev1.2.pdf


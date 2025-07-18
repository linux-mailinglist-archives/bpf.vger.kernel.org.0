Return-Path: <bpf+bounces-63706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCDCB0A156
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075945A77DC
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB32BE026;
	Fri, 18 Jul 2025 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dja8nQYS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15EF2BDC20;
	Fri, 18 Jul 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836212; cv=none; b=fCn8MplnSEB5h3dda91FNwrffIhJTyJha3PZ6p/EMKptQB0a92THG6NAuezy3jX6lbJccUFU5x8yX+uC1bbyXl6sOVfftM1laS7hsP2WQwcK56Xq7gAujzT7ZXzfttKTAvMaZICBjQ6tn4vBJAL2y+V0LeIOR7h2xj9ulb3ez6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836212; c=relaxed/simple;
	bh=GXGPG/dXUPXi2EQO1KdqRc/RUmrH2/XT1ZYS2PrRhFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nc7sVmnEVZ1r5d1IL3pzj3XaZSoUhK9t1wxrNxGU3OsnSnHAfygMaRBANPjzgyEgWsg4nKzCQw2dgN2Xdsy7KjOa52AzYLejMAniFunVlQdBiSjTkdQKBLImFGeSBD5pzZ+2Ve452uQI4bz4fKRuvROfLGPapVvJCcMMlb7y6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dja8nQYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DB9C4CEEB;
	Fri, 18 Jul 2025 10:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752836212;
	bh=GXGPG/dXUPXi2EQO1KdqRc/RUmrH2/XT1ZYS2PrRhFE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dja8nQYSBSupKitQWWNnqZrNzUZh6rQ6Ns7Mz6j3dOlZJDjNRIUqNXFTTF8AXHFba
	 UKdPImSbYNn+p/cWqD8khhs3nHlgzikLRelQl4L9Zy8A0CHLuNdi+5rkSevbHay7dE
	 gZPZUCx/i8H5hdM9gn9ytZN4Mryom7WkolsDlOeAKHrDjFk2u76eHzs4/Q4R8EmbrK
	 18ZKuBN1y7wxHsG7ERAvV/yGfhzPdAphRyD+wPF9RCZYkf+qvYqH9GDGPIsdzpsGJP
	 R6FZs33unqtB/pOwvUOpcmbTEHLhlNev+0+VEqVfPtBXlBoPY1Anzmh98LB+U1/bBj
	 XKmU9Ge5tSP9w==
Message-ID: <ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
Date: Fri, 18 Jul 2025 12:56:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
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
 <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
 <20250717182534.4f305f8a@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250717182534.4f305f8a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 18/07/2025 03.25, Jakub Kicinski wrote:
> On Thu, 17 Jul 2025 15:08:49 +0200 Jesper Dangaard Brouer wrote:
>> Let me explain why it is a bad idea of writing into the RX descriptors.
>> The DMA descriptors are allocated as coherent DMA (dma_alloc_coherent).
>> This is memory that is shared with the NIC hardware device, which
>> implies cache-line coherence.  NIC performance is tightly coupled to
>> limiting cache misses for descriptors.  One common trick is to pack more
>> descriptors into a single cache-line.  Thus, if we start to write into
>> the current RX-descriptor, then we invalidate that cache-line seen from
>> the device, and next RX-descriptor (from this cache-line) will be in an
>> unfortunate coherent state.  Behind the scene this might lead to some
>> extra PCIe transactions.
>>
>> By writing to the xdp_frame, we don't have to modify the DMA descriptors
>> directly and risk invalidating cache lines for the NIC.
> 
> I thought you main use case is redirected packets. In which case it's
> the _remote_ end that's writing its metadata, if it's veth it's
> obviously not going to be doing it into DMA coherent memory.

My apologies for the confusion. That entire explanation about the
dangers of writing to RX descriptors was a direct response to
Stanislav's earlier proposal (for the XDP_PASS case, I assume).

You are right that this isn't relevant for redirected xdp_frames,
as there is no access to the original RX-descriptor on a remote CPU or
target device like veth.


>> Thanks for the feedback. I can see why you'd be concerned about adding
>> another adhoc scheme or making xdp_frame grow into a "para-skb".
>>
>> However, I'd like to frame this as part of a long-term plan we've been
>> calling the "mini-SKB" concept. This isn't a new idea, but a
>> continuation of architectural discussions from as far back as [2016].
> 
> My understanding is that while this was floated as a plan by some,
> nobody came up with a clean way of implementing it.

I can see why you might think that, but from my perspective, the
xdp_frame *is* the implementation of the mini-SKB concept. We've been
building it incrementally for years. It started as the most minimal
structure possible and has gradually gained more context (e.g. dev_rx,
mem_info/rxq_info, flags, and also uses skb_shared_info with same layout
as SKB).

This patch is simply the next logical step in that existing evolution:
adding hardware metadata to make it more capable, starting with enabling
XDP_REDIRECT offloads. The xdp_frame is our mini-SKB, and this patchset
continues its evolution.

--Jesper


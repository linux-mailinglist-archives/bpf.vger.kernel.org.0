Return-Path: <bpf+bounces-20421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE083E1E9
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 19:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBBF1F29518
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C872231F;
	Fri, 26 Jan 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="lZ/8j10O"
X-Original-To: bpf@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9C1DA24;
	Fri, 26 Jan 2024 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294906; cv=none; b=fmYxhuwdRdRiWLiWML6DjhtyRtIyMwfOsxCDBbcYFlkWtX04e9Xr/99OiZnlFmF+Z+Jm2jUUUuRNrMH3Uf2uu0ufaizFaiGqUVcEgrZPyqtlufMXyE5drLxkATi8W4FjI6f7svFlOJt5dWN5K6v9ONEDtcQHra4xwDAK9m0EIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294906; c=relaxed/simple;
	bh=wnUNn5yxHCVb9FiP1SFelXYi0ONajKNwQyCfVL9ATek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKHEroCAzR7n6ngYgZ04dCuY8lidnsMfjcDAn9NasnAxPGijGm4Ewf+/1KMago92gWVKWymd5KgvKxLuoOAkqIlJEH25Qkzc7S+VgaRzjx/E2jAizGzFQH8UFAwFkZbwbe2SJmszoQn8dUejGUZcNdp0Ztm0akJDMse9O1pR1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=lZ/8j10O; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id C9B2518E2AB;
	Fri, 26 Jan 2024 19:48:20 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706294901; bh=wnUNn5yxHCVb9FiP1SFelXYi0ONajKNwQyCfVL9ATek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lZ/8j10OdMsjKsw2hHbOfIszeiZ1QgSFl52Xs3dQ9zc4NbXZedtviL6xvim7FfU3r
	 uGcj3Wy0wrkTTkFjiJz/6nhrd61KIRCZ9qe0u3UBpGNXLOw6ZSWn7FPUEJlHF784ew
	 GFnbOO6Ehj96nx0wr/eFuCBhZ7mJCMRR4LGoyHmDTIWY6xeyTgcsNhp/uNNAq0/llB
	 VuTlEWAxee4sKfVsd/BIjLME/iyablo2kerVOIZA26t7pBOs/PmIxCsIyAys2dafAj
	 Le3PclwTvOgYFrvIzYU71mVYxnfxQmDFkjQgcHn1WgFzQIDhaa6QDSOs7q0uOPLIp/
	 MM7BdyJ8g0XRw==
Date: Fri, 26 Jan 2024 19:48:19 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Alexander Duyck <alexanderduyck@fb.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] dma: avoid expensive redundant calls for
 sync operations
Message-ID: <20240126194819.147cb4e2@meshulam.tesarici.cz>
In-Reply-To: <0cf72c00-21d9-4f1a-be14-80336da5dff4@arm.com>
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
	<20240126135456.704351-3-aleksander.lobakin@intel.com>
	<0f6f550c-3eee-46dc-8c42-baceaa237610@arm.com>
	<7ff3cf5d-b3ff-4b52-9031-30a1cb71c0c9@intel.com>
	<0cf72c00-21d9-4f1a-be14-80336da5dff4@arm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 17:21:24 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 26/01/2024 4:45 pm, Alexander Lobakin wrote:
> > From: Robin Murphy <robin.murphy@arm.com>
> > Date: Fri, 26 Jan 2024 15:48:54 +0000
> >   
> >> On 26/01/2024 1:54 pm, Alexander Lobakin wrote:  
> >>> From: Eric Dumazet <edumazet@google.com>
> >>>
> >>> Quite often, NIC devices do not need dma_sync operations on x86_64
> >>> at least.
> >>> Indeed, when dev_is_dma_coherent(dev) is true and
> >>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
> >>> and friends do nothing.
> >>>
> >>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
> >>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
> >>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
> >>>
> >>> Add dev->skip_dma_sync boolean which is set during the device
> >>> initialization depending on the setup: dev_is_dma_coherent() for direct
> >>> DMA, !(sync_single_for_device || sync_single_for_cpu) or positive result
> >>> from the new callback, dma_map_ops::can_skip_sync for non-NULL DMA ops.
> >>> Then later, if/when swiotlb is used for the first time, the flag
> >>> is turned off, from swiotlb_tbl_map_single().  
> >>
> >> I think you could probably just promote the dma_uses_io_tlb flag from
> >> SWIOTLB_DYNAMIC to a general SWIOTLB thing to serve this purpose now.  
> > 
> > Nice catch!
> >   
> >>
> >> Similarly I don't think a new op is necessary now that we have
> >> dma_map_ops.flags. A simple static flag to indicate that sync may be> skipped under the same conditions as implied for dma-direct - i.e.
> >> dev_is_dma_coherent(dev) && !dev->dma_use_io_tlb - seems like it ought
> >> to suffice.  
> > 
> > In my initial implementation, I used a new dma_map_ops flag, but then I
> > realized different DMA ops may require or not require syncing under
> > different conditions, not only dev_is_dma_coherent().
> > Or am I wrong and they would always be the same?  
> 
> I think it's safe to assume that, as with P2P support, this will only 
> matter for dma-direct and iommu-dma for the foreseeable future, and 
> those do currently share the same conditions as above. Thus we may as 
> well keep things simple for now, and if anything ever does have cause to 
> change, it can be the future's problem to keep this mechanism working as 
> intended.

Can we have a comment that states this assumption along with the flag?
Because when it breaks, it will keep someone cursing for days why DMA
sometimes fails on their device before they find out it's not synced.
And then wondering why the code makes such silly assumptions...

My two cents
Petr T


Return-Path: <bpf+bounces-22061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798EE8559F1
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 06:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137E11F2A37A
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 05:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E628F68;
	Thu, 15 Feb 2024 05:06:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F09539A;
	Thu, 15 Feb 2024 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707973610; cv=none; b=sRoUKV/pTvcJfLDOmhORDDr03ZI5GuWRIklkE9/COIZu37j7tJO++4BauTt30TAMrMmUxauHpHDOfc4u0mjVHm3XGxcZkfLhouweZOLOFKJ8PyfdgFo3fnyJE4t22zFDrD7xDRPos+NBs5WAtj4QqO3moHFWI+HahtM+4mZThbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707973610; c=relaxed/simple;
	bh=EhSg2QHqNh/t2QONcG+qGuJ0J095P903O68xo1d47Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udiBohXkhwwZAh1uiF0wDJFWBmTJBdPsWGEY6+V1dKGJaIOtazdCMNYnZ84rUY6hd2Hq3xcp3VE1vk5vDHTUOjOaOFAFL4Iuuzen4RfgRGm6VsL19gHCozJMQKdXnH7QBMUbHVQr1kSeRSyYzcQ80TP18RhKGZVv23XpQZoRrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2BDCC67373; Thu, 15 Feb 2024 06:06:43 +0100 (CET)
Date: Thu, 15 Feb 2024 06:06:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/7] dma: compile-out DMA sync op calls
 when not used
Message-ID: <20240215050642.GA4861@lst.de>
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com> <20240214162201.4168778-2-aleksander.lobakin@intel.com> <893ad3a4-ba24-43cf-8200-b8cd7742622d@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893ad3a4-ba24-43cf-8200-b8cd7742622d@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 14, 2024 at 05:20:50PM +0000, Robin Murphy wrote:
>>   +config DMA_NEED_SYNC
>> +	def_bool ARCH_HAS_SYNC_DMA_FOR_DEVICE || ARCH_HAS_SYNC_DMA_FOR_CPU || \
>> +		 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL || DMA_OPS || SWIOTLB
>
> I'm not sure DMA_OPS belongs here - several architectures have non-trivial 
> ops without syncs, e.g. Alpha.

True, but peeking through the ops is a bit hard.  And I don't think it's
worth optimizing the dma sync performance on Alpha :)

>> +static inline void __dma_sync_single_for_cpu(struct device *dev,
>> +		dma_addr_t addr, size_t size, enum dma_data_direction dir)
>
> To me it would feel more logical to put all the wrappers inside the #ifdef 
> CONFIG_HAS_DMA and not touch these stubs at all (what does it mean to skip 
> an inline no-op?). Or in fact, if dma_skip_sync() is constant false for 
> !HAS_DMA, then we could also just make the external function declarations 
> unconditional and remove the stubs. Not a critical matter though, and I 
> defer to whatever Christoph thinks is most maintainable.

Your idea sounds reasonable to me, but I don't have a strong preference.

>> +static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>> +{
>> +	return !dma_skip_sync(dev) ? __dma_need_sync(dev, dma_addr) : false;
>> +}
>
> That's a bit of a mind-bender... is it actually just
>
> 	return !dma_skip_sync(dev) && __dma_need_sync(dev, dma_addr);
>
> ?

That looks a lot more readable for sure.

> (I do still think the negative flag makes it all a little harder to follow 
> in general than a positive "device needs to consider syncs" flag would.)

Probably.



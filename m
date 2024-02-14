Return-Path: <bpf+bounces-22007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B185500D
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F51E1F2AA70
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F08528A;
	Wed, 14 Feb 2024 17:20:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88E839ED;
	Wed, 14 Feb 2024 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931256; cv=none; b=QF3/lu5wFsJl7ZsVBV7lGQa6rk8OYot1Piw+WT4cFMg4x7XuMUCuuIRfzme1r6IPHHdp6j5XDuu/Z/6JZ32MKNhmG+kLyDaHVTR5PuBJtKvmOieYbzCWSMxOEmusHhPtBbqSwlx360dOS3L6/EEgdGKBZvrklgCtnNQRvvgn5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931256; c=relaxed/simple;
	bh=DRFlqUoQ+56jX8SosJW0HOg/C/81XeRHYKQhTNegNK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmiWFU5gOpzYZYF5zo8ir6NnR8WPmhhn32J3RGDjCmmKHmZz8q6gEXgBTmIjFxA7+u5MauL7iUFSl4uQVhqSaUzYCt1kH8SIjJqCWJ1xMfqUSM8NkP2XNnPciHunhWDEoV/3q2cwi0QE1W7lxVvskmGiNNztENSs6485D9QiuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22EF71FB;
	Wed, 14 Feb 2024 09:21:35 -0800 (PST)
Received: from [10.57.47.86] (unknown [10.57.47.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65B743F766;
	Wed, 14 Feb 2024 09:20:51 -0800 (PST)
Message-ID: <893ad3a4-ba24-43cf-8200-b8cd7742622d@arm.com>
Date: Wed, 14 Feb 2024 17:20:50 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/7] dma: compile-out DMA sync op calls when
 not used
Content-Language: en-GB
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
 <20240214162201.4168778-2-aleksander.lobakin@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240214162201.4168778-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-14 4:21 pm, Alexander Lobakin wrote:
> Some platforms do have DMA, but DMA there is always direct and coherent.
> Currently, even on such platforms DMA sync operations are compiled and
> called.
> Add a new hidden Kconfig symbol, DMA_NEED_SYNC, and set it only when
> either sync operations are needed or there is DMA ops or swiotlb
> enabled. Set dma_need_sync() and dma_skip_sync() depending on this
> symbol state and don't call sync ops when dma_skip_sync() is true.
> The change allows for future optimizations of DMA sync calls depending
> on compile-time or runtime conditions.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   kernel/dma/Kconfig          |  4 ++
>   include/linux/dma-mapping.h | 80 +++++++++++++++++++++++++++++++------
>   kernel/dma/mapping.c        | 20 +++++-----
>   3 files changed, 81 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index d62f5957f36b..1c9ff05b1ecb 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -107,6 +107,10 @@ config DMA_BOUNCE_UNALIGNED_KMALLOC
>   	bool
>   	depends on SWIOTLB
>   
> +config DMA_NEED_SYNC
> +	def_bool ARCH_HAS_SYNC_DMA_FOR_DEVICE || ARCH_HAS_SYNC_DMA_FOR_CPU || \
> +		 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL || DMA_OPS || SWIOTLB

I'm not sure DMA_OPS belongs here - several architectures have 
non-trivial ops without syncs, e.g. Alpha.

> +
>   config DMA_RESTRICTED_POOL
>   	bool "DMA Restricted Pool"
>   	depends on OF && OF_RESERVED_MEM && SWIOTLB
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 4a658de44ee9..6c7640441214 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -117,13 +117,13 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs);
>   void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
>   		enum dma_data_direction dir, unsigned long attrs);
> -void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
> +void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
>   		enum dma_data_direction dir);
> -void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
> +void __dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
>   		size_t size, enum dma_data_direction dir);
> -void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
> +void __dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>   		    int nelems, enum dma_data_direction dir);
> -void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
> +void __dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>   		       int nelems, enum dma_data_direction dir);
>   void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		gfp_t flag, unsigned long attrs);
> @@ -147,7 +147,7 @@ u64 dma_get_required_mask(struct device *dev);
>   bool dma_addressing_limited(struct device *dev);
>   size_t dma_max_mapping_size(struct device *dev);
>   size_t dma_opt_mapping_size(struct device *dev);
> -bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
> +bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr);
>   unsigned long dma_get_merge_boundary(struct device *dev);
>   struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
>   		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
> @@ -195,19 +195,19 @@ static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   }
> -static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
> -		size_t size, enum dma_data_direction dir)
> +static inline void __dma_sync_single_for_cpu(struct device *dev,
> +		dma_addr_t addr, size_t size, enum dma_data_direction dir)

To me it would feel more logical to put all the wrappers inside the 
#ifdef CONFIG_HAS_DMA and not touch these stubs at all (what does it 
mean to skip an inline no-op?). Or in fact, if dma_skip_sync() is 
constant false for !HAS_DMA, then we could also just make the external 
function declarations unconditional and remove the stubs. Not a critical 
matter though, and I defer to whatever Christoph thinks is most 
maintainable.

>   {
>   }
> -static inline void dma_sync_single_for_device(struct device *dev,
> +static inline void __dma_sync_single_for_device(struct device *dev,
>   		dma_addr_t addr, size_t size, enum dma_data_direction dir)
>   {
>   }
> -static inline void dma_sync_sg_for_cpu(struct device *dev,
> +static inline void __dma_sync_sg_for_cpu(struct device *dev,
>   		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
>   {
>   }
> -static inline void dma_sync_sg_for_device(struct device *dev,
> +static inline void __dma_sync_sg_for_device(struct device *dev,
>   		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
>   {
>   }
> @@ -277,7 +277,7 @@ static inline size_t dma_opt_mapping_size(struct device *dev)
>   {
>   	return 0;
>   }
> -static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
> +static inline bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>   {
>   	return false;
>   }
> @@ -348,18 +348,72 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
>   	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
>   }
>   
> +static inline void __dma_sync_single_range_for_cpu(struct device *dev,
> +		dma_addr_t addr, unsigned long offset, size_t size,
> +		enum dma_data_direction dir)
> +{
> +	__dma_sync_single_for_cpu(dev, addr + offset, size, dir);
> +}
> +
> +static inline void __dma_sync_single_range_for_device(struct device *dev,
> +		dma_addr_t addr, unsigned long offset, size_t size,
> +		enum dma_data_direction dir)
> +{
> +	__dma_sync_single_for_device(dev, addr + offset, size, dir);
> +}

There is no need to introduce these two.

> +
> +static inline bool dma_skip_sync(const struct device *dev)
> +{
> +	return !IS_ENABLED(CONFIG_DMA_NEED_SYNC);
> +}
> +
> +static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
> +{
> +	return !dma_skip_sync(dev) ? __dma_need_sync(dev, dma_addr) : false;
> +}

That's a bit of a mind-bender... is it actually just

	return !dma_skip_sync(dev) && __dma_need_sync(dev, dma_addr);

?

(I do still think the negative flag makes it all a little harder to 
follow in general than a positive "device needs to consider syncs" flag 
would.)

> +static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
> +		size_t size, enum dma_data_direction dir)
> +{
> +	if (!dma_skip_sync(dev))
> +		__dma_sync_single_for_cpu(dev, addr, size, dir);
> +}
> +
> +static inline void dma_sync_single_for_device(struct device *dev,
> +		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> +{
> +	if (!dma_skip_sync(dev))
> +		__dma_sync_single_for_device(dev, addr, size, dir);
> +}
> +
> +static inline void dma_sync_sg_for_cpu(struct device *dev,
> +		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
> +{
> +	if (!dma_skip_sync(dev))
> +		__dma_sync_sg_for_cpu(dev, sg, nelems, dir);
> +}
> +
> +static inline void dma_sync_sg_for_device(struct device *dev,
> +		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
> +{
> +	if (!dma_skip_sync(dev))
> +		__dma_sync_sg_for_device(dev, sg, nelems, dir);
> +}
> +
>   static inline void dma_sync_single_range_for_cpu(struct device *dev,
>   		dma_addr_t addr, unsigned long offset, size_t size,
>   		enum dma_data_direction dir)
>   {
> -	return dma_sync_single_for_cpu(dev, addr + offset, size, dir);
> +	if (!dma_skip_sync(dev))
> +		__dma_sync_single_for_cpu(dev, addr + offset, size, dir);
>   }
>   
>   static inline void dma_sync_single_range_for_device(struct device *dev,
>   		dma_addr_t addr, unsigned long offset, size_t size,
>   		enum dma_data_direction dir)
>   {
> -	return dma_sync_single_for_device(dev, addr + offset, size, dir);
> +	if (!dma_skip_sync(dev))
> +		__dma_sync_single_for_device(dev, addr + offset, size, dir);
>   }

These two don't need changing either, since the dma_sync_single_* 
wrappers have already taken care of it.

Thanks,
Robin.


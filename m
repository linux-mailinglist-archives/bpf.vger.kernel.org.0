Return-Path: <bpf+bounces-29194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8879E8C11BB
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5751C215CE
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770C15E7F3;
	Thu,  9 May 2024 15:11:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2A912FF9B;
	Thu,  9 May 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267493; cv=none; b=ifT8W+iyyMD/bw19qK9hR0FFasNAH2FSq1wmu8tEW4nvrAmMtDwNf2EQQH1Lw3i7corpTeBK9L/loO64eo7zDItu1vKpE9D61f55gC+AodbHwlnn8WfKaDXkgKkeF0sngIRilVzXyokwIH3z3IpYh2RusEuNCOkPrd/ewMaxaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267493; c=relaxed/simple;
	bh=GPbYouet8G2wsKDht1TdOXTnqgewPV/olDc41m19SKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VK5a8EA5jiFGOXKRXgxZFO9qa8brZztCqwbUf29xlEGTEw+zKJhCXTYtGbuNqhuhRUq95+MnbJcuN6+m7qGJwzSdB/y2rTAPGB5d44aKTt29/hNMRk+UmtGRdcoXQfaut+kg8n+rW30nbsBCjgusJStCeZIpxAw7t2T71WQs8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39396106F;
	Thu,  9 May 2024 08:11:56 -0700 (PDT)
Received: from [10.1.28.39] (e122027.cambridge.arm.com [10.1.28.39])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB8F63F641;
	Thu,  9 May 2024 08:11:27 -0700 (PDT)
Message-ID: <ce83b3b8-2246-4006-a111-f2da0740bd8e@arm.com>
Date: Thu, 9 May 2024 16:11:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: fix DMA sync for drivers not calling dma_set_mask*()
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240509144616.938519-1-aleksander.lobakin@intel.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240509144616.938519-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2024 15:46, Alexander Lobakin wrote:
> There are several reports that the DMA sync shortcut broke non-coherent
> devices.
> dev->dma_need_sync is false after the &device allocation and if a driver
> didn't call dma_set_mask*(), it will still be false even if the device
> is not DMA-coherent and thus needs synchronizing. Due to historical
> reasons, there's still a lot of drivers not calling it.
> Invert the boolean, so that the sync will be performed by default and
> the shortcut will be enabled only when calling dma_set_mask*().
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/lkml/46160534-5003-4809-a408-6b3a3f4921e9@samsung.com
> Reported-by: Steven Price <steven.price@arm.com>
> Closes: https://lore.kernel.org/lkml/010686f5-3049-46a1-8230-7752a1b433ff@arm.com
> Fixes: 32ba8b823252 ("dma: avoid redundant calls for sync operations")
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Tested-by: Steven Price <steven.price@arm.com>

Thanks for the quick fix.

Note that the fixes hash (32ba8b823252) is not the one in linux-next -
that's f406c8e4b770. If the branch is getting rebased then no problem, I
just thought I should point that out.

Thanks,
Steve

> ---
>  include/linux/device.h      |  4 ++--
>  include/linux/dma-map-ops.h |  4 ++--
>  include/linux/dma-mapping.h |  2 +-
>  kernel/dma/mapping.c        | 10 +++++-----
>  kernel/dma/swiotlb.c        |  2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ed95b829f05b..d4b50accff26 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -691,7 +691,7 @@ struct device_physical_location {
>   *		and optionall (if the coherent mask is large enough) also
>   *		for dma allocations.  This flag is managed by the dma ops
>   *		instance from ->dma_supported.
> - * @dma_need_sync: The device needs performing DMA sync operations.
> + * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
>   *
>   * At the lowest level, every device in a Linux system is represented by an
>   * instance of struct device. The device structure contains the information
> @@ -805,7 +805,7 @@ struct device {
>  	bool			dma_ops_bypass : 1;
>  #endif
>  #ifdef CONFIG_DMA_NEED_SYNC
> -	bool			dma_need_sync:1;
> +	bool			dma_skip_sync:1;
>  #endif
>  };
>  
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 4893cb89cb52..5217b922d29f 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -280,8 +280,8 @@ static inline void dma_reset_need_sync(struct device *dev)
>  {
>  #ifdef CONFIG_DMA_NEED_SYNC
>  	/* Reset it only once so that the function can be called on hotpath */
> -	if (unlikely(!dev->dma_need_sync))
> -		dev->dma_need_sync = true;
> +	if (unlikely(dev->dma_skip_sync))
> +		dev->dma_skip_sync = false;
>  #endif
>  }
>  
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index eb4e15893b6c..f693aafe221f 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -295,7 +295,7 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr);
>  static inline bool dma_dev_need_sync(const struct device *dev)
>  {
>  	/* Always call DMA sync operations when debugging is enabled */
> -	return dev->dma_need_sync || IS_ENABLED(CONFIG_DMA_API_DEBUG);
> +	return !dev->dma_skip_sync || IS_ENABLED(CONFIG_DMA_API_DEBUG);
>  }
>  
>  static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 3524bc92c37f..3f77c3f8d16d 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -392,7 +392,7 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>  
>  	if (dma_map_direct(dev, ops))
>  		/*
> -		 * dma_need_sync could've been reset on first SWIOTLB buffer
> +		 * dma_skip_sync could've been reset on first SWIOTLB buffer
>  		 * mapping, but @dma_addr is not necessary an SWIOTLB buffer.
>  		 * In this case, fall back to more granular check.
>  		 */
> @@ -407,20 +407,20 @@ static void dma_setup_need_sync(struct device *dev)
>  
>  	if (dma_map_direct(dev, ops) || (ops->flags & DMA_F_CAN_SKIP_SYNC))
>  		/*
> -		 * dma_need_sync will be reset to %true on first SWIOTLB buffer
> +		 * dma_skip_sync will be reset to %false on first SWIOTLB buffer
>  		 * mapping, if any. During the device initialization, it's
>  		 * enough to check only for the DMA coherence.
>  		 */
> -		dev->dma_need_sync = !dev_is_dma_coherent(dev);
> +		dev->dma_skip_sync = dev_is_dma_coherent(dev);
>  	else if (!ops->sync_single_for_device && !ops->sync_single_for_cpu &&
>  		 !ops->sync_sg_for_device && !ops->sync_sg_for_cpu)
>  		/*
>  		 * Synchronization is not possible when none of DMA sync ops
>  		 * is set.
>  		 */
> -		dev->dma_need_sync = false;
> +		dev->dma_skip_sync = true;
>  	else
> -		dev->dma_need_sync = true;
> +		dev->dma_skip_sync = false;
>  }
>  #else /* !CONFIG_DMA_NEED_SYNC */
>  static inline void dma_setup_need_sync(struct device *dev) { }
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ae3e593eaadb..068134697cf1 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1409,7 +1409,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  	}
>  
>  	/*
> -	 * If dma_need_sync wasn't set, reset it on first SWIOTLB buffer
> +	 * If dma_skip_sync was set, reset it on first SWIOTLB buffer
>  	 * mapping to always sync SWIOTLB buffers.
>  	 */
>  	dma_reset_need_sync(dev);



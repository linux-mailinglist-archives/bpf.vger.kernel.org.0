Return-Path: <bpf+bounces-22021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 717188550E5
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CC9284B6D
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BA71272D8;
	Wed, 14 Feb 2024 17:55:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9141170F;
	Wed, 14 Feb 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933332; cv=none; b=GJaqlaOjJ/R2j6IXv2WF7oC8s5oMKVIBljqooQIqxtko/ZQ+ikHOscBX2t4DT9gOaFyOpTIDgTdCndNGedbq8iGVPYBVIP5FJpIVOeCEUK+zuO7e781QuV0MbTjl23Ygn8HCG7wxki/3WnbRREXLllAEbukSyq6eJU4p3ZRoeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933332; c=relaxed/simple;
	bh=Q+zwuCQCedgZ3MWerytsD0hvfHCUgL8H8cPvcaHYg0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOU/LRC8YqzaPEch0rPwdPv2A17hUgPK/tWQvL2S+UGy4mNq8f+NT60CZfUrP6V2PigbnKbZ57bd9LOJtx2gROvJl0SCNfrkLIfoVAGCaYZDAfAEWQrZHjRslhdqV+rKRKsxr6Kws2cWZUs9DZnr9CfNS5qPuuY1zSGTcJou2iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC911FB;
	Wed, 14 Feb 2024 09:56:09 -0800 (PST)
Received: from [10.57.47.86] (unknown [10.57.47.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2E73F766;
	Wed, 14 Feb 2024 09:55:24 -0800 (PST)
Message-ID: <3a9dd580-1977-418f-a3f3-73003dd37710@arm.com>
Date: Wed, 14 Feb 2024 17:55:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/7] dma: avoid redundant calls for sync
 operations
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
 <20240214162201.4168778-3-aleksander.lobakin@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240214162201.4168778-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-14 4:21 pm, Alexander Lobakin wrote:
> Quite often, devices do not need dma_sync operations on x86_64 at least.
> Indeed, when dev_is_dma_coherent(dev) is true and
> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
> and friends do nothing.
> 
> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
> 
> Add dev->skip_dma_sync boolean which is set during the device
> initialization depending on the setup: dev_is_dma_coherent() for the
> direct DMA, !(sync_single_for_device || sync_single_for_cpu) or the new
> dma_map_ops flag, %DMA_F_CAN_SKIP_SYNC, advertised for non-NULL DMA ops.
> Then later, if/when swiotlb is used for the first time, the flag
> is turned off, from swiotlb_tbl_map_single().
> 
> On iavf, the UDP trafficgen with XDP_DROP in skb mode test shows
> +3-5% increase for direct DMA.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de> # direct DMA shortcut
> Co-developed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   include/linux/device.h      |  5 +++++
>   include/linux/dma-map-ops.h | 21 ++++++++++++++++++++
>   include/linux/dma-mapping.h |  6 +++++-
>   drivers/base/dd.c           |  2 ++
>   kernel/dma/mapping.c        | 39 ++++++++++++++++++++++++++++++++++++-
>   kernel/dma/swiotlb.c        |  8 ++++++++
>   6 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 97c4b046c09d..f23e6a32bea0 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -686,6 +686,8 @@ struct device_physical_location {
>    *		other devices probe successfully.
>    * @dma_coherent: this particular device is dma coherent, even if the
>    *		architecture supports non-coherent devices.
> + * @dma_skip_sync: DMA sync operations can be skipped for coherent non-SWIOTLB
> + *		buffers.
>    * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
>    *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*),
>    *		and optionall (if the coherent mask is large enough) also
> @@ -800,6 +802,9 @@ struct device {
>       defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>   	bool			dma_coherent:1;
>   #endif
> +#ifdef CONFIG_DMA_NEED_SYNC
> +	bool			dma_skip_sync:1;
> +#endif
>   #ifdef CONFIG_DMA_OPS_BYPASS
>   	bool			dma_ops_bypass : 1;
>   #endif
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 4abc60f04209..327b73f653ad 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -18,8 +18,11 @@ struct iommu_ops;
>    *
>    * DMA_F_PCI_P2PDMA_SUPPORTED: Indicates the dma_map_ops implementation can
>    * handle PCI P2PDMA pages in the map_sg/unmap_sg operation.
> + * DMA_F_CAN_SKIP_SYNC: DMA sync operations can be skipped if the device is
> + * coherent and it's not an SWIOTLB buffer.
>    */
>   #define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
> +#define DMA_F_CAN_SKIP_SYNC		BIT(1)

Yuck, please be consistent - either match the style of the existing 
code, or change that to BIT(0) as well.

>   struct dma_map_ops {
>   	unsigned int flags;
> @@ -111,6 +114,24 @@ static inline void set_dma_ops(struct device *dev,
>   }
>   #endif /* CONFIG_DMA_OPS */
>   
> +#ifdef CONFIG_DMA_NEED_SYNC
> +void dma_setup_skip_sync(struct device *dev);
> +
> +static inline void dma_clear_skip_sync(struct device *dev)
> +{
> +	/* Clear it only once so that the function can be called on hotpath */
> +	if (unlikely(dev->dma_skip_sync))
> +		dev->dma_skip_sync = false;
> +}
> +#else /* !CONFIG_DMA_NEED_SYNC */
> +static inline void dma_setup_skip_sync(struct device *dev)
> +{
> +}
> +static inline void dma_clear_skip_sync(struct device *dev)
> +{
> +}
> +#endif /* !CONFIG_DMA_NEED_SYNC */
> +
>   #ifdef CONFIG_DMA_CMA
>   extern struct cma *dma_contiguous_default_area;
>   
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 6c7640441214..d85ae541c267 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -364,7 +364,11 @@ static inline void __dma_sync_single_range_for_device(struct device *dev,
>   
>   static inline bool dma_skip_sync(const struct device *dev)
>   {
> -	return !IS_ENABLED(CONFIG_DMA_NEED_SYNC);
> +#ifdef CONFIG_DMA_NEED_SYNC
> +	return dev->dma_skip_sync;
> +#else
> +	return true;
> +#endif
>   }
>   
>   static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 85152537dbf1..67ad3e1d51f6 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -642,6 +642,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>   			goto pinctrl_bind_failed;
>   	}
>   
> +	dma_setup_skip_sync(dev);
> +
>   	ret = driver_sysfs_add(dev);
>   	if (ret) {
>   		pr_err("%s: driver_sysfs_add(%s) failed\n",
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 85feaa0e008c..5f588e31ea89 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -846,8 +846,14 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   
>   	if (dma_map_direct(dev, ops))
> +		/*
> +		 * dma_skip_sync could've been set to false on first SWIOTLB
> +		 * buffer mapping, but @dma_addr is not necessary an SWIOTLB
> +		 * buffer. In this case, fall back to more granular check.
> +		 */
>   		return dma_direct_need_sync(dev, dma_addr);
> -	return ops->sync_single_for_cpu || ops->sync_single_for_device;
> +
> +	return true;
>   }
>   EXPORT_SYMBOL_GPL(__dma_need_sync);
>   
> @@ -861,3 +867,34 @@ unsigned long dma_get_merge_boundary(struct device *dev)
>   	return ops->get_merge_boundary(dev);
>   }
>   EXPORT_SYMBOL_GPL(dma_get_merge_boundary);
> +
> +#ifdef CONFIG_DMA_NEED_SYNC
> +void dma_setup_skip_sync(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	if (dma_map_direct(dev, ops))

For DMA_OPS_BYPASS this will be making the decision based on the default 
dma_mask, but a driver could subsequently set a smaller mask for which 
the bypass condition will no longer be true.

Maybe instead of driver probe this setup should actually be tied in to 
dma_set_mask() anyway?

> +		/*
> +		 * dma_skip_sync will be set to false on first SWIOTLB buffer
> +		 * mapping, if any. During the device initialization, it's
> +		 * enough to check only for DMA coherence.
> +		 */
> +		dev->dma_skip_sync = dev_is_dma_coherent(dev);
> +	else if (!ops->sync_single_for_device && !ops->sync_single_for_cpu)

I guess this was the existing condition from dma_need_sync(), but now 
it's on a one-off slow path it might be nice to check the sync_sg_* ops 
as well for completeness, or at least comment that nobody should be 
implementing those without also implementing the sync_single_* ops.

> +		/*
> +		 * Synchronization is not possible when none of DMA sync ops
> +		 * is set. This check precedes the below one as it disables
> +		 * the synchronization unconditionally.
> +		 */
> +		dev->dma_skip_sync = true;
> +	else if (ops->flags & DMA_F_CAN_SKIP_SYNC)

Personally I'd combine this into the dma-direct condition.

> +		/*
> +		 * Assume that when ``DMA_F_CAN_SKIP_SYNC`` is advertised,
> +		 * the conditions for synchronizing are the same as with
> +		 * the direct DMA.
> +		 */
> +		dev->dma_skip_sync = dev_is_dma_coherent(dev);
> +	else
> +		dev->dma_skip_sync = false;
> +}
> +#endif /* CONFIG_DMA_NEED_SYNC */
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b079a9a8e087..0b737eab4d48 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1323,6 +1323,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   		return (phys_addr_t)DMA_MAPPING_ERROR;
>   	}
>   
> +	/*
> +	 * If dma_skip_sync was set, reset it to false on first SWIOTLB buffer
> +	 * mapping to always sync SWIOTLB buffers.
> +	 */
> +	dma_clear_skip_sync(dev);
> +
>   	/*
>   	 * Save away the mapping from the original address to the DMA address.
>   	 * This is needed when we sync the memory.  Then we sync the buffer if
> @@ -1640,6 +1646,8 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>   	if (index == -1)
>   		return NULL;
>   
> +	dma_clear_skip_sync(dev);

We don't need this here, since this isn't a streaming API path.

Thanks,
Robin.

> +
>   	tlb_addr = slot_addr(pool->start, index);
>   
>   	return pfn_to_page(PFN_DOWN(tlb_addr));


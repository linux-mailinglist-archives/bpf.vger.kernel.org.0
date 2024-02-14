Return-Path: <bpf+bounces-22022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5BA85516E
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 19:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2827D29319A
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CD712836C;
	Wed, 14 Feb 2024 17:58:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFF8127B51;
	Wed, 14 Feb 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933517; cv=none; b=EiwTBQxmjONUvf6DoZ+yEayq+AI30j3YldI0Ocw6eKJggQrHd1yUwXtZglvSLp3x4it7/adfHldFh52bfIk5mvURwrK5eKHktjgbZoguIcAktZl0i8qNAGtz1Y6RcxtCU/iyEXEESgICMz0XH3ca3j6LIHl269ctj8ujKRa0aVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933517; c=relaxed/simple;
	bh=M9SzvVIV7YSZhK7oCmf3vj7+C0jEeizkNf7iIs8Prgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D74D6rXgIP31aqKyuNjFuEMWncYyki+H3gtCUJGlYoKHHLHbvFjHrMx+z8N9M7IX+g4nMeZKosnEcv/2pXUf295xLUXDoQ5ywUTo6eN2ZerfMzgARJ7YS0T+R/njDArkw+EwYe0Fv0bf++UKdN49v9LlzNivMId9aaAZE5T92cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13D4B1FB;
	Wed, 14 Feb 2024 09:59:16 -0800 (PST)
Received: from [10.57.47.86] (unknown [10.57.47.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59B433F766;
	Wed, 14 Feb 2024 09:58:32 -0800 (PST)
Message-ID: <2d13134d-1e5c-4534-8686-c0022caeb36c@arm.com>
Date: Wed, 14 Feb 2024 17:58:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/7] iommu/dma: avoid expensive indirect calls
 for sync operations
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
 <20240214162201.4168778-4-aleksander.lobakin@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240214162201.4168778-4-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-14 4:21 pm, Alexander Lobakin wrote:
> When IOMMU is on, the actual synchronization happens in the same cases
> as with the direct DMA. Advertise %DMA_F_CAN_SKIP_SYNC in IOMMU DMA to
> skip sync ops calls (indirect) for non-SWIOTLB buffers.
> 
> perf profile before the patch:
> 
>      18.53%  [kernel]       [k] gq_rx_skb
>      14.77%  [kernel]       [k] napi_reuse_skb
>       8.95%  [kernel]       [k] skb_release_data
>       5.42%  [kernel]       [k] dev_gro_receive
>       5.37%  [kernel]       [k] memcpy
> <*>  5.26%  [kernel]       [k] iommu_dma_sync_sg_for_cpu
>       4.78%  [kernel]       [k] tcp_gro_receive
> <*>  4.42%  [kernel]       [k] iommu_dma_sync_sg_for_device
>       4.12%  [kernel]       [k] ipv6_gro_receive
>       3.65%  [kernel]       [k] gq_pool_get
>       3.25%  [kernel]       [k] skb_gro_receive
>       2.07%  [kernel]       [k] napi_gro_frags
>       1.98%  [kernel]       [k] tcp6_gro_receive
>       1.27%  [kernel]       [k] gq_rx_prep_buffers
>       1.18%  [kernel]       [k] gq_rx_napi_handler
>       0.99%  [kernel]       [k] csum_partial
>       0.74%  [kernel]       [k] csum_ipv6_magic
>       0.72%  [kernel]       [k] free_pcp_prepare
>       0.60%  [kernel]       [k] __napi_poll
>       0.58%  [kernel]       [k] net_rx_action
>       0.56%  [kernel]       [k] read_tsc
> <*>  0.50%  [kernel]       [k] __x86_indirect_thunk_r11
>       0.45%  [kernel]       [k] memset
> 
> After patch, lines with <*> no longer show up, and overall
> cpu usage looks much better (~60% instead of ~72%):
> 
>      25.56%  [kernel]       [k] gq_rx_skb
>       9.90%  [kernel]       [k] napi_reuse_skb
>       7.39%  [kernel]       [k] dev_gro_receive
>       6.78%  [kernel]       [k] memcpy
>       6.53%  [kernel]       [k] skb_release_data
>       6.39%  [kernel]       [k] tcp_gro_receive
>       5.71%  [kernel]       [k] ipv6_gro_receive
>       4.35%  [kernel]       [k] napi_gro_frags
>       4.34%  [kernel]       [k] skb_gro_receive
>       3.50%  [kernel]       [k] gq_pool_get
>       3.08%  [kernel]       [k] gq_rx_napi_handler
>       2.35%  [kernel]       [k] tcp6_gro_receive
>       2.06%  [kernel]       [k] gq_rx_prep_buffers
>       1.32%  [kernel]       [k] csum_partial
>       0.93%  [kernel]       [k] csum_ipv6_magic
>       0.65%  [kernel]       [k] net_rx_action
> 
> iavf yields +10% of Mpps on Rx. This also unblocks batched allocations
> of XSk buffers when IOMMU is active.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Co-developed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   drivers/iommu/dma-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 50ccc4f1ef81..4ab9ac13d362 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1707,7 +1707,8 @@ static size_t iommu_dma_opt_mapping_size(void)
>   }
>   
>   static const struct dma_map_ops iommu_dma_ops = {
> -	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
> +	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED |
> +				  DMA_F_CAN_SKIP_SYNC,
>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
>   	.alloc_pages		= dma_common_alloc_pages,


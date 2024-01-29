Return-Path: <bpf+bounces-20597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2849E840854
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B7B25EC5
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9EB12F5A2;
	Mon, 29 Jan 2024 14:29:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDEE679E0;
	Mon, 29 Jan 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538591; cv=none; b=VLnvgPiKlJg05rcuGK1YgvllKDHnRIfJeDGY4JkJb9/tey8aDhJ4N9fqMILutmloa14bDTjgR+KsUNVmOv3QRYXpbcgY84TqJzU4NB7yNxws34UETRy4biGu47lM6+Vkd+1RxwC+OM+fmuo1B+H0fjXs4MQL49qunFndMCxrZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538591; c=relaxed/simple;
	bh=sUOl21AQ9QP1KxLqMgEvOcJJpRIJ5FdSCV60Ux3RHr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYSwsE8rBGVmu5VVlg5EKwAgg1gBc286hEu2upppUNXse+5NxBZ7y9UU+J4UBPi8AQW9w4gEqq1wUgLY7xv/C2luhDJO/+OhNaSN5VRP+D7POXPB9KKx7iyx826a+9v3O3Upu6qzKyr/pluIPEQKzyCzzuXPFlq5XiZxYtvT6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13FF4DA7;
	Mon, 29 Jan 2024 06:30:32 -0800 (PST)
Received: from [10.57.77.253] (unknown [10.57.77.253])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C1D33F5A1;
	Mon, 29 Jan 2024 06:29:45 -0800 (PST)
Message-ID: <9ab3aa81-294c-4b16-a4e3-97b4fe358be8@arm.com>
Date: Mon, 29 Jan 2024 14:29:43 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] dma: avoid expensive redundant calls for
 sync operations
Content-Language: en-GB
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
 <20240126135456.704351-3-aleksander.lobakin@intel.com>
 <0f6f550c-3eee-46dc-8c42-baceaa237610@arm.com>
 <7ff3cf5d-b3ff-4b52-9031-30a1cb71c0c9@intel.com>
 <3d9f7f89-9d62-4916-8f3f-a4aaad85a8e2@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <3d9f7f89-9d62-4916-8f3f-a4aaad85a8e2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-29 2:07 pm, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Fri, 26 Jan 2024 17:45:11 +0100
> 
>> From: Robin Murphy <robin.murphy@arm.com>
>> Date: Fri, 26 Jan 2024 15:48:54 +0000
>>
>>> On 26/01/2024 1:54 pm, Alexander Lobakin wrote:
>>>> From: Eric Dumazet <edumazet@google.com>
>>>>
>>>> Quite often, NIC devices do not need dma_sync operations on x86_64
>>>> at least.
>>>> Indeed, when dev_is_dma_coherent(dev) is true and
>>>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
>>>> and friends do nothing.
>>>>
>>>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
>>>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
>>>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>>>>
>>>> Add dev->skip_dma_sync boolean which is set during the device
>>>> initialization depending on the setup: dev_is_dma_coherent() for direct
>>>> DMA, !(sync_single_for_device || sync_single_for_cpu) or positive result
>>>> from the new callback, dma_map_ops::can_skip_sync for non-NULL DMA ops.
>>>> Then later, if/when swiotlb is used for the first time, the flag
>>>> is turned off, from swiotlb_tbl_map_single().
>>>
>>> I think you could probably just promote the dma_uses_io_tlb flag from
>>> SWIOTLB_DYNAMIC to a general SWIOTLB thing to serve this purpose now.
>>
>> Nice catch!
> 
> BTW, this implies such hotpath check:
> 
> 	if (dev->dma_skip_sync && !READ_ONCE(dev->dma_uses_io_tlb))
> 		// ...
> 
> This seems less effective than just resetting dma_skip_sync on first
> allocation.

Well, my point is not to have a dma_skip_sync at all; I'm suggesting the 
check would be:

	if (dev_is_dma_coherent(dev) && dev_uses_io_tlb(dev))
		...

where on the platform which cares about this most, that first condition 
is a compile-time constant (and as implied, the second would want to be 
similarly wrapped for !SWIOTLB configs).

Thanks,
Robin.


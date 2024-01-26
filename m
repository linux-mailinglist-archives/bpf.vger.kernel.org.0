Return-Path: <bpf+bounces-20412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751383DFE5
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4E3B21244
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A531F5FD;
	Fri, 26 Jan 2024 17:21:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5B01EB45;
	Fri, 26 Jan 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289692; cv=none; b=rulr+klGCW4qaPVvs964eg5szPpZERXf945MWfwktgDcXTyd/GIo50EUKvIh1zfh2nTOWCbJv4ik6Mgb+SEDx1vpXydavRyteRI6qwfN1zM26NeCDpobshoo4GvZXNr8f6YDoTlBoJt9+daACm6uqjsIQxECBK1UPvtcp0Ul6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289692; c=relaxed/simple;
	bh=f+GiwjdOekcSqEi3/DLPCaEvvf4ah7db8RL/lfaPNZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGjwVIv5FUTX2ruMfmUEc1j2hDEk83iCy36YFJpY1qf8nAw4cMRmUBjnTk84v0akjjaO76/q5aCUkABFU/OLWPnu7sunTGAhL6acMvCnVSg6XW4v3Lk8qDki2RM4PKlLUOqYUn2GMF2qglQPyxsdHify1nFWesHuxogPqT7CAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1111D1FB;
	Fri, 26 Jan 2024 09:22:14 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 782C13F762;
	Fri, 26 Jan 2024 09:21:26 -0800 (PST)
Message-ID: <0cf72c00-21d9-4f1a-be14-80336da5dff4@arm.com>
Date: Fri, 26 Jan 2024 17:21:24 +0000
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
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7ff3cf5d-b3ff-4b52-9031-30a1cb71c0c9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2024 4:45 pm, Alexander Lobakin wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> Date: Fri, 26 Jan 2024 15:48:54 +0000
> 
>> On 26/01/2024 1:54 pm, Alexander Lobakin wrote:
>>> From: Eric Dumazet <edumazet@google.com>
>>>
>>> Quite often, NIC devices do not need dma_sync operations on x86_64
>>> at least.
>>> Indeed, when dev_is_dma_coherent(dev) is true and
>>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
>>> and friends do nothing.
>>>
>>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
>>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
>>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>>>
>>> Add dev->skip_dma_sync boolean which is set during the device
>>> initialization depending on the setup: dev_is_dma_coherent() for direct
>>> DMA, !(sync_single_for_device || sync_single_for_cpu) or positive result
>>> from the new callback, dma_map_ops::can_skip_sync for non-NULL DMA ops.
>>> Then later, if/when swiotlb is used for the first time, the flag
>>> is turned off, from swiotlb_tbl_map_single().
>>
>> I think you could probably just promote the dma_uses_io_tlb flag from
>> SWIOTLB_DYNAMIC to a general SWIOTLB thing to serve this purpose now.
> 
> Nice catch!
> 
>>
>> Similarly I don't think a new op is necessary now that we have
>> dma_map_ops.flags. A simple static flag to indicate that sync may be> skipped under the same conditions as implied for dma-direct - i.e.
>> dev_is_dma_coherent(dev) && !dev->dma_use_io_tlb - seems like it ought
>> to suffice.
> 
> In my initial implementation, I used a new dma_map_ops flag, but then I
> realized different DMA ops may require or not require syncing under
> different conditions, not only dev_is_dma_coherent().
> Or am I wrong and they would always be the same?

I think it's safe to assume that, as with P2P support, this will only 
matter for dma-direct and iommu-dma for the foreseeable future, and 
those do currently share the same conditions as above. Thus we may as 
well keep things simple for now, and if anything ever does have cause to 
change, it can be the future's problem to keep this mechanism working as 
intended.

Thanks,
Robin.


Return-Path: <bpf+bounces-29184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D498C1142
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E23C1F23E13
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522312E1F1;
	Thu,  9 May 2024 14:33:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37D41B5AA;
	Thu,  9 May 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265198; cv=none; b=d/Do7dCkD4WL+VRtuQf8Oyqia8z1ZtjMGCkIg44UkPuN1go0arSJp9Sb6D5ck8Qo0xJts2kdQgMovGwK5WSbTMQgs8fu3gwXzLwCBxqGKUaPH+9KuQC3/xdiSjqdCXeHCV9x69KqQ+3qYVl/H3n+LVEPeeDjfBfPe+aSjW7kSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265198; c=relaxed/simple;
	bh=x+Uf/gt/MrLRVLMFBjjZ3+jQZpEm03831m9IVETeVCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMKZuhHeQkLJT00GIYU6CrMWIPXA270Zs2+Ch2C2fBKY157ayYcda5ZCWK5ZCP4rhP4F6ctZRnnDZVe52KcwDnNORQtcoBoHdFHHTdpAtyy7aBOI5cbD8wWTOmtaDioODLOPUPqcolPMdQWEmVuKH2vE32wqpidljtlPatPUtJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97890106F;
	Thu,  9 May 2024 07:33:41 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 695983F641;
	Thu,  9 May 2024 07:33:14 -0700 (PDT)
Message-ID: <5d6a26f5-5acb-4c5d-aa11-724399d1348b@arm.com>
Date: Thu, 9 May 2024 15:33:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] dma: avoid redundant calls for sync operations
To: Steven Price <steven.price@arm.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240507112026.1803778-1-aleksander.lobakin@intel.com>
 <20240507112026.1803778-3-aleksander.lobakin@intel.com>
 <010686f5-3049-46a1-8230-7752a1b433ff@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <010686f5-3049-46a1-8230-7752a1b433ff@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2024 2:43 pm, Steven Price wrote:
> On 07/05/2024 12:20, Alexander Lobakin wrote:
>> Quite often, devices do not need dma_sync operations on x86_64 at least.
>> Indeed, when dev_is_dma_coherent(dev) is true and
>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
>> and friends do nothing.
>>
>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>>
>> Add dev->need_dma_sync boolean and turn it off during the device
>> initialization (dma_set_mask()) depending on the setup:
>> dev_is_dma_coherent() for the direct DMA, !(sync_single_for_device ||
>> sync_single_for_cpu) or the new dma_map_ops flag, %DMA_F_CAN_SKIP_SYNC,
>> advertised for non-NULL DMA ops.
>> Then later, if/when swiotlb is used for the first time, the flag
>> is reset back to on, from swiotlb_tbl_map_single().
>>
>> On iavf, the UDP trafficgen with XDP_DROP in skb mode test shows
>> +3-5% increase for direct DMA.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de> # direct DMA shortcut
>> Co-developed-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> I've bisected a boot failure (on a Firefly RK3288) to this commit.
> AFAICT the problem is that I have (at least) two drivers which don't
> call dma_set_mask() and therefore never initialise the new dma_need_sync
> variable.
> 
> The specific drivers are "rockchip-drm" and "rk_gmac-dwmac". Is it a
> requirement that all drivers engaging in DMA should call dma_set_mask()
> - and therefore this has uncovered a bug in those drivers. Or is the
> assumption that all drivers call dma_set_mask() faulty?

Historically it's long been documented (at least in DMA-API-HOWTO) that 
a 32-bit DMA mask is assumed by default, so as much as we would prefer 
to shift expectations, there are still going to be a great many drivers 
relying on that :(

Perhaps its time for dma-debug to start warning about implicit mask 
usage, maybe that might help push the agenda a bit?

Thanks,
Robin.


Return-Path: <bpf+bounces-22733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B924E867BEC
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 17:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAACF1C2985F
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7861C12F5BA;
	Mon, 26 Feb 2024 16:27:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECEF12C810;
	Mon, 26 Feb 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964848; cv=none; b=SfpLWc6J25GvPdTLI6IPQydbgSSAuWduHILjQmlwSxax2SVRV4ybwXIIFTQtYmeXPsrpYhNQMeu5Yz7NzQlrykWk/U3cdfp4V+MEkUKkeas4WyacP971kGjEGFgkU1V5mlj19BYhSiHKD3RcWyqr1bFbjnbWyX4m84NSJW+4YLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964848; c=relaxed/simple;
	bh=mO9DSkJwDCEJi0Uvk9Pm5rQ7w+WPMSHOMnK//jgc+C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rK+MfGUWUXkyvk/NX89qupKprsLy7tDdNLet1ny9EP3aY+idkzCLrvv6jJ5Q74Ox98x/aY0JA/ZiBxLzOu/7jEZDKEowOZYVxX/pROe5vZJnHNLQjc02oGjiLS1th649IjOym4kE+QJsM7VVRsHJlR2l7u3ndD4zrJUzgyClgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4510EDA7;
	Mon, 26 Feb 2024 08:27:58 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 965933F73F;
	Mon, 26 Feb 2024 08:27:17 -0800 (PST)
Message-ID: <94043c84-0b03-491a-9dd4-2a792d33bca0@arm.com>
Date: Mon, 26 Feb 2024 16:27:16 +0000
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
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
 <20240214162201.4168778-2-aleksander.lobakin@intel.com>
 <893ad3a4-ba24-43cf-8200-b8cd7742622d@arm.com>
 <6b003271-cd83-4091-89c6-bb37da62afef@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <6b003271-cd83-4091-89c6-bb37da62afef@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2024 12:53 pm, Alexander Lobakin wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> Date: Wed, 14 Feb 2024 17:20:50 +0000
> 
>> On 2024-02-14 4:21 pm, Alexander Lobakin wrote:
> 
> [...]
> 
>>> -static inline void dma_sync_single_for_cpu(struct device *dev,
>>> dma_addr_t addr,
>>> -        size_t size, enum dma_data_direction dir)
>>> +static inline void __dma_sync_single_for_cpu(struct device *dev,
>>> +        dma_addr_t addr, size_t size, enum dma_data_direction dir)
>>
>> To me it would feel more logical to put all the wrappers inside the
>> #ifdef CONFIG_HAS_DMA and not touch these stubs at all (what does it
>> mean to skip an inline no-op?). Or in fact, if dma_skip_sync() is
>> constant false for !HAS_DMA, then we could also just make the external
>> function declarations unconditional and remove the stubs. Not a critical
>> matter though, and I defer to whatever Christoph thinks is most
>> maintainable.
> 
> It's done like that due to that I'm adding a runtime check in the second
> patch. I don't feel like touching this twice makes sense.

Huh? Why would anything need touching twice? All I'm saying is that it's 
pretty pointless to add any invocations of dma_skip_sync() in !HAS_DMA 
paths where we already know the whole API is stubbed out anyway. The 
only cases which are worth differentiating here are HAS_DMA + 
DMA_NEED_SYNC vs. HAS_DMA + !DMA_NEED_SYNC (with the subsequent runtime 
check then just subdividing the former).

> 
> [...]
> 
>>> @@ -348,18 +348,72 @@ static inline void dma_unmap_single_attrs(struct
>>> device *dev, dma_addr_t addr,
>>>        return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
>>>    }
>>>    +static inline void __dma_sync_single_range_for_cpu(struct device *dev,
>>> +        dma_addr_t addr, unsigned long offset, size_t size,
>>> +        enum dma_data_direction dir)
>>> +{
>>> +    __dma_sync_single_for_cpu(dev, addr + offset, size, dir);
>>> +}
>>> +
>>> +static inline void __dma_sync_single_range_for_device(struct device
>>> *dev,
>>> +        dma_addr_t addr, unsigned long offset, size_t size,
>>> +        enum dma_data_direction dir)
>>> +{
>>> +    __dma_sync_single_for_device(dev, addr + offset, size, dir);
>>> +}
>>
>> There is no need to introduce these two.
> 
> I already replied to this in the previous thread. Some subsys may want
> to check for the shortcut earlier to avoid call ladders of their own
> functions. See patch 6 for example where I use this one.

Ugh, no. If the page pool code wants to be clever poking around and 
sidestepping parts of the documented API, it can flippin' well open-code 
a single addition to call __dma_sync_single_for_device() directly 
itself. I'm not at all keen on having to maintain "common" APIs for such 
niche trickery.

Thanks,
Robin.


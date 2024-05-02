Return-Path: <bpf+bounces-28453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1538B9DC6
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB551C22BB3
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC5F15B96A;
	Thu,  2 May 2024 15:49:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404F15574D;
	Thu,  2 May 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664995; cv=none; b=Uhhq/N5Mi2gu+ej/Be2c+qVoTAVgpPf/xNVgRFsxWqWYyQxJvjuB6n+W+56G8rwFZXWQaJ3mpRnVR74QUnjq0VNiyvdooJJ2lTMj/Rl2QJfKJAhUzzEBZj9pEb8kPm4O6ibCVNQiBCXzh7e7fynKYsvXoJfYoPtnEp2QqFh1llE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664995; c=relaxed/simple;
	bh=lSLQE7weTxnVqPnhv28TxjpfYwfoIlf4YwWxqRNzmeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwdR4yj6phaQLQz2Aujrw4SBXz1tHs1YnIBHamjd9+3Rupucc8g0eK7ql+LAKPDm5q/lAxAHlZz4VsDBcMk5ZVpQF+//eBUXfX5Kz/e7idlxFI3aFIQAckAXEutb+oXW3+7jN5s+hF1qITdg3leZBMX5DIVcRtIme041n9h3x3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 458BD2F4;
	Thu,  2 May 2024 08:50:17 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6C993F793;
	Thu,  2 May 2024 08:49:49 -0700 (PDT)
Message-ID: <ac0a09f2-5f05-4317-a1cf-b7135791c639@arm.com>
Date: Thu, 2 May 2024 16:49:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/7] page_pool: check for DMA sync shortcut
 earlier
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
 <20240423135832.2271696-7-aleksander.lobakin@intel.com>
 <81df4e0f-07f3-40f6-8d71-ffad791ab611@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <81df4e0f-07f3-40f6-8d71-ffad791ab611@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2024 9:52 am, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Tue, 23 Apr 2024 15:58:31 +0200
> 
>> We can save a couple more function calls in the Page Pool code if we
>> check for dma_need_sync() earlier, just when we test pp->p.dma_sync.
>> Move both these checks into an inline wrapper and call the PP wrapper
>> over the generic DMA sync function only when both are true.
>> You can't cache the result of dma_need_sync() in &page_pool, as it may
>> change anytime if an SWIOTLB buffer is allocated or mapped.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>   net/core/page_pool.c | 31 +++++++++++++++++--------------
>>   1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 6cf26a68fa91..87319c6365e0 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -398,16 +398,24 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
>>   	return page;
>>   }
>>   
>> -static void page_pool_dma_sync_for_device(const struct page_pool *pool,
>> -					  const struct page *page,
>> -					  unsigned int dma_sync_size)
>> +static void __page_pool_dma_sync_for_device(const struct page_pool *pool,
>> +					    const struct page *page,
>> +					    u32 dma_sync_size)
>>   {
>>   	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
>>   
>>   	dma_sync_size = min(dma_sync_size, pool->p.max_len);
>> -	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
>> -					 pool->p.offset, dma_sync_size,
>> -					 pool->p.dma_dir);
>> +	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
>> +				     dma_sync_size, pool->p.dma_dir);
> 
> Breh, this breaks builds on !DMA_NEED_SYNC systems, as this function
> isn't defined there, and my CI didn't catch it in time... I'll ifdef
> this in the next spin after some reviews for this one.

Hmm, the way things have ended up, do we even need this change? (Other
than factoring out the pool->dma_sync check, which is clearly nice)

Since __page_pool_dma_sync_for_device() is never called directly, the
flow we always get is:

page_pool_dma_sync_for_device()
     dma_dev_need_sync()
         __page_pool_dma_sync_for_device()
             ... // a handful of trivial arithmetic
             __dma_sync_single_for_device()

i.e. still effectively the same order of
"if (dma_dev_need_sync()) __dma_sync()" invocations as if we'd just used
the standard dma_sync(), so referencing the unwrapped internals only
spreads it out a bit more for no real benefit. As an experiment I tried
the diff below on top, effectively undoing this problematic part, and it
doesn't seem to make any appreciable difference in a before-and-after
comparison of the object code, at least for my arm64 build.

Thanks,
Robin.

----->8-----
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 27f3b6db800e..b8ab7d4ca229 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -398,24 +398,20 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
  	return page;
  }
  
-static void __page_pool_dma_sync_for_device(const struct page_pool *pool,
-					    const struct page *page,
-					    u32 dma_sync_size)
-{
-	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
-
-	dma_sync_size = min(dma_sync_size, pool->p.max_len);
-	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
-				     dma_sync_size, pool->p.dma_dir);
-}
-
  static __always_inline void
  page_pool_dma_sync_for_device(const struct page_pool *pool,
  			      const struct page *page,
  			      u32 dma_sync_size)
  {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
-		__page_pool_dma_sync_for_device(pool, page, dma_sync_size);
+	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
+
+	if (!pool->dma_sync)
+		return;
+
+	dma_sync_size = min(dma_sync_size, pool->p.max_len);
+	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
+					 pool->p.offset, dma_sync_size,
+					 pool->p.dma_dir);
  }
  
  static bool page_pool_dma_map(struct page_pool *pool, struct page *page)


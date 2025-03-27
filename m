Return-Path: <bpf+bounces-54779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A89A72960
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 04:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC741173532
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 03:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5D31A8F60;
	Thu, 27 Mar 2025 03:54:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24FA1DFF8;
	Thu, 27 Mar 2025 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743047663; cv=none; b=tXcx82DS+0h/QCKyOuHyjePTk9qplKHneCZZNa+zt4UHXgJF3gnqTRNIlxpCb20MTpbbX0jadGF4b8/wZeW3gyyevsS5Coc7311H/UKnoEnZhuEIYUB3+ta+sWs1MDB3suY3h8LUW1umY4q7SkdSE5I3apk/uVU8Scs4EtZKGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743047663; c=relaxed/simple;
	bh=IA+LK06a1j5hDSebQ1n7z6fLY39JQRegN6M6AkDs6E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iSTt8pfLPOgTTbiOgSzalPa8dKzFBmDyYIbhh0FmiuX31dIA975fZJBA+dbNeI7surZuXwHolc4awnx4jOlV9HNCCt0g0VNA5qxmcNHF7cVkSehStQ6CpEYEivTDz5HaBrf7VZQ7jcVIoLjcQMotlKTua45VcqcadbVrowtHtd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZNV7S3X2Hz2CdMH;
	Thu, 27 Mar 2025 11:51:00 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C8D521A0188;
	Thu, 27 Mar 2025 11:54:17 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Mar 2025 11:54:17 +0800
Message-ID: <f1a33452-31a4-4651-8d4a-3650fd27174b@huawei.com>
Date: Thu, 27 Mar 2025 11:53:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Saeed Mahameed <saeedm@nvidia.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
	<almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com>
 <Z-RF4_yotcfvX0Xz@x130>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <Z-RF4_yotcfvX0Xz@x130>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/27 2:22, Saeed Mahameed wrote:

...

> 
> I know there's an extra check on fast path, but looking below it seems
> like slow path is becoming unnecessarily complicated, and we are sacrificing
> slow path performance significantly for the sake of not touching fast path
> at all. page_pool slow path should _not_ be significantly slower
> than using the page allocator directly! In many production environments and
> some workloads, page pool recycling can happen at a very low rate resulting
> on performance relying solely on slow path..

+1. And we also rely on the above 'slow path' to flush old nid-mismatched pages
and refill new pages from the correct nid, see the nid checking and updating in
page_pool_refill_alloc_cache() and page_pool_update_nid() when irq migrates
between different numa nodes as it seems common for linux distributions to use
irqbalance to tune performance.

>> To fix this, implement a simple tracking of outstanding DMA-mapped pages
>> in page pool using an xarray. This was first suggested by Mina[0], and
>> turns out to be fairly straight forward: We simply store pointers to
>> pages directly in the xarray with xa_alloc() when they are first DMA
>> mapped, and remove them from the array on unmap. Then, when a page pool
>> is torn down, it can simply walk the xarray and unmap all pages still
>> present there before returning, which also allows us to get rid of the
>> get/put_device() calls in page_pool. Using xa_cmpxchg(), no additional
>> synchronisation is needed, as a page will only ever be unmapped once.
>>
>> To avoid having to walk the entire xarray on unmap to find the page
>> reference, we stash the ID assigned by xa_alloc() into the page
>> structure itself, using the upper bits of the pp_magic field. This
>> requires a couple of defines to avoid conflicting with the
>> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
>> so does not affect run-time performance. The bitmap calculations in this
>> patch gives the following number of bits for different architectures:
>>
>> - 23 bits on 32-bit architectures
>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
>> - 32 bits on other 64-bit architectures
>>
>> Stashing a value into the unused bits of pp_magic does have the effect
>> that it can make the value stored there lie outside the unmappable
>> range (as governed by the mmap_min_addr sysctl), for architectures that
>> don't define ILLEGAL_POINTER_VALUE. This means that if one of the
>> pointers that is aliased to the pp_magic field (such as page->lru.next)
>> is dereferenced while the page is owned by page_pool, that could lead to
>> a dereference into userspace, which is a security concern. The risk of
>> this is mitigated by the fact that (a) we always clear pp_magic before
>> releasing a page from page_pool, and (b) this would need a
>> use-after-free bug for struct page, which can have many other risks
>> since page->lru.next is used as a generic list pointer in multiple
>> places in the kernel. As such, with this patch we take the position that
>> this risk is negligible in practice. For more discussion, see[1].

The below is a recent UAF for a page, I guess it can be said that this
patch seem to basically make mmap_min_addr mechanism useless for the above
arches when a driver with page_pool dma mapping support is loaded:
https://lore.kernel.org/all/Z878K7JQ93LqBdCB@casper.infradead.org/

So how about logging a warning so that user can tell if their system may
be in security compromised state for the above case?

>>
>> Since all the tracking added in this patch is performed on DMA
>> map/unmap, no additional code is needed in the fast path, meaning the
>> performance overhead of this tracking is negligible there. A
>> micro-benchmark shows that the total overhead of the tracking itself is
>> about 400 ns (39 cycles(tsc) 395.218 ns; sum for both map and unmap[2]).
>> Since this cost is only paid on DMA map and unmap, it seems like an
>> acceptable cost to fix the late unmap issue. Further optimisation can
>> narrow the cases where this cost is paid (for instance by eliding the
>> tracking when DMA map/unmap is a no-op).
>>
> What I am missing here, what is the added cost of those extra operations on
> the slow path compared to before this patch? Total overhead being
> acceptable doesn't justify the change, we need diff before and after.

Toke used my data in [2] below:
The above 400ns is the added cost of those extra operations on the slow path,
before this patch the slow path only cost about 170ns, so there is more than
200% performance degradation for the page tracking in this patch, which I
failed to see why it is acceptable:(

> 
>> The extra memory needed to track the pages is neatly encapsulated inside
>> xarray, which uses the 'struct xa_node' structure to track items. This
>> structure is 576 bytes long, with slots for 64 items, meaning that a
>> full node occurs only 9 bytes of overhead per slot it tracks (in
>> practice, it probably won't be this efficient, but in any case it should
>> be an acceptable overhead).
>>
>> [0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/
>> [1] https://lore.kernel.org/r/20250320023202.GA25514@openwall.com
>> [2] https://lore.kernel.org/r/ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com



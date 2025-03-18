Return-Path: <bpf+bounces-54308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9DDA67422
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 13:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4438189BB23
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CB820C49B;
	Tue, 18 Mar 2025 12:40:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079020C02D;
	Tue, 18 Mar 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301604; cv=none; b=K3fF6CFZ0qocGArmGgw441wxhr1/XYtCuUieYjmDhZCjKPl9opM/hN9DNJGF4FU9c5Wuht5JIX2+y5tnpsBE9xoa2s+OlSAL6WF91aHclEkNNQJcJ6FXlXlCCb/y0yYvDwgbCl0oW2c9fXUT9R40LJmrHgYd2ewr0NBWcM5Qgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301604; c=relaxed/simple;
	bh=R5N3kWFhUrqILW5PrwqrHX1ifNxovTVrLKDlFbMYDDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TidPjWmAoBfV5ggmlNd13wnI+CB1Ti+/tP5Jj/sIuw7ZgMFW/RUWohk679ZPcSg5b2gOWwkIrrAd4fPFUDPvUq5YdHRDo4woFsBydBxb4axPOiw8Bw1Qmg9lx/xMbaAtgHxV3NCTP/oCtPE8F5cDmJyvplZ1mktr8ePCmSNotkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZHBDF08cTz2Cd0h;
	Tue, 18 Mar 2025 20:36:45 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F2FA140159;
	Tue, 18 Mar 2025 20:39:58 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Mar 2025 20:39:58 +0800
Message-ID: <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com>
Date: Tue, 18 Mar 2025 20:39:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Yunsheng
 Lin <yunshenglin0825@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>, Yonglong
 Liu <liuyonglong@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	IOMMU <iommu@lists.linux.dev>, <segoon@openwall.com>, <solar@openwall.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <87jz8nhelh.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/17 23:16, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
> 
>> On 3/14/2025 6:10 PM, Toke Høiland-Jørgensen wrote:
>>
>> ...
>>
>>>
>>> To avoid having to walk the entire xarray on unmap to find the page
>>> reference, we stash the ID assigned by xa_alloc() into the page
>>> structure itself, using the upper bits of the pp_magic field. This
>>> requires a couple of defines to avoid conflicting with the
>>> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
>>> so does not affect run-time performance. The bitmap calculations in this
>>> patch gives the following number of bits for different architectures:
>>>
>>> - 24 bits on 32-bit architectures
>>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
>>> - 32 bits on other 64-bit architectures
>>
>>  From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
>> "The page->signature field is aliased to page->lru.next and
>> page->compound_head, but it can't be set by mistake because the
>> signature value is a bad pointer, and can't trigger a false positive
>> in PageTail() because the last bit is 0."
>>
>> And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1,2} 
>> offset"):
>> "Poison pointer values should be small enough to find a room in
>> non-mmap'able/hardly-mmap'able space."
>>
>> So the question seems to be:
>> 1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
>>     easier-mmap'able space? If yes, how can we make sure this will not
>>     cause any security problem?
>> 2. Is the masking the page->pp_magic causing a valid pionter for
>>     page->lru.next or page->compound_head to be treated as a vaild
>>     PP_SIGNATURE? which might cause page_pool to recycle a page not
>>     allocated via page_pool.
> 
> Right, so my reasoning for why the defines in this patch works for this
> is as follows: in both cases we need to make sure that the ID stashed in
> that field never looks like a valid kernel pointer. For 64-bit arches
> (where CONFIG_ILLEGAL_POINTER_VALUE), we make sure of this by never
> writing to any bits that overlap with the illegal value (so that the
> PP_SIGNATURE written to the field keeps it as an illegal pointer value).
> For 32-bit arches, we make sure of this by making sure the top-most bit
> is always 0 (the -1 in the define for _PP_DMA_INDEX_BITS) in the patch,
> which puts it outside the range used for kernel pointers (AFAICT).

Is there any season you think only kernel pointer is relevant here?
It seems it is not really only about kernel pointers as round_hint_to_min()
in mm/mmap.c suggests and the commit log in the above commit 8a5e5e02fc83
if I understand it correctly:
"Given unprivileged users cannot mmap anything below mmap_min_addr, it
should be safe to use poison pointers lower than mmap_min_addr."

And the above "making sure the top-most bit is always 0" doesn't seems to
ensure page->signature to be outside the range used for kernel pointers
for 32-bit arches with VMSPLIT_1G defined, see arch/arm/Kconfig, there
is a similar config for x86 too:
       prompt "Memory split"
       depends on MMU
       default VMSPLIT_3G
       help
         Select the desired split between kernel and user memory.

         If you are not absolutely sure what you are doing, leave this
         option alone!

       config VMSPLIT_3G
              bool "3G/1G user/kernel split"
       config VMSPLIT_3G_OPT
             depends on !ARM_LPAE
              bool "3G/1G user/kernel split (for full 1G low memory)"
       config VMSPLIT_2G
              bool "2G/2G user/kernel split"
       config VMSPLIT_1G
              bool "1G/3G user/kernel split"

IMHO, even if some trick like above is really feasible, it may be
adding some limitation or complexity to the ARCH and MM subsystem, for
example, stashing the ID in page->signature may cause 0x*40 signature
to be unusable for other poison pointer purpose, it makes more sense to
make it obvious by doing the above trick in some MM header file like
poison.h instead of in the page_pool subsystem.

> 
>>> Since all the tracking is performed on DMA map/unmap, no additional code
>>> is needed in the fast path, meaning the performance overhead of this
>>> tracking is negligible. A micro-benchmark shows that the total overhead
>>> of using xarray for this purpose is about 400 ns (39 cycles(tsc) 395.218
>>> ns; sum for both map and unmap[1]). Since this cost is only paid on DMA
>>> map and unmap, it seems like an acceptable cost to fix the late unmap
>>
>> For most use cases when PP_FLAG_DMA_MAP is set and IOMMU is off, the
>> DMA map and unmap operation is almost negligible as said below, so the
>> cost is about 200% performance degradation, which doesn't seems like an
>> acceptable cost.
> 
> I disagree. This only impacts the slow path, as long as pages are
> recycled there is no additional cost. While your patch series has
> demonstrated that it is *possible* to reduce the cost even in the slow
> path, I don't think the complexity cost of this is worth it.

It is still the datapath otherwise there isn't a specific testing
for that use case, more than 200% performance degradation is too much
IHMO.

Let aside the above severe performance degradation, reusing space in
page->signature seems to be a tradeoff between adding complexity in
page_pool subsystem and in VM/ARCH subsystem as mentioned above.

> 
> [...]
> 
>>> The extra memory needed to track the pages is neatly encapsulated inside
>>> xarray, which uses the 'struct xa_node' structure to track items. This
>>> structure is 576 bytes long, with slots for 64 items, meaning that a
>>> full node occurs only 9 bytes of overhead per slot it tracks (in
>>> practice, it probably won't be this efficient, but in any case it should
>>
>> Is there any debug infrastructure to know if it is not this efficient?
>> as there may be 576 byte overhead for a page for the worst case.
> 
> There's an XA_DEBUG define which enables some dump functions, but I
> don't think there's any API to inspect the memory usage. I guess you
> could attach a BPF program and walk the structure, or something?
> 

It seems the XA_DEBUG is not defined in production environment.
And I am not familiar enough with BPF program to understand if the
BPF way is feasiable in production environment.
Any example for the above BPF program and how to attach it?


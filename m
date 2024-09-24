Return-Path: <bpf+bounces-40242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFDB983FA6
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 09:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC01C2264C
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 07:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2A814BF8F;
	Tue, 24 Sep 2024 07:48:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6811CBD;
	Tue, 24 Sep 2024 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164109; cv=none; b=iSPjxuqId/yNI5J2ayP1+OXMh6eH63oxTUK8y/DShyVHcjSJtqbQIgkGRVWLPpQhl/nzqRyypMAefVmFZh6Y8BP2t9TqU2dC2wrIZZROqFmgJ+clZhuNaFM7TtURAUddsia+LZKal7U6XMU9VULdffOKWo7VJGtMRJB56Qsz2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164109; c=relaxed/simple;
	bh=CSwaPVNkAQ30B+hlvci2uTj9rmPm9lc0sX+C9imgF5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QG76Hmq18YpOZ3DUm33gs9RQKSzsAzckRxzbGrgd9NrU4ok1vdMABzXN3L7yERz4OmE7p2eWZqm6lcd4CulqvPuihmU1Db9ev7jh3wMwkAESau9MoEE1tXDb+p7i3graAc9DfHDFeY51HkklPU400PKy54GDbOdpfJ13eap7ARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XCX5H6pvcz2QTxJ;
	Tue, 24 Sep 2024 15:47:31 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A6BD31A016C;
	Tue, 24 Sep 2024 15:48:17 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Sep 2024 15:48:17 +0800
Message-ID: <64730d70-e5b7-4117-9ee8-43f23543eafd@huawei.com>
Date: Tue, 24 Sep 2024 15:48:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Gur Stavi <gur.stavi@huawei.com>
CC: <akpm@linux-foundation.org>, <aleksander.lobakin@intel.com>,
	<alexander.duyck@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<anthony.l.nguyen@intel.com>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<fanghaiqing@huawei.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<imx@lists.linux.dev>, <intel-wired-lan@lists.osuosl.org>,
	<iommu@lists.linux.dev>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<kvalo@kernel.org>, <leon@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<liuyonglong@huawei.com>, <lorenzo@kernel.org>, <matthias.bgg@gmail.com>,
	<nbd@nbd.name>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <robin.murphy@arm.com>,
	<ryder.lee@mediatek.com>, <saeedm@nvidia.com>, <sean.wang@mediatek.com>,
	<shayne.chen@mediatek.com>, <shenwei.wang@nxp.com>, <tariqt@nvidia.com>,
	<wei.fang@nxp.com>, <xiaoning.wang@nxp.com>, <zhangkun09@huawei.com>
References: <2fb8d278-62e0-4a81-a537-8f601f61e81d@huawei.com>
 <20240924064559.1681488-1-gur.stavi@huawei.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20240924064559.1681488-1-gur.stavi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/24 14:45, Gur Stavi wrote:
>>>>> With all the caching in the network stack, some pages may be
>>>>> held in the network stack without returning to the page_pool
>>>>> soon enough, and with VF disable causing the driver unbound,
>>>>> the page_pool does not stop the driver from doing it's
>>>>> unbounding work, instead page_pool uses workqueue to check
>>>>> if there is some pages coming back from the network stack
>>>>> periodically, if there is any, it will do the dma unmmapping
>>>>> related cleanup work.
>>>>>
>>>>> As mentioned in [1], attempting DMA unmaps after the driver
>>>>> has already unbound may leak resources or at worst corrupt
>>>>> memory. Fundamentally, the page pool code cannot allow DMA
>>>>> mappings to outlive the driver they belong to.
>>>>>
>>>>> Currently it seems there are at least two cases that the page
>>>>> is not released fast enough causing dma unmmapping done after
>>>>> driver has already unbound:
>>>>> 1. ipv4 packet defragmentation timeout: this seems to cause
>>>>>    delay up to 30 secs:
>>>>>
>>>>> 2. skb_defer_free_flush(): this may cause infinite delay if
>>>>>    there is no triggering for net_rx_action().
>>>>>
>>>>> In order not to do the dma unmmapping after driver has already
>>>>> unbound and stall the unloading of the networking driver, add
>>>>> the pool->items array to record all the pages including the ones
>>>>> which are handed over to network stack, so the page_pool can
>>>>> do the dma unmmapping for those pages when page_pool_destroy()
>>>>> is called.
>>>>
>>>> So, I was thinking of a very similar idea. But what do you mean by
>>>> "all"? The pages that are still in caches (slow or fast) of the pool
>>>> will be unmapped during page_pool_destroy().
>>>
>>> Yes, it includes the one in pool->alloc and pool->ring.
>>
>> It worths mentioning that there is a semantics changing here:
>> Before this patch, there can be almost unlimited inflight pages used by
>> driver and network stack, as page_pool doesn't really track those pages.
>> After this patch, as we use a fixed-size pool->items array to track the
>> inflight pages, the inflight pages is limited by the pool->items, currently
>> the size of pool->items array is calculated as below in this patch:
>>
>> +#define PAGE_POOL_MIN_ITEM_CNT	512
>> +	unsigned int item_cnt = (params->pool_size ? : 1024) +
>> +				PP_ALLOC_CACHE_SIZE + PAGE_POOL_MIN_ITEM_CNT;
>>
>> Personally I would consider it is an advantage to limit how many pages which
>> are used by the driver and network stack, the problem seems to how to decide
>> the limited number of page used by network stack so that performance is not
>> impacted.
> 
> In theory, with respect to the specific problem at hand, you only have
> a limit on the number of mapped pages inflight. Once you reach this
> limit you can unmap these old pages, forget about them and remember
> new ones.

Yes, it can be done theoretically.
The tricky part seems to be how to handle the concurrency problem when
we evict the old pages and the old pages are also returned back to the
page_pool concurrently without any locking or lockless operation.

For now each item has only one producer and one consumer, so we don't
really have to worry about the concurrency problem before calling
page_pool_item_uninit() in page_pool_destroy() to do the unmapping
for the inflight pages by using a newly added 'destroy_lock' lock.


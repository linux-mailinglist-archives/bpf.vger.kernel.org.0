Return-Path: <bpf+bounces-40236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B9983D53
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 08:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219481F23F44
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 06:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C4D823D1;
	Tue, 24 Sep 2024 06:47:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E31E515;
	Tue, 24 Sep 2024 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160433; cv=none; b=DsB2a/y0X/A6CZWjkpjVXN62FWJCVbx5kA0n5tkQXJwzDuzgqkfXKWjCcVF9DQ6S9K9cT8ZXSBP0DeFbpT/HqA2WrNpXIMrlDtB15yCJ67sga4vIbhN7fGa67OCfpvIo9Ao6Yhz+L5zXAVGcju6j6LM9yj0FeGuEQSog9ScnSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160433; c=relaxed/simple;
	bh=eU2hnVzQrG1TIFcdYq+7+iCa3lWVqm+QQXfhMDdsbic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChoScf/QaVCTZnrdx2GOBx5BW+xwnmZr79TVqMK7uZKlMI4715B5vTItr9dT8CzDTnwlur8AaJjdiARMHMZcoUQfwzPLQI6QkTmawcpURpUxWg7IXzUxJgknHN2wyYfpdMRPAhNZVrFYi5TvsGBOLTJQZYo+3tqX0MfRCBbAoJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XCVl40H3fz6J6DN;
	Tue, 24 Sep 2024 14:46:40 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id EE8BB140B63;
	Tue, 24 Sep 2024 14:47:07 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 08:46:45 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <linyunsheng@huawei.com>
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
Subject: Re: [PATCH net 2/2] page_pool: fix IOMMU crash when driver has already unbound
Date: Tue, 24 Sep 2024 09:45:59 +0300
Message-ID: <20240924064559.1681488-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2fb8d278-62e0-4a81-a537-8f601f61e81d@huawei.com>
References: <2fb8d278-62e0-4a81-a537-8f601f61e81d@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

>>>> With all the caching in the network stack, some pages may be
>>>> held in the network stack without returning to the page_pool
>>>> soon enough, and with VF disable causing the driver unbound,
>>>> the page_pool does not stop the driver from doing it's
>>>> unbounding work, instead page_pool uses workqueue to check
>>>> if there is some pages coming back from the network stack
>>>> periodically, if there is any, it will do the dma unmmapping
>>>> related cleanup work.
>>>>
>>>> As mentioned in [1], attempting DMA unmaps after the driver
>>>> has already unbound may leak resources or at worst corrupt
>>>> memory. Fundamentally, the page pool code cannot allow DMA
>>>> mappings to outlive the driver they belong to.
>>>>
>>>> Currently it seems there are at least two cases that the page
>>>> is not released fast enough causing dma unmmapping done after
>>>> driver has already unbound:
>>>> 1. ipv4 packet defragmentation timeout: this seems to cause
>>>>    delay up to 30 secs:
>>>>
>>>> 2. skb_defer_free_flush(): this may cause infinite delay if
>>>>    there is no triggering for net_rx_action().
>>>>
>>>> In order not to do the dma unmmapping after driver has already
>>>> unbound and stall the unloading of the networking driver, add
>>>> the pool->items array to record all the pages including the ones
>>>> which are handed over to network stack, so the page_pool can
>>>> do the dma unmmapping for those pages when page_pool_destroy()
>>>> is called.
>>>
>>> So, I was thinking of a very similar idea. But what do you mean by
>>> "all"? The pages that are still in caches (slow or fast) of the pool
>>> will be unmapped during page_pool_destroy().
>>
>> Yes, it includes the one in pool->alloc and pool->ring.
>
> It worths mentioning that there is a semantics changing here:
> Before this patch, there can be almost unlimited inflight pages used by
> driver and network stack, as page_pool doesn't really track those pages.
> After this patch, as we use a fixed-size pool->items array to track the
> inflight pages, the inflight pages is limited by the pool->items, currently
> the size of pool->items array is calculated as below in this patch:
>
> +#define PAGE_POOL_MIN_ITEM_CNT	512
> +	unsigned int item_cnt = (params->pool_size ? : 1024) +
> +				PP_ALLOC_CACHE_SIZE + PAGE_POOL_MIN_ITEM_CNT;
>
> Personally I would consider it is an advantage to limit how many pages which
> are used by the driver and network stack, the problem seems to how to decide
> the limited number of page used by network stack so that performance is not
> impacted.

In theory, with respect to the specific problem at hand, you only have
a limit on the number of mapped pages inflight. Once you reach this
limit you can unmap these old pages, forget about them and remember
new ones.


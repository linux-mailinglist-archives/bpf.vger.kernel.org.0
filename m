Return-Path: <bpf+bounces-51398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C261A33D8F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 12:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3387A2B2A
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 11:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CB6214801;
	Thu, 13 Feb 2025 11:13:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1D20AF66;
	Thu, 13 Feb 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445222; cv=none; b=eEdBHXCUlTISt8RKmFfEKQTCzLlqkdSt6kxtbw/UtvnC1qKNtdEC4K5pPUrmc4rLMWOg/heBoVXY3VsDdXZZy8c2BoyEthkL7H4Zo+GkBUVPFil5s228LuzdynaDLjBRfINdZu8BrQY04S7ezj9JmizsDOn9HScswIo0zosoKS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445222; c=relaxed/simple;
	bh=uBbuyzSkt8awEsdjpCoyug75xEtJcJzY3ERuKiAc0z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q5Jdhdnf7ac6bha3KNoN0ROIoIi24r2engAcs/9AQJim9X4vS+aaNV5w+yLMkO7sHLHCf240NeeF9hprEpvxTLwlxXKN6gZRHXpI7vyD8lhK1yJJrI8tRtcr+1wWo65YkWa3uWeRIMHlgj3G+mdmxk0wz/294RCQFZf+66cMnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ytsrv5vcRz2FdXd;
	Thu, 13 Feb 2025 19:09:35 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0608A180042;
	Thu, 13 Feb 2025 19:13:23 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 19:13:22 +0800
Message-ID: <febbedb5-4d37-4799-83f6-6f1add26a2fd@huawei.com>
Date: Thu, 13 Feb 2025 19:13:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/4] fix the DMA API misuse problem for
 page_pool
To: Matthew Wilcox <willy@infradead.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<zhangkun09@huawei.com>, <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>, MM
	<linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
References: <20250212092552.1779679-1-linyunsheng@huawei.com>
 <Z6zuLJU7o_gRsQRu@casper.infradead.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <Z6zuLJU7o_gRsQRu@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/2/13 2:53, Matthew Wilcox wrote:
> On Wed, Feb 12, 2025 at 05:25:47PM +0800, Yunsheng Lin wrote:
>> This patchset fix the dma API misuse problem as mentioned in [1].
>>
>> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
> 
> That's a very long and complicated thread.  I gave up.  You need to
> provide a proper description of the problem.

The description of the problem is in the commit log of patch 2
as something below:
"Networking driver with page_pool support may hand over page
still with dma mapping to network stack and try to reuse that
page after network stack is done with it and passes it back
to page_pool to avoid the penalty of dma mapping/unmapping.
With all the caching in the network stack, some pages may be
held in the network stack without returning to the page_pool
soon enough, and with VF disable causing the driver unbound,
the page_pool does not stop the driver from doing it's
unbounding work, instead page_pool uses workqueue to check
if there is some pages coming back from the network stack
periodically, if there is any, it will do the dma unmmapping
related cleanup work.

As mentioned in [1], attempting DMA unmaps after the driver
has already unbound may leak resources or at worst corrupt
memory. Fundamentally, the page pool code cannot allow DMA
mappings to outlive the driver they belong to."


The description of the fixing is also in the commit log of patch 2
as below:
"By using the 'struct page_pool_item' referenced by page->pp_item,
page_pool is not only able to keep track of the inflight page to
do dma unmmaping if some pages are still handled in networking
stack when page_pool_destroy() is called, and networking stack is
also able to find the page_pool owning the page when returning
pages back into page_pool:
1. When a page is added to the page_pool, an item is deleted from
   pool->hold_items and set the 'pp_netmem' pointing to that page
   and set item->state and item->pp_netmem accordingly in order to
   keep track of that page, refill from pool->release_items when
   pool->hold_items is empty or use the item from pool->slow_items
   when fast items run out.
2. When a page is released from the page_pool, it is able to tell
   which page_pool this page belongs to by masking off the lower
   bits of the pointer to page_pool_item *item, as the 'struct
   page_pool_item_block' is stored in the top of a struct page. And
   after clearing the pp_item->state', the item for the released page
   is added back to pool->release_items so that it can be reused for
   new pages or just free it when it is from the pool->slow_items.
3. When page_pool_destroy() is called, item->state is used to tell if
   a specific item is being used/dma mapped or not by scanning all the
   item blocks in pool->item_blocks, then item->netmem can be used to
   do the dma unmmaping if the corresponding inflight page is dma
   mapped."

it is worth to mention that the changing of page->pp to page->pp_item
for the above fix may be able to enable the decoupling page_pool from
using the metadata of 'struct page' if folios only provide a memdesc
pointer to the page_pool subsystem in the future as pp_item may be
used as the metadata replacement of existing 'struct page'.

> 


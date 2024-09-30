Return-Path: <bpf+bounces-40547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24333989CEE
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 10:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C31B2449A
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885F23FB0E;
	Mon, 30 Sep 2024 08:38:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21517BB38;
	Mon, 30 Sep 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685534; cv=none; b=kjBYO881+W7w9eNuLwB65y+Ax11HmRPVdZZspiA5npN+1HEjmtbbD4dJSZng5tbrU9iXP/hZ15u609zXLSAlQCJO9J1yAElFGCZ9QCTZUVOyAiX+wE5sFWUKbJJhV9djz7l/kAjt1NkaEPMRnw6g5tEi5aYbzZo8ldk+HiJh9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685534; c=relaxed/simple;
	bh=TCAu0YxfZ7XwQ7EJrXWX7h4UBhonVS5YLNk5f81Jut0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SkVGwNHbuTvR9HfE605siK6KROIfMAu82adSJXYK9HUnwqU/Ty87y/0wU447tuanAQDxELrrtrOndptauj5k1SPS8FqA6aFj3nc1lfmWx/aWYvA6uCp+jmBEFTCdI4+XXxtVx61whifJfuvCFLUHftDR2eP4A+AwRHiMexHJWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XHDwY3YV3z1SC0g;
	Mon, 30 Sep 2024 16:37:49 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B68231400CB;
	Mon, 30 Sep 2024 16:38:43 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Sep 2024 16:38:43 +0800
Message-ID: <ed399e31-cfe5-4504-9537-88879afac53d@huawei.com>
Date: Mon, 30 Sep 2024 16:38:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Mina Almasry <almasrymina@google.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle Valo
	<kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Andrew
 Morton <akpm@linux-foundation.org>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-mm@kvack.org>
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com>
 <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
 <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com>
 <CAC_iWjLgNOtsbhqrhvvEz2C3S668qB8KatL_W+tPHMSkDrNS=w@mail.gmail.com>
 <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com>
 <CAC_iWjKeajwn3otjdEekE6VDLHGEvqmnQRwpN5R3yHj8UpEiDw@mail.gmail.com>
 <934d601f-be43-4e04-b126-dc86890a4bfa@huawei.com>
 <CAC_iWjL7m4ZL2W2OZM5F22dLvZhxU6fyCXV_xjyGf+W7UP43EQ@mail.gmail.com>
 <ac2eec69-8f44-4adb-8182-02c78625851d@huawei.com>
 <CAC_iWj+Shb6buVf+wZaWe-NZ+UVxmW9DYqsTiL27U+V_Ko_65w@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAC_iWj+Shb6buVf+wZaWe-NZ+UVxmW9DYqsTiL27U+V_Ko_65w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/30 16:09, Ilias Apalodimas wrote:
> On Sun, 29 Sept 2024 at 05:44, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/9/28 15:34, Ilias Apalodimas wrote:
>>
>> ...
>>
>>>
>>> Yes, that wasn't very clear indeed, apologies for any confusion. I was
>>> trying to ask on a linked list that only lives in struct page_pool.
>>> But I now realize this was a bad idea since the lookup would be way
>>> slower.
>>>
>>>> If I understand question correctly, the single/doubly linked list
>>>> is more costly than array as the page_pool case as my understanding.
>>>>
>>>> For single linked list, it doesn't allow deleting a specific entry but
>>>> only support deleting the first entry and all the entries. It does support
>>>> lockless operation using llist, but have limitation as below:
>>>> https://elixir.bootlin.com/linux/v6.7-rc8/source/include/linux/llist.h#L13
>>>>
>>>> For doubly linked list, it needs two pointer to support deleting a specific
>>>> entry and it does not support lockless operation.
>>>
>>> I didn't look at the patch too carefully at first. Looking a bit
>>> closer now, the array is indeed better, since the lookup is faster.
>>> You just need the stored index in struct page to find the page we need
>>> to unmap. Do you remember if we can reduce the atomic pp_ref_count to
>>> 32bits? If so we can reuse that space for the index. Looking at it
>>
>> For 64 bits system, yes, we can reuse that.
>> But for 32 bits system, we may have only 16 bits for each of them, and it
>> seems that there is no atomic operation for variable that is less than 32
>> bits.
>>
>>> requires a bit more work in netmem, but that's mostly swapping all the
>>> atomic64 calls to atomic ones.
>>>
>>>>
>>>> For pool->items, as the alloc side is protected by NAPI context, and the
>>>> free side use item->pp_idx to ensure there is only one producer for each
>>>> item, which means for each item in pool->items, there is only one consumer
>>>> and one producer, which seems much like the case when the page is not
>>>> recyclable in __page_pool_put_page, we don't need a lock protection when
>>>> calling page_pool_return_page(), the 'struct page' is also one consumer
>>>> and one producer as the pool->items[item->pp_idx] does:
>>>> https://elixir.bootlin.com/linux/v6.7-rc8/source/net/core/page_pool.c#L645
>>>>
>>>> We only need a lock protection when page_pool_destroy() is called to
>>>> check if there is inflight page to be unmapped as a consumer, and the
>>>> __page_pool_put_page() may also called to unmapped the inflight page as
>>>> another consumer,
>>>
>>> Thanks for the explanation. On the locking side, page_pool_destroy is
>>> called once from the driver and then it's either the workqueue for
>>> inflight packets or an SKB that got freed and tried to recycle right?
>>> But do we still need to do all the unmapping etc from the delayed
>>> work? Since the new function will unmap all packets in
>>> page_pool_destroy, we can just skip unmapping when the delayed work
>>> runs
>>
>> Yes, the pool->dma_map is clear in page_pool_item_uninit() after it does
>> the unmapping for all inflight pages with the protection of pool->destroy_lock,
>> so that the unmapping is skipped in page_pool_return_page() when those inflight
>> pages are returned back to page_pool.
> 
> Ah yes, the entire destruction path is protected which seems correct.
> Instead of that WARN_ONCE in page_pool_item_uninit() can we instead
> check the number of inflight packets vs what we just unmapped? IOW
> check 'mask' against what page_pool_inflight() gives you and warn if
> those aren't equal.
Yes, it seems it is quite normal to trigger the warning from testing,
it makes sense to check it against page_pool_inflight() to catch some
bug of tracking/calculating inflight pages.

> 
> 
> Thanks
> /Ilias
>>
>>>


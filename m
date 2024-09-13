Return-Path: <bpf+bounces-39811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF1977C44
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9DD1C24902
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4B31D79AA;
	Fri, 13 Sep 2024 09:35:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03B175D45;
	Fri, 13 Sep 2024 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220159; cv=none; b=pwnTLeJbFnS3TxZlV8iym5tRfZqI6ECiNRvM2zR257xZaYmDLyjDDIjDyVaMZ1e2wCbxhukm+O/0UwcxI8DqVO2fBhcS8fvWbKyOp1uqkSU7ARz6pPcz+gi89rfltRHN+h4PislRIvb+AtqiJJVh9jr7UkflHnDwXK5mO9SBhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220159; c=relaxed/simple;
	bh=Kq+ZW0trtXLDeahV2skxFysYfWalXik5sgiriea1S1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o0bX++E4YPY13b37aXb6CQJGcfvc34bfzdPndJn1GPkvAUUk3hik3uj1OnoqZRhu6djGCp4t36XkI92hGODs7S+Xv8CiLEEQoLFPkIULGZPvltZlbRC00oUV++LVh6jiJgq4dFM14yDpKBaL/GMRb4A57Q/RjwV2FYA1UZ57PHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X4q0m4b9zz2CpYn;
	Fri, 13 Sep 2024 17:35:20 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 79E181402CE;
	Fri, 13 Sep 2024 17:35:52 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Sep 2024 17:35:51 +0800
Message-ID: <00c41a5b-6a5b-4ee1-b0e2-eae819e3cf3b@huawei.com>
Date: Fri, 13 Sep 2024 17:35:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] page_pool: fix IOMMU crash when driver has already
 unbound
To: Mina Almasry <almasrymina@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<liuyonglong@huawei.com>, <fanghaiqing@huawei.com>, Robin Murphy
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
 Morton <akpm@linux-foundation.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-mm@kvack.org>
References: <20240912124514.2329991-1-linyunsheng@huawei.com>
 <20240912124514.2329991-3-linyunsheng@huawei.com>
 <CAHS8izPc8fy08mL1RJtnxiOvTx=Uk037Q5SKobC80jQocEKMJQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAHS8izPc8fy08mL1RJtnxiOvTx=Uk037Q5SKobC80jQocEKMJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/12 22:25, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 5:51 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> Networking driver with page_pool support may hand over page
>> still with dma mapping to network stack and try to reuse that
>> page after network stack is done with it and passes it back
>> to page_pool to avoid the penalty of dma mapping/unmapping.
>> With all the caching in the network stack, some pages may be
>> held in the network stack without returning to the page_pool
>> soon enough, and with VF disable causing the driver unbound,
>> the page_pool does not stop the driver from doing it's
>> unbounding work, instead page_pool uses workqueue to check
>> if there is some pages coming back from the network stack
>> periodically, if there is any, it will do the dma unmmapping
>> related cleanup work.
>>
>> As mentioned in [1], attempting DMA unmaps after the driver
>> has already unbound may leak resources or at worst corrupt
>> memory. Fundamentally, the page pool code cannot allow DMA
>> mappings to outlive the driver they belong to.
>>
>> Currently it seems there are at least two cases that the page
>> is not released fast enough causing dma unmmapping done after
>> driver has already unbound:
>> 1. ipv4 packet defragmentation timeout: this seems to cause
>>    delay up to 30 secs:
>>
>> 2. skb_defer_free_flush(): this may cause infinite delay if
>>    there is no triggering for net_rx_action().
>>
>> In order not to do the dma unmmapping after driver has already
>> unbound and stall the unloading of the networking driver, add
>> the pool->items array to record all the pages including the ones
>> which are handed over to network stack, so the page_pool can
>> do the dma unmmapping for those pages when page_pool_destroy()
>> is called.
>>
> 
> The approach in this patch is a bit complicated. I wonder if there is
> something simpler that we can do. From reading the thread, it seems
> the issue is that in __page_pool_release_page_dma we're calling
> dma_unmap_page_attrs() on a pool->p.dev that has been deleted via
> device_del, right?
> 
> Why not consider pool->p.dev unusable if pool->destroy_cnt > 0? I.e.
> in __page_pool_release_page_dma, we can skip dma_unmap_page_attrs() if
> destry_cnt > 0?

The skipping is already done for __dma_sync_single_for_device() in this
patch, but not for dma_unmap_page_attrs(), see the clearing of dma_sync
in page_pool_destroy().

> 
> More generally, probably any use of pool->p.dev may be invalid if
> page_pool_destroy has been called. The call sites can be scrubbed for
> latent bugs.

As mentioned in commit log, attempting DMA unmaps after the driver has
already unbound may leak resources or at worst corrupt memory.
The skipping only avoid corrupting memory, but not leaking resources, as
there may be bounce buffer or iova resources before the dma mapping as my
understanding.

And when page_pool_destroy() is called, there is currently no way to
tell if the device is going to be invalid or not.

> 
> The hard part is handling the concurrency. I'm not so sure we can fix
> this without introducing some synchronization between the
> page_pool_destroy seeing the device go away and the code paths using
> the device. Are these being called from the fast paths? Jespers
> benchmark can tell for sure if there is any impact on the fast path.

It depends on what your definition of fast path here, there are three
kinds of fast path for page pool as my understanding.

For the first and second fast path, the synchronization cost is the
rcu read lock overhead introduced in patch 1.

For the third fast path when we need to refill from or flush to the
page allocator, the added overhead is the page_pool_item_add() and
page_pool_item_del() calling as my understanding.

Will provide the performance data in the next version.

> 
>> Note, the devmem patchset seems to make the bug harder to fix
>> and to backport too, this patch does not consider fixing the
>> case for devmem yet.
>>
> 
> FWIW from a quick look I did not see anything in this patch that is
> extremely hard to port to netmem. AFAICT the issue is that you skipped
> changing page_pool to page_pool_items in net_iov. Once that is done, I
> think the rest should be straightforward.

Does page_pool_item_uninit() need to handle 'netmem' case?

How does the devmem handle the case net_iov being cached in network stack
when the driver has already unbound? I am supposing there is a device for
dma_buf_unmap_attachment_unlocked(), and is it possible that the device
become invalid too when the driver has unbound? If yes, doesn't it have a
similar problem as the case of normal page?

> 


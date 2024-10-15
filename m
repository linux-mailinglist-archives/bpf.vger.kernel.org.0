Return-Path: <bpf+bounces-42007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B899E49D
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9221C24D48
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E2F1E7640;
	Tue, 15 Oct 2024 10:52:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5911E4110;
	Tue, 15 Oct 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989560; cv=none; b=XlA6kEDmLPrHtYkSIA2zw0wTUFcqbJ9Li3BXuNOA0KTvzKKtqVgUz4yTPa+5Q9WKS/7olHIYsRUHoCei7fxWLl2/m2FXzLgwQR75VDqMQzMKWEP3ugEl29jUvtCrFOzyL8AW83xnPpCgczPdJZaA/WJPt0SaUKiUZwTNToMeWzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989560; c=relaxed/simple;
	bh=JbYhV7N7Mb4Y/IMjLhPKo5oTfSI5VQYw4oDX2w97mTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y9m+drDEuBZCEsSRbzbLxKQv3wmaAAzMUNZ+IF9bmEKbBa95XVZs3Zbqzx6u6/rRvA9NMuGT8pBJGj2v/7hOE/61Ay8kRBK9g8Bz5YoxBDnKGbHjIVfL0s+4QdNeA+vtqwEsxa7CF43z2vhrT7NOptdqZuhJYxBhWUQ7RnOJ2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XSW8J5gS7zfdGR;
	Tue, 15 Oct 2024 18:50:08 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FC56140257;
	Tue, 15 Oct 2024 18:52:35 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Oct 2024 18:52:35 +0800
Message-ID: <5d9ea7bd-67bb-4a9d-a120-c8f290c31a47@huawei.com>
Date: Tue, 15 Oct 2024 18:52:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] fix two bugs related to page_pool
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <b1fd5ece-b967-4e56-ad4f-64ec437e2634@huawei.com>
 <20241014171406.43e730c9@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241014171406.43e730c9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/15 8:14, Jakub Kicinski wrote:
> On Sat, 12 Oct 2024 20:05:31 +0800 Yunsheng Lin wrote:
>> 1. Semantics changing of supporting unlimited inflight pages
>>    to limited inflight pages that are as large as the pool_size
>>    of page_pool.
> 
> How can this possibly work?

As a similar comment in [1], do we really need unlimited inflight pages
for the page_pool to work? If we do, it seems there is something really
need fixing here. I am agreed changing of semantics here might introduce
regressions here because there may be some subsystem depending on the
previous semantics or incorrect calculating of how many inflight pages it
is needed, so I am agreed that it might be better to target the net-next
tree to give some cycles of testing before backporting it.

1. https://lore.kernel.org/all/842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com/

> 
> The main thing stopping me from reposting my fix that it'd be nice to
> figure out if a real IOMMU device is bound or not. If we don't have

device_iommu_mapped() might be used to check if a real IOMMU device is
bound or not.
I am afraid it is not just about IOMMU here as there might be other
resource behind the dma mapping, like the bounce buffer memory as below:

https://elixir.bootlin.com/linux/v6.7-rc8/source/drivers/iommu/dma-iommu.c#L1204
https://elixir.bootlin.com/linux/v6.7-rc8/source/kernel/dma/direct.h#L125

And we may argue is_swiotlb_active() can be used check if there is any
bounce buffer memory behind the dma mapping as the device_iommu_mapped()
does, but I am not sure if there is any other resource besides iommu and
bounce buffer.

> real per-device mappings we presumably don't have to wait. If we can 

For not having to wait part:
I am not sure if the page_pool_destroy()/__page_pool_release_page_dma()
need to synchronize with arch_teardown_dma_ops() or how to synchronize
with it, as it seems to be called when driver unloading even if we have
ensured that there is no IOMMU or bounce buffer memory behind the device
by the above checking:
__device_release_driver -> device_unbind_cleanup -> arch_teardown_dma_ops

> check this condition we are guaranteed not to introduce regressions,
> since we would be replacing a crash by a wait, which is strictly better.

For the waiting part:
The problem is how much time we need to wait when device_iommu_mapped()
or is_swiotlb_active() return true here, as mentioned in [2], [3]. And
currently the waiting might be infinite as the testing in [4].

> 
> If we'd need to fiddle with too many internals to find out if we have
> to wait - let's just always wait and see if anyone complains.

Does the testing report in [4] classify as someone complaining? As
the driver unloading seems to be stalling forever, and the cause of the
infinite stalling is skb_attempt_defer_free() by debugging as mentioned
in [2].

2. https://lore.kernel.org/all/2c5ccfff-6ab4-4aea-bff6-3679ff72cc9a@huawei.com/
3. https://lore.kernel.org/netdev/d50ac1a9-f1e2-49ee-b89b-05dac9bc6ee1@huawei.com/
4. https://lore.kernel.org/netdev/758b4d47-c980-4f66-b4a4-949c3fc4b040@huawei.com/

> 


Return-Path: <bpf+bounces-40097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E997C86A
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 13:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CBC1C2555A
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C9119D89A;
	Thu, 19 Sep 2024 11:15:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C91319D88C;
	Thu, 19 Sep 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744519; cv=none; b=fv8ApJ+36r9H5oyWVI7U5dlDoRGe6N9w8/wdB6Kwaf9Aj0AZuGpdSB9Nk2XyWwut3Gl971Ap2Gs6jNtqGCAJavY1VNMFxZjD3snH/azwZd4YvUkUYH2/ogrMjpPX/UwkNQYS8l+nUj96BPZ4IdQc0HqS4KSExsPYLz1a2iPhPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744519; c=relaxed/simple;
	bh=RbDtzFY4xR7hRu6Pf3a1C6ue6w6zG+4Zddlf2w/ZKJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RF8EFl6HhyI6J43zTf7oCZLC/15LLxZ20AQtsd9gUJPyZlRqAEYE+sGvJipyCdF014anUyVx1RfdiUVH04wIA9vld5jJ46zVoOm3I4+Bl1dQcRosPKEvCTbd76JfaR8P0JKM15fbe721tFqjDp5zeczckzyjIzDUJoWVvfT3E9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X8XwS0qCqz2DcFV;
	Thu, 19 Sep 2024 19:14:32 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BC8361A016C;
	Thu, 19 Sep 2024 19:15:11 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Sep 2024 19:15:11 +0800
Message-ID: <cdfecd37-31d7-42d2-a8d8-92008285b42e@huawei.com>
Date: Thu, 19 Sep 2024 19:15:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<liuyonglong@huawei.com>, <fanghaiqing@huawei.com>, <zhangkun09@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau
	<nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
	<ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Andrew Morton
	<akpm@linux-foundation.org>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<bpf@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>
References: <20240918111826.863596-1-linyunsheng@huawei.com>
 <20240918111826.863596-3-linyunsheng@huawei.com>
 <CAC_iWjK=G7Oo5=pN2QunhasgDC6NyC1L+96jigX7u9ad+PbYng@mail.gmail.com>
 <894a3c2c-22f9-45b9-a82b-de7320066b42@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <894a3c2c-22f9-45b9-a82b-de7320066b42@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/19 17:42, Jesper Dangaard Brouer wrote:
> 
> On 18/09/2024 19.06, Ilias Apalodimas wrote:
>>> In order not to do the dma unmmapping after driver has already
>>> unbound and stall the unloading of the networking driver, add
>>> the pool->items array to record all the pages including the ones
>>> which are handed over to network stack, so the page_pool can
>>> do the dma unmmapping for those pages when page_pool_destroy()
>>> is called.
>>
>> So, I was thinking of a very similar idea. But what do you mean by
>> "all"? The pages that are still in caches (slow or fast) of the pool
>> will be unmapped during page_pool_destroy().
> 
> I really dislike this idea of having to keep track of all outstanding pages.
> 
> I liked Jakub's idea of keeping the netdev around for longer.
> 
> This is all related to destroying the struct device that have points to
> the DMA engine, right?

Yes, the problem seems to be that when device_del() is called, there is
no guarantee hw behind the 'struct device ' will be usable even if we
call get_device() on it.

> 
> Why don't we add an API that allow netdev to "give" struct device to
> page_pool.  And then the page_poll will take over when we can safely
> free the stuct device?

By 'allow netdev to "give" struct device to page_pool', does it mean
page_pool become the driver for the device?
If yes, it seems that is similar to jakub's idea, as both seems to stall
the calling of device_del() by not returning when the driver unloading.
If no, it seems that the problem is still existed when the driver for
the device has unbound after device_del() is called.

> 
> --Jesper


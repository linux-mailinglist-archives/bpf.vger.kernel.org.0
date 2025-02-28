Return-Path: <bpf+bounces-52837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA4EA48E85
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 03:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EA016EAF1
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 02:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74FD155393;
	Fri, 28 Feb 2025 02:23:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45832E628;
	Fri, 28 Feb 2025 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709415; cv=none; b=f5L4+VLT5OP1XZre59lHcZgNgBM5UydmkjEuLYIgU9PMRVLZ/V9rSP8ql1+2CC4EG7i7JETwRA2eMcQEpECduUYjDErijWol0unWfGLUo86ao99x3k2GiqE2BhDVyPt8mvYsFriz9pNrb5kKjF+HBhRFcse7Gbid7w0yKXdsnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709415; c=relaxed/simple;
	bh=7wG1NYOp+m+Pq/or5SdEgUzX1HYtcHjjMmMnc4MOhsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=lJfL7lclRvyV7vcKFzKy5zpPhrCHfoeXdDtUDHc0NEL9+lYySaJMDfch8zy+a2EYxde8rjjLT4YnLodcHaav7eWoXNA3WoQc0fOdHqF72Ow3Me/MEhRBk5g1bFrQG/JGYQaqyP0MUMdXeNGJqOgVu+HsG7AV8dFelTGFTLiVJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z3sRB30zpzVmVS;
	Fri, 28 Feb 2025 10:21:58 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F94B1402C3;
	Fri, 28 Feb 2025 10:23:30 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 10:23:28 +0800
Message-ID: <de39d59b-fce2-4dee-9986-f931619599fe@huawei.com>
Date: Fri, 28 Feb 2025 10:23:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 1/6] octeontx2-pf: use xdp_return_frame() to
 free xdp buffers
To: Suman Ghosh <sumang@marvell.com>, <horms@kernel.org>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lcherian@marvell.com>, <jerinj@marvell.com>,
	<john.fastabend@gmail.com>, <bbhushan2@marvell.com>, <hawk@kernel.org>,
	<andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<bpf@vger.kernel.org>, <larysa.zaremba@intel.com>
References: <20250213053141.2833254-1-sumang@marvell.com>
 <20250213053141.2833254-2-sumang@marvell.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250213053141.2833254-2-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/2/13 13:31, Suman Ghosh wrote:

> -		put_page(page);
>  		cq->pool_ptrs++;
> +		if (page->pp) {

It seems the above changing caused the below error for the DMA API misuse
patchset：
https://lore.kernel.org/oe-kbuild-all/202502280250.Bp3jD6ZE-lkp@intel.com/

And it seems this patch uses 'page->pp' being NULL or not to decide if a
page is page_pool owned or not, I am not sure if the buddy page allocator
will always ensure that memory that 'page->pp' points to will always be
zero, even if it is for now, It seems the driver should not use that to
decide if a page is page_pool owned or not.

The PP_SIGNATURE magic macro seems to be correct way to decide if the page
is page_pool owned or not when driver doesn't have its own way to decide
if a page is page_pool owned or not, see:
https://elixir.bootlin.com/linux/v6.14-rc1/source/net/core/skbuff.c#L924

> +			page_pool_recycle_direct(pool->page_pool, page);
> +		} else {
> +			otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
> +					    DMA_FROM_DEVICE);
> +			put_page(page);
> +		}
>  		return true;
>  	}
>  	return false;


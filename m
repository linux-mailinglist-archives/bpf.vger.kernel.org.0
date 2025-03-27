Return-Path: <bpf+bounces-54782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3932AA72A7D
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C3A189489F
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0027D1CCB21;
	Thu, 27 Mar 2025 07:21:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BCB225D7;
	Thu, 27 Mar 2025 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743060090; cv=none; b=tjkXA4/PIeeMFXW4Dh6IMoiinJ3WH5DEWvvUdPeiQYXHbY3nS0ixsz1LyPHujIR0Fe/ts23H2PsILRGl+pbWf93AsP2uslwdjrULotV1qhTTdUCSju11uCmsiBXmo3Y5lE+jcHysDD3AjqV2rmitFTHN48nSMs6hqGTjtpSBe0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743060090; c=relaxed/simple;
	bh=Hkk+TXBm+ainUsNZp9ZeIR4pFjXXsCXjRuCrIqTpmYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sQUOqSb0VAc475yCdXYmUJE7Sts1EG11est+p8N7vzCBwjbbXJCotWeLqCV91HNboge+9CPAICWkhGm9OCjHRf8WTWTf4UvzqcAJPTiv21mNfEFLSDklnlzjMmeQE75t8MZ3AskrZV6uEVnNfNr+qCNdQHgr/IWiXVz4Hsc52Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZNZkQ1vLdz2CdVr;
	Thu, 27 Mar 2025 15:18:06 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FA111800B3;
	Thu, 27 Mar 2025 15:21:23 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Mar 2025 15:21:23 +0800
Message-ID: <77cd9e2d-da66-4e8f-831d-87915465f98a@huawei.com>
Date: Thu, 27 Mar 2025 15:21:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Mina Almasry <almasrymina@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Yonglong Liu <liuyonglong@huawei.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com>
 <Z-RF4_yotcfvX0Xz@x130> <f1a33452-31a4-4651-8d4a-3650fd27174b@huawei.com>
 <CAHS8izPA+hmOkP=jZd3mm1Zux2uaqpOf0poEci-Jn1g7msfkbA@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAHS8izPA+hmOkP=jZd3mm1Zux2uaqpOf0poEci-Jn1g7msfkbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/27 12:59, Mina Almasry wrote:
> On Wed, Mar 26, 2025 at 8:54 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>
>>>> Since all the tracking added in this patch is performed on DMA
>>>> map/unmap, no additional code is needed in the fast path, meaning the
>>>> performance overhead of this tracking is negligible there. A
>>>> micro-benchmark shows that the total overhead of the tracking itself is
>>>> about 400 ns (39 cycles(tsc) 395.218 ns; sum for both map and unmap[2]).
>>>> Since this cost is only paid on DMA map and unmap, it seems like an
>>>> acceptable cost to fix the late unmap issue. Further optimisation can
>>>> narrow the cases where this cost is paid (for instance by eliding the
>>>> tracking when DMA map/unmap is a no-op).

See the above statement, and note the above optimisation was also discussed
before and it seemed unfeasible too.

> 
> what time_bench_page_pool03_slow actually does each iteration:
> - Allocates a page *from the fast path*
> - Frees a page to through the slow path (recycling disabled).
> 
> Notably it doesn't do anything in the slow path that I imagine is
> actually expensive: alloc_page, dma_map_page, & dma_unmap_page.

As above, for most arches, the DMA map/unmap seems to be almost no-op when
page_pool is created with PP_FLAG_DMA_MAP flag without IOMMU/swiotlb behind
the DMA MAPPING.

> 
> We do not have an existing benchmark case that actually tests the full
> cost of the slow path (i.e full cost of page_pool_alloc from slow path
> with dma-mapping and page_pool_put_page to the slow path with
> dma-unmapping). That test case would have given us the full picture in
> terms of % regression.
> 
> This is partly why I want to upstream the benchmark. Such cases can be
> added after it is upstreamed.

Why not add it now when you seemed to be arguing that exercising the code
path of dma_map_page() and dma_unmap_page() may change the full picture
here.


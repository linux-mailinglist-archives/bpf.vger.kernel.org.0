Return-Path: <bpf+bounces-54155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F38A63AFA
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 03:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B335C3AD5BC
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA11494A3;
	Mon, 17 Mar 2025 02:03:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8118F66;
	Mon, 17 Mar 2025 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742176982; cv=none; b=apwNk1yH1/Xf611o9iXmH0W4jF6PC+Ti/8myDmmk9PH/bKY+eRtE7SJdVz+7SVm64C98mqcUdYAMpnHAVBD0lK3vsGlnrKmFoQsIWt01Pg6rl8IYQxBoJn1Ppz5yHSeJ3xqq8iBs71f6idgNdSFo9PFpknOnrbW4scMCOEIkHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742176982; c=relaxed/simple;
	bh=yYHXnIYsaqcS+6IhtWhRNwEkzZ0hyG20mSczIi+VzjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j7B4Gb9h8TPG334CSIqvogAF7gwFGKNhHe0oLpQg/DsP7RlmVptSPXfSjCm35LU/KKmY13DQO+LTiAYTejVrI0IKCZHT0QtXVWa4Mw5PxpYZt0fdoYJSPp7bhAI7auHFpA0DL7W4NzsB6QGVDmDJ5cA2vurRgmyZLsHKfvg69u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZGJ9Y4JKwztQmx;
	Mon, 17 Mar 2025 10:01:21 +0800 (CST)
Received: from kwepemf200007.china.huawei.com (unknown [7.202.181.233])
	by mail.maildlp.com (Postfix) with ESMTPS id E9F83140391;
	Mon, 17 Mar 2025 10:02:49 +0800 (CST)
Received: from [10.67.121.184] (10.67.121.184) by
 kwepemf200007.china.huawei.com (7.202.181.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Mar 2025 10:02:48 +0800
Message-ID: <80bb0e6c-99eb-4c8f-ac00-0c048ec7bbb1@huawei.com>
Date: Mon, 17 Mar 2025 10:02:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] Fix late DMA unmap crash for page pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yunsheng Lin <linyunsheng@huawei.com>,
	Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
Content-Language: en-US
From: Yonglong Liu <liuyonglong@huawei.com>
In-Reply-To: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf200007.china.huawei.com (7.202.181.233)

I know this solution is still under discussion, but anyway, I tested the
scenarios I reported in:

[0]https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

It seems the problem has been solved. Thanks!


Tested-by: Yonglong Liu<liuyonglong@huawei.com>

On 2025/3/14 18:10, Toke Høiland-Jørgensen wrote:
> This series fixes the late dma_unmap crash for page pool first reported
> by Yonglong Liu in [0]. It is an alternative approach to the one
> submitted by Yunsheng Lin, most recently in [1]. The first two commits
> are small refactors of the page pool code, in preparation of the main
> change in patch 3. See the commit message of patch 3 for the details.
>
> -Toke
>
> [0] https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
> [1] https://lore.kernel.org/r/20250307092356.638242-1-linyunsheng@huawei.com
>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
> Toke Høiland-Jørgensen (3):
>        page_pool: Move pp_magic check into helper functions
>        page_pool: Turn dma_sync and dma_sync_cpu fields into a bitmap
>        page_pool: Track DMA-mapped pages and unmap them when destroying the pool
>
>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 +-
>   include/net/page_pool/helpers.h                  |  6 +-
>   include/net/page_pool/types.h                    | 54 +++++++++++++++-
>   mm/page_alloc.c                                  |  9 +--
>   net/core/devmem.c                                |  3 +-
>   net/core/netmem_priv.h                           | 33 +++++++++-
>   net/core/page_pool.c                             | 81 ++++++++++++++++++++----
>   net/core/skbuff.c                                | 16 +----
>   net/core/xdp.c                                   |  4 +-
>   9 files changed, 164 insertions(+), 46 deletions(-)
> ---
> base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
> change-id: 20250310-page-pool-track-dma-0332343a460e
>
>


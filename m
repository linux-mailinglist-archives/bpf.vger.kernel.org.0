Return-Path: <bpf+bounces-41814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BA199B4BC
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 14:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24B2281DD3
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 12:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC6116C6A7;
	Sat, 12 Oct 2024 12:06:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287147F69;
	Sat, 12 Oct 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734785; cv=none; b=q3axZSWP7m76Lu0yRxKv2oUOV6W7Snp8eo/e0SEp3F9r3fHnpbZHeVlvXteHUtjFO96H2w++83RVBCbpGPi30ypzJRvjTq/5Xi6EFy5v1eQcW8K/JkT8sqia6E8shaXMQ6GXbH6OPpkYVYLUsHFqzwmy+1hAHH35gVzHPxjlkaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734785; c=relaxed/simple;
	bh=IwUtYPQKqU20Pw5cpn9ykl4bTHIrKjZbpIEJm7B8vG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gURJaQ1P6VpZrkAFvBLiEbZ7tr2qYDSW9VqR5iaWOg9tIl+nDRznHDItxiFsmcao6kZi5FAhnYRKNH3ysdoYokmvDplAmwpYNuP4QdkzG23Wui1jkVOWWkzZzXex/MxlrZwLvBv77XDtZ9f90n0s334tGDIuJ/RNKu5V6QW49E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XQhvv1XPnzkWcD;
	Sat, 12 Oct 2024 20:03:07 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 66A98140393;
	Sat, 12 Oct 2024 20:05:32 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Oct 2024 20:05:32 +0800
Message-ID: <b1fd5ece-b967-4e56-ad4f-64ec437e2634@huawei.com>
Date: Sat, 12 Oct 2024 20:05:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] fix two bugs related to page_pool
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20240925075707.3970187-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/25 15:57, Yunsheng Lin wrote:
> Patch 1 fix a possible time window problem for page_pool.
> Patch 2 fix the kernel crash problem at iommu_get_dma_domain
> reported in [1].

Hi, all

Through the discussions, it seems there are some main concerns
as below:
1. Semantics changing of supporting unlimited inflight pages
   to limited inflight pages that are as large as the pool_size
   of page_pool.
2. The overhead of finding available pool->items in
   page_pool_item_add().

Any other concerns I missed here?
As it is unclear about the impact of the above concerns, which seemed
to lead Paolo to suggest this patchset targetting net-next tree
instead of net tree, so I am planning to target the net-next tree
keeping the 'Fixes' tag for the next version, if there is any other
opinion here, please let me know.

Also, I still have the page_frag refactoring patchset pending in the
nex-next, please let me know if I should wait for that patchset to
be applied before sending this one to the net-next tree.

> 


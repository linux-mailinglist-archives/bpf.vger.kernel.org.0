Return-Path: <bpf+bounces-54440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB11A6A4B8
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C147A488B
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B7121D3D4;
	Thu, 20 Mar 2025 11:17:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337121CA04;
	Thu, 20 Mar 2025 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469472; cv=none; b=Lr611drTrL+Vj0S7z/mp8YCnXvSQidKTzsW1ehXM4mURNSuyf9J7ZsCgXvv1sbLZt2OYbnCzo8j3XpWOAQ5Uv19fwII5P3E/j3aUqeFg8O1v6ofRFVty14LhKIhVa1gyvSnBZAAy7nlkCdroEuTgdIUljXvCaHNwi8vsFyH30oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469472; c=relaxed/simple;
	bh=kxjhNiy9u63coIBPEMlihOBsfAmnOpzMK4kohTUw/gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YZJaBmjhrE+qrS2k+0OSdtE0oFTigNP4omdQvIFh3dbpR/vJ8GBJXD1/d3lQnRjCGpSq2Gk5SP+hDhP0X8ravHgkOpVpJjeCwmk5v9yH6fLVVgCIlL6wT3OjHhN/wSwFSFhwon2fZSGSXOZA/IfhD0jdFK35+0n3SQzrghQSE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZJNJT6YtXz2Cd0j;
	Thu, 20 Mar 2025 19:14:33 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B464180216;
	Thu, 20 Mar 2025 19:17:48 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Mar 2025 19:17:47 +0800
Message-ID: <7a604ae4-063f-48ff-a92f-014d1cf86adc@huawei.com>
Date: Thu, 20 Mar 2025 19:17:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Yunsheng
 Lin <yunshenglin0825@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>, Yonglong
 Liu <liuyonglong@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	IOMMU <iommu@lists.linux.dev>, <segoon@openwall.com>, <solar@openwall.com>,
	<oss-security@lists.openwall.com>, <kernel-hardening@lists.openwall.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk>
 <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com> <87wmcmhxdz.fsf@toke.dk>
 <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com> <87r02ti57p.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <87r02ti57p.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/19 20:18, Toke Høiland-Jørgensen wrote:
>>
>> All I asked is about moving PP_MAGIC_MASK macro into poison.h if you
>> still want to proceed with reusing the page->pp_magic as the masking and
>> the signature to be masked seems reasonable to be in the same file.
> 
> Hmm, my thinking was that this would be a lot of irrelevant stuff to put
> into poison.h, but I suppose we could do so if the mm folks don't object :)

The masking and the signature to be masked is correlated, I am not sure
what you meant by 'irrelevant stuff' here.

As you seemed to have understood most of my concern about reusing
page->pp_magic, I am not going to argue with you about the uncertainty
of security and complexity of different address layout for different
arches again.

But I am still think it is not the way forward with the reusing of
page->pp_magic through doing some homework about the 'POISON_POINTER'.
If you still think my idea is complex and still want to proceed with
reusing the space of page->pp_magic, go ahead and let the maintainers
decide if it is worth the security risk and performance degradation.

> 
> -Toke
> 
> 


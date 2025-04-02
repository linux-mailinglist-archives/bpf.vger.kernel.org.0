Return-Path: <bpf+bounces-55139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C15A78CF1
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 13:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF031892F65
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8114237717;
	Wed,  2 Apr 2025 11:16:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083F32AEE9;
	Wed,  2 Apr 2025 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592562; cv=none; b=b1y5t+lAl21dQ1C1S3oR8lWfx1jv1O5A4Ks5m6jEmviDNUK+SKah3Y0gKbDPeAy8hgJ4Feo/c68DLfJDaL6OlCqo+aDUX1FVT81kDd/nTlxGEVZH97URZT4DkgfSEpNhLvMQd0w2cHwOM2PWfUr3nsxEOyUKEOLlZASlxavbxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592562; c=relaxed/simple;
	bh=JhUo/aChD/18U7gBE8w/fmpWt+EyPWny3Tq6rchm2WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RQ1VCtHdlMkHq+5KI9oEvNmdtuwmzBanY/rK6fJjQRvgVzHB7Us7hfAT0Ong6dFK3VP0SJzdVMQiYxIgHC7An2l9X+MQNx4+0xYyaTiQNhtaKb96EOZmmheY9Iy0EJbB7BLc66VqbuAHgADrc/K1buxZ2uTrXPGdxVRg7NVLizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZSMkk2m1fz27gml;
	Wed,  2 Apr 2025 19:16:30 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 48E821A0188;
	Wed,  2 Apr 2025 19:15:51 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 19:15:50 +0800
Message-ID: <6cd5a1dc-b938-46f3-8957-c2d99921f95c@huawei.com>
Date: Wed, 2 Apr 2025 19:15:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Zhu Yanjun <yanjun.zhu@linux.dev>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
	Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
	<willy@infradead.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
 <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
 <b75c5329-0049-4c9c-ba79-a1132d848d5d@linux.dev>
 <b87a14f4-181b-4a82-9d71-2750699601d6@huawei.com>
 <d3dcd3e1-c6ba-4756-bd8e-273e727b635a@intel.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <d3dcd3e1-c6ba-4756-bd8e-273e727b635a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/4/1 19:56, Alexander Lobakin wrote:

...

>> There are two reading of dma_sync in this patch, the first reading is not
>> under rcu read lock and doing the reading without READ_ONCE(), the second
>> reading is under rcu read lock and do the reading with READ_ONCE().
>>
>> The first one seems an optimization to avoid taking the rcu read lock,
>> why might need READ_ONCE() to make KCSAN happy if we do care about making
>> KCSAN happy.
>>
>> The second one does not seems to need the atomicity by using the READ_ONCE()
>> as it is always under RCU read lock(implicit or explicit one), and there is
>> a rcu sync after the clearing of that bit.
> 
> IOW, are you saying this change is not needed at all?

It is not needed unless KCSAN is not happy about this and we really want to make
KCSAN happy about it as my understanding.



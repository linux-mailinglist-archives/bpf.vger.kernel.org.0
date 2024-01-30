Return-Path: <bpf+bounces-20701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB6F8422E5
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CFE1C21A30
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8D667740;
	Tue, 30 Jan 2024 11:23:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37060B97;
	Tue, 30 Jan 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613800; cv=none; b=I3QQg1RJDuS5+TqFGuEfH/nIgA1KSZXaNlHdzlq1n9I6ZWRRg3fGSGEbfBx/LAkLNk3s2+zUENcSE29oIL0oKdUNYJTthjVJLpAtNJBzc9DhhJxUiQOlGKq99A9UwBruIFhrwsXvv7R6gfOPlTD26vK3kK4xRdVIZulb+ly8uAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613800; c=relaxed/simple;
	bh=TwC3EhkWYG9H8IvMTAnwLWyac25q45LqmxcuIlLONCo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dG7onM7FC9LfkbdELU8Xp2w2o4rFauViajjIDLGKf8AaPKx/bIaMAVzt3ouImXzjDeScyKcOduTvS8+GWWhGflst1RP9/Lz9olby8G3GtcjJKTFKf44wdanlmHP2grGS6rDWhW1wVn4zD8JPL5fNfeyh3fwJjvwCrqnqRppWyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TPN5y4hq2z29krw;
	Tue, 30 Jan 2024 19:21:26 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4037F1404D7;
	Tue, 30 Jan 2024 19:23:16 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Jan
 2024 19:23:15 +0800
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available just
 for global pools
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <bpf@vger.kernel.org>, <toke@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>, <sdf@google.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
 <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
 <ZbejGhc8K4J4dLbL@lore-desk>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ef59f9ac-b622-315a-4892-6c7723a2986a@huawei.com>
Date: Tue, 30 Jan 2024 19:23:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbejGhc8K4J4dLbL@lore-desk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/29 21:07, Lorenzo Bianconi wrote:
>> On 2024/1/28 22:20, Lorenzo Bianconi wrote:
>>> Move page_pool stats allocation in page_pool_create routine and get rid
>>> of it for percpu page_pools.
>>
>> Is there any reason why we do not need those kind stats for per cpu
>> page_pool?
>>
> 
> IIRC discussing with Jakub, we decided to not support them since the pool is not
> associated to any net_device in this case.

It seems what jakub suggested is to 'extend netlink to dump unbound page pools'?

> 
> Regards,
> Lorenzo
> 


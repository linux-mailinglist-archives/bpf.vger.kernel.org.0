Return-Path: <bpf+bounces-20697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEE484222B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC832885F7
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2378679F5;
	Tue, 30 Jan 2024 11:02:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2D679E2;
	Tue, 30 Jan 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612548; cv=none; b=gV7rEy0vtnzdytqgvxHQezWZXCr2mYTsN4u1gAnkmOsJCpjSevkakPjFw4aei0e1zgCLtgNYazTpb3Q+LXO2SVjrP9BarH1nPkEYq8XBv6t2sf3Apm92KIqC+pnE3LNu4Ax/ZiBS6IGdjFK+ViuSvniwmOBcepsZnoNdIXeTPuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612548; c=relaxed/simple;
	bh=p7c+qDD3OMCSk0FyAvRjZKJP4ym+RqwtlD1e2srSZUA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I5e8fKiszcSO4R0EAizMhX9QVIReLxmwmjQS6Zi+sr4FIY2ecQsFAaAcsf+xsMlCcNwMN2HW1HmNCePPrrQlPiYkY+eToeloSJqYCFUT5CNtFQ1VkgEO9S2wd2JxV6ikHf6q4AopKnaHDPKDxls/LbBDzccUG5F1OvcAw5DsKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TPMgT2RnczLqWP;
	Tue, 30 Jan 2024 19:01:57 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DAAE140132;
	Tue, 30 Jan 2024 19:02:23 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Jan
 2024 19:02:22 +0800
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <bpf@vger.kernel.org>, <toke@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>, <sdf@google.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
 <f6273e01-a826-4182-a5b5-564b51f2d9ae@huawei.com>
 <ZbeiZaUrWoj39_LZ@lore-desk>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <7343292d-3273-a10a-9167-420f3232dbdd@huawei.com>
Date: Tue, 30 Jan 2024 19:02:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbeiZaUrWoj39_LZ@lore-desk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/29 21:04, Lorenzo Bianconi wrote:
>> On 2024/1/28 22:20, Lorenzo Bianconi wrote:
>>
>>>  #ifdef CONFIG_LOCKDEP
>>>  /*
>>>   * register_netdevice() inits txq->_xmit_lock and sets lockdep class
>>> @@ -11686,6 +11690,27 @@ static void __init net_dev_struct_check(void)
>>>   *
>>>   */
>>>  
>>> +#define SD_PAGE_POOL_RING_SIZE	256
>>
>> I might missed that if there is a reason we choose 256 here, do we
>> need to use different value for differe page size, for 64K page size,
>> it means we might need to reserve 16MB memory for each CPU.
> 
> honestly I have not spent time on it, most of the current page_pool users set
> pool_size to 256. Anyway, do you mean something like:
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f70fb6cad2b2..3934a3fc5c45 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11806,12 +11806,11 @@ static void __init net_dev_struct_check(void)
>   *
>   */
>  
> -#define SD_PAGE_POOL_RING_SIZE	256
>  static int net_page_pool_alloc(int cpuid)
>  {
>  #if IS_ENABLED(CONFIG_PAGE_POOL)

Isn't better to have a config like CONFIG_PER_CPU_PAGE_POOL to enable
this feature? and this config can be selected by whoever needs this
feature?

>  	struct page_pool_params page_pool_params = {
> -		.pool_size = SD_PAGE_POOL_RING_SIZE,
> +		.pool_size = PAGE_SIZE < SZ_64K ? 256 : 16,

What about other page size? like 16KB?
How about something like below:
PAGE_SIZE << get_order(PER_CPU_PAGE_POOL_MAX_SIZE)

>  		.nid = NUMA_NO_NODE,
>  	};
>  	struct page_pool *pp_ptr;


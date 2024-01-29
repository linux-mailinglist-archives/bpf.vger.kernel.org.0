Return-Path: <bpf+bounces-20563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBBD840494
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A193F1F232E6
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CA4604C0;
	Mon, 29 Jan 2024 12:05:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0D60241;
	Mon, 29 Jan 2024 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529929; cv=none; b=Vh4hhl1iyqADvgli2WVStgz467iutphuGDTJ+IvqCY2J3hWMbwrgQ0r/wXEixCsuq/eHlY1VLOfV6x7oTO/wMS5bORqbHaKna90ztXDWSWim/+PszcRm+lZNxkRJa4d5hbs1ATLc33LArzi2K66nPyIzNOgTDwbwqa6QholatIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529929; c=relaxed/simple;
	bh=yn1GgIJZrYyANWUbN58ureOv+gtQrRwJRnE4qxcryHI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rAoz+sfVn8nCjM6zoLrpwCsJJrlV4iFJpU5AuekdxC2LovXZnR1HdpQESSVvepTaO6wuIwOifCI7az0w1Q7XaSQC34SNOmGThyc6G/Xc9O/PvlV1Q2/NX4/CUYT5DX4RdnZibDPhBKdEn9FI0ARyxqB1olnsx0XhvYEA0ZYDhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TNn5q2Vn3zsWd0;
	Mon, 29 Jan 2024 20:04:15 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id CF49E1404F8;
	Mon, 29 Jan 2024 20:05:24 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 20:05:24 +0800
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
To: Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>
CC: <lorenzo.bianconi@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <bpf@vger.kernel.org>,
	<toke@redhat.com>, <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<sdf@google.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <f6273e01-a826-4182-a5b5-564b51f2d9ae@huawei.com>
Date: Mon, 29 Jan 2024 20:05:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/28 22:20, Lorenzo Bianconi wrote:

>  #ifdef CONFIG_LOCKDEP
>  /*
>   * register_netdevice() inits txq->_xmit_lock and sets lockdep class
> @@ -11686,6 +11690,27 @@ static void __init net_dev_struct_check(void)
>   *
>   */
>  
> +#define SD_PAGE_POOL_RING_SIZE	256

I might missed that if there is a reason we choose 256 here, do we
need to use different value for differe page size, for 64K page size,
it means we might need to reserve 16MB memory for each CPU.

> +static int net_page_pool_alloc(int cpuid)
> +{
> +#if IS_ENABLED(CONFIG_PAGE_POOL)
> +	struct page_pool_params page_pool_params = {
> +		.pool_size = SD_PAGE_POOL_RING_SIZE,
> +		.nid = NUMA_NO_NODE,
> +	};
> +	struct page_pool *pp_ptr;
> +
> +	pp_ptr = page_pool_create_percpu(&page_pool_params, cpuid);
> +	if (IS_ERR(pp_ptr)) {
> +		pp_ptr = NULL;

unnecessary NULL setting?

> +		return -ENOMEM;
> +	}
> +
> +	per_cpu(page_pool, cpuid) = pp_ptr;
> +#endif
> +	return 0;
> +}
> +
>  /*
>   *       This is called single threaded during boot, so no need
>   *       to take the rtnl semaphore.
> @@ -11738,6 +11763,9 @@ static int __init net_dev_init(void)
>  		init_gro_hash(&sd->backlog);
>  		sd->backlog.poll = process_backlog;
>  		sd->backlog.weight = weight_p;
> +
> +		if (net_page_pool_alloc(i))
> +			goto out;
>  	}
>  
>  	dev_boot_phase = 0;
> @@ -11765,6 +11793,18 @@ static int __init net_dev_init(void)
>  	WARN_ON(rc < 0);
>  	rc = 0;
>  out:
> +	if (rc < 0) {
> +		for_each_possible_cpu(i) {
> +			struct page_pool *pp_ptr = this_cpu_read(page_pool);

this_cpu_read() -> per_cpu_ptr()?

> +
> +			if (!pp_ptr)
> +				continue;
> +
> +			page_pool_destroy(pp_ptr);
> +			per_cpu(page_pool, i) = NULL;
> +		}
> +	}
> +
>  	return rc;
>  }



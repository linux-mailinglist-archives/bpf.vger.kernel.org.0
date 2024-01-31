Return-Path: <bpf+bounces-20819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA43843F69
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 13:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A207E1C24742
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7078B73;
	Wed, 31 Jan 2024 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry7vCI0k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A078695;
	Wed, 31 Jan 2024 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704112; cv=none; b=WmtmbMMuIHEish0BHUArRMSBOcb7qWPed/MoFZNGUXNC+8kVYw/lTuUz4+OUheHns5rOwHzkmbi9TtrF5BnCwNu1J/lk8hYMS8IiGG3FyJ1QHOgBKomjQmTLlNMP9fyUeBdpyVzNQQq7+EFvoF96WUXcGsJJWOtaCTWnt/Zfl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704112; c=relaxed/simple;
	bh=7PYbJpYbNE1H2oDbkMpYdoVzL0HGqhKQKxhZsry7l8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGHg/ecu11/+dmeio4A1tS/xC6Zwfl5cR3Z9xlQtR9LcEHIkgM2MtK5upP92XHBUBXSfdqwEkRq6hbT42UojDuBcdsm0iEHsmJSAPjvEMiyyiiFxg8Qd2kQvqOmiRGpT3kVyCAQr1y1+qq1H80TG04III+tp96SrO4PugWDO9+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry7vCI0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0A4C433C7;
	Wed, 31 Jan 2024 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706704112;
	bh=7PYbJpYbNE1H2oDbkMpYdoVzL0HGqhKQKxhZsry7l8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ry7vCI0k5FJghlxZwytM/xHFCKymezqDJsGzhO1/jQHt2jWzZQqduQ9GPqMSTzD+I
	 /Hwm3ETxKLjaPI5a0QFO4Bl/k10PLxdCJj9qHtLqgrhZSQnCP5aQucmTCzTmOchrS4
	 tMKz3O+zOTbjFpSNroTzYsvlL0L8Czg5RRcP/Eos4ZVsUnaGyJ6ONvMOOCGnbHvdNz
	 2IZANnCBV2pBImiLCRbjWe1xsdxCSpd7pWwqHGlSG61P96SrlOEJiWEJqG1hYKpTd7
	 hfazQBt27z9LeWVgqmU6y82T2qPxa8KR6Z+oE8OvvntG3NY/qjdts4Ol/wmUt85qeS
	 vmKnxwpusS00A==
Message-ID: <91cf832e-ad66-47d0-bf2b-a8c9492d16a9@kernel.org>
Date: Wed, 31 Jan 2024 13:28:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com, ilias.apalodimas@linaro.org
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/01/2024 15.20, Lorenzo Bianconi wrote:
> Introduce generic percpu page_pools allocator.
> Moreover add page_pool_create_percpu() and cpuid filed in page_pool struct
> in order to recycle the page in the page_pool "hot" cache if
> napi_pp_put_page() is running on the same cpu.
> This is a preliminary patch to add xdp multi-buff support for xdp running
> in generic mode.
> 
> Signed-off-by: Lorenzo Bianconi<lorenzo@kernel.org>
> ---
>   include/net/page_pool/types.h |  3 +++
>   net/core/dev.c                | 40 +++++++++++++++++++++++++++++++++++
>   net/core/page_pool.c          | 23 ++++++++++++++++----
>   net/core/skbuff.c             |  5 +++--
>   4 files changed, 65 insertions(+), 6 deletions(-)
> 
[...]
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cb2dab0feee0..bf9ec740b09a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[...]
> @@ -11686,6 +11690,27 @@ static void __init net_dev_struct_check(void)
>    *
>    */
>   
> +#define SD_PAGE_POOL_RING_SIZE	256
> +static int net_page_pool_alloc(int cpuid)

I don't like the name net_page_pool_alloc().
It uses the page_pool_create APIs.

Let us renamed to net_page_pool_create() ?


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
> +		return -ENOMEM;
> +	}
> +
> +	per_cpu(page_pool, cpuid) = pp_ptr;
> +#endif
> +	return 0;
> +}
> +
>   /*
>    *       This is called single threaded during boot, so no need
>    *       to take the rtnl semaphore.
> @@ -11738,6 +11763,9 @@ static int __init net_dev_init(void)
>   		init_gro_hash(&sd->backlog);
>   		sd->backlog.poll = process_backlog;
>   		sd->backlog.weight = weight_p;
> +
> +		if (net_page_pool_alloc(i))
> +			goto out;
>   	}
>   
>   	dev_boot_phase = 0;
> @@ -11765,6 +11793,18 @@ static int __init net_dev_init(void)
>   	WARN_ON(rc < 0);
>   	rc = 0;
>   out:
> +	if (rc < 0) {
> +		for_each_possible_cpu(i) {
> +			struct page_pool *pp_ptr = this_cpu_read(page_pool);
> +
> +			if (!pp_ptr)
> +				continue;
> +
> +			page_pool_destroy(pp_ptr);
> +			per_cpu(page_pool, i) = NULL;
> +		}
> +	}
> +
>   	return rc;
>   }
>   


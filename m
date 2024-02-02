Return-Path: <bpf+bounces-21009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C83B846B69
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 09:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5664286C79
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBD3679F9;
	Fri,  2 Feb 2024 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goDqYRYT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F1160DF2;
	Fri,  2 Feb 2024 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864368; cv=none; b=ee1c4P/ziDxiubEX+zi00vGD0D1CjB4FwxCOSSw8XXrlJII3+E/Mpv/jLT+0m/5mMObpiOTbKBknuSqjzxFyKHkdEJcJG4Y9KXWqs+0v2tk2IkAaQWmYyaO1CRcbwSjlqBo2xshFr8saoe8jIIBwUoL3wWyEvT/0/0OstHmoAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864368; c=relaxed/simple;
	bh=8FRv6aqHBC3oi4Y3TOZ4hlePm6hRKPFbP0TrbuA8RHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTvjUOq+OAKzqLnKtdOLLH43q9Cq6vG6n7kX0IIJDb6VKVhLwWSh0MB6q1bTNcig/S1wtgZeq8ulsFGZ6BO22X57yFN+1erG7liXFnfxbeKzdbtkJHcsIkM4P/w+80cqCb5gWUKz4gRFS2DZgp1otx3sIOvbAwnOokYuOlIqDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goDqYRYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A721FC433C7;
	Fri,  2 Feb 2024 08:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706864367;
	bh=8FRv6aqHBC3oi4Y3TOZ4hlePm6hRKPFbP0TrbuA8RHY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=goDqYRYT6gpGpsHHgK4SVUrOMX3GssROOpSIJC03jIFI6BntZLz+L3EuO17BKGPhL
	 HtK3vyE4vXWdOPFVoZf3i9iWAhjoJ+0l8JlwcLnPcjuOs7mHN8oo9YT5wDl2jIXbXb
	 LmqfVOW+93zBJkxrtTMbDiX6ipS2II2RccXzZQqUvA2wvYOLrDCQrScLtIzFEkP9lx
	 rUSO0DnbQr86cUEHijXH5moywkVMTvujOGN58JBbSHFSelgnU+lc3fW/rzfZVc+qP4
	 mZYvAFZhfIYmy7pBfiB/ACkRlOtRrumSZUPYV+oZ9+JxjBPM0GRvFNrOMywBaZqeeq
	 lRQGZRdP3mpHg==
Message-ID: <48336c66-a5ed-4a07-a686-0e4a73a20f99@kernel.org>
Date: Fri, 2 Feb 2024 09:59:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 1/4] net: add generic percpu page_pool
 allocator
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com, ilias.apalodimas@linaro.org, linyunsheng@huawei.com
References: <cover.1706861261.git.lorenzo@kernel.org>
 <1d34b717f8f842b9c3e9f70f0e8ffd245a5d2460.1706861261.git.lorenzo@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <1d34b717f8f842b9c3e9f70f0e8ffd245a5d2460.1706861261.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/02/2024 09.12, Lorenzo Bianconi wrote:
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
>   net/core/dev.c                | 45 +++++++++++++++++++++++++++++++++++
>   net/core/page_pool.c          | 23 ++++++++++++++----
>   net/core/skbuff.c             |  5 ++--
>   4 files changed, 70 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 76481c465375..3828396ae60c 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -128,6 +128,7 @@ struct page_pool_stats {
>   struct page_pool {
>   	struct page_pool_params_fast p;
>   
> +	int cpuid;
>   	bool has_init_callback;
>   
>   	long frag_users;
> @@ -203,6 +204,8 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
>   struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
>   				  unsigned int size, gfp_t gfp);
>   struct page_pool *page_pool_create(const struct page_pool_params *params);
> +struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
> +					  int cpuid);
>   
>   struct xdp_mem_info;
>   
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b53b9c94de40..5a100360389f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -153,6 +153,8 @@
>   #include <linux/prandom.h>
>   #include <linux/once_lite.h>
>   #include <net/netdev_rx_queue.h>
> +#include <net/page_pool/types.h>
> +#include <net/page_pool/helpers.h>
>   
>   #include "dev.h"
>   #include "net-sysfs.h"
> @@ -450,6 +452,12 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
>   DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
>   EXPORT_PER_CPU_SYMBOL(softnet_data);
>   
> +/* Page_pool has a lockless array/stack to alloc/recycle pages.
> + * PP consumers must pay attention to run APIs in the appropriate context
> + * (e.g. NAPI context).
> + */
> +static DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);

Thanks for adding comment.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>




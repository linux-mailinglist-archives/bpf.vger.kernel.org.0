Return-Path: <bpf+bounces-3752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFA9742E5C
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB991C20B08
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FA2154B5;
	Thu, 29 Jun 2023 20:30:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4591640F;
	Thu, 29 Jun 2023 20:30:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B440268F;
	Thu, 29 Jun 2023 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=JCG9TzY8s/hwSq5LLBsUgQBXA+fGn+gT6MXU6Bs/KnA=; b=pMG6K5G0ytzxyPJfLoFF63Bx5a
	BMLkltsOqSA0j6GkKHO6VbW45H5CCGDEdc+QDsnvZEzcpgAmQlwY75o9MTcE2QayuDDIPjDgAQ16g
	7+ry/JQuQsXA1FwWTdrUXvnHeOXv/wUKnn9RmZKOD0VsGQj+PJuRuidtNFy5k7xZ6V/IGbIN2zVLI
	w91DTciMkgdgY9TBveXDsjMilbD+bCYdxPirNV4jIgHjGs4xfx3KmtI0LFN0HIkwSQWj/W8QcRqdL
	YqNEVrSbCP3FONwE881oekdRZBahoDfP7DOnTslWpPG7JeB0FGmMF3tO1vos528tW9E2qbI49THn0
	lmIIKpkw==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qEyHs-0025KP-0t;
	Thu, 29 Jun 2023 20:30:44 +0000
Message-ID: <dc48e465-c422-d9c4-a28e-7ed97950e1c8@infradead.org>
Date: Thu, 29 Jun 2023 13:30:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 RFC 5/6] page_pool: update document about frag API
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Liang Chen <liangchen.linux@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-6-linyunsheng@huawei.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230629120226.14854-6-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi--

On 6/29/23 05:02, Yunsheng Lin wrote:
> As more drivers begin to use the frag API, update the
> document about how to decide which API to use for the
> driver author.
> 
> Also it seems there is a similar document in page_pool.h,
> so remove it to avoid the duplication.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  Documentation/networking/page_pool.rst | 34 ++++++++++++++++++++++----
>  include/net/page_pool.h                | 22 -----------------
>  2 files changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
> index 873efd97f822..18b13d659c98 100644
> --- a/Documentation/networking/page_pool.rst
> +++ b/Documentation/networking/page_pool.rst
> @@ -4,12 +4,27 @@
>  Page Pool API
>  =============
>  
> -The page_pool allocator is optimized for the XDP mode that uses one frame
> -per-page, but it can fallback on the regular page allocator APIs.
> +The page_pool allocator is optimized for recycling page or page frag used by skb
> +packet and xdp frame.

That sentence could use some adjectives. Choose singular or plural:

> +The page_pool allocator is optimized for recycling a page or page frag used by an skb
> +packet or xdp frame.

or

> +The page_pool allocator is optimized for recycling pages or page frags used by skb
> +packets or xdp frames.

Now that I have written them, I prefer the latter one (plural). FWIW.

>  
> -Basic use involves replacing alloc_pages() calls with the
> -page_pool_alloc_pages() call.  Drivers should use page_pool_dev_alloc_pages()
> -replacing dev_alloc_pages().
> +Basic use involves replacing napi_alloc_frag() and alloc_pages() calls with
> +page_pool_cache_alloc() and page_pool_alloc(), which allocate memory with or
> +without page splitting depending on the requested memory size.
> +
> +If the driver knows that it always requires full pages or its allocates are

                                                                 allocations are

> +always smaller than half a page, it can use one of the more specific API calls:
> +
> +1. page_pool_alloc_pages(): allocate memory without page splitting when driver
> +   knows that the memory it need is always bigger than half of the page
> +   allocated from page pool. There is no cache line dirtying for 'struct page'
> +   when a page is recycled back to the page pool.
> +
> +2. page_pool_alloc_frag(): allocate memory with page splitting when driver knows
> +   that the memory it need is always smaller than or equal to half of the page
> +   allocated from page pool. Page splitting enables memory saving and thus avoid

                                                                     and thus avoids

> +   TLB/cache miss for data access, but there also is some cost to implement page
> +   splitting, mainly some cache line dirtying/bouncing for 'struct page' and
> +   atomic operation for page->pp_frag_count.
>  
>  API keeps track of in-flight pages, in order to let API user know
>  when it is safe to free a page_pool object.  Thus, API users
> @@ -93,6 +108,15 @@ a page will cause no race conditions is enough.
>  * page_pool_dev_alloc_pages(): Get a page from the page allocator or page_pool
>    caches.
>  
> +* page_pool_dev_alloc_frag(): Get a page frag from the page allocator or
> +  page_pool caches.
> +
> +* page_pool_dev_alloc(): Get a page or page frag from the page allocator or
> +  page_pool caches.
> +
> +* page_pool_dev_cache_alloc(): Get a cache from the page allocator or page_pool
> +  caches.
> +
>  * page_pool_get_dma_addr(): Retrieve the stored DMA address.
>  
>  * page_pool_get_dma_dir(): Retrieve the stored DMA direction.

Thanks for adding the documentation.

-- 
~Randy


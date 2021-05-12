Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD2D37CF1E
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 19:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbhELRIq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 13:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343570AbhELQxS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 12:53:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D748C034617
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 09:47:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so81116wmk.1
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bDKYc6juyaymxPVjFoz4H55W1iGwXmuC+dG6aoLf7OA=;
        b=oYirGOrNIcNwMpkAHzcPYl0Qh5mhW1k7/1qO+qzT05aC765M6Vsg9BuZtavalWCBO4
         o0QFswgOc95tPHp89yndOoxlZuw/0PdSI92mJB+WH7RbEltI1ssXo8LnPWsjipjaUxDk
         zU7GzUCqM+wMOsQSQfe0hfqEA6EwcKRXkr5EipMQ3f2eGD+NfX7ZFw3a50AXswFhUYWK
         yhuezdiXWJFTiSqM7Rq1vNWZ3erRdlRa6DfSFrGgIEAGl6M4KcuKaH7Yr9vq6BjeuAxR
         yi8+3GK4WThFGnMUvhKKqAgImphjXzMWiWeHz9bUnHWmnabS4XKRe88d/uG97oFfql2n
         lr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDKYc6juyaymxPVjFoz4H55W1iGwXmuC+dG6aoLf7OA=;
        b=rLfvhWDBKCM4M/SoP5Yd28jmAhv92e8TDEoAQhfNN95QDawiKqCYqSFdnPQ2kc8zPP
         mZiso7NaN3kjfv0E/NortHsDvNQLalxrDLkU5mFNuDV5Q3FQorAYmjCHDOkMLwsYtHvI
         sqr9rQSduy4TAMJRLDYXiH4L4oTrLqIdmQE1kb3ZLyoSW8YshrPM7Hj+ut7lycnAtn0l
         b7JBLZ9grltn5ZGONAAfFR6cnlxb88YZxzt/jnwQZE+v/EFM2wH/N8zmwFlYxMOTFTFd
         wKmp+p1al7V0pyoNkut15U9Vwdx93bvrpVQmivLFYEsXiew6A/2tGXOGnZLr0xnVrFU5
         X/ww==
X-Gm-Message-State: AOAM532NMKXJDe5K8CiGWzFQcOL89nnDDSXDKQePzPkDc8RyMJxnoPpR
        CYRUaRmNBRVd1d3AV7+qs4YFEw==
X-Google-Smtp-Source: ABdhPJzDMlMeT7C3maJdPrl7Y+VmQFC0wDQfotNCrVBtjxuloaDP335rfrwZkK1gstgOHCj/mFuZ5w==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr39895803wml.123.1620838070248;
        Wed, 12 May 2021 09:47:50 -0700 (PDT)
Received: from apalos.home ([94.69.77.156])
        by smtp.gmail.com with ESMTPSA id d9sm210203wrp.47.2021.05.12.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 09:47:49 -0700 (PDT)
Date:   Wed, 12 May 2021 19:47:44 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        Networking <netdev@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Roman Gushchin <guro@fb.com>, Hugh Dickins <hughd@google.com>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Cong Wang <cong.wang@bytedance.com>, wenxu <wenxu@ucloud.cn>,
        Kevin Hao <haokexin@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>
Subject: Re: [PATCH net-next v4 1/4] mm: add a signature in struct page
Message-ID: <YJwGsPq7M1eA9f+S@apalos.home>
References: <20210511133118.15012-1-mcroce@linux.microsoft.com>
 <20210511133118.15012-2-mcroce@linux.microsoft.com>
 <YJqKfNh6l3yY2daM@casper.infradead.org>
 <YJqQgYSWH2qan1GS@apalos.home>
 <YJqSM79sOk1PRFPT@casper.infradead.org>
 <CAC_iWj+Tw9DzzzVj-F9AwzBN_OJV_HN2miJT4KTBH_Uei_V2ZA@mail.gmail.com>
 <YJv65eER2qgaP9Ib@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJv65eER2qgaP9Ib@casper.infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 12, 2021 at 04:57:25PM +0100, Matthew Wilcox wrote:
> On Tue, May 11, 2021 at 05:25:36PM +0300, Ilias Apalodimas wrote:
> > Nope not at all, either would work. we'll switch to that
> 
> You'll need something like this because of the current use of
> page->index to mean "pfmemalloc".
> 

Yes, I was somehow under the impression that was already merged.
We'll include it in the series, with your Co-developed-by tag.

Thanks
/Ilias

> From ecd6d912056a21bbe55d997c01f96b0b8b9fbc31 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Fri, 16 Apr 2021 18:12:33 -0400
> Subject: [PATCH] mm: Indicate pfmemalloc pages in compound_head
> 
> The net page_pool wants to use a magic value to identify page pool pages.
> The best place to put it is in the first word where it can be clearly a
> non-pointer value.  That means shifting dma_addr up to alias with ->index,
> which means we need to find another way to indicate page_is_pfmemalloc().
> Since page_pool doesn't want to set its magic value on pages which are
> pfmemalloc, we can use bit 1 of compound_head to indicate that the page
> came from the memory reserves.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h       | 12 +++++++-----
>  include/linux/mm_types.h |  7 +++----
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bd21864449bf..4f9b2007efad 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1670,10 +1670,12 @@ struct address_space *page_mapping(struct page *page);
>  static inline bool page_is_pfmemalloc(const struct page *page)
>  {
>  	/*
> -	 * Page index cannot be this large so this must be
> -	 * a pfmemalloc page.
> +	 * This is not a tail page; compound_head of a head page is unused
> +	 * at return from the page allocator, and will be overwritten
> +	 * by callers who do not care whether the page came from the
> +	 * reserves.
>  	 */
> -	return page->index == -1UL;
> +	return page->compound_head & 2;
>  }
>  
>  /*
> @@ -1682,12 +1684,12 @@ static inline bool page_is_pfmemalloc(const struct page *page)
>   */
>  static inline void set_page_pfmemalloc(struct page *page)
>  {
> -	page->index = -1UL;
> +	page->compound_head = 2;
>  }
>  
>  static inline void clear_page_pfmemalloc(struct page *page)
>  {
> -	page->index = 0;
> +	page->compound_head = 0;
>  }
>  
>  /*
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5aacc1c10a45..1352e278939b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -96,10 +96,9 @@ struct page {
>  			unsigned long private;
>  		};
>  		struct {	/* page_pool used by netstack */
> -			/**
> -			 * @dma_addr: might require a 64-bit value on
> -			 * 32-bit architectures.
> -			 */
> +			unsigned long pp_magic;
> +			struct page_pool *pp;
> +			unsigned long _pp_mapping_pad;
>  			unsigned long dma_addr[2];
>  		};
>  		struct {	/* slab, slob and slub */
> -- 
> 2.30.2
> 

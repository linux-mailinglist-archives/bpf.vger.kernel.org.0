Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93463BDE99
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 22:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhGFUs0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 16:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhGFUs0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 16:48:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0927FC061574;
        Tue,  6 Jul 2021 13:45:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v20so36260906eji.10;
        Tue, 06 Jul 2021 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVtwFK1vDGGT5B2YxajXtIyEswR9GpVxg1YF5OrM1NU=;
        b=Cwg3d8KyLiaO+fHdkvP55uwBsJpEha4kt9wDHIUYATJ01zRLcP5ucLtb5SYVL7jBHH
         Ib03UuRqaCN8MMJGbvPJw7q7oL8BdachzM0RWfj6zrN9sPJ+J6is68/jzjEePQ4IMY2r
         Apd7Z5xuVFp2LjMLtY5eLiOURdGmdM4pQL93++gDceoVYqaOlqOikUEdvtHHsZ85nrlY
         RPDpmX/8YrDmMyZYeqMhNi9lsyuvm0sXx5adK8j7pkXqS8/HR0hSNGoThLBKA1llp8gY
         90Pr9O9lgMudXDQp9wVf2u8RaaJviet3ABG2Nzej7pvEdPuaQtazEtw/5YgdQS2NC6mD
         usZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVtwFK1vDGGT5B2YxajXtIyEswR9GpVxg1YF5OrM1NU=;
        b=i0wd9AOg5ftb5tNVYsHzjZ0XkRhdB+Bd5QYF5vpbMUbg3x8agKtytRvn/PpV5cRsMo
         2sYzsEVRePNkB3evhXbYTrEm22y4CVPPoD3QPBAWi1+YnSxellPmdidsTvUojQDm4it0
         3yvOVi3wn+Fd9/M0dSETX22wFtsfsjBHeQ5rDlTfrT0SJ5DjDmK1jXMJ7JnfgNs8mNWP
         8JSz5hEwTJKQxkGgJxdlZo6wD9e+cgRX5JiJFPwUzUoPm+suKYOJwpkPuQuS8Ay2qUAS
         WPqy8GRQ8HvLw72JqSGnCySEeW+sZRcGty4UvCLsDwx9d4rhbHOHbGb9IaxaUSpolaNC
         DWGg==
X-Gm-Message-State: AOAM532NsWyBLeweQkaEMZj1RpcOOMDq64tpgdwDiQ0iFI5tsE6pTSIF
        LwtbrwdhNtZSMI7ZwKZzK6puxvOnKO0VDHrnidU=
X-Google-Smtp-Source: ABdhPJypBjjo6EPf6cEYdLn2qwY01RmbZ5f9senQ4E+A8hVy2hYK/kqW+jAFO5v1fDPrlPFOWVm4s7Fs3Scg5ZAmr8M=
X-Received: by 2002:a17:906:bc2:: with SMTP id y2mr20465225ejg.489.1625604345351;
 Tue, 06 Jul 2021 13:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <1625044676-12441-1-git-send-email-linyunsheng@huawei.com> <1625044676-12441-2-git-send-email-linyunsheng@huawei.com>
In-Reply-To: <1625044676-12441-2-git-send-email-linyunsheng@huawei.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 6 Jul 2021 13:45:34 -0700
Message-ID: <CAKgT0Ueyc8BqjkdTVC_c-Upn-ghNeahYQrWJtQSqxoqN7VvMWA@mail.gmail.com>
Subject: Re: [PATCH net-next RFC 1/2] page_pool: add page recycling support
 based on elevated refcnt
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linuxarm@openeuler.org,
        yisen.zhuang@huawei.com, Salil Mehta <salil.mehta@huawei.com>,
        thomas.petazzoni@bootlin.com, mw@semihalf.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        hawk@kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, fenghua.yu@intel.com,
        guro@fb.com, peterx@redhat.com, Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, mcroce@microsoft.com,
        Hugh Dickins <hughd@google.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Willem de Bruijn <willemb@google.com>, wenxu@ucloud.cn,
        cong.wang@bytedance.com, Kevin Hao <haokexin@gmail.com>,
        nogikh@google.com, Marco Elver <elver@google.com>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 30, 2021 at 2:19 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> Currently page pool only support page recycling only when
> refcnt of page is one, which means it can not support the
> split page recycling implemented in the most ethernet driver.
>
> So add elevated refcnt support in page pool, and support
> allocating page frag to enable multi-frames-per-page based
> on the elevated refcnt support.
>
> As the elevated refcnt is per page, and there is no space
> for that in "struct page" now, so add a dynamically allocated
> "struct page_pool_info" to record page pool ptr and refcnt
> corrsponding to a page for now. Later, we can recycle the
> "struct page_pool_info" too, or use part of page memory to
> record pp_info.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

So this isn't going to work with the current recycling logic. The
expectation there is that we can safely unmap the entire page as soon
as the reference count is greater than 1.

In addition I think I need to look over that code better as I am
wondering if there are potential issues assuming a path such as a
skb_clone followed by pskb_expand_head may lead to memory corruptions
since the clone will still have pp_recycle set but none of the pages
will be part of the page pool anymore.

For us the pagecnt_bias would really represent the number of
additional mappings beyond the current page that are being held. I
have already been playing around with something similar. However the
general idea is that we want to keep track of how many references to
the page the device is holding onto. When that hits 0 and the actual
page count is 1 we can refill both, however if we hit 0 and there are
multiple references to the page still floating around we should just
unmap the page and turn it over to the stack or free it.

> ---
>  drivers/net/ethernet/marvell/mvneta.c           |   6 +-
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   2 +-
>  include/linux/mm_types.h                        |   2 +-
>  include/linux/skbuff.h                          |   4 +-
>  include/net/page_pool.h                         |  30 +++-
>  net/core/page_pool.c                            | 215 ++++++++++++++++++++----
>  6 files changed, 207 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 88a7550..5a29af2 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2327,7 +2327,7 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
>         if (!skb)
>                 return ERR_PTR(-ENOMEM);
>
> -       skb_mark_for_recycle(skb, virt_to_page(xdp->data), pool);
> +       skb_mark_for_recycle(skb);
>
>         skb_reserve(skb, xdp->data - xdp->data_hard_start);
>         skb_put(skb, xdp->data_end - xdp->data);
> @@ -2339,10 +2339,6 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
>                 skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
>                                 skb_frag_page(frag), skb_frag_off(frag),
>                                 skb_frag_size(frag), PAGE_SIZE);
> -               /* We don't need to reset pp_recycle here. It's already set, so
> -                * just mark fragments for recycling.
> -                */
> -               page_pool_store_mem_info(skb_frag_page(frag), pool);
>         }
>
>         return skb;

So as I mentioned earlier the problem with recycling is that splitting
up the ownership of the page makes it difficult for us to clean it up.
Technically speaking if the pages are being allowed to leave while
holding references to DMA addresses that we cannot revoke then we
should be holding references to the device.

That is one of the reasons why the previous code was just clearing the
mapping as soon as the refcount was greater than 1. However for this
to work out correctly we would have to track how many DMA mappings we
have outstanding in addition to the one we are working on currently.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 3135220..540e387 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3997,7 +3997,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
>                 }
>
>                 if (pp)
> -                       skb_mark_for_recycle(skb, page, pp);
> +                       skb_mark_for_recycle(skb);
>                 else
>                         dma_unmap_single_attrs(dev->dev.parent, dma_addr,
>                                                bm_pool->buf_size, DMA_FROM_DEVICE,
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 862f88a..cf613df 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -101,7 +101,7 @@ struct page {
>                          * page_pool allocated pages.
>                          */
>                         unsigned long pp_magic;
> -                       struct page_pool *pp;
> +                       struct page_pool_info *pp_info;
>                         unsigned long _pp_mapping_pad;
>                         /**
>                          * @dma_addr: might require a 64-bit value on

So the problem here is that this is creating a pointer chase, and the
need to allocate yet another structure to store it is going to be
expensive.

As far as storing the pagecnt_bias it might make more sense to
repurpose the lower 12 bits of the dma address. A DMA mapping should
be page aligned anyway so the lower 12 bits would be reserved 0. When
we decrement the value so that the lower 12 bits are 0 we should be
unmapping the page anyway, or resetting the pagecnt_bias to PAGE_SIZE
- 1 and adding back the bias to the page to effectively reset it for
reuse.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index b2db9cd..7795979 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4711,11 +4711,9 @@ static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
>  }
>
>  #ifdef CONFIG_PAGE_POOL
> -static inline void skb_mark_for_recycle(struct sk_buff *skb, struct page *page,
> -                                       struct page_pool *pp)
> +static inline void skb_mark_for_recycle(struct sk_buff *skb)
>  {
>         skb->pp_recycle = 1;
> -       page_pool_store_mem_info(page, pp);
>  }
>  #endif

I am not a fan of the pp_recycle flag either. We duplicate it via
skb_clone and from what I can tell if we call pskb_expand_head
afterwards I don't see how we avoid recycling the page frags twice.

> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 3dd62dd..44e7545 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -45,7 +45,9 @@
>                                         * Please note DMA-sync-for-CPU is still
>                                         * device driver responsibility
>                                         */
> -#define PP_FLAG_ALL            (PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
> +#define PP_FLAG_PAGECNT_BIAS   BIT(2)  /* Enable elevated refcnt */
> +#define PP_FLAG_ALL            (PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |\
> +                                PP_FLAG_PAGECNT_BIAS)
>
>  /*

It might be better to just put each flag on a seperate line for
PP_FLAG_ALL just to make it easier to read due to the wrapping. Either
that or you could look at converting this over to an enum with a MAX
value and then define the flags based on those enums, and PP_FLAG_ALL
being BIT(MAX) - 1.

>   * Fast allocation side cache array/stack
> @@ -77,6 +79,7 @@ struct page_pool_params {
>         enum dma_data_direction dma_dir; /* DMA mapping direction */
>         unsigned int    max_len; /* max DMA sync memory size */
>         unsigned int    offset;  /* DMA addr offset */
> +       unsigned int    frag_size;
>  };
>
>  struct page_pool {
> @@ -88,6 +91,8 @@ struct page_pool {
>         unsigned long defer_warn;
>
>         u32 pages_state_hold_cnt;
> +       unsigned int frag_offset;
> +       struct page *frag_page;
>
>         /*
>          * Data structure for allocation side
> @@ -128,6 +133,11 @@ struct page_pool {
>         u64 destroy_cnt;
>  };
>
> +struct page_pool_info {
> +       struct page_pool *pp;
> +       int pagecnt_bias;
> +};
> +

Rather than having a top-down structure here it might be better to
work bottom up. If you assume you are keeping a pagecnt_bias per page
it might make more sense to store this in the driver somewhere rather
than having it as a separate allocated buffer. One advantage of the
Intel drivers was doing this as we had the pagecnt_bias in a structure
that also pointed to the page. That way we were only updating that
count if we dropped the page and didn't have to even touch the page.
You could use that to batch updates to the pagecnt_bias if we did use
the lower 12 bits of the DMA address to store it as well.

I'm assuming the idea with this is that you will be having multiple
buffers received off of a single page and so doing it that way you
should only have one update on allocation, maybe a trickle of updates
for XDP_TX, and another large update when the page is fully consumed
and you drop the remaining pagecnt_bias for Rx.

>  struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
>
>  static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
> @@ -137,6 +147,17 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
>         return page_pool_alloc_pages(pool, gfp);
>  }
>
> +struct page *page_pool_alloc_frag(struct page_pool *pool,
> +                                 unsigned int *offset, gfp_t gfp);
> +
> +static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
> +                                                   unsigned int *offset)
> +{
> +       gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
> +
> +       return page_pool_alloc_frag(pool, offset, gfp);
> +}
> +
>  /* get the stored dma direction. A driver might decide to treat this locally and
>   * avoid the extra cache line from page_pool to determine the direction
>   */
> @@ -253,11 +274,4 @@ static inline void page_pool_ring_unlock(struct page_pool *pool)
>                 spin_unlock_bh(&pool->ring.producer_lock);
>  }
>
> -/* Store mem_info on struct page and use it while recycling skb frags */
> -static inline
> -void page_pool_store_mem_info(struct page *page, struct page_pool *pp)
> -{
> -       page->pp = pp;
> -}
> -
>  #endif /* _NET_PAGE_POOL_H */

So the issue as I see it with the page_pool recycling patch set is
that I don't think we had proper guarantees in place that the page->pp
value was flushed in all cases where skb->dev was changed. Basically
the logic we need to have in place to address those issues is that
skb->dev is changed we need to invalidate the DMA mappings on the
page_pool page.

I honestly wonder if it wouldn't be better for the recycling to just
make use of the page->lru pointers to keep a list of pages that are
outstanding so that it could release them if it is under DMA pressure.

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 5e4eb45..95d94a7 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -206,6 +206,49 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>         return true;
>  }
>
> +static int page_pool_set_pp_info(struct page_pool *pool,
> +                                struct page *page, gfp_t gfp)
> +{
> +       struct page_pool_info *pp_info;
> +
> +       pp_info = kzalloc_node(sizeof(*pp_info), gfp, pool->p.nid);
> +       if (!pp_info)
> +               return -ENOMEM;
> +
> +       if (pool->p.flags & PP_FLAG_PAGECNT_BIAS) {
> +               page_ref_add(page, USHRT_MAX);
> +               pp_info->pagecnt_bias = USHRT_MAX;
> +       } else {
> +               pp_info->pagecnt_bias = 0;
> +       }
> +
> +       page->pp_magic |= PP_SIGNATURE;
> +       pp_info->pp = pool;
> +       page->pp_info = pp_info;
> +       return 0;
> +}
> +

Having to perform a kzalloc in this path pretty much ruins the whole
point of the page_pool API in my opinion. We would be much better off
having a static structure that is to be maintained somewhere rather
than doing this dynamically as you would just make a memory hog able
to hold that much more memory.

> +static int page_pool_clear_pp_info(struct page *page)
> +{
> +       struct page_pool_info *pp_info = page->pp_info;
> +       int bias;
> +
> +       bias = pp_info->pagecnt_bias;
> +
> +       kfree(pp_info);
> +       page->pp_info = NULL;
> +       page->pp_magic = 0;
> +
> +       return bias;
> +}
> +
> +static void page_pool_clear_and_drain_page(struct page *page)
> +{
> +       int bias = page_pool_clear_pp_info(page);
> +
> +       __page_frag_cache_drain(page, bias + 1);
> +}
> +
>  static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
>                                                  gfp_t gfp)
>  {
> @@ -216,13 +259,16 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
>         if (unlikely(!page))
>                 return NULL;
>
> -       if ((pool->p.flags & PP_FLAG_DMA_MAP) &&
> -           unlikely(!page_pool_dma_map(pool, page))) {
> +       if (unlikely(page_pool_set_pp_info(pool, page, gfp))) {
>                 put_page(page);
>                 return NULL;
>         }
>
> -       page->pp_magic |= PP_SIGNATURE;
> +       if ((pool->p.flags & PP_FLAG_DMA_MAP) &&
> +           unlikely(!page_pool_dma_map(pool, page))) {
> +               page_pool_clear_and_drain_page(page);
> +               return NULL;
> +       }
>
>         /* Track how many pages are held 'in-flight' */
>         pool->pages_state_hold_cnt++;
> @@ -261,12 +307,17 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
>          */
>         for (i = 0; i < nr_pages; i++) {
>                 page = pool->alloc.cache[i];
> +               if (unlikely(page_pool_set_pp_info(pool, page, gfp))) {
> +                       put_page(page);
> +                       continue;
> +               }
> +
>                 if ((pp_flags & PP_FLAG_DMA_MAP) &&
>                     unlikely(!page_pool_dma_map(pool, page))) {
> -                       put_page(page);
> +                       page_pool_clear_and_drain_page(page);
>                         continue;
>                 }

This seems backwards to me. I would have the pp_info populated after
you have generated the DMA mapping.

> -               page->pp_magic |= PP_SIGNATURE;
> +
>                 pool->alloc.cache[pool->alloc.count++] = page;
>                 /* Track how many pages are held 'in-flight' */
>                 pool->pages_state_hold_cnt++;
> @@ -284,6 +335,25 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
>         return page;
>  }
>
> +static void page_pool_sub_bias(struct page *page, int nr)
> +{
> +       struct page_pool_info *pp_info = page->pp_info;
> +
> +       /* "pp_info->pagecnt_bias == 0" indicates the PAGECNT_BIAS
> +        * flags is not set.
> +        */
> +       if (!pp_info->pagecnt_bias)
> +               return;
> +
> +       /* Make sure pagecnt_bias > 0 for elevated refcnt case */
> +       if (unlikely(pp_info->pagecnt_bias <= nr)) {
> +               page_ref_add(page, USHRT_MAX);
> +               pp_info->pagecnt_bias += USHRT_MAX;
> +       }
> +
> +       pp_info->pagecnt_bias -= nr;

So we should never have a case where pagecnt_bias is less than the
value we are subtracting. If we have that then it is a bug.

The general idea with the pagecnt_bias is that we want to batch the
release of the page from the device. So the assumption is we are going
to pull multiple references from the page and rather than doing
page_ref_inc repeatedly we want to batch it at the start, and we have
to perform a __page_frag_cache_drain to remove any unused references
when we need to free it.

What we should probably be checking for is "pp_info->pagecnt_bias -
page_count(page) > 1" when we hit the end of the page. If that is true
then we cannot recycle the page and so when we hit PAGE_SIZE for the
offset we have to drop the mapping and free the page subtracting any
remaining pagecnt_bias we are holding. If I recall I actually ran this
the other way and ran toward 0 in my implementation before as that
allows for not having to track via a value and instead simply checking
for a signed result.

> +}
> +
>  /* For using page_pool replace: alloc_pages() API calls, but provide
>   * synchronization guarantee for allocation side.
>   */
> @@ -293,15 +363,66 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
>
>         /* Fast-path: Get a page from cache */
>         page = __page_pool_get_cached(pool);
> -       if (page)
> +       if (page) {
> +               page_pool_sub_bias(page, 1);
>                 return page;
> +       }

I'm not sure we should be subtracting from the bias here. Ideally if
you are getting a page you are getting the full 4K page. So having a
bias other than PAGE_SIZE - 1 wouldn't make much sense here.

>
>         /* Slow-path: cache empty, do real allocation */
>         page = __page_pool_alloc_pages_slow(pool, gfp);
> +       if (page)
> +               page_pool_sub_bias(page, 1);
> +

Same here. Really in both cases we should be getting initialized
pages, not ones that are already decrementing.

>         return page;
>  }
>  EXPORT_SYMBOL(page_pool_alloc_pages);
>
> +struct page *page_pool_alloc_frag(struct page_pool *pool,
> +                                 unsigned int *offset, gfp_t gfp)
> +{
> +       unsigned int frag_offset = pool->frag_offset;
> +       unsigned int frag_size = pool->p.frag_size;
> +       struct page *frag_page = pool->frag_page;
> +       unsigned int max_len = pool->p.max_len;
> +
> +       if (!frag_page || frag_offset + frag_size > max_len) {

These are two very different cases. If frag_page is set and just out
of space we need to be freeing the unused references.

> +               frag_page = page_pool_alloc_pages(pool, gfp);

So as per my comment above the page should be coming in with a
pagecnt_bias of PAGE_SIZE - 1, and an actual page_ref_count of
PAGE_SIZE.

> +               if (unlikely(!frag_page)) {
> +                       pool->frag_page = NULL;
> +                       return NULL;
> +               }
> +
> +               pool->frag_page = frag_page;
> +               frag_offset = 0;
> +
> +               page_pool_sub_bias(frag_page, max_len / frag_size - 1);

Why are you doing division here? We should just be subtracting 1 from
the pagecnt_bias since that is the number of buffers that are being
used. The general idea is that when pagecnt_bias is 0 we cut the page
loose for potential recycling or freeing, otherwise we just subtract
our new value from pagecnt_bias until we reach it.

> +       }
> +
> +       *offset = frag_offset;
> +       pool->frag_offset = frag_offset + frag_size;
> +
> +       return frag_page;
> +}
> +EXPORT_SYMBOL(page_pool_alloc_frag);
> +
> +static void page_pool_empty_frag(struct page_pool *pool)
> +{
> +       unsigned int frag_offset = pool->frag_offset;
> +       unsigned int frag_size = pool->p.frag_size;
> +       struct page *frag_page = pool->frag_page;
> +       unsigned int max_len = pool->p.max_len;
> +
> +       if (!frag_page)
> +               return;
> +
> +       while (frag_offset + frag_size <= max_len) {
> +               page_pool_put_full_page(pool, frag_page, false);
> +               frag_offset += frag_size;
> +       }
> +
> +       pool->frag_page = NULL;
> +}
> +

It would be good to look over the page_frag_alloc_align and
__page_frag_cache_drain functions for examples of how to do most of
this. The one complication is that we have the dma mappings and
page_pool logic to deal with.

>  /* Calculate distance between two u32 values, valid if distance is below 2^(31)
>   *  https://en.wikipedia.org/wiki/Serial_number_arithmetic#General_Solution
>   */
> @@ -326,10 +447,11 @@ static s32 page_pool_inflight(struct page_pool *pool)
>   * a regular page (that will eventually be returned to the normal
>   * page-allocator via put_page).
>   */
> -void page_pool_release_page(struct page_pool *pool, struct page *page)
> +static int __page_pool_release_page(struct page_pool *pool,
> +                                   struct page *page)
>  {
>         dma_addr_t dma;
> -       int count;
> +       int bias, count;
>
>         if (!(pool->p.flags & PP_FLAG_DMA_MAP))
>                 /* Always account for inflight pages, even if we didn't
> @@ -345,22 +467,29 @@ void page_pool_release_page(struct page_pool *pool, struct page *page)
>                              DMA_ATTR_SKIP_CPU_SYNC);
>         page_pool_set_dma_addr(page, 0);
>  skip_dma_unmap:
> -       page->pp_magic = 0;
> +       bias = page_pool_clear_pp_info(page);
>
>         /* This may be the last page returned, releasing the pool, so
>          * it is not safe to reference pool afterwards.
>          */
>         count = atomic_inc_return(&pool->pages_state_release_cnt);
>         trace_page_pool_state_release(pool, page, count);
> +       return bias;
> +}
> +
> +void page_pool_release_page(struct page_pool *pool, struct page *page)
> +{
> +       int bias = __page_pool_release_page(pool, page);
> +
> +       WARN_ONCE(bias, "PAGECNT_BIAS is not supposed to be enabled\n");
>  }
>  EXPORT_SYMBOL(page_pool_release_page);
>
>  /* Return a page to the page allocator, cleaning up our state */
>  static void page_pool_return_page(struct page_pool *pool, struct page *page)
>  {
> -       page_pool_release_page(pool, page);
> +       __page_frag_cache_drain(page, __page_pool_release_page(pool, page) + 1);
>
> -       put_page(page);
>         /* An optimization would be to call __free_pages(page, pool->p.order)
>          * knowing page is not part of page-cache (thus avoiding a
>          * __page_cache_release() call).
> @@ -395,7 +524,16 @@ static bool page_pool_recycle_in_cache(struct page *page,
>         return true;
>  }
>
> -/* If the page refcnt == 1, this will try to recycle the page.
> +static bool page_pool_bias_page_recyclable(struct page *page, int bias)
> +{
> +       int ref = page_ref_dec_return(page);
> +
> +       WARN_ON(ref < bias);
> +       return ref == bias + 1;
> +}
> +
> +/* If pagecnt_bias == 0 and the page refcnt == 1, this will try to
> + * recycle the page.
>   * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
>   * the configured size min(dma_sync_size, pool->max_len).
>   * If the page refcnt != 1, then the page will be returned to memory
> @@ -405,16 +543,35 @@ static __always_inline struct page *
>  __page_pool_put_page(struct page_pool *pool, struct page *page,
>                      unsigned int dma_sync_size, bool allow_direct)
>  {
> -       /* This allocator is optimized for the XDP mode that uses
> +       int bias = page->pp_info->pagecnt_bias;
> +
> +       /* Handle the elevated refcnt case first:
> +        * multi-frames-per-page, it is likely from the skb, which
> +        * is likely called in non-sofrirq context, so do not recycle
> +        * it in pool->alloc.
> +        *
> +        * Then handle non-elevated refcnt case:
>          * one-frame-per-page, but have fallbacks that act like the
>          * regular page allocator APIs.
> -        *
>          * refcnt == 1 means page_pool owns page, and can recycle it.
>          *
>          * page is NOT reusable when allocated when system is under
>          * some pressure. (page_is_pfmemalloc)
>          */
> -       if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
> +       if (bias) {
> +               /* We have gave some refcnt to the stack, so wait for
> +                * all refcnt of the stack to be decremented before
> +                * enabling recycling.
> +                */
> +               if (!page_pool_bias_page_recyclable(page, bias))
> +                       return NULL;
> +
> +               /* only enable recycling when it is not pfmemalloced */
> +               if (!page_is_pfmemalloc(page))
> +                       return page;
> +

So this would be fine if this was only accessed from the driver. The
problem is the recycling code made it so that this is accessed in the
generic skb freeing path. As such I think this is prone to races since
you have to guarantee the ordering of things between the reference
count and pagecnt_bias.

> +       } else if (likely(page_ref_count(page) == 1 &&
> +                         !page_is_pfmemalloc(page))) {
>                 /* Read barrier done in page_ref_count / READ_ONCE */
>
>                 if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> @@ -428,22 +585,8 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>                 /* Page found as candidate for recycling */
>                 return page;
>         }
> -       /* Fallback/non-XDP mode: API user have elevated refcnt.
> -        *
> -        * Many drivers split up the page into fragments, and some
> -        * want to keep doing this to save memory and do refcnt based
> -        * recycling. Support this use case too, to ease drivers
> -        * switching between XDP/non-XDP.
> -        *
> -        * In-case page_pool maintains the DMA mapping, API user must
> -        * call page_pool_put_page once.  In this elevated refcnt
> -        * case, the DMA is unmapped/released, as driver is likely
> -        * doing refcnt based recycle tricks, meaning another process
> -        * will be invoking put_page.
> -        */
> -       /* Do not replace this with page_pool_return_page() */
> +
>         page_pool_release_page(pool, page);
> -       put_page(page);
>
>         return NULL;
>  }
> @@ -452,6 +595,7 @@ void page_pool_put_page(struct page_pool *pool, struct page *page,
>                         unsigned int dma_sync_size, bool allow_direct)
>  {
>         page = __page_pool_put_page(pool, page, dma_sync_size, allow_direct);
> +
>         if (page && !page_pool_recycle_in_ring(pool, page)) {
>                 /* Cache full, fallback to free pages */
>                 page_pool_return_page(pool, page);
> @@ -503,8 +647,11 @@ static void page_pool_empty_ring(struct page_pool *pool)
>
>         /* Empty recycle ring */
>         while ((page = ptr_ring_consume_bh(&pool->ring))) {
> -               /* Verify the refcnt invariant of cached pages */
> -               if (!(page_ref_count(page) == 1))
> +               /* Verify the refcnt invariant of cached pages for
> +                * non elevated refcnt case.
> +                */
> +               if (!(pool->p.flags & PP_FLAG_PAGECNT_BIAS) &&
> +                   !(page_ref_count(page) == 1))
>                         pr_crit("%s() page_pool refcnt %d violation\n",
>                                 __func__, page_ref_count(page));
>
> @@ -544,6 +691,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
>
>  static void page_pool_scrub(struct page_pool *pool)
>  {
> +       page_pool_empty_frag(pool);
>         page_pool_empty_alloc_cache_once(pool);
>         pool->destroy_cnt++;
>
> @@ -637,14 +785,13 @@ bool page_pool_return_skb_page(struct page *page)
>         if (unlikely(page->pp_magic != PP_SIGNATURE))
>                 return false;
>
> -       pp = page->pp;
> +       pp = page->pp_info->pp;
>
>         /* Driver set this to memory recycling info. Reset it on recycle.
>          * This will *not* work for NIC using a split-page memory model.
>          * The page will be returned to the pool here regardless of the
>          * 'flipped' fragment being in use or not.
>          */
> -       page->pp = NULL;
>         page_pool_put_full_page(pp, page, false);
>
>         return true;
> --
> 2.7.4
>

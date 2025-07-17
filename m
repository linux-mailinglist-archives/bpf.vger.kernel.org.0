Return-Path: <bpf+bounces-63550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E22B0833C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 05:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80CC1AA5414
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3171D1E5207;
	Thu, 17 Jul 2025 03:09:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA71F95C;
	Thu, 17 Jul 2025 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721758; cv=none; b=pIpBlqZHxlQub+HqACXWJYbixdzJsQCM2yTcmx7EAg9idbdHCOztGgU4EpRagP4dykPEXa3Wz1/VLDz5wXP0NaUd4+V83eDZQyAOzqbK5PvsKBpU6zqFJRgA44Cu2Fv6+ToJVCS72aJgvEEz79+8Wn3+Qr6PBS7Ad3U6DBNP91w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721758; c=relaxed/simple;
	bh=/A6dkkboZZCec41Ma72Iyrcv75pL7Zzl0qbmSOdeQL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBC3elas4/RWf37y6ecGzWOQV8/s3aH24RVff4UvfoG+du14ZXTwvw6mJ1YjZuuaP3i4Fe0azj+fpFksXYYdmVLhSpoeFbwRY/vCSrI4hHDN4xVsQ2zTGE8auZFQGjygGYqXpyxAdBLvzH02Ew5sAfqSE87f79ZAML4bIEglIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-57-6878694f2f10
Date: Thu, 17 Jul 2025 12:08:58 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>,
	David Hildenbrand <david@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
Message-ID: <20250717030858.GA26168@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-4-byungchul@sk.com>
 <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
 <20250711011435.GC40145@system.software.com>
 <582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e+cnXNcDv6tsr8VgasIlOyCH17SrIjg0B2iLxXl1EMbzWWz
	dBOtVUI20jK7zgWTzGwaqyVzSVot0yRhscjWzdVMQzTN28hMzaNEfnt43uf58X54OEpxVbqA
	0+iOCXqdSqtkZLTsR3jpip0ag3qVyb8SrI4qBip/GeDOF7cUrHYXgqGRjywMNjQxcKs0RIHV
	m0fDsOM3BR2NQRYqndshUN5Jw+OzNRQEL7xkoCBvlIK6kV4WTrsrJPDaVSiFy79vU1Bj+sLC
	m1orA21VE1Lo9BTQ0Gy5S0OgcAM02iIg9KoHQYOjRgKh8zcZKPbZGGjPCyDwPQ/SUHKqEIGj
	3i+F0V+TjJIXbeyGpfzznj6Kr777XsI/snxmeZvzOP+wIpo3+30U77SfY3jnwCWW/9T6mOFf
	Xh+l+UfuQQlfcKaX4fs7PtB8X/1bhndUv6X5FlsDu2v2XllCqqDVZAr6lYlJMrW7KESnl603
	lNaW0CZUv8qMOI7gOFLsjjOjsCn59FofI9o0XkY89hWizeDlxO8foUQ9F8eQ7nceVtQUfseQ
	cmeiGJ+DDcT+aqopx0B8Y3vNSMYpsFlCHP3dUjEux7NJ841v9HQ1mvjHuyRinsILyZ1xTrTD
	8Dpiqeuaos/DS8hTV5NE5BDs5sjlsjLp9JeR5FmFn76IsGUG1jIDa/mPtSHKjhQaXWaaSqON
	i1UbdRpDbMqRNCeaXEt57p99bjTwercHYQ4pw+VJ97PUCqkqM8OY5kGEo5Rz5cW+TLVCnqoy
	Zgv6Iwf1x7VChgct5GjlfPmaUFaqAh9SHRMOC0K6oP93lXBhC0zoKK7d49JpmqxRmybWGmcl
	DjQuTqYSwnMeNDyJNy3aHxiuunVg6OSWXO1a/VBXtTLqe7N3oyUpR5MSolq0Eds+umIsV53X
	o0uftHgvjM2v3J5a5D0U4/BmByPb6zbHRMV/HdPHng4k5LfuS95R2Lo1+LN+64l7csFn3CXL
	97snrijpDLVqdTSlz1D9BfwjHZcpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+59zdnZcDY7L8jSFYiGBkhoZvHSxUZF/BLtAENSHHHloS121
	6ZxBZDoq56XsgrUtWlSzLWGxZE5T02leEDIm5krLWhaVknmlua4ror49PO/v93x6GVISpKSM
	Sp3Ha9SKHBktokQ7NpSs3qnSK5MfP4gFi7OWhrtf9FDzyiMAi8ONYCY4JITpji4abt6YI8HS
	Z6Bg1jlPwtvOgBDuujJgxPaOgqYz9SQEznXTUGEIkdAc/CSEYs8dAtqv9QjgibtSAJfmb5NQ
	X/RKCP2NFhpe1v4QwDtvBQU9JjsFI5Vy6LQuhbnecQQdznoC5sqv0XDRZ6XhjWEEga89QIH5
	VCUCZ4tfAKEvvzbMj14K5XG4fXyCxHX2ZwRuML0QYqsrH9+/E4+Nfh+JXY5SGrumLgjx8NMm
	GndfCVG4wTNN4IqSTzSefPucwhMtAzS++f4zgZ11A9QuyT7Rxiw+R6XjNUmpmSKlp2qOOnpr
	s/5Go5kqQi3JRhTBcGwK11o9QRsRw1BsHOd1rA7XNLuK8/uDZDhHsQnc2KBXGM4kO0hzNldq
	GF/M6jlH729TzALn+7bPiESMhDUSnHNyTBDGxWwk13N1lPqjxnP+7x+IME+yMVzNdyZcR7Cb
	OFPzh9/rS9iVXKu7iziPxKb/bNN/tumfbUWkA0Wp1LpchSpnXaI2W1moVukTDx7JdaFfD2E7
	8bXKg2b607yIZZBskTjzXoFSIlDotIW5XsQxpCxKfNGnU0rEWYrC47zmyAFNfg6v9aIYhpJF
	i9P38pkS9pAij8/m+aO85u+VYCKkRehh3NfLeR3BVQ0xw9qgQR/oGPuoXtD8se16mX3gpGp/
	9/LW8t3VoWPbl/f0Vc3LY+tN9jTT+tJvsPF0+miG0bhiPHqh133G1iZ9oA+dlR9OS1pWMHp1
	6zbvdLK8+DRRNvR6uE4q2zJ4YjCxPHLaPNUPblxQmzK73Z8AgeiRPWtllFapWBNParSKn16C
	57gMAwAA
X-CFilter-Loop: Reflected

On Sat, Jul 12, 2025 at 02:58:14PM +0100, Pavel Begunkov wrote:
> On 7/11/25 02:14, Byungchul Park wrote:
> ...>>> +#ifdef CONFIG_PAGE_POOL
> > > > +/* XXX: This would better be moved to mm, once mm gets its way to
> > > > + * identify the type of page for page pool.
> > > > + */
> > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > +{
> > > > +       struct netmem_desc *desc = page_to_nmdesc(page);
> > > > +
> > > > +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > +}
> > > 
> > > pages can be pp pages (where they have pp fields inside of them) or
> > > non-pp pages (where they don't have pp fields inside them, because
> > > they were never allocated from the page_pool).
> > > 
> > > Casting a page to a netmem_desc, and then checking if the page was a
> > > pp page doesn't makes sense to me on a fundamental level. The
> > > netmem_desc is only valid if the page was a pp page in the first
> > > place. Maybe page_to_nmdesc should reject the cast if the page is not
> > > a pp page or something.
> > 
> > Right, as you already know, the current mainline code already has the
> > same problem but we've been using the werid way so far, in other words,
> > mm code is checking if it's a pp page or not by using ->pp_magic, but
> > it's ->lur, ->buddy_list, or ->pcp_list if it's not a pp page.
> > 
> > Both the mainline code and this patch can make sense *only if* it's
> > actually a pp page.  It's unevitable until mm provides a way to identify
> > the type of page for page pool.  Thoughts?
> Question to mm folks, can we add a new PGTY for page pool and use
> that to filter page pool originated pages? Like in the incomplete
> and untested diff below?
> 
> 
> commit 8fc2347fb3ff4a3fc7929c70a5a21e1128935d4a
> Author: Pavel Begunkov <asml.silence@gmail.com>
> Date:   Sat Jul 12 14:29:52 2025 +0100
> 
>     net/mm: use PGTY for tracking page pool pages
> 
>     Currently, we use page->pp_magic to determine whether a page belongs to
>     a page pool. It's not ideal as the field is aliased with other page
>     types, and thus needs to to rely on elaborated rules to work. Add a new
>     page type for page pool.

Hi Pavel,

I need this work to be done to remove ->pp_magic in struct page.  Will
you let me work on this work?  Or can you please refine and post this
work?  If you let me, I will go for this as a separate patch from this
series.

	Byungchul

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ef2ba0c667a..975a013f1f17 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4175,7 +4175,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  #ifdef CONFIG_PAGE_POOL
>  static inline bool page_pool_page_is_pp(struct page *page)
>  {
> -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> +       return PageNetpp(page);
>  }
>  #else
>  static inline bool page_pool_page_is_pp(struct page *page)
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4fe5ee67535b..9bd1dfded2fc 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -957,6 +957,7 @@ enum pagetype {
>        PGTY_zsmalloc           = 0xf6,
>        PGTY_unaccepted         = 0xf7,
>        PGTY_large_kmalloc      = 0xf8,
> +       PGTY_netpp              = 0xf9,
> 
>        PGTY_mapcount_underflow = 0xff
>  };
> @@ -1101,6 +1102,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
> 
> +/*
> + * Marks page_pool allocated pages
> + */
> +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> +
>  /**
>   * PageHuge - Determine if the page belongs to hugetlbfs
>   * @page: The page to test.
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index de1d95f04076..20f5dbb08149 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -113,6 +113,8 @@ static inline bool netmem_is_net_iov(const netmem_ref netmem)
>   */
>  static inline struct page *__netmem_to_page(netmem_ref netmem)
>  {
> +       DEBUG_NET_WARN_ON_ONCE(netmem_is_net_iov(netmem));
> +
>        return (__force struct page *)netmem;
>  }
> 
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index cd95394399b4..e38c64da1a78 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -13,16 +13,11 @@ static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
>        __netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
>  }
> 
> -static inline void netmem_clear_pp_magic(netmem_ref netmem)
> -{
> -       WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
> -
> -       __netmem_clear_lsb(netmem)->pp_magic = 0;
> -}
> -
>  static inline bool netmem_is_pp(netmem_ref netmem)
>  {
> -       return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> +       if (netmem_is_net_iov(netmem))
> +               return true;
> +       return page_pool_page_is_pp(netmem_to_page(netmem));
>  }
> 
>  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 05e2e22a8f7c..52120e2912a6 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -371,6 +371,13 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
>  }
>  EXPORT_SYMBOL(page_pool_create);
> 
> +static void page_pool_set_page_pp_info(struct page_pool *pool,
> +                                      struct page *page)
> +{
> +       __SetPageNetpp(page);
> +       page_pool_set_pp_info(page_to_netmem(page));
> +}
> +
>  static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem);
> 
>  static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
> @@ -534,7 +541,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
>        }
> 
>        alloc_stat_inc(pool, slow_high_order);
> -       page_pool_set_pp_info(pool, page_to_netmem(page));
> +       page_pool_set_page_pp_info(pool, page);
> 
>        /* Track how many pages are held 'in-flight' */
>        pool->pages_state_hold_cnt++;
> @@ -579,7 +586,7 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
>                        continue;
>                }
> 
> -               page_pool_set_pp_info(pool, netmem);
> +               page_pool_set_page_pp_info(pool, __netmem_to_page(netmem));
>                pool->alloc.cache[pool->alloc.count++] = netmem;
>                /* Track how many pages are held 'in-flight' */
>                pool->pages_state_hold_cnt++;
> @@ -654,7 +661,6 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
>  void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>  {
>        netmem_set_pp(netmem, pool);
> -       netmem_or_pp_magic(netmem, PP_SIGNATURE);
> 
>        /* Ensuring all pages have been split into one fragment initially:
>         * page_pool_set_pp_info() is only called once for every page when it
> @@ -669,7 +675,6 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
> 
>  void page_pool_clear_pp_info(netmem_ref netmem)
>  {
> -       netmem_clear_pp_magic(netmem);
>        netmem_set_pp(netmem, NULL);
>  }
> 
> @@ -730,8 +735,11 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
>        trace_page_pool_state_release(pool, netmem, count);
> 
>        if (put) {
> +               struct page *page = netmem_to_page(netmem);
> +
>                page_pool_clear_pp_info(netmem);
> -               put_page(netmem_to_page(netmem));
> +               __ClearPageNetpp(page);
> +               put_page(page);
>        }
>        /* An optimization would be to call __free_pages(page, pool->p.order)
>         * knowing page is not part of page-cache (thus avoiding a
> 
> --
> Pavel Begunkov


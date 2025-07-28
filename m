Return-Path: <bpf+bounces-64508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174A2B13964
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 12:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E717A6BB
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF682571B6;
	Mon, 28 Jul 2025 10:57:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2953621A95D;
	Mon, 28 Jul 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700277; cv=none; b=CqgBZOGN7cTvf3W8VfH57tQhYkc84UJmBUVw5cGToKdg/CvQBf0ih2ntkZUS3w98C9JgCHraQb4oMQLFUo76pSuQVJRfCT+h5D0v8Np2e83IrRTEKlHTndpvhbJ9gPaFNvKGQMyiJMKPSzPYA8DSyNfrW61nwp+J46TxWLNUBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700277; c=relaxed/simple;
	bh=A4knATuivEowMF1PWUDb3KzqGWKHX3mVmc45WU2zTGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTC1uHAZm880vO9wV/yGLwftwar/ZTaBmgrLjZltPMArqNZ/6rhCfaC8p8ZY3HJvmFGnz5QehMbCcYH7HSwvSo7+VVLq30Eiyg28xBeq+hnBgL7ya1H6HWFd4RudshoKI6Dw4xtJZlLPMuFIWOpT4+lcsdps7NPtHoDNyZXSHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-41-688757afd71e
Date: Mon, 28 Jul 2025 19:57:46 +0900
From: Byungchul Park <byungchul@sk.com>
To: linux-mm@kvack.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page
 pool in page type
Message-ID: <20250728105746.GB21732@system.software.com>
References: <20250728052742.81294-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728052742.81294-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG853v9JzTYs2xon7WmJiaiWKGzqB7ZWYy5Y8vMS4YgxrvRY5r
	M4qkFQZLCKh4IwKimEgtsUQRClVIVaAI05WbDKcELzmKk8vAS2DowKEFA3IwZv73y/O+z/O8
	f7wC1nlVesEct1+yxhljDZyG1fwzpeDr8s1HTUuv3ETgKHNzUPo+CYo6q1TgKKlA8NbfzsN4
	bSOCofomDvrqBhFcKBjG4LiXzsJ/ZSMYehu7eSj1rIeOS89ZqDlaiaE7+zYHmemjGGr9Azwc
	rCpmwHE1jYfWiiwV5I4UYqhM6+ThfrWDg2fucRU892Wy0Gx3sfDmTD2GjqxwaHTOhOGWfgT1
	ZZUMDJ/I5+BhXjUD12sf8nC6zcnB3+kdCNrqulk48+EYB+cOZCEYfT8ROXDyrQrONTzjwxfT
	A7LM0br+15hecz1mqPzbHwz12v/iqdOTQK8WB9MMuQ1TT8lxjnoGT/H06aMajt4+O8pSb9dK
	6q0aYmjmoQGO/tv7hI0M3KpZFSPFmhMl65Lvd2tMea7o+JYNSf0lPpyGLv+QgdQCEUPJA9cV
	lIGESc53LldkVvyKHD/kVinMiUFElv1Y4UAxhAw1jrAZSCNg8SxPctw1nOKdLu4g5Te/U3a0
	IpCeu9mMwjpxOfEefMd+0qeR5ryeScZiMJHHXjGKFYtzSNGYoMhqcQUpah6brJ0hzie3KpoY
	pYqIPQLJfnBN9enk2eT3Ypk9iUT7F7H2L2Lt/8c6ES5BOnNcosVojg0NMSXHmZNC9uyzeNDE
	Q11K+bCtCg22bvQhUUCGKdqX3x4x6VTGRFuyxYeIgA2B2vjCCUkbY0z+VbLu22VNiJVsPjRH
	YA2ztMuGf4nRiT8Z90s/S1K8ZP08ZQS1Pg3t3YJXw87oP338DtuagqiwH28Un9++pZwcDuA2
	2Z2ptCu8r/ziyhunN8+0LLKMq+eGpazt1fvt7NLC1L7d/khuYW7uwrWrUiIaQL4QdC9av0S/
	13cnInXuOpt73ovSnJZFI1ENRaMD79RP7lSHtU/1n28y50TMsC0b6nQFaPV3FxhYm8n4TTC2
	2owfAdeuInBMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec97bq4Gp6V1MIhYV4bZdfV0v0D0VhZFUBFFnfTURvPCVqJB
	sdyotDS7GDknrUydZlmr1NnMmKaZdMFIZpaaWRQNu2iWFyxXRH378X+e3/N8+fNYlcWE8vqY
	fbIxRjKoWQWtWLfAMrV481Hd9NQcDdiLi1i48iMB8tvKGLAXliDo7m3m4GdFDYKu6loWPlZ9
	RZBzsQeD/YmVhm/FfRje1rRzcMW1Flrz3tHgOVqKof3kAxZSrf0YKno7OUgqc1Jgv2nmoCq7
	joGnJWkMnO3LxVBqbuPgWbmdhZainwy886bSUGcroOFzRjWG1rSlUOMYBT31fgTVxaUU9JzI
	ZuF5ZjkFtyuec3CmwcHCG2srgoaqdhoyBo6xkHU4DUH/j6GTnendDGTdb+GWhpHDPh9Lqvyf
	MLlV0EQR392HFHHbXnHE4dpPbjo1JMXXgImrMJklrq+nOfKy0cOSB+f7aeJ+PY+4y7ookmrp
	ZMmXty/o9SFbFQujZIM+XjZOW7xTocss2BVXvyHBX+jFZnR1WQrieVGYLWY7tCkoiKeFiWKy
	pYgJMCtMFn2+XhzgYCFc7Krpo1OQgsfCeU48VeRhA+5IYbt4vXJBYEcpgNjx+CQVYJWgFd1J
	3+k/+QixLrPjN2NBI/oGP1ABFQtjxPxBPhAHCXPE/LrB329DhPHivZJaKh0pbf/Ztv9s2z/b
	gXAhCtbHxEdLeoM23LRXlxijTwiPjI12oaHK5B0cOFWGup+t9CKBR+rhyvdzj+hUjBRvSoz2
	IpHH6mBlXO5QpIySEg/Ixtgdxv0G2eRFY3haPVq5erO8UyXskfbJe2U5Tjb+nVJ8UKgZzbq8
	aWVJ0zVjdNuX3WPfN21ccTV0o2l4kvlz9YSnlcHX/RGNIY/c85VLRt2qXb7trjOvXBpYNFV/
	fK5lj3NW7bessEtOsuW41BWW2TJtU9IdJuxQck7o6xuxZ+otHv+iSQatKXL6TGeQdZi1Z8o4
	ba7nAhO36lxGx5qQyPQIlSbD36ymTTpphgYbTdIvbYdATi4DAAA=
X-CFilter-Loop: Reflected

On Mon, Jul 28, 2025 at 02:27:42PM +0900, Byungchul Park wrote:
> Changes from v1:
> 	1. Rebase on linux-next.

+cc sfr@canb.auug.org.au

	Byungchul

> 	2. Initialize net_iov->pp = NULL when allocating net_iov in
> 	   net_devmem_bind_dmabuf() and io_zcrx_create_area().
> 	3. Use ->pp for net_iov to identify if it's pp rather than
> 	   always consider net_iov as pp.
> 	4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
> 
> ---8<---
> >From 08b65324282bbe683a2479faef8eb24df249fd18 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Mon, 28 Jul 2025 14:07:17 +0900
> Subject: [PATCH v2] mm, page_pool: introduce a new page type for page pool in page type
> 
> ->pp_magic field in struct page is current used to identify if a page
> belongs to a page pool.  However, ->pp_magic will be removed and page
> type bit in struct page e.i. PGTY_netpp can be used for that purpose.
> 
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
> 
> For net_iov, use ->pp to identify if it's pp, with making sure that ->pp
> is NULL for non-pp net_iov.
> 
> This work was inspired by the following link:
> 
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> 
> While at it, move the sanity check for page pool to on free.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
>  include/linux/mm.h                            | 27 +++----------------
>  include/linux/page-flags.h                    |  6 +++++
>  io_uring/zcrx.c                               |  1 +
>  mm/page_alloc.c                               |  7 +++--
>  net/core/devmem.c                             |  1 +
>  net/core/netmem_priv.h                        | 23 +++++++---------
>  net/core/page_pool.c                          | 10 +++++--
>  8 files changed, 33 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 5ce1b463b7a8..79a3ceff3952 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
>  				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
>  				page = xdpi.page.page;
>  
> -				/* No need to check page_pool_page_is_pp() as we
> +				/* No need to check PageNetpp() as we
>  				 * know this is a page_pool page.
>  				 */
>  				page_pool_recycle_direct(page->pp, page);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3bfb566ad202..d01b296e7184 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4171,10 +4171,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>   * DMA mapping IDs for page_pool
>   *
>   * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
> - * stashes it in the upper bits of page->pp_magic. We always want to be able to
> - * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
> - * pages can have arbitrary kernel pointers stored in the same field as pp_magic
> - * (since it overlaps with page->lru.next), so we must ensure that we cannot
> + * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
> + * arbitrary kernel pointers stored in the same field as pp_magic (since
> + * it overlaps with page->lru.next), so we must ensure that we cannot
>   * mistake a valid kernel pointer with any of the values we write into this
>   * field.
>   *
> @@ -4205,26 +4204,6 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
>  				  PP_DMA_INDEX_SHIFT)
>  
> -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
> - * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
> - * the head page of compound page and bit 1 for pfmemalloc page, as well as the
> - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> - */
> -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> -
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -	return false;
> -}
> -#endif
> -
>  #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
>  #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
>  #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 8e4d6eda8a8d..548a68415845 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -935,6 +935,7 @@ enum pagetype {
>  	PGTY_zsmalloc		= 0xf6,
>  	PGTY_unaccepted		= 0xf7,
>  	PGTY_large_kmalloc	= 0xf8,
> +	PGTY_netpp		= 0xf9,
>  
>  	PGTY_mapcount_underflow = 0xff
>  };
> @@ -1079,6 +1080,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
>  
> +/*
> + * Marks page_pool allocated pages.
> + */
> +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> +
>  /**
>   * PageHuge - Determine if the page belongs to hugetlbfs
>   * @page: The page to test.
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index 100b75ab1e64..34634552cf74 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -444,6 +444,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
>  		area->freelist[i] = i;
>  		atomic_set(&area->user_refs[i], 0);
>  		niov->type = NET_IOV_IOURING;
> +		niov->pp = NULL;
>  	}
>  
>  	area->free_count = nr_iovs;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fa09154a799c..cb90d6a3fd9d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1042,7 +1042,6 @@ static inline bool page_expected_state(struct page *page,
>  #ifdef CONFIG_MEMCG
>  			page->memcg_data |
>  #endif
> -			page_pool_page_is_pp(page) |
>  			(page->flags & check_flags)))
>  		return false;
>  
> @@ -1069,8 +1068,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>  	if (unlikely(page->memcg_data))
>  		bad_reason = "page still charged to cgroup";
>  #endif
> -	if (unlikely(page_pool_page_is_pp(page)))
> -		bad_reason = "page_pool leak";
>  	return bad_reason;
>  }
>  
> @@ -1379,9 +1376,11 @@ __always_inline bool free_pages_prepare(struct page *page,
>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>  		folio->mapping = NULL;
>  	}
> -	if (unlikely(page_has_type(page)))
> +	if (unlikely(page_has_type(page))) {
> +		WARN_ON_ONCE(PageNetpp(page));
>  		/* Reset the page_type (which overlays _mapcount) */
>  		page->page_type = UINT_MAX;
> +	}
>  
>  	if (is_check_pages_enabled()) {
>  		if (free_page_is_bad(page))
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index b3a62ca0df65..40e7a4ec9009 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -285,6 +285,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  			niov = &owner->area.niovs[i];
>  			niov->type = NET_IOV_DMABUF;
>  			niov->owner = &owner->area;
> +			niov->pp = NULL;
>  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
>  						      net_devmem_get_dma_addr(niov));
>  			if (direction == DMA_TO_DEVICE)
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index cd95394399b4..4b90332d6c64 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -8,21 +8,18 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
>  	return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
>  }
>  
> -static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
> -{
> -	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
> -}
> -
> -static inline void netmem_clear_pp_magic(netmem_ref netmem)
> -{
> -	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
> -
> -	__netmem_clear_lsb(netmem)->pp_magic = 0;
> -}
> -
>  static inline bool netmem_is_pp(netmem_ref netmem)
>  {
> -	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> +	/* Use ->pp for net_iov to identify if it's pp, which requires
> +	 * that non-pp net_iov should have ->pp NULL'd.
> +	 */
> +	if (netmem_is_net_iov(netmem))
> +		return !!__netmem_clear_lsb(netmem)->pp;
> +
> +	/* For system memory, page type bit in struct page can be used
> +	 * to identify if it's pp.
> +	 */
> +	return PageNetpp(__netmem_to_page(netmem));
>  }
>  
>  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 05e2e22a8f7c..0a10f3026faa 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -654,7 +654,6 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
>  void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>  {
>  	netmem_set_pp(netmem, pool);
> -	netmem_or_pp_magic(netmem, PP_SIGNATURE);
>  
>  	/* Ensuring all pages have been split into one fragment initially:
>  	 * page_pool_set_pp_info() is only called once for every page when it
> @@ -665,12 +664,19 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>  	page_pool_fragment_netmem(netmem, 1);
>  	if (pool->has_init_callback)
>  		pool->slow.init_callback(netmem, pool->slow.init_arg);
> +
> +	if (netmem_is_net_iov(netmem))
> +		return;
> +	__SetPageNetpp(__netmem_to_page(netmem));
>  }
>  
>  void page_pool_clear_pp_info(netmem_ref netmem)
>  {
> -	netmem_clear_pp_magic(netmem);
>  	netmem_set_pp(netmem, NULL);
> +
> +	if (netmem_is_net_iov(netmem))
> +		return;
> +	__ClearPageNetpp(__netmem_to_page(netmem));
>  }
>  
>  static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
> 
> base-commit: 97987520025658f30bb787a99ffbd9bbff9ffc9d
> -- 
> 2.17.1


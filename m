Return-Path: <bpf+bounces-63884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBDFB0BEAF
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F6B3BB1CC
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3182877E0;
	Mon, 21 Jul 2025 08:19:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775BD22D781;
	Mon, 21 Jul 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085968; cv=none; b=mzhohovBqsmaheCbLFnjMPZMUw11iul1pA+hGwgH0aZEtsAMwT+E0+MOAwcqd2t+baNw0ENnkNrEjx17peG9k0eV+FIrPxpHijWqEMKI4jfYgVSWSOJ94zwSVs5wIoTKBuzm8n4IlzfXfJLSmX1XX7+smiD5Pg5zmLNhs+o8cE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085968; c=relaxed/simple;
	bh=3qogy6Eu124weeVZ0Zp2cNlMb4SiB0GBWDEiO6+5yyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2neEhN74Hkj23wc5MnM7fxhiEfgvuv/6uFwykQDSW4UqjaK0gczCFEC0wVlusePNSuD3O06BfW1l97491yOg50EowAWxX6g3dHQFtfNG2o29Tvr0WG0eUMd/ff63wyvI4kpXh+XX2ZgLZjjDFnmZSdcphg2elGqaX81IDFRIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-91-687df80446e0
Date: Mon, 21 Jul 2025 17:19:10 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool
 in page type
Message-ID: <20250721081910.GA21207@system.software.com>
References: <20250721054903.39833-1-byungchul@sk.com>
 <e897e784-4403-467c-b3e4-4ac4dc7b2e25@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e897e784-4403-467c-b3e4-4ac4dc7b2e25@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0zMcRjHfb6f732/327Ovs7hI3+w83O3Ob+yPQzT/OHjD783mx+TU1/d
	TZ3bpXSmOQpJHaPbdC4iP1JNXOkuU7jSDzZS005SVJhRqKSTxV0Y/732PM/79Tx/PAJWumWh
	gsG4RzIbdTFqTs7Ku0ZenMUOJOnnpH+eDs6iQg4KBhLh6iuPDJz5pQj6/C94+FlejaC3qoaD
	D5U9CHIv9GNwPklh4WvRdwxvqtt5KHCtgrYrb1m4c9SNof1ELQcZKYMYyv3dPBzy5DHgLLby
	UF9qk0Hm98sY3NZXPDTednLQWvhTBm+9GSzUOa6x8NlehaHNtgyqc8ZB/6OPCKqK3Az0p2dz
	8CzrNgOnG3I46EhpQ9BQ2c6C/UcqB2cP2hAMDgRs3Sf7ZHD2QSu/TEMrP37CtOTac4b6Kh4y
	tMzxkqc5rnhanKehab4GTF35xzjq6jnF05amOxytPTPI0rLXC2mZp5ehGcndHP3yppmlnyqe
	cWvHbJYvjpJiDAmSefbS7XJ9XXYGNuWGJyb7e3kr+qZNQyECEcPI9XdD/F/uKqllgsyK04g9
	6wkKMifOID6fHwdZJc4kriM3AiwXsOjkSYMtezg8RtxM6q3lw2GFCORMctpwQCkaiP30b5FC
	HE3qsjrZIGNRQ3xD7wPzQoAnkqtDQrAcIi4ll5psw5qx4hRyr7SGCe4iYotAOppv/jl0Armf
	52NPItHxn9bxn9bxT5uDcD5SGowJsTpDTJhWbzEaErWRu2NdKPBOV5J+bPGgnvoNXiQKSD1S
	YWKT9EqZLiHOEutFRMBqlYLW7NMrFVE6yz7JvDvCHB8jxXnRRIFVj1fM698bpRSjdXukXZJk
	ksx/u4wQEmpFa1u3teU+tqw8tzp1vvv4iLQbByftUIV/9SRv3JuSvq7k/IUlHVst97WtLYYK
	7YKoUWuKCxZVT9d2xkfLmn34aU2oSaUKj9AoPyxvaYw0Nhd22e5mPh3nP27aNPkAN7U99fn6
	zMbSzseHo+1JW96rbkmj9+sjb15cUemNjSh7uWHn9j41G6fXzdVgc5zuFxYBtBZKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec97ds5xtDgtq1NK0SIqI7Po8pRdKeilKMIgQ4o85Kkt3ZSt
	RANhqd0s13WUa4a1vEvGvE1xUmrq6kM1L6yrZllkaqVmXqLajKhvP57///f/9HBYmSGbwWl0
	RyS9ToxRMXJaviM0ZRE9nKQOcZbIwVpcxEDhcALkdjhkYC0oRzA48oKFX84GBAP1jQx8qutH
	YLs5hMH6OJWGb8WjGLoaOlkotG+H9pz3NFSfqsDQeb6JgfTUMQzOkT4Wkh15FFhLjCzUZbpk
	8KTcJIMro9kYKowdLDRXWRl4XfRLBu9r02lwWfJp+GKux9Bu2gANWVNh6FEPgvriCgqGzmUy
	0JpRRcFldxYDb1PbEbjrOmkw/zjNwPXjJgRjw961vguDMrj+4DW7YSGp6/mMSWn+M4p4ah5S
	pNLyiiVZ9qOkJC+IpHncmNgLzjDE3n+JJS/bqhnSdG2MJpVvVpFKxwBF0lP6GPK16zlNPte0
	Mjv9I+RroqQYTbykX7wuUq52ZabjONvGhJSRAdaIvgenIT9O4JcJvaVNlI9pfq5gzniMfMzw
	8wSPZwT72J+fL9hP3vWynMO8lRXcpkzWF0zmI4QnRue4rOBBuJaSNi4oeY1gvvxnSMFPElwZ
	72gfYz5I8Pz86O1zXg4Qcn9yvrMfv0643WYan5nCzxHulTdSF5DC8p9t+c+2/LOzEC5A/hpd
	vFbUxCwPNkSrE3WahOADsVo78j5MTtKPiw402LylFvEcUk1QxNFJaqVMjDckamuRwGGVv4I0
	HlMrFVFi4jFJH7tffzRGMtSiAI5WTVNsDZcilfwh8YgULUlxkv5vSnF+M4woMrAs0Nay9ur9
	544Vro6nZw9GO6Xcw3sCWw5GrC7b1HKjOnS3raOgBk33Cw3JKzFv7+pa2Z08MeTjiakvV53b
	uytsVHc2eJI6oHx9s/zQ930LxJNNS79VvvswrE12o1kV1Y8+hIVjbUNbbz/S980u7p3j6t5s
	mXvrzsxtPVsviknZNhVtUItLgrDeIP4GDJeV7SwDAAA=
X-CFilter-Loop: Reflected

On Mon, Jul 21, 2025 at 10:05:25AM +0200, David Hildenbrand wrote:
> On 21.07.25 07:49, Byungchul Park wrote:
> > Hi,
> > 
> > I focused on converting the existing APIs accessing ->pp_magic field to
> > page type APIs.  However, yes.  Additional works would better be
> > considered on top like:
> > 
> >     1. Adjust how to store and retrieve dma index.  Maybe network guys
> >        can work better on top.
> > 
> >     2. Move the sanity check for page pool in mm/page_alloc.c to on free.
> > 
> >     Byungchul
> > 
> > ---8<---
> >  From 7d207a1b3e9f4ff2a72f5b54b09e3ed0c4aaaca3 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Mon, 21 Jul 2025 14:05:20 +0900
> > Subject: [PATCH] mm, page_pool: introduce a new page type for page pool in page type
> > 
> > ->pp_magic field in struct page is current used to identify if a page
> > belongs to a page pool.  However, page type e.i. PGTY_netpp can be used
> > for that purpose.
> > 
> > Use the page type APIs e.g. PageNetpp(), __SetPageNetpp(), and
> > __ClearPageNetpp() instead, and remove the existing APIs accessing
> > ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> > netmem_clear_pp_magic() since they are totally replaced.
> > 
> > This work was inspired by the following link by Pavel:
> > 
> > [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> 
> I'm, sure you saw my comment (including my earlier suggestion for using
> a page type), in particular around ...

Honestly, I was too confused to understand exactly what you meant.
Maybe my bad but I was and I'm still so.  Lemme add a question below.

> > ---
> >   .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
> >   include/linux/mm.h                            | 28 ++-----------------
> >   include/linux/page-flags.h                    |  6 ++++
> >   include/net/netmem.h                          |  2 +-
> >   mm/page_alloc.c                               |  4 +--
> >   net/core/netmem_priv.h                        | 16 ++---------
> >   net/core/page_pool.c                          | 10 +++++--
> >   7 files changed, 24 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > index 5d51600935a6..def274f5c1ca 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
> >                               xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
> >                               page = xdpi.page.page;
> > 
> > -                             /* No need to check page_pool_page_is_pp() as we
> > +                             /* No need to check PageNetpp() as we
> >                                * know this is a page_pool page.
> >                                */
> >                               page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp,
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index ae50c1641bed..736061749535 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4135,10 +4135,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >    * DMA mapping IDs for page_pool
> >    *
> >    * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
> > - * stashes it in the upper bits of page->pp_magic. We always want to be able to
> > - * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
> > - * pages can have arbitrary kernel pointers stored in the same field as pp_magic
> > - * (since it overlaps with page->lru.next), so we must ensure that we cannot
> > + * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
> > + * arbitrary kernel pointers stored in the same field as pp_magic (since
> > + * it overlaps with page->lru.next), so we must ensure that we cannot
> >    * mistake a valid kernel pointer with any of the values we write into this
> >    * field.
> >    *
> > @@ -4168,25 +4167,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > 
> >   #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
> >                                 PP_DMA_INDEX_SHIFT)
> > -
> > -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
> > - * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
> > - * the head page of compound page and bit 1 for pfmemalloc page, as well as the
> > - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> > - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> > - */
> > -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > -
> > -#ifdef CONFIG_PAGE_POOL
> > -static inline bool page_pool_page_is_pp(const struct page *page)
> > -{
> > -     return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > -}
> > -#else
> > -static inline bool page_pool_page_is_pp(const struct page *page)
> > -{
> > -     return false;
> > -}
> > -#endif
> > -
> >   #endif /* _LINUX_MM_H */
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 4fe5ee67535b..906ba7c9e372 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -957,6 +957,7 @@ enum pagetype {
> >       PGTY_zsmalloc           = 0xf6,
> >       PGTY_unaccepted         = 0xf7,
> >       PGTY_large_kmalloc      = 0xf8,
> > +     PGTY_netpp              = 0xf9,
> > 
> >       PGTY_mapcount_underflow = 0xff
> >   };
> > @@ -1101,6 +1102,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
> >   PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
> >   FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
> > 
> > +/*
> > + * Marks page_pool allocated pages.
> > + */
> > +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> > +
> >   /**
> >    * PageHuge - Determine if the page belongs to hugetlbfs
> >    * @page: The page to test.
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index f7dacc9e75fd..3667334e16e7 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -298,7 +298,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> >    */
> >   #define pp_page_to_nmdesc(p)                                                \
> >   ({                                                                  \
> > -     DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));               \
> > +     DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));                          \
> >       __pp_page_to_nmdesc(p);                                         \
> >   })
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 2ef3c07266b3..71c7666e48a9 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -898,7 +898,7 @@ static inline bool page_expected_state(struct page *page,
> >   #ifdef CONFIG_MEMCG
> >                       page->memcg_data |
> >   #endif
> > -                     page_pool_page_is_pp(page) |
> > +                     PageNetpp(page) |
> >                       (page->flags & check_flags)))
> >               return false;
> > 
> > @@ -925,7 +925,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> >       if (unlikely(page->memcg_data))
> >               bad_reason = "page still charged to cgroup";
> >   #endif
> > -     if (unlikely(page_pool_page_is_pp(page)))
> > +     if (unlikely(PageNetpp(page)))
> >               bad_reason = "page_pool leak";
> >       return bad_reason;
> >   }
> 
> ^ this
> 
> This will not work they way you want it once you rebase on top of
> linux-next, where we have (from mm/mm-stable)
>
> commit 2dfcd1608f3a96364f10de7fcfe28727c0292e5d

I just checked this.

So is it sufficient that I rebase on mm/mm-stable?  Or should I wait for
something else?  Or should I achieve this in other ways?

	Byungchul

> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri Jul 4 12:24:58 2025 +0200
> 
>     mm/page_alloc: let page freeing clear any set page type
> 
> 
> I commented what to do already.
> 
> --
> Cheers,
> 
> David / dhildenb


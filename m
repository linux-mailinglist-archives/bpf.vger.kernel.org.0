Return-Path: <bpf+bounces-64318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E8B11539
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 02:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032BF3A2707
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 00:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A044874040;
	Fri, 25 Jul 2025 00:26:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D1341AA;
	Fri, 25 Jul 2025 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403199; cv=none; b=Y8Y7KwYrnEcEmI5P1tOXLDcKT62vMRIv3ozFVO8DDHQJK6IUjZz6pyNGFIrd/83Fd8BFoh5vw0+pnUX8NnNzvMeMV9YeasGf6WeKLEY9z8I+wLBhGLSeyP99VrBZuY8ujtG4XB5/JZ2UgmLUejmZtZ4GJwZvbotb0ki6/ZetEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403199; c=relaxed/simple;
	bh=agpv9S9Mak0o5aKUB9hyX3H8IhS+yjKewsgU+wSUly4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b10dT4L4JQnLE+nKC0g47DdPWfFCfEz4A/e9/dBVsBsEK6WBf8UxrDFo3Dvc9nMO2sGvriy90aQSWFlBqbd0qINcTLomCOui9Q0os7g6jLzbI1HNEDcEBazt9K6vTWDQ29kTUn3BFwwERkkZFg+Xsc8rizpcfZ0jCxo0iXEEu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-cb-6882cf2f93ac
Date: Fri, 25 Jul 2025 09:26:18 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
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
	toke@redhat.com, asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool
 in page type
Message-ID: <20250725002618.GA11321@system.software.com>
References: <20250721054903.39833-1-byungchul@sk.com>
 <CAHS8izM11fxu6jHZw5VJsHXeZ+Tk+6ZBGDk0vHiOoHyXZoOvOg@mail.gmail.com>
 <20250723044610.GA80428@system.software.com>
 <CAHS8izMO0LO1uKu0peSAC8Sixes06KLfKJvyQnAOiLfDqZd5+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMO0LO1uKu0peSAC8Sixes06KLfKJvyQnAOiLfDqZd5+Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRjHvXvOnnNarTltyiszjG1oZERk5nGZ5Ns74zIMPmAMOzrs0s2W
	aplm1mrIUnJnW2wuqURsqTbVqK1cGlNWy1KJbj4grDS2bWK3GH37zf953+f3//BwlOy5OIhT
	xSUJ6jhFjJyR0JIvvrnz5jfrlAsq7XPBWFzEwO1fqXDrfYUYjIVlCAZcbSz8rm5E8KP+MQOf
	rE4E13MHKTA2p9Pws3iIgt7GLhZum9dAZ14fDVVHyynoOvmEgcx0NwXVrn4WdBX5IjCWaFlo
	KcsSw9mhmxSUa9+z8LLSyMC7ot9i6KvLpOGpoYCGb+fqKejMioJGUyAMNn1GUF9cLoLBE5cZ
	sF+qFMEZm4mB7vROBDZrFw3nhjMYyDmUhcD9y7OtP3tADDkN79ioUGL9/JUipQVvRMRR80xE
	LIYOlpjM+0lJfijRO2wUMRceY4jZeZol7a+qGPLkopsmlg9LiKXih4hkHu5nyPfetzT5WmNn
	1vlvkSyPFmJUyYJ6fuQOibLW1YgS2jenjvR1i7XofpQe+XCYj8BNd44x/7jKbWX1iONofhYe
	erbCGzN8CHY4XJSXJ/Nz8I2aU2IvU/x5Fl8/MsnL/vwW3KKtFnlZygPWZbtH38h4J8INRQlj
	uR9+eqmHHvsbgoev2CiviuKn4Vsj3Fg8Ax9+kDOq8uHX45IC/WizAD4YPyp77Fkv8bTs4fDx
	R21/K0/FtfkOOhv5GcYpDOMUhv8KwziFCdGFSKaKS45VqGIiwpSaOFVq2M74WDPyHFle2vDW
	CuRs2VCHeA7JfaUkRKeUiRXJiZrYOoQ5Sj5Z2nbPE0mjFZoDgjp+u3p/jJBYh6ZxtHyKdOFg
	SrSM361IEvYKQoKg/jcVcT5BWqRxLNs4vTM6zHDeVxO5Psj+Zunaia4UY1pDU8Oe7tIVpXNn
	t0f4536Z2WG9cyEkj7+6a3EHXnmyqNWyr+rGalXk0pVLdlpsZ16k2Pjg1qMB+tno4/dTmp7U
	gJzcn6En8jvA+XDbLl1GUvzdkT0TAux4+aYEv0WBM8INqw4KGQPXal/L6USlIjyUUicq/gAl
	8aVOYAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+d230uS2rC5FFIuwDLOo4NjDpKB+BPagKJJAR17acE67S3FB
	sVR6SJrae1u10ExttJz5qinldGYFimFZmaY2CSwtU3FuZS6J/O/D95zz+f5zOFJuoxdwau1x
	UdIqNQomkArctTEjLLwlXbXa9G0WmG1WBu6Pp8G9T9U0mEsrEYx4PrAwWetC8LOhiYEB5zCC
	gjtjJJhbMikYtU2Q4Hb1snDfHg3dRf0UOM5WkdB78TkD2ZleEmo9gyykVxcTYC43sOC82UxD
	a2UODZcn7pJQZfjEwuvHZga6rJM09NdnU9BsLKHg+5UGErpzosBlmQdjL78iaLBVETB24SYD
	7TceE3CpzcJAX2Y3gjZnLwVXfOcYMJ3OQeAdn7IN5o7QYGrsYqNWYufXIRI/KnlH4I66FwSu
	MX5kscWegsuLQ3FWRxuJ7aXnGWwfzmdx5xsHg59f91K4picC11T/JHB2xiCDf7jfU3iorp3Z
	ExwTuCle1KhTRSk8Mi5Q9czjQsmdh9J+9/fRBlQWlYUCOIFfJzi8TjYLcRzFLxMmXmzxxwwf
	InR0eEg/B/MrhMK6PNrPJH+VFQrOBPl5Dh8jtBpqCT/LeBDSc71/d+T8MBIarcnT+Wyh+cZn
	avo2RPDdaiP9VSS/ULj3m5uOFwsZFaa/VQH8XqG8JIvx81x+qfC0sonIRUHGGSbjDJPxv8k4
	w2RBVCkKVmtTE5VqzfpVugSVXqtOW3UkKdGOpt6o6KQvrxqNvN5Rj3gOKWbJcEi6Sk4rU3X6
	xHokcKQiWPbh4VQki1fqT4hSUqyUohF19WghRynmy3YeFOPk/FHlcTFBFJNF6d+U4AIWGND2
	24vaW38V6p/tcy/O2+8wDIXuKN45UGkNO7UkQvugaXJ08/jguSpv6RuJjO5bn29JKNBo2+W8
	pzemMcEdaXf8mLN7g1SkXFeRv20Pv/xsRNmT74c/d3I9sXlWaeumtYmjTfNerbw4MPuAz0DJ
	LkXH2VwT14K+9Kxd/Xa489iKA5EKSqdSrgklJZ3yD3IX9RFCAwAA
X-CFilter-Loop: Reflected

On Thu, Jul 24, 2025 at 02:23:05PM -0700, Mina Almasry wrote:
> On Tue, Jul 22, 2025 at 9:46 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > On Tue, Jul 22, 2025 at 03:17:15PM -0700, Mina Almasry wrote:
> > > On Sun, Jul 20, 2025 at 10:49 PM Byungchul Park <byungchul@sk.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I focused on converting the existing APIs accessing ->pp_magic field to
> > > > page type APIs.  However, yes.  Additional works would better be
> > > > considered on top like:
> > > >
> > > >    1. Adjust how to store and retrieve dma index.  Maybe network guys
> > > >       can work better on top.
> > > >
> > > >    2. Move the sanity check for page pool in mm/page_alloc.c to on free.
> > > >
> > > >    Byungchul
> > > >
> > > > ---8<---
> > > > From 7d207a1b3e9f4ff2a72f5b54b09e3ed0c4aaaca3 Mon Sep 17 00:00:00 2001
> > > > From: Byungchul Park <byungchul@sk.com>
> > > > Date: Mon, 21 Jul 2025 14:05:20 +0900
> > > > Subject: [PATCH] mm, page_pool: introduce a new page type for page pool in page type
> > > >
> > > > ->pp_magic field in struct page is current used to identify if a page
> > > > belongs to a page pool.  However, page type e.i. PGTY_netpp can be used
> > > > for that purpose.
> > > >
> > > > Use the page type APIs e.g. PageNetpp(), __SetPageNetpp(), and
> > > > __ClearPageNetpp() instead, and remove the existing APIs accessing
> > > > ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> > > > netmem_clear_pp_magic() since they are totally replaced.
> > > >
> > > > This work was inspired by the following link by Pavel:
> > > >
> > > > [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> > > >
> > > > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > ---
> > > >  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
> > > >  include/linux/mm.h                            | 28 ++-----------------
> > > >  include/linux/page-flags.h                    |  6 ++++
> > > >  include/net/netmem.h                          |  2 +-
> > > >  mm/page_alloc.c                               |  4 +--
> > > >  net/core/netmem_priv.h                        | 16 ++---------
> > > >  net/core/page_pool.c                          | 10 +++++--
> > > >  7 files changed, 24 insertions(+), 44 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > > > index 5d51600935a6..def274f5c1ca 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > > > @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
> > > >                                 xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
> > > >                                 page = xdpi.page.page;
> > > >
> > > > -                               /* No need to check page_pool_page_is_pp() as we
> > > > +                               /* No need to check PageNetpp() as we
> > > >                                  * know this is a page_pool page.
> > > >                                  */
> > > >                                 page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp,
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index ae50c1641bed..736061749535 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -4135,10 +4135,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > >   * DMA mapping IDs for page_pool
> > > >   *
> > > >   * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
> > > > - * stashes it in the upper bits of page->pp_magic. We always want to be able to
> > > > - * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
> > > > - * pages can have arbitrary kernel pointers stored in the same field as pp_magic
> > > > - * (since it overlaps with page->lru.next), so we must ensure that we cannot
> > > > + * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
> > > > + * arbitrary kernel pointers stored in the same field as pp_magic (since
> > > > + * it overlaps with page->lru.next), so we must ensure that we cannot
> > > >   * mistake a valid kernel pointer with any of the values we write into this
> > > >   * field.
> > > >   *
> > > > @@ -4168,25 +4167,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > >
> > > >  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
> > > >                                   PP_DMA_INDEX_SHIFT)
> > > > -
> > > > -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
> > > > - * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
> > > > - * the head page of compound page and bit 1 for pfmemalloc page, as well as the
> > > > - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> > > > - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> > > > - */
> > > > -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > > > -
> > > > -#ifdef CONFIG_PAGE_POOL
> > > > -static inline bool page_pool_page_is_pp(const struct page *page)
> > > > -{
> > > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > -}
> > > > -#else
> > > > -static inline bool page_pool_page_is_pp(const struct page *page)
> > > > -{
> > > > -       return false;
> > > > -}
> > > > -#endif
> > > > -
> > > >  #endif /* _LINUX_MM_H */
> > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > index 4fe5ee67535b..906ba7c9e372 100644
> > > > --- a/include/linux/page-flags.h
> > > > +++ b/include/linux/page-flags.h
> > > > @@ -957,6 +957,7 @@ enum pagetype {
> > > >         PGTY_zsmalloc           = 0xf6,
> > > >         PGTY_unaccepted         = 0xf7,
> > > >         PGTY_large_kmalloc      = 0xf8,
> > > > +       PGTY_netpp              = 0xf9,
> > > >
> > > >         PGTY_mapcount_underflow = 0xff
> > > >  };
> > > > @@ -1101,6 +1102,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
> > > >  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
> > > >  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
> > > >
> > > > +/*
> > > > + * Marks page_pool allocated pages.
> > > > + */
> > > > +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> > > > +
> > > >  /**
> > > >   * PageHuge - Determine if the page belongs to hugetlbfs
> > > >   * @page: The page to test.
> > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > index f7dacc9e75fd..3667334e16e7 100644
> > > > --- a/include/net/netmem.h
> > > > +++ b/include/net/netmem.h
> > > > @@ -298,7 +298,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > > >   */
> > > >  #define pp_page_to_nmdesc(p)                                           \
> > > >  ({                                                                     \
> > > > -       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));               \
> > > > +       DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));                          \
> > > >         __pp_page_to_nmdesc(p);                                         \
> > > >  })
> > > >
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 2ef3c07266b3..71c7666e48a9 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -898,7 +898,7 @@ static inline bool page_expected_state(struct page *page,
> > > >  #ifdef CONFIG_MEMCG
> > > >                         page->memcg_data |
> > > >  #endif
> > > > -                       page_pool_page_is_pp(page) |
> > > > +                       PageNetpp(page) |
> > > >                         (page->flags & check_flags)))
> > > >                 return false;
> > > >
> > > > @@ -925,7 +925,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> > > >         if (unlikely(page->memcg_data))
> > > >                 bad_reason = "page still charged to cgroup";
> > > >  #endif
> > > > -       if (unlikely(page_pool_page_is_pp(page)))
> > > > +       if (unlikely(PageNetpp(page)))
> > > >                 bad_reason = "page_pool leak";
> > > >         return bad_reason;
> > > >  }
> > > > diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> > > > index cd95394399b4..39a97703d9ed 100644
> > > > --- a/net/core/netmem_priv.h
> > > > +++ b/net/core/netmem_priv.h
> > > > @@ -8,21 +8,11 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
> > > >         return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
> > > >  }
> > > >
> > > > -static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
> > > > -{
> > > > -       __netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
> > > > -}
> > > > -
> > > > -static inline void netmem_clear_pp_magic(netmem_ref netmem)
> > > > -{
> > > > -       WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
> > > > -
> > > > -       __netmem_clear_lsb(netmem)->pp_magic = 0;
> > > > -}
> > > > -
> > > >  static inline bool netmem_is_pp(netmem_ref netmem)
> > > >  {
> > > > -       return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > +       if (netmem_is_net_iov(netmem))
> > > > +               return true;
> > >
> > > As Pavel alludes, this is dubious, and at least it's difficult to
> > > reason about it.
> > >
> > > There could be net_iovs that are not attached to pp, and should not be
> > > treated as pp memory. These are in the devmem (and future net_iov) tx
> > > paths.
> > >
> > > We need a way to tell if a net_iov is pp or not. A couple of options:
> > >
> > > 1. We could have it such that if net_iov->pp is set, then the
> > > netmem_is_pp == true, otherwise false.
> > > 2. We could implement a page-flags equivalent for net_iov.
> > >
> > > Option #1 is simpler and is my preferred. To do that properly, you need to:
> > >
> > > 1. Make sure everywhere net_iovs are allocated that pp=NULL in the
> > > non-pp case and pp=non NULL in the pp case. those callsites are
> > > net_devmem_bind_dmabuf (devmem rx & tx path), io_zcrx_create_area
> > > (io_uring rx path).
> > >
> > > 2. Change netmem_is_pp to check net_iov->pp in the net_iov case.
> >
> > Good idea, but I'm not sure if I could work on it without consuming your
> > additional review efforts.  Can anyone add net_iov_is_pp() helper?
> >
> 
> Things did indeed get busy for me with work work the past week and I
> still need to look at your merged netmem desc series, but I'm happy to
> review whenever I can.
> 
> > Or use the page type, Netpp, as an additional way to identify if it's a
> > pp page for system memory, keeping the current way using ->pp_magic.
> > So the page type, Netpp, is used for system memory, and ->pp_magic is
> > used for net_iov.  The clean up for ->pp_magic can be done if needed.
> >
> 
> IMO I would like to avoid deviations like this, especially since
> ->pp_magic is in the netmem_desc struct that is now shared between
> page and net_iov. I'd rather both use pp_magic or both not, but that
> may just be me.

Totally Agree.  Lemme try your option #1 then.

	Byungchul
> 
> 
> --
> Thanks,
> Mina


Return-Path: <bpf+bounces-64547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3CFB1416B
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 19:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655F14E0E9D
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939C27587E;
	Mon, 28 Jul 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZ+KRn4y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D87273D8C
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725073; cv=none; b=uKK1oeTHg7IzbBZQAQNnUqz7MLmZpCWa/NSLa6Ir7kO4sicpqxIShhNHhz8L2ooXSuJDJ+/Ciz0i+dPq+94hw9Ori4XhRXLJVwI5d2aY1JbV7NI1nl3rNTUGKA5uPIcnjslIBewqDJhheiKUcTV0IsHcrx6wzY4ldnfRVgAjf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725073; c=relaxed/simple;
	bh=vOmFchgkQyEQ+7SGTx8BojdlIqRNaIQQqGvyMI05+8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNaQAunR2r0X9Q827ujJBdwaRiCMXB8X7nfKUtmHP6hkr5rJ3c65deyXHEAsahuUyASlQt6IM6iEpTQPMgFgRhTI9+DJciOPOE32V3UwsgbEQCV9WNdoWfWqKH7b41px1NnhLQhq3JZckyWNhjFE9234GZuf2j0q/TqcbARIO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZ+KRn4y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-237f18108d2so20005ad.0
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725070; x=1754329870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBKeku6zVO55K67MLztQ2tt1Uyve6xAQKNrkkCjEuZI=;
        b=DZ+KRn4yri2ntC5ftorXZQdkJw0s497yIfCelXQ3V2ohVdtCdXILMCgMTXogXIs5yB
         B6cM4Gj7lnaqdLdHljd4HmgdR/M9wyh1V9BXeeKtrzTMm/jZy+3w+6JKuPzDPnsWFeyc
         R/+9v+fzlgyVqFDdhlKoJNu6tvGX+4V2yRXBGUYHQiVX9pFkdu8aVIrevV0yyZ3jKzZB
         Gg/glpNq1zqp/Q+SaTvD5QqixetZxktrR1GhRIM4agVH3FoJZJA+gxrtQXxdHfE/GyPm
         Sr1iTOleog4qXQnGuHiFv+i6/GbXFU1m0YSWJ8XCCZu0Tx4vadGi6BuViH6pS21zKJdo
         xPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725070; x=1754329870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBKeku6zVO55K67MLztQ2tt1Uyve6xAQKNrkkCjEuZI=;
        b=LH/j9Z/mkMzPyoiY4gKkLrqT4Ocnr/iMpMz/fwoJdGVMsh824p5aOssPkA7p6yGPdN
         fDT4IN4LNYUPyeteiXlykV0rgyxngG1OaM7BztosFF6nLqEjtoQb3Ox/76Go2Gnu6CoX
         Hs7ESyfJcFz4QSkuoGC0Q9J+1P7Zux11RIyKIMN81eaZbWzFNDqoLECngWmOkk/br4rx
         HQVxL/aNwBBU1iWrwPqNGRubSxNor9l66mLFgePBSJhhEq7T2Om+WfQ2Fhpz/pRt+U9Q
         hSsTHx/ltEXi1o3WFcaIDDMhYD7Lq3gYOcozJ6p1OHn5FM29evZOVOeQ2j7Gn88IPg7Z
         6iCA==
X-Forwarded-Encrypted: i=1; AJvYcCX41xV0/UbLaLFk2vrtAvQYAWS0gvD7nRDUcfqZ7MDazagux+4Izuun/oZmcPkiUDSevgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6BN0NgGJ4P2t7CsyZqI1AGHaawQ25BHL6chxjP+7aP3by8YU
	hd74rpN1KUg5OT/h+yLO0NePO+5YlOnPJ5JrGzwiyhLarRgmAncmvQzPEY6pVsfQQXC7f+/ayqy
	o/sM+9P3nEacPhyaGRH436MecljkgRpzavi/S6y4t
X-Gm-Gg: ASbGncsEd93h2EsZGQfoByBr32HKuGEw+S8VbyCwwraGwcGNgnoZXrRpz/B734zboek
	09uSuML0w+BzGOSIw37gwGN5gk4o098hJ8Jl5ZSgpIJo/AQeaE55zYtd4Sr39d53yKix5aOhfB/
	23g9dD/KT9APvdBRWwKM1oDZ3Pn/6FBQ0PvryCpvI45gZpnPCWB0qAeWYLyJB9hasGgqQBOciLV
	7d5FmKmCU7keywdz8iDPmlu7EK7GF0Z1glNUA==
X-Google-Smtp-Source: AGHT+IHcYeKC05850F4TTaw5KxBzxMXvA6FA4+SMB9VpNRlorOlyAj+f8QimcI7qy9S+bhrDnuKB9SXXwdjOVkm0pSM=
X-Received: by 2002:a17:903:94c:b0:240:58bd:11ba with SMTP id
 d9443c01a7336-24058cc56cemr1345875ad.23.1753725069763; Mon, 28 Jul 2025
 10:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728052742.81294-1-byungchul@sk.com> <20250728082008.34091-1-byungchul@sk.com>
In-Reply-To: <20250728082008.34091-1-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 28 Jul 2025 10:50:55 -0700
X-Gm-Features: Ac12FXxVdVrRJS8-nghy7iGoNOdvPeYRQkCbX14O9WycDp4E_Y6QBKwCNMt-Clw
Message-ID: <CAHS8izPTLSdN7uqPN7n97ovkdvc1vLc46EgyxDYSbAM6bdLUjg@mail.gmail.com>
Subject: Re: [PATCH v2 rebase as of Jul 28] mm, page_pool: introduce a new
 page type for page pool in page type
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org, 
	kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	baolin.wang@linux.alibaba.com, toke@redhat.com, asml.silence@gmail.com, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 1:20=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Rebasing on the latest linux-next/master is required.  Otherwise, a
> build fail is observed.  Sorry about the noise.
>
> Changes from v1:
>         1. Rebase on linux-next.
>         2. Initialize net_iov->pp =3D NULL when allocating net_iov in
>            net_devmem_bind_dmabuf() and io_zcrx_create_area().
>         3. Use ->pp for net_iov to identify if it's pp rather than
>            always consider net_iov as pp.
>         4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
>
> ---8<---
> From 26c9a731f388b788d6ea972c313bc8da8831412b Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Mon, 28 Jul 2025 17:09:20 +0900
> Subject: [PATCH v2 rebase as of Jul 28] mm, page_pool: introduce a new pa=
ge type for page pool in page type
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
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmai=
l.com/
>
> While at it, move the sanity check for page pool to on free.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
>  include/linux/mm.h                            | 27 +++----------------
>  include/linux/page-flags.h                    |  6 +++++
>  include/net/netmem.h                          |  2 +-
>  io_uring/zcrx.c                               |  1 +
>  mm/page_alloc.c                               |  7 +++--
>  net/core/devmem.c                             |  1 +
>  net/core/netmem_priv.h                        | 23 +++++++---------
>  net/core/page_pool.c                          | 10 +++++--
>  9 files changed, 34 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en/xdp.c
> index 5d51600935a6..def274f5c1ca 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq =
*sq,
>                                 xdpi =3D mlx5e_xdpi_fifo_pop(xdpi_fifo);
>                                 page =3D xdpi.page.page;
>
> -                               /* No need to check page_pool_page_is_pp(=
) as we
> +                               /* No need to check PageNetpp() as we
>                                  * know this is a page_pool page.
>                                  */
>                                 page_pool_recycle_direct(pp_page_to_nmdes=
c(page)->pp,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0d4ee569aa6b..d01b296e7184 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4171,10 +4171,9 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>   * DMA mapping IDs for page_pool
>   *
>   * When DMA-mapping a page, page_pool allocates an ID (from an xarray) a=
nd
> - * stashes it in the upper bits of page->pp_magic. We always want to be =
able to
> - * unambiguously identify page pool pages (using page_pool_page_is_pp())=
. Non-PP
> - * pages can have arbitrary kernel pointers stored in the same field as =
pp_magic
> - * (since it overlaps with page->lru.next), so we must ensure that we ca=
nnot
> + * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
> + * arbitrary kernel pointers stored in the same field as pp_magic (since
> + * it overlaps with page->lru.next), so we must ensure that we cannot
>   * mistake a valid kernel pointer with any of the values we write into t=
his
>   * field.
>   *
> @@ -4205,26 +4204,6 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT=
 - 1, \
>                                   PP_DMA_INDEX_SHIFT)
>
> -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magi=
c is
> - * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit=
 0 for
> - * the head page of compound page and bit 1 for pfmemalloc page, as well=
 as the
> - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> - */
> -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> -
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -       return false;
> -}
> -#endif
> -
>  #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
>  #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
>  #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 8d3fa3a91ce4..84247e39e9e7 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -933,6 +933,7 @@ enum pagetype {
>         PGTY_zsmalloc           =3D 0xf6,
>         PGTY_unaccepted         =3D 0xf7,
>         PGTY_large_kmalloc      =3D 0xf8,
> +       PGTY_netpp              =3D 0xf9,
>
>         PGTY_mapcount_underflow =3D 0xff
>  };
> @@ -1077,6 +1078,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
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
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index f7dacc9e75fd..3667334e16e7 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -298,7 +298,7 @@ static inline struct net_iov *__netmem_clear_lsb(netm=
em_ref netmem)
>   */
>  #define pp_page_to_nmdesc(p)                                           \
>  ({                                                                     \
> -       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));               \
> +       DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));                          \
>         __pp_page_to_nmdesc(p);                                         \
>  })
>
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index e5ff49f3425e..4cceb97ca26a 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -444,6 +444,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *if=
q,
>                 area->freelist[i] =3D i;
>                 atomic_set(&area->user_refs[i], 0);
>                 niov->type =3D NET_IOV_IOURING;
> +               niov->pp =3D NULL;
>         }
>
>         area->free_count =3D nr_iovs;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d1d037f97c5f..2f6a55fab942 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1042,7 +1042,6 @@ static inline bool page_expected_state(struct page =
*page,
>  #ifdef CONFIG_MEMCG
>                         page->memcg_data |
>  #endif
> -                       page_pool_page_is_pp(page) |
>                         (page->flags & check_flags)))
>                 return false;
>
> @@ -1069,8 +1068,6 @@ static const char *page_bad_reason(struct page *pag=
e, unsigned long flags)
>         if (unlikely(page->memcg_data))
>                 bad_reason =3D "page still charged to cgroup";
>  #endif
> -       if (unlikely(page_pool_page_is_pp(page)))
> -               bad_reason =3D "page_pool leak";
>         return bad_reason;
>  }
>
> @@ -1379,9 +1376,11 @@ __always_inline bool free_pages_prepare(struct pag=
e *page,
>                 mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>                 folio->mapping =3D NULL;
>         }
> -       if (unlikely(page_has_type(page)))
> +       if (unlikely(page_has_type(page))) {
> +               WARN_ON_ONCE(PageNetpp(page));
>                 /* Reset the page_type (which overlays _mapcount) */
>                 page->page_type =3D UINT_MAX;
> +       }
>
>         if (is_check_pages_enabled()) {
>                 if (free_page_is_bad(page))
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index b3a62ca0df65..40e7a4ec9009 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -285,6 +285,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                         niov =3D &owner->area.niovs[i];
>                         niov->type =3D NET_IOV_DMABUF;
>                         niov->owner =3D &owner->area;
> +                       niov->pp =3D NULL;
>                         page_pool_set_dma_addr_netmem(net_iov_to_netmem(n=
iov),
>                                                       net_devmem_get_dma_=
addr(niov));
>                         if (direction =3D=3D DMA_TO_DEVICE)
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index cd95394399b4..4b90332d6c64 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -8,21 +8,18 @@ static inline unsigned long netmem_get_pp_magic(netmem_=
ref netmem)
>         return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
>  }
>
> -static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long p=
p_magic)
> -{
> -       __netmem_clear_lsb(netmem)->pp_magic |=3D pp_magic;
> -}
> -
> -static inline void netmem_clear_pp_magic(netmem_ref netmem)
> -{
> -       WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_=
MASK);
> -
> -       __netmem_clear_lsb(netmem)->pp_magic =3D 0;
> -}
> -
>  static inline bool netmem_is_pp(netmem_ref netmem)
>  {
> -       return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) =3D=3D PP_SI=
GNATURE;
> +       /* Use ->pp for net_iov to identify if it's pp, which requires
> +        * that non-pp net_iov should have ->pp NULL'd.
> +        */
> +       if (netmem_is_net_iov(netmem))
> +               return !!__netmem_clear_lsb(netmem)->pp;
> +
> +       /* For system memory, page type bit in struct page can be used
> +        * to identify if it's pp.
> +        */
> +       return PageNetpp(__netmem_to_page(netmem));
>  }
>
>  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *po=
ol)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 05e2e22a8f7c..0a10f3026faa 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -654,7 +654,6 @@ s32 page_pool_inflight(const struct page_pool *pool, =
bool strict)
>  void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>  {
>         netmem_set_pp(netmem, pool);
> -       netmem_or_pp_magic(netmem, PP_SIGNATURE);
>
>         /* Ensuring all pages have been split into one fragment initially=
:
>          * page_pool_set_pp_info() is only called once for every page whe=
n it
> @@ -665,12 +664,19 @@ void page_pool_set_pp_info(struct page_pool *pool, =
netmem_ref netmem)
>         page_pool_fragment_netmem(netmem, 1);
>         if (pool->has_init_callback)
>                 pool->slow.init_callback(netmem, pool->slow.init_arg);
> +
> +       if (netmem_is_net_iov(netmem))
> +               return;
> +       __SetPageNetpp(__netmem_to_page(netmem));

nit:

if (!netmem_is_net_iov(netmem))
  __SetPageNetpp(__netmem_to_page(netmem));

i.e. no need for the early return. I would also move the diff to
replace netmem_or_pp_magic.

>  }
>
>  void page_pool_clear_pp_info(netmem_ref netmem)
>  {
> -       netmem_clear_pp_magic(netmem);
>         netmem_set_pp(netmem, NULL);
> +
> +       if (netmem_is_net_iov(netmem))
> +               return;
> +       __ClearPageNetpp(__netmem_to_page(netmem));

Same here. I would do:

if (!netmem_is_net_iov(netmem))
  __ClearPageNetpp(__netmem_to_page(netmem));

and no need for the early return.

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina


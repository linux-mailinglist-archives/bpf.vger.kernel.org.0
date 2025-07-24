Return-Path: <bpf+bounces-64302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEE5B11307
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 23:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B744AE37C9
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E6A2EE5F6;
	Thu, 24 Jul 2025 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZ5Qi4LG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E82EE263
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392201; cv=none; b=jobVgqhJZ4u3TA4Gph16rXTuJll2M4boHTfvDUM2GwfmAIWI8mwhE4NQK85F4qoZtk/geFDp053Ee+iTLPY+whFRKaQp+CF8CPo7OjAb3ekcQ5kx/jDWOL5uxxxukrjKYzMPUa3VA+bUuuUnlIAfZTpXXFH9xA3mKR0jXsouunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392201; c=relaxed/simple;
	bh=AWa3QljlTQI2w6CzFs/GJMnKM1od+dLR+KMOmwq2NRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEmizUu915HNO8th4w4LqdiKNKM9eFZWmnJsfwZZPGYYp+7JELY32Xi4hn2gW2jZbdy3Qcb1pr96C1Jv1eD6xZJbuqB2k74tN5KK7QZHsCphXKdHgBPSfssJvaKbBzWrbzcFWi+qp49aMIq/p/MFsarBWvbH7bmWHAn+H5mv/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZ5Qi4LG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23dd9ae5aacso26255ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753392199; x=1753996999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNnTJ5darf1pQDB2vsYeV7FJpreNa9uOT82oPg1Gxp8=;
        b=jZ5Qi4LG9byWLV2CFlBI6eNDIxXIsnTNhRI/EvwTF56DPpWAT5cLUQooVsFfJG+NjX
         AU31WoPK2QdXqz/QcjdAU6WFnzSLCs2yzmzxvNEEgu9Ug4MigGnJVpQ/lqPNehQnmQ6a
         XCvRJ+M33c4fpO9p6CwJ0lLP83gQd26UtGNCBFzSzrT5G2Dkn5iE+5WB8ae/iOjFdSBS
         jL4aEjekadOsZSumx9HbPlePhuPt9AbAVqZyIbl6RjNZmPgAwyatykA/lRWwyAkAcm/M
         NvWtElxtpZ2p164pQFy36ym7oj1/yGG0owJRf0v+nml2HAopav+vJjUkNzzGq0iUriLI
         /BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753392199; x=1753996999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNnTJ5darf1pQDB2vsYeV7FJpreNa9uOT82oPg1Gxp8=;
        b=Vv00x4kLLL6p4Sp9ptIsnFlJsc421pmbuNznN3RGYWdjQEuma0Wp+BT5mP/jV3YOrB
         3CtSzPyBYvktzr4plqn0jZBcbTGkGeAT7VPlKfms72MRUtZKXbM/QUntY1WrME/UPVz4
         x3NLo+4qJLt1vjCRMWZ+gwFkBUyizy87+3X/RVLgG23wogv5BB3Oks41l+jnLYQM5IzK
         WMhKRWKJxkAxdEXH4ZcC3l+rHrto3pHFd612lMjx4topAWcCrYSv5vAcIUlnPTHZ0upG
         WyFryN92wqoSpoSMh3E9QJHackyZAW466J4WCo/tj7sVB0PbE+wju5EhC/ck+2YMhe/V
         Oojg==
X-Forwarded-Encrypted: i=1; AJvYcCW4eUDtyonAouslEN7I8HF1a9ngBhsqY2tWmyvyKnsrpRpoYzqWF4OK78mom4HYRrX0GxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbARHuBDSt8EyyZjVYxUMCTdOwZTcUfOlAkUnYpBLTGgQpj/Ke
	47gqE8DAD1vWacXpmElN6TcOcAS7kjVdVll1xCcokArtj9Ig0Y4EMR13THZmg6nFTUBwSgKwWXN
	OS3XiCTCjmefbMGAmrgKNn+5UvcMODNfD/NFtkai6
X-Gm-Gg: ASbGncs749MM61+LSNxyr5Nz2pfrbZT0eibLCcvUwTrG9pCrJZP7XiqQRBieCLLMqaI
	cpIT7anc70dFq/a8wdDnyUsd028J2ggThqn3c4MXylm+++awTR3TjsRCKRhOERyH+1LWvMmgser
	G13ISvPA6rRBNF8D9WL0phfc2DT5BeYnGJaSlN7rP8Edmg/PMtWCYxoPFq3h6tMub2RA5Uul3n2
	M9fm87Ku8QYD0rRHA2PowXERYqU9ZsI+unWWn9VEmq7TtyT
X-Google-Smtp-Source: AGHT+IHP4CcY56s6tdK30PaY3+VQezaoZk4lvk+rDg73ia56t/qWWvkH19hG/XzNRK1ErwjJSSAFdSL4fYDkuZlCRh0=
X-Received: by 2002:a17:903:32ce:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-23fada5b364mr924205ad.8.1753392198670; Thu, 24 Jul 2025
 14:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721054903.39833-1-byungchul@sk.com> <CAHS8izM11fxu6jHZw5VJsHXeZ+Tk+6ZBGDk0vHiOoHyXZoOvOg@mail.gmail.com>
 <20250723044610.GA80428@system.software.com>
In-Reply-To: <20250723044610.GA80428@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Jul 2025 14:23:05 -0700
X-Gm-Features: Ac12FXz-gExQLTDVuATyXHwkSGv0B-njaHRD7KrjKadlfvJJk-4Hay1UO-wB7MU
Message-ID: <CAHS8izMO0LO1uKu0peSAC8Sixes06KLfKJvyQnAOiLfDqZd5+Q@mail.gmail.com>
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool in
 page type
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

On Tue, Jul 22, 2025 at 9:46=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Tue, Jul 22, 2025 at 03:17:15PM -0700, Mina Almasry wrote:
> > On Sun, Jul 20, 2025 at 10:49=E2=80=AFPM Byungchul Park <byungchul@sk.c=
om> wrote:
> > >
> > > Hi,
> > >
> > > I focused on converting the existing APIs accessing ->pp_magic field =
to
> > > page type APIs.  However, yes.  Additional works would better be
> > > considered on top like:
> > >
> > >    1. Adjust how to store and retrieve dma index.  Maybe network guys
> > >       can work better on top.
> > >
> > >    2. Move the sanity check for page pool in mm/page_alloc.c to on fr=
ee.
> > >
> > >    Byungchul
> > >
> > > ---8<---
> > > From 7d207a1b3e9f4ff2a72f5b54b09e3ed0c4aaaca3 Mon Sep 17 00:00:00 200=
1
> > > From: Byungchul Park <byungchul@sk.com>
> > > Date: Mon, 21 Jul 2025 14:05:20 +0900
> > > Subject: [PATCH] mm, page_pool: introduce a new page type for page po=
ol in page type
> > >
> > > ->pp_magic field in struct page is current used to identify if a page
> > > belongs to a page pool.  However, page type e.i. PGTY_netpp can be us=
ed
> > > for that purpose.
> > >
> > > Use the page type APIs e.g. PageNetpp(), __SetPageNetpp(), and
> > > __ClearPageNetpp() instead, and remove the existing APIs accessing
> > > ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> > > netmem_clear_pp_magic() since they are totally replaced.
> > >
> > > This work was inspired by the following link by Pavel:
> > >
> > > [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@=
gmail.com/
> > >
> > > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
> > >  include/linux/mm.h                            | 28 ++---------------=
--
> > >  include/linux/page-flags.h                    |  6 ++++
> > >  include/net/netmem.h                          |  2 +-
> > >  mm/page_alloc.c                               |  4 +--
> > >  net/core/netmem_priv.h                        | 16 ++---------
> > >  net/core/page_pool.c                          | 10 +++++--
> > >  7 files changed, 24 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drive=
rs/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > > index 5d51600935a6..def274f5c1ca 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > > @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xd=
psq *sq,
> > >                                 xdpi =3D mlx5e_xdpi_fifo_pop(xdpi_fif=
o);
> > >                                 page =3D xdpi.page.page;
> > >
> > > -                               /* No need to check page_pool_page_is=
_pp() as we
> > > +                               /* No need to check PageNetpp() as we
> > >                                  * know this is a page_pool page.
> > >                                  */
> > >                                 page_pool_recycle_direct(pp_page_to_n=
mdesc(page)->pp,
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index ae50c1641bed..736061749535 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -4135,10 +4135,9 @@ int arch_lock_shadow_stack_status(struct task_=
struct *t, unsigned long status);
> > >   * DMA mapping IDs for page_pool
> > >   *
> > >   * When DMA-mapping a page, page_pool allocates an ID (from an xarra=
y) and
> > > - * stashes it in the upper bits of page->pp_magic. We always want to=
 be able to
> > > - * unambiguously identify page pool pages (using page_pool_page_is_p=
p()). Non-PP
> > > - * pages can have arbitrary kernel pointers stored in the same field=
 as pp_magic
> > > - * (since it overlaps with page->lru.next), so we must ensure that w=
e cannot
> > > + * stashes it in the upper bits of page->pp_magic. Non-PP pages can =
have
> > > + * arbitrary kernel pointers stored in the same field as pp_magic (s=
ince
> > > + * it overlaps with page->lru.next), so we must ensure that we canno=
t
> > >   * mistake a valid kernel pointer with any of the values we write in=
to this
> > >   * field.
> > >   *
> > > @@ -4168,25 +4167,4 @@ int arch_lock_shadow_stack_status(struct task_=
struct *t, unsigned long status);
> > >
> > >  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_S=
HIFT - 1, \
> > >                                   PP_DMA_INDEX_SHIFT)
> > > -
> > > -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_=
magic is
> > > - * OR'ed with PP_SIGNATURE after the allocation in order to preserve=
 bit 0 for
> > > - * the head page of compound page and bit 1 for pfmemalloc page, as =
well as the
> > > - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> > > - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> > > - */
> > > -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > > -
> > > -#ifdef CONFIG_PAGE_POOL
> > > -static inline bool page_pool_page_is_pp(const struct page *page)
> > > -{
> > > -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> > > -}
> > > -#else
> > > -static inline bool page_pool_page_is_pp(const struct page *page)
> > > -{
> > > -       return false;
> > > -}
> > > -#endif
> > > -
> > >  #endif /* _LINUX_MM_H */
> > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > index 4fe5ee67535b..906ba7c9e372 100644
> > > --- a/include/linux/page-flags.h
> > > +++ b/include/linux/page-flags.h
> > > @@ -957,6 +957,7 @@ enum pagetype {
> > >         PGTY_zsmalloc           =3D 0xf6,
> > >         PGTY_unaccepted         =3D 0xf7,
> > >         PGTY_large_kmalloc      =3D 0xf8,
> > > +       PGTY_netpp              =3D 0xf9,
> > >
> > >         PGTY_mapcount_underflow =3D 0xff
> > >  };
> > > @@ -1101,6 +1102,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
> > >  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
> > >  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
> > >
> > > +/*
> > > + * Marks page_pool allocated pages.
> > > + */
> > > +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> > > +
> > >  /**
> > >   * PageHuge - Determine if the page belongs to hugetlbfs
> > >   * @page: The page to test.
> > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > index f7dacc9e75fd..3667334e16e7 100644
> > > --- a/include/net/netmem.h
> > > +++ b/include/net/netmem.h
> > > @@ -298,7 +298,7 @@ static inline struct net_iov *__netmem_clear_lsb(=
netmem_ref netmem)
> > >   */
> > >  #define pp_page_to_nmdesc(p)                                        =
   \
> > >  ({                                                                  =
   \
> > > -       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));            =
   \
> > > +       DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));                       =
   \
> > >         __pp_page_to_nmdesc(p);                                      =
   \
> > >  })
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 2ef3c07266b3..71c7666e48a9 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -898,7 +898,7 @@ static inline bool page_expected_state(struct pag=
e *page,
> > >  #ifdef CONFIG_MEMCG
> > >                         page->memcg_data |
> > >  #endif
> > > -                       page_pool_page_is_pp(page) |
> > > +                       PageNetpp(page) |
> > >                         (page->flags & check_flags)))
> > >                 return false;
> > >
> > > @@ -925,7 +925,7 @@ static const char *page_bad_reason(struct page *p=
age, unsigned long flags)
> > >         if (unlikely(page->memcg_data))
> > >                 bad_reason =3D "page still charged to cgroup";
> > >  #endif
> > > -       if (unlikely(page_pool_page_is_pp(page)))
> > > +       if (unlikely(PageNetpp(page)))
> > >                 bad_reason =3D "page_pool leak";
> > >         return bad_reason;
> > >  }
> > > diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> > > index cd95394399b4..39a97703d9ed 100644
> > > --- a/net/core/netmem_priv.h
> > > +++ b/net/core/netmem_priv.h
> > > @@ -8,21 +8,11 @@ static inline unsigned long netmem_get_pp_magic(net=
mem_ref netmem)
> > >         return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_M=
ASK;
> > >  }
> > >
> > > -static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned lo=
ng pp_magic)
> > > -{
> > > -       __netmem_clear_lsb(netmem)->pp_magic |=3D pp_magic;
> > > -}
> > > -
> > > -static inline void netmem_clear_pp_magic(netmem_ref netmem)
> > > -{
> > > -       WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_IN=
DEX_MASK);
> > > -
> > > -       __netmem_clear_lsb(netmem)->pp_magic =3D 0;
> > > -}
> > > -
> > >  static inline bool netmem_is_pp(netmem_ref netmem)
> > >  {
> > > -       return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) =3D=3D P=
P_SIGNATURE;
> > > +       if (netmem_is_net_iov(netmem))
> > > +               return true;
> >
> > As Pavel alludes, this is dubious, and at least it's difficult to
> > reason about it.
> >
> > There could be net_iovs that are not attached to pp, and should not be
> > treated as pp memory. These are in the devmem (and future net_iov) tx
> > paths.
> >
> > We need a way to tell if a net_iov is pp or not. A couple of options:
> >
> > 1. We could have it such that if net_iov->pp is set, then the
> > netmem_is_pp =3D=3D true, otherwise false.
> > 2. We could implement a page-flags equivalent for net_iov.
> >
> > Option #1 is simpler and is my preferred. To do that properly, you need=
 to:
> >
> > 1. Make sure everywhere net_iovs are allocated that pp=3DNULL in the
> > non-pp case and pp=3Dnon NULL in the pp case. those callsites are
> > net_devmem_bind_dmabuf (devmem rx & tx path), io_zcrx_create_area
> > (io_uring rx path).
> >
> > 2. Change netmem_is_pp to check net_iov->pp in the net_iov case.
>
> Good idea, but I'm not sure if I could work on it without consuming your
> additional review efforts.  Can anyone add net_iov_is_pp() helper?
>

Things did indeed get busy for me with work work the past week and I
still need to look at your merged netmem desc series, but I'm happy to
review whenever I can.

> Or use the page type, Netpp, as an additional way to identify if it's a
> pp page for system memory, keeping the current way using ->pp_magic.
> So the page type, Netpp, is used for system memory, and ->pp_magic is
> used for net_iov.  The clean up for ->pp_magic can be done if needed.
>

IMO I would like to avoid deviations like this, especially since
->pp_magic is in the netmem_desc struct that is now shared between
page and net_iov. I'd rather both use pp_magic or both not, but that
may just be me.


--=20
Thanks,
Mina


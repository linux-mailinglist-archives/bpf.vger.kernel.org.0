Return-Path: <bpf+bounces-47192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1649F5DF7
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 05:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92ACB18888C6
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836DA15250F;
	Wed, 18 Dec 2024 04:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EktDwS8u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B135974
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734497963; cv=none; b=WVWS+gdyoXFNrdglu+DFHBbLz5mHrnr4fCD824nJIqk7M4l8H2GN5SR98kxS3y6hUQy+MgleUG5trWPf80Q+g/mR1D75i8SS35SsaTuo53rgxH7JVoh7jDUUplMIGLdVNLj5dc4XXt+cl+u0MuqHI4cDC2roLfOmZcJ7O87YLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734497963; c=relaxed/simple;
	bh=PuF702OMKBO3vBs6+Ps2RuKOd/mxzfHnb1UDPh4Kivk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lxd6Yq2E1LncGDIQ1cgzXzprmya9hY/KSvORS+sOKar2gcj/DEuCiZTiPt90IsIqbUur4y/f/0lvYzixPeZwg/u2dWt7IIu+UlbrsOCl9x85Ctpm9D/LYb0q9j55tWa5XuceoQr6r7Buiq+QtxB6mANgq7p7xKJTBOWuTZB9Kzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EktDwS8u; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d91653e9d7so56878496d6.1
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 20:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734497960; x=1735102760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tM9aAIzem3SfKVAWA4VaTEk++v35HrnlAHqCNLRzXMk=;
        b=EktDwS8uDztJkFsEXKvzgMh14tstbJR2klu7aynKQwLfPr3+IeX8mTIYqOq3PJz64v
         XrP4KHfba48m0KboVhamHQcH0Gp3y19oNpeo8XpriuGrWcWCzvllAKUBBk7Yl/1ALYqX
         MpfMUuNr90fANR+kQxyQgfe19DiSqIdGq23W1/CJfavTJr5fH6p9NupLtL2Yzfs0RWUF
         tRW8L+iL4gWEiR6469JdAYp8RJTITncmEbup3rDdBh9Rhj/nzQ31vzcLLE9sTJfsh3zR
         Xa1O22ssegZlz8IanhO1UevkBUczkQqhetvFmRPgm/WeiF2eXEe0wTmg5wZTccNqu43h
         OwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734497960; x=1735102760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tM9aAIzem3SfKVAWA4VaTEk++v35HrnlAHqCNLRzXMk=;
        b=M4Xwh1H2ZOoaq1Ytp+1mwTEmjfng/oAkeEYac3ZhAFtqlsMpPTxA4/CaeCwJbPEH2k
         jeVikVhXiEMkq4Aw26QjvFTynMHEDTelOuUg3imSzmENYh0sjkxWHi1kvRhx3MPcSOaR
         hLLYAEtR1SmOOTYhoqzHLVGJ9dY6r0K73xugl90Io4f13xjZErOAIzjkI+v3JM3fZnmL
         1RvPuYjfGEqMzkuF46ojk1MvwjEIIWLIGj/dG/TdmI6Z2OMVVwFsrK6CzHyBuuvLLUYP
         tbfa7EQ4rKZZoJTWrDgy0dcotaUVEjFR3S5nszdUhWsMOzfzcj1k/qxTOyQJDi3Tn7O8
         CcCA==
X-Gm-Message-State: AOJu0YwRB+rGR7Ya3qURsqWSZBEcZKvtzIBRKfIAqI8CU1vlKI9SG6Dc
	5R9psRa/16ohSHwK5tBksW7s+JQvJTS2vn/z0S+lybZ5XCjiszOF6IVb+1JZau0y0ZBOktr+dv8
	0DJ/j7SHSQfA3edHhiMUcObNMXw4a3M1Km30O
X-Gm-Gg: ASbGncsC1xF1FnZPg+0rx/SlhvJcVbEHSHlP8pktQhlKeQxez5+xwyEgsmqIjw3F4yF
	9hlUGDgYVHwYKfSYcw1q4JHCPMMyw2nAoIW8=
X-Google-Smtp-Source: AGHT+IGGee0Jhlf7uun5NkaJLNERwoodBYYu5MEU02cNCdKeTSuAt+mlVLQw7SdIS8zsgM1D1cZNHs3S5Qbc20myLIs=
X-Received: by 2002:ad4:4eac:0:b0:6dc:d29a:b18e with SMTP id
 6a1803df08f44-6dd0925cc7amr31279036d6.47.1734497959872; Tue, 17 Dec 2024
 20:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com> <20241218030720.1602449-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20241218030720.1602449-3-alexei.starovoitov@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 17 Dec 2024 20:58:43 -0800
X-Gm-Features: AbW1kvYrgEsUSkvjR1lm0Dsfqg2WP9ABQhR90_xAulHmJGik8KXpYq8q3U9F9-0
Message-ID: <CAJD7tkYOfBepXDeUFj6mM1evRoDdaS_THwmhp9a4pHeM4bgsFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, 
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@suse.com, 
	willy@infradead.org, tglx@linutronix.de, jannh@google.com, tj@kernel.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 7:07=E2=80=AFPM <alexei.starovoitov@gmail.com> wrot=
e:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce free_pages_nolock() that can free pages without taking locks.
> It relies on trylock and can be called from any context.
> Since spin_trylock() cannot be used in RT from hard IRQ or NMI
> it uses lockless link list to stash the pages which will be freed
> by subsequent free_pages() from good context.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/gfp.h      |  1 +
>  include/linux/mm_types.h |  4 ++
>  include/linux/mmzone.h   |  3 ++
>  mm/page_alloc.c          | 79 ++++++++++++++++++++++++++++++++++++----
>  4 files changed, 79 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 65b8df1db26a..ff9060af6295 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -372,6 +372,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid,=
 size_t size, gfp_t gfp_mas
>         __get_free_pages((gfp_mask) | GFP_DMA, (order))
>
>  extern void __free_pages(struct page *page, unsigned int order);
> +extern void free_pages_nolock(struct page *page, unsigned int order);
>  extern void free_pages(unsigned long addr, unsigned int order);
>
>  #define __free_page(page) __free_pages((page), 0)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7361a8f3ab68..52547b3e5fd8 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -99,6 +99,10 @@ struct page {
>                                 /* Or, free page */
>                                 struct list_head buddy_list;
>                                 struct list_head pcp_list;
> +                               struct {
> +                                       struct llist_node pcp_llist;
> +                                       unsigned int order;
> +                               };
>                         };
>                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
>                         struct address_space *mapping;
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b36124145a16..1a854e0a9e3b 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -953,6 +953,9 @@ struct zone {
>         /* Primarily protects free_area */
>         spinlock_t              lock;
>
> +       /* Pages to be freed when next trylock succeeds */
> +       struct llist_head       trylock_free_pages;
> +
>         /* Write-intensive fields used by compaction and vmstats. */
>         CACHELINE_PADDING(_pad2_);
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d23545057b6e..10918bfc6734 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -88,6 +88,9 @@ typedef int __bitwise fpi_t;
>   */
>  #define FPI_TO_TAIL            ((__force fpi_t)BIT(1))
>
> +/* Free the page without taking locks. Rely on trylock only. */
> +#define FPI_TRYLOCK            ((__force fpi_t)BIT(2))
> +

The comment above the definition of fpi_t mentions that it's for
non-pcp variants of free_pages(), so I guess that needs to be updated
in this patch.

More importantly, I think the comment states this mainly because the
existing flags won't be properly handled when freeing pages to the
pcplist. The flags will be lost once the pages are added to the
pcplist, and won't be propagated when the pages are eventually freed
to the buddy allocator (e.g. through free_pcppages_bulk()).

So I think we need to at least explicitly check which flags are
allowed when freeing pages to the pcplists or something similar.

>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields=
 */
>  static DEFINE_MUTEX(pcp_batch_high_lock);
>  #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
> @@ -1247,13 +1250,44 @@ static void split_large_buddy(struct zone *zone, =
struct page *page,
>         }
>  }
>
> +static void add_page_to_zone_llist(struct zone *zone, struct page *page,
> +                                  unsigned int order)
> +{
> +       /* Remember the order */
> +       page->order =3D order;
> +       /* Add the page to the free list */
> +       llist_add(&page->pcp_llist, &zone->trylock_free_pages);
> +}
> +
>  static void free_one_page(struct zone *zone, struct page *page,
>                           unsigned long pfn, unsigned int order,
>                           fpi_t fpi_flags)
>  {
> +       struct llist_head *llhead;
>         unsigned long flags;
>
> -       spin_lock_irqsave(&zone->lock, flags);
> +       if (!spin_trylock_irqsave(&zone->lock, flags)) {
> +               if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> +                       add_page_to_zone_llist(zone, page, order);
> +                       return;
> +               }
> +               spin_lock_irqsave(&zone->lock, flags);
> +       }
> +
> +       /* The lock succeeded. Process deferred pages. */
> +       llhead =3D &zone->trylock_free_pages;
> +       if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_TRYLOCK)))=
 {
> +               struct llist_node *llnode;
> +               struct page *p, *tmp;
> +
> +               llnode =3D llist_del_all(llhead);
> +               llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
> +                       unsigned int p_order =3D p->order;
> +
> +                       split_large_buddy(zone, p, page_to_pfn(p), p_orde=
r, fpi_flags);
> +                       __count_vm_events(PGFREE, 1 << p_order);
> +               }
> +       }
>         split_large_buddy(zone, page, pfn, order, fpi_flags);
>         spin_unlock_irqrestore(&zone->lock, flags);
>
> @@ -2596,7 +2630,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, s=
truct zone *zone,
>
>  static void free_unref_page_commit(struct zone *zone, struct per_cpu_pag=
es *pcp,
>                                    struct page *page, int migratetype,
> -                                  unsigned int order)
> +                                  unsigned int order, fpi_t fpi_flags)
>  {
>         int high, batch;
>         int pindex;
> @@ -2631,6 +2665,14 @@ static void free_unref_page_commit(struct zone *zo=
ne, struct per_cpu_pages *pcp,
>         }
>         if (pcp->free_count < (batch << CONFIG_PCP_BATCH_SCALE_MAX))
>                 pcp->free_count +=3D (1 << order);
> +
> +       if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> +               /*
> +                * Do not attempt to take a zone lock. Let pcp->count get
> +                * over high mark temporarily.
> +                */
> +               return;
> +       }
>         high =3D nr_pcp_high(pcp, zone, batch, free_high);
>         if (pcp->count >=3D high) {
>                 free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, fr=
ee_high),
> @@ -2645,7 +2687,8 @@ static void free_unref_page_commit(struct zone *zon=
e, struct per_cpu_pages *pcp,
>  /*
>   * Free a pcp page
>   */
> -void free_unref_page(struct page *page, unsigned int order)
> +static void __free_unref_page(struct page *page, unsigned int order,
> +                             fpi_t fpi_flags)
>  {
>         unsigned long __maybe_unused UP_flags;
>         struct per_cpu_pages *pcp;
> @@ -2654,7 +2697,7 @@ void free_unref_page(struct page *page, unsigned in=
t order)
>         int migratetype;
>
>         if (!pcp_allowed_order(order)) {
> -               __free_pages_ok(page, order, FPI_NONE);
> +               __free_pages_ok(page, order, fpi_flags);
>                 return;
>         }
>
> @@ -2671,24 +2714,33 @@ void free_unref_page(struct page *page, unsigned =
int order)
>         migratetype =3D get_pfnblock_migratetype(page, pfn);
>         if (unlikely(migratetype >=3D MIGRATE_PCPTYPES)) {
>                 if (unlikely(is_migrate_isolate(migratetype))) {
> -                       free_one_page(page_zone(page), page, pfn, order, =
FPI_NONE);
> +                       free_one_page(page_zone(page), page, pfn, order, =
fpi_flags);
>                         return;
>                 }
>                 migratetype =3D MIGRATE_MOVABLE;
>         }
>
>         zone =3D page_zone(page);
> +       if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq())) =
{
> +               add_page_to_zone_llist(zone, page, order);
> +               return;
> +       }
>         pcp_trylock_prepare(UP_flags);
>         pcp =3D pcp_spin_trylock(zone->per_cpu_pageset);
>         if (pcp) {
> -               free_unref_page_commit(zone, pcp, page, migratetype, orde=
r);
> +               free_unref_page_commit(zone, pcp, page, migratetype, orde=
r, fpi_flags);
>                 pcp_spin_unlock(pcp);
>         } else {
> -               free_one_page(zone, page, pfn, order, FPI_NONE);
> +               free_one_page(zone, page, pfn, order, fpi_flags);
>         }
>         pcp_trylock_finish(UP_flags);
>  }
>
> +void free_unref_page(struct page *page, unsigned int order)
> +{
> +       __free_unref_page(page, order, FPI_NONE);
> +}
> +
>  /*
>   * Free a batch of folios
>   */
> @@ -2777,7 +2829,7 @@ void free_unref_folios(struct folio_batch *folios)
>
>                 trace_mm_page_free_batched(&folio->page);
>                 free_unref_page_commit(zone, pcp, &folio->page, migratety=
pe,
> -                               order);
> +                                      order, FPI_NONE);
>         }
>
>         if (pcp) {
> @@ -4854,6 +4906,17 @@ void __free_pages(struct page *page, unsigned int =
order)
>  }
>  EXPORT_SYMBOL(__free_pages);
>
> +/*
> + * Can be called while holding raw_spin_lock or from IRQ and NMI,
> + * but only for pages that came from try_alloc_pages():
> + * order <=3D 3, !folio, etc
> + */
> +void free_pages_nolock(struct page *page, unsigned int order)
> +{
> +       if (put_page_testzero(page))
> +               __free_unref_page(page, order, FPI_TRYLOCK);
> +}
> +
>  void free_pages(unsigned long addr, unsigned int order)
>  {
>         if (addr !=3D 0) {
> --
> 2.43.5
>
>


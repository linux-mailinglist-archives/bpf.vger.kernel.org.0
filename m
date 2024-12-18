Return-Path: <bpf+bounces-47194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327459F5E4E
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 06:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A679D7A364E
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 05:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8514AD3A;
	Wed, 18 Dec 2024 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vx+wv7mX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5E135956
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734500003; cv=none; b=MwrXnooEFbfudDc26BIOrIvhmNdudsVYDW/af1/I+bc1tGphGcl/dzn4mDnJQwX3t5CuIATf2cCK1Ri6q8HV72o1UrzsaxEJFojHywOsB/GWs8qjoevqDNqCs3LuZOj8DSKXRrAkm0Ow0Dp4cZ7ECVQsJhsBZCkS1wwEtCkWfps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734500003; c=relaxed/simple;
	bh=Bdo6Rr8LT5IQqWFmfYK0S0PGliPhL4YGzMr0R9PWiU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7zJrcSC2J6w177G9IMT+FfnDoAl3ajys1722a0f0Fw2H6MIbsKuWXdsJyXgpXmEwDc9fpzCscI+sUyycIYD/gxHYTfgl5uQJJWgdiknRYY1t6g4rd9HYTO9KkZlBCqsQJx6TomsEd2iFnVnAw3UWjzDiSq+cu/bkjjd1HFIK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vx+wv7mX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43635796b48so2195165e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 21:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734500000; x=1735104800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvHy4KOpgBZf/IJf46ySixTP0NFggSNEF5TfM2rS5wY=;
        b=Vx+wv7mXZkx9skkY1mOZuei2E9niBPnYB/3Yyr8bIAvSXvhnrZ93NyrwPd4Wm/0tpL
         ZJ9YE8kxjFcuAHnmuw3h+29+R7WkmBvr0UftZBR2/TeRXQq5QyjxjDNCLBWMLD4XNK4k
         BPHS3+0HsVeG41MahWYl/7cDQV8WvNaop+jWL8uNcnwV49SkFUtJhsQ/NQPWFKb0NZDV
         EhO80kKqq9s538rlLD+uoADbHngbT9BxEvv+Zf9owG2hia6hHi4xLt64Sp49A4G8EKSK
         162qDSouh7+E4IKaiU3ef9xvbjLgZLRgrRNFPiAGHwbTGwfazrm+Sg2BJpqRJeEwFV2d
         kmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734500000; x=1735104800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvHy4KOpgBZf/IJf46ySixTP0NFggSNEF5TfM2rS5wY=;
        b=c3LgO/l+oOS5HpPYRRuhK71Yhd4cNvZwPgC/ffjAIDxqAUu/+qkFjDTuJy/DcZX2nv
         07ZTi2tvFTdvYNkqKUQm2K5Q2dcBUZzGQwOR8ySeiLZVv2br192mKElg+nmWGIaLd90w
         IBKNZp8QcKblOAlKCmAn90Q/9p219pZE1Fofhng52CZI5Nw4Z52A2qvuR7xTnd6g2UhL
         xU9fglukUlZQuL5sPqquLfCe1rkRIQYLvDFTqF9HzpDL4rxs36lC/9512dGSWlA1Juoi
         X05sEIUd94adj2HzEDy+nKGhK05k2jy873n8sc+KaS5Tdy0W/CV1HGqqRtGobUKr+jPM
         I6sQ==
X-Gm-Message-State: AOJu0YzhDKFydr88u47HLiUCL/ljeiFCBMsJZIszND1Om4A3MxLFkl0G
	TUq4JMRsCxtrOnIFh53eh3W0PmZc/Vax/ATNeKQGZa9zbTdaUCJB6+VwYBcorKTvB6wXbqe4a9R
	5pMLX0kvoIeQbdFcY8KN8Y02rFBM=
X-Gm-Gg: ASbGncsOv7/e3yJrGJX73vxe9gGN96QcM2ctCcGFADsJrwBxgse33kgmC2TBAO1G1EM
	1Mj7jHtDRBDhVlpzXahA5hH5GEjlWB7lo27UffzzUZuhrv74oKhqOJQ==
X-Google-Smtp-Source: AGHT+IFW2gOk9eqtLmZgNmnjhSTCmOtziWxFq5eH20ukbKr+4HxiISRwwVya156Yu3IE0InO1ES5H9am6yo1yrUdlWM=
X-Received: by 2002:a05:600c:1909:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-4365537668dmr9420465e9.10.1734499999773; Tue, 17 Dec 2024
 21:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-3-alexei.starovoitov@gmail.com> <CAJD7tkYOfBepXDeUFj6mM1evRoDdaS_THwmhp9a4pHeM4bgsFA@mail.gmail.com>
In-Reply-To: <CAJD7tkYOfBepXDeUFj6mM1evRoDdaS_THwmhp9a4pHeM4bgsFA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Dec 2024 21:33:08 -0800
Message-ID: <CAADnVQKmMaybRQJDyC9sbtmxod6S8kgcrk4FerWt9ve0vR9U1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 8:59=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Dec 17, 2024 at 7:07=E2=80=AFPM <alexei.starovoitov@gmail.com> wr=
ote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce free_pages_nolock() that can free pages without taking locks.
> > It relies on trylock and can be called from any context.
> > Since spin_trylock() cannot be used in RT from hard IRQ or NMI
> > it uses lockless link list to stash the pages which will be freed
> > by subsequent free_pages() from good context.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/gfp.h      |  1 +
> >  include/linux/mm_types.h |  4 ++
> >  include/linux/mmzone.h   |  3 ++
> >  mm/page_alloc.c          | 79 ++++++++++++++++++++++++++++++++++++----
> >  4 files changed, 79 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 65b8df1db26a..ff9060af6295 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -372,6 +372,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int ni=
d, size_t size, gfp_t gfp_mas
> >         __get_free_pages((gfp_mask) | GFP_DMA, (order))
> >
> >  extern void __free_pages(struct page *page, unsigned int order);
> > +extern void free_pages_nolock(struct page *page, unsigned int order);
> >  extern void free_pages(unsigned long addr, unsigned int order);
> >
> >  #define __free_page(page) __free_pages((page), 0)
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 7361a8f3ab68..52547b3e5fd8 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -99,6 +99,10 @@ struct page {
> >                                 /* Or, free page */
> >                                 struct list_head buddy_list;
> >                                 struct list_head pcp_list;
> > +                               struct {
> > +                                       struct llist_node pcp_llist;
> > +                                       unsigned int order;
> > +                               };
> >                         };
> >                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
> >                         struct address_space *mapping;
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index b36124145a16..1a854e0a9e3b 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -953,6 +953,9 @@ struct zone {
> >         /* Primarily protects free_area */
> >         spinlock_t              lock;
> >
> > +       /* Pages to be freed when next trylock succeeds */
> > +       struct llist_head       trylock_free_pages;
> > +
> >         /* Write-intensive fields used by compaction and vmstats. */
> >         CACHELINE_PADDING(_pad2_);
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d23545057b6e..10918bfc6734 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -88,6 +88,9 @@ typedef int __bitwise fpi_t;
> >   */
> >  #define FPI_TO_TAIL            ((__force fpi_t)BIT(1))
> >
> > +/* Free the page without taking locks. Rely on trylock only. */
> > +#define FPI_TRYLOCK            ((__force fpi_t)BIT(2))
> > +
>
> The comment above the definition of fpi_t mentions that it's for
> non-pcp variants of free_pages(), so I guess that needs to be updated
> in this patch.

No. The comment:
/* Free Page Internal flags: for internal, non-pcp variants of free_pages()=
. */
typedef int __bitwise fpi_t;

is still valid.
Most of the objective of the FPI_TRYLOCK flag is used after pcp is over.

> More importantly, I think the comment states this mainly because the
> existing flags won't be properly handled when freeing pages to the
> pcplist. The flags will be lost once the pages are added to the
> pcplist, and won't be propagated when the pages are eventually freed
> to the buddy allocator (e.g. through free_pcppages_bulk()).

Correct. fpi_t flags have a local effect. Nothing new here.


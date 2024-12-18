Return-Path: <bpf+bounces-47198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 691309F5E63
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 06:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C6C1891547
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 05:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9540C155303;
	Wed, 18 Dec 2024 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7UsIrK/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12F13F42A
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734501495; cv=none; b=C/UhBWYXO3wmwXclHpVtTqwQYzBwxkBR6HNs6HB3DL0ZMi4Wo0gw1eepqIjYxGlBOh9xxNOhETq8qlz4zpyGGLGQs49Op4MPXayYVgDzu0gNUuTUiu31B27wNkNM/SGnjLlh22qZZobdQR6Ri3PpCI4Lu7g8V4IZzrkVZYVAKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734501495; c=relaxed/simple;
	bh=uug1qaQpTH0RvvNHhfgOSCppGL3ANr1Q7742nGkLcXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDJXES3/lGNGb5ZtT3HohEyJpb/Dbo8Acp8RcF2N+Hq2+paZXT/meplOOn10NhwS7kqnRfjYZW2gpZKsndYq/x2IFlswme3Yl/ttF/5QTb5n6DvFm9WE3X6FmxR1xAesvwRf7Dfs8pA0art9t27+8BKJyIbvWqKy2JDFluFQLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7UsIrK/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dcf62a3768so13499526d6.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 21:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734501492; x=1735106292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdVC+V1lE3EzFMku1CBbi1h5NIdtzmwR83XRp1ok54I=;
        b=v7UsIrK/LHryp+QktvKgp+K8YXB+JUy0XqR8I1W/no1dRBXp4GpbFIEOV5dKmv5No3
         DnzQiH8v37sIn/XpHPXtGY846bYyEYiquT8V80+peqCBJSCNtq/Vq6JAi+biAEj3j/pc
         xH6PKjN6rvcjlTL0A7H4C2sywY7ZvnlGhRyPwYmesOKcPZkntEDzeFbdnQLQvBVwl4nf
         /huE3/gY9ftXgi+5TfEHXNOBxXa/7oTZDPDiQNK6333y7NVH3n+BOO9H0gX9i/PEyAUR
         RdR4dqXt/Wx5qyUPp1D1SamymrrQRFySZJROgw9K1hRntQNjy31wRMw8UvcECw/R1+NH
         8qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734501492; x=1735106292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdVC+V1lE3EzFMku1CBbi1h5NIdtzmwR83XRp1ok54I=;
        b=p51tVJYrZ9mUHtvKf5fHrwNrRXutigq06Q7fru4vjlIdN/EBGVtO0y25dNZTVIaIO0
         IwBSb715wf8TZcLlo3t7Zd5QKYSCoi7gdzHdwQG4LIWSfnlL9/P8OwagQwubPpDENVIo
         tc72z7KNzj46Sjgdih17pkxfZRhi5kWeepSVbxuIoAnqh7hV9/aODrQURI0y5IrGlhpC
         mtlS4nMfx6TFyooTE6AWv+7uPg/NKSMAhL3eyvIz1yELlWjgHl0dl7BmcGp4KvpxXA1B
         7WLJv0HbQPsBaD2NQ3Uca7w9LoPijTHjpjyViq+ov3w81mA14Y+65/yf7CWwFClvEdm1
         5Yvw==
X-Gm-Message-State: AOJu0YzzxHHzQFkIwf/T6mqgF6qVJl0Hv81nYWBxVI1gAiw/hyem5YXP
	2QgFFGnM3KjmKg/U9SYtY3j1fCQ8i0p2IrER4CJS5q6TaL0RtowWHpoJCKCdchtJsUQpCGZA6yM
	4LcfQktRwumAgB5Rjn3refX4U4rPId6/wPOC8
X-Gm-Gg: ASbGncttmnIFy2+13+9lpjIDiekwAm+6LI/MDpbRUDkiXmYWXMtMFczH4SKjd7VTsFS
	oK5v7MNd0rRHLl5k7cxEeDGXijvh3Bm2T/Ag=
X-Google-Smtp-Source: AGHT+IGO3tVMnb8y1w3lzTzwiPPQ+okT6q01VKlJV3KSmw8yJD+Z3c2J6GiLhYMdLxSFoQjTQV5YJxKZRJTyUIIBpj0=
X-Received: by 2002:a05:6214:c45:b0:6d4:3c10:5065 with SMTP id
 6a1803df08f44-6dd0923a590mr27329546d6.32.1734501492018; Tue, 17 Dec 2024
 21:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-3-alexei.starovoitov@gmail.com> <CAJD7tkYOfBepXDeUFj6mM1evRoDdaS_THwmhp9a4pHeM4bgsFA@mail.gmail.com>
 <CAADnVQKmMaybRQJDyC9sbtmxod6S8kgcrk4FerWt9ve0vR9U1w@mail.gmail.com>
In-Reply-To: <CAADnVQKmMaybRQJDyC9sbtmxod6S8kgcrk4FerWt9ve0vR9U1w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 17 Dec 2024 21:57:35 -0800
X-Gm-Features: AbW1kvbg0vhYDiDFK_Uh0GQNmC7y-RtR1w69Jl0iG8r6QtJLfE7edweC07ccEvg
Message-ID: <CAJD7tkaP40Tde1KHr2t8O9dHyiRSx8Q02=EmPtROyRpS+_qPDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Tue, Dec 17, 2024 at 9:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 17, 2024 at 8:59=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Dec 17, 2024 at 7:07=E2=80=AFPM <alexei.starovoitov@gmail.com> =
wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Introduce free_pages_nolock() that can free pages without taking lock=
s.
> > > It relies on trylock and can be called from any context.
> > > Since spin_trylock() cannot be used in RT from hard IRQ or NMI
> > > it uses lockless link list to stash the pages which will be freed
> > > by subsequent free_pages() from good context.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  include/linux/gfp.h      |  1 +
> > >  include/linux/mm_types.h |  4 ++
> > >  include/linux/mmzone.h   |  3 ++
> > >  mm/page_alloc.c          | 79 ++++++++++++++++++++++++++++++++++++--=
--
> > >  4 files changed, 79 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > index 65b8df1db26a..ff9060af6295 100644
> > > --- a/include/linux/gfp.h
> > > +++ b/include/linux/gfp.h
> > > @@ -372,6 +372,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int =
nid, size_t size, gfp_t gfp_mas
> > >         __get_free_pages((gfp_mask) | GFP_DMA, (order))
> > >
> > >  extern void __free_pages(struct page *page, unsigned int order);
> > > +extern void free_pages_nolock(struct page *page, unsigned int order)=
;
> > >  extern void free_pages(unsigned long addr, unsigned int order);
> > >
> > >  #define __free_page(page) __free_pages((page), 0)
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 7361a8f3ab68..52547b3e5fd8 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -99,6 +99,10 @@ struct page {
> > >                                 /* Or, free page */
> > >                                 struct list_head buddy_list;
> > >                                 struct list_head pcp_list;
> > > +                               struct {
> > > +                                       struct llist_node pcp_llist;
> > > +                                       unsigned int order;
> > > +                               };
> > >                         };
> > >                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
> > >                         struct address_space *mapping;
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index b36124145a16..1a854e0a9e3b 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -953,6 +953,9 @@ struct zone {
> > >         /* Primarily protects free_area */
> > >         spinlock_t              lock;
> > >
> > > +       /* Pages to be freed when next trylock succeeds */
> > > +       struct llist_head       trylock_free_pages;
> > > +
> > >         /* Write-intensive fields used by compaction and vmstats. */
> > >         CACHELINE_PADDING(_pad2_);
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index d23545057b6e..10918bfc6734 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -88,6 +88,9 @@ typedef int __bitwise fpi_t;
> > >   */
> > >  #define FPI_TO_TAIL            ((__force fpi_t)BIT(1))
> > >
> > > +/* Free the page without taking locks. Rely on trylock only. */
> > > +#define FPI_TRYLOCK            ((__force fpi_t)BIT(2))
> > > +
> >
> > The comment above the definition of fpi_t mentions that it's for
> > non-pcp variants of free_pages(), so I guess that needs to be updated
> > in this patch.
>
> No. The comment:
> /* Free Page Internal flags: for internal, non-pcp variants of free_pages=
(). */
> typedef int __bitwise fpi_t;
>
> is still valid.
> Most of the objective of the FPI_TRYLOCK flag is used after pcp is over.

Right, but the comment says the flags are for non-pcp variants yet we
are passing them now to pcp variants. Not very clear.

>
> > More importantly, I think the comment states this mainly because the
> > existing flags won't be properly handled when freeing pages to the
> > pcplist. The flags will be lost once the pages are added to the
> > pcplist, and won't be propagated when the pages are eventually freed
> > to the buddy allocator (e.g. through free_pcppages_bulk()).
>
> Correct. fpi_t flags have a local effect. Nothing new here.

What I mean is, functions like __free_unref_page() and
free_unref_page_commit() now accept fpi_flags, but any flags other
than FPI_TRYLOCK are essentially ignored, also not very clear.

Anyway, these are just my 2c, I am just passing by and I thought it's
a bit confusing :)


Return-Path: <bpf+bounces-76504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D1BCB7C41
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 04:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97B083053FC1
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 03:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC09F2DC780;
	Fri, 12 Dec 2025 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPlk6yFb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234242D73B0
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509413; cv=none; b=ltbU0nMTNZgyrc9hpGRHmo8+bopkXL9Egs01O1ADoNac/admwDif0VxvQxqHSF/m/whyGZwlhsUMjHSnIEZ6kym97Ko8KXc3ZxQ8YwsA5cBzQry+SS9Za5/O1ZeS+UsHsTQwnImr/fxYUCMpVZ7fiRXXpaEtahptDw7qWjAv9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509413; c=relaxed/simple;
	bh=yPECOhtMQ7RnvZC02Qlik9MySQgV8FNENTISeqY/jkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+EfxBlD3CAT9cIac0HisD5B8MO5EzGHHgIBYSXzahmtFIBCFip7UCndXqwKDai+4xa87VVcMsLAl0M4ilVIayv9i1WdzS0tjNt+JpGwTUj0RyCCcxhLaiCynNTCkyvD4/RIPVYew+Ofaz/LjJTCUremYR6hIqcuhUE/cMOP0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPlk6yFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C768C4CEF5
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 03:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765509412;
	bh=yPECOhtMQ7RnvZC02Qlik9MySQgV8FNENTISeqY/jkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WPlk6yFbBW+eM+qey7ZHyF1RdW88UMClRc4RtbqtKrmMjQEu5vV8UOTGElugFcfix
	 vMr1WkXJN3HD1YBLHHTpW1dRTfCcTtTJun5E9C839WBpd2etqbz90e3VxshCEo4vBV
	 DL+eIMR8KvnS6jVcCe1z9kxHv1Rb4pr3fABWI+KFyQRFf01zL0rGRtwLwXUS7aecBt
	 276lYeatGKGUCX4EIkte8PL8509ytNgj68SO62yeMRu2zhscKpR247VQCXFIPuViAs
	 7CtjVn46fLTasSK7NqszCkGSbz1c9a0YUXDeKi4fHvFTG79PEbRT6/vteepa/tocNX
	 t7X7VD5nlVtsA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6495c4577adso1036345a12.3
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 19:16:52 -0800 (PST)
X-Gm-Message-State: AOJu0YxJZ4/wKB0I2+bRXIxQK48opH/JNl5ICtrKDN/kU3xr1WsV0mqT
	hz5SKQDsBmuCKSeo0DMWQXMjJ+jOq2ZiJrfablZ0dHJRxPf/04h4BFcZR1vwrWOwniQUdIiV3jq
	ClnhR3nINV+X5nnnKZSejSRNEFEohRw8=
X-Google-Smtp-Source: AGHT+IHCaRIP8I5dpb67E/f6xHb9sZRRzgYUowvKDZCUyi14jXYLGrNmnZwk06Sr6j6F0bC0aQnMfrUlgBhICC77D48=
X-Received: by 2002:a17:906:7954:b0:b73:4fbb:37a2 with SMTP id
 a640c23a62f3a-b7d238ee6b1mr40139266b.5.1765509410945; Thu, 11 Dec 2025
 19:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212004350.6520-4-puranjay@kernel.org> <c5daf712b2a51bf284ff8b01a0a0cf3a74b9bf30873dcdf83a8b4a5875c4427a@mail.kernel.org>
In-Reply-To: <c5daf712b2a51bf284ff8b01a0a0cf3a74b9bf30873dcdf83a8b4a5875c4427a@mail.kernel.org>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Fri, 12 Dec 2025 12:16:39 +0900
X-Gmail-Original-Message-ID: <CANk7y0igaXufjF-fH+Cph+gKoAfzhxZotbuH61-Vzfz_ndpEhQ@mail.gmail.com>
X-Gm-Features: AQt7F2r_QdRulKt-w8c9s-zd6Mz5B7v7zhIonpi-pYmp0ZFnX_VIS8Q3bCoJD_8
Message-ID: <CANk7y0igaXufjF-fH+Cph+gKoAfzhxZotbuH61-Vzfz_ndpEhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: arena: make arena kfuncs any context safe
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, kernel-team@meta.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 10:05=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 28d8d6b7bb1e..e873dc34fc2f 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -673,6 +673,21 @@ void bpf_map_free_internal_structs(struct bpf_map =
*map, void *obj);
> >  int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
> >                                  struct bpf_dynptr *ptr__uninit);
> >
> > +#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> > +void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ig=
n, u32 page_cnt, int node_id,
> > +                                       u64 flags);
> > +void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, =
u32 page_cnt);
> > +#else
> > +static inline void *bpf_arena_alloc_pages_non_sleepable(void *p__map, =
void *addr__ign, u32 page_cnt,
> > +                                                     int node_id, u64 =
flags)
> > +{
> > +}
>
> Should bpf_arena_alloc_pages_non_sleepable() return NULL here? The
> function is declared to return void * but has no return statement.

Will fix this in the next version.

>
> > +
> > +static inline void bpf_arena_free_pages_non_sleepable(void *p__map, vo=
id *ptr__ign, u32 page_cnt)
> > +{
> > +}
> > +#endif
>
> [ ... ]
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>
> [ ... ]
>
> > -static void arena_free_pages(struct bpf_arena *arena, long uaddr, long=
 page_cnt)
> > +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long=
 page_cnt, bool sleepable)
> >  {
> >       u64 full_uaddr, uaddr_end;
> > -     long kaddr, pgoff, i;
> > +     long kaddr, pgoff;
> >       struct page *page;
> > +     struct llist_head free_pages;
> > +     struct llist_node *pos, *t;
> > +     struct arena_free_span *s;
> > +     unsigned long flags;
> > +     int ret =3D 0;
> >
> >       /* only aligned lower 32-bit are relevant */
> >       uaddr =3D (u32)uaddr;
> >       uaddr &=3D PAGE_MASK;
> > +     kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
> >       full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;
> >       uaddr_end =3D min(arena->user_vm_end, full_uaddr + (page_cnt << P=
AGE_SHIFT));
> >       if (full_uaddr >=3D uaddr_end)
> >               return;
> >
> >       page_cnt =3D (uaddr_end - full_uaddr) >> PAGE_SHIFT;
> > +     pgoff =3D compute_pgoff(arena, uaddr);
> >
> > -     guard(mutex)(&arena->lock);
> > +     if (!sleepable)
> > +             goto defer;
> > +
> > +     ret =3D raw_res_spin_lock_irqsave(&arena->spinlock, flags);
> > +
> > +     /* Can't proceed without holding the spinlock so defer the free *=
/
> > +     if (ret)
> > +             goto defer;
> >
> > -     pgoff =3D compute_pgoff(arena, uaddr);
> > -     /* clear range */
> >       range_tree_set(&arena->rt, pgoff, page_cnt);
> >
> > +     init_llist_head(&free_pages);
> > +     /* clear ptes and collect struct pages */
> > +     apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SH=
IFT,
> > +                                  apply_range_clear_cb, &free_pages);
> > +
> > +     /* drop the lock to do the tlb flush and zap pages */
> > +     raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> > +
> > +     /* ensure no stale TLB entries */
> > +     flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
> > +
> >       if (page_cnt > 1)
> >               /* bulk zap if multiple pages being freed */
> >               zap_pages(arena, full_uaddr, page_cnt);
> >
> > -     kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
> > -     for (i =3D 0; i < page_cnt; i++, kaddr +=3D PAGE_SIZE, full_uaddr=
 +=3D PAGE_SIZE) {
> > -             page =3D vmalloc_to_page((void *)kaddr);
> > -             if (!page)
> > -                     continue;
> > +     llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
> > +             page =3D llist_entry(pos, struct page, pcp_llist);
> >               if (page_cnt =3D=3D 1 && page_mapped(page)) /* mapped by =
some user process */
> >                       /* Optimization for the common case of page_cnt=
=3D=3D1:
> >                        * If page wasn't mapped into some user vma there
> > @@ -640,9 +697,20 @@ static void arena_free_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
> >                        * page_cnt is big it's faster to do the batched =
zap.
> >                        */
> >                       zap_pages(arena, full_uaddr, 1);
> > -             apply_to_existing_page_range(&init_mm, kaddr, PAGE_SIZE, =
apply_range_clear_cb,
> > -                                          NULL);
> > +             __free_page(page);
> >       }
> > +
> > +     return;
> > +
> > +defer:
> > +     s =3D kmalloc_nolock(sizeof(struct arena_free_span), 0, -1);
> > +     if (!s)
> > +             return;
>
> Does this leak pages when kmalloc_nolock() fails? The function returns
> without clearing the PTEs, flushing TLB, or freeing the pages. The
> range_tree bits are also not set back to free, so these pages become
> permanently inaccessible until the arena is destroyed.
>
> In the non-sleepable path when kmalloc_nolock() returns NULL:
> - Pages remain allocated in the arena
> - PTEs are not cleared
> - range_tree bits remain cleared (pages marked as allocated)
> - No retry mechanism exists to free these pages later

This is intentional as nothing can be done if this allocation fails
(unlikely). The pages will be
inaccessible until the arena is destroyed. I will add a comment here
in the next version.

>
> > +
> > +     s->page_cnt =3D page_cnt;
> > +     s->uaddr =3D uaddr;
> > +     llist_add(&s->node, &arena->free_spans);
> > +     irq_work_queue(&arena->free_irq);
> >  }
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/201524=
58491


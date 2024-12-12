Return-Path: <bpf+bounces-46738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C99EFCDA
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB12116ABE4
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220281A76BC;
	Thu, 12 Dec 2024 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYUK8DGT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55519E971
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033437; cv=none; b=hsXrS0y1FHbBWRyJUvD4pZshgwxBItZV2lm1YM3JTlMFHxXKFm7On+3Hv6EJqctle9goYdvP0y3fKI7rUaVJqvV4GgCpCo424VDapo5wDAMdjOjkfGrazRvENY3i+0FWTFb0IaXxczkp76Klmc9jWSCxjudunqC70QamOoj+7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033437; c=relaxed/simple;
	bh=aKY+RTOD0iguRBIt0BeuOQrzDTE+7QoCjXdvId+eqaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exbcTSvOyjf6oVO21Njhbt7ENqZ6f+Si7fQ8PnCXyjNGaYmu5VWrBZponZ39e2mL/ySY7E2irwvd4DBK+cLQu0AEjAtHoMSaSRc2JNjWBsv0xq82qmMRGD+J4m0ThMIBWyOBPm4lNMDO36gXnkzOFTQAycz4jdnhr/VAbropq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYUK8DGT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso10697855e9.2
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734033434; x=1734638234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JEGqxKtdaUUilE2n0nETZalgEqO/v8JCJtGSqnmfjs=;
        b=JYUK8DGT7vl4oqOGY/cnaqhsImvOo4vunkal6WUb9wVXJf9K7OxXY6zQ4/COrtNlIL
         3pHdQsCjtKzMuSZWPDnvUqfHPrY2aoha/RnoIjyL8KiIrcWTQ/humN0EdE22wia75PZo
         8l5duJLWI8DBk/GnDzxxc7EgULoG6xfxgwKsMpXDv312BrY4CHdcG+DZB7jnzwPz7zf3
         qjfrmgs4PNVND8WsXs34uLjnydraK8F3AfvYlIj/ETjq56fUN6UyCc5ZgshI0SzFkhrh
         zxvmc0yLw1MzPaCr9NHINTRUmKu8ilIyXiLYiSu3Y0f0BxzI6WT3OPINRU+eED2zMjgu
         1AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734033434; x=1734638234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JEGqxKtdaUUilE2n0nETZalgEqO/v8JCJtGSqnmfjs=;
        b=Clhhn9vzRu8rOu3HRl0BkdTtKlBUaYHvs7fQdJfq9BcXmIRcK2allPoTKStEMEK8JR
         dl1A5LSXTWclSlECXzS8Tn7s+gBe3bWhgxFmUXE5xIVHcEIhCyqWEepMwzzbq1TCaPoJ
         K7btGkO7sQtTOsbvNlV+sHFuF7iWTkt4frHF90HNQcqepKzryBTZDGmGEGyBuJvMnDnf
         uHYHzC3gtBlhKML4rEPfJo1mNxNvJzTDDcTvTAls8EXn+SX3EfQw4EldXG2QZBytCr5k
         0o2PWLEkDLtOoFCkuiwqaCwLAJNZnLZ417NvjrwATKk4VjysIXDoOkmVGYsdbrD8ojGm
         fTcw==
X-Gm-Message-State: AOJu0YyzscAfnV/5Q3LGf/jOJME/OnCLo1L7GEHAqfw3r110yaUmVmua
	LMISY/i9hfLNVGHOtb9metXScj/dUhzLTcpf5RR/Qwuttz1yWNfZdK/KDLNfjK3ko8ZsTIuQtyp
	xDGRl1MLkIHI/6uvIy1Ar8+t9VEk=
X-Gm-Gg: ASbGnctSymEsZmMAmkPvdQ3usRhPit3Qtqf3d1lwId2T3P7jiICKuALTcIDO1HPA0oj
	r0vv0Xul+BeejG6wTYGqumGk+M6utpKMjjutvjQMAwwFO6owvXZqusKfniJkW4xI8GVPSFA==
X-Google-Smtp-Source: AGHT+IGF7gUTtsY5pQMcEJgtjMQfaCZcdoWMxUYkZxHPtYKNCnC8ZsYLG8Cu+mz5d968ne2oPFonsnUOrbO6fA+PJRg=
X-Received: by 2002:a05:6000:1541:b0:385:e5d8:3ec2 with SMTP id
 ffacd0b85a97d-38787697206mr4289022f8f.28.1734033434066; Thu, 12 Dec 2024
 11:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-3-alexei.starovoitov@gmail.com> <20241210083503.zJdPI8s5@linutronix.de>
 <CAADnVQJ6c6R5wr1qpQBKnYh2WOC6SjiuZg9K=3ULePOh=5T8_Q@mail.gmail.com> <20241212144438.HDVlGUyA@linutronix.de>
In-Reply-To: <20241212144438.HDVlGUyA@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Dec 2024 11:57:03 -0800
Message-ID: <CAADnVQK07h7HNyu5u4xnCepnHejSTcG3kJT3JKdk6xEJwojjxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] mm, bpf: Introduce free_pages_nolock()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 6:44=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-12-10 14:49:14 [-0800], Alexei Starovoitov wrote:
> > On Tue, Dec 10, 2024 at 12:35=E2=80=AFAM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2024-12-09 18:39:32 [-0800], Alexei Starovoitov wrote:
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index d511e68903c6..a969a62ec0c3 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -1251,9 +1254,33 @@ static void free_one_page(struct zone *zone,=
 struct page *page,
> > > >                         unsigned long pfn, unsigned int order,
> > > >                         fpi_t fpi_flags)
> > > >  {
> > > > +     struct llist_head *llhead;
> > > >       unsigned long flags;
> > > >
> > > > -     spin_lock_irqsave(&zone->lock, flags);
> > > > +     if (!spin_trylock_irqsave(&zone->lock, flags)) {
> > > > +             if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> > > > +                     /* Remember the order */
> > > > +                     page->order =3D order;
> > > > +                     /* Add the page to the free list */
> > > > +                     llist_add(&page->pcp_llist, &zone->trylock_fr=
ee_pages);
> > > > +                     return;
> > > > +             }
> > > > +             spin_lock_irqsave(&zone->lock, flags);
> > > > +     }
> > > > +
> > > > +     /* The lock succeeded. Process deferred pages. */
> > > > +     llhead =3D &zone->trylock_free_pages;
> > > > +     if (unlikely(!llist_empty(llhead))) {
> > > > +             struct llist_node *llnode;
> > > > +             struct page *p, *tmp;
> > > > +
> > > > +             llnode =3D llist_del_all(llhead);
> > >
> > > Do you really need to turn the list around?
> >
> > I didn't think LIFO vs FIFO would make a difference.
> > Why spend time rotating it?
>
> I'm sorry. I read llist_reverse_order() in there but it is not there. So
> it is all good.
>
> > > > +             llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) =
{
> > > > +                     unsigned int p_order =3D p->order;
> > > > +                     split_large_buddy(zone, p, page_to_pfn(p), p_=
order, fpi_flags);
> > > > +                     __count_vm_events(PGFREE, 1 << p_order);
> > > > +             }
> > >
> > > We had something like that (returning memory in IRQ/ irq-off) in RT t=
ree
> > > and we got rid of it before posting the needed bits to mm.
> > >
> > > If we really intend to do something like this, could we please proces=
s
> > > this list in an explicitly locked section? I mean not in a try-lock
> > > fashion which might have originated in an IRQ-off region on PREEMPT_R=
T
> > > but in an explicit locked section which would remain preemptible. Thi=
s
> > > would also avoid the locking problem down the road when
> > > shuffle_pick_tail() invokes get_random_u64() which in turn acquires a
> > > spinlock_t.
> >
> > I see. So the concern is though spin_lock_irqsave(&zone->lock)
> > is sleepable in RT, bpf prog might have been called in the context
> > where preemption is disabled and do split_large_buddy() for many
> > pages might take too much time?
> Yes.
>
> > How about kicking irq_work then? The callback is in kthread in RT.
> > We can irq_work_queue() right after llist_add().
> >
> > Or we can process only N pages at a time in this loop and
> > llist_add() leftover back into zone->trylock_free_pages.
>
> It could be simpler to not process the trylock_free_pages list in the
> trylock attempt, only in the lock case which is preemptible.

Make sense. Will change to:

        /* The lock succeeded. Process deferred pages. */
        llhead =3D &zone->trylock_free_pages;
-       if (unlikely(!llist_empty(llhead))) {
+       if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_TRYLOCK))) {


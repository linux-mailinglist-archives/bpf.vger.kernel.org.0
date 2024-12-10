Return-Path: <bpf+bounces-46578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABA99EBE15
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 23:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6836B28365E
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 22:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77621F1929;
	Tue, 10 Dec 2024 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIyF0IpZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89AD211287
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870970; cv=none; b=XBipB1lxVdt6kD6GUQHi/VRqgvcYxvFidP2JRc2by9BL7Q5mcYuHn4CgGX0sVhx0XCyik0o1/TaUW3CGcri/jcOtyegm3zxOEwlb3D2g/jlzmYaRy9KR4t/M9gzTIOODYuJS/advFecdpflIRIm61JXBNFNYuSD2ZMcaguw4gaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870970; c=relaxed/simple;
	bh=OjYMfVbzJKRLFDbxdyOMBxsGjVluYJR8NLyt97uwhPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVs/19DsCrvWRWu5LoI0pLjjYnrM4U5jEvfe7rJCG/PGXfZx42yK3qgms1RgMUCBCgg0bFKdswez2T8WoKbt22s00G7k8Jg7vUkIHm1nWUJ5+OEma3to9DujPiCY5ylATJk5VVjwpaXxqaxawE/MOMGiMbe4lL+RXO5hR5hVb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIyF0IpZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43618283dedso8968905e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 14:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733870966; x=1734475766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3SmH96rZdAmxXm/LtFzOTj0/FSlJY104Q51DFmlAfw=;
        b=BIyF0IpZUbO+dXV3w8dIULFW7YjX/QYE3cP4dzbTPP0OwLJxyoXFgEo8WMy6fT0gZr
         9VnHd0jZnNIhDQkq7WvJU8phz4Ud2Gy+iZrtXD7MYdpdr2mM6QQoyEgB86PYzCqBSKxM
         vU05uqQhhQMDEomqlGBqYqgR42tmJeQm7V7jjC91+JIQH0h74PTsYlkW+AxbMqQeCi9X
         sT7JFck4039BzWaty1w2HqT7dWMMCON3VgYrIK9FzOU/XislWqHS/xfmwdiqgtgmvbnT
         r42jesFDj0Q89H9/PyanLiI7+/gor5N8kPmO2aN91KTC1JcEWhRnUENO3mswlqVQ11T0
         +0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733870966; x=1734475766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3SmH96rZdAmxXm/LtFzOTj0/FSlJY104Q51DFmlAfw=;
        b=M1/KFToBXYR4/38obD6IskLvP1XWbyEPnIo3sCaxzVfEAkB2jIYNbByD6Odm2sgoUw
         ILtORrDv8RLddfcWsOh4ysv+8k2aaAMwD7v3izgcA9ruJ0sT0DPLxPqukdSX/B96JtPy
         FB4jd4jOZBn25yM7+ayTVtJ4LPS8TP7vbY2ZNoOaACJV2YTpt3/wQbbabINcvPDWJZKN
         nbw+THQXHJDEe6HSI6iFYGHA527z/eSknY40aSYXhQiQMbfomiun2Eup67KA9r+Qf0zo
         hR6E28lvv0V5W3S0XcUYm9krcEiyiOC/LdaBs/c40MEFVpLUqnKl7w1SNW3cIyY5WUcg
         JtDw==
X-Gm-Message-State: AOJu0Yy/Yn9ri6ltwMdqcj28EyLGSXkbjuOzb563xbEMqQ6OCRWC2fIY
	kOqiSfucTtd8VdRIjIvgWvxRU2NEFGxZ/QSXX6JXTv/RDhQSwZnOYSqD2TNatob4/z+rLOqOnrl
	RwpcNkkjxO78HX3wrF0eeai51D1A=
X-Gm-Gg: ASbGnctVkdDwll6Fq0S7Y5kZc5L8ZpRwIRjiKt72QZ5LvGEfKwQ4sNGsNprzcis66rB
	BDB0k+8aTTwrBY2FjCSfrLxJ0q4Qt4WTfX3xkl81COIW2/2JEcDQ=
X-Google-Smtp-Source: AGHT+IGj6D9A1VwFS0CULfUzd94ydRp3gIEuxsI0eI+elw2hof/SD0900ib3R/UplLbD13SBkGMK3x8lGNh63gTolfY=
X-Received: by 2002:a05:6000:2a7:b0:385:ddd2:6ab7 with SMTP id
 ffacd0b85a97d-3864ced2f4dmr641758f8f.52.1733870966112; Tue, 10 Dec 2024
 14:49:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-3-alexei.starovoitov@gmail.com> <20241210083503.zJdPI8s5@linutronix.de>
In-Reply-To: <20241210083503.zJdPI8s5@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 14:49:14 -0800
Message-ID: <CAADnVQJ6c6R5wr1qpQBKnYh2WOC6SjiuZg9K=3ULePOh=5T8_Q@mail.gmail.com>
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

On Tue, Dec 10, 2024 at 12:35=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-12-09 18:39:32 [-0800], Alexei Starovoitov wrote:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d511e68903c6..a969a62ec0c3 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1251,9 +1254,33 @@ static void free_one_page(struct zone *zone, str=
uct page *page,
> >                         unsigned long pfn, unsigned int order,
> >                         fpi_t fpi_flags)
> >  {
> > +     struct llist_head *llhead;
> >       unsigned long flags;
> >
> > -     spin_lock_irqsave(&zone->lock, flags);
> > +     if (!spin_trylock_irqsave(&zone->lock, flags)) {
> > +             if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> > +                     /* Remember the order */
> > +                     page->order =3D order;
> > +                     /* Add the page to the free list */
> > +                     llist_add(&page->pcp_llist, &zone->trylock_free_p=
ages);
> > +                     return;
> > +             }
> > +             spin_lock_irqsave(&zone->lock, flags);
> > +     }
> > +
> > +     /* The lock succeeded. Process deferred pages. */
> > +     llhead =3D &zone->trylock_free_pages;
> > +     if (unlikely(!llist_empty(llhead))) {
> > +             struct llist_node *llnode;
> > +             struct page *p, *tmp;
> > +
> > +             llnode =3D llist_del_all(llhead);
>
> Do you really need to turn the list around?

I didn't think LIFO vs FIFO would make a difference.
Why spend time rotating it?

> > +             llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
> > +                     unsigned int p_order =3D p->order;
> > +                     split_large_buddy(zone, p, page_to_pfn(p), p_orde=
r, fpi_flags);
> > +                     __count_vm_events(PGFREE, 1 << p_order);
> > +             }
>
> We had something like that (returning memory in IRQ/ irq-off) in RT tree
> and we got rid of it before posting the needed bits to mm.
>
> If we really intend to do something like this, could we please process
> this list in an explicitly locked section? I mean not in a try-lock
> fashion which might have originated in an IRQ-off region on PREEMPT_RT
> but in an explicit locked section which would remain preemptible. This
> would also avoid the locking problem down the road when
> shuffle_pick_tail() invokes get_random_u64() which in turn acquires a
> spinlock_t.

I see. So the concern is though spin_lock_irqsave(&zone->lock)
is sleepable in RT, bpf prog might have been called in the context
where preemption is disabled and do split_large_buddy() for many
pages might take too much time?
How about kicking irq_work then? The callback is in kthread in RT.
We can irq_work_queue() right after llist_add().

Or we can process only N pages at a time in this loop and
llist_add() leftover back into zone->trylock_free_pages.


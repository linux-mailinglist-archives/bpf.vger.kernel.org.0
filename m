Return-Path: <bpf+bounces-46707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FC29EE935
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 15:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0945289574
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4377D2153DC;
	Thu, 12 Dec 2024 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MNStwzcm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VXbkPsTI"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AED20E716
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014684; cv=none; b=AkYfsCpkwG78LTFEKBSlyR4BCelNBqZnscryHjG8ceMO9uc68VUVHn4XZj1io2MeQe+LNZYG6Hd4Yhcjs8eOsPL2v6R+bVkDYBTF4MHC+mEWJy2wMV82dqjyD+j5YOkWbNs2QrX4qH3hwJ3YFYEK28BprBwWlKBUVtfggb3Dxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014684; c=relaxed/simple;
	bh=CO/Db98yf/+rnIdVzc+L8G8sFejwZV7wim64womlW/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxACaFcFa1CV2s9cpRm4C2VCXWs3PDqYMGsqn9/QZ9iV8w8rv+XHrjj9CxZE+7WVldTovMA3iWJHzwWjdTBcamI0jBXRknMQPTmpXF7/8Z/5Z5EO+tTK4gKzeW0wGuJ3vD3d2sY4VwG2DfOPiM4UNqAf+nChHaQKUPlL/tZWqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MNStwzcm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VXbkPsTI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Dec 2024 15:44:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734014680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4Omk5678+THnJHgzrgIJpzmquIj1RqB6vEWe8xWi4A=;
	b=MNStwzcm6YDOdfC7m04uibbBOh8HhPqqXAeMwkyP2Jbt4lapKaFllVDIaNoC2D9JuP1NE0
	m0QKNyZTIYfZF+QgBR93bSrAQlT5HJOeWndbGhtHG2ZU8cH3AbxThfksGJQRbGVVGJMTTo
	wvDHTqJHrSOVdjMv/RkSUVIXI5agURYYh3JArfhixT4EphAbrtV3hqq6Mq/pm4VQpECV8t
	axlYAHDDV865HaYqF+X4NBCNYwQ9PIo0l9buDZW2zazlKWYWOXvTKP9pepC8nsQnPm0J20
	OCL5lBLxjI4QFGEyyjzx1lH/Q4MO7w/rgTQ20ZMdQbc8GSJ2f9yyx2IXGKqgRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734014680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4Omk5678+THnJHgzrgIJpzmquIj1RqB6vEWe8xWi4A=;
	b=VXbkPsTIa0I9BDwIqYzZbpSBi+7fQ71onc4N/G3kZb2OQGPaHlL3ybxZ9YdTmcUl4tIrUp
	y6S8jU+U4/qPFLAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 2/6] mm, bpf: Introduce free_pages_nolock()
Message-ID: <20241212144438.HDVlGUyA@linutronix.de>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-3-alexei.starovoitov@gmail.com>
 <20241210083503.zJdPI8s5@linutronix.de>
 <CAADnVQJ6c6R5wr1qpQBKnYh2WOC6SjiuZg9K=3ULePOh=5T8_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAADnVQJ6c6R5wr1qpQBKnYh2WOC6SjiuZg9K=3ULePOh=5T8_Q@mail.gmail.com>

On 2024-12-10 14:49:14 [-0800], Alexei Starovoitov wrote:
> On Tue, Dec 10, 2024 at 12:35=E2=80=AFAM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2024-12-09 18:39:32 [-0800], Alexei Starovoitov wrote:
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index d511e68903c6..a969a62ec0c3 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1251,9 +1254,33 @@ static void free_one_page(struct zone *zone, s=
truct page *page,
> > >                         unsigned long pfn, unsigned int order,
> > >                         fpi_t fpi_flags)
> > >  {
> > > +     struct llist_head *llhead;
> > >       unsigned long flags;
> > >
> > > -     spin_lock_irqsave(&zone->lock, flags);
> > > +     if (!spin_trylock_irqsave(&zone->lock, flags)) {
> > > +             if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> > > +                     /* Remember the order */
> > > +                     page->order =3D order;
> > > +                     /* Add the page to the free list */
> > > +                     llist_add(&page->pcp_llist, &zone->trylock_free=
_pages);
> > > +                     return;
> > > +             }
> > > +             spin_lock_irqsave(&zone->lock, flags);
> > > +     }
> > > +
> > > +     /* The lock succeeded. Process deferred pages. */
> > > +     llhead =3D &zone->trylock_free_pages;
> > > +     if (unlikely(!llist_empty(llhead))) {
> > > +             struct llist_node *llnode;
> > > +             struct page *p, *tmp;
> > > +
> > > +             llnode =3D llist_del_all(llhead);
> >
> > Do you really need to turn the list around?
>=20
> I didn't think LIFO vs FIFO would make a difference.
> Why spend time rotating it?

I'm sorry. I read llist_reverse_order() in there but it is not there. So
it is all good.

> > > +             llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
> > > +                     unsigned int p_order =3D p->order;
> > > +                     split_large_buddy(zone, p, page_to_pfn(p), p_or=
der, fpi_flags);
> > > +                     __count_vm_events(PGFREE, 1 << p_order);
> > > +             }
> >
> > We had something like that (returning memory in IRQ/ irq-off) in RT tree
> > and we got rid of it before posting the needed bits to mm.
> >
> > If we really intend to do something like this, could we please process
> > this list in an explicitly locked section? I mean not in a try-lock
> > fashion which might have originated in an IRQ-off region on PREEMPT_RT
> > but in an explicit locked section which would remain preemptible. This
> > would also avoid the locking problem down the road when
> > shuffle_pick_tail() invokes get_random_u64() which in turn acquires a
> > spinlock_t.
>=20
> I see. So the concern is though spin_lock_irqsave(&zone->lock)
> is sleepable in RT, bpf prog might have been called in the context
> where preemption is disabled and do split_large_buddy() for many
> pages might take too much time?
Yes.

> How about kicking irq_work then? The callback is in kthread in RT.
> We can irq_work_queue() right after llist_add().
>=20
> Or we can process only N pages at a time in this loop and
> llist_add() leftover back into zone->trylock_free_pages.

It could be simpler to not process the trylock_free_pages list in the
trylock attempt, only in the lock case which is preemptible.

Sebastian


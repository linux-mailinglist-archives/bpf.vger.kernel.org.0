Return-Path: <bpf+bounces-66617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FEAB377C4
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 04:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE557C06EA
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 02:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454F2749C8;
	Wed, 27 Aug 2025 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKjUiv8z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839E01EFF80
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261909; cv=none; b=t2X6i5qJRjRGGFRMHqAIaNu1NeV7HwPgEIjteRdsZw84diGr+hWHlVyu1OoB+uyJpuw33JdhuSvNOQ/MgDdYeypOYjWNVAGIaSeA0qvC3bclUTkNgtnaccwFSOZda7Hxl0pj/v93RCtgHup6hFgx0BsXxeZ0vi6OczeLtTdBtNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261909; c=relaxed/simple;
	bh=JsCM6cUrsSAWEC5+Cl8xQAkPpRceUbn0olHkCGvWnDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRxKjk5T/pGcXiM2nqAxG1rHNe3/eHJLVaR15SBJ97kIJlZwVNp1KRpV2lMDRrFIsH/Omo4gFf6Dq3/UEeDdd+9oUA1u7Zwklgdk63uL0cCnk66j9GK4vltcpyDkuA3O9EUUTiDbQeClavu0lqcCRYh9kcBF0fZg4DBvddwyr28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKjUiv8z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso32666285e9.3
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 19:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756261906; x=1756866706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPZ0cjHpX9ISkQzDoldFUyRE8ewsbgZ6deVAAiBZcHA=;
        b=iKjUiv8z+xiF65P1QE91MCvu06DhvctANtAJzetk3n+QcVuwbisabcopMQoVXykxIe
         3gDwRkiobZWmAr2HVdM6vr23sYUZapoRfEY2H/F1pC9d9wFpE/Q8buAhK38sJ27PZIF5
         oB72huuNxIC0QlsLd49DckvzJmgJw1Ljxy01IzfgM6E4yzDoZom8sktLeg0Eq1jFiGbV
         6mauAVP9zn9DDbkisqZ4lHbvZNBhcxkhM6WZ0m29pmWHxN6WbEzcpxOEcUiiNtDOQap1
         lE7c9mtl3gQzZE50snz6RyV5ejJ5TSP+ueduekLitpLXuNF5UciapB2m3yJgajOtoGoE
         Qriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756261906; x=1756866706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPZ0cjHpX9ISkQzDoldFUyRE8ewsbgZ6deVAAiBZcHA=;
        b=MTfeTNe4z/cU33ZZ7xWmTOZOGmUWNXXUnHWZB/xicWMf4P/v4XjJwLbZG8aZ4IukiX
         DWCB4r2h9m+E3rVTZu82onFxJoB8L7mhraXsr2KNXE5Tw6/MQjyZkTdJG7JuY1n7t1dh
         Z0TiwGxRxngapsrC04JS1H+S6szLCrCLAwSvmW9BXTnEuyoQUx7M7bvUDWBQyVS/oJpE
         LoG8MZ2Yx6/k4jVtxs2zo+qzxfv9SSjc+/+6e/40PqArdmk+v+5Zsf/8dZgontxRGfpQ
         Ba8V6ceZcgafSKsjS25ga2FEEhsTs4ZIapAnGpoSPiBWmgugJMTZwYSPC2FvBt9KHFCB
         ao6w==
X-Gm-Message-State: AOJu0Yxhl8TlY3OvRgBdsNicnCphj4WWC3TC5hx9+q60yCsOZ24o3lIR
	QwKG4+7dCWF1PsqqDWnzXJB8X5SYqHcNjuemvx8JnV24R+vKRf0Px3yMdKKk+fWuS0XQ8PNzSVF
	e4hgjBDBadvqqoC6Q/kSwF5NpLKCao10=
X-Gm-Gg: ASbGncuvNkFyIV2n4tudo2iwsSU6pw+w33xw29FPPaCxHAeNjtWcDiiiqrWOdb1zhdy
	e0LsbJZwIZP8wcSf/9pXGhfDDb3xFrjbQYzuZD/hY0/3/W+oEBw2ZcSGVHTjE4k6d8tmKm6bZbJ
	1DI0Jp90KT/9UOyBhLJBn61DkhzseuSZhv7uPG1dYP3oCbM3VMh/HZwS5rt4gFMHhhgdZBwir7L
	RPWLG9E0gvWP7SDvi/LLzoWdPukv3d16GjSUO/OL7PDpDWiW6dQtM/WjA==
X-Google-Smtp-Source: AGHT+IEGvo/30kFFrtTrRRK4xdcQTRYg7nDPi1UfUAg7xHV+Ke7cIP+dwEKwVCmAa/gFohW6TR4IoCcu37qvVrTeKAo=
X-Received: by 2002:a05:600c:4743:b0:458:bfe1:4a82 with SMTP id
 5b1f17b1804b1-45b5179683dmr206749405e9.16.1756261905648; Tue, 26 Aug 2025
 19:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
 <20250716022950.69330-6-alexei.starovoitov@gmail.com> <aKvqT-BAXGkjW7JT@hyeyoo>
In-Reply-To: <aKvqT-BAXGkjW7JT@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Aug 2025 19:31:34 -0700
X-Gm-Features: Ac12FXwjjsZ2EvcANqqa7llhwppJYGqGgQVuUglhvIlTkrBSooCtpKFyYoUNJlg
Message-ID: <CAADnVQJ3vhBsRqgYEG13neTuXbSU1hNngYmWHqKCLTRr8+QVhw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Harry Yoo <harry.yoo@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 9:46=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Tue, Jul 15, 2025 at 07:29:49PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > kmalloc_nolock() relies on ability of local_lock to detect the situatio=
n
> > when it's locked.
> > In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> > irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
> > In that case retry the operation in a different kmalloc bucket.
> > The second attempt will likely succeed, since this cpu locked
> > different kmem_cache_cpu.
> >
> > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > per-cpu rt_spin_lock is locked by current task. In this case re-entranc=
e
> > into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> > a different bucket that is most likely is not locked by the current
> > task. Though it may be locked by a different task it's safe to
> > rt_spin_lock() on it.
> >
> > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > immediately if called from hard irq or NMI in PREEMPT_RT.
> >
> > kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> > and in_nmi() or in PREEMPT_RT.
> >
> > SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> > spin_trylock_irqsave(&n->list_lock) to allocate while kfree_nolock()
> > always defers to irq_work.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/kasan.h |  13 +-
> >  include/linux/slab.h  |   4 +
> >  mm/Kconfig            |   1 +
> >  mm/kasan/common.c     |   5 +-
> >  mm/slab.h             |   6 +
> >  mm/slab_common.c      |   3 +
> >  mm/slub.c             | 454 +++++++++++++++++++++++++++++++++++++-----
> >  7 files changed, 434 insertions(+), 52 deletions(-)
>
> > +static void defer_free(struct kmem_cache *s, void *head)
> > +{
> > +     struct defer_free *df =3D this_cpu_ptr(&defer_free_objects);
> > +
> > +     if (llist_add(head + s->offset, &df->objects))
> > +             irq_work_queue(&df->work);
> > +}
> > +
> > +static void defer_deactivate_slab(struct slab *slab)
> > +{
> > +     struct defer_free *df =3D this_cpu_ptr(&defer_free_objects);
> > +
> > +     if (llist_add(&slab->llnode, &df->slabs))
> > +             irq_work_queue(&df->work);
> > +}
> > +
> > +void defer_free_barrier(void)
> > +{
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu)
> > +             irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->wor=
k);
> > +}
>
> I think it should also initiate deferred frees, if kfree_nolock() freed
> the last object in some CPUs?

I don't understand the question. "the last object in some CPU" ?
Are you asking about the need of defer_free_barrier() ?

PS
I just got back from 2+ week PTO. Going through backlog.


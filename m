Return-Path: <bpf+bounces-46575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A39EBDF5
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 23:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04E6283FE4
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 22:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67951F1936;
	Tue, 10 Dec 2024 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDP+jfhG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAAE1D014E
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870544; cv=none; b=i6qMUjChL8UT/QgDqDT6LBBDeWx9fqw5E8Y+q48rpYyfft8McKylZbCvhR2z9QJbXaeClydvdm8rlD+7Na1kYMpXfX7T0uu9IXPWvowPPqcURoMkzM9ioolnRok1bAlvzUAeFiimlzmKi8ykN1/2FYDIzfuxCsJhGrMmLPYXP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870544; c=relaxed/simple;
	bh=eAR55BMT3tm1hod1H8QH9auL3F5QCe1VipF4snxPGJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9SGi3tNM6Al3QgYK2sYH0cNG8CW8KnwtjMBBWLEo/kUXyIUMdmjD6PQruZVtJ+pEc53dKx7BSYbRyTNVE4UEYKDusj1xGgmbM6uWI6zAxwBNKGr9jTnDPLW9sgZNgcClv9bT+z//VpXNh4wCvJe33tkR5rBYz5DXL1I8eGHbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDP+jfhG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434f7f6179aso21422305e9.0
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 14:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733870541; x=1734475341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V8YDQEXdiG8e/cO5xVij7n6RmOLAOSXEgElRYuLPvY=;
        b=MDP+jfhGD8Ik/bXNZ6fT3ZVSMO1nId363pMpk8BAdlThEHvrn9+TrDdtF4HjbkGatU
         y3ilFnSM7PStx85641M9ly67armlpTvQa1a4t2VydMbiDMX0ysxfEAyAxmVzyjdfEtnE
         zTJXXqdlV7BMDwiHDtsQ7+0e8DlUYg2XEPuaDwYK3l+rDoJ1lp+arrpfdrCrRgYnh/dn
         e5xTUBv1IT7EfdWXch4kQsaBgKJSCLfb5E7kk1Qtrkt5l77fp/FZutE6h3Ior74FieKG
         KjxQIPDsjOzbBX8lDGgOt7oYaLx0uz2PbT9tgmz9D/dHd1vDOC20jEBYOR8oLpRgYfuT
         FGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733870541; x=1734475341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5V8YDQEXdiG8e/cO5xVij7n6RmOLAOSXEgElRYuLPvY=;
        b=i8JMYxqMgPd8Ap2+wb4qxN3dupXQO9yvHnW7BM0B4BoBgM4YeAN7nV1nv0W+RmKWo2
         kyP0p6BkCp6aIgFkq5rbmjpSmKiO+gXhx1sWtMIO2+KOAtR4Vyv2kUM/w7OnxCED68Es
         2FBNEN9JsJnBmuw92U2c73NvUtLpb8pz+mNPQKW5+Grc6HLU/9W9koAzrUH5+p6SfDcs
         P1Cn0q+YO4Cr+2oqTPNSp9gu5mJ2lrEnpZw4w5rQwZsFAVdt+H9chO4qf7wnnCmIsXAu
         nZeVEXRbYaqu+BIQlFREj8mxd85Pe2Mw/4xjZIKjWiuR2saHTONsuro0j4O62mUiE3yH
         2zlg==
X-Gm-Message-State: AOJu0Yz48bl3C8B0culDD3iqJMHUMdS+EPxSmBfvAJApaqmv3Uyq55n5
	fSnl2BOZEs5oNfK0LhKEKiE0PL8N7afoOYL1B7bZFWRQzGl0YunjgnIpr+9I7AmbXN/CDtt+xF8
	5IwR6mLy8ZWhrFvjg52FsK+C6Du8=
X-Gm-Gg: ASbGncs01mtPVSAfZGbUbmSzbPM5AxQARdrmdso67LphMHLpvdUnZfjFFJyPyjx+9+v
	98dYUu/Q9AFQ9MevKYdXQ03C0KrnPKS/TcIO3i7eVDaYgg0JoTrA=
X-Google-Smtp-Source: AGHT+IHj/62BMYkIgVRaz93McxZ59M/qHEEAKX+T9xDTcRjD+6EtSJzUAmuKClFVK3RHpFbHxAW80PDJV2pw1ISUMAU=
X-Received: by 2002:a05:6000:1542:b0:385:f470:c2e1 with SMTP id
 ffacd0b85a97d-3864ce4b014mr572733f8f.2.1733870540616; Tue, 10 Dec 2024
 14:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com> <c5e2138c-f1a8-4091-bd60-ac7f704c6d13@suse.cz>
In-Reply-To: <c5e2138c-f1a8-4091-bd60-ac7f704c6d13@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 14:42:09 -0800
Message-ID: <CAADnVQJ4814Bq3bZXdgqSQ9kuJ7EohxaBBdfs+YxsYUqmCQsBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 12/10/24 03:39, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Tracing BPF programs execute from tracepoints and kprobes where running
> > context is unknown, but they need to request additional memory.
> > The prior workarounds were using pre-allocated memory and BPF specific
> > freelists to satisfy such allocation requests. Instead, introduce
> > __GFP_TRYLOCK flag that makes page allocator accessible from any contex=
t.
> > It relies on percpu free list of pages that rmqueue_pcplist() should be
> > able to pop the page from. If it fails (due to IRQ re-entrancy or list
> > being empty) then try_alloc_pages() attempts to spin_trylock zone->lock
> > and refill percpu freelist as normal.
> > BPF program may execute with IRQs disabled and zone->lock is sleeping i=
n RT,
> > so trylock is the only option.
> > In theory we can introduce percpu reentrance counter and increment it
> > every time spin_lock_irqsave(&zone->lock, flags) is used,
> > but we cannot rely on it. Even if this cpu is not in page_alloc path
> > the spin_lock_irqsave() is not safe, since BPF prog might be called
> > from tracepoint where preemption is disabled. So trylock only.
> >
> > Note, free_page and memcg are not taught about __GFP_TRYLOCK yet.
> > The support comes in the next patches.
> >
> > This is a first step towards supporting BPF requirements in SLUB
> > and getting rid of bpf_mem_alloc.
> > That goal was discussed at LSFMM: https://lwn.net/Articles/974138/
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> I think there might be more non-try spin_locks reachable from page alloca=
tions:
>
> - in reserve_highatomic_pageblock() which I think is reachable unless thi=
s
> is limited to order-0

Good point. I missed this bit:
   if (order > 0)
     alloc_flags |=3D ALLOC_HIGHATOMIC;

In bpf use case it will be called with order =3D=3D 0 only,
but it's better to fool proof it.
I will switch to:
__GFP_NOMEMALLOC | __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO | __GFP_ACCOUN=
T


> - try_to_accept_memory_one()

when I studied the code it looked to me that there should be no
unaccepted_pages.
I think you're saying that there could be unaccepted memory
from the previous allocation and trylock attempt just got unlucky
to reach that path?
What do you think of the following:
-               cond_accept_memory(zone, order);
+               cond_accept_memory(zone, order, alloc_flags);

                /*
                 * Detect whether the number of free pages is below high
@@ -7024,7 +7024,8 @@ static inline bool has_unaccepted_memory(void)
        return static_branch_unlikely(&zones_with_unaccepted_pages);
 }

-static bool cond_accept_memory(struct zone *zone, unsigned int order)
+static bool cond_accept_memory(struct zone *zone, unsigned int order,
+                              unsigned int alloc_flags)
 {
        long to_accept;
        bool ret =3D false;
@@ -7032,6 +7033,9 @@ static bool cond_accept_memory(struct zone
*zone, unsigned int order)
        if (!has_unaccepted_memory())
                return false;

+       if (unlikely(alloc_flags & ALLOC_TRYLOCK))
+               return false;
+

or is there a better approach?

Reading from current->flags the way Matthew proposed?

> - as part of post_alloc_hook() in set_page_owner(), stack depot might do
> raw_spin_lock_irqsave(), is that one ok?

Well, I looked at the stack depot and was tempted to add trylock
handling there, but it looked to be a bit dodgy in general and
I figured it should be done separately from this set.
Like:
        if (unlikely(can_alloc && !READ_ONCE(new_pool))) {
                page =3D alloc_pages(gfp_nested_mask(alloc_flags),
followed by:
        if (in_nmi()) {
                /* We can never allocate in NMI context. */
                WARN_ON_ONCE(can_alloc);

that warn is too late. If we were in_nmi and called alloc_pages
the kernel might be misbehaving already.

>
> hope I didn't miss anything else especially in those other debugging hook=
s
> (KASAN etc)

I looked through them and could be missing something, of course.
kasan usage in alloc_page path seems fine.
But for slab I found kasan_quarantine logic which needs a special treatment=
.
Other slab debugging bits pose issues too.
The rough idea is to do kmalloc_nolock() / kfree_nolock() that
don't call into any pre/post hooks (including slab_free_hook,
slab_pre_alloc_hook).
kmalloc_nolock() will pretty much call __slab_alloc_node() directly
and do basic kasan poison stuff that needs no locks.

I will be going over all the paths again, of course.

Thanks for the reviews so far!


Return-Path: <bpf+bounces-57465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E550AAB8D0
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA4B1C236DA
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351A2C0861;
	Tue,  6 May 2025 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn4LPFD0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A8734B1C6
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746492602; cv=none; b=eNxBcvu9RFJyOsuHLCnLakPCHnc4soHjQNHT9r4ySeoO4zpOgX3AMA6vtY3WSLY9vB8/GAAR5PPE2WXWzVYB1yXNfWIaaozeCR4OCFcJwglmjJAtGUsoOBWlnWMDaF58P0kEwU57nw2GOlbfqsuKuoIOpQCwHD5q2bbTDClCCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746492602; c=relaxed/simple;
	bh=ROqN3bqj9DMJkHiAwBT1hk9SChj1QsDOOzZ1LMkNcss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LA5wsacWJhHip7n6A7Uql72NrJdVKpfLH/xIuP7Cf4dfqyAT4hSzwCD6xQPkCTUy5bKEUwAiUlZ5wmjeBnjG43QwNAU86V5eg3Xz8XxaZvQI1zzFAG6o11J8vrDH4e+B50u+6FmmrSXpdhsN079l5JLLbzNiJ6X2zEw0gL2+Z1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn4LPFD0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so5313755f8f.0
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 17:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746492598; x=1747097398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kYkFCBBmPy4T85wpFGmROsEJALC7bO/4xMlhN5NF/o=;
        b=Wn4LPFD0CgpVfoYedP8aljX//rpB9kuehV/hF0LYtijUNEP8PEZeyoIE2juGAr7VNK
         yTD57Wb06HYgS3tAq5FFCIm5CAd4RB/O/mIu4ycihGdCSaLq3eEw69o7riZcrjwpjzMF
         DCnkdw49GD/wuWvPNe31Y3kRhAp9QubvBFDyGkIJt5yBDPehjvMSmew88TsblcmpVQdw
         2fxrXCexAELFhxB7mS1zyw1usNpsH7Eb7z1swLDgClDt9Uk0I9Xfw7pKydr1o43Bzc9k
         OLWsBU4gQdMbwrz3mPAU6vNcBT1VHJirhGjCqBymigJUOxNJi9ODUq6Pl0gti4nyVpKk
         oDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746492598; x=1747097398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kYkFCBBmPy4T85wpFGmROsEJALC7bO/4xMlhN5NF/o=;
        b=Bc+h6q0raO39HEVKl7oOVyWRgK/TJGJe0kMEValOn6dxjZfHWntORoFFUY5/5unN/8
         uhbh8Y3+tbznpJSOk+Hzb7zUADoBHDZfrZ3DQ8Q2lOcVbq2vgVqoYQty/hTELbhT5bAw
         2d5eBN59Bb52GsfHJdvFqMZhzkGX/44DKIAGOgM9h2Zeba0JEVDK1RSSHX4oA2YFbI+d
         3kUIt/u5NzoTeHwCPNOwztCeHXnVTLVvMRSGpRvPlBI6Tte3w/dJQzsa5IkBG7sL/flP
         OPR3L3lJfe6Hqj3ZYuKmYVRc5CWuh1vJkdjJpQU5QQRlaKUcmAAsdiuKv4jnX/u+HswY
         9pJQ==
X-Gm-Message-State: AOJu0YwIF0AZPPPvDAShNa1By2y48Jt15UZzU5z5/ZmF4pjBwwOT/+6t
	boDLZUpLAj4h5tyrjGxa0oYUPH9uy00tu/p745ZVDLuLY1PZM2h/VKvslvSiFCngBlyH3tuwDt0
	Sez3mF0PVvrGKV1tDD8/Xfj9nA9A=
X-Gm-Gg: ASbGncu9RwXFyJ8H0l9KZ7QHsNGtJNQBcDQlRvp5GNcZu8wzeMbgf91OrS2ZbdA9RIL
	N4NtFbTUu8YexBNzjvCLnt5aDinM9RcUGHpnhwy6+g0CfrfnMT2FQX7RYOe87GV++hZ9JuteSvT
	fLJmMci5BxmJEl4EEfQotytEoFZ13nTcRh4Bp4z8rDBmhFag8IbdvkcQw5LHHO
X-Google-Smtp-Source: AGHT+IGtZ9BU5HYCpKD3bvs4zRGF35ibOXCV2qyV/g+kztcZM0YAg1VBYIQuGLc1PUJI/IOlo0HLJG/oqSWKY280NX8=
X-Received: by 2002:a05:6000:1449:b0:3a0:80bf:b4e3 with SMTP id
 ffacd0b85a97d-3a0ac3ec4d6mr622651f8f.58.1746492598119; Mon, 05 May 2025
 17:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com> <a74hjevi7tyq36vekcft7mlfdgwtcg6ddvr3bekb3amcf4fiuc@z7xszkyjcrbb>
In-Reply-To: <a74hjevi7tyq36vekcft7mlfdgwtcg6ddvr3bekb3amcf4fiuc@z7xszkyjcrbb>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 May 2025 17:49:47 -0700
X-Gm-Features: ATxdqUHN4s32Fei5KXYAx2bOJLl9c4dX97Sy3yVQojA0qLJvMHYB9wpx_n7B3WE
Message-ID: <CAADnVQ+OroM-auGvC7GPzaOUz90zHktF545BC7wRz5s_tW6z4w@mail.gmail.com>
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:46=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Apr 30, 2025 at 08:27:18PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -595,7 +595,13 @@ static inline void memcg_rstat_updated(struct mem_=
cgroup *memcg, int val)
> >       if (!val)
> >               return;
> >
> > -     cgroup_rstat_updated(memcg->css.cgroup, cpu);
> > +     /*
> > +      * If called from NMI via kmalloc_nolock -> memcg_slab_post_alloc=
_hook
> > +      * -> obj_cgroup_charge -> mod_memcg_state,
> > +      * then delay the update.
> > +      */
> > +     if (!in_nmi())
> > +             cgroup_rstat_updated(memcg->css.cgroup, cpu);
>
> I don't think we can just ignore cgroup_rstat_updated() for nmi as there
> is a chance (though very small) that we will loose these stats updates.

I'm failing to understand why it's an issue.
Not doing cgroup_rstat_updated() can only cause updated_next link
to stay NULL when it should be set,
but it should be harmless, and no different from racy check
that the code already doing:
if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
  return;

Imaging it was !NULL, the code would return,
but then preemption, something clears it to NULL,
and here we're skipping a set of updated_next.

> In addition, memcg_rstat_updated() itself is not reentrant safe along
> with couple of functions leading to it like __mod_memcg_lruvec_state().

Sure. __mod_memcg_lruvec_state() is not reentrant,
but it's not an issue for kmalloc_nolock(), since objcg/memcg
charge/uncharge from slub is not calling it (as far as I can tell).

>
> >       statc =3D this_cpu_ptr(memcg->vmstats_percpu);
> >       for (; statc; statc =3D statc->parent) {
> >               /*
> > @@ -2895,7 +2901,7 @@ static bool consume_obj_stock(struct obj_cgroup *=
objcg, unsigned int nr_bytes,
> >       unsigned long flags;
> >       bool ret =3D false;
> >
> > -     local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > +     local_lock_irqsave_check(&memcg_stock.stock_lock, flags);
> >
> >       stock =3D this_cpu_ptr(&memcg_stock);
> >       if (objcg =3D=3D READ_ONCE(stock->cached_objcg) && stock->nr_byte=
s >=3D nr_bytes) {
> > @@ -2995,7 +3001,7 @@ static void refill_obj_stock(struct obj_cgroup *o=
bjcg, unsigned int nr_bytes,
> >       unsigned long flags;
> >       unsigned int nr_pages =3D 0;
> >
> > -     local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > +     local_lock_irqsave_check(&memcg_stock.stock_lock, flags);
> >
> >       stock =3D this_cpu_ptr(&memcg_stock);
> >       if (READ_ONCE(stock->cached_objcg) !=3D objcg) { /* reset if nece=
ssary */
> > @@ -3088,6 +3094,27 @@ static inline size_t obj_full_size(struct kmem_c=
ache *s)
> >       return s->size + sizeof(struct obj_cgroup *);
> >  }
> >
> > +/*
> > + * Try subtract from nr_charged_bytes without making it negative
> > + */
> > +static bool obj_cgroup_charge_atomic(struct obj_cgroup *objcg, gfp_t f=
lags, size_t sz)
> > +{
> > +     size_t old =3D atomic_read(&objcg->nr_charged_bytes);
> > +     u32 nr_pages =3D sz >> PAGE_SHIFT;
> > +     u32 nr_bytes =3D sz & (PAGE_SIZE - 1);
> > +
> > +     if ((ssize_t)(old - sz) >=3D 0 &&
> > +         atomic_cmpxchg(&objcg->nr_charged_bytes, old, old - sz) =3D=
=3D old)
> > +             return true;
> > +
> > +     nr_pages++;
> > +     if (obj_cgroup_charge_pages(objcg, flags, nr_pages))
> > +             return false;
> > +
> > +     atomic_add(PAGE_SIZE - nr_bytes, &objcg->nr_charged_bytes);
> > +     return true;
> > +}
> > +
> >  bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lr=
u *lru,
> >                                 gfp_t flags, size_t size, void **p)
> >  {
> > @@ -3128,6 +3155,21 @@ bool __memcg_slab_post_alloc_hook(struct kmem_ca=
che *s, struct list_lru *lru,
> >                       return false;
> >       }
> >
> > +     if (!gfpflags_allow_spinning(flags)) {
> > +             if (local_lock_is_locked(&memcg_stock.stock_lock)) {
> > +                     /*
> > +                      * Cannot use
> > +                      * lockdep_assert_held(this_cpu_ptr(&memcg_stock.=
stock_lock));
> > +                      * since lockdep might not have been informed yet
> > +                      * of lock acquisition.
> > +                      */
> > +                     return obj_cgroup_charge_atomic(objcg, flags,
> > +                                                     size * obj_full_s=
ize(s));
>
> We can not just ignore the stat updates here.
>
> > +             } else {
> > +                     lockdep_assert_not_held(this_cpu_ptr(&memcg_stock=
.stock_lock));
> > +             }
> > +     }
> > +
> >       for (i =3D 0; i < size; i++) {
> >               slab =3D virt_to_slab(p[i]);
> >
> > @@ -3162,8 +3204,12 @@ bool __memcg_slab_post_alloc_hook(struct kmem_ca=
che *s, struct list_lru *lru,
> >  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> >                           void **p, int objects, struct slabobj_ext *ob=
j_exts)
> >  {
> > +     bool lock_held =3D local_lock_is_locked(&memcg_stock.stock_lock);
> >       size_t obj_size =3D obj_full_size(s);
> >
> > +     if (likely(!lock_held))
> > +             lockdep_assert_not_held(this_cpu_ptr(&memcg_stock.stock_l=
ock));
> > +
> >       for (int i =3D 0; i < objects; i++) {
> >               struct obj_cgroup *objcg;
> >               unsigned int off;
> > @@ -3174,8 +3220,12 @@ void __memcg_slab_free_hook(struct kmem_cache *s=
, struct slab *slab,
> >                       continue;
> >
> >               obj_exts[off].objcg =3D NULL;
> > -             refill_obj_stock(objcg, obj_size, true, -obj_size,
> > -                              slab_pgdat(slab), cache_vmstat_idx(s));
> > +             if (unlikely(lock_held)) {
> > +                     atomic_add(obj_size, &objcg->nr_charged_bytes);
>
> objcg->nr_charged_bytes is stats ignorant and the relevant stats need to
> be updated before putting stuff into it.

I'm not following.
It's functionally equivalent to refill_obj_stock() without
__account_obj_stock().
And the stats are not ignored.
The next __memcg_slab_free_hook() from good context will update
them. It's only a tiny delay in update.
I don't see why it's an issue.

> > +             } else {
> > +                     refill_obj_stock(objcg, obj_size, true, -obj_size=
,
> > +                                      slab_pgdat(slab), cache_vmstat_i=
dx(s));
> > +             }
> >               obj_cgroup_put(objcg);
> >       }
> >  }
>
> I am actually working on making this whole call chain (i.e.
> kmalloc/kmem_cache_alloc to memcg [un]charging) reentrant/nmi safe.

Thank you for working on it!
You mean this set:
https://lore.kernel.org/all/20250429061211.1295443-1-shakeel.butt@linux.dev=
/
?
it's making css_rstat_updated() re-entrant,
which is renamed/reworked version of memcg_rstat_updated().
That's good, but not enough from slub pov.
It removes the need for the first hunk in this patch from mm/memcontrol.c
+ if (!in_nmi())
+               cgroup_rstat_updated(...);

but hunks in __memcg_slab_post_alloc_hook() and __memcg_slab_free_hook()
are still needed.
And I think the obj_cgroup_charge_atomic() approach in this patch is correc=
t.
The delay in rstat update seems fine.
Please help me understand what I'm missing.


Return-Path: <bpf+bounces-61701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37063AEA7AE
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 22:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20C53A5E86
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 20:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CF02EF65B;
	Thu, 26 Jun 2025 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv6HrmOv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC82063F3
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968250; cv=none; b=N8GOSdDWr/hAE2AD7O0yvh8c0tjJcssl2E7tZr5sOmymGSjjpqjS/9DIL7SaBnHE4AgArnDnvvy3qGTxPc0xGwWafJ7LDtFX7rjqmQAjG6GRA/o+UiYRkUH0hRfnsXRnGrRsmKHtOWfXoh5nSgPkyfeCh27tJoH5glbQT/fbz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968250; c=relaxed/simple;
	bh=hhPgkMigG5Q72xiLy9vvN3QFPZsSY/kM8Ghs2rsMbUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1q0O5DsbHHZ9y0WM2JjEgs342HzfTSOj+vh0zv6R+6I2TCFrJyA8RLeSGvmQ1xjum6e1f8c1g0J/eVJjrwdcp0/bTpQuq7WITD8yQGW4ruD1ZHcnhaRP57e8dz34wvuMMuFc3EgWlrefaj86rPttTyBBqck49vQz8Hkx9qedqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv6HrmOv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a53359dea5so915046f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750968247; x=1751573047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQCbS/HjgZKKichcZaS63aazCIIPAdL8cR0fR9IrlVI=;
        b=lv6HrmOvasPzWtNhOuJ9uHH27dgODfAzikYivz/gdSTEG8HOSRzKVucDHuzfwtVuTi
         fC21SSSB5nD0rF71iAIC3Ipv134FMIWB3oZwEmuCiZO1sHlYLrmg0NbG8hDexMQsHm18
         9HEgAdB/T8UGy0JgCNRtmbD/nFzdygOzRw7rRe00BPaLcG9BxTQA42NXUupO3dAFr6Se
         w7K5ghaqeO5xX3xbVmWwobihxhFQeJk6W8tY/UwDKDTKR0pNvFiVDBPgUiBzZuBDbKMM
         /wexUWxgXo3RyTpKjal8/onF8zukbFK0lSfa8hevrVu/6Mtn3AM7UJDw6rp4D9vvIEvG
         z5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968247; x=1751573047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQCbS/HjgZKKichcZaS63aazCIIPAdL8cR0fR9IrlVI=;
        b=CNCqVSqxDUVkIoJVxEvxXMvavU5t35vy07CEZAoWL5MHgI9XcJ8AOUbu5v+Ic6M3dR
         /sAO8Lph5pR4vpkJJaPaPXKrFIa5dWaYqK0FW2bSuCp/UDRp0WNY1xzXVWNQ/1O7FTHh
         VL6BT9ulH/AVDmhzZm8RG4GjPf1P4Hz8k/dGn4HpWeDBXGiFzAL7NTJlodsrTGJQBogS
         NNhycKxN7qIRTuyaZASqnuVWRQlBH2ibpUaqNjwLsgYoMnpHUDwKLXFVYsgTEkWl3OXg
         CeGTxlnqblbkLt9Le7PoZqUGHRsd4k1PYnSnpPevJHCUsV/jSFmSJiMnMvzS0Q+tb5l9
         IBbQ==
X-Gm-Message-State: AOJu0YxsZDIUx3pB6SJ6P5WwYSZ1bTIUCdSAuDg5+3mn4nb4gNyJEq5/
	PZDPUAoxhFseWBsbiX0aKMmsLfVaicew8gaVgLKKVq5aMO+zv/4rzSYxR7XLlshGnHW1R7HUPqQ
	9dLbIfmf5E0tb/0ssSkK/IuwY7sxxwIY=
X-Gm-Gg: ASbGnctiNu4AD75MoLLYf9f8ddeOqfOGlrPoYDeV7BMT6lK39a2pyS0gwG+a+Ukg/mS
	5LXsAVqCuI3leWPmE4umWeH47hyqAqBnvh7D8/iFroxHi6vqjdkRz/PyiQpwdaI4FLGeP+MVc1c
	z+n7dDvfiJ1za+gV8FH1pk4yCBa5RYpOGiNu6kIInkxJvHO6F2ZEwK3KC0edaZYxONmPu6cAHQJ
	yUsLZJujTs=
X-Google-Smtp-Source: AGHT+IHNsEyH4zXsR8XhUHCuIlAny2GHVSvoSwZ3KwdYJ7vl4ofvMDE2bRkJ4IU245CbPVCBaieFZi5SqWppHKQ8a2U=
X-Received: by 2002:a05:6000:270e:b0:3a4:e609:dc63 with SMTP id
 ffacd0b85a97d-3a8fdb2a345mr531042f8f.20.1750968247103; Thu, 26 Jun 2025
 13:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com> <aB1UVkKSeJWEGECq@hyeyoo>
 <CAADnVQKQ-kqpO_vkyDcaUdvrvntWjwUfDy00SOawuRMrx0rfzw@mail.gmail.com> <aFvfr1KiNrLofavW@hyeyoo>
In-Reply-To: <aFvfr1KiNrLofavW@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Jun 2025 13:03:56 -0700
X-Gm-Features: Ac12FXzYRjgVGeObofZlNcvYhCYwFL26bL4avlqFpoSTBUZRSJ7eZFkwdTTjh9A
Message-ID: <CAADnVQJaOD7ovoZhA2=dcWiEXUYTtFeU=xW3PNz0e36E=YHb+A@mail.gmail.com>
Subject: Re: SLAB_NO_CMPXCHG was:: [PATCH 6/6] slab: Introduce
 kmalloc_nolock() and kfree_nolock().
To: Harry Yoo <harry.yoo@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 4:38=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Tue, Jun 24, 2025 at 10:13:49AM -0700, Alexei Starovoitov wrote:
> > On Thu, May 8, 2025 at 6:03=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com>=
 wrote:
> > > > +     s =3D kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
> > > > +
> > > > +     if (!(s->flags & __CMPXCHG_DOUBLE))
> > > > +             /*
> > > > +              * kmalloc_nolock() is not supported on architectures=
 that
> > > > +              * don't implement cmpxchg16b.
> > > > +              */
> > > > +             return NULL;
> > >
> > > Hmm when someone uses slab debugging flags (e.g., passing boot
> > > parameter slab_debug=3DFPZ as a hardening option on production [1], o=
r
> > > just for debugging), __CMPXCHG_DOUBLE is not set even when the arch
> > > supports it.
> > >
> > > Is it okay to fail all kmalloc_nolock() calls in such cases?
> >
> > I studied the code and the git history.
> > Looks like slub doesn't have to disable cmpxchg mode when slab_debug is=
 on.
>
> A slight correction; Debug caches do not use cmpxchg mode at all by
> design. If a future change enables cmpxchg mode for them, it will cause
> the same consistency issue.
>
> > The commit 41bec7c33f37 ("mm/slub: remove slab_lock() usage for debug
> > operations")
> > removed slab_lock from debug validation checks.
>
> An excellent point!
>
> Yes, SLUB does not maintain cpu slab and percpu partial slabs on
> debug caches.

Ohh. That was a crucial detail I was missing.
Now I see that 90% of ___slab_alloc() logic is not executed
for debug slabs :)

> Alloc/free is done under n->list_lock, so no need for
> cmpxchg double and slab_lock() at all :)
>
> > So right now slab_lock() only serializes slab->freelist/counter update.
> > It's still necessary on arch-s that don't have cmpxchg, but that's it.
> > Only __update_freelist_slow() is using it.
>
> Yes.
>
> > The comment next to SLAB_NO_CMPXCHG is obsolete as well.
> > It's been there since days that slab_lock() was taken during
> > consistency checks.
>
> Yes.
>
> > I think the following diff is appropriate:
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 044e43ee3373..9d615cfd1b6f 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -286,14 +286,6 @@ static inline bool
> > kmem_cache_has_cpu_partial(struct kmem_cache *s)
> >  #define DEBUG_DEFAULT_FLAGS (SLAB_CONSISTENCY_CHECKS | SLAB_RED_ZONE |=
 \
> >                                 SLAB_POISON | SLAB_STORE_USER)
> >
> > -/*
> > - * These debug flags cannot use CMPXCHG because there might be consist=
ency
> > - * issues when checking or reading debug information
> > - */
> > -#define SLAB_NO_CMPXCHG (SLAB_CONSISTENCY_CHECKS | SLAB_STORE_USER | \
> > -                               SLAB_TRACE)
> > -
> > -
> >
> >  /*
> >   * Debugging flags that require metadata to be stored in the slab.  Th=
ese get
> >   * disabled when slab_debug=3DO is used and a cache's min order increa=
ses with
> > @@ -6654,7 +6646,7 @@ int do_kmem_cache_create(struct kmem_cache *s,
> > const char *name,
> >         }
> >
> >  #ifdef system_has_freelist_aba
> > -       if (system_has_freelist_aba() && !(s->flags & SLAB_NO_CMPXCHG))=
 {
> > +       if (system_has_freelist_aba()) {
> >                 /* Enable fast mode */
> >                 s->flags |=3D __CMPXCHG_DOUBLE;
> >         }
> >
> > It survived my stress tests.
> > Thoughts?
>
> Perhaps it's better to change the condition in
> kmalloc_nolock_noprof() from;
>
>     if (!(s->flags & __CMPXCHG_DOUBLE))
>         return NULL;
>
> to;
>
>     if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>         return NULL;
>
> Because debug caches do not use cmpxchg double (and that's why
> it survived your test), it is not accurate to set __CMPXCHG_DOUBLE.
>
> And it'll get into trouble anyway if debug caches use cmpxchg double.

All makes sense. Tested this suggestion. Indeed behaves as
you described :) It's quite a relief, since I was also worried
that __CMPXCHG_DOUBLE limitation of kmalloc_nolock() might hurt
debug_slab cases.

Only slub_tiny case left to do before I can post v2.


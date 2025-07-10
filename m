Return-Path: <bpf+bounces-62978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86102B00C1A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 21:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DF65C491F
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D902F0C55;
	Thu, 10 Jul 2025 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUidWjpH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634882882DE
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175313; cv=none; b=LeKVUvpHfrvW1hTGsZ2+RgctXYc3PYQwYCaZaUr5urLoYd9JWgI8Wiv+48fIfnQgNL1hd3RkBGwbmpRFaTPn/YpQcb58Xxlys6CWNM6ZnmMqOecwAnGaNUrcI/evXtKR0F8XK85AnZ8xn20QvdrrtpZvax4x5EQtD9b7SA1FLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175313; c=relaxed/simple;
	bh=bQbqIVyKo54GQHp5JhwriCNzpr7sUHtbq/wIwT+8r4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRefFW3e5p52N/7kzAv7pb/gEooyzBABhsgeDlFenxSHg8upJ0/a709McinZRfy4o8YMatLI8vY6+HG9SqcoZBlHHLVEVBbPV4Xov0mauZRBtTm79cqXCkDA80cIL5c/Dy8WKG70xE3Bc/Nzc9tK3iCJvPBcpmQS5H17fEH5lts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUidWjpH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-453066fad06so8619185e9.2
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752175309; x=1752780109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUiBFyM0Yn00R3t8T16IwBYSTuDffC72F3UZOtwQCEE=;
        b=AUidWjpHEGDk8jUnEBR2E8Pb8Em9p7klm+6yNe8DoowsIVEWpqvfmb3zk2fbUoLb08
         w1EPQus4h0lkXLjhastE4lA3OpcfaWz1AtQsmXIr+H5P54czN9SHoLiLF+yeh9ouDRnj
         6HpySw8bLSmPlKuKNRPurGxsZVFEC89UDPvMOJckaLuuRuddfFRbSUfpyXAnPODet2h3
         g4DujP1ThS2yDkO7j/hgGjisZhYnPSM/vDH2WyjvFZ31Zzmj76aXb3EUp/TqT9vxPlEz
         w/kUqQabZyeixADlGpX0RFd5k4pEEJN+AIxJyyTcPTr/WCxZGjYFEHC8p0fR+9IOfLXS
         G+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752175309; x=1752780109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUiBFyM0Yn00R3t8T16IwBYSTuDffC72F3UZOtwQCEE=;
        b=Y4svAYAUPPkMCqgWQ42gDelVF3K5nkgIXHSFdBNzRo1mOBcaGf/jIIursZJynMovfp
         mVG370j/kVIa79BkdsxnLtWwbp52fr6UVWZwE0WA9OGRlb8BKt4t5S6vIkWRiuO/8UPg
         7A3LD0ZD83v85Z2LwPO2rX2eUja905MeggHToq0xZ3rpYsjplQHxdYG/1cOkYdOxLNom
         XbzrepoIpqOxWDWg6++2sVa8mCE4O9qhxFM/O5MNYFCCSTQEusPge7B+RM5tyW8iQv8p
         U0opaC/Sb1tF9vOevYF3kewRnx1DaKvi89gB2YKRxLJRE3kaCScZsmFc+f94HwmTFPbR
         syLw==
X-Gm-Message-State: AOJu0Ywp7jTjX8pYGfuXf+txIBzTKtiXno4u21tHZK27vapGpLPEYugo
	ZgGaWCEAKXecmrGBoLeHbD3OIFf22gM/vldl2hjZdab6u6/Eb2FFxHdoQHsxL/LHBjYsNcvAyEj
	j8Anw4kix7y1OLeYKduEdFf8+berN78Y=
X-Gm-Gg: ASbGncvO2KhHBS7Yn7enOdXt81a1Tc3RoH1XHwA2uTbM7nyneWGE3BsyGumj6gM78sc
	B+pUWDgsMXuWsjwIAzIW+Pg+qPErKnZicrZHFPrvFDl21jVTpJcRc8pOIc4T1cJP+LXbQHDmiBs
	VKwUZpHLJ2HASF4y+9BiMINK08gkbFNz7dTMR/E2th1dLIN4Z2lVliCSqntfZsCD2oK4mP/zyZ3
	dsr/CWsa80=
X-Google-Smtp-Source: AGHT+IE8J4fA8ruUMSURSR3iBDBJ6W96CyD0YH06p+VMUk8sYNYqP6QxPlwCGMKXkjHfQ0nc4Oo18etF+PbrbO1oViw=
X-Received: by 2002:a05:600c:3b82:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-454ec131ce1mr1027385e9.10.1752175309353; Thu, 10 Jul 2025
 12:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-7-alexei.starovoitov@gmail.com> <683189c3-934e-4398-b970-34584ac70a69@suse.cz>
In-Reply-To: <683189c3-934e-4398-b970-34584ac70a69@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Jul 2025 12:21:38 -0700
X-Gm-Features: Ac12FXxYKFCHpSKbbo5umlXWioHW1RzkGHfC30HxTA9RgRLit_mjyvQAYY3z4dY
Message-ID: <CAADnVQKGfRQV=93=NcKb--R_40kWwmn-u75BRmOX6bEiMVAx5A@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 2:36=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> > +     if (unlikely(!allow_spin)) {
> > +             folio =3D (struct folio *)alloc_frozen_pages_nolock(0/* _=
_GFP_COMP is implied */,
> > +                                                               node, o=
rder);
> > +     } else if (node =3D=3D NUMA_NO_NODE)
> >               folio =3D (struct folio *)alloc_frozen_pages(flags, order=
);
> >       else
> >               folio =3D (struct folio *)__alloc_frozen_pages(flags, ord=
er, node, NULL);
>
> Nit: should use { } either for everything or nothing (seems your new bran=
ch
> would work without them)

leftover from v1. will fix.

> >                       stat(s, ALLOC_NODE_MISMATCH);
> > @@ -3730,7 +3762,7 @@ static void *___slab_alloc(struct kmem_cache *s, =
gfp_t gfpflags, int node,
> >        * PFMEMALLOC but right now, we are losing the pfmemalloc
> >        * information when the page leaves the per-cpu allocator
> >        */
> > -     if (unlikely(!pfmemalloc_match(slab, gfpflags)))
> > +     if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin))
> >               goto deactivate_slab;
> >
> >       /* must check again c->slab in case we got preempted and it chang=
ed */
> > @@ -3803,7 +3835,12 @@ static void *___slab_alloc(struct kmem_cache *s,=
 gfp_t gfpflags, int node,
> >               slub_set_percpu_partial(c, slab);
> >
> >               if (likely(node_match(slab, node) &&
> > -                        pfmemalloc_match(slab, gfpflags))) {
> > +                        pfmemalloc_match(slab, gfpflags)) ||
> > +                 /*
> > +                  * Reentrant slub cannot take locks necessary
> > +                  * for __put_partials(), hence downgrade to any node
> > +                  */
> > +                 !allow_spin) {
>
> Uh this seems rather ugly, I'd move the comment above everything. Also it=
's
> not "downgrade" as when you assign NUMA_NO_NODE earlier, I'd say "ignore =
the
> preference".
> Note that it would be bad to ignore with __GFP_THISNODE but then it's not
> allowed for kmalloc_nolock() so that's fine.

Yes. All correct. Will reword.

> > @@ -3911,6 +3953,12 @@ static void *___slab_alloc(struct kmem_cache *s,=
 gfp_t gfpflags, int node,
> >               void *flush_freelist =3D c->freelist;
> >               struct slab *flush_slab =3D c->slab;
> >
> > +             if (unlikely(!allow_spin))
> > +                     /*
> > +                      * Reentrant slub cannot take locks
> > +                      * necessary for deactivate_slab()
> > +                      */
> > +                     return NULL;
>
> Hm but this is leaking the slab we allocated and have in the "slab"
> variable, we need to free it back in that case.
>
> >               c->slab =3D NULL;
> >               c->freelist =3D NULL;
> >               c->tid =3D next_tid(c->tid);
>
> > @@ -4593,10 +4792,31 @@ static __always_inline void do_slab_free(struct=
 kmem_cache *s,
> >       barrier();
> >
> >       if (unlikely(slab !=3D c->slab)) {
> > -             __slab_free(s, slab, head, tail, cnt, addr);
> > +             /* cnt =3D=3D 0 signals that it's called from kfree_noloc=
k() */
> > +             if (unlikely(!cnt)) {
> > +                     /*
> > +                      * __slab_free() can locklessly cmpxchg16 into a =
slab,
> > +                      * but then it might need to take spin_lock or lo=
cal_lock
> > +                      * in put_cpu_partial() for further processing.
> > +                      * Avoid the complexity and simply add to a defer=
red list.
> > +                      */
> > +                     defer_free(head);
> > +             } else {
> > +                     __slab_free(s, slab, head, tail, cnt, addr);
> > +             }
> >               return;
> >       }
> >
> > +     if (unlikely(!cnt)) {
> > +             if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
> > +                 local_lock_is_locked(&s->cpu_slab->lock)) {
> > +                     defer_free(head);
> > +                     return;
> > +             }
> > +             cnt =3D 1;
>
> Hmm we might end up doing a "goto redo" later and then do the wrong thing=
 above?

Great catch. Will fix. That's two serious bugs.
That's my penalty for reviewing other people code 99% of the time
and little time to code myself.


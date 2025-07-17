Return-Path: <bpf+bounces-63556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6742FB08370
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 05:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC747B5D23
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D981D5CFE;
	Thu, 17 Jul 2025 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlVcP/9P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AA383
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 03:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752723142; cv=none; b=Kepv2ohHt+spAtFNZOd6cCkxmGZu7cLjR5AZn31k3e/S4XjGWHJmDRHmxyKqhxtBZX4UlKu6On4pvrRjI4FqtDDI1CzbYv2z+az9lHnAUClBu+XO0fFq3NGdlAgicYO6btSOyr82YLKka5ysx3kozocoOHK9XbLGa7WZoOxnUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752723142; c=relaxed/simple;
	bh=doTfp4HJRTb8FUSk6ed3fQT6CkY0+pnUGj+ZVdo3h00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hirhJZpkSgN7sjreeYzueO/oRm+WZH3gtx8FWNR/v1I1b9H50n2pXAAMpAtZ16+gSiiHF/p2NSeSK5lV5YmUGSuso642tKqDHepBCLP3g9lsYufHn4oQ31ZquUBD8J+oResMsuEE6Bn/zK+zMVUX4c416b4zlNBI9cT84eUaC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlVcP/9P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45622a1829eso1314465e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 20:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752723138; x=1753327938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALXWQ2fb8wYyWYYm6SUMuBZcHfhUAJGMpunbcmlC6NE=;
        b=VlVcP/9P0UqfGRkr7rZdbLZoW5J0SF9L3Ti8qBvq13uHz5r5tI1ymZ6iRT3nd2ph/k
         oHMRSrVXCsd5Pmf08vlv89qfpzKq5rNgW3tSa4irGE9Z6bxyVlSeKfcwI8snd41umOVY
         ZTJpqU8w3s8uPKzhipTNh4j8yaqlCiYZeAo5B5mgGFVdwOXIRZemyluOJ50skUMpYgwY
         7atZ+M9TU7xPX6er1cu4SvPubCp3VxgFakAojjM+XJ75GlTkfkA9EMdonfKHi4Ab/X2T
         1GKTUvlxr8hWEFDj8A8paETL/+YV2UmvAHvDUIfn3JQFYeXgxB7/anm0po/4nHVQrBHu
         FceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752723138; x=1753327938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALXWQ2fb8wYyWYYm6SUMuBZcHfhUAJGMpunbcmlC6NE=;
        b=g4F5VWGNrRlONcIqYf+epixcflMSD7D6pGEQa5jWVhL6fQi+OtnW017dLAbPd/ZZqP
         YRBfOjLb2+bzEwFMoUZtl5mtXvjEKfzC/wsmXVe+Z0f8Q5UOHCPjBuQfDQqWc0s07R74
         pPGWtO2K40LrFHkb/c/903bvVpensIT39lJRz1crG8v0hyIUOQth6JUsuiZKtD36lyPF
         kwxHVa0Gdi97Jq6lAjYqiyVFxajs82PQMJNfzQ3ekggjGjR+h3OPMGxXukC1mwvgiJ1b
         7MGhrlHpOI997ih7g/B74AInYMU0D7uucyfEs9r9gOaqo+btHAKwpFvTIHNmTRHiNM4/
         U9Fw==
X-Gm-Message-State: AOJu0YzehEplEtCVPDrT/eSFXsjK5x2ksRMgZDSJ5jrHE/JEjUqTCLdM
	39KERGK6hNbMgVdTXze1T5uhHUHrQVcAa77lGqEebCrFyYjbOWQZPvMlHhF848COWuHaUaIXDag
	MtTCAhZCRzUjKnCjnJn5WL/hljSVTzEo=
X-Gm-Gg: ASbGnct3d2psNB9VBiVCdA28BgAnnArrlKNScAmptaw4CypmH3EZE77nAq3auDbIyHj
	Im121BYmPLYn8qFlNuw84yiM5F6h4iIpVqY1zu3dY45UEtThJ6S0+8hClR4QIYraKHUPq+1k0a+
	ipLiLNfiEPtgkhQqFh/c1uQC1WgrX+kFNYv4YhHgWVTqMfILPWYIf1z4DkSGvZzl9IxgNof8YLP
	K55423Ng5K6q1/Y/WQzhuL5MBx4cy9n3tLt
X-Google-Smtp-Source: AGHT+IHHbwzegNRrMGleXtzaCJc5bmREIP4rsBChMliIwYO0/KXfSZvif+U/kAjHKVH66r3+hL/jJAmkkVvV1p0Y3xA=
X-Received: by 2002:a05:600c:19d4:b0:456:237b:5e4e with SMTP id
 5b1f17b1804b1-4562e2aa1eamr44363395e9.32.1752723138177; Wed, 16 Jul 2025
 20:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
 <20250716022950.69330-7-alexei.starovoitov@gmail.com> <7173c09b-99fa-4e16-a764-b9ddfa7909ce@suse.cz>
In-Reply-To: <7173c09b-99fa-4e16-a764-b9ddfa7909ce@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Jul 2025 20:32:06 -0700
X-Gm-Features: Ac12FXy1n3F0bXBVzhjZco6DV9ntN-DghynUZhzi6NebtapC1Isi__SnkU5TEkg
Message-ID: <CAADnVQ+HoTbEdE1h+GubW_9++avZKGXLpifCK89nBh9cvDNRMQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] slab: Make slub local_trylock_t more precise for LOCKDEP
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/16/25 04:29, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Since kmalloc_nolock() can be called from any context
> > the ___slab_alloc() can acquire local_trylock_t (which is rt_spin_lock
> > in PREEMPT_RT) and attempt to acquire a different local_trylock_t
> > while in the same task context.
> >
> > The calling sequence might look like:
> > kmalloc() -> tracepoint -> bpf -> kmalloc_nolock()
> >
> > or more precisely:
> > __lock_acquire+0x12ad/0x2590
> > lock_acquire+0x133/0x2d0
> > rt_spin_lock+0x6f/0x250
> > ___slab_alloc+0xb7/0xec0
> > kmalloc_nolock_noprof+0x15a/0x430
> > my_debug_callback+0x20e/0x390 [testmod]
> > ___slab_alloc+0x256/0xec0
> > __kmalloc_cache_noprof+0xd6/0x3b0
> >
> > Make LOCKDEP understand that local_trylock_t-s protect
> > different kmem_caches. In order to do that add lock_class_key
> > for each kmem_cache and use that key in local_trylock_t.
> >
> > This stack trace is possible on both PREEMPT_RT and !PREEMPT_RT,
> > but teach lockdep about it only for PREEMP_RT, since
> > in !PREEMPT_RT the code is using local_trylock_irqsave() only.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Should we switch the order of patches 5 and 6 or is it sufficient there a=
re
> no callers of kmalloc_nolock() yet?

I can switch the order. I don't think it makes much difference.

> > ---
> >  mm/slab.h |  1 +
> >  mm/slub.c | 17 +++++++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 65f4616b41de..165737accb20 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -262,6 +262,7 @@ struct kmem_cache_order_objects {
> >  struct kmem_cache {
> >  #ifndef CONFIG_SLUB_TINY
> >       struct kmem_cache_cpu __percpu *cpu_slab;
> > +     struct lock_class_key lock_key;
>
> I see " * The class key takes no space if lockdep is disabled:", ok good.

yes.
I was considering guarding it with
#ifdef CONFIG_PREEMPT_RT
but then all accesses to ->lock_key would need to be wrapped
with #ifdef as well. So init_kmem_cache_cpus() will have
three #ifdef-s instead of one.
Hence the above lock_key; is unconditional,
though it's a bit odd that it's completely unused on !RT
(only the compiler touches it).

> >  #endif
> >       /* Used for retrieving partial slabs, etc. */
> >       slab_flags_t flags;
> > diff --git a/mm/slub.c b/mm/slub.c
> > index c92703d367d7..526296778247 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3089,12 +3089,26 @@ static inline void note_cmpxchg_failure(const c=
har *n,
> >
> >  static void init_kmem_cache_cpus(struct kmem_cache *s)
> >  {
> > +#ifdef CONFIG_PREEMPT_RT
> > +     /* Register lockdep key for non-boot kmem caches */
> > +     bool finegrain_lockdep =3D !init_section_contains(s, 1);
>
> I guess it's to avoid the "if (WARN_ON_ONCE(static_obj(key)))"
> if it means the two bootstrap caches get a different class just by being
> static, then I guess it works.

Yes. Not pretty. The alternative is to pass a flag
through a bunch of functions all the way from kmem_cache_init.
Another alternative is to
bool finegrain_lockdep =3D s !=3D boot_kmem_cache_node && s !=3D boot_kmem_=
cache.
Both are imo uglier.
init_section_contains() is more precise and matches static_obj().

Checking for SLAB_NO_OBJ_EXT isn't an option. Since it's conditional.


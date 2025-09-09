Return-Path: <bpf+bounces-67817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A75B49DDC
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 02:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D24144175D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882FC168BD;
	Tue,  9 Sep 2025 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdY+RoND"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE394A3E
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376538; cv=none; b=B62PVOicBtTPZpQ5ddVee+k+1T5tmGlKah1HsCIyVzOdvYcLoB47YckkFVPNjgV7gyHxjWYM8Ic1XPuwus/TTToi67yfcHP7EUEyTu3L4lItJGacf74SFvDCJN7mF8rgbHDYqzuhxtkqsB7OAnP3g3bz+kd4qG7PEBy9UiQeP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376538; c=relaxed/simple;
	bh=frHQ1yx6syGxDGyV7V4DGIC7aCTLy5qRYcOKvyXbmxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEr+qngjxWTfP89MZpmO0D7xNSq43+ubRJmLpf1N4LWsBsHgOprjFjYoTY+DFJ+OHKxcVLHxJQo+lX6/Sx1nMTZMm9g5vRWznWNZx0zS8D3F2PbdIR0B6KqaWQ9k4yGJUKakQLZua7BHf9s6hdJ0qT3oz04XocJUHYIBVLB6H/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdY+RoND; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so19106235e9.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 17:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757376535; x=1757981335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp4mwjrOklNOXxTbWmC667rfKJrZM5GjA02GKAs4tfE=;
        b=RdY+RoNDBch5aoSxFZAlBj+n5hZ4A+bamplr5Oizy5bMmpeMhKCMWsAx8wlPMA10tI
         j8TNf6cPfEHaP7wny+K3gi2LdvzNDeUdiF1PjPeDCFdrMpAS8eIiCOO2R+6C0sAXhuso
         UkQU8QGnDb6AvNq/f1zZn5wk5zGZ/5/cyTKLt5D3+lMECPxE/g8otXr8j9W0rf+/t4p3
         q9/jbnQ1p4Jw1/NoZBFnB4WovVuueFRcu4z5vya80+yZz6gMSsZMsfobDjHJKLMxKKD+
         zscdUvdrOa8uIO1tpH6TZhsm4yhLEx3X494EsC8+tQu+QSyzHoTooappnJAsjimVhR5S
         pGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757376535; x=1757981335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp4mwjrOklNOXxTbWmC667rfKJrZM5GjA02GKAs4tfE=;
        b=dHvaQ/Nicqlp5k+I4K+g/ZrSoHfUSpKk/IHC1Bhf16oEnsbiMNmvqHRlIGg25gwndP
         QCzjMG5NHZkyEZrMJssJnwuOFxCaZ+5+tVuXjKWxtLTsJ4/lmeYJRGtt1BYnt4HlUy9m
         xLvSOonrqTPWHmXdJBnQNsVpOkYoC8YdzulPw34bM3IFJoO59S/QDdRjb5WMPsKkEqpu
         4ZNVoAuHaqYV/sQS8M8YWwZdyW5z1H+GSS68Zz1K4V5xwyq3V4tfoP7gFqjXgNXLRiN+
         ZYkLQCICQ0RPPT6OAlW7J/4v6f7bWqIABMJaUcPbqkrUAxW2fpbD+AHaN7PUuM6gQVKq
         davA==
X-Gm-Message-State: AOJu0YxLfOLJw1CvISiejpZyVO9eZGLJRvcESgVCPmkou0zR4U4dj9gm
	n4pXLtZk+HbX5snhUZiVk0fJCSOlySsF6Lv4zRqopRZ3/dJHAJ0JA7NKwZ9NL9k2SacQmvuF8cx
	SKJVScuG9Fw/OULPCfvTfiXT+aq0SuO0=
X-Gm-Gg: ASbGnctolBBiWXJn5jTDbMNMLvLkk3lewzucdXPrPbVktWzCzIwpdlepp0DmYnHYkP+
	vTCgZqnqwLYrJ8JM+BbZTLgeSNDxfjO74BXKiMJcZU+W6dJht4YyN7ORph1BznU50Y31Fg2FvrW
	jA1nOnUoJyOqdWaK41hJSZClEJ2pJ5/jP3smMhopuqVV4JR96weGDlBMZyEzRsbq0NgD7q+63JL
	ynTtjF+qGGkaEbteVu5WdW4DOxiA4zxt0W+
X-Google-Smtp-Source: AGHT+IHxcybvED+0BOKpyGhQK1ngiooddpmdIAtYBYZ4h7rBKcRvSR3lUyUjbfCnGSsSCqWOtR69wvcRqmSlMZdACho=
X-Received: by 2002:a05:600c:310e:b0:45d:98be:ee8f with SMTP id
 5b1f17b1804b1-45de1ad26aemr73438205e9.26.1757376534649; Mon, 08 Sep 2025
 17:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
 <20250718021646.73353-7-alexei.starovoitov@gmail.com> <aH-ztTONTcgjU7xl@hyeyoo>
 <CAADnVQLrTJ7hu0Au-XzBu9=GUKHeobnvULsjZtYO3JHHd75MTA@mail.gmail.com>
 <aJtZrgcylnWgfR9r@hyeyoo> <aJt1FHnavjRv5CzI@hyeyoo>
In-Reply-To: <aJt1FHnavjRv5CzI@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 17:08:43 -0700
X-Gm-Features: AS18NWAcrURD6cSs8YFhK6At7ukKcp3fduqIT5t_3BqXOqyQ9qXPkH9La4LpcMU
Message-ID: <CAADnVQ+aLojadnDgnOwJCTAE319can=rW7ELh2Xy5M-d2TWcHQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Harry Yoo <harry.yoo@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:08=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>

Sorry for the delay. I addressed all other comments
and will respin soon.
Only below question remains..

> > > > >  {
> > > > > @@ -3732,9 +3808,13 @@ static void *___slab_alloc(struct kmem_cac=
he *s, gfp_t gfpflags, int node,
> > > > >       if (unlikely(!node_match(slab, node))) {
> > > > >               /*
> > > > >                * same as above but node_match() being false alrea=
dy
> > > > > -              * implies node !=3D NUMA_NO_NODE
> > > > > +              * implies node !=3D NUMA_NO_NODE.
> > > > > +              * Reentrant slub cannot take locks necessary to
> > > > > +              * deactivate_slab, hence ignore node preference.
> > > >
> > > > Now that we have defer_deactivate_slab(), we need to either update =
the
> > > > code or comment?
> > > >
> > > > 1. Deactivate slabs when node / pfmemalloc mismatches
> > > > or 2. Update comments to explain why it's still undesirable
> > >
> > > Well, defer_deactivate_slab() is a heavy hammer.
> > > In !SLUB_TINY it pretty much never happens.
> > >
> > > This bit:
> > >
> > > retry_load_slab:
> > >
> > >         local_lock_cpu_slab(s, flags);
> > >         if (unlikely(c->slab)) {
> > >
> > > is very rare. I couldn't trigger it at all in my stress test.
> > >
> > > But in this hunk the node mismatch is not rare, so ignoring node pref=
erence
> > > for kmalloc_nolock() is a much better trade off.
>
> But users would have requested that specific node instead of
> NUMA_NO_NODE because (at least) they think it's worth it.
> (e.g., allocating kernel data structures tied to specified node)
>
> I don't understand why kmalloc()/kmem_cache_alloc() try harder
> (by deactivating cpu slab) to respect the node parameter,
> but kmalloc_nolock() does not.

Because kmalloc_nolock() tries to be as least intrusive as possible
to kmalloc slabs that the rest of the kernel is using.
There won't be kmem_cache_alloc _nolock() version, because
the algorithm retries from a different bucket when the primary one
is locked. So it's only kmalloc_nolock() flavor and it takes
from generic kmalloc slab buckets with or without memcg.
My understanding that c->slab is effectively a cache and in the long
run all c->slab-s should be stable. A given cpu should be kmalloc-ing
the memory suitable for this local cpu.
In that sense deactivate_slab is a heavy hammer. kmalloc_nolock()
is for users who cannot control their running context. imo such
users shouldn't affect the cache property of c->slab hence ignoring
node preference for !allow_spin is not great, but imo it's a better
trade off than defer_deactivate_slab.
defer_deactivate_slab() is there for a rare race in retry_load_slab.
It can be done for !node_match(c->slab, node) too,
but it feels like a worse-r evil. Especially since kmalloc_nolock()
doesn't support __GFP_THISNODE.


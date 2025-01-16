Return-Path: <bpf+bounces-49021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C991A13185
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 03:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02FC3A11CB
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 02:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB378F3E;
	Thu, 16 Jan 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqFbtNmT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D8136672
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736995513; cv=none; b=ji++nMEKiDPUO8W6rawh6f867GRRvys4c9+P0/6Nw6GKze3lDuoLyeu3UJqgZuyyIfiPAEoqPZJN/o9ApN7wWVyfizs1obc9PP4uQQzZh8pEsAq5iIJKv+etFdyK1cSfyNsYBQZFbViVHoLgI2NOqKOFqQxpxpo7wTc/zGJC1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736995513; c=relaxed/simple;
	bh=EdoaE+Zqr9/WMgxcpIm/C+wXk7OZbP/FmyGkfVtvk0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMINBV+bMJC69cVa1zIu3Wblm6bIqx1OS+9c9O04LAbEDy9gB/NSdJ5W53YH5Pp2fXN+ZK5Lf+OGCbPHRz/j99pHf/tMSQfMY/xwiQe2znJ+p6mWuUAwK1/R04S8ZALvnveZZgdK0sUKBie+LiLUPN82sjiTjqJkRFzFJlH8p4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqFbtNmT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862d6d5765so220034f8f.3
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 18:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736995509; x=1737600309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUUyrqUxzYlS5Wo3hrGvUlpzZSewOKz5LWx+ks3q5Y8=;
        b=aqFbtNmTk7pGaomjXIXpkv11F2BC/9B9AAT1dT06FkUPypKU+cnEEX/lk9hLkLPzIa
         k099RPX7Uh1SPJGGBE6qqo6WbJ22FIHZkkLwTp/j2iLBeJsarfL2SzQDSVyLBGLwzhQb
         8KSvU0sgm6fQ1dP9Qfkb7K+fzGecntmRByqXrfVPmWzUVUZm0lP/wR9Aw7i21ThA/gQh
         ocV18/YpHxNx5r3BruvZ46jTy6mjepJApwJWmrJA4i/O+lK9AiUVvCShJ8mpiRvUt8T8
         4n3VW4B7V5XWLJq0XK230g3cHbO5o6Hsim+CvkA0rvIFRXZLVuRlRFyK4GpAc5ai1xn6
         nUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736995509; x=1737600309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUUyrqUxzYlS5Wo3hrGvUlpzZSewOKz5LWx+ks3q5Y8=;
        b=bpWyXUv2aALcgP0HsZmi64Ze6vyqMrN9c468QO86o1D1ye4zAX6O1quDFcU8k+pzWv
         idpIiy6c0jPszhJc4N2W68YheZvhREYBvjv1oPRQwvL9u1wrX6BNopRnUvx3r4hH69Uh
         jS4bLybDadvzrhXMEms6bQp7iUvAhQtbjkMiP2JHoOqo56OdYxm29jmHPfzT0lGUGkaj
         IU5zfIUMngLs84NdQ8AYOKinKvqGSxsp679jZ3ekXyCLHQqqLrkLXEiJRH6r3qMsXuQu
         a4jZgX+4qa8zFw+0Dc/Qr9EGQAEATP8gkBkth2M3WBMFn4/+y0Zz5VVmegzICfJ1DHlR
         wDSA==
X-Forwarded-Encrypted: i=1; AJvYcCXFTEQnWcsP8I1MbaJJL9y8fbInNBw+pTje1GccaoTSfgCdGjlrthiiUpaagcFMH0lHHXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweB/XpMiIYq3DsoEG68Fg3NzvGEZUg84edMYroxLKs3kZpK8I/
	tx9NLquP3ay5a8rAXy6NuntfoveG24OVKeAPEv6C/zBP6h8BasprsLVY6rqBWAYIF+wXMMagMW9
	Cesz5Smoz9m8iEyzdwWYzeg0w0Io=
X-Gm-Gg: ASbGncuKLfmvz1SIAM/ViF5QculH1JZcUNGQn/RPPqHGnDrNaJoKCc05VHnL42eTXFx
	WkmtXoTaBwxfCO5dUdoOCO+yxHIWqsNgRh3s+wv8+NwnpvK6Ww2rCtw==
X-Google-Smtp-Source: AGHT+IHnw+CRA39JAHy5NAOmwN2RTgLmf6uco3ZjOjO86oSkjt79ZCqv0L7sFDm55OIKY4IKnUDiZhFViEnIREMORHQ=
X-Received: by 2002:a5d:6da1:0:b0:385:eecb:6f02 with SMTP id
 ffacd0b85a97d-38a872ebe97mr27508287f8f.28.1736995509261; Wed, 15 Jan 2025
 18:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-2-alexei.starovoitov@gmail.com> <9fb94763-69b2-45bd-bc54-aef82037a68c@suse.cz>
 <CAADnVQ+TecNdNir8QK_3cOKf4WhYj9+j5oZKdzWUoE6H5PuetQ@mail.gmail.com> <ntbykvhaw7ohuu5nb7x4g4kqrlqkxfzb5ydjxpxszayfvewkrn@lvx22b7p7it5>
In-Reply-To: <ntbykvhaw7ohuu5nb7x4g4kqrlqkxfzb5ydjxpxszayfvewkrn@lvx22b7p7it5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Jan 2025 18:44:56 -0800
X-Gm-Features: AbW1kvZYd19foovg0gB4qxvYaJMO27oXbcme34UNsIKlUE206yTCEH09JZOnY-g
Message-ID: <CAADnVQ+5=6bbq-1o1hGVX6UCHOS1fG6Hh5--C69i_Zivc8hCrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/7] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, 
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 3:47=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Jan 15, 2025 at 03:00:08PM -0800, Alexei Starovoitov wrote:
> > On Wed, Jan 15, 2025 at 3:19=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > >
> > >
>
> Sorry missed your response here.
>
> > > What about set_page_owner() from post_alloc_hook() and it's stackdepo=
t
> > > saving. I guess not an issue until try_alloc_pages() gets used later,=
 so
> > > just a mental note that it has to be resolved before. Or is it actual=
ly safe?
> >
> > set_page_owner() should be fine.
> > save_stack() has in_page_owner recursion protection mechanism.
> >
> > stack_depot_save_flags() may be problematic if there is another
> > path to it.
> > I guess I can do:
> >
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index 245d5b416699..61772bc4b811 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -630,7 +630,7 @@ depot_stack_handle_t
> > stack_depot_save_flags(unsigned long *entries,
> >                         prealloc =3D page_address(page);
> >         }
>
> There is alloc_pages(gfp_nested_mask(alloc_flags)...) just couple of
> lines above. How about setting can_alloc false along with the below
> change for this case?

argh. Just noticed this code path:
free_pages_prepare
  __reset_page_owner
    save_stack(GFP_NOWAIT | __GFP_NOWARN);
       stack_depot_save(entries, nr_entries, flags);
          stack_depot_save_flags(entries, nr_entries, alloc_flags,
                                      STACK_DEPOT_FLAG_CAN_ALLOC);

bool can_alloc =3D depot_flags & STACK_DEPOT_FLAG_CAN_ALLOC;

if (unlikely(can_alloc && !READ_ONCE(new_pool))) {
         page =3D alloc_pages(gfp_nested_mask(alloc_flags),
                                 DEPOT_POOL_ORDER);

> Or we can set ALLOC_TRYLOCK in core alloc_pages()
> for !gfpflags_allow_spinning().

so gfpflags_allow_spinning() approach doesn't work out of the door,
since free_pages don't have gfp flags.
Passing FPI flags everywhere is too much churn.

I guess using the same gfp flags as try_alloc_pages()
in __reset_page_owner() should work.
That will make gfpflags_allow_spinning()=3D=3Dtrue in stack_depot.

In an earlier email I convinced myself that
current->in_page_owner recursion protection in save_stack()
is enough, but looks like it's not.
We could be hitting tracepoint somewhere inside alloc_pages() then
alloc_pages -> tracepoint -> bpf
-> free_pages_nolock -> __free_unref_page -> free_pages_prepare
-> save_stack(GFP_NOWAIT | __GFP_NOWARN);

and this save_stack will be called for the first time.
It's not recursing into itself. Then:

-> stack_depot_save_flags -> alloc_pages(GFP_NOWAIT) -> boom.

So looks like __reset_page_owner() has to use
!gfpflags_allow_spinning() flags and
stack_depot_save_flags() has
to do:
if (!gfpflags_allow_spinning(alloc_flags))
   can_alloc =3D false;
   raw_spin_trylock_irqsave(&pool_lock, ..)

Will code this up. Unless there are better ideas.


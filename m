Return-Path: <bpf+bounces-47291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CD09F71A2
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 02:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDBB169326
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 01:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812653594B;
	Thu, 19 Dec 2024 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJVSSEyS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590A1E4BE
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571146; cv=none; b=UiSe4DqZX9rALTrYa7mbL0NBXx9rs/bVvzypqQCM5SffNPw4UUrUJaSv6313z8iahF5kTVIwSQjlEIrS0H/EABMwpIB4vf+F63N+3ELcGMkldTVGRc5TqS6UOWBbBcbbLsy1YLnOts471eSN02B61whF25AahYOqSssWZqC7OwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571146; c=relaxed/simple;
	bh=uAz5FHm8yiuEro0+/cev5Khp68g61wg7IcbKZhsC6ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rzap9mRAj1j6MX/MvrbUNH0cxrLYsQQHF91sZQpZHOqifPrPkpxqP/jy4z7IZpIJQDJHM2E+fB+C/7A2thKK8Fq1qz/JRSr15yeljTVnhQaVZbrNk7uFetPN6c4WpI6e9u5bR/5OrKQXxez6iYZntTRLFoZMdpvMPuUsNafZWr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJVSSEyS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f664af5so2835345e9.1
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 17:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734571143; x=1735175943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xswLO3aU6iIX4PogxhwW2hgaGIB3kpLUE2ybR+JJZcs=;
        b=FJVSSEySG+dXbPVZip/rgWy5XmwglLUqLacRVuj6HVONMpQr2FgnyeUhFj/ZKv4uhs
         yF6NHQJU+lWTVraXEu9sEEuy4hmWVDYatXR06/OR/3EqJ5PpNtIbQTlthBgUBQ15dZQ4
         M/4Z1ETDpim0dqxDtR/9Abrnxo2TvWa9nHWuZov+7I4B8tkMZYlPs+3BY3mAGJ8mYS64
         hLjNE2oAFGfZyZdXlAR7G3FK6ofGItNgCbE7KSayZvtckYcQyGNyTDc2XCfqJHkGHVHg
         a60Us7iwmVuCFRDvcPIlfDsCOD15pxWdBGqFeQ2woM4pRKFFZsQdDwKh9c7Jmzp0Z2jc
         5wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734571143; x=1735175943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xswLO3aU6iIX4PogxhwW2hgaGIB3kpLUE2ybR+JJZcs=;
        b=TYRgrZmEmkGbMRjVPVo2WmmUpcDxaCEjTK+e0PmvEhQOmIR9Zn/AfLtCJDDFKqmpAM
         ElydzwOSJ42db+PyIvkbnEdzDFmUApvmzfw7304jWPh4o/XGLujqZdk2FwDdvvqcBHGw
         YId6y5tdYCVuSLeIlvk/iixnR1AThE4UfWA+jn7DWNUjLHsLJv0AnVzHMDtEGJ99FCZT
         RplMhIuWL3ItLR3C/dbH5ZQMzsWb+eMIt/wEgz3U7x0Z0qAY7Cdw22ajNgorB0kj5U9/
         XKr9/Mowx/MbQhtb0FgQByqoBSIvDXllxZgjMk86hIysC7yq29SRTKs5Uz2AP/ltjEJS
         NW9Q==
X-Gm-Message-State: AOJu0YxXEXQXwS8tHQaJ0JYvybjdpD9tPL6nQY3IBBLyVgo0joq5SBoN
	ctrI6PVrYr7ILqcwASymm5OXbv89E2p5YS7t+47yms08JrspGRtAL8dqZ5qFXjPVfgasfuoe7y8
	pR8U5CdZS/wwqPzQbFQHRi51kB3U=
X-Gm-Gg: ASbGnctMTfT5LoPOgsyWG3ewsM2w2egL3cRMgtWY8fJuquend9m2vv4XV1fa8g0ywHx
	fMyY12ALar6GkhZZdzb1zcZWHK9qN4HvyYtpC+A==
X-Google-Smtp-Source: AGHT+IHIGoZFqo6a1Y+o45xe6bl5jc4kkv0Bc5aDD8UlPVp7SF4gzrOCelgSsmEEbzTsHxlNCOl17CxT9wUHnKpVEIU=
X-Received: by 2002:a05:600c:3b26:b0:435:23c:e23e with SMTP id
 5b1f17b1804b1-4365535b704mr48275125e9.12.1734571142438; Wed, 18 Dec 2024
 17:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-2-alexei.starovoitov@gmail.com> <Z2KyxEHA8NCNGF6u@tiehlicka>
In-Reply-To: <Z2KyxEHA8NCNGF6u@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Dec 2024 17:18:51 -0800
Message-ID: <CAADnVQJDTjKJXzFm80UwFpV1gJHgboQ72eJ5hOai3seJ6Jf-iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Michal Hocko <mhocko@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, 
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 3:32=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> I like this proposal better. I am still not convinced that we really
> need internal __GFP_TRYLOCK though.
>
> If we reduce try_alloc_pages to the gfp usage we are at the following
>
> On Tue 17-12-24 19:07:14, alexei.starovoitov@gmail.com wrote:
> [...]
> > +struct page *try_alloc_pages_noprof(int nid, unsigned int order)
> > +{
> > +     gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_ZERO |
> > +                       __GFP_NOMEMALLOC | __GFP_TRYLOCK;
> > +     unsigned int alloc_flags =3D ALLOC_TRYLOCK;
> [...]
> > +     prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> > +                         &alloc_gfp, &alloc_flags);
> [...]
> > +     page =3D get_page_from_freelist(alloc_gfp, order, alloc_flags, &a=
c);
> > +
> > +     /* Unlike regular alloc_pages() there is no __alloc_pages_slowpat=
h(). */
> > +
> > +     trace_mm_page_alloc(page, order, alloc_gfp & ~__GFP_TRYLOCK, ac.m=
igratetype);
> > +     kmsan_alloc_page(page, order, alloc_gfp);
> [...]
>
> From those that care about __GFP_TRYLOCK only kmsan_alloc_page doesn't
> have alloc_flags. Those could make the locking decision based on
> ALLOC_TRYLOCK.

__GFP_TRYLOCK here sets a baseline and is used in patch 4 by inner
bits of memcg's consume_stock() logic while called from
try_alloc_pages() in patch 5.
We cannot pass alloc_flags into it.
Just too much overhead.

__memcg_kmem_charge_page()
  -> obj_cgroup_charge_pages()
      -> try_charge_memcg()
         -> consume_stock()

all of them would need an extra 'u32 alloc_flags'.
This is too high cost to avoid ___GFP_TRYLOCK_BIT in gfp_types.h

> I am not familiar with kmsan internals and my main question is whether
> this specific usecase really needs a dedicated reentrant
> kmsan_alloc_page rather than rely on gfp flag to be sufficient.
> Currently kmsan_in_runtime bails out early in some contexts. The
> associated comment about hooks is not completely clear to me though.
> Memory allocation down the road is one of those but it is not really
> clear to me whether this is the only one.

As I mentioned in giant v2 thread I'm not touching kasan/kmsan
in this patch set, since it needs its own eyes
from experts in those bits,
but when it happens gfp & __GFP_TRYLOCK would be the way
to adjust whatever is necessary in kasan/kmsan internals.

As Shakeel mentioned, currently kmsan_alloc_page() is gutted,
since I'm using __GFP_ZERO unconditionally here.
We don't even get to kmsan_in_runtime() check.
For bpf use cases __GFP_ZERO and __GFP_ACCOUNT are pretty much
mandatory. When there will be a 2nd user of this try_alloc_pages()
api we can consider making flags for these two
and at that time full analysis kmsan reentrance would be necessary.
It works in this patch because of GFP_ZERO.

So __GFP_TRYLOCK is needed in many cases:
- to make decisions in consume_stock()
- in the future in kasan/kmsan
- and in slab kmalloc. There I'm going to introduce try_kmalloc()
(or kmalloc_nolock(), naming is hard) that will use this
internal __GFP_TRYLOCK flag to avoid locks and when it gets
to new_slab()->allocate_slab()->alloc_slab_page()
the latter will use try_alloc_pages() instead of alloc_pages().


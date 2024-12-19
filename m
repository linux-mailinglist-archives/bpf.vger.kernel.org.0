Return-Path: <bpf+bounces-47304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF50E9F7532
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 08:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F3916C9ED
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 07:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F092163BC;
	Thu, 19 Dec 2024 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PMfKJJkE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30FC148FE8
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592445; cv=none; b=ogB/qAoCHVmbhzgrjZx+VjSKH3AuTNQzWbGrjQRu1KGYgnpt31ROFdSlpsn0Zb7AN4AS5ya6z+rm3Ae+xQXkUjY2dLtYnnVrzb5WKiJEwppl29FxoAl2ixg7BJUc+idpu+61+YFYihcai1lXxACq6XPcayQWUyvXJ7q79SnXEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592445; c=relaxed/simple;
	bh=DAWvJ/bDpjD05N5prIAUYZhOpM6AY/rJGSZL3wMc1M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfAGrNnIYRgFzw141/f9+E6kQrIATf9nTQjcdSFVf29hd/qpF0z/v/sIctXzw/ErtjoGBWEgMyO7otbn2/t4abjsZ+5d84yiNzm7pIgRSAnkICnekcILCgMUd8jYti5r6k+QvKJQAf9S3krRLussk4NfvdZ+6GgMKPT2M8Bad6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PMfKJJkE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso517931a12.0
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 23:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734592441; x=1735197241; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u1OEi5ZhPA9+MrgzSUOcSZypRzfKMXc2kF2QroNnpVk=;
        b=PMfKJJkE+H0Q43jzuGltI66b3ExYjtfYmSOFl5wV85oiK4nTtGoFNVVGGyXBedD/D/
         QUCnYIJR0fFzDyAtNUIlWIbuFUfVTb0WqcblbkyNiQSA0WMLOOg4GWgB3sGZ7oL3w5EF
         o+/AYjJNSclWV4zNbYkEs/TYuvTeEFXQrPilRdqfpOtJnCIKXKQKKQx0PTcwClsQLO33
         gq9otz2XoPavZg0OyDVvrNwxyEc5W1XZozwDI9Nhwqkd6zfwtRgBMmx17J+NkKaO/HJx
         ddXewJjA5p0mNp+xstqm43TB8FpiD5Wfs7ELP/3/osMHAZrEeby2vwye1R1JlKt+f9Ec
         qeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734592441; x=1735197241;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1OEi5ZhPA9+MrgzSUOcSZypRzfKMXc2kF2QroNnpVk=;
        b=VSE9rplev0Wf90Th0woPpvXx5rsMX2MktzytBGLH4yj85AjDyGfQ3/rA/itbA/Kkxr
         4X5VPMDoXeU7+TeCjLkBD6GNMiBPiAlbBDRX17QGGdfuH/sGSS/u4LuaQFlp7YBWrdVw
         p8RHI5jFNF/6FhqlI/OVqSXRZC9x4S96goJFsM01xKTOrhxAuEzfhBOtETnBi3RHl/4g
         4QdbnlwS3aLfmG3WWAolp1Ri5Hcnh5iPITDauMgpUXbOVrqB4xRRStFODIp4uIDtpv6W
         Hd3C32qMeINGkoj/dM9uPSFgnGPWgr2dig2m219AYTWd5ybh9LSrODYVFfN8BNbfKtO+
         sm2Q==
X-Gm-Message-State: AOJu0YydjjM8QWzhgI6mIxztNDPVM+z6SDNFPgPmJLRTp3kWYw0L/1Fe
	824m9LIht4b47sBDHWfQoF5pjbzJtMn0w5ez6Dv5WeKsQk0ZvxbEWuF/PM1GlCg=
X-Gm-Gg: ASbGnctpw6XPzMqJ41ENohFq9DGMLYP8s3jZWWT3Vnudd/8u+Cnfkgd6o3yrATiG3WW
	QYht4UoXh31rEM48GqPHkMBTTMv7DCv0AuE8kCu2jncJtRWQWac8PanSxo5uzvhUCEv3bjSiLtc
	V0ixYwNP513MBOS1C8f/aHhmH3wVJ9FAwQm9XmBD2L5xg9NnlhluTHye4EbZF/GFKSITOB+6v4f
	2Clt1VWtk3Jhcn8w9/ihWYUzfTamYO+HZRspH6Ke0fx01jWYE4OnkG7ouF/w1UO
X-Google-Smtp-Source: AGHT+IGbKA88esNGTqcBeufNXkCLlBriajGKpzYOGrs0/RmlZlpKSoGsUeabkdTSnLOY8snhYdh7Aw==
X-Received: by 2002:a05:6402:2695:b0:5d1:1024:97a0 with SMTP id 4fb4d7f45d1cf-5d7ee3a29d7mr5286714a12.6.1734592441063;
        Wed, 18 Dec 2024 23:14:01 -0800 (PST)
Received: from localhost (109-81-88-1.rct.o2.cz. [109.81.88.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c8cfsm342882a12.39.2024.12.18.23.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 23:14:00 -0800 (PST)
Date: Thu, 19 Dec 2024 08:13:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <Z2PHt6-rdkC3f_tQ@tiehlicka>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-2-alexei.starovoitov@gmail.com>
 <Z2KyxEHA8NCNGF6u@tiehlicka>
 <CAADnVQJDTjKJXzFm80UwFpV1gJHgboQ72eJ5hOai3seJ6Jf-iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJDTjKJXzFm80UwFpV1gJHgboQ72eJ5hOai3seJ6Jf-iA@mail.gmail.com>

On Wed 18-12-24 17:18:51, Alexei Starovoitov wrote:
> On Wed, Dec 18, 2024 at 3:32 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > I like this proposal better. I am still not convinced that we really
> > need internal __GFP_TRYLOCK though.
> >
> > If we reduce try_alloc_pages to the gfp usage we are at the following
> >
> > On Tue 17-12-24 19:07:14, alexei.starovoitov@gmail.com wrote:
> > [...]
> > > +struct page *try_alloc_pages_noprof(int nid, unsigned int order)
> > > +{
> > > +     gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO |
> > > +                       __GFP_NOMEMALLOC | __GFP_TRYLOCK;
> > > +     unsigned int alloc_flags = ALLOC_TRYLOCK;
> > [...]
> > > +     prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> > > +                         &alloc_gfp, &alloc_flags);
> > [...]
> > > +     page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
> > > +
> > > +     /* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
> > > +
> > > +     trace_mm_page_alloc(page, order, alloc_gfp & ~__GFP_TRYLOCK, ac.migratetype);
> > > +     kmsan_alloc_page(page, order, alloc_gfp);
> > [...]
> >
> > From those that care about __GFP_TRYLOCK only kmsan_alloc_page doesn't
> > have alloc_flags. Those could make the locking decision based on
> > ALLOC_TRYLOCK.
> 
> __GFP_TRYLOCK here sets a baseline and is used in patch 4 by inner
> bits of memcg's consume_stock() logic while called from
> try_alloc_pages() in patch 5.

Yes, I have addressed that part in a reply. In short I believe we can
achieve reentrancy for NOWAIT/ATOMIC charges without a dedicated gfp
flag.

[...]
> > I am not familiar with kmsan internals and my main question is whether
> > this specific usecase really needs a dedicated reentrant
> > kmsan_alloc_page rather than rely on gfp flag to be sufficient.
> > Currently kmsan_in_runtime bails out early in some contexts. The
> > associated comment about hooks is not completely clear to me though.
> > Memory allocation down the road is one of those but it is not really
> > clear to me whether this is the only one.
> 
> As I mentioned in giant v2 thread I'm not touching kasan/kmsan
> in this patch set, since it needs its own eyes
> from experts in those bits,
> but when it happens gfp & __GFP_TRYLOCK would be the way
> to adjust whatever is necessary in kasan/kmsan internals.
> 
> As Shakeel mentioned, currently kmsan_alloc_page() is gutted,
> since I'm using __GFP_ZERO unconditionally here.
> We don't even get to kmsan_in_runtime() check.

I have missed that part! That means that you can drop kmsan_alloc_page
altogether no?

[...]

> - and in slab kmalloc. There I'm going to introduce try_kmalloc()
> (or kmalloc_nolock(), naming is hard) that will use this
> internal __GFP_TRYLOCK flag to avoid locks and when it gets
> to new_slab()->allocate_slab()->alloc_slab_page()
> the latter will use try_alloc_pages() instead of alloc_pages().

I cannot really comment on the slab side of things. All I am saying is
that we should _try_ to avoid __GFP_TRYLOCK if possible/feasible. It
seems that the page allocator can do without that. Maybe slab side can
as well.
-- 
Michal Hocko
SUSE Labs


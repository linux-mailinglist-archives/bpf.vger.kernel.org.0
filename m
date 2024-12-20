Return-Path: <bpf+bounces-47467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A499F9AA7
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB41E7A2049
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AEB2210C1;
	Fri, 20 Dec 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wTFs2ICp"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C27921D59E
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723957; cv=none; b=gZIey5hhy6ENJtd+1MTEQ1kwKlMgdha1YrOvmd4dpc80DLuXyxyWWGrszeNZowcAD9lVVfTJoIbAFGO3ZqjNYQxp4iHFnFPEFLYwMzNhZNbBfI4CZrUhme3DAGWhD2iycW9PmGYlI30xUJkhBRzfFHHLeL9TTwMkaQrWT+heUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723957; c=relaxed/simple;
	bh=hrUK0+eCMAP+Ju0rPbZppQIUyrt5r5XoIi+SJh9J+GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzFqV4QeCZfK411m8SmjtzqSGta24IuoFPJAZ2Kf2cHrpa5naPYiccbbEJQaYvuG9g/6+dtIKJRF+417/h8tju1RMpKusSav33qMu0PNPREKgdKmFkFPZh8cuzCk+x/Xvm166LPLsEhACmyi5QDofewJrwC62OShvVvr7leS1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wTFs2ICp; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 20 Dec 2024 11:45:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734723953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmhkYguEhBw74e/yDb6B2nnf/MGyGWg0Z2UpSuQG8Kc=;
	b=wTFs2ICpGBlStxOTOUroqnmX1Y53plE0WbmZD+qWiyaxGVfmD8NuaozVoxz1LPg9Kby4qS
	WRHyv7u8X1wJLh3NN4Ol6pgf8J2icXmn0Vbu/hScw2Vq2bLhxd+6V48fyZr6GJkC7gotZ1
	XSFP+ILPmPDUzCd9IaUZ4fPuJZeFM2g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 4/6] memcg: Use trylock to access memcg
 stock_lock.
Message-ID: <7s6fbpwsynadnzybhdqg3jwhls4pq2sptyxuyghxpaufhissj5@iadb6ibzscjj>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-5-alexei.starovoitov@gmail.com>
 <Z2Ky2idzyPn08JE-@tiehlicka>
 <CAADnVQKv_J-8CdSZsJh3uMz2XFh_g+fHZVGCmq6KTaAkupqi5w@mail.gmail.com>
 <Z2PGetahl-7EcoIi@tiehlicka>
 <Z2PKyU3hJY5e0DUE@tiehlicka>
 <Z2PQv8dVNBopIiYN@tiehlicka>
 <CAADnVQLm=gSAh2u3iF4HoGmLEqa-AV0FAEnDqcoFYDgZ06d+gQ@mail.gmail.com>
 <Z2Up17maf6FHkVu5@tiehlicka>
 <CAADnVQ+t3EF_CDrsYuY4eR87u1YnoSoj2S7fCQS7gi67cdhz0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+t3EF_CDrsYuY4eR87u1YnoSoj2S7fCQS7gi67cdhz0A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 20, 2024 at 08:10:47AM -0800, Alexei Starovoitov wrote:
> On Fri, Dec 20, 2024 at 12:24 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > > +static inline bool gfpflags_allow_spinning(const gfp_t gfp_flags)
> > > +{
> > > +       /*
> > > +        * !__GFP_DIRECT_RECLAIM -> direct claim is not allowed.
> > > +        * !__GFP_KSWAPD_RECLAIM -> it's not safe to wake up kswapd.
> > > +        * All GFP_* flags including GFP_NOWAIT use one or both flags.
> > > +        * try_alloc_pages() is the only API that doesn't specify either flag.
> >
> > I wouldn't be surprised if we had other allocations like that. git grep
> > is generally not very helpful as many/most allocations use gfp argument
> > of a sort. I would slightly reword this to be more explicit.
> >           /*
> >            * This is stronger than GFP_NOWAIT or GFP_ATOMIC because
> >            * those are guaranteed to never block on a sleeping lock.
> >            * Here we are enforcing that the allaaction doesn't ever spin
> >            * on any locks (i.e. only trylocks). There is no highlevel
> >            * GFP_$FOO flag for this use try_alloc_pages as the
> >            * regular page allocator doesn't fully support this
> >            * allocation mode.
> 
> Makes sense. I like this new wording. Will incorporate.
> 
> > > +        */
> > > +       return !(gfp_flags & __GFP_RECLAIM);
> > > +}
> > > +
> > >  #ifdef CONFIG_HIGHMEM
> > >  #define OPT_ZONE_HIGHMEM ZONE_HIGHMEM
> > >  #else
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index f168d223375f..545d345c22de 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1768,7 +1768,7 @@ static bool consume_stock(struct mem_cgroup
> > > *memcg, unsigned int nr_pages,
> > >                 return ret;
> > >
> > >         if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > > -               if (gfp_mask & __GFP_TRYLOCK)
> > > +               if (!gfpflags_allow_spinning(gfp_mask))
> > >                         return ret;
> > >                 local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > >         }
> > >
> > > If that's acceptable then such an approach will work for
> > > my slub.c reentrance changes too.
> >
> > It certainly is acceptable for me.
> 
> Great.
> 
> > Do not forget to add another hunk to
> > avoid charging the full batch in this case.
> 
> Well. It looks like you spotted the existing bug ?
> 
> Instead of
> +       if (!gfpflags_allow_blockingk(gfp_mask))
> +               batch = nr_pages;
> 
> it should be unconditional:
> 
> +               batch = nr_pages;
> 
> after consume_stock() returns false.
> 
> Consider:
>         stock_pages = READ_ONCE(stock->nr_pages);
>         if (memcg == READ_ONCE(stock->cached) && stock_pages >= nr_pages) {
> 
> stock_pages == 10
> nr_pages == 20
> 
> so after consume_stock() returns false
> the batch will stay == MEMCG_CHARGE_BATCH == 64
> and
> page_counter_try_charge(&memcg->memsw, batch,...
> 
> will charge too much ?
> 
> and the bug was there for a long time.
> 
> Johaness,
> 
> looks like it's mostly your code?
> 
> Pls help us out.

I think the code is fine as the overcharge amount will be refilled into
the stock (old one will be flushed). 

	if (gfpflags_allow_spinning(gfp_mask))
		batch = nr_pages;

The above code will just avoid the refill and flushing the older stock.
Maybe Michal's suggestion is due to that reason.

BTW after the done_restock tag in try_charge_memcg(), we will another
gfpflags_allow_spinning() check to avoid schedule_work() and
mem_cgroup_handle_over_high(). Maybe simply return early for
gfpflags_allow_spinning() without checking high marks.


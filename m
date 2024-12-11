Return-Path: <bpf+bounces-46614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597F79ECA2D
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 11:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4096C281989
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFE21C5F00;
	Wed, 11 Dec 2024 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cWahypwV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29B236FA9
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912357; cv=none; b=U5axBde3y0v5VheaIiA9zyZJdOI0kiLzYIs0bBDXFHIjxJQ7T63uQt5zPBFt8ZsqVUtkap4dv0lEGZNYVLorNOCbkkLhSJoUlzPvWxjvXJHTFhT3xdjyIjpGxFiCgikbqdOqAeKaAic6EsjcXTPn4/XQRLdjV6brW5XtRL9f6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912357; c=relaxed/simple;
	bh=IfrJNU6XdUxLHzZ91OCZHcORI3kHU9EnCqwbI0/W36c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJCY6zhkrKnfzsrg18YFWhgfwJTQQXFDWJ9TYpyvmBU9uq2dBVJNganLFvxpMlgrNsl7TpVTuWFVIC7AZ9H1xFjjr81SiKveqS25hvmbi+rP0SK7B+zh9UfpXmHyBe/hVLq8QXicXBTDs53K9O+xATQ7luAIBfYOEIh9rWb5SBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cWahypwV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-432d86a3085so43267445e9.2
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 02:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733912354; x=1734517154; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=650XyRGaHbLD677ELO1Xl1lrF0UQbw67E/gRyWNlMa0=;
        b=cWahypwVI+Mvu/080+WSw+W80S5+qrjZqetNa63mldwTvrnZw5tP/NnjhkoYnCeLp5
         oU8P3bEyTlaaYK4YmRgwdWwioKemPnOrH8C850mxqzE3/lPO8DRRBweWEJuIlFopsnFF
         agkbkYR9fXBC/VB/a5M49v/hIH4zRTXZfCMx4lXVXJubVtHoKcA4dGZmJUWM/AWPfU/C
         md0+grPndcwsCtcXUkaJSHV8/JCXim0K2pyMuJl+CFK4vL8jZwo72rVp9G4Yo8yuwDNZ
         tS2+SJ/Jq1kiq0TYLBMia1fRZRKN/FxnFnjHHi+aYSDK+sguZFDKA4FaYWCHdwkUs8l7
         uLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912354; x=1734517154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=650XyRGaHbLD677ELO1Xl1lrF0UQbw67E/gRyWNlMa0=;
        b=w2axnWkR79kJQ0Z0jl0+Eg6TXclI+iL1zYOl2jmm2pjoB9HTafqgoK959lhmVBkQzh
         YXZ+mvusfHUEublAnnBYzWVh7f9XfHNoagimaski7T9erI3YKzk0LVNxkemboLTumGxz
         EWD/NwuTozT2pESCB6YzXJ5lw+LfNMLJmUNbv+rN8xZ5+M9ssPDmXAFecsX5OaTGF/es
         72sxhkd8D23jlZibEhmEaZueh9HzPT2bxVtV+3B5mF5aviyEXpB9wEPpZY3g377LsqVl
         G+TTSQthFDogQ/ZY3BcExH8lB5JMP6t0EIT0Jd1B+ErQz8gzbe89Boe9O+qE5flGqj6X
         C6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfBLT7466QIG777VxTTup+fKBjQD8Uh+w2oilrCU3X/b7xIspATTAwCid/r0LFJWzJd8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRezRTPnRYZm9TXpo3alje0DLg2djsZGF4wUrUMxLK2W18y8U
	Lslbapgrkb2BD5tL0gWTpAF9DHEglwu9Z8JJobLwPfNVBXRsGWP+pJq6vtLosCh4Wa8s3o2fWQa
	H
X-Gm-Gg: ASbGncuai13w89EOcUVPQRYtD1OlVpY+xpvg1DokeLg+Pr6NqJ6V6XUcWzEEEiAZjeF
	pqClkiXU+h2vjbk8UTgS7IVwxKgX5Lk9GKyLDhUhzMTZXwIC/sEjUqywg41R8L2+crole2J6kbP
	2eHHekAOxpryDyuWaZnOGOky1I9O8NW60sg6B6r1bj9Xx4TKle1/x+tpZ3NyY8+2vTdnjbyPdN6
	z4fdegs5hFDoenZZZUB3heQSJU19XAwZSUZGsnhBpqqaBNVyyDMQR7Yiii1D1xZXBM=
X-Google-Smtp-Source: AGHT+IHYg2Y8g4/aWQs8zDiuCFpi6DoGTJ4Z4OGmOvw05oFkj1Vpg4R3AQ8XJBYJM01DWA40uRtntQ==
X-Received: by 2002:a05:600c:a011:b0:434:ff45:cbd0 with SMTP id 5b1f17b1804b1-4361c3766bfmr17715885e9.17.1733912353890;
        Wed, 11 Dec 2024 02:19:13 -0800 (PST)
Received: from localhost (109-81-86-131.rct.o2.cz. [109.81.86.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e57fsm970272f8f.8.2024.12.11.02.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:19:13 -0800 (PST)
Date: Wed, 11 Dec 2024 11:19:12 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <Z1lnIG_ywpjv7OlQ@tiehlicka>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
 <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka>
 <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>

On Tue 10-12-24 14:06:32, Alexei Starovoitov wrote:
> On Tue, Dec 10, 2024 at 1:05 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 10-12-24 05:31:30, Matthew Wilcox wrote:
> > > On Mon, Dec 09, 2024 at 06:39:31PM -0800, Alexei Starovoitov wrote:
> > > > +   if (preemptible() && !rcu_preempt_depth())
> > > > +           return alloc_pages_node_noprof(nid,
> > > > +                                          GFP_NOWAIT | __GFP_ZERO,
> > > > +                                          order);
> > > > +   return alloc_pages_node_noprof(nid,
> > > > +                                  __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO,
> > > > +                                  order);
> > >
> > > [...]
> > >
> > > > @@ -4009,7 +4018,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
> > > >      * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
> > > >      */
> > > >     alloc_flags |= (__force int)
> > > > -           (gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
> > > > +           (gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM | __GFP_TRYLOCK));
> > >
> > > It's not quite clear to me that we need __GFP_TRYLOCK to implement this.
> > > I was originally wondering if this wasn't a memalloc_nolock_save() /
> > > memalloc_nolock_restore() situation (akin to memalloc_nofs_save/restore),
> > > but I wonder if we can simply do:
> > >
> > >       if (!preemptible() || rcu_preempt_depth())
> > >               alloc_flags |= ALLOC_TRYLOCK;
> >
> > preemptible is unusable without CONFIG_PREEMPT_COUNT but I do agree that
> > __GFP_TRYLOCK is not really a preferred way to go forward. For 3
> > reasons.
> >
> > First I do not really like the name as it tells what it does rather than
> > how it should be used. This is a general pattern of many gfp flags
> > unfotrunatelly and historically it has turned out error prone. If a gfp
> > flag is really needed then something like __GFP_ANY_CONTEXT should be
> > used.  If the current implementation requires to use try_lock for
> > zone->lock or other changes is not an implementation detail but the user
> > should have a clear understanding that allocation is allowed from any
> > context (NMI, IRQ or otherwise atomic contexts).
> 
> __GFP_ANY_CONTEXT would make sense if we wanted to make it available
> for all kernel users. In this case I agree with Sebastian.
> This is bpf specific feature, since it doesn't know the context.
> All other kernel users should pick GFP_KERNEL or ATOMIC or NOWAIT.
> Exposing GFP_ANY_CONTEXT to all may lead to sloppy code in drivers
> and elsewhere.

I do not think we want a single user special allocation mode. Not only
there is no way to enforce this to remain BPF special feature, it is
also not really a good idea to have a single user feature in the
allocator.

> > Is there any reason why GFP_ATOMIC cannot be extended to support new
> > contexts? This allocation mode is already documented to be usable from
> > atomic contexts except from NMI and raw_spinlocks. But is it feasible to
> > extend the current implementation to use only trylock on zone->lock if
> > called from in_nmi() to reduce unexpected failures on contention for
> > existing users?
> 
> No. in_nmi() doesn't help. It's the lack of reentrance of slab and page
> allocator that is an issue.
> The page alloctor might grab zone lock. In !RT it will disable irqs.
> In RT will stay sleepable. Both paths will be calling other
> kernel code including tracepoints, potential kprobes, etc
> and bpf prog may be attached somewhere.
> If it calls alloc_page() it may deadlock on zone->lock.
> pcpu lock is thankfully trylock already.
> So !irqs_disabled() part of preemptible() guarantees that
> zone->lock won't deadlock in !RT.
> And rcu_preempt_depth() case just steers bpf into try lock only path in RT.
> Since there is no way to tell whether it's safe to call
> sleepable spin_lock(&zone->lock).

OK I see!

> > We
> > already have a precence in form of __alloc_pages_bulk which is a special
> > case allocator mode living outside of the page allocator path. It seems
> > that it covers most of your requirements except the fallback to the
> > regular allocation path AFAICS. Is this something you could piggy back
> > on?
> 
> __alloc_pages_bulk() has all the same issues. It takes locks.
> Also it doesn't support GFP_ACCOUNT which is a show stopper.
> All bpf allocations are going through memcg.

OK, this requirement was not clear until I've reached later patches in
the series (now).
-- 
Michal Hocko
SUSE Labs


Return-Path: <bpf+bounces-45043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788BA9D02FE
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 11:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CCA1F21BDE
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3812E1E0;
	Sun, 17 Nov 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I5XhPSiD"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C81392
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731840625; cv=none; b=eES/Zqc4pfdOnua1eUYnCSMq1Ft4V/Z8dwlmWiM/Nwj1pNga9Ryx21OBvd3sdcP24oU4qQTQ8VJcWyFJHRoTCjTjrfuLiwXT1qmwu588dIF9w1fNOOHKukCW9AQL6c67S+j9TAoKnlkLlm7XGVNLu+s+XvaKq3Hu6KHKCh5tQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731840625; c=relaxed/simple;
	bh=dZEpdMNktylf3JiHSsjSYHDlL4tRbc2K1rKO3wBWqPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4gn1dWTyyzp06NJ/RhLYezAtt2SJcyKMXf8JvtLfcI5k6vojxm8hdcPHrkcK1HoHCs30a6Chsbu1SCoKyXtTEvptiewlQWLy8/8Seszy0aPhLyMr2N6Gk1/JYQuEigpAFCF6iWPL2rg3tVxkY/2JCBsuv4MsHXSPsalreYJuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I5XhPSiD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=pshiIs3frOWk0a9YBcwoAUViLhisC1xEmCnwHIj23MA=; b=I5XhPSiDYaBULLTJ4FiFE0Cves
	a9n2Sg0Ig6GTtSO6ABAGVePvOdGx9abwZ9dAl5xACUslE41B285l1G4Vtjy6MVGpAEe5jhHid2tt6
	HmT0i1A1C4C0bUqtghrY+lyQ4jL4ROjHFW1/UoNvMJhhVj185WyYwbrSDmhEU2sv+4fScOjrXx8Gx
	nu0ugpUr5XUEHbf0EN1iGvPb4JmENI3B9gRj22/dqDL3cqAWa+W62muw0oOigh1jm72GU64uW/THH
	BWSVA0ekDlMUmDInqcW1TriJ11Lhnyf+Up7kl1d7kdKugMG8989eg2knMCvKbhpd7ijQCxUuUPKiZ
	KDB5sxsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCcr0-000000007T5-3cpd;
	Sun, 17 Nov 2024 10:50:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04BC23006B7; Sun, 17 Nov 2024 11:50:06 +0100 (CET)
Date: Sun, 17 Nov 2024 11:50:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/2] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241117105005.GA27667@noisy.programming.kicks-ass.net>
References: <20241116014854.55141-1-alexei.starovoitov@gmail.com>
 <20241116194202.GR22801@noisy.programming.kicks-ass.net>
 <CAADnVQLOyY=Jvibq-hnv6dpXy+hAJFWojyHh7wuEiMn-itMvaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLOyY=Jvibq-hnv6dpXy+hAJFWojyHh7wuEiMn-itMvaw@mail.gmail.com>

On Sat, Nov 16, 2024 at 01:13:20PM -0800, Alexei Starovoitov wrote:
> On Sat, Nov 16, 2024 at 11:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 15, 2024 at 05:48:53PM -0800, Alexei Starovoitov wrote:
> > > +static inline struct page *try_alloc_page_noprof(int nid)
> > > +{
> > > +     /* If spin_locks are not held and interrupts are enabled, use normal path. */
> > > +     if (preemptible())
> > > +             return alloc_pages_node_noprof(nid, GFP_NOWAIT | __GFP_ZERO, 0);
> >
> > This isn't right for PREEMPT_RT, spinlock_t will be preemptible, but you
> > very much do not want regular allocation calls while inside the
> > allocator itself for example.
> 
> I'm aware that spinlocks are preemptible in RT.
> Here is my understanding of why the above is correct...
> - preemptible() means that IRQs are not disabled and preempt_count == 0.
> 
> - All page alloc operations are protected either by
> pcp_spin_trylock() or by spin_lock_irqsave(&zone->lock, flags)
> or both together.
> 
> - In non-RT spin_lock_irqsave disables IRQs, so preemptible()
> check guarantees that we're not holding zone->lock.
> The page alloc logic can hold pcp lock when try_alloc_page() is called,
> but it's always using pcp_trylock, so it's still ok to call it
> with GFP_NOWAIT. pcp trylock will fail and zone->lock will proceed
> to acquire zone->lock.
> 
> - In RT spin_lock_irqsave doesn't disable IRQs despite its name.
> It calls rt_spin_lock() which calls rcu_read_lock()
> which increments preempt_count.

It does not on PREEMPT_RCU, which is mandatory for PREEMPT_RT.


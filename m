Return-Path: <bpf+bounces-57032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C60AA4204
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 06:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EDC9855E9
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 04:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43081DDC33;
	Wed, 30 Apr 2025 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xYVbdazZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C179FE
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 04:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987868; cv=none; b=FJLigF23e5A/3hAogGMZ80ynZNUsDAp88+93Lr7sfdo6KQtlwuaUhl4MSDM2q8p9BRn6+B7aHlVbVCTvE4Hy1a/6CxYFvo4OnJ9UGEVNwbXKljhmpw2fnOpgm90zZmcFobYb7yY26iWhe+xAf6mb3y5uKstkKfBFlClZeb3V54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987868; c=relaxed/simple;
	bh=f3ULwdz3E+FT0nhtRA9uWt9Tazclrc2kktUie/YwiJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euEecGPtuBqFYp2QfFVshfU46RzeWpswARBPkRWjGb6F3TJLTcEvkimKNQAUOuTlVVP4Per5hfNqB6D2Fsw0PDFtfdwcjjgourZU+5d4QvkotI6U4V/7SxmSe1YYkoySzJOxrNI0QiC/uZJvTZxXGif1w4j6VFY+Hcqza+DS61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xYVbdazZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Apr 2025 21:37:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745987853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk++kZUym1lInKgvd6euou9nW/mbCsjkNUrb182STy8=;
	b=xYVbdazZKtwWLsUH/QfCw2fysf6554U6sfclBklEutued09XIvwNg/PqHt5eJ8mrUGtPGe
	9tJOEtXp5wi1kQPR1ezcvanMiJuB/eO14DYEhHHEhHv6TMrxUa2TaKbZUIp5j2WxY3TbEF
	ZF/uOK14ntiqWdwtJWLleirD1q6pp+c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] memcg: simplify consume_stock
Message-ID: <ik3yjjt6evxexkaculyiibgrgxtvimwx7rzalpbecb75gpmmck@pcsmy6kxzynb>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
 <20250429230428.1935619-2-shakeel.butt@linux.dev>
 <dvyyqubghf67b3qsuoreegqk4qnuuqfkk7plpfhhrck5yeeuic@xbn4c6c7yc42>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dvyyqubghf67b3qsuoreegqk4qnuuqfkk7plpfhhrck5yeeuic@xbn4c6c7yc42>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 29, 2025 at 04:51:03PM -0700, Alexei Starovoitov wrote:
> On Tue, Apr 29, 2025 at 04:04:25PM -0700, Shakeel Butt wrote:
> > The consume_stock() does not need to check gfp_mask for spinning and can
> > simply trylock the local lock to decide to proceed or fail. No need to
> > spin at all for local lock.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/memcontrol.c | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 650fe4314c39..40d0838d88bc 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1804,16 +1804,14 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
> >   * consume_stock: Try to consume stocked charge on this cpu.
> >   * @memcg: memcg to consume from.
> >   * @nr_pages: how many pages to charge.
> > - * @gfp_mask: allocation mask.
> >   *
> > - * The charges will only happen if @memcg matches the current cpu's memcg
> > - * stock, and at least @nr_pages are available in that stock.  Failure to
> > - * service an allocation will refill the stock.
> > + * Consume the cached charge if enough nr_pages are present otherwise return
> > + * failure. Also return failure for charge request larger than
> > + * MEMCG_CHARGE_BATCH or if the local lock is already taken.
> >   *
> >   * returns true if successful, false otherwise.
> >   */
> > -static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> > -			  gfp_t gfp_mask)
> > +static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> >  {
> >  	struct memcg_stock_pcp *stock;
> >  	uint8_t stock_pages;
> > @@ -1821,12 +1819,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> >  	bool ret = false;
> >  	int i;
> >  
> > -	if (nr_pages > MEMCG_CHARGE_BATCH)
> > -		return ret;
> > -
> > -	if (gfpflags_allow_spinning(gfp_mask))
> > -		local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > -	else if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags))
> > +	if (nr_pages > MEMCG_CHARGE_BATCH ||
> > +	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags))
> 
> I don't think it's a good idea.
> spin_trylock() will fail often enough in PREEMPT_RT.
> Even during normal boot I see preemption between tasks and they
> contend on the same cpu for the same local_lock==spin_lock.
> Making them take slow path is a significant behavior change
> that needs to be carefully considered.

I didn't really think too much about PREEMPT_RT kernels as I assume
performance is not top priority but I think I get your point. Let me
explain and correct me if I am wrong. On PREEMPT_RT kernel, the local
lock is a spin lock which is actually a mutex but with priority
inheritance. A task having the local lock can still get context switched
(but will remain on same CPU run queue) and the newer task can try to
acquire the memcg stock local lock. If we just do trylock, it will
always go to the slow path but if we do local_lock() then it will sleeps
and possibly gives its priority to the task owning the lock and possibly
make that task to get the CPU. Later the task slept on memcg stock lock
will wake up and go through fast path.


Ok, I will drop the first patch. Please let me know your comments on the
remaining series.

> 
> Also please cc bpf@vger in the future for these kind of changes.

Sounds good.


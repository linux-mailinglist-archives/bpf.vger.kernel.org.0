Return-Path: <bpf+bounces-67341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AED6B42A79
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 22:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3C1582129
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048C92DEA6F;
	Wed,  3 Sep 2025 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RC3AYnob"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCAF1DE885;
	Wed,  3 Sep 2025 20:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929937; cv=none; b=Jr5aCrETOFgV1OW8R6pLYr0d81zOIFb9Z9MEegaZIEiX+a8qFCwnhkJVw1joxTQ4/nXaYL72JUZvH7VS66gqYOTmD5UusX74lw2O0l6P5+CO48mG+UxS1uGczAZhpgZg5WNoEjk/yrrkgIzG2wmDNPEe979u2I+XpCkOsJxu7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929937; c=relaxed/simple;
	bh=VSnWu8ZchqXl6sfiGU6rEpBT5AdzfhQhNjQ0afucGvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi1Pku36TYtLOow5V+B//0W6SDp8CBW78cO+mC5NRi9bInI9Bb0LQooRhsqUBw6J3rA9tNDk9bP5FuOXVGtVD+NxiXZgZquoZV096IClSZI63+iipAGSvlr5X0yd8lbSW/KunrDh0lNVxgkX57wHA3kY7pwZEwopIgJnaRokFgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RC3AYnob; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hORezU9YIiX/YoaprSM+m2+DrF64xiFzVBU7gNksov4=; b=RC3AYnobPEbzmuUs3pHMDyWne+
	fjgNFz9KenOlpIsnTgmfz9xCYEzd6YbiajHEm3QfM0q+fFdjwjEte4xPIKEWG18ze5e2d5ZRFAzfq
	yy5OLWKkD4n0b435jUTGrnlOfw2t1nACtj7Po69UwPtrvOe1TEwr/9AmXJHWFNxpLqs3x2PJkiSZj
	ZfjaCETIyw7NK5GxA4roC7J0oPG2VtrlZjVmffZXOwf8qYXUuEg9zl/3LZtQ76sK9+CaUQ5Fmgbd5
	ERfn6MBuY1DFkDcPqMIpjS6WSQ/fdW76pt6ZVqUgNUXGtY8d7agyZW20muhn73Rk8sZ/YuAvt+xRb
	6mHet9TQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uttjO-00000004DIW-1Cgg;
	Wed, 03 Sep 2025 20:05:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A2D39300220; Wed, 03 Sep 2025 22:05:20 +0200 (CEST)
Date: Wed, 3 Sep 2025 22:05:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>
Subject: Re: [PATCH 05/16] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <20250903200520.GN4067720@noisy.programming.kicks-ass.net>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-6-arighi@nvidia.com>
 <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>

On Wed, Sep 03, 2025 at 04:53:59PM +0200, Juri Lelli wrote:
> Hi,
> 
> On 03/09/25 11:33, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > root domain containing cpu_active() CPUs. So in this case, don't mess
> > with accounting and we can retry later. Without this patch, we see
> > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > 
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/sched/deadline.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 3c478a1b2890d..753e50b1e86fc 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1689,7 +1689,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> >  	cpus = dl_bw_cpus(cpu);
> >  	cap = dl_bw_capacity(cpu);
> >  
> > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > +	/*
> > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > +	 * with accounting and we can retry later.
> > +	 */
> > +	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
> >  		return -EBUSY;
> >  
> >  	if (init) {
> 
> Yuri is proposing to ignore dl-servers bandwidth contribution from
> admission control (as they essentially operate on the remaining
> bandwidth portion not available to RT/DEADLINE tasks):
> 
> https://lore.kernel.org/lkml/20250903114448.664452-1-yurand2000@gmail.com/
> 
> His patch should make this patch not required. Would you be able and
> willing to test this assumption?
> 
> I don't believe Peter already expressed his opinion on what Yuri is
> proposing, so this might be moot. 

Urgh, yeah, I don't like that at all. That reasoning makes no sense what
so ever. That 5% is not lost time, that 5% is being very optimistic and
'models' otherwise unaccountable time like IRQ and random overheads.

Thinking you can give out 100% CPU time to a bandwidth limited group of
tasks is delusional.

Explicitly not accounting things that you *can* is just plain wrong. So
no, Yuri's thing is not going to go anywhere.


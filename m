Return-Path: <bpf+bounces-32895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0755914A37
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 14:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A14D1F215EB
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD2D13C691;
	Mon, 24 Jun 2024 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="spqPJQp/"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C801E4AE;
	Mon, 24 Jun 2024 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232552; cv=none; b=SGC+qLjCdrg5TrOj5FgbouMkvHmDfn35D9uCt5kREbDU7bDxkJMNHcDyKJKTVcxxfUxCegZaLv6nJd+M6NgGkrtnCav7VZ0zMVnSFWVNZhzqM+DyYFMJoK8KPRHuF9V1ZfF5p1pqILDUKuhAftnlSx39/8dg8Oh3yLEsi5luBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232552; c=relaxed/simple;
	bh=b4OfR3kPYjIt3ptNEk8re7Km0yUPn41sHSR+XClF/q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJl9DurtyR5NTu6MIbYHN/1vh2LkcjyGZjylCSqFC0RLszqgtUeBi9y2Nig7cxb77JDAIvnxa0OgnmcXPE0rrzM3dM3+iBTI1o0VjidFVAEiivkCU6lH6t8c9e/A6PAjHsy1cjEKr7mQlZwToWxAJzf6jUNlGpwQ43gv0Bfkz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=spqPJQp/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vfxipKwPSiPtFOclKlM4eBqCSYvecyEBGlQCJIpR8/g=; b=spqPJQp/Noiw+TNMULXA5q4Whw
	stiOmNCDgP9b7/V3nh73dldzFZFFtdveY3WtS2+dYirKY+XMDSHgwNv1aM7hI7ppqu8vmVyvzYYUo
	IOBw4BWZbbtNThDUlwR/cx4OS2Q0XoGGX1cjpgpFhVfzdIIkya9uFxwOXnphNzjyoMFUyf5Dl1hmc
	OWLRiLLaMtZp6FUR6Y0RZ7kF8f7KQ3b09bkzUK7ZBTNUdHsrmo5G4ashYgFer2kB3NciEWjFx5E6g
	R4msVIcM6/1PoZpi6zPDhG7EkC3P9DeEfnw8FEfBo0Jg0gTSzbZSmabGWDHoN2y72MHi2cFCHUm/D
	0s08PChQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLiux-0000000A2o4-3oTY;
	Mon, 24 Jun 2024 12:35:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A94A0300DCB; Mon, 24 Jun 2024 14:35:29 +0200 (CEST)
Date: Mon, 24 Jun 2024 14:35:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 10/39] sched: Factor out update_other_load_avgs() from
 __update_blocked_others()
Message-ID: <20240624123529.GM31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-11-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-11-tj@kernel.org>

On Wed, May 01, 2024 at 05:09:45AM -1000, Tejun Heo wrote:
> RT, DL, thermal and irq load and utilization metrics need to be decayed and
> updated periodically and before consumption to keep the numbers reasonable.
> This is currently done from __update_blocked_others() as a part of the fair
> class load balance path. Let's factor it out to update_other_load_avgs().
> Pure refactor. No functional changes.
> 
> This will be used by the new BPF extensible scheduling class to ensure that
> the above metrics are properly maintained.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> ---
>  kernel/sched/core.c  | 19 +++++++++++++++++++
>  kernel/sched/fair.c  | 16 +++-------------
>  kernel/sched/sched.h |  3 +++
>  3 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 90b505fbb488..7542a39f1fde 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7486,6 +7486,25 @@ int sched_core_idle_cpu(int cpu)
>  #endif
>  
>  #ifdef CONFIG_SMP
> +/*
> + * Load avg and utiliztion metrics need to be updated periodically and before
> + * consumption. This function updates the metrics for all subsystems except for
> + * the fair class. @rq must be locked and have its clock updated.
> + */
> +bool update_other_load_avgs(struct rq *rq)
> +{
> +	u64 now = rq_clock_pelt(rq);
> +	const struct sched_class *curr_class = rq->curr->sched_class;
> +	unsigned long thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	return update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> +		update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> +		update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
> +		update_irq_load_avg(rq, 0);
> +}

Yeah, but you then ignore the return value and don't call into cpufreq.

Vincent, what would be the right thing to do here?


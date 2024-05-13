Return-Path: <bpf+bounces-29628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451D48C3CD6
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681631C20F7F
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1CF146D70;
	Mon, 13 May 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3eYSRrU"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE9146D62;
	Mon, 13 May 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587466; cv=none; b=qq0ZStQ7wH9LymqD2sPqjolJOFBpUHCtn9SRHMEKAjUHvWjFspAkt9zg8uAhjSH+XLXEFCGzH/ObeInuw3gJppjRD5EbaUjZfTMSTlhe7aaanKO4PHzhf+IoVA6T4Q6oa99iWXKnq5PyC8ubIEDR8ILAT+XRtURyck9k/VzehyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587466; c=relaxed/simple;
	bh=EAmiv7VSHmjNnLH+14OUNkI/+sQMsz87MSk2GKwM+/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV5/xVdDN4EBq2hWkXwsxmdsnYQ90GZiRNiCLnmyUimJe7d92ZyrJPZCo/hVdxJZxXShXTkYU511bOeiMRszi//ssvHB2JyDIyxDe0yAfpzZyIfKlC8QPG9N0/xpCyuefRxClcVubPcRGxTwT6W4tetQmfhxO/cgssPw7MOgsyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d3eYSRrU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=trTboVybSpPr171+KCudUR4Obn/YpkzCtmzvOfCwqIY=; b=d3eYSRrUrt2qXEe99LIREdczLQ
	pHtJ4aKB9ric91TLuOhYMaTSUOokSfB8DCnxWZLFkjBOU2UsH4wfTTGJF3pRmqIm2tFdgSeuqLnhl
	9DlvPa3ZpMMPDqMx52jOvmLLRN+iH/aCk74HTtgGGzXm8+NwBjPokFqGC3ofcCBSyp8ZQT5HRDX+h
	gCq5hqM86P0rAqBV5e6VdRPLToisLcrdTCUj0OZVZuU3PO+aUE1WHqA7+RhE5imb+rqwn3wueC6Cm
	yrLezqNByK5C/b2t4yqhejx/qoCy4hTPx17L7pp9oOqSGBk/nyInjghxXfboiSLdBkYLv2WFRdGEC
	lT2K6Grw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6QfA-00000007nhx-0qqq;
	Mon, 13 May 2024 08:04:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 568513011E8; Mon, 13 May 2024 10:03:59 +0200 (CEST)
Date: Mon, 13 May 2024 10:03:59 +0200
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
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <20240513080359.GI30852@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjgWzhruwo8euPC0@slm.duckdns.org>

On Sun, May 05, 2024 at 01:31:26PM -1000, Tejun Heo wrote:

> > You Google/Facebook are touting collaboration, collaborate on fixing it.
> > Instead of re-posting this over and over. After all, your main
> > motivation for starting this was the cpu-cgroup overhead.
> 
> The hierarchical scheduling overhead isn't the main motivation for us. We
> can't use the CPU controller for all workloads and while it'd be nice to
> improve that,

Hurmph, I had the impression from the earlier threads that this ~5%
cgroup overhead was most definitely a problem and a motivator for all
this.

The overhead was prohibitive, it was claimed, and you needed a solution.
Did not previous versions use this very argument in order to push for
all this?

By improving the cgroup mess -- I very much agree that the cgroup thing
is not very nice. This whole argument goes away and we all get a better
cgroup implementation.

> This view works only if you assume that the entire world contains only a
> handful of developers who can work on schedulers. The only way that would be
> the case is if the barrier of entry is raised unreasonably high. Sometimes a
> high barrier of entry can't be avoided or is beneficial. However, if it's
> pushed up high enough to leave only a handful of people to work on an area
> as large as scheduling, something probably is wrong.

I've never really felt there were too few sched patches to stare at on
any one day (quite the opposite on many days in fact).

There have also always been plenty out of tree scheduler patches --
although I rarely if ever have time to look at them.

Writing a custom scheduler isn't that hard, simply ripping out
fair_sched_class and replacing it with something simple really isn't
*that* hard.

The only really hard requirement is respecting affinities, you'll crash
and burn real hard if you get that wrong (think of all the per-cpu
kthreads that hard rely on the per-cpu-ness of them).

But you can easily ignore cgroups, uclamp and a ton of other stuff and
still boot and play around.

> I believe we agree that we want more people contributing to the scheduling
> area. 

I think therein lies the rub -- contribution. If we were to do this
thing, random loadable BPF schedulers, then how do we ensure people will
contribute back?

That is, from where I am sitting I see $vendor mandate their $enterprise
product needs their $BPF scheduler. At which point $vendor will have no
incentive to ever contribute back.

And customers of $vendor that want to run additional workloads on
their machine are then stuck with that scheduler, irrespective of it
being suitable for them or not. This is not a good experience.

So I don't at all mind people playing around with schedulers -- they can
do so today, there are a ton of out of tree patches to start or learn
from, or like I said, it really isn't all that hard to just rip out fair
and write something new.

Open source, you get to do your own thing. Have at.

But part of what made Linux work so well, is in my opinion the GPL. GPL
forces people to contribute back -- to work on the shared project. And I
see the whole BPF thing as a run-around on that.

Even the large cloud vendors and service providers (Amazon, Google,
Facebook etc.) contribute back because of rebase pain -- as you well
know. The rebase pain offsets the 'TIVO hole'.

But with the BPF muck; where is the motivation to help improve things?

Keeping a rando github repo with BPF schedulers is not contributing.
That's just a repo with multiple out of tree schedulers to be ignored.
Who will put in the effort of upsteaming things if they can hack up a
BPF and throw it over the wall?

So yeah, I'm very much NOT supportive of this effort. From where I'm
sitting there is simply not a single benefit. You're not making my life
better, so why would I care?

How does this BPF muck translate into better quality patches for me?


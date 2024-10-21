Return-Path: <bpf+bounces-42635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B39A6B33
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018311F2141F
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262E91F8914;
	Mon, 21 Oct 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjcTtZZY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805941F4FAB;
	Mon, 21 Oct 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519047; cv=none; b=fk56+yvpGjW46XtNJHEh0n3G5G1f40UyHM1pANu3nURSgEptbe8/h6peXyfE36kqJkKM+macQ1ddOFIisdua9CBF+cvuWXge2Bp7sc2Scfmwcu0mcGHJJEmjJyteK/2di3qh4R7fMfw84eCVlT+F9Yqwb8kHvG71B22Or4VMOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519047; c=relaxed/simple;
	bh=Dpacqvghjn+prdNdw3RYq6t7J0XmTTREpNbPYnoLUrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuK9Ix8InYJlUVl9gZCAsg5MJYn95VsrloSTfeOBfl31YJP0Pqvq4cCsWN585T9MiM58Wc0tGXIbFyaJwfzVDZ3BZQ/kAyhfpFOcQD2Rr3Fad6/pcKMXO0wh3R9XDKw+htq+z7mZQhCJswzy5djsfjiMePhhlyWsIn/Ks9l5cAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjcTtZZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEC8C4CEC3;
	Mon, 21 Oct 2024 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729519047;
	bh=Dpacqvghjn+prdNdw3RYq6t7J0XmTTREpNbPYnoLUrU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CjcTtZZYTojvnp6s7clNB5dxncnCSBBXNhCVQc/Og6/p52mTFfYTX2As9rfdlXcmg
	 wr6bO3JP5AL/X1UOyNuJfk40xyW6a2TmOscAKqwuTVybqXa6WDyeEWkYM8vbYBj+F5
	 pw0+YSW1Sg67Sa+aezPOT2nKpkgZpmjycb1eQPtOGvfbCGqfUVpVpLCQmMlQpVZ7A/
	 0HwcyHMM+hQFh0nWupBDa64V63Di1jx3d5J+UzAc93xz+c4FnMukS/s6JOq5TsN6/P
	 1jmDs5Yca5x/mw0/hR1PM9SsTs4r8znoVg0Yute46kOtKJroaoPx2UBYQC+wt57wpQ
	 9ABize7D40V+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D3B8CE0DFD; Mon, 21 Oct 2024 06:57:26 -0700 (PDT)
Date: Mon, 21 Oct 2024 06:57:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
Message-ID: <b70994c4-04dd-4120-8598-fe1d604a07d8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241008002556.2332835-1-andrii@kernel.org>
 <20241008002556.2332835-3-andrii@kernel.org>
 <20241018101647.GA36494@noisy.programming.kicks-ass.net>
 <CAEf4BzZaZGE7Kb+AZkN0eTH+0ny-_0WUxKT7ydDzAfEwP8cKVg@mail.gmail.com>
 <20241021104815.GC6791@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021104815.GC6791@noisy.programming.kicks-ass.net>

On Mon, Oct 21, 2024 at 12:48:15PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 18, 2024 at 11:22:09AM -0700, Andrii Nakryiko wrote:
> 
> > > So... after a few readings I think I'm mostly okay with this. But I got
> > > annoyed by the whole HPROBE_STABLE with uprobe=NULL weirdness. Also,
> > > that data_race() usage is weird, what is that about?
> > 
> > People keep saying that evil KCSAN will come after me if I don't add
> > data_race() for values that can change under me, so I add it to make
> > it explicit that it's fine. But I can of course just drop data_race(),
> > as it has no bearing on correctness.
> 
> AFAICT this was READ_ONCE() vs xchg(), and that should work. Otherwise I
> have to yell at KCSAN people again :-)
> 
> > > And then there's the case where we end up doing:
> > >
> > >   try_get_uprobe()
> > >   put_uprobe()
> > >   try_get_uprobe()
> > >
> > > in the dup path. Yes, it's unlikely, but gah.
> > >
> > >
> > > So how about something like this?
> > 
> > Yep, it makes sense to start with HPROBE_GONE if it's already NULL, no
> > problem. I'll roll those changes in.
> > 
> > I'm fine with the `bool get` flag as well. Will incorporate all that
> > into the next revision, thanks!
> > 
> > The only problem I can see is in the assumption that `srcu_idx < 0` is
> > never going to be returned by srcu_read_lock(). Paul says that it can
> > only be 0 or 1, but it's not codified as part of a contract.
> 
> Yeah, [0,1] is the current range. Fundamentally that thing is an array
> index, so negative values are out and generally safe to use as 'error'
> codes. Paul can't we simply document that the SRCU cookie is always a
> positive integer (or zero) and the negative space shall not be used?

We are looking at a few approaches, but they all guarantee that the
return value will be non-negative.  My current guess is that we will
just document this non-negative return value, but in all cases, you
should feel free to assume non-negative starting now.

							Thanx, Paul

> > So until we change that, probably safer to pass an extra bool
> > specifying whether srcu_idx is valid or not, is that OK?
> 
> I think Changeing the SRCU documentation to provide us this guarantee
> should be an achievable goal.
> 
> > (and I assume you want me to drop verbose comments for various states, right?)
> 
> I axed the comments because I made them invalid and didn't care enough
> to fix them up. If you like them feel free to amend them to reflect the
> new state of things.


Return-Path: <bpf+bounces-72006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF2C05241
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 10:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5ED1AE6157
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629873081D8;
	Fri, 24 Oct 2025 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e0hazy2m"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23B30649F;
	Fri, 24 Oct 2025 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295507; cv=none; b=OF0PlYU3b8DRq0fD9LcegTGWn1HhM72kioSuhnI2r3wna83i1Sw8GRVvzTz17P21JL+zZrYcUbq9ckdDrzNBBy2XM7NoPeh3y4jZP/NhN9qUP6oyWrVSsDEanp4xbwJr4uefv2Z8CAYDfD9uW2Psh+YcK0fTxvSPqHRGIPPYYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295507; c=relaxed/simple;
	bh=5WRKXr/s4dS5ied+yVXMNfNJW6eRvSH+xOfGJEEcBN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP3lf12lmUgPPi7KHC2kEchHwbSXcbCri1bzYPiADkE6264y5MvgtQrKK7wcaQPWhfMrmxuR3vB6K+ZYOSMR9FVsBjiUj8Tr6wS0IckNh9jH91epSlI561PxRKpM79RC4BmCuN7rSF+PG8Vsh9EE4UNC/AKmbR0MhXTMZlbnNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e0hazy2m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K+lXc2trFeRORJCdrbLRdnsn5WXxpv1QGwVNva4aeSU=; b=e0hazy2mF00Finsa5zVtK3ono5
	9hzGF22bXfr877SBfHF59FO0XD26xLrJ21W58PDvjn4wTyPINHPD45IM3YVOec4i45m2C9TaxKyif
	SQiLqeX13XAZWATfafUrb1a85+gCqPeZh5kQuiBBFxy1jJeEQHIyblcmi6zXLFc08z88RRUI0FLcU
	1SK33skLzDAZOOqEIpM6f3p6WTEMGlRczxNcUfgi0dTFspRbvHgtxsKtL2QC98xla1PGgzO8uUWOh
	DGRSf4DF1F2H1FCDMJd8puleei2lHYsBWLU2/x8fLYscUne8mrOYXGMIdsmd5+k9RecQ0XdrkKsVw
	qxJriPzw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCD8S-0000000CEiB-3QsI;
	Fri, 24 Oct 2025 08:26:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C578730029E; Fri, 24 Oct 2025 10:26:56 +0200 (CEST)
Date: Fri, 24 Oct 2025 10:26:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251024082656.GS4067720@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251023124057.2a6e793a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023124057.2a6e793a@gandalf.local.home>

On Thu, Oct 23, 2025 at 12:40:57PM -0400, Steven Rostedt wrote:
> On Thu, 23 Oct 2025 17:00:02 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > +/* Deferred unwinding callback for task specific events */
> > +static void perf_unwind_deferred_callback(struct unwind_work *work,
> > +					 struct unwind_stacktrace *trace, u64 cookie)
> > +{
> > +	struct perf_callchain_deferred_event deferred_event = {
> > +		.trace = trace,
> > +		.event = {
> > +			.header = {
> > +				.type = PERF_RECORD_CALLCHAIN_DEFERRED,
> > +				.misc = PERF_RECORD_MISC_USER,
> > +				.size = sizeof(deferred_event.event) +
> > +					(trace->nr * sizeof(u64)),
> > +			},
> > +			.cookie = cookie,
> > +			.nr = trace->nr,
> > +		},
> > +	};
> > +
> > +	perf_iterate_sb(perf_callchain_deferred_output, &deferred_event, NULL);
> > +}
> > +
> 
> So "perf_iterate_sb()" was the key point I was missing. I'm guessing it's
> basically a demultiplexer that distributes events to all the requestors?

A superset. Basically every event in the relevant context that 'wants'
it.

It is what we use for all traditional side-band events (hence the _sb
naming) like mmap, task creation/exit, etc.

I was under the impression the perf tool would create one software dummy
event to listen specifically for these events per buffer, but alas, when
I looked at the tool this does not appear to be the case.

As a result it is possible to receive these events multiple times. And
since that is a problem that needs to be solved anyway, I didn't think
it 'relevant' in this case.

> If I had know this, I would have done it completely different.

I did do mention it here:

  https://lkml.kernel.org/r/20250923103213.GD3419281@noisy.programming.kicks-ass.net

Anyway, no worries. Onwards to figuring out WTF the unwinder doesn't
seem to terminate properly.


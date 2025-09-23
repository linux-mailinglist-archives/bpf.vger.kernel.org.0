Return-Path: <bpf+bounces-69366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0698B955C6
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1067A9603
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB08B286413;
	Tue, 23 Sep 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cwlNGojy"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431B13B797;
	Tue, 23 Sep 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621710; cv=none; b=BuhvGye+aSaosVYTK/in0e5FSv8ToBwuEo/y1epvP6XtN0w0HOfkqqymoQih9fUCBgYfxHJUOc6IdT+h+9HPskt2meeE3uKRiOSsHdg6dPSTKke2kQqbGp7/qGStpl0e14IgiB6LvBRYWCdMYFPeD75strelpFh5V6HeTSYIHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621710; c=relaxed/simple;
	bh=H66pboQoJo8IfGy7SEDJFTFcAXDk7qmARTyg7LlRVCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRfJgmRCBldGsakVxZdXVN965zt5AySm+gInG92z9uN8tDP94y/rohzOaxs0Z0AHDpOkVJUuaX6S9Y3BnrHdTt5MoBEyRI0/ACP/kz9vKif6anr/cD8I3rv1VjJuUsXSDtLINXRN6k1wv463V+p1xUYq8NPG6ZJtIgYjAd7QnK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cwlNGojy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZJB/cAN/NZ934Eo6FWgaO0JE3BoJmkJPozs04WZwYr8=; b=cwlNGojyeXZkx1IDwcDvXrJ1w0
	Ho0qAHQV8sMu2BD2cf4CHBuh83EGUUHL0rgtwpme1MxXaYg9y5xwEHe1MjE3HHTdgjsnmaH10lnsY
	CBwRv1ksl3B3VuJyiPmwqB121G9AVfp5H9Q2MFDRwJV9A1+xKGb9Lk10NpJ86X14KkZ0riYgfK0L5
	YcXj7QJs5S7mUhIVfkmlBk6ghEaTNs/HpPOIzOAFIkZM4+RzOlmZG4Pyw4afjuqm5Qi+ZqCR8Euz+
	lVtmbn5F//doA+RkSYiQnZ9fSa6J+aengGUpvfH4aENuCuv/UJVff83Zygzwpgcc8/dMT5Nh8q/5C
	P1zZaBeA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0zq6-00000009YwE-1iUF;
	Tue, 23 Sep 2025 10:01:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6334830049C; Tue, 23 Sep 2025 12:01:37 +0200 (CEST)
Date: Tue, 23 Sep 2025 12:01:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
Subject: Re: [RESEND][PATCH v15 2/4] perf: Support deferred user callchains
Message-ID: <20250923100137.GC3419281@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
 <20250908171524.605637238@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908171524.605637238@kernel.org>

On Mon, Sep 08, 2025 at 01:14:14PM -0400, Steven Rostedt wrote:
> +	/*
> +	 * All accesses related to the event are within the same RCU section in
> +	 * perf_event_callchain_deferred(). The RCU grace period before the
> +	 * event is freed will make sure all those accesses are complete by then.
> +	 */
> +	rcuwait_wait_event(&event->pending_unwind_wait, !event->pending_unwind_callback, TASK_UNINTERRUPTIBLE);

You need a narrower terminal, this is again excessive. I mostly code
with my screen split in 4 columns (3 if I can't find my glasses), and
that gets me around 90 character columns.

> +	if (event->attr.defer_callchain)
> +		init_task_work(&event->pending_unwind_work,
> +			       perf_event_callchain_deferred);

And let me hand you a bucket of {}, I've heard they're getting expensive
over in the US due to this tariff nonsense :-)


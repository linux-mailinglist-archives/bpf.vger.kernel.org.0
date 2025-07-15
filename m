Return-Path: <bpf+bounces-63359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F52B06671
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 21:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D6B1AA28AE
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADBD2BE7C2;
	Tue, 15 Jul 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mWO1O5FI"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0C29E117;
	Tue, 15 Jul 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606302; cv=none; b=Jm91whS2ojz1VZWQeZhcrME4UlRPEdCT3VRVuDwxd+ms/Oh7TR2UEtKlEKJEx6loCwnuB/Glabq++bOTSD7t5CzbbnM30zTUnfz00j3p8PkwJ6ssQS43tRXtVmbG0vcWyGA4OGY31PAYXW7A0VeR9DfVWVIDEtAGf0uJttzjKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606302; c=relaxed/simple;
	bh=oh1WiQHU+OESyTvxNEBn2VoQ7xQAzNKKIYjLsgFQQDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZrG69xk61kzNMdy3AursDVtfnAD6pIFMv90XmoWVK2ZudvK4OKB1P2d/uT4fuw5eCM7yoSewljW/9sLKmpzajT2IfQV1knUyO+vLvLOesIWJfkjfaO67+83/xsjBub+G0obBzNWl5+J5FdH0w2oO47YTxjZMlBViFYgue7/DRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mWO1O5FI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GyoqrrjfwZIc2bgIVXvyQBYuaCWu28O+RO4kH1BswgU=; b=mWO1O5FIauCk7o5Rn1QyTfx3+W
	weV2av1fhnvImLWnM7FGCbqJIRkC+5zWnnTogRwQTkbvZu3DYplR6qzkZ/huZrvpFNhum5YVBOgg+
	1qeOvzKmNKpBnms2WBQZ/heXIYVk89yvXtIJP80ZjgKyD+Nvb7Xgy7t2yq9yDqy+EfKm38T4qe9ch
	tuzjSFfwliroH9vyikOvfADqsmMlNhkD5RC6Xmovk7+NpMBLIMg7+EAVvkRh8tqZWsmfHrBY9GNMK
	wA2iE2uWHR2eoW7ZFgyiHzgXyr9ntF1ufb1f2ysyGlsb+92rAjBKrky74lVdF7yK+KrNZogQxEGL5
	DC52nLQA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubkxK-0000000DV2q-1fxc;
	Tue, 15 Jul 2025 19:04:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2EFEE300230; Tue, 15 Jul 2025 21:04:45 +0200 (CEST)
Date: Tue, 15 Jul 2025 21:04:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to user
 space
Message-ID: <20250715190445.GG4105545@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
 <20250708012359.345060579@kernel.org>
 <20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
 <20250715084932.0563f532@gandalf.local.home>
 <20250715140650.19c0a8ed@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715140650.19c0a8ed@batman.local.home>

On Tue, Jul 15, 2025 at 02:06:50PM -0400, Steven Rostedt wrote:
> On Tue, 15 Jul 2025 08:49:32 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > >   *
> > > > - * Return: 1 if the the callback was already queued.
> > > > - *         0 if the callback successfully was queued.
> > > > + * Return: 0 if the callback successfully was queued.
> > > > + *         UNWIND_ALREADY_PENDING if the the callback was already queued.
> > > > + *         UNWIND_ALREADY_EXECUTED if the callback was already called
> > > > + *                (and will not be called again)
> > > >   *         Negative if there's an error.
> > > >   *         @cookie holds the cookie of the first request by any user
> > > >   */    
> > > 
> > > Lots of babbling in the Changelog, but no real elucidation as to why you
> > > need this second return value.
> > > 
> > > AFAICT it serves no real purpose; the users of this function should not
> > > care. The only difference is that the unwind reference (your cookie)
> > > becomes a backward reference instead of a forward reference. But why
> > > would anybody care?  
> > 
> > Older versions of the code required it. I think I can remove it now.
> 
> Ah it is still used in the perf code:
> 
> perf_callchain() has:
> 
>         if (defer_user) {
>                 int ret = deferred_request(event);
>                 if (!ret)
>                         local_inc(&event->ctx->nr_no_switch_fast);
>                 else if (ret < 0)
>                         defer_user = false;
>         }
> 
> Where deferred_requests() is as static function that returns the result
> of the unwind request. If it is zero, it means the callback will be
> called, if it is greater than zero it means it has already been called,
> and negative is an error (and use the old method).
> 
> It looks like when the callback is called it expects nr_no_switch_fast
> to be incremented and it will decrement it. This is directly from
> Josh's patch and I don't know perf well enough to know if that update
> to nr_no_switch_fast is needed.
> 
> If it's not needed, we can just return 0 on success and negative on
> failure. What do you think?

I'm yet again confused. I don't see this code differentiate between 1
and 2 return values (those PENDING and EXECUTED).

Anyway, fundamentally I don't think there is a problem with backward
references as opposed to the normal forward references.

So leave it out for now.


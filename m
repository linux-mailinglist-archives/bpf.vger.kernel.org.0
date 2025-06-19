Return-Path: <bpf+bounces-61059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90742AE01A3
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100A11899B02
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC157263C8F;
	Thu, 19 Jun 2025 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jJPrO+oy"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35C166F1A;
	Thu, 19 Jun 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325061; cv=none; b=PKZC4USKGsZWz9bw9CPNYoMiw7ukEW0hAqOB1WrpHkbYcw2Wl+epsNfFZc3Aul6vKzZ0Hmu1VLfCbSAFEdMRGtlrnjYJfRzv1gl15wLPQYnfzmxE3Yj7Cvf+nN14+YGK/cE4YJURCV26dn0LFAdBm+A975QgJtO4sWaBOA1gjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325061; c=relaxed/simple;
	bh=JbzrzqA0/p8I8EtwwZirDCjv+hDsXgCgRktfC4CCX8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvE7UWpao8VGsbuwBIn9PAqf8ObWCTHhzhmm/ra5aY4q/OmS97Y+0Hewpscy570IeT8MOQmc+AiHXdKk0QanR7jyo52UWuvynZ5xrDCehUKer9KvY/8gk/ZW6PA0hbAyyEtNe9b0hApXKNmfxxtPZJzGGZ22cN4FgqnSudraqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jJPrO+oy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2JeEE3ggrTpBGQUKEsYkqTFhXO/k+e9yZjnLbjYAA0g=; b=jJPrO+oyphGhQXrIlBketeJfcc
	cIiw+MrKL9bpn3Ptn4rnBqLPveCu+ARDsdTDlQFCeUQND3hWkq+k80DqEvYJuhRAyTwwHJpQKfmNe
	7Lhn1PjytOd6PIMHJ0VVsX4bCtKisbs4rL1f8UlsSfJokaga5DqKe/TW3thLjVH9maXZlKZFBTc6S
	cGz2zm+/Gsrz7ZuP9j+/TQiETjLPmvCKLLqu38y0UoqdJEvsZaChVow7aVSoTvTZD05l7yYs1DRF4
	xhIGnUYBdDy0Klhf6FT2Z5SArEl2t89TmMj1xHBWzB46LKxVyWzg4Xh6h9IAcebukubV4eAaZ6rdz
	LINNUghg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSBV9-000000080wO-1Zt3;
	Thu, 19 Jun 2025 09:24:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 74F823088F2; Thu, 19 Jun 2025 11:24:06 +0200 (CEST)
Date: Thu, 19 Jun 2025 11:24:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250619092406.GG1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.938845449@goodmis.org>
 <20250619083415.GZ1613376@noisy.programming.kicks-ass.net>
 <20250619043733.2a74d431@batman.local.home>
 <20250619084427.GA1613376@noisy.programming.kicks-ass.net>
 <20250619084813.GG1613633@noisy.programming.kicks-ass.net>
 <66B9E72C-4FDF-46DF-9231-BED06A6000D9@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66B9E72C-4FDF-46DF-9231-BED06A6000D9@goodmis.org>

On Thu, Jun 19, 2025 at 05:10:20AM -0400, Steven Rostedt wrote:
> 
> 
> On June 19, 2025 4:48:13 AM EDT, Peter Zijlstra <peterz@infradead.org> wrote:
> >On Thu, Jun 19, 2025 at 10:44:27AM +0200, Peter Zijlstra wrote:
> >
> >> Luckily, x86 dropped support for !CMPXCHG8B right along with !TSC. So on
> >> x86 we good with timestamps, even on 32bit.
> >
> >Well, not entirely true, local_clock() is not guaranteed monotonic. So
> >you might be in for quite a bit of hurt if you rely on that.
> >
> 
> As long as it is monotonic per task. If it is not, then pretty much all tracers that use it are broken.

It is monotonic per CPU. It says so in the comment.

The inter-CPU drift is bounded to a tick or something.

The trade-off is that it can be the same value for the majority if the
that tick.

The way that thing is set up, is that we use GTOD (HPET if your TSC is
buggered) snapshots at ticks, set up a window to the next tick, and fill
out with TSC deltas and a (local) monotonicity filter.

So if TSC is really wild, it can hit that window boundary real quick,
get stuck there until the next tick.

Some of the early had TSC affected by DVFS, so you change CPU speed, TSC
speed changes along with it. We sorta try and compensate for that.

Anyway, welcome to the wonderful world of trying to tell time on x86 :-(


Today, most x86_64 chips made in the last few years will have relatively
sane TSC, but still we get the rare random case it gets marked unstable
(they're becoming few and far between though).

x86 is one of the worst architectures in this regard -- but IIRC there
were a few others out there. Also, virt, lets not talk about virt.


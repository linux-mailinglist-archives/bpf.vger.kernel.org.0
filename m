Return-Path: <bpf+bounces-73626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D563FC35C48
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 14:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E351A21C68
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 13:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EDE3168EF;
	Wed,  5 Nov 2025 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTabv0Ir"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0F18A921;
	Wed,  5 Nov 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348130; cv=none; b=H3MTs+FS05Ryys+ZqWvhhnvYDjv9hLZyxHInCtP3X6cyqhueraOCezS02B3wWwHpDZHNTZdZ5Wi7aGa+rxfbIyFmdwUYnSP++14uLPFoaglRloQVSsAC2zUhEpDpihEHmVkHkMpMhM4KoZ7lTpOvCWCtrptJ+tUIZfw1eGsink0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348130; c=relaxed/simple;
	bh=tIXN69NhcMpIUNMTvR0fHGOEfPzcKsrg05Mq0Prh/K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehlUJMjIcmPVMQtGzLVta79s8D+oI9bv25+SIXwEMh2rGG2DB/z1gzrc0YH49W9HjKHmD0PU1D8Xn0SjlHRFrdABnhAqNY68xib2dMtIvs15Y+9ENB3HWUKz7j5NvKJu0yEjnpEn8QjlnkH8ApFldXfbdRgpWE09DDJh5sPE4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HTabv0Ir; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yagpRY+a+yMfMlbGTqpj5YyUleDnBH+cyCzDbrx1n98=; b=HTabv0IrhUjTaGC+iDA5NWyTyw
	kPDwLnrjnlGPgKXG4boDqLcwLrIL+rjTJUItAWTPD756A+vne0GUUnW1wT/FBRrAr+jLZk4al6xI3
	RpFjq6tU45rllMEwjdqPcDWP0NUQZBEonp+008EJgEYSz5UT6UoCKOYrXln/kvuacwpYGCSlZof7z
	X0EK7q5s6x0b4c6vDM0GX3ynE7b8DGfkdXkaAm1WQD38svy2sNAXf0hJb5wEJpYdXnxQJgttrvFXn
	MRVh7W8KAf4cd+kaHW2QDBG3ABg7EGWyw9uxP0MLLjFykOvh2GmktSajTcv69rIF4EHeNWhJUqn80
	uDtMqikg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGdFZ-00000006g3w-0c3R;
	Wed, 05 Nov 2025 13:08:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A1A9E300230; Wed, 05 Nov 2025 14:08:33 +0100 (CET)
Date: Wed, 5 Nov 2025 14:08:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
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
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>,
	Carlos O'Donell <codonell@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251105130833.GN3245006@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251024092926.GI4068168@noisy.programming.kicks-ass.net>
 <20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
 <a59509f0-5888-4663-9e82-98e27fc3e813@linux.ibm.com>
 <20251024140815.GE3245006@noisy.programming.kicks-ass.net>
 <20251024145156.GM4068168@noisy.programming.kicks-ass.net>
 <lhuldkmujom.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhuldkmujom.fsf@oldenburg.str.redhat.com>

On Tue, Nov 04, 2025 at 12:22:01PM +0100, Florian Weimer wrote:
> * Peter Zijlstra:
> 
> > +/*
> > + * Heuristic-based check if uprobe is installed at the function entry.
> > + *
> > + * Under assumption of user code being compiled with frame pointers,
> > + * `push %rbp/%ebp` is a good indicator that we indeed are.
> > + *
> > + * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
> > + * If we get this wrong, captured stack trace might have one extra bogus
> > + * entry, but the rest of stack trace will still be meaningful.
> > + */
> > +bool is_uprobe_at_func_entry(struct pt_regs *regs)
> 
> Is this specifically for uprobes?  Wouldn't it make sense to tell the
> kernel when the uprobe is installed whether the frame pointer has been
> set up at this point?  Userspace can typically figure this out easily
> enough (it's not much more difficult to find the address of the
> function).

Yeah, I suppose so. Not sure the actual user interface for this allows
for that. Someone would have to dig into that a bit.


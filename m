Return-Path: <bpf+bounces-72713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA0CC19D9F
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 11:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66BE1C84B22
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617C3009F5;
	Wed, 29 Oct 2025 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kGOneHR8"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9E24C068;
	Wed, 29 Oct 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734317; cv=none; b=nFwMxbFiylsM6UypxvbWDeCyYEkHRW2bhLjTk5V+B+5vsKdHtwT0KSaqZzaqK4rBiooAdPQulZUfGmA1HY7NgbK4aZUEvB6nRt7xEErR6LnA76S8quMVdIscS0QCKiu9j6mzqPGsNrhGDTus9O9z+/sMu7NehHM/ryhSgiyoQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734317; c=relaxed/simple;
	bh=3s31/yBaG51d9qnkQpUcKyMtEB4jvcWcKzIO66o2Bdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7WjMRXuMGoYHNyrrIL2sUQ/FOT5Ze7hP/bqFLgq8pjQL5r/F2h8nW6+yE2wznLaI9qel9r4ac+zKsvzc3LUfO7FIoLTUNMX38SmrWsV/yuliNA2C/79gbvVXTqU8+LVDpr8Gu2UyCYysfAIqdjBKQ8W6a1oZyHAL4WbpW7FMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kGOneHR8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eHGSKAl2qgha8GO/z2VZF0A4lrkYk6RSodk4W7L/YGU=; b=kGOneHR8G49DYpxW0CsTg/SSBu
	1QLUKocXaBLRrboFtgp9rpEIe90u8Ac8mpcto3HR0Pi9YcXQvxTWmJrhjY1Jrm75WDk/SvW0tfdJp
	g3vGSwBWIhAHwNfE1FrEAFY1V+33c4QsWkRM8KqSysLu0tkgOd+Uag90pc5q1gtxX4XlqqI4t8whm
	vQJ4S3KphBNAefAKEzxzstdcBKIPVk1swmAs4UjS7Fz501D2KRkokYp43CpgEpu+7RHJN6LRC4319
	ghkkOnNXGyeewm0piiI0tP9nsuoactzwTtaE4P6pweEbE+kY4qydJOVeYShLOzp5CAzCsMN9heZpd
	B6B7vytA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3ZM-00000007WWi-1SWE;
	Wed, 29 Oct 2025 10:38:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 17B29300289; Wed, 29 Oct 2025 11:38:21 +0100 (CET)
Date: Wed, 29 Oct 2025 11:38:21 +0100
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
Subject: Re: [PATCH v16 4/4] perf tools: Merge deferred user callchains
Message-ID: <20251029103821.GH3419281@noisy.programming.kicks-ass.net>
References: <20250908175319.841517121@kernel.org>
 <20250908175430.639412649@kernel.org>
 <20251002134938.756db4ef@gandalf.local.home>
 <20251024130203.GC3245006@noisy.programming.kicks-ass.net>
 <20251028200955.0340ae1c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028200955.0340ae1c@gandalf.local.home>

On Tue, Oct 28, 2025 at 08:09:55PM -0400, Steven Rostedt wrote:
> On Fri, 24 Oct 2025 15:02:03 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > The sample__merge_deferred_callchain() initializes both
> > > orig_sample.deferred_callchain and the callchain. But now that it's not
> > > being called, it can cause the below free to happen with junk as the
> > > callchain. This needs:
> > > 
> > > 		else
> > > 			orig_sample.deferred_callchain = false;  
> > 
> > Ah, so I saw crashes from here and just deleted both free()s and got on
> > with things ;-)
> 
> I just downloaded your tree again and it doesn't look like it was updated.
> 
> Just didn't want you to forget about this ;)

Done, this should all be in tip/perf/core now. Thanks!


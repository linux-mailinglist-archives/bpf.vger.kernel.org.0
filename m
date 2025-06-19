Return-Path: <bpf+bounces-61057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD171AE0186
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB92188746B
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06277255240;
	Thu, 19 Jun 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OfBQVq47"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9721FAC4E;
	Thu, 19 Jun 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324290; cv=none; b=tD3qCc1rnAZVYnRIly9t5/MbeSuHYL7PI/iX53XUKEDivEzGsAwuItRUE/luzowqNh2MJw5iHKEhHue4r/XW6ppGIH8Ae9672n4PzX24nJO7dDNsXYOYOCVebtFNRsBMDlMeOTSgl/pdp2Rsu9HO2NXWfl9BGrkA+kiWw0cV+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324290; c=relaxed/simple;
	bh=id+4Obe9bYVtCSedihssbxztPpNf7tuDB/mRLWXQypM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgoLrW0nZHBFP81BDuRLCde4W+qIV6tCHQfIHKjkyEsEnMi8gAL9fF31YlnAtwd3i9vIRYli/aR3ly+kRzzKPvcYH9llgrhZKADC/ynSPlHJNY+tB324X72PCStYHzbr/TnGJaaRJByBHB01r0Dt7zg0xViFCVVvxRuhiNbyvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OfBQVq47; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/freNvJTihapOdWiWbhhHfrSf90bbOLe8PP6624NwlE=; b=OfBQVq47aP/lu+UVT99qBe3Asp
	X1yZ6QQtYySfP88Pg2P1I7ylGurdZcTJKpI3+8gGjBEAKaDy/pN2glRavep/6Gy3Ttqog0qp2IGBe
	z9gnEaNmM9QKuaWyd/SQfSbuZfSbuiMDa7zCCx8nntINh9+2qnYzdGNWZ6EowbcmO+Cgl50rk1I7L
	TKDI0uHJBcXrm2M0B/71Tty/09QQjPr58SSrIcUAoLiSX3HUSalRMjDglLiSC1zomaNhdW8qIlMiA
	+oGD2MmFUJEorVDIOQDZ21iisGRer0jXavvjYgIRwGbg+n0lpfrPnz3cM+6M3alXonZbEROc7Q0Ak
	ut/o2bDw==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSBIn-00000007zbt-3UYC;
	Thu, 19 Jun 2025 09:11:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 58196307FB7; Thu, 19 Jun 2025 11:11:21 +0200 (CEST)
Date: Thu, 19 Jun 2025 11:11:21 +0200
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
Subject: Re: [PATCH v10 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250619091121.GF1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.770214773@goodmis.org>
 <20250618184620.GT1613376@noisy.programming.kicks-ass.net>
 <20250618150915.3e811f4b@gandalf.local.home>
 <20250619075008.GU1613376@noisy.programming.kicks-ass.net>
 <20250619045659.390cc014@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619045659.390cc014@batman.local.home>

On Thu, Jun 19, 2025 at 04:56:59AM -0400, Steven Rostedt wrote:

> We have a many to many relationship here where a task_work doesn't work.
> 
> That is, you can have a tracer that expects callbacks from several
> tasks at the same time, as well as some of those tasks expect to send a
> callback to different tracers.
> 
> Later patches add a bitmask to every task that gets set to know which
> trace to use.
> 
> Since the number of tracers that can be called back is fixed to the
> number of bits in long (for the bitmask), I can get rid of the link
> list and make it into an array. That would make this easier.

So something sketching this design decision might be useful. Perhaps a
comment in the file itself?

I feel much of this complication stems from the fact you're wanting to
make this perhaps too generic.




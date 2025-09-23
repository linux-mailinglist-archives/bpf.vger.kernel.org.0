Return-Path: <bpf+bounces-69398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10B1B95DA8
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A761625D0
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1AE322DBB;
	Tue, 23 Sep 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t47aui4f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65013245006;
	Tue, 23 Sep 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630986; cv=none; b=pEOAgRa3IBkBnJBNJc/BUQh5QYN7fAbqK5oNqB24qkHnEELuJHDKeSy4mMslEWZFcGRDz4N2bWs72NeaqwsdneJzZO48OnwyjFuy+vaZ3VDY2Vp4Y2D+5ntvYD3sj0HUqU3La0FF+tJBhmGFHnCylo3JeYs8B4kgt4VmLg5sl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630986; c=relaxed/simple;
	bh=BYP+piG4+h2S+71BxBsBcFE0M7inyCGui7t2SCh0h/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EucgIZu/d9ybkhfhBPlr9NZrMc5SXyVZsvTlMdsbNujoKNgC1T4kLV5zMHAS693PwtIS58JJcJS8XLoHL3yZ57/xDxQCMsySqid7cHZ2x/YNXYqyD6+5nvW4brikokRaap7q/IGHteORodNEhjlMzoACrHIHukTjeKx3x2Ok72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t47aui4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7A0C113CF;
	Tue, 23 Sep 2025 12:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758630985;
	bh=BYP+piG4+h2S+71BxBsBcFE0M7inyCGui7t2SCh0h/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t47aui4fs9uGM4H0GkV9w2oqvo9NSKsp5psPxtP7VbHaYFqG0cP8PEcpuUHtCEI57
	 lh4BnyqT8Wlh23l4vzQcI6j08kzOA+VvpAjrZdAKyLmfHtW/WQQtwhno5kdmWrPT1Y
	 xI+HM9VZSNHKbUpTxdnc8HRNSuvK4QHL5iYuNrvpL367ixsst6kc7bqTROfzsIpt2n
	 WrZ1ZFSi84XRZyjiJEp6tU51gVbYF4iRt32TMfb9naU5eobHeGI/LcK+HLV/pvr0Sb
	 nkPjfkd4JnV3Rvm1S3kQdcx7c6OnIzfIcUT+R+49Ap+J7QPl1T3HdgzfqlQk7NB1nZ
	 1p2dqq/T4NRnw==
Date: Tue, 23 Sep 2025 08:36:16 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Sam James
 <sam@gentoo.org>, Kees Cook <kees@kernel.org>, Carlos O'Donell
 <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 2/4] perf: Support deferred user callchains
Message-ID: <20250923083616.0413966a@batman.local.home>
In-Reply-To: <20250923103213.GD3419281@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
	<20250908171524.605637238@kernel.org>
	<20250923103213.GD3419281@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 12:32:13 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> So the thing that stands out is that you're not actually using the
> unwind infrastructure you've previously created. Things like: struct
> unwind_work, unwind_deferred_{init,request,cancel}() all go unused, and
> instead you seem to have build a parallel set, with similar bugs to the
> ones I just had to fix in the unwind_deferred things :/
> 
> I'm also not much of a fan of nr_no_switch_fast, and the fact that this
> patch is limited to per-task events, and you're then adding another 300+
> lines of code to support per-cpu events later on.
> 
> Fundamentally we only have one stack-trace per task at any one point. We
> can have many events per task and many more per-cpu. Let us stick a
> struct unwind_work in task_struct and have the perf callback function
> use perf_iterate_sb() to find all events that want delivery or so (or we
> can add another per perf_event_context list for this purpose).
> 
> But duplicating all this seems 'unfortunate'.

We could remove this and have perf only use the CPU version. That may
be better in the long run anyway, as it gets rid of the duplication. In
fact that was the original plan we had, but since Josh wrote this patch
thinking it was all that perf needed (which ended not being the case),
I still kept it in. But I believe this will work just the same as the
CPU tracing which uses all the other infrastructure.

-- Steve



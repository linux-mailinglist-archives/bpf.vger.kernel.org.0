Return-Path: <bpf+bounces-69183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE50B8F471
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 09:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CE7189F141
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 07:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5E2F5326;
	Mon, 22 Sep 2025 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T3Ym5TLa"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FDD212578;
	Mon, 22 Sep 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525805; cv=none; b=heUG2bUYvfv9awBQ/9q/HEEcqFi3mr24k4guqt8wRsoAnhP7QRAjyvBsCN64EXNl6kq+e1g9QwGoFBp8Ek+Yey4OifxFFG8nJhfKw/eg3YJ4j+T58LN8DaQE+iq0I+jok9byOKgSoPdPz8E8gnwfyZNWXvsKZjLGYPAOsCUxEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525805; c=relaxed/simple;
	bh=4gSyreMsz1SzvIt6bu5X0lC8HZlBc0UBFd5PiUnExYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwI8Uw3UMtR7sZNZLensq+vOz7AFdBZitU/ujUz4UNCeRReaw0vcutQffxO3AQzXv2ivrfX0fZtPkoBF0rpq5vnZKuLfHfOdsKZ64VCWtHO7DNEAuoY6DzMsRUhlSSq1f3A+XXw2CszYusZNk3ibJHc8FSW9TbRf0ggstNL2+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T3Ym5TLa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q5KkD/XraiOQEskxvcqMgy2jL5L1tqkNah5t780SQt0=; b=T3Ym5TLazEK0t2f+z5h2KQHIMi
	1j2dupNIlqDkh4Ghy4uyic8EuujRhsK4rRD5H0U5BsaQMmbOSXPwTDTsXSBwxIV9siwWfHiE9DSsQ
	2Gm218In5mNsgrdj8cJeqLw6jXW45JSkOwDX0Z9zv5PphZWmycVKtKed4/+S2L9l1eETz0iO63m86
	V1erXovLcT987e3QUqu+QM+6QVIzA3SgD9l6NZgHeXdrWHJJKV7l7UCX/wL0gxo6bnmOL7MlYLzBB
	9hB6O+50/tEF+Po8UpnMThPmYXBMCX6wHN/7pJt8aIlnH6flF0dYzGiu89BJcCvFz99t6xyWd9R9b
	rsiwe3rQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0atA-00000002q7Z-2WsD;
	Mon, 22 Sep 2025 07:23:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AC94A300230; Mon, 22 Sep 2025 09:23:07 +0200 (CEST)
Date: Mon, 22 Sep 2025 09:23:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: Re: [RESEND][PATCH v15 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250922072307.GQ4067720@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
 <20250918114610.GZ3419281@noisy.programming.kicks-ass.net>
 <20250918111853.5dc424df@gandalf.local.home>
 <20250918172414.GC3409427@noisy.programming.kicks-ass.net>
 <20250918173220.GA3475922@noisy.programming.kicks-ass.net>
 <20250918151018.7281647b@batman.local.home>
 <pde32olzdlqvbom5bya5exndcrfgsw7lmffy6uav5yoplonzj3@ddb2b5sihlpx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pde32olzdlqvbom5bya5exndcrfgsw7lmffy6uav5yoplonzj3@ddb2b5sihlpx>

On Fri, Sep 19, 2025 at 04:34:02PM -0700, Josh Poimboeuf wrote:
> On Thu, Sep 18, 2025 at 03:10:18PM -0400, Steven Rostedt wrote:
> > On Thu, 18 Sep 2025 19:32:20 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > Now, task_work_run() is in the exit_to_user_mode_loop() which is notably
> > > > *before* exit_to_user_mode() which does the unwind_reset_info().
> > > > 
> > > > What happens if we get an NMI requesting an unwind after
> > > > unwind_reset_info() while still very much being in the kernel on the way
> > > > out?  
> > > 
> > > AFAICT it will try and do a task_work_add(TWA_RESUME) from NMI context,
> > > and this will fail horribly.
> > > 
> > > If you do something like:
> > > 
> > > 	twa_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
> > > 	task_work_add(foo, twa_mode);
> > > 
> > > it might actually work.
> > 
> > Ah, the comment for TWA_RESUME didn't express this restriction.
> > 
> > That does look like that would work as the way I expected task_work to
> > handle this case.
> 
> BTW, I remember Peter had a fix for TWA_NMI_CURRENT, I guess it got lost
> in the shuffle or did something else happen in the meantime?
> 
>   https://lore.kernel.org/20250122124228.GO7145@noisy.programming.kicks-ass.net

Oh, yeah, I had completely forgotten about all that :-)

I'll go stick it in the pile. Thanks!


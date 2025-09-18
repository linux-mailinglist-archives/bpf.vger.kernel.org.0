Return-Path: <bpf+bounces-68832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5610AB86334
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 19:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3373F5654A5
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAEC31A7EF;
	Thu, 18 Sep 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sQ0wo1M3"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73DF31A7E1;
	Thu, 18 Sep 2025 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216273; cv=none; b=uZ9U5Tb1ddVTH0begWa/c99ObZwf0Kw7imsA2mHeZJgeiPjQ4yCHbnAggqUyo92NMqchs7ZrwvuKEjxlDAXEzea4+oef30sKa8qsU9qqaun6ruU4I9X0DD7FzRw7jarjue20eqOrhWp8yNKdbY+ORptcG0a97M6dyxp5NH7dl+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216273; c=relaxed/simple;
	bh=7zUIF4doMbyCpR2nzVRmsi7rEQhw/x7p/IcFKhdqYCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNmDCcm9NSKDiDGPiau+QrzeutY7Xwovf0h05ZQiWyUimxXJeUvYD+JK8/nMNartzFZQ3MhuzrjKCdBRQTomstKSLt5o38Ic+VH9hcXLr/umVyolkV95sJhT0/WJrOzQ43dofBJMivG4ofLoGSYr3bieWEwYMlsdqkH1PGeEcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sQ0wo1M3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pX8hgFoPiMyFYee1qff/GbRGpxMGCd83byCgw7rNe+s=; b=sQ0wo1M3ipZBhGr1+5Pl2TV/5v
	Ir3PiYGREY5KOhNnxm/AACaskE7a3vwAHnC7QB//zQ39mQOCTaVzv6FnHVm0kAIJH6xsnS+0joJVR
	ixjl0jjs1QHh4SLHtwUl764UGgpBCZKu6SFDyL7AM3VIEMNdlyj4cOX7JyLdj+akMSKOhEgQNDI+Z
	bbEIbfcX5xwTICRq5Ey+oS3Kp7tXPNEwGTvqBpxNeXDdhnElhi0uHes2DrbJJOPG5/qlvNI8u5QvP
	K8YvUgDR2gGHOTbIMa1hXCRJarxRsuCSPHR3oyBQRg3pR1gjgcqyBKo9OAxH/Ah4aCkfhMIWObU5f
	poxrbR6g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzIMh-00000007KAU-3mnE;
	Thu, 18 Sep 2025 17:24:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 813E8300125; Thu, 18 Sep 2025 19:24:14 +0200 (CEST)
Date: Thu, 18 Sep 2025 19:24:14 +0200
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
Subject: Re: [RESEND][PATCH v15 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250918172414.GC3409427@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
 <20250918114610.GZ3419281@noisy.programming.kicks-ass.net>
 <20250918111853.5dc424df@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918111853.5dc424df@gandalf.local.home>

On Thu, Sep 18, 2025 at 11:18:53AM -0400, Steven Rostedt wrote:
> On Thu, 18 Sep 2025 13:46:10 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > So I started looking at this, but given I never seen the deferred unwind
> > bits that got merged I have to look at that first.
> > 
> > Headers want something like so.. Let me read the rest.
> > 
> > ---
> >  include/linux/unwind_deferred.h       | 38 +++++++++++++++++++----------------
> >  include/linux/unwind_deferred_types.h |  2 ++
> >  2 files changed, 23 insertions(+), 17 deletions(-)
> 
> Would you like to send a formal patch with this? I'd actually break it into
> two patches. One to clean up the long lines, and the other to change the
> logic.

Sure, I'll collect the lot while I go through it and whip something up
when I'm done. For now, I'll just shoot a few questions your way.


So we have:

do_syscall_64()
  ... do stuff ...
  syscall_exit_to_user_mode(regs)
    syscall_exit_to_user_mode_work(regs)
      syscall_exit_work()
      exit_to_user_mode_prepare()
        exit_to_user_mode_loop()
	  retume_user_mode_work()
	    task_work_run()
    exit_to_user_mode()
      unwind_reset_info();
      user_enter_irqoff();
      arch_exit_to_user_mode();
      lockdep_hardirqs_on();
  SYSRET/IRET


and

DEFINE_IDTENTRY*()
  irqentry_enter();
  ... stuff ...
  irqentry_exit()
    irqentry_exit_to_user_mode()
      exit_to_user_mode_prepare()
        exit_to_user_mode_loop();
	  retume_user_mode_work()
	    task_work_run()
      exit_to_user_mode()
        unwind_reset_info();
	...
  IRET

Now, task_work_run() is in the exit_to_user_mode_loop() which is notably
*before* exit_to_user_mode() which does the unwind_reset_info().

What happens if we get an NMI requesting an unwind after
unwind_reset_info() while still very much being in the kernel on the way
out?


What is the purpose of unwind_deferred_task_exit()? This is called from
do_exit(), only slightly before it does exit_task_work(), which runs all
pending task_work. Is there something that justifies the manual run and
cancel instead of just leaving it sit in task_work an having it run
naturally? If so, that most certainly deserves a comment.


A similar question for unwind_task_free(), where exactly is it relevant?
Where does it acquire a task_work that is not otherwise already ran on
exit?


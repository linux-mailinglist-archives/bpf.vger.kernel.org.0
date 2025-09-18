Return-Path: <bpf+bounces-68833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A33B86370
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 19:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166B01CC384B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC6313521;
	Thu, 18 Sep 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q2gNplf9"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778A14B06C;
	Thu, 18 Sep 2025 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216753; cv=none; b=ps0bC4Ts+fnS0IoiRAFDMu+BAnajJphNGK53cQ+kp90RM0MnTVRRhkjvhLwWCagRuTaZTkccpW+ODjH0118v2WcioOLQDKhcLUuk08P1t5mcnGsdVJiDod+Coyy02MWSm8V37XFxq4rSerH/msRQ/6JjtL1Fkk+eCNXm6lIzeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216753; c=relaxed/simple;
	bh=fIyWLjYWYolK8kGtjGTSGMprnorrZ3sH2ZGKz6a6zIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx6n9i1HEq3lUu2nWM5lIxG5Ns1W29xTtlkFckyCGb80mOTx9o80XgcTf5z9R3hGec/VVq/HWaTJYTGdvTIv+gVc1EyjCuCvC+c3iVKbQqYyr5rvBoi1AB4ibFO4EhfTbOV430iga3pEoAVKTRzW/TnWT1i6xXBdpi8WQJkwelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q2gNplf9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ks+P0m4BW3azJD/lpZITgC4Oc94NZbotAXAdYynHzYA=; b=q2gNplf9YLRm7AXnfsuUzaAiIo
	9Lk9KBjDgqyB+ZeMoMow0ZWYZM5t66q7CJe61AE4T5MSk/ADD/WLzhNgSnuC5bkp+TPnrwDvIxnx+
	36hHpbn65CSuq7zD3F7G3tW0fgOElY3xvXnBir1y7fZPABK+ZAzmUnh0GjwswgWUP5XXlwUtlyrBv
	/Hk3K2ZXEBtneFEaoU/bOWpbAXHvljm5qROQmx/032QauKy88+2oA60KCqbZwMetvd/fdlzGuhqZ5
	s3hTYcquaS5gxZi9dYR87xrBAjTDdNuR5vqYEVHCEblL0wA7N3Gfdf7yRU3MWtfCXwl4XWpEQvcFk
	BikYBTeQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzIUW-00000007Tns-44Be;
	Thu, 18 Sep 2025 17:32:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A5A5300125; Thu, 18 Sep 2025 19:32:20 +0200 (CEST)
Date: Thu, 18 Sep 2025 19:32:20 +0200
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
Message-ID: <20250918173220.GA3475922@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
 <20250918114610.GZ3419281@noisy.programming.kicks-ass.net>
 <20250918111853.5dc424df@gandalf.local.home>
 <20250918172414.GC3409427@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918172414.GC3409427@noisy.programming.kicks-ass.net>

On Thu, Sep 18, 2025 at 07:24:14PM +0200, Peter Zijlstra wrote:

> So we have:
> 
> do_syscall_64()
>   ... do stuff ...
>   syscall_exit_to_user_mode(regs)
>     syscall_exit_to_user_mode_work(regs)
>       syscall_exit_work()
>       exit_to_user_mode_prepare()
>         exit_to_user_mode_loop()
> 	  retume_user_mode_work()
> 	    task_work_run()
>     exit_to_user_mode()
>       unwind_reset_info();
>       user_enter_irqoff();
>       arch_exit_to_user_mode();
>       lockdep_hardirqs_on();
>   SYSRET/IRET
> 
> 
> and
> 
> DEFINE_IDTENTRY*()
>   irqentry_enter();
>   ... stuff ...
>   irqentry_exit()
>     irqentry_exit_to_user_mode()
>       exit_to_user_mode_prepare()
>         exit_to_user_mode_loop();
> 	  retume_user_mode_work()
> 	    task_work_run()
>       exit_to_user_mode()
>         unwind_reset_info();
> 	...
>   IRET
> 
> Now, task_work_run() is in the exit_to_user_mode_loop() which is notably
> *before* exit_to_user_mode() which does the unwind_reset_info().
> 
> What happens if we get an NMI requesting an unwind after
> unwind_reset_info() while still very much being in the kernel on the way
> out?

AFAICT it will try and do a task_work_add(TWA_RESUME) from NMI context,
and this will fail horribly.

If you do something like:

	twa_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
	task_work_add(foo, twa_mode);

it might actually work.



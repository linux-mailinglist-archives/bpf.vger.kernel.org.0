Return-Path: <bpf+bounces-14265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7AC7E17DA
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 00:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A181C20ACD
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 23:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803001946D;
	Sun,  5 Nov 2023 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cy8MGuHI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE7F199A1;
	Sun,  5 Nov 2023 23:18:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5CBE0;
	Sun,  5 Nov 2023 15:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WRzc8iSMZ3s/SPfYK8NAg2CySTvFUz9+wHH4x+bWOPw=; b=Cy8MGuHIuO5bucbrbZ3TAyLt+w
	axueqeRAPshmKo4grkOnNYx5lB+Jvhv5wX5N5XaoLR4501TSBfdavpUcziXBbk0ued+vbemuiW6iw
	IJvE/nYtylODJnYtZiJfWFATI5BUYHBkKiMfls38/AZaOFlrZo8Ipwn/RPsFC3mPk4BOliVFFEJ4c
	a0ThgXD0bloEtab3XslA0aLkwUcqMw3tw8xkuyR7qXzGZf4SxyQ97ChKzULMqTcNdkmh/abn8jvjX
	eny63U8vbdFJ8ckTqc7YiJ7uDB3LP3WEsks6jkdCYtcHdagwTMJhSMUfd7atjbO59UxoLTm+mEeY7
	cfkmU3Rw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qzmN5-009uqA-1K;
	Sun, 05 Nov 2023 23:17:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 13E39300326; Mon,  6 Nov 2023 00:17:35 +0100 (CET)
Date: Mon, 6 Nov 2023 00:17:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-ID: <20231105231734.GE3818@noisy.programming.kicks-ass.net>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
 <169920068069.482486.6540417903833579700.stgit@devnote2>
 <20231105172536.GA7124@noisy.programming.kicks-ass.net>
 <20231105141130.6ef7d8bd@rorschach.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105141130.6ef7d8bd@rorschach.local.home>

On Sun, Nov 05, 2023 at 02:11:30PM -0500, Steven Rostedt wrote:
> On Sun, 5 Nov 2023 18:25:36 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Nov 06, 2023 at 01:11:21AM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Support HAVE_FUNCTION_GRAPH_FREGS on x86-64, which saves ftrace_regs
> > > on the stack in ftrace_graph return trampoline so that the callbacks
> > > can access registers via ftrace_regs APIs.  
> > 
> > What is ftrace_regs ? If I look at arch/x86/include/asm/ftrace.h it's a
> > pointless wrapper around pt_regs.
> > 
> > Can we please remove the pointless wrappery and call it what it is?
> 
> A while back ago when I introduced FTRACE_WITH_ARGS, it would have all
> ftrace callbacks get a pt_regs, but it would be partially filled for
> those that did not specify the "REGS" flag when registering the
> callback. You and Thomas complained that it would be a bug to return
> pt_regs that was not full because something might read the non filled
> registers and think they were valid.
> 
> To solve this, I came up with ftrace_regs to only hold the registers
> that were required for function parameters (including the stack
> pointer). You could then call arch_ftrace_get_regs(ftrace_regs) and if
> this "wrapper" had all valid pt_regs registers, then it would return
> the pt_regs, otherwise it would return NULL, and you would need to use
> the ftrace_regs accessor calls to get the function registers. You and
> Thomas agreed with this.

Changelog nor code made it clear this was partial anything. So this is
still the partial thing?

Can we then pretty clear clarify all that, and make it clear which regs
are in there? Because when I do 'vim -t ftrace_regs' it just gets me a
seemingly pointless wrapper struct, no elucidating comments nothingses.

> You even Acked the patch:
>
> commit 02a474ca266a47ea8f4d5a11f4ffa120f83730ad
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Tue Oct 27 10:55:55 2020 -0400

You expect me to remember things from 3 years ago?


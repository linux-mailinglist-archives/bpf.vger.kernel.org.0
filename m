Return-Path: <bpf+bounces-14271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3167E183D
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 02:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09CB281243
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 01:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA8639;
	Mon,  6 Nov 2023 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqRAjlra"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C339F;
	Mon,  6 Nov 2023 01:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C293EC433C8;
	Mon,  6 Nov 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699232755;
	bh=UfrmHYAckoHJxYOMbqXLSDZEhJ9cF93AOlJeMYEmPL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DqRAjlrapexsBNLg2I7qk9HJjN1c2zT5goRAXh1xs7eXKs0n9mCGDZJcnbwLPlWJF
	 EhVlgvNtUtAhaOpqM5zvORosLRikHp4YhIXtNet8pa3YMFyZZ+oFuN4eq+MxZlx4QF
	 pwGsImIXU6O+DeLJHtP7xbYZtJqsvCMa7WXZbEmipSsZ742F2n6xMNgdR5jY1Mx8lh
	 w0owf4MDhPLaHBquwObmUi7ZXGL5UDbGTGfQsMBA6fLa3EI4uR1hTUqXlUp+X1EOvz
	 IrHC7oHxDu9M7ZJeKr6Z+3nVtGSJN3vFn4M01TENhyUWvQiCaIR8MZUNpbruMdoQDK
	 GwGH92zFAxyEg==
Date: Mon, 6 Nov 2023 10:05:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-Id: <20231106100549.33f6ce30d968906979ca3954@kernel.org>
In-Reply-To: <20231105183301.38be5598@rorschach.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920068069.482486.6540417903833579700.stgit@devnote2>
	<20231105172536.GA7124@noisy.programming.kicks-ass.net>
	<20231105141130.6ef7d8bd@rorschach.local.home>
	<20231105231734.GE3818@noisy.programming.kicks-ass.net>
	<20231105183301.38be5598@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Nov 2023 18:33:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 6 Nov 2023 00:17:34 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Changelog nor code made it clear this was partial anything. So this is
> > still the partial thing?
> > 
> > Can we then pretty clear clarify all that, and make it clear which regs
> > are in there? Because when I do 'vim -t ftrace_regs' it just gets me a
> > seemingly pointless wrapper struct, no elucidating comments nothingses.
> 
> I agree it should be better documented (like everything else). The
> ftrace_regs must have all the registers needed to produce a function's
> arguments. For x86_64, that would be:
> 
>   rdi, rsi, rdx, r8, r9, rsp
> 
> Basically anything that is needed to call mcount/fentry.

Oops, I found I missed to save rsp. let me update it.

Anyway, this will be defined clearly. ftrace_regs needs to be a partial
set of registers related to the (kernel) function call.

 - registers which is used for passing the function parameters in
   integer registers and stack pointer (for parameters on memory).

 - registers which is used for passing the return values.

 - call-frame-pointer register if exists.

So for x86-64,

 - rdi, rsi, rcx, rdx, r8, r9, and rsp
 - rax and rdx
 - rbp

(BTW, why orig_rax is cleared?)

> But yes, it's still partial registers but for archs that support
> FTRACE_WITH_REGS, it can also hold all pt_regs which can be retrieved
> by the arch_ftrace_get_regs(), which is why there's a pt_regs struct in
> the x86 version. But that's not the case for arm64, as
> arch_ftrace_get_regs() will always return NULL.

The major reason of the DYNAMIC_FTRACE_WITH_REGS is livepatch and
kprobe on ftrace (if kprobe puts probe on the ftrace address, it uses
ftrace instead of breakpoint).

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


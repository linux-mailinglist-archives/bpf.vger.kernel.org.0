Return-Path: <bpf+bounces-14341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801347E3251
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 01:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A799280E0E
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2A17E3;
	Tue,  7 Nov 2023 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTDWS6yI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411910E4;
	Tue,  7 Nov 2023 00:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D448C433C7;
	Tue,  7 Nov 2023 00:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699317785;
	bh=ZDSZrTPjdbQ1tzVXs6DT67Wg83zVrMpSIvmICGi3DDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QTDWS6yId+pWs8EyAV7mggdfaXC2dOCCM7NJJmavNb8580+6kNUX37Nai376HiCgV
	 xis7aOGWkVhB8qT/ya1PMnsmjm+CDFZrJVO+v6OV+Gf893/BD+vyqRovbVElgu5sNb
	 O7JjVtE8VJpMZXbDh70Z0ro4gM0lIXU79ZFLFOSqqAbIaVX8w7Ux0fS/XJHClThXF+
	 6HxdZzRB+jVcEHvmuzezJZ4HguhT7I34Pfg9+1FtF5rgJ8SRS7pB6Gd+dUzvvfP4jX
	 Te8mAtiJOcgnJnNDevGfm8CK/jITfnB33qWoBHCuec5uc43IfVDv9KI6KOC0TKJzei
	 cnOMazeqSMxag==
Date: Tue, 7 Nov 2023 09:42:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-Id: <20231107094258.d41a46c202197e92bc6d9656@kernel.org>
In-Reply-To: <20231106113710.3bf69211@gandalf.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920068069.482486.6540417903833579700.stgit@devnote2>
	<20231105172536.GA7124@noisy.programming.kicks-ass.net>
	<20231105141130.6ef7d8bd@rorschach.local.home>
	<20231105231734.GE3818@noisy.programming.kicks-ass.net>
	<20231105183301.38be5598@rorschach.local.home>
	<20231106100549.33f6ce30d968906979ca3954@kernel.org>
	<20231106113710.3bf69211@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Nov 2023 11:37:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 6 Nov 2023 10:05:49 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > So for x86-64,
> > 
> >  - rdi, rsi, rcx, rdx, r8, r9, and rsp
> >  - rax and rdx
> >  - rbp
> > 
> > (BTW, why orig_rax is cleared?)
> 
> You mean from ftrace_caller?
> 
> That's a "hack" to determine if we need to call the direct trampoline or
> not. When you have both a direct trampoline and ftrace functions on the
> same function, it will call ftrace_ops_list_func() to iterate all the
> registered ftrace callbacks. The direct callback helper will set "orig_rax"
> to let the return of the ftrace trampoline call the direct callback.

Got it. So does ftrace_regs need a placeholder for direct trampoline?
(Or, can we use a register to pass it?)
I think we don't need to clear it for return_to_handler() but if
`ftrace_regs` spec requires it, it is better to do so.

Thank you,

> 
> Remember if a direct callback is by itself, the fentry will call that
> direct trampoline without going through the ftrace trampoline. This is used
> to tell the ftrace trampoline that it's attached to a direct caller and
> needs to call that and not return back to the function it is tracing.
> 
> See later down in that file we have:
> 
> 	/*
> 	 * If ORIG_RAX is anything but zero, make this a call to that.
> 	 * See arch_ftrace_set_direct_caller().
> 	 */
> 	testq	%rax, %rax
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <bpf+bounces-14818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B007E8830
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696DDB20BF7
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B5E4432;
	Sat, 11 Nov 2023 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9DUrkLZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4DF4405;
	Sat, 11 Nov 2023 02:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7965EC433C8;
	Sat, 11 Nov 2023 02:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699669479;
	bh=aIdbMSq84A3+20V/l6jBNeX8gsHkBhcldmzU2v6Ubf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9DUrkLZHHyvDa1HtWTbqbTpW2YUdXB0mEO3QfEPr4+9o5+EunMDmUuAnon+jHgpS
	 AKAuzQqzVRoUSgWMrrrcJdJcvWM5REgA76ujsqQtsZ4bMO0ADwUQkRM8YZkRMEsjGg
	 0kdAGA8g6hEevMAY1M7P09fWM/XxwBLzFG8ABNkcEWGZxTOZ68CLl76U0SZO2oKll6
	 tBYtOY4HhGEFj0lJVg6VaJMtajPSwB7/TO4DJM+LeaWQSYv6mR+6wYUPe3xfy6P7T1
	 7R5rBK1Wbg5IIEZmezub2+PAGq/zVkcJtAfFzbi1Z9R1SGSl1QKu+Rns6MljqupYLK
	 cErb0ls6spKxw==
Date: Sat, 11 Nov 2023 11:24:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH v2 01/31] tracing: Add a comment about ftrace_regs
 definition
Message-Id: <20231111112434.2e8d76e59e6f5ed4f166ff6b@kernel.org>
In-Reply-To: <ZU4P45t-mDoyItg3@FVFF77S0Q05N>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
	<169945347160.55307.1488323435914144870.stgit@devnote2>
	<20231109081452.fd6e091df9df1bc7c5ced38b@kernel.org>
	<ZU4P45t-mDoyItg3@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 11:11:31 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Thu, Nov 09, 2023 at 08:14:52AM +0900, Masami Hiramatsu wrote:
> > On Wed,  8 Nov 2023 23:24:32 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > To clarify what will be expected on ftrace_regs, add a comment to the
> > > architecture independent definition of the ftrace_regs.
> > > 
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > >  Changes in v2:
> > >   - newly added.
> > > ---
> > >  include/linux/ftrace.h |   25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index e8921871ef9a..b174af91d8be 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -118,6 +118,31 @@ extern int ftrace_enabled;
> > >  
> > >  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > >  
> > > +/**
> > > + * ftrace_regs - ftrace partial/optimal register set
> > > + *
> > > + * ftrace_regs represents a group of registers which is used at the
> > > + * function entry and exit. There are three types of registers.
> > > + *
> > > + * - Registers for passing the parameters to callee, including the stack
> > > + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> > > + * - Registers for passing the return values to caller.
> > > + *   (e.g. rax and rdx on x86_64)
> > > + * - Registers for hooking the function return including the frame pointer
> > > + *   (the frame pointer is architecture/config dependent)
> > > + *   (e.g. rbp and rsp for x86_64)
> > 
> > Oops, I found the program counter/instruction pointer must be saved too.
> > This is used for live patching. One question is that if the IP is modified
> > at the return handler, what should we do? Return to the specified address?
> 
> I'm a bit confused here; currently we use fgraph_ret_regs for function returns,
> are we going to replace that with ftrace_regs?

Yes. It is limited and does not have APIs compatibility.

> 
> I think it makes sense for the PC/IP to be the address the return handler will
> eventually return to (and hence allowing it to be overridden), but that does
> mean we'll need to go recover the return address *before* we invoke any return
> handlers.

The actual return address has been recovered from shadow stack at first,
and callback the handlers. See __ftrace_return_to_handler() and
ftrace_pop_return_trace().
So it is easy to set it to the ftrace_regs :)

Thank you!

> 
> Thanks,
> Mark.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


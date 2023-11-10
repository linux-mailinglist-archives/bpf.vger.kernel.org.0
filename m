Return-Path: <bpf+bounces-14768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6F7E7BB8
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 12:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CD41C20BF5
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429B14F70;
	Fri, 10 Nov 2023 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1934814A91;
	Fri, 10 Nov 2023 11:11:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C40472D4C9;
	Fri, 10 Nov 2023 03:11:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C32106F;
	Fri, 10 Nov 2023 03:12:24 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.41.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F23BD3F7C5;
	Fri, 10 Nov 2023 03:11:36 -0800 (PST)
Date: Fri, 10 Nov 2023 11:11:31 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH v2 01/31] tracing: Add a comment about ftrace_regs
 definition
Message-ID: <ZU4P45t-mDoyItg3@FVFF77S0Q05N>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
 <169945347160.55307.1488323435914144870.stgit@devnote2>
 <20231109081452.fd6e091df9df1bc7c5ced38b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109081452.fd6e091df9df1bc7c5ced38b@kernel.org>

On Thu, Nov 09, 2023 at 08:14:52AM +0900, Masami Hiramatsu wrote:
> On Wed,  8 Nov 2023 23:24:32 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > To clarify what will be expected on ftrace_regs, add a comment to the
> > architecture independent definition of the ftrace_regs.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - newly added.
> > ---
> >  include/linux/ftrace.h |   25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index e8921871ef9a..b174af91d8be 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -118,6 +118,31 @@ extern int ftrace_enabled;
> >  
> >  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >  
> > +/**
> > + * ftrace_regs - ftrace partial/optimal register set
> > + *
> > + * ftrace_regs represents a group of registers which is used at the
> > + * function entry and exit. There are three types of registers.
> > + *
> > + * - Registers for passing the parameters to callee, including the stack
> > + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> > + * - Registers for passing the return values to caller.
> > + *   (e.g. rax and rdx on x86_64)
> > + * - Registers for hooking the function return including the frame pointer
> > + *   (the frame pointer is architecture/config dependent)
> > + *   (e.g. rbp and rsp for x86_64)
> 
> Oops, I found the program counter/instruction pointer must be saved too.
> This is used for live patching. One question is that if the IP is modified
> at the return handler, what should we do? Return to the specified address?

I'm a bit confused here; currently we use fgraph_ret_regs for function returns,
are we going to replace that with ftrace_regs?

I think it makes sense for the PC/IP to be the address the return handler will
eventually return to (and hence allowing it to be overridden), but that does
mean we'll need to go recover the return address *before* we invoke any return
handlers.

Thanks,
Mark.


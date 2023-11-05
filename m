Return-Path: <bpf+bounces-14262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB67E1601
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 20:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7551F2168F
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 19:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BB3171DC;
	Sun,  5 Nov 2023 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177A17730;
	Sun,  5 Nov 2023 19:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF9BC433C8;
	Sun,  5 Nov 2023 19:11:32 +0000 (UTC)
Date: Sun, 5 Nov 2023 14:11:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-ID: <20231105141130.6ef7d8bd@rorschach.local.home>
In-Reply-To: <20231105172536.GA7124@noisy.programming.kicks-ass.net>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920068069.482486.6540417903833579700.stgit@devnote2>
	<20231105172536.GA7124@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Nov 2023 18:25:36 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Nov 06, 2023 at 01:11:21AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Support HAVE_FUNCTION_GRAPH_FREGS on x86-64, which saves ftrace_regs
> > on the stack in ftrace_graph return trampoline so that the callbacks
> > can access registers via ftrace_regs APIs.  
> 
> What is ftrace_regs ? If I look at arch/x86/include/asm/ftrace.h it's a
> pointless wrapper around pt_regs.
> 
> Can we please remove the pointless wrappery and call it what it is?

A while back ago when I introduced FTRACE_WITH_ARGS, it would have all
ftrace callbacks get a pt_regs, but it would be partially filled for
those that did not specify the "REGS" flag when registering the
callback. You and Thomas complained that it would be a bug to return
pt_regs that was not full because something might read the non filled
registers and think they were valid.

To solve this, I came up with ftrace_regs to only hold the registers
that were required for function parameters (including the stack
pointer). You could then call arch_ftrace_get_regs(ftrace_regs) and if
this "wrapper" had all valid pt_regs registers, then it would return
the pt_regs, otherwise it would return NULL, and you would need to use
the ftrace_regs accessor calls to get the function registers. You and
Thomas agreed with this.

You even Acked the patch:

commit 02a474ca266a47ea8f4d5a11f4ffa120f83730ad
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Tue Oct 27 10:55:55 2020 -0400

    ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default
    
    Currently, the only way to get access to the registers of a function via a
    ftrace callback is to set the "FL_SAVE_REGS" bit in the ftrace_ops. But as this
    saves all regs as if a breakpoint were to trigger (for use with kprobes), it
    is expensive.
    
    The regs are already saved on the stack for the default ftrace callbacks, as
    that is required otherwise a function being traced will get the wrong
    arguments and possibly crash. And on x86, the arguments are already stored
    where they would be on a pt_regs structure to use that code for both the
    regs version of a callback, it makes sense to pass that information always
    to all functions.
    
    If an architecture does this (as x86_64 now does), it is to set
    HAVE_DYNAMIC_FTRACE_WITH_ARGS, and this will let the generic code that it
    could have access to arguments without having to set the flags.
    
    This also includes having the stack pointer being saved, which could be used
    for accessing arguments on the stack, as well as having the function graph
    tracer not require its own trampoline!
    
    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


-- Steve


Return-Path: <bpf+bounces-9301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044A7932CC
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1A22811FB
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 00:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9419736E;
	Wed,  6 Sep 2023 00:06:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58BD362
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 00:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE46DC433C8;
	Wed,  6 Sep 2023 00:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693958787;
	bh=xJ1s7oM+G4FARqPGnOatxoVeb1iA2/xOJAA5CciM1aE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kmq2Al/LPSAzDps5g1bpJo4fXlZQXFJiQeLjwPWqYMnFOFoQfNC03DOyiP3ogv0PE
	 DRLTscCcslc3rr9XsZIFgYe0Zj5BB7S9sQ/bNCN+M1ZgHGLLb7+xctAiEVSkFezTEP
	 Q1j9cIIfBMpRe8X3wWbfs+SBOQjFbvImpQhTENGeKnySA1QqwFBRg9qo6xvAE2zNGH
	 dgYEpxVdwOQPP+dv5LBOwB6Yr2BB6EVgpx/Xba9u2WKLObrVzQGCRFFUpvoPefsgIT
	 g15snsR9bW+w4uAcz14Nbbch8yItdmQRJs8ZjdzdFOyNuT1xDPQAuf+HBmnNEP3goF
	 hb7mwfgHGYk/A==
Date: Wed, 6 Sep 2023 09:06:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 4/9] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
Message-Id: <20230906090621.3cd9333886b6779a817ffc2b@kernel.org>
In-Reply-To: <20230905123058.706b12de@gandalf.local.home>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
	<169280377434.282662.7610009313268953247.stgit@devnote2>
	<20230904224038.4420a76ea15931aa40179697@kernel.org>
	<yt9d5y4pozrl.fsf@linux.ibm.com>
	<20230905223633.23cd4e6e8407c45b934be477@kernel.org>
	<20230905123058.706b12de@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Sep 2023 12:30:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 5 Sep 2023 22:36:33 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Yes, arch_rethook_trampoline() is good. It needs to save all registers.
> > 
> > In this series, I'm trying to change the pt_regs with ftrace_regs which will
> > reduce trampoline overhead if DYNAMIC_FTRACE_WITH_ARGS=y.
> > 
> > kprobe -> (pt_regs) -> rethook_try_hook()
> > fprobe -> (ftrace_regs) -> rethook_try_hook_ftrace() # new function
> > 
> > Thus, we need to ensure that the ftrace_regs which is saved in the ftrace
> > *without* FTRACE_WITH_REGS flags, can be used for hooking the function
> > return. I saw;
> > 
> > void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
> > {
> >         rh->ret_addr = regs->gprs[14];
> >         rh->frame = regs->gprs[15];
> > 
> >         /* Replace the return addr with trampoline addr */
> >         regs->gprs[14] = (unsigned long)&arch_rethook_trampoline;
> > }
> > 
> > gprs[15] is a stack pointer, so it is saved in ftrace_regs too, but what about
> > gprs[14]? (I guess it is a link register)
> > We need to read the gprs[14] and ensure that is restored to gpr14 when the
> > ftrace is exit even without FTRACE_WITH_REGS flag.
> > 
> > IOW, it is ftrace save regs/restore regs code issue. I need to check how the
> > function_graph implements it.
> 
> I would argue that the link register should also be saved in ftrace_regs.
> 
> The thing that ftrace_regs is not suppose to save is the general purpose
> registers.

Let me confirm that if ftrace_regs user changes a member of the ftrace_regs,
is that restored to the actual register when exits the ftrace too?

On x86, we just tweak the stack on memory, so I'm sure that that change is
effective, but not sure on other arch. Ah, but function_graph may also need it.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


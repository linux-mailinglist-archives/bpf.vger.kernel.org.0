Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589A1309151
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 02:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhA3BoU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 20:44:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhA3Bl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 20:41:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABFBE64D7F;
        Sat, 30 Jan 2021 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611970875;
        bh=iyVil0L0LGMYVmrDFIMIsjI6dSD0wzIlbbHJtS/uxxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uSJUuoZzKFWdxoq6sGtFtOdfNj09rQJ3FuSCY34Ep7SFvvYJwG+DGeh+VK2OYqLdZ
         J0xl6dXRj26RcTn+4sPj9deH8DYRGiK3jjI9bCJwK3d9DWzElvQhKQeAdWpbsxOjte
         QFG9WNA0cMHui5aYd7qJpV7E7AZfd+nmRrKEkTxWuUB735IqUhbJ4CLHMokjwFZYM2
         /uKoi3iCnb25igIkWVVO65SaMsnK3DbrHYeR6cqRLkBVgiK4TIaPKhDuw5RUTqn3+P
         VdXj37GgWuNDT4CoV439cDC7RJdwBwD9r2Bc7qKPNyp6j3vR1DzW19eK2vBp+GChIG
         8AFtS9MVot+7Q==
Date:   Sat, 30 Jan 2021 10:41:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28
 ("x86: Replace ist_enter() with nmi_enter()")
Message-Id: <20210130104110.0a25f155c00a86513e959ef0@kernel.org>
In-Reply-To: <20210129210533.7s6udd3vobkgb27u@ast-mbp.dhcp.thefacebook.com>
References: <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
        <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
        <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
        <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
        <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
        <20210129105952.74dc8464@gandalf.local.home>
        <20210129162438.GC8912@worktop.programming.kicks-ass.net>
        <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
        <20210129175943.GH8912@worktop.programming.kicks-ass.net>
        <20210129140103.3ce971b7@gandalf.local.home>
        <20210129210533.7s6udd3vobkgb27u@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 29 Jan 2021 13:05:33 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Jan 29, 2021 at 02:01:03PM -0500, Steven Rostedt wrote:
> > On Fri, 29 Jan 2021 18:59:43 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Fri, Jan 29, 2021 at 09:45:48AM -0800, Alexei Starovoitov wrote:
> > > > Same things apply to bpf side. We can statically prove safety for
> > > > ftrace and kprobe attaching whereas to deal with NMI situation we
> > > > have to use run-time checks for recursion prevention, etc.  
> > > 
> > > I have no idea what you're saying. You can attach to functions that are
> > > called with random locks held, you can create kprobes in some very
> > > sensitive places.
> > > 
> > > What can you staticlly prove about that?
> > 
> > I think the main difference is, if you attach a kprobe or ftrace function,
> > you can theoretically analyze the location before you do the attachment.
> 
> Excatly.
> When we're writing bpf helpers we need to carefully think about reentrance and NMI.
> If the helper looks like:
> int nokprobe notrace bpf_something(...)
> {
>   // access variables A and B
> }
> 
> The implementation can rely on the fact that even if the helper is reentrant
> the state of A and B will be consistent. Either both got touched or none.
> Only NMI condition we have to worry about, because A could be modified 
> without touching B.
> If we write it as
> int nokprobe bpf_something(...) { ... }
> that would be another case.
> Here we need to consider the case that bpf prog can be attached to it via fentry nop.
> But no need to worry about instructions split in the middle because of kprobe via int3.
> Since we have big "if (in_nmi()) goto unsupported;" check in the beginning we
> only need to worry about combinations of kprobe at the start of the func,
> kprobe anywhere inside the func via int3, and ftrace at the start.
> Not having to think of NMI helps a ton.
> My earlier this_cpu vs __this_cpu comment is an example of that.
> If in_nmi is filtered early it's one implementation. If nmi has to be handled
> it's completely different algorithm.
> Now you've broke all this logic by making int3 to be marked as 'in_nmi' and
> bpf in kprobe in the middle of the func are now broken.
> Do people use that? Yeah they do.
> We have to fix it.
> What were your reasons to make int3 in_nmi?
> I've read the commit log, but I don't see in it the actual motivation
> for int3 other than "it looks like NMI to me. Let's make it so".
> The commit logs talk about cpu exceptions. I agree that #DB and #MC do behave like NMI.
> But #BP is not really. My understanding it's used by kprobes and text_poke_bp only.
> If the motivation was to close some issue with text_poke_bp then, sure,
> let's make handling of text_poke_bp to be treated as nmi.
> But kprobe is not that.
> I'm thinking either of the following solutions would be generic:
> - introduce another state to preempt flags like "kernel exception"

I like this solution. Or, at least there should be a way to provide the
probed context is NMI or not.
(BTW, would the NMI has a specific stack area? If so, nmi_context(regs)
 can be implemented.)

> - remove kprobe's int3 from in_nmi
> As bpf specific alternative we can do:
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6c0018abe68a..37cc549ad52e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -96,7 +96,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
>  {
>         unsigned int ret;
> 
> -       if (in_nmi()) /* not supported yet */
> +       if (in_nmi() && !kprobe_running()) /* not supported yet */

This doesn't make sense, because kprobe_running() always true in the kprobe handler.

The problem is that the in_nmi() checks whether the current context is NMI context,
but you want to know the context where the kprobe is invoked, is NMI context or not.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

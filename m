Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7980730C293
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 15:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhBBOy0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 09:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234099AbhBBOxg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 09:53:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C30264D99;
        Tue,  2 Feb 2021 14:52:50 +0000 (UTC)
Date:   Tue, 2 Feb 2021 09:52:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <20210202095249.5abd6780@gandalf.local.home>
In-Reply-To: <YBktVT+z7sV/vEPU@hirez.programming.kicks-ass.net>
References: <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
        <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
        <20210129105952.74dc8464@gandalf.local.home>
        <20210129162438.GC8912@worktop.programming.kicks-ass.net>
        <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
        <20210129175943.GH8912@worktop.programming.kicks-ass.net>
        <20210129140103.3ce971b7@gandalf.local.home>
        <20210129162454.293523c6@gandalf.local.home>
        <YBUYsFlxjsQxuvfB@hirez.programming.kicks-ass.net>
        <20210130074410.6384c2e2@oasis.local.home>
        <YBktVT+z7sV/vEPU@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Feb 2021 11:45:41 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > The stack tracer checks the size of the stack, compares it to the
> > largest recorded size, and if it's bigger, it will save the stack. But
> > if this happens on two CPUs at the same time, only one can do the
> > recording at the same time. To synchronize this, a spin lock must be
> > taken. Similar to spin locks in an NMI.  
> 
> That sounds like something cmpxchg() should be able to do.
> 
> Have a per-cpu stack trace buffer and a global max one, when cpu local
> exceeds previous max, cmpxchg the buffer.
> 
> > But the problem here is, the callbacks can also be done from an NMI
> > context, so if we are in NMI, we don't want to take any locks, and
> > simply don't record the stack traces from NMIs.  
> 
> Which is obviously shit :-) The NMI might have interesting stack usage.

Actually, it only checks task stacks. It doesn't check IRQ stacks if
they are different than the task stack, because to do it properly, it
must know the size of the stack. The tracer currently masks the stack
pointer with THREAD_SIZE to find the top of the stack.

As other stacks may not be THREAD_SIZE, that won't work. It has been on
my TODO list (for a long time), to add an arch specific way to quickly find
the top of the stack.

> 
> > The more I think about it, the more I hate the idea that ftrace
> > callbacks and kprobes are considered NMIs. Simply because they are not!  
> 
> Yet they happen when IRQs are off, so they are ;-)

But from a handler, you could do:

	if (in_nmi())
		return;
	local_irq_save(flags);
	/* Now you are safe from being re-entrant. */

Where as there's no equivalent in a NMI handler. That's what makes
kprobe/ftrace handlers different than NMI handlers.

> 
> Also, given how everything can nest, it had better all be lockless
> anyway. You can get your regular function trace interrupted, which can
> hit a #DB, which can function trace, which can #BP which can function
> trace again which can get #NMI etc.. Many wonderfun nestings possible.

I would call #DB an #BP handlers very special.

Question: Do #DB and #BP set "in_interrupt()"? Because the function tracer
has infrastructure to prevent recursion in the same context. That is, a
ftrace handler calls something that gets traced, the recursion protection
will detect that and prevent the handler from being called again. But the
recursion protection is interrupt context aware and lets the handler get
called again if the recursion happens from a different context:

func:
   call ftrace_caller
      ftrace_caller:
          call ftrace_handler
              ftrace_handler() {

                   if (recursion_test()) <- false
                       return;

                   some_traced_func() {
                        call ftrace_caller
                               call ftrace_handler
                                    ftrace_handler() {
                                        if (recursion_test()) <- true
                                               return
                                    }
                    <interrupt>
                         func
                            call ftrace_caller
                                 call ftrace_handler
                                       ftrace_handler() {
                                            if (recursion_test()) <- false
                                                 return;
                                       /* continue */


If #DB and #BP do not change the in_interrupt() context, then the above
still will protect the ftrace handlers from recursion due to them.

> 
> And god knows what these handlers end up calling.
> 
> The only sane approach is treating it all as NMI and having it all
> lockless.

That would require refactoring all the code that's been around since 2008.

Worse yet. lockless is much more complex to get right. So this refactoring
will likely cause more bugs than it solves.

-- Steve

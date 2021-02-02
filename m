Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE4C30C6CC
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 18:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhBBQ7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 11:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236955AbhBBQ5T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 11:57:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8884164DB2;
        Tue,  2 Feb 2021 16:56:25 +0000 (UTC)
Date:   Tue, 2 Feb 2021 11:56:23 -0500
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
Message-ID: <20210202115623.08e8164d@gandalf.local.home>
In-Reply-To: <YBmBu0c24RjNYFet@hirez.programming.kicks-ass.net>
References: <20210129105952.74dc8464@gandalf.local.home>
        <20210129162438.GC8912@worktop.programming.kicks-ass.net>
        <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
        <20210129175943.GH8912@worktop.programming.kicks-ass.net>
        <20210129140103.3ce971b7@gandalf.local.home>
        <20210129162454.293523c6@gandalf.local.home>
        <YBUYsFlxjsQxuvfB@hirez.programming.kicks-ass.net>
        <20210130074410.6384c2e2@oasis.local.home>
        <YBktVT+z7sV/vEPU@hirez.programming.kicks-ass.net>
        <20210202095249.5abd6780@gandalf.local.home>
        <YBmBu0c24RjNYFet@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Feb 2021 17:45:47 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Feb 02, 2021 at 09:52:49AM -0500, Steven Rostedt wrote:
> 
> > But from a handler, you could do:
> > 
> > 	if (in_nmi())
> > 		return;
> > 	local_irq_save(flags);
> > 	/* Now you are safe from being re-entrant. */  
> 
> But that's an utter crap thing to do. That's like saying I don't care
> about my events, at which point you might as well not bother at all.
> 
> And you can still do that, you just get less coverage today than you
> used to. You used to throw things under the bus, now you throw more
> under the bus. If you didn't care, I can't seem to find myself caring
> either.

NMIs are special, and they always have been. They shouldn't be doing much
anyway. If they are, then that's a problem.

But if you want to make the stack tracer work on all contexts, I'm happy to
take patches. I don't have time to work on it today.

> 
> > Where as there's no equivalent in a NMI handler. That's what makes
> > kprobe/ftrace handlers different than NMI handlers.  
> 
> I don't see how.
> 
> > > Also, given how everything can nest, it had better all be lockless
> > > anyway. You can get your regular function trace interrupted, which can
> > > hit a #DB, which can function trace, which can #BP which can function
> > > trace again which can get #NMI etc.. Many wonderfun nestings possible.  
> > 
> > I would call #DB an #BP handlers very special.  
> 
> They are, just like NMI is special, which is why they're classed
> together.
> 
> > Question: Do #DB and #BP set "in_interrupt()"? Because the function tracer
> > has infrastructure to prevent recursion in the same context.  
> 
> Sure we _could_ do that, but then we get into the 'fun' problem of
> getting a breakpoint/int3 at random places and calling random code and
> having deadlocks because they take the same lock.

My question wasn't to have them do it, I was simply asking if they do. I
was assuming that they do not.

> 
> There was very little that stopped that from happening.
> 
> > That is, a
> > ftrace handler calls something that gets traced, the recursion protection
> > will detect that and prevent the handler from being called again. But the
> > recursion protection is interrupt context aware and lets the handler get
> > called again if the recursion happens from a different context:  
> 
> > If #DB and #BP do not change the in_interrupt() context, then the above
> > still will protect the ftrace handlers from recursion due to them.  
> 
> But it doesn't help with:
> 
> 	spin_lock_irq(&foo); // task context
> 	#DB
> 	  spin_lock_irq(&foo); // interrupt context per your above

The statement above said:

 "If #DB and #BP do not change the in_interrupt() context"

Which would make the above be in the same context and the handler would
not be called for the #DB case.

> 
> All you need to do is put a breakpoint on a piece of code that holds a
> spinlock and a handler that takes the same spinlock.
> 
> There was very little from stopping that.
> 
> > That would require refactoring all the code that's been around since 2008.  
> 
> Because I couldn't tell why/if any of that was correct at all. #DB/#BP
> don't play by the normal rules. They're _far_ more NMI-like than they're
> IRQ-like due to ignoring IF.

I'm fine with #DB and #BP being a "in_nmi()", as they are probably even
more special than NMIs.

-- Steve


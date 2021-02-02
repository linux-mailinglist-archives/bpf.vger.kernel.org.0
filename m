Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6530BC56
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 11:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBBKqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 05:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhBBKqe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 05:46:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695DBC06174A;
        Tue,  2 Feb 2021 02:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n0m769ZMPd/PM7XjIEQvcyoZkVUym0HTy3iZtH6Lb7Y=; b=ffurwNWebitiux3pz6mLKop4jd
        iyT0lR6n9jCm3mLOaRMeWZvIBcmJpC3nR8LOtnF7rTa7QXqPCoummUWfwOlz7Y+gRZ8ZK8d06CYwv
        SpuzOn48ZBFX0RJxrSC89b/arNY3okgNnJXrAVb9V5BWM+eqQjUeciMleuyPjgQo8QDJuw7upREjQ
        TBeqQGOocbw8EPUIHp1PhBQ6qB5CblmRuY0BFUbZ4sPGrymy0/rGv1+xN/VWZYXEFem12ttP3UabO
        m1gUpXJPsOAY5KD6fecStUYjpoUj9LeqfRHVyXexGFn8Pzardny9kD++Hqo2F+ROuOmzb3ZKkQhSx
        zJmQ8Kaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6tBo-0000n9-6S; Tue, 02 Feb 2021 10:45:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F008D301179;
        Tue,  2 Feb 2021 11:45:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDC8D299C9F61; Tue,  2 Feb 2021 11:45:41 +0100 (CET)
Date:   Tue, 2 Feb 2021 11:45:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <YBktVT+z7sV/vEPU@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130074410.6384c2e2@oasis.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 30, 2021 at 07:44:10AM -0500, Steven Rostedt wrote:
> On Sat, 30 Jan 2021 09:28:32 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Jan 29, 2021 at 04:24:54PM -0500, Steven Rostedt wrote:
> > > Specifically, kprobe and ftrace callbacks may have this:
> > > 
> > > 	if (in_nmi())
> > > 		return;
> > > 
> > > 	raw_spin_lock_irqsave(&lock, flags);
> > > 	[..]
> > > 	raw_spin_unlock_irqrestore(&lock, flags);
> > > 
> > > Which is totally fine to have,  
> > 
> > Why? There's a distinct lack of explaining here.
> > 
> > Note that we ripped out all such dodgy locking from kretprobes.
> 
> Actually, I think you helped explain the distinction. You mention
> "kretpobes" do you mean the infrastructure of kretprobes or all its
> users?

kretprobe infra.

> The infrastructure of ftrace and kprobes can work in any context, it
> does not mean that the callbacks must. Again, these are more like
> exceptions. Why have "in_nmi()"? If anything that can be called by an
> NMI should just work, right? That's basically your argument for having
> ftrace and kprobes set "in_nmi".
> 
> You can have locking in NMIs if the locking is *only* in NMI handlers,
> right? If that's the case, then so should ftrace and kprobe callbacks.

Which is still dodgy as heck. NMIs _can_ nest. Now mostly it doesn't
happen, and the few sites that do use spinlocks from NMI context are
sure to use it from a specific NMI 'handler' context which typically
don't nest.

But I still utterly detest the idea of using spinlocks from NMI. It's
inherently fragile.

> The stack tracer checks the size of the stack, compares it to the
> largest recorded size, and if it's bigger, it will save the stack. But
> if this happens on two CPUs at the same time, only one can do the
> recording at the same time. To synchronize this, a spin lock must be
> taken. Similar to spin locks in an NMI.

That sounds like something cmpxchg() should be able to do.

Have a per-cpu stack trace buffer and a global max one, when cpu local
exceeds previous max, cmpxchg the buffer.

> But the problem here is, the callbacks can also be done from an NMI
> context, so if we are in NMI, we don't want to take any locks, and
> simply don't record the stack traces from NMIs.

Which is obviously shit :-) The NMI might have interesting stack usage.

> The more I think about it, the more I hate the idea that ftrace
> callbacks and kprobes are considered NMIs. Simply because they are not!

Yet they happen when IRQs are off, so they are ;-)

Also, given how everything can nest, it had better all be lockless
anyway. You can get your regular function trace interrupted, which can
hit a #DB, which can function trace, which can #BP which can function
trace again which can get #NMI etc.. Many wonderfun nestings possible.

And god knows what these handlers end up calling.

The only sane approach is treating it all as NMI and having it all
lockless.

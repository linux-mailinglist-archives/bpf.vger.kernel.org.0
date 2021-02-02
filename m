Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E07530C66C
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 17:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhBBQsC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 11:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbhBBQq5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 11:46:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7EC0613ED;
        Tue,  2 Feb 2021 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Xq3+Qjdwj+GhQbI6GS2G9oLuGd9Efu1ya5uWYO1ET0=; b=ItiwRUM9onvOiBevrnXhCIUw6Y
        ti6CvS2rl/jIKRPPZagfLgQQLdBNtQ48A/dFgW33OIuoIqmnAXHDzsdtuQiTO70W1gxGkHkvzHBI7
        9pFNQFPYYLvyl6z+BlYJGqTFOMhC78GxSwJ52sfYacU9XFfMjC4MhQdDnL1bOrbzFw3cw192viPjp
        Mxj1BcE9AuHkWc+bCkOUctAu/V8hIGptXkppsM3WdjTt+7ha++svsXNYwARt2vDuSYuXnzeKs5Vz0
        AH3m33rNIuZD4Qr/1wZnczQgvJ3PYacyRJjeyjhiCGxdlR9MOwjVstu35vnHsKOTPsV0lUSzD+v3E
        rDL0OqkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6yoG-00FTPf-Fp; Tue, 02 Feb 2021 16:45:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 404AF3011FE;
        Tue,  2 Feb 2021 17:45:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AA4C2B7AB29D; Tue,  2 Feb 2021 17:45:47 +0100 (CET)
Date:   Tue, 2 Feb 2021 17:45:47 +0100
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
Message-ID: <YBmBu0c24RjNYFet@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202095249.5abd6780@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 02, 2021 at 09:52:49AM -0500, Steven Rostedt wrote:

> But from a handler, you could do:
> 
> 	if (in_nmi())
> 		return;
> 	local_irq_save(flags);
> 	/* Now you are safe from being re-entrant. */

But that's an utter crap thing to do. That's like saying I don't care
about my events, at which point you might as well not bother at all.

And you can still do that, you just get less coverage today than you
used to. You used to throw things under the bus, now you throw more
under the bus. If you didn't care, I can't seem to find myself caring
either.

> Where as there's no equivalent in a NMI handler. That's what makes
> kprobe/ftrace handlers different than NMI handlers.

I don't see how.

> > Also, given how everything can nest, it had better all be lockless
> > anyway. You can get your regular function trace interrupted, which can
> > hit a #DB, which can function trace, which can #BP which can function
> > trace again which can get #NMI etc.. Many wonderfun nestings possible.
> 
> I would call #DB an #BP handlers very special.

They are, just like NMI is special, which is why they're classed
together.

> Question: Do #DB and #BP set "in_interrupt()"? Because the function tracer
> has infrastructure to prevent recursion in the same context.

Sure we _could_ do that, but then we get into the 'fun' problem of
getting a breakpoint/int3 at random places and calling random code and
having deadlocks because they take the same lock.

There was very little that stopped that from happening.

> That is, a
> ftrace handler calls something that gets traced, the recursion protection
> will detect that and prevent the handler from being called again. But the
> recursion protection is interrupt context aware and lets the handler get
> called again if the recursion happens from a different context:

> If #DB and #BP do not change the in_interrupt() context, then the above
> still will protect the ftrace handlers from recursion due to them.

But it doesn't help with:

	spin_lock_irq(&foo); // task context
	#DB
	  spin_lock_irq(&foo); // interrupt context per your above

All you need to do is put a breakpoint on a piece of code that holds a
spinlock and a handler that takes the same spinlock.

There was very little from stopping that.

> That would require refactoring all the code that's been around since 2008.

Because I couldn't tell why/if any of that was correct at all. #DB/#BP
don't play by the normal rules. They're _far_ more NMI-like than they're
IRQ-like due to ignoring IF.

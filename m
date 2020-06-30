Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBFC20F4D6
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbgF3MjR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 08:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387773AbgF3MjQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 08:39:16 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF772078B;
        Tue, 30 Jun 2020 12:39:13 +0000 (UTC)
Date:   Tue, 30 Jun 2020 08:39:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Will Deacon <will@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, bpf@vger.kernel.org
Subject: Re: [PATCH] kernel/trace: Add TRACING_ALLOW_PRINTK config option
Message-ID: <20200630083912.40a6c50d@oasis.local.home>
In-Reply-To: <20200630051659.uqnkkwaho3lvvnu7@ast-mbp.dhcp.thefacebook.com>
References: <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
        <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
        <20200626181455.155912d9@oasis.local.home>
        <20200628172700.5ea422tmw77otadn@ast-mbp.dhcp.thefacebook.com>
        <20200628144616.52f09152@oasis.local.home>
        <20200628192107.sa3ppfmxtgxh7sfs@ast-mbp.dhcp.thefacebook.com>
        <20200628154331.2c69d43e@oasis.local.home>
        <20200628220209.3oztcjnzsotlfria@ast-mbp.dhcp.thefacebook.com>
        <20200628182842.2abb0de2@oasis.local.home>
        <20200628194334.6238b933@oasis.local.home>
        <20200630051659.uqnkkwaho3lvvnu7@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 29 Jun 2020 22:16:59 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > 
> > Warning, not even compiled tested.  
> 
> Thanks! I see what you mean now.

Great! :-)

> 
> > 
> > -- Steve
> > 
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index 6575bb0a0434..aeba5ee7325a 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -31,6 +31,8 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
> >  GCOV_PROFILE := y
> >  endif
> >  
> > +CFLAGS_bpf_trace.o := -I$(src)  
> 
> not following. why this is needed?

It's required in order to have the TRACE_EVENT macro magic work. More
info about it here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/trace_events/Makefile


> 
> > +
> >  CFLAGS_trace_benchmark.o := -I$(src)
> >  CFLAGS_trace_events_filter.o := -I$(src)
> >  
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index dc05626979b8..01bedf335b2e 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -19,6 +19,9 @@
> >  #include "trace_probe.h"
> >  #include "trace.h"
> >  
> > +#define CREATE_TRACE_EVENTS  
> 
> CREATE_TRACE_POINTS ?


Doh, yeah. I did say it wasn't even compiled tested ;-)

> 
> > +#include "bpf_trace.h"
> > +
> >  #define bpf_event_rcu_dereference(p)					\
> >  	rcu_dereference_protected(p, lockdep_is_held(&bpf_event_mutex))
> >  
> > @@ -473,13 +476,29 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
> >  		fmt_cnt++;
> >  	}
> >  
> > +static DEFINE_SPINLOCK(trace_printk_lock);
> > +#define BPF_TRACE_PRINTK_SIZE	1024
> > +
> > +static inline void do_trace_printk(const char *fmt, ...)
> > +{
> > +	static char buf[BPF_TRACE_PRINT_SIZE];
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&trace_printk_lock, flags);
> > +	va_start(ap, fmt);
> > +	vsnprintf(buf, BPF_TRACE_PRINT_SIZE, fmt, ap);
> > +	va_end(ap);
> > +
> > +	trace_bpf_trace_printk(buf);
> > +	spin_unlock_irqrestore(&trace_printk_lock, flags);  
> 
> interesting. I don't think anyone would care about spin_lock overhead.
> It's better because 'trace_bpf_trace_printk' would be a separate event
> that can be individually enabled/disabled?
> I guess it can work.
> Thanks!

I hope this does everything you need for bpf_trace_printk. If there's
something  that's not working for you, PLEASE reach out to me and ask
what you need.

Cheers!

-- Steve

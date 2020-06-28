Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB6A20C9B2
	for <lists+bpf@lfdr.de>; Sun, 28 Jun 2020 20:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgF1SqU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Jun 2020 14:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgF1SqU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Jun 2020 14:46:20 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5523206C0;
        Sun, 28 Jun 2020 18:46:17 +0000 (UTC)
Date:   Sun, 28 Jun 2020 14:46:16 -0400
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
Message-ID: <20200628144616.52f09152@oasis.local.home>
In-Reply-To: <20200628172700.5ea422tmw77otadn@ast-mbp.dhcp.thefacebook.com>
References: <20200624084524.259560-1-drinkcat@chromium.org>
        <20200624120408.12c8fa0d@oasis.local.home>
        <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
        <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
        <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
        <20200626181455.155912d9@oasis.local.home>
        <20200628172700.5ea422tmw77otadn@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 28 Jun 2020 10:27:00 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Jun 26, 2020 at 06:14:55PM -0400, Steven Rostedt wrote:
> > On Wed, 24 Jun 2020 20:59:13 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >   
> > > > >
> > > > > Nack.  
> > 
> > I nack your nack ;-)  
> 
> ok. let's take it up to Linus to decide.

I'm fine with that.

> 
> >   
> > > > > The message is bogus. It's used in production kernels.
> > > > > bpf_trace_printk() calls it.    
> > > > 
> > > > Interesting. BTW, the same information (trace_printk is for debugging
> > > > only) is repeated all over the place, including where bpf_trace_printk
> > > > is documented:
> > > > https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h#L757
> > > > https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/bpf.h#L706
> > > > https://elixir.bootlin.com/linux/latest/source/kernel/trace/trace.c#L3157
> > > > 
> > > > Steven added that warning (2184db46e425c ("tracing: Print nasty banner
> > > > when trace_printk() is in use")), so maybe he can confirm if it's
> > > > still relevant.    
> > > 
> > > The banner is nasty and it's actively causing harm.  
> > 
> > And it's doing exactly what it was intended on doing!  
> 
> I disagree. The message is _lying_ about the state of the kernel.
> It's not a debug kernel and it's absolutely fine for production.

No it is not!

It causes the trace buffer to be filled with crap that can not be
easily disabled. That's the reason I only allowed trace_printk() for
debug kernels. And the only way to prevent people from sticking it in
their code and making an API out of it was for this banner.

I refuse to remove that banner. It's my API!

> > 
> > Now I do have an answer for you that I believe is a great compromise.
> > 
> > There's something you can call (and even call it from a module). It's
> > called "trace_array_vprintk()". But has one caveat, and that is, you
> > can not write to the main top level trace buffer with it (I have
> > patches for the next merge window to enforce that). And that's what
> > I've been trying to avoid trace_printk() from doing, as that's what it
> > does by default. It writes to /sys/kernel/tracing/trace.
> > 
> > Now what you can do, is have bpf create
> > a /sys/kernel/tracing/instances/bpf_trace/ instance, and use
> > trace_array_printk(), to print into that, and you will never have to
> > see that warning again! It shows up in your own
> > tracefs/instances/bpf_trace/trace file!
> > 
> > If you need more details, let me know, and I can give you all you need
> > to know to create you very own trace instance (that can enable events,
> > kprobe events, uprobe events, function tracing, and soon function graph
> > tracing). And the bonus, you get trace_array_vprintk() and no more
> > complaining. :-) :-) :-)  
> 
> We added a bunch of code to libbcc in the past to support instances,
> but eventually removed it all due to memory overhead per instance.
> If I recall it was ~8Mbyte per instance. That was couple years ago.

I'd like to see where that 8 MB per instance came from. You can control
the size of the instance buffers. If size is still an issue, I'll be
happy to work with you to fix it.


> 
> By now everyone has learned to use bpf_trace_printk() and expects
> to see the output in /sys/kernel/debug/tracing/trace.
> It's documented in uapi/bpf.h and various docs.

Re-teach them, or are you finally admitting that the tracing system is
a permanent API?  This is the reason people are refusing to add trace
points into their subsystems. Because user space may make it required.

I see no reason why you can't create a dedicated BPF tracing instance
(you only need one) to add all your trace_array_printk()s to.

-- Steve


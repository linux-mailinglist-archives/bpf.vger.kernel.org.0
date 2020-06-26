Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14B20BC45
	for <lists+bpf@lfdr.de>; Sat, 27 Jun 2020 00:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgFZWPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jun 2020 18:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgFZWPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jun 2020 18:15:02 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9BE20663;
        Fri, 26 Jun 2020 22:14:57 +0000 (UTC)
Date:   Fri, 26 Jun 2020 18:14:55 -0400
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
Message-ID: <20200626181455.155912d9@oasis.local.home>
In-Reply-To: <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
References: <20200624084524.259560-1-drinkcat@chromium.org>
        <20200624120408.12c8fa0d@oasis.local.home>
        <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
        <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
        <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Jun 2020 20:59:13 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > >
> > > Nack.

I nack your nack ;-)

> > > The message is bogus. It's used in production kernels.
> > > bpf_trace_printk() calls it.  
> > 
> > Interesting. BTW, the same information (trace_printk is for debugging
> > only) is repeated all over the place, including where bpf_trace_printk
> > is documented:
> > https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h#L757
> > https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/bpf.h#L706
> > https://elixir.bootlin.com/linux/latest/source/kernel/trace/trace.c#L3157
> > 
> > Steven added that warning (2184db46e425c ("tracing: Print nasty banner
> > when trace_printk() is in use")), so maybe he can confirm if it's
> > still relevant.  
> 
> The banner is nasty and it's actively causing harm.

And it's doing exactly what it was intended on doing!

> Every few month I have to explain to users that it's absolulte ok to
> ignore that banner. Nothing bad is happening with the kernel.
> The kernel is still perfectly safe for production use.
> It's not a debug kernel.
> 
> What bpf_trace_printk() doc is saying that it's not recommended to use
> this helper for production bpf programs. There are better alternatives.
> It is absolutely fine to use bpf_trace_printk() to debug production and
> experimental bpf programs on production servers, android phones and
> everywhere else.

Now I do have an answer for you that I believe is a great compromise.

There's something you can call (and even call it from a module). It's
called "trace_array_vprintk()". But has one caveat, and that is, you
can not write to the main top level trace buffer with it (I have
patches for the next merge window to enforce that). And that's what
I've been trying to avoid trace_printk() from doing, as that's what it
does by default. It writes to /sys/kernel/tracing/trace.

Now what you can do, is have bpf create
a /sys/kernel/tracing/instances/bpf_trace/ instance, and use
trace_array_printk(), to print into that, and you will never have to
see that warning again! It shows up in your own
tracefs/instances/bpf_trace/trace file!

If you need more details, let me know, and I can give you all you need
to know to create you very own trace instance (that can enable events,
kprobe events, uprobe events, function tracing, and soon function graph
tracing). And the bonus, you get trace_array_vprintk() and no more
complaining. :-) :-) :-)

-- Steve

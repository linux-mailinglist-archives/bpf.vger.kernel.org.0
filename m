Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D1B20C9EE
	for <lists+bpf@lfdr.de>; Sun, 28 Jun 2020 21:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgF1Tng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Jun 2020 15:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgF1Tng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Jun 2020 15:43:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92FF9206A1;
        Sun, 28 Jun 2020 19:43:33 +0000 (UTC)
Date:   Sun, 28 Jun 2020 15:43:31 -0400
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
Message-ID: <20200628154331.2c69d43e@oasis.local.home>
In-Reply-To: <20200628192107.sa3ppfmxtgxh7sfs@ast-mbp.dhcp.thefacebook.com>
References: <20200624084524.259560-1-drinkcat@chromium.org>
        <20200624120408.12c8fa0d@oasis.local.home>
        <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
        <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
        <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
        <20200626181455.155912d9@oasis.local.home>
        <20200628172700.5ea422tmw77otadn@ast-mbp.dhcp.thefacebook.com>
        <20200628144616.52f09152@oasis.local.home>
        <20200628192107.sa3ppfmxtgxh7sfs@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

 On Sun, 28 Jun 2020 12:21:07 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > Re-teach them, or are you finally admitting that the tracing system is
> > a permanent API?  This is the reason people are refusing to add trace
> > points into their subsystems. Because user space may make it required.
> > 
> > I see no reason why you can't create a dedicated BPF tracing instance
> > (you only need one) to add all your trace_array_printk()s to.  
> 
> All bpf helpers are stable api. We cannot remove bpf_trace_printk() and
> cannot change the fact that it has to print into /sys/kernel/debug/tracing/trace.

Then do a bpf trace event and enable it when a bpf_trace_printk() is
loaded. It will work the same for your users.

> If we do so a lot of users will complain. Loudly.
> If you really want to see the flames, go ahead and rename 'trace_pipe'
> into something else.

The layout of the tracefs system *is* a stable API. No argument there.

> This has nothing to do with tracing in general and tracepoints.
> Those come and go.

And in this case, trace_printk() is no different than any other trace
event. Obviously, your use case doesn't let it go. If some tool starts
relying on another trace event (say someone adds another bpf handler that
enables a trace event, and is documented) then under your scenario,
it's a stable API.

Hence, your "tracepoints come and go" is not universal, and there's no
telling which ones will end up being a stable API.


> If you really want to nuke trace_printk from the kernel we need time
> to work on replacement and give users at least few releases of helper
> deprecation time.

I never said I would nuke it. This patch in question makes it so those
that don't want that banner to ever show up can do so. A trace-printk()
is something to add via compiling. And since I and others use it
heavily for debugging, I would have this option not be a default, but
something that others can enable.

> We've never done in the past though.
> There could be flames even if we deprecate it gradually.
> Looking how unyielding you're about this banner I guess we have to start
> working on replacement sooner than later. Oh well.

Hmm, so you are happier to bully and burn bridges with me to deprecate
the trace_printk() interface, than to work with me and add an update to
look into an instance for the print instead of the top level? That's
not very collaborative.

-- Steve

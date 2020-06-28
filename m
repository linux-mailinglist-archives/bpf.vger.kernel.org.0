Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22A120CAED
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 00:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgF1W2r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Jun 2020 18:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgF1W2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Jun 2020 18:28:47 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A06CD206E9;
        Sun, 28 Jun 2020 22:28:44 +0000 (UTC)
Date:   Sun, 28 Jun 2020 18:28:42 -0400
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
Message-ID: <20200628182842.2abb0de2@oasis.local.home>
In-Reply-To: <20200628220209.3oztcjnzsotlfria@ast-mbp.dhcp.thefacebook.com>
References: <20200624084524.259560-1-drinkcat@chromium.org>
        <20200624120408.12c8fa0d@oasis.local.home>
        <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
        <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
        <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
        <20200626181455.155912d9@oasis.local.home>
        <20200628172700.5ea422tmw77otadn@ast-mbp.dhcp.thefacebook.com>
        <20200628144616.52f09152@oasis.local.home>
        <20200628192107.sa3ppfmxtgxh7sfs@ast-mbp.dhcp.thefacebook.com>
        <20200628154331.2c69d43e@oasis.local.home>
        <20200628220209.3oztcjnzsotlfria@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 28 Jun 2020 15:02:09 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > 
> > Then do a bpf trace event and enable it when a bpf_trace_printk() is
> > loaded. It will work the same for your users.  
> 
> I'm not sure I follow. How that would preserve the expectation
> to see the output in /sys/kernel/debug/tracing/trace ?

You create a bpf event just like you create any other event. When a bpf
program that uses a bpf_trace_printk() is loaded, you can enable that
event from within the kernel. Yes, there's internal interfaces to
enabled and disable events just like echoing 1 into
tracefs/events/system/event/enable. See trace_set_clr_event().

Then the data of that event will appear in
the /sys/kernel/tracing/trace file just like the trace_printk does.

The difference is, if something in the kernel decides to use that
event, I can easily disable it from user space, where trace_printk() I
can't.


> > 
> > Hmm, so you are happier to bully and burn bridges with me to deprecate
> > the trace_printk() interface, than to work with me and add an update to
> > look into an instance for the print instead of the top level? That's
> > not very collaborative.  
> 
> I'm seeing it differently.
> I'm saying bpf users are complaining about misleading dmesg warning.
> You're saying 'screw your users I want to keep that warning'.
> Though the warning is lying with a straight face. The only thing happened
> is few pages were allocated that will never be freed. The kernel didn't
> suddenly become non-production. It didn't become slower. No debug features
> were turned on.

Come now Alexei. That banner was there from day one trace_printk() was
added into the kernel. YOU used this knowing damn well that banner
existed. If the bpf users should be upset with someone, it is you for
not asking me for how to do this properly from the beginning.

This is not a regression. trace_printk() always has shown this, and
when I added trace_printk() I stated this is only for debugging a
kernel, and not to be kept in mainline. That banner helped enforce
that. If I didn't do that, there would be trace_printk()s all over the
place, and there's no way to disable one without disabling all the
others. This would have made trace_printk() become useless for
debugging a kernel, as then you will have to deal with everyone's
trace_printks() adding noise to what you want to debug.

-- Steve


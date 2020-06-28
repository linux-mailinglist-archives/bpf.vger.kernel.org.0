Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C20420C93F
	for <lists+bpf@lfdr.de>; Sun, 28 Jun 2020 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgF1R1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Jun 2020 13:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgF1R1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Jun 2020 13:27:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA83C03E979;
        Sun, 28 Jun 2020 10:27:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so4274842pgf.0;
        Sun, 28 Jun 2020 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bjuKIwrHXRrjet6X0ouLLC01GCKaJ752wLzJS383UoA=;
        b=jWq8ksRbTI2bw2B6kfISIq0pN8gsY5L7ckCsdRoJ1Gx85/RRUsCeCohc0kEKMFTBoK
         0dUagVu2u0PIgOVFS9YJqBVlOGa9T/pTqKipqmr5JOwftXg0qbK2E840QQ/XftzaEk0w
         Dla1mEhYWIVwTXrB3mfDZaGEagn/nEejPI5ZEMFDPaQMKBzYe187paZ9lpsoXtv51Yp3
         dvSQTI/w+/qiwKd62gUbQ3WVTnXeyWy8KXevddygfCAH+u9JqR6WInvi2xmZxzqI7x2K
         /dezYHYdXi9+WIiBsTj4Pq8CKKOTDUIJOkP5DHygmSTj3TeR7OEnCfgHTpsmlEVAU9hP
         z2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bjuKIwrHXRrjet6X0ouLLC01GCKaJ752wLzJS383UoA=;
        b=KL1gyZHGpWCa2hakO5xIV1lqO4E1QwWHhiNLgulRjwB4nkeCeFScVM4GRTbwNU0FuR
         HBGzVWLfRjYBMMDPWihEvYUxEJts9k5D7lrzTtQrTspO7Gv+MKO1Qzkwn3/r4TZ5+7rs
         WJTdrWVOU75iT87Am9RXBmv0U5e4N8Vb893nT+Pr0HlJ2xzbfsnWg/wPZeUWVknCmvXa
         RXh+wpaJUp3P5g2yDh/SvuHgmg6I64TXTW6t0d3qgZx26hKj9aXqfPTrnmuuMn68x4fW
         nBpKcBNw5XDnBM4OZewaZ35BtFJqQwnHgxWaC8bYU9PLOEsrun2dXHYJ7KLMri0zlf0F
         Vh1w==
X-Gm-Message-State: AOAM530JiL7EaH7YMSFCgS6GReovTLL/jiRLOvmscBqOQXqk7qfcwm2T
        mD0gFqbUcTPwjkFD+7a1ZQU=
X-Google-Smtp-Source: ABdhPJwELS9/13z/j91e47mWZNjaPYntb7B337DFK9LRVj+yiD5RQ1rQuPiWF8inXcMlgwxYFEqSqQ==
X-Received: by 2002:a63:df54:: with SMTP id h20mr6967108pgj.319.1593365224098;
        Sun, 28 Jun 2020 10:27:04 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:616])
        by smtp.gmail.com with ESMTPSA id t24sm27489187pgm.10.2020.06.28.10.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 10:27:03 -0700 (PDT)
Date:   Sun, 28 Jun 2020 10:27:00 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20200628172700.5ea422tmw77otadn@ast-mbp.dhcp.thefacebook.com>
References: <20200624084524.259560-1-drinkcat@chromium.org>
 <20200624120408.12c8fa0d@oasis.local.home>
 <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
 <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
 <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
 <20200626181455.155912d9@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626181455.155912d9@oasis.local.home>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 26, 2020 at 06:14:55PM -0400, Steven Rostedt wrote:
> On Wed, 24 Jun 2020 20:59:13 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > > >
> > > > Nack.
> 
> I nack your nack ;-)

ok. let's take it up to Linus to decide.

> 
> > > > The message is bogus. It's used in production kernels.
> > > > bpf_trace_printk() calls it.  
> > > 
> > > Interesting. BTW, the same information (trace_printk is for debugging
> > > only) is repeated all over the place, including where bpf_trace_printk
> > > is documented:
> > > https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h#L757
> > > https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/bpf.h#L706
> > > https://elixir.bootlin.com/linux/latest/source/kernel/trace/trace.c#L3157
> > > 
> > > Steven added that warning (2184db46e425c ("tracing: Print nasty banner
> > > when trace_printk() is in use")), so maybe he can confirm if it's
> > > still relevant.  
> > 
> > The banner is nasty and it's actively causing harm.
> 
> And it's doing exactly what it was intended on doing!

I disagree. The message is _lying_ about the state of the kernel.
It's not a debug kernel and it's absolutely fine for production.

> > Every few month I have to explain to users that it's absolulte ok to
> > ignore that banner. Nothing bad is happening with the kernel.
> > The kernel is still perfectly safe for production use.
> > It's not a debug kernel.
> > 
> > What bpf_trace_printk() doc is saying that it's not recommended to use
> > this helper for production bpf programs. There are better alternatives.
> > It is absolutely fine to use bpf_trace_printk() to debug production and
> > experimental bpf programs on production servers, android phones and
> > everywhere else.
> 
> Now I do have an answer for you that I believe is a great compromise.
> 
> There's something you can call (and even call it from a module). It's
> called "trace_array_vprintk()". But has one caveat, and that is, you
> can not write to the main top level trace buffer with it (I have
> patches for the next merge window to enforce that). And that's what
> I've been trying to avoid trace_printk() from doing, as that's what it
> does by default. It writes to /sys/kernel/tracing/trace.
> 
> Now what you can do, is have bpf create
> a /sys/kernel/tracing/instances/bpf_trace/ instance, and use
> trace_array_printk(), to print into that, and you will never have to
> see that warning again! It shows up in your own
> tracefs/instances/bpf_trace/trace file!
> 
> If you need more details, let me know, and I can give you all you need
> to know to create you very own trace instance (that can enable events,
> kprobe events, uprobe events, function tracing, and soon function graph
> tracing). And the bonus, you get trace_array_vprintk() and no more
> complaining. :-) :-) :-)

We added a bunch of code to libbcc in the past to support instances,
but eventually removed it all due to memory overhead per instance.
If I recall it was ~8Mbyte per instance. That was couple years ago.

By now everyone has learned to use bpf_trace_printk() and expects
to see the output in /sys/kernel/debug/tracing/trace.
It's documented in uapi/bpf.h and various docs.

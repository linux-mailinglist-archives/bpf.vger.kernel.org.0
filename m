Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6E20CAD6
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 00:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgF1WCO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Jun 2020 18:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgF1WCO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Jun 2020 18:02:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A7BC03E979;
        Sun, 28 Jun 2020 15:02:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h22so7158570pjf.1;
        Sun, 28 Jun 2020 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VqS8bhh7NwFVANMN9R3qApVh1yAOo5mpLwb4AxLehrs=;
        b=pSoQPHn8B/aKIukyq684XfojXbHedNxAIZMz8csdJVWfnKT8rRpYl7Xg05MrMtyKxY
         FE2qs/skTluTscm0tc5npNQwMOG/DKZooTZd7+/pFBXG4nfR79VPuBbhjNh4F3pLxmqM
         mgPq5G0mkd8ZKsNXImsfUQO/vR1F2PufphUTXPu1/cy/+tE4Y4lXgDOmWU2zmrRHy3YI
         Ig19n6i5NFcAIqd2UyME+9QMkG7LFUcqtnNjxnihoEbndbemMKjfKZv6ku/8oLCjbfD9
         P8uP6CuYIDRBut49iWJOQMxntxjFpF9ugH+QlveancJV9OTzfGOS5OCzE6+mwaBj29ON
         zgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VqS8bhh7NwFVANMN9R3qApVh1yAOo5mpLwb4AxLehrs=;
        b=j4Gu9wgQX7+ZQSHMuD/Aoyce3FLg1dJq7o2j6EGvczeiiT7MHUUwmVjhxP3tfv451P
         WnUXSiimbNEf9ki3vXdqKLhjDRa4ixwImGVPiNhD5e37u0tyeWwW4PQz9h22sr3u7/yb
         zVNA5KZk4m21L1FbmYZ+wh+d4y3aOMQi4HWnKX4vTsWuWbv1Sud7IQm9uTw9Sxrs4F4H
         E3HX1phx2av2udKqiVG45PMQf8edXYOK9B+O/WiwDz1rieFbiaFkB6Vq5BD+AZrTVzeA
         mQ7SIQ6wQI63HQFp4SYaHT2UgIlvXgd4TaN1GTS2NDwdYaA0XB56m9/U2K9iO0pZW9iL
         hPeA==
X-Gm-Message-State: AOAM530LXYheumkSjCN4zyf0jnzUiRAujDXXf9UxOQ0xK8Ogt9MQcaid
        io7JMLP3dKleUBtJ6VY+LAs=
X-Google-Smtp-Source: ABdhPJyYpBT/Hwn+BAItA3VjPPwHiNXJpf6HpsMFV91E5xL65/OYaRSP16zH/g+mwDzEr0KZFoS/Og==
X-Received: by 2002:a17:90a:26c6:: with SMTP id m64mr391100pje.215.1593381733480;
        Sun, 28 Jun 2020 15:02:13 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:616])
        by smtp.gmail.com with ESMTPSA id m14sm17098356pjv.12.2020.06.28.15.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 15:02:12 -0700 (PDT)
Date:   Sun, 28 Jun 2020 15:02:09 -0700
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
Message-ID: <20200628220209.3oztcjnzsotlfria@ast-mbp.dhcp.thefacebook.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628154331.2c69d43e@oasis.local.home>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 28, 2020 at 03:43:31PM -0400, Steven Rostedt wrote:
>  On Sun, 28 Jun 2020 12:21:07 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > > Re-teach them, or are you finally admitting that the tracing system is
> > > a permanent API?  This is the reason people are refusing to add trace
> > > points into their subsystems. Because user space may make it required.
> > > 
> > > I see no reason why you can't create a dedicated BPF tracing instance
> > > (you only need one) to add all your trace_array_printk()s to.  
> > 
> > All bpf helpers are stable api. We cannot remove bpf_trace_printk() and
> > cannot change the fact that it has to print into /sys/kernel/debug/tracing/trace.
> 
> Then do a bpf trace event and enable it when a bpf_trace_printk() is
> loaded. It will work the same for your users.

I'm not sure I follow. How that would preserve the expectation
to see the output in /sys/kernel/debug/tracing/trace ?

> > If we do so a lot of users will complain. Loudly.
> > If you really want to see the flames, go ahead and rename 'trace_pipe'
> > into something else.
> 
> The layout of the tracefs system *is* a stable API. No argument there.
> 
> > This has nothing to do with tracing in general and tracepoints.
> > Those come and go.
> 
> And in this case, trace_printk() is no different than any other trace
> event. Obviously, your use case doesn't let it go. If some tool starts
> relying on another trace event (say someone adds another bpf handler that
> enables a trace event, and is documented) then under your scenario,
> it's a stable API.

not quite. Documneting kprobe+bpf as an example and writing a blog and a book
about it doesn't make it stable.

> 
> Hence, your "tracepoints come and go" is not universal, and there's no
> telling which ones will end up being a stable API.
> 
> 
> > If you really want to nuke trace_printk from the kernel we need time
> > to work on replacement and give users at least few releases of helper
> > deprecation time.
> 
> I never said I would nuke it. This patch in question makes it so those
> that don't want that banner to ever show up can do so. A trace-printk()
> is something to add via compiling. And since I and others use it
> heavily for debugging, I would have this option not be a default, but
> something that others can enable.
> 
> > We've never done in the past though.
> > There could be flames even if we deprecate it gradually.
> > Looking how unyielding you're about this banner I guess we have to start
> > working on replacement sooner than later. Oh well.
> 
> Hmm, so you are happier to bully and burn bridges with me to deprecate
> the trace_printk() interface, than to work with me and add an update to
> look into an instance for the print instead of the top level? That's
> not very collaborative.

I'm seeing it differently.
I'm saying bpf users are complaining about misleading dmesg warning.
You're saying 'screw your users I want to keep that warning'.
Though the warning is lying with a straight face. The only thing happened
is few pages were allocated that will never be freed. The kernel didn't
suddenly become non-production. It didn't become slower. No debug features
were turned on.

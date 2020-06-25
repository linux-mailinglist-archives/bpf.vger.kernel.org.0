Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3E72098D3
	for <lists+bpf@lfdr.de>; Thu, 25 Jun 2020 05:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbgFYD7U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 23:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbgFYD7T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 23:59:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4650FC061573;
        Wed, 24 Jun 2020 20:59:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j4so2218983plk.3;
        Wed, 24 Jun 2020 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QUMoNwc9dGmOGskLKFiTixLHPu4FnFfX6iAmslzBe2E=;
        b=gSYYRKAegLzZuWF302Q2DSP+skdY94rm2eB+k3FbsuRKRa0cQAd2qi0cCELsBJ4f8d
         fbA5YKrBFcFzuBUMva6q5r6PA9h+jACuEtHsPHbtKdIWD5Wd24WyldYR//3I7qh6RW9J
         s1gI7IXeWdz6ZX6ghCbpblknEZBzLXYrByFGHTQs9V7EWkdY9IlERlg1EzWoupJ7xJZr
         n7VmGNA1Xu/FTaPBBvX/1muYNf8HCUax2wMjuZri9bJr/xo0F2kUt8Tt2jUSONVDJRiD
         56Zfh8IphUjvMXFgXkDu4ZRFq5vqEMTRtMjturXrFNTh8OkNrYDoAP3SdqS3L2Q6Spzr
         wtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QUMoNwc9dGmOGskLKFiTixLHPu4FnFfX6iAmslzBe2E=;
        b=A0fwxbmFsvoQTmGsODPD2el92zRQcPtWDjm/eYqflJywdoY9kJ+hV/EVI1DA7yHknU
         sSblhLfbofL+CarlYQUEGOv1qZ6w/PfyH94hhpc/2m6EtRKIqptH7lostLC4O7zU3z+U
         nrrG6a+//+KS29R9LDzbic4MjlmmYh6Amcnk1B21xneVpERFPfKSF2FdwpC0uwCvk87K
         zfGGt/yD8IV419ijy/gq2bEoxwJeK/0GyJakNH9DopRzbtXHHdFpDt+l95QVN5qsqMR2
         HCSzTv8e6+HcQQTtcYBQSe7FpIny7J5YPeTUEYwzqSA56rg0XriD9eGRsLsSYUcG6x6G
         pNaA==
X-Gm-Message-State: AOAM533tLxToNUVv31tWAzfW9AmlL261UBbDRR2VqKPZNpMi7MDM2z2N
        D0b2Mujvmu7Uj6Pz9qMpASYleSx8
X-Google-Smtp-Source: ABdhPJyHMTMJPUzrhGGnkh3V3vR+R75Gk7LpHdvhxwTsdZjnGQyZfCJ3zxg3ApCDgTu1r3ffjoiBlQ==
X-Received: by 2002:a17:90b:1981:: with SMTP id mv1mr1112443pjb.41.1593057557595;
        Wed, 24 Jun 2020 20:59:17 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:cac0])
        by smtp.gmail.com with ESMTPSA id w203sm11376708pfc.128.2020.06.24.20.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 20:59:16 -0700 (PDT)
Date:   Wed, 24 Jun 2020 20:59:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
References: <20200624084524.259560-1-drinkcat@chromium.org>
 <20200624120408.12c8fa0d@oasis.local.home>
 <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
 <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 25, 2020 at 10:00:09AM +0800, Nicolas Boichat wrote:
> On Thu, Jun 25, 2020 at 1:25 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 9:07 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed, 24 Jun 2020 16:45:24 +0800
> > > Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > > trace_printk is only meant as a debugging tool, and should never be
> > > > compiled into production code without source code changes, as
> > > > indicated by the warning that shows up on boot if any trace_printk
> > > > is called:
> > > >  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> > > >  **                                                      **
> > > >  ** trace_printk() being used. Allocating extra memory.  **
> > > >  **                                                      **
> > > >  ** This means that this is a DEBUG kernel and it is     **
> > > >  ** unsafe for production use.                           **
> > > >
> > > > If this option is set to n, the kernel will generate a build-time
> > > > error if trace_printk is used.
> > > >
> > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > >
> > > Interesting. Note, this will prevent modules with trace_printk from
> > > being loaded as well.
> >
> > Nack.
> > The message is bogus. It's used in production kernels.
> > bpf_trace_printk() calls it.
> 
> Interesting. BTW, the same information (trace_printk is for debugging
> only) is repeated all over the place, including where bpf_trace_printk
> is documented:
> https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h#L757
> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/bpf.h#L706
> https://elixir.bootlin.com/linux/latest/source/kernel/trace/trace.c#L3157
> 
> Steven added that warning (2184db46e425c ("tracing: Print nasty banner
> when trace_printk() is in use")), so maybe he can confirm if it's
> still relevant.

The banner is nasty and it's actively causing harm.
Every few month I have to explain to users that it's absolulte ok to
ignore that banner. Nothing bad is happening with the kernel.
The kernel is still perfectly safe for production use.
It's not a debug kernel.

What bpf_trace_printk() doc is saying that it's not recommended to use
this helper for production bpf programs. There are better alternatives.
It is absolutely fine to use bpf_trace_printk() to debug production and
experimental bpf programs on production servers, android phones and
everywhere else.

> Also, note that emitting the build error is behind a Kconfig option,
> you don't have to select it if you don't want to (the default is =y
> which allows trace_printk).
> 
> If the overhead is real, we (Chrome OS) would like to make sure
> trace_printk does not slip into production kernels (we do want to
> provide basic tracing support so we can't just remove CONFIG_TRACING
> as a whole which would make trace_printk no-ops). I could also imagine
> potential security issues if people print raw pointers/sensitive data
> in trace_printk, assuming that the code is for debugging only.
> 
> Also, the fact that the kernel test robot already found a stray
> trace_printk in drivers/usb/cdns3/gadget.c makes me think that this
> change is working as intended ,-) (we're going to need to add a few
> Kconfig deps though for other debugging options that intentionally use
> trace_printk).

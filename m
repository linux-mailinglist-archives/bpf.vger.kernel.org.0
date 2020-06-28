Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF920C9DA
	for <lists+bpf@lfdr.de>; Sun, 28 Jun 2020 21:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgF1TVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Jun 2020 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgF1TVL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Jun 2020 15:21:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70942C03E979;
        Sun, 28 Jun 2020 12:21:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so7309902pgh.3;
        Sun, 28 Jun 2020 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=juNBvBEwxyhkL1BHcBnLnRlW48vC/9qZ2CQ7kLNxHj8=;
        b=LuoVAkH1TyOzQ72WQFxBhyluYUsNToJnNWtpVAEiDWzcgPqAgRd0n3yQxCaT5gVF90
         Wm/kTe8E0CTfcysF5FnovZCikh69WMoRQfaN5ZVzS5AyFevvRtMlrEJN/s+vJ6q8Q4MK
         6EmO5iHP8EnS46SvuTEZxsxzXmb6WIdSd0OLMBeboSHgJaIyRXxUpDGzHiWDIPH97cMv
         TiVjQXreeredizeQmMSDY5mL5aMuWUlEfoS85vIz1qKus4qZ/vT0fcWhhOVe+daB3o/9
         EHOqyJS/xnAr6MYfN4VwcUh9PwRTDbERY+QZdc7vyK2p4tHb4ORqNy8IVL7CH5x2AMIg
         pGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=juNBvBEwxyhkL1BHcBnLnRlW48vC/9qZ2CQ7kLNxHj8=;
        b=qMy66YSuhbl2rBKq1WKhsJHHkU1/gkab29ztpq/Kbc8IF7E0nQJx3vLMAaTtyCqZVM
         Rq7AVOhHUfRw9PLnRopKfAHbxRg4srbBKo1mpFBC4lVJWN4HLPQWgZuRadQJLKa1HQTg
         og2Vj2hEA0hjWj+WmoY72MUTVBy32mRhfdW/ihRXPMefCCHiIzlFUXcTHDBLZoDgEAUQ
         TXeR2SZ32Xl881urqoRIrrAqx/Lzvfj9ZtRpZcuMjpD/R8iippY0K55/0p1m4q7uoBT7
         Rm4Phns1hnTbHaZDGZ0N77Q9Mq/IrbbrUJ5wscMQWzoAy0wC5u1WRUpv7C3tygb6z0MB
         jx3g==
X-Gm-Message-State: AOAM531DmYvZ3XQXPtpKwKnoM5iVM0uiReCnlZzFBvCRB3+mSFGIgKm/
        sxJqsyt7ye7KBxEkhxwCinc=
X-Google-Smtp-Source: ABdhPJxVJbsx554JURqQb2p9V7LmwC7Z4Et1fKFei9olGuuLHMC1vWEBDB7O3SwXCDIPs1fQLip43w==
X-Received: by 2002:a62:3303:: with SMTP id z3mr2774223pfz.59.1593372070760;
        Sun, 28 Jun 2020 12:21:10 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:616])
        by smtp.gmail.com with ESMTPSA id 83sm10139134pfu.60.2020.06.28.12.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 12:21:09 -0700 (PDT)
Date:   Sun, 28 Jun 2020 12:21:07 -0700
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
Message-ID: <20200628192107.sa3ppfmxtgxh7sfs@ast-mbp.dhcp.thefacebook.com>
References: <20200624084524.259560-1-drinkcat@chromium.org>
 <20200624120408.12c8fa0d@oasis.local.home>
 <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
 <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
 <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
 <20200626181455.155912d9@oasis.local.home>
 <20200628172700.5ea422tmw77otadn@ast-mbp.dhcp.thefacebook.com>
 <20200628144616.52f09152@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628144616.52f09152@oasis.local.home>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 28, 2020 at 02:46:16PM -0400, Steven Rostedt wrote:
> > 
> > By now everyone has learned to use bpf_trace_printk() and expects
> > to see the output in /sys/kernel/debug/tracing/trace.
> > It's documented in uapi/bpf.h and various docs.
> 
> Re-teach them, or are you finally admitting that the tracing system is
> a permanent API?  This is the reason people are refusing to add trace
> points into their subsystems. Because user space may make it required.
> 
> I see no reason why you can't create a dedicated BPF tracing instance
> (you only need one) to add all your trace_array_printk()s to.

All bpf helpers are stable api. We cannot remove bpf_trace_printk() and
cannot change the fact that it has to print into /sys/kernel/debug/tracing/trace.
If we do so a lot of users will complain. Loudly.
If you really want to see the flames, go ahead and rename 'trace_pipe'
into something else.
This has nothing to do with tracing in general and tracepoints.
Those come and go.
If you really want to nuke trace_printk from the kernel we need time
to work on replacement and give users at least few releases of helper
deprecation time. We've never done in the past though.
There could be flames even if we deprecate it gradually.
Looking how unyielding you're about this banner I guess we have to start
working on replacement sooner than later. Oh well.

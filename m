Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA93D80F7
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 23:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhG0VKE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 17:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhG0VJh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 17:09:37 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA6DC061799
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 14:09:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id s19so294234ybc.6
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VowmoBQHns5A8qcfJjwgHHmXQXhTeUi2UyOBeXLtGcM=;
        b=GHAuCXp00N/K+taMMp5MuokVQqoaSGvyba790JXYmoI7mNY5T/saJbhBFQugfQgnux
         VDQngSonc6gYdm/g/AStGQ34VCmtUvcUv4bcAHaLOwagGcD2SELJ2PhsCIiSSJ4eNcSQ
         NrPkQ1r34cDOnXYcGlYcfa7kYBaf8JJSLH1zVlAYe5r7M21wunxYJnFgyHgkl6U+Zph4
         sI03LUoUrwkQeHOo6bveKny9yLLW0fZ+bAjlTqfuEGtB6dhDO5q7Pg0+333SDI4Pvk1C
         BC+xbqaUB5Gu3Xgw08btmpw2kJORDxnfcwfBA0LuiM+Dt+roOM6JKyXgYh+74D3a6HtI
         jfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VowmoBQHns5A8qcfJjwgHHmXQXhTeUi2UyOBeXLtGcM=;
        b=FFBP1zBPaGtsfH1hRQA5J4zvjQHKZfRlrmfhu4nypmTg3H7PXFLtlnhL5IhIJXDW/E
         WDuUM8rf32o8sUZK5EY3qQ1Xgb7QQcGCtLU590yqfgHVms5A94TwUQbEr2wVuCDko6et
         ZxkkGiaZj6Xzn2c6Xaj2nI/gkLkjDZ1/g2PvKT+7xAa0J/C6uFoL4Lbvhz0POdUOgBic
         XInpZymRbLYQg6bjXtDvvtBO6Xz4J0zLHwxoVuGMxYj3hE3qhfwsVODlR5VAGOsgcaPb
         k47+Z5kMIrwRFFsTg5XZ1xTS2gBD0A837bxJxXFrGP+eJZR2RRBm5XvPdLzkyYBzAgMQ
         gjmg==
X-Gm-Message-State: AOAM532ZarrgXTo8zXQ9Pj/DiX1+S9cPjKtZkHjbHsqO7vWLY3+veo7c
        K8bsCIi/5WA/GWKlC9ThTvXejXlK2r3XAowj2Ng=
X-Google-Smtp-Source: ABdhPJxcwadnx1kF5wo4npZsdcX6bmovpXIKc3E5N4JjnHSG0HpaZKob/+ZSspidqhm03AEsSm2VM3NTx04hKnMRS/Q=
X-Received: by 2002:a25:6148:: with SMTP id v69mr12045964ybb.510.1627420158989;
 Tue, 27 Jul 2021 14:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210726161211.925206-1-andrii@kernel.org> <20210726161211.925206-6-andrii@kernel.org>
 <YP/N1HR6GAanBd9m@hirez.programming.kicks-ass.net>
In-Reply-To: <YP/N1HR6GAanBd9m@hirez.programming.kicks-ass.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Jul 2021 14:09:08 -0700
Message-ID: <CAEf4BzZCOj_rQrUjLnvBNYTDCg6A_5mC7rBuBJxm0Lzr8F5-pg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/14] bpf: allow to specify user-provided
 context value for BPF perf links
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 27, 2021 at 2:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 26, 2021 at 09:12:02AM -0700, Andrii Nakryiko wrote:
> > Add ability for users to specify custom u64 value when creating BPF link for
> > perf_event-backed BPF programs (kprobe/uprobe, perf_event, tracepoints).
>
> If I read this right, the value is dependent on the link, not the
> program. In which case:

You can see it both ways. BPF link in this (and at least few other
cases) is just this invisible orchestrator of BPF program
attachment/detachment. The underlying perf_event subsystem doesn't
know about the existence of the BPF link at all. In the end, it's
actually struct bpf_prog that is added to perf_event or into tp's
bpf_prog_array list, and this user-provided value (bpf cookie per
below) is associated with that particular attachment. So when we call
trace_call_bpf() from tracepoint or kprobe/uprobe, there is no BPF
link anywhere, it's just a list of bpf_prog_array_items, with bpf_prog
pointer and associated user value. Note, exactly the same bpf_prog can
be attached to another perf_event with a completely different cookie
and that's expected and is fine.

So in short, perf_event just needs to know about attaching/detaching
bpf_prog pointer (and this cookie), it doesn't need to know about
bpf_link. Everything is handled the same regardless if bpf_link is
used to attach or ioctl(PERF_EVENT_IOC_SET_BPF).

>
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 2d510ad750ed..97ab46802800 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -762,6 +762,7 @@ struct perf_event {
> >  #ifdef CONFIG_BPF_SYSCALL
> >       perf_overflow_handler_t         orig_overflow_handler;
> >       struct bpf_prog                 *prog;
> > +     u64                             user_ctx;
> >  #endif
> >
> >  #ifdef CONFIG_EVENT_TRACING
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 8ac92560d3a3..4543852f1480 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -675,7 +675,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
> >
> >  #ifdef CONFIG_BPF_EVENTS
> >  unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
> > -int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> > +int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 user_ctx);
>
> This API would be misleading, because it is about setting the program.

Answered above, here perf_event just provides a low-level internal API
for attaching bpf_prog with associated value. BPF link is a
higher-level invisible concept as far as perf_event is concerned.

>
> >  void perf_event_detach_bpf_prog(struct perf_event *event);
> >  int perf_event_query_prog_array(struct perf_event *event, void __user *info);
> >  int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
>
> > @@ -9966,6 +9968,7 @@ static int perf_event_set_bpf_handler(struct perf_event *event, struct bpf_prog
> >       }
> >
> >       event->prog = prog;
> > +     event->user_ctx = user_ctx;
> >       event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
> >       WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
> >       return 0;
>
> Also, the name @user_ctx is a bit confusing. Would something like
> @bpf_cookie or somesuch not be a better name?

I struggled to come up with a good name, user_ctx was the best I could
do. But I do like bpf_cookie for this, thank you! I'll switch the
terminology in the next revision.

>
> Combined would it not make more sense to add something like:
>
> extern int perf_event_set_bpf_cookie(struct perf_event *event, u64 cookie);

Passing that user_ctx along the bpf_prog makes it clear that they go
together and user_ctx is immutable once set. I don't actually plan to
allow updating this cookie value.

>
>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D95333F7
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 01:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbiEXXkL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 19:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbiEXXkH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 19:40:07 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C3F5DA7C
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 16:40:06 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id 3so12875658ily.2
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 16:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lVnptcVVZxz8gglgU751AS5ETSOAYe3JoKUEGpDm5w=;
        b=kpvvyMI3FyDqVBkaTklgqh6n/wISj5MJrxdNVIssAxLfMEz1G0z08cHd39+xUylwxF
         ryCFLVuoWvjJL8Iz6nSOK/3lTJoFIyVDE60C5L4qX+d3nDw4MxT3knF84iD9osLaz9TU
         TFKmPTRFxGD8TlKyZ+GdTJJECcvfnJrGvSGnYivCHg/rH/o+TUy29vl9BQKJKONdcC5E
         VgLFX7684uPnc8zKDvSG3K2EkZr0+HQnbvxQ/sNqdklTm9DXWFtEksNXZlTw4Jf9uUjv
         LyMmkJHDaP6sHzt0m0Z9S8q2bcQhAwoMv0kfyZYVyVW8uzD+XvGtsmHMlkPeyKyqGlaU
         EmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lVnptcVVZxz8gglgU751AS5ETSOAYe3JoKUEGpDm5w=;
        b=ybSN2/v9NntGnU38JwjBSURWkNlZK4LfqR/ehoAlwtXjXi6/uTWbMw+HSkH7VuAraz
         R8RONkiq91NygyJm5H1Qk951Sr/DBpHyb8nL5QuWfMIqlaxvaRoS9i/VRtTOIRw7SHC0
         frwh27fl+54RRKB/FG3cTsHQ8/0oPk0/h+udiIOJxP1LrGnZv+7h/p0uzQkzTr6PuBFN
         q2ys+JUWysk0X8YOCSl1PnQU+49AS2ONSCDodU5iPatXHLfADnuv15GWkXCf5t+efvYd
         iGT9S/wvd32aHpndDJ9yuIqQc0p6WTquhLjqy7WtPckkx3zbXuH727PkB83Tfnx3iE/O
         E6/w==
X-Gm-Message-State: AOAM530vLYQx2bYXCdny3nfCS+R/qjqiixSsawx7dJEfZogj7QxHpbKm
        9eQzB6JcBKs889g+LM3jQid23f9ZNC1yO3A2Qle0LLQI
X-Google-Smtp-Source: ABdhPJw7Gg2+m0u9GLa6zAkp2rgfTTNG0BPxOvjuxK0+wvjt+wTy19vHcoFZ+mXJ9K9Z7Fb5pVUxb4o4dSuAaENl23k=
X-Received: by 2002:a05:6e02:1b8f:b0:2d1:b707:3022 with SMTP id
 h15-20020a056e021b8f00b002d1b7073022mr5195412ili.71.1653435605870; Tue, 24
 May 2022 16:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxVHdL-dT2GQh-HEkNjNoTEzA9DRL4W4ZfmUzc1+Bdz89fftQ@mail.gmail.com>
 <CAEf4BzZg0r4YptYPu8Y_-qp=rY__W6dmb9kLwMV5MAH6C-2PSg@mail.gmail.com>
 <CAPxVHdJbnu5fk5btxATWM5NTd0NofeJREuX_8R_2i3GX_ho87g@mail.gmail.com> <CAPxVHd+_fmCvhhYWCtjjjvzNi5GNfoDP3=aHgihVwzSwN9vKnQ@mail.gmail.com>
In-Reply-To: <CAPxVHd+_fmCvhhYWCtjjjvzNi5GNfoDP3=aHgihVwzSwN9vKnQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 24 May 2022 16:39:54 -0700
Message-ID: <CAEf4BzbhvD_f=y3SDAiFqNvuErcnXt4fErMRSfanjYQg5=7GJg@mail.gmail.com>
Subject: Re: Tracing NVMe Driver with BPF missing events
To:     John Mazzie <john.p.mazzie@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "John Mazzie (jmazzie)" <jmazzie@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 24, 2022 at 9:12 AM John Mazzie <john.p.mazzie@gmail.com> wrote:
>
> After thinking about this more, maybe it's more to do with the
> interrupt handler for nvme_complete_rq.
>
> In this situation, sometimes the handler for nvme_setup_cmd could be
> interrupted to handle nvme_complete_rq and in this situation the
> nvme_complete_rq handler wouldn't run. because the nvme_setup_cmd
> handler is not complete.
>
> Is this understanding correct?

Yes.

> I'm assuming there is no real
> workaround for this situation, so we may just need to accept some
> missed events.

Try using fentry/fexit programs instead. They use different reentrancy
protection which is at a per-program level.

>
> John
>
> On Sat, May 21, 2022 at 11:52 AM John Mazzie <john.p.mazzie@gmail.com> wrote:
> >
> > In this case is a BPF program the individual handler of a tracepoint,
> > or in my context, a BPF program my compiled program that traces both
> > tracepoints? We aren't running any other BPF tracing during these
> > tests besides my program counting these 2 tracepoints.
> >
> > In my program I have 2 handlers, one for
> > tracepoint:nvme:nvme_setup_cmd and another for
> > tracepoint:nvme:nvme_complete_rq. I've created a PERCPU_HASH map for
> > each handler (unique map for each) to use that keeps track of each
> > time the handler is invoked. The only thing that handler is doing in
> > each case is incrementing the count value in the map. Though I do
> > filter by device on each tracepoint. If I comment out the
> > nvme_setup_cmd code the nvme_complete_rq does get the correct count.
> >
> > The user side of my program just prints the values for each of these
> > maps on a 10 second increment.
> >
> > I can share my code to make this easier, is it preferred that I upload
> > my code to github and share the link in this thread?
> >
> > I agree that your suggestion could be my issue, but I just want to
> > make sure we're on the same page since I'm less familiar with the
> > internals of BPF.
> >
> > Thanks,
> > John
> >
> > On Fri, May 20, 2022 at 7:10 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, May 18, 2022 at 2:35 PM John Mazzie <john.p.mazzie@gmail.com> wrote:
> > > >
> > > > My group at Micron is using BPF and love the tracing capabilities it
> > > > provides. We are mainly focused on the storage subsystem and BPF has
> > > > been really helpful in understanding how the storage subsystem
> > > > interacts with our drives while running applications.
> > > >
> > > > In the process of developing a tool using BPF to trace the nvme
> > > > driver, we ran into an issue with some missing events. I wanted to
> > > > check to see if this is possibly a bug/limitation that I'm hitting or
> > > > if it's expected behavior with heavy tracing. We are trying to trace 2
> > > > trace points (nvme_setup_cmd and nvme_complete_rq) around 1M times a
> > > > second.
> > > > We noticed if we just trace one of the two, we see all the expected
> > > > events, but if we trace both at the same time, the nvme_complete_rq
> > >
> > > kprobe programs have per-CPU reentrancy protection. That is, if some
> > > BPF kprobe/tracepoint program is running and something happens (e.g.,
> > > BPF program calls some kernel function that has another BPF program
> > > attached to it, or preemption happens and another BPF program is
> > > supposed to run) that would trigger another BPF program, then that
> > > nested BPF program invocation will be skipped.
> > >
> > > This might be what happens in your case.
> > >
> > > > misses events. I am using two different percpu_hash maps to count both
> > > > events. One for setup and another for complete. My expectation was
> > > > that tracing these events would affect performance, somewhat, but not
> > > > miss events. Ultimately the tool would be used to trace nvme latencies
> > > > at the driver level by device and process.
> > > >
> > > > My tool was developed using libbpf v0.7, and I've tested on Rocky
> > > > Linux 8.5 (Kernel 4.18.0), Ubuntu 20.04 (Kernel 5.4) and Fedora 36
> > > > (Kernel 5.17.6) with the same results.
> > > >
> > > > Thanks,
> > > > John Mazzie
> > > > Principal Storage Solutions Engineer
> > > > Micron Technology, Inc.

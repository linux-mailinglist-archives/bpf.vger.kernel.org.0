Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7346A53C1DE
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 04:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiFCBwm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 21:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiFCBwl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 21:52:41 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4133310C5
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 18:52:40 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id s23so6487973iog.13
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 18:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4QoqGf+lZNXIWOxkAgl/BGLORs0Qx7HPXwKGTBwfro=;
        b=k0fRqahWY6OiXNHa0BywgD0MqhfYzUw3Mh6CGsDDhr2nk9jD7DZHT5OpIwOIJ1L78H
         JnJWHZNvI00ayN6Y5qrJbKWvWKK0xDAHATQPI8KjHacGUxUKpaTD37x7mSqze1zN4R9s
         QGeatR19TfkgTDGcaMdDYw/A3O2Q3ISYHzA4NxtSjFlzccfUKk1L3a85NBJjni3qN+OY
         mEhkPVnC0/Z1CkQyexvwqzMm0MNu5AsOYxF4qKinshwW9hCria+2OFo6peyymrQaGfMB
         DCmpYB5A74vXTLf+D2tHv2QGL/sqMGJfBsB72HxrO0G7R1unhPiX6AXXMl85tuwqgVWX
         cI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4QoqGf+lZNXIWOxkAgl/BGLORs0Qx7HPXwKGTBwfro=;
        b=HJ4bmi71MEgrEv3+do8H1fV7WQMpxsazAq7zpYUpPovMu/mjcrCdZ/Av/DK+8EKhTl
         y95EkGFCVWRjNKqqxLyzYyNp8a5fdZrz/cL3HfsVtVgYnZIOMQovQN4/3lJDiUD9f5ni
         SqB9G36bRp8OloKK+m5pjBV7jbb8gqdte82qLcBdhfZT+lrfeexVMTORRdgccRApbjqI
         KgfZ5N/Dm+y856/7J9sNZn2MY6F04kmQPXFG1ealQE9ekIH6+MJ3BL0fyZY1spIBjAdM
         I7nf6suWZwTTPRj3fQ/odrDD7G9YX48YVUvxUvEmazD1/QQdvT3PQvo90Lc8LkDVijws
         sdpQ==
X-Gm-Message-State: AOAM530zsKJrRJSMCMkUrb40QWpypOLUIWy1XkBdy1WYuAsIfGWOJr1p
        c54ZpTJQCjn2YbFXLtOKCwJdeX9pfSrgS/x6XLax/cUvqNY=
X-Google-Smtp-Source: ABdhPJweWixJoRpuJQ30LEbpvj2VARwzg6MWahXC67zcXrdueuYMaP0VLFg5P7o0dvVWA+RRfsvSVCkEogh9FHvDutQ=
X-Received: by 2002:a02:b18b:0:b0:331:6385:a257 with SMTP id
 t11-20020a02b18b000000b003316385a257mr4026116jah.235.1654221159621; Thu, 02
 Jun 2022 18:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxVHdL-dT2GQh-HEkNjNoTEzA9DRL4W4ZfmUzc1+Bdz89fftQ@mail.gmail.com>
 <CAEf4BzZg0r4YptYPu8Y_-qp=rY__W6dmb9kLwMV5MAH6C-2PSg@mail.gmail.com>
 <CAPxVHdJbnu5fk5btxATWM5NTd0NofeJREuX_8R_2i3GX_ho87g@mail.gmail.com>
 <CAPxVHd+_fmCvhhYWCtjjjvzNi5GNfoDP3=aHgihVwzSwN9vKnQ@mail.gmail.com> <CAEf4BzbhvD_f=y3SDAiFqNvuErcnXt4fErMRSfanjYQg5=7GJg@mail.gmail.com>
In-Reply-To: <CAEf4BzbhvD_f=y3SDAiFqNvuErcnXt4fErMRSfanjYQg5=7GJg@mail.gmail.com>
From:   John Mazzie <john.p.mazzie@gmail.com>
Date:   Thu, 2 Jun 2022 20:52:28 -0500
Message-ID: <CAPxVHdLMsotw3wFDM05kzb7O6kA4PM_uQ4D+DCXYcZbtwdt_ag@mail.gmail.com>
Subject: Re: Tracing NVMe Driver with BPF missing events
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

Thanks for the help. fentry/fexit seem to be working to get every
event when tracing both events.

I do have one question about how fentry/fexit work in regards to the
function parameters. fexit can access the function parameters in
addition to the return value. Let's say the parameters are pointers
whose value changes between entry and exit on the probed function. Are
the parameters being accessed on entry or exit in fexit. My assumption
would be exit, so I could access the modified values. Is that correct?
The data I'm pulling appears like it might just be the entry
(non-configured) values.

On Tue, May 24, 2022 at 6:40 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 24, 2022 at 9:12 AM John Mazzie <john.p.mazzie@gmail.com> wrote:
> >
> > After thinking about this more, maybe it's more to do with the
> > interrupt handler for nvme_complete_rq.
> >
> > In this situation, sometimes the handler for nvme_setup_cmd could be
> > interrupted to handle nvme_complete_rq and in this situation the
> > nvme_complete_rq handler wouldn't run. because the nvme_setup_cmd
> > handler is not complete.
> >
> > Is this understanding correct?
>
> Yes.
>
> > I'm assuming there is no real
> > workaround for this situation, so we may just need to accept some
> > missed events.
>
> Try using fentry/fexit programs instead. They use different reentrancy
> protection which is at a per-program level.
>
> >
> > John
> >
> > On Sat, May 21, 2022 at 11:52 AM John Mazzie <john.p.mazzie@gmail.com> wrote:
> > >
> > > In this case is a BPF program the individual handler of a tracepoint,
> > > or in my context, a BPF program my compiled program that traces both
> > > tracepoints? We aren't running any other BPF tracing during these
> > > tests besides my program counting these 2 tracepoints.
> > >
> > > In my program I have 2 handlers, one for
> > > tracepoint:nvme:nvme_setup_cmd and another for
> > > tracepoint:nvme:nvme_complete_rq. I've created a PERCPU_HASH map for
> > > each handler (unique map for each) to use that keeps track of each
> > > time the handler is invoked. The only thing that handler is doing in
> > > each case is incrementing the count value in the map. Though I do
> > > filter by device on each tracepoint. If I comment out the
> > > nvme_setup_cmd code the nvme_complete_rq does get the correct count.
> > >
> > > The user side of my program just prints the values for each of these
> > > maps on a 10 second increment.
> > >
> > > I can share my code to make this easier, is it preferred that I upload
> > > my code to github and share the link in this thread?
> > >
> > > I agree that your suggestion could be my issue, but I just want to
> > > make sure we're on the same page since I'm less familiar with the
> > > internals of BPF.
> > >
> > > Thanks,
> > > John
> > >
> > > On Fri, May 20, 2022 at 7:10 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, May 18, 2022 at 2:35 PM John Mazzie <john.p.mazzie@gmail.com> wrote:
> > > > >
> > > > > My group at Micron is using BPF and love the tracing capabilities it
> > > > > provides. We are mainly focused on the storage subsystem and BPF has
> > > > > been really helpful in understanding how the storage subsystem
> > > > > interacts with our drives while running applications.
> > > > >
> > > > > In the process of developing a tool using BPF to trace the nvme
> > > > > driver, we ran into an issue with some missing events. I wanted to
> > > > > check to see if this is possibly a bug/limitation that I'm hitting or
> > > > > if it's expected behavior with heavy tracing. We are trying to trace 2
> > > > > trace points (nvme_setup_cmd and nvme_complete_rq) around 1M times a
> > > > > second.
> > > > > We noticed if we just trace one of the two, we see all the expected
> > > > > events, but if we trace both at the same time, the nvme_complete_rq
> > > >
> > > > kprobe programs have per-CPU reentrancy protection. That is, if some
> > > > BPF kprobe/tracepoint program is running and something happens (e.g.,
> > > > BPF program calls some kernel function that has another BPF program
> > > > attached to it, or preemption happens and another BPF program is
> > > > supposed to run) that would trigger another BPF program, then that
> > > > nested BPF program invocation will be skipped.
> > > >
> > > > This might be what happens in your case.
> > > >
> > > > > misses events. I am using two different percpu_hash maps to count both
> > > > > events. One for setup and another for complete. My expectation was
> > > > > that tracing these events would affect performance, somewhat, but not
> > > > > miss events. Ultimately the tool would be used to trace nvme latencies
> > > > > at the driver level by device and process.
> > > > >
> > > > > My tool was developed using libbpf v0.7, and I've tested on Rocky
> > > > > Linux 8.5 (Kernel 4.18.0), Ubuntu 20.04 (Kernel 5.4) and Fedora 36
> > > > > (Kernel 5.17.6) with the same results.
> > > > >
> > > > > Thanks,
> > > > > John Mazzie
> > > > > Principal Storage Solutions Engineer
> > > > > Micron Technology, Inc.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBD2532EAE
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiEXQMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 12:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiEXQMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 12:12:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967B7E1DA
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 09:12:52 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d198so13772995iof.12
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PqnGyjMG/9xSW1zrt309NMQhq/hbepQwLrO4jaLcpgU=;
        b=h2nyyc3N7FOMlm/oSnvjLjnwe8Uo2EbEKNdPZZBUjaEhMFvzxG3h4TmG7ur2yw3K+N
         LRcBan9LvqX8nxR18WCdyv63nZOeaaHbtZd3fpcOs24G9qm/NgHzbxd/ans0qDfrLKYk
         VsRwphyP/rCPtPkJxGmq2HHUg/aJl5NHGE6nI8DHWJNO1jvgg4frnn/8a6XJSieAx9Wk
         ZfWYxhzj6EwX3y4O0Y3Rl0Up4/dA/BycZsGilLIhehe+lQWaIQRgGwvNS5CqSbmKDtih
         Ic4dtv0CMolWZ8ihDDHMa3qdv/HBMTc1oJ79EM3ze01Z5aueRVPdni/tYs7RKZ1+JjMk
         R20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqnGyjMG/9xSW1zrt309NMQhq/hbepQwLrO4jaLcpgU=;
        b=5THbNA/3uK7Aiff29nTcBUVp/mx9lw2odhAe7n+y0FVuE+6vN26JT9FQeeJogxUpUu
         Cl2kWLcwdn0AlEW8NXT9qXgC+4tbUd9kC0TsZHdkkkKE+QB3P73dRVkOL0dXCIYFkhxE
         Q/JiBrYIDRpmSU7wYndI1gvkczyfdCfCAJkoI9/a8rOnvdMBGYt12bgJpE7NwfnBbUSu
         jnKxr8tdixghVLU9ngLl/TZ3FI32MxZiflsTZ/9XURzDRXn/JszxJH1bajyKP7mgxHzO
         Fi046MPOhoH7UoScwsmknDaNQlfeCviDovW9Z95iHb7Vw02okTy12bkI3AgSULKkZEev
         ZRQg==
X-Gm-Message-State: AOAM532YQ7Rw/JjVVV37ZOYXe/LbXVCpY2TcwtgvfgRXsNgTjM0qG7Mu
        LkrsIiCEsThpLJCrypNcMjG0jkxe+Ot/9CrsfD0=
X-Google-Smtp-Source: ABdhPJzKeM2bI+FV6XhQv4wmRqOuePnzwxBcM64YGhSWAUcxOIWtEjPafZTXw2xfCQHIEFnJ62JuWKmIjR8I+43rbY4=
X-Received: by 2002:a6b:ed06:0:b0:649:d35f:852c with SMTP id
 n6-20020a6bed06000000b00649d35f852cmr12594236iog.186.1653408771926; Tue, 24
 May 2022 09:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxVHdL-dT2GQh-HEkNjNoTEzA9DRL4W4ZfmUzc1+Bdz89fftQ@mail.gmail.com>
 <CAEf4BzZg0r4YptYPu8Y_-qp=rY__W6dmb9kLwMV5MAH6C-2PSg@mail.gmail.com> <CAPxVHdJbnu5fk5btxATWM5NTd0NofeJREuX_8R_2i3GX_ho87g@mail.gmail.com>
In-Reply-To: <CAPxVHdJbnu5fk5btxATWM5NTd0NofeJREuX_8R_2i3GX_ho87g@mail.gmail.com>
From:   John Mazzie <john.p.mazzie@gmail.com>
Date:   Tue, 24 May 2022 11:12:39 -0500
Message-ID: <CAPxVHd+_fmCvhhYWCtjjjvzNi5GNfoDP3=aHgihVwzSwN9vKnQ@mail.gmail.com>
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

After thinking about this more, maybe it's more to do with the
interrupt handler for nvme_complete_rq.

In this situation, sometimes the handler for nvme_setup_cmd could be
interrupted to handle nvme_complete_rq and in this situation the
nvme_complete_rq handler wouldn't run. because the nvme_setup_cmd
handler is not complete.

Is this understanding correct? I'm assuming there is no real
workaround for this situation, so we may just need to accept some
missed events.

John

On Sat, May 21, 2022 at 11:52 AM John Mazzie <john.p.mazzie@gmail.com> wrote:
>
> In this case is a BPF program the individual handler of a tracepoint,
> or in my context, a BPF program my compiled program that traces both
> tracepoints? We aren't running any other BPF tracing during these
> tests besides my program counting these 2 tracepoints.
>
> In my program I have 2 handlers, one for
> tracepoint:nvme:nvme_setup_cmd and another for
> tracepoint:nvme:nvme_complete_rq. I've created a PERCPU_HASH map for
> each handler (unique map for each) to use that keeps track of each
> time the handler is invoked. The only thing that handler is doing in
> each case is incrementing the count value in the map. Though I do
> filter by device on each tracepoint. If I comment out the
> nvme_setup_cmd code the nvme_complete_rq does get the correct count.
>
> The user side of my program just prints the values for each of these
> maps on a 10 second increment.
>
> I can share my code to make this easier, is it preferred that I upload
> my code to github and share the link in this thread?
>
> I agree that your suggestion could be my issue, but I just want to
> make sure we're on the same page since I'm less familiar with the
> internals of BPF.
>
> Thanks,
> John
>
> On Fri, May 20, 2022 at 7:10 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, May 18, 2022 at 2:35 PM John Mazzie <john.p.mazzie@gmail.com> wrote:
> > >
> > > My group at Micron is using BPF and love the tracing capabilities it
> > > provides. We are mainly focused on the storage subsystem and BPF has
> > > been really helpful in understanding how the storage subsystem
> > > interacts with our drives while running applications.
> > >
> > > In the process of developing a tool using BPF to trace the nvme
> > > driver, we ran into an issue with some missing events. I wanted to
> > > check to see if this is possibly a bug/limitation that I'm hitting or
> > > if it's expected behavior with heavy tracing. We are trying to trace 2
> > > trace points (nvme_setup_cmd and nvme_complete_rq) around 1M times a
> > > second.
> > > We noticed if we just trace one of the two, we see all the expected
> > > events, but if we trace both at the same time, the nvme_complete_rq
> >
> > kprobe programs have per-CPU reentrancy protection. That is, if some
> > BPF kprobe/tracepoint program is running and something happens (e.g.,
> > BPF program calls some kernel function that has another BPF program
> > attached to it, or preemption happens and another BPF program is
> > supposed to run) that would trigger another BPF program, then that
> > nested BPF program invocation will be skipped.
> >
> > This might be what happens in your case.
> >
> > > misses events. I am using two different percpu_hash maps to count both
> > > events. One for setup and another for complete. My expectation was
> > > that tracing these events would affect performance, somewhat, but not
> > > miss events. Ultimately the tool would be used to trace nvme latencies
> > > at the driver level by device and process.
> > >
> > > My tool was developed using libbpf v0.7, and I've tested on Rocky
> > > Linux 8.5 (Kernel 4.18.0), Ubuntu 20.04 (Kernel 5.4) and Fedora 36
> > > (Kernel 5.17.6) with the same results.
> > >
> > > Thanks,
> > > John Mazzie
> > > Principal Storage Solutions Engineer
> > > Micron Technology, Inc.

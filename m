Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF996C6173
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 09:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCWISK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 04:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCWISJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 04:18:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48E8A64
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 01:18:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so82988178edb.11
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679559487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnXPPvUayRYrcW/acR8CYZCA7ZJe7nR8oOT0eJriZjg=;
        b=qmsHHclhj00G70NZv7sBZ9p2xLwRMKFdetpnmTNkSQJp9uD8g48Osrh7We+s2oc0rK
         2ey0MjKd2TxWvQ5rAKvuD1Sk/8iy+gbLHIy98L63ZWI6snZajE3Okb5zPlk9GqypWVdE
         JS1Pm7uffRNWPEUvnozz/gGB2eRk71lViT8hUpnSVCVrkx5kfL0/ozHGxmkgrCm9mjPm
         /K4h7/5yotm3O84rna1Tww9g2Tx6AgQiMMu+bCjzD+7+4IWYzb6IrWLyLkubmeiD0jWz
         ZkILOWPqJks7eC2RQLegG3juO5Q4OWX58ehszE0sW/Agi6pBOhij4RtuqIcrSahRiX+K
         MaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679559487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnXPPvUayRYrcW/acR8CYZCA7ZJe7nR8oOT0eJriZjg=;
        b=oLC3Lhh2fcm/oz7Q0NZNCjFZFqFjmMfuYcnnAYPSKGma46kkIB8J2tT0y8gY1G91td
         YKaFuFAgA0mMDUYSoxQiVcPTvRDemYTpJhAgonvrmdzJeEkahdG1JvM1/PS/NcYG1OYo
         QQskJfFxzRqe60owwBwPE/PDW1ftrPhtsmeuOCgzpJ6sd4iu6hhngQP9OBz+CaFpN9se
         ZRgfhLaQcXb8Fi9Oge97WkZPOo4TUeABlt6KUyDhZdwPsebFuI8KNyfsdX//JLT3rLo3
         GWZRely0Pxi04ccVXvXeN6iwEBWO1Tw4bg6MD4WYWJ0WnZruCytyJJkZ5e2FJMR+YF3O
         qj5Q==
X-Gm-Message-State: AO0yUKW2QDVC8PeWxIeIpYx6KzyXGcOsuMfrP2kJi3EmbkA3jtOtMqSv
        NQH0WDKv6EupBdL4hLEgRWWYhdS5CO32odsCE0KW5MY9+aWC5g==
X-Google-Smtp-Source: AK7set/ctG+DjDhR31YQML1Y0f98l0oDLTCcLFI9oSe+7ns2QoTXa4EPxB11n+syE2weYE5im5V+v13g/7NXGrux0v8=
X-Received: by 2002:a50:9b55:0:b0:4fc:473d:3308 with SMTP id
 a21-20020a509b55000000b004fc473d3308mr2555505edj.8.1679559486528; Thu, 23 Mar
 2023 01:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
 <ZBo164Lc2eL3HUvN@krava> <CAMAi7A7Y=m=i-yEOuh-sO-5R5zEGQuo1VwOLKsgvFcv4RRhbhQ@mail.gmail.com>
 <ZBr7Jt9+yr0PHk6K@krava> <CAADnVQLCSMBhHzOgB1iYMpWVTYsKerMUJ_8MX1W+7BNveF+0tQ@mail.gmail.com>
 <CAMAi7A4asgEE7MKOJC7ak4Q-wWXtfnHTtv8+x0GZ88ZUWZLMKQ@mail.gmail.com>
 <CAADnVQKxbzULYHhWUr=OQWke-QJt6QkVsO7pVBNpgurQMZPWkQ@mail.gmail.com>
 <CAMAi7A4e=yJrCBrWMuKGs37LjOMeVAQzBPvMiysG7QW1gL0yHw@mail.gmail.com> <CAADnVQKp9QLDKZTs=ArxQfSBDKXS769BOUYFpBn0O2oumrvO5A@mail.gmail.com>
In-Reply-To: <CAADnVQKp9QLDKZTs=ArxQfSBDKXS769BOUYFpBn0O2oumrvO5A@mail.gmail.com>
From:   Davide Miola <davide.miola99@gmail.com>
Date:   Thu, 23 Mar 2023 09:17:56 +0100
Message-ID: <CAMAi7A6gY_6nEfMouYOCKKHZL6ebNj-X81i8ioeZ=7wBKvsHgg@mail.gmail.com>
Subject: Re: bpf: missed fentry/fexit invocations due to implicit recursion
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 23 Mar 2023 at 00:00, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 22, 2023 at 3:45=E2=80=AFPM Davide Miola <davide.miola99@gmai=
l.com> wrote:
> >
> > On Wed, 22 Mar 2023 at 23:21, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Mar 22, 2023 at 2:39=E2=80=AFPM Davide Miola <davide.miola99@=
gmail.com> wrote:
> > > >
> > > > On Wed, 22 Mar 2023 at 17:06, Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > On Wed, Mar 22, 2023 at 6:10=E2=80=AFAM Jiri Olsa <olsajiri@gmail=
.com> wrote:
> > > > > >
> > > > > > there was discussion about this some time ago:
> > > > > >   https://lore.kernel.org/bpf/CAEf4BzZ-xe-zSjbBpKLHfQKPnTRTBMA2=
Eg382+_4kQoTLnj4eQ@mail.gmail.com/
> > > > > >
> > > > > > seems the 'active' problem andrii described fits to your case a=
s well
> > > > >
> > > > > I suspect per-cpu recursion counter will miss more events in this=
 case,
> > > > > since _any_ kprobe on that cpu will be blocked.
> > > > > If missing events is not an issue you probably want a per-cpu cou=
nter
> > > > > that is specific to your single ip_queue_xmit attach point.
> > > >
> > > > The difference between the scenario described in the linked thread
> > > > and mine is also the reason why I think in-bpf solutions like a
> > > > per-cpu guard can't work here: my programs are recursing due to irq=
s
> > > > interrupting them and invoking ip_queue_xmit, not because some help=
er
> > > > I'm using ends up calling ip_queue_xmit. Recursion can happen
> > > > anywhere in my programs, even before they get the chance to set a
> > > > flag or increment a counter in a per-cpu map, since there is no
> > > > atomic "bpf_map_lookup_and_increment" (or is there?)
> > >
> > > __sync_fetch_and_add() is supported. A bunch of selftests are using i=
t.
> > > Or you can use bpf_spin_lock.
> >
> > Sure, but I'd still have to lookup the element from the map first.
> > At a minimum it would look something like:
> >
> > SEC("fentry/ip_queue_xmit")
> > int BPF_PROG(entry_prog) {
> >     int key =3D 0;
> >     int64_t *guard =3D bpf_map_lookup_elem(&per_cpu, &key);
> >     if (guard) {
> >         if (__sync_fetch_and_add(guard, 1) =3D=3D 0) {
> >             ...
> >         }
> >     }
> > }
> >
> > The program could be interrupted before it reaches
> > __sync_fetch_and_add (just tested this and it does not solve the
> > problem)
>
> Ahh. I got confused by your bpf_map_lookup_and_increment idea.
> It won't help here either if you're concerned of IRQ
> after prog starts and before the first lookup.
> You can use global data. In such case there is no lookup function call.
> It reduces the race window, but it's theoretically still there.

Per-cpu global variables? Is that a thing?

> Try kprobes, but they're slower and I suspect you'll miss more events,
> because all kprobe progs are in one bucket.
>
> Better approach is to switch to networking hooks instead of tracing.

Yeah, worst case kprobes would be acceptable, the number of
problematic interruptions is quite small to the point where losing
more events shouldn't be an issue, but I agree I should be looking
for a better hook.

Thanks!

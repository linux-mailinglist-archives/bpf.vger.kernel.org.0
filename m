Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2F52443F
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 06:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbiELE2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 00:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242764AbiELE2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 00:28:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F3E6899A
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 21:28:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ch13so7710680ejb.12
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 21:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npEaMpCcneWn2Ogf0UFk0/LjakjBtoa+CdgPvJNewB0=;
        b=K6DjtVaTapW4HtjTu6qhAq0kxpofITbP6h5BDX9SKsy1lfJNFRt5h8pu2AlcMGUyKT
         guCbodYLA3F2JCGcwlDBWL0JKX0H+EgVKcdVtDRn2YkCezizD1Jpm8SaLL8BkBMFSRRP
         9EM19+pWHQrEFHGqe/EOo1GFqq5abt0+Z8E3/NlLwqG7VtjrFjSd/jDkWbDve8FhlwmC
         InTWM7Ys4AyXSAoIbjfCMhNR9O18wh76j9/EzDuaWQE3wl7fcESaJL0/rNyE3pf6a+2L
         1Vk5pM7euKUhEv0jZgnzz99z6nJkBO34TMLX+LdNwJhvU4LBDWpyxlAmlo5VgQbO1Jd3
         3xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npEaMpCcneWn2Ogf0UFk0/LjakjBtoa+CdgPvJNewB0=;
        b=bfXEYb1B/f6gRaSXk46cSByosZrzVYQhoMkZlXbWgUidIasrMTDAmHoxLbQg8Voc7u
         G7Uk4u55Q2LU7E2xtbeeuiQONUs3oupD2jzAlFKtBBVJQIJzeBe39GLEbMt6MBG19rcB
         HdrlvsbEXrEQs6mqBFXTkqITL8llrMLSYk9nfftgB87wkI3eOLUeJNCG4dXS/LkOggfK
         mI06kTP3h7iCw2ar9D90lhCi+t8EdIUeUqt+Acvi5FD0F5ZDoFgYEQ/YCqqDZkP1OXoB
         lHRVRf7wnWieQwolJ6uxsUUrB8UQhv0+15+pemsyg+ETrdTbLLrKL/idI4e1BTI1mhoR
         9WKg==
X-Gm-Message-State: AOAM5317xEae00/mMtyMzH4u7zctdgi/Tj/XSp+q3mqhS9ErTiLaV5RE
        +9k9In7jhi9fOe+QUkmcPM8YF6JRqI8iEfDYxqw=
X-Google-Smtp-Source: ABdhPJyg5AIVwp0JR8L1/xDgCYKCkbBN8p4jgsrewBjU/25kIHz8la/nd+4Vfsc/VyEFXIgmIiSpVxQ9Ul4QhACvDj0=
X-Received: by 2002:a17:906:58d2:b0:6fd:daa7:3a6e with SMTP id
 e18-20020a17090658d200b006fddaa73a6emr4627766ejs.0.1652329716768; Wed, 11 May
 2022 21:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAN9vWDLY24LEY-zhBSNVRTPBqbYQd+D62av0jKK_BqMvwt5-ig@mail.gmail.com>
 <CAEf4Bza6Ks-FGAGkLCGhK1KEDRdtqv==y7nN63KejF829XQtfA@mail.gmail.com>
 <CAN9vWD+6SBQtQqxZ__bvqJ8MsrOUr4cfQcU99at1XVPSUiOsmw@mail.gmail.com> <CAEf4BzYtkLX8cYGC9rAnDyMBrQ8uHmgA8T8+nZ6dJe3c1X+73w@mail.gmail.com>
In-Reply-To: <CAEf4BzYtkLX8cYGC9rAnDyMBrQ8uHmgA8T8+nZ6dJe3c1X+73w@mail.gmail.com>
From:   Michael Zimmermann <sigmaepsilon92@gmail.com>
Date:   Thu, 12 May 2022 06:28:25 +0200
Message-ID: <CAN9vWDJHrYUVFtBU-cAz6trvJAx903hGgO2Yj6=3Bt2CjS61Yg@mail.gmail.com>
Subject: Re: BPF maps don't work without CONFIG_TRACING/CONFIG_FTRACE
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 5:21 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 9, 2022 at 10:12 PM Michael Zimmermann
> <sigmaepsilon92@gmail.com> wrote:
> >
> > Thank you for your answer.
> > What I'm ultimately trying to do is: Use aya-rs to watch egress on a
> > network interface and notify userspace through a map (for certain IPs
> > only).
> >
> > In my actual use case, the userspace is supposed to do more complex
> > stuff but for testing I simply logged the receival of a message
> > through the BPF map on the console. And that is what I expect to
> > happen and which does happen as long as CONFIG_TRACING/CONFIG_FTRACE
> > are active. If not, I simply never receive any messages on any map.
> >
> > I've also tried this using an XDP program which sends a message every
> > time it sees a packet. And while the program seemed to be
> > working(since it did block certain traffic), I never saw any data in
> > the map when those configs were disabled.
> >
> > Also, I'm giving you two configs(tracing and ftrace) since the other
> > one seems to get y-selected automatically if one of them is active.
>
> Please don't top post, reply inline instead.
Sorry for that, GMail does that by default and even hides that it's
quoting at all.

>
> I don't think we have enough to investigate here, even "receive any
> messages on any map" is so ambiguous that it's hard to even guess what
> you are really trying to do. BPF maps are not sending/receiving
> messages. So please provide some pieces of code and what you are doing
> to check. CONFIG_TRACING and CONFIG_FTRACE shouldn't have any effect
> on functioning of BPF maps, so it's most probably that you are doing
> something besides BPF map update/lookup, but you don't provide enough
> information to check anything.

An aya project I tested where I don't receive any events:
https://github.com/aya-rs/book/tree/6b52a6fac5fa3e5a1165f98591b2eaff9692048a/examples/myapp-03

A bcc project where I don't receive any ping event:
https://github.com/iovisor/bcc/blob/2df19cd16ff69429faa8b7b86d6630ba35907734/examples/networking/tc_perf_event.py

If that's too abstract and far away from the kernel for you to figure
out what's going on I'd have to dig deeper into how bcc or aya work
internally which is not that easy to do.
>
> >
> > On Tue, May 10, 2022 at 2:00 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, May 3, 2022 at 2:40 AM Michael Zimmermann
> > > <sigmaepsilon92@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I'm using a kernel which has TRACING and FTRACE disabled and it looks
> > > > like BPF programs are unable to communicate with usespace.
> > > > I've reproduced this on aarch64 and x86_64 with both aya-rs's XDP
> > > > sample and bcc's "tc_perf_event.py" sample. bcc's sample uses
> > > > BPF_PERF_OUTPUT instead of maps though.
> > > >
> > > > Everything seems to run and work correctly, but there's no data being
> > > > send to userspace resulting in no log output.
> > > > Is that expected or am I running into a weird bug here?
> > > >
> > >
> > > You probably need to provide few more details on what you are trying
> > > to do, what you expect to happen and what's actually happening. As it
> > > is it's hard to provide any useful help.
> > >
> > > > Thanks
> > > > Michael

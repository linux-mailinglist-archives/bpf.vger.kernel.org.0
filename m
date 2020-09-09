Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E76262D51
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 12:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIKgS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 06:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIIKgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 06:36:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7076EC061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 03:36:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z22so2783083ejl.7
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tzhpphIZPNY5HcPVpD2+EfgrB7S3JPj/42APLIASAH8=;
        b=jbL2tg7Ps/+widMQTGjlh0P2t7g/AY83MSiTvWlda0Suk4Zs0XiCaCgCo7ZrRM1fJH
         aCQuHi/l75xxIN6eccqZHwvA+L3saYTUv5iqL0CwMtxow/MWJP04b10ZgscVIeB+ayuo
         94VnsPRY+gAz615jxaA7UVtzORyMijNcrg0ULj1MFsT/RrPU/MXrHC9iqk0p86G2Ofoj
         WEXfNND7JUCLZAlmIe4/MGXVguk5NWV/iXqu77dRRy5R/r3tW2YP7YmYojCpAwh1QFU9
         7t0vq8KHesHiJe+gEtUs+qneCaUqjDRNWpCVSVHHy71ptruv+1IuahLvSJYHifKkyZk6
         HPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tzhpphIZPNY5HcPVpD2+EfgrB7S3JPj/42APLIASAH8=;
        b=ax6qXVBNeSkTUB93Y1J2+t2DabfynUXIHloHQB/CzItBzRbzNkchE/8kZYFZnqejgW
         Vb1SGGlXGvM5M0dyTZGp/GBOqHs2YjLt7CqoClySrOyvpJ1MILyH4+AGQCdRh7LVMQqO
         /5/e2GhQCcWyUCMWFv3Zf38pFbTlRs+GhTQ6CZ9hRVPt9cr/k8msF/o4bLEVxFHlC6z8
         +1ai9HhdTsgxoBbpWeeBe9/4vp/pOGQ4ZXa/qtnkLM5UL1faxd1RO/0XjmCzNyb1jQTx
         f+PQii2ACORaKp4Ss/IMoC79+oUvisdfJ41BtFcWm0RqUYTKmwcSwxaE3K0Arh5aUOA4
         9jaQ==
X-Gm-Message-State: AOAM531WoViz4vIOFcL2gsPs9jl2I5Ih+hfArGTuzrFtitqokdRSIJiO
        2yFI2KDL73hh+lv0JhcqvLVnwTc9ZeM9btFgwj1L
X-Google-Smtp-Source: ABdhPJwCl6eteNuBgQu+3r8s4PSaBxXmmWl+i7CK6YgF79FSaKs8vVqQPWfmNGMWq1RmR7haK8g7X9zKrK5IkZbrX0s=
X-Received: by 2002:a17:906:7809:: with SMTP id u9mr2793628ejm.511.1599647773878;
 Wed, 09 Sep 2020 03:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeTCaU1fEGVVWnXKR_zv4ZSoCrBGSN65-RpFuKg9Gf-_z6TOw@mail.gmail.com>
 <CAADnVQKsbbd9dbPYQqa5=QsRfLo07hEjr1rSC=5DfVpzUK7Ajw@mail.gmail.com>
 <CAGeTCaWSSBJye72NCQW4N=XtsFx-rv-EEgTowTT3VEtus=pFtA@mail.gmail.com>
 <878sdlpv92.fsf@toke.dk> <CAGeTCaWDk_ok38Xm8H8-8HQYP-bbPqMuwWDpEYM=i1=e0e88bw@mail.gmail.com>
 <87mu1znt7q.fsf@toke.dk>
In-Reply-To: <87mu1znt7q.fsf@toke.dk>
From:   KP Singh <kpsingh@google.com>
Date:   Wed, 9 Sep 2020 12:35:57 +0200
Message-ID: <CAFLU3KteR+snvWpth3PBoQARTtpeBhEEVWH+a2bg0y=cxR81MQ@mail.gmail.com>
Subject: Re: HASH_OF_MAPS inner map allocation from BPF
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Borna Cafuk <borna.cafuk@sartura.hr>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 9, 2020 at 12:24 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Borna Cafuk <borna.cafuk@sartura.hr> writes:
>
> > On Mon, Sep 7, 2020 at 3:33 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Borna Cafuk <borna.cafuk@sartura.hr> writes:
> >>
> >> > On Sat, Sep 5, 2020 at 12:47 AM Alexei Starovoitov
> >> > <alexei.starovoitov@gmail.com> wrote:

[...]

> >> >
> >> > The idea is to have an outer map where the keys are PIDs, and inner =
maps where
> >> > the keys are system call numbers. This would enable tracking the num=
ber of
> >> > syscalls made by each process and the makeup of those calls for all =
processes
> >> > simultaneously.
> >> >
> >> > [1] https://github.com/iovisor/bcc/blob/master/libbpf-tools/syscount=
.bpf.c
> >>
> >> Well, if you just want to count, map-in-map seems a bit overkill? You
> >> could just do:
> >>
> >> struct {
> >>   u32 pid;
> >>   u32 syscall;
> >> } map_key;
> >>
> >> and use that?
> >>
> >> -Toke
> >>
> >
> > I have considered that, but maps in maps seem better for when I need to=
 get the
> > data about a single process's syscalls: It requires reading only one of=
 the
> > inner maps in its entirety. If I have a composite key like that, I don'=
t see
> > any way, other than:
> >  * either iterating through all the possible keys for a process
> >    (i.e. over all syscalls) and looking them up in the map, or
> >  * iterating over all entries in the map and filtering them.
> >
> > Looking at it again, the first option does not seem _that_ bad,
>
> You could even use BPF_MAP_LOOKUP_BATCH to do this in one operation, I
> suppose...
>
> > but just iterating over one (inner) map would be easier to fit into
> > our use-case.
>
> ...but yeah, I see what you mean. Well, maybe BPF local storage per
> process would also be a nice fit here?

Yes, task local storage does seem like a good fit and is the next one I was
thinking of implementing.

- KP

>
> -Toke
>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB678393878
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 23:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhE0WAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhE0WAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 18:00:22 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F383C061574;
        Thu, 27 May 2021 14:58:48 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c15so1380464qte.6;
        Thu, 27 May 2021 14:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=hyfdK0ASIZyZEeSnI5fyrk9s/8te09CW3fcAUhkMzJ0=;
        b=OIyfbgSJJn7fa37WVR9wGjQ6hDZ1pkzCoj39/TTKfYulXmMM3Lu5W2TFAoTG3/csfk
         WdboosSwnSnShhfu13GE3b+y7KVlNVGq09pZp428UHHqfJYhddjLLyKWUJ/RnI0adjb8
         40uHLxyNlPGmwHAJ1MImE4OkIhRksOfaaUChb9gPV1PsPOGcIqCVFnONTjIkY6nIjFDw
         K566+zIoJ7d8OXqXahNSxuqsdGtZPkxyh/7ecBns6w5OTthNa+kdz/5s6DtEASaaOvf5
         H+2MOubrn3OCl1YhwEH2T3Wq+ppcJ1RJNuAWHWUgdkta6rnOqx2EtcnIikuIvV55QBgD
         PK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=hyfdK0ASIZyZEeSnI5fyrk9s/8te09CW3fcAUhkMzJ0=;
        b=ExybKipqXGwRiDmeKA080X5ERoFF/lNabNwgG4I2K1PNwvqnfLtqTJbjvXYZeBstbt
         SIk1m5Q9Vhl93+DmmfbWDhRodOF7UuGYUgNPwaXpUdQh+L8Ky2JqdstzopBMqu5r1TId
         2IDtVpaR+nzBQKYGKkmJoYUWZBSjFo3ldVA7aSpVWeakPtC5jMBLTy7jFb2KUCMXRPCA
         VmvUBbxU1pKgJso9hcmCcD4wqkZydIsCB8OQDaxGYKiAspNmFOHfGK3aux5qHUSq0vYy
         9JQ3ySpKzwgeyaDXnqeTyrrwMf2oMbOyGOOhtcTmzWzVqiAkAxEPpM7D8TIMTcu7Tskx
         r9nA==
X-Gm-Message-State: AOAM533OwPpkdAMlQ40ZJkNL/dO9pMl/TErQgU0rvH10MRAOU2EU4gcr
        RI5orbX54o5KZXTUItBg2es=
X-Google-Smtp-Source: ABdhPJxoBhcdf16VKAqC7dvneyBluqdnqwgWTiX13uiHLtdOB0UvUF9mS1qXSMHwuqGp9k9LQSypUA==
X-Received: by 2002:ac8:7083:: with SMTP id y3mr654009qto.129.1622152726967;
        Thu, 27 May 2021 14:58:46 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p11sm2330306qtl.82.2021.05.27.14.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 14:58:46 -0700 (PDT)
Date:   Thu, 27 May 2021 18:57:31 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <YLAKUbjrdYio+ncV@krava>
References: <YK+41f972j25Z1QQ@kernel.org> <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com> <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com> <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com> <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com> <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com> <YLAKUbjrdYio+ncV@krava>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFT] Testing 1.22
To:     Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Petlan <mpetlan@redhat.com>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <337EEBAA-2ADD-4A46-BC6F-69FC38083668@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On May 27, 2021 6:08:33 PM GMT-03:00, Jiri Olsa <jolsa@redhat=2Ecom> wrote=
:
>On Thu, May 27, 2021 at 01:41:13PM -0700, Andrii Nakryiko wrote:
>> On Thu, May 27, 2021 at 12:57 PM Arnaldo <arnaldo=2Emelo@gmail=2Ecom>
>wrote:
>> >
>> >
>> >
>> > On May 27, 2021 4:14:17 PM GMT-03:00, Andrii Nakryiko
><andrii=2Enakryiko@gmail=2Ecom> wrote:
>> > >On Thu, May 27, 2021 at 12:06 PM Arnaldo <arnaldo=2Emelo@gmail=2Ecom=
>
>> > >wrote:
>> > >>
>> > >>
>> > >>
>> > >> On May 27, 2021 1:54:40 PM GMT-03:00, Andrii Nakryiko
>> > ><andrii=2Enakryiko@gmail=2Ecom> wrote:
>> > >> >On Thu, May 27, 2021 at 8:20 AM Arnaldo Carvalho de Melo
>> > >> ><acme@kernel=2Eorg> wrote:
>> > >> >>
>> > >> >> Hi guys,
>> > >> >>
>> > >> >>         Its important to have 1=2E22 out of the door ASAP, so
>please
>> > >> >clone
>> > >> >> what is in tmp=2Emaster and report your results=2E
>> > >> >>
>> > >> >
>> > >> >Hey Arnaldo,
>> > >> >
>> > >> >If we are going to make pahole 1=2E22 a new mandatory minimal
>version
>> > >of
>> > >> >pahole, I think we should take a little bit of time and fix
>another
>> > >> >problematic issue and clean up Kbuild significantly=2E
>> > >> >
>> > >> >We discussed this before, it would be great to have an ability
>to
>> > >dump
>> > >> >generated BTF into a separate file instead of modifying vmlinux
>> > >image
>> > >> >in place=2E I'd say let's try to push for [0] to land as a
>temporary
>> > >> >work around to buy us a bit of time to implement this feature=2E
>Then,
>> > >> >when pahole 1=2E22 is released and packaged into major distros,
>we can
>> > >> >follow up in kernel with Kbuild clean ups and making pahole
>1=2E22
>> > >> >mandatory=2E
>> > >> >
>> > >> >What do you think? If anyone agrees, please consider chiming in
>on
>> > >the
>> > >> >above thread ([0])=2E
>> > >>
>> > >> There's multiple fixes that affects lots of stakeholders, so I'm
>more
>> > >inclined to release 1=2E22 sooner rather than later=2E
>> > >>
>> > >> If anyone has cycles right now to work on that detached BTF
>feature,
>> > >releasing 1=2E23 as soon as that feature is complete and tested
>shouldn't
>> > >be a problem=2E
>> > >>
>> > >> Then 1=2E23 the mandatory minimal version=2E
>> > >>
>> > >> Wdyt?
>> > >
>> > >If we make 1=2E22 mandatory there will be no good reason to make
>1=2E23
>> > >mandatory again=2E So I will have absolutely no inclination to work
>on
>> > >this, for example=2E So we are just wasting a chance to clean up the
>> > >Kbuild story w=2Er=2Et=2E pahole=2E And we are talking about just a =
few
>days
>> > >at most, while we do have a reasonable work around on the kernel
>side=2E
>> >
>> > So there were patches for stop using objcopy, which we thought
>could uncover some can of worms, were there patches for the detached
>BTF  file?
>>=20
>> No, there weren't, if I remember correctly=2E What's the concern,
>> though? That detached BTF file isn't even an ELF, so it's
>> btf__get_raw_data() and write it to the file=2E Done=2E
>
>heya,
>I probably overlooked this, but are there more details about that
>detached BTF file feature somewhere?=20


Look in the dwarves mailing list archives at lore, but it's just a new opt=
ion to ask for the BTF data to be written to a file instead of to an ELF se=
ction, that will simplify the series of steps in the kernel building proces=
s=2E

I'll cook a patch early tomorrow=2E

- Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB630EABF
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 04:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBDDOa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 22:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbhBDDOa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 22:14:30 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA8AC0613ED
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 19:13:49 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w18so1192014pfu.9
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 19:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaD6sGrh13jKf92b5i6r6S0mLTiP02KjIFA6/14apQ4=;
        b=q3o8eGlIqp5+a/uK8OG6mfLFZt66d5ZgADuOg2NItU1LhvOO5aBYFbKRxeG4pSIQjZ
         p+/HbdCY46Ir4A8ECIJjeVmLZFLUm07l3eZ34KBQs2zvpykBPJVfbvKJ0CqlMAY+VcIT
         2Y0B6gzYCY8X/SplzgZT+t0DthmH2ADwzetQGNu+YIzn3/bDOiaSn3N9PT/NTVWydFhK
         AxTSG+WIjw62xmDpwdICrz2Aj1eVJNovjN0MdNGjpDS/YHkZ90mSGtokL9IVyM7hbgMZ
         0GrW9bMed2Wm8mucE4MFgNy56dqP00lYiZJrvMxKq+5/ERqj7w0MK7NQWwpxxM5hWJn8
         VRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaD6sGrh13jKf92b5i6r6S0mLTiP02KjIFA6/14apQ4=;
        b=qvODRiDkPVLq2YjU96mZHQi6u9G+vrt3MoD1Dd0fqftjCCIH+Gn+sTHXnMen8Az6pA
         Ta+XeItsMa23AOHEIWswEBQToZ+IAz+nKIyVd3agJmz+HzEUhKwYhUgEd9ODEGMTRPK4
         dcwyVwCnmpyhLYeKlbOpUphesg+qf/bFyr8SkLIkvYnvFYq3aaXNxW+fbRoLX0ZgKRkR
         aCTDyobft1IuHVQoi+x3cEuklQVmnEgbrxPjB8YrU80ASSJ10bsGFM9KoUWwLPdLL4Jk
         EEeyWsGu2MO5Re45xuEYGCQlHQ5GCtYMOrvxueT8hrlHoELqfqKnL10S9J1/GQktYQby
         HkeQ==
X-Gm-Message-State: AOAM531QTL259EZGKSj/B9QLRX1E+5sgS3AH+k9ElMHGrPjP5zhxgJmG
        lkdpuZ564IERLMZEyyHdLdbLaTqTjNb9POT0fHaarw==
X-Google-Smtp-Source: ABdhPJxw+Ouh0oumywhHaNdIDk3+/XTrZhogFr3Hf/FwMSKTttSmCmHb2KYldu+cjEk6OsgpvXnVx6agqWUPUWR4q5o=
X-Received: by 2002:a63:7e10:: with SMTP id z16mr6908717pgc.263.1612408429056;
 Wed, 03 Feb 2021 19:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com> <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
 <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com> <20210117201500.GO457607@kernel.org>
 <CAKwvOdmniAMZD0LiFdr5N8eOwHqNFED2Pd=pwOFF2Y8eSRXUHA@mail.gmail.com> <CAEf4Bzbn1app3LZ1oah5ARn81j5RMNxRRHPVAkeY3h_0q7+7fg@mail.gmail.com>
In-Reply-To: <CAEf4Bzbn1app3LZ1oah5ARn81j5RMNxRRHPVAkeY3h_0q7+7fg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Feb 2021 19:13:36 -0800
Message-ID: <CAKwvOdmrVdxbEHdOFA8x+Q2yDWOfChZzBc6nR3rdaM8R3LsxfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 6:58 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 3, 2021 at 5:31 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Sun, Jan 17, 2021 at 12:14 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Fri, Jan 15, 2021 at 03:43:06PM -0800, Yonghong Song escreveu:
> > > >
> > > >
> > > > On 1/15/21 3:34 PM, Nick Desaulniers wrote:
> > > > > On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 1/15/21 1:53 PM, Sedat Dilek wrote:
> > > > > > > En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> > > > > > > CONFIG_DEBUG_INFO_DWARF4.
> > > > > > > So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.
> > > > >
> > > > > Can you privately send me your configs that repro? Maybe I can isolate
> > > > > it to a set of configs?
> > > > >
> > > > > >
> > > > > > I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
> > > > > > It is not there before and adding this may suddenly break some users.
> > > > > >
> > > > > > If certain combination of gcc/llvm does not work for
> > > > > > CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
> > > > > > should fix.
> > > > >
> > > > > Is there a place I should report bugs?
> > > >
> > > > You can send bug report to Arnaldo Carvalho de Melo <acme@kernel.org>,
> > > > dwarves@vger.kernel.org and bpf@vger.kernel.org.
> > >
> > > I'm coming back from vacation, will try to read the messages and see if
> > > I can fix this.
> >
> > IDK about DWARF v4; that seems to work for me.  I was previously observing
> > https://bugzilla.redhat.com/show_bug.cgi?id=1922698
> > with DWARF v5.  I just re-pulled the latest pahole, rebuilt, and no
> > longer see that warning.
> >
> > I now observe a different set.  I plan on attending "BPF office hours
> > tomorrow morning," but if anyone wants a sneak peak of the errors and
> > how to reproduce:
> > https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781
> >
>
> Is there another (easy) way to get your patch set without the b4 tool?
> Is your patch set present in some patchworks instance, so that I can
> download it in mbox format, for example?

$ wget https://lore.kernel.org/lkml/20210130004401.2528717-2-ndesaulniers@google.com/raw
-O - | git am
$ wget https://lore.kernel.org/lkml/20210130004401.2528717-3-ndesaulniers@google.com/raw
-O - | git am

If you haven't tried b4 yet, it's quite nice.  Hard to go back.  Lore
also has mbox.gz links.  Not sure about patchwork.

>
> >
> > (FWIW: some other folks are hitting issues now with kernel's lack of
> > DWARF v5 support: https://bugzilla.redhat.com/show_bug.cgi?id=1922707)


-- 
Thanks,
~Nick Desaulniers

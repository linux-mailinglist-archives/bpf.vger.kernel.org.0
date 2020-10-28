Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE929DC5F
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 01:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgJ1Wdd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 18:33:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41581 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388260AbgJ1Wda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 18:33:30 -0400
Received: by mail-oi1-f193.google.com with SMTP id k65so1237262oih.8;
        Wed, 28 Oct 2020 15:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XH5fEY967sQGo5TmBvXohkmKAaL8RC4qbRi4BtBMuM0=;
        b=LFLWGtAalQM8ZAFtIS2H9evoE4p22g+VRre2VsOgh4lpHLAVSh+Mz7FHQCor9m4Oq8
         W2gIm927eKmkIpac/QhFto9gQ6A4s4vvPrPN+qI+AETyPDodE1aCQ9PHFkvIT71FTh7z
         q2D+Ra98NX1MasE4A7vFM/gXqhStMO2Xqe7S8cHDNO17FImuG/6mPaAlseGwPAAuC9iL
         QpC/5Hty77XP/Dpl9rzU1rmGc9Xr3WORS+zQik4Wd7KwIT9rxzQl7SyYXasBZ7UDYK9F
         6/+MQ5MNEKNtU4YfFxE1f/5SapzQOb2oWaESEkORzvBz9p7DM7rMpNJGqnNFF4tnyVxr
         Mesg==
X-Gm-Message-State: AOAM530Rr7N60bY/ErJbGnkjMOxCWkrGIUbufo7jra9yHeA6Gwc4pj6p
        6bW7ugeUv21cvAH/ywk+GTIgWnHettay0igHZL1TjW2mVXV/fg==
X-Google-Smtp-Source: ABdhPJw6WDLyOvB0+BhHMeuPy0t7zaAp6XH9HiAYir4ZWG1UgoaiE5jfBGmT2ghntDdAX5N6W7oM8IuIZYfj5F/E2yQ=
X-Received: by 2002:aca:f40c:: with SMTP id s12mr4164246oih.153.1603873143175;
 Wed, 28 Oct 2020 01:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <9ede6ef35c847e58d61e476c6a39540520066613.1600951211.git.yifeifz2@illinois.edu>
 <CAMuHMdXTLKr6pvoE+JAdn_P5kVxL6gx8PJ8mqfXcS+SF+pRbkQ@mail.gmail.com> <202010271653.B6D7D6B@keescook>
In-Reply-To: <202010271653.B6D7D6B@keescook>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Oct 2020 09:18:51 +0100
Message-ID: <CAMuHMdX-y+ButCt=CH+Ao=RtO_eGz0DaTJupwuHNa7=Xi_AGoQ@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 1/6] seccomp: Move config option SECCOMP to arch/Kconfig
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        containers@lists.linux-foundation.org,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kees,

On Wed, Oct 28, 2020 at 1:06 AM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Oct 27, 2020 at 10:52:39AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Sep 24, 2020 at 2:48 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > > From: YiFei Zhu <yifeifz2@illinois.edu>
> > >
> > > In order to make adding configurable features into seccomp
> > > easier, it's better to have the options at one single location,
> > > considering easpecially that the bulk of seccomp code is
> > > arch-independent. An quick look also show that many SECCOMP
> > > descriptions are outdated; they talk about /proc rather than
> > > prctl.
> > >
> > > As a result of moving the config option and keeping it default
> > > on, architectures arm, arm64, csky, riscv, sh, and xtensa
> > > did not have SECCOMP on by default prior to this and SECCOMP will
> > > be default in this change.
> > >
> > > Architectures microblaze, mips, powerpc, s390, sh, and sparc
> > > have an outdated depend on PROC_FS and this dependency is removed
> > > in this change.
> > >
> > > Suggested-by: Jann Horn <jannh@google.com>
> > > Link: https://lore.kernel.org/lkml/CAG48ez1YWz9cnp08UZgeieYRhHdqh-ch7aNwc4JRBnGyrmgfMg@mail.gmail.com/
> > > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> >
> > Thanks for your patch. which is now commit 282a181b1a0d66de ("seccomp:
> > Move config option SECCOMP to arch/Kconfig") in v5.10-rc1.
> >
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -458,6 +462,23 @@ config HAVE_ARCH_SECCOMP_FILTER
> > >             results in the system call being skipped immediately.
> > >           - seccomp syscall wired up
> > >
> > > +config SECCOMP
> > > +       def_bool y
> > > +       depends on HAVE_ARCH_SECCOMP
> > > +       prompt "Enable seccomp to safely compute untrusted bytecode"
> > > +       help
> > > +         This kernel feature is useful for number crunching applications
> > > +         that may need to compute untrusted bytecode during their
> > > +         execution. By using pipes or other transports made available to
> > > +         the process as file descriptors supporting the read/write
> > > +         syscalls, it's possible to isolate those applications in
> > > +         their own address space using seccomp. Once seccomp is
> > > +         enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
> > > +         and the task is only allowed to execute a few safe syscalls
> > > +         defined by each seccomp mode.
> > > +
> > > +         If unsure, say Y. Only embedded should say N here.
> > > +
> >
> > Please tell me why SECCOMP is special, and deserves to default to be
> > enabled.  Is it really that critical, given only 13.5 (half of sparc
> > ;-) out of 24
> > architectures implement support for it?
>
> That's an excellent point; I missed this in my review as I saw several
> Kconfig already marked "def_bool y" but failed to note it wasn't _all_
> of them. Okay, checking before this patch, these had them effectively
> enabled:
>
> via Kconfig:
>
> parisc
> s390
> um
> x86

Mostly "server" and "desktop" platforms.

> via defconfig, roughly speaking:
>
> arm
> arm64
> sh

Note that these defconfigs are example configs, not meant for production.
E.g. arm/multi_v7_defconfig and arm64/defconfig enable about everything
for compile coverage.

> How about making the default depend on HAVE_ARCH_SECCOMP_FILTER?
>
> These have SECCOMP_FILTER support:
>
> arch/arm/Kconfig:       select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
> arch/arm64/Kconfig:     select HAVE_ARCH_SECCOMP_FILTER
> arch/csky/Kconfig:      select HAVE_ARCH_SECCOMP_FILTER
> arch/mips/Kconfig:      select HAVE_ARCH_SECCOMP_FILTER
> arch/parisc/Kconfig:    select HAVE_ARCH_SECCOMP_FILTER
> arch/powerpc/Kconfig:   select HAVE_ARCH_SECCOMP_FILTER
> arch/riscv/Kconfig:     select HAVE_ARCH_SECCOMP_FILTER
> arch/s390/Kconfig:      select HAVE_ARCH_SECCOMP_FILTER
> arch/sh/Kconfig:        select HAVE_ARCH_SECCOMP_FILTER
> arch/um/Kconfig:        select HAVE_ARCH_SECCOMP_FILTER
> arch/x86/Kconfig:       select HAVE_ARCH_SECCOMP_FILTER
> arch/xtensa/Kconfig:    select HAVE_ARCH_SECCOMP_FILTER
>
> So the "new" promotions would be:
>
> csky
> mips
> powerpc
> riscv
> xtensa
>
> Which would leave only these two:
>
> arch/microblaze/Kconfig:        select HAVE_ARCH_SECCOMP
> arch/sparc/Kconfig:     select HAVE_ARCH_SECCOMP if SPARC64
>
> At this point, given the ubiquity of seccomp usage (e.g. systemd), I
> guess it's not unreasonable to make it def_bool y?

Having support does not necessarily imply you want it enabled.
If systemd needs it (does it? I have Debian nfsroots with systemd,
without SECCOMP), you can enable it in the defconfig.
"Default y" is for things you cannot do without, unless you know
better.

Bloat-o-meter says enabling SECCOMP consumes only ca. 8 KiB
(on arm32), so perhaps "default y if !EXPERT"?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

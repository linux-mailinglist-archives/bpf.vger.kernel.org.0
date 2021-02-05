Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E874A310156
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 01:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhBEAHt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 19:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhBEAHq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 19:07:46 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22DAC0613D6
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 16:07:06 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id k4so5021690ybp.6
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 16:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0sgC2TF0wHMn4MJ2bgqkKriGF103yjqQdzbw+Nspgg=;
        b=p+DkXGgFrB5WQ4kQbwjxCa3Hb8wifCqSqIQ4Qll3dWQR0F/UlGf/CNaYqZ1qFuMKYj
         +VTgOMumaDgSP5ApUmEkourILstbR10V+M0X7sRzmYTK/eFuYjySdV4TBeHnANCjWSBp
         Iq/jVcRo9ELuU7xGTsEvW+kBU9QXUjX+9JaI7wYjrAgBUYR+bSyYpZbKnQXvb3VHTXdB
         aDlKrvha75bqXOthFXrPJSfAssWUvdmVAz8SSBWNGvtqoe5emc/wVc8T80E/e1DfZ+Uw
         0SOAqJOrD2/2EV0EqerUE9mF2azMSkGOL/oX/n7oKi04LqyqL9AUpeagW7X+dzQduFYT
         Q9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0sgC2TF0wHMn4MJ2bgqkKriGF103yjqQdzbw+Nspgg=;
        b=A5hMLkxdbmU7PHXdoJfv6Q7UJxcxvjifCvFXGY09Vlmjurfj1dbtkBc5UTJA1TP7Mk
         +IK7O8OHAliBFr6Afx2lyyxJ2XchyinfZhblgnJjQlvQOvnWK8J8EBF6XYqpvOx7jnKj
         UTj2gBcIqO+2vLLUjJBO79kk/Xl7koqLBf5gr3dtnC/SNodjc8H9o51yO+R3PYi0/7hm
         RHGdaONNhS5V0nBkJzIxiPa2l7g5TXyoBIpwboxvigfHlOka0qxUaMmINbrWwv0pUv97
         3V6VcRpqVeA7ly2xUcDMultx5j6yVRsVIcvjXawgbku3UsG24y5Qq5tNevVLhrFY9V8N
         9Txg==
X-Gm-Message-State: AOAM530ty3fAVwAEfBkO6aagWxZ8k14iIK4GRg+d6Dg0nVVYlMyjd8mR
        A8zZTjwk49CBYoRu1ReAtOe1Bjo9eqRMGpvp4m8FtLySO+Csv+LU
X-Google-Smtp-Source: ABdhPJzUo5Jef0ivh4sDQUq1vTZW8oFhVTKmuCKxOC33n6nWywCYE/oYe9wP2o6mdXtMPme1VsNkLF8cWxY7mOmjiPg=
X-Received: by 2002:a25:da4d:: with SMTP id n74mr2707506ybf.347.1612483625908;
 Thu, 04 Feb 2021 16:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com> <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
 <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com> <20210117201500.GO457607@kernel.org>
 <CAKwvOdmniAMZD0LiFdr5N8eOwHqNFED2Pd=pwOFF2Y8eSRXUHA@mail.gmail.com>
 <CAEf4Bzbn1app3LZ1oah5ARn81j5RMNxRRHPVAkeY3h_0q7+7fg@mail.gmail.com>
 <CAKwvOdmrVdxbEHdOFA8x+Q2yDWOfChZzBc6nR3rdaM8R3LsxfQ@mail.gmail.com>
 <CAEf4Bzbs5sDTB6w1D4LpKLGjY5sCCUnRUsU84Ccn8DoL352j1g@mail.gmail.com> <CAKwvOdk-4_Pt=DKFokDpG8L58xj4J-=PPrgSLEZnYs7VJu1jZA@mail.gmail.com>
In-Reply-To: <CAKwvOdk-4_Pt=DKFokDpG8L58xj4J-=PPrgSLEZnYs7VJu1jZA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Feb 2021 16:06:55 -0800
Message-ID: <CAEf4Bza8yrmq5_Crg9XHA6e+fxfQDRQ-tRDGBzPT5ww4YNuhWw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 4:04 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Moving a bunch of folks + lists to BCC.
>
> On Thu, Feb 4, 2021 at 3:54 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Feb 3, 2021 at 7:13 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Wed, Feb 3, 2021 at 6:58 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 3, 2021 at 5:31 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > >
> > > > > On Sun, Jan 17, 2021 at 12:14 PM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > Em Fri, Jan 15, 2021 at 03:43:06PM -0800, Yonghong Song escreveu:
> > > > > > >
> > > > > > >
> > > > > > > On 1/15/21 3:34 PM, Nick Desaulniers wrote:
> > > > > > > > On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > On 1/15/21 1:53 PM, Sedat Dilek wrote:
> > > > > > > > > > En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> > > > > > > > > > CONFIG_DEBUG_INFO_DWARF4.
> > > > > > > > > > So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.
> > > > > > > >
> > > > > > > > Can you privately send me your configs that repro? Maybe I can isolate
> > > > > > > > it to a set of configs?
> > > > > > > >
> > > > > > > > >
> > > > > > > > > I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
> > > > > > > > > It is not there before and adding this may suddenly break some users.
> > > > > > > > >
> > > > > > > > > If certain combination of gcc/llvm does not work for
> > > > > > > > > CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
> > > > > > > > > should fix.
> > > > > > > >
> > > > > > > > Is there a place I should report bugs?
> > > > > > >
> > > > > > > You can send bug report to Arnaldo Carvalho de Melo <acme@kernel.org>,
> > > > > > > dwarves@vger.kernel.org and bpf@vger.kernel.org.
> > > > > >
> > > > > > I'm coming back from vacation, will try to read the messages and see if
> > > > > > I can fix this.
> > > > >
> > > > > IDK about DWARF v4; that seems to work for me.  I was previously observing
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=1922698
> > > > > with DWARF v5.  I just re-pulled the latest pahole, rebuilt, and no
> > > > > longer see that warning.
> > > > >
> > > > > I now observe a different set.  I plan on attending "BPF office hours
> > > > > tomorrow morning," but if anyone wants a sneak peak of the errors and
> > > > > how to reproduce:
> > > > > https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781
> > > > >
> > > >
> > > > Is there another (easy) way to get your patch set without the b4 tool?
> > > > Is your patch set present in some patchworks instance, so that I can
> > > > download it in mbox format, for example?
> > >
> > > $ wget https://lore.kernel.org/lkml/20210130004401.2528717-2-ndesaulniers@google.com/raw
> > > -O - | git am
> > > $ wget https://lore.kernel.org/lkml/20210130004401.2528717-3-ndesaulniers@google.com/raw
> > > -O - | git am
> > >
> > > If you haven't tried b4 yet, it's quite nice.  Hard to go back.  Lore
> > > also has mbox.gz links.  Not sure about patchwork.
> > >
> >
> > Ok, I managed to apply that on linux-next, but I can't get past this:
> >
> > ld.lld: error: undefined symbol: pa_trampoline_start
> > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
>
> Thanks for testing and the report. Do you have a .config you can send
> me to reproduce?
>

I followed your steps exactly, used olddefconfig. I've build with both
latest clang master and llvmorg-12.0.0-rc1 tag. This might be
something with my environment, I don't know.

> >
> > ld.lld: error: undefined symbol: pa_trampoline_header
> > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> >
> > ld.lld: error: undefined symbol: pa_trampoline_pgd
> > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> > >>> referenced by trampoline_64.S:142 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:142)
> > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> >
> > ld.lld: error: undefined symbol: pa_wakeup_start
> > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> >
> > ld.lld: error: undefined symbol: pa_wakeup_header
> > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> >
> > ld.lld: error: undefined symbol: pa_machine_real_restart_asm
> > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> >
> > ld.lld: error: undefined symbol: pa_startup_32
> > >>> referenced by trampoline_64.S:77 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:77)
> > >>>               arch/x86/realmode/rm/trampoline_64.o:(trampoline_start)
> >
> > ld.lld: error: undefined symbol: pa_tr_flags
> > >>> referenced by trampoline_64.S:124 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:124)
> > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> >
> > ld.lld: error: undefined symbol: pa_tr_cr4
> > >>> referenced by trampoline_64.S:138 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:138)
> > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> >
> > ld.lld: error: undefined symbol: pa_tr_efer
> > >>> referenced by trampoline_64.S:146 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:146)
> > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> > >>> referenced by trampoline_64.S:147 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:147)
> > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> >
> > ld.lld: error: undefined symbol: pa_startup_64
> > >>> referenced by trampoline_64.S:161 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:161)
> > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> >
> > ld.lld: error: undefined symbol: pa_tr_gdt
> > >>> referenced by arch/x86/realmode/rm/trampoline_64.o:(tr_gdt)
> > >>> referenced by reboot.S:28 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:28)
> > >>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)
> >
> > ld.lld: error: undefined symbol: pa_machine_real_restart_paging_off
> > >>> referenced by reboot.S:34 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:34)
> > >>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)
> >
> > ld.lld: error: undefined symbol: pa_machine_real_restart_idt
> > >>> referenced by reboot.S:47 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:47)
> > >>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)
> >
> > ld.lld: error: undefined symbol: pa_machine_real_restart_gdt
> > >>> referenced by reboot.S:54 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:54)
> > >>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)
> > >>> referenced by arch/x86/realmode/rm/reboot.o:(machine_real_restart_gdt)
> >
> > ld.lld: error: undefined symbol: pa_wakeup_gdt
> > >>> referenced by arch/x86/realmode/rm/wakeup_asm.o:(wakeup_gdt)
> >   CC      arch/x86/mm/numa_64.o
> >   CC      arch/x86/mm/amdtopology.o
> >   HOSTCC  arch/x86/entry/vdso/vdso2c
> > make[4]: *** [arch/x86/realmode/rm/realmode.elf] Error 1
> > make[3]: *** [arch/x86/realmode/rm/realmode.bin] Error 2
> > make[2]: *** [arch/x86/realmode] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> >
> >
> > Hopefully Arnaldo will have better luck.
> >
> >
> >
> > > >
> > > > >
> > > > > (FWIW: some other folks are hitting issues now with kernel's lack of
> > > > > DWARF v5 support: https://bugzilla.redhat.com/show_bug.cgi?id=1922707)
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers

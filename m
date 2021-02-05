Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F474310166
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 01:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhBEAMo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 19:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhBEAMn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 19:12:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEE9C061786
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 16:12:02 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o21so1876666pgn.12
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 16:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpdFauSXVsiLvu4pXiR9tEezIR4W+MJLHz/acfLTf+s=;
        b=YI7xZcUxcVYuWUoejVUF6udPiDNC08AskSJmeUEcE2tl3VmPXybyFldppBrHjkh8nI
         aqiuTnv2QPXxp4FSsvSL/YyJ/LtegG3wG9rr7pTlhS719dx5KRngaq+vvgOtK+pj5eh6
         5Tldw45cJjfIxtW16ket1iUdOm3QW+xJqKjtj+A0CJQ2QiOstcbhz8MEhDzADTXT8hbn
         U5QGhiKbcuXFMc5CqT9Mt0BwjhgKavS8kAoKAmpaj6N0TiFmvxcRp8Lzb3I8YuTqmGvV
         ECgY5MeTIyGXXDFIr+gYUo2Z1OxapY4k9w8c3ENCAw5zCGk8GH5HJoxayRc48x1cZj2j
         D8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpdFauSXVsiLvu4pXiR9tEezIR4W+MJLHz/acfLTf+s=;
        b=PCDpOb3iSSr1AmgYIXKeopKxFPq7iNis74cqC9pFKq3GL5jWcMoRy7TBpprouL3QXc
         y7rlbDWIFrajLOaWbMR3c3L0NxMcktkFtEV+bFPiVdm8F6LWdkWJEUSfRkVklGyV68UK
         UrRWVPRwkNVibpf/zBZO5GuYH7Nm9346Mll/MH2Z+ryQWMGgaT+SkqgY7i03IGcgkVDM
         504xV8jwsJCcznRiXaWMEppen1aQ6MrAaLp6nxCpWQlQl+P2EqDin51NF7x/uaoCO5Za
         h6ohHm90mByFAWLLvVlEQgccQ/XIDGkavSGS+e+NPTlyvivvJGdxFTiz6be6dR5tzBye
         owJQ==
X-Gm-Message-State: AOAM531P8mtXOibX6f0btezpdXyFRQtGdVdFvizCDWAMvGNjPaegUOOi
        85Q4MRIe6sJQVPjz1sNwqhjWzkpxRrYwGaKfHl7wuA==
X-Google-Smtp-Source: ABdhPJxOXE7TzS1NbHEj9QsgioxqNqu3enBEEiHF66Z8aC0x+GvnUef9txMOznE9D6sJ9668qfnsMzgFaW+qbRI60io=
X-Received: by 2002:aa7:9f5a:0:b029:1d4:fa02:a044 with SMTP id
 h26-20020aa79f5a0000b02901d4fa02a044mr1689799pfr.30.1612483922117; Thu, 04
 Feb 2021 16:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com> <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
 <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com> <20210117201500.GO457607@kernel.org>
 <CAKwvOdmniAMZD0LiFdr5N8eOwHqNFED2Pd=pwOFF2Y8eSRXUHA@mail.gmail.com>
 <CAEf4Bzbn1app3LZ1oah5ARn81j5RMNxRRHPVAkeY3h_0q7+7fg@mail.gmail.com>
 <CAKwvOdmrVdxbEHdOFA8x+Q2yDWOfChZzBc6nR3rdaM8R3LsxfQ@mail.gmail.com>
 <CAEf4Bzbs5sDTB6w1D4LpKLGjY5sCCUnRUsU84Ccn8DoL352j1g@mail.gmail.com>
 <CAKwvOdk-4_Pt=DKFokDpG8L58xj4J-=PPrgSLEZnYs7VJu1jZA@mail.gmail.com> <CAEf4Bza8yrmq5_Crg9XHA6e+fxfQDRQ-tRDGBzPT5ww4YNuhWw@mail.gmail.com>
In-Reply-To: <CAEf4Bza8yrmq5_Crg9XHA6e+fxfQDRQ-tRDGBzPT5ww4YNuhWw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Feb 2021 16:11:50 -0800
Message-ID: <CAKwvOdk7vkep157q4q4EamkdYWMLYzwM_7PYW1rdy=BFQye66w@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Thu, Feb 4, 2021 at 4:07 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 4, 2021 at 4:04 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Moving a bunch of folks + lists to BCC.
> >
> > On Thu, Feb 4, 2021 at 3:54 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Feb 3, 2021 at 7:13 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > On Wed, Feb 3, 2021 at 6:58 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Feb 3, 2021 at 5:31 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > > >
> > > > > > On Sun, Jan 17, 2021 at 12:14 PM Arnaldo Carvalho de Melo
> > > > > > <acme@kernel.org> wrote:
> > > > > > >
> > > > > > > Em Fri, Jan 15, 2021 at 03:43:06PM -0800, Yonghong Song escreveu:
> > > > > > > >
> > > > > > > >
> > > > > > > > On 1/15/21 3:34 PM, Nick Desaulniers wrote:
> > > > > > > > > On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > On 1/15/21 1:53 PM, Sedat Dilek wrote:
> > > > > > > > > > > En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> > > > > > > > > > > CONFIG_DEBUG_INFO_DWARF4.
> > > > > > > > > > > So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.
> > > > > > > > >
> > > > > > > > > Can you privately send me your configs that repro? Maybe I can isolate
> > > > > > > > > it to a set of configs?
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
> > > > > > > > > > It is not there before and adding this may suddenly break some users.
> > > > > > > > > >
> > > > > > > > > > If certain combination of gcc/llvm does not work for
> > > > > > > > > > CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
> > > > > > > > > > should fix.
> > > > > > > > >
> > > > > > > > > Is there a place I should report bugs?
> > > > > > > >
> > > > > > > > You can send bug report to Arnaldo Carvalho de Melo <acme@kernel.org>,
> > > > > > > > dwarves@vger.kernel.org and bpf@vger.kernel.org.
> > > > > > >
> > > > > > > I'm coming back from vacation, will try to read the messages and see if
> > > > > > > I can fix this.
> > > > > >
> > > > > > IDK about DWARF v4; that seems to work for me.  I was previously observing
> > > > > > https://bugzilla.redhat.com/show_bug.cgi?id=1922698
> > > > > > with DWARF v5.  I just re-pulled the latest pahole, rebuilt, and no
> > > > > > longer see that warning.
> > > > > >
> > > > > > I now observe a different set.  I plan on attending "BPF office hours
> > > > > > tomorrow morning," but if anyone wants a sneak peak of the errors and
> > > > > > how to reproduce:
> > > > > > https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781
> > > > > >
> > > > >
> > > > > Is there another (easy) way to get your patch set without the b4 tool?
> > > > > Is your patch set present in some patchworks instance, so that I can
> > > > > download it in mbox format, for example?
> > > >
> > > > $ wget https://lore.kernel.org/lkml/20210130004401.2528717-2-ndesaulniers@google.com/raw
> > > > -O - | git am
> > > > $ wget https://lore.kernel.org/lkml/20210130004401.2528717-3-ndesaulniers@google.com/raw
> > > > -O - | git am
> > > >
> > > > If you haven't tried b4 yet, it's quite nice.  Hard to go back.  Lore
> > > > also has mbox.gz links.  Not sure about patchwork.
> > > >
> > >
> > > Ok, I managed to apply that on linux-next, but I can't get past this:
> > >
> > > ld.lld: error: undefined symbol: pa_trampoline_start
> > > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> >
> > Thanks for testing and the report. Do you have a .config you can send
> > me to reproduce?
> >
>
> I followed your steps exactly, used olddefconfig. I've build with both
> latest clang master and llvmorg-12.0.0-rc1 tag. This might be
> something with my environment, I don't know.

Perhaps, but "olddefconfig" is not reproducible for anyone else, ever.
Please send me your .config that produced the errors.

>
> > >
> > > ld.lld: error: undefined symbol: pa_trampoline_header
> > > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> > >
> > > ld.lld: error: undefined symbol: pa_trampoline_pgd
> > > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> > > >>> referenced by trampoline_64.S:142 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:142)
> > > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> > >
> > > ld.lld: error: undefined symbol: pa_wakeup_start
> > > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> > >
> > > ld.lld: error: undefined symbol: pa_wakeup_header
> > > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> > >
> > > ld.lld: error: undefined symbol: pa_machine_real_restart_asm
> > > >>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
> > >
> > > ld.lld: error: undefined symbol: pa_startup_32
> > > >>> referenced by trampoline_64.S:77 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:77)
> > > >>>               arch/x86/realmode/rm/trampoline_64.o:(trampoline_start)
> > >
> > > ld.lld: error: undefined symbol: pa_tr_flags
> > > >>> referenced by trampoline_64.S:124 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:124)
> > > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> > >
> > > ld.lld: error: undefined symbol: pa_tr_cr4
> > > >>> referenced by trampoline_64.S:138 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:138)
> > > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> > >
> > > ld.lld: error: undefined symbol: pa_tr_efer
> > > >>> referenced by trampoline_64.S:146 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:146)
> > > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> > > >>> referenced by trampoline_64.S:147 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:147)
> > > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> > >
> > > ld.lld: error: undefined symbol: pa_startup_64
> > > >>> referenced by trampoline_64.S:161 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:161)
> > > >>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
> > >
> > > ld.lld: error: undefined symbol: pa_tr_gdt
> > > >>> referenced by arch/x86/realmode/rm/trampoline_64.o:(tr_gdt)
> > > >>> referenced by reboot.S:28 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:28)
> > > >>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)
> > >
> > > ld.lld: error: undefined symbol: pa_machine_real_restart_paging_off
> > > >>> referenced by reboot.S:34 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:34)
> > > >>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)
> > >
> > > ld.lld: error: undefined symbol: pa_machine_real_restart_idt
> > > >>> referenced by reboot.S:47 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:47)
> > > >>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)
> > >
> > > ld.lld: error: undefined symbol: pa_machine_real_restart_gdt
> > > >>> referenced by reboot.S:54 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:54)
> > > >>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)
> > > >>> referenced by arch/x86/realmode/rm/reboot.o:(machine_real_restart_gdt)
> > >
> > > ld.lld: error: undefined symbol: pa_wakeup_gdt
> > > >>> referenced by arch/x86/realmode/rm/wakeup_asm.o:(wakeup_gdt)
> > >   CC      arch/x86/mm/numa_64.o
> > >   CC      arch/x86/mm/amdtopology.o
> > >   HOSTCC  arch/x86/entry/vdso/vdso2c
> > > make[4]: *** [arch/x86/realmode/rm/realmode.elf] Error 1
> > > make[3]: *** [arch/x86/realmode/rm/realmode.bin] Error 2
> > > make[2]: *** [arch/x86/realmode] Error 2
> > > make[2]: *** Waiting for unfinished jobs....
> > >
> > >
> > > Hopefully Arnaldo will have better luck.
> > >
> > >
> > >
> > > > >
> > > > > >
> > > > > > (FWIW: some other folks are hitting issues now with kernel's lack of
> > > > > > DWARF v5 support: https://bugzilla.redhat.com/show_bug.cgi?id=1922707)
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > > ~Nick Desaulniers
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers

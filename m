Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AA62F5B14
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 08:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhANHKg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 02:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbhANHKf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 02:10:35 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE76C061575
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 23:09:49 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u17so9353429iow.1
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 23:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=U17MbycEx9onzbzW0lZ9HQMBZMQ/bkoRQmc2cH8Qbpc=;
        b=Wk4HdgnFx49J+SxkzTU4q4e9EritOJjfjLSm8HQiA4+EV/AQiyYAI10tyhDboag67s
         uuRJnztk942uYBJ4GhzdAd/r7BRmUistlxFLU7uIr5aBUBskGQuSk36SIZp03I+k8U3o
         IW9D7uf+/abF8YkbgjZSUw5tD4yprMwd+9oxyyAHP9+9CONk1tY/6WzEZZ46hxzLwtny
         /pnDoiN5Du+/AKXdGuQDvwrO8WSNpESZRFLDkG3xmDIV0FRgmmoFr+/B0lsAkKlN0ZZd
         wkH4/haPnmmt1FrLjvXOw1FxDJjJ+7Cjy/M8SPEZciCRDTwGej2p+jvIw7sunVuQxw70
         R3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=U17MbycEx9onzbzW0lZ9HQMBZMQ/bkoRQmc2cH8Qbpc=;
        b=JcclipLB3U2K/yKKbD9dfhDocQmvbPqEYnVpfrRSwU+AvQG5Ygm3MICSyjYSvgp+xe
         LxsCE4ppfu6NCNwj4YM86uudtaDxXbJysMImRaHgs79isPLnEzVlVh+sNc2H5T6uCw52
         UhryULjJsGO6XmdAiTk44RfqouorTxs/T4BqqaLG4i/Vi+kX2wF/eVhT6BLnnb1cGa92
         o4j73gPSbFwW4b6xWIJ3IkR+QaUTldxHuzcg++PuIPrwEO01W2D20VbepvkSSAXsSy26
         38WIBtyB3/6iPLx/ipy6ACd9iSK5Yd6x9rUCl5c5S7NhVkczpjWjfmmbrYUAZyfn2yHX
         8C6Q==
X-Gm-Message-State: AOAM5320tEyvaBVjDDfraqPqKD3dlveJY9xEOyaoJdASdoqmjkDFi9E0
        kjuvVGQ3RaI/aNPAhhCzhZMU/e1Q+iwpW7IUSsEphaByZgI=
X-Google-Smtp-Source: ABdhPJzoi91WiDd83k/G+SDkZVRAm3rh8fO56UN982kN2W3wYNQKOqHCvuYkBuUAQW3aYl5n7hap2FNDUlQQdvXPMok=
X-Received: by 2002:a05:6602:2f93:: with SMTP id u19mr4356544iow.110.1610608188875;
 Wed, 13 Jan 2021 23:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com> <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com> <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
In-Reply-To: <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 08:09:37 +0100
Message-ID: <CA+icZUU3-tz8Jjs3GxVVY4ch8aLXJxet6sERZrf0xny7QnD+Dw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Kbuild: DWARF v5 support
To:     Caroline Tice <cmtice@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Clifton <nickc@redhat.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 7:18 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Jan 13, 2021 at 11:25 PM Caroline Tice <cmtice@google.com> wrote:
> >
> >
> >
> >
> >
> > On Tue, Jan 12, 2021 at 3:17 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>
> >> On Mon, Jan 11, 2021 at 9:27 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >> >
> >> > On Fri, Dec 4, 2020 at 2:11 AM 'Nick Desaulniers' via Clang Built
> >> > Linux <clang-built-linux@googlegroups.com> wrote:
> >> > >
> >> > > DWARF v5 is the latest standard of the DWARF debug info format.
> >> > >
> >> > > DWARF5 wins significantly in terms of size when mixed with compression
> >> > > (CONFIG_DEBUG_INFO_COMPRESSED).
> >> > >
> >> >
> >> > Is this patchset bulletproof with CONFIG_DEBUG_INFO_BTF=y (and clang-cfi)?
> >> >
> >> > Debian has enabled this Kconfig in recent Linux v5.10 kernels which is
> >> > a base for my custom kernels.
> >> >
> >> > It was fu**ing annoying to see I have no pahole binary installed and
> >> > my build got broken after 3 hours of build.
> >> > OK, I see that requirements is coded in scripts/link-vmlinux.sh.
> >> >
> >> > I needed to install dwarves package which provides pahole binary.
> >> >
> >> > I would like to see a prereq-checking for needed binaries with certain
> >> > Kconfig set.
> >> >
> >> > After I calmed down I will - maybe - write to linux-kbuild mailing-list.
> >> > Hope this will be a friendly email.
> >> >
> >>
> >> After linux-bpf folks recommended not to use LLVM I jumped to gcc-10.
> >>
> >> I tried with ld.bfd first and then in a next run with LLVM=1.
> >>
> >> Upgraded pahole binary to latest Git plus a recommended patch from
> >> linux-btf folks.
> >>
> >> Unfortunately, I see with CONFIG_DEBUG_INFO_DWARF5=y and
> >> CONFIG_DEBUG_INFO_BTF=y:
> >>
> >> die__process_inline_expansion: DW_TAG_INVALID (0x48) @ <0x3f0dd5a> not handled!
> >> die__process_function: DW_TAG_INVALID (0x48) @ <0x3f0dd69> not handled!
> >>
> >> In /usr/include/dwarf.h I found:
> >>
> >> 498:    DW_OP_lit24 = 0x48,                /* Literal 24.  *
> >
> >
> > There are multiple dwarf objects with the value 0x48, depending on which section of the dwarf.h file you search:
> >
> > DW_TAG_call_site = 0x48
> > DW_AT_static_link = 0x48
> > DW_OP_lit24 = 0x48.
> >
> > In this case, since the error message was about a DW_TAG, it would be complaining about DW_TAG_call_site, which is new to DWARR v5.
> >
>
> [ CC linux-bpf & Andrii and Jiri ]
>
> Thanks for your feedback Caroline.
>
> I ran several builds in the last 24 hours with Linux v5.11-rc3.
>
> Setting DWARF version 2 (CONFIG_DEBUG_INFO_DWARF2=y) or version 4
> (CONFIG_DEBUG_INFO_DWARF4=y) with this patchset together with GCC
> v10.2.1 plus LLVM=1 does NOT show this.
> BTW, it does not matter when LLVM/Clang v12 and LLVM/Clang v11 is used.
> But again my compiler is here GCC plus LLVM utils like llvm-objcopy,
> ld.lld, lllvm-ar, llvm-nm, etc.
> ( My initial problem was also seen with Clang v11.0.1 - I switched to
> GCC as Debian's linux-kernel uses CONFIG_DEBUG_INFO_BTF=y
> successfully. )
>

I have to correct myself:
The used assembler within my GCC experiments is GNU/ld BFD version
v2.35.1 - not LLD linker!

- Sedat -

> So, this is definitely a DWARF version 5 issue when
> CONFIG_DEBUG_INFO_BTF=y (and CONFIG_DEBUG_INFO_BTF_MODULES=y).
>
> Furthermore, my build-log says with pahole (see post-scriptum) from
> dwarves package - here as an example:
>
> WARN: multiple IDs found for 'bpf_map': 3860, 369255 - using 3860
>
> $ grep 'WARN: multiple IDs found for'
> build-log_5.11.0-rc3-6-amd64-gcc10-llvm11.txt | wc -l
> 1621
>
> In the Linux code this derives from tools/bpf/resolve_btfids:
>
> static int symbols_resolve(struct object *obj)
> ...
>                                 pr_info("WARN: multiple IDs found for
> '%s': %d, %d - using %d\n",
>
> ( Cut-n-paste into Gmail truncates the lines and indentation, so I dropped it. )
>
> Please see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/bpf/resolve_btfids/main.c#n469
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/bpf/resolve_btfids/main.c#n532
>
> I looked with llvm-dwarf tool and saw some errors concerning
> ".debug-ranges" (cannot remember the exact output and the command-line
> I used).
>
> Example for "DW_TAG_INVALID (0x48)" from my build-log:
>
> die__process_inline_expansion: DW_TAG_INVALID (0x48) @ <0x1f671e7> not handled!
>
> $ llvm-dwarfdump-11 --debug-info=0x1f671e7 vmlinux
> vmlinux:        file format elf64-x86-64
>
> .debug_info contents:
>
> 0x01f671e7: DW_TAG_call_site
>              DW_AT_call_return_pc      (0xffffffff811b16f2)
>              DW_AT_call_origin (0x01f67f1d)
>
> Looking for "DW_AT_call_origin (0x01f67f1d)":
>
> $ llvm-dwarfdump-11 --debug-info=0x01f67f1d vmlinux
> vmlinux:        file format elf64-x86-64
>
> .debug_info contents:
>
> 0x01f67f1d: DW_TAG_subprogram
>              DW_AT_external    (true)
>              DW_AT_declaration (true)
>              DW_AT_linkage_name        ("fput")
>              DW_AT_name        ("fput")
>              DW_AT_decl_file
> ("/home/dileks/src/linux-kernel/git/./include/linux/file.h")
>              DW_AT_decl_line   (16)
>              DW_AT_decl_column (0x0d)
>
> I have no experience in digging into DWARF (version 5) issues and how
> to use llvm-dwarf or another appropriate tool.
> If you give me a hand...
> So all the above says - to be honest - nothing to me.
> I hope it says something to you experts.
>
> Regards,
> - Sedat -
>
> P.S.: I tried with a selfmade pahole from latest Git plus Jiri's v2
> patch of "btf_encoder: Add extra checks for symbol names".
>
> link="https://lore.kernel.org/bpf/20210113102509.1338601-1-jolsa@kernel.org/T/#t
> b4 -d am $link
> ...
> Wrote v2_20210113_jolsa_btf_encoder_add_extra_checks_for_symbol_names.am
> for thanks tracking
>
> [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
>
> >>
> >>
> >> Can someone enlighten what is going on?
> >>
> >> Nick, Fangrui?
> >>
> >> Thanks.
> >>
> >> - Sedat -
> >>
> >> P.S.: Patch from linux-bpf
> >>
> >> link="https://lore.kernel.org/bpf/20210112194724.GB1291051@krava/T/#t"
> >> b4 -d am $link
> >>
> >> - EOT -

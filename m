Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B25A2F5DDF
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 10:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbhANJie (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 04:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbhANJh5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 04:37:57 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4036EC0617A2
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 01:36:37 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d9so9884232iob.6
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 01:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8yEozLBbojK3LMsKx8dIthS97lH2HPvpcREqx+xNlDA=;
        b=iB9snSE6UCxu8wU96VUvupN1rVQBbzSvbz6BU3IoxjxsMCgnSLhAsBJ0WfF5aC8CxO
         +YZfvpKZhKN61VvELJbZ/JCAuayfK+uAuxE77ECd5Wfn+3b+BxtgXYEWPm1Ii4r6DcpV
         z53A48BXQxQmJn04ymHn7oDXvIQr2nk53X5HFXsD7RzOz8MNI+fRkN+6gokN8nNo3SXT
         TLgZcKwCpbZNOpUjZZv2AP2UGCJ6gJBhdPqD9RxwPfv2JgPJIFBX7+0juB/NUB4ub2Yr
         YGVTnt/zYN0fwZWYaFsQr+IdHoEzgWwJXYo6h2kfh9zQC+T6m3zeUJRHUCTRwka+Rgm8
         thbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8yEozLBbojK3LMsKx8dIthS97lH2HPvpcREqx+xNlDA=;
        b=ZnXSfK+WD2WaxYai8P/SDBZsomAss9uouhbwF/vlIbHxACkOJTmwzm5qeGneP+oALV
         WlXi3aZDyGQwLqwc6qnHpZW84WsLBScCznTbLJ/tdN0DscCUfB1K63HrV2MH49B7pnqc
         LyteLPbfG03WPnVf8ezCdfyBdUT7Rku2dc6ZSyhcYIeQw+D6AH1WB6n3cNgCMGlI5MNn
         rt9JO7aajaDiPAhZtGXf4o/yb+IXhZ/2s9EPH94jmzGrIt2Ui2D9KMuZvwheeKyQQAin
         ryGDa2IXkxgzcY2pevPUWYabL+mVS2/ofBjRGYtSv4aWPkkH/bV7C37Lwu0Ju+1AIr6T
         iyIQ==
X-Gm-Message-State: AOAM531iFcwUfrKQID3eIohQiW0PxFF9dSyXbNSGWRQ/VB2USaU/YU6H
        5oc1NE/r1qBp8myk10wGld4lUsI6/zf3LOMoos4NI6FpC0CxCw==
X-Google-Smtp-Source: ABdhPJzcPCARPRDtyp0utYH8Z+Lc87H2dzJZq1gMzgvaCzYPnPC/95kaS3YZJpHlu5/zV4HB7PoAXks7d/srj5x6P+A=
X-Received: by 2002:a05:6602:2f93:: with SMTP id u19mr4615963iow.110.1610616996433;
 Thu, 14 Jan 2021 01:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com> <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com> <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
In-Reply-To: <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 10:36:24 +0100
Message-ID: <CA+icZUWgrp1mXRU+5ADWRGK5nQ=fbgn2+FBANB5g+9rAi+Ewsw@mail.gmail.com>
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

I found in my archives:

[ error: decoding address ranges: ]

Looks like these DW_TAG_xxx are involved.

$ egrep -B4 -n 'error: decoding address ranges:' llvm-dwarfdump.txt |
grep DW_TAG_ | awk '{ print $2 }' | sort | uniq
DW_TAG_compile_unit
DW_TAG_formal_parameter
DW_TAG_inlined_subroutine
DW_TAG_lexical_block
DW_TAG_subprogram

[ example ]

1017373-0x001a1691: DW_TAG_compile_unit
1017374-              DW_AT_producer    ("GNU C89 10.2.1 20210110
-mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387
-mno-fp-ret-in-387 -mpreferred-stack-
boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone
-mcmodel=kernel -mindirect-branch=thunk-extern
-mindirect-branch-register -mrecord-mcount -mfentry -march=x86-
64 -g -gdwarf-5 -O2 -std=gnu90 -p -fno-strict-aliasing -fno-common
-fshort-wchar -fno-PIE -falign-jumps=1 -falign-loops=1
-fno-asynchronous-unwind-tables -fno-jump-tab
les -fno-delete-null-pointer-checks -fno-allow-store-data-races
-fstack-protector-strong -fno-strict-overflow -fstack-check=no
-fconserve-stack -fcf-protection=none")
1017375-              DW_AT_language    (DW_LANG_C11)
1017376-              DW_AT_name        ("arch/x86/events/intel/knc.c")
1017377-              DW_AT_comp_dir    ("/home/dileks/src/linux-kernel/git")
1017378:              DW_AT_ranges      (0x000080d8error: decoding
address ranges: invalid range list offset 0x80d8
1017379-)
1017380-              DW_AT_low_pc      (0x0000000000000000)
1017381-              DW_AT_stmt_list   (0x000298ec)
1017382-

Furthermore I see <decoding error>.

[ example <decoding error> ]

1016826-0x001a131b:     DW_TAG_formal_parameter
1016827-                  DW_AT_abstract_origin (0x0019dacd "event")
1016828-                  DW_AT_location        (0x00020eff:
1016829:                     [0xffffffff8100f9c0, 0xffffffff8100fa76):
<decoding error> fa 37 3e 01 00 9f)
1016830-                  DW_AT_unknown_2137    (0x00020efd)

- Sedat -

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

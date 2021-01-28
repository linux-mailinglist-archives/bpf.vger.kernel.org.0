Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47A308119
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 23:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhA1W3F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 17:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhA1W3E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 17:29:04 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8447C061573;
        Thu, 28 Jan 2021 14:28:23 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e7so6793237ile.7;
        Thu, 28 Jan 2021 14:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ELqSBfu2vyzyGj5dFK7kc/OpXl+WUV/0wOP0dfvVFs0=;
        b=VufRjeabT+0kGgn0mKK0XYTyUBg32wG+m/aPLViwxXuLBSjGFgW6jwD3IiFhEaaIMr
         zlvkROoI+UoKhvTOjJbhh9Vqx08atnQzy9GxtfLmceg/n1wIYWcil4xvhzuV+bzy5EaM
         UqxVj8k4m0aFN5LVorLAxuXWvllbUuu7SZaWJ/2ExZ5w6I4FJU93TiKhRtrNgbahSq1b
         zfDYfmtyVi93dpEYDu4D7KuoSWeiZSFiOSD85aARgotTZSau49R+qE9pQRLxJQ3zjPNW
         gjKLF4MlZRMoMJknFDxEf84Qh5eDt23xA01/8JvQzlLGnPVAHm0xYlQ4C/7MC59NSeKQ
         Nd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ELqSBfu2vyzyGj5dFK7kc/OpXl+WUV/0wOP0dfvVFs0=;
        b=YqigAz7ZRM7DQ/+KHoRefXOar7ykaHf/WgE2IY5hpJ4f1LIS1yRnb1DV105t68IoV1
         ofqxHzJzWgxQPw7EgPQ/fciIaXCXjyFsJ/YAbwwCLdIWRIys/mHB1fR+dYsX1zKOQSQO
         arFSZr3o8YKwZVlCsHoj6HGWFf0XN/K0/F8QdOMNy4wUsOrFdnmlUJrwkkpC9i86JNgH
         ozSwSC0MeXP2fRUOYq559lRhP1ipn/IjNUOcSZrwGhj4PqAkZToBhLCtgBsl1ucKdmzC
         rQou590CSVTzY8WW5VMw5k0oKViRHaAyzQXK5VsxjU17NUtOUZdXlz8VOw56rJtnJUhx
         f6qQ==
X-Gm-Message-State: AOAM532ChrKbqXAACuMgdvzEz8b+zLJnYbJD9auGM07HNb45OGm3C8ch
        d7WyFw7+jFL19boIBtSORWdDC8etwvacvUSjmv8=
X-Google-Smtp-Source: ABdhPJwC08mq28Ieq+1/NTSj8eufqC91M0zZAJcfgu3OAPooqdxheecE3iQa+v9BsC0EFBAt5y5kvQ+Fqh5iswxcs5k=
X-Received: by 2002:a05:6e02:e94:: with SMTP id t20mr1023596ilj.10.1611872903274;
 Thu, 28 Jan 2021 14:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org> <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
 <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
 <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com>
 <20210128200046.GA794568@kernel.org> <CA+icZUWi_3=T2B-bv4dd6D78rpHKVyYrkpxEVcXPW5saqHttCg@mail.gmail.com>
 <20210128211120.GB794568@kernel.org>
In-Reply-To: <20210128211120.GB794568@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 28 Jan 2021 23:28:10 +0100
Message-ID: <CA+icZUWsMKXZSZN9MSY-uCuCa_WVFLjn2JqkaM9e2zwS1A8Z8A@mail.gmail.com>
Subject: Re: [RFT] pahole 1.20 RC was Re: [PATCH] btf_encoder: Add extra
 checks for symbol names
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Mark Wielaard <mark@klomp.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 10:11 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Jan 28, 2021 at 09:57:14PM +0100, Sedat Dilek escreveu:
> > On Thu, Jan 28, 2021 at 9:00 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
>
> > > Em Thu, Jan 21, 2021 at 08:11:17PM -0800, Andrii Nakryiko escreveu:
> > > > On Thu, Jan 21, 2021 at 6:07 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > Do you want Nick's DWARF v5 patch-series as a base?
>
> > > > Arnaldo was going to figure out the DWARF v5 problem, so I'm leaving
> > > > it up to him. I'm curious about DWARF v4 problems because no one yet
> > > > reported that previously.
>
> > > I think I have the reported one fixed, Andrii, can you please do
> > > whatever pre-release tests you can in your environment with what is in:
>
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=DW_AT_data_bit_offset
>
> > > ?
>
> > > The cset has the tests I performed and the references to the bugzilla
> > > ticket and Daniel has tested as well for his XDR + gcc 11 problem.
> >
> > What Git tree should someone use to test this?
> > Linus Git?
> > bpf / bpf-next?
>
> The one you were having problems with :)
>
> This pahole branch should be handling multiple problems, this is the
> list of changes since v1.19:
>
> [acme@five pahole]$ git log --oneline v1.19..
> b91b19840b0062b8 (HEAD -> master, quaco/master, origin/DW_AT_data_bit_offset) dwarf_loader: Support DW_AT_data_bit_offset
> c692e8ac5ccbab99 dwarf_loader: Optimize a bit the reading of DW_AT_data_member_location
> 65917b24942ce620 dwarf_loader: Fix typo
> 77205a119c85e396 dwarf_loader: Introduce __attr_offset() to reuse call to dwarf_attr()
> 8ec231f6b0c8aaef dwarf_loader: Support DW_FORM_implicit_const in attr_numeric()
> 7453895e01edb535 (origin/master, origin/HEAD) btf_encoder: Improve ELF error reporting
> 1bb49897dd2b65b0 bpf_encoder: Translate SHN_XINDEX in symbol's st_shndx values
> 3f8aad340bf1a188 elf_symtab: Handle SHN_XINDEX index in elf_section_by_name()
> e32b9800e650a6eb btf_encoder: Add extra checks for symbol names
> 82749180b23d3c9c libbpf: allow to use packaged version
> 452dbcf35f1a7bf9 btf_encoder: Improve error-handling around objcopy
> cf381f9a3822d68b btf_encoder: Fix handling of restrict qualifier
> b688e35970600c15 btf_encoder: fix skipping per-CPU variables at offset 0
> 8c009d6ce762dfc9 btf_encoder: fix BTF variable generation for kernel modules
> b94e97e015a94e6b dwarves: Fix compilation on 32-bit architectures
> 17df51c700248f02 btf_encoder: Detect kernel module ftrace addresses
> 06ca639505fc56c6 btf_encoder: Use address size based on ELF's class
> aff60970d16b909e btf_encoder: Factor filter_functions function
> 1e6a3fed6e52d365 rpm: Fix changelog date
> [acme@five pahole]$
>
> Now I just need to do the boilerplate update of the version number,
> Changes and .spec file, to release v1.20.
>

When do you plan to release v1.20?
I can wait until this is done.

- Sedat -

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87AE30E525
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 22:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBCVs7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 16:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhBCVs5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 16:48:57 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F9AC061573;
        Wed,  3 Feb 2021 13:48:17 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y19so1019826iov.2;
        Wed, 03 Feb 2021 13:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=nTqV+R8t56296c8JuUfgr9lZlT9ZCtRpcpTT3uo8rh4=;
        b=jxObuLg8vva6iafZBwhHs87KrcR2vrwngkwy8yUGaQLEi85lYUM4CoGeX4rf0Ct8aQ
         PR4qeR/26U0e84hbjrzROfJntFuRbKqSKLu1MhjrzjJ42tHQur2Lnza6WZCbJg7ShbZ6
         dwcf4c+5GRfQxgyEdp/2DKqXCehKIRyLkPGVCp22qhJAOhFDM+/k221xdKNzTaeklA94
         sQAmkfGlVQ4dv901AApreuBVVDFygFLfthNmsTVk8Urq2FObWK7QJdWPd9AgE5L88r/o
         MHwDSz3j2JmmYnk+e9ZN4ytXNyAFogLlpDK5HGnXqCJGTo5qBXamwUzlc6lxqa8dN1l0
         2FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=nTqV+R8t56296c8JuUfgr9lZlT9ZCtRpcpTT3uo8rh4=;
        b=MuLKRR8+ZLBpQuLL5svNMXwynARRzYBSptuq5T+0GnVRboV28loCOPhRXPXL809VD/
         NbsyBfvXeyabyhRs4LTapy5fQ4w8wJRTkWMe01s3VycQXlngZ0yyp0g27LH7rhDei5iq
         w+YH3glBo/YNiBSPJ2U7+Q+Xr3Jued2oBw6dJ7smIQWxHHW7gEWurPU/PkY7pwxF+PxS
         Uq5HHiUUVmWnJkSHkcR/ir7gNmGYMByDNrDcuMVN8PhvlZmJe1EBX5fhGvBXGgveIUFh
         yLyNq2frIX2keXMwkd/rwI6p8leRnWZGt/UqRdx5jIqPnbrrZsjuiwQsFmEzs3giVxBE
         wdEg==
X-Gm-Message-State: AOAM530ygAFbIS6fF1tiFjvKuhnKZ9xiB6093E2cZrcgyi+MSv7OytLL
        zcukVYCn+n/vh2FOhpZo+NUM9D4ZF2zDf++RQSX87toYExyyow0V
X-Google-Smtp-Source: ABdhPJyd7+UlFczlni9ZedEUeVecsDW1Xhc5NkEZeHzNb0puu7YTRQYmBM5zmC210b3rC/Y+4MbWPgYt0Dfdcym5QHM=
X-Received: by 2002:a05:6602:150a:: with SMTP id g10mr4123618iow.75.1612388896722;
 Wed, 03 Feb 2021 13:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org> <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
 <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
 <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com>
 <20210128200046.GA794568@kernel.org> <CAEf4BzbXhn2qAwNyDx6Oqaj7+RdBtjnPPLe27=B0-aB9yY+Xmw@mail.gmail.com>
 <CA+icZUUTddV18rhZjaVif0a6BgpWtpj4mP1pyQ9cfh_e2xxvMQ@mail.gmail.com> <95233b493fd29b613f5bf3f92419528ce3298c14.camel@klomp.org>
In-Reply-To: <95233b493fd29b613f5bf3f92419528ce3298c14.camel@klomp.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 3 Feb 2021 22:48:05 +0100
Message-ID: <CA+icZUU+XEMnrwgOSRhAaO1bn2p62P6g1KVKGyJfRqxt_jr0Ew@mail.gmail.com>
Subject: Re: [RFT] pahole 1.20 RC was Re: [PATCH] btf_encoder: Add extra
 checks for symbol names
To:     Mark Wielaard <mark@klomp.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 11:23 AM Mark Wielaard <mark@klomp.org> wrote:
>
> Hi,
>
> On Wed, 2021-02-03 at 10:03 +0100, Sedat Dilek wrote:
> > > It all looks to be working fine on my side. There is a compilation
> > > error in our libbpf CI when building the latest pahole from sources
> > > due to DW_FORM_implicit_const being undefined. I'm updating our VMs to
> > > use Ubuntu Focal 20.04, up from Bionic 18.04, and that should
> > > hopefully solve the issue due to newer versions of libdw. If you worry
> > > about breaking others, though, we might want to add #ifndef guards and
> > > re-define DW_FORM_implicit_const as 0x21 explicitly in pahole source
> > > code.
>
> I think that might be a good idea for older setups. But that also means
> that the underlying elfutils libdw doesn't support DWARF5, so pahole
> itself also wouldn't work (the define would only fix the compile time
> issue, not the runtime issue of not being able to parse
> DW_FORM_implicit_const). That might not be a problem because such
> systems also wouldn't have GCC11 defaulting to DWARF5.
>
> > > But otherwise, all good from what I can see in my environment.
> > > Looking
> > > forward to 1.20 release! I'll let you know if, after updating to
> > > Ubuntu Focal, any new pahole issues crop up.
> > >
> >
> > Last weekend I did some testing with
> > <pahole.git#DW_AT_data_bit_offset> and DWARF-v5 support for the
> > Linux-kernel.
> >
> > The good: I was able to compile :-).
> > The bad: My build-log grew up to 1.2GiB and I could not boot in QEMU.
> > The ugly: I killed the archive which had all relevant material.
>
> I think the build-log grew so much because of warnings about unknown
> tags. At least when using GCC11 you'll get a couple of standardized
> DWARF5 tags instead of the GNU extensions to DWARF4. That should be
> solved by:
>
>    commit d783117162c0212d4f75f6cea185f493d2f244e1
>    Author: Mark Wielaard <mark@klomp.org>
>    Date:   Sun Jan 31 01:27:31 2021 +0100
>
>        dwarf_loader: Handle DWARF5 DW_TAG_call_site like DW_TAG_GNU_call_site
>

I had some conversation with Mark directly as I dropped by accident the CC list.

With latest pahole from Git and CONFIG_DEBUG_INFO_BTF=y I was not able
to build with DWARF-v4 and DWARF-v5.

Hope it is OK for you Mark when I quote you:

> Here I use LLVM/Clang v12.0.0-rc1 with Clang's Integrated Assembler
> (make LLVM_IAS=1).

Note I haven't personally tested llvm with DWARF5. I know some other
tools cannot (yet) handle the DWARF5 produced by llvm (for example
valgrind, rpm debugedit and dwz don't handle all the forms llvm emits
when it produces DWARF5, which aren't emitted by GCC unless requesting
split-dwarf). In theory dwarves/pahole should be able to handle it
because elfutils libdw (at least versions > 0.172) does handle it. But
I don't know if anybody ever tested that. But I believe llvm will by
default emit DWARF4, not 5.

More quotes from Mark:

I would try to avoid using clang producing DWARF5. It clearly has some
incompatibilities with dwarves/pahole. It should work if you don't set
DEBUG_INFO_DWARF5. Try GCC 11 (which defaults to -gdwarf-5) or an
earlier version (probably at least GCC 8 or higher) using -gdwarf-5
explicitly.

What makes me nerves are reports from Red Hat's CKI reporting:

'failed to validate module [something] BTF: -22 '

This is was from ClangBuiltLinux mailing-list.

Looks like CONFIG_DEBUG_INFO_BTF=y makes troubles with LLVM/Clang.
Can we have a fix for Linux v5.11-rc6+ to avoid a selection of it when
CC_IS_CLANG=y?

- Sedat -


- Sedat -

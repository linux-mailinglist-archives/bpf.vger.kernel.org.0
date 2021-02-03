Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E30F30D766
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 11:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhBCKYe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Feb 2021 05:24:34 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:37754 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhBCKYb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 05:24:31 -0500
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 5301B30014A4;
        Wed,  3 Feb 2021 11:23:48 +0100 (CET)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id EB7E24000C6A; Wed,  3 Feb 2021 11:23:47 +0100 (CET)
Message-ID: <95233b493fd29b613f5bf3f92419528ce3298c14.camel@klomp.org>
Subject: Re: [RFT] pahole 1.20 RC was Re: [PATCH] btf_encoder: Add extra
 checks for symbol names
From:   Mark Wielaard <mark@klomp.org>
To:     sedat.dilek@gmail.com, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date:   Wed, 03 Feb 2021 11:23:47 +0100
In-Reply-To: <CA+icZUUTddV18rhZjaVif0a6BgpWtpj4mP1pyQ9cfh_e2xxvMQ@mail.gmail.com>
References: <20210112184004.1302879-1-jolsa@kernel.org>
         <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
         <20210121133825.GB12699@kernel.org>
         <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
         <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
         <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
         <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com>
         <20210128200046.GA794568@kernel.org>
         <CAEf4BzbXhn2qAwNyDx6Oqaj7+RdBtjnPPLe27=B0-aB9yY+Xmw@mail.gmail.com>
         <CA+icZUUTddV18rhZjaVif0a6BgpWtpj4mP1pyQ9cfh_e2xxvMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Wed, 2021-02-03 at 10:03 +0100, Sedat Dilek wrote:
> > It all looks to be working fine on my side. There is a compilation
> > error in our libbpf CI when building the latest pahole from sources
> > due to DW_FORM_implicit_const being undefined. I'm updating our VMs to
> > use Ubuntu Focal 20.04, up from Bionic 18.04, and that should
> > hopefully solve the issue due to newer versions of libdw. If you worry
> > about breaking others, though, we might want to add #ifndef guards and
> > re-define DW_FORM_implicit_const as 0x21 explicitly in pahole source
> > code.

I think that might be a good idea for older setups. But that also means
that the underlying elfutils libdw doesn't support DWARF5, so pahole
itself also wouldn't work (the define would only fix the compile time
issue, not the runtime issue of not being able to parse
DW_FORM_implicit_const). That might not be a problem because such
systems also wouldn't have GCC11 defaulting to DWARF5.

> > But otherwise, all good from what I can see in my environment.
> > Looking
> > forward to 1.20 release! I'll let you know if, after updating to
> > Ubuntu Focal, any new pahole issues crop up.
> > 
> 
> Last weekend I did some testing with
> <pahole.git#DW_AT_data_bit_offset> and DWARF-v5 support for the
> Linux-kernel.
> 
> The good: I was able to compile :-).
> The bad: My build-log grew up to 1.2GiB and I could not boot in QEMU.
> The ugly: I killed the archive which had all relevant material.

I think the build-log grew so much because of warnings about unknown
tags. At least when using GCC11 you'll get a couple of standardized
DWARF5 tags instead of the GNU extensions to DWARF4. That should be
solved by:

   commit d783117162c0212d4f75f6cea185f493d2f244e1
   Author: Mark Wielaard <mark@klomp.org>
   Date:   Sun Jan 31 01:27:31 2021 +0100

       dwarf_loader: Handle DWARF5 DW_TAG_call_site like DW_TAG_GNU_call_site

Cheers,

Mark

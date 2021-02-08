Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EBB313273
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 13:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhBHMee (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 07:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhBHMdl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 07:33:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C09164E29;
        Mon,  8 Feb 2021 12:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612787576;
        bh=QHwBG5t3IgPGFwvRBSet4aYWvotFTkddluPXk2FzwEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGsYuMrxFvuSdyzd6WJKnPijC+J71+PFg8/YbICLxaCwSbDNb1ttMyIgeldDzuU7K
         jVwOVyfiS1oHkCi5hZIHcS6tPj1t819TtDd0tVRO4X4CwEQOtxd+7GWyHA9J7d1Z26
         bJHOPtQ5OMPtEudEYk57VvkXVWWvEeRu0OlJ/tbpSki+9s8xzbH9n9z4skMBvja6Gh
         vrgT0U6E1y93a6i29wKHdgffExxEPIivEkJYy2vGtrH4PTbOddnF/3DChr8E1HA/Ec
         iPDxjPIa3EfMolUh9ps05Q942e84iNGooRiGjXHzw6uy2wsELOMU0ktvdyUjd8cUXM
         vKCnhEFkapW1A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8B13140513; Mon,  8 Feb 2021 09:32:53 -0300 (-03)
Date:   Mon, 8 Feb 2021 09:32:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF
 sections, BTF)
Message-ID: <20210208123253.GI920417@kernel.org>
References: <20210204220741.GA920417@kernel.org>
 <CA+icZUXngJL2WXRyeWDjTyBYbXc0uC0_C69nBH9bq4sr_TAx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXngJL2WXRyeWDjTyBYbXc0uC0_C69nBH9bq4sr_TAx5g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 08, 2021 at 03:44:54AM +0100, Sedat Dilek escreveu:
> On Thu, Feb 4, 2021 at 11:07 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Hi,
> >
> >         The v1.20 release of pahole and its friends is out, mostly
> > addressing problems related to gcc 11 defaulting to DWARF5 for -g,
> > available at the usual places:
> >
> > Main git repo:
> >
> >    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> >
> > Mirror git repo:
> >
> >    https://github.com/acmel/dwarves.git
> >
> > tarball + gpg signature:
> >
> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.xz
> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.bz2
> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.sign
> >
> 
> FYI:
> Debian now ships dwarves package version 1.20-1 in unstable.
> 
> Just a small nit to this release and its tagging:
> 
> You did:
> commit 0d415f68c468b77c5bf8e71965cd08c6efd25fc4 ("pahole: Prep 1.20")
> 
> Is this new?
> 
> The release before:
> commit dd15aa4b0a6421295cbb7c3913429142fef8abe0 ("dwarves: Prep v1.19")

Its minor but intentional, pahole is by far the most well known tool in
dwarves, so using that name more frequently (the git repo is pahole.git
, for instance) may help more quickly associate with the tool needed for
BTF encoding, data analysis, etc. And since its not about only DWARF,
perhaps transitioning to using 'pahole' more widely is interesting.

- Arnaldo
 
> - Sedat -
> 
> > Best Regards,
> >
> >  - Arnaldo
> >
> > v1.20:
> >
> > BTF encoder:
> >
> >   - Improve ELF error reporting using elf_errmsg(elf_errno()).
> >
> >   - Improve objcopy error handling.
> >
> >   - Fix handling of 'restrict' qualifier, that was being treated as a 'const'.
> >
> >   - Support SHN_XINDEX in st_shndx symbol indexes, to handle ELF objects with
> >     more than 65534 sections, for instance, which happens with kernels built
> >     with 'KCFLAGS="-ffunction-sections -fdata-sections", Other cases may
> >     include when using FG-ASLR, LTO.
> >
> >   - Cope with functions without a name, as seen sometimes when building kernel
> >     images with some versions of clang, when a SEGFAULT was taking place.
> >
> >   - Fix BTF variable generation for kernel modules, not skipping variables at
> >     offset zero.
> >
> >   - Fix address size to match what is in the ELF file being processed, to fix using
> >     a 64-bit pahole binary to generate BTF for a 32-bit vmlinux image.
> >
> >   - Use kernel module ftrace addresses when finding which functions to encode,
> >     which increases the number of functions encoded.
> >
> > libbpf:
> >
> >   - Allow use of packaged version, for distros wanting to dynamically link with
> >     the system's libbpf package instead of using the libbpf git submodule shipped
> >     in pahole's source code.
> >
> > DWARF loader:
> >
> >   - Support DW_AT_data_bit_offset
> >
> >     This appeared in DWARF4 but is supported only in gcc's -gdwarf-5,
> >     support it in a way that makes the output be the same for both cases.
> >
> >       $ gcc -gdwarf-5 -c examples/dwarf5/bf.c
> >       $ pahole bf.o
> >       struct pea {
> >             long int                   a:1;                  /*     0: 0  8 */
> >             long int                   b:1;                  /*     0: 1  8 */
> >             long int                   c:1;                  /*     0: 2  8 */
> >
> >             /* XXX 29 bits hole, try to pack */
> >             /* Bitfield combined with next fields */
> >
> >             int                        after_bitfield;       /*     4     4 */
> >
> >             /* size: 8, cachelines: 1, members: 4 */
> >             /* sum members: 4 */
> >             /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 29 bits */
> >             /* last cacheline: 8 bytes */
> >       };
> >
> >   - DW_FORM_implicit_const in attr_numeric() and attr_offset()
> >
> >   - Support DW_TAG_GNU_call_site, its the standardized rename of the previously supported
> >     DW_TAG_GNU_call_site.
> >
> > build:
> >
> >     - Fix compilation on 32-bit architectures.
> >
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

-- 

- Arnaldo

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63431327E
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 13:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhBHMii (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 07:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhBHMhf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 07:37:35 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43032C061756;
        Mon,  8 Feb 2021 04:36:55 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id s24so14768313iob.6;
        Mon, 08 Feb 2021 04:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=XVgkuNO4+jr2vCIL3QHJO3r5ytZj4xYpNO3TrrbQxUI=;
        b=r3HvRdjnJXQ/1/LSSLo3mL3rHT4DPlo4wNWe3irW/4+lwzKQhlzaS7H+PZpU+UZZZR
         pmXw8rixFb9R9a26r6XEElcNIniE6cIXlnW27k/QFJwuTefhyzQ5a49PkYX1d8L1ewM4
         xtiMCyhvtod7kVPbakX7CgCsBHbsky+PzyxhX8DCdEIHDaFA3Pq5+LA+4zUdwFZds8+v
         MEOy3i634/Zfxf3U+MI1nCcoBNIXqQyauBsWM8qzcoK6ZWdY5rp2RuwzWqOzSYtnvGZG
         MCpqV9E/8DqQtnJQNviRluYiTZuknrbVkvM86l3m2hQtn6mBPt+Ettyo0BjXCVLoVATZ
         syIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=XVgkuNO4+jr2vCIL3QHJO3r5ytZj4xYpNO3TrrbQxUI=;
        b=VhBUHjR0BN2bGij8JkEqmyK33LN+v2OWrfOuhJDaFpngON66vFadS3j2HaE2X/FebF
         bsuqT+eSe7dSnHUhgsH3/a3CFLs9p1e4ClBjQD8zQjWfnO0dAylhbSs/8BnzYRLXET0D
         vsS4SZJbudmky6o1xFG+kl7Q9gGb0vz/CRCATM4VvosG/3aq7iSYnp4ZmFPuwMlZNQnf
         Puk/WkRFgZ9TbcDgWfYZ62FyBkWrp/pJ6p8iGQJ1FJ+98/1zrCbuFyAbrrvQgTm70tca
         3xC9ONylYf95Lgucj3ulF7cEmdjC/Z3GRk+yzBCjprdpXEYh6aOJHx5nTFNcUSzm+k0n
         7SmA==
X-Gm-Message-State: AOAM533tjdMQbSZ6e9izp2a27Z1o/Y6p8eHMqyn8tCNFHzhIolmV7DrW
        lgkD08/Pi8ARUcCqckqTzkYtgSOb/htDhbyx750=
X-Google-Smtp-Source: ABdhPJwMzS+T/NH5AD/g6WfN6JkDacKQrt/8Mvgbz6m6uqFcNA9UgFPyb//NdriGvqHH4RGua8qZAt3d5nGw2ac4v9E=
X-Received: by 2002:a05:6602:1541:: with SMTP id h1mr14540632iow.171.1612787814564;
 Mon, 08 Feb 2021 04:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUXngJL2WXRyeWDjTyBYbXc0uC0_C69nBH9bq4sr_TAx5g@mail.gmail.com>
 <20210208123253.GI920417@kernel.org>
In-Reply-To: <20210208123253.GI920417@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Feb 2021 13:36:43 +0100
Message-ID: <CA+icZUXxRfsm_2siyb-kjPjikJk1uSnbQNzxP_7=3=HyJdkDaQ@mail.gmail.com>
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF
 sections, BTF)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 1:32 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Feb 08, 2021 at 03:44:54AM +0100, Sedat Dilek escreveu:
> > On Thu, Feb 4, 2021 at 11:07 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > >         The v1.20 release of pahole and its friends is out, mostly
> > > addressing problems related to gcc 11 defaulting to DWARF5 for -g,
> > > available at the usual places:
> > >
> > > Main git repo:
> > >
> > >    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> > >
> > > Mirror git repo:
> > >
> > >    https://github.com/acmel/dwarves.git
> > >
> > > tarball + gpg signature:
> > >
> > >    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.xz
> > >    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.bz2
> > >    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.sign
> > >
> >
> > FYI:
> > Debian now ships dwarves package version 1.20-1 in unstable.
> >
> > Just a small nit to this release and its tagging:
> >
> > You did:
> > commit 0d415f68c468b77c5bf8e71965cd08c6efd25fc4 ("pahole: Prep 1.20")
> >
> > Is this new?
> >
> > The release before:
> > commit dd15aa4b0a6421295cbb7c3913429142fef8abe0 ("dwarves: Prep v1.19")
>
> Its minor but intentional, pahole is by far the most well known tool in
> dwarves, so using that name more frequently (the git repo is pahole.git
> , for instance) may help more quickly associate with the tool needed for
> BTF encoding, data analysis, etc. And since its not about only DWARF,
> perhaps transitioning to using 'pahole' more widely is interesting.
>

I am fine with that, Arnaldo.
The Git tree is called "pahole" Git, so that makes sense to me.

- Sedat -

> - Arnaldo
>
> > - Sedat -
> >
> > > Best Regards,
> > >
> > >  - Arnaldo
> > >
> > > v1.20:
> > >
> > > BTF encoder:
> > >
> > >   - Improve ELF error reporting using elf_errmsg(elf_errno()).
> > >
> > >   - Improve objcopy error handling.
> > >
> > >   - Fix handling of 'restrict' qualifier, that was being treated as a 'const'.
> > >
> > >   - Support SHN_XINDEX in st_shndx symbol indexes, to handle ELF objects with
> > >     more than 65534 sections, for instance, which happens with kernels built
> > >     with 'KCFLAGS="-ffunction-sections -fdata-sections", Other cases may
> > >     include when using FG-ASLR, LTO.
> > >
> > >   - Cope with functions without a name, as seen sometimes when building kernel
> > >     images with some versions of clang, when a SEGFAULT was taking place.
> > >
> > >   - Fix BTF variable generation for kernel modules, not skipping variables at
> > >     offset zero.
> > >
> > >   - Fix address size to match what is in the ELF file being processed, to fix using
> > >     a 64-bit pahole binary to generate BTF for a 32-bit vmlinux image.
> > >
> > >   - Use kernel module ftrace addresses when finding which functions to encode,
> > >     which increases the number of functions encoded.
> > >
> > > libbpf:
> > >
> > >   - Allow use of packaged version, for distros wanting to dynamically link with
> > >     the system's libbpf package instead of using the libbpf git submodule shipped
> > >     in pahole's source code.
> > >
> > > DWARF loader:
> > >
> > >   - Support DW_AT_data_bit_offset
> > >
> > >     This appeared in DWARF4 but is supported only in gcc's -gdwarf-5,
> > >     support it in a way that makes the output be the same for both cases.
> > >
> > >       $ gcc -gdwarf-5 -c examples/dwarf5/bf.c
> > >       $ pahole bf.o
> > >       struct pea {
> > >             long int                   a:1;                  /*     0: 0  8 */
> > >             long int                   b:1;                  /*     0: 1  8 */
> > >             long int                   c:1;                  /*     0: 2  8 */
> > >
> > >             /* XXX 29 bits hole, try to pack */
> > >             /* Bitfield combined with next fields */
> > >
> > >             int                        after_bitfield;       /*     4     4 */
> > >
> > >             /* size: 8, cachelines: 1, members: 4 */
> > >             /* sum members: 4 */
> > >             /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 29 bits */
> > >             /* last cacheline: 8 bytes */
> > >       };
> > >
> > >   - DW_FORM_implicit_const in attr_numeric() and attr_offset()
> > >
> > >   - Support DW_TAG_GNU_call_site, its the standardized rename of the previously supported
> > >     DW_TAG_GNU_call_site.
> > >
> > > build:
> > >
> > >     - Fix compilation on 32-bit architectures.
> > >
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> --
>
> - Arnaldo

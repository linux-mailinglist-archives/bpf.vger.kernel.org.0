Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0052431D92F
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 13:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhBQMJ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 07:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhBQMJK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 07:09:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9200C061756;
        Wed, 17 Feb 2021 04:08:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s11so16101512edd.5;
        Wed, 17 Feb 2021 04:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wCiprttcJrxg36K7+oZp1ekp7sHvdrxJrdrMsQnuA4I=;
        b=TU4RgbOYRInkGvV+4PQ14uKZwd/i64yZaEV+4i3DVwQOhlkahCyMImCDYghB3xW3zG
         DKoZ/TIyBu1hSAg9oxDC2t97PGUa0zAobJ+wBL/Q4Q4IuCqVuk5kWkuWv3fifkwgFpZ2
         0JSS1C5eNo8ceCuY6Dg+0yF9G2hy64Sc7AI1ZV7Yl2e8FnwFkRLr3vFaPVg4UCuj9u2x
         7DRnxaPaHpZSwZQUSK6x36sTRBV8LuHb+WumkHnGpeoXjvAgn9LpHoCMERB3ZNuWSu9E
         r3QN7SgH5a6DVvs7OOaV4VUu52OuqD+y98/ZoqAMF1ARP6tIiERIi/JedP2RVGgPzQrV
         Y3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wCiprttcJrxg36K7+oZp1ekp7sHvdrxJrdrMsQnuA4I=;
        b=I8vKeWFjbh0Qt+RhUUwDeKi83XfPDY+y6a60AYxBYSyIivdz/pjuKoiZ6S64Yvatoa
         gzQ8MSJckLQaq52xv/Bxuhr0g++ESXND7Krjy/EF+dwlZ+abif9vbZaXGn04ZYv/mtHH
         NPM9xZTkull+/jNCZdist+UmsUIeOt84QsRQaXJgM/MEfIQxyVPco6KejNX0Psu4GUWA
         Ij+ll0PdrUg+9Tl1k1ZTpSZR6P47zedeplBNhSkF8yMUZRcXcXCciUwta9zmt1nz4Rh/
         tRYkelu5PbkrVq4diczPhQK2CaKJPfHGWAVZFBLHMywlsi2FlsdIu8P4WWOVBN/jDfCu
         iRig==
X-Gm-Message-State: AOAM532FwuPx8NfqmnSqUWq6RX2oA5nZIedvRcV3GA58ayq4ttNSvBT8
        n5qfg3BwFDarGfxr+QtqaUM=
X-Google-Smtp-Source: ABdhPJzUvyFHPz/a/dERWGi/qD53dMGA76GDrWPaNOGriRcbeImOwfvwwv6emN5wUEr416BQDhhthg==
X-Received: by 2002:a05:6402:4312:: with SMTP id m18mr25916678edc.99.1613563708584;
        Wed, 17 Feb 2021 04:08:28 -0800 (PST)
Received: from m4.love (tor-exit-6.zbau.f3netze.de. [2a0b:f4c0:16c:6::1])
        by smtp.gmail.com with ESMTPSA id lj13sm425377ejb.123.2021.02.17.04.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 04:08:27 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.love with local (Exim 4.94)
        (envelope-from <cavok@m4>)
        id 1lCLd1-00066Y-Ih; Wed, 17 Feb 2021 13:08:23 +0100
Date:   Wed, 17 Feb 2021 13:08:23 +0100
From:   Domenico Andreoli <cavok@debian.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>, 705969@bugs.debian.org
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF
 sections, BTF)
Message-ID: <YC0HN+0Tva0lOPIt@m4>
References: <20210204220741.GA920417@kernel.org>
 <CA+icZUXngJL2WXRyeWDjTyBYbXc0uC0_C69nBH9bq4sr_TAx5g@mail.gmail.com>
 <20210208123253.GI920417@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gIYVh1ASy4tAHzNX"
Content-Disposition: inline
In-Reply-To: <20210208123253.GI920417@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--gIYVh1ASy4tAHzNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2021 at 09:32:53AM -0300, Arnaldo Carvalho de Melo wrote:
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
> >=20
> > FYI:
> > Debian now ships dwarves package version 1.20-1 in unstable.
> >=20
> > Just a small nit to this release and its tagging:
> >=20
> > You did:
> > commit 0d415f68c468b77c5bf8e71965cd08c6efd25fc4 ("pahole: Prep 1.20")
> >=20
> > Is this new?
> >=20
> > The release before:
> > commit dd15aa4b0a6421295cbb7c3913429142fef8abe0 ("dwarves: Prep v1.19")
>=20
> Its minor but intentional, pahole is by far the most well known tool in
> dwarves, so using that name more frequently (the git repo is pahole.git
> , for instance) may help more quickly associate with the tool needed for
> BTF encoding, data analysis, etc. And since its not about only DWARF,
> perhaps transitioning to using 'pahole' more widely is interesting.

Any plan to switch also the release tarball name?

We are planning to rename the Debian package once the Bullseye is
released, currently it's dwarves-dfsg for legacy/unclear reasons.

Would it be a good idea to switch directly to pahole then?

Dom

>=20
> - Arnaldo
> =20
> > - Sedat -
> >=20
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
> > >   - Fix handling of 'restrict' qualifier, that was being treated as a=
 'const'.
> > >
> > >   - Support SHN_XINDEX in st_shndx symbol indexes, to handle ELF obje=
cts with
> > >     more than 65534 sections, for instance, which happens with kernel=
s built
> > >     with 'KCFLAGS=3D"-ffunction-sections -fdata-sections", Other case=
s may
> > >     include when using FG-ASLR, LTO.
> > >
> > >   - Cope with functions without a name, as seen sometimes when buildi=
ng kernel
> > >     images with some versions of clang, when a SEGFAULT was taking pl=
ace.
> > >
> > >   - Fix BTF variable generation for kernel modules, not skipping vari=
ables at
> > >     offset zero.
> > >
> > >   - Fix address size to match what is in the ELF file being processed=
, to fix using
> > >     a 64-bit pahole binary to generate BTF for a 32-bit vmlinux image.
> > >
> > >   - Use kernel module ftrace addresses when finding which functions t=
o encode,
> > >     which increases the number of functions encoded.
> > >
> > > libbpf:
> > >
> > >   - Allow use of packaged version, for distros wanting to dynamically=
 link with
> > >     the system's libbpf package instead of using the libbpf git submo=
dule shipped
> > >     in pahole's source code.
> > >
> > > DWARF loader:
> > >
> > >   - Support DW_AT_data_bit_offset
> > >
> > >     This appeared in DWARF4 but is supported only in gcc's -gdwarf-5,
> > >     support it in a way that makes the output be the same for both ca=
ses.
> > >
> > >       $ gcc -gdwarf-5 -c examples/dwarf5/bf.c
> > >       $ pahole bf.o
> > >       struct pea {
> > >             long int                   a:1;                  /*     0=
: 0  8 */
> > >             long int                   b:1;                  /*     0=
: 1  8 */
> > >             long int                   c:1;                  /*     0=
: 2  8 */
> > >
> > >             /* XXX 29 bits hole, try to pack */
> > >             /* Bitfield combined with next fields */
> > >
> > >             int                        after_bitfield;       /*     4=
     4 */
> > >
> > >             /* size: 8, cachelines: 1, members: 4 */
> > >             /* sum members: 4 */
> > >             /* sum bitfield members: 3 bits, bit holes: 1, sum bit ho=
les: 29 bits */
> > >             /* last cacheline: 8 bytes */
> > >       };
> > >
> > >   - DW_FORM_implicit_const in attr_numeric() and attr_offset()
> > >
> > >   - Support DW_TAG_GNU_call_site, its the standardized rename of the =
previously supported
> > >     DW_TAG_GNU_call_site.
> > >
> > > build:
> > >
> > >     - Fix compilation on 32-bit architectures.
> > >
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> --=20
>=20
> - Arnaldo

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--gIYVh1ASy4tAHzNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0znebYyV6RAN/q8htwRzp/vsqYEFAmAtBzMACgkQtwRzp/vs
qYFwaQ//cmKhFeLG2+gdsqQq4giRbZXq2lnrUpPV/WHtlMQ/VHjwicMP80GqHZ1h
7SUDggas/62cxXZ2+9ffyQYUbgvpNwk5MVPsAUOzCJF6EQ/1SDMQEsS2lGEU6SVc
qtYXB7YTaKCxFNBeh6mcNqpPZnJ4qwezVs52e36Rk0tiYJNneHrhOmXrox16vI1/
X5q7NaGvfmsB/WpyWiecw7MpuI3aoZq+D7Y5rOoEgCML4s/13rUuybJlAYnsuww5
9OZomNOWypQpPTmdGBd2APBsK/VaGZkoYtGVGMXqg+XqiYh/1aUlmo95blbsFMuB
sRKTRoHkY6Hf4JjalAKgUfYAsHnBxBxMdV3nmLypEeEX9YPROBj6e3c7HlkgsWbb
oxL7WpqxWrVNPl5FtchzMaBD9xt+tWgzhTFLnKNsEbprHAuLzp/p8fPC91HCf7c7
Ox1gVR2UY0Lju+aByffZlRxJ/pbSYZpTYtKZUXrTw/pGoAqKer4ntNBiRfl4vG97
PbMKV49faixLwpkTQr1VuS7RpE2nkrnT9mRMVZk4aFxGq5sgpfLWfXmvOtVX6Zq0
/kyoan585ro4qtlQ5Wxq2TcSU5QNcLCtI4N89wqENyzTbFqZjU4LE/jhtoSYpYOO
fBf5WybiqIKJSHOArgCXKWQvg7DAfGCP5pkTS2zCye0r3J2MGx8=
=aQcl
-----END PGP SIGNATURE-----

--gIYVh1ASy4tAHzNX--

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E043CC401
	for <lists+bpf@lfdr.de>; Sat, 17 Jul 2021 17:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhGQPR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Jul 2021 11:17:59 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54845 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbhGQPRz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Jul 2021 11:17:55 -0400
Received: by mail-wm1-f47.google.com with SMTP id f190so5987191wmf.4;
        Sat, 17 Jul 2021 08:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=B7fP5CY1G2fTDIvxnIjh1oanff+lfLNVbaoPapOtKv4=;
        b=MOXCW4bug8+2NBu1KH0eS09eeGlyZZHxdnyHH0vIP2GSSOw17XOGCNaiOzxDDYrlRD
         x9qlpIFQHMLS6JCf5LITF+KW+JluDiS8MXEHU7oDaTrBFyjI6N6vwMHVwpD2WiZQP/Sz
         c3voP9N9l0eH8TkIySE3RAyEYTpylOWxqNnlmW7sXErzbhY2I8d3xQwviNo/hsOX9K2n
         An9mXWxa11gHErTDqUS5jpXfAD+WIw/RWWNyef9iZY2NdN7P50vGe2mhgm0ErBr0EKz1
         VirUPiiq9C0KbhX3rbFKWZwez8StZfs0B2L2jC9iOMPCmXoUJRn6w8T2TBbhDS29qcyp
         4Uzg==
X-Gm-Message-State: AOAM530yxguOA815OwfXUG1TPmKNrh/ZmKphsRUJXf9CHkc7lrtjQzSZ
        bg3EieUUzrcmRMoWX/SzYPg=
X-Google-Smtp-Source: ABdhPJzeeo50r3fvnhI3o0364eCBH97OWwiowyF/o91WyARu7a9QaKIXD/1o54UHYd61XXKDCgEl+Q==
X-Received: by 2002:a05:600c:3799:: with SMTP id o25mr22852617wmr.63.1626534897478;
        Sat, 17 Jul 2021 08:14:57 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id a9sm13867241wrv.37.2021.07.17.08.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:14:56 -0700 (PDT)
Message-ID: <b07015ebd7bbadb06a95a5105d9f6b4ed5817b2f.camel@debian.org>
Subject: Re: [RFT] Testing 1.22
From:   Luca Boccassi <bluca@debian.org>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Date:   Sat, 17 Jul 2021 16:14:54 +0100
In-Reply-To: <20210717151003.GM24916@kitsune.suse.cz>
References: <YK+41f972j25Z1QQ@kernel.org>
         <20210715213120.GJ24916@kitsune.suse.cz> <YPGIxJao9SrsiG9X@kernel.org>
         <484bd96c1ae52516d54a5a45f2be108ee838f77a.camel@debian.org>
         <22b863ce92fb0f90006eee9a2a1bf82a7352cf1b.camel@debian.org>
         <20210716201248.GL24916@kitsune.suse.cz>
         <f699a04791efbb6936ef19a8dbfc99f6e77e7136.camel@debian.org>
         <20210717151003.GM24916@kitsune.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Q/YLAt9OmWygB1hiy7uo"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-Q/YLAt9OmWygB1hiy7uo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2021-07-17 at 17:10 +0200, Michal Such=C3=A1nek wrote:
> Hello,
>=20
> On Sat, Jul 17, 2021 at 03:35:03PM +0100, Luca Boccassi wrote:
> > On Fri, 2021-07-16 at 22:12 +0200, Michal Such=C3=A1nek wrote:
> > > On Fri, Jul 16, 2021 at 08:08:27PM +0100, Luca Boccassi wrote:
> > > > On Fri, 2021-07-16 at 14:35 +0100, Luca Boccassi wrote:
> > > > > On Fri, 2021-07-16 at 10:25 -0300, Arnaldo Carvalho de Melo wrote=
:
> > > > > > Em Thu, Jul 15, 2021 at 11:31:20PM +0200, Michal Such=C3=A1nek =
escreveu:
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > when building with system libbpf I get:
> > > > > > >=20
> > > > > > > [   40s] make[1]: Nothing to be done for 'preinstall'.
> > > > > > > [   40s] make[1]: Leaving directory '/home/abuild/rpmbuild/BU=
ILD/dwarves-1.21+git175.1ef87b2/build'
> > > > > > > [   40s] Install the project...
> > > > > > > [   40s] /usr/bin/cmake -P cmake_install.cmake
> > > > > > > [   40s] -- Install configuration: "RelWithDebInfo"
> > > > > > > [   40s] -- Installing: /home/abuild/rpmbuild/BUILDROOT/dwarv=
es-1.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > > > > > [   40s] CMake Error at cmake_install.cmake:63 (file):
> > > > > > > [   40s]   file RPATH_CHANGE could not write new RPATH:
> > > > > > > [   40s]=20
> > > > > > > [   40s]    =20
> > > > > > > [   40s]=20
> > > > > > > [   40s]   to the file:
> > > > > > > [   40s]=20
> > > > > > > [   40s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git=
175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > > > > > [   40s]=20
> > > > > > > [   40s]   The current RUNPATH is:
> > > > > > > [   40s]=20
> > > > > > > [   40s]     /home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.=
1ef87b2/build:
> > > > > > > [   40s]=20
> > > > > > > [   40s]   which does not contain:
> > > > > > > [   40s]=20
> > > > > > > [   40s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwa=
rves-1.21+git175.1ef87b2/build:
> > > > > > > [   40s]=20
> > > > > > > [   40s]   as was expected.
> > > > > > > [   40s]=20
> > > > > > > [   40s]=20
> > > > > > > [   40s] make: *** [Makefile:74: install] Error 1
> > > > > > > [   40s] make: Leaving directory '/home/abuild/rpmbuild/BUILD=
/dwarves-1.21+git175.1ef87b2/build'
> > > > > > > [   40s] error: Bad exit status from /var/tmp/rpm-tmp.OaGNX4 =
(%install)
> > > > > > >=20
> > > > > > > This is not a problem with embedded libbpf.
> > > > > > >=20
> > > > > > > Using system libbpf seems to be new in 1.22
> > > > > >=20
> > > > > > Lucca, can you take a look at this?
> > > > > >=20
> > > > > > Thanks,
> > > > > >=20
> > > > > > - Arnaldo
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > Michal, what is the CMake configuration command line you are usin=
g?
> > > >=20
> > > > Latest tmp.master builds fine here with libbpf 0.4.0. To reproduce =
it
> > > > would be good to know build env and command line used, otherwise I
> > > > can't really tell.
> > >=20
> > > Indeed, there is non-trivial rpm macro expanded when invoking cmake.
> > >=20
> > > Attaching log.
> > >=20
> > > Thanks
> > >=20
> > > Michal
> >=20
> > So, this took some spelunking. TL;DR: openSUSE's libbpf.pc from libbpf-
> > devel is broken, it lists -L/usr/local/lib64 in Libs even though it
> > doesn't install anything in that prefix. Fix it to list the right path
> > and the problem goes away.
> >=20
> > Longer version: CMake is complaining that the rpath in the binary is
> > not what it expected it to be when stripping it. Of course the first
> > question is, why does that matter since it's removing it? Just remove
> > it, no? Another CMake weirdness to add the the list, I guess.
> >=20
> > [   20s]   file RPATH_CHANGE could not write new RPATH:
> > [   20s]=20
> > [   20s]    =20
> > [   20s]=20
> > [   20s]   to the file:
> > [   20s]=20
> > [   20s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-
> > 1.21+git175.1ef87b2-21.1.x86_64/usr/bin/codiff
> > [   20s]=20
> > [   20s]   The current RUNPATH is:
> > [   20s]=20
> > [   20s]     /home/abuild/rpmbuild/BUILD/dwarves-
> > 1.21+git175.1ef87b2/build:
> > [   20s]=20
> > [   20s]   which does not contain:
> > [   20s]=20
> > [   20s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-
> > 1.21+git175.1ef87b2/build:
> > [   20s]=20
> > [   20s]   as was expected.
> >=20
> > This is the linking step where the rpath is set:
> >=20
> > [   19s] /usr/bin/cc -O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector-
> > strong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-
> > protection -Werror=3Dreturn-type -flto=3Dauto -g -DNDEBUG
> > -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -O2 -g -DNDEBUG -flto=3D=
auto
> > -Wl,--as-needed -Wl,--no-undefined -Wl,-z,now -rdynamic
> > CMakeFiles/codiff.dir/codiff.c.o -o codiff   -L/usr/local/lib64  -Wl,-
> > rpath,/usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-
> > 1.21+git175.1ef87b2/build: libdwarves.so.1.0.0 -ldw -lelf -lz -lbpf=20
> >=20
> > On a build without -DLIBBPF_EMBEDDED=3Doff, this is the linking step fo=
r
> > the same binary:
> >=20
> > [   64s] /usr/bin/cc -O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector-
> > strong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-
> > protection -Werror=3Dreturn-type -flto=3Dauto -g -DNDEBUG
> > -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -O2 -g -DNDEBUG -flto=3D=
auto
> > -Wl,--as-needed -Wl,--no-undefined -Wl,-z,now -rdynamic
> > CMakeFiles/codiff.dir/codiff.c.o -o codiff  -Wl,-
> > rpath,/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
> > libdwarves.so.1.0.0 -ldw -lelf -lz
> >=20
> > /usr/local/lib64 is not in the rpath. Why? The hint is that
> > -L/usr/local/lib64 is not passed either, too much of a coincidence to
> > be unrelated.
> >=20
> > Where is it coming from? Well, when using the system's libbpf we are
> > using the pkgconfig file from the package. It is common to list linker
> > flags in there, although this one shouldn't be in it. Sure enough,
> > downloading libbpf-devel from=20
> > https://build.opensuse.org/package/binaries/openSUSE:Factory/libbpf/sta=
ndard
> > and extracting the pc file:
> >=20
> > $ cat /tmp/libbpf.pc=20
> > # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >=20
> > prefix=3D/usr/local
> > libdir=3D/usr/local/lib64
> > includedir=3D${prefix}/include
> >=20
> > Name: libbpf
> > Description: BPF library
> > Version: 0.3.0
> > Libs: -L${libdir} -lbpf
> > Requires.private: libelf zlib
> > Cflags: -I${includedir}
> >=20
> > There it is. Nothing is installed in that path, so it shouldn't be
> > there in the first place.
> >=20
> > $ rpm -qlp /tmp/libbpf0-5.12.4-2.7.x86_64.rpm=20
> > warning: /tmp/libbpf0-5.12.4-2.7.x86_64.rpm: Header V3 RSA/SHA256
> > Signature, key ID 3dbdc284: NOKEY
> > /usr/lib64/libbpf.so.0
> > /usr/lib64/libbpf.so.0.3.0
>=20
> Thanks for the investigation
>=20
> So this libbpf comes from the kernel, and there is a separate github
> repository for libbpf.
>=20
> Should the kernel ship its own copy of the library?
>=20
> Seeing that the one in the kernel is 0.3.0 and the required one for
> dwarves is 0.4.0 maybe the one in the kernel needs updating if it needs
> to be shipped there?
>=20
> I wil file a bug to build the libbpf from the git repo instead of the
> kernel to make the openSUSE libbpf less baroque.
>=20
> Thanks
>=20
> Michal

They provide the same ABI, so there should be only one in the same
distro, the kernel package shouldn't ship its own copy if there's a
standalone package built from the standalone sources.
If you are asking why the sources are still present in the upstream
kernel, I don't know - maybe historical reasons, since that's where it
came from? But AFAIK the majority of distros don't use that anymore.

--=20
Kind regards,
Luca Boccassi

--=-Q/YLAt9OmWygB1hiy7uo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDy8+4ACgkQKGv37813
JB7c1g//XwyExncimnbmSy240+XPjQDBa5TViL3FEfUpAXmd/c5mGuiPbf7A7gsi
WwqPCLXe7xTLtkwCgdQ86ZSv5H0WDzcFx38d9lJsUblOIabZ9hD2QG0AUJtDdACS
wC4fIqpDvvSMLeffMP2Wu6dbsvE0QaxovUiDBrqWs/ikhSW3/bvSaZcHHdMh+DRx
MHbHstj6mlt4vufKDd5rcZDjwDq2cKcvCHoNwtu2+h5pm1T0r4QuU21Qj4/kfp9B
G96P0CvCLfdXBAKpKhGtQFXu8YhDvH7wwbNh0Ure49KabF1MnBYOOpKLKcMo/KOn
55DUhy6UP8kqdSq7QRxzcsWklpcNXTe4PNQnk3E6CU6uG8b/2DxGfAHH/vge6hZw
RMCSy3+gHad3RqPy5kvJjb/P5r5fd0LEmXp2A0PV7YESjG5ppXMi/+vXucLMJGDg
Jl2nTjx7wGOGS+pTC8OIIszz3pJDoJsNpBP1d4QtbGvyIMKJjmpMdGcBFBoe+p8x
xOfMw3ldtx3IU2N8ASd8qCEe93S0YdU8zClsngFRP2DojAK2ftkQqLo/KyDNECBY
5GfdsXglzZwXnjVvSOH2EtgPFD2nB5pcnp6GzUFOMDbTb9finAxCcgO2/4KmY2rQ
w1yTml3W2IBjHd1y1VTuXEMuAf/8iMwLxvXBmbhGtBRbrkNN6I0=
=Qdry
-----END PGP SIGNATURE-----

--=-Q/YLAt9OmWygB1hiy7uo--

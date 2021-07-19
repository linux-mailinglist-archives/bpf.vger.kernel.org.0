Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4AB3CD201
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbhGSJx0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 05:53:26 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:56150 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhGSJx0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 05:53:26 -0400
Received: by mail-wm1-f42.google.com with SMTP id c17so3002755wmb.5;
        Mon, 19 Jul 2021 03:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=dVtfIGoBOuNqHzfqZyMDOk24omqvIiRTHLHQMCeFAnk=;
        b=bkAQe0PvQq+8MYM3qgFAdxKXO2CZaetDh7eDZVkfBZaJk6amV/xgT3ia6D4Lx33V+U
         X0th5HUG2iB4JcOCOG3OX0tHq8zj3TKnMCkj6Jhi3FChKiL85sR/j3r2gsuMAu1wmYmk
         61xtMrvcVmrrLUe84R6cqAgeCczzhRN3JHFviJoSUH0FuIks2mVrQy4+3nrx96pKP+Vm
         p4zwqzr5E2nBJeG0SqgR2Wkc844otHc2V3ouT88MZG0GOkyvLpsP4ZWrypqJaFY4ejkk
         FKUnB/Tsd1u+GiZOXo6ijedMnrVHSmPaX2FSFprDKLz2OhHOhPEasRakUOVbFVeGRtyB
         bcdw==
X-Gm-Message-State: AOAM5318GZHlwzp+jkX8zxH+5gf4R4BhV2F7YEXlrFJZK+q4YnfXLTHP
        DXypdewVKWn2MzdMm+vgzaY=
X-Google-Smtp-Source: ABdhPJxcS4wI2ZBjYDztT3/mLUgH7s0iUU3nvIctLm5sNzOMGbcH5rO5cxkQ9vnwyRsD7Jl4UXOD9g==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr26195503wmj.73.1626690844483;
        Mon, 19 Jul 2021 03:34:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:360b:9754:2e3a:c344])
        by smtp.gmail.com with ESMTPSA id u12sm20362441wrt.50.2021.07.19.03.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 03:34:03 -0700 (PDT)
Message-ID: <3f4a7a7d6b652f1175dea9b7cb86c2bceeb40b55.camel@debian.org>
Subject: Re: [RFT] Testing 1.22
From:   Luca Boccassi <bluca@debian.org>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Date:   Mon, 19 Jul 2021 11:34:01 +0100
In-Reply-To: <20210719103025.GR24916@kitsune.suse.cz>
References: <YK+41f972j25Z1QQ@kernel.org>
         <20210715213120.GJ24916@kitsune.suse.cz> <YPGIxJao9SrsiG9X@kernel.org>
         <484bd96c1ae52516d54a5a45f2be108ee838f77a.camel@debian.org>
         <22b863ce92fb0f90006eee9a2a1bf82a7352cf1b.camel@debian.org>
         <20210716201248.GL24916@kitsune.suse.cz>
         <f699a04791efbb6936ef19a8dbfc99f6e77e7136.camel@debian.org>
         <20210717151003.GM24916@kitsune.suse.cz>
         <b07015ebd7bbadb06a95a5105d9f6b4ed5817b2f.camel@debian.org>
         <20210719103025.GR24916@kitsune.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-OKm5VHoRZSJznI60a5mJ"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-OKm5VHoRZSJznI60a5mJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-07-19 at 12:30 +0200, Michal Such=C3=A1nek wrote:
> On Sat, Jul 17, 2021 at 04:14:54PM +0100, Luca Boccassi wrote:
> > On Sat, 2021-07-17 at 17:10 +0200, Michal Such=C3=A1nek wrote:
> > > Hello,
> > >=20
> > > On Sat, Jul 17, 2021 at 03:35:03PM +0100, Luca Boccassi wrote:
> > > > On Fri, 2021-07-16 at 22:12 +0200, Michal Such=C3=A1nek wrote:
> > > > > On Fri, Jul 16, 2021 at 08:08:27PM +0100, Luca Boccassi wrote:
> > > > > > On Fri, 2021-07-16 at 14:35 +0100, Luca Boccassi wrote:
> > > > > > > On Fri, 2021-07-16 at 10:25 -0300, Arnaldo Carvalho de Melo w=
rote:
> > > > > > > > Em Thu, Jul 15, 2021 at 11:31:20PM +0200, Michal Such=C3=A1=
nek escreveu:
> > > > > > > > > Hello,
> > > > > > > > >=20
> > > > > > > > > when building with system libbpf I get:
> > > > > > > > >=20
> > > > > > > > > [   40s] make[1]: Nothing to be done for 'preinstall'.
> > > > > > > > > [   40s] make[1]: Leaving directory '/home/abuild/rpmbuil=
d/BUILD/dwarves-1.21+git175.1ef87b2/build'
> > > > > > > > > [   40s] Install the project...
> > > > > > > > > [   40s] /usr/bin/cmake -P cmake_install.cmake
> > > > > > > > > [   40s] -- Install configuration: "RelWithDebInfo"
> > > > > > > > > [   40s] -- Installing: /home/abuild/rpmbuild/BUILDROOT/d=
warves-1.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > > > > > > > [   40s] CMake Error at cmake_install.cmake:63 (file):
> > > > > > > > > [   40s]   file RPATH_CHANGE could not write new RPATH:
> > > > > > > > > [   40s]=20
> > > > > > > > > [   40s]    =20
> > > > > > > > > [   40s]=20
> > > > > > > > > [   40s]   to the file:
> > > > > > > > > [   40s]=20
> > > > > > > > > [   40s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21=
+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > > > > > > > [   40s]=20
> > > > > > > > > [   40s]   The current RUNPATH is:
> > > > > > > > > [   40s]=20
> > > > > > > > > [   40s]     /home/abuild/rpmbuild/BUILD/dwarves-1.21+git=
175.1ef87b2/build:
> > > > > > > > > [   40s]=20
> > > > > > > > > [   40s]   which does not contain:
> > > > > > > > > [   40s]=20
> > > > > > > > > [   40s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD=
/dwarves-1.21+git175.1ef87b2/build:
> > > > > > > > > [   40s]=20
> > > > > > > > > [   40s]   as was expected.
> > > > > > > > > [   40s]=20
> > > > > > > > > [   40s]=20
> > > > > > > > > [   40s] make: *** [Makefile:74: install] Error 1
> > > > > > > > > [   40s] make: Leaving directory '/home/abuild/rpmbuild/B=
UILD/dwarves-1.21+git175.1ef87b2/build'
> > > > > > > > > [   40s] error: Bad exit status from /var/tmp/rpm-tmp.OaG=
NX4 (%install)
> > > > > > > > >=20
> > > > > > > > > This is not a problem with embedded libbpf.
> > > > > > > > >=20
> > > > > > > > > Using system libbpf seems to be new in 1.22
> > > > > > > >=20
> > > > > > > > Lucca, can you take a look at this?
> > > > > > > >=20
> > > > > > > > Thanks,
> > > > > > > >=20
> > > > > > > > - Arnaldo
> > > > > > >=20
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > Michal, what is the CMake configuration command line you are =
using?
> > > > > >=20
> > > > > > Latest tmp.master builds fine here with libbpf 0.4.0. To reprod=
uce it
> > > > > > would be good to know build env and command line used, otherwis=
e I
> > > > > > can't really tell.
> > > > >=20
> > > > > Indeed, there is non-trivial rpm macro expanded when invoking cma=
ke.
> > > > >=20
> > > > > Attaching log.
> > > > >=20
> > > > > Thanks
> > > > >=20
> > > > > Michal
> > > >=20
> > > > So, this took some spelunking. TL;DR: openSUSE's libbpf.pc from lib=
bpf-
> > > > devel is broken, it lists -L/usr/local/lib64 in Libs even though it
> > > > doesn't install anything in that prefix. Fix it to list the right p=
ath
> > > > and the problem goes away.
> > > >=20
> > > > Longer version: CMake is complaining that the rpath in the binary i=
s
> > > > not what it expected it to be when stripping it. Of course the firs=
t
> > > > question is, why does that matter since it's removing it? Just remo=
ve
> > > > it, no? Another CMake weirdness to add the the list, I guess.
> > > >=20
> > > > [   20s]   file RPATH_CHANGE could not write new RPATH:
> > > > [   20s]=20
> > > > [   20s]    =20
> > > > [   20s]=20
> > > > [   20s]   to the file:
> > > > [   20s]=20
> > > > [   20s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-
> > > > 1.21+git175.1ef87b2-21.1.x86_64/usr/bin/codiff
> > > > [   20s]=20
> > > > [   20s]   The current RUNPATH is:
> > > > [   20s]=20
> > > > [   20s]     /home/abuild/rpmbuild/BUILD/dwarves-
> > > > 1.21+git175.1ef87b2/build:
> > > > [   20s]=20
> > > > [   20s]   which does not contain:
> > > > [   20s]=20
> > > > [   20s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-
> > > > 1.21+git175.1ef87b2/build:
> > > > [   20s]=20
> > > > [   20s]   as was expected.
> > > >=20
> > > > This is the linking step where the rpath is set:
> > > >=20
> > > > [   19s] /usr/bin/cc -O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protec=
tor-
> > > > strong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-
> > > > protection -Werror=3Dreturn-type -flto=3Dauto -g -DNDEBUG
> > > > -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -O2 -g -DNDEBUG -flt=
o=3Dauto
> > > > -Wl,--as-needed -Wl,--no-undefined -Wl,-z,now -rdynamic
> > > > CMakeFiles/codiff.dir/codiff.c.o -o codiff   -L/usr/local/lib64  -W=
l,-
> > > > rpath,/usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-
> > > > 1.21+git175.1ef87b2/build: libdwarves.so.1.0.0 -ldw -lelf -lz -lbpf=
=20
> > > >=20
> > > > On a build without -DLIBBPF_EMBEDDED=3Doff, this is the linking ste=
p for
> > > > the same binary:
> > > >=20
> > > > [   64s] /usr/bin/cc -O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protec=
tor-
> > > > strong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-
> > > > protection -Werror=3Dreturn-type -flto=3Dauto -g -DNDEBUG
> > > > -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -O2 -g -DNDEBUG -flt=
o=3Dauto
> > > > -Wl,--as-needed -Wl,--no-undefined -Wl,-z,now -rdynamic
> > > > CMakeFiles/codiff.dir/codiff.c.o -o codiff  -Wl,-
> > > > rpath,/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build=
:
> > > > libdwarves.so.1.0.0 -ldw -lelf -lz
> > > >=20
> > > > /usr/local/lib64 is not in the rpath. Why? The hint is that
> > > > -L/usr/local/lib64 is not passed either, too much of a coincidence =
to
> > > > be unrelated.
> > > >=20
> > > > Where is it coming from? Well, when using the system's libbpf we ar=
e
> > > > using the pkgconfig file from the package. It is common to list lin=
ker
> > > > flags in there, although this one shouldn't be in it. Sure enough,
> > > > downloading libbpf-devel from=20
> > > > https://build.opensuse.org/package/binaries/openSUSE:Factory/libbpf=
/standard
> > > > and extracting the pc file:
> > > >=20
> > > > $ cat /tmp/libbpf.pc=20
> > > > # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > > >=20
> > > > prefix=3D/usr/local
> > > > libdir=3D/usr/local/lib64
> > > > includedir=3D${prefix}/include
> > > >=20
> > > > Name: libbpf
> > > > Description: BPF library
> > > > Version: 0.3.0
> > > > Libs: -L${libdir} -lbpf
> > > > Requires.private: libelf zlib
> > > > Cflags: -I${includedir}
> > > >=20
> > > > There it is. Nothing is installed in that path, so it shouldn't be
> > > > there in the first place.
> > > >=20
> > > > $ rpm -qlp /tmp/libbpf0-5.12.4-2.7.x86_64.rpm=20
> > > > warning: /tmp/libbpf0-5.12.4-2.7.x86_64.rpm: Header V3 RSA/SHA256
> > > > Signature, key ID 3dbdc284: NOKEY
> > > > /usr/lib64/libbpf.so.0
> > > > /usr/lib64/libbpf.so.0.3.0
> > >=20
> > > Thanks for the investigation
> > >=20
> > > So this libbpf comes from the kernel, and there is a separate github
> > > repository for libbpf.
> > >=20
> > > Should the kernel ship its own copy of the library?
> > >=20
> > > Seeing that the one in the kernel is 0.3.0 and the required one for
> > > dwarves is 0.4.0 maybe the one in the kernel needs updating if it nee=
ds
> > > to be shipped there?
> > >=20
> > > I wil file a bug to build the libbpf from the git repo instead of the
> > > kernel to make the openSUSE libbpf less baroque.
> > >=20
> > > Thanks
> > >=20
> > > Michal
> >=20
> > They provide the same ABI, so there should be only one in the same
> > distro, the kernel package shouldn't ship its own copy if there's a
> > standalone package built from the standalone sources.
> > If you are asking why the sources are still present in the upstream
> > kernel, I don't know - maybe historical reasons, since that's where it
> > came from? But AFAIK the majority of distros don't use that anymore.
> Apparently the libbpf github repository is only mirror of the kernel
> libbpf source with some modifications to build it as standalone.
>=20
> Thanks
>=20
> Michal

Yes the source code is mirrored, IIRC the main difference is in the
makefiles which are more standalone-build-friendly than the kernel's.

--=20
Kind regards,
Luca Boccassi

--=-OKm5VHoRZSJznI60a5mJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmD1VRkACgkQKGv37813
JB6X2RAAjt7j6/LwNrhA3nP/2GBNqkCpt/jlr8JDsmPNHKbrhADLdl98hpL4MR0j
C5bWSB3uNATQfTEBUUhOwSXc+AUoDN6QcnBY+PmNWyWrEOakpAD1IXy0A2Cm8xC9
Cext5p6Cu9SnmAFS94QAAz/cpoiHU3oYlwJTnxKefO/Yl0OpOjNRTaI1OEldUXBn
YK7OH6Qr/rL5Y7RC2hJDplupWs65ODE7MCWSLfaXRSMeKNqEWKX1W7KD3NIOqkZN
ZZvy+kZec3Zg5I/G3Mv60f4NJMz+kBM+VsvCfRp0SbgRRjBHk6jD6XqAUIYnVQBc
xxD+RoCOkHR+XAfv48NrX8zLjRHjcSglB9cIuXpWH2QwF7LHj8ubMUiCfokynReT
MX+3jbzEAvPhjJE+uvm8ZS/eu3RVeKqkMIYXsNxH6mJWCl9Sw886j/rrVZyt2R5j
OsZ8FYj3rOsqC0CYRqme+Qo99r564D34yPrxcgMJdl1ta1qolxDB5YXMux97K19f
ApyvWrIdGCEvRjTkLG3h/1fXUWWgd7lEVecqq8LMfwRAh5YguEQGHazuIwV0m5hE
25LzwIKfXZVGXkQd4wqHrtt6nMvmZlRMkqwWN++ilpN3nkWAgsYV4p7s4qKXEqjI
SD5e3ppkcg5yriWJOJbgJoHTJg58KZxvHJ1eEFcXm7Au7WU+vJ0=
=+a12
-----END PGP SIGNATURE-----

--=-OKm5VHoRZSJznI60a5mJ--

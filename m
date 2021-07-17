Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19213CC3D6
	for <lists+bpf@lfdr.de>; Sat, 17 Jul 2021 16:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhGQOiE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Jul 2021 10:38:04 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41898 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhGQOiE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Jul 2021 10:38:04 -0400
Received: by mail-wr1-f43.google.com with SMTP id k4so15454816wrc.8;
        Sat, 17 Jul 2021 07:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=QAF9twYYbTKlh+q87IdXRoUL73/zaWsQAj3wDGXMeuQ=;
        b=aOPkrBgVbURpjNhRb9sQxC6yQT5YL0JFN/NJQzWKTCHk0EIeBoTMpULNCtCNIU5YRk
         htIj6DAAbeWiP3wS168vpk2MxS0aiaM5dzWTxmAJ1q3O5ib5Pduvhluh+Su8sCmoO0IE
         jNU1fV7oESbDYdCLg0r2X770JwyFN+tZ70ALIBbZNuCDOyITPil+czrtCDgwO1iR6kRe
         eMiiWyVyrX++aShIfHTXFn/+0kDl/xvhnU3rlzOuqImMeWJ8FTVmtnRdw7zrLUWWFiuE
         r8VeCCHQlLXaZPkuMbEtg7XsUUKyW11v10uOOwzkthcUqT16a2nVPi68i0mkLqp75vti
         SVng==
X-Gm-Message-State: AOAM532IZi9ngEDncjkEGC2FCLT3qakLN6TORSRUz7iMUap/jqj15ytA
        KicEsi+BbOj23VS/lQxOwKc=
X-Google-Smtp-Source: ABdhPJwp3x2g9Koc7HE+FLvGg5M9stNaKBIx8/3fi0kxuZphQBJENDW48B0bOnJKszpsrp/SK7tgVA==
X-Received: by 2002:a5d:6daf:: with SMTP id u15mr19956338wrs.41.1626532506560;
        Sat, 17 Jul 2021 07:35:06 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id e6sm16090681wrg.18.2021.07.17.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:35:05 -0700 (PDT)
Message-ID: <f699a04791efbb6936ef19a8dbfc99f6e77e7136.camel@debian.org>
Subject: Re: [RFT] Testing 1.22
From:   Luca Boccassi <bluca@debian.org>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Date:   Sat, 17 Jul 2021 15:35:03 +0100
In-Reply-To: <20210716201248.GL24916@kitsune.suse.cz>
References: <YK+41f972j25Z1QQ@kernel.org>
         <20210715213120.GJ24916@kitsune.suse.cz> <YPGIxJao9SrsiG9X@kernel.org>
         <484bd96c1ae52516d54a5a45f2be108ee838f77a.camel@debian.org>
         <22b863ce92fb0f90006eee9a2a1bf82a7352cf1b.camel@debian.org>
         <20210716201248.GL24916@kitsune.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-4cgGXVoQ5IuPHd8p76c+"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-4cgGXVoQ5IuPHd8p76c+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-07-16 at 22:12 +0200, Michal Such=C3=A1nek wrote:
> On Fri, Jul 16, 2021 at 08:08:27PM +0100, Luca Boccassi wrote:
> > On Fri, 2021-07-16 at 14:35 +0100, Luca Boccassi wrote:
> > > On Fri, 2021-07-16 at 10:25 -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Thu, Jul 15, 2021 at 11:31:20PM +0200, Michal Such=C3=A1nek escr=
eveu:
> > > > > Hello,
> > > > >=20
> > > > > when building with system libbpf I get:
> > > > >=20
> > > > > [   40s] make[1]: Nothing to be done for 'preinstall'.
> > > > > [   40s] make[1]: Leaving directory '/home/abuild/rpmbuild/BUILD/=
dwarves-1.21+git175.1ef87b2/build'
> > > > > [   40s] Install the project...
> > > > > [   40s] /usr/bin/cmake -P cmake_install.cmake
> > > > > [   40s] -- Install configuration: "RelWithDebInfo"
> > > > > [   40s] -- Installing: /home/abuild/rpmbuild/BUILDROOT/dwarves-1=
.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > > > [   40s] CMake Error at cmake_install.cmake:63 (file):
> > > > > [   40s]   file RPATH_CHANGE could not write new RPATH:
> > > > > [   40s]=20
> > > > > [   40s]    =20
> > > > > [   40s]=20
> > > > > [   40s]   to the file:
> > > > > [   40s]=20
> > > > > [   40s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.=
1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > > > [   40s]=20
> > > > > [   40s]   The current RUNPATH is:
> > > > > [   40s]=20
> > > > > [   40s]     /home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef8=
7b2/build:
> > > > > [   40s]=20
> > > > > [   40s]   which does not contain:
> > > > > [   40s]=20
> > > > > [   40s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves=
-1.21+git175.1ef87b2/build:
> > > > > [   40s]=20
> > > > > [   40s]   as was expected.
> > > > > [   40s]=20
> > > > > [   40s]=20
> > > > > [   40s] make: *** [Makefile:74: install] Error 1
> > > > > [   40s] make: Leaving directory '/home/abuild/rpmbuild/BUILD/dwa=
rves-1.21+git175.1ef87b2/build'
> > > > > [   40s] error: Bad exit status from /var/tmp/rpm-tmp.OaGNX4 (%in=
stall)
> > > > >=20
> > > > > This is not a problem with embedded libbpf.
> > > > >=20
> > > > > Using system libbpf seems to be new in 1.22
> > > >=20
> > > > Lucca, can you take a look at this?
> > > >=20
> > > > Thanks,
> > > >=20
> > > > - Arnaldo
> > >=20
> > > Hi,
> > >=20
> > > Michal, what is the CMake configuration command line you are using?
> >=20
> > Latest tmp.master builds fine here with libbpf 0.4.0. To reproduce it
> > would be good to know build env and command line used, otherwise I
> > can't really tell.
>=20
> Indeed, there is non-trivial rpm macro expanded when invoking cmake.
>=20
> Attaching log.
>=20
> Thanks
>=20
> Michal

So, this took some spelunking. TL;DR: openSUSE's libbpf.pc from libbpf-
devel is broken, it lists -L/usr/local/lib64 in Libs even though it
doesn't install anything in that prefix. Fix it to list the right path
and the problem goes away.

Longer version: CMake is complaining that the rpath in the binary is
not what it expected it to be when stripping it. Of course the first
question is, why does that matter since it's removing it? Just remove
it, no? Another CMake weirdness to add the the list, I guess.

[   20s]   file RPATH_CHANGE could not write new RPATH:
[   20s]=20
[   20s]    =20
[   20s]=20
[   20s]   to the file:
[   20s]=20
[   20s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-
1.21+git175.1ef87b2-21.1.x86_64/usr/bin/codiff
[   20s]=20
[   20s]   The current RUNPATH is:
[   20s]=20
[   20s]     /home/abuild/rpmbuild/BUILD/dwarves-
1.21+git175.1ef87b2/build:
[   20s]=20
[   20s]   which does not contain:
[   20s]=20
[   20s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-
1.21+git175.1ef87b2/build:
[   20s]=20
[   20s]   as was expected.

This is the linking step where the rpath is set:

[   19s] /usr/bin/cc -O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector-
strong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-
protection -Werror=3Dreturn-type -flto=3Dauto -g -DNDEBUG
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -O2 -g -DNDEBUG -flto=3Dauto
-Wl,--as-needed -Wl,--no-undefined -Wl,-z,now -rdynamic
CMakeFiles/codiff.dir/codiff.c.o -o codiff   -L/usr/local/lib64  -Wl,-
rpath,/usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-
1.21+git175.1ef87b2/build: libdwarves.so.1.0.0 -ldw -lelf -lz -lbpf=20

On a build without -DLIBBPF_EMBEDDED=3Doff, this is the linking step for
the same binary:

[   64s] /usr/bin/cc -O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector-
strong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-
protection -Werror=3Dreturn-type -flto=3Dauto -g -DNDEBUG
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -O2 -g -DNDEBUG -flto=3Dauto
-Wl,--as-needed -Wl,--no-undefined -Wl,-z,now -rdynamic
CMakeFiles/codiff.dir/codiff.c.o -o codiff  -Wl,-
rpath,/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
libdwarves.so.1.0.0 -ldw -lelf -lz

/usr/local/lib64 is not in the rpath. Why? The hint is that
-L/usr/local/lib64 is not passed either, too much of a coincidence to
be unrelated.

Where is it coming from? Well, when using the system's libbpf we are
using the pkgconfig file from the package. It is common to list linker
flags in there, although this one shouldn't be in it. Sure enough,
downloading libbpf-devel from=20
https://build.opensuse.org/package/binaries/openSUSE:Factory/libbpf/standar=
d
and extracting the pc file:

$ cat /tmp/libbpf.pc=20
# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

prefix=3D/usr/local
libdir=3D/usr/local/lib64
includedir=3D${prefix}/include

Name: libbpf
Description: BPF library
Version: 0.3.0
Libs: -L${libdir} -lbpf
Requires.private: libelf zlib
Cflags: -I${includedir}

There it is. Nothing is installed in that path, so it shouldn't be
there in the first place.

$ rpm -qlp /tmp/libbpf0-5.12.4-2.7.x86_64.rpm=20
warning: /tmp/libbpf0-5.12.4-2.7.x86_64.rpm: Header V3 RSA/SHA256
Signature, key ID 3dbdc284: NOKEY
/usr/lib64/libbpf.so.0
/usr/lib64/libbpf.so.0.3.0
$ rpm -qlp /tmp/libbpf-devel-5.12.4-2.7.x86_64.rpm=20
warning: /tmp/libbpf-devel-5.12.4-2.7.x86_64.rpm: Header V3 RSA/SHA256
Signature, key ID 3dbdc284: NOKEY
/usr/include/bpf
/usr/include/bpf/bpf.h
/usr/include/bpf/bpf_core_read.h
/usr/include/bpf/bpf_endian.h
/usr/include/bpf/bpf_helper_defs.h
/usr/include/bpf/bpf_helpers.h
/usr/include/bpf/bpf_tracing.h
/usr/include/bpf/btf.h
/usr/include/bpf/libbpf.h
/usr/include/bpf/libbpf_common.h
/usr/include/bpf/libbpf_util.h
/usr/include/bpf/xsk.h
/usr/lib64/libbpf.so
/usr/lib64/pkgconfig/libbpf.pc

After hacking it out in the libbpf build:

https://build.opensuse.org/package/show/home:bluca:branches:home:michals/li=
bbpf

Dwarves then builds just fine with system libbpf:

https://build.opensuse.org/package/show/home:bluca:branches:home:michals/dw=
arves

Here's a PR for the libbpf package that applies a quick hack to fix it:

https://build.opensuse.org/request/show/906834

I'll send my invoice to SUSE Inc. ;-)

--=20
Kind regards,
Luca Boccassi

--=-4cgGXVoQ5IuPHd8p76c+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDy6pcACgkQKGv37813
JB5X6A//cNBtMrXaQRAoO2LAlNmUcXf5S3fqfrIOYmA4f73HrI0n6fDOhvGb7qjZ
WGY7MmyNoRfuz8g/mi1PehdefTsVX99KoFsXPRgUQQ7U6wNWvU4HdN9m3Bf6hn9t
xDBJdH8H2ybRgSYr5gsXbYfLGgExWAAX7FvtiAjLXBFrwYBiZ5uLanOxke6BhE/T
8WzNGWVEMgWA8Dan0vHkbWtvo+iVUqo2ums4BzLjc8iq/dKqOKnHSQTPU6QGivtH
DrxhI8iapvK/NogSeq1CHHtJuvrFfSvDuZlGZepX/g/8HiZ4BmMRHeVZ0lG2sqG9
49Z7dtn1rXsKm0UlbuFMNdhOOLfQRv4dq85TeDXlHrVSk1ZzuYihNaQX3Ji8fxsP
EdHvbn62DXk2e26kqBiBAI34E8dYueXwl/Yiei17mtSXFzahSd4F62495TYfkniQ
KlFAGd3dfdMdgxpyS1skjn1Lh81YFNL7iMndjRXT+o40ANPAIRHukrxdm0t/lLwB
QLyfk+OZyzfiRPw6redBDBscBwcjWXY87L80nC+Rv1F/ri5xGTWvZlVl1u35lFUt
j9JlEiEbxNiWIVoiRPuEN7YPvVVmXjqmoc/jataE0Lxc5VWA2tW4T6pBd2nyf6n/
JSDD8WETfqeu4X6qSmnIc67pFJrvjeY9GtM1mtNaa1jFR/X3tvU=
=SuOn
-----END PGP SIGNATURE-----

--=-4cgGXVoQ5IuPHd8p76c+--

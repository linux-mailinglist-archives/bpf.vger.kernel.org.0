Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4373D3A4AEA
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 00:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhFKWTq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 18:19:46 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:38477 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFKWTp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 18:19:45 -0400
Received: by mail-wm1-f49.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso9439751wmi.3;
        Fri, 11 Jun 2021 15:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=q28/zhdS3ZOpv0uHECMF52ivM61tod9qoq4YBGF2uGg=;
        b=FYXSkAr5w5HxEq0pj+YCDZJFmpR/8A0Yg8gwj2siVOwTDh6gBR7JBHLCsR65ZteUVh
         /NZde94eij/dvILt5JUfT3kX9U7ET9Q3BYYhEIv0TJz7L+SlagoteA36nvniXXULYzXj
         udk6Bc2/LJYxOdyIyG9fbeh9XU1eGMvoWeYTeESSVDiHPooJtOlTpCxBVMwCSGtNayrb
         dIcN0OkwT1Iibhs2MxhB8xHhYVfkbjyf1xwvS56UJ+RTixqAVhpyRLSD7eKsXSm15UeR
         W/S4S2lpUZlRjv/Uy+qwrbGbLWUz8nH2K6IwN5HMD4oXoHNz354GsOB8SFTyVg973MEw
         aXcw==
X-Gm-Message-State: AOAM53040NW+maHyKTwQ9x3PgUWQhoZm4nUDiWo/o6RyC7G4dGhnPRb0
        bRStse6UmlWfuLQd/ZRkexM=
X-Google-Smtp-Source: ABdhPJwnLN3/jliwarNg2VSkjmbO+kFKO1bSrjAA6SNVIaC/YB3pE3ArFOno0xD1tgrZRCULdZKu7g==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr22043138wmi.132.1623449851696;
        Fri, 11 Jun 2021 15:17:31 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id i15sm8232907wmq.23.2021.06.11.15.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 15:17:30 -0700 (PDT)
Message-ID: <9b4bcb2372f00c9ffa1b3d5d30a84755d8a3896c.camel@debian.org>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib
 creation
From:   Luca Boccassi <bluca@debian.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        dwarves@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, siudin@fb.com,
        bpf <bpf@vger.kernel.org>
Date:   Fri, 11 Jun 2021 23:17:29 +0100
In-Reply-To: <CAEf4BzYwf0fO5Y9pVKPg3TOwMcq-HneG-BGU8M+oAjMyhXBwQA@mail.gmail.com>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
         <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
         <YMJMdQvCWHd5J0M1@kernel.org>
         <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
         <YMPA1T0Cuo7xw/Sp@kernel.org>
         <CAEf4BzYwf0fO5Y9pVKPg3TOwMcq-HneG-BGU8M+oAjMyhXBwQA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-lWMhlaSJ+kovHpe6J6vg"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-lWMhlaSJ+kovHpe6J6vg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-06-11 at 13:08 -0700, Andrii Nakryiko wrote:
On Fri, Jun 11, 2021 at 1:00 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>=20
> Em Fri, Jun 11, 2021 at 12:34:13PM -0700, Andrii Nakryiko escreveu:
> > On Thu, Jun 10, 2021 at 10:31 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >=20
> > > Em Tue, Jun 08, 2021 at 12:50:13AM +0530, Deepak Kumar Mishra
> > > escreveu:
> > > > CMakeLists.txt does not allow creation of static library and
> > > > link applications
> > > > accordingly.
> > > >=20
> > > > Creation of SHARED and STATIC should be allowed using -
> > > > DBUILD_SHARED_LIBS
> > > > If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt
> > > > sets it to ON.
> > > >=20
> > > > Ex:
> > > > cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF ..
> > > > cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DON ..
> > >=20
> > > Had to do some fixups due to a previous patch touching
> > > CMakeLists.txt,
> > > please check below.
> > >=20
> > > I tested it and added some performance notes.
> >=20
> > Hey Arnaldo, Deepak,
> >=20
> > I think this commit actually breaks libbpf's CI (see [0]) and my
> > local
> > setup as well (see output below). It seems like now we are using
> > system-wide libbpf headers, while still building local libbpf
> > sources.
> > This is pretty bad because system-wide headers might be too old
> > or
> > just missing.
>=20
> I can't check this right now, but isn't this related to this one
> instead?

Heh, I beat you by 5 minutes ;)


Hi,

This should not be the case - the local paths are added to CMake and
should win, unless something is going wrong - which is of course
possible. A quick build of the current tip of the master branch would
seem to confirm things are working - building with -
DLIBBPF_EMBEDDED=3Doff (which does force to use the system library, and
defaults to on) the build fails, while building without any options on
a new tree the build succeeds.

I'll fetch the script and try to reproduce, as it might be using other
options - I assume it's this one, right?

https://github.com/libbpf/libbpf/blob/master/travis-ci/vmtest/build_pahole.=
sh

> >=20
> > commit ae2581647e84948810ba209f3891359dd4540110 (quaco/master,
> > quaco/HEAD, acme/tmp.master)
> > Author: Luca Boccassi <bluca@debian.org>
> > Date:=C2=A0=C2=A0 Mon Jan 4 22:16:22 2021 +0000
> >=20
> > =C2=A0=C2=A0=C2=A0 libbpf: Allow to use packaged version
> >=20
> > =C2=A0=C2=A0=C2=A0 Add a new CMake option, LIBBPF_EMBEDDED, to switch b=
etween the
> > embedded
> > =C2=A0=C2=A0=C2=A0 version and the system version (searched via pkg-con=
fig) of
> > libbpf. Set
> > =C2=A0=C2=A0=C2=A0 the embedded version as the default.
> >=20
> > =C2=A0-------
> >=20
> > I can't look at this right now, will try probably tomorrow.
> >=20
> > Andrii, I would love to be able to stage this somewhere, like I did
> > with
> > tmp.master, so that it could go thru your CI before I moved to
> > master,
> > is that possible?
>=20
> Yes, absolutely, we can pick whatever branch and use that to checkout
> and build pahole. It would be great, though, if you can keep an eye
> on
> kernel CI and/or libbpf CI breakages when you are pushing new changes
> to pahole. That would save everyone time and will shorten the
> downtime
> for our CIs.
>=20
> Here are the links where all the builds can be seen in real-time:
>=20
> =C2=A0 - kernel CI:=20
> https://travis-ci.com/github/kernel-patches/bpf/pull_requests
> =C2=A0 - libbpf CI: https://travis-ci.com/github/libbpf/libbpf
>=20
>=20
> Let me know which branch we should hard-code for staging.
>=20
> >=20
> > - Arnaldo
> >=20
> > > Is it possible to make sure that we always use local libbpf
> > > headers
> > > when building pahole with libbpf built from sources (the default
> > > case,
> > > right?). It's also important to use UAPI headers distributed with
> > > libbpf when building libbpf itself, I don't know if that's what
> > > is
> > > done right now or not.
> > >=20
> > > Note how libbpf CI case shows that system-wide bpf/btf.h is not
> > > available at all because we don't have system-wide libbpf
> > > installed.
> > > In my local case, you can see that my system-wide header is
> > > outdated
> > > and doesn't have BTF_LITTLE_ENDIAN/BTF_BIG_ENDIAN constants
> > > defined in
> > > libbpf.h.
> > >=20
> > > BTW, I tried -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF options and they
> > > didn't help. Maybe I'm doing something wrong.
> > >=20
> > > =C2=A0 [0]=20
> > > https://travis-ci.com/github/kernel-patches/bpf/builds/228673352
> > >=20
> > >=20
> > > $ make -j60
> > > -- Setting BUILD_SHARED_LIBS =3D ON
> > > -- Checking availability of DWARF and ELF development libraries
> > > -- Checking availability of DWARF and ELF development libraries -
> > > done
> > > -- Configuring done
> > > -- Generating done
> > > -- Build files have been written to:
> > > /home/andriin/local/pahole/build
> > >=20
> > > ....
> > >=20
> > > /home/andriin/local/pahole/btf_encoder.c:900:28: error:
> > > =E2=80=98BTF_LITTLE_ENDIAN=E2=80=99 undeclared (first use in this fun=
ction)
> > > =C2=A0=C2=A0 btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^
> > > /home/andriin/local/pahole/btf_encoder.c:900:28: note: each
> > > undeclared
> > > identifier is reported only once for each function it appears in
> > > /home/andriin/local/pahole/btf_encoder.c:903:28: error:
> > > =E2=80=98BTF_BIG_ENDIAN=E2=80=99 undeclared (first use in this functi=
on)
> > > =C2=A0=C2=A0 btf__set_endianness(btf, BTF_BIG_ENDIAN);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^
> > > ...
> > >=20
> > >=20
> > > >=20
> > > > Thanks!
> > > >=20
> > > > - Arnaldo
> > > >=20
> > > > commit aa2027708659f172780f85698f14303c7de6a1d2
> > > > Author: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
> > > > Date:=C2=A0=C2=A0 Tue Jun 8 00:50:13 2021 +0530
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 CMakeLists.txt: Enable SHARED and STATIC lib cre=
ation
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 CMakeLists.txt does not allow creation of static=
 library
> > > > and link applications
> > > > =C2=A0=C2=A0=C2=A0 accordingly.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 Creation of SHARED and STATIC should be allowed =
using -
> > > > DBUILD_SHARED_LIBS
> > > > =C2=A0=C2=A0=C2=A0 If -DBUILD_SHARED_LIBS option is not supplied,
> > > > CMakeLists.txt sets it to ON.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 Ex:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ cmake -D__LIB=3Dlib -DBUILD_SHARED=
_LIBS=3DOFF ..
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ cmake -D__LIB=3Dlib -DBUILD_SHARED=
_LIBS=3DON ..
> > > >=20
> > >=20
> > > [...]
> >=20
> > --
> >=20
> > - Arnaldo

--=20
Kind regards,
Luca Boccassi

--=-lWMhlaSJ+kovHpe6J6vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAmDD4PkACgkQSylmgFB4
UWJS5Qf+OdvJcBEkSr/F1Y8HFfWpyMZCaY2JW77iQUlomo+0ZhY/88RxDA9A0ue0
/iH0oFrO55Ea9phgwXhl5e3FvXA1gSjdGl7KisNBQX3ysuKiFqupeFi3I8uGHM+X
un1DeItJGwomry+vdpeaCr9vI06rtPp8f77PAY/MBAqmTj69BoNal7LAF72DBYV8
nPr617+6oPpIWjS8mjBR0rMXxi7+Gn0BiiNx4SSi73+F/4XsQo/pHiCDaWwD8EK8
weq85X/MOsgj7b0egvhybcI1iWJBayh4uBd51Jb5nXsab1P0W0MteMxdxYigbMVp
bXTW/5qXxLo02aeSsN0ymTGDgsgFag==
=fK4h
-----END PGP SIGNATURE-----

--=-lWMhlaSJ+kovHpe6J6vg--

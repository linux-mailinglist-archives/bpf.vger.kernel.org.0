Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24C83CBC33
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 21:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhGPTL1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Jul 2021 15:11:27 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:42765 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPTL0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Jul 2021 15:11:26 -0400
Received: by mail-wm1-f42.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso4047157wmm.1;
        Fri, 16 Jul 2021 12:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=NkFgFtynkKTZMf2iUxMKhrbM7aDHg3qx0QUIEWEyCzI=;
        b=kfQ2gE+HvZT2ozl0+EF7Fa/Z48OzyG8qlraBgKtbqhrkF9KuoCGt1lZFXZKhvF3yhq
         IEMY4etxor7wl64+5+OScP2ldNoAYvJsuSs0t2/NNngg1h0HR3VbOD7gDk0NjqxYd4Ji
         lNj48LH8C1lrAmhtrd5OEDW6FSCNl2vYtssz5H+dbcYkAj2f5NpI7nCH9gx6QKYdSz46
         xlWGY3rlFQyB6wKraScba4g+38j+FC6vx5yERy+NBh25YC2IjAHJ9cKKP7KrT3EN6C+o
         +yw7plT+o4fmOcUofr970o0ASOWX0G16juWKvxkjmPodOcxBFx3/06jSJP5KLRKbc/9y
         vzmg==
X-Gm-Message-State: AOAM5308r9L4gkUqnq7EbDAATW8/XROFvQvOy3ZHXZOvxoxqF7GWpp/h
        S6/VjFGu3bKch0WyHdI02H4=
X-Google-Smtp-Source: ABdhPJw6Fy+2MQig3ii02iKFw2vlOs2dpHZr/OSLtYBb1Xg4euc0dB0hHMe2Sad5KXjYvIO0VR5obA==
X-Received: by 2002:a05:600c:5127:: with SMTP id o39mr12001767wms.124.1626462510399;
        Fri, 16 Jul 2021 12:08:30 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id r4sm11226706wre.84.2021.07.16.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:08:29 -0700 (PDT)
Message-ID: <22b863ce92fb0f90006eee9a2a1bf82a7352cf1b.camel@debian.org>
Subject: Re: [RFT] Testing 1.22
From:   Luca Boccassi <bluca@debian.org>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Date:   Fri, 16 Jul 2021 20:08:27 +0100
In-Reply-To: <484bd96c1ae52516d54a5a45f2be108ee838f77a.camel@debian.org>
References: <YK+41f972j25Z1QQ@kernel.org>
         <20210715213120.GJ24916@kitsune.suse.cz> <YPGIxJao9SrsiG9X@kernel.org>
         <484bd96c1ae52516d54a5a45f2be108ee838f77a.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-uMvwAdHi6qfprzpzTgex"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-uMvwAdHi6qfprzpzTgex
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-07-16 at 14:35 +0100, Luca Boccassi wrote:
> On Fri, 2021-07-16 at 10:25 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jul 15, 2021 at 11:31:20PM +0200, Michal Such=C3=A1nek escreveu=
:
> > > Hello,
> > >=20
> > > when building with system libbpf I get:
> > >=20
> > > [   40s] make[1]: Nothing to be done for 'preinstall'.
> > > [   40s] make[1]: Leaving directory '/home/abuild/rpmbuild/BUILD/dwar=
ves-1.21+git175.1ef87b2/build'
> > > [   40s] Install the project...
> > > [   40s] /usr/bin/cmake -P cmake_install.cmake
> > > [   40s] -- Install configuration: "RelWithDebInfo"
> > > [   40s] -- Installing: /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+=
git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > [   40s] CMake Error at cmake_install.cmake:63 (file):
> > > [   40s]   file RPATH_CHANGE could not write new RPATH:
> > > [   40s]=20
> > > [   40s]    =20
> > > [   40s]=20
> > > [   40s]   to the file:
> > > [   40s]=20
> > > [   40s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.1ef8=
7b2-15.1.ppc64le/usr/bin/codiff
> > > [   40s]=20
> > > [   40s]   The current RUNPATH is:
> > > [   40s]=20
> > > [   40s]     /home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/=
build:
> > > [   40s]=20
> > > [   40s]   which does not contain:
> > > [   40s]=20
> > > [   40s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-1.2=
1+git175.1ef87b2/build:
> > > [   40s]=20
> > > [   40s]   as was expected.
> > > [   40s]=20
> > > [   40s]=20
> > > [   40s] make: *** [Makefile:74: install] Error 1
> > > [   40s] make: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarves=
-1.21+git175.1ef87b2/build'
> > > [   40s] error: Bad exit status from /var/tmp/rpm-tmp.OaGNX4 (%instal=
l)
> > >=20
> > > This is not a problem with embedded libbpf.
> > >=20
> > > Using system libbpf seems to be new in 1.22
> >=20
> > Lucca, can you take a look at this?
> >=20
> > Thanks,
> >=20
> > - Arnaldo
>=20
> Hi,
>=20
> Michal, what is the CMake configuration command line you are using?

Latest tmp.master builds fine here with libbpf 0.4.0. To reproduce it
would be good to know build env and command line used, otherwise I
can't really tell.

--=20
Kind regards,
Luca Boccassi

--=-uMvwAdHi6qfprzpzTgex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDx2SsACgkQKGv37813
JB7hFw//YLbbvnzMBqfp286beD1bekt4J803AaDQjlKPpx1eIXRrD3v2OeNeU6le
kEVfknwT+1Pmq/Ra4n2HGvHNZbiWw4IWZOmMCfV7fof/6J4ZCKZRaKTWqnCHcVAZ
7mJxwhJ/tVmOXZq2StQmClTkGRch4tRFn1UqmUM2G2PUbcRixrUDxiuisquKNi3D
aaTmYMPkurgHTrRdb6nwUn3q4DgIavR0t9+UREvPHRHTa5fOmAMKK0AI5nWvIVmT
l5Z4wDTkuiDJbT1DlpKX+5P8I5xCSYyrbHv880at5qkR2Im4NeLit2GeAPIKaSXf
5oHgEbllaCwnyvgn5gXMZvFobzXiI7HMdyVfRzHe5jGthk4lLDOJ88HWvXckKK7m
SWVc9VGvhajuJQkGGhRUbzyNuTQXgirDCIrfNAgw5M8fG1NANoDfvjI8CbYywSeJ
16fuky29zwUHZRZ6DUuWYOVXNgDt+kupJlaiQ5wbFWyLnHOnZz/bql5eARx4Zvt7
BWyAzg1QsmTgtpOjrf5nBI2PCjx/oAqI86BvYH37d53/A9fVDDLGvJ3DlcuklRYK
jexhNFVvQFUnRcyV6pCC1uG+T93LRoMeuXx0vi0gdzAjKST+ktlvUyrdXk4mWDbj
zpB2Y27O0azfGeDbFYgYFGYJomLaqxte4vxxF6wkiSMC6MuAlLc=
=fJSV
-----END PGP SIGNATURE-----

--=-uMvwAdHi6qfprzpzTgex--

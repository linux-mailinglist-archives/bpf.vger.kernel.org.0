Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3E13CB7ED
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 15:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhGPNiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Jul 2021 09:38:51 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42604 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbhGPNiv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Jul 2021 09:38:51 -0400
Received: by mail-wr1-f44.google.com with SMTP id r11so12127147wro.9;
        Fri, 16 Jul 2021 06:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=pyMQsdIK7X+BgKbuWFOosVqXAjhCWyckbMhV7eVWgvg=;
        b=sRVFiOe3Ghf9uWItAw4zBo5zZpUEy4Q3+7SiwFDYo4PLT3rb4Ppm4VseBccFm/IgG1
         bWlKPX6bjH13ekCVg4V6GRcJwt7UjueSyvDqFVp2033+nyP80YZjjdLi3D2WGsILSyn+
         Imsp8xUE2fWs2XNFsn9Ye+d10BatK3Z9dDYx2Tv79dRT5EhRHs/l1hTadVm2wH2AfPCz
         l7042lQ5a86CRRuLJaO7t30P3iubNqF1HI1T4DVj6sgU34EU7EF9MnUbm4B7e9Tme1Cn
         i/ZzVxhZNGmHu1qRCqAgKe32L7l5e8+IHkhr1U3G4hanbEBPOG//xE3OHfcqGBeQPo7T
         pczg==
X-Gm-Message-State: AOAM533Kj0RMnWyWWfTOVLX0ccKbULahE98wLkQ9PPthhdC/H/uBJSkZ
        a1Lz6+NJeIsvCDMiej2i6uA=
X-Google-Smtp-Source: ABdhPJwFnhYLVcMIrZIiC7iiI+5vCO5Tam653yCKJFh2fUFLEM/LRllrYN9JQjGvoE1+FjhEWGlWFg==
X-Received: by 2002:adf:fc50:: with SMTP id e16mr12653828wrs.31.1626442554747;
        Fri, 16 Jul 2021 06:35:54 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id 139sm9285223wma.32.2021.07.16.06.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:35:53 -0700 (PDT)
Message-ID: <484bd96c1ae52516d54a5a45f2be108ee838f77a.camel@debian.org>
Subject: Re: [RFT] Testing 1.22
From:   Luca Boccassi <bluca@debian.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Date:   Fri, 16 Jul 2021 14:35:51 +0100
In-Reply-To: <YPGIxJao9SrsiG9X@kernel.org>
References: <YK+41f972j25Z1QQ@kernel.org>
         <20210715213120.GJ24916@kitsune.suse.cz> <YPGIxJao9SrsiG9X@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-suhOP6HetBHA5lCAGqi0"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-suhOP6HetBHA5lCAGqi0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-07-16 at 10:25 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 15, 2021 at 11:31:20PM +0200, Michal Such=C3=A1nek escreveu:
> > Hello,
> >=20
> > when building with system libbpf I get:
> >=20
> > [   40s] make[1]: Nothing to be done for 'preinstall'.
> > [   40s] make[1]: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarve=
s-1.21+git175.1ef87b2/build'
> > [   40s] Install the project...
> > [   40s] /usr/bin/cmake -P cmake_install.cmake
> > [   40s] -- Install configuration: "RelWithDebInfo"
> > [   40s] -- Installing: /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+gi=
t175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > [   40s] CMake Error at cmake_install.cmake:63 (file):
> > [   40s]   file RPATH_CHANGE could not write new RPATH:
> > [   40s]=20
> > [   40s]    =20
> > [   40s]=20
> > [   40s]   to the file:
> > [   40s]=20
> > [   40s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.1ef87b=
2-15.1.ppc64le/usr/bin/codiff
> > [   40s]=20
> > [   40s]   The current RUNPATH is:
> > [   40s]=20
> > [   40s]     /home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/bu=
ild:
> > [   40s]=20
> > [   40s]   which does not contain:
> > [   40s]=20
> > [   40s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-1.21+=
git175.1ef87b2/build:
> > [   40s]=20
> > [   40s]   as was expected.
> > [   40s]=20
> > [   40s]=20
> > [   40s] make: *** [Makefile:74: install] Error 1
> > [   40s] make: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarves-1=
.21+git175.1ef87b2/build'
> > [   40s] error: Bad exit status from /var/tmp/rpm-tmp.OaGNX4 (%install)
> >=20
> > This is not a problem with embedded libbpf.
> >=20
> > Using system libbpf seems to be new in 1.22
>=20
> Lucca, can you take a look at this?
>=20
> Thanks,
>=20
> - Arnaldo

Hi,

Michal, what is the CMake configuration command line you are using?

--=20
Kind regards,
Luca Boccassi

--=-suhOP6HetBHA5lCAGqi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDxizcACgkQKGv37813
JB77SQ/+IwHjStCuGfwY0xeyAjV79KSHBJdaMFKFqJDHQxJcnJfrzzRlETbCLoM0
E60aVpssvuevVFfCSuFfW1lHC3M0pCTdGWB6UsfTQNwKIQa67dEAjRIhpQ5d9zh/
K77VepTHzI58S/BhW86dXWs3SDB9qALkXYns0xU/+MeyDi30YXc/fya2X1V7hUh3
disWFhNs7lVH3Pftd/4Zx0LldpJq9tdvARv5OL7P47xXTnyaJ0MhKwTL58+Z9Z8s
2HB+BskU3YOPPmGTA1dzNF7OwUy4m/383i2bEQRhm4HJl0ThirzATxh8WjQLiQg/
KAeXo97UXJYdpaxI6abysQV1piU9vgJNtBS+2ESupJDfsTrcB9yNealxgbR6uMkR
HNAFMAYOyIwmONZMiu+RCvVaJRKBqSbfbmYc2r3M/4QdN1flFqbcIdYrH64dvvQm
6V+EyPEZO3UkcgxhrROJDtf9ZTwHRFjxMwIH9tHzvyzreNMQgdKPBVEbi4kUsQIS
NZqOYFUmRnXD5+hoa8n2f50HSJFY2iNVTJulo9joqN9jTgbqrMfJzydvkveuQ4Gr
rKerCdPSVsd/y+jsJKycgxIuOVHDc1hLKwttDQ0gnS7o2PuDAjUZTqj3s/kBXaJ1
W/kfreG4E0CfQSlIO/Xvj5iw5rz8ecTv15Hc/4SE2HKOlOazzig=
=3Ugo
-----END PGP SIGNATURE-----

--=-suhOP6HetBHA5lCAGqi0--

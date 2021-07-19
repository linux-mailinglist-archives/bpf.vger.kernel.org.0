Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2933CD461
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhGSLaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 07:30:17 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:47084 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhGSLaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 07:30:16 -0400
Received: by mail-wm1-f49.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so10345660wms.5;
        Mon, 19 Jul 2021 05:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=koZGbvFEAM16s+N6Y1AQXIw+Wb77ZNvF/MPR2LgApCQ=;
        b=Lmoc9SXsQafpvoUZPj+uTJjY4/8JuoA7tkdZmYb8SUtom0B0+OzdvnuObOKVLO9SOV
         pQvKOaqw0DvTADeGW8f3o52YTESZRw+zEE8RIz4JclJSQZOgNwfmHTEG9cn7zEdqPFjC
         45sNraJkI6ZRfdwvGmF0nOAtWhc8OtWYV3Wrv523iw2Xnt1rbecGaGXk+YJ3HEfrFmTc
         K/otRxwHZQWsy7Vm8OwVJvpVYNI/XVe0S8LkI3Ka/bDWIkopfiXNZSEA9J6odkoS9hRl
         9NrCcxNTX3CIbqQGTEDo56aomJT4FBRoLk2V+ZhQD+3TSvEXsv3DMHXPLBtoh1s+Ie8t
         kOUw==
X-Gm-Message-State: AOAM533RCkLzaCb5mDjyoaznTRGD7z+AvyGwI8dCuhS2PhyPAmndSm6r
        gkaertWGrxgYUdUy03Lm/gk=
X-Google-Smtp-Source: ABdhPJw9Y/urcJU/xrpSehyrLFKkjLKQECxj2h9MLrNdnn/hWFPksrxe4r8vAqjHGJpRyL+FM6yIbw==
X-Received: by 2002:a7b:c099:: with SMTP id r25mr31037211wmh.127.1626696654654;
        Mon, 19 Jul 2021 05:10:54 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id x9sm20309526wrm.82.2021.07.19.05.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 05:10:53 -0700 (PDT)
Message-ID: <d5b963695314f66240b96f5699a78f0d980a0b44.camel@debian.org>
Subject: Re: [RFT] Testing 1.22
From:   Luca Boccassi <bluca@debian.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Date:   Mon, 19 Jul 2021 13:10:52 +0100
In-Reply-To: <YPGIxJao9SrsiG9X@kernel.org>
References: <YK+41f972j25Z1QQ@kernel.org>
         <20210715213120.GJ24916@kitsune.suse.cz> <YPGIxJao9SrsiG9X@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-/UdReZxmDh41D16oROIk"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-/UdReZxmDh41D16oROIk
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

Arnaldo, just to give you a quick summary and close the loop in case
you haven't followed the (very verbose) thread: the root cause was a
packaging issue of libbpf in SUSE, which is now solved, and the
reported build problem is now gone:

https://build.opensuse.org/package/show/home:michals/dwarves

--=20
Kind regards,
Luca Boccassi

--=-/UdReZxmDh41D16oROIk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmD1a8wACgkQKGv37813
JB57MRAAzOr0Kmg0Y4RhkaQPEhOS44c84oXllGq1rdjM8O2NQnDtV/fWO8aOw1K9
rKeabzNMP2JOy5zBCzTlpITHun/v/2XidNvlU6aUrWxpxjhMuwFjR+vP9S8T7BO6
+8wt8gnd/Z/UeMcp37gYF1GfjKMCh/vDwxdR4faLskwWtKDPv8WmjyYvpb8dpgxu
+3j22nCKV1q1ixyyofXaFWZ90jgKF3GdpCROHSfjlD8F0CgB3pfLRLgS9QX9vv6S
U0PnzotFxTSi0OmK/urEWFabxTC+2crrIxO04zAhVROp7EjWXTgGjnrSMJkI5/tj
i5rh5mO1YRY+f/CFKfrfjnfIKbKfslNayUKhKVojzsnye0WXhNkSMQAtqc8tzq3x
F/z0Co5LF3OpGyyStfWjTpQ9tEgGyQZebPDX5SqMxwE35WqHqotfhYnDJngmvFU3
QIn1+PKOxMJ2dvmidIpyhgeZ6rBrjr/vZ4zQ40Wpf5U+dr5rVIfWMfHDLKzFdWmp
kFvJGTmniD7vk9IbdnMANMMZZSfA6xCkWjhlkP7pQl0hAyE4eWk51YMoj4WFibC1
K5SjfmNdwpoH5QbmwF7VtLntD9JOX3wNOCKLT3X+85Fpi7bwL2UJ0kF4jCGUCZqA
HEycPWc0uMmFo6ei3xTMkAjEkP/NC5wDRKuRH2F2cT6Z4quKTwE=
=tV80
-----END PGP SIGNATURE-----

--=-/UdReZxmDh41D16oROIk--

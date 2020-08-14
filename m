Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8B4244FCB
	for <lists+bpf@lfdr.de>; Sat, 15 Aug 2020 00:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgHNWRu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Aug 2020 18:17:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40848 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgHNWRt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 Aug 2020 18:17:49 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <benh@debian.org>)
        id 1k6i1A-0007Ml-V8; Fri, 14 Aug 2020 23:17:45 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <benh@debian.org>)
        id 1k6i1A-002J3r-I7; Fri, 14 Aug 2020 23:17:44 +0100
Message-ID: <ebf711740484b0a489f11b749d0f00d30be5a5b1.camel@debian.org>
Subject: Re: [PATCH] bpftool: Fix version string in recursive builds
From:   Ben Hutchings <benh@debian.org>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, debian-kernel@lists.debian.org
Date:   Fri, 14 Aug 2020 23:17:39 +0100
In-Reply-To: <1c00ee1f-5103-e8ec-7953-e09a1c0de707@fb.com>
References: <20200813235837.GA497088@decadent.org.uk>
         <1c00ee1f-5103-e8ec-7953-e09a1c0de707@fb.com>
Organization: Debian project
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-EZbJgUeGIM8jJ4u2zgBn"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: benh@debian.org
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-EZbJgUeGIM8jJ4u2zgBn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-08-14 at 08:43 -0700, Yonghong Song wrote:
[...]
> I tried the following
>=20
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -25,7 +25,7 @@ endif
>=20
>   LIBBPF =3D $(LIBBPF_PATH)libbpf.a
>=20
> -BPFTOOL_VERSION :=3D $(shell make -rR --no-print-directory -sC ../../..=
=20
> kernelversion)
> +BPFTOOL_VERSION :=3D $(shell MAKEFLAGS=3Dw make -rR --no-print-directory=
=20
> -sC ../../.. kernelversion)
>=20
> -bash-4.4$ ./bpftool version
> ./bpftool v5.8.0
>=20
> I set env variable MAKEFLAGS=3Dw, and build bpftool it works fine too.
> Maybe I miss something or debian changed top level Makefile?

Yes, but we don't change MAKEFLAGS or any of the logic around quietness
or verbosity.

I assume there are other factors involved, as I've also been unable to
construct a simple reproducer.

Ben.

> I am testing against latest bpf tree.
>=20
> >  =20
> >   $(LIBBPF): FORCE
> >   	$(if $(LIBBPF_OUTPUT),@mkdir -p $(LIBBPF_OUTPUT))
> >=20
--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS teams

--=-EZbJgUeGIM8jJ4u2zgBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl83DYMACgkQ57/I7JWG
EQn4MRAArfzuHq272rYNAWm/zmGrzI+X0JUQt41K7BeVvmxvsPpfdNguJb6fWM+6
R6dq0MXRC+W8wNB5xIWwzJOu5MPRlRsp+K4uuzzdeuvYBcrtabnGXUXBZoJQrSM8
ET65PpZ5IcDwf+0bK5ho4TG7L4TdxIDXK7RDR3dO4xOvLuGYFyXdP43Pv0hbUTpg
k+13L6KmRERP6KdH8hW1U+XDkzYdisQpDLML9vQpb7rIpRvC6Xtklsq3jm9tIcK4
iMwTUEGXpW5/L0AS1do44w62nH0aBwK2JXm6mGjo0R+/gMFJyDf2dF8x/U4nML56
J2UGhQQZgVTpBd3pkq413jdQn4zD27zDOeG3X9TUjq+DTQ7dYxamjsPdjAAJWE1O
xmps3rtrzpUtvg/N3qflSLB34YBiwUQ/7+N3/h5m6qsTgchNKFlOyCPDK5rx02kZ
TiLNGgKXsrUO3iHLjF4Lh3yuUTJdj0OHudW6jFwIvim8iZcp8Z/GqOZWJoMlE6fZ
td4KKTgIlsWqIWyrgdCyhju2On7Jvp7XvQc+OqOmi9oIrjDJszMG8K46DriHPbO1
6uUBrx4bTkOUw9EZWZs7eUTXWu258ZzIPOdyzEQmSndU5CRnd4yZnXBu21WfX0PL
gE/aY6MUdN4nrddUCFeqVP1MNQFE697ISoPO/1jlxAcUgXAqISA=
=aLe4
-----END PGP SIGNATURE-----

--=-EZbJgUeGIM8jJ4u2zgBn--

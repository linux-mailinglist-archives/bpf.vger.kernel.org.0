Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BFB575067
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiGNOKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 10:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiGNOKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 10:10:19 -0400
X-Greylist: delayed 2660 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 07:10:18 PDT
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335654A81C;
        Thu, 14 Jul 2022 07:10:18 -0700 (PDT)
Received: from [91.187.115.177] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1oByqp-0000X2-IP; Thu, 14 Jul 2022 15:25:55 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1oByqn-004wFW-2Z;
        Thu, 14 Jul 2022 15:25:53 +0200
Message-ID: <5afd3b45e9b95fa5023790c24f8a1b0b4ce1ca7c.camel@decadent.org.uk>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
From:   Ben Hutchings <ben@decadent.org.uk>
To:     sedat.dilek@gmail.com, Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 14 Jul 2022 15:25:44 +0200
In-Reply-To: <CA+icZUVDzogiyG=8sCuxdW4aaby_kRwToit2tg-A4D3VorVKnA@mail.gmail.com>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
         <20220703212551.1114923-1-andres@anarazel.de>
         <CA+icZUVDzogiyG=8sCuxdW4aaby_kRwToit2tg-A4D3VorVKnA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-OgXkSgMMXMfCDQQ6En6D"
User-Agent: Evolution 3.44.2-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.187.115.177
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-OgXkSgMMXMfCDQQ6En6D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-07-14 at 11:16 +0200, Sedat Dilek wrote:
> On Sun, Jul 3, 2022 at 11:25 PM Andres Freund <andres@anarazel.de> wrote:
> >=20
> > binutils changed the signature of init_disassemble_info(), which now ca=
uses
> > compilation failures for tools/{perf,bpf} on e.g. debian unstable. Rele=
vant
> > binutils commit:
> > https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3D60a3da0=
0bd5407f07
> >=20
> > I first fixed this without introducing the compat header, as suggested =
by
> > Quentin, but I thought the amount of repeated boilerplate was a bit too
> > much. So instead I introduced a compat header to wrap the API changes. =
Even
> > tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json,=
 imo
> > looks nicer this way.
> >=20
> > I'm not regular contributor, so it very well might be my procedures are=
 a
> > bit off...
> >=20
> > I am not sure I added the right [number of] people to CC?
> >=20
> > WRT the feature test: Not sure what the point of the -DPACKAGE=3D'"perf=
"' is,
> > nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are al=
so
> > in feature/Makefile and why -ldl isn't needed in the other places. But.=
..
> >=20
> > V2:
> > - split patches further, so that tools/bpf and tools/perf part are enti=
rely
> >   separate
> > - included a bit more information about tests I did in commit messages
> > - add a maybe_unused to fprintf_json_styled's style argument
> >=20
>=20
> [ CC Ben ]
>=20
> The Debian kernel-team has integrated your patchset v2.
>=20
> In case you build without libbfd support there is [1].
> So, feel free to take this for v3.
>=20
> -Sedat-
>=20
> [1] https://salsa.debian.org/kernel-team/linux/-/blob/sid/debian/patches/=
bugfix/all/tools-perf-fix-build-without-libbfd.patch
[...]

Thanks, I meant to send that fix upstream but got distracted.  It
should really be folded into "tools perf: Fix compilation error with
new binutils".

Ben.
>=20

--=20
Ben Hutchings
Always try to do things in chronological order;
it's less confusing that way.

--=-OgXkSgMMXMfCDQQ6En6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmLQGVgACgkQ57/I7JWG
EQnUjBAAk2XI7hNjRozbY7yy+c7k2alNVHWewYw9eUYYJ/2tSIMWsZuerXn0V7iT
iUEDDd2CVlSSWiSrUHOHimsNjfsDlUtQ+Ev4pc+D83czOWFibs3n4qfixLsE2MFM
dUXatRQVLgYCJzAvEZnsRK1rAMAbwhh6F1lZGPu+qBN10qDbUOIUnzpEcv4KOhb4
yLEG1dLHNTO1L2N11xkG2OyDQTUhZxUetEwvmV7LikaA8zXfEpF2O1DNFVdgw3zI
T0TzpQEvxaPgEcGd2PxFH034gNajsq9WkkiTdXBSGAF0XRkgPQP+LKoQKFc7RkGj
E01IFeR+DuJVgf6J0YlrQYM23TuJOz4VKVjbbLUFgRqeBC5CQTKvE79jbQSmDZhm
7QPfcOyRMAJ/FeGDuo8gn9S+9iIWJN8lJ+2RXMv0oT2wvyVF7C292mhAUecz5pmy
Q/50PBWq3DCDEW8ILlWxqOBI7HeboygjznfEbubJtom13HYCwETUYjxIUdL/duLH
6/MoktNcrC8XXCttBaFdLO9Ylp7z1w2hDB4+6Trz4y8uitQnJP2hNwxuhsb9clYh
/fAxsXWPL45QAXMsAQMcWy+ciFaO7nEeTqcWgnj3O29htS72HgOkcdKTtNUp0enI
OJrsQpLJlAa/4EbpLjtCPDDmDwrtGhlInE3P7mBhWf3iNuCP7Dk=
=ReGY
-----END PGP SIGNATURE-----

--=-OgXkSgMMXMfCDQQ6En6D--

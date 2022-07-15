Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E0E576742
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiGOTSh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 15:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGOTSg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 15:18:36 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7560506;
        Fri, 15 Jul 2022 12:18:35 -0700 (PDT)
Received: from [91.187.115.177] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1oCQpc-000793-9X; Fri, 15 Jul 2022 21:18:32 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1oCQpb-0058Ah-1E;
        Fri, 15 Jul 2022 21:18:31 +0200
Message-ID: <60c84caf421d831ce6661c60503c1c56ef55e0ce.camel@decadent.org.uk>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Andres Freund <andres@anarazel.de>
Cc:     sedat.dilek@gmail.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Date:   Fri, 15 Jul 2022 21:18:26 +0200
In-Reply-To: <20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
         <20220703212551.1114923-1-andres@anarazel.de>
         <CA+icZUVDzogiyG=8sCuxdW4aaby_kRwToit2tg-A4D3VorVKnA@mail.gmail.com>
         <5afd3b45e9b95fa5023790c24f8a1b0b4ce1ca7c.camel@decadent.org.uk>
         <20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-mSANknzUMiXSAkb0/rhn"
User-Agent: Evolution 3.44.2-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.187.115.177
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-mSANknzUMiXSAkb0/rhn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-07-15 at 12:16 -0700, Andres Freund wrote:
> Hi,
>=20
> On 2022-07-14 15:25:44 +0200, Ben Hutchings wrote:
> > Thanks, I meant to send that fix upstream but got distracted.  It
> > should really be folded into "tools perf: Fix compilation error with
> > new binutils".
>=20
> I'll try to send a new version out soon. I think the right process is to =
add
> Signed-off-by: Ben Hutchings <benh@debian.org>
> to the patch I squash it with?

Yes, OK.

Ben.

--=20
Ben Hutchings
Unix is many things to many people,
but it's never been everything to anybody.

--=-mSANknzUMiXSAkb0/rhn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmLRvYIACgkQ57/I7JWG
EQn0Jw//UXpZFfBVI3IopQFG3f+rCI9Nc7QeIdIH4GlTfJVyZgFquHHWtkc63WRx
f7UvUQn1NyKTk72RBKFDIwWhJ1gEocdRrdHFvnYAADjDV5WhuObdfm3kC5V6EWKo
h39XJsxvmRrvQUThrxq3JNCzqFZJ1e/4cwT1kAPeCYbUINZ3cMquc4oSXqHIJse3
wtJ/dF73IiMhda6RkLPUTjQ5MBOrQoXMnp9gGwxp8UCiyWZ5+1LNolouGYLJUUGr
fAYdKDzHyQwEbSMACyOEi9mW1IvuakxccKhE5u+RS1E5TJAmaVH681HuqXaLOHMm
h1FNljqGyNPvQ08dTEtspVfY2XwHtJZFtWwulRki5MpMLmQBgSg3rY0mzSEfQB1O
K8C3po2ZM7/djGpn1hGyKX5qcfOEA7UXxFn8PJtO7AKkxWblQrj3I7RzHOd3oTe7
zwdZNF1F3QEw8C371T/CkHmism+aB2qV+FzfyNaen6tk5hUGHbt2NWXDzEIQHYFU
lufYapsbBNkNGnZVz68N4A5anysNV5Mxb7So7n3fHfvEJdmWzxwAKvX1ixfaEZaX
tNm0KOudouKoxqSNZDFeXby8WAff3R2pJyWmlqwWx5RIlVWnOAHyguuQvq6O7d3+
gqVxDU6LsjjNSg0eImU6LDd2bMKnAtj0TE+YUKHxihlQ+r5b79Q=
=mawm
-----END PGP SIGNATURE-----

--=-mSANknzUMiXSAkb0/rhn--

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91375650E21
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 15:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiLSO6h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 09:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiLSO6Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 09:58:16 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA66103E;
        Mon, 19 Dec 2022 06:55:12 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.64]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsaeR-1oslfq133D-00tyIB; Mon, 19 Dec 2022 15:44:53 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id A7FAB3C1B9;
        Mon, 19 Dec 2022 15:44:49 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 711B377B; Mon, 19 Dec 2022 15:44:38 +0100 (CET)
Date:   Mon, 19 Dec 2022 15:44:38 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/5] tools lib subcmd: Add dependency test to
 install_headers
Message-ID: <Y6B41hsv1KHDQMYh@bergen.fjasle.eu>
References: <20221202045743.2639466-1-irogers@google.com>
 <20221202045743.2639466-4-irogers@google.com>
 <Y5eVwlId2A2/pN40@fjasle.eu>
 <CAP-5=fXeYsOs-YJH+hx=haGwJ_eqDNXYQQ30AiyDDfc5P2o84Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="keRu1ywOaLNQdaoA"
Content-Disposition: inline
In-Reply-To: <CAP-5=fXeYsOs-YJH+hx=haGwJ_eqDNXYQQ30AiyDDfc5P2o84Q@mail.gmail.com>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:yl11gYBxldkrWBmMWqPPZ7dMxGlIZugrpEYUIRHh38u8ZimLr8b
 1zTL5CA03GKrLX5KddnhDPuoCpPPCg+XKi/89LoG0aHPG00VlmGn/jQV3VjU1FEc4f6/ABR
 jsQKfhRcYUBTk0oCwwjJI68WUTsXD6fXYAmi610sEyBVz3cb9ONljYGLMYEhu2tGphMNhD7
 bstfVrPwf9h8u+5BFyLGQ==
UI-OutboundReport: notjunk:1;M01:P0:GHm+LHFQNqM=;mbXxJ8TCl6plJc3uEROHGtH5QWS
 ohcK7K8aIm9/1DEoWLoqekUocP4s9FK9CGV4HA77xIclj+OJXXiXRjA6ABAY9IPeU59ZZL7lw
 45+9Y+kwa8v7RXP9Qr0bjykHxKXmHUPFYKpGfugcCylUBfRxMKjYdB01RVeA1bongbHK35cOO
 lh61W1x8L66izMQSP+DhE/KAjcac/4RDTPryPN7sxORT/gCGJVrSWF8hSaxjB1OAoO1dUWPfo
 bw8Vl9ZnIudAkhqRH99kN5wL/81yB56IjG6eNwc/eASdZov95NkMWArTEY647JbsnV7aUnPMI
 G2TMcqMoNSu8teietwr5yJGeWYAYz/eRG7An37WNzdAC6GzTTMaDF05bY29hGxipWtYGR0Nnh
 8jZ6h3Zh0nWhdgCbog1GBMLTb1HfpCmxB/myZVhB/6UbUZm6LFn8cA98+18aJvccmtkJNjWHF
 0fZ6nMhmzdH/LS/lyy+Dg4svw2ESUSHJSPGNhRWZzx3f3zEHfCl/LbM6th/BKIdfdoaIo4Gmj
 cC08goRSqAvozbO4clExazOPUgAOGfKYRZiS5G9EBgJMt8QqTlHb5tJDnLct9dbvXtOa6ScpH
 MkxjNDHKo1hexGbyn+ar9rK7Pgk159Zv4Ij4uAu4Xxq3BlVdX6oLNy1iq7CVO4GxXj00ciucA
 cw2LTJiz6kGQPdxaslNpEWG7i4kCB5494Khzbc2RQg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--keRu1ywOaLNQdaoA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 13 Dec 2022 13:28:21 GMT, Ian Rogers wrote:
> On Mon, Dec 12, 2022 at 12:57 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
> >
> > On Thu, Dec 01, 2022 at 08:57:41PM -0800 Ian Rogers wrote:
> > > Compute the headers to be installed from their source headers and make
> > > each have its own build target to install it. Using dependencies
> > > avoids headers being reinstalled and getting a new timestamp which
> > > then causes files that depend on the header to be rebuilt.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/lib/subcmd/Makefile | 23 +++++++++++++----------
> > >  1 file changed, 13 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> > > index 9a316d8b89df..b87213263a5e 100644
> > > --- a/tools/lib/subcmd/Makefile
> > > +++ b/tools/lib/subcmd/Makefile
> > > @@ -89,10 +89,10 @@ define do_install_mkdir
> > >  endef
> > >
> > >  define do_install
> > > -     if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
> > > -             $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
> > > +     if [ ! -d '$2' ]; then             \
> > > +             $(INSTALL) -d -m 755 '$2'; \
> > >       fi;                                             \
> > > -     $(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
> > > +     $(INSTALL) $1 $(if $3,-m $3,) '$2'
> >
> > What about using '$(INSTALL) -D ...' instead of the if-mkdir-block abov=
e?
> > (E.g. as in tools/debugging/Makefile.)
> >
> > Kind regards,
> > Nicolas
>=20
> Thanks Nicolas, the reason was to keep the code consistent. That's not
> to say this is the best approach. For example, here is the same thing
> for tools/lib/api:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools=
/lib/api/Makefile?h=3Dperf/core&id=3Df43368371888694a2eceaaad8f5e9775c09200=
9a#n84
>=20
> If you'd like to improve this in all the versions and send patches I'd
> be happy to take a look.
>=20
> Thanks,
> Ian

Ian, while watching at tools/lib/*/Makefile I stumple across the=20
special single-quote handling (e.g. 'DESTDIR_SQ') several times. =20

Top-level Makefile and kbuild are not designed to work with file or=20
directory names containing spaces.  Do you know whether this is needed=20
for the installation rules in tools/lib/?  I'd like to remove support=20
for path names with spaces for a increasing simplicity and consistency.

Kind regards,
Nicolas

--keRu1ywOaLNQdaoA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOgeNUACgkQB1IKcBYm
EmmqvBAAvc+hpUNMRLt4cfWfIA2KsbSBDQLjh+dWIF4bhH9lSOuSlfmwlYSaCjpG
r656tEHGAS2oYr12RNBwDa7Rpl8M0XycHyCO39PmsUrjFDNlIrsIclhYo++9X+9G
iJJIzy8fsBAW3apLVOv3sPnzMcv6jPj8QD4nQXtgAqBy1Nj798t416TC9gkd6ZXC
ZBYbV2d6I4EtIbD24IK5eptBObyjSU1WlsZRlLq60JCMNjXTszsBTmN+qi91bZs0
cctgVxhXxkB0d75w3KWHXKSbbAHurLtmIjzZMJEI3f+o+ptEwOWiP/+Sk3NXu7JX
udi4vKNCX4TXXf3cOUmhKqGigaYpbCn4drPCa4r0kmdE7zkCeGtEuNLs8ocItiOS
fRsxU9bTXcC/7Ox0DqX1/qBYQgHBmbF5eXqAg4UerAn4/8l4fxdXemeO/LwNVpGC
Pkmioif0PU4wZFU27qzOqKnjgKfioLh8qLgXmTPMo8Hq7c62ytA/A35Hcn9ZEE/X
e9F8Kg734p1LUHPTrpCfOg3Q3X0t9c2ra+4wBa8d7zhOWhFFfQDjsaIuoe8ZiSqv
ZITXn7XySp/0sjot8HyO0a9bIZvR5RK9OfEayShgLuLIkd5yoByEjz551oh5I753
KyeIgi+OMvO56V0n0kd2rh4O5E4IggpGJbjvG+KO4uY9L1DYYcU=
=DYaH
-----END PGP SIGNATURE-----

--keRu1ywOaLNQdaoA--

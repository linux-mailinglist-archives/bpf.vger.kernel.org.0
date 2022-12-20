Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DDF651BCC
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 08:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiLTHlA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 02:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiLTHk6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 02:40:58 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED0F72;
        Mon, 19 Dec 2022 23:40:49 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.99.43]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXop2-1pNwzJ3lO8-00YAcI; Tue, 20 Dec 2022 08:33:58 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 0FC3A3C0EE;
        Tue, 20 Dec 2022 08:33:52 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id A79D423F; Tue, 20 Dec 2022 08:33:50 +0100 (CET)
Date:   Tue, 20 Dec 2022 08:33:50 +0100
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
Message-ID: <Y6FlXj2IT/5ruI/j@bergen.fjasle.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iTsQL20z2LG4ZgZl"
Content-Disposition: inline
In-Reply-To: <CAP-5=fXX5RsCFvGy2_CBYJczauWVemSRB=Bz3nDQ9iufuAXyHg@mail.gmail.com>
 <20221202045743.2639466-4-irogers@google.com>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:olVMs0MvHTcPOd+l3DsTa5pBjm+dogUdGH44zkKe9/7m2zeuAiX
 Tb4h6bKxmRzUqf9MEUYwvde7kUrQjhoHgyotiak1j66PXYPzYY5lO43ZaXtx0WXJ5Y1/J17
 5DWQZqI/kzo9Wv86erKvk27BndkmA1VjA3mwBfBD0G1oZQUoIYwKiELsog5ldjTNahmbLqa
 v7Z43zcCPCh64Puv9GUaQ==
UI-OutboundReport: notjunk:1;M01:P0:sMiFDohd1Wo=;SbjFRhEBbe8SUFWXQv+3apLh4HM
 PgkXMwlVw85ZSgTWUTzxD5qRW9l832uGEpmoGFo88bfWYAGYyhww/2W23pg4I2aJEphInDVON
 n9DUpTkWLesuzw4q7gbO6qaTcntUSkkTNxWf59LEuActoF3EIS9DfWWPR5wzaL19yz5XeeLju
 xOdna8Co55800qnui7iAexTCvf+347f4YzrxDnb0S4P8yRImKyBcux1LPNt//H1GIMUxaAdKi
 3wwC6bJBplW5+tSHLtQbzFNBLT8WET6xgb0678bh33Zvz+avtukApSmwjxV61ErCADSHw3VUr
 e1wjCyFXeOoS3BxhElN6yzDkG3shq6vJAAX3OMPhyafu4yX0o3BsFXVuBY1sPvnqQy/jXN4U0
 w+1Uk7oB6OV+Syv7S36ZTYgCkGMRW0gT1hudac15dqHnpwzTunLN046odYABGDlkIi+njmBxv
 EW1evOCjaTOBMoRpqceeEl7GLI9rIv2E0r2tVhzOTEoV6ZKdxBw8lSWNErozmJhAA1aF5OM1S
 sQ387/XoFrHBNTWLprZO96GO6AzPG0JqoRkVnJw3fUxWdS0jvtM+VsgxtpncmYSmcIpuzBPbn
 sVqwWjXdqQd3UWwpU3WgNiDJc7+eOS0rb6KcwScD6YMvcLr1tYe3TZZsxHTmpGTeCmpHMqwpI
 W0aqWzvmMV9JHPif3SNmpkanM7250nehlwimwiEBYA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--iTsQL20z2LG4ZgZl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 19 Dec 2022 14:48:59 GMT, Ian Rogers wrote:
> On Mon, Dec 19, 2022 at 6:44 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>=20
> > On Tue 13 Dec 2022 13:28:21 GMT, Ian Rogers wrote:
> > > On Mon, Dec 12, 2022 at 12:57 PM Nicolas Schier <nicolas@fjasle.eu>
> > wrote:
> > > >
> > > > On Thu, Dec 01, 2022 at 08:57:41PM -0800 Ian Rogers wrote:
> > > > > Compute the headers to be installed from their source headers and
> > make
> > > > > each have its own build target to install it. Using dependencies
> > > > > avoids headers being reinstalled and getting a new timestamp which
> > > > > then causes files that depend on the header to be rebuilt.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/lib/subcmd/Makefile | 23 +++++++++++++----------
> > > > >  1 file changed, 13 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> > > > > index 9a316d8b89df..b87213263a5e 100644
> > > > > --- a/tools/lib/subcmd/Makefile
> > > > > +++ b/tools/lib/subcmd/Makefile
> > > > > @@ -89,10 +89,10 @@ define do_install_mkdir
> > > > >  endef
> > > > >
> > > > >  define do_install
> > > > > -     if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
> > > > > -             $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
> > > > > +     if [ ! -d '$2' ]; then             \
> > > > > +             $(INSTALL) -d -m 755 '$2'; \
> > > > >       fi;                                             \
> > > > > -     $(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
> > > > > +     $(INSTALL) $1 $(if $3,-m $3,) '$2'
> > > >
> > > > What about using '$(INSTALL) -D ...' instead of the if-mkdir-block
> > above?
> > > > (E.g. as in tools/debugging/Makefile.)
> > > >
> > > > Kind regards,
> > > > Nicolas
> > >
> > > Thanks Nicolas, the reason was to keep the code consistent. That's not
> > > to say this is the best approach. For example, here is the same thing
> > > for tools/lib/api:
> > >
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/too=
ls/lib/api/Makefile?h=3Dperf/core&id=3Df43368371888694a2eceaaad8f5e9775c092=
009a#n84
> > >
> > > If you'd like to improve this in all the versions and send patches I'd
> > > be happy to take a look.
> > >
> > > Thanks,
> > > Ian
> >
> > Ian, while watching at tools/lib/*/Makefile I stumple across the
> > special single-quote handling (e.g. 'DESTDIR_SQ') several times.
> >
> > Top-level Makefile and kbuild are not designed to work with file or
> > directory names containing spaces.  Do you know whether this is needed
> > for the installation rules in tools/lib/?  I'd like to remove support
> > for path names with spaces for a increasing simplicity and consistency.
> >
> > Kind regards,
> > Nicolas
> >
>=20
> Hi Nicolas,
>=20
> Simplicity in the files SGTM, my own shell script norms are to be
> cautious/defensive around the interpretation of spaces. The SQ code was
> cargo culted and so may or may not be necessary. The installation rules a=
re
> dealing with user paths which may contain spaces, so I'd encourage some
> caution. We should be able to come up with some command lines that test a=
ll
> cases to determine if anything suffers from the changes and whether to ca=
re.
>=20
> Thanks,
> Ian

Hi Ian,

looking at some of the tools/lib/*/Makefiles and your patch above, the=20
use of DESTDIR vs. DESTDIR_SQ seems to be quite inconsistent already:

>  define do_install
> -	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
> -		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
> +	if [ ! -d '$2' ]; then             \
> +		$(INSTALL) -d -m 755 '$2'; \
>  	fi;                                             \
> -	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
> +	$(INSTALL) $1 $(if $3,-m $3,) '$2'

Here, the single-quoted DESTDIR_SQ is removed from do_install (which I=20
think is a good thing)...

>  endef
> =20
>  install_lib: $(LIBFILE)
> @@ -100,13 +100,16 @@ install_lib: $(LIBFILE)
>  		$(call do_install_mkdir,$(libdir_SQ)); \
>  		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> =20
> -install_headers:
> -	$(call QUIET_INSTALL, libsubcmd_headers) \
> -		$(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644); \
> -		$(call do_install,help.h,$(prefix)/include/subcmd,644); \
> -		$(call do_install,pager.h,$(prefix)/include/subcmd,644); \
> -		$(call do_install,parse-options.h,$(prefix)/include/subcmd,644); \
> -		$(call do_install,run-command.h,$(prefix)/include/subcmd,644);
> +HDRS :=3D exec-cmd.h help.h pager.h parse-options.h run-command.h
> +INSTALL_HDRS_PFX :=3D $(DESTDIR)$(prefix)/include/subcmd
> +INSTALL_HDRS :=3D $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
> +
> +$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: %.h
> +	$(call QUIET_INSTALL, $@) \
> +		$(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)

=2E.. and a plain $(DESTDIR) (via $(INSTALL_HDRS_PFX)) is forwarded to=20
do_install.  Doesn't that mean, that we end up with

  $(INSTALL) $< -m 644 '$(DESTDIR)$(prefix)/include/subcmd'

where neither $(DESTDIR) nor $(prefix) has the special single-quote=20
handling?  If we would remove the single-quoting and _SQ redefinitions,=20
it _should_ be possible (again) to have destination paths with spaces=20
(and single quotes), iff users escape properly e.g.
DESTDIR=3D"'/name with space'".  Perhaps a hint about that in the=20
Documentation might then be helpful.

Or do I get something completely wrong?

If nobody complains, I am going to prepare a patch for removing the=20
single-quote special handling.

Kind regards,
Nicolas

--iTsQL20z2LG4ZgZl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOhZVgACgkQB1IKcBYm
EmmSmhAA57YOl1MinlSplaZWdWN5NpBPPPEvGI6x+GQEqSP3EDguUqjDXF2HRT2c
JyhabSzz1QnI3Dv/D+Hfu0H4x6vezixXYp2krWcjg5GBW+MAfIhr+L0pIgQXOj+1
+pswC12cksIOhfIn1HavWHHgidFvrxjQFo/649prLznaHdWxK1UKGL9bXWIcdFcq
ntM8RlO0ixEnAmAhYPy0+61cg7n3X3Gq1C/WIyXu9d66ORkNSKWrnztP5qWVKOe2
eWBh/kZnj+TW67wLBOm6i7gsUYy7EXHrKad39XpTsSGmzlxXkmfGBJhTSGbMSYtA
SI4bVPp664FkMEz9diR2iSGObWyqvStnMOeFGitkBQBJRL7Y/8wMja8zdp9AGyvj
BB6ygJr+0wzIsgfJmcHtyEAImlANfACoyTq1LyKJIaRqZMi/OsE5yOU8HLC4iQgU
dtHuxtV+IrE+byZa6aWIUI5itvTyMuyEUG0E5A9AofP+vg+rglsnrmGOYvIBfwvq
SNSQoxc3vf4gKNMj6jmLlGltFUNEeKW5jzSR1Wefm9jt2rRjCOzaBtn4fM1ssqGg
LX1KM9JLQUx7MlQrEs5R32KL5hzAq0+LDL+5oEGHuRaiyeG2tPB2cNLzV2RTHiv8
HMv7tAK+7qX1bPaP6xmk7ahwGZe4jrYzjh1i+2+wP+LT5DC9UmI=
=ACeV
-----END PGP SIGNATURE-----

--iTsQL20z2LG4ZgZl--

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB284A5E8A
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 15:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiBAOsQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 09:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiBAOsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 09:48:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70DFC061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 06:48:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77329B82E0B
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 14:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBB9C340EB;
        Tue,  1 Feb 2022 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643726892;
        bh=DKOEWiNJGjP5rYTu1lG5TOgfkxLZD/ZzPtE0p96dmLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPK24sqF8pb3A0K0ModfkLG5bsYJIYiIADhKu/vCr5i6wABYoD8w0OVNrs7WdE3yP
         u3vNSH/hsoxSGEZJYFCwZzaVAFpJE/eLvfTNb3W7irZjjrDNzFWWEnET1qUIT+IMBF
         sqf6Rh2mZRP0NxsxJ6ERuWeOBy9IO+kr3WoSviyRu01nLKaVXD7+zJ+9vht9H1YupS
         UKfk+YWZKY/iPSDoEhBkEkXo5CLvnHdizK88AnvcC7kJaL+yimulEeHpRPaxMm6GjJ
         /JXo1bpJ7BtW/e9C/XbBHonSuEmpQTAB6aC4A2U21dPzSuKBGAmXvrqsn/Gs6+qxSg
         RUJuB9Xbs/JxA==
Date:   Tue, 1 Feb 2022 15:48:08 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: deprecate xdp_cpumap and xdp_devmap
 sec definitions
Message-ID: <YflIKBDrHD/w59hR@lore-desk>
References: <d456931681fe2344ae56225a698a0bd1d5c63b88.1643375942.git.lorenzo@kernel.org>
 <CAEf4Bzbt--iLcctUq+D_CXY0qyDRi3_uWc=vvOV4z-eQvum2cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwQHuZxi6UQP3qxc"
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbt--iLcctUq+D_CXY0qyDRi3_uWc=vvOV4z-eQvum2cA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--LwQHuZxi6UQP3qxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jan 28, 2022 at 5:29 AM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> >
> > Deprecate xdp_cpumap xdp_devmap sec definitions.
> > Introduce xdp/devmap and xdp/cpumap definitions according to the standa=
rd
> > for SEC("") in libbpf:
> > - prog_type.prog_flags/attach_place
> > Update cpumap/devmap samples and kselftests
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes since v1:
> > - refer to Libbpf-1.0-migration-guide in the warning rised by libbpf
> > ---
> >  samples/bpf/xdp_redirect_cpu.bpf.c                   |  8 ++++----
> >  samples/bpf/xdp_redirect_map.bpf.c                   |  2 +-
> >  samples/bpf/xdp_redirect_map_multi.bpf.c             |  2 +-
> >  tools/lib/bpf/libbpf.c                               | 12 ++++++++++--
> >  .../bpf/progs/test_xdp_with_cpumap_frags_helpers.c   |  2 +-
> >  .../bpf/progs/test_xdp_with_cpumap_helpers.c         |  2 +-
> >  .../bpf/progs/test_xdp_with_devmap_frags_helpers.c   |  2 +-
> >  .../bpf/progs/test_xdp_with_devmap_helpers.c         |  2 +-
> >  .../selftests/bpf/progs/xdp_redirect_multi_kern.c    |  2 +-
>=20
> Please split samples/bpf, selftests/bpf, and libbpf changes into
> separate patches. We keep them separate whenever possible.

ack, I will do in v3.

>=20
> >  9 files changed, 21 insertions(+), 13 deletions(-)
> >
>=20
> [...]
>=20
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4ce94f4ed34a..ba003cabe4a4 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -237,6 +237,8 @@ enum sec_def_flags {
> >         SEC_SLOPPY_PFX =3D 16,
> >         /* BPF program support non-linear XDP buffer */
> >         SEC_XDP_FRAGS =3D 32,
> > +       /* deprecated sec definitions not supposed to be used */
> > +       SEC_DEPRECATED =3D 64,
> >  };
> >
> >  struct bpf_sec_def {
> > @@ -6575,6 +6577,10 @@ static int libbpf_preload_prog(struct bpf_progra=
m *prog,
> >         if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS=
))
> >                 opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> >
> > +       if (def & SEC_DEPRECATED)
> > +               pr_warn("sec '%s' is deprecated, please take a look at =
https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide\n",
> > +                       prog->sec_name);
> > +
>=20
> Please add a link directly to [0]. I just added a new section listing
> xdp_devmap and xdp_cpumap. I also added SEC("classifier") ->
> SEC("tc"), so let's mark SEC("classifier") as deprecated as well in
> the next revision?

ack, I will do.

>=20
> Daniel, does that sound reasonable to you or should we leave
> SEC("classifier") intact?
>=20
> Let's use also the syntax consistent with the code people write.
> Something like "SEC(\"%s\") is deprecated, please see
> https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#bpf-prog=
ram-sec-annotation-deprecations
> for details"?

ack, I will do in v3.

Regards,
Lorenzo

>=20
>   [0] https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#bp=
f-program-sec-annotation-deprecations
>=20
> >         if ((prog->type =3D=3D BPF_PROG_TYPE_TRACING ||
> >              prog->type =3D=3D BPF_PROG_TYPE_LSM ||
> >              prog->type =3D=3D BPF_PROG_TYPE_EXT) && !prog->attach_btf_=
id) {
> > @@ -8618,9 +8624,11 @@ static const struct bpf_sec_def section_defs[] =
=3D {
> >         SEC_DEF("iter.s/",              TRACING, BPF_TRACE_ITER, SEC_AT=
TACH_BTF | SEC_SLEEPABLE, attach_iter),
> >         SEC_DEF("syscall",              SYSCALL, 0, SEC_SLEEPABLE),
> >         SEC_DEF("xdp.frags/devmap",     XDP, BPF_XDP_DEVMAP, SEC_XDP_FR=
AGS),
> > -       SEC_DEF("xdp_devmap/",          XDP, BPF_XDP_DEVMAP, SEC_ATTACH=
ABLE),
> > +       SEC_DEF("xdp/devmap",           XDP, BPF_XDP_DEVMAP, SEC_ATTACH=
ABLE),
> > +       SEC_DEF("xdp_devmap/",          XDP, BPF_XDP_DEVMAP, SEC_ATTACH=
ABLE | SEC_DEPRECATED),
> >         SEC_DEF("xdp.frags/cpumap",     XDP, BPF_XDP_CPUMAP, SEC_XDP_FR=
AGS),
> > -       SEC_DEF("xdp_cpumap/",          XDP, BPF_XDP_CPUMAP, SEC_ATTACH=
ABLE),
> > +       SEC_DEF("xdp/cpumap",           XDP, BPF_XDP_CPUMAP, SEC_ATTACH=
ABLE),
> > +       SEC_DEF("xdp_cpumap/",          XDP, BPF_XDP_CPUMAP, SEC_ATTACH=
ABLE | SEC_DEPRECATED),
> >         SEC_DEF("xdp.frags",            XDP, BPF_XDP, SEC_XDP_FRAGS),
> >         SEC_DEF("xdp",                  XDP, BPF_XDP, SEC_ATTACHABLE_OP=
T | SEC_SLOPPY_PFX),
> >         SEC_DEF("perf_event",           PERF_EVENT, 0, SEC_NONE | SEC_S=
LOPPY_PFX),
>=20
> [...]

--LwQHuZxi6UQP3qxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYflIJwAKCRA6cBh0uS2t
rEjrAP9Y1KALQsuuEk/oRHow/nLfMIUPGof/WcQ1RfUAe7VXEAD+OQ+meBEvUVhI
fwQ1tJIHR/tbMAbvW5cOfzsfc/uOrQk=
=TS1R
-----END PGP SIGNATURE-----

--LwQHuZxi6UQP3qxc--

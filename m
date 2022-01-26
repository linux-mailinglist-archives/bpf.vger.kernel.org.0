Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FD249CF4F
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiAZQLu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 11:11:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39554 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiAZQLt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 11:11:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82462B81EE4
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 16:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFC4C340E3;
        Wed, 26 Jan 2022 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643213507;
        bh=6cqkzEIIRW0gmQwT/9KKv45+rfMvDK9BX5KVJS4bgkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HfH19ouYbd7qK3wk48i/Y9Amlrbg/71IS7i04dBetTpwt4HqeyissxTyh/5jicR+N
         Lt9zvurse5PeKDvepbkpN6pc6QeA61FndAkftTTsjjMUvi4W1gWKnf0l9C0UODLUhP
         zwQqZQMt7EdesiImoeeQQUPRJmNEZIP7d+HQHs647e44ZmkDO2RuENPy+o/VIYsTuH
         znE0i0AELAKMVVxAuB4eLWub0kSID0w1aMi+3xXn6doBh26kwcmGOohhNizznyMDii
         sb6zdXViv08RLgbpNkQHVsPc0+pHEcMxqfoxdfVQfnDIYiY//7jkMtiGGzA06OI3B5
         6ykhXGeTjQg2Q==
Date:   Wed, 26 Jan 2022 17:11:43 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Zvi Effron <zeffron@riotgames.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        john fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [PATCH v21 bpf-next 18/23] libbpf: Add SEC name for xdp_mb
 programs
Message-ID: <YfFyv8l6xDNM70eZ@lore-desk>
References: <Yd82J8vxSAR9tvQt@lore-desk>
 <8735lshapk.fsf@toke.dk>
 <47a3863b-080c-3ac2-ff2d-466b74d82c1c@redhat.com>
 <Yd/9SPHAPH3CpSnN@lore-desk>
 <CAADnVQJaB8mmnD1Z4jxva0CqA2D0aQDmXggMEQPX2MRLZvoLzA@mail.gmail.com>
 <YeC8sOAeZjpc4j8+@lore-desk>
 <CAADnVQ+=0k1YBbkMmSKSBtkmiG8VCYZ5oKGjPPr4s9c53QF-mQ@mail.gmail.com>
 <e86ccea8-af77-83bf-e90e-dce88b26f07c@redhat.com>
 <CAC1LvL3M9OaSanES0uzp=vvgK23qPGRPpcAR6Z_Vqcvma3K5Qg@mail.gmail.com>
 <CAEf4BzZAMtmqW4sMfhEX8WtAzmQoVQ=WupqeqXa=5KbYXAbQNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F5B0qkXAbrXnTAJt"
Content-Disposition: inline
In-Reply-To: <CAEf4BzZAMtmqW4sMfhEX8WtAzmQoVQ=WupqeqXa=5KbYXAbQNA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--F5B0qkXAbrXnTAJt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jan 14, 2022 at 10:55 AM Zvi Effron <zeffron@riotgames.com> wrote:
> >
> > On Fri, Jan 14, 2022 at 8:50 AM Jesper Dangaard Brouer
> > <jbrouer@redhat.com> wrote:
> > >
> > >
> > >
> > > On 14/01/2022 03.09, Alexei Starovoitov wrote:
> > > > On Thu, Jan 13, 2022 at 3:58 PM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
> > > >>>
> > > >>> Btw "xdp_cpumap" should be cleaned up.
> > > >>> xdp_cpumap is an attach type. It's not prog type.
> > > >>> Probably it should be "xdp/cpumap" to align with "cgroup/bind[46]=
" ?
> > > >>
> > > >> so for xdp "mb" or xdp "frags" it will be xdp/cpumap.mb (xdp/devma=
p.mb) or
> > > >> xdp/cpumap.frags (xdp/devmap.frags), right?
> > > >
> > > > xdp.frags/cpumap
> > > > xdp.frags/devmap
> > > >
> > > > The current de-facto standard for SEC("") in libbpf:
> > > > prog_type.prog_flags/attach_place
> > >
> > > Ups, did we make a mistake with SEC("xdp_devmap/")
> > >
> > > and can we correct without breaking existing programs?
> > >
> >
> > We can (at the very least) add the correct sections, even if we leave t=
he
> > current incorrect ones as well. Ideally we'd mark the incorrect ones de=
precated
> > and either remove them before libbpf 1.0 or as part of 2.0?
> >
>=20
> Correct, those would need to be new aliases. We can also deprecate old
> ones, if we have consensus on that. We can teach libbpf to emit
> warnings (through logs, of course) for such uses of to-be-removed
> sections aliases. We still have probably a few months before the final
> 1.0 release, should hopefully be plenty of time to people to adapt.

If we all agree on old cpumap/devmap sec deprecation and replace them with
xdp/cpumap and xdp/devmap, would it be ok something like the patch below or
would be necessary something different?

Regards,
Lorenzo

--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6575,6 +6575,12 @@ static int libbpf_preload_prog(struct bpf_program *p=
rog,
 	if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
 		opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
=20
+	if (strstr(prog->sec_name, "xdp_devmap") ||
+	    strstr(prog->sec_name, "xdp_cpumap")) {
+		pr_warn("sec_name '%s' is deprecated, use xdp/devmap or xdp_cpumap inste=
ad\n",
+			prog->sec_name);
+	}
+
 	if ((prog->type =3D=3D BPF_PROG_TYPE_TRACING ||
 	     prog->type =3D=3D BPF_PROG_TYPE_LSM ||
 	     prog->type =3D=3D BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
@@ -8618,8 +8624,10 @@ static const struct bpf_sec_def section_defs[] =3D {
 	SEC_DEF("iter.s/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPAB=
LE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
 	SEC_DEF("xdp.frags/devmap",	XDP, BPF_XDP_DEVMAP, SEC_XDP_FRAGS),
+	SEC_DEF("xdp/devmap",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
 	SEC_DEF("xdp_devmap/",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
 	SEC_DEF("xdp.frags/cpumap",	XDP, BPF_XDP_CPUMAP, SEC_XDP_FRAGS),
+	SEC_DEF("xdp/cpumap",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
 	SEC_DEF("xdp_cpumap/",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
 	SEC_DEF("xdp.frags",		XDP, BPF_XDP, SEC_XDP_FRAGS),
 	SEC_DEF("xdp",			XDP, BPF_XDP, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),


>=20
> > --Zvi
> >
> > > > "attach_place" is either function_name for fentry/, tp/, lsm/, etc.
> > > > or attach_type/hook/target for cgroup/bind4, cgroup_skb/egress.
> > > >
> > > > lsm.s/socket_bind -> prog_type =3D LSM, flags =3D SLEEPABLE
> > > > lsm/socket_bind -> prog_type =3D LSM, non sleepable.
> > > >
> > >

--F5B0qkXAbrXnTAJt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYfFyvgAKCRA6cBh0uS2t
rIUlAP9K6P0vUuCMOnM4qdHkmQFR+xEZdLpY/74wSXQrNljTnQD9Ht91FZTehAYA
Z4ouOg4v6RNoB8x2alXcScdjNj3MhQw=
=zPgV
-----END PGP SIGNATURE-----

--F5B0qkXAbrXnTAJt--

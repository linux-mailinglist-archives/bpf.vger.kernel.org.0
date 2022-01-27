Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF249E8E1
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiA0RYW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 12:24:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51100 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiA0RYW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 12:24:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE5D61B10
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 17:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCE8C340E4;
        Thu, 27 Jan 2022 17:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643304261;
        bh=MLL1wKJpT7La/NQH2wHUVjkfLuHzAgNomf2UCn0Ixv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jBdMw0yQmteH7/leQTgF9Ns31ouyQp89W/7rI/LS3PGdOSv5all0ci565WRsgl/q7
         10OSJ+wEs4sazOdmBOip1mdxQwhjorBg5bwvawKqqZRAO0aop74lsVm4sPXIDkhDuE
         noSvnA27Kmsjpv2WGEizxhCPBVkD8a4J4jpEkGDoiEGgbdh8g0ukVqI2t5pVmLJxXS
         +LcfbZ36UVwjVT9MugxZZhhZOkpNIKA6isdt4cftpPmWQcQHnEpGrgRBHQ0X4cx2U6
         UrShm9wCmQwEwkFLUecT2fMDPjYtkYlkPAVaAH4rbELj2qB/3MVk9d/m2ncDprCLL2
         4o0FcA1+KBwyA==
Date:   Thu, 27 Jan 2022 18:24:16 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: deprecate xdp_cpumap and xdp_devmap sec
 definitions
Message-ID: <YfLVQAbbR+dcZfii@lore-desk>
References: <d7f8f9e3370d33be0a3385c7604d8925e10c91d1.1643285321.git.lorenzo@kernel.org>
 <87pmod196i.fsf@toke.dk>
 <CAEf4BzYOZ6fi_SSgJmWRD7TM44w71L_+QPv9H13OCA08f9RHww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xxIdjWXUF11Vp8zp"
Content-Disposition: inline
In-Reply-To: <CAEf4BzYOZ6fi_SSgJmWRD7TM44w71L_+QPv9H13OCA08f9RHww@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--xxIdjWXUF11Vp8zp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jan 27, 2022 at 7:37 AM Toke H=F8iland-J=F8rgensen <toke@redhat.c=
om> wrote:
> >
> > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >
> > > Deprecate xdp_cpumap xdp_devmap sec definitions.
> > > Introduce xdp/devmap and xdp/cpumap definitions according to the stan=
dard
> > > for SEC("") in libbpf:
> > > - prog_type.prog_flags/attach_place
> > > Update cpumap/devmap samples and kselftests
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  samples/bpf/xdp_redirect_cpu.bpf.c                   |  8 ++++----
> > >  samples/bpf/xdp_redirect_map.bpf.c                   |  2 +-
> > >  samples/bpf/xdp_redirect_map_multi.bpf.c             |  2 +-
> > >  tools/lib/bpf/libbpf.c                               | 12 ++++++++++=
--
> > >  .../bpf/progs/test_xdp_with_cpumap_frags_helpers.c   |  2 +-
> > >  .../bpf/progs/test_xdp_with_cpumap_helpers.c         |  2 +-
> > >  .../bpf/progs/test_xdp_with_devmap_frags_helpers.c   |  2 +-
> > >  .../bpf/progs/test_xdp_with_devmap_helpers.c         |  2 +-
> > >  .../selftests/bpf/progs/xdp_redirect_multi_kern.c    |  2 +-
> > >  9 files changed, 21 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/samples/bpf/xdp_redirect_cpu.bpf.c b/samples/bpf/xdp_red=
irect_cpu.bpf.c
> > > index 25e3a405375f..87c54bfdbb70 100644
> > > --- a/samples/bpf/xdp_redirect_cpu.bpf.c
> > > +++ b/samples/bpf/xdp_redirect_cpu.bpf.c
> > > @@ -491,7 +491,7 @@ int  xdp_prognum5_lb_hash_ip_pairs(struct xdp_md =
*ctx)
> > >       return bpf_redirect_map(&cpu_map, cpu_dest, 0);
> > >  }
> > >
> > > -SEC("xdp_cpumap/redirect")
> > > +SEC("xdp/cpumap")
> > >  int xdp_redirect_cpu_devmap(struct xdp_md *ctx)
> > >  {
> > >       void *data_end =3D (void *)(long)ctx->data_end;
> > > @@ -507,19 +507,19 @@ int xdp_redirect_cpu_devmap(struct xdp_md *ctx)
> > >       return bpf_redirect_map(&tx_port, 0, 0);
> > >  }
> > >
> > > -SEC("xdp_cpumap/pass")
> > > +SEC("xdp/cpumap")
> > >  int xdp_redirect_cpu_pass(struct xdp_md *ctx)
> > >  {
> > >       return XDP_PASS;
> > >  }
> > >
> > > -SEC("xdp_cpumap/drop")
> > > +SEC("xdp/cpumap")
> > >  int xdp_redirect_cpu_drop(struct xdp_md *ctx)
> > >  {
> > >       return XDP_DROP;
> > >  }
> > >
> > > -SEC("xdp_devmap/egress")
> > > +SEC("xdp/devmap")
> > >  int xdp_redirect_egress_prog(struct xdp_md *ctx)
> > >  {
> > >       void *data_end =3D (void *)(long)ctx->data_end;
> > > diff --git a/samples/bpf/xdp_redirect_map.bpf.c b/samples/bpf/xdp_red=
irect_map.bpf.c
> > > index 59efd656e1b2..415bac1758e3 100644
> > > --- a/samples/bpf/xdp_redirect_map.bpf.c
> > > +++ b/samples/bpf/xdp_redirect_map.bpf.c
> > > @@ -68,7 +68,7 @@ int xdp_redirect_map_native(struct xdp_md *ctx)
> > >       return xdp_redirect_map(ctx, &tx_port_native);
> > >  }
> > >
> > > -SEC("xdp_devmap/egress")
> > > +SEC("xdp/devmap")
> > >  int xdp_redirect_map_egress(struct xdp_md *ctx)
> > >  {
> > >       void *data_end =3D (void *)(long)ctx->data_end;
> > > diff --git a/samples/bpf/xdp_redirect_map_multi.bpf.c b/samples/bpf/x=
dp_redirect_map_multi.bpf.c
> > > index bb0a5a3bfcf0..8b2fd4ec2c76 100644
> > > --- a/samples/bpf/xdp_redirect_map_multi.bpf.c
> > > +++ b/samples/bpf/xdp_redirect_map_multi.bpf.c
> > > @@ -53,7 +53,7 @@ int xdp_redirect_map_native(struct xdp_md *ctx)
> > >       return xdp_redirect_map(ctx, &forward_map_native);
> > >  }
> > >
> > > -SEC("xdp_devmap/egress")
> > > +SEC("xdp/devmap")
> > >  int xdp_devmap_prog(struct xdp_md *ctx)
> > >  {
> > >       void *data_end =3D (void *)(long)ctx->data_end;
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 4ce94f4ed34a..1d97bc346be6 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -237,6 +237,8 @@ enum sec_def_flags {
> > >       SEC_SLOPPY_PFX =3D 16,
> > >       /* BPF program support non-linear XDP buffer */
> > >       SEC_XDP_FRAGS =3D 32,
> > > +     /* deprecated sec definitions not supposed to be used */
> > > +     SEC_DEPRECATED =3D 64,
> > >  };
> > >
> > >  struct bpf_sec_def {
> > > @@ -6575,6 +6577,10 @@ static int libbpf_preload_prog(struct bpf_prog=
ram *prog,
> > >       if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS=
))
> > >               opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> > >
> > > +     if (def & SEC_DEPRECATED)
> > > +             pr_warn("sec '%s' is deprecated, please use new version=
 instead\n",
> > > +                     prog->sec_name);
> > > +
> >
> > How is the user supposed to figure out what "the new version" is?
>=20
>=20
> Let's add the section to
> https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide and
> link to it from the deprecation warning.

so, is it better to add an utility routine to map the deprecated sec_name to
the new one, or is it enough to add a section in Libbpf-1.0-migration-guide?
I am fine both ways.

Regards,
Lorenzo

>=20
> >
> > -Toke
> >

--xxIdjWXUF11Vp8zp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYfLVQAAKCRA6cBh0uS2t
rN9mAQCWWk67dkrGvz4wAQcrPkOkbhejR0UbEVUGf/SCZEppnAEAhxoCkxf6DZO2
BUrlGaBRsVVqjE5XdtSAeUhkEB4JwgI=
=6KPz
-----END PGP SIGNATURE-----

--xxIdjWXUF11Vp8zp--

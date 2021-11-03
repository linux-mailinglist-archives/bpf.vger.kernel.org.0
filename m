Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC8443A55
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 01:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhKCARN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 20:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233071AbhKCARN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 20:17:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48D8B60EDF;
        Wed,  3 Nov 2021 00:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635898477;
        bh=9rDBkxdbfFV5+DW4L3+/mObeMYbKCKDZDU0P7y+u3JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s86tKUM72yIDAlNPbCgFjibjmjz1ke3aBCk8poGOZ2AXNOWrpVwtMOHBM02Ir50oI
         8KFf4KwhOC5GZE0AfKu08FVIsgDi9wUO6nw/TNtkIpPZtjCBJlRK2pdCTn9R4IQhsF
         xXCyXIOZqCPgs/wQqUwZYeWEN7q2WFtovdRUa9QiMA1JB6naIzA6FmydrPDkrQJEF3
         5AtSt/eSiHPoBqr9oSIM1JW5u2fIzgbWfuemmT70wLw6LdVRXnZbM2Tv6gcHFImtPW
         5RG6+WMK7O02tUGN16wwXifcyUtjLrYaZiiOy76bypeDK6C3tT+3yTzK2bm/V9ASa6
         X6Y3fej3frTZw==
Date:   Wed, 3 Nov 2021 01:14:33 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCH bpf-next] bpf: introduce bpf_map_get_xdp_prog utility
 routine
Message-ID: <YYHUabJ5TedbUsd/@lore-desk>
References: <269c70c6c529a09eb6d6b489eb9bf5e5513c943a.1635196496.git.lorenzo@kernel.org>
 <CAADnVQLG-T-7mLgVY9naMKGog-Qcf3yoZRvZLJqm55iAPhFEhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7cw+6OMXf+opqeCE"
Content-Disposition: inline
In-Reply-To: <CAADnVQLG-T-7mLgVY9naMKGog-Qcf3yoZRvZLJqm55iAPhFEhQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--7cw+6OMXf+opqeCE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Oct 25, 2021 at 2:18 PM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> >
> > Introduce bpf_map_get_xdp_prog to load an eBPF program on
> > CPUMAP/DEVMAP entries since both of them share the same code.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  include/linux/bpf.h |  2 ++
> >  kernel/bpf/core.c   | 17 +++++++++++++++++
> >  kernel/bpf/cpumap.c | 12 ++++--------
> >  kernel/bpf/devmap.c | 16 ++++++----------
> >  4 files changed, 29 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 26bf8c865103..891936b54b55 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1910,6 +1910,8 @@ static inline struct bpf_prog *bpf_prog_get_type(=
u32 ufd,
> >         return bpf_prog_get_type_dev(ufd, type, false);
> >  }
> >
> > +struct bpf_prog *bpf_map_get_xdp_prog(struct bpf_map *map, int fd,
> > +                                     enum bpf_attach_type attach_type);
> >  void __bpf_free_used_maps(struct bpf_prog_aux *aux,
> >                           struct bpf_map **used_maps, u32 len);
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index dee91a2eea7b..7e72c21b6589 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2228,6 +2228,23 @@ void __bpf_free_used_maps(struct bpf_prog_aux *a=
ux,
> >         }
> >  }
> >
> > +struct bpf_prog *bpf_map_get_xdp_prog(struct bpf_map *map, int fd,
> > +                                     enum bpf_attach_type attach_type)
> > +{
> > +       struct bpf_prog *prog;
> > +
> > +       prog =3D bpf_prog_get_type(fd, BPF_PROG_TYPE_XDP);
> > +       if (IS_ERR(prog))
> > +               return prog;
> > +
> > +       if (prog->expected_attach_type !=3D attach_type) {
> > +               bpf_prog_put(prog);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       return prog;
> > +}
>=20
> It is supposed to be a cleanup... but...
>=20
> 1. it's tweaking __cpu_map_load_bpf_program()
> to pass extra 'map' argument further into this helper,
> but the 'map' is unused.

For xdp multi-buff we will need to extend Toke's bpf_prog_map_compatible fix
running bpf_prog_map_compatible routine for cpumaps and devmaps in
order to avoid mixing xdp mb and xdp legacy programs in a cpumaps or devmap=
s.
For this reason I guess we will need to pass map pointer to
__cpu_map_load_bpf_program anyway.
I do not have a strong opinion on it, but the main idea here is just to hav=
e a
common code and avoid adding the same changes to cpumap and devmap.
Anyway if you prefer to do it separately for cpumap  and devmap I am fine
with it.

>=20
> 2. bpf_map_get_xdp_prog is a confusing name. what 'map' doing in there?

maybe bpf_xdp_map_load_prog? (naming is always hard :))

Regards,
Lorenzo

>=20
> 3. it's placed in core.c while it's really cpumap/devmap only.
>=20
> I suggest leaving the code as-is.

--7cw+6OMXf+opqeCE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYYHUaQAKCRA6cBh0uS2t
rATsAP4gD+6yKiRMo7cs7N/o1n1Qe3DukocBEzm/tUMPukrDugEA38Q0ZuoGMzmM
gjRTbkxiDwL3s9uRWYxHc/7MtuIQ4Q8=
=w0RC
-----END PGP SIGNATURE-----

--7cw+6OMXf+opqeCE--

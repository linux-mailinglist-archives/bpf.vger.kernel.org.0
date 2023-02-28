Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF566A5522
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 10:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjB1JGL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 04:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjB1JGJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 04:06:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E47B1BAFE
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 01:06:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7E4161033
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 09:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF514C433EF;
        Tue, 28 Feb 2023 09:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677575163;
        bh=0eWMlMGI2RcrCwduamP7bwmNMOKFU4gjsMoHTxoSinY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7tVgobE8tFvDiJtDcO93v1XVLiICxITvZRQq8AFze6obLmLJBJV9PoaKV0InKs7J
         +s6Rmcws9ERMYH6/BfqX4w4NIOCU61W6XaFqnvGxb1hr8vaQKajDX3OeIlBJU1qhEf
         Wh78uPM174HjlyPZMWW/NvDIdC2mL0CbN2n88C4ptNv/z7xwLSRCGWp4Hsc6/i8zHF
         WYbAIRybvimrH+ZgW2CSZ2u7soxBs0aESlgLA54Jf3S+9TGNae3F3yBf5oQbjhYGnl
         FziW56q9KulVsvZsBScbOxILFB2g9kPI0rQ+gDKrPvT8/JEG4Ex1mwr+T8dLfm3y3t
         XWLcery/TBpvQ==
Date:   Tue, 28 Feb 2023 10:05:59 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf] libbpf: Fix bpf_xdp_query() in old kernels
Message-ID: <Y/3D9+E6bR23jKqy@lore-desk>
References: <20230227224943.1153459-1-yhs@fb.com>
 <CAEf4Bzaqqzxo7fMNxrYXf5VgLVqSR3cOGkM6KF=hTNqcc1DTBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j2vvOQZ+jkYtWwBw"
Content-Disposition: inline
In-Reply-To: <CAEf4Bzaqqzxo7fMNxrYXf5VgLVqSR3cOGkM6KF=hTNqcc1DTBw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--j2vvOQZ+jkYtWwBw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Feb 27, 2023 at 2:50=E2=80=AFPM Yonghong Song <yhs@fb.com> wrote:
> >
> > Commit 04d58f1b26a4("libbpf: add API to get XDP/XSK supported features")
> > added feature_flags to struct bpf_xdp_query_opts. If a user uses
> > bpf_xdp_query_opts with feature_flags member, the bpf_xdp_query()
> > will check whether 'netdev' family exists or not in the kernel.
> > If it does not exist, the bpf_xdp_query() will return -ENOENT.
> >
> > But 'netdev' family does not exist in old kernels as it is
> > introduced in the same patch set as Commit 04d58f1b26a4.
> > So old kernel with newer libbpf won't work properly with
> > bpf_xdp_query() api call.
> >
> > To fix this issue, if the return value of
> > libbpf_netlink_resolve_genl_family_id() is -ENOENT, bpf_xdp_query()
> > will just return 0, skipping the rest of xdp feature query.
> > This preserves backward compatibility.
> >
> > Fixes: 04d58f1b26a4 ("libbpf: add API to get XDP/XSK supported features=
")
> > Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  tools/lib/bpf/netlink.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> > index 1653e7a8b0a1..4c1b3502f88d 100644
> > --- a/tools/lib/bpf/netlink.c
> > +++ b/tools/lib/bpf/netlink.c
> > @@ -468,8 +468,11 @@ int bpf_xdp_query(int ifindex, int xdp_flags, stru=
ct bpf_xdp_query_opts *opts)
> >                 return 0;
> >
> >         err =3D libbpf_netlink_resolve_genl_family_id("netdev", sizeof(=
"netdev"), &id);
> > -       if (err < 0)
> > +       if (err < 0) {
> > +               if (err =3D=3D -ENOENT)
> > +                       return 0;
> >                 return libbpf_err(err);
> > +       }
> >
>=20
> As I mentioned in another thread, I'm a bit worried of this early
> return, because query_opts might be extended and then we'll forget
> about this early return. So I did these changes and pushed to
> bpf-next:
>=20
> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> index 4c1b3502f88d..84dd5fa14905 100644
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c
> @@ -469,8 +469,10 @@ int bpf_xdp_query(int ifindex, int xdp_flags,
> struct bpf_xdp_query_opts *opts)
>=20
>         err =3D libbpf_netlink_resolve_genl_family_id("netdev",
> sizeof("netdev"), &id);
>         if (err < 0) {
> -               if (err =3D=3D -ENOENT)
> -                       return 0;
> +               if (err =3D=3D -ENOENT) {
> +                       opts->feature_flags =3D 0;
> +                       goto skip_feature_flags;
> +               }
>                 return libbpf_err(err);
>         }
>=20
> @@ -492,6 +494,7 @@ int bpf_xdp_query(int ifindex, int xdp_flags,
> struct bpf_xdp_query_opts *opts)
>=20
>         opts->feature_flags =3D md.flags;
>=20
> +skip_feature_flags:
>         return 0;

thx for fixing this:
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Regards,
Lorenzo

>  }
>=20
> >         memset(&req, 0, sizeof(req));
> >         req.nh.nlmsg_len =3D NLMSG_LENGTH(GENL_HDRLEN);
> > --
> > 2.30.2
> >

--j2vvOQZ+jkYtWwBw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY/3D9wAKCRA6cBh0uS2t
rGfrAQDF5u64eYhOWQrvMjNS/LSFmCDhRgXyKd+IYamX4vEV0AEA9r+sK4xWW68R
n0onEVZ1t/Dno4cottA08l3AR1sNwwA=
=yE8a
-----END PGP SIGNATURE-----

--j2vvOQZ+jkYtWwBw--

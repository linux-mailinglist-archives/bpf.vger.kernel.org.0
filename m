Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0E4942A9
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 22:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357440AbiASVzC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 16:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343606AbiASVzB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 16:55:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C98C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 13:55:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6836136E
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 21:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E433C004E1;
        Wed, 19 Jan 2022 21:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642629299;
        bh=ImzmEkMvVz9dn41v1WSijVnhJNzkWQ1uQw7z//6iEUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qfgcgeq/8oxGxGqLlFsyk2qdzdNcRSEPbILr1Y1M/qN1i/1sU1YRTyfUB2paYhoPM
         ZtRsm4I0TF4k6hFqI3AkTQt4mmia2xyn+BDMQwy6h6/Fu/Z8j6aPqWGgELnIAlqdnw
         nckxucjXZu4V83zqpyDvLSuZcBfBBsiRTLywqQYz9YAfmSppfwWcsCukVhDVvhVgMQ
         iwOr2t6sI2hKsetjn4wxUG8Dk6b/Xju2WPDbOqxMOUvP99OLuHxFxN/ffdxmBmzAI3
         WmTWB9jphy6F1H2wXe8cthA1fUl+k6TF0Wxs/CMR8bNJpBijInMwPIHhdOCnYDx1Dg
         7W4WV8JlS9NJw==
Date:   Wed, 19 Jan 2022 22:54:56 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: selftests: get rid of CHECK macro in
 xdp_adjust_tail.c
Message-ID: <YeiIsGwk8XUcpJDu@lore-desk>
References: <cover.1642611050.git.lorenzo@kernel.org>
 <bd3608faf2e9162cc93d54ee93d2d6737750bb30.1642611050.git.lorenzo@kernel.org>
 <CAEf4BzafyO6ZnESn_hk56FX6MZoHdfTU6e33_FECv91Y7GFnew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HnMsfM8U4cT8H6pG"
Content-Disposition: inline
In-Reply-To: <CAEf4BzafyO6ZnESn_hk56FX6MZoHdfTU6e33_FECv91Y7GFnew@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--HnMsfM8U4cT8H6pG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jan 19, 2022 at 8:58 AM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> >
> > Rely on ASSERT* macros and get rid of deprecated CHECK ones in
> > xdp_adjust_tail bpf selftest.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bpf/prog_tests/xdp_adjust_tail.c          | 62 +++++++------------
> >  1 file changed, 23 insertions(+), 39 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b=
/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> > index 3f5a17c38be5..dffa21b35503 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> > @@ -11,22 +11,19 @@ static void test_xdp_adjust_tail_shrink(void)
> >         char buf[128];
> >
> >         err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog=
_fd);
> > -       if (CHECK_FAIL(err))
> > +       if (ASSERT_OK(err, "test_xdp_adjust_tail_shrink"))
> >                 return;
> >
> >         err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
> >                                 buf, &size, &retval, &duration);
> >
> > -       CHECK(err || retval !=3D XDP_DROP,
> > -             "ipv4", "err %d errno %d retval %d size %d\n",
> > -             err, errno, retval, size);
> > +       ASSERT_OK(err || retval !=3D XDP_DROP, "ipv4");
>=20
> it's better to do such checks as two ASSERTS: ASSERT_OK(err) and
> ASSERT_EQ(retval, XDP_DROP). It will give much more meaningful error
> messages and I think is easier to follow.

ack, I will fix it in v2.

>=20
> >
> >         expect_sz =3D sizeof(pkt_v6) - 20;  /* Test shrink with 20 byte=
s */
> >         err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
> >                                 buf, &size, &retval, &duration);
> > -       CHECK(err || retval !=3D XDP_TX || size !=3D expect_sz,
> > -             "ipv6", "err %d errno %d retval %d size %d expect-size %d=
\n",
> > -             err, errno, retval, size, expect_sz);
> > +       ASSERT_OK(err || retval !=3D XDP_TX || size !=3D expect_sz, "ip=
v6");
>=20
> same as above, old CHECK printed all those values so it was ok-ish to
> combine checks. With ASSERT_XXX() let's do each error condition check
> separately. Same for all the rest below.

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> > +
> >         bpf_object__close(obj);
> >  }
> >
>=20
> [...]

--HnMsfM8U4cT8H6pG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYeiIsAAKCRA6cBh0uS2t
rMiPAP48dNzsKdgUE0zmVnB3EWAiBcHPrIFjDC2WRw7EjE5WwgD+LbB9vSeJBswb
2wzJOx3xWV45KXWsUKCoEPtmJTSNEgg=
=b6jQ
-----END PGP SIGNATURE-----

--HnMsfM8U4cT8H6pG--

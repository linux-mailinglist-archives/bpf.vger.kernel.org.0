Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED04942A4
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 22:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357383AbiASVx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 16:53:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43766 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343606AbiASVx6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 16:53:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EDD3CCE1F43
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 21:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEEFC004E1;
        Wed, 19 Jan 2022 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642629235;
        bh=3McgxxuaELeBSYvy5X7flNUP0K8Hxak8OcudBha4YdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGQFRpJcA0p0SHmC/xJgX17hR6iatqo7uBtwDfXEzaok59Uz0KVPqUJHbCte5HELd
         6aRpu1A4paB7jAbG5FUOcEqYWZxHcyIN1563GjvR0w7bfCfl97CEtRMsLmLjPiH1Hr
         d+0TmHvBD/bJ34n7NFBO0IRD4oSxc0oIRXdNDwyqX18AHsFpiMkHJzNANaujwgKiNE
         arEoJpeyVQPbDughqVNVLmX58fyHMjzgKS2tNU6/v+bjLTJbnVPBRVz7smAQxX9jCz
         +X8qc6MeJUHwG8fFFGbQ1TsFTYVEwX1tp9yaVS682A8gZGr8JSMJag6pJJCktTZ1fy
         R69L6D1YEdWDQ==
Date:   Wed, 19 Jan 2022 22:53:51 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] bpf: selftests: get rid of CHECK macro in
 xdp_bpf2bpf.c
Message-ID: <YeiIb3IkSl90BuaF@lore-desk>
References: <cover.1642611050.git.lorenzo@kernel.org>
 <ec0dbfecc37e9900001bfbd5744d917eb48de870.1642611050.git.lorenzo@kernel.org>
 <CAEf4BzZVYLGHX1zexH0wuAXD_OLAA3Kv2LSi7eCQNw=VS1B0ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FBT3MZk/5m5i3mx8"
Content-Disposition: inline
In-Reply-To: <CAEf4BzZVYLGHX1zexH0wuAXD_OLAA3Kv2LSi7eCQNw=VS1B0ZA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--FBT3MZk/5m5i3mx8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jan 19, 2022 at 8:58 AM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> >
> > Rely on ASSERT* macros and get rid of deprecated CHECK ones in
> > xdp_bpf2bpf bpf selftest.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    | 43 ++++++++-----------
> >  1 file changed, 17 insertions(+), 26 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
> > index c98a897ad692..951ce1fc535d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
> > @@ -12,25 +12,21 @@ struct meta {
> >
> >  static void on_sample(void *ctx, int cpu, void *data, __u32 size)
> >  {
> > -       int duration =3D 0;
> >         struct meta *meta =3D (struct meta *)data;
> >         struct ipv4_packet *trace_pkt_v4 =3D data + sizeof(*meta);
> >
> > -       if (CHECK(size < sizeof(pkt_v4) + sizeof(*meta),
> > -                 "check_size", "size %u < %zu\n",
> > -                 size, sizeof(pkt_v4) + sizeof(*meta)))
> > +       if (!ASSERT_GE(size, sizeof(pkt_v4) + sizeof(*meta), "check_siz=
e"))
> >                 return;
> >
> > -       if (CHECK(meta->ifindex !=3D if_nametoindex("lo"), "check_meta_=
ifindex",
> > -                 "meta->ifindex =3D %d\n", meta->ifindex))
> > +       if (!ASSERT_EQ(meta->ifindex, if_nametoindex("lo"),
> > +                      "check_meta_ifindex"))
> >                 return;
> >
> > -       if (CHECK(meta->pkt_len !=3D sizeof(pkt_v4), "check_meta_pkt_le=
n",
> > -                 "meta->pkt_len =3D %zd\n", sizeof(pkt_v4)))
> > +       if (!ASSERT_EQ(meta->pkt_len, sizeof(pkt_v4), "check_meta_pkt_l=
en"))
> >                 return;
> >
> > -       if (CHECK(memcmp(trace_pkt_v4, &pkt_v4, sizeof(pkt_v4)),
> > -                 "check_packet_content", "content not the same\n"))
> > +       if (!ASSERT_EQ(memcmp(trace_pkt_v4, &pkt_v4, sizeof(pkt_v4)),
> > +                      0, "check_packet_content"))
> >                 return;
> >
>=20
> we can simplify and make it easier to follow by not doing early
> returns. Just a sequence of ASSERTs would be compact and nice.

ack, fine. I will fix it in v2.

>=20
> >         *(bool *)ctx =3D true;
> > @@ -52,7 +48,7 @@ void test_xdp_bpf2bpf(void)
> >
> >         /* Load XDP program to introspect */
> >         pkt_skel =3D test_xdp__open_and_load();
> > -       if (CHECK(!pkt_skel, "pkt_skel_load", "test_xdp skeleton failed=
\n"))
> > +       if (!ASSERT_OK_PTR(pkt_skel, "test_xdp__open_and_load"))
> >                 return;
> >
> >         pkt_fd =3D bpf_program__fd(pkt_skel->progs._xdp_tx_iptunnel);
> > @@ -62,7 +58,7 @@ void test_xdp_bpf2bpf(void)
> >
> >         /* Load trace program */
> >         ftrace_skel =3D test_xdp_bpf2bpf__open();
> > -       if (CHECK(!ftrace_skel, "__open", "ftrace skeleton failed\n"))
> > +       if (!ASSERT_OK_PTR(ftrace_skel, "test_xdp_bpf2bpf__open"))
> >                 goto out;
> >
> >         /* Demonstrate the bpf_program__set_attach_target() API rather =
than
> > @@ -77,11 +73,11 @@ void test_xdp_bpf2bpf(void)
> >         bpf_program__set_attach_target(prog, pkt_fd, "_xdp_tx_iptunnel"=
);
> >
> >         err =3D test_xdp_bpf2bpf__load(ftrace_skel);
> > -       if (CHECK(err, "__load", "ftrace skeleton failed\n"))
> > +       if (!ASSERT_OK(err, "test_xdp_bpf2bpf__load"))
> >                 goto out;
> >
> >         err =3D test_xdp_bpf2bpf__attach(ftrace_skel);
> > -       if (CHECK(err, "ftrace_attach", "ftrace attach failed: %d\n", e=
rr))
> > +       if (!ASSERT_OK(err, "test_xdp_bpf2bpf__attach"))
> >                 goto out;
> >
> >         /* Set up perf buffer */
> > @@ -94,30 +90,25 @@ void test_xdp_bpf2bpf(void)
> >         err =3D bpf_prog_test_run(pkt_fd, 1, &pkt_v4, sizeof(pkt_v4),
> >                                 buf, &size, &retval, &duration);
> >         memcpy(&iph, buf + sizeof(struct ethhdr), sizeof(iph));
> > -       if (CHECK(err || retval !=3D XDP_TX || size !=3D 74 ||
> > -                 iph.protocol !=3D IPPROTO_IPIP, "ipv4",
> > -                 "err %d errno %d retval %d size %d\n",
> > -                 err, errno, retval, size))
> > +       if (!ASSERT_OK(err || retval !=3D XDP_TX || size !=3D 74 ||
> > +                      iph.protocol !=3D IPPROTO_IPIP, "ipv4"))
> >                 goto out;
> >
> >         /* Make sure bpf_xdp_output() was triggered and it sent the exp=
ected
> >          * data to the perf ring buffer.
> >          */
> >         err =3D perf_buffer__poll(pb, 100);
> > -       if (CHECK(err < 0, "perf_buffer__poll", "err %d\n", err))
> > +       if (!ASSERT_GE(err, 0, "perf_buffer__poll"))
> >                 goto out;
> >
> > -       CHECK_FAIL(!passed);
> > +       ASSERT_TRUE(passed, "test passed");
> >
> >         /* Verify test results */
> > -       if (CHECK(ftrace_skel->bss->test_result_fentry !=3D if_nametoin=
dex("lo"),
> > -                 "result", "fentry failed err %llu\n",
> > -                 ftrace_skel->bss->test_result_fentry))
> > +       if (!ASSERT_EQ(ftrace_skel->bss->test_result_fentry, if_nametoi=
ndex("lo"),
> > +                      "fentry result"))
> >                 goto out;
> >
> > -       CHECK(ftrace_skel->bss->test_result_fexit !=3D XDP_TX, "result",
> > -             "fexit failed err %llu\n", ftrace_skel->bss->test_result_=
fexit);
> > -
> > +       ASSERT_EQ(ftrace_skel->bss->test_result_fexit, XDP_TX, "fexit r=
esult");
> >  out:
> >         if (pb)
>=20
> while at it, please drop this if. perf_buffer__free() handles NULLs
> and error pointers.

ack, fine. I will fix it in v2.

Regards,
Lorenzo

>=20
> >                 perf_buffer__free(pb);
> > --
> > 2.34.1
> >

--FBT3MZk/5m5i3mx8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYeiIbwAKCRA6cBh0uS2t
rNGaAP9zf8gkhQnX3xN6WHAbtVABevxuIhCzo9Gl0YeDPyHx0gD9HGXMDWpo1fYG
BtXKGo+0zMJF4SImzZu1jPzVLrlMDgE=
=cM97
-----END PGP SIGNATURE-----

--FBT3MZk/5m5i3mx8--

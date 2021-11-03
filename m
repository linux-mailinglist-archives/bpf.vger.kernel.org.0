Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A744464C
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 17:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhKCQzV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 12:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhKCQzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 12:55:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B9A160F9D;
        Wed,  3 Nov 2021 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635958363;
        bh=jpB3zR7nNS9WfA7WgsUJBpE0RZcSokDysQmjcwJWEQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NEhwOAYGzpkS9Znu24nU/esF9Ak9kY3OIREtTeSB/3KlDozHIQX/MLzAX3Qfei+j+
         fQ7hmHZNoJhBi/tsVSm4k/i8teuUpHsjQbJ9/miH5E/2BSwTSnaT8tIbVPD5s8BDYi
         x6hD7iR8i1wyI9X9y2L5k0U2qAV8TdLjD6cMX9aBenzXuSjrF2kCNX5XAUMlt83Zwj
         CCCok0of0+fgXCgVeSwAX1f3b4rFTo9m+MpNBjG/t8aEySTgbkHmJtYETfkefxxU/3
         cpjzIbpdvN5moB9YbWic7n4n96RIPYKuaBJyar0533tovc7MowfKlntUy2ZK6ghUBP
         hvFP1XgGfVK7g==
Date:   Wed, 3 Nov 2021 17:52:39 +0100
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
Message-ID: <YYK+Vz9xPhGaEt+L@lore-desk>
References: <269c70c6c529a09eb6d6b489eb9bf5e5513c943a.1635196496.git.lorenzo@kernel.org>
 <CAADnVQLG-T-7mLgVY9naMKGog-Qcf3yoZRvZLJqm55iAPhFEhQ@mail.gmail.com>
 <YYHUabJ5TedbUsd/@lore-desk>
 <CAADnVQKAX-6mFBXWDDjF3Hdi-KbAzhTHtiNa2ePHSTb+3SVGDw@mail.gmail.com>
 <YYK8bmBFriIgh4O+@lore-desk>
 <CAADnVQLfTYBtj9_zfxJPt261wEu1t_nzjH_XbzQ+Zr59MmUWFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YLTIh3SAPjtnnYHJ"
Content-Disposition: inline
In-Reply-To: <CAADnVQLfTYBtj9_zfxJPt261wEu1t_nzjH_XbzQ+Zr59MmUWFg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--YLTIh3SAPjtnnYHJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Nov 3, 2021 at 9:44 AM Lorenzo Bianconi <lorenzo@kernel.org> wrot=
e:
> > > That patch alone is unnecessary.
> >
> > Yes, right. Sorry for the noise.
> > Regarding this patch, do you want me to repost with a proper commit log=
 (maybe
> > included in the xdp multi-buff series) or do you prefer to just drop it?
>=20
> I think this patch alone is not necessary.
> When you'll get to the full series it could be meaningful.
> It's hard to tell without seeing the rest of the patches.

ack, fine to me. I will drop it for the moment and then we will re-evaluate.
Thanks.

Regards,
Lorenzo

--YLTIh3SAPjtnnYHJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYYK+VwAKCRA6cBh0uS2t
rK49APoCz0UQv0rbuyKd12TvezdcYQrz5eyo1jTrZkSdIBI44gEAxbauM/AZEu+t
n8tFCguiigpwATlJ5PnSMe9hFqxHhg0=
=NXiN
-----END PGP SIGNATURE-----

--YLTIh3SAPjtnnYHJ--

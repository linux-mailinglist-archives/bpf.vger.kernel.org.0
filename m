Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF41444625
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 17:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhKCQrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 12:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232806AbhKCQrL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 12:47:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE66B610EA;
        Wed,  3 Nov 2021 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635957874;
        bh=aXd2GiRjmu8NlV6b8h9KL3KdLF6bZNok+d7pfunNLXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtK8pIttsZO/6tO/JsUrVdMluAHxSROlF1ZeCoyzUcaE7xVL9VbSdnxPptJhmDjim
         HHeT0xH0hhJ+nJgwwBN4WvfdoK+DSSfje52OXryQcp3m0KFFiR9peimpVQHZkHjfmu
         zDlO08nFhl1xcjgSvn9vDbU0wZRwEOiTOiz3BPPzilzjgV7qGJvFDxGv6vqptcqdPP
         LCxoO9wBjHzeoPGS/y4LH6wFMw8inIpyXGDUULQ6gKB4e4/4Xd9aUZWsHZcT7xg54L
         BtmxCrVjILOBX70pNKGI35YUbxyLPXl+eepvkU/BADaK/pecy9PuDDglDVm06Ihgbm
         0HJsRXrWrEGIg==
Date:   Wed, 3 Nov 2021 17:44:30 +0100
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
Message-ID: <YYK8bmBFriIgh4O+@lore-desk>
References: <269c70c6c529a09eb6d6b489eb9bf5e5513c943a.1635196496.git.lorenzo@kernel.org>
 <CAADnVQLG-T-7mLgVY9naMKGog-Qcf3yoZRvZLJqm55iAPhFEhQ@mail.gmail.com>
 <YYHUabJ5TedbUsd/@lore-desk>
 <CAADnVQKAX-6mFBXWDDjF3Hdi-KbAzhTHtiNa2ePHSTb+3SVGDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fXTX4nLMTfOnGFP0"
Content-Disposition: inline
In-Reply-To: <CAADnVQKAX-6mFBXWDDjF3Hdi-KbAzhTHtiNa2ePHSTb+3SVGDw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--fXTX4nLMTfOnGFP0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Nov 2, 2021 at 5:14 PM Lorenzo Bianconi <lorenzo@kernel.org> wrot=
e:
> > >
> > > 1. it's tweaking __cpu_map_load_bpf_program()
> > > to pass extra 'map' argument further into this helper,
> > > but the 'map' is unused.
> >
> > For xdp multi-buff we will need to extend Toke's bpf_prog_map_compatibl=
e fix
> > running bpf_prog_map_compatible routine for cpumaps and devmaps in
> > order to avoid mixing xdp mb and xdp legacy programs in a cpumaps or de=
vmaps.
> > For this reason I guess we will need to pass map pointer to
> > __cpu_map_load_bpf_program anyway.
> > I do not have a strong opinion on it, but the main idea here is just to=
 have a
> > common code and avoid adding the same changes to cpumap and devmap.
> > Anyway if you prefer to do it separately for cpumap  and devmap I am fi=
ne
> > with it.
>=20
> None of that information was in the original commit log.
> Please make sure to provide such details in the future and make it
> part of the series.
> That patch alone is unnecessary.

Yes, right. Sorry for the noise.
Regarding this patch, do you want me to repost with a proper commit log (ma=
ybe
included in the xdp multi-buff series) or do you prefer to just drop it?

Regards,
Lorenzo

--fXTX4nLMTfOnGFP0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYYK8bgAKCRA6cBh0uS2t
rBjkAQChIAPvBLcC47oXIIEnQWg3wPUkmbV99MfC0Mt1N2sjTgEAtcS5MyZhn3YR
bRdR4nxJAPrmf+hIBr6q8J96JH04zgc=
=EOb7
-----END PGP SIGNATURE-----

--fXTX4nLMTfOnGFP0--

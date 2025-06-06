Return-Path: <bpf+bounces-59963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49930AD09F6
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 00:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4222417614F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A1233156;
	Fri,  6 Jun 2025 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3NDBykl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1A13EFF3;
	Fri,  6 Jun 2025 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749248172; cv=none; b=rlQ2lJ8CWnVpOXdH29uT1z8i9Kh5E+aEnNEzQW6ustqWE27T91pmosghyA+mzt29pV8OXwwu/f2Jm4l2JerHhs1SChhecY3pAeHUzpOIYbI+suQpaND+XR/UgAFW/xR4DNpY3itibD08Pi8QEv7r5SfwIGkA8VxV+OWjkksrFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749248172; c=relaxed/simple;
	bh=FpC5qa1vI63HsGTpUNDKv1yoTcE6jGzo8UyJQyvX/EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGSmFyB16/yFC85wokJwK7hfkwql5fRu5by0aXqA3YskwexlJQE9OKlnoPtDFfyhsEEvUNwJPTlsVQgvvW99irXG9aLMMfsldI1CQW+96i2hVGaSTN8YzchgeRIYGTjtPhi+n3Qcxf4UA/GndJQO2PqwfNTBomVzqNXn9EnkbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3NDBykl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4A8C4CEEB;
	Fri,  6 Jun 2025 22:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749248172;
	bh=FpC5qa1vI63HsGTpUNDKv1yoTcE6jGzo8UyJQyvX/EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k3NDByklP5tZHlyzv/jh8b7+0PdctFYxot2ynvgfZGF2EmXbeGM+p/k8Xn3shtAnx
	 y+GSQTnc0HoHKzExhhu+Lfe/36XOkadhaW8zTdun/1R9hkhey268uBAP2R2h3FlOHq
	 POuJ3W9FuKBKIauwvDNcolrkSaCR4mGJU089waxzovsv1eFp12aTXzhuAH2NL/dAvH
	 PC72fc+W+p3VRh+4uIcY1+uwrLiw9WWAW9DlOF521yoO3UVRypLLUoSwMPymYgxCEn
	 GgOudptExYkf51o+733ljV0qJGFeBJKb5VjIKotr7s9oG8xL8wxRr6VcLCK8eDnHPi
	 2V0P7aIg6Ar/w==
Date: Sat, 7 Jun 2025 00:16:09 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	kernel-team <kernel-team@cloudflare.com>,
	Arthur Fabre <arthur@arthurfabre.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next V1 6/7] bpf: selftests: Add rx_meta store kfuncs
 selftest
Message-ID: <aENoqY9fAWtxoVWA@lore-desk>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897278834.1677018.7674555608317742053.stgit@firesoul>
 <CAADnVQJSE2=YE=-CihGXUtFbEVzyxQXrSGojkLKqkMhACxJjGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QBLrrdr/ygQyINEK"
Content-Disposition: inline
In-Reply-To: <CAADnVQJSE2=YE=-CihGXUtFbEVzyxQXrSGojkLKqkMhACxJjGg@mail.gmail.com>


--QBLrrdr/ygQyINEK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Jun 3, 2025 at 10:46=E2=80=AFAM Jesper Dangaard Brouer <hawk@kern=
el.org> wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c b/=
tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c
> > new file mode 100644
> > index 000000000000..1606454a1fbc
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define BPF_NO_KFUNC_PROTOTYPES
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_endian.h>
> > +
> > +extern void bpf_xdp_store_rx_hash(struct xdp_md *ctx, u32 hash,
> > +                                 enum xdp_rss_hash_type rss_type) __ks=
ym;
> > +extern void bpf_xdp_store_rx_ts(struct xdp_md *ctx, __u64 ts) __ksym;
>=20
> CI rightfully complains that kfunc proto is incorrect.
>=20
> In general there is no need to manually specify kfunc protos.
> They will be in vmlinux.h already with a recent pahole.

ack, I will fix it in v2.

Regards,
Lorenzo

--QBLrrdr/ygQyINEK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaENoqQAKCRA6cBh0uS2t
rKlwAQC7F0ZoKDusj/DwudtZy1w6AV95RSs4r+cA+a6t6XO88wEAiKiqLl1I+67e
rxq4aoFh0MQtpv9ME6SbwqQnLtrWBgk=
=bUOH
-----END PGP SIGNATURE-----

--QBLrrdr/ygQyINEK--


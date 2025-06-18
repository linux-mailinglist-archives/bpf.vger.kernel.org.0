Return-Path: <bpf+bounces-60919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C42ADEB77
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283601646F1
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7AE249E5;
	Wed, 18 Jun 2025 12:12:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9D239561
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248753; cv=none; b=EGaC9ZUrxsNOgNLbW07MctRp/kgbhS66AT17bswyAGzJ2fk6aEXUm30R4sg9XNBWIEb0tfS2fzEPB+66Do3MFAdF5TC7NkBYmF4yEAQ4x02A+pTkIziZyW4wQPB4Fb2+9a7H5cHYdoDIuwVyChlmffe6z6Yw8n6Mt00m0uFuOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248753; c=relaxed/simple;
	bh=MN+TyrcXv4/90+oVhRN9ySXbBDxubTUmyqDR7cf9ceY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSKRC2FdUdkPjOelXVUVRug14Y4Wx/TprZJ+vd7O7gS5iLP6LopD1kWFfxLaCBcmsiThvo8fKpdnTPj4Z18V8buut3abhv3Kfs5TV2PZpNl6PG1t1U0ajJtXvNvziUVYgGekVuDlXqy6SWQ7iQ65BTIf/0qha087kasjbHN+T6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRreN-0004yT-GA; Wed, 18 Jun 2025 14:12:19 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRreL-0048Th-21;
	Wed, 18 Jun 2025 14:12:17 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 34CEB42B666;
	Wed, 18 Jun 2025 12:12:17 +0000 (UTC)
Date: Wed, 18 Jun 2025 14:12:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, bpf@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4 00/11] net: fec: general + VLAN cleanups
Message-ID: <20250618-wooden-russet-condor-5d1623-mkl@pengutronix.de>
References: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ztf3dn6k37tmgoin"
Content-Disposition: inline
In-Reply-To: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bpf@vger.kernel.org


--ztf3dn6k37tmgoin
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v4 00/11] net: fec: general + VLAN cleanups
MIME-Version: 1.0

On 18.06.2025 14:00:00, Marc Kleine-Budde wrote:
> This series first cleans up the fec driver a bit (typos, obsolete
> comments, add missing header files, rename struct, replace magic
> number by defines).
>=20
> The last 5 patches clean up the fec_enet_rx_queue() function,
> including VLAN handling.

I accidentally dropped the patch "net: fec: add missing header files".
But this series can be applies as is, I'll include the missing patch in
my next series.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ztf3dn6k37tmgoin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhSrRwACgkQDHRl3/mQ
kZxSeQf/bBTOiveZRWN5kyvNQrFsBijmfXa9nWahkiEGnEUVDigRod+muBeTqccK
NT+DcVh36hZjUhsgZ7DAy8EU4GjHnX3HHY7FyUcV9XpwLMfQEQAqz9W6IHhKfcA7
Eh+OlKFk+YgkNkvNu3Xp7NSDpuYXVDazFmo55dkGtJwMlWtp5hlMLF8l/wcIF2zg
FPKLz2DshxCSCChdEgWfMHIn/p8nJZcJLdM3qEDtltq4SPDQp2GCrxzSGyKv1LZQ
uCrQykEqgpIh8rYjMZMkDWa8Ru90lV6LgqyZkBHm3XcnZaZ6q/SXaSAg/9wEZNrj
u3iS03sJ9Ycw24TU7Y+gCLev3ZsWgQ==
=5bIr
-----END PGP SIGNATURE-----

--ztf3dn6k37tmgoin--


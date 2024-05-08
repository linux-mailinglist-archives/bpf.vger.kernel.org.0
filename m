Return-Path: <bpf+bounces-29100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB148C0267
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 18:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EA41C21B70
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAADF6C;
	Wed,  8 May 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6uhNQ1o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B214DDB2;
	Wed,  8 May 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187349; cv=none; b=Jp3Kr8a9TLrh+YdJo0lIWQOWcwQKKB1i3F1mhqAupfSBzbcMO5PEf5x34XsAyC4n41VMuOWB34bIIb3GuEBF/FrVOar8ouFvZ6Xd90E5T+PKH13vaU6rvflMZlhkym5WuZ7W0VhsyQ/AxXtlnJvHH9T6VsEHL6VgcmR2V74/fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187349; c=relaxed/simple;
	bh=oV9q6FohML+t2GsOtO4f7Y/sVfHt/7X/LujEYuhSVX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNzCZtRxwNex5oL469LCGPQRGq8oQipQN2UkWZrAqrfcBBt+wlpWlfjo8ZF2QSfOsViaVuproYsm6N7naxGHGQwIVT5VE6ym2i7Xu0EYJxtdshCQ07KJ9GP9luP4CWfdFpaCKkVOCjKRg0s5lfefbDZE93d/5fmEn3UcKNmhpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6uhNQ1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8C8C113CC;
	Wed,  8 May 2024 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715187348;
	bh=oV9q6FohML+t2GsOtO4f7Y/sVfHt/7X/LujEYuhSVX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6uhNQ1oq6Rn5WQb042DEvXZnTUepAiSPmAjDtYr5An6TZV3w2plxq2bKwuN7C2J0
	 hOvQEROUy/ICLmgmQm/7iEFRvJPRKVSjfz0bWHrOQDxgQLllOwWuwkdLb78j2zh1xD
	 dBFpIfOT871mUsCl2/DRD6q615dEZ3+Sedo4Q/c/o2oK4vsvsbUZ9YtgAT1QRDRZe4
	 /Rwy7ykBQ9e/guvz5JNTU0zsQ/LxRIJoflPbOSOtX7iSyR2/oGkpongQIOSVeMbXDM
	 3hXBS5OluDrRUcGRM6dNvJet7GpI7Xcwxmv1FKitzIxIi1+OqYHyI916q+0GMRYy1r
	 ZAXpILsX/Rb4g==
Date: Wed, 8 May 2024 17:55:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 10/12] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Message-ID: <20240508-stalling-skinless-2ee6926d5bba@spud>
References: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
 <20240507-pci2_upstream-v4-10-e8c80d874057@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QdjAdVM3nDrdUFsa"
Content-Disposition: inline
In-Reply-To: <20240507-pci2_upstream-v4-10-e8c80d874057@nxp.com>


--QdjAdVM3nDrdUFsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 02:45:48PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings. clock-names align dwc
> common naming convension.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--QdjAdVM3nDrdUFsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjuujQAKCRB4tDGHoIJi
0iEAAP4odCwqsa0krpPtS6/ctZZWtHEAap7Ag61eyEoeDNMojQD/Sn+eC8qeLR/x
JDSqlvC8xXonb7tvS7luBljtDTpTBgE=
=3NM7
-----END PGP SIGNATURE-----

--QdjAdVM3nDrdUFsa--


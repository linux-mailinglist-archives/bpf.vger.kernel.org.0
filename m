Return-Path: <bpf+bounces-27666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF8C8B07A6
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 12:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DEB284076
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 10:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664B71598ED;
	Wed, 24 Apr 2024 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khQ5FhJT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDCF3EA66;
	Wed, 24 Apr 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955787; cv=none; b=MWGLaobaA3FHtvKQJ0mc3hykyYbClrByM8V13X6pCNcem9fy/aWR0m0vPSop6jXcqHTMGe9dUcsJmtXPfNTj17apcSwE2qlFJE7yvkFUvtOm2y7A8sYNRjruAlkKwHHaG/ugy5GsH+ngVwhFRdiv5sZrJVEOS+7Xot4Pvo9zXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955787; c=relaxed/simple;
	bh=13Hi6ZoedF7xEUK5sGqH0Sjd7YNhbMjL1SAgv6avwWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIouf/faiffyeOT4mzHGm11ljAXAxMUPqoQ6bj3IHbrr3zgGSUvLAumvsyqU5XNY0AHDmocCIUNl1XEZi5Xe3zk4RIsvDeukskHMbezApcy6XCqY/Bq+0bcOw09EZ2vmLW5qgrouCDhVEBcGljuMzliOLp4viO2WDeg6lR1rtAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khQ5FhJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA7CC113CE;
	Wed, 24 Apr 2024 10:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713955786;
	bh=13Hi6ZoedF7xEUK5sGqH0Sjd7YNhbMjL1SAgv6avwWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khQ5FhJT5PNr6HWVYFrPZXydqeSHrF0F3rLggVHJqLhR0jsFTHBtnFms6eixSLKNa
	 vCWBfATJSsIT9q4Z3jTkkomxD/o8Y38zHWifEZhLepdOPXBqA4gkcoBbWFGqBoC85w
	 3d3qPFsX87FWPQC3ivOza86kHUEr5uwfBZ1BQfpH8cBCYJd7OY4aaWZJA8Ia4jOcnu
	 WKh14ZSN/Mm3dLaPCzyxYpH0UyUhM5MPPjFAqEuIgt3p/m0I8kl4OGIXdzQIrIxpq3
	 ODoftLnsP21x2NUgPg/EftL3rgJ0BsGG7ny0xHU8hd7DxAFo5mFqOQzi2ImL7rSFxn
	 2meeXkPLUTvBA==
Date: Wed, 24 Apr 2024 11:49:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 5/7] riscv: Pass patch_text() the length in bytes
Message-ID: <20240424-math-recapture-49618e9f9b11@spud>
References: <20240327160520.791322-1-samuel.holland@sifive.com>
 <20240327160520.791322-6-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sqfgg+TcvaEXDvan"
Content-Disposition: inline
In-Reply-To: <20240327160520.791322-6-samuel.holland@sifive.com>


--sqfgg+TcvaEXDvan
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 09:04:44AM -0700, Samuel Holland wrote:
> patch_text_nosync() already handles an arbitrary length of code, so this
> removes a superfluous loop and reduces the number of icache flushes.
>=20
> Reviewed-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--sqfgg+TcvaEXDvan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZijjxgAKCRB4tDGHoIJi
0qvcAP4r2MrLGz9H1r7SbjaqoHG7Zb6RvXCN/VmJFpdJYnXfAwD/QEb6Rj6izInw
SNqGMSWRNoFweZB4bLuaxlv7QL37bwo=
=z3sD
-----END PGP SIGNATURE-----

--sqfgg+TcvaEXDvan--


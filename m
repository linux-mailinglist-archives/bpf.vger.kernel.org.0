Return-Path: <bpf+bounces-50271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF4BA247D2
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 09:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E522016726C
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D61487C1;
	Sat,  1 Feb 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Cc6GyaHj"
X-Original-To: bpf@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511EFA935;
	Sat,  1 Feb 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738400154; cv=none; b=rQj+DUJf/YyEnuocad+exk2jQGlX3qDQjqwP4YpXY7ATiiflT6UG7LtlQk/7Fc6PcejOJmcrCaaRCh0WobFpz7E9wVPioKX+5WWmFBrCWMFXgI5OnuDXR7kPNGDr5vWXxFnUM2p73Vy+cGnZzWyiQR/qgRmtfp05e9Cn2mKSEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738400154; c=relaxed/simple;
	bh=sLqe1UM0fRkBMfE6INasFA8BOIgS22SSCi+w6VqaMv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+JFl4+a+4iA6Ku23QKUOzhEbZjO0NwoZr6oMUh3y+MSLqcE9mMLv/zQnQAKzhReCqy88FWea9PQldoGVZMzR4em3q7n/yr2h26iqopBzQ17B316Hhted+JWOG9Dw2wW2r6rC3q+MuJ0aME/OcqHZ5Zm+f/ynLcrKUjFl/w4u1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Cc6GyaHj; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B9C5C1C01A4; Sat,  1 Feb 2025 09:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1738399725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S9/h32gsK9ywKqz5Lw4yDI62fcqfLayMm/eCbggP/f4=;
	b=Cc6GyaHjdGK5vJNZmBRJZdW6cD7JZ5/g+lRg3vUYzcbG8jlBBAWeaIwJQ4wfcxU2Rog8nW
	TmbodGUmcppl4wDtqneQdxt+PgGjRw8EcJj6lizfx+v5JYKlpDWrBg/55HhgDV9snGysTX
	M1H958VDKPut1DTqxg5ljm2G82rF3Xk=
Date: Sat, 1 Feb 2025 09:48:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Werner Sembach <wse@tuxedocomputers.com>, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, bentiss@kernel.org,
	dri-devel@lists.freedesktop.org, jelle@vdwaa.nl, jikos@kernel.org,
	lee@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org,
	onitake@gmail.com, cs@tuxedo.de,
	platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 0/1] platform/x86/tuxedo: Add virtual LampArray for
 TUXEDO NB04 devices
Message-ID: <Z53f7VNIgUWWFn9l@duo.ucw.cz>
References: <20250121225510.751444-1-wse@tuxedocomputers.com>
 <aa91e17f-0ea8-4645-a0f9-57c016e36a9e@gmx.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t+WGy4gS/jMLitDQ"
Content-Disposition: inline
In-Reply-To: <aa91e17f-0ea8-4645-a0f9-57c016e36a9e@gmx.de>


--t+WGy4gS/jMLitDQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I now got my feet a little wet with hid-bpf regarding something else, a=
nd
> > with that knowledge I would leave the long arrays in the beginning in t=
he
> > kernel code for the time being:
> >=20
> > sirius_16_ansii_kbl_mapping and sirius_16_iso_kbl_mapping are required
> > during initialization so they have to exist in the kernel code anyway.
> >=20
> > report_descriptor will most likly not change even for future models and
> > afaik having report_descriptors in kernel drivers is not unheard of.
> >=20
> > So the only things that could be meaningfully moved to a hid-bpf program
> > are the sirius_16_*_kbl_mapping_pos_* arrays. But for these is have to =
give
> > out some fallback value anyway for the case where a hid-bpf file is mis=
sing
> > or fails to load. So why not use real world values from my test device =
for
> > these values?
> >=20
> > As soon as there is a future device that can use the same driver with j=
ust
> > these pos arrays different, then I would implement that change via a bpf
> > program instead of a change to the kernel driver.
> >=20
> > Let me know if you too think this is a sensefull approach?
> >=20
> >=20
> > Another question: Would this patch need to wait for a userspace
> > implementation of lamp array before it can get accepted?
>=20
> It would be nice if you could test the LampArray implementation. But othe=
r than that
> userspace can catch up later.
>=20
> Still, i am interested in the opinion of the LED maintainers
> regarding the fake HID interface.

Comments from previous review were not addressed.

Most importantly, this is not a way to do kernel interface. We want
reasonable interface that can be documented and modified as needed. We
want to pass /dev/input to userspace, not raw HID. This is not ok.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--t+WGy4gS/jMLitDQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ53f7QAKCRAw5/Bqldv6
8r1XAJ9ybQ25RhK01bbqWLJeDafym4vE7wCfcUwxRi+iQ738e+ZzEgfvabQY5NE=
=upCv
-----END PGP SIGNATURE-----

--t+WGy4gS/jMLitDQ--


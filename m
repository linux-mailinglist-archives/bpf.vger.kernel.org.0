Return-Path: <bpf+bounces-54075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C67DA61D93
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 22:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE26880F58
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53B41C8631;
	Fri, 14 Mar 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="DJi/IKUS"
X-Original-To: bpf@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE71190676;
	Fri, 14 Mar 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986408; cv=none; b=dE5fuIu5k/pZk3amf0aowFkNUQ2fszjcWCLzPgyNkVy8Orr5Xk3NS79HX+JKUCLsM18pDtUeVfqqEPKCFeotBZndZcUF6RIvia6V+dmaPI/A+6FbzuluJq85916JaoFddnVlqSfQiE90EKKz57f+BH4HSBClHG5CXI2kVYui1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986408; c=relaxed/simple;
	bh=6LYyJEQSRLfRi3eWvEUXDA8dkKvwR9DDtj4F2tbzI8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI8B/9v8eaTgJE30kLMSc1D41uBMVN5y7kIBnBMQyXMECbaGuO5VXP3R5guMolWLZXTLl8Yrscf6gT3Vwer4CpYENvOSFjVZjauqLXcQPSyT3d2KuSGiqqQwqpwkWYCmxOvpKSaW+DvInwNRS22OZR7RtyAfIiNX1lZcj+iva/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=DJi/IKUS; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 24C141C00B2; Fri, 14 Mar 2025 22:06:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1741986403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=smPhwJATKEjWQ+pl7R6bsg4CgAkcIEX5UUZ9M/FhqZE=;
	b=DJi/IKUSvjJ2MP//YCjTNZjs/ita0pUBnuUuS7aGK4JeC/seuTz+RW7jJro2VKTnBHsvpE
	NMKSF3lW3eK/OR5z8bRq23Zin1mzdpQxO1mcGqi84VEktTeW5b+3zI1ZV8eJ5HdwtHrVy+
	RICi0A+z73e+F+oj/RUvNljmne5pHIQ=
Date: Fri, 14 Mar 2025 22:06:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, bentiss@kernel.org,
	dri-devel@lists.freedesktop.org, jelle@vdwaa.nl, jikos@kernel.org,
	lee@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org,
	onitake@gmail.com, cs@tuxedo.de,
	platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 0/1] platform/x86/tuxedo: Add virtual LampArray for
 TUXEDO NB04 devices
Message-ID: <Z9SaYi5sKOeKTvRA@duo.ucw.cz>
References: <20250121225510.751444-1-wse@tuxedocomputers.com>
 <aa91e17f-0ea8-4645-a0f9-57c016e36a9e@gmx.de>
 <Z53f7VNIgUWWFn9l@duo.ucw.cz>
 <b69e2766-2238-4913-ae2d-21d8716f2eef@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="75ovjfMpliKM0pqD"
Content-Disposition: inline
In-Reply-To: <b69e2766-2238-4913-ae2d-21d8716f2eef@tuxedocomputers.com>


--75ovjfMpliKM0pqD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Comments from previous review were not addressed.
> >=20
> > Most importantly, this is not a way to do kernel interface. We want
> > reasonable interface that can be documented and modified as needed. We
> > want to pass /dev/input to userspace, not raw HID. This is not ok.
>=20
> There are already 2 endless discussions about this:
>=20
> https://lore.kernel.org/all/1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedoco=
mputers.com/
>=20
> https://lore.kernel.org/all/73c36418-34d6-46cf-9f10-6ca5e569274f@tuxedoco=
mputers.com/
>=20
> And a shorter one before that:
>=20
> https://lore.kernel.org/all/30cbbf20-08cf-a69b-4f58-359a9802e86f@tuxedoco=
mputers.com/
>=20
> The brief:
>=20
> - LampArray is a standard that will hit the Linux world anyway.

Maybe. Still have to see device implementing that. LampArray will
still need /sys/class/leds for compatibility. LampArray still does not
solve effects. More importantly, it is not okay to say "kernel
interface is specified by that crazy document from 3rd party".

> - The alternative proposal via a led matrix does not even really fit
> keyboards, and does not at all fit all other device types.

We are solving keyboards, not the other device types. The other devices
can likely be handled by existing /sys/class/leds interfaces.

> Hans and Benjamin already agree with me that LampArray is the way to go.
>=20
> So after over 2 years can I please have a final decision on how to implem=
ent this?

For final decisions, you'd have to talk to Linus.

(And sorry for the delay, btw).

If you want to move this forward, place a driver in
drivers/leds/keyboard. Implement /sys/class/leds interface, but make
sure interface is clearly separated from the code talking to the
firmware. Then we can review that, perhaps merge, so users will have
something, and decide what interface to use for per-key control.

LampArray is no-go. Other options are open.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--75ovjfMpliKM0pqD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9SaYgAKCRAw5/Bqldv6
8iwJAJ9mnjTAm2a5BD6DI5p8cmuCHFDsmgCfQXGzc5tidZGm75RqL1iGB0UMvPw=
=uU6V
-----END PGP SIGNATURE-----

--75ovjfMpliKM0pqD--


Return-Path: <bpf+bounces-59903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9ACAD0792
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186631794DD
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA70289E3F;
	Fri,  6 Jun 2025 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20230601.gappssmtp.com header.i=@manifault-com.20230601.gappssmtp.com header.b="nj9ce7m+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC764289819
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231456; cv=none; b=PkK8KDPZF+bDGQhAVgHWQtiVqHYTaqtyB3DE91MdesUTVJhKcp8zJbK5zj6cQZLiChQMUGl4aQYG0LmbR4MVSMcAEOvyKI23fm4mSZlbpzLdabf0utiy/xYTG80W/VEh5IlADtfXFYXi+Ss0NnRLWmXUspzOD8NiRAtQCtb2h2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231456; c=relaxed/simple;
	bh=vPIpEDJIxKfhkTcu+dZoQqd7Um5ZG/Wxw0SY+43oEc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3e7zLphZzlR7OG+DOvo2v++176Nz2Idw2/R7ImKA9AJbhVHC7jr177iO+Y2UKezBGsZzjeQEHad7ord6wY/YULztR4OHJLSA4/r2uAkCPrbi+AXpADHTiuM5+W48R/KqnseuGdWUdQVxP1hFOhF17X7QbK62hmOkNq1OBprdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20230601.gappssmtp.com header.i=@manifault-com.20230601.gappssmtp.com header.b=nj9ce7m+; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-86d0c598433so71944139f.3
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20230601.gappssmtp.com; s=20230601; t=1749231454; x=1749836254; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjmgHwU8i86bDRJzXQwmHUhM8F0hM0j8Ly1R4pl+zL0=;
        b=nj9ce7m+LS9kWr33Xbps7GYPrBhf+zKcynj5dwMCfPAR0zjNQcc6m1BNkKACFCbJFd
         ZDMuElTUilOvCqtWdizp4+13QNKoG/VGJBst1IBEabO6HBHOB0++xy5UAVzsah7OHg6L
         HYL6TBWDsbon6Cl2iWF3JP8NWGH/Ac8qGYGctuSSzAFHub9JxHM4C/bldmKGinjhCQHT
         UFrZwc7LwCAuas1o0nh6GL3GLPYaK8e2PeD6C3KjkmBNxDkBw7nrCYS5YyJQFQPpmGFg
         wH0sSiLd/Lk6omwMMsXhYz5oXg/0wAOQpoBzNIKNbW20RLYFhDqOJtjJ+phmG4mHsAL6
         svAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749231454; x=1749836254;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjmgHwU8i86bDRJzXQwmHUhM8F0hM0j8Ly1R4pl+zL0=;
        b=HDbph0WUYYWJ7qCG+7gcPNHRMaANfu5K7dJN6vQfQzLuVMQD3LBssYtZOzLQGxz1Oc
         7GjYz+sU+tU9dPmaMou9zOaquOGEw4B7YpxJj29GsyQ+TN7ABP5/aLKmfSCH62Uo+ZcR
         WKn1LeXBALoiXPhfRTnwejtxoow0lMUTnBk6IvOVvhjaMaPxdbFdjIFVa+u3+66Ce5ML
         KvepmvPKRZJ5pBbDaYkVed1jWtFiA2LmxVJGMtrnCMrbg5+Lf8ycFBKOoOLGfxUyZ7mR
         /zDvXeLwSzIuWlbgbKHGK+OvCCLl+A6UAev7qlclP1BZsfVcjkBqo/zMg9ZXT0hhQ8N5
         6NUw==
X-Forwarded-Encrypted: i=1; AJvYcCX9ijrhiL88skRLipd9z18zsgAUL042yFqre5lxbMKOn/6SRoDgUFsAjn2BAO4gyODbjoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5eTuE0J2imhLwJT4lzrbbSt5l0/3UjP9c6yGdto7lmV/BLuK
	BRawwpfnc9NNECfoK/e5LIL5PedL6hWFhTL3bia4gBPj59KOwr3yf1Poi9aI+rI5IBv+5qM5qsX
	F6TzGXfG5EfI=
X-Gm-Gg: ASbGncsgUh0wLXQIb91XjgmsKAByaDONr0sodk4jolELzCYrBucG3Tfornq/nMIFqza
	bbNfxoee/A9Hh5yxgfAIYId8kVWEHRDB5BIoLTCiyUT9MNciOTgnokBaCpWFWFqDg6PZEGMqa7k
	c6AS7BWGxLhNJdpMLdoRPhleIcEbW/gNfgY96BRHb7pWfHzd8ycECiT5KXBvraRRDd0d3VgTYdF
	hk0PY3vzN6G4LBMGRKNTd6vB/rwMfRjSpNo6aKBgegSesnkR5H/pbPr9SkFh5n4KIM2Df7FEfb5
	tGwvnE2AeWJJbJ3LqF8x0pBZ2WHHnq3o/lcBcCxuxxT3yGzimIfknfD5hlfnAdtJPmWUXQ==
X-Google-Smtp-Source: AGHT+IEWFeYDgHF2aPKD60TtUWh5UCpHGwpxG1vz1cbPOgZ3p661GBvZaintCfTEI5JlxH7z7nAidw==
X-Received: by 2002:a05:6e02:1c0f:b0:3dd:a13c:b663 with SMTP id e9e14a558f8ab-3ddce495e82mr44503905ab.14.1749231453912;
        Fri, 06 Jun 2025 10:37:33 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-500df585606sm529431173.64.2025.06.06.10.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 10:37:33 -0700 (PDT)
Date: Fri, 6 Jun 2025 12:37:32 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: 'Eslam Khafagy' <eslam.medhat1993@gmail.com>, ast@kernel.org, 
	linux-doc@vger.kernel.org, skhan@linuxfoundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] Documentation: Fix spelling mistake.
Message-ID: <nlb4qwgyrx3iyw3tzy2t7f2t5z77k7rskqusfwfnh3aa6vif7x@zcdkq5tjjqt3>
References: <20250606100511.368450-1-eslam.medhat1993@gmail.com>
 <04a101dbd6f6$2635cac0$72a16040$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3ir7k5vvyhxzszp"
Content-Disposition: inline
In-Reply-To: <04a101dbd6f6$2635cac0$72a16040$@gmail.com>
User-Agent: NeoMutt/20250510-dirty


--k3ir7k5vvyhxzszp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH bpf-next] Documentation: Fix spelling mistake.
MIME-Version: 1.0

On Fri, Jun 06, 2025 at 08:17:41AM -0700, Dave Thaler wrote:
> > -----Original Message-----
> > From: Eslam Khafagy <eslam.medhat1993@gmail.com>
> > Sent: Friday, June 6, 2025 3:05 AM
> > To: void@manifault.com; ast@kernel.org
> > Cc: linux-doc@vger.kernel.org; skhan@linuxfoundation.org;
> bpf@vger.kernel.org;
> > Eslam Khafagy <eslam.medhat1993@gmail.com>
> > Subject: [PATCH bpf-next] Documentation: Fix spelling mistake.
> >=20
> > Fix typo "desination =3D> destination"
> > in file
> > Documentation/bpf/standardization/instruction-set.rst
> >=20
> > Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>

Acked-by: David Vernet <void@manifault.com>

> However the phrase "dividing -1" is one I find confusing.  E.g.,
> "INT_MIN dividing -1" sounds like "-1 / INT_MIN" rather than the inverse.
> Perhaps "divided by" instead of "dividing" assuming the inverse is meant.

+1, probably worth fixing in a follow-on diff

--k3ir7k5vvyhxzszp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCaEMnXAAKCRBZ5LhpZcTz
ZDuHAQDW8/3XFM2RbdM24rGGM4R9Zkq8guM4rEpeulA7x2GllAEAzHxglTp3OZoS
E4RHfjMtOSFTIjMqhsGUXgg31cZ7gg8=
=p148
-----END PGP SIGNATURE-----

--k3ir7k5vvyhxzszp--


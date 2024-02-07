Return-Path: <bpf+bounces-21439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936D84D595
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D561F2606A
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236F61350E2;
	Wed,  7 Feb 2024 21:56:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865C1292FB
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343003; cv=none; b=kxSxOrAeTT5WHw8abDnewxVKJ0JlGAjfY9xlnbo2zjXO5XlZyPBg5K+/7hMM1GNMJIMK6XihP6vF1rAb0Kahuj0e3Vx+K+MRxUKvcV8ahqlzP13mnMYJpF1rmWNcAJXeDkTbMT39HNb98Bdl9Ip+15V8mnvOgMQblusqC7MDh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343003; c=relaxed/simple;
	bh=0YyhITRK5mdjxg/KVU5mGvmZsxAtmQOKw0M9GWpd8gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPMOIvuct7NBq5tZecWhO0T96tx1WccrVp6o9csiaDH1z2hrgaKdQv6z8yHmgwCRnPjUKdpRyt8NeF0rKMyp3VYSi1vzqEe1Cq4xq8cZPFxlL44ed/SWoWtOqyGFomLDv+NG4pKUy2KU3Cp0qawTaZMGa3WzoeNsVlzB/1EyM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42c3a75c172so7894761cf.2
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 13:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707343001; x=1707947801;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bg2P+nAlDQNpEHQ+LQLQYmHmXjg4pcyUd5qZttno0P0=;
        b=DwUKNxN9wY3bjeCopbh4rLfbLSB5cqhUXMytRxaWj1Ah+MdUrtjnT8+yzpET3IbI/Z
         wuI43hExn6IUjxtdjtnWiUNJRC2yr5LmFt666DFukHp/NZYanIcTJD+oUb0rcttsVhRX
         M81hqOKqCAvpH/1NtCggLdAI/c9GSp0Wehv5Ds6uCBy8d6ZnhUkuyhqyvd+fSX00YysG
         qmsTgQISoy93cs1sfVUB6zLDkDXWnJwIY1Jn6PR2qXkU7xYglrTLbOaciwPyA/DixUWj
         2Ahf0aeatYBJKdgieIjjJ1DADCZikIF7qPiKDWUbGsDXKp943y/7ma1vIc28Xl5ZNgoe
         TIog==
X-Gm-Message-State: AOJu0Ywq01Gzi4qk74ibyphzbXh8zDhtGDgWYyI+71QoFhnbeNoajXHB
	Q1VW/7hPpbKeDTkBlC+aMyrzxeXeTEItQhEHWOCzv9+Lzkd6RmQz0mRZo7U8j70=
X-Google-Smtp-Source: AGHT+IEopWPDKZL+TxqqWBCQwz+doNz54tR3AovKB0uz9wb2W4XYyGp5E5KxBQpan7ZpZAaNo81I+Q==
X-Received: by 2002:a0c:e487:0:b0:685:8ac0:c027 with SMTP id n7-20020a0ce487000000b006858ac0c027mr6124477qvl.23.1707343000858;
        Wed, 07 Feb 2024 13:56:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5X/xo0s9/zT3MMymAAa6Fp8Pb/4bMgaNvnk+apoiI6RST1nBfs0vG/16bZgbLaNMcqJO6CnC0wI1/4A4=
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id d10-20020a056214184a00b0068c4b445991sm971651qvy.67.2024.02.07.13.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:56:40 -0800 (PST)
Date: Wed, 7 Feb 2024 15:56:38 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: 'bpf' <bpf@vger.kernel.org>, bpf@ietf.org
Subject: Re: [Bpf] ISA document title question
Message-ID: <20240207215638.GF2087132@maniforge.lan>
References: <134701da5a0e$2c80c710$85825530$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ojOD+1PuRbswj7c9"
Content-Disposition: inline
In-Reply-To: <134701da5a0e$2c80c710$85825530$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--ojOD+1PuRbswj7c9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 01:39:47PM -0800, dthaler1968=3D40googlemail.com@dm=
arc.ietf.org wrote:
> The Internet Draft filename is draft-ietf-bpf-isa-XX, and the charter has:
> > [PS] the BPF instruction set architecture (ISA) that defines the
> > instructions and low-level virtual machine for BPF programs,
>=20
> That is, "instruction set architecture (ISA)", but the document itself ha=
s:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BPF Instruction Set Specification, v1.0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This document specifies version 1.0 of the BPF instruction set.
>=20
> Notably, no "architecture (ISA)".   Also, we now have a mechanism
> to extend it with conformance groups over time, so "v1.0" seems
> less relevant and perhaps not important given there's only one
> version being standardized at present.

Not only this, but we may extend individual conformance groups to new
versions, while leaving others the same. So versioning this document
seems like the wrong granularity. If we want to version anything as 1.0,
we should probably version the conformance groups.

>=20
> What do folks think about changing the doc to say:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BPF Instruction Set Architecture
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This document specifies the BPF instruction set architecture (ISA).
> ?

+1

Thanks,
David

--ojOD+1PuRbswj7c9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcP8lgAKCRBZ5LhpZcTz
ZHOIAQDTAXkEIano23KsMwbhejXxWvejzWCOiYQFzMYe4yC59wD+PGyg3+NJDn7z
y9J6NVv8kPRckGGsIp7OLpo5FL4HaQI=
=YpgB
-----END PGP SIGNATURE-----

--ojOD+1PuRbswj7c9--


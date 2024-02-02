Return-Path: <bpf+bounces-21105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29349847C84
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462821C23C25
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A2E85958;
	Fri,  2 Feb 2024 22:47:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F933D2
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914032; cv=none; b=XVgkNZkXEE2QWYqopBqKLNzlNRge0hTHPcmMfFA+0//Aa4iZvue/gnQ/aZ7NyHKFpDlJI1999wuCGyLeAARqw/AEm4mIlmM55evehNWQrDVexFfLsV8PyqDhqDcv6fGkY28hBuTB6pB7MHcY0q5bibsQgFGgIdpe6Z/Vkw6aVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914032; c=relaxed/simple;
	bh=pLZqAQZAmSACjZ0lsbSgV4+MZdp4zXv3rWbCR6D7SII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1xce/DLh7iRpxS15BdibSc2Yrq+RWdjXMThvdVi963x15U3kLFmn9tw9nJGcfFxKHm33uNg2Y9Z4EBvI9xlNrXW76KC4GZgfn7RZuWTQ5sUubI541YsfXEwO4dJJmN8hnvJwQn2JDKdM9jinqjtAkRZgcEzh/Qe17zYHujCnpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68c4fb9e7ccso10885866d6.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914029; x=1707518829;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrIqKBXYRJ2iii7fOSRikAKu8sNmRspAkC6/qmp0zQo=;
        b=NjMkMfoDKFOkS4+uTQY1Eb4NqpndMOx+SzoPjHJFs9P2MVuGRTyJkrvGsKOwPUKOzp
         j98JoVVGwI8w5UCOKG8gzXvDYijWXCaj6QK6hZskLlgunFmiNy8b0V9HRpSrwiNF9JNY
         DCAiaRxSt1sxAvM+2wLg7Uvhk1CfMUTkN5BX99RP4MG5g7D3qp3SThC8mV/BmxEbDACB
         5gaBYXNUalM/x76/CaSVgRDt+Q4eV9SdjFPFIZVauzKAIqkDDymmta3ZSnbswvPMi3dP
         ha8gusNA/0uQq4lRr0NVYO/ZZI4dZgXPQD+SJI1oy9GDCjPQ7eR5gqm6z8XZD50/SU6u
         EEqA==
X-Gm-Message-State: AOJu0Yw4KDC9rZ6XF99cD3ZSvVp2qHwcrTnm/Yd55LUi4dgIQ7ZXj/gr
	w6T/VJQsvI9W8D9h4RIqWx1c03uZXIxdpH/CRGd9V8dZoQZtMWin
X-Google-Smtp-Source: AGHT+IHjF4zDjT4o+jA3HvGBg1KWYLjcY0RjXcXALz0lW7xnTbCnauUA66XiSY1P6VZaZr/818TrMg==
X-Received: by 2002:a0c:e3c9:0:b0:68c:61fc:680a with SMTP id e9-20020a0ce3c9000000b0068c61fc680amr3293035qvl.25.1706914029609;
        Fri, 02 Feb 2024 14:47:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6d6du1kh3wM4g1hCsPSg/Os6OcZa7Kk0BXGPAfe6SZczQ9g8Lxd3rlXLMDnqihMuXHZTLxGn+TAmyF2RbQYlkqFtZzIB15A3kON9++3VPvn998Q==
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id od17-20020a0562142f1100b0068c89d8eb53sm674898qvb.81.2024.02.02.14.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:47:09 -0800 (PST)
Date: Fri, 2 Feb 2024 16:47:06 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Expand set of initial
 conformance groups
Message-ID: <20240202224706.GA2244152@maniforge>
References: <20240202221110.3872-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ili3dk1y5KBFrdpt"
Content-Disposition: inline
In-Reply-To: <20240202221110.3872-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Ili3dk1y5KBFrdpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 02:11:10PM -0800, Dave Thaler wrote:
> This patch attempts to update the ISA specification according
> to the latest mailing list discussion about conformance groups,
> in a way that is intended to be consistent with IANA registry
> processes and IETF 118 WG meeting discussion.
>=20
> It does the following:
> * Split basic into base32 and base64 for 32-bit vs 64-bit base
>   instructions
> * Split division/multiplication/modulo instructions out of base groups
> * Split atomic instructions out of base groups
>=20
> There may be additional changes as discussion continues,
> but there seems to be consensus on the principles above.
>=20
> v1->v2: fixed typo pointed out by David Vernet
>=20
> v2->v3: Moved multiplication to same groups as division/modulo
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

Thanks!

--Ili3dk1y5KBFrdpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZb1w6gAKCRBZ5LhpZcTz
ZGZvAQCC3wAzgaIuCEelr2aHX1bGY6YEKeTuuy75tRwNRbMT3QEAl2VdjeACdKCY
uictak+1vbD3uH7X9TbYwBsFwJ001AM=
=lXeP
-----END PGP SIGNATURE-----

--Ili3dk1y5KBFrdpt--


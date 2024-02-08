Return-Path: <bpf+bounces-21561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDADD84EC4C
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 00:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C40E1C22BC6
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9769650260;
	Thu,  8 Feb 2024 23:13:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA444F61E
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434018; cv=none; b=mGUzzSJDzTtJbPCNhKWiyDZoL+BR5kGkOOPNi41fsjwWxcFANPNcY9SrGgNbtcdvdMNySHNYjFR7k2PLaGT7H6fBV1Xbs63lxcZG6Nwt06wFC7C7r8ZfmJaxWXhQtdv3s6wNJGbrN5uEqe/VlykNZeZd9V8c7+r9TYjmw0fnS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434018; c=relaxed/simple;
	bh=gqlPDvi6YrGCKPhl4PDZRQYo1q+Ry7Szzj7GPwmiJbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i29es49gLrHo2mw+DgBNH28HPsQPgSJPaFTcXTTzZfAQkh16EqZ/q82yuxiXSlK9f/5BoC5RmcjhQ7d0EV8Ad1RbbREfpcOdFx6YxoNyNwrUNTQykJ6yNIlurHMzfpC9aUNAcvKKlL+8TswnSFCzqISp7DFbw96UQT56zuZK0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso150522241.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 15:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707434015; x=1708038815;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmvYoTRVGkpbw6I/4s7nR94bpI+sqaWfNwXudh0lI/Y=;
        b=EMWgupHPURutAtZcriOtbNyAHwatMaQ+zZ778kS8+3DeCLdCoIWTSo9DrqU3z2KLhS
         TgAml6BwVsmNNji4SaqSwBDwqFuKc5ghLJM64DxaDTvzRwlwgxZnqSt5ZivIHsaj0Fem
         Up+8uVoPgUTeOxrS5hvXKC95CfFs7zE2w4pDOG1yqp2egj24QssrhryVwaM6Va1wd9b0
         3qruAFAN7GAD997Uw3diP3xGrHgRrt3uByHxMUAjr4QiP2cupClGOskP8wXBpsNVr6Yu
         mRwyA++iIFKMhxriuSlpdtHdJLRkcasS2Q92qB7UztL3KCSibT9mFKkq7+U3J4nawVi0
         M5iQ==
X-Gm-Message-State: AOJu0Yzxjkqlhwu9+ogHLu3L63aicLDlqvnEoRYG7BUboIQzqry774iz
	5SDe/SraAD4gvWN/7NWAaclXAZUDBnEBaWObuSu0z9vznQkAxGSK
X-Google-Smtp-Source: AGHT+IHrgvWJTcf/vSwztkbsVW1a/C8Lr0tIftA41IqOTMHxPpnzxa26uYFhA1YgOY2B+nXMdAxjXg==
X-Received: by 2002:a1f:e042:0:b0:4bd:7bf5:934c with SMTP id x63-20020a1fe042000000b004bd7bf5934cmr76499vkg.4.1707434015095;
        Thu, 08 Feb 2024 15:13:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSCl/QOE4NMvO3Bwgkyr3xBgcid0l8Z5Zx9J9GOi9GFIOOKTqDe9IHBGA1kTGZM+UhmC6XQzvaZexW1YjUVyboGfFDas6Zoulky63FNMODqa4pqQ==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id kf3-20020a056214524300b0068cc289c936sm248022qvb.31.2024.02.08.15.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 15:13:34 -0800 (PST)
Date: Thu, 8 Feb 2024 17:13:32 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: Update ISA document title
Message-ID: <20240208231332.GA3488427@maniforge.lan>
References: <20240208221449.12274-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FMSKXUZyyNt3i7q2"
Content-Disposition: inline
In-Reply-To: <20240208221449.12274-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--FMSKXUZyyNt3i7q2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 02:14:49PM -0800, Dave Thaler wrote:
> * Use "Instruction Set Architecture (ISA)" instead of "Instruction Set
>   Specification"
> * Remove version number
>=20
> As previously discussed on the mailing list at
> https://mailarchive.ietf.org/arch/msg/bpf/SEpn3OL9TabNRn-4rDX9A6XVbjM/
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--FMSKXUZyyNt3i7q2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcVgHAAKCRBZ5LhpZcTz
ZFC/AQCcRjT2NDna7nS8G86pK5FYQDmoRyJuPvpczFRKXVL+egD+JKn7tA79Bzbb
8HX9tSXrmykI2aBY2R8L6ZU/ix52aws=
=3wXO
-----END PGP SIGNATURE-----

--FMSKXUZyyNt3i7q2--


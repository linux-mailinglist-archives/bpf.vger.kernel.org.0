Return-Path: <bpf+bounces-27467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DD18AD4F7
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC928139B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A4715533B;
	Mon, 22 Apr 2024 19:38:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB6155331
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814732; cv=none; b=OuP0GiV2/Dr1CyDVrkybuXZ9rZywOu+agrnOKYBs8JV+bjzTEK1P9b3OnOG/dqd7TNUS5teoh3tIgntKfxy3RLaLY5RE29+EssqZRI9FgUMa10dPtyPQYLq3BTsVc/I0TwmU6A4gRGlCxa4KXIzCdAPqXO20QX0sca2YVTb154c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814732; c=relaxed/simple;
	bh=+NgV8/5DqHMjjjqZlB9XgOodX07KmQNZOUCmDihykNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XivpUqzY+4BHMh/74Orr6ZVmUvikb5TZ523o3gz4M99y4uFV6+em5b8oxqrgnFVfG2ezh2DB20urv2aTPQ1hqplMAH55jHZHpFxqH46Mu3f5R6ewGGE9D2rf17gXeulN0/YfacxCh3+GMsWwLtiBmZs3h8du+VbQAJomMpFIK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de46da8ced2so4717441276.0
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713814730; x=1714419530;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEBGdHu7pues5aIj8L/m4SpnO+cRtOw1iKcBcs8MCVs=;
        b=bBxKlzbn/BCrXDCee5HmJwRp2HRui5CsqzYaO8xqbYVvoH52n+4gRzT4z0/I8OrxiY
         i9l6zPm8SPVQLrOdIMLx0AgwO4DBktsgiHwjd8sBXS+gtRrIjx5rkJ2rxontf9v1acFa
         bh+ATVZkqIXqcapp45leOYD0GGP46t7fV4tvvqv8LEyFSDRGj2f8QSrt88UMZBtU0L+n
         Y0OT9EJ2HdAN2xbyAzRBUbWp05y6qY5WQ+uGFqAC99R/+gxoeMcRS229dvFh8SOOTlAc
         Ofr+4QKakmBhKi7jhTeS+e5vY2sYR9Pzu1KvL1TLCbBIAE94fQyeSX1xvAq9zMq3lskn
         hUvg==
X-Gm-Message-State: AOJu0YwNO2+jMvWUiRXf9+1jjgovQaO7/T6Ubr5Wsf2lFSxMujinBIuu
	worjPIp9VZS/pubGtlRnM4YyMMcdquUYDrHQ4qkU8H2NfVxpfd6c
X-Google-Smtp-Source: AGHT+IEki3iam8MD2m3eNX7SlyCAsv1ygau1fUpOiTaJxtIawP89cBJgfr/xPuIR4SvWLd22vhqUhg==
X-Received: by 2002:a25:d00d:0:b0:de4:6bf7:d848 with SMTP id h13-20020a25d00d000000b00de46bf7d848mr11053139ybg.33.1713814730188;
        Mon, 22 Apr 2024 12:38:50 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id s90-20020a25aa63000000b00dcc70082018sm2196675ybi.37.2024.04.22.12.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:38:49 -0700 (PDT)
Date: Mon, 22 Apr 2024 14:38:47 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Add introduction for use in
 the ISA Internet Draft
Message-ID: <20240422193847.GB18561@maniforge>
References: <20240422190942.24658-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8RhQd7bHZMF35SjI"
Content-Disposition: inline
In-Reply-To: <20240422190942.24658-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--8RhQd7bHZMF35SjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 12:09:42PM -0700, Dave Thaler wrote:
> The proposed intro paragraph text is derived from the first paragraph
> of the IETF BPF WG charter at https://datatracker.ietf.org/wg/bpf/about/
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index d03d90afb..b44bdacd0 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -5,7 +5,11 @@
>  BPF Instruction Set Architecture (ISA)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -This document specifies the BPF instruction set architecture (ISA).
> +eBPF (which is no longer an acronym for anything), also commonly
> +referred to as BPF, is a technology with origins in the Linux kernel
> +that can run untrusted programs in a privileged context such as an

Perhaps this should be phrased as:

=2E..that can run untrusted programs in privileged contexts such as the
operating system kernel.

Not sure if that's actually a grammar correction but it sounds more
correct in my head. Wdyt?

Regardless:

Acked-by: David Vernet <void@manifault.com>

> +operating system kernel. This document specifies the BPF instruction
> +set architecture (ISA).
> =20
>  Documentation conventions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> --=20
> 2.40.1
>=20
> --=20
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

--8RhQd7bHZMF35SjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZia8xwAKCRBZ5LhpZcTz
ZOxtAQCC8mL+DePpWppZXI1Z0mMOZMMCw7YA7kumKNMNqImIfwEApR2e+CndkHPw
PmKFAhUNpPyiIEbcTPAs6hBY1cuiEws=
=pj/+
-----END PGP SIGNATURE-----

--8RhQd7bHZMF35SjI--


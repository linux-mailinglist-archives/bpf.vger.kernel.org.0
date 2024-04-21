Return-Path: <bpf+bounces-27326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205828AC01F
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 18:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059751C208CB
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F418638;
	Sun, 21 Apr 2024 16:38:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3A915E96
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713717527; cv=none; b=KVvYCrgC5kLnOu2j/eiBJIqAA52Kq5NpFJmJUzaukiXKJ7wIMy2dz+waLHvdhI1Ct2cR16e+LDYntyLRYcZvEIL2fbAiD32URJcAe5NUNUIEpMCoaaVk2LH8IkuyWIczBsnUZ74JpuT8ZbffoIIMrJojVQNCyi51jClCdx813rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713717527; c=relaxed/simple;
	bh=Nm5dkH/MIwEnF98ON8uINVkKwhvPZphzWtcRP1tSiNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyXmT+8Hv81J1PhfFu6B2ufXFZJ3tGJoxKMb/iwmXU1PLak2CratEE4ziQd97eCfdGyzfaPoW4ckQibhRUMWQFBattlHjg8Pwu7NWt9epaTvtyVyP1DNmzlPWA0fP1CB1/CGL0y4vViRAW+GXbc32M/2+8sQ0FHO1LNByPfmvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de45e5c3c84so3357109276.1
        for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 09:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713717525; x=1714322325;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOR+AYrLtNL7l8v3dr2Gt+pTc8obIcyCPx3GHPRsTzw=;
        b=oI9eeC5CMNd/GyYDlgl3wFR/rd5BZfREuizJRHONBNSr3nX0bdTIBgoR6fd+PqjWCU
         XTxq/3THLZlbt05/finOobmwluOgC8BZ4TmCqckbYC7Rwn7xkPK99Qo9N3rtjmCIb+Rr
         fUyPr8uEGOC32ZVEq5fyVodpOxrchcXbLRtPU8YU/a+m+CExfa47w+EZcbNjjg/ZZT8I
         arhsX4GALwrz7rL/atLX7vBAPHbii5IWnRvcM1X8samxG367ETuKzilKgZWeZ9FTeSYi
         fNTa21uzDd/V57YW1yxDQTh8RD7f6z/qTnOUTP2M+8QAGuq3TbmyMnCqODPm4LNDLVCx
         tHtg==
X-Gm-Message-State: AOJu0YzIM5IslKSk6BeUYCPM4sadVrgcSfMUihGrogG8c3YLM0O0i5VF
	5kKjG58Dj9WeP6MQvYtOZsW4zNnsEYnirBJ+4LzmUUDZQ0OUxvva
X-Google-Smtp-Source: AGHT+IEIU4GT4jJcNLtyp0i5A8mETarP2WuC5OjV9Q4N6PZyYC15JesqzB5ipvv0C8G3tP5i1oF0fg==
X-Received: by 2002:a25:ad5f:0:b0:de0:e368:fa59 with SMTP id l31-20020a25ad5f000000b00de0e368fa59mr6692508ybe.31.1713717525060;
        Sun, 21 Apr 2024 09:38:45 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id 126-20020a251984000000b00dc230f91674sm1695641ybz.26.2024.04.21.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 09:38:44 -0700 (PDT)
Date: Sun, 21 Apr 2024 11:38:42 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Fix formatting nit in
 instruction-set.rst
Message-ID: <20240421163842.GA8626@maniforge>
References: <20240419213826.7301-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lHT9sOIxyn9YAd6l"
Content-Disposition: inline
In-Reply-To: <20240419213826.7301-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--lHT9sOIxyn9YAd6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 02:38:26PM -0700, Dave Thaler wrote:
> Other places that had pseudocode were prefixed with ::
> so as to appear in a literal block, but one place was inconsistent.
> This patch fixes that inconsistency.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/standardization/instruction-set.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 8d0781f0b..02fbc286c 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -370,7 +370,7 @@ Note that there are varying definitions of the signed=
 modulo operation
>  when the dividend or divisor are negative, where implementations often
>  vary by language such that Python, Ruby, etc.  differ from C, Go, Java,
>  etc. This specification requires that signed modulo use truncated divisi=
on
> -(where -13 % 3 =3D=3D -1) as implemented in C, Go, etc.:
> +(where -13 % 3 =3D=3D -1) as implemented in C, Go, etc.::
> =20
>     a % n =3D a - n * trunc(a / n)
> =20
> --=20
> 2.40.1
>=20
> --=20
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

--lHT9sOIxyn9YAd6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZiVBEQAKCRBZ5LhpZcTz
ZMzfAQDtwENLh06G3HGQy/TJdzm4/CEwrf3xprx5S32173pTqAEAm6eBaNsnA9wS
MTXrVLok218g13i4nF0nn1Y50ISofAc=
=8SDC
-----END PGP SIGNATURE-----

--lHT9sOIxyn9YAd6l--


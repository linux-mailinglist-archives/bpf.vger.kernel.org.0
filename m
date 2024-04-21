Return-Path: <bpf+bounces-27327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EB68AC020
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B1281600
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53E218E1C;
	Sun, 21 Apr 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xFu5TVdO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xFu5TVdO"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E217BD4
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713717539; cv=none; b=jnmvYK4vL5FbhSe9gmBueJAiKMLvX6ilr/x6m6Rkxo1YGJv9Cojk5rGXZVkM1ZLaUJ1HJiNjVNGeEBQW0XscLnRL73n/3DcuQ5CXw3AtdpAnkndDVAfFQFZvZwI9c95YBFwJ0o5mDfJiYeR7d2ll/UAQcfYQ2O5oH/hbX3SjE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713717539; c=relaxed/simple;
	bh=8aqwy/0kds9147S9YGGPE0RQ2k0n4nmGJc0pnx4tELQ=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=kWNYPIHsIrLHgXJl5OMsgE/Cj7/36ih9qfdlEHyJUv3dG6aNGt76FjypHIqJud2veApYfBys3mMqMlZYaG6A7m8mgxBJ+CWkOLduf6KGYa+Vu0Sgw5oElTmfunPft87JDULrjJiKFjlMf5YYieecxMJDT99iAdE0KvE871e9uE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=xFu5TVdO; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=xFu5TVdO; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8F42AC151073
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713717531; bh=8aqwy/0kds9147S9YGGPE0RQ2k0n4nmGJc0pnx4tELQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xFu5TVdOfdshVqxMFSAZh6AWlT6KqnPMF7WpxY25Ze9KNz0ovKCXaomZUmlc17yHJ
	 Rnr8FoTKSiy1gTm+gwcf4zOivpvksH7xqk6TRBz9vStF7P6cgtCAWZMVuWk40fdy53
	 K2ILFAL3H7Z2zOFv1EUrE1we07svndLHgpjEbfE0=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sun Apr 21 09:38:51 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3207AC14F61C;
	Sun, 21 Apr 2024 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713717531; bh=8aqwy/0kds9147S9YGGPE0RQ2k0n4nmGJc0pnx4tELQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xFu5TVdOfdshVqxMFSAZh6AWlT6KqnPMF7WpxY25Ze9KNz0ovKCXaomZUmlc17yHJ
	 Rnr8FoTKSiy1gTm+gwcf4zOivpvksH7xqk6TRBz9vStF7P6cgtCAWZMVuWk40fdy53
	 K2ILFAL3H7Z2zOFv1EUrE1we07svndLHgpjEbfE0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E0920C14F61C
 for <bpf@ietfa.amsl.com>; Sun, 21 Apr 2024 09:38:49 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.648
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id upcTD9Tsypd5 for <bpf@ietfa.amsl.com>;
 Sun, 21 Apr 2024 09:38:46 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com
 [209.85.219.175])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 2A99CC14F610
 for <bpf@ietf.org>; Sun, 21 Apr 2024 09:38:46 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id
 3f1490d57ef6-de462f3d992so3769003276.2
 for <bpf@ietf.org>; Sun, 21 Apr 2024 09:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713717525; x=1714322325;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOR+AYrLtNL7l8v3dr2Gt+pTc8obIcyCPx3GHPRsTzw=;
 b=Xd62tacFh3GromM0iBLH9nYc+S+UD4939SYaxZNspIfUb7qqzhIDJkcYF1eqAudiQb
 /7K1/O9ALBXLE2Fqtsf6uFBMoiNSVF6yKnfazhgfKETrNsc1fKZ7RPAum/1+3IUel0yu
 ucsbVM5uLN2G4+37/jQqgKqKjEpW8WbPOpEiktyxw/2Q6faTlOm0rE7kounZ32VugvEy
 n+zzFvxpSSrVWzAN7d7j99+je1pC5eSu0fb2YuyEWHElMqUsqtn8UDy3kySDCCdjMxVP
 7WRG5ocA0K1ywZXMuJYVdTm8j5vx09lIQKVNvjtQCUKUMbqNGvUhZVEZiusANiBb9Z5X
 xirQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1YfzrkJGsgTvU5ovNA5NLt6v3pdLRQteRZe6ogcrLtcHVG0ne36MEn6/kMk0TEDSNpT1MvJ9u/Uu2W7I=
X-Gm-Message-State: AOJu0YyKrzjwx4s/LXZxRxfK9HMNy70QhzQQSaD/khDstCeIwYCj8VEI
 cHxoRDn6FQbvCUoXvSOv6g2Tl5BGEq1JWPixCevO3DnfZVoGixPfaJ1l5g==
X-Google-Smtp-Source: AGHT+IEIU4GT4jJcNLtyp0i5A8mETarP2WuC5OjV9Q4N6PZyYC15JesqzB5ipvv0C8G3tP5i1oF0fg==
X-Received: by 2002:a25:ad5f:0:b0:de0:e368:fa59 with SMTP id
 l31-20020a25ad5f000000b00de0e368fa59mr6692508ybe.31.1713717525060; 
 Sun, 21 Apr 2024 09:38:45 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 126-20020a251984000000b00dc230f91674sm1695641ybz.26.2024.04.21.09.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Apr 2024 09:38:44 -0700 (PDT)
Date: Sun, 21 Apr 2024 11:38:42 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
Message-ID: <20240421163842.GA8626@maniforge>
References: <20240419213826.7301-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240419213826.7301-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/i5L5GxOf52kQpSjbU_PLZefSx58>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Fix formatting nit in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============6008511198417599270=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============6008511198417599270==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lHT9sOIxyn9YAd6l"
Content-Disposition: inline


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


--===============6008511198417599270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============6008511198417599270==--



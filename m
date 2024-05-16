Return-Path: <bpf+bounces-29844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7798C73F2
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53215282505
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B603143751;
	Thu, 16 May 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMMZSXSN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259514374C;
	Thu, 16 May 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852191; cv=none; b=hV7DTVR9LgWsh34aUBKfqHMGazqyTr1KoVQZVJvgPoHjA7v1mWeLORGIrmMoQfhaCnVHwO4Uz8Jhmg2rzb88VSzfAasiNiQyszOK3sWrdZoF4MLQMV5Ejkr0DBQ0NH95Ns1gQ/vX2nXMW0jydc5Lyig+o4/afALteDHrorpJ1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852191; c=relaxed/simple;
	bh=J6sD28lgfKh27e2j9CLxVNjQggPRio4KaVElzKmuzCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZJ5R5Qo6domSEGlBqlX9ea0jgjW11jwO1oh3V65PoB4doAq3si3Zl3HkmmPblgdKN+EAGtOwdXLrJANilmkcUjgNZC4nI1ff+HH2R9UuQfyvGs8aGPiCHLqKwWgRfsGrAdjpZS6ZXVDQ+H0cQIL4VX4spvxsX3oW/+GTRc9zho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMMZSXSN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5723edf0ae5so2799256a12.0;
        Thu, 16 May 2024 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715852188; x=1716456988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvXv+pGqbfkwd6X1s9SxJ9Fq0l86c61XKwIlx/950E4=;
        b=fMMZSXSNrkwdx6XFr8ci++sBH50hbGoOS8jiQgJ7WrpXjtKptvS6trjmK1rQ3HDtJD
         tgXMTjXCr62om4vatG1He1vIW+QuyTB081IBJ5Ojk7o71TyvSMNGef0OAKZ61oWJz8Yy
         bByrm68rhqkx+Tf3U3y6sEQs/UEIOMBAPDPPOd8nSWdTkMj2Ni/PCeV42LXIvpUOYeIt
         sqxkQtFY7ekQb2imeUfHpakc9qUoK+aIiX/310M4U2fvYDR4uhWWV4rzqXlNDaj7qJMI
         txJWwgzGMFUmXJVCgRjKPreuaeJEbCxfluVlRzgCARYZ56QkQ0OXTAhLI38DeRKq4vgl
         poAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715852188; x=1716456988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvXv+pGqbfkwd6X1s9SxJ9Fq0l86c61XKwIlx/950E4=;
        b=bWHrK3mHJpcfg2RTACaSyXondmjIXUIfn5ujgfoj5Q6wkzbCqyInBx54hyk8v5rwPV
         lW4KZPCLYHfsKorQh+rlOnwrPzwVryGHHKbTw/8SwUy0VAMQ/Zk0pNsCDJWi0vI/1Jlr
         4SOq0pimejG2bphx30hlYI/DB0TofQeAbv401PZbQjGxAQWiGKGAF8swl5pMdTqP1jo0
         GxsyaBd6YLTkTrsOddHFWYxvtpTB0PE1y6oyAuiKzv5CtXHXfTuT25r1rXdbnVqGDH7Z
         MzAIyu78waLKeT7Dc1LhM9AgPeyK9ktlW0yze88ZG2sON1+azGEM2mFyVGQ1eola1ECf
         1VtA==
X-Forwarded-Encrypted: i=1; AJvYcCV05EJHKB8KyubZWc5Cp77UQZ5HzIsdfT2QQwE5ma1Tn0kwT/pHfaAEozaHwqNvu4KJ7cizqupxmMmH7Wh8/TqDjPAsuvODQFJFg1NpkS1m8se2Qnp0mFUMj7pdC6MmtbZa
X-Gm-Message-State: AOJu0YwfwHUxAR0Mw1iyxQrJuTIW+40PkDVmVz9OUI2ReOcS0HYlt7b8
	yaEOSrzpanP+9nROC948EzsvtTP52QLVhlrgskXYmdjhKLxr/ygF
X-Google-Smtp-Source: AGHT+IHHV69RLJNpaBjl5GbwCsRINJCGP6ZRDgLVz7LqC3L1sToOsa41I3DZilJuFLG+fWtHkZZEFA==
X-Received: by 2002:a50:aada:0:b0:572:7b08:d497 with SMTP id 4fb4d7f45d1cf-5734d5c17acmr13034438a12.17.1715852187856;
        Thu, 16 May 2024 02:36:27 -0700 (PDT)
Received: from localhost (77-162-229-73.fixed.kpn.net. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2c7de4sm10127159a12.63.2024.05.16.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 02:36:27 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Date: Thu, 16 May 2024 11:36:25 +0200
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Jan Engelhardt <jengelh@inai.de>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>, J B <jb.1234abcd@gmail.com>
Subject: Re: ANNOUNCE: pahole v1.26 (more holes, --bpf_features,
 --contains_enum)
Message-ID: <ZkXTmTvII2PDqVvx@localhost>
References: <YbC5MC+h+PkDZten@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sY/nlHJyYy4WYvdJ"
Content-Disposition: inline
In-Reply-To: <YbC5MC+h+PkDZten@kernel.org>


--sY/nlHJyYy4WYvdJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 04:39:21PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> =20
> 	The v1.26 release of pahole and its friends is out, showing more
> holes (the ones in contained types) the ability to express the BTF
> features to encode, to simplify the addition of new BTF features in the
> Linux kernel build infrastructure, a way to find the enumeration with
> some enumerator and various fixes.
>=20
> Main git repo:
>=20
>    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
>=20
> Mirror git repo:
>=20
>    https://github.com/acmel/dwarves.git
>=20
> tarball + gpg signature:
>=20
>    https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.xz
>    https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.bz2
>    https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.sign

Which key do you use to sign this?          ^^^^^^^^^^^^^^^^^^^^^

>=20
> 	Thanks a lot to all the contributors and distro packagers, you're on the
> CC list, I appreciate a lot the work you put into these tools,
>=20
> Best Regards,

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--sY/nlHJyYy4WYvdJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIhioiE2Z74CX+BiELwJgSGECT1EFAmZF05UACgkQLwJgSGEC
T1HmwBAAsxEaGM+xrNDoTEWojFRH8sL3fd/gaegb0oUzRl/+F+EoYjinB6N8UpZe
3wrWYPJLAdb5jZDfhei8uJWS3hsKFd0nD6orh1enkTuTmLUYwD2BLzgfrDnK0A+R
rPt4IUg1kqPPKrBsJaSQG0eDug8bbZjzyl0Qv4ae5aPzdcDQutQYxOHJNFPItZrx
XS7tKd3IckX88ikebhd0lYSN9rTxPpLRFqNq1Ukp6BlsT+jDQ7G5kSHkRtJSaAfs
dcwW4qDG736TBS9q7FqI2q/aPy/bGaXqFIjVhIdYGzYLMcc2A/73FmFHd+aGKHL/
VkhH6x6txarHWjldeTmRx4Vcb5VJ9Nuq4xMW0MhJ4B6cfUtbsGxVbfMP/wUevm7y
D3jszUDMcP5v84p4bQkNLExR+kfUB/ttx7LDS7Zy9VlmrgpdKfVyyTmp1EvlsAC8
ArcgxIFD/v9tR4ReLMAmoBx0kDcvICW3uhoxjJ12+QJk+hYNR91pvVQFqOjyd8dJ
cOSd2irL+yMUQkilcbWDHXyxAu3GfdBo36/eCWwJH1ap072HNAxUhoCKq3BU9zNB
UHEP7qbfyEEWYKIrVrkTczZJ6KuorBui3OXiIyz1bM7uiPtTgbr3PE0kQj1KLa6j
GwNnVIG16UWd6Rp/CmLxZeGewuWbLyb0Q0wmd4EqA5zerZLarwc=
=z3uI
-----END PGP SIGNATURE-----

--sY/nlHJyYy4WYvdJ--


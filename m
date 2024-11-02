Return-Path: <bpf+bounces-43809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051DC9B9F42
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 12:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22231F21F24
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3E117624F;
	Sat,  2 Nov 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="vjmTzVjh"
X-Original-To: bpf@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F913C67E;
	Sat,  2 Nov 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730546896; cv=none; b=X80DhQlma/Dy6y9aikK101myELkWepAS9peWBJ04DSnILfoDtMfOw7Ov0pgtpJmFdRb0uk6IofajCN3GJYauqsAgpAe+H1Qj6DYna5SHXfAnSorYtIXvh19fR6JOFxb2d9W7lfPLRptExbKP9wvSwfLNAsspHVp/5olEO4eBqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730546896; c=relaxed/simple;
	bh=6Xuvqvjz0O0f5DtMDCZIJtSxqS5u8/HCzRNuy/jlh0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCmBQeWs4vgXlMEDHumF4xiIKUYeXw5l9J/uhJzqTIG7/uzRquCj7Fs1/vzG0lvMjVX8uFiBImihx3YRBT+YoWfZIJEvODWBBv2n6z6+Y5MniyT+IyGaja6r9+9NyVXfaQ71FBFn9idreF3JP6nXzCE5VYYdQ7jjjGbE7d1k15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=vjmTzVjh; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1730546857; x=1731151657; i=christian@heusel.eu;
	bh=WmMrR/YhdN4xuscWAnklkE6sNO6ghcpu6+bEbGV0Dl8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vjmTzVjh0S6GfFz24w7LgZLafZcxyg/CzcOzuKD6qKO+ytJm7SgiHWJxGl3R/+lu
	 BCxrMZVfhO3iBmMa9x2Y9F74pflSaX8cl60zCD4ffZvHX04HEeAn3wvMtgPbfPYHS
	 iMRPw7w49MwG27wlR9qtdw5qQ7T8zvy9JT1kxVVwrtKV/cX49uc65pmlFAqISzKif
	 eOPoQYqezruUquf4sg/ciaGZe798zaDixOlYO+b8JfWTRjKoy1szrI2tDiem+KEfV
	 M7M6GweONgY6PlMrQdg6c+Ek/fgK100CYB9OBxAECoKlUsfRkMCS+D0NcQ3Pn6lbC
	 Ym5ytnc0D8weKfScYw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([84.170.95.171]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MhDEq-1tkOvj2UsM-00ajVM; Sat, 02 Nov 2024 12:27:37 +0100
Date: Sat, 2 Nov 2024 12:27:36 +0100
From: Christian Heusel <christian@heusel.eu>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bpf: replace redundant |= operation with assignmen
Message-ID: <cef129cd-44b2-449c-8a60-c918af005cbc@heusel.eu>
References: <20241031130704.3249126-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mq46d7w2jh5srwvq"
Content-Disposition: inline
In-Reply-To: <20241031130704.3249126-1-colin.i.king@gmail.com>
X-Provags-ID: V03:K1:BLFSXaSDwrRUxOWPQAYJW4MCsCZ66VH3B5fNZlyrNPQpIVwAuxQ
 EIkKOJtYFfeQVdxZQqwxoddegPY2yO9b51n6S7hW4vjrFPm1SRmruP8OQbvYJCNaXs1/FCR
 Ep06esM4QyyHNAg7NYWvu5YGBpbHFBbDG2ksbGy6afBXhFQPgXihjw9yKdo7OHLTHIH3DM9
 WAIfJ3H8CT/iuXFlPJ4tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0c9rEGd8oOs=;gNv4hqN2OexMjuuM10htPanwg2B
 p4OqAKHEKbgJADSpmFSXa/BjBgfSY8VkxKDNwPe+hMWdRkhF+ADhwG49MONFNgwPj9da3b4dx
 rgUUXIz2s2AsQkPDGHo+fJxAKwYNTtFBvdg/qX+gXZvw219u1rrk+zhSf3U8Wb4Q/sSDpdr7k
 ox1MgluLPvnX0m+8p4zi/fscS+C6FNJAMlqHrz/+h1R7J3W8Gd29UHxuDnILTMTVOaHk5w8uh
 INXCOEv0U9sZVd0Z8oHTkarsdr++kuRaKY5dnXltuBAyYCgXLu1rf0fdLAv9yIVjYZjclOi7Y
 554Wws/ICn/9XF2rWzxuXpDOOaUr+aq03xTOfowyA+E7OOZAr3ns4BRR3Ms9WONtQHLYmtOir
 Zz/tFA+n5PkzVanhR5TVSRaeqRM0i9otuJ1/HyVGNL6jWfkwgoV5DWXlnlE4Hl5/Nm/t2oKXm
 wA3WmA5w8Aso+hiHVK5iY3sR5QR84YGsmP39gjIfDMI+Ab/E5/DIAAygi1g92TM7WMk7eIP2c
 fUHLmUPGXG75NUuHx8cHmWOTsX5op3sp26E5Toee/Tlef11X3tFsDKOhsQjhVFT+o18huCZBM
 nSb9Ie+lffn+vstVzgKJKblFHi59iwxjryt1EulzW1CZ00DtyotCO93ZiiBWyXMtxfzGpQEnA
 2T6AcKCtwYyhZlntf4rj909FCrGmf5wUMlWqGLu8HOsX/XF1O70/5O1D6vM6sfSoDYB+xdin3
 RJQlXJHHt/Q3JqGeh1UZJclnKG4s5NI5g==


--mq46d7w2jh5srwvq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH][next] bpf: replace redundant |= operation with assignmen
MIME-Version: 1.0

On 24/10/31 01:07PM, Colin Ian King wrote:
> The operation msk |=3D ~0ULL contains a redundant bit-wise or operation
> since all the bits are going to be set to 1, so replace this with
> an assignment since this is more optimal and probably clearer too.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  kernel/bpf/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 9aaf5124648b..fea07e12601f 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -914,7 +914,7 @@ static int bpf_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)
>  		str =3D param->string;
>  		while ((p =3D strsep(&str, ":"))) {
>  			if (strcmp(p, "any") =3D=3D 0) {
> -				msk |=3D ~0ULL;
> +				msk =3D ~0ULL;
>  			} else if (find_btf_enum_const(info.btf, enum_t, enum_pfx, p, &val)) {
>  				msk |=3D 1ULL << val;
>  			} else {
> --=20
> 2.39.5

The patch subject contains a typo ("assignmen" should be "assignment"),
but maybe this can just be fixed on apply ..

Cheers,
Chris

--mq46d7w2jh5srwvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmcmDKgACgkQwEfU8yi1
JYWdIxAAotM3cGdE2NzOWvfeXmB8y5/PcO7OvXnCcp4RiWLjDHDO2TA1Mq3fOkRb
TdBAIByTs2xo2lRyYFreqnoWA+PvwX7oxJouR1SMEWUbyWfWf3SwjiWgk4vW1V1B
cmmF87IeRRN2ViIjW/aIhN2pjVcRjHxRZJcjORNlfDEewJDd9iT4cE5IkYcE9W/C
baipFrEj6J0Kf7ewq22A3mKbaHRCoNYDRkOgNonh1jEORX0MHwMJIDHhVkzmtgC6
tStNIDDg3A9Hp11li+eTDecA0OC9nvENYntfWvpdAqUi8jlC/+62LxadcSerTCSf
N+ru/Qw7bJ8D9hmBano7iXzBFHK9rNVS73ctus0cIM2ge2JLDqdbs/QkAchk12vk
drDcJc2VH931lh9eI88uDfQWSJFjFgI1yN2kBdycjsqIvX9VbZfJcb635FYbgK20
KFF4ZhB8d5DTdR8+2UHpum5FgNWOITXB9u+NHSVZDd5a4y26E1gXBGr8jXHp85wx
WIthFb+65YHwaGyeohR8RcEiG7SPIqAyqmdUUqJgKqzIeFlK1ww+UWQpK2rwJEd5
fzukt2s3CeXKy9OB36ZfZ8MBj+Mz7J198AjP+KC3nBPla2n0NcY9hDX38XBQ91Hk
9wfcA54NifMJLMPE3U8WU2CYGBnkufLDB0yYdiP3IY3lrSDwCT4=
=b+Wj
-----END PGP SIGNATURE-----

--mq46d7w2jh5srwvq--


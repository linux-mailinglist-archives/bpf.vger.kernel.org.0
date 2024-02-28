Return-Path: <bpf+bounces-22895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9483B86B64F
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5081B28A47F
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC6F15D5B7;
	Wed, 28 Feb 2024 17:44:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DDB15A4A6
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142266; cv=none; b=FIQN548rDnr/WIeCOKx383F0B4hGVR09fOxe4SWAGjhXRY9soaOPtrQdqW7AKnkkzB39k2L+Qzd/n4F+iI2jpUTlYFRGDQBeyzJOWKur6NpsinFOSBqiG/f2+3tp42J118sraYeCfH7uykq13geDDP7M6cc37E9Trd06pMCRwGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142266; c=relaxed/simple;
	bh=mFXf6YgSVGxaqcHLmTtHirJlGhGS+90hKFskKdKAP7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIv1P5SHjghmHC5Qt+QjB+SJGce7Rowcil4cDTGnNF6+GsOSkv91Xj3Ka/7AZoFyPbpBjiGSXaM46JbaAyjpMhfJZE74iCND/SpYgmCPnQYb33VX71p/pfRJt2aEycQp9Ie1W5PWUyJrK/7QgHcLx9BOKq0VZLwZFsn7vORmFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7879e69af35so371485a.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142263; x=1709747063;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hAyjcoP/94ORZVTeJQEJyp9PIbFp2U4vwWLWvFFAxI=;
        b=jYbT+L8F1GCTFMWwvn0q3/eaZuLxKZBVSop/FpXMZT/l5vtbLvIr2VLkRvFUISQolP
         G1aJ826B5Wy83+7sSliEGyY6BQByn15CFjOKCbYeDxNh4Pdg54P8aQhBJzGPhDFMQhXt
         hlre4Rf3NT23kVEi/8JzHZ6pFLFM5mvgwD48sa6PcVGmY8UrYZnXvNz6O/sGuR1ADDDa
         Nm0npVOG82BUF+sifEFq+R1t0efFxnFvEnf01Npktgq50XyUcibk6XThG0cBjYMYNtjY
         9dA3O8ffadE0xkRLF9LTQMkfu+CngijurDYJsfhWPwlNVpxUyZNZXcWjZM7c6ve87YDI
         Ldrw==
X-Gm-Message-State: AOJu0YwKFsYdOAEu1IoFfrbbTA/PTgbnGDInk2zPaOKb0QLsoDP9y6Ce
	wIXPDftHr/EmFwmw/SuCe2THdb7+FDmET+763LSNrc+sXm+KZKJLg7IQVneY
X-Google-Smtp-Source: AGHT+IEYd5xkoJUNtLgPEcTjVu0+canXraFadtc6Dz1LyUdRsQk0yFkOFcwoiqAWr9NlqAaRKUnfvw==
X-Received: by 2002:a05:620a:4016:b0:787:da0e:36da with SMTP id h22-20020a05620a401600b00787da0e36damr6346345qko.33.1709142263552;
        Wed, 28 Feb 2024 09:44:23 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id wg8-20020a05620a568800b00787c6ed9a68sm4398097qkn.91.2024.02.28.09.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:44:23 -0800 (PST)
Date: Wed, 28 Feb 2024 11:44:20 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 3/8] libbpf: honor autocreate flag for
 struct_ops maps
Message-ID: <20240228174420.GD148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-4-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2m9CzkioAXOSATSP"
Content-Disposition: inline
In-Reply-To: <20240227204556.17524-4-eddyz87@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--2m9CzkioAXOSATSP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:45:51PM +0200, Eduard Zingerman wrote:
> Skip load steps for struct_ops maps not marked for automatic creation.
> This should allow to load bpf object in situations like below:
>=20
>     SEC("struct_ops/foo") int BPF_PROG(foo) { ... }
>     SEC("struct_ops/bar") int BPF_PROG(bar) { ... }
>=20
>     struct test_ops___v1 {
>     	int (*foo)(void);
>     };
>=20
>     struct test_ops___v2 {
>     	int (*foo)(void);
>     	int (*does_not_exist)(void);
>     };
>=20
>     SEC(".struct_ops.link")
>     struct test_ops___v1 map_for_old =3D {
>     	.test_1 =3D (void *)foo
>     };
>=20
>     SEC(".struct_ops.link")
>     struct test_ops___v2 map_for_new =3D {
>     	.test_1 =3D (void *)foo,
>     	.does_not_exist =3D (void *)bar
>     };
>=20
> Suppose program is loaded on old kernel that does not have definition
> for 'does_not_exist' struct_ops member. After this commit it would be
> possible to load such object file after the following tweaks:
>=20
>     bpf_program__set_autoload(skel->progs.bar, false);
>     bpf_map__set_autocreate(skel->maps.map_for_new, false);
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Is this technically a bug fix? We were already skipping creating the map in
bpf_object__create_maps(), so initializing the struct_ops map even when
autocreate isn't set just seems like an oversight.

Either way:

Acked-by: David Vernet <void@manifault.com>

> ---
>  tools/lib/bpf/libbpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c239b75d5816..b39d3f2898a1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1192,7 +1192,7 @@ static int bpf_object__init_kern_struct_ops_maps(st=
ruct bpf_object *obj)
>  	for (i =3D 0; i < obj->nr_maps; i++) {
>  		map =3D &obj->maps[i];
> =20
> -		if (!bpf_map__is_struct_ops(map))
> +		if (!bpf_map__is_struct_ops(map) || !map->autocreate)
>  			continue;
> =20
>  		err =3D bpf_map__init_kern_struct_ops(map);
> @@ -8114,7 +8114,7 @@ static int bpf_object_prepare_struct_ops(struct bpf=
_object *obj)
>  	int i;
> =20
>  	for (i =3D 0; i < obj->nr_maps; i++)
> -		if (bpf_map__is_struct_ops(&obj->maps[i]))
> +		if (bpf_map__is_struct_ops(&obj->maps[i]) && obj->maps[i].autocreate)
>  			bpf_map_prepare_vdata(&obj->maps[i]);
> =20
>  	return 0;
> --=20
> 2.43.0
>=20

--2m9CzkioAXOSATSP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd9w9AAKCRBZ5LhpZcTz
ZH/PAP4j2dXh8lyGFKcD1xuWGW1Wm+dspCgQ5Kvxx3rkF3y6iwEAihe60P+lf+wz
fGDE+hiikgai8YJoLyIgZDQSCMstOwc=
=iOOH
-----END PGP SIGNATURE-----

--2m9CzkioAXOSATSP--


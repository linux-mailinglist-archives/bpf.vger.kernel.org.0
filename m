Return-Path: <bpf+bounces-22887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1687D86B4F7
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B2DB2A42C
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F516EF17;
	Wed, 28 Feb 2024 16:29:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA746EEEC
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137782; cv=none; b=ZzCsKHiXNV0ox7jfWkTkuTflcv5JXNnNtBt8Xg7ule0tH8Ywm4rFBE4EJednZGHSV7yObrI28WYpsksY2klKzLCamD0tW95fq0N6lrhqPvl2ZSod6xLiIspXTHqrGDXM09sZBJXB/4P6/DTDsO2UZZfs8bQtra4vykzzK/FWP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137782; c=relaxed/simple;
	bh=7FShfiRtUDq5MY2jiTwl3J6BevfBQL933/trQT0wsCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViFBGVLYSM9c9HcgqsnKkp7iL20qdyK/rZHFD4W4o5CHKFXpxXDavkL23n1583U7e2jBiOtr37d1zqpoqFfv4SuydMg68yZSpg5flGNL/v/SFbP/jX+oeD+3ODaHt2/Tqwbk6I7e1AF9MpIOcoTNbQW3WiBAB48BBT1tSSGfWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso5973428276.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 08:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137779; x=1709742579;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2M0S2ob8ErKCZKuWlCMDS1N0jmUFtv1XZQZlbWVHv7U=;
        b=MD39Ojtfokfs06yBU4b4sBDON3yl0onnqDJxysoZVOI2R/g51+5PGdwfHfYaToPKJq
         HVA6T4p2cnnC/kyZumUSRMACVXhFWq06UD7JRxS2gf1J0QRDW3f65QnJtHXeN3mmXrHQ
         N7zoFfoQV/brkvsCpglBUPie8+JPkbHfx73PoGiNluloLjvxn7yeu19hYjC8Ri1TbcS0
         7mfRuQWP5G7tFBE/RKmZOZMwZtU2KfRK/kpdOoNqqugQPrrrY9+cQiLoU8BK2w2WunWs
         PB9WD7GjndkiXExK43mrxWImswxuU0skzrUCQ4IrJfhE7X1AYt6HvlvFT/h8dhNjijQI
         M43Q==
X-Gm-Message-State: AOJu0Yw61cOG3Oag6PTgTUuJ/yX7lJ3YG3bU1sVAJXA9JMVND2A6zdHB
	6y6HyO2LUL0rgZiyrGjfk7sTru6IeMF8QyRLHyqx8T7lNmTMExoc
X-Google-Smtp-Source: AGHT+IFkAUJWedkBM20O+no7JjcYZFumnj1MeGFWnTWvNsuisBOXs4yYG8Uumli6aEhNszOH425gtA==
X-Received: by 2002:a25:2643:0:b0:dc7:4268:3a1c with SMTP id m64-20020a252643000000b00dc742683a1cmr2794942ybm.18.1709137779004;
        Wed, 28 Feb 2024 08:29:39 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id g17-20020a258a11000000b00dc7622402b9sm1948763ybl.43.2024.02.28.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:29:38 -0800 (PST)
Date: Wed, 28 Feb 2024 10:29:36 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 1/8] libbpf: allow version suffixes (___smth)
 for struct_ops types
Message-ID: <20240228162936.GA148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-2-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Am2/qdChx1JegM2Y"
Content-Disposition: inline
In-Reply-To: <20240227204556.17524-2-eddyz87@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Am2/qdChx1JegM2Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:45:49PM +0200, Eduard Zingerman wrote:
> E.g. allow the following struct_ops definitions:
>=20
>     struct bpf_testmod_ops___v1 { int (*test)(void); };
>     struct bpf_testmod_ops___v2 { int (*test)(void); };
>=20
>     SEC(".struct_ops.link")
>     struct bpf_testmod_ops___v1 a =3D { .test =3D ... }
>     SEC(".struct_ops.link")
>     struct bpf_testmod_ops___v2 b =3D { .test =3D ... }
>=20
> Where both bpf_testmod_ops__v1 and bpf_testmod_ops__v2 would be
> resolved as 'struct bpf_testmod_ops' from kernel BTF.
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: David Vernet <void@manifault.com>

Modulo the leak pointed out by Kui-Feng in another thread. It would be nice=
 if
we could just do this on the stack, but I guess there's no static max size =
for
a tname.

> ---
>  tools/lib/bpf/libbpf.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 01f407591a92..abe663927013 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -948,7 +948,7 @@ static int find_btf_by_prefix_kind(const struct btf *=
btf, const char *prefix,
>  				   const char *name, __u32 kind);
> =20
>  static int
> -find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
> +find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
>  			   struct module_btf **mod_btf,
>  			   const struct btf_type **type, __u32 *type_id,
>  			   const struct btf_type **vtype, __u32 *vtype_id,
> @@ -957,15 +957,21 @@ find_struct_ops_kern_types(struct bpf_object *obj, =
const char *tname,
>  	const struct btf_type *kern_type, *kern_vtype;
>  	const struct btf_member *kern_data_member;
>  	struct btf *btf;
> -	__s32 kern_vtype_id, kern_type_id;
> +	__s32 kern_vtype_id, kern_type_id, err;
> +	char *tname;
>  	__u32 i;
> =20
> +	tname =3D strndup(tname_raw, bpf_core_essential_name_len(tname_raw));
> +	if (!tname)
> +		return -ENOMEM;
> +
>  	kern_type_id =3D find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
>  					&btf, mod_btf);
>  	if (kern_type_id < 0) {
>  		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
>  			tname);
> -		return kern_type_id;
> +		err =3D kern_type_id;
> +		goto err_out;
>  	}
>  	kern_type =3D btf__type_by_id(btf, kern_type_id);
> =20
> @@ -979,7 +985,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, co=
nst char *tname,
>  	if (kern_vtype_id < 0) {
>  		pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\=
n",
>  			STRUCT_OPS_VALUE_PREFIX, tname);
> -		return kern_vtype_id;
> +		err =3D kern_vtype_id;
> +		goto err_out;
>  	}
>  	kern_vtype =3D btf__type_by_id(btf, kern_vtype_id);
> =20
> @@ -997,7 +1004,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, c=
onst char *tname,
>  	if (i =3D=3D btf_vlen(kern_vtype)) {
>  		pr_warn("struct_ops init_kern: struct %s data is not found in struct %=
s%s\n",
>  			tname, STRUCT_OPS_VALUE_PREFIX, tname);
> -		return -EINVAL;
> +		err =3D -EINVAL;
> +		goto err_out;
>  	}
> =20
>  	*type =3D kern_type;
> @@ -1007,6 +1015,10 @@ find_struct_ops_kern_types(struct bpf_object *obj,=
 const char *tname,
>  	*data_member =3D kern_data_member;
> =20
>  	return 0;
> +
> +err_out:
> +	free(tname);
> +	return err;
>  }
> =20
>  static bool bpf_map__is_struct_ops(const struct bpf_map *map)
> --=20
> 2.43.0
>=20

--Am2/qdChx1JegM2Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd9fcAAKCRBZ5LhpZcTz
ZKh7AQC2cm9A8Y3HewoBCskl1E0HFj/mSG2NxWAf7yfilcm0XQD/aP61cpBQyN0V
ELFCx9IRMk5OeYqUUcv+HfzpVJucEQk=
=yPFH
-----END PGP SIGNATURE-----

--Am2/qdChx1JegM2Y--


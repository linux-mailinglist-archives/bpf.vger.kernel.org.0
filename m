Return-Path: <bpf+bounces-28476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32178BA116
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 21:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422B41F249D2
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED517BB1E;
	Thu,  2 May 2024 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYAzHKAS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F251635CC
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678475; cv=none; b=aIjKFz/oWHMGJI3vu5+7JwXopF8JYBupPmb0V8G7YD5WNPzGTC9JsKqVQWBDC61t3F22+GceHFpHdhVkIwCwUGCeJfJHJAsQw5x5LDk4H3d1jBwXjTFfEcDbt/Nz9fiifJ/POdXrkqr1ybNTzd3VnJyH2v26QC9O7Ym6M04cwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678475; c=relaxed/simple;
	bh=G3coAzMdZU9of0PGdU98FqqiX0n2G3udXA1A1LE/muY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=en10YB1e2iVCv8ZnTKgvvqOOho3jeKiyQaGuY2ouERbZpevg5rGaKXl4jCLtbA+FMNHH6skB9DrTEdkurvKYVJHZBNlzjRw94ojW9qssrh4X0LrY+agJvzWA1h3hk6evR3mAOjMrMEkZmpskO6bgcRLkEQ7s322CjBFuWOcx/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYAzHKAS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ecd3867556so13772095ad.0
        for <bpf@vger.kernel.org>; Thu, 02 May 2024 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714678473; x=1715283273; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pGw80syNMnLFyZ+tpuv94voLrF6zLArmQABNnqnnT18=;
        b=LYAzHKASt01hDy1RVX3FJwUCcjkNk9Uk75HqcVibV3VjcOi0HRnnHXflLZPbB+2bZn
         rrK+F/OQVROCfefqj4OK1lMYEetU4DxkWdqL4yLwcFsBT8pZ/VW0TcBAywRi6uySCsmk
         rgPKodQEb0yRy6pbchr7FDpZbmNt+lg+EIijRaHGal7v5941WUhmazejsibNvsnwoQIe
         XR1Rrp8iRiHslpOSpUpxQ06lBrmkzmSLGMLZ3o8Xw3R+NT1kpSdvUbWQalqfGWrFOe+U
         XLWCYj3Ks7OAPNjy3t0n5k/0ydsaFBeHTxssDfo1aa5sN7b+Z7hhcv3nHKpf8u5mxPfZ
         j3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714678473; x=1715283273;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGw80syNMnLFyZ+tpuv94voLrF6zLArmQABNnqnnT18=;
        b=e+5Vhc5Yz6rQ26Ywx9cyRCnKgxGCq1qChGwUlbA9VeleIfOBudFt+pnuZBvubZ35uU
         kRpbH7qIFZhiri+Q8qi74UyxwZM2kJm+Djf4n6xWrV1l5AOQJcPSwce16vlntrDr2cNE
         PU9XU/1k8BgVj2mo1K8mTCpI/i+bhDE5GINqEBg6128BPNlaTE2z+PuSp+7+tP88q/fh
         O9YKvlt+scuMpY0szKa7PSE9dyEc8sRwym5z3TTyZBJ9TwB0LaQP910f56hhdzJa8q3m
         VQBPsUud2++uhp2A9bqF5FvFgcHitrTvQRO2z00n/SD63CDq4WmJ3yLh8/D7nTr6F/s+
         UcJA==
X-Forwarded-Encrypted: i=1; AJvYcCUgGMKCOCz3n7eKTKb6HL/myEKyYhmby8mWRu5qJd7OziFJHJONhwvl5P/j9laUf0/Z3nUBZmwkkvXlpEBPcKpaMPTm
X-Gm-Message-State: AOJu0Ywe1W+KNVE0WYY/tAEGTyE+pIveGmXysTsBpjxS2XWUOBB2tnqd
	3yQNJ2MKSve+XhqM1P90a05FPnnfu91XDknQqoUz2W4yXhOyHWHGBE34L97r
X-Google-Smtp-Source: AGHT+IFFa5O8VpQjjIHvJs1IWhW6uGJg2oft6nwnjY00TwHULGCLDj2HlKui7EUsxSJFje0qRxFhuQ==
X-Received: by 2002:a17:902:d512:b0:1e4:4887:74f0 with SMTP id b18-20020a170902d51200b001e4488774f0mr800691plg.36.1714678472900;
        Thu, 02 May 2024 12:34:32 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:eb24:8e0f:7a62:3e6d? ([2604:3d08:6979:1160:eb24:8e0f:7a62:3e6d])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001e2c1740264sm1718493plk.252.2024.05.02.12.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:34:32 -0700 (PDT)
Message-ID: <ef932548808bd55dae8bccbbab63de60b86985ee.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: look into the types of the fields
 of a struct type recursively.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Thu, 02 May 2024 12:34:31 -0700
In-Reply-To: <20240501204729.484085-5-thinker.li@gmail.com>
References: <20240501204729.484085-1-thinker.li@gmail.com>
	 <20240501204729.484085-5-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-01 at 13:47 -0700, Kui-Feng Lee wrote:
> The verifier has field information for specific special types, such as
> kptr, rbtree root, and list head. These types are handled
> differently. However, we did not previously examine the types of fields o=
f
> a struct type variable. Field information records were not generated for
> the kptrs, rbtree roots, and linked_list heads that are not located at th=
e
> outermost struct type of a variable.
>=20
> For example,
>=20
>   struct A {
>     struct task_struct __kptr * task;
>   };
>=20
>   struct B {
>     struct A mem_a;
>   }
>=20
>   struct B var_b;
>=20
> It did not examine "struct A" so as not to generate field information for
> the kptr in "struct A" for "var_b".
>=20
> This patch enables BPF programs to define fields of these special types i=
n
> a struct type other than the direct type of a variable or in a struct typ=
e
> that is the type of a field in the value type of a map.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---

I think that the main logic of this commit is fine.
A few nitpicks about code organization below.

>  kernel/bpf/btf.c | 118 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 98 insertions(+), 20 deletions(-)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4a78cd28fab0..2ceff77b7e71 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3493,41 +3493,83 @@ static int btf_get_field_type(const char *name, u=
32 field_mask, u32 *seen_mask,

[...]

> +static int btf_find_struct_field(const struct btf *btf,
> +				 const struct btf_type *t, u32 field_mask,
> +				 struct btf_field_info *info, int info_cnt);
> +
> +/* Find special fields in the struct type of a field.
> + *
> + * This function is used to find fields of special types that is not a
> + * global variable or a direct field of a struct type. It also handles t=
he
> + * repetition if it is the element type of an array.
> + */
> +static int btf_find_nested_struct(const struct btf *btf, const struct bt=
f_type *t,
> +				  u32 off, u32 nelems,
> +				  u32 field_mask, struct btf_field_info *info,
> +				  int info_cnt)
> +{
> +	int ret, err, i;
> +
> +	ret =3D btf_find_struct_field(btf, t, field_mask, info, info_cnt);

btf_find_nested_struct() and btf_find_struct_field() are mutually recursive=
,
as far as I can see this is usually avoided in kernel source.
Would it be possible to make stack explicit or limit traversal depth here?
The 'info_cnt' field won't work as it could be unchanged in
btf_find_struct_field() if 'idx =3D=3D 0'.

> +
> +	if (ret <=3D 0)
> +		return ret;
> +
> +	/* Shift the offsets of the nested struct fields to the offsets
> +	 * related to the container.
> +	 */
> +	for (i =3D 0; i < ret; i++)
> +		info[i].off +=3D off;
> +
> +	if (nelems > 1) {
> +		err =3D btf_repeat_fields(info, 0, ret, nelems - 1, t->size);
> +		if (err =3D=3D 0)
> +			ret *=3D nelems;
> +		else
> +			ret =3D err;
> +	}
> +
> +	return ret;
> +}
> +
>  static int btf_find_struct_field(const struct btf *btf,
>  				 const struct btf_type *t, u32 field_mask,
>  				 struct btf_field_info *info, int info_cnt)

[...]

> @@ -3644,6 +3707,21 @@ static int btf_find_datasec_var(const struct btf *=
btf, const struct btf_type *t,
> =20
>  		field_type =3D btf_get_field_type(__btf_name_by_offset(btf, var_type->=
name_off),
>  						field_mask, &seen_mask, &align, &sz);

Actions taken for members in btf_find_datasec_var() and
btf_find_struct_field() are almost identical, would it be possible to
add a refactoring commit this patch-set so that common logic is moved
to a separate function? It looks like this function would have to be
parameterized only by member size and offset.

> +		/* Look into variables of struct types */
> +		if ((field_type =3D=3D BPF_KPTR_REF || !field_type) &&
> +		    __btf_type_is_struct(var_type)) {
> +			sz =3D var_type->size;
> +			if (vsi->size !=3D sz * nelems)
> +				continue;
> +			off =3D vsi->offset;
> +			ret =3D btf_find_nested_struct(btf, var_type, off, nelems, field_mask=
,
> +						     &info[idx], info_cnt - idx);
> +			if (ret < 0)
> +				return ret;
> +			idx +=3D ret;
> +			continue;
> +		}
> +
>  		if (field_type =3D=3D 0)
>  			continue;
>  		if (field_type < 0)

[...]


Return-Path: <bpf+bounces-45890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA02C9DED0E
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 22:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D46BAB21B0C
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9D1A0BE0;
	Fri, 29 Nov 2024 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpX5diq2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0EB176FB4;
	Fri, 29 Nov 2024 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732917026; cv=none; b=PhAJ88whNrPo7iymfwY4gynZdDMTB+cs9n6oU7cRFlbX0SEw00t4BNCf3cgVXEU3Dh97kQK+t2Uk825PZiv42WHiAbP9qHH7j7we07WdG8FUWEPOxIoPnkxjmdu+LERYTjmdtgL4ZmnR78akxBXDfGcPlxYPXgySkZz7+ZGwZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732917026; c=relaxed/simple;
	bh=AM848ys1g7IyhQYE4MA0Tdnkg3TjnNg6GhEOUNn6NQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TpJ7Z9t73teGh5ZFNBTVfQfJOt7NsCFFkEQmUnxfmAi/WwKgHwBIPLTYd4y0V90xPlTxYC8XC+jd1rgw18CgaUNeJ2cJG1ob01Bp9LUhL5+MVMLXROqrSl3m7MAIXEh+xyuPBEId3YHgVG1PfvZoWDMNKg64OB/gv7jMx6ZvMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpX5diq2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2128383b86eso21995485ad.2;
        Fri, 29 Nov 2024 13:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732917024; x=1733521824; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HIodyhiD6UOinbKHhvLMloGzV8x9o6B6YnMkFkiRuBY=;
        b=JpX5diq2AlK/Fq/ebreVZWYSLw0FbqPMBFxw9bvymvtB4eXkr8i6DCXlUQQXi1C4n7
         fAhjnu3S4b+gHePJiyyooh216gp9kioWujgAge3cSw49fOQWh9PX4X59TGHVx/EjnS8J
         oKF3kH4ZtCv9NTITpTq2AHRaDTmt8wgmp4WjF3tsLI6xxS59Mo2jU4/NB7ZhpYIa/Pq6
         e5OgUcrbdIywxM7tcbk0SLdANJE3OLAj3KJC2M7wX0Yw82hUOdztNbaRrcrClPBPRZ82
         snpJNIVtbHW6ADc5HK2N/xghBIWoDBR780adDh+WLQIpG39OEwr+Da8xIFmsgFZ1oBR4
         BiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732917024; x=1733521824;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIodyhiD6UOinbKHhvLMloGzV8x9o6B6YnMkFkiRuBY=;
        b=tRFhqpQxKpM+zRRDJKVU8eHD3qFpe/8HqhZdZLYUUQH/aSVtRITUSZ+9JlGSmBfIhJ
         Hf1vdCKfC1NisN9apux0S9KiTS2Nt9UcRyJGLCSWqB47Xw5lpx8RPhqiSbGaG9KiHE8+
         SwTkNIFO0HaQOJos4AVfqafVwFIVWWtXRMmvWccJBj3/T1tyzhMoOk/ePp2GgUl5LV6j
         XjcZk0BvqNHdkQygD1LUBFt0yIAUM2DQvrSlT5xEHQS+fGlnrs1Yu7b0OeiETn5qYG+1
         EWLW62nR0EDOOD8wmmTuaIymb73NL1VH/5ESW+f0554sUyIBG/WVtBHqwMxj2NJQczmo
         XIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxpUe2cZvt6obUG9GPDX+kGVJDLm/6pMsQURksHcPZ5oMJvv/decRfvQft5hc+90OZSZ+Qd6b2@vger.kernel.org
X-Gm-Message-State: AOJu0YwerjjMxQA5cH/I3T9notMSbjlwvoVewp2okkBhtJql4bAyVTBF
	5vA342x+uzcYrIGPy5LzY7eG0DJy4wE6UdqUFvgnEitaq9c/1KV9Xp5dYwzP
X-Gm-Gg: ASbGncudQLlhKxHlIWUqpaqsrfBt6I5jxVvi4b4d+XNsdAleAxaD6JXcxtFPCxreWcr
	mHWBpw24oHpOGDJpql+1MwbvRTrpIbdsG//dOOYxGHk9ydKvAVYVKrBkCQ3m7hdwoWICiNMUgsa
	vihvlW53pZ5bXtFwyu7ia/eRlzPxhLA/CGOLuw7QcxjYYi1ctia1Ps3dOsjUvALtl1vP6xsxo+B
	mQ84agymOkcR9MGGpo9WlkY3gK/H5UjQCNEi1htiQr5NkY=
X-Google-Smtp-Source: AGHT+IF5CctYGKDYd6a4VPlBJjD0x/WYLGYicqJxHDHrjVeiXCG5b+SSvfo9YKKWPtFeSQzHi6u25w==
X-Received: by 2002:a17:903:298e:b0:215:352c:af5d with SMTP id d9443c01a7336-215352cb18bmr95569775ad.25.1732917024005;
        Fri, 29 Nov 2024 13:50:24 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219063ddsm35315705ad.100.2024.11.29.13.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 13:50:23 -0800 (PST)
Message-ID: <0ea54d31ef9c473ee99f191bf00e451bb941710d.camel@gmail.com>
Subject: Re: [RFC PATCH 5/9] btf_encoder: introduce elf_functions struct type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org, 
	acme@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, 
	mykolal@fb.com
Date: Fri, 29 Nov 2024 13:50:18 -0800
In-Reply-To: <20241128012341.4081072-6-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
	 <20241128012341.4081072-6-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 01:24 +0000, Ihor Solodrai wrote:
> Extract elf_functions struct type from btf_encoder.
>=20
> Replace methods operating functions table in btf_encoder by methods
> operating on elf_functions:
> - btf_encoder__collect_function -> elf_functions__collect_function
> - btf_encoder__collect_symbols -> elf_functions__collect
>=20
> Now these functions do not depend on btf_encoder being passed to them
> as a parameter.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -2132,31 +2110,59 @@ int btf_encoder__encode(struct btf_encoder *encod=
er)
>  	return err;
>  }
> =20
> -
> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
> +static int elf_functions__collect(struct elf_functions *functions)
>  {
> -	bool base_addr_set =3D false;
> -	uint32_t sym_sec_idx;
> +	uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab);
> +	struct elf_function *tmp;
> +	Elf32_Word sym_sec_idx;
>  	uint32_t core_id;
>  	GElf_Sym sym;
> +	int err;
> +
> +	/* We know that number of functions is less than number of symbols,
> +	 * so we can overallocate temporarily.
> +	 */
> +	functions->entries =3D calloc(nr_symbols, sizeof(struct elf_function));

Nit: use sizeof(*functions->entries) instead of sizeof(struct elf_function)
     here and elsewhere.

> +	if (!functions->entries) {
> +		err =3D -ENOMEM;
> +		goto out_free;
> +	}
> =20
> -	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_se=
c_idx) {
> -		if (!base_addr_set && sym_sec_idx && sym_sec_idx < encoder->seccnt) {
> -			encoder->functions.base_addr =3D encoder->secinfo[sym_sec_idx].addr;
> -			base_addr_set =3D true;
> +	functions->cnt =3D 0;
> +	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_=
sec_idx) {
> +		if (elf_functions__collect_function(functions, &sym)) {
> +			err =3D -1;
> +			goto out_free;

Nit: elf_functions__collect_function() never fails now (make it void?).

>  		}
> -		if (btf_encoder__collect_function(encoder, &sym))
> -			return -1;
>  	}
> =20
> -	if (encoder->functions.cnt) {
> -		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encod=
er->functions.entries[0]),
> +	if (functions->cnt) {
> +		qsort(functions->entries,
> +		      functions->cnt,
> +		      sizeof(functions->entries[0]),
>  		      functions_cmp);
> -		if (encoder->verbose)
> -			printf("Found %d functions!\n", encoder->functions.cnt);
> +	} else {
> +		err =3D 0;
> +		goto out_free;
> +	}
> +
> +	/* Reallocate to the exact size */
> +	tmp =3D realloc(functions->entries, functions->cnt * sizeof(struct elf_=
function));
> +	if (tmp) {
> +		functions->entries =3D tmp;
> +	} else {
> +		fprintf(stderr, "could not reallocate memory for elf_functions table\n=
");
> +		err =3D -ENOMEM;
> +		goto out_free;
>  	}
> =20
>  	return 0;
> +
> +out_free:
> +	free(functions->entries);
> +	functions->entries =3D NULL;
> +	functions->cnt =3D 0;
> +	return err;
>  }
> =20
>  static bool ftype__has_arg_names(const struct ftype *ftype)
> @@ -2417,6 +2423,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu,=
 const char *detached_filenam
>  				printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filename);
>  			goto out;
>  		}
> +		encoder->functions.symtab =3D encoder->symtab;
> =20
>  		/* index the ELF sections for later lookup */
> =20
> @@ -2455,7 +2462,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu,=
 const char *detached_filenam
>  		if (!found_percpu && encoder->verbose)
>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename=
, PERCPU_SECTION);
> =20
> -		if (btf_encoder__collect_symbols(encoder))
> +		if (elf_functions__collect(&encoder->functions))
>  			goto out_delete;
> =20
>  		if (encoder->verbose)
> @@ -2486,7 +2493,7 @@ void btf_encoder__delete(struct btf_encoder *encode=
r)
>  	encoder->btf =3D NULL;
>  	elf_symtab__delete(encoder->symtab);
> =20
> -	encoder->functions.allocated =3D encoder->functions.cnt =3D 0;
> +	encoder->functions.cnt =3D 0;
>  	free(encoder->functions.entries);
>  	encoder->functions.entries =3D NULL;

Nit: this cleanup code is repeated two times.





Return-Path: <bpf+bounces-26587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592AF8A21A6
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 00:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEE11F21A09
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 22:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E5405FB;
	Thu, 11 Apr 2024 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDKfHG1z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70D383AA
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873655; cv=none; b=jazHAW3asoUAAKEVLaWU0gLMDLDKUNTKyJbKy0F2H8phyhd5wl7nInyH6vLjKonQNd6X3/33do6gLhYsz9WaEXVWWOEx/fwyA/oIBuRTVwmOm6EnNZnZyay49vE00y47lS04d4zXyVpCNHwy6ETk+QleddLgNzJRdOeL7UGmybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873655; c=relaxed/simple;
	bh=hJgFshN6xOUy+naVeCtyk1aRNBipg3GbWpPUA0Y8qpM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KuDfdyE0UTzNaedTTP3vjFRk0193RS/Dx7VZgczLihMr0oXQwTh0NV2u3SbeAG2eptW3Zv/QwefPLT5RFYzg7CZxjCPUC7pewZjT2Y4ySeonxXZFIN7GWL4Ua0kGJP2hcbx81tZisorHDXUFzZRUVg1XuA7KQBQas6lcP4kPPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDKfHG1z; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51969e780eso34414566b.3
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 15:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712873652; x=1713478452; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iI+tIT9wxj+3TGAeztGp9kTKEX8rWRO1jVGMbX/Oph8=;
        b=BDKfHG1zoohBVXxu+MbeQwGrJjQzI7A3jOxDyNjxX+pQi4dcurBVGnneGj624Rirnb
         /3TGrxfaDqB69L7/Frm0i+bqa9srn1uHDxHeI7mfgwNKjNrTp15IJuxuq8Sbo8+gOqYk
         mmmof/j7pMvxXqZml1SdxMtr/FzVutDj6UsoY7LuRXrF7oRQtXpYoqyd7QLcrNVDmCJt
         5/Qfr0KIhED5q0LhJxJ5ju8MBgP/fnF3bbxCMrDbdjDjsfMJtEqDXOM4UNj1NloVljqz
         tGsIus7i/o14nqMUgad8HaQqo+mA+6X6T4LDRl80wIxwZC+iTzpGMD3ElnsttBS6ugVY
         ijJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712873652; x=1713478452;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iI+tIT9wxj+3TGAeztGp9kTKEX8rWRO1jVGMbX/Oph8=;
        b=cqXLmmP5r1B02KWGpfQQslZXtML/gmBW8INlRG2w2QO6/sHTRPTfqaR78eaYSCnmt5
         bJXYBdpkeg+cbzYrr2eUHApXDVCi57NeSSYTbWI1Q3PvsqMwEG8DIFfHiJNdNI3LfWpJ
         PCRfE+FNvOfIVSZNK2BQ9hb5MHIOisSy0yVyERIdetRpMKh9ktdLCnt+It7YiDguMaOu
         vbVqIXZ3Y9riiCbB11q6jhvmWX3DA+l+0vPqOsCUs69C1mv7ih/QNCB/u2VyvbEzlJqc
         6HHyE8eZdDtd9x0fjX9cjblIR0KAme6JAZKtYMnJRAkObZGy5zhmdMncPR9ivayBUARE
         D+kg==
X-Forwarded-Encrypted: i=1; AJvYcCUpAIETKBR6pIiB7qEePhhM2prhDoIF+he2DfGhCT9qMPZpDx3vTiKUsDkhW9kzw4RBQTtsZT4LZLPa08CiuxwKWqRw
X-Gm-Message-State: AOJu0YzmsL0pn9SeeNMp9fKeLxdI7anRHPttyKqktQugwn8TTB+/nLX4
	S7uluHsrqgFONbfs0RpndDlkqh5rF8vr1Aq/SA3SnRDGb/FY1xkx
X-Google-Smtp-Source: AGHT+IFtLUfBILFOgYQbhCFfktOWdQVEXQGFDMv1OcW1SbzKKMq6AvwIZ7WIfZyXb1qKDQITgeCdbg==
X-Received: by 2002:a17:906:4c45:b0:a4e:9962:2dfc with SMTP id d5-20020a1709064c4500b00a4e99622dfcmr462142ejw.21.1712873652172;
        Thu, 11 Apr 2024 15:14:12 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id hz12-20020a1709072cec00b00a5226401c60sm804499ejc.107.2024.04.11.15.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 15:14:11 -0700 (PDT)
Message-ID: <3ccb7e3c1b71bfe63606565d0a1b418876b45535.camel@gmail.com>
Subject: Re: [PATCH bpf-next 06/11] bpf: Find btf_field with the knowledge
 of arrays.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Fri, 12 Apr 2024 01:14:10 +0300
In-Reply-To: <20240410004150.2917641-7-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
	 <20240410004150.2917641-7-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
> Make btf_record_find() find the btf_field for an offset by comparing the
> offset with the offset of each element, rather than the offset of the
> entire array, if a btf_field represents an array. It is important to have
> support for btf_field arrays in the future.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  kernel/bpf/syscall.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 543ff0d944e8..1a37731e632a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -516,11 +516,18 @@ int bpf_map_alloc_pages(const struct bpf_map *map, =
gfp_t gfp, int nid,
>  static int btf_field_cmp(const void *a, const void *b)
>  {
>  	const struct btf_field *f1 =3D a, *f2 =3D b;
> +	int gt =3D 1, lt =3D -1;
> =20
> +	if (f2->nelems =3D=3D 0) {
> +		swap(f1, f2);
> +		swap(gt, lt);
> +	}
>  	if (f1->offset < f2->offset)
> -		return -1;
> -	else if (f1->offset > f2->offset)
> -		return 1;
> +		return lt;
> +	else if (f1->offset >=3D f2->offset + f2->size)
> +		return gt;
> +	if ((f1->offset - f2->offset) % (f2->size / f2->nelems))
> +		return gt;

Binary search requires elements to be sorted in non-decreasing order,
however usage of '%' breaks this requirement. E.g. consider an array
with element size equal to 3:

   |  elem #0  |  elem #1  |
   | 0 | 1 | 2 | 3 | 4 | 5 |
   ^         ^   ^
   '         '   '
   f2        f1  f1'
  =20
Here f1 > f2, but f1' =3D=3D f2, while f1' > f1.
Depending on whether or not fields can overlap this might not be a problem,
but I suggest to rework the comparison function to avoid this confusion.
(E.g., find the leftmost field that overlaps with offset being searched for=
).

>  	return 0;
>  }
> =20
> @@ -528,10 +535,14 @@ struct btf_field *btf_record_find(const struct btf_=
record *rec, u32 offset,
>  				  u32 field_mask)
>  {
>  	struct btf_field *field;
> +	struct btf_field key =3D {
> +		.offset =3D offset,
> +		.size =3D 0,	/* as a label for this key */
> +	};
> =20
>  	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & field_mask))
>  		return NULL;
> -	field =3D bsearch(&offset, rec->fields, rec->cnt, sizeof(rec->fields[0]=
), btf_field_cmp);
> +	field =3D bsearch(&key, rec->fields, rec->cnt, sizeof(rec->fields[0]), =
btf_field_cmp);
>  	if (!field || !(field->type & field_mask))
>  		return NULL;
>  	return field;




Return-Path: <bpf+bounces-61034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BF3ADFECE
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4365189A3A3
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B523248F6D;
	Thu, 19 Jun 2025 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaJ96M4W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8047C242D89
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318460; cv=none; b=hHUucB2ROOmgezrd1labzrTEwwS02i1EDCuKcVVEdImu3QJ5M4k9Hg1KM2cJy8xBoJavSDMrLSe7VXnXOEObGiw8k5Q0RZw3tMs8BfVm5W+QSKV5jTmwHIRngoAryOtqV0qdojwq708a4MpsTR4uQffUO4PCE3frfnQJ6wlj7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318460; c=relaxed/simple;
	bh=yeWtiBHZH55n42YNLoCsOYSdzWMXXcEm7aOvz/PsYMk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0HuPnmaoEymE73s3Ql3Wz2+E5kxTm5lCdk1ANsV9RxuwYmFc5qhUcdZ7gCNkeVHOjDAJwPDD5noD9VWKsO+kzGj5+CAA1Z9GDFEDnsdbF1dItV9bDY5gD5/mU3jJNh4NeOIONjzvMMLdlekAocEE3b1tr4oaGtuR83/kFu8wX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaJ96M4W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236470b2dceso5450535ad.0
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 00:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750318456; x=1750923256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0KYHqwue1sBve1P/vKqUFzQgU9HAIouU3ioU5vMyvnM=;
        b=EaJ96M4WVr9J5YUdsclVV8zLYVe+lzHJcoZ/Eie5dIxE38fCFskiLEDnjWDGg6Vdk0
         EkVZ4OYzrZkWxKaE0y5kbPwpfMiJ4pvhcszjtFAfTTYg6rvRBzbIOL2VYnTwBtZFXBnK
         MLHI4UHMfRZKZB+ixK4F1OtLEoXxDIY/6DKXTUKAstbcKrInDPZ1Gj7goRwRU/MXkzDf
         YtiXJEQ8QuGhcHJtojYxHhLlWG154knBresN/ja33nqZTOBlPn6MMvX2CaqxFkaSFDTz
         B++5SZk4N0tUQ+Rh1p9nU/TuieXPkNqbeHsnMZJAkhhtWp5ga91EosOGbzpyjQBwjvzP
         oyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750318456; x=1750923256;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KYHqwue1sBve1P/vKqUFzQgU9HAIouU3ioU5vMyvnM=;
        b=FBEr6K4QLPGmKKfjamAvva1vF0kzjwo71VmCosVSzfph2/04/LnOPF+q0tvctzwjb7
         2okDM92bhnDFBNqYG/vrgN3lugAnjDadpy3Xd2l4wFtx5HShewYqlTYUVeQScI9xJStQ
         x0YG28AKdMFm1TjJAQQ5f1vEeOIULzx8bqCwqIxvxc/wOfT03ESrZjMV9iTfTcHr7CBx
         JtLc380EnTkhvbr5RTscO5hN/8KalgGvg9VCOYJeEXkMNQj+Gko2WAB9Ert49bPC5VBP
         3HptXtWmqBNYooE2W+8OGYFr6XDL71OIXNCPYOUYW/7yMLhhvnH7nnjhl9CsepS5T1OR
         f/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyHZ7doZKiT2NmfkZnc9nuHGsL+9cJIL9rpqAYecQikoSWk98CjekXQCqlWBH2Z+ezlx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkQUfkwl4Vnshfv6ZIxKapIPHVRg0rv2SoayTTwBHH/tZTsV7
	btHfZa+EOfdA1wqey8AluVulqE4d+0Ig0k1A0qiXWJeq7HrRxRB1yF1H2xZ/pHOb
X-Gm-Gg: ASbGncsAhk94/FG23OfaeDq/Hu0mzTdku1sEYUr/f1cF4m2mjY7GRSqDtDhNqI21jin
	5y+ZL60U8/zeIrxyY26RLBFuC8Mp85k4aDc/JWYf6tJw6dtp93T2INISPm7bI69botqi2IzgVK+
	nx96a5Gyw7OYz6h6/Efzd78hZ7gMn3OsK7OYIz4b9Cu4YqtcOuELOwKO2WRpkY4GXdSTrHFGrDu
	koS4MYz7486bo3M6qUdPU++FhaIjzJjKUGMUDVE0T6qmlJWOK2/izVZBJ2hUvya1CSwqB3KwV+p
	rth9shIRUr1UonvtnblZKY2vG/xXdgj8NCst5diQ77Hk/hMy6IKrKoR8QnlDP21v7sj6
X-Google-Smtp-Source: AGHT+IERvGhw29/ssIW9pVTeW/CvFbjIanfJ/JldRLAbG8i24z8ksOyTstaNUqVIyC/bvT2iPCQJmw==
X-Received: by 2002:a17:903:98c:b0:236:9dd9:b75d with SMTP id d9443c01a7336-2369dd9bb57mr129569715ad.40.1750318455583;
        Thu, 19 Jun 2025 00:34:15 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea7db9sm113736095ad.144.2025.06.19.00.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 00:34:15 -0700 (PDT)
Message-ID: <9bb199046f0b55ea4952ee028fc242db7a56bcc3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: support array presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 19 Jun 2025 00:34:13 -0700
In-Reply-To: <20250618203903.539270-3-mykyta.yatsenko5@gmail.com>
References: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
	 <20250618203903.539270-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-18 at 21:39 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Implement support for presetting values for array elements in veristat.
> For example:
> ```
> sudo ./veristat set_global_vars.bpf.o -G "arr[3] =3D 1"
> ```
> Arrays of structures and structure of arrays work, but each individual
> scalar value has to be set separately: `foo[1].bar[2] =3D value`.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 226 ++++++++++++++++++++-----
>  1 file changed, 180 insertions(+), 46 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 483442c08ecf..9942adbda411 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -1670,7 +1706,7 @@ static int append_var_preset(struct var_preset **pr=
esets, int *cnt, const char *
>  	memset(cur, 0, sizeof(*cur));
>  	(*cnt)++;
> =20
> -	if (sscanf(expr, "%s =3D %s %n", var, val, &n) !=3D 2 || n !=3D strlen(=
expr)) {
> +	if (sscanf(expr, "%[][a-zA-Z0-9_.] =3D %s %n", var, val, &n) !=3D 2 || =
n !=3D strlen(expr)) {

Out of curiosity, won't match if the pattern would remain "%s =3D %s %n"?

>  		fprintf(stderr, "Failed to parse expression '%s'\n", expr);
>  		return -EINVAL;
>  	}
> @@ -1763,17 +1799,103 @@ static bool is_preset_supported(const struct btf=
_type *t)
>  	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>  }
> =20
> +static int find_enum_value(const struct btf *btf, const char *name, long=
 long *value)
> +{
> +	const struct btf_type *t;
> +	int cnt, i;
> +	long long lvalue;
> +
> +	cnt =3D btf__type_cnt(btf);
> +	for (i =3D 1; i !=3D cnt; ++i) {
> +		t =3D btf__type_by_id(btf, i);
> +
> +		if (!btf_is_any_enum(t))
> +			continue;
> +
> +		if (enum_value_from_name(btf, t, name, &lvalue) =3D=3D 0) {
> +			*value =3D lvalue;
> +			return 0;
> +		}
> +	}
> +	return -ESRCH;
> +}
> +

[...]

> @@ -1815,26 +1938,29 @@ const int btf_find_member(const struct btf *btf,
>  static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
>  			      struct btf_var_secinfo *sinfo, struct var_preset *preset)
>  {
> -	const struct btf_type *base_type, *member_type;
> -	int err, member_tid, i;
> -	__u32 member_offset =3D 0;
> -
> -	base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->type));
> -
> -	for (i =3D 1; i < preset->atom_count; ++i) {
> -		err =3D btf_find_member(btf, base_type, 0, preset->atoms[i].name,
> -				      &member_tid, &member_offset);
> -		if (err) {
> -			fprintf(stderr, "Could not find member %s for variable %s\n",
> -				preset->atoms[i].name, preset->atoms[i - 1].name);
> -			return err;
> +	const struct btf_type *base_type;
> +	int err, i =3D 1, n;
> +	int tid;
> +
> +	tid =3D btf__resolve_type(btf, t->type);
> +	base_type =3D btf__type_by_id(btf, tid);
> +
> +	while (i < preset->atom_count) {
> +		if (preset->atoms[i].type =3D=3D ARRAY_INDEX) {
> +			n =3D adjust_var_secinfo_array(btf, tid, preset, i, sinfo);
> +			if (n < 0)
> +				return n;
> +			i +=3D n;

Having a nested loop to consume all indices looks annoying.
On the other hand, there is not much one can do w/o some kind of
btf__type_physical_size.

> +		} else {
> +			err =3D btf_find_member(btf, base_type, 0, preset->atoms[i].name, sin=
fo);
> +			if (err)
> +				return err;
> +			i++;
>  		}
> -		member_type =3D btf__type_by_id(btf, member_tid);
> -		sinfo->offset +=3D member_offset / 8;
> -		sinfo->size =3D member_type->size;
> -		sinfo->type =3D member_tid;
> -		base_type =3D member_type;
> +		base_type =3D btf__type_by_id(btf, sinfo->type);
> +		tid =3D sinfo->type;
>  	}
> +
>  	return 0;
>  }
> =20

[...]



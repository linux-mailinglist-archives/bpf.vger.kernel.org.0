Return-Path: <bpf+bounces-77047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E9CCDB68
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E57B30240AE
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138CF2D0C6C;
	Thu, 18 Dec 2025 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0JiDnTC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C52F6910
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093896; cv=none; b=gPEBghJQ4PekZs7tnIOnrzdk62ANdSRAenuTrcXVj+IVvbcu0pgm06MfEaxoe2leomRny1ZGjhQN5YtcVKjECZwAYKXoDmFAAat5icinyHsmSpx/aLk6N95QFpfLGA7HRJ4l3RxN63p4Qy9+NXGvcBCcCoucVgtLKCWYYTzDueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093896; c=relaxed/simple;
	bh=x3gs/QkwhXWKJee9flxhMM41mwK7jJYdeEPKYBqsGbk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WIj5yuccp/pZl+B9gTm84p2c+CXN1l3Fpf3tbbco1fekCnymnplM5JYw+3g2L9K0yIfE56Mzwm6+Xuz/lXW3WW3fYThzAX8ELqmAfpuyisCcgsAIoS+sJBZ2zBQeB7mx+NqjshYXoNpG7JzDTYGjNsGutU9iJzijKEUCY+o29J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0JiDnTC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so1243825b3a.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766093891; x=1766698691; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=46e/g8olhTGyx9sgeuPo5RKSKaANbZnSdw71U+AdQtk=;
        b=i0JiDnTClOSHSHhOWVmFa7ZENwjSTEsrC2HPt/wgOurEzGRmgaXNpVf7NOaKRzZ7i9
         M0+4PQas4Fntx8kIWqQM5dcd0rBAhENAW1M1zwzmitOUtGEmaRzMfnOPcPCmp+WtRDMz
         QdcgyRlA0zlYCmDWg+wlWG/adddTCVbur32v9uOQfITmwn52VESzK5/YI9mhqEBOCeon
         0DHN2GyoHn4ltXnOdcelWMDBSBVSWFtEhKzegZlbeziAIH9TZWFwrBjhZvgLSgOv5PJR
         XsJTZwmdGroNu+ONLOCzaFoBeUDezW/LgPuOFz1Di3WH++uDOmEt1PRhFCtx40gzqIPQ
         tpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766093891; x=1766698691;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46e/g8olhTGyx9sgeuPo5RKSKaANbZnSdw71U+AdQtk=;
        b=TBcFSiRjFrEqRvepqN9RJxh89K6w5uWs7k9E3imUhl6UfRVx8i3hWmMYli44VKOIts
         VOlTUxhLTi/bU8rG6SURJiJpIL6By9Pw4+D4kRhyTrga6helXPyv1oS/+a23FAKbnBSM
         iSzPFHCvojanL0eR3n8ogB22mH84rhwIyluN7U5SzHBMHYaF5M4Axck55HjnotiBNVbW
         v0aoE/Jh2WCv3mg2BO0AcQaYcrZQLOQ28cNjA4c4mqTQKdABvgHnCfi0hKartwyvwjfs
         BQmGMyBMv5qCcqYk+VLucPVysVtcjLsuz8BwAOMgiMWZUuQITS1wthsJaH1/rWWY1Bg2
         QcEw==
X-Forwarded-Encrypted: i=1; AJvYcCUCCQnH2zt7FBRqR9FBMBrqFBE2SN262nFUaPqI66MDlCfFxaXRMpUnXhtJa8Sn+OEGv8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8rqav4EOdE4O+mnRhLVSzwVyiJdchQS9EJI42nrm7xB6YHcD
	bkSr3Hzz+iZ3nSjTBjRXAax76QEcPVBKpfphstw+uW5LFpI4MgZu3yaz
X-Gm-Gg: AY/fxX7YCZ/tknpWXkbN4CEcU0w7fgk81AA/gqOVH+lVN0IqyErh8SE8Rg+wjk41J0C
	VeZRLqXImtKUvVAgNJrAgclk45bOtnNBO7B0EHbxeLzxU2f0+Nk4qwJ3NWouiEoSDw3OtwAflS8
	LyDVt8ULyRU4p5G+UdC3kRfinS+ap7wIlGRGWV0wwN/6/1Hfgbj0SMmvwC9s92L/71wN5rVdCCW
	a95BFpSJtuByE3pCAeU55yHWGgH4Nkt0FxlWQq1LbF4DZgA77dBeiOdwekH2kCxI8lFBbBmKdBa
	w9kRpphSdguNM1alHfEKvjgm/l9/5bo8dzMGUKI/LuW/ZQjv5pIAW3QPA/Vx7ft7Fq34EYN/kw7
	O4khh3M6h7K2J/kM4yqyQhRgx3J3u8x1AzA4N07k79us+30cM0rikAc9hN99PXXXY7W8oG8HjT2
	cC5VHGiW/gDw6MgTJBfBgmFVYYHserfBPYWH60
X-Google-Smtp-Source: AGHT+IE9S8nx1Xj9+e7DuNbibOjjVl4iWT965rzzma8m6a0Lb7aAXpTMmbJDs9+ZKMAmR9hsb9qWsw==
X-Received: by 2002:a05:7022:ef0b:b0:11b:8161:5cfc with SMTP id a92af1059eb24-12172306ccfmr931972c88.36.1766093890851;
        Thu, 18 Dec 2025 13:38:10 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfa2csm1294024c88.3.2025.12.18.13.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 13:38:10 -0800 (PST)
Message-ID: <290a67f65e9f7083895b5177d524e3ce27e9f93c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 06/13] btf: Optimize type lookup with
 binary search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 13:38:09 -0800
In-Reply-To: <20251218113051.455293-7-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-7-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> Improve btf_find_by_name_kind() performance by adding binary search
> support for sorted types. Falls back to linear search for compatibility.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---

(One nit below).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/btf.c | 85 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 76 insertions(+), 9 deletions(-)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0de8fc8a0e0b..0394f0c8ef74 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -259,6 +259,7 @@ struct btf {
>  	void *nohdr_data;
>  	struct btf_header hdr;
>  	u32 nr_types; /* includes VOID for base BTF */
> +	u32 sorted_start_id;
>  	u32 types_size;
>  	u32 data_size;
>  	refcount_t refcnt;
> @@ -494,6 +495,11 @@ static bool btf_type_is_modifier(const struct btf_ty=
pe *t)
>  	return false;
>  }
> =20
> +static int btf_start_id(const struct btf *btf)
> +{
> +	return btf->start_id + (btf->base_btf ? 0 : 1);
> +}
> +
>  bool btf_type_is_void(const struct btf_type *t)
>  {
>  	return t =3D=3D &btf_void;
> @@ -544,21 +550,79 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
> =20
> +static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *n=
ame,
> +				    s32 start_id, s32 end_id)
> +{
> +	const struct btf_type *t;
> +	const char *tname;
> +	s32 l, r, m, lmost =3D -ENOENT;
> +	int ret;
> +
> +	l =3D start_id;
> +	r =3D end_id;
> +	while (l <=3D r) {
> +		m =3D l + (r - l) / 2;
> +		t =3D btf_type_by_id(btf, m);
> +		tname =3D btf_name_by_offset(btf, t->name_off);
> +		ret =3D strcmp(tname, name);
> +		if (ret < 0) {
> +			l =3D m + 1;
> +		} else {
> +			if (ret =3D=3D 0)
> +				lmost =3D m;
> +			r =3D m - 1;
> +		}
> +	}
> +
> +	return lmost;
> +}
> +
>  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd)
>  {
> +	const struct btf *base_btf =3D btf_base_btf(btf);
>  	const struct btf_type *t;
>  	const char *tname;
> -	u32 i, total;
> +	s32 idx;
> =20
> -	total =3D btf_nr_types(btf);
> -	for (i =3D 1; i < total; i++) {
> -		t =3D btf_type_by_id(btf, i);
> -		if (BTF_INFO_KIND(t->info) !=3D kind)
> -			continue;
> +	if (base_btf) {
> +		idx =3D btf_find_by_name_kind(base_btf, name, kind);
> +		if (idx > 0)
> +			return idx;
> +	}
> =20
> -		tname =3D btf_name_by_offset(btf, t->name_off);
> -		if (!strcmp(tname, name))
> -			return i;
> +	if (btf->sorted_start_id > 0 && name[0]) {
            ^^^^^^^^^^^^^^^^^^^^^^^^
Nit: Maybe pull the is_sorted helper into this patch-set?

> +		/* skip anonymous types */
> +		s32 start_id =3D btf->sorted_start_id;
> +		s32 end_id =3D btf_nr_types(btf) - 1;
> +
> +		idx =3D btf_find_by_name_bsearch(btf, name, start_id, end_id);
> +		if (idx < 0)
> +			return -ENOENT;
> +
> +		t =3D btf_type_by_id(btf, idx);
> +		if (BTF_INFO_KIND(t->info) =3D=3D kind)
> +			return idx;
> +
> +		for (idx++; idx <=3D end_id; idx++) {
> +			t =3D btf_type_by_id(btf, idx);
> +			tname =3D btf_name_by_offset(btf, t->name_off);
> +			if (strcmp(tname, name) !=3D 0)
> +				return -ENOENT;
> +			if (BTF_INFO_KIND(t->info) =3D=3D kind)
> +				return idx;
> +		}
> +	} else {
> +		u32 i, total;
> +
> +		total =3D btf_nr_types(btf);
> +		for (i =3D btf_start_id(btf); i < total; i++) {
> +			t =3D btf_type_by_id(btf, i);
> +			if (BTF_INFO_KIND(t->info) !=3D kind)
> +				continue;
> +			tname =3D btf_name_by_offset(btf, t->name_off);
> +			if (strcmp(tname, name) =3D=3D 0)
> +				return i;
> +		}
>  	}
> =20
>  	return -ENOENT;
> @@ -5791,6 +5855,7 @@ static struct btf *btf_parse(const union bpf_attr *=
attr, bpfptr_t uattr, u32 uat
>  		goto errout;
>  	}
>  	env->btf =3D btf;
> +	btf->sorted_start_id =3D 0;
> =20
>  	data =3D kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
>  	if (!data) {
> @@ -6210,6 +6275,7 @@ static struct btf *btf_parse_base(struct btf_verifi=
er_env *env, const char *name
>  	btf->data =3D data;
>  	btf->data_size =3D data_size;
>  	btf->kernel_btf =3D true;
> +	btf->sorted_start_id =3D 0;
>  	snprintf(btf->name, sizeof(btf->name), "%s", name);
> =20
>  	err =3D btf_parse_hdr(env);
> @@ -6327,6 +6393,7 @@ static struct btf *btf_parse_module(const char *mod=
ule_name, const void *data,
>  	btf->start_id =3D base_btf->nr_types;
>  	btf->start_str_off =3D base_btf->hdr.str_len;
>  	btf->kernel_btf =3D true;
> +	btf->sorted_start_id =3D 0;
>  	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
> =20
>  	btf->data =3D kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);


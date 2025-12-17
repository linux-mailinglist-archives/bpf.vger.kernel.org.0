Return-Path: <bpf+bounces-76799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0805CCC5A2A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 01:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98ECB3034ED0
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 00:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E3A21CC7B;
	Wed, 17 Dec 2025 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNUiZwLB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C01ADC7E
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765932492; cv=none; b=T7ArVbwNV27Obg6F0HAGeT1dLwfSgmrHeEC4EOQhCzKu+J/g+ZShaCL2T9hYRd7u1SIklQ6mC/Kxaa6WAV/stY3AkSv8u5Q4xDUacR3ROOakbOiq3nz6JiYDcEhskxQkVw8liC4RPvUYpB5szGcPwYj8RRtRBDC36EuQhgCupGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765932492; c=relaxed/simple;
	bh=Ny+yuLc1o/B4ZppOwUSBfovH1Zs+njl9stcHGGsR+/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hOxif4H/r/DXN1yGAFmOSQ0wxhNL5od4qRNtxGGk+Ki3vvRiKT/a+A/8hOFbKexnFcgF5Eyfr9bzlDYqXAkEQvloDyYxKNOpde7m7SZSI6UAHytgn4a3om+4kcKAQzdZ35C/eIqcVotpiVbdWbxqimRRHkspCi+APObudQirVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNUiZwLB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so6145416b3a.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 16:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765932489; x=1766537289; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1nPJt4pCXiX80ArQ3awzkqjh8BNkySW8GQZrbQCMPk=;
        b=PNUiZwLBZNpWCTrfKeLPjTuDwSwkxH81uC0DASKJ3j74q1BuF/0QYYzJ53nUbW5F1g
         WuQtKvQmZUzdqWTt/oFOMXjeRy6bSMdOTIEhsmVAB+PFHGFYNcnydrQXX0Fc5A3F1q/m
         r7vSdQ7zkPxJmvNtq1SllE9f1mpoTR8zFljEn30/xJZjrtQOkEMHomsZfptYOtje9nCm
         9+KUltdBE3djod26U7O1qX8txTqhZq7T8wUcEby6SRnSq8+xODHKDP45UhEgUEdj0eyk
         UQpr6mDBUSeaiGADNocTsjkPd6Qyh2gSqfXsvcEaO1hsFzKDF0zlJ38vh419IBwFfbmG
         4pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765932489; x=1766537289;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1nPJt4pCXiX80ArQ3awzkqjh8BNkySW8GQZrbQCMPk=;
        b=S7pbIx84hG9iPPzgAm4I1wClwz4Up/GigqWyCPaanXy03aWvelI7v2OJf99mOksiCM
         XLPsjtjTttZzA2pYKU1z1HmcJhX3U+3KiGugTxNh5OskVzZT+fpi6+vZPlOWQywCEuUq
         I9aTndchh+4M+yEItuJfHdnwuCuh6dnqr7LbcVL8n0Mgv5qSkayiSY9Cs118csyLYIFF
         eDxVwTXowloP6aqw6sFmTHD+BQoxMgolkW2KsQKzTX1igCt8qzHGl+8kZk9VUnFzmQWK
         ouwOMZQC1zGl1G+bdd6Kn+jnr89aOKmKworLAzsOYRHC4Xa9v/fFfdJWpwa6VZmHiCjV
         CeeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUJ4vOk3/JIhZLq9E2SkFRUN/dxXq4oXCsXSJg8cyj6Ue6zHz7/dp0cdvSPIahkM4MoFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9bQuqeXmj6a6Fm/Wzmqm5QNN/mBxvCcDIo0DVqhLvVWwJYVe
	9n3q/0hZJAUrDnq4QDzHZMcYl39Smp0h3dSkTCh8tYMbxm043GefibUc
X-Gm-Gg: AY/fxX7tIc/IuMCF06tL1/gxtfmKbT9H0O5KFzOMX+HcxS8ElBiC+tJbP1U/FmgU6i2
	PkFAq2ZB1+MncDIQSSjFneQU4eLhskiRhvZCF3JTQelDsS14/wKRqpFIROHkjP7jW8NMgtU0gAi
	gtueZUJIL6P4rR53E4LCPeEsGLSfdUZtzuvSFaUKsgdcW+HR1F7loGfDEYvg7ns10wLpKe3fVMd
	ugbvyN2YcgKDkQPhB/WdbshxCVplmdP0wbkaZgh5/mN1EuDUYrjbl2XxeSyEkImevWhIl8n+pqw
	PVFJbCaNGkO032069BrunLV0oEB0n+WUVHHeysDxiVISFuoD3viIhBKWeEGXtKkUMD7YSpMaSm4
	OW1bGctWp5MVXvBzk4+XFOLFhE1uPnI6WyNgZ3CneFWUx9oHXuIaIIozzsusopHPGdmH1dqrfli
	YKmHUee99M
X-Google-Smtp-Source: AGHT+IEpflpIas9dYPJQ170FD9DjFlBm26hwOIRWcZvtH6OmSzhTumsmrO9irWCJjSK8uwUx7p5Cwg==
X-Received: by 2002:a05:6a21:9999:b0:364:13e1:10f0 with SMTP id adf61e73a8af0-369afa0f337mr17403090637.48.1765932489144;
        Tue, 16 Dec 2025 16:48:09 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a10d021c03sm66619955ad.96.2025.12.16.16.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 16:48:08 -0800 (PST)
Message-ID: <6eb163ae1dbe8bb44e47f1c1ebc37de34c6b7df5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 07/10] btf: Verify BTF Sorting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 16:48:05 -0800
In-Reply-To: <20251208062353.1702672-8-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-8-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> This patch checks whether the BTF is sorted by name in ascending order.
> If sorted, binary search will be used when looking up types.
>=20
> Specifically, vmlinux and kernel module BTFs are always sorted during
> the build phase with anonymous types placed before named types, so we
> only need to identify the starting ID of named types.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  kernel/bpf/btf.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 842f9c0200e4..925cb524f3a8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -550,6 +550,60 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
> =20
> +/*
> + * Assuming that types are sorted by name in ascending order.
> + */
> +static int btf_compare_type_names(const void *a, const void *b, void *pr=
iv)
> +{
> +	struct btf *btf =3D (struct btf *)priv;
> +	const struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> +	const struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> +	const char *na, *nb;
> +
> +	na =3D btf_name_by_offset(btf, ta->name_off);
> +	nb =3D btf_name_by_offset(btf, tb->name_off);
> +	return strcmp(na, nb);
> +}
> +
> +/* Note that vmlinux and kernel module BTFs are always sorted
> + * during the building phase.
> + */
> +static void btf_check_sorted(struct btf *btf)
> +{
> +	const struct btf_type *t;
> +	bool skip_cmp =3D btf_is_kernel(btf);

Nit: maybe just do a separate loop when btf_is_kernel(btf) =3D=3D true?

  for (i =3D 0, n =3D btf_nr_types(btf); i < n, i++) {
    t =3D btf_type_by_id(btf, i);
    if (t->name_off) {
      btf->sorted_start_id =3D i;
      return;
    }
  }
  return;

> +	u32 sorted_start_id =3D 0;
> +	int i, n, k =3D 0;
> +
> +	if (btf->nr_types < 2)
> +		return;
> +
> +	n =3D btf_nr_types(btf) - 1;
> +	for (i =3D btf_start_id(btf); i < n; i++) {
> +		k =3D i + 1;
> +		if (!skip_cmp &&
> +			btf_compare_type_names(&i, &k, btf) > 0)
> +			return;
> +
> +		if (sorted_start_id =3D=3D 0) {
> +			t =3D btf_type_by_id(btf, i);
> +			if (t->name_off) {
> +				sorted_start_id =3D i;
> +				if (skip_cmp)
> +					break;
> +			}
> +		}
> +	}
> +
> +	if (sorted_start_id =3D=3D 0) {
> +		t =3D btf_type_by_id(btf, k);
> +		if (t->name_off)
> +			sorted_start_id =3D k;
> +	}
> +	if (sorted_start_id)
> +		btf->sorted_start_id =3D sorted_start_id;
> +}
> +
>  static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *n=
ame,
>  				    s32 start_id, s32 end_id)
>  {
> @@ -5889,6 +5943,8 @@ static struct btf *btf_parse(const union bpf_attr *=
attr, bpfptr_t uattr, u32 uat
>  	if (err)
>  		goto errout;
> =20
> +	btf_check_sorted(btf);
> +
>  	struct_meta_tab =3D btf_parse_struct_metas(&env->log, btf);
>  	if (IS_ERR(struct_meta_tab)) {
>  		err =3D PTR_ERR(struct_meta_tab);
> @@ -6296,6 +6352,7 @@ static struct btf *btf_parse_base(struct btf_verifi=
er_env *env, const char *name
>  	if (err)
>  		goto errout;
> =20
> +	btf_check_sorted(btf);
>  	refcount_set(&btf->refcnt, 1);
> =20
>  	return btf;
> @@ -6430,6 +6487,7 @@ static struct btf *btf_parse_module(const char *mod=
ule_name, const void *data,
>  	}
> =20
>  	btf_verifier_env_free(env);
> +	btf_check_sorted(btf);
>  	refcount_set(&btf->refcnt, 1);
>  	return btf;
> =20


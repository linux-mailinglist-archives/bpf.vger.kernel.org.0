Return-Path: <bpf+bounces-76796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911C3CC59B5
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 01:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E2F7302BA8A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 00:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ACA1EB1AA;
	Wed, 17 Dec 2025 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0+Piya7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238421DDA18
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765931535; cv=none; b=A6S6wlfMauUJAHkyohnRr0KS68Ut76yqyRz/mqouE6l+n7AIu+/MGNEVrBl0aOUCPB1RfbCWW23WLtRm9rhfdO2S8l0/JkPWYZ0pKXGEfQaFTkUYag5kvxICmTDUyABUYCf/iwjqzJPH1W84kliHNXNrsbM17knMBfhZPotVWPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765931535; c=relaxed/simple;
	bh=SDZxhgXeRpb5AZsbUgX+tbIngP6hoMO3hq1PpSdk2Hc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sS/8jwQzMpBxoqXjmELB3rtiTwkB1eDOAnQSPPjUWhbrPOO5+ug38qZKrrAsc9ITiFG1V/c+BbA21bGcAFMtmS6AgcO21SpraWQDIQUmLZNYrkORjS+jpn6cBNIv15K6szWv1TaKFAm0H1VbI9tpmlkcWl2+xiPWuT3GD3yiRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0+Piya7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c277ea011so4132733a91.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 16:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765931533; x=1766536333; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/VT22ZtH0G6qWJ/tFlXK0+84Il/3ib56pQsFHo2JQSQ=;
        b=L0+Piya7aPomuw8R/Dm6xMdAZb1/wc8ErIGI4sJsn45TNOBe/YebG2PK/Ud9PdVpss
         Xp+G60JkSKSR8OazZ6jRHjX9Ms2VVbF9O6obGfDr7EcknNqrFaKfQGKHChOIFxNi5P2m
         msGrUGjCWTOKgSqj7hKXTngifr8exYzri6Gj/jfyb7vguzZFNXmE/IiMR7UJtG2Q9auP
         Cle5jAVyY/SMRvelL3SjabpsbpYDF234Aen8G4syqGb0FeITSxXJLz++n3qcVsB0xyBW
         J6cFd6OdvphxW3l/1mUXVGubDH6MjX06qh16BqCwX4FmENa47XR21Ce+F4B9q254cp40
         hqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765931533; x=1766536333;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VT22ZtH0G6qWJ/tFlXK0+84Il/3ib56pQsFHo2JQSQ=;
        b=CHZBPfJgqmbZeiF/tMBRi1o2sf+9UmdeCgOjJSoKS19QQslYtkASP9eyb8Yke4Dsvx
         i/K0/fYbfU8WeLPIKLxjF7MoZTFLVWmQ6sSeOWviFPAzzVyJJQvRlHJhh//rhNQwAjj5
         0VBtz/EG/0+LjITVpTpmlLLl2R9tus6EjgUbRpBAS6H4/8W6ucaMlcK4ScsNpK7TM6KW
         sQ89E4PclpTTI+HTd0nN1gYAtpGhX94MXJKPDENmh5NTkxKZO0YVkt5EUFUaE0pU0MAE
         3/RQz+C2Av/36ynzR3+yM2mOdT2BMsbA5YlFyFl+1KFDto0C1wBGlPYCwYoTYFIrUSG6
         vm3g==
X-Forwarded-Encrypted: i=1; AJvYcCUhjR+9z+buwWF7Cy68sA5edIx0MlgFHDWdQc7HMAdudAiOh7S3iRWwXJp6XvinZAACQtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDLMftN8VZg2+BVEpi8aBFbGd/3fkWjWC4aIGD0EYgZfaTxxz
	ku5kIIXZiRmJH8ErTQTPhLm1jIN1aA9FM3riRvjJul1/aNkqLocUYTww
X-Gm-Gg: AY/fxX79ZtdCG3bHT8cOeL5Y1/gHQ4oUG4ytyBRlYZdFJtNcNRzn588KyEBxda8JlFo
	GcvotWO6mXGfBgtKApCKPkBUYylZPQP1sIwNfPXixhCHxLqrfvhR/OHGMS4ICvrzJUTPllltqyI
	wtJgUfK8NpZQYJ3tbz7fw/tSW3zFbG4vflFf90+6KHRl4i/aHv/8lqFzewo9p61psWxVSiPkFZt
	hN1U2Qb3xhZxFgP6LHliQ0vLUBwafF4Co/3MZjr6ecOt9AbOdXUU/uqynFDfQyvBXO+lgffG0h8
	KQsfRhP/zJM+/X10qylG1eHYckikU0Usq69a5s1w/LVlKY676mygdF5wbQIYpVsXcQlBBT2z2l8
	bg22RbPj5pztHFZNPXlSGBekG45w3aVwLMgDKElLJan+55QzZ9j3n/zxKhusvtHnMy/+uYFHyP8
	oCPUxlZx9cGK4fGboaQiY=
X-Google-Smtp-Source: AGHT+IHUxRS7eRtYzrOGXaeS3bIYBTh4/1Bw67dBozbzXa0+D0jOpBIISxlOl1dr0/eVcz5ia1JLXw==
X-Received: by 2002:a17:90b:4a10:b0:34c:7d65:e4a with SMTP id 98e67ed59e1d1-34c7d651260mr7381468a91.31.1765931533230;
        Tue, 16 Dec 2025 16:32:13 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd40cde56sm948375a91.1.2025.12.16.16.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 16:32:11 -0800 (PST)
Message-ID: <0b9fd098307b5aa15a7d7a3f7f2b01fe63e66a53.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 05/10] libbpf: Verify BTF Sorting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 16:32:08 -0800
In-Reply-To: <20251208062353.1702672-6-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-6-dolinux.peng@gmail.com>
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
> This patch checks whether the BTF is sorted by name in ascending
> order. If sorted, binary search will be used when looking up types.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  tools/lib/bpf/btf.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 7f150c869bf6..a53d24704857 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -899,6 +899,49 @@ int btf__resolve_type(const struct btf *btf, __u32 t=
ype_id)
>  	return type_id;
>  }
> =20
> +/*
> + * Assuming that types are sorted by name in ascending order.
> + */
> +static int btf_compare_type_names(const void *a, const void *b, void *pr=
iv)

This can be declared as ...(u32 a, u32 b, struct btf *btf).

> +{
> +	struct btf *btf =3D (struct btf *)priv;
> +	struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> +	struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> +	const char *na, *nb;
> +
> +	na =3D btf__str_by_offset(btf, ta->name_off);
> +	nb =3D btf__str_by_offset(btf, tb->name_off);
> +	return strcmp(na, nb);
> +}
> +
> +static void btf_check_sorted(struct btf *btf)
> +{
> +	const struct btf_type *t;
> +	int i, k =3D 0, n;
> +	__u32 sorted_start_id =3D 0;
> +
> +	if (btf->nr_types < 2)
> +		return;
> +
> +	n =3D btf__type_cnt(btf) - 1;
> +	for (i =3D btf->start_id; i < n; i++) {
> +		k =3D i + 1;
> +		if (btf_compare_type_names(&i, &k, btf) > 0)
> +			return;
> +		t =3D btf_type_by_id(btf, i);
> +		if (sorted_start_id =3D=3D 0 &&
> +			!str_is_empty(btf__str_by_offset(btf, t->name_off)))
                ^^^^^^^^
Nit: broken indentation.

> +			sorted_start_id =3D i;
> +	}
> +
> +	t =3D btf_type_by_id(btf, k);

Nit: please use 'n' instead of 'k'.
     Maybe just change condition in the loop and avoid the second part?
     E.g.:

       n =3D btf__type_cnt(btf);
       for (...) {
         ...
         if (k < n && btf_compare_type_names(a: &i, b: &k, priv: btf) > 0)
           return;
         ...
       }

     A bit shorter/simpler this way.

> +	if (sorted_start_id =3D=3D 0 &&
> +		!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +		sorted_start_id =3D k;
> +	if (sorted_start_id)
> +		btf->sorted_start_id =3D sorted_start_id;
> +}
> +
>  static __s32 btf_find_by_name_bsearch(const struct btf *btf, const char =
*name,
>  						__s32 start_id, __s32 end_id)
>  {
> @@ -935,7 +978,7 @@ static __s32 btf_find_by_name_kind(const struct btf *=
btf, int start_id,
> =20
>  	if (start_id < btf->start_id) {
>  		idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> -			type_name, kind);
> +					    type_name, kind);

Nit: shouldn't be in this patch.

>  		if (idx >=3D 0)
>  			return idx;
>  		start_id =3D btf->start_id;
> @@ -1147,6 +1190,7 @@ static struct btf *btf_new(const void *data, __u32 =
size, struct btf *base_btf, b
>  	err =3D err ?: btf_sanity_check(btf);
>  	if (err)
>  		goto done;
> +	btf_check_sorted(btf);
> =20
>  done:
>  	if (err) {


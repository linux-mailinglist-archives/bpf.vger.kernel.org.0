Return-Path: <bpf+bounces-77048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD3CCDB95
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F28373015E15
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 21:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7130D33468F;
	Thu, 18 Dec 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqpiXNRJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6C322B68
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766094192; cv=none; b=rzEnwK4MLIfUrZMq8OL7UlVtdjb39r1rcESVTzJlgkSbl+WPMer19QAOPdW+VeYsQ5NX7ZXpOWE0ClaD+azfYL6yzNsd0+rZPL/g3r8r7JfSXslcFndlukDpnjoP0mfo8k39VTKx0KdfttZc6Mo4GjWZEU+Wt3jrzR76F8oo6Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766094192; c=relaxed/simple;
	bh=5xoJ+FAwmvBBOlQ1HBxPlbDwjy7kb9lj2INfUmDlOss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H65ayyyen9Pc6dAGfhv8auYfprYGteZpw8KzGt5Ut9rNim8r4qYNK9tMXfvxVF+sDHcFEwQU6OL0Uvxv4ZuhOALiduklpSQndmdy/WNcFKKhcm2AcxSbHadyFET0XdekX7gfhzYsE3dbWrs9nu3jfMSEyO599F1vne3al2QNwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqpiXNRJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c03eb31db80so856760a12.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 13:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766094184; x=1766698984; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zIi7zvTPASA4DYIZ2FET2r2wmNcVdbNKGGGML9Mr4dM=;
        b=hqpiXNRJIQBUeJ3ShR1B0owwEv/o2ed7Bg/LOfIPJkliDCxEqDLU+Ahf7QcHkIteRI
         ghzzFPvAyHjnbDODCT2rmY3Z8cVf/JIH5mgyzAYrX/+AoM+trCG2BnNyiNyIck5yaE2K
         T9jsf1SlqaFwWwf0BS5/cDTiuma89UASTVgQeRlXQfg0qXpunOMffuNZHyt1/X1N/DMW
         5dKH6lLKIheF1IroRRfrccU5w0S8pcooc8es1P3sXyCY69Fp6ndpwScj/GSGeP18vK+Y
         9NiCThgNwH7N5umlPFw7Mr0l6cNCxkq2WUxtUiBoKyhzuYqn0OUwRrrGIKoQAZ3rEsJ0
         7fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766094184; x=1766698984;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIi7zvTPASA4DYIZ2FET2r2wmNcVdbNKGGGML9Mr4dM=;
        b=oPC3x2ya2G2rMwRWz6haoDxhLDYRKGwDBNQJ1xFEwaIOQ8AqSPrin7rowptPVft1nt
         deMiT7CrdGzD+flcD4HL/MbnWo6YAGh8uYuuRIkOzxeMdjIZVo0GaA5DJSB2/PF39aot
         0Bfj+CuisDxYOoOZ1unV58wKPaz0tV8L0WPxeJml1PLvH0IkQLxENCakw1Po048xFH48
         TtvjqJRPtxAutGfrx4x70f1AlJscYYCRSpgG2NLS6/1DNkD0jltGaSLQ5H6I9avNod/T
         cJeH8k60B7rdAEcTjSbsXofNT9osBvF0KxYS7PBeAErn6mxNGF5cx/nTePBKQHd0svUG
         n7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVF8vl+AyuJw3V3IXUAT7+l/UCZBuLP2KyurO2IY2HLFCxuyS7GxKevkujnVaybnCocRRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBxL6OeP8TNHXJ1HyP0lNcNGJWHJKKUPJj1HaGqw16+EVbfq5
	7KYtv7jlcFo9DjJpyD5HZlmnKNhzG60chgjv32OWrCwjs3Nl1B80Ro7z
X-Gm-Gg: AY/fxX7niXwHpvGZnZuzV3xOVwso4Mnv9wBsPbyeGaS7xh14x66L2TKxZpSEecSX1BS
	36qdTxghD2y9qk9e4NSEqbGZNVdF/LDcj5EyCNY9vjNeiOg3AsdkJK+Yeyd5dZgpqIXEm51uxrw
	9uK6eIATut8MwmKyhbcmVjb7vALyb6fWFhyK1GoVu6nGP3N3vY5PkfSYsfLzYETYltvZJnARVgN
	kPL7df54bY9QfztzBMiaWz6wYqdZdhAJ3of73kOirToXiZ0Ze2eyS2iHy6hXPL7pq/DLElDQ1wn
	frwqYe3bN3AhVNwd5853gJDztzFAyAqPh/VMgmoiY431kL/SWGHii2MxzLQTMSmYESp4KTtAciM
	yltB6K7WRP/Th08HkhChsy4PutCYT6zd0b6KnAWDOTqPxjQlJ/takJMMXl5w08X0xS9IwQBN6z/
	zXsTAAf3Q/IwwRWxx87zcqrXGjkESFw0zOwu4O
X-Google-Smtp-Source: AGHT+IF6PosctMUD6swP6NPgKPI4DdVv2r80djgQpA1bMjDo9jebIdYS3EJsb2g0nGmwkAoHidG8nw==
X-Received: by 2002:a05:7022:985:b0:11b:a8e3:8468 with SMTP id a92af1059eb24-121722fd206mr785123c88.33.1766094184436;
        Thu, 18 Dec 2025 13:43:04 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm1708148c88.0.2025.12.18.13.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 13:43:04 -0800 (PST)
Message-ID: <1a9c0b5c22b2ecd8a8df531b1ed9441ab926415b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 07/13] btf: Verify BTF Sorting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 13:43:02 -0800
In-Reply-To: <20251218113051.455293-8-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-8-dolinux.peng@gmail.com>
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

Lgtm, but please take a look at a few nits.

>  kernel/bpf/btf.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0394f0c8ef74..a9e2345558c0 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -550,6 +550,60 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
> =20
> +/*
> + * Assuming that types are sorted by name in ascending order.
> + */
> +static int btf_compare_type_names(u32 *a, u32 *b, const struct btf *btf)

Nit: no need for 'a' and 'b' to be pointers.

> +{
> +	const struct btf_type *ta =3D btf_type_by_id(btf, *a);
> +	const struct btf_type *tb =3D btf_type_by_id(btf, *b);
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
> +	u32 sorted_start_id;
> +	u32 i, n, k;
> +
> +	if (btf_is_kernel(btf) && !btf_is_module(btf)) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Nit: there is a btf_is_vmlinux() helper, which does the same thing.

> +		for (i =3D btf_start_id(btf); i < n; i++) {
> +			t =3D btf_type_by_id(btf, i);
> +			if (t->name_off) {
> +				btf->sorted_start_id =3D i;
> +				return;
> +			}
> +		}

Nit: return here?

> +	}
> +
> +	if (btf->nr_types < 2)
> +		return;
> +
> +	sorted_start_id =3D 0;
> +	n =3D btf_nr_types(btf);
> +	for (i =3D btf_start_id(btf); i < n; i++) {
> +		k =3D i + 1;
> +		if (k < n && btf_compare_type_names(&i, &k, btf) > 0)
> +			return;
> +
> +		if (sorted_start_id =3D=3D 0) {
> +			t =3D btf_type_by_id(btf, i);
> +			if (t->name_off)
> +				sorted_start_id =3D i;
> +		}
> +	}
> +
> +	if (sorted_start_id)
> +		btf->sorted_start_id =3D sorted_start_id;
> +}
> +
>  static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *n=
ame,
>  				    s32 start_id, s32 end_id)
>  {
> @@ -6296,6 +6350,7 @@ static struct btf *btf_parse_base(struct btf_verifi=
er_env *env, const char *name
>  	if (err)
>  		goto errout;
> =20
> +	btf_check_sorted(btf);
>  	refcount_set(&btf->refcnt, 1);
> =20
>  	return btf;
> @@ -6430,6 +6485,7 @@ static struct btf *btf_parse_module(const char *mod=
ule_name, const void *data,
>  	}
> =20
>  	btf_verifier_env_free(env);
> +	btf_check_sorted(btf);
>  	refcount_set(&btf->refcnt, 1);
>  	return btf;
> =20


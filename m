Return-Path: <bpf+bounces-78787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC67D1BCF5
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6D73062CDB
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4712220DD75;
	Wed, 14 Jan 2026 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv7k4DEK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368923C465
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350603; cv=none; b=GmFp1GfPSR09REGSvlhk79Dbs90P1Yqkrt2gQpUrbQgfitlbwXKC26YHTKnxX+DNzO2O0SOxxS31w12tOPBv3cCBYuRsWY32g2AH4ym5bBxLWhMZGyVWJS6X3T73wuHI3ApLJWGDGkwZinJVYmWaov8SUsNNu9t0acn/zW61JQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350603; c=relaxed/simple;
	bh=tOAtSyHPSRla2OblmgH3t6ZVa7BvWCyXVR8ZpGie9Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELgT+FfgRpgPHjaulS3KyGdcr0UU1nOuwYGZ5zIkBfNIhV5QBzJ2P4c4eNF9njJJeVFAG5XGGozIdwZMsG/inBp/GCAeUa8oabqnUMeMHC/RFkHrfgNCq4TvpVLKsfQe1nn3nhVOhHJvFOCJlNAGZBxFKPJq2SxtDO+m6excK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv7k4DEK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34f0bc64a27so3855668a91.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 16:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768350601; x=1768955401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc2/mc9VBp4kHDHX+x0//yQDAw/YMka220PWnSKMjgo=;
        b=Mv7k4DEK0lr1BLPfpkYHEWzpw26bL/Y6WYdSaGbnQ5HyCsPpnQ7aVWf7DO6RFbEWO0
         s5p0asVM2DI9iGWvKG/k0H9jEZKvw8G68ImObGjpxamKAA4+biaQzxMQHVLmtebDIO6E
         tkMRO1tbKpl+zp5KW7shk1PBC2q0kN5cON1oSi1E4O5W2Ozji0fnqTBlqETB0gsg2XO7
         GBE9H8Ypeb/3CCnaW0LGpPi4Rh31EuTmGhmZLFr2ADgG1BDRwoj/uBg6Y8N+nQqniDVe
         xhM5JFmgCqOuB/QCL4FJRMHuhU9J5JMExGiGj9WyqD9BIsy3v4V3am69bVGKB0op9g+4
         Xiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768350601; x=1768955401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dc2/mc9VBp4kHDHX+x0//yQDAw/YMka220PWnSKMjgo=;
        b=bYeFPJfww5opXfjbL03QMKcpFwfy4HabXqKu1SfiJrbqcqBFAk1v05G5arMtLoTdbE
         uhMKBNK2c/8Rwwija/TodhBKa5qrpipH8Q9tcmyXL42KZzlWYBTsbs6xaZsf1qboNHEV
         l4aZ+vitBy5vB7/edd9aaIMNUmEKTK/THfS+QjtdoeYeMD/DoQW76vjG7bNwzHcy4z7A
         +8+1F6noxOJXXXWKo6fcVVVl1THj+km/wLnvXoz7gIecHYRDpAANR2cEydsRnbHLgyl6
         CeuiehOAZyNbO1jXFs7MoUfxx+0/3OcdED4nIgcV5tMUmFVPfeC5WL4MTdBxXO4DAZwP
         6hDg==
X-Forwarded-Encrypted: i=1; AJvYcCWhPM+cOojV0Y4Iksa0mKhHp0qMh05GsHlHNW/9taTCCsaPQsgtDYB8SA+8w48COeTXyHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZaQkIM8LvO02E7rLoW/CssiXTZe08c0vMstUbWwcNz+lUykU
	YUUcmfncmEw+hH3E+VYpCE2gjWQW13mSR0d7xLYW2nI4Z724krAnvOtopGlGg22NZNG3pHIX+10
	vt/aw1H2s+ryh64N+MTky6FCn2ubhLec=
X-Gm-Gg: AY/fxX7R2LCljlON5swOqw04VDHdgSYuCG2Nj9xGOyb7u89kxOZ5GKxEGlKgDn2cDE4
	Ut4J2EYhpLDMZzoHw2QQldtxeXNZ8lZ0KMVluVdBg0hAVA9CkRZ2p+fdQl52gjzVpgb5uEvr4dY
	lS8vY4n+X4eGV3sR6kXSXcl11J3y12wO6PvDgZeVIIqyIvtVmAa9KywVAWbkDO4vah5sHErwTZM
	cdfvK2tjNCnC9MGYZ2UWIwJdOkFFI5YZsMvEQsUvk0uQYCdZ4ev3wZpiwaAS+Bvxhkx+sU5i65n
	cn821FenLpk=
X-Received: by 2002:a17:90a:e70e:b0:34a:b4a2:f0c1 with SMTP id
 98e67ed59e1d1-351090bb8c9mr956936a91.16.1768350601503; Tue, 13 Jan 2026
 16:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com> <20260109130003.3313716-8-dolinux.peng@gmail.com>
In-Reply-To: <20260109130003.3313716-8-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 16:29:42 -0800
X-Gm-Features: AZwV_QjkNzoC2Jti1-AXCo0dK3yk-lndRKTNZ3P8lzU6gayVSSOuzOVqZoMeTro
Message-ID: <CAEf4BzZpNz6BWg3GJcmbQh_nN71bKnohG5L_0hhD+=DkHLgMbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 07/11] btf: Verify BTF sorting
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:00=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: Donglin Peng <pengdonglin@xiaomi.com>
>
> This patch checks whether the BTF is sorted by name in ascending order.
> If sorted, binary search will be used when looking up types.
>
> Specifically, vmlinux and kernel module BTFs are always sorted during
> the build phase with anonymous types placed before named types, so we
> only need to identify the starting ID of named types.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  kernel/bpf/btf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d1f4b984100d..12eecf59d71f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -550,6 +550,46 @@ u32 btf_nr_types(const struct btf *btf)
>         return total;
>  }
>
> +/* Note that vmlinux and kernel module BTFs are always sorted

wrong comment style, I'll fix it up when applying, but keep this in
mind for the future


> + * during the building phase.
> + */
> +static void btf_check_sorted(struct btf *btf)
> +{
> +       u32 i, n, named_start_id =3D 0;
> +
> +       n =3D btf_nr_types(btf);
> +       if (btf_is_vmlinux(btf)) {
> +               for (i =3D btf_start_id(btf); i < n; i++) {
> +                       const struct btf_type *t =3D btf_type_by_id(btf, =
i);
> +                       const char *n =3D btf_name_by_offset(btf, t->name=
_off);
> +
> +                       if (n[0] !=3D '\0') {
> +                               btf->named_start_id =3D i;
> +                               return;
> +                       }
> +               }
> +               return;
> +       }
> +
> +       for (i =3D btf_start_id(btf) + 1; i < n; i++) {
> +               const struct btf_type *ta =3D btf_type_by_id(btf, i - 1);
> +               const struct btf_type *tb =3D btf_type_by_id(btf, i);
> +               const char *na =3D btf_name_by_offset(btf, ta->name_off);
> +               const char *nb =3D btf_name_by_offset(btf, tb->name_off);
> +
> +               if (strcmp(na, nb) > 0)
> +                       return;
> +
> +               if (named_start_id =3D=3D 0 && na[0] !=3D '\0')
> +                       named_start_id =3D i - 1;
> +               if (named_start_id =3D=3D 0 && nb[0] !=3D '\0')
> +                       named_start_id =3D i;
> +       }
> +
> +       if (named_start_id)
> +               btf->named_start_id =3D named_start_id;
> +}
> +
>  /* btf_named_start_id - Get the named starting ID for the BTF
>   * @btf: Pointer to the target BTF object
>   * @own: Flag indicating whether to query only the current BTF (true =3D=
 current BTF only,
> @@ -6302,6 +6342,7 @@ static struct btf *btf_parse_base(struct btf_verifi=
er_env *env, const char *name
>         if (err)
>                 goto errout;
>
> +       btf_check_sorted(btf);
>         refcount_set(&btf->refcnt, 1);
>
>         return btf;
> @@ -6436,6 +6477,7 @@ static struct btf *btf_parse_module(const char *mod=
ule_name, const void *data,
>         }
>
>         btf_verifier_env_free(env);
> +       btf_check_sorted(btf);
>         refcount_set(&btf->refcnt, 1);
>         return btf;
>
> --
> 2.34.1
>


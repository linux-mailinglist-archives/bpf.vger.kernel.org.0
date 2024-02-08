Return-Path: <bpf+bounces-21467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6D184D77E
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 02:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF741F233BE
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7976715AF1;
	Thu,  8 Feb 2024 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYPA3Y5Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8675D1E885
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355032; cv=none; b=D4OZv0xpS/ZRvnSxB327KeoBoQ1Nf1PeUfXi880sn5sg96EOp7wpwF+FuWjWKn5q2TNjdqGrREc36RXTVfQXGPpcodf9Jzq4TbcP3YkjLJVBihiAWW7MBZhCleBH08s8pHf7UdnLWDR5fSIy4A3+McyezbjI15a3k+j/Q6QB5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355032; c=relaxed/simple;
	bh=b7J6FK3BLtP4bifKmVWC3C0LPfpGFjbHbwaht2Ugev8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIPL6X5xAvBmj/bDEFuhjCOB+2V4hHIiCLpqQwwRXotKyf+7FBtVypiWDKYIsNHF/sgMLkusJftwq2IJkiWcHmlUIieQpDMy+mTbjBOA+vHp7LBIIewZujsA45wdyfo2SU71mtZ1O694w+xFX/nZiLUF0ybEmfYyr8R1w6D7z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYPA3Y5Y; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e065abd351so721078b3a.3
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 17:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707355030; x=1707959830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4021p6aWWpOkC2Rkmcf8GScpQhZDkM0AtFP8+zr1J5Y=;
        b=OYPA3Y5YIjr3vLMR22FyfWoG7J3ddsQ1U1kDL+o3QZHccx7HQ2gWULCF0Ft+MoIzfC
         8oZ8487xblcCctN/J5PXpJwJYK7ASknR2PACWuINqHMckfTG2nRXYCztVc2alTT80kuB
         YgcDhUiG0CFKT1GkwsfhxUQifrF4cXK6p9RezuXM+uS4IMgvS11dzZ58wvUXvEu7ATYC
         RMPnhr2VSgFkM992RskP9m0QHOLgzoe4255Bz0+TB6TFqIN4dOSXY1rlGEqu0ScCSrK1
         8n/driBRkANgDreXSRYok4YyWI9LnlsiE3bO2kJepH5+8C9rXz6FVhNNk01z7ggvqsB3
         8Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707355030; x=1707959830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4021p6aWWpOkC2Rkmcf8GScpQhZDkM0AtFP8+zr1J5Y=;
        b=dlTs5BGnN7w2jT/gEVeoZ5wzk1S26PkX7iFMm1UoVVBBXGP76qS4vRx3JULZr62try
         /C594+um5KLYYExPi+c/YOgkuXZ9c66WMowLXBI3cjLCF+srIAX6vHfWTvn9h76qIOTy
         wdOL+vewB/IAB3qrUChs/Kj7wov0UQ3O12RmencVhFokXuqcLgR2wrn+/mZWFvpWYVtL
         UJFhl+DFy9WyoDxcdS78WYBIbmtar5pmF/myDCNuOZ+c74UCJNxVB5xSsvgKiI57NB99
         bHeAiYsDrJVhGwogM8rAlZVKJMRwrxyxnU2O0sfTqGJa9v5nPHkvgQF9eRBptAHW8tID
         JoHQ==
X-Gm-Message-State: AOJu0YwIi0wDlZA7Q782VMqXdccZlugsS5Le/EwXOUMcGDz6838bwBLe
	CVXWJd2fECGZSrQw6I6HiCMnaMHv2Rh+MfmX85D0KfEMH+70W0uRpSVp6ib4Q0+gmESulY0Rb6E
	Occ+vDKdeDZRieE5nzY55jAyLles=
X-Google-Smtp-Source: AGHT+IFBUSu5OJb19ossIGo4OkyrBe3c+arF3/fXbLA52LN8nvrK//EHNkYWdFhhTjdO76Oof5fAUp4UUazsV9UW76Y=
X-Received: by 2002:a05:6a00:b4e:b0:6e0:3f63:ed64 with SMTP id
 p14-20020a056a000b4e00b006e03f63ed64mr5967448pfo.34.1707355029732; Wed, 07
 Feb 2024 17:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com> <20240206220441.38311-13-alexei.starovoitov@gmail.com>
In-Reply-To: <20240206220441.38311-13-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Feb 2024 17:16:58 -0800
Message-ID: <CAEf4BzbAj=zU+iAc6KFsCscKKYZBKmCtNvtW1e9u=TJ+LpUG7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 12/16] libbpf: Allow specifying 64-bit integers
 in map BTF.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, 
	brho@google.com, hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> __uint() macro that is used to specify map attributes like:
>   __uint(type, BPF_MAP_TYPE_ARRAY);
>   __uint(map_flags, BPF_F_MMAPABLE);
> is limited to 32-bit, since BTF_KIND_ARRAY has u32 "number of elements" f=
ield.
>
> Introduce __ulong() macro that allows specifying values bigger than 32-bi=
t.
> In map definition "map_extra" is the only u64 field.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/bpf_helpers.h |  1 +
>  tools/lib/bpf/libbpf.c      | 44 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 9c777c21da28..fb909fc6866d 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -13,6 +13,7 @@
>  #define __uint(name, val) int (*name)[val]
>  #define __type(name, val) typeof(val) *name
>  #define __array(name, val) typeof(val) *name[]
> +#define __ulong(name, val) enum name##__enum { name##__value =3D val } n=
ame

Can you try using __ulong() twice in the same file? enum type and
value names have global visibility, so I suspect second use with the
same field name would cause compilation error

>
>  /*
>   * Helper macro to place programs, maps, license in
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c5ce5946dc6d..a8c89b2315cd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2229,6 +2229,39 @@ static bool get_map_field_int(const char *map_name=
, const struct btf *btf,
>         return true;
>  }
>
> +static bool get_map_field_long(const char *map_name, const struct btf *b=
tf,
> +                              const struct btf_member *m, __u64 *res)
> +{
> +       const struct btf_type *t =3D skip_mods_and_typedefs(btf, m->type,=
 NULL);
> +       const char *name =3D btf__name_by_offset(btf, m->name_off);
> +
> +       if (btf_is_ptr(t))
> +               return false;
> +
> +       if (!btf_is_enum(t) && !btf_is_enum64(t)) {
> +               pr_warn("map '%s': attr '%s': expected enum or enum64, go=
t %s.\n",
> +                       map_name, name, btf_kind_str(t));
> +               return false;
> +       }
> +
> +       if (btf_vlen(t) !=3D 1) {
> +               pr_warn("map '%s': attr '%s': invalid __ulong\n",
> +                       map_name, name);
> +               return false;
> +       }
> +
> +       if (btf_is_enum(t)) {
> +               const struct btf_enum *e =3D btf_enum(t);
> +
> +               *res =3D e->val;
> +       } else {
> +               const struct btf_enum64 *e =3D btf_enum64(t);
> +
> +               *res =3D btf_enum64_value(e);
> +       }
> +       return true;
> +}
> +
>  static int pathname_concat(char *buf, size_t buf_sz, const char *path, c=
onst char *name)
>  {
>         int len;
> @@ -2462,10 +2495,15 @@ int parse_btf_map_def(const char *map_name, struc=
t btf *btf,
>                         map_def->pinning =3D val;
>                         map_def->parts |=3D MAP_DEF_PINNING;
>                 } else if (strcmp(name, "map_extra") =3D=3D 0) {
> -                       __u32 map_extra;
> +                       __u64 map_extra;
>
> -                       if (!get_map_field_int(map_name, btf, m, &map_ext=
ra))
> -                               return -EINVAL;
> +                       if (!get_map_field_long(map_name, btf, m, &map_ex=
tra)) {
> +                               __u32 map_extra_u32;
> +
> +                               if (!get_map_field_int(map_name, btf, m, =
&map_extra_u32))
> +                                       return -EINVAL;
> +                               map_extra =3D map_extra_u32;
> +                       }
>                         map_def->map_extra =3D map_extra;
>                         map_def->parts |=3D MAP_DEF_MAP_EXTRA;
>                 } else {
> --
> 2.34.1
>


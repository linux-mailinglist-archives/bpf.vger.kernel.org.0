Return-Path: <bpf+bounces-63740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA5B0A7F1
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538554E2940
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832CB2E5B12;
	Fri, 18 Jul 2025 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi51hpJM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FC2E5B0F
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853962; cv=none; b=NoCXfsKQaUJPqe7TbVDMkwAfVDmA8IvgOv21xa9YEAR96d3M+IPpFMllA211ZiDYgbVaNFdH8l24ZtlzvxW+h07qG9di3RYQSrWkPpmqblIQ4Nabyep6dLjZG/CVOjtkeOduLZP2hqclAkYwWx9fl+qx1JyiJHYDc7uzfqEWzvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853962; c=relaxed/simple;
	bh=3XgbwjKgYTbpBHMgxuNGYp2wQsSPHPTBjLsOJpsf1S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klwEHOH3VN97OQfPoz2xFhgG3BVHAwdotq5SLbl9VXsyiZRun9K/PNPkGGXNxILpCyhD74rT/79VFARkJciOpVbirTDEWzOlwltrQoR6SOrROui93Aedxr59FH9brT5tr4fW3I5q+c1wThmDpR1wiX8wgXEPSGRQFuwQi+0YXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi51hpJM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso375665166b.1
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752853958; x=1753458758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx6X02FjDKQdH0MdgJ+YabAwWhOGVu3xOhD5jr/8Q1Q=;
        b=Pi51hpJMCTVXBDNWcWkjnOUyoYpJCe79lkbi0U/qTx4SDym52qxwOhHiyzKlXoID0y
         qscfW8/wI6uchx3Mfz5n24NiD6fSac0xxvY5yaG9n+DaKm6jWf4wGMX2UO75wrMcjIPE
         Z6RJJ+IIS9ecWIu7Vwtf8EgBaCDm41iCdUrceGmyS14DgpAkMNENHq+iPkn/bS+AyPp1
         D7Lms2f+In0mhX9Y3Xg6yamrEkMua/BES1aQfd2o7qUt95slDFb+7QpZTmWv1buKPUjM
         OfHZVNBrU4EQxIQR6njztiWrfgRhBZrmWSOyGnoqwBEvjQxuPSFvWKClCok6rY93A7O7
         ZBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752853958; x=1753458758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx6X02FjDKQdH0MdgJ+YabAwWhOGVu3xOhD5jr/8Q1Q=;
        b=XlgfJZkptXwNzHTjyBqntfp71TZGrnPJNopLY2xV7+uUsXJj8SoVzf/6VTipgDSJvX
         fK5HvA2DYMFpep4nO9aLQf2iQlpKqCca8hLIsdsL6rDiD+mQKoGwwx5nJ5440WZjmdNl
         KqCk6EEBfmdZ60mN0M4J1C5MWzJc3clD8FfKflCmQyLt0bLoKjvNOix4kSt4RvwdrPKC
         xLqEiGYyoRf4BlwEz9nRLlHyxV4meqDQRFi1pP3mLV5df1VWDE1RfRXQyzqV2ZPswZ5U
         kJCP61qklQYSg/HLmC7vwvdsyDYRhq1C1METZKaWzpU15Raq1f8LQm+1Ar1acR/Dp3iT
         oZQA==
X-Gm-Message-State: AOJu0Yy2uqZnMILlNy+/m/uJRjiz5KzUJRUkXEJPXhslO0iaXus6eJv6
	u4ytzEIawNNhcw1bZbRgv8ffDo4DUqDE8Y3pVzfxHzPoJsNeUzN6Y6PTMVa8fwo5AIyrfByLT1R
	f6R35qUV52w3svHu42z8Dh6dOnKvIyh8=
X-Gm-Gg: ASbGncuVQC+J2qL9HAhXle24fLfGaImhlhgVL7pkFzlhPLXJ0uHRX1iRKcJJ5HeE79E
	zc9mbxH7M0p1E/yRT7SxpZHAc0Dbf1935Rkp/6eUbEcv3+B27+N2tTgU94zp1dLea2JE/5ouQ0p
	VzIKZ+ZVGe0eL3Kq9W1h7wC5u3Bg7Uzlmw5+BYmch7c/xossMUj/GDMMPM6KRvqD2R8Ee1jTVHt
	cXicQ==
X-Google-Smtp-Source: AGHT+IGc9bOcX1oGmbxRfLn2TVfZGy8ex5zbDzBVwX69BF1AxxDPBVaUuAktdEFGUYCPdPbAqbrLdVB6oh+zN1B682E=
X-Received: by 2002:a17:907:e8c:b0:ade:44f6:e3d6 with SMTP id
 a640c23a62f3a-ae9ce104d0fmr1033753066b.46.1752853958041; Fri, 18 Jul 2025
 08:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717193756.37153-1-leon.hwang@linux.dev> <20250717193756.37153-2-leon.hwang@linux.dev>
In-Reply-To: <20250717193756.37153-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 18 Jul 2025 08:52:20 -0700
X-Gm-Features: Ac12FXyqaOXJy5Fz7YwIQMXS48033ZmoKHWNzSJKogS53hSfOwZLdtH6xu9-yOk
Message-ID: <CAEf4BzY74tbyzD-4iF1Em9EmKX=2fAN4dTp_k8o+MuN2T3CVqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array map
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:38=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> This patch introduces support for the BPF_F_CPU flag in percpu_array maps
> to allow updating or looking up values for specified CPUs or for all CPUs
> with a single value.
>
> This enhancement enables:
>
> * Efficient update of all CPUs using a single value when cpu =3D=3D (u32)=
~0.
> * Targeted update or lookup for a specified CPU otherwise.
>
> The flag is passed via:
>
> * map_flags in bpf_percpu_array_update() along with embedded cpu field.
> * elem_flags in generic_map_update_batch() along with separated cpu field=
.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h            |  3 +-
>  include/uapi/linux/bpf.h       |  7 +++++
>  kernel/bpf/arraymap.c          | 54 ++++++++++++++++++++++++++--------
>  kernel/bpf/syscall.c           | 52 ++++++++++++++++++++------------
>  tools/include/uapi/linux/bpf.h |  7 +++++
>  5 files changed, 90 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f9cd2164ed23..faee5710e913 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2671,7 +2671,8 @@ int map_set_for_each_callback_args(struct bpf_verif=
ier_env *env,
>                                    struct bpf_func_state *callee);
>
>  int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
> +                         u64 flags);
>  int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
>                            u64 flags);
>  int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 233de8677382..4cad3de6899d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1372,6 +1372,12 @@ enum {
>         BPF_NOEXIST     =3D 1, /* create new element if it didn't exist *=
/
>         BPF_EXIST       =3D 2, /* update existing element */
>         BPF_F_LOCK      =3D 4, /* spin_lock-ed map_lookup/map_update */
> +       BPF_F_CPU       =3D 8, /* map_update for percpu_array */
> +};
> +
> +enum {
> +       /* indicate updating value across all CPUs for percpu maps. */
> +       BPF_ALL_CPUS    =3D (__u32)~0,
>  };
>
>  /* flags for BPF_MAP_CREATE command */
> @@ -1549,6 +1555,7 @@ union bpf_attr {
>                 __u32           map_fd;
>                 __u64           elem_flags;
>                 __u64           flags;
> +               __u32           cpu;
>         } batch;

So you use flags to pass cpu for singular lookup/delete operations,
but separate cpu field for batch. We need to be consistent here. I
think I initially suggested a separate cpu field, but given how much
churn it's causing in API and usage, I guess I'm leaning towards just
passing it through flags.

But if someone else has strong preferences, I can be convinced otherwise.

Either way, it has to be consistent between batched and non-batched API.

Other than that and minor formatting needs below, LGTM.

pw-bot: cr

>
>         struct { /* anonymous struct used by BPF_PROG_LOAD command */
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 3d080916faf9..d333663cbe71 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -295,17 +295,24 @@ static void *percpu_array_map_lookup_percpu_elem(st=
ruct bpf_map *map, void *key,
>         return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
>  }
>
> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u=
64 flags)
>  {
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         u32 index =3D *(u32 *)key;
>         void __percpu *pptr;
> -       int cpu, off =3D 0;
> -       u32 size;
> +       u32 size, cpu;
> +       int off =3D 0;
>
>         if (unlikely(index >=3D array->map.max_entries))
>                 return -ENOENT;
>
> +       cpu =3D (u32)(flags >> 32);
> +       flags &=3D (u32)~0;
> +       if (unlikely(flags > BPF_F_CPU))
> +               return -EINVAL;
> +       if (unlikely((flags & BPF_F_CPU) && cpu >=3D num_possible_cpus())=
)
> +               return -E2BIG;

nit: I'd probably do -ERANGE for this one

> +
>         /* per_cpu areas are zero-filled and bpf programs can only
>          * access 'value_size' of them, so copying rounded areas
>          * will not leak any kernel data

[...]

> @@ -1941,19 +1945,25 @@ int generic_map_update_batch(struct bpf_map *map,=
 struct file *map_file,
>  {
>         void __user *values =3D u64_to_user_ptr(attr->batch.values);
>         void __user *keys =3D u64_to_user_ptr(attr->batch.keys);
> -       u32 value_size, cp, max_count;
> +       u32 value_size, cp, max_count, cpu =3D attr->batch.cpu;
> +       u64 elem_flags =3D attr->batch.elem_flags;
>         void *key, *value;
>         int err =3D 0;
>
> -       if (attr->batch.elem_flags & ~BPF_F_LOCK)
> +       if (elem_flags & ~(BPF_F_LOCK | BPF_F_CPU))
>                 return -EINVAL;
>
> -       if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> +       if ((elem_flags & BPF_F_LOCK) &&
>             !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
>                 return -EINVAL;
>         }
>
> -       value_size =3D bpf_map_value_size(map);
> +       if ((elem_flags & BPF_F_CPU) &&
> +               map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)

nit: keep on the single line

> +               return -EINVAL;
> +
> +       value_size =3D bpf_map_value_size(map, elem_flags);
> +       elem_flags |=3D ((u64)cpu) << 32;
>
>         max_count =3D attr->batch.count;
>         if (!max_count)

[...]

> -       if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> +       if ((elem_flags & BPF_F_LOCK) &&
>             !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>                 return -EINVAL;
>
> -       value_size =3D bpf_map_value_size(map);
> +       if ((elem_flags & BPF_F_CPU) &&
> +               map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +               return -EINVAL;

same, formatting is off, but best to keep it single line

> +
> +       value_size =3D bpf_map_value_size(map, elem_flags);
> +       elem_flags |=3D ((u64)cpu) << 32;
>
>         max_count =3D attr->batch.count;
>         if (!max_count)

[...]


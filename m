Return-Path: <bpf+bounces-66325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5BAB324FF
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EADA626CC1
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA2827CB35;
	Fri, 22 Aug 2025 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3kUoOFo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39CC23505F
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901223; cv=none; b=VREkR0qgo5+x++Gmm4nV/Sl96ciTBz3k5FwRAr5w/2ilR3M7xfDM8oG52sY1TmM0FhK9zp5wHKYy1v42Tkjlv0rgR5UT032yHFx4wZnRmXBgN0HznleFhvaabbDnsDU1YJJrMKhmrschp99z42ULpAeQDAfHN/EZOvJ9zKJJ5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901223; c=relaxed/simple;
	bh=NuoLpZ4XkUr1ci3XN+VNi6oxsJ/kErnqgGjwXv6XLlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHIjRkne1XIdpL8uV5G/2z1mJLlvP2HU+J5FzqmuzDTTw32lZpKChY/S5bPmdJJA/V0vI45MQyn4UCIxXE7wjY1CZaC8GDipbuVQq12YsNAZA7vbYeT1Ogn3/uZ8/H+TjwDLcCDOeUMFeyyg/aAagtb1uIzZ1yDJrHtMMJ5EGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3kUoOFo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b47174aec0eso1670538a12.2
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755901220; x=1756506020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1Ic7nY9iixCEF6hcBrmFZrQYG2PocTsGrlqQKwq+ws=;
        b=k3kUoOFoGPfDP6gzDrGAjOLXQfV7FZV7C2qJS615reE+4AFGuIbH/Cm6JbspWsz4EJ
         Hs1hqEWNLtmocQPGUIVA322yXzvykpO4O52Cg3D6YmXdgEcI+DY88NNxqdMWH65Nbi03
         ntNT/2dI30hnI57aNRP51VdVwHnBnsgnXjEJiHHxxxnvs+5W9/MS4hnIiMtVRoYl4ULw
         0pYRp3LbYQYzgGBpK5L2FutYDeO00Yn/dhRu+DXzJbOeEYHzyiSB2+VMYCpqOVOxga7e
         h6zIkYcGBtsntPGT8oyp3cMrp9K+dbdrHJazkvJpRGFoc3F5vooGsyPaHXOXwDp0D1yl
         P8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901220; x=1756506020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1Ic7nY9iixCEF6hcBrmFZrQYG2PocTsGrlqQKwq+ws=;
        b=IymHx3ZmkbrRcQBH4r8Se020sp/ZpXx9cLOUsjEddlPS129hHs9Nfd1wNAZrL8yrmv
         aBu51tNl+LfQNv01twrLPj/ToNBo/yI+0PQ2PKohRL99gNa1xO3S/KQjf2XRxNy724Nt
         uGIeE3EgPv1dZ1ryC/VVqnPLQR9uPgehs4XsvcjHwWYchdt6VsnMpLu4+f0304W3+3pl
         ETY8ogCX49EUG6g09MsTS5FaWaEDrmagzkh6A/eaRKoGQ6uCi/fKL3Z2WRHgJaxAg9aF
         VB5WuagiRGUXq8zRYK3dMReHHkOJDPkn7m8s6XChHzbqQ6FcbAF3/CXW3+7X423X9dX6
         qzTg==
X-Gm-Message-State: AOJu0YwGUN8AhQr+lsLSPSBf6R9kxTnSNMlzcF2lCTi2uj241mbXTYDM
	FwifdSi4UhTri00FVtwPJyl6rbGzd1oyqV6csxenVVUinVvrUiyJ/1ojUhh8tVrUDWLzbiVnQ+O
	UtERrNbNM97mx4ekR/39eOxbl/0wjr6M=
X-Gm-Gg: ASbGncvZTYHuOtxI/dTy1lIllvD5VahJUydjYT6EDutuyDrZknOBFNyhvBaJMwkdUTK
	TEl3o+PZEgx3VfkcQFxmKUoVoLFuGRVCTIY2jl+QPUF9WlqP/PBgi8Gt+ygK4FiI2Ft6c4R+RJC
	cHKMNcnnyoeQThVxOCG1KUPzL8R4ofdzkBEUur88oCheRycBLMClwLlB3OelCxlVC9SoC2Snn2J
	Mqpki3aAHy5TYuJXSmPNm0=
X-Google-Smtp-Source: AGHT+IGoGMaIRM7TJjQwULdMr0LZH8BeBjF+1bmsshwNzD2dDmOLAzoDEcc7f0Z6aiuFXL7FIsGlFZr6SwKU2HONteE=
X-Received: by 2002:a17:902:e84a:b0:234:b41e:37a4 with SMTP id
 d9443c01a7336-2462ede2880mr71219945ad.6.1755901219927; Fri, 22 Aug 2025
 15:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821160817.70285-1-leon.hwang@linux.dev> <20250821160817.70285-6-leon.hwang@linux.dev>
In-Reply-To: <20250821160817.70285-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 15:20:05 -0700
X-Gm-Features: Ac12FXzc4EVHuJ7o0hvQjk8monFq5Y9Wuzwo9j1SmElFU48yVrVp8bFBlGQnoRQ
Message-ID: <CAEf4BzbcAnmHd42gVXJHPJWczYPQ3Vq6t9E+VT-m7UNLzLmidQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] libbpf: Support BPF_F_CPU for percpu maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, olsajiri@gmail.com, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:09=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Add libbpf support for the BPF_F_CPU flag for percpu maps by embedding th=
e
> cpu info into the high 32 bits of:
>
> 1. **flags**: bpf_map_lookup_elem_flags(), bpf_map__lookup_elem(),
>    bpf_map_update_elem() and bpf_map__update_elem()
> 2. **opts->elem_flags**: bpf_map_lookup_batch() and
>    bpf_map_update_batch()
>
> And the flag can be BPF_F_ALL_CPUS, but cannot be
> 'BPF_F_CPU | BPF_F_ALL_CPUS'.
>
> Behavior:
>
> * If the flag is BPF_F_ALL_CPUS, the update is applied across all CPUs.
> * If the flag is BPF_F_CPU, it updates value only to the specified CPU.
> * If the flag is BPF_F_CPU, lookup value only from the specified CPU.
> * lookup does not support BPF_F_ALL_CPUS.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.h    |  8 ++++++++
>  tools/lib/bpf/libbpf.c | 25 +++++++++++++++++++------
>  tools/lib/bpf/libbpf.h | 21 ++++++++-------------
>  3 files changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 7252150e7ad35..28acb15e982b3 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -286,6 +286,14 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int f=
d, void *in_batch,
>   *    Update spin_lock-ed map elements. This must be
>   *    specified if the map value contains a spinlock.
>   *
> + * **BPF_F_CPU**
> + *    As for percpu maps, update value on the specified CPU. And the cpu
> + *    info is embedded into the high 32 bits of **opts->elem_flags**.
> + *
> + * **BPF_F_ALL_CPUS**
> + *    As for percpu maps, update value across all CPUs. This flag cannot
> + *    be used with BPF_F_CPU at the same time.
> + *
>   * @param fd BPF map file descriptor
>   * @param keys pointer to an array of *count* keys
>   * @param values pointer to an array of *count* values
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fe4fc5438678c..c949281984880 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10603,7 +10603,7 @@ bpf_object__find_map_fd_by_name(const struct bpf_=
object *obj, const char *name)
>  }
>
>  static int validate_map_op(const struct bpf_map *map, size_t key_sz,
> -                          size_t value_sz, bool check_value_sz)
> +                          size_t value_sz, bool check_value_sz, __u64 fl=
ags)
>  {
>         if (!map_is_created(map)) /* map is not yet created */
>                 return -ENOENT;
> @@ -10630,6 +10630,19 @@ static int validate_map_op(const struct bpf_map =
*map, size_t key_sz,
>                 int num_cpu =3D libbpf_num_possible_cpus();
>                 size_t elem_sz =3D roundup(map->def.value_size, 8);
>
> +               if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
> +                       if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPU=
S))
> +                               return -EINVAL;
> +                       if ((flags >> 32) >=3D num_cpu)
> +                               return -ERANGE;

The idea of validate_map_op() is to make it easier for users to
understand what's wrong with how they deal with the map, rather than
just getting indiscriminate -EINVAL from the kernel.

Point being: add human-readable pr_warn() explanations for all the new
conditions you are detecting, otherwise it's just meaningless.

> +                       if (value_sz !=3D elem_sz) {
> +                               pr_warn("map '%s': unexpected value size =
%zu provided for per-CPU map, expected %zu\n",
> +                                       map->name, value_sz, elem_sz);
> +                               return -EINVAL;
> +                       }
> +                       break;
> +               }
> +
>                 if (value_sz !=3D num_cpu * elem_sz) {
>                         pr_warn("map '%s': unexpected value size %zu prov=
ided for per-CPU map, expected %d * %zu =3D %zd\n",
>                                 map->name, value_sz, num_cpu, elem_sz, nu=
m_cpu * elem_sz);
> @@ -10654,7 +10667,7 @@ int bpf_map__lookup_elem(const struct bpf_map *ma=
p,
>  {
>         int err;
>
> -       err =3D validate_map_op(map, key_sz, value_sz, true);
> +       err =3D validate_map_op(map, key_sz, value_sz, true, flags);
>         if (err)
>                 return libbpf_err(err);
>
> @@ -10667,7 +10680,7 @@ int bpf_map__update_elem(const struct bpf_map *ma=
p,
>  {
>         int err;
>
> -       err =3D validate_map_op(map, key_sz, value_sz, true);
> +       err =3D validate_map_op(map, key_sz, value_sz, true, flags);
>         if (err)
>                 return libbpf_err(err);
>
> @@ -10679,7 +10692,7 @@ int bpf_map__delete_elem(const struct bpf_map *ma=
p,
>  {
>         int err;
>
> -       err =3D validate_map_op(map, key_sz, 0, false /* check_value_sz *=
/);
> +       err =3D validate_map_op(map, key_sz, 0, false /* check_value_sz *=
/, 0);

hard-coded 0 instead of flags, why?

>         if (err)
>                 return libbpf_err(err);
>
> @@ -10692,7 +10705,7 @@ int bpf_map__lookup_and_delete_elem(const struct =
bpf_map *map,
>  {
>         int err;
>
> -       err =3D validate_map_op(map, key_sz, value_sz, true);
> +       err =3D validate_map_op(map, key_sz, value_sz, true, 0);

same about flags

>         if (err)
>                 return libbpf_err(err);
>
> @@ -10704,7 +10717,7 @@ int bpf_map__get_next_key(const struct bpf_map *m=
ap,
>  {
>         int err;
>
> -       err =3D validate_map_op(map, key_sz, 0, false /* check_value_sz *=
/);
> +       err =3D validate_map_op(map, key_sz, 0, false /* check_value_sz *=
/, 0);
>         if (err)
>                 return libbpf_err(err);
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 2e91148d9b44d..6a972a8d060c3 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1196,12 +1196,13 @@ LIBBPF_API struct bpf_map *bpf_map__inner_map(str=
uct bpf_map *map);
>   * @param key_sz size in bytes of key data, needs to match BPF map defin=
ition's **key_size**
>   * @param value pointer to memory in which looked up value will be store=
d
>   * @param value_sz size in byte of value data memory; it has to match BP=
F map
> - * definition's **value_size**. For per-CPU BPF maps value size has to b=
e
> - * a product of BPF map value size and number of possible CPUs in the sy=
stem
> - * (could be fetched with **libbpf_num_possible_cpus()**). Note also tha=
t for
> - * per-CPU values value size has to be aligned up to closest 8 bytes for
> - * alignment reasons, so expected size is: `round_up(value_size, 8)
> - * * libbpf_num_possible_cpus()`.
> + * definition's **value_size**. For per-CPU BPF maps, value size can be
> + * definition's **value_size** if **BPF_F_CPU** or **BPF_F_ALL_CPUS** is
> + * specified in **flags**, otherwise a product of BPF map value size and=
 number
> + * of possible CPUs in the system (could be fetched with
> + * **libbpf_num_possible_cpus()**). Note else that for per-CPU values va=
lue
> + * size has to be aligned up to closest 8 bytes for alignment reasons, s=
o

nit: aligned up for alignment reasons... drop "for alignment reasons", I gu=
ess?

> + * expected size is: `round_up(value_size, 8) * libbpf_num_possible_cpus=
()`.
>   * @flags extra flags passed to kernel for this operation
>   * @return 0, on success; negative error, otherwise
>   *
> @@ -1219,13 +1220,7 @@ LIBBPF_API int bpf_map__lookup_elem(const struct b=
pf_map *map,
>   * @param key pointer to memory containing bytes of the key
>   * @param key_sz size in bytes of key data, needs to match BPF map defin=
ition's **key_size**
>   * @param value pointer to memory containing bytes of the value
> - * @param value_sz size in byte of value data memory; it has to match BP=
F map
> - * definition's **value_size**. For per-CPU BPF maps value size has to b=
e
> - * a product of BPF map value size and number of possible CPUs in the sy=
stem
> - * (could be fetched with **libbpf_num_possible_cpus()**). Note also tha=
t for
> - * per-CPU values value size has to be aligned up to closest 8 bytes for
> - * alignment reasons, so expected size is: `round_up(value_size, 8)
> - * * libbpf_num_possible_cpus()`.
> + * @param value_sz refer to **bpf_map__lookup_elem**'s description.'
>   * @flags extra flags passed to kernel for this operation
>   * @return 0, on success; negative error, otherwise
>   *
> --
> 2.50.1
>


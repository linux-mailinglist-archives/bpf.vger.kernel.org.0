Return-Path: <bpf+bounces-66315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F730B324E8
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459147B114F
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B53291C1E;
	Fri, 22 Aug 2025 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgyrm22C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204C285CB6
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755900913; cv=none; b=urHUeKwp+GeBY1ou+hwONWbfedsw1IUUahvIIxySkYVwejPrLI0I3y4AsmQlkwRbfcWoBty5srcVEsYqXui62cjgvT/Cp2UH3l/hD9lo/jdmyDLFu6LkdShT1SnLJ9mYOWlbdyK2XUDqRMIoPmpGIU0QOmqZUMpV9yPNLOFX4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755900913; c=relaxed/simple;
	bh=CqpkCAHj/IyfPiA6//EFXbuO/j0Y4YaLU/OvCn+mC9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEx5Ggys0Z6p7FmdWaWrvNpnQaM89FaVm2+gFdsbh99N/f2YBWxN2SkF01UpFE80iGbK6UQv/keqeJ/ladhwqpFVmhyJ2xseCWFmjj8B38BLGTXpWY8fxuh9gUfEkh4NTWxLZXnXMgwG21p3ez5TRFtwgFQGKwWk7WUkPsXytS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgyrm22C; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so2395844b3a.0
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755900910; x=1756505710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBEtCj7EyMG1LYD14TU6RPe9wYbFrsyDz4+BDArSDKw=;
        b=fgyrm22CbgQKgQQl0m7WbKEJwJ6PoX5Ha36D83ZhkuOy8pD7q+TLlY6FwYxTWqUa/n
         sU9VYVmXp/I8V5p0JbEv2mEz7DM9nhTVLgW9huphysHt8M5JsA/cG+IrI2vZS7zKrcHP
         KirxFeOY7z6Z7xMjHkgk2zk8XNfsyWb7GeGXs/RutMkERq1cqkt7vjF3c7F2Y6BXmjEv
         dXcgSxKgnaxY4NjAyLeN1AD51xmLyZHgQZB+9HvEeT32sZDUviL8HrAGy+iCMAlxCni4
         PCM41DLDL4BQyZlwjEp97j/7GirZ7URfGI8aWabm9aTuNAQMTUYTtH23Ex/7icwxZpDu
         BJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755900910; x=1756505710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBEtCj7EyMG1LYD14TU6RPe9wYbFrsyDz4+BDArSDKw=;
        b=qcbCfiQMb6dTBkVjkf55UOb0pTMFHnBIr0GnnVg0ljIgjzXOEE63XlQjU8hgTuMsVj
         ai+QsH8xzLgg5p4mnbhvmJ5Za1yLOxZgvIGrWoEwyM6jqQT+5xmLe1bJNiNNIOt7CBsB
         VB3UFt0ldYIHm9PTPBbIESalXv+/Guzn7k0nmbCKS9TBtpOUxtHXlwoMlPO9LuNqVy94
         MrDKUxRpQOzbP1GjwgcTVsrFYe3H+AgLmDDIwOg1uAcNVFNvKIj7gnAVJke/43gjnPVe
         F9fpNw0O5bFYRh0OkhLjPUmfakmKY5kq2idttzmq4xb7/W0mde3kSky92be01MmD7WDW
         zmJQ==
X-Gm-Message-State: AOJu0Yyo4eXoKw7W0QGm8Tgc9W7l0L+5qxArU8CtfVfTIF2ibJKw/+qM
	mmY95Fuzz6d/0o7PYNwaYKFYC1s+zf61rz7dTb+3ILEcgWMFiwwHNeu9EiZgfTEnnJBWLIWzddW
	ZntWDc6DJeyIbYder6pybmJQJttJQq9c=
X-Gm-Gg: ASbGncvqNVdVXZRmzDulg+rKHw47biQtSM0z1Ts8sUytyqbOxb+OeFDJwwn6U0I5Bb5
	pdJEXowM96Vl74qusjByPI3UKC0pSt3HNv2Owa0DGBTQCLgZA7Rrk1Otx0Hs6ymrnNn11OAXdpx
	ylm2c6Qh2eBL9HWVphzmTvGEJ5EglFn/eizZ7hGxBsZacQ/VeugEcGs1QEkJ/lGAV+O9sWI5GoQ
	LF3w6Yybrh/ESzJOQfrYaM=
X-Google-Smtp-Source: AGHT+IHeJ2FpbjUteZ8htbISH1l+n+h3m0fGPDlwoSjVU400vS2f3aHSABxAvs3fs992MIcVPgWQg80s6WwtJqyuTbI=
X-Received: by 2002:a05:6a21:998a:b0:23d:e6ec:5410 with SMTP id
 adf61e73a8af0-24340d8cd5cmr6881695637.17.1755900910393; Fri, 22 Aug 2025
 15:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821160817.70285-1-leon.hwang@linux.dev> <20250821160817.70285-4-leon.hwang@linux.dev>
In-Reply-To: <20250821160817.70285-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 15:14:54 -0700
X-Gm-Features: Ac12FXwHm55pviaaRR-6Ghlnq1vE3uzarETwbCI_rSEWLCDVxJ37YOa6lQ4C9qI
Message-ID: <CAEf4BzZQBTMNBhp2HhYqGa0sb0X308oabBhWeeizDbw9erXzpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Introduce BPF_F_CPU flag for
 percpu_hash and lru_percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, olsajiri@gmail.com, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:08=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Introduce BPF_F_ALL_CPUS flag support for percpu_hash and lru_percpu_hash
> maps to allow updating values for all CPUs with a single value.
>
> Introduce BPF_F_CPU flag support for percpu_hash and lru_percpu_hash
> maps to allow updating value for specified CPU.
>
> This enhancement enables:
>
> * Efficient update values across all CPUs with a single value when
>   BPF_F_ALL_CPUS is set for update_elem and update_batch APIs.
> * Targeted update or lookup for a specified CPU when BPF_F_CPU is set.
>
> The BPF_F_CPU flag is passed via:
>
> * map_flags of lookup_elem and update_elem APIs along with embedded cpu
>   field.
> * elem_flags of lookup_batch and update_batch APIs along with embedded
>   cpu field.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h   |  54 +++++++++++++++++++-
>  kernel/bpf/arraymap.c |  29 ++++-------
>  kernel/bpf/hashtab.c  | 111 +++++++++++++++++++++++++++++-------------
>  kernel/bpf/syscall.c  |  30 +++---------
>  4 files changed, 147 insertions(+), 77 deletions(-)
>

[...]

> @@ -397,22 +395,14 @@ int bpf_percpu_array_update(struct bpf_map *map, vo=
id *key, void *value,
>                             u64 map_flags)
>  {
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> -       const u64 cpu_flags =3D BPF_F_CPU | BPF_F_ALL_CPUS;
>         u32 index =3D *(u32 *)key;
>         void __percpu *pptr;
> +       int off =3D 0, err;
>         u32 size, cpu;
> -       int off =3D 0;
> -
> -       if (unlikely((u32)map_flags > BPF_F_ALL_CPUS))
> -               /* unknown flags */
> -               return -EINVAL;
> -       if (unlikely((map_flags & cpu_flags) =3D=3D cpu_flags))
> -               return -EINVAL;
>
> -       cpu =3D map_flags >> 32;
> -       if (unlikely((map_flags & BPF_F_CPU) && cpu >=3D num_possible_cpu=
s()))
> -               /* invalid cpu */
> -               return -ERANGE;
> +       err =3D bpf_map_check_cpu_flags(map_flags, true);
> +       if (unlikely(err))
> +               return err;

again, unnecessary churn, why not add this function in previous patch
when you add cpu flags ?


>
>         if (unlikely(index >=3D array->map.max_entries))
>                 /* all elements were pre-allocated, cannot insert a new o=
ne */
> @@ -432,6 +422,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void=
 *key, void *value,
>         rcu_read_lock();
>         pptr =3D array->pptrs[index & array->index_mask];
>         if (map_flags & BPF_F_CPU) {
> +               cpu =3D map_flags >> 32;
>                 copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
>                 bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, =
cpu));
>         } else {
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 71f9931ac64cd..34a35cdade425 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -937,24 +937,39 @@ static void free_htab_elem(struct bpf_htab *htab, s=
truct htab_elem *l)
>  }
>
>  static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
> -                           void *value, bool onallcpus)
> +                           void *value, bool onallcpus, u64 map_flags)
>  {
> +       int cpu =3D map_flags & BPF_F_CPU ? map_flags >> 32 : 0;
> +       int current_cpu =3D raw_smp_processor_id();
> +
>         if (!onallcpus) {
>                 /* copy true value_size bytes */
> -               copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
> +               copy_map_value(&htab->map, (map_flags & BPF_F_CPU) && cpu=
 !=3D current_cpu ?
> +                              per_cpu_ptr(pptr, cpu) : this_cpu_ptr(pptr=
), value);

is there any benefit to this cpu =3D=3D current_cpu special casing?
Wouldn't per_cpu_ptr() do the right thing even if cpu =3D=3D current_cpu?

>         } else {
>                 u32 size =3D round_up(htab->map.value_size, 8);
> -               int off =3D 0, cpu;
> +               int off =3D 0;
> +
> +               if (map_flags & BPF_F_CPU) {
> +                       copy_map_value_long(&htab->map, cpu !=3D current_=
cpu ?
> +                                           per_cpu_ptr(pptr, cpu) : this=
_cpu_ptr(pptr), value);
> +                       return;
> +               }

[...]

> @@ -1806,10 +1834,17 @@ __htab_map_lookup_and_delete_batch(struct bpf_map=
 *map,
>                         void __percpu *pptr;
>
>                         pptr =3D htab_elem_get_ptr(l, map->key_size);
> -                       for_each_possible_cpu(cpu) {
> -                               copy_map_value_long(&htab->map, dst_val +=
 off, per_cpu_ptr(pptr, cpu));
> -                               check_and_init_map_value(&htab->map, dst_=
val + off);
> -                               off +=3D size;
> +                       if (!do_delete && (elem_map_flags & BPF_F_CPU)) {

if do_delete is true we can't have BPF_F_CPU set, right? We checked
that above, so why all these complications?

> +                               cpu =3D elem_map_flags >> 32;
> +                               copy_map_value_long(&htab->map, dst_val, =
per_cpu_ptr(pptr, cpu));
> +                               check_and_init_map_value(&htab->map, dst_=
val);
> +                       } else {
> +                               for_each_possible_cpu(cpu) {
> +                                       copy_map_value_long(&htab->map, d=
st_val + off,
> +                                                           per_cpu_ptr(p=
ptr, cpu));
> +                                       check_and_init_map_value(&htab->m=
ap, dst_val + off);
> +                                       off +=3D size;
> +                               }
>                         }
>                 } else {
>                         value =3D htab_elem_value(l, key_size);
> @@ -2365,14 +2400,18 @@ static void *htab_lru_percpu_map_lookup_percpu_el=
em(struct bpf_map *map, void *k
>         return NULL;
>  }
>
> -int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
> +int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u6=
4 map_flags)
>  {
> +       int ret, cpu, off =3D 0;
>         struct htab_elem *l;
>         void __percpu *pptr;
> -       int ret =3D -ENOENT;
> -       int cpu, off =3D 0;
>         u32 size;
>
> +       ret =3D bpf_map_check_cpu_flags(map_flags, false);
> +       if (unlikely(ret))
> +               return ret;
> +       ret =3D -ENOENT;
> +
>         /* per_cpu areas are zero-filled and bpf programs can only
>          * access 'value_size' of them, so copying rounded areas
>          * will not leak any kernel data
> @@ -2386,10 +2425,16 @@ int bpf_percpu_hash_copy(struct bpf_map *map, voi=
d *key, void *value)
>          * eviction heuristics when user space does a map walk.
>          */
>         pptr =3D htab_elem_get_ptr(l, map->key_size);
> -       for_each_possible_cpu(cpu) {
> -               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, c=
pu));
> -               check_and_init_map_value(map, value + off);
> -               off +=3D size;
> +       if (map_flags & BPF_F_CPU) {
> +               cpu =3D map_flags >> 32;
> +               copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
> +               check_and_init_map_value(map, value);
> +       } else {
> +               for_each_possible_cpu(cpu) {
> +                       copy_map_value_long(map, value + off, per_cpu_ptr=
(pptr, cpu));
> +                       check_and_init_map_value(map, value + off);
> +                       off +=3D size;
> +               }
>         }

it feels like this whole logic of copying per-cpu value to/from user
should be generic between all per-cpu maps, once we get that `void
__percpu *` pointer, no? See if you can extract it as reusable helper
(but, you know, without all the per-map type special casing, though it
doesn't seem like you should need it, though I might be missing
details, of course). One for bpf_percpu_copy_to_user() and another for
bpf_percpu_copy_from_user(), which would take into account all these
cpu flags?


[...]


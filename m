Return-Path: <bpf+bounces-62002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84454AF04B7
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384517AC45B
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E2E2EACEE;
	Tue,  1 Jul 2025 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5cbYITD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DD2EA72E
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401340; cv=none; b=ROJNJXGFhl06LTJ2r8s7eVKZRyN/Oph/qvV4NUUzdOH6RU/DM2zVLFdwDECStNz4GyQys7yslTsaU1RbrSQCjYQqW5TxPzKx5TSm9SZpMJgSNBnXjIJH3uHw9vY1DlxOPdWFS5At/BYDxNn6+uLdBy9x3DZ02e5r4F9uvfTTUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401340; c=relaxed/simple;
	bh=CHjcwgnQpKLxqBkJjyFHKhxKpGDqGrk1POp0KltV/Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhV59+BPCUc/nZTv+oZgNEMhe+O6OxSRVdbQrXq/FuSjPL8HzndPLekmxmzIuWXHYc/o/99VOe2EJcq0ZKJ/IPTH4dh8+j/cF7pknOQ+JcSJqbXXDIp83Rp/3KAVoj0DMGIqClXH33L3vAoE4Hdsl8qkM9Zv8p7pw+iVicGRVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5cbYITD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso3895902a91.3
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751401338; x=1752006138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOPBTUOutkIuIa+kDPweSpx5523Jh1hIzo5JrBlEzbA=;
        b=c5cbYITDWiqy/B6qUUGVV6sI5Hw6iID2x3bhufQs0ANr5Ko1SaJyGg6c80UPbI7aAu
         DnsFQQVTU2jfpwD3Gu/65EaTXs/Ta5JaZNdXy6HOvF4nYeVsBolLGwR+45gM6edonxpr
         2VIo296YQMILpvCLMbag5XjxJfAduxteytFZCbdUPUly0cRmvmJB75Eiv5FfNoxyD48b
         SHlHKbZhr8JxSJ617pq2/pciv+ug4dge+75w19MFeHdKFzZCwR0EiSioTHaw+dZ3w82j
         KH/l9/UVbfmaPHFuJg/953qSHSimU9PufH/UyLjB9/GdH/BQzx12As3LFrFo00zCVn27
         2RmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751401338; x=1752006138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOPBTUOutkIuIa+kDPweSpx5523Jh1hIzo5JrBlEzbA=;
        b=uClANWVb/fHrjL0AEcYjTyqdPltNMSaZ+ijUIY4rz8EuYLAlcYPsf10JGfwVkAPur0
         4MmatqsCZc2JD3xxDkUjEGmm3TZVRHilFOFJ9St6FEzHZ8Y5ZwFBayAu+5A/XzLmaJqz
         546UjOwZH+KOe3eHSqBHLBpVnqLxTEtOC4vyw0DaBIFqsQi1fanialtraGa3FGpXIgcT
         iDD37HemaB4P62Nb4xZiIRYiBUKGesZnpyj2/6Y0A/dauAVglt2sI8mNpqlxWJawv5BG
         fe4b7llNDMFJjCqiazA58qdDkkfkrQCtQYrnEOGYp5l3z93OCqLU36I9Nq3pZB5l6n0y
         mPDQ==
X-Gm-Message-State: AOJu0Yy0s+gSfIiWhq2tpkJ/uUMC4KLPz3bdL/3bgIcG1R+zr1ZSUzzc
	WAbHcKpBQYllrZnbSk95hydRaZzbkjvL1DKeVAwS2tc5uYXs/MD3k05gz4118hgk0I32jEe9TrT
	ioXIf9AXmsFO1Om2c0GEJVINoU9aIkoDQMuiH
X-Gm-Gg: ASbGncvSQQ4THr4p0pdpYBBSIn9+5MQNIk5JNrDqa4eJU6fkgqkDViKpl1iwhpYZ2o8
	0P/zKtr5uNBEv+qYU+9bl+FQKtxlESNoRNxlq6foRzuYaXT5Cx0v0zUCaLtNNXwOf5jhTg65hGe
	lZQQgHgpK0xrhRK7bydr8wt5W2ydcR9gpUhuPN1k6dWPUrBh8jMgtu9f47AKvXAWf30aLHbw==
X-Google-Smtp-Source: AGHT+IEcEiAND7v4TxmzbvxKYMbqhHwfY0D1H+qlEuGhXiu+7M6PKT8AANikJT9u6poZLz0HQ0RY/sy8FW481jqCCIQ=
X-Received: by 2002:a17:90b:5345:b0:311:c1ec:7d11 with SMTP id
 98e67ed59e1d1-31a90bd7750mr613591a91.18.1751401337730; Tue, 01 Jul 2025
 13:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624165354.27184-1-leon.hwang@linux.dev> <20250624165354.27184-2-leon.hwang@linux.dev>
In-Reply-To: <20250624165354.27184-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Jul 2025 13:22:02 -0700
X-Gm-Features: Ac12FXz33b0AmqXACAM1FzvmhNSkqEUFz2eCyzM7zMU4JqhtD9ThgSSRODm2WfY
Message-ID: <CAEf4BzYFjKEdpf9xHfeW8hs+zzmppvw2-RzJELrRc=QfKfga1A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array map
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 9:54=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch introduces support for the BPF_F_CPU flag in percpu_array maps
> to allow updating or looking up values for specific CPUs or for all CPUs
> with a single value.
>
> This enhancement enables:
>
> * Efficient update of all CPUs using a single value when cpu =3D=3D 0xFFF=
FFFFF.
> * Targeted update or lookup for a specific CPU otherwise.
>
> The flag is passed via:
>
> * map_flags in bpf_percpu_array_update() along with the cpu field.
> * elem_flags in generic_map_update_batch() along with the cpu field.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h            |  5 +--
>  include/uapi/linux/bpf.h       |  6 ++++
>  kernel/bpf/arraymap.c          | 46 ++++++++++++++++++++++++----
>  kernel/bpf/syscall.c           | 56 ++++++++++++++++++++++------------
>  tools/include/uapi/linux/bpf.h |  6 ++++
>  5 files changed, 92 insertions(+), 27 deletions(-)
>

[...]

> #define BPF_ALL_CPU    0xFFFFFFFF

at the very least we have to make it an enum, IMO. but I'm in general
unsure if we need it at all... and in any case, should it be named
"BPF_ALL_CPUS" (plural)?


> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
> +                         u64 flags, u32 cpu)
>  {
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         u32 index =3D *(u32 *)key;
>         void __percpu *pptr;
> -       int cpu, off =3D 0;
> +       int off =3D 0;
>         u32 size;
>
>         if (unlikely(index >=3D array->map.max_entries))
>                 return -ENOENT;
>
> +       if (unlikely(flags > BPF_F_CPU))
> +               /* unknown flags */
> +               return -EINVAL;
> +
>         /* per_cpu areas are zero-filled and bpf programs can only
>          * access 'value_size' of them, so copying rounded areas
>          * will not leak any kernel data
>          */
>         size =3D array->elem_size;
> +
> +       if (flags & BPF_F_CPU) {
> +               if (cpu >=3D num_possible_cpus())
> +                       return -E2BIG;
> +
> +               rcu_read_lock();
> +               pptr =3D array->pptrs[index & array->index_mask];
> +               copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
> +               check_and_init_map_value(map, value);
> +               rcu_read_unlock();
> +               return 0;
> +       }
> +

nit: it seems a bit cleaner to me to not duplicate
rcu_read_{lock,unlock} and pptr fetching

I'd probably add `if ((flags & BPF_F_CPU) && cpu >=3D
num_possible_cpus())` check, and then within rcu region

if (flags & BPF_F_CPU) {
    copy_map_value_long(...);
    check_and_init_map_value(...);
} else {
    for_each_possible_cpu(cpu) {
       copy_map_value_long(...);
       check_and_init_map_value(...);
    }
}


This to me is more explicitly showing that locking/data fetching isn't
different, and it's only about singular CPU vs all CPUs

(oh, and move int off inside the else branch then as well)


>         rcu_read_lock();
>         pptr =3D array->pptrs[index & array->index_mask];
>         for_each_possible_cpu(cpu) {
> @@ -382,15 +400,16 @@ static long array_map_update_elem(struct bpf_map *m=
ap, void *key, void *value,
>  }
>
>  int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
> -                           u64 map_flags)
> +                           u64 map_flags, u32 cpu)
>  {
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         u32 index =3D *(u32 *)key;
>         void __percpu *pptr;
> -       int cpu, off =3D 0;
> +       bool reuse_value;
> +       int off =3D 0;
>         u32 size;
>
> -       if (unlikely(map_flags > BPF_EXIST))
> +       if (unlikely(map_flags > BPF_F_CPU))
>                 /* unknown flags */
>                 return -EINVAL;
>
> @@ -409,10 +428,25 @@ int bpf_percpu_array_update(struct bpf_map *map, vo=
id *key, void *value,
>          * so no kernel data leaks possible
>          */
>         size =3D array->elem_size;
> +
> +       if ((map_flags & BPF_F_CPU) && cpu !=3D BPF_ALL_CPU) {
> +               if (cpu >=3D num_possible_cpus())
> +                       return -E2BIG;
> +
> +               rcu_read_lock();
> +               pptr =3D array->pptrs[index & array->index_mask];
> +               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
> +               bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, =
cpu));
> +               rcu_read_unlock();
> +               return 0;
> +       }
> +
> +       reuse_value =3D (map_flags & BPF_F_CPU) && cpu =3D=3D BPF_ALL_CPU=
;
>         rcu_read_lock();
>         pptr =3D array->pptrs[index & array->index_mask];
>         for_each_possible_cpu(cpu) {
> -               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + =
off);
> +               copy_map_value_long(map, per_cpu_ptr(pptr, cpu),
> +                                   reuse_value ? value : value + off);
>                 bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, =
cpu));
>                 off +=3D size;


ditto here, I'd not touch rcu locking and bpf_obj_free_fields. The
difference would be singular vs all CPUs, and then for all CPUs with
BPF_F_CPU we just don't update off, getting desired behavior without
extra reuse_value variable?

[...]

> @@ -1941,19 +1941,27 @@ int generic_map_update_batch(struct bpf_map *map,=
 struct file *map_file,
>  {
>         void __user *values =3D u64_to_user_ptr(attr->batch.values);
>         void __user *keys =3D u64_to_user_ptr(attr->batch.keys);
> +       u64 elem_flags =3D attr->batch.elem_flags;
>         u32 value_size, cp, max_count;
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
> +       if (elem_flags & BPF_F_CPU) {
> +               if (map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +                       return -EINVAL;
> +
> +               value_size =3D round_up(map->value_size, 8);
> +       } else {
> +               value_size =3D bpf_map_value_size(map);
> +       }

why not roll this into bpf_map_value_size() helper? it's internal,
should be fine

pw-bot: cr

>
>         max_count =3D attr->batch.count;
>         if (!max_count)
> @@ -1980,7 +1988,8 @@ int generic_map_update_batch(struct bpf_map *map, s=
truct file *map_file,
>                         break;
>
>                 err =3D bpf_map_update_value(map, map_file, key, value,
> -                                          attr->batch.elem_flags);
> +                                          attr->batch.elem_flags,
> +                                          attr->batch.cpu);

So I think we discussed cpu as a separate field vs embedded into flags
field, right? I don't remember what I argued for, but looking at this
patch, it seems like it would be more convenient to have cpu come as
part of flags, no? And I don't mean UAPI-side, there separate cpu
field I think makes most sense. But internally I'd roll it into flags
as ((cpu << 32) | flags), instead of dragging it around everywhere. It
feels unclean to have "cpu" argument to generic
bpf_map_copy_value()...

(and looking at how much code we add just to pass that extra cpu
argument through libbpf API, maybe combining cpu and flags is actually
a way to go?..)

WDYT?


[...]


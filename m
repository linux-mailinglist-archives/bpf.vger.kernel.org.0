Return-Path: <bpf+bounces-63078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B8CB0235B
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B53A40234
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5490A2F1FEC;
	Fri, 11 Jul 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjJ9xhug"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B72F1FF2
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257471; cv=none; b=t+EVCM+l0FX514GRjj/inXjq/Vj1HzvZUvHIyZ5QiC1cj1qvSRV0XvWCQkOimOg112jjHcOQCmdxwNQzrQhJjA6/stEwmimuDkyr0/vwLYBFjHxrucl7KNs36ofVHOsZraNDUsKobMUp/ooDl+585/pjA/vRC1Nz/fH/iL2UE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257471; c=relaxed/simple;
	bh=AxX6LYv/4mutROeYlbrlIY9D5+PKuYqUOJhXLaMGWWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvKrq+FjPF892VoClvTKOUkaqO8rJ1A5k0bZUsDbzcr1nO3Gg4rrUNSbKxraVzQcFWiPy6/1u1+4taAMgGe0YpkvlWUMyo7lmtr4GqYyebaXuH0Sm46/ME1xgCyql5Ky5pFBDhW3eWVQ6FdFfgH8yumHkFTl2oEVKD5OjPRh5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjJ9xhug; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313cde344d4so2578293a91.0
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752257469; x=1752862269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSvZvyC0i0/FlhfGy3P+557Xz9DxmqPA3m4AdTO7fKU=;
        b=AjJ9xhugS4kCUTurURSSfh9s8l0MrL0ANNd4W/UifBsjFT/vEsjD/CzYdKvDNdIHlH
         tDj0jtDBcTQc9RHbxXLpNnTpqRw+cAXorGBiEvFAj2mKzGR52HbJktxAEqsbPH95L5ie
         BX7134kCrl5xVfGdcDUqvpL6xg1QaCIdTIfmqsjiF6FUAjzzdvQIK+VLrHOAS4l4eqip
         +/nbD+sefGF59DRzegjo+p6UK3cQcuQmO3HIXdehjg9RIj6/wltubFX4eEIX4Sk6YKHI
         bB+2eGRZslBoC5Gz0UDwC4M5GofZ/iewJx/KRrUP4Vpa3gGKNvGVeeg6wTR+51MReaTq
         Rcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257469; x=1752862269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSvZvyC0i0/FlhfGy3P+557Xz9DxmqPA3m4AdTO7fKU=;
        b=L3oCBhrUu8ggdK0KZLBsfQp3Bm9wRiu1IinH5Be5OrJ8WQsP66OzffAGr99cAL8vbK
         Ki80YMbZpzdbdQUyJqNlOcFT8CvLvkAJ3zw2VyZhQf5K68lS5+LEv5vqjg8Pn2X1h/RO
         OK50yBTYQtFoEZy7GkrJKvt8IodB5+1vi7/kX3nCoOfVr/iJl7jz3aeNQZm9Mjc/bBTl
         xPfXuCIij+Wa1E0GVPrbbGmQ+RZZESfMErEakBL8hnLqhrirCsZGjPugZvlczQo6pMsc
         F1qiR+Qb8LTqeInT1T14YAWNw9EwVyNdCTDi3fk68AOKdSFZSmhi740OAMOQ0Bq2svJr
         vlRw==
X-Gm-Message-State: AOJu0YzlmVMjjy8YYG+ccX6+gxeLobvPwQtKaEHQ6jH7jUDZyos0ZAnP
	BlLrIpR+waYNF3ckIWHa3y7S9YztlUBo/ElfJYGgU/BBnXXkYfuXCSBEg7km8e8XQiH2OG0RH5+
	9XxGpYVuG9G66O1/AnykaO345paf9QjGjWA==
X-Gm-Gg: ASbGncsz6f9HIwcg7U8Sk9czgWyYsNyzSaSizJ0lAaAcCP61IETwrmV3wpJVhZfXrHX
	gOdNMUQVNRQOkSuMFDftCLXWFemqj0b/PqzQvsPW8mU0PGtXTM2AusIAVhnsZXI7PIhnumANx5+
	x9uX1eNyG0fDhf1fjbCh4dHfweNgsMkBZUj2lJeNIn3TC55v9j48njd9Km4OCj/oE8FGTkWF1AJ
	dcN+TltcuJT0vXmSeo8HW2GrZShE+Ucaw==
X-Google-Smtp-Source: AGHT+IEtbMPUk7QfkR3z6WH5oR2XQN4wZGk3nBjjbUWAZzr6KBx+KOwP9XNYl8+C4YHxZi2MYAwFipWtF+U0oTVyNXk=
X-Received: by 2002:a17:90b:3942:b0:311:c1ec:7d12 with SMTP id
 98e67ed59e1d1-31c4f591c3amr4732518a91.23.1752257469260; Fri, 11 Jul 2025
 11:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707160404.64933-1-leon.hwang@linux.dev> <20250707160404.64933-2-leon.hwang@linux.dev>
In-Reply-To: <20250707160404.64933-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Jul 2025 11:10:53 -0700
X-Gm-Features: Ac12FXxJc-7c1t1FUjeqXHZBEE85KhFOsnUH0MM6vCRa914aMYcVBYFTIWgUmbY
Message-ID: <CAEf4BzZCzd0VGNBoLOd=ENxPnwsynuwvKdNYkKhUc7ARFCudSQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array map
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:04=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> This patch introduces support for the BPF_F_CPU flag in percpu_array maps
> to allow updating or looking up values for specified CPUs or for all CPUs
> with a single value.
>

For next revision, please drop RFC tag, so this is tested and reviewed
as a proper patch set.

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
>  kernel/bpf/arraymap.c          | 56 ++++++++++++++++++++++++++--------
>  kernel/bpf/syscall.c           | 52 +++++++++++++++++++------------
>  tools/include/uapi/linux/bpf.h |  7 +++++
>  5 files changed, 92 insertions(+), 33 deletions(-)
>

[...]

>
> +       cpu =3D (u32)(flags >> 32);
> +       flags &=3D (u32)~0;
> +       if (unlikely(flags > BPF_F_CPU))
> +               return -EINVAL;
> +       if (unlikely((flags & BPF_F_CPU) && cpu >=3D num_possible_cpus())=
)
> +               return -E2BIG;
> +
>         /* per_cpu areas are zero-filled and bpf programs can only
>          * access 'value_size' of them, so copying rounded areas
>          * will not leak any kernel data
> @@ -313,10 +320,15 @@ int bpf_percpu_array_copy(struct bpf_map *map, void=
 *key, void *value)
>         size =3D array->elem_size;
>         rcu_read_lock();
>         pptr =3D array->pptrs[index & array->index_mask];
> -       for_each_possible_cpu(cpu) {
> -               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, c=
pu));
> -               check_and_init_map_value(map, value + off);
> -               off +=3D size;
> +       if (flags & BPF_F_CPU) {
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
>         rcu_read_unlock();
>         return 0;
> @@ -387,13 +399,21 @@ int bpf_percpu_array_update(struct bpf_map *map, vo=
id *key, void *value,
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         u32 index =3D *(u32 *)key;
>         void __percpu *pptr;
> -       int cpu, off =3D 0;
> -       u32 size;
> +       bool reuse_value;
> +       u32 size, cpu;
> +       int off =3D 0;
>
> -       if (unlikely(map_flags > BPF_EXIST))
> +       cpu =3D (u32)(map_flags >> 32);
> +       map_flags =3D map_flags & (u32)~0;

be consistent, use &=3D approach as above

> +       if (unlikely(map_flags > BPF_F_CPU))
>                 /* unknown flags */
>                 return -EINVAL;
>
> +       if (unlikely((map_flags & BPF_F_CPU) && cpu !=3D BPF_ALL_CPUS &&
> +                    cpu >=3D num_possible_cpus()))
> +               /* invalid cpu */
> +               return -E2BIG;
> +
>         if (unlikely(index >=3D array->map.max_entries))
>                 /* all elements were pre-allocated, cannot insert a new o=
ne */
>                 return -E2BIG;
> @@ -409,12 +429,22 @@ int bpf_percpu_array_update(struct bpf_map *map, vo=
id *key, void *value,
>          * so no kernel data leaks possible
>          */
>         size =3D array->elem_size;
> +       reuse_value =3D (map_flags & BPF_F_CPU) && cpu =3D=3D BPF_ALL_CPU=
S;

I find "reuse_value" name extremely misleading, I stumble upon this
every time (because "value" is ambiguous, is it the source value or
map value we are updating?). Please drop it, there is no need for it,
just do `map_flags & BPF_F_CPU` check in that for_each_possible_cpu
loop below

>         rcu_read_lock();
>         pptr =3D array->pptrs[index & array->index_mask];
> -       for_each_possible_cpu(cpu) {
> -               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + =
off);
> +       if ((map_flags & BPF_F_CPU) && cpu !=3D BPF_ALL_CPUS) {
> +               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
>                 bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, =
cpu));
> -               off +=3D size;
> +       } else {
> +               for_each_possible_cpu(cpu) {
> +                       if (!reuse_value) {
> +                               copy_map_value_long(map, per_cpu_ptr(pptr=
, cpu), value + off);
> +                               off +=3D size;
> +                       } else {
> +                               copy_map_value_long(map, per_cpu_ptr(pptr=
, cpu), value);
> +                       }

simpler and less duplication:

copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
/*
 * same user-provided value is used if BPF_F_CPU is specified,
 * otherwise value is an array of per-cpu values
 */
if (!(map_flags & BPF_F_CPU))
    off +=3D size;

> +                       bpf_obj_free_fields(array->map.record, per_cpu_pt=
r(pptr, cpu));
> +               }
>         }
>         rcu_read_unlock();
>         return 0;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7db7182a3057..a3ce0cdecb3c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -129,8 +129,12 @@ bool bpf_map_write_active(const struct bpf_map *map)
>         return atomic64_read(&map->writecnt) !=3D 0;
>  }
>
> -static u32 bpf_map_value_size(const struct bpf_map *map)
> +static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
>  {
> +       if ((flags & BPF_F_CPU) &&
> +               map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)

formatting is off, keep single line

> +               return round_up(map->value_size, 8);
> +
>         if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
>             map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
>             map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
> @@ -312,7 +316,7 @@ static int bpf_map_copy_value(struct bpf_map *map, vo=
id *key, void *value,
>             map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH) {
>                 err =3D bpf_percpu_hash_copy(map, key, value);
>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
> -               err =3D bpf_percpu_array_copy(map, key, value);
> +               err =3D bpf_percpu_array_copy(map, key, value, flags);
>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAG=
E) {
>                 err =3D bpf_percpu_cgroup_storage_copy(map, key, value);
>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_STACK_TRACE) {
> @@ -1662,7 +1666,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>         if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
>                 return -EINVAL;
>
> -       if (attr->flags & ~BPF_F_LOCK)
> +       if ((attr->flags & (u32)~0) & ~(BPF_F_LOCK | BPF_F_CPU))

nit: this whole `attr->flags & (u32)~0` looks like an over-engineered
`(u32)attr->flags`...

>                 return -EINVAL;

we should probably also have a condition checking that upper 32 bits
are zero if BPF_F_CPU is not set?

>
>         CLASS(fd, f)(attr->map_fd);
> @@ -1680,7 +1684,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>         if (IS_ERR(key))
>                 return PTR_ERR(key);
>
> -       value_size =3D bpf_map_value_size(map);
> +       value_size =3D bpf_map_value_size(map, attr->flags);
>
>         err =3D -ENOMEM;
>         value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> @@ -1749,7 +1753,7 @@ static int map_update_elem(union bpf_attr *attr, bp=
fptr_t uattr)
>                 goto err_put;
>         }
>
> -       value_size =3D bpf_map_value_size(map);
> +       value_size =3D bpf_map_value_size(map, attr->flags);
>         value =3D kvmemdup_bpfptr(uvalue, value_size);
>         if (IS_ERR(value)) {
>                 err =3D PTR_ERR(value);
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
> +               return -EINVAL;
> +
> +       value_size =3D bpf_map_value_size(map, elem_flags);
> +       elem_flags =3D (((u64)cpu) << 32) | elem_flags;

nit: elem_flags |=3D (u64)cpu << 32;

same effect, but a bit more explicitly stating "we are just adding
stuff to elem_flags"

>
>         max_count =3D attr->batch.count;
>         if (!max_count)
> @@ -1979,8 +1989,7 @@ int generic_map_update_batch(struct bpf_map *map, s=
truct file *map_file,
>                     copy_from_user(value, values + cp * value_size, value=
_size))
>                         break;
>
> -               err =3D bpf_map_update_value(map, map_file, key, value,
> -                                          attr->batch.elem_flags);
> +               err =3D bpf_map_update_value(map, map_file, key, value, e=
lem_flags);
>
>                 if (err)
>                         break;
> @@ -2004,18 +2013,24 @@ int generic_map_lookup_batch(struct bpf_map *map,
>         void __user *ubatch =3D u64_to_user_ptr(attr->batch.in_batch);
>         void __user *values =3D u64_to_user_ptr(attr->batch.values);
>         void __user *keys =3D u64_to_user_ptr(attr->batch.keys);
> +       u32 value_size, cp, max_count, cpu =3D attr->batch.cpu;
>         void *buf, *buf_prevkey, *prev_key, *key, *value;
> -       u32 value_size, cp, max_count;
> +       u64 elem_flags =3D attr->batch.elem_flags;
>         int err;
>
> -       if (attr->batch.elem_flags & ~BPF_F_LOCK)
> +       if (elem_flags & ~(BPF_F_LOCK | BPF_F_CPU))
>                 return -EINVAL;
>
> -       if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> +       if ((elem_flags & BPF_F_LOCK) &&
>             !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>                 return -EINVAL;
>
> -       value_size =3D bpf_map_value_size(map);
> +       if ((elem_flags & BPF_F_CPU) &&
> +               map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +               return -EINVAL;
> +
> +       value_size =3D bpf_map_value_size(map, elem_flags);
> +       elem_flags =3D (((u64)cpu) << 32) | elem_flags;
>

ditto

>         max_count =3D attr->batch.count;
>         if (!max_count)

[...]


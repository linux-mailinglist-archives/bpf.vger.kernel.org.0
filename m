Return-Path: <bpf+bounces-70452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B23BBFB1F
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 00:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3323BED9A
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0B41DF261;
	Mon,  6 Oct 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdwFeRXe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE4288A2
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790017; cv=none; b=Dzv2W/l5hxAyoOmBZHdfVNJ+STASZPvoqqpXhlY7OefiF+8O5LtJYu2MutTPMYn/IBi1ovpWHtd4yhO8Mt1jNh/tOcPIvnshVzKzlKV5nuE1kSaldbqvndQoOYETDh6I0nlZN19MoBp6s1Q7jsTslqvq3ZvRaw5ddv1iNKCEiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790017; c=relaxed/simple;
	bh=yLw8fylRlPw2gvkncXT/IFYqaZTI95TjPb4O1oXGTeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gpe2V1pLnaelykm6Z9GFM3tjEZUaXCH2i6igFhrcTQLkgYj/csWyvsGiyu0Cs7hs2yhaYzHLqIa9+r+JSQqdn27RbRUGACAKIxHptZFXJI7Jd+zO+ZkUdI9PnGHNGbDwdzjTKEcqaHvszYAW6sqzejudYfk8H1M/Shu1PTg+3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdwFeRXe; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b57bf560703so4001860a12.2
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 15:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759790015; x=1760394815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58v5k8gEKsxcHO6Mr+tFu30Zm0tr0fSTG2lDuYQw5Y4=;
        b=PdwFeRXearlQBN3zRiiAawgpfVBm7wC2CDSqJifUS9w9TTOCEkKzUGbJIdSJ2Om0M/
         LmMUMIDZXvhaV+b+KMK7euSYogiHDBFW0TasDdHI+XrP5HOzh0rPdHkgQxcaBqPlmUgW
         s65T3JZZ7uhm7r0g5FygcgAd4ZIDIOX7pb/LXHv7K7zgemdvLJMjEAv47uvMIY6k71dT
         dmlFw5J/fUSeR7Xmgywctt41CJVsGkUegfA05kKjVKm0HsOoy0x6LHM5Xf5fnjEjFQds
         tKWVsikZyQjBFlSOE5mT6Hp1nyReqd1xJhsLBI50K5BEIcLsw0KnCrjg7BLzVcDVYvDM
         YgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759790015; x=1760394815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58v5k8gEKsxcHO6Mr+tFu30Zm0tr0fSTG2lDuYQw5Y4=;
        b=fX7gpjskpzUlRxTLjmNUejIH2tLu4x3Ch/aKxrpkZ0cpeWV7yziyYt0vLorlAL0cRA
         weD1AnAYcmxDyqhuNL+YexYaSLnj2zNr42SbK7t9oi/hpx4m7FsszJ/F+5hXH+/pTM9e
         X2Jwj8QPyn7aqMXly1rOHWqZOGpEabXMY4QDO55jjQmbKQwGjyelTFBf2coMoc7UgUov
         JaEJbFyLl9vjwopIOBXdeOYhK/1Aq91reXTphScrGRcUwXdnFc/oo9ndtXfYp/1S6x/P
         rOx1vJCiPBkowdXLhorZcRzPL7pEx481MLLl4iq6r/uCmIJ0QG6tOKbDHnQjdmXLOEyk
         UqkQ==
X-Gm-Message-State: AOJu0Yymb7qxY2mX0ZheGwDUNA8pk4URA1GDzSPCxMFldAAzn3ldL7nG
	cM5IjDz7Mp1bzNwagmV1Y0VdrvnOJdFn7PoZBZbu3oCmGLRANa0J22qmTP7aCNnzOPVSWbDc5Rt
	1AeztFYJSE2Ez0VYR5x4dEfxfLKvxJ2g=
X-Gm-Gg: ASbGnctJxQu7UC/iwvtcp6HklDqYqOAfjZoCbqq/W4fAN26ILU7XrRZXAl5m4mxpEGq
	mBEOMgATdlqcGpC9sIqvDUTEs5UpujnXipe7KiMfyDQvAbnD2d090oyPORxZ430pD6mGM61LeCT
	s95NufuG6FJFznDXrhIe0056sD5Q5nhNM+jqocPFvrZKqTJI1Gh6Ziqx9pi2pv+zLInSIS7dfff
	KVaM+Y/7aZcj4PUUeW5JjVQG6CYFECvUpq1VTx4zXf3gsI=
X-Google-Smtp-Source: AGHT+IHUg4zxb3TQemS6KFPePgjGVudv7igAfbX7lxSSK93lmNFW4WuN2NI6tZvVBmAsUhYbSIEgQx8UtlS3+gjd5ZE=
X-Received: by 2002:a17:902:d4d2:b0:267:9a29:7800 with SMTP id
 d9443c01a7336-28e9a6609b7mr165304745ad.59.1759790015140; Mon, 06 Oct 2025
 15:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930153942.41781-1-leon.hwang@linux.dev> <20250930153942.41781-6-leon.hwang@linux.dev>
In-Reply-To: <20250930153942.41781-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 15:33:21 -0700
X-Gm-Features: AS18NWB1Zh9T_SX5337BrcAaJ44YENEu7yyszXFqyyzJR5wlw8J7Y-zNBUtw37w
Message-ID: <CAEf4BzaVmJ83q5DxKkeJEhNeQ87HDQ7yZjg_PNFWpNEUvAFOnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_cgroup_storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:40=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps to
> allow updating values for all CPUs with a single value for update_elem
> API.
>
> Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to
> allow:
>
> * update value for specified CPU for update_elem API.
> * lookup value for specified CPU for lookup_elem API.
>
> The BPF_F_CPU flag is passed via map_flags along with embedded cpu info.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf-cgroup.h |  4 ++--
>  include/linux/bpf.h        |  1 +
>  kernel/bpf/local_storage.c | 27 ++++++++++++++++++++-------
>  kernel/bpf/syscall.c       |  2 +-
>  4 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index aedf573bdb426..013f4db9903fd 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -172,7 +172,7 @@ void bpf_cgroup_storage_link(struct bpf_cgroup_storag=
e *storage,
>  void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
>  int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *=
map);
>
> -int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void =
*value);
> +int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void =
*value, u64 flags);
>  int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
>                                      void *value, u64 flags);
>
> @@ -467,7 +467,7 @@ static inline struct bpf_cgroup_storage *bpf_cgroup_s=
torage_alloc(
>  static inline void bpf_cgroup_storage_free(
>         struct bpf_cgroup_storage *storage) {}
>  static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, vo=
id *key,
> -                                                void *value) {
> +                                                void *value, u64 flags) =
{
>         return 0;
>  }
>  static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b3d9a584f34e2..6250804394b53 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3774,6 +3774,7 @@ static inline bool bpf_map_supports_cpu_flags(enum =
bpf_map_type map_type)
>         case BPF_MAP_TYPE_PERCPU_ARRAY:
>         case BPF_MAP_TYPE_PERCPU_HASH:
>         case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> +       case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
>                 return true;
>         default:
>                 return false;
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index c93a756e035c0..f5188e0afa478 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -180,7 +180,7 @@ static long cgroup_storage_update_elem(struct bpf_map=
 *map, void *key,
>  }
>
>  int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
> -                                  void *value)
> +                                  void *value, u64 map_flags)
>  {
>         struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
>         struct bpf_cgroup_storage *storage;
> @@ -198,12 +198,18 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *=
_map, void *key,
>          * access 'value_size' of them, so copying rounded areas
>          * will not leak any kernel data
>          */
> +       if (map_flags & BPF_F_CPU) {
> +               cpu =3D map_flags >> 32;
> +               memcpy(value, per_cpu_ptr(storage->percpu_buf, cpu), _map=
->value_size);

this is so far ok, because we don't seem to allow special fields for
PERCPU_CGROUP_STORAGE, but it's best to switch this one to
copy_map_value()

> +               goto unlock;
> +       }
>         size =3D round_up(_map->value_size, 8);
>         for_each_possible_cpu(cpu) {
>                 bpf_long_memcpy(value + off,
>                                 per_cpu_ptr(storage->percpu_buf, cpu), si=
ze);

and let's switch this to copy_map_value_long() to future-proof this:
copy_map_value[_long]() should work correctly with any type of map and
will take care of all existing and future special fields

(but maybe have it as a separate patch with just that change to make it obv=
ious)

>                 off +=3D size;
>         }
> +unlock:
>         rcu_read_unlock();
>         return 0;
>  }
> @@ -213,10 +219,11 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map=
 *_map, void *key,
>  {
>         struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
>         struct bpf_cgroup_storage *storage;
> -       int cpu, off =3D 0;
> +       void *ptr;
>         u32 size;
> +       int cpu;
>
> -       if (map_flags !=3D BPF_ANY && map_flags !=3D BPF_EXIST)
> +       if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_AL=
L_CPUS))
>                 return -EINVAL;
>
>         rcu_read_lock();
> @@ -232,12 +239,18 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map=
 *_map, void *key,
>          * returned or zeros which were zero-filled by percpu_alloc,
>          * so no kernel data leaks possible
>          */
> -       size =3D round_up(_map->value_size, 8);
> +       size =3D (map_flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) ? _map->value=
_size :
> +               round_up(_map->value_size, 8);
> +       if (map_flags & BPF_F_CPU) {
> +               cpu =3D map_flags >> 32;
> +               memcpy(per_cpu_ptr(storage->percpu_buf, cpu), value, size=
);
> +               goto unlock;
> +       }
>         for_each_possible_cpu(cpu) {
> -               bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
> -                               value + off, size);
> -               off +=3D size;
> +               ptr =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + si=
ze * cpu;
> +               memcpy(per_cpu_ptr(storage->percpu_buf, cpu), ptr, size);
>         }
> +unlock:
>         rcu_read_unlock();
>         return 0;
>  }
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ce525a474656a..b654115c99e01 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -320,7 +320,7 @@ static int bpf_map_copy_value(struct bpf_map *map, vo=
id *key, void *value,
>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
>                 err =3D bpf_percpu_array_copy(map, key, value, flags);
>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAG=
E) {
> -               err =3D bpf_percpu_cgroup_storage_copy(map, key, value);
> +               err =3D bpf_percpu_cgroup_storage_copy(map, key, value, f=
lags);
>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_STACK_TRACE) {
>                 err =3D bpf_stackmap_extract(map, key, value, false);
>         } else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
> --
> 2.51.0
>


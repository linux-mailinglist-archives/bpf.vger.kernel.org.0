Return-Path: <bpf+bounces-62003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C2CAF04B8
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAA14E0D14
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8A02EB5BA;
	Tue,  1 Jul 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORPEMThh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4B2EAD16
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401344; cv=none; b=k7v2qqajS4Ar1holACe/+yWKZssBmh4bMJCb5KSOruxRCOZXICILah4dWkSrVfRyxO+rAddriYHJfWIrmEIUmZ02fmVCwIXReRKyfb2QY59rmTeR9G8u8NM5rzSOdUbwESPIO3DAsMbnHUcVsKvSodnK0m9XiMp8dSDjC2rh+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401344; c=relaxed/simple;
	bh=SfDPybz5lXcVjGANiRk/sMr0pTmKkfgImcy4vDEDbtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XN1oV8ufutmppUlsBGR5LUZcsCTb6avle1cv0PMLk+1C7CCwxTg+N7DSD0zS2iiuMh+jzEybqXU9PLpj63ANhJhtu83/fx4+UfRjMQMnz6eN9q1GNf0/f9Z3RN2AOG8pOswkEcpYpYB74dG9j43XdYWEkNq7+nTO19FrOkZRZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORPEMThh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313910f392dso2831080a91.2
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751401342; x=1752006142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8PG9POnz+imvfqhIQtLsdvQESTRjBUx6SPUltd7uVg=;
        b=ORPEMThhcsnKFeOBdC0W9mFh2ZOK/YsDkvySP/Q3omgAkjjDOTR6eP2+NUYeQMq2Og
         NqJih3W1tp2JfM8j9yTynq1xwoYCCq+hEYnx9DELpTNUhgrzPI12jP6kpDj66icxwP42
         vN+RkhmOBhyhrGO3uglt4kxMyPj24eEq17VgW3rJQkkYbIUtpmAIq/B1j97059kViHHL
         GmrI7O7HxEmvig9o4zc4NcXs6v0KWQhRQbjL/TgUItkssuq57TRaftmAdR2L0u2Wa1wK
         rtiYsPmm0LHF9vCEmNNYngBqXB5+VpZ7weJmTbdeLn82iixAl4gj8cCSlP4foTyg65Te
         AKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751401342; x=1752006142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8PG9POnz+imvfqhIQtLsdvQESTRjBUx6SPUltd7uVg=;
        b=Sq9+x+uyqSHApkN/BFEcblsmQIPd60gdFRERuSNpBXdpX7tvrNZYru7tVDMaypNo6k
         gt+jj9tbXlSfNQ0vHeH45DApdFzpT0+cyEni7Bg97O99UoZydK9O/vkmwvo+OyjBen81
         bWfjFrIPkBZbEGYigoizeXBx10xwq2i7FXNf89wQVm3UduBUN8m85CH6CaqbAZHKros1
         GQ15KBR2XPT4clOCZuZvFqVokW2FcUmuz3Sgs95Hb4KScYHkJUUYLduwJtS1GhcbsQj8
         tH9ydLUdeluAGud4pHZ14ekz7B62Hg3elBaIWPzUqA9eZdWS3Ehpb8dSNSDsvUT9BzyI
         Lh8A==
X-Gm-Message-State: AOJu0YwrotR9hr8hpvZFPJ2aRBA7OlD+KKBueWf0qrYGwKIrL9/ZosUy
	DotAeu+5fHPJI6rSyR8Ujof+qspJhy6I600VhWCFFwSjdjA6Mf+U3azqHlXVb/VNEMtYacBiH33
	pQgVBorkTY2ceUjZjBTefSQxawyoNaPY=
X-Gm-Gg: ASbGncsi2dMjtkH79k0xhcwb82p617DuyjOId+vsMWih3htAfEyl1JxOByPVYzaTSMN
	gKFEjPUvGDdVw7pia/rM8DIpf+5OmTXGYxeXP3jGofvFoJuV+OeJUDKzeAp2xnKwusmoGs9jULg
	LQHxAyVC4/3Pu7ar9OlChP8EGT6ddOw6C4ZbJBJuoYv60wgNqQH+lbCGzhdKI=
X-Google-Smtp-Source: AGHT+IE3Rd/HzTiZd8uUVOFSh5QGwyCRHNj/sNvzxnTzViCGseDAPu/6Fo7FvJO6Pl+Ua+3CiX6MtAkFjJ/PWQWC39I=
X-Received: by 2002:a17:90b:4e8b:b0:313:14b5:2538 with SMTP id
 98e67ed59e1d1-31a90c1526amr464701a91.35.1751401341622; Tue, 01 Jul 2025
 13:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624165354.27184-1-leon.hwang@linux.dev> <20250624165354.27184-3-leon.hwang@linux.dev>
In-Reply-To: <20250624165354.27184-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Jul 2025 13:22:05 -0700
X-Gm-Features: Ac12FXxwlE1isiIF9OGJWiiMFR6-E17OVkdrJvzSdiALhBkO0S3uUlshrDzUcnw
Message-ID: <CAEf4BzagyjD3LAc3s=w=TbVrqxKWJ=t6Enu6s6BN8cAu3Vmzyw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf, libbpf: Support BPF_F_CPU for
 percpu_array map
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 9:55=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch adds libbpf support for the BPF_F_CPU flag in percpu_array map=
s,
> introducing the following APIs:
>
> 1. bpf_map_update_elem_opts(): update with struct bpf_map_update_elem_opt=
s
> 2. bpf_map_lookup_elem_opts(): lookup with struct bpf_map_lookup_elem_opt=
s
> 3. bpf_map__update_elem_opts(): high-level wrapper with input validation
> 4. bpf_map__lookup_elem_opts(): high-level wrapper with input validation
>
> Behavior:
>
> * If opts->cpu =3D=3D 0xFFFFFFFF, the update is applied to all CPUs.
> * Otherwise, it applies only to the specified CPU.
> * Lookup APIs retrieve values from the target CPU when BPF_F_CPU is used.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c           | 37 +++++++++++++++++++++++
>  tools/lib/bpf/bpf.h           | 35 +++++++++++++++++++++-
>  tools/lib/bpf/libbpf.c        | 56 +++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h        | 45 ++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map      |  4 +++
>  tools/lib/bpf/libbpf_common.h | 12 ++++++++
>  6 files changed, 188 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 6eb421ccf91b..80f7ea041187 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -402,6 +402,24 @@ int bpf_map_update_elem(int fd, const void *key, con=
st void *value,
>         return libbpf_err_errno(ret);
>  }
>
> +int bpf_map_update_elem_opts(int fd, const void *key, const void *value,
> +                            const struct bpf_map_update_elem_opts *opts)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, cpu);
> +       union bpf_attr attr;
> +       int ret;
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.map_fd =3D fd;
> +       attr.key =3D ptr_to_u64(key);
> +       attr.value =3D ptr_to_u64(value);
> +       attr.flags =3D OPTS_GET(opts, flags, 0);
> +       attr.cpu =3D OPTS_GET(opts, cpu, BPF_ALL_CPU);
> +
> +       ret =3D sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
> +       return libbpf_err_errno(ret);
> +}
> +
>  int bpf_map_lookup_elem(int fd, const void *key, void *value)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
> @@ -433,6 +451,24 @@ int bpf_map_lookup_elem_flags(int fd, const void *ke=
y, void *value, __u64 flags)
>         return libbpf_err_errno(ret);
>  }
>
> +int bpf_map_lookup_elem_opts(int fd, const void *key, void *value,
> +                            const struct bpf_map_lookup_elem_opts *opts)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, cpu);
> +       union bpf_attr attr;
> +       int ret;
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.map_fd =3D fd;
> +       attr.key =3D ptr_to_u64(key);
> +       attr.value =3D ptr_to_u64(value);
> +       attr.flags =3D OPTS_GET(opts, flags, 0);
> +       attr.cpu =3D OPTS_GET(opts, cpu, BPF_ALL_CPU);

can't do that, setting cpu field to 0xffffffff on old kernels will
cause -EINVAL, immediate backwards compat breakage

just default it to zero, this field should remain zero and not be used
unless flags have BPF_F_CPU

> +
> +       ret =3D sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
> +       return libbpf_err_errno(ret);
> +}
> +
>  int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
> @@ -542,6 +578,7 @@ static int bpf_map_batch_common(int cmd, int fd, void=
  *in_batch,
>         attr.batch.count =3D *count;
>         attr.batch.elem_flags  =3D OPTS_GET(opts, elem_flags, 0);
>         attr.batch.flags =3D OPTS_GET(opts, flags, 0);
> +       attr.batch.cpu =3D OPTS_GET(opts, cpu, BPF_ALL_CPU);

ditto

>
>         ret =3D sys_bpf(cmd, &attr, attr_sz);
>         *count =3D attr.batch.count;
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 1342564214c8..7c6a0a3693c9 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -163,12 +163,41 @@ LIBBPF_API int bpf_map_delete_elem_flags(int fd, co=
nst void *key, __u64 flags);
>  LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_=
key);
>  LIBBPF_API int bpf_map_freeze(int fd);
>
> +/**
> + * @brief **bpf_map_update_elem_opts** allows for updating percpu map wi=
th value
> + * on specified CPU or on all CPUs.

IMO, a bit too specific a description. xxx_ops APIs are extended
versions of original non-opts APIs allowing to pass extra (optional)
arguments. Keep it generic. cpu field is currently the only "extra",
but this might grow over time

> + *
> + * @param fd BPF map file descriptor
> + * @param key pointer to key
> + * @param value pointer to value
> + * @param opts options for configuring the way to update percpu map

again, too specific

> + * @return 0, on success; negative error code, otherwise (errno is also =
set to
> + * the error code)
> + */
> +LIBBPF_API int bpf_map_update_elem_opts(int fd, const void *key, const v=
oid *value,
> +                                       const struct bpf_map_update_elem_=
opts *opts);
> +
> +/**
> + * @brief **bpf_map_lookup_elem_opts** allows for looking up the value f=
rom
> + * percpu map on specified CPU.
> + *
> + * @param fd BPF map file descriptor
> + * @param key pointer to key
> + * @param value pointer to value
> + * @param opts options for configuring the way to lookup percpu map
> + * @return 0, on success; negative error code, otherwise (errno is also =
set to
> + * the error code)
> + */
> +LIBBPF_API int bpf_map_lookup_elem_opts(int fd, const void *key, void *v=
alue,
> +                                       const struct bpf_map_lookup_elem_=
opts *opts);
> +
>  struct bpf_map_batch_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         __u64 elem_flags;
>         __u64 flags;
> +       __u32 cpu;

add size_t: 0 to avoid having non-zeroed padding at the end (see other
opts structs)

>  };
> -#define bpf_map_batch_opts__last_field flags
> +#define bpf_map_batch_opts__last_field cpu
>
>
>  /**
> @@ -286,6 +315,10 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int f=
d, void *in_batch,
>   *    Update spin_lock-ed map elements. This must be
>   *    specified if the map value contains a spinlock.
>   *
> + * **BPF_F_CPU**
> + *    As for percpu map, update value on all CPUs if **opts->cpu** is
> + *    0xFFFFFFFF, or on specified CPU otherwise.
> + *
>   * @param fd BPF map file descriptor
>   * @param keys pointer to an array of *count* keys
>   * @param values pointer to an array of *count* values
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6445165a24f2..30400bdc20d9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10636,6 +10636,34 @@ int bpf_map__lookup_elem(const struct bpf_map *m=
ap,
>         return bpf_map_lookup_elem_flags(map->fd, key, value, flags);
>  }
>
> +int bpf_map__lookup_elem_opts(const struct bpf_map *map, const void *key=
,
> +                             size_t key_sz, void *value, size_t value_sz=
,
> +                             const struct bpf_map_lookup_elem_opts *opts=
)
> +{
> +       int nr_cpus =3D libbpf_num_possible_cpus();
> +       __u32 cpu =3D OPTS_GET(opts, cpu, nr_cpus);
> +       __u64 flags =3D OPTS_GET(opts, flags, 0);
> +       int err;
> +
> +       if (flags & BPF_F_CPU) {
> +               if (map->def.type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +                       return -EINVAL;
> +               if (cpu >=3D nr_cpus)
> +                       return -E2BIG;
> +               if (map->def.value_size !=3D value_sz) {
> +                       pr_warn("map '%s': unexpected value size %zu prov=
ided, expected %u\n",
> +                               map->name, value_sz, map->def.value_size)=
;
> +                       return -EINVAL;
> +               }

shouldn't this go into validate_map_op?..

> +       } else {
> +               err =3D validate_map_op(map, key_sz, value_sz, true);
> +               if (err)
> +                       return libbpf_err(err);
> +       }
> +
> +       return bpf_map_lookup_elem_opts(map->fd, key, value, opts);
> +}
> +
>  int bpf_map__update_elem(const struct bpf_map *map,
>                          const void *key, size_t key_sz,
>                          const void *value, size_t value_sz, __u64 flags)
> @@ -10649,6 +10677,34 @@ int bpf_map__update_elem(const struct bpf_map *m=
ap,
>         return bpf_map_update_elem(map->fd, key, value, flags);
>  }
>
> +int bpf_map__update_elem_opts(const struct bpf_map *map, const void *key=
,
> +                             size_t key_sz, const void *value, size_t va=
lue_sz,
> +                             const struct bpf_map_update_elem_opts *opts=
)
> +{
> +       int nr_cpus =3D libbpf_num_possible_cpus();
> +       __u32 cpu =3D OPTS_GET(opts, cpu, nr_cpus);
> +       __u64 flags =3D OPTS_GET(opts, flags, 0);
> +       int err;
> +
> +       if (flags & BPF_F_CPU) {
> +               if (map->def.type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +                       return -EINVAL;
> +               if (cpu !=3D BPF_ALL_CPU && cpu >=3D nr_cpus)
> +                       return -E2BIG;
> +               if (map->def.value_size !=3D value_sz) {
> +                       pr_warn("map '%s': unexpected value size %zu prov=
ided, expected %u\n",
> +                               map->name, value_sz, map->def.value_size)=
;
> +                       return -EINVAL;
> +               }

same, move into validate_map_op

> +       } else {
> +               err =3D validate_map_op(map, key_sz, value_sz, true);
> +               if (err)
> +                       return libbpf_err(err);
> +       }
> +
> +       return bpf_map_update_elem_opts(map->fd, key, value, opts);
> +}
> +
>  int bpf_map__delete_elem(const struct bpf_map *map,
>                          const void *key, size_t key_sz, __u64 flags)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d1cf813a057b..ba0d15028c72 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1185,6 +1185,28 @@ LIBBPF_API int bpf_map__lookup_elem(const struct b=
pf_map *map,
>                                     const void *key, size_t key_sz,
>                                     void *value, size_t value_sz, __u64 f=
lags);
>
> +/**
> + * @brief **bpf_map__lookup_elem_opts()** allows to lookup BPF map value
> + * corresponding to provided key with options to lookup percpu map.
> + * @param map BPF map to lookup element in
> + * @param key pointer to memory containing bytes of the key used for loo=
kup
> + * @param key_sz size in bytes of key data, needs to match BPF map defin=
ition's **key_size**
> + * @param value pointer to memory in which looked up value will be store=
d
> + * @param value_sz size in byte of value data memory; it has to match BP=
F map
> + * definition's **value_size**. For per-CPU BPF maps value size can be
> + * definition's **value_size** if **BPF_F_CPU** is specified in **opts->=
flags**,
> + * or the size described in **bpf_map__lookup_elem()**.

let's describe all this sizing in one place (either __lookup_elem or
__lookup_elem_opts) and then refer to that succinctly from another one
(without BPF_F_CPU exception spread out across two API descriptions)

> + * @opts extra options passed to kernel for this operation
> + * @return 0, on success; negative error, otherwise
> + *
> + * **bpf_map__lookup_elem_opts()** is high-level equivalent of
> + * **bpf_map_lookup_elem_opts()** API with added check for key and value=
 size.
> + */
> +LIBBPF_API int bpf_map__lookup_elem_opts(const struct bpf_map *map,
> +                                        const void *key, size_t key_sz,
> +                                        void *value, size_t value_sz,
> +                                        const struct bpf_map_lookup_elem=
_opts *opts);
> +
>  /**
>   * @brief **bpf_map__update_elem()** allows to insert or update value in=
 BPF
>   * map that corresponds to provided key.
> @@ -1209,6 +1231,29 @@ LIBBPF_API int bpf_map__update_elem(const struct b=
pf_map *map,
>                                     const void *key, size_t key_sz,
>                                     const void *value, size_t value_sz, _=
_u64 flags);
>
> +/**
> + * @brief **bpf_map__update_elem_opts()** allows to insert or update val=
ue in BPF
> + * map that corresponds to provided key with options for percpu maps.
> + * @param map BPF map to insert to or update element in
> + * @param key pointer to memory containing bytes of the key
> + * @param key_sz size in bytes of key data, needs to match BPF map defin=
ition's **key_size**
> + * @param value pointer to memory containing bytes of the value
> + * @param value_sz size in byte of value data memory; it has to match BP=
F map
> + * definition's **value_size**. For per-CPU BPF maps value size can be
> + * definition's **value_size** if **BPF_F_CPU** is specified in **opts->=
flags**,
> + * or the size described in **bpf_map__update_elem()**.
> + * @opts extra options passed to kernel for this operation
> + * @flags extra flags passed to kernel for this operation
> + * @return 0, on success; negative error, otherwise
> + *
> + * **bpf_map__update_elem_opts()** is high-level equivalent of
> + * **bpf_map_update_elem_opts()** API with added check for key and value=
 size.
> + */
> +LIBBPF_API int bpf_map__update_elem_opts(const struct bpf_map *map,
> +                                        const void *key, size_t key_sz,
> +                                        const void *value, size_t value_=
sz,
> +                                        const struct bpf_map_update_elem=
_opts *opts);
> +
>  /**
>   * @brief **bpf_map__delete_elem()** allows to delete element in BPF map=
 that
>   * corresponds to provided key.
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index c7fc0bde5648..c39814adeae9 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -436,6 +436,10 @@ LIBBPF_1.6.0 {
>                 bpf_linker__add_buf;
>                 bpf_linker__add_fd;
>                 bpf_linker__new_fd;
> +               bpf_map__lookup_elem_opts;
> +               bpf_map__update_elem_opts;
> +               bpf_map_lookup_elem_opts;
> +               bpf_map_update_elem_opts;
>                 bpf_object__prepare;
>                 bpf_program__attach_cgroup_opts;
>                 bpf_program__func_info;
> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.=
h
> index 8fe248e14eb6..ef29caf91f9c 100644
> --- a/tools/lib/bpf/libbpf_common.h
> +++ b/tools/lib/bpf/libbpf_common.h
> @@ -89,4 +89,16 @@
>                 memcpy(&NAME, &___##NAME, sizeof(NAME));                 =
   \
>         } while (0)
>
> +struct bpf_map_update_elem_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> +       __u64 flags;
> +       __u32 cpu;

size_t: 0

> +};
> +
> +struct bpf_map_lookup_elem_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> +       __u64 flags;
> +       __u32 cpu;

size_t: 0


> +};
> +
>  #endif /* __LIBBPF_LIBBPF_COMMON_H */
> --
> 2.49.0
>


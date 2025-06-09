Return-Path: <bpf+bounces-60090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D0AD283B
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 22:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAD716DFE5
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEFE221F18;
	Mon,  9 Jun 2025 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8d6wFdL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C718F40;
	Mon,  9 Jun 2025 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502720; cv=none; b=TzVw/atNQM73Zm4ne9fguyl50Vl4Fu7OOUCDqlMTLJkDajvtg0dU8z84wQ5xTnWeWvKN6lI+t5xkHfNXlgg6yLuwpWqUfMWxD6P3sG8rZZKpOB/7T2a2aeBFoQGv8uEN1nSsr5xAso0maqTtubXd9bgu2M3pRAyuoOZ2eAwSHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502720; c=relaxed/simple;
	bh=a0g30dtCdd9GafX/Of0kUAy/pnjdIpXRUlCwH+40Gzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3J6mJSzChkWFMbmX7uo39h96c8YsDIz9VXMkeE2hXMEiEHhBZngQdiU3SWXTCvdMb5ehNt0F7Bx18QbzR24/MuUQg1pEdPm/xBw5Fop/zHHAwb2VAspM/E8QP5bF1cJU+yx7Ujsr4LnzFn9FZ3AXcbzuEbwqpkrOTazDyPkGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8d6wFdL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so54848895e9.2;
        Mon, 09 Jun 2025 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749502716; x=1750107516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIeS4g08HhZvlrSRMzzIUOMlFWtZ1oH7A962B1Bd1OY=;
        b=U8d6wFdLNvI3fyD6JEvrB/qA0IxoxbKmTHfpeQjWKiYAnwmMNQen+B3WusWe5z4ndX
         0L1sCaPzwva4dGNmzSWxytfwprKfIG7NjAGkEZGuBeoo2Mk0B6QWQr46/njODbiJO0ro
         W4IxPR/i5PP+eX6a3kxbIwG4U9hMr0IcEcAD77qRSABZ71rGWdF6xTDKkbtYwqm6JlAh
         G5bCHUw2QN7eaT92trEadGnKTqxhqtwCoHZQG2EfP3HRH/du8mjwe2Nqi8FM3YzRD4nT
         EYxrI4jmf/Tf8Mj19AN/g799U4veEjZG+ghWNCYpmNzbhQO+9vxy9J111ZlERazqzRt/
         PFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749502716; x=1750107516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIeS4g08HhZvlrSRMzzIUOMlFWtZ1oH7A962B1Bd1OY=;
        b=EUUOkgCpmXdiB5sZR+Km2S/SmpXPmNkm/Pk9d7InEdHI84ybZc+MtEOhx6/VwgjYs3
         kGFXZ5qcE0PJKlFUv2EyxjfdhcxMrSSH8k/a3V/xqDhmwrkvKIkvyiYo2xBvA5HNzChG
         jBryPuKrY7DA7OC/iSZwPo9J5f9D5gAhl8KPSFpaxNrlSB2xprhUAfl6WoT4AV9PYw3x
         /bpoy7irHoVOGIYK/cXaUYz0oDn3r0nO3vo1/hCrGfGwSowVA7xNtCjgcnQkP48RINBK
         5iKfO7LHWzPEODXDw920x+9R4q36eJP+8tVwqzPltKlXlIl7jMYa40eXEMIknZwNv2PR
         E+QA==
X-Forwarded-Encrypted: i=1; AJvYcCV2SsEEJDUI12WyQEzAJhaTQ3FQTvjSSs9MvcUFJ40RWMh+v4wL/IuwDQw0jDB9w0Yf38UhUMsiB96+uTWO2nMrYh2XagQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvyNZnxPUoVDtXyqLzx4mWuBeXxWwsKUqdheZtzrD7Dqj6lyu
	vvNjhaeVJ8fOSEj/kOIcu7tQ/bsXb2/sfChAkl8pudQx4gHWBIeWXBVRyqTiky8eU55ttYnJHRA
	E+V7KUf2lEhmStHH4QGLKwX9bPuHYwUDsCupJ
X-Gm-Gg: ASbGncs29azLBYHi7tzlHssGxZml3hVf3nfTtKfNpBeSxys7rhjuNVCf1jUqGDUmGJU
	QSPOtL60P7M17PvBDkujmDWi0dtHgVaKBOvF6kM/F7EuECW5hXuSM1O788GKH6hUEAaefQo0zQk
	EqDscz4S+eJaRi2W30zT3PcbFtMiiRh+BACd3F4ac3dKv/N2irpPYBE+aTRefxeLyjY1JS0EQR
X-Google-Smtp-Source: AGHT+IFR/A0rD2yVBG4/CVGM2LUwLRRxV/D0JL+V76Zcanv8gw4CaTI76f7Zoovxk6BpxDEgBGKSI/6lm8ALfEBiiZo=
X-Received: by 2002:a05:6000:2088:b0:3a4:d64a:3df6 with SMTP id
 ffacd0b85a97d-3a5319b1ab1mr10382047f8f.3.1749502716249; Mon, 09 Jun 2025
 13:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-4-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-4-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Jun 2025 13:58:25 -0700
X-Gm-Features: AX0GCFt2lus7yZ49c_BTiKSdNEHrFJj-VJHxQx0puZz5RbgWY69x58X5JoDVOL4
Message-ID: <CAADnVQLMff33qY+xY3Ztybbo38Wr9-bp_GPcoFna4EbtgTrWrg@mail.gmail.com>
Subject: Re: [PATCH 03/12] bpf: Implement exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> Exclusive maps allow maps to only be accessed by a trusted loader
> program with a matching hash. This allows the trusted loader program
> to load the map and verify the integrity.
>
> Both maps of maps (array, hash) cannot be exclusive and exclusive maps
> cannot be added as inner maps. This is because one would need to
> guarantee the exclusivity of the inner maps and would require
> significant changes in the verifier.

I was back and forth on it early, but after sleeping on it
I think we should think of exclusive maps as a generic concept and
not tied to trusted loader and prog signatures.
So any map type should be allowed to be exclusive and this patch
can handle it fine without adding more complexity.
In map-in-map case the outer map can be created exclusive
to a particular program, but inner maps don't have to be exclusive,
and it's fine. The lskel loader won't be using map-in-map anyway,
so no issues there.

> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  3 ++-
>  kernel/bpf/arraymap.c          |  4 ++++
>  kernel/bpf/hashtab.c           | 15 +++++++++------
>  kernel/bpf/syscall.c           | 35 ++++++++++++++++++++++++++++++----
>  kernel/bpf/verifier.c          |  7 +++++++
>  tools/include/uapi/linux/bpf.h |  3 ++-
>  7 files changed, 56 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 77d62c74a4e7..cb1bea99702a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -311,6 +311,7 @@ struct bpf_map {
>         bool free_after_rcu_gp;
>         atomic64_t sleepable_refcnt;
>         s64 __percpu *elem_count;
> +       char *excl_prog_sha;
>  };
>
>  static inline const char *btf_field_type_name(enum btf_field_type type)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 16e95398c91c..6f2f4f3b3822 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1504,6 +1504,8 @@ union bpf_attr {
>                  * If provided, map_flags should have BPF_F_TOKEN_FD flag=
 set.
>                  */
>                 __s32   map_token_fd;
> +               __u32 excl_prog_hash_size;
> +               __aligned_u64 excl_prog_hash;
>         };
>
>         struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_F=
REEZE commands */
> @@ -1841,7 +1843,6 @@ union bpf_attr {
>                 __u32           flags;
>                 __u32           bpffs_fd;
>         } token_create;
> -
>  } __attribute__((aligned(8)));
>
>  /* The description below is an attempt at providing documentation to eBP=
F
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index eb28c0f219ee..8719aa821b63 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -896,6 +896,10 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map=
, struct file *map_file,
>         if (IS_ERR(new_ptr))
>                 return PTR_ERR(new_ptr);
>
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MAPS &&
> +               ((struct bpf_map *)new_ptr)->excl_prog_sha)
> +               return -EOPNOTSUPP;
> +

bpf_fd_array_map_update_elem() is called for prog_array too,
so new_ptr can be a pointer to a bpf_prog.
If we support all map types this check can be dropped.

>         if (map->ops->map_poke_run) {
>                 mutex_lock(&array->aux->poke_mutex);
>                 old_ptr =3D xchg(array->ptrs + index, new_ptr);
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 71f9931ac64c..2732b4a23c27 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2537,22 +2537,25 @@ int bpf_fd_htab_map_lookup_elem(struct bpf_map *m=
ap, void *key, u32 *value)
>  int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_fi=
le,
>                                 void *key, void *value, u64 map_flags)
>  {
> -       void *ptr;
> +       struct bpf_map *inner_map;
>         int ret;
>
> -       ptr =3D map->ops->map_fd_get_ptr(map, map_file, *(int *)value);
> -       if (IS_ERR(ptr))
> -               return PTR_ERR(ptr);
> +       inner_map =3D map->ops->map_fd_get_ptr(map, map_file, *(int *)val=
ue);
> +       if (IS_ERR(inner_map))
> +               return PTR_ERR(inner_map);
> +
> +       if (inner_map->excl_prog_sha)
> +               return -EOPNOTSUPP;

I would simply drop these checks too.

>         /* The htab bucket lock is always held during update operations i=
n fd
>          * htab map, and the following rcu_read_lock() is only used to av=
oid
>          * the WARN_ON_ONCE in htab_map_update_elem_in_place().
>          */
>         rcu_read_lock();
> -       ret =3D htab_map_update_elem_in_place(map, key, &ptr, map_flags, =
false, false);
> +       ret =3D htab_map_update_elem_in_place(map, key, &inner_map, map_f=
lags, false, false);
>         rcu_read_unlock();
>         if (ret)
> -               map->ops->map_fd_put_ptr(map, ptr, false);
> +               map->ops->map_fd_put_ptr(map, inner_map, false);
>
>         return ret;
>  }
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4b5f29168618..bef9edcfdb76 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -858,6 +858,7 @@ static void bpf_map_free(struct bpf_map *map)
>          * the free of values or special fields allocated from bpf memory
>          * allocator.
>          */
> +       kfree(map->excl_prog_sha);
>         migrate_disable();
>         map->ops->map_free(map);
>         migrate_enable();
> @@ -1335,9 +1336,9 @@ static bool bpf_net_capable(void)
>         return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
>  }
>
> -#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
> +#define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash
>  /* called via syscall */
> -static int map_create(union bpf_attr *attr, bool kernel)
> +static int map_create(union bpf_attr *attr, bpfptr_t uattr)
>  {
>         const struct bpf_map_ops *ops;
>         struct bpf_token *token =3D NULL;
> @@ -1527,7 +1528,33 @@ static int map_create(union bpf_attr *attr, bool k=
ernel)
>                         attr->btf_vmlinux_value_type_id;
>         }
>
> -       err =3D security_bpf_map_create(map, attr, token, kernel);
> +       if (attr->excl_prog_hash) {
> +               bpfptr_t uprog_hash =3D make_bpfptr(attr->excl_prog_hash,=
 uattr.is_kernel);
> +
> +               if (map->inner_map_meta) {
> +                       err =3D -EOPNOTSUPP;
> +                       goto free_map;
> +               }

drop this one too.

> +
> +               map->excl_prog_sha =3D kzalloc(SHA256_DIGEST_SIZE, GFP_KE=
RNEL);
> +               if (!map->excl_prog_sha) {
> +                       err =3D -EINVAL;

ENOMEM

> +                       goto free_map;
> +               }
> +
> +               if (attr->excl_prog_hash_size < SHA256_DIGEST_SIZE) {

The idea here is to allow extensibility with different sizes?
Then use =3D=3D here.

> +                       err =3D -EINVAL;
> +                       goto free_map;
> +               }
> +
> +               if (copy_from_bpfptr(map->excl_prog_sha, uprog_hash,
> +                                    SHA256_DIGEST_SIZE)) {
> +                       err =3D -EFAULT;
> +                       goto free_map;
> +               }
> +       }

in the 'else' part let's also check that excl_prog_hash_size !=3D 0
while excl_prog_hash =3D=3D 0 is an invalid combination.

> +
> +       err =3D security_bpf_map_create(map, attr, token, uattr.is_kernel=
);
>         if (err)
>                 goto free_map_sec;
>
> @@ -5815,7 +5842,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uat=
tr, unsigned int size)
>
>         switch (cmd) {
>         case BPF_MAP_CREATE:
> -               err =3D map_create(&attr, uattr.is_kernel);
> +               err =3D map_create(&attr, uattr);
>                 break;
>         case BPF_MAP_LOOKUP_ELEM:
>                 err =3D map_lookup_elem(&attr);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d5807d2efc92..15fdd63bdcf9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19943,6 +19943,12 @@ static int check_map_prog_compatibility(struct b=
pf_verifier_env *env,
>  {
>         enum bpf_prog_type prog_type =3D resolve_prog_type(prog);
>
> +       if (map->excl_prog_sha &&
> +           memcmp(map->excl_prog_sha, prog->digest, SHA256_DIGEST_SIZE))=
 {
> +               verbose(env, "exclusive map access denied\n");

May be make it a bit more precise:
"program's digest doesn't match map's digest" ?

> +               return -EACCES;
> +       }
> +
>         if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
>             btf_record_has_field(map->record, BPF_RB_ROOT)) {
>                 if (is_tracing_prog_type(prog_type)) {
> @@ -20051,6 +20057,7 @@ static int __add_used_map(struct bpf_verifier_env=
 *env, struct bpf_map *map)
>  {
>         int i, err;
>
> +       /* check if the map is used already*/

left over comment?

>         /* check whether we recorded this map already */
>         for (i =3D 0; i < env->used_map_cnt; i++)
>                 if (env->used_maps[i] =3D=3D map)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 16e95398c91c..6f2f4f3b3822 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1504,6 +1504,8 @@ union bpf_attr {
>                  * If provided, map_flags should have BPF_F_TOKEN_FD flag=
 set.
>                  */
>                 __s32   map_token_fd;
> +               __u32 excl_prog_hash_size;
> +               __aligned_u64 excl_prog_hash;
>         };
>
>         struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_F=
REEZE commands */
> @@ -1841,7 +1843,6 @@ union bpf_attr {
>                 __u32           flags;
>                 __u32           bpffs_fd;
>         } token_create;
> -
>  } __attribute__((aligned(8)));
>
>  /* The description below is an attempt at providing documentation to eBP=
F
> --
> 2.43.0
>


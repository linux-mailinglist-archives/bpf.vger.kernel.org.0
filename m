Return-Path: <bpf+bounces-67322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E79B4280B
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFBB3BE175
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4922D3ECA;
	Wed,  3 Sep 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYIewe6n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463134C92
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920989; cv=none; b=o6kwOCR14cQ0efgsfMup5/cTooNTQ7lrhcIEgBoVoKglq3L6C1q/nMAnZcwSPRV9R2I6B1XagrWWMZwL84IA8KXud4KkRi5rl/lrapW7dOM4rPJJ1C6VdjR/plosdNbSfroUYQQ+uj3yyy533FPL/WyThBtRcx423DQAQifxz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920989; c=relaxed/simple;
	bh=FyxikpDB6NmZDsL8wg2wQn/Qq8OClMkqnc8J3QNLlk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJMvUUGCyWBLkJwh8ZxaJvz+ChLCaix7d3DbFduL+g0aw8npYdNdHM4b+vHts1LdYYTon85ixi9NkYhVHJ2Riubx4YvKQHfQfHqJ41gZD4iqPxilkkUkwGqqVItnBM8JLMHD3Egr59H15ps54ik5K2i2GGJZEG68L6+D2FKmWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYIewe6n; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0449b1b56eso24736366b.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756920985; x=1757525785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbzKAWNRLjJj67tbN2L6zhA3z70SJoeoCtZ9zHlkKa4=;
        b=mYIewe6nITJ2+N9ddNd1eGs0NWVBrQ8oHrcpwymrIJLPWFm7KnmnC8YmPXcdjfKNZs
         of6OztWy0J0da6W/rmU/isQiMZR9rjAaKt978XreHyPubz8EC/BGxzfaEH5HjjZyWZVq
         CdfmQJoMwgUZKhLC7RlexT6Ks0x209TPl5wGJAESXJ14wvmiaiFqau9MS6NtLednZmxn
         TOR9aKLd6sRqGKGp2A+kwyRrlEBUpJbOmK4VqQCwlpNozbihEvU/OChzRHr/GvuDnY8p
         WqGpsy9ewxVfqEdE/4p1tSKXOZQf3eyY8dEQEiKGRBUns4b7rpEi/qNxXjSZY7Fjlh7j
         dyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756920985; x=1757525785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbzKAWNRLjJj67tbN2L6zhA3z70SJoeoCtZ9zHlkKa4=;
        b=iJbDWe1PsLr6mVtE0NaX8KUa27R76s4sFDjMdCfhll5GgSkXzUj6/+oWowGgjKqCHp
         4ZHIqTiBACeq6YAOMFdSMvexRPPm8CVFC/WyEWVA26cklUY2NYwUiKjNgeAH+jSm+tRE
         eAj15GIzh+YJ0sIMlmC+k8xeIxQP4GwI+zeN5VN/ud6h47PCJ2i6kO0cIACxKUNVNxIZ
         8tsv+AHvHOEtqAl9tQgXphrtwXThXzOwpcX6RC0uagu+hrNNNbFK1sMpFWK7QsKGWzWL
         tq3Cpq7HdyyexxEImjqH8xm3M+AfLKynGy9N9kDg+yH2wi3mfhTZQcLQ9g5bIPrsZPAY
         SxQQ==
X-Gm-Message-State: AOJu0YzFLm6/UTF8oxOTZMRwv4b3We3QghPFeczA1zdU6jci+CFMqzh5
	9ww6Qx/ZgdVkBDTwWr8Rn4buSCQIAIAcXiqknjd++FJJmRKTy05TMAG65IWecPhMxARfDgRBPcX
	3YVi9PifzsMgTa8QKNtarXI5OyWUTPWf5sw==
X-Gm-Gg: ASbGncvLTO5XfoUAtiCaW6Yxkv8ZjGW3cyXT9NAFgwCJJ2zaV4kvrsEG2djoX8MxeWa
	N0GLH4vg2oDxGf1OowKVEcPKL/hYF/YGEQAxRGGgW9vthhDmtR9onIgOoxLx63KW/iSYG/frI0r
	W4bjI3c7VmvvIBswFMorkZHJCqzal88uVaWhbWtKHQ5rcfPd7c6k49e+x0hq6hnDzdMsQZJskQb
	i6uDDmt5VhQf85ZQ9OK1vF+ObZj7AiwRA==
X-Google-Smtp-Source: AGHT+IHd0QxPpDD2dIztzqresRHkk4xF9zG3fWEn3K23T9fQT4irGmlmvnrYMYX98TDkWoxIxzGUMStNcAVvEKkWBcI=
X-Received: by 2002:a17:907:e98b:b0:afe:e7f1:289d with SMTP id
 a640c23a62f3a-b01df90c1ccmr1739053566b.62.1756920985212; Wed, 03 Sep 2025
 10:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903170411.69188-1-leon.hwang@linux.dev>
In-Reply-To: <20250903170411.69188-1-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Sep 2025 10:36:11 -0700
X-Gm-Features: Ac12FXzvPg9whaDr7t7OpHlV2VVRbo_Por5l2PvAoG-1Y19BdX1Bc36znVaaBYw
Message-ID: <CAADnVQL-Zj95bfOxkxc2tf9CKvUSCt4PKdoQMZtqaiirzPLxvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Generalize data copying for percpu maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:04=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> While adding support for the BPF_F_CPU and BPF_F_ALL_CPUS flags, the data
> copying logic of the following percpu map types needs to be updated:
>
> * percpu_array
> * percpu_hash
> * lru_percpu_hash
> * percpu_cgroup_storage
>
> Following Andrii=E2=80=99s suggestion[0], this patch refactors the data c=
opying
> logic by introducing two helpers:
>
> * `bpf_percpu_copy_to_user()`
> * `bpf_percpu_copy_from_user()`
>
> This prepares the codebase for the upcoming CPU flag support.
>
> [0] https://lore.kernel.org/bpf/20250827164509.7401-1-leon.hwang@linux.de=
v/
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h        | 29 ++++++++++++++++++++++++++++-
>  kernel/bpf/arraymap.c      | 14 ++------------
>  kernel/bpf/hashtab.c       | 20 +++-----------------
>  kernel/bpf/local_storage.c | 18 ++++++------------
>  4 files changed, 39 insertions(+), 42 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8f6e87f0f3a89..2dc0299a2da50 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -547,6 +547,34 @@ static inline void copy_map_value_long(struct bpf_ma=
p *map, void *dst, void *src
>         bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
>  }
>
> +#ifdef CONFIG_BPF_SYSCALL
> +static inline void bpf_percpu_copy_to_user(struct bpf_map *map, void __p=
ercpu *pptr, void *value,
> +                                          u32 size)
> +{
> +       int cpu, off =3D 0;
> +
> +       for_each_possible_cpu(cpu) {
> +               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, c=
pu));
> +               check_and_init_map_value(map, value + off);
> +               off +=3D size;
> +       }
> +}
> +
> +void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
> +
> +static inline void bpf_percpu_copy_from_user(struct bpf_map *map, void _=
_percpu *pptr, void *value,
> +                                            u32 size)
> +{
> +       int cpu, off =3D 0;
> +
> +       for_each_possible_cpu(cpu) {
> +               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + =
off);
> +               bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cpu));
> +               off +=3D size;
> +       }
> +}
> +#endif
> +
>  static inline void bpf_obj_swap_uptrs(const struct btf_record *rec, void=
 *dst, void *src)
>  {
>         unsigned long *src_uptr, *dst_uptr;
> @@ -2417,7 +2445,6 @@ struct btf_record *btf_record_dup(const struct btf_=
record *rec);
>  bool btf_record_equal(const struct btf_record *rec_a, const struct btf_r=
ecord *rec_b);
>  void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
>  void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
> -void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
>  void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool per=
cpu);
>
>  struct bpf_map *bpf_map_get(u32 ufd);
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 3d080916faf97..6be9c54604503 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -300,7 +300,6 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *=
key, void *value)
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         u32 index =3D *(u32 *)key;
>         void __percpu *pptr;
> -       int cpu, off =3D 0;
>         u32 size;
>
>         if (unlikely(index >=3D array->map.max_entries))
> @@ -313,11 +312,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, void =
*key, void *value)
>         size =3D array->elem_size;
>         rcu_read_lock();
>         pptr =3D array->pptrs[index & array->index_mask];
> -       for_each_possible_cpu(cpu) {
> -               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, c=
pu));
> -               check_and_init_map_value(map, value + off);
> -               off +=3D size;
> -       }
> +       bpf_percpu_copy_to_user(map, pptr, value, size);
>         rcu_read_unlock();
>         return 0;
>  }
> @@ -387,7 +382,6 @@ int bpf_percpu_array_update(struct bpf_map *map, void=
 *key, void *value,
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         u32 index =3D *(u32 *)key;
>         void __percpu *pptr;
> -       int cpu, off =3D 0;
>         u32 size;
>
>         if (unlikely(map_flags > BPF_EXIST))
> @@ -411,11 +405,7 @@ int bpf_percpu_array_update(struct bpf_map *map, voi=
d *key, void *value,
>         size =3D array->elem_size;
>         rcu_read_lock();
>         pptr =3D array->pptrs[index & array->index_mask];
> -       for_each_possible_cpu(cpu) {
> -               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + =
off);
> -               bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, =
cpu));
> -               off +=3D size;
> -       }
> +       bpf_percpu_copy_from_user(map, pptr, value, size);
>         rcu_read_unlock();
>         return 0;
>  }
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 71f9931ac64cd..5f0f3c00dbb74 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -944,12 +944,8 @@ static void pcpu_copy_value(struct bpf_htab *htab, v=
oid __percpu *pptr,
>                 copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
>         } else {
>                 u32 size =3D round_up(htab->map.value_size, 8);
> -               int off =3D 0, cpu;
>
> -               for_each_possible_cpu(cpu) {
> -                       copy_map_value_long(&htab->map, per_cpu_ptr(pptr,=
 cpu), value + off);
> -                       off +=3D size;
> -               }
> +               bpf_percpu_copy_from_user(&htab->map, pptr, value, size);

This is not a refactor. There is a significant change in the logic.
Why is it needed? Bug fix or introducing a bug?

The names to_user and from_user are wrong.
There is no user space memory involved.

pw-bot: cr


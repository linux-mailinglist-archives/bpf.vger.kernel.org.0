Return-Path: <bpf+bounces-69916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A9BA6675
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 04:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FA0189AB7E
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 02:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7AB248F6A;
	Sun, 28 Sep 2025 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDrnKCVx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8C02EAE3
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759027343; cv=none; b=HXuL2mtINmx/DRtRaTdCj5V3uEWIpGNVTPIjYPqmIokGuMqDGLu8Pg/ERKYTR4MZ+Drccwx/LX83fuxjoXdJDLVZh8gOh3fvrHHuUpLibBrNRmBN9Mpnqogp0JRd6CE1np8qJXG/q/cOBzndfZHyI/OjREhnCH9X+mO9Iy3fJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759027343; c=relaxed/simple;
	bh=2/hTZSBR94co4mxqReNyzHWxAVPXUjLxtdHgt39hpkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/oBunVH5F+8jye4o7PUS2KJMc2+K4VJBhoi/BjodIwMnGeIrfbrpi2UkrI3GXxhLI2Tly3Cw3il2lU+xHWMa2aYFLpHGg7htX/ju4kKRupuBMjk71VTdrzAxZqB88fHeF8v4xdZ9hnStt6UXt89zQOtVxHNgTYUeJfZTzMY2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDrnKCVx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27c369f8986so34221545ad.3
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 19:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759027341; x=1759632141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xot7+8m5woTFdoMYBkbaWhdMziRG3yXFo5iRhjW3U6s=;
        b=fDrnKCVxS5zxJOqi6EXBKaBNb2giRApT+chXwMw47nLbBYQQAR/QgKCp+kzDE6mUzF
         b/NdA/MJPrhfH/5ldrMYiiAqwH+ewkviESzXNe9OchikXqco2tVoa9fJDdYwSb77Qs6T
         BkCfHX9bl1pjtq3yTubu0X6Pw2iAJ3g7+Rkwby9Ir3kaWW7dHGMGSy+IeiVWoz/rarrG
         +R+NpRUIfcRErHAOidmjzwez6WQwaZPuNJ3vMLd4g7mghL2F7bJkk4pv6h8gIhFTBEp4
         PgvK3fJRWq20zUVJVvPJmPozu1e+sIOmEIRE5cbWpWRQscPXa7KFHO82G6QtwXUEll5E
         SCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759027341; x=1759632141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xot7+8m5woTFdoMYBkbaWhdMziRG3yXFo5iRhjW3U6s=;
        b=PeiH7y2GCNHGhqOIs+alqIFK5KvqlqiBHnS70PEPTa4LLox80WPCWR4Wd8FQqbWNLx
         UexF93eXVLDAXQKhdr4aYybNCCHxj8p7eBLWX/yv8yNYsWtMt4FOhDNMFqdtEvzse8Hv
         yezSiSXCqIi9TiN9LgNXm3SmsazzkimuPAvyzLRI1HhzsLTLT66mulC6h5RQEQUWer/T
         21NFb5cxgrglhhD0mJOFogwvE/tIjvovKhY5ZsXajPvvYvhq5CZYqv15OR/PizzFd1eP
         A4f5VtOqbZWSDBPs3C0A1wf2AJYf2/ik7NN6JjVG03ay48dhIKHV2+xdc/6WNnckEhSQ
         txPg==
X-Gm-Message-State: AOJu0YzLTo6vMDRUUQzaZeUlv8nwGZO4OI/E16xRJuoMX/UKFWXt/2C5
	wZzb/D6poU9zZpRX+8l053+U0KSeQlzaj+NSV1SWHHGn+cD3oR+dmPhcC9btsKRChiqSi/HqIxP
	ToFs7EeGh5U19hNKGW9L4INujKM3t/xY=
X-Gm-Gg: ASbGncvjD6n5OBDaByWKFCO4vXTAUBiVNB6REsUFED6MOhstUcSj+lYc5kPeUM2MTI8
	CaeOOwmnw2kGiF5TZN8JMcvANH2ZkRJyBFNmu6+O591wlbZ9btg8W7HJOg4s8/pw6zZncGlo7I8
	sIg9Px8vwcgcOdCMtgzddiKiFsvFvPGhzD6CwHJFygF0IAJzfN6aY1pfBbza3PMFHsAwVleT901
	30qNnxCB2sJY8I=
X-Google-Smtp-Source: AGHT+IF0Y4OsQNTylr5MdP4BG/u47zJhj8IXlXSW4g1bgnrY/7JlA7sBL1rv7zNdmmReErtRlZZDlscfRv/rrpL41Ks=
X-Received: by 2002:a17:902:e54f:b0:267:9c2f:4655 with SMTP id
 d9443c01a7336-27ed4a49254mr131173685ad.41.1759027341225; Sat, 27 Sep 2025
 19:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925153746.96154-1-leon.hwang@linux.dev> <20250925153746.96154-6-leon.hwang@linux.dev>
In-Reply-To: <20250925153746.96154-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 27 Sep 2025 19:42:07 -0700
X-Gm-Features: AS18NWCHrWJ5Y01HDEMP7gksqhMf2rFusWxmUFoHkUc23UYIGL7_BvedAdgu05A
Message-ID: <CAEf4Bzacd768RGKyujM7TTWa-JeNnZntJbJoZr2FetCR4X-soQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_cgroup_storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 8:38=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
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
>  kernel/bpf/local_storage.c | 22 +++++++++++++++++++---
>  kernel/bpf/syscall.c       |  2 +-
>  4 files changed, 23 insertions(+), 6 deletions(-)
>

[...]

>  int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
> -                                  void *value)
> +                                  void *value, u64 map_flags)
>  {
>         struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
>         struct bpf_cgroup_storage *storage;
> @@ -199,11 +199,17 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *=
_map, void *key,
>          * will not leak any kernel data
>          */
>         size =3D round_up(_map->value_size, 8);

um... same issue with rounding up value_size when BPF_F_CPU is set, no?

> +       if (map_flags & BPF_F_CPU) {
> +               cpu =3D map_flags >> 32;
> +               bpf_long_memcpy(value, per_cpu_ptr(storage->percpu_buf, c=
pu), size);
> +               goto unlock;
> +       }
>         for_each_possible_cpu(cpu) {
>                 bpf_long_memcpy(value + off,
>                                 per_cpu_ptr(storage->percpu_buf, cpu), si=
ze);
>                 off +=3D size;
>         }
> +unlock:
>         rcu_read_unlock();
>         return 0;
>  }
> @@ -216,7 +222,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *=
_map, void *key,
>         int cpu, off =3D 0;
>         u32 size;
>
> -       if (map_flags !=3D BPF_ANY && map_flags !=3D BPF_EXIST)
> +       if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_AL=
L_CPUS))
>                 return -EINVAL;
>
>         rcu_read_lock();
> @@ -233,11 +239,21 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map=
 *_map, void *key,
>          * so no kernel data leaks possible
>          */
>         size =3D round_up(_map->value_size, 8);
> +       if (map_flags & BPF_F_CPU) {
> +               cpu =3D map_flags >> 32;
> +               bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu), va=
lue, size);

ditto

> +               goto unlock;
> +       }
>         for_each_possible_cpu(cpu) {
>                 bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
>                                 value + off, size);
> -               off +=3D size;
> +               /* same user-provided value is used if BPF_F_ALL_CPUS is
> +                * specified, otherwise value is an array of per-CPU valu=
es.
> +                */
> +               if (!(map_flags & BPF_F_ALL_CPUS))
> +                       off +=3D size;

btw, given we'll need another revision to fix up all those round_up()
issues, what do you think about make this offset logic completely
stateless (and, in my opinion, more obvious):

for_each_possible_cpu(cpu) {
    p =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
    memcpy(per_cpu_ptr(storage->percpu_buf, cpu), p, size);
}

seems more straightforward to me

P.S. And please update this everywhere for consistency ;)


>         }
> +unlock:
>         rcu_read_unlock();
>         return 0;
>  }
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index f336ca1f48d9b..c227994c065ff 100644
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
>                 err =3D bpf_stackmap_copy(map, key, value);
>         } else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
> --
> 2.50.1
>


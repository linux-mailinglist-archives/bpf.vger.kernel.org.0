Return-Path: <bpf+bounces-68585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45635B7E6E7
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C194610A7
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049322F361C;
	Tue, 16 Sep 2025 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgsFTQ7T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9EA2D3EF5
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066299; cv=none; b=l97UCLteRHZ3c9jFGKkHq1Q93jxEPBJ9V6S1LHiTRMCcR/6MxqcevobekwBHDGQ46EcMVHye4qHdu38DW0iQ4CaJagnBs04KyDZartB1K8Di/YpDPka8QnfSzhK7tKsBzrL+xpey0ooFAgCGsdOVArS5RQQA2tgO9ChwE65X0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066299; c=relaxed/simple;
	bh=ut5HkMKJN6Ij6XmbA5eOI7KYS9T6h2kr+gmNxTqRiCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tN2AK7y8IxynPvidt+F3Jh66qnU/p9ZV7gqMIjg2p0MBW+KzLuLG0TSthiNC2GAcWuYxaAKFk90D9E8R+J3ZrFl4b8TRXDrdEniid1YrS1sbYoDot5KHaQKD2iwbtwGNiaXvlzqVPAV99XAEa3UvG7ZBtIaInGNBEGIWHlCHZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgsFTQ7T; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26488308cf5so24429925ad.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066297; x=1758671097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcBkKO9ecM41QS5eKrsyLlfd9/TQI9vpUkdJs9nxymY=;
        b=CgsFTQ7T+8UiVN8Jy0SvjQ6lR0W/ZWdVEVH7A5j8Nx67KvNQ/mzhMhPy+qV6APQCcv
         DebC5BZF8/RBUhbEnU1FecpPqI2apcb1CoSmsroDSpuIkBhYQhbtQze0LTMW91ovci61
         khVOURXxLe36zVwbFU7t8EnVNjCP7M4l4SGumL+clZPuTWaf8ExxUV5cKsyUxp5pZ6vF
         xATdOH5Fya3BBDyWkmsaS+BhEBzigriD5D1Kh2sgdwjdmhP+qyP2BwDJKb2gXsltGfPd
         78s4D53UzEBjcanhsCyoDlKxZ5JJD0N9X/3PYMHMXnTjjlExuoippx0u6v/LY62QVYt8
         BJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066297; x=1758671097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcBkKO9ecM41QS5eKrsyLlfd9/TQI9vpUkdJs9nxymY=;
        b=kCyALGeuEbnJnqV3ioL5C4/AxLDgvZf3/yS2fW8fi4DRnOzNTBhGbF4ZbXcu0tJp/s
         1BSBsGdHvjNfud/EDyCveSoflP5NjaFgOrtNjB7SnZYaZCUyuf/VoOuwe0dm62/EvAjF
         AtVqVTQKIJKh0TLj4h8zFh80mCYVk0BASnqVHuqztWabODNxdSP4bi0i3ZQwwll9Pq5c
         zKH4oi0ppmu4xFfAJ/bFkxaLf6HOJ95J269oQnCwA2xiudWfpw5lpuTlkO895Lsq+nlm
         c5+rOZhkrnVtPX5QkO15IwlAF0orzgbTYR7wtANOOkR4Udta1y1p/sLMIUh9YiUAE3sC
         +Adg==
X-Gm-Message-State: AOJu0YwULs+EyuNmrUzIoPfINZSi3UL9q8PxTU2qAMSgIVe2bHNuKYVS
	Q50YBom41RVXG8DSMc4GPb9VZ49TrBm6drElN63jhNOvc6yrb6nSdtK7xThLcxkLocR2mRIZIJZ
	xTAKlFSU5yCMjw056XVZZqe1hHQ0VjYU=
X-Gm-Gg: ASbGncsrfGOGHIF9jizEAtjLExy/cNB+UKFia1nQhm7Pgkaqip6lG8reiZ7FemqGj6X
	lqtC2viYri4EVVYdKhVUnM3kdDTNX1KBhRpIikWJ7p2OswyOR34nMtdaxjnzUv2bHWCm9W/yzyA
	hEywMCSy7yiMZszGdUOOHxuZTRY+vMK9p1AKk++fgIQ6LOYlccyvDuBeITddexsUP4D9/sKksWk
	FsT2gB5tEXDk7undEIqGqM=
X-Google-Smtp-Source: AGHT+IEGkPZ5qDuIt5qzq3YxqOS/dsb+uuKY1M/aGeVxs/x5yzi0gJ740T9CLyxLSD8Yr5JDim5I+wKDt//5mrBH3BM=
X-Received: by 2002:a17:902:da84:b0:265:a159:2bab with SMTP id
 d9443c01a7336-26810df1fabmr1819165ad.0.1758066297474; Tue, 16 Sep 2025
 16:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-4-leon.hwang@linux.dev>
In-Reply-To: <20250910162733.82534-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 16:44:39 -0700
X-Gm-Features: AS18NWDbHJcneVB3N5OdnVnWefyTOtRwQt2_-Cgf6CLuPQGMniZnXsatoMsJqK8
Message-ID: <CAEf4Bzb2WMEbw0x7RQQh6v43_OUcXGX-W_uDPGc6zO6nO5ZdXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_array maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 9:28=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Introduce support for the BPF_F_ALL_CPUS flag in percpu_array maps to
> allow updating values for all CPUs with a single value for both
> update_elem and update_batch APIs.
>
> Introduce support for the BPF_F_CPU flag in percpu_array maps to allow:
>
> * update value for specified CPU for both update_elem and update_batch
> APIs.
> * lookup value for specified CPU for both lookup_elem and lookup_batch
> APIs.
>
> The BPF_F_CPU flag is passed via:
>
> * map_flags of lookup_elem and update_elem APIs along with embedded cpu
> info.
> * elem_flags of lookup_batch and update_batch APIs along with embedded
> cpu info.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h   |  9 +++++++--
>  kernel/bpf/arraymap.c | 24 +++++++++++++++++++++---
>  kernel/bpf/syscall.c  |  2 +-
>  3 files changed, 29 insertions(+), 6 deletions(-)
>

[...]

>
> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u=
64 map_flags)
>  {
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         u32 index =3D *(u32 *)key;
> @@ -313,11 +313,18 @@ int bpf_percpu_array_copy(struct bpf_map *map, void=
 *key, void *value)
>         size =3D array->elem_size;
>         rcu_read_lock();
>         pptr =3D array->pptrs[index & array->index_mask];
> +       if (map_flags & BPF_F_CPU) {
> +               cpu =3D map_flags >> 32;
> +               copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
> +               check_and_init_map_value(map, value);
> +               goto unlock;

goto is not how I'd structure this logic, I think if/else is a more
logical structure here, but this works, I suppose...

> +       }
>         for_each_possible_cpu(cpu) {
>                 copy_map_value_long(map, value + off, per_cpu_ptr(pptr, c=
pu));
>                 check_and_init_map_value(map, value + off);
>                 off +=3D size;
>         }
> +unlock:
>         rcu_read_unlock();
>         return 0;
>  }
> @@ -390,7 +397,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void=
 *key, void *value,
>         int cpu, off =3D 0;
>         u32 size;
>
> -       if (unlikely(map_flags > BPF_EXIST))
> +       if (unlikely((u32)map_flags > BPF_F_ALL_CPUS))

this will let through BPF_F_LOCK, no? which is not what you intended,
right? So you need to check for

(map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS

>                 /* unknown flags */
>                 return -EINVAL;
>

[...]


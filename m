Return-Path: <bpf+bounces-69915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FDBBA6672
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 04:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4183BBF42
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 02:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC60C2475D0;
	Sun, 28 Sep 2025 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqXz0HeT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B72EAE3
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 02:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759027340; cv=none; b=hp9Mpb+jo5yMDvxnzjLC+b6AHQsl23v76tIpBttMLmlveRZvzuUt3N195IvfOKKeFuSi/dK0KdBUGClr7BsI9jAY3wCHcFqnG4YSadr0FO82BBR6OnMfUbUhj4eOlSRBMasGwaMPlD3MaBZSy7wqPMUWH9TzxnrkSBb8VNpS5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759027340; c=relaxed/simple;
	bh=nIrzT0RjgE80360ZTKvur97D80d3VXVW2m6cxXfXk9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmknNKJmvgvTzzHpDnfTqqvKqSfhWPoqsSB11+UeFtMMxM7ZSLG22aV0Jh+71SV9t8KVwuDnR9KK3aewQtf5oK9/vay6dqhnwR+GO558z+/j51tlQQkz/zsPMxeI4kUn/2KMcVvAWnFh3xSSSC6mkaguEnHMC6qmRK/fUQ1wWNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqXz0HeT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so2971195a91.3
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 19:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759027338; x=1759632138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54FKpYFeIi/UDCwG5WNQ/pNG0M22fQ5KvZvvZ/E9eOs=;
        b=hqXz0HeTmR3ceeVxPtG8IncY8434HPFa0NnyVajz8I0kCr2Wn/PNnooYwQCLne4/vF
         PYine44G2qbh4+mGrJWilrSKodXgLCrX8TTKU5zC/JbpPaOXA3xTNQrzgIJwCVPz8pbC
         xaTMZY9WiB5I/v0x0MScSbJq/BRa+6ul9VpvZr2CoOUI/qN5GQZ1LNZnwECFAw6fVWXD
         IlCsHzii2DkWBNjoflVUwOO6WSClxFOqwsIT2qDxJ6AESJsxefXKgNHuGm0ZFvdZuxQE
         cNluCnKbYiuJxt+z6ijnPUYUBz9u9Y656FVwQwTYxsOelH9TY07ZROsdd6CjR+X3U2sH
         4lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759027338; x=1759632138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54FKpYFeIi/UDCwG5WNQ/pNG0M22fQ5KvZvvZ/E9eOs=;
        b=NqEH3OWTWDcqzu2ZIkVfgQK4m/Cn7CB7oenjtLmhFxM+vj1ZBLhYecDGrg1LLOIDgO
         pQP3TS/3emDLvMcmoLH8G6pnircYqfJVNoci+M3QqqtkHxNUd6CHX5GxzJnFIDU3H+y8
         kIg6IYd/wtIEyi9P0Fzry7T6VrDA4I+E6cs/2Is5jkowMooHf89D67xrBpFJvE5K3agZ
         8eO0zwYywU+fc3cKZLOVdQyUXsCI/N3ICehfA5f2orNBLnGoG5HGyj/z6JeiLaGXK08G
         x7bLu4Wz7aHEC+xBsY8zevLWMs7ZBoKaf1FJ1wZXLLShThJN40134KbLJgcsMOSKcSZw
         yFMw==
X-Gm-Message-State: AOJu0YzQi2/30Wqaw0bFOLhKQBDi3NLSZyFnEkykbZaadYlKcnhPpBOO
	8SYUivac/G0xVtC6uaPeb8l568OAYFdwygufvvVHMmHkYX+jEehaV0VcCrbyRxr9cDr/doEuEUd
	z7u2iDo7glvQSM31UC+HPeTNS8TmaMY1nLJrH
X-Gm-Gg: ASbGnct+4oZGj6/Vi8FpnG8C7nZDnu9/SCApOBSS+GzM6qFRkEEmzKjyGUcAc0DCojC
	KrfP16qTMzPf8asOcboSwtsAeQlNABf9i7bgOxiORh9iVTGPgtmCxwffMESOt97dBIsePJrS7H8
	b9WAWUK82paZElPNsxVqNdMxhnG0aE4T+Cly0ezzbxo6Bwmm8zRnNv8HnXbWSJUrsFXlitArw1g
	ZSU
X-Google-Smtp-Source: AGHT+IFUdkYyDGHOgMtYUUJiE6u2r/KqO48c0KF/LugI3mWx2f8wTcBGydRZ8Pud++MOYXcXXoVW3PieVGZFbP0aIMM=
X-Received: by 2002:a17:90b:350c:b0:330:6c04:a72b with SMTP id
 98e67ed59e1d1-3342a2498f2mr13269886a91.3.1759027338130; Sat, 27 Sep 2025
 19:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925153746.96154-1-leon.hwang@linux.dev> <20250925153746.96154-3-leon.hwang@linux.dev>
In-Reply-To: <20250925153746.96154-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 27 Sep 2025 19:42:03 -0700
X-Gm-Features: AS18NWAzOg4cQrhhJMtYmOk-TfrK5LTjgCeq2NgTArpslKF-perE55JFQK0sMy4
Message-ID: <CAEf4BzbeCzFbw=cPe4AktrdA9QPB7uUP0z1dcoCw7g-DLFnuOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags
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
> Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags and check them for
> following APIs:
>
> * 'map_lookup_elem()'
> * 'map_update_elem()'
> * 'generic_map_lookup_batch()'
> * 'generic_map_update_batch()'
>
> And, get the correct value size for these APIs.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h            | 23 ++++++++++++++++++++++-
>  include/uapi/linux/bpf.h       |  2 ++
>  kernel/bpf/syscall.c           | 31 +++++++++++++++++--------------
>  tools/include/uapi/linux/bpf.h |  2 ++
>  4 files changed, 43 insertions(+), 15 deletions(-)
>

[...]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 84261a0211c51..d1bbc309b62ff 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -133,12 +133,14 @@ bool bpf_map_write_active(const struct bpf_map *map=
)
>         return atomic64_read(&map->writecnt) !=3D 0;
>  }
>
> -static u32 bpf_map_value_size(const struct bpf_map *map)
> -{
> -       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> +static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
> +{
> +       if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS))
> +               return round_up(map->value_size, 8);

with the idea that BPF_F_CPU (and BPF_F_ALL_CPUS for updates) turns
per-CPU lookup/update into a singular non-per-CPU lookup, shouldn't
this be just `return map->value_size;`?

pw-bot: cr

> +       else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
>                 return round_up(map->value_size, 8) * num_possible_cpus()=
;
>         else if (IS_FD_MAP(map))
>                 return sizeof(u32);

[...]


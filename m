Return-Path: <bpf+bounces-67951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93C5B5090E
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 01:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30501B27F6B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A233C2820A4;
	Tue,  9 Sep 2025 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC4i8RA8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1392571A5
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757459278; cv=none; b=kcSjQ5pPKt/FlkkMeaZACpXYKC1Qf0Jb90BXv/yb6yYSEF16PvLUwRNgYPQEpO+o7qB2tOOmez7+SRaeavxXdgntD6NkFNT1LxL16HvDkQpWRkDi3L1GWZXzcPN+DTFG+39lPrcHDvwKAOcUUcfBYy43XQW35iSJsZL7COxYBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757459278; c=relaxed/simple;
	bh=GgylwrOXok+WbcEaH+4tqu6CXvL0KiFy7l5ZeijLdTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdfSm/t9gGg9c+TP6O/TfyqckLQWGa0oMRE5Q9n494UzpUO+tiTCl3e1EVMqOkcCqe4UI9fPGdrBJznZasfAwntwJamG5JchKgl0WmSw2+sFoSLrCmirFkecJNBIyuswlnMkw8ZVTWeEhrF8LNZ0JecSCRqutts4F2S8hh9y91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC4i8RA8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso31745705e9.2
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 16:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757459273; x=1758064073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfgFHEe8SGqUGOQZ0ZmzWIHPmoqaa5x+W0yvTRRoVYQ=;
        b=hC4i8RA8Ti0a7GS7uJCx/2PKzi7ma5Ac8jJvTsY1mSEmr3GS+D1pPLkje1pkTcOYCo
         nRfB2190WoL1VdKmwn9IhFcFN5rskU0qDtPs8d9GxoT0VqXFxGauGNpvthzgjk74Q6MH
         Gc492MkadomagXoBt3dnrzCJKWYWYNBGbGINEpuJ7Ofs3shvLq7OiHXpjYKgF5A1EFLJ
         X8XBwlrSfF1iQDddQvbwam+LmOT0CyKdav8zuVj6YTa+3/BU6S8xwg/a+P6a2I/iGMGl
         Fr2GlfW7p/cXGSzvXSR1o1x2gfevVPy45D8Vyh54lDsF1BjilPeBG7HYcweqWaJlgF9S
         iHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757459273; x=1758064073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfgFHEe8SGqUGOQZ0ZmzWIHPmoqaa5x+W0yvTRRoVYQ=;
        b=ZE4ytz7ykhcw42pyZNEpOO4QDof2v4RzVDK+g1Z/XTtYUpRZxWxRi9oxZ3OfAzjJYJ
         vBIBFylOon/0EeGLYdPgG7ZX/QrA4vcOenpVD6jf2wo4KgtdaeMw0/A03dkta6d2fDzs
         hcuz0Jktw4shQJUJSdv35cb+vNBn9vEu4fGPIgrchbPhB5EqO5+Iit/hpj/ponuP98az
         ll9nG9OY9mFFJzvgjIKXADBzB24OTvocxB8U5m1Tnvx+9GHAhDpRLP2NLpVEwkEUWkcE
         giiTzOYzEGIFcqoBmqaHQBP3UoNTo3BiB2RkB4XAHhshXZgrds4pSlnOptczo4Zc8LkC
         vIXg==
X-Gm-Message-State: AOJu0YxmjxCxcA0HIsZx7ZYN1Lh6FRyhGEgrmaa3InWnrkRNbFtYelfu
	MVBZREdVXWdE+BE30BCDiF/GGeuL9NdIDPeltYbDKI/IxspbhN6OHmoVGoShTA6m+anyWaXnSBY
	q7+mXTPAaBGuzJy/cwKjf19wxSUwohH0=
X-Gm-Gg: ASbGnctxz4NH35KVZlwEpXFrOMH+/uGlDuYwNPlic53rdv/JGWFhSdAPaOh1eNX/9F+
	h5Svn3ieLEngi3NmP5o8n/TnS/rvvuL8RC4MsVuNvdNEK63JBo0xgnvXuGKEEs0d7lQqJoU6FwW
	dB9c7uH5DhZ5BwGjuYtRN9bq/X5m/tWef2RxhmEg0CuhdqCgqIczscU9m8a94bnTeTajPT+Wxqj
	nydpumDrfXlSu10vt8snApBTWYkFjt7gVrh
X-Google-Smtp-Source: AGHT+IHFFRx+FqtwZnEwO4YrfiR16uiVez5uGa9G5yPPiksvH6SPSeoZNOgN0Lfg9Sj3oIQAFXYbFeUCO/lfsO2eAXs=
X-Received: by 2002:a05:600c:b8a:b0:456:1c4a:82b2 with SMTP id
 5b1f17b1804b1-45ddde82fa8mr120554105e9.10.1757459273456; Tue, 09 Sep 2025
 16:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909141422.45450-1-leon.hwang@linux.dev> <20250909141422.45450-3-leon.hwang@linux.dev>
In-Reply-To: <20250909141422.45450-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Sep 2025 16:07:42 -0700
X-Gm-Features: AS18NWCGm-3uC8ryr-Bs9WPoST08a2pMfyDIsnTIE6CEaYhi06s4V7mJk8uaikQ
Message-ID: <CAADnVQJcu2VM-NdXsteA=0+MtdxvhGya7PZ5_UcYe+d9xqobbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:14=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
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
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h            | 22 ++++++++++++++++++
>  include/uapi/linux/bpf.h       |  2 ++
>  kernel/bpf/syscall.c           | 42 ++++++++++++++++++++++------------
>  tools/include/uapi/linux/bpf.h |  2 ++
>  4 files changed, 54 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8f6e87f0f3a89..60c235836987d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3709,4 +3709,26 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, =
unsigned long ip, const char *
>                            const char **linep, int *nump);
>  struct bpf_prog *bpf_prog_find_from_stack(void);
>
> +static inline int bpf_map_check_cpu_flags(u64 flags, bool check_all_cpus=
_flag)
> +{

This function is not used in this patch. Don't add it without users.

Also I really don't like 'bool' arguments.
They make callsite hard to read.
Instead of bool use
bpf_map_check_flags(u64 flags, u64 allowed_flags)

so the callsites will look like:
bpf_map_check_flags(flags, BPF_F_CPU);
and
bpf_map_check_flags(flags, BPF_F_CPU | BPF_F_ALL_CPUS);

Also two functions that do very similar things look redundant.
This bpf_map_check_flags() vs bpf_map_check_op_flags()...
I think one should do it.

pw-bot: cr

> +       const u64 cpu_flags =3D BPF_F_CPU | BPF_F_ALL_CPUS;
> +       u32 cpu;
> +
> +       if (check_all_cpus_flag) {
> +               if (unlikely((u32)flags > BPF_F_ALL_CPUS))
> +                       return -EINVAL;
> +               if (unlikely((flags & cpu_flags) =3D=3D cpu_flags))
> +                       return -EINVAL;
> +       } else {
> +               if (unlikely((u32)flags & ~BPF_F_CPU))
> +                       return -EINVAL;
> +       }
> +
> +       cpu =3D flags >> 32;
> +       if (unlikely((flags & BPF_F_CPU) && cpu >=3D num_possible_cpus())=
)
> +               return -ERANGE;
> +
> +       return 0;
> +}
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 233de8677382e..be1fdc5042744 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1372,6 +1372,8 @@ enum {
>         BPF_NOEXIST     =3D 1, /* create new element if it didn't exist *=
/
>         BPF_EXIST       =3D 2, /* update existing element */
>         BPF_F_LOCK      =3D 4, /* spin_lock-ed map_lookup/map_update */
> +       BPF_F_CPU       =3D 8, /* cpu flag for percpu maps, upper 32-bit =
of flags is a cpu number */
> +       BPF_F_ALL_CPUS  =3D 16, /* update value across all CPUs for percp=
u maps */
>  };
>
>  /* flags for BPF_MAP_CREATE command */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index f5448e00a2e8f..db841b38f0c22 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -131,23 +131,36 @@ bool bpf_map_write_active(const struct bpf_map *map=
)
>         return atomic64_read(&map->writecnt) !=3D 0;
>  }
>
> +static bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
> +{
> +       return false;
> +}
> +
>  static int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 al=
lowed_flags)
>  {
> -       if (flags & ~allowed_flags)
> +       if ((u32)flags & ~allowed_flags)
>                 return -EINVAL;
>
>         if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BP=
F_SPIN_LOCK))
>                 return -EINVAL;
>
> +       if (!(flags & BPF_F_CPU) && flags >> 32)
> +               return -EINVAL;
> +
> +       if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) && !bpf_map_supports_c=
pu_flags(map->map_type))
> +               return -EINVAL;
> +
>         return 0;
>  }
>
> -static u32 bpf_map_value_size(const struct bpf_map *map)
> +static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
>  {
> -       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> +       if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS))
> +               return round_up(map->value_size, 8);
> +       else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
>                 return round_up(map->value_size, 8) * num_possible_cpus()=
;
>         else if (IS_FD_MAP(map))
>                 return sizeof(u32);
> @@ -1687,7 +1700,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>         if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
>                 return -EPERM;
>
> -       err =3D bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK);
> +       err =3D bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK | BPF=
_F_CPU);
>         if (err)
>                 return err;
>
> @@ -1695,7 +1708,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>         if (IS_ERR(key))
>                 return PTR_ERR(key);
>
> -       value_size =3D bpf_map_value_size(map);
> +       value_size =3D bpf_map_value_size(map, attr->flags);
>
>         err =3D -ENOMEM;
>         value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> @@ -1762,7 +1775,7 @@ static int map_update_elem(union bpf_attr *attr, bp=
fptr_t uattr)
>                 goto err_put;
>         }
>
> -       value_size =3D bpf_map_value_size(map);
> +       value_size =3D bpf_map_value_size(map, attr->flags);
>         value =3D kvmemdup_bpfptr(uvalue, value_size);
>         if (IS_ERR(value)) {
>                 err =3D PTR_ERR(value);
> @@ -1958,11 +1971,12 @@ int generic_map_update_batch(struct bpf_map *map,=
 struct file *map_file,
>         void *key, *value;
>         int err =3D 0;
>
> -       err =3D bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F=
_LOCK);
> +       err =3D bpf_map_check_op_flags(map, attr->batch.elem_flags,
> +                                    BPF_F_LOCK | BPF_F_CPU | BPF_F_ALL_C=
PUS);
>         if (err)
>                 return err;
>
> -       value_size =3D bpf_map_value_size(map);
> +       value_size =3D bpf_map_value_size(map, attr->batch.elem_flags);
>
>         max_count =3D attr->batch.count;
>         if (!max_count)
> @@ -2017,11 +2031,11 @@ int generic_map_lookup_batch(struct bpf_map *map,
>         u32 value_size, cp, max_count;
>         int err;
>
> -       err =3D bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F=
_LOCK);
> +       err =3D bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F=
_LOCK | BPF_F_CPU);
>         if (err)
>                 return err;
>
> -       value_size =3D bpf_map_value_size(map);
> +       value_size =3D bpf_map_value_size(map, attr->batch.elem_flags);
>
>         max_count =3D attr->batch.count;
>         if (!max_count)
> @@ -2143,7 +2157,7 @@ static int map_lookup_and_delete_elem(union bpf_att=
r *attr)
>                 goto err_put;
>         }
>
> -       value_size =3D bpf_map_value_size(map);
> +       value_size =3D bpf_map_value_size(map, 0);
>
>         err =3D -ENOMEM;
>         value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 233de8677382e..be1fdc5042744 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1372,6 +1372,8 @@ enum {
>         BPF_NOEXIST     =3D 1, /* create new element if it didn't exist *=
/
>         BPF_EXIST       =3D 2, /* update existing element */
>         BPF_F_LOCK      =3D 4, /* spin_lock-ed map_lookup/map_update */
> +       BPF_F_CPU       =3D 8, /* cpu flag for percpu maps, upper 32-bit =
of flags is a cpu number */
> +       BPF_F_ALL_CPUS  =3D 16, /* update value across all CPUs for percp=
u maps */
>  };
>
>  /* flags for BPF_MAP_CREATE command */
> --
> 2.50.1
>


Return-Path: <bpf+bounces-75508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEADC87742
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017B23B5552
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954882F068C;
	Tue, 25 Nov 2025 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoVFZyZc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C90232785
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112879; cv=none; b=lf9lGcTFSEi3BaehcWKSPyAbfsj1TYi7F8qhXedwy8Ommaltj9DXfUKBjhKb30Zz11gxbPv15tZuwLOX0fsXG9vx/PvkrZvhKaTJ1r1wCT4nWpWTCbIhmG8r77bJ9OPlhsCR1t1pHZSEbV8lVDJFzKjin910ox8QFa8N0MSH0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112879; c=relaxed/simple;
	bh=ixdjz/lGdTrJVZQtJSefqkGpGRZIOsnVcZFxk7Y/X+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQE5llCLmD+32w5yd0W3lDxselLrMxd7xg5hSNqv+NLF6x5HqdcyX0l3VSLmoVwgXeIRHBw1E3xWaXr5U25qrE3kYYzWZBofpEhpyb/jCl4WTqW2AyVIpT6aJrXA3C/e/5TcGDjij7r4Er3aAILSjICsMN1bOg7OfMZM0ex5W+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoVFZyZc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso1755495e9.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764112875; x=1764717675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkxQBqbD1/JuOSygAWMRrM27Y5Xe0IPLQCwbELxwSlQ=;
        b=CoVFZyZcNtyndRPVTE1AbiV5HwuwUBS9NWe/59klivKR9Aaww2DmHJCa9ah1wEheAP
         Cnmlqa3IaTQkiXGyv2JCh/eKH2saMoVyYonGVjAGjGWEmYmPHRd8g8Qz+M+QgG0byrXE
         uGpmpEUfehoReJxYBEmF9pgf1cUwYSIpDG40KzHq2YzO0u6HinYw5Y4dmo9W6h2T9dZ4
         cIm7pKoNtk41yHJwaVHlaX41Zlj/kucmweOJNkoGvAeEJ0Lka39jP0wCY9KPIUvfxOPW
         04nJZnok4iTH8Rlaj3eKouJDRC6ezNZJjfMX6cgSb/l3vq7XCrrO+xyRXbJANeLxX4qD
         T/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764112875; x=1764717675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OkxQBqbD1/JuOSygAWMRrM27Y5Xe0IPLQCwbELxwSlQ=;
        b=ow8hh6OUjzB7gUzdyKOdoStf6k8XapVHNuBc4DA7WExFYRbH6wblryZVHv8PZ+d1nj
         I1Qv78xJBoLf9fD67cbTqfr7qVzG8aVVZT4CddedR923LVBU9enkkCBts9QBFlKyepti
         TUE792LW1v+iGEWNwPeNlueTS1xm65k5s40OqD7o4JvPMTh1QVu16hALhSPrUnqAjp54
         AlsOFDbB50FnsQFD0VLC4uSpkuwLmjIDyEslNvIiufHiesalsAwyt0KBgDa/r8zAtUJt
         /EK5MsURViFgfps2I9Lsime6rFfEau7lL680FpA3V7z2ocNkUm2I7+fyuVCdbxZbl/pW
         p0kQ==
X-Gm-Message-State: AOJu0Yyx9bXFWxoJEsBxy5N+ASeUHVzVVVYaazkUF75xN2q4M9A8fX/h
	AGg90N4ulw9vi7LcrTpW0EXGFI09CEdD5cUIWqttBWkZH0LYoYqBIWJBc/VqmwhpmQufbRMCHXf
	9t1pXI5pgVdpCYPrJ33p6we7FJyyGn14=
X-Gm-Gg: ASbGncsPOO9obdLhnHX4UifUuTExBWEY8yiMNJXjwMcMGJ+c7Bcapd4GngpndttcOFu
	/U1wcxPnSk3J5slJ91kbn21h8zj3sfcYeM1DC3J2og588UJIguhbpCqtZ5G9SeDh9yQR9slgk9d
	VfXsGUbKyCrJu9TKlyy8I17mXuMHsqs9Vvv50DJ80GUG1HQFUxcga4q5eUtFmrcfRLLwZGWHP6J
	o9hsm/qYOdAamW8WBcZHwMWup4n7r5SyZYSxxfzSWDnals6upYafnB6zTVhXlnz3aWSzgnti38n
	Q8vj/Qu1YSyz9Wt6e01d0buTAU7b
X-Google-Smtp-Source: AGHT+IHpsa6m5s+OcFlKFSEdPJn+Zr1doCCS5y/jRcYPMbR2ruY/x2rwTEg2Gp9lw28vekpJgO5KF4Y4qqmH4kVNTRA=
X-Received: by 2002:a5d:5d88:0:b0:3e7:428f:d33 with SMTP id
 ffacd0b85a97d-42cc135db29mr18718124f8f.16.1764112875269; Tue, 25 Nov 2025
 15:21:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125145857.98134-1-leon.hwang@linux.dev> <20251125145857.98134-3-leon.hwang@linux.dev>
In-Reply-To: <20251125145857.98134-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Nov 2025 15:21:04 -0800
X-Gm-Features: AWmQ_bmB_4Aa-Z_uNUEFFbiGYz-C8c50-S9BMrQhpOQTRRB7ECxDwHkzQdgzuJU
Message-ID: <CAADnVQKuWrS57niXtr-xu4daR=GvnZORa+X2gHkDbsDZ3qyveQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 2/8] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Tobias Klauser <tklauser@distanz.ch>, kernel-patches-bot@fb.com, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 6:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
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
> v10 -> v11:
>  - Use '(BPF_F_ALL_CPUS << 1) - 1' as allowed_flags in map_update_elem().
>  - Add BPF_EXIST to allowed_flags in generic_map_update_batch().

It should be mentioned in the commit log.
Lines after --- don't stay in the log.

> ---
>  include/linux/bpf.h            | 23 +++++++++++++++++++++-
>  include/uapi/linux/bpf.h       |  2 ++
>  kernel/bpf/syscall.c           | 36 ++++++++++++++++++++--------------
>  tools/include/uapi/linux/bpf.h |  2 ++
>  4 files changed, 47 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6498be4c44f8..d84af3719b59 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3829,14 +3829,35 @@ bpf_prog_update_insn_ptrs(struct bpf_prog *prog, =
u32 *offsets, void *image)
>  }
>  #endif
>
> +static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type=
)
> +{
> +       return false;
> +}
> +
>  static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags,=
 u64 allowed_flags)
>  {
> -       if (flags & ~allowed_flags)
> +       u32 cpu;
> +
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
> +       if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
> +               if (!bpf_map_supports_cpu_flags(map->map_type))
> +                       return -EINVAL;
> +               if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPUS))
> +                       return -EINVAL;
> +
> +               cpu =3D flags >> 32;
> +               if ((flags & BPF_F_CPU) && cpu >=3D num_possible_cpus())
> +                       return -ERANGE;
> +       }
> +
>         return 0;
>  }
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f5713f59ac10..8b6279ca6e66 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1373,6 +1373,8 @@ enum {
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
> index cef8963d69f9..3c3e3b4095b9 100644
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
> +               return map->value_size;
> +       else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
>                 return round_up(map->value_size, 8) * num_possible_cpus()=
;
>         else if (IS_FD_MAP(map))
>                 return sizeof(u32);
> @@ -1732,7 +1734,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>         if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
>                 return -EPERM;
>
> -       err =3D bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK);
> +       err =3D bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK | BPF=
_F_CPU);
>         if (err)
>                 return err;
>
> @@ -1740,7 +1742,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>         if (IS_ERR(key))
>                 return PTR_ERR(key);
>
> -       value_size =3D bpf_map_value_size(map);
> +       value_size =3D bpf_map_value_size(map, attr->flags);
>
>         err =3D -ENOMEM;
>         value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> @@ -1781,6 +1783,7 @@ static int map_update_elem(union bpf_attr *attr, bp=
fptr_t uattr)
>         bpfptr_t uvalue =3D make_bpfptr(attr->value, uattr.is_kernel);
>         struct bpf_map *map;
>         void *key, *value;
> +       u64 allowed_flags;
>         u32 value_size;
>         int err;
>
> @@ -1797,7 +1800,8 @@ static int map_update_elem(union bpf_attr *attr, bp=
fptr_t uattr)
>                 goto err_put;
>         }
>
> -       err =3D bpf_map_check_op_flags(map, attr->flags, ~0);
> +       allowed_flags =3D (BPF_F_ALL_CPUS << 1) - 1;

This is cryptic.
Use
allowed_flags =3D BPF_NOEXIST | BPF_EXIST | BPF_F_LOCK | BPF_F_CPU |
BPF_F_ALL_CPUS;


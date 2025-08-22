Return-Path: <bpf+bounces-66314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF536B324E7
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6272E681516
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 22:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6A231832;
	Fri, 22 Aug 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3+GPkWx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E827CB0A
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755900909; cv=none; b=HNA0LYgBRQLdEbrognHgPbaRlFPqZ4eNujgxuQ7Ga6rnafO3fdazsD++8NrYH92TXGC3peNPgEd9euvkQciAE1w+BkV295la7tyb8nZc5ik27Uj3BkE64RNndBDoaPZPMtzY0eiIp0q6JBZp+7AQTgkl17pUM7OiGctDDCVG5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755900909; c=relaxed/simple;
	bh=JgaRzqDoswZsV9OQP7RAYxuFMQvUDBXScnEJW8Zd05M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKw2SfUJiU7aWY+P466be4aZb9TPJh4sFunMxcx254wCnpWL+pbZPULNDSasU5hcS3wjuzQox1h0cPdH8PiYyKSqRS6syBAFaWQeAkpaRUyrlIHNRFfxD0/VypvGSoFt2UhINA1bieWRxtajWOQJII6BRgL2xCXZMbiavgzWvo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3+GPkWx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3252c3b048cso780298a91.2
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755900906; x=1756505706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/iuMVvVPckCk2H8lHT3VjaZK/11XbuETIkdpkyugwQ=;
        b=K3+GPkWx88WSHmMgdcpGev6RrUFoT4EUesK21LIv5Gi0FepIR32hA7wvh7vygZ1d3l
         9LAtWsEvoorSAJ8F/hKmaMcBJPDR3ScGWIkkgNLbf9tW3tRvu9f9/mp2nKwfWe+zqroW
         R9Lr8TJx7dGiyDkOLJGcjHYK4O2yoTmXy+zAjJ+9DJuZZtoOdZ9wWewLaqpN0jNRjsdQ
         DfMpobjjQewL86gIdfjL3bbP192225x8IWkfVj+JMgD9CCxIxByzMjXv8BMvY8WoafUH
         +IraRO6SwOOTu6/fX4m5Id5IisJ8Pn8lBnXud0csyft3YAB9R9R161IwSf8lAxsRkTem
         PiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755900906; x=1756505706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/iuMVvVPckCk2H8lHT3VjaZK/11XbuETIkdpkyugwQ=;
        b=OLpt29NEzFohndS/HJG7w8QKCLc2iQ5OMFfKKbHEYRDXy77wLLXazZji7GlxnbDcWk
         87APChK/5PSGbvv48xlBDc0zAJXEACvQ4Ov7ZclBPn9t4W8f8OBEMtGBewtoVCVC8b1e
         +sbuwLezz6M4XTgMny79XdzWqzQdCw0R3Z3HyjtU9ZGy8PUSluO7jyAKYyMxMBzE5k2o
         St+UiOU0BJDV6HMWLemdyQgKKQYySMT7ocur/j+CkkkR9ruiCXWUceFRaTAnLROwEnde
         RAK2q2t2Q9guV07lZ59peAF2nFD+5v9ftwl+b5Gxo3xkWg3fkdSLURmMZGC7yFOBfpxm
         uCwQ==
X-Gm-Message-State: AOJu0YxV9r7pQCgObE6MjNR0DRk+xpw7CuvyA4qdO7eL7m3CcLUAmwEn
	/5WC3x4VXt6PTwBI5rr8G6uIBFUt7BtVhf0bRUXdZSfkpI73rppKunNrE2TRa/DDguO8Yq6d4M2
	2SYnmmZNWSKu5h9yrSGGTfqnDsD18yqs=
X-Gm-Gg: ASbGnctZMOod3xOb/zObRUnyQXIEgtVnYCA4kSdJ4WNI+YbzM8E1H4gztB/5SGx0vEA
	q/VWBbVgOw85nQbQX00GxWJYbQSJfuwJgCnz2xudDTZFFrPYQ0uLcwUQMoIs9EwyRDTZT0jTx1n
	5MmKYVbBYEjSwg0tdPOQdiH6stzKoixo+aFvrjuZUKasNXnulaBI3YbVvpI2HSIo22L0QtRhnpX
	CVZ48pAewhjb/T/pyYrM1w=
X-Google-Smtp-Source: AGHT+IE031wIjw2+UDfQ8QxSo861qNiJZcHNIH4re5VW3wHn7Bd2vHSsogomf4gJsy3/HQq/19TB56q6upYTirCrZ8k=
X-Received: by 2002:a17:90b:5343:b0:31f:5ebe:fa1c with SMTP id
 98e67ed59e1d1-32515e1976fmr6409835a91.0.1755900905680; Fri, 22 Aug 2025
 15:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821160817.70285-1-leon.hwang@linux.dev> <20250821160817.70285-3-leon.hwang@linux.dev>
In-Reply-To: <20250821160817.70285-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 15:14:49 -0700
X-Gm-Features: Ac12FXyqLf4C2tIfM6y3Vv4kRwDWbQ4qzqFDlxmAaovN1bRbvGX2xdQX6X7o0DQ
Message-ID: <CAEf4BzZnCudvoFd9WJ+sTJ63txxWi=h_0FmVz2HKPXCeqp6zbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Introduce BPF_F_CPU flag for
 percpu_array maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, olsajiri@gmail.com, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:08=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Introduce support for the BPF_F_ALL_CPUS flag in percpu_array maps to
> allow updating values for all CPUs with a single value.
>
> Introduce support for the BPF_F_CPU flag in percpu_array maps to allow
> updating value for specified CPU.
>
> This enhancement enables:
>
> * Efficient update values across all CPUs with a single value when
>   BPF_F_ALL_CPUS is set for update_elem and update_batch APIs.
> * Targeted update or lookup for a specified CPU when BPF_F_CPU is set.
>
> The BPF_F_CPU flag is passed via:
>
> * map_flags of lookup_elem and update_elem APIs along with embedded cpu
>   field.
> * elem_flags of lookup_batch and update_batch APIs along with embedded
>   cpu field.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h            |  3 +-
>  include/uapi/linux/bpf.h       |  2 ++
>  kernel/bpf/arraymap.c          | 56 ++++++++++++++++++++++++++--------
>  kernel/bpf/syscall.c           | 27 ++++++++++------
>  tools/include/uapi/linux/bpf.h |  2 ++
>  5 files changed, 67 insertions(+), 23 deletions(-)
>

[...]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 19f7f5de5e7dc..6251ac9bc7e42 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -131,9 +131,11 @@ bool bpf_map_write_active(const struct bpf_map *map)
>         return atomic64_read(&map->writecnt) !=3D 0;
>  }
>
> -static u32 bpf_map_value_size(const struct bpf_map *map)
> +static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
>  {
> -       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY && (flags & (B=
PF_F_CPU | BPF_F_ALL_CPUS)))
> +               return round_up(map->value_size, 8);

this doesn't depend on the PERCPU_ARRAY map type, right? Any map for
which we allowed BPF_F_CPU or BPF_F_ALL_CPUS would use this formula?
(and if map doesn't support those flags, you should have filtered that
out earlier, no?) So maybe add this is first separate condition before
all this map type specific logic?

> +       else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
>             map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
>             map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
>             map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> @@ -314,7 +316,7 @@ static int bpf_map_copy_value(struct bpf_map *map, vo=
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
> @@ -1656,12 +1658,19 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 k=
ey_size)
>
>  static int check_map_flags(struct bpf_map *map, u64 flags, bool check_fl=
ag)

you are later moving this into bpf.h header, so do it in previous
patch early on, less unnecessary code churn and easier to review
actual changes to that function in subsequent patches

>  {
> -       if (check_flag && (flags & ~BPF_F_LOCK))
> +       if (check_flag && ((u32)flags & ~(BPF_F_LOCK | BPF_F_CPU | BPF_F_=
ALL_CPUS)))
>                 return -EINVAL;
>
>         if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BP=
F_SPIN_LOCK))
>                 return -EINVAL;
>
> +       if (!(flags & BPF_F_CPU) && flags >> 32)
> +               return -EINVAL;
> +
> +       if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) &&
> +               map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +               return -EINVAL;
> +
>         return 0;
>  }
>

[...]


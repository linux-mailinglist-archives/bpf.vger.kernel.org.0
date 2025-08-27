Return-Path: <bpf+bounces-66747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E00B38F02
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 01:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373CD4635E7
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6072F3601;
	Wed, 27 Aug 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QztOmQ19"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F739239E8B
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336714; cv=none; b=bWQiSr0Jv6LM69EzE5F7WdiKra0/GzsehpqD18k58edGzhka5QOOHjhzVyub5z1R7oKp4KfsWhgBfBD7psP3CtYtHnohHIyLfAoIPGJtKPYkcPFLkbNsrJgRKu1tjmORyiwW4If+3rFEC7lPqV3Xr2ZhiDtCU6ImoY4kdivlvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336714; c=relaxed/simple;
	bh=560BTp+zlO4VZ1sms5GSgI973uTW7aA6tF29EvDrUsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQUXoHcea51zD210faY8zA/mTPcOwT2NvM9ky/NHQDmfa9Pl5n/mHyIGZ5EU0rEUNCkaWSwsBUPOdJjpt5R/aHZT9Kj0oldtdAUA+V3GXgxtvXcbLt6d+yljaYU7JY74bOHH29JUsr5Z5q9o9kPVgLyGkcIey85362wNe1BEVvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QztOmQ19; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-324e6daaa39so386162a91.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756336713; x=1756941513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7H2/wxWXTCjiAtAuCrz4CepGe2HQsoALGh1jU3Xrt8=;
        b=QztOmQ19uGjenNcrJBTIc9f2guPU6kPvRyCXsviPG5Y4Trt3PXI1/2Z2+HNOgdwpOz
         jvVkeayCKyL3Vs/D7RNgIxJtdtTRyEja+THI5+2YhYI1uq1fe70XyyG3Vm/RIKiTxa9t
         QiIkrWmAuKEZ4rP26lYBHRw5DkY4K4Dj5fxa7ZRLKbDSSLSmMBwnw64XlHtJ7DlScn/N
         4Yc3RtIdthX3MEutrkdm0QZdDRZ9YJmEjBXOXTCapBUdM2YMqDls1Xoi51TB1z0HRHvq
         311qtG3bhR/4QF9GrB1PrVpIXPaiu/Y2sdlNePxNt07qTJfRHCxQsiDVyKPjulG9bgLN
         yX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336713; x=1756941513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7H2/wxWXTCjiAtAuCrz4CepGe2HQsoALGh1jU3Xrt8=;
        b=sXcn5PyxK/qrKwFUPB2ienNvAvXV/9TfNivIMVMpMbx4QApD7m7m2aZcGGYErBq+Fk
         n8/kJL6p5XMTLtYCUafX5LVywGqsNvy+6KC7UDGRcg6sYpMKLAdhV9rLFK+xQKVYF8YH
         tn6RJZ70/ZzTp5NpFcOJR3E3fU/qdh0+ZKyA9r0HwgYRYtnwPZHiTY9cT9OIujCMw+rq
         GAdRyh6FcLZbmQhThxv9DWmJ6qJJL9zRQZt5oVbqIm1x7iSMCB0rgxx+L9zGDV7OeUte
         nkmNuRAfIhjwuZvEys+UxSAqZmWfwlfv6F7VmpbOZ18ucqEoPLqBCtMYGiiGWfdBVmiM
         6L4A==
X-Gm-Message-State: AOJu0YyDHYT9qYUe0X0dax0UaHz6ZFufaCSkqTUfWs1v2WkLs0S2Iruk
	4HSBRI2yo4ILtMyp6KlxXaSXiH7kjkpYVh3seXowx65nJ53blubNtb+tsBbGrRhdWzt8nvbQnJ7
	F/fLwVtRGjIJn1igJkAl6qyoFM2yUEus=
X-Gm-Gg: ASbGncvFfoci1ZllgEzO3qvrlwPWqUuSM/GT/cwbN3Kc8ew0C+cyqRjk3rbtlfhKcBg
	hJz+IphlpyJ/pPW+IlasuAvRpfaZPtt7CvAB9+OAedKVpC5uKLzRnXtdg+tltfsK4L503a1ggI6
	U1hH7PiSj+Df7FyF08priPxCEOvaoYmHiHNWRw2BGLYBalxLlo3rvyKhJCToRQd18sx9P2d1eLj
	of0e0URYN8PeRv3cI08RvU=
X-Google-Smtp-Source: AGHT+IE1EX61Q8Qk/5BW/E3jBFJQ5DD1bTyOmP7eXSGWh0Cthfp52+mkfe+22KW0eYCriLNzK/21XvXHl9iT+Mganbo=
X-Received: by 2002:a17:90b:1f91:b0:321:2b89:957c with SMTP id
 98e67ed59e1d1-32515ec8d01mr26225829a91.27.1756336712766; Wed, 27 Aug 2025
 16:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827164509.7401-1-leon.hwang@linux.dev> <20250827164509.7401-7-leon.hwang@linux.dev>
In-Reply-To: <20250827164509.7401-7-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 16:18:11 -0700
X-Gm-Features: Ac12FXy00ZHUbp-opCCecx6M6KODPqqhBJQ-cOR8-7_NB1zcrYQJxuav3yvOjHU
Message-ID: <CAEf4BzaLiFhd5RiSEzA-mk7bGZC-5YANBciQfhk+yxnN_inuXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/7] libbpf: Support BPF_F_CPU and
 BPF_F_ALL_CPUS flags for percpu maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:46=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Add libbpf support for the BPF_F_CPU flag for percpu maps by embedding th=
e
> cpu info into the high 32 bits of:
>
> 1. **flags**: bpf_map_lookup_elem_flags(), bpf_map__lookup_elem(),
>    bpf_map_update_elem() and bpf_map__update_elem()
> 2. **opts->elem_flags**: bpf_map_lookup_batch() and
>    bpf_map_update_batch()
>
> And the flag can be BPF_F_ALL_CPUS, but cannot be
> 'BPF_F_CPU | BPF_F_ALL_CPUS'.
>
> Behavior:
>
> * If the flag is BPF_F_ALL_CPUS, the update is applied across all CPUs.
> * If the flag is BPF_F_CPU, it updates value only to the specified CPU.
> * If the flag is BPF_F_CPU, lookup value only from the specified CPU.
> * lookup does not support BPF_F_ALL_CPUS.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.h    |  8 ++++++++
>  tools/lib/bpf/libbpf.c | 33 +++++++++++++++++++++++++++------
>  tools/lib/bpf/libbpf.h | 21 ++++++++-------------
>  3 files changed, 43 insertions(+), 19 deletions(-)
>

[...]

> @@ -10629,6 +10629,27 @@ static int validate_map_op(const struct bpf_map =
*map, size_t key_sz,
>         case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE: {
>                 int num_cpu =3D libbpf_num_possible_cpus();
>                 size_t elem_sz =3D roundup(map->def.value_size, 8);
> +               __u32 cpu;
> +
> +               if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
> +                       if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPU=
S)) {
> +                               pr_warn("map '%s': can't use BPF_F_CPU an=
d BPF_F_ALL_CPUS at the same time\n",
> +                                       map->name);
> +                               return -EINVAL;
> +                       }
> +                       cpu =3D flags >> 32;
> +                       if (cpu >=3D num_cpu) {

only check this if BPF_F_CPU is set

> +                               pr_warn("map '%s': cpu %u in flags cannot=
 be GE num cpus %d\n",

"GE"? maybe "CPU #%d is not valid"... (or don't even check cpu value
itself, it's unlikely user using BPF_F_CPU will get it so wrong)

[...]


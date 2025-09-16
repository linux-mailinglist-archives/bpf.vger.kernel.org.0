Return-Path: <bpf+bounces-68586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B1B7E3D2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CC51C04903
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4111A2C21D5;
	Tue, 16 Sep 2025 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecijYRHH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A3AD2C
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066308; cv=none; b=s5cIqKjpwaNNWNkZq6OrqkHpUs3pU6z4G1YVDvnTKN1tnIrznygc/4KRiggMwbt1Vl+L7Lty9uY/vOqMKAf8qqIxLVYGzHs4gXFEB0EkPeY89CnPejAkhCR14yipnTbYinjjhlvxbquWJIKgqur+N+PwlyLzFCad60RFD//0xI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066308; c=relaxed/simple;
	bh=d2qUQrbWYvXVRrD7nf1harZW2izk2NZI+deQeS+Ve94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZNA3pkeqsJk661fSyjPwOfrfxsLBk8wUO5SYxsPSLAJzlkjTH73mMShIv9Yr7TFGS/E6meUm68LYysNa5ybSaZu0L2TB6mwenLElcNEdoCv2bs+rQUKkttINqsQ7SNxfdeYYj2qeCwBQ7MmMbkdRgSZw+ncgiUtUkXa8bXMv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecijYRHH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2570bf6058aso78077825ad.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066307; x=1758671107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaccP59V8IGRSr6yDGuVwoylntqnWlVjniDxaj5cR1M=;
        b=ecijYRHHb6S6hrd9pyqDosB4fNzzoItmacfXDLXaRLrRuZ1cSU9GrcaQSaldoH59A/
         O5wKepi2wxdDZG7oVXLyepBQUnVJAFfkldq7Ou6UwtXsbkZTLe8h6Jm8t/CBSReqhGcz
         ZzlRHjp0F0YqfpwXmOzIF2X/S9P9xfoaHywBiMUf+VDmRIIBtJWH8Fy/jjwsqRimZj3Q
         QOaeqHMIYSPElPIQU22cstnYg+RsnmbdsGMYyhpfXQQ258hGocYrKJH2ltMR4jLzjQpL
         fATDHJukXReu+VEtaOSCmLZ8jptwISFcCW5ZPKSMmg6j2QjoQSDVG52GtUlgq9v4pzbK
         ZMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066307; x=1758671107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaccP59V8IGRSr6yDGuVwoylntqnWlVjniDxaj5cR1M=;
        b=rQsg07Xg/YLhPSQqebpCdEFjnt9AXhXJfO+TCIpeE8Uo3gO+lW2pwAlLrCY9fS9wAC
         dKeSx3ymugGOmbw5ECRrX0UN0s3WGuWetrqpQVgBDcrLOGnTG7YdnpwESThyiBEq9XGz
         NXH+0Ao9RrFS+5GT0dpRzgYPDau+5j9KkaXVheL02W512RqJzbul7pC5iEHPvMdmwWAG
         JtDuTxAB0b0RCRQexwJbH7zW8+2522qnvnHB1MNaC077VvD/I7HI60qo5sB3Ut122Us4
         N448f/XwBC2bPuVZ+idbKXczp54ZKtab0YygCahnbDlvDCKTI4qr/mIDZJyUKdfBBBfU
         PKpA==
X-Gm-Message-State: AOJu0Yw2umPaU3fn9ql+yNbSxgaJlEbz2Ip52ru6kJxKf7yujEW99A8W
	neOsneLXMUv2903TNmnPkIiKvyMlM4Tbe0nglpwDMELW2ElFwO0voFy9j3YXaoM5as2v30D80YY
	7ErVaP21h38vRoo5+Dxl4WcSXHOXnSj4=
X-Gm-Gg: ASbGncsFi16gpQbyxpo4nwrDduvIBqOU98q0vFsyU0VxuxqUzgn1twIVGLkkBCtcFlx
	7LvkvZiX5KiLziuSvKvMVFWhf3ZUrM1EFUqStx6B0sRybKhe64I8O7iPGrXGmzA6VJzMVCXVCVa
	mZ+eLOs6+uh8n0SXWHgbOjnKpDBaiB1M2ByimniyjxwcR1/tvABCpvLWcbEdOyqpcNRj0OIIR4P
	XC7YG3x8CfbpZjJ66k3EGU=
X-Google-Smtp-Source: AGHT+IFVkP95pa6dWhR61/qAoUqOuE2gYWt0IT5TJg7NcjhhePJmk4tYEIxgNXViflL+wohrP4nQBanq/CrkVLOoSss=
X-Received: by 2002:a17:902:d582:b0:25c:9688:bdca with SMTP id
 d9443c01a7336-26813bf1f32mr785855ad.50.1758066306625; Tue, 16 Sep 2025
 16:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-5-leon.hwang@linux.dev>
In-Reply-To: <20250910162733.82534-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 16:44:44 -0700
X-Gm-Features: AS18NWDeAeRqiKSF92fkTiGHBncF-za9mOjdO1HZApo4TvZbEmn4gZF-AmWrwD4
Message-ID: <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
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
> Introduce BPF_F_ALL_CPUS flag support for percpu_hash and lru_percpu_hash
> maps to allow updating values for all CPUs with a single value for both
> update_elem and update_batch APIs.
>
> Introduce BPF_F_CPU flag support for percpu_hash and lru_percpu_hash
> maps to allow:
>
> * update value for specified CPU for both update_elem and update_batch
> APIs.
> * lookup value for specified CPU for both lookup_elem and lookup_batch
> APIs.
>
> The BPF_F_CPU flag is passed via:
>
> * map_flags along with embedded cpu info.
> * elem_flags along with embedded cpu info.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h  |  4 ++-
>  kernel/bpf/hashtab.c | 77 +++++++++++++++++++++++++++++++-------------
>  kernel/bpf/syscall.c |  2 +-
>  3 files changed, 58 insertions(+), 25 deletions(-)
>

[...]

> @@ -1147,7 +1158,7 @@ static long htab_map_update_elem(struct bpf_map *ma=
p, void *key, void *value,
>         }
>
>         l_new =3D alloc_htab_elem(htab, key, value, key_size, hash, false=
, false,
> -                               l_old);
> +                               l_old, map_flags);
>         if (IS_ERR(l_new)) {
>                 /* all pre-allocated elements are in use or memory exhaus=
ted */
>                 ret =3D PTR_ERR(l_new);
> @@ -1263,7 +1274,7 @@ static long htab_map_update_elem_in_place(struct bp=
f_map *map, void *key,
>         u32 key_size, hash;
>         int ret;
>
> -       if (unlikely(map_flags > BPF_EXIST))
> +       if (unlikely(!onallcpus && map_flags > BPF_EXIST))

BPF_F_LOCK shouldn't be let through

>                 /* unknown flags */
>                 return -EINVAL;
>

[...]

> @@ -1698,9 +1709,16 @@ __htab_map_lookup_and_delete_batch(struct bpf_map =
*map,
>         int ret =3D 0;
>
>         elem_map_flags =3D attr->batch.elem_flags;
> -       if ((elem_map_flags & ~BPF_F_LOCK) ||
> -           ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(map->=
record, BPF_SPIN_LOCK)))
> -               return -EINVAL;
> +       if (!do_delete && is_percpu) {
> +               ret =3D bpf_map_check_op_flags(map, elem_map_flags, BPF_F=
_LOCK | BPF_F_CPU);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               if ((elem_map_flags & ~BPF_F_LOCK) ||
> +                   ((elem_map_flags & BPF_F_LOCK) &&
> +                    !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
> +                       return -EINVAL;
> +       }

partially open-coded bpf_map_check_op_flags() if `do_delete ||
!is_percpu`, right? Have you considered

u32 allowed_flags =3D 0;

...

allowed_flags =3D BPF_F_LOCK | BPF_F_CPU;
if (do_delete || !is_percpu)
    allowed_flags ~=3D BPF_F_CPU;
err =3D bpf_map_check_op_flags(map, elem_map_flags, allowed_flags);


This reads way more natural (in my head...), and no open-coding the
helper you just so painstakingly extracted and extended to check all
these conditions.

>
>         map_flags =3D attr->batch.flags;
>         if (map_flags)
> @@ -1724,7 +1742,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *=
map,
>         value_size =3D htab->map.value_size;
>         size =3D round_up(value_size, 8);
>         if (is_percpu)
> -               value_size =3D size * num_possible_cpus();
> +               value_size =3D (elem_map_flags & BPF_F_CPU) ? size : size=
 * num_possible_cpus();

if (is_percpu && !(elem_map_flags & BPF_F_CPU))
    value_size =3D size * num_possible_cpus();

?

>         total =3D 0;
>         /* while experimenting with hash tables with sizes ranging from 1=
0 to
>          * 1000, it was observed that a bucket can have up to 5 entries.

[...]


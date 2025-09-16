Return-Path: <bpf+bounces-68588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431FBB7E509
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DE9583804
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BAE2F39B1;
	Tue, 16 Sep 2025 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8wA9tZP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB52F39A6
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066320; cv=none; b=B+EifpPTFBnYw+ijdWIQXP77PVaRZaPkpfQG9pBJUSCXWTtr3fbVHP+/Y0EZhLl8QkTQ4HelzaPuXf+QYTpRc2dsPEcK4bSGDzEdDHBjHOjDjbVJDzA6HD1oPCTFucV1lPB0TG6OtWd0aCNzMdlHKyA2s3isJp7kGGxsryJy5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066320; c=relaxed/simple;
	bh=VniUahvMdktxwJ5guBg+topyv1D5cpGPzcqvyx29F7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4yQ4gK7yeiYlnv9Vb6+lz6ccDHVDlOXwWON7LeV/hMZnyGRifMSpbybP/i5a8YyeC1TYBVLmVg5N0VBITdHJHLP+F2gkZZ5vUGvSuVhM1qGOnuGHw/P5vD4pAbqO8TS+kVv20x0kESNeaYkBcnXO4ArNR6oIEGQoq2XXTiy0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8wA9tZP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5070831a12.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066318; x=1758671118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrVSbyRWgOvPZ5aXJf3Kvr/aSlms2vNDCGQo2Q0ic40=;
        b=N8wA9tZPIKdLj61At8ybjYDKrwLH5dZdXgpesAViBMjAyjPe2neDtE6KSjd9b/1VQp
         PX43iLClv8/CDPL8rJ9zjfh9F4OGykKUJLRr4WIfEazcFxSfrd1PJRh14oOzEXgwnH1I
         1jkNLxEtI3ygNZijzCLhKvKZa63BG3OFNHBvMvvCy5/YCeJqZ76nvkbI0PaWk2JTJWAr
         LFhKf+8aVqWORkw2tagyLNG9+cBMnf0dVax8JAHBRtzzphsRvZIq4Z3+3pHx+B/YtQbu
         3yM9BGFY3nxlDuF7HPhoNoo1Xp8Fueijtm1ixdOBqZ9PmUKPtG1QHlrvRmlRux9NjgWj
         v2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066318; x=1758671118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrVSbyRWgOvPZ5aXJf3Kvr/aSlms2vNDCGQo2Q0ic40=;
        b=b+fyCLj/iE70HgXvVRnZY9bWt8Cb/lwKLWABjtLxFuFXzc2ajNVo+97MTyIM9CUYNL
         myp4TFMzigZ8LsNOIt77K+8zMSQZZ3pwFiZhOzMssQLXKoYWg2NaCBUDLQ0UmhLFKCB5
         0WQ3rqFW9E+ghQc0ONSs9VF+0VwyBJDw4G83aDLOA3tiDFg5L9k9Ez30e8AIVmXID4vr
         IHp1phrlJ4Kpfm932oO+KTFg3UaYm405YRMIdUkaUKYI9ub8q0l7k6eDeHUuuyq/etak
         R7No9rU0tUAd4OKO4je7FdF+7sLYFKeAl3xoiU2XSWaVTiJIyvSsLpxrI3TPUoM3Wmo2
         u+Sg==
X-Gm-Message-State: AOJu0YzNZJc8zQp01Ud42QQqnTmihQ7VsjsEc/j0a7N/ArR+3p5VEhIx
	KDvqXIyimrcZXf5augTbOkIy/fJHecB01b9/7mVZ40gL1kejlSaSZCSRq6ZsBfwna8LlsoLlg18
	1jNtVdCqlXGJpoN35eYomfYel4EaEAGQ=
X-Gm-Gg: ASbGncs0uOmT6is66Sg8++hYma1vDjwIEfuGUQZoMnA9jLwB2L8iC0UbjTpjp+H7ZWe
	2DBLoAjXlyBSM3ouGww0YxrWboSos08hCrOsOBa1rXqM76yR20mhYECc98CgEDXHUeGDDooGBag
	smctdewm8lTH3AUZEZnmAh5p02UqQxwpK9Tdc4OhF8a5Vmb0fXJYMmC5mBzmso+zzqSVtAPQ6cU
	xUqhXd5TF5h4l1lzGgnbzI=
X-Google-Smtp-Source: AGHT+IHex/JqN0mVSkslsPPXl14v4OzHEhk4HcojdKMVeTCGVrzWM6n9qs8Cwx4xJafDhxxeI8885OcZUAvu+mPrLBg=
X-Received: by 2002:a17:90b:4fcf:b0:32e:43ae:e7e9 with SMTP id
 98e67ed59e1d1-32ee3f6329cmr192187a91.17.1758066317898; Tue, 16 Sep 2025
 16:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-7-leon.hwang@linux.dev>
In-Reply-To: <20250910162733.82534-7-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 16:44:50 -0700
X-Gm-Features: AS18NWCeC1FC0bu5_fddtER_XweP5q9MB7hM8vd-fRNkN4vKgHVXxkGWT4aBgwo
Message-ID: <CAEf4BzYfg8Xvukcnvja7U=AXoGr=8tZYbZWydo9MZjWhviY==Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 6/7] libbpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu maps
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
>  tools/lib/bpf/libbpf.c | 26 ++++++++++++++++++++------
>  tools/lib/bpf/libbpf.h | 21 ++++++++-------------
>  3 files changed, 36 insertions(+), 19 deletions(-)
>

LGTM, but see some wording nits below

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 7252150e7ad35..28acb15e982b3 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -286,6 +286,14 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int f=
d, void *in_batch,
>   *    Update spin_lock-ed map elements. This must be
>   *    specified if the map value contains a spinlock.
>   *
> + * **BPF_F_CPU**
> + *    As for percpu maps, update value on the specified CPU. And the cpu
> + *    info is embedded into the high 32 bits of **opts->elem_flags**.
> + *
> + * **BPF_F_ALL_CPUS**
> + *    As for percpu maps, update value across all CPUs. This flag cannot
> + *    be used with BPF_F_CPU at the same time.
> + *
>   * @param fd BPF map file descriptor
>   * @param keys pointer to an array of *count* keys
>   * @param values pointer to an array of *count* values
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fe4fc5438678c..3d60e7a713518 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10603,7 +10603,7 @@ bpf_object__find_map_fd_by_name(const struct bpf_=
object *obj, const char *name)
>  }
>
>  static int validate_map_op(const struct bpf_map *map, size_t key_sz,
> -                          size_t value_sz, bool check_value_sz)
> +                          size_t value_sz, bool check_value_sz, __u64 fl=
ags)
>  {
>         if (!map_is_created(map)) /* map is not yet created */
>                 return -ENOENT;
> @@ -10630,6 +10630,20 @@ static int validate_map_op(const struct bpf_map =
*map, size_t key_sz,
>                 int num_cpu =3D libbpf_num_possible_cpus();
>                 size_t elem_sz =3D roundup(map->def.value_size, 8);
>
> +               if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
> +                       if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPU=
S)) {
> +                               pr_warn("map '%s': can't use BPF_F_CPU an=
d BPF_F_ALL_CPUS at the same time\n",

"BPF_F_CPU and BPF_F_ALL_CPUS are mutually exclusive" ?

> +                                       map->name);
> +                               return -EINVAL;
> +                       }
> +                       if (value_sz !=3D elem_sz) {
> +                               pr_warn("map '%s': unexpected value size =
%zu provided for per-CPU map, expected %zu\n",
> +                                       map->name, value_sz, elem_sz);
> +                               return -EINVAL;
> +                       }
> +                       break;
> +               }
> +
>                 if (value_sz !=3D num_cpu * elem_sz) {
>                         pr_warn("map '%s': unexpected value size %zu prov=
ided for per-CPU map, expected %d * %zu =3D %zd\n",
>                                 map->name, value_sz, num_cpu, elem_sz, nu=
m_cpu * elem_sz);

[...]

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 2e91148d9b44d..f221dc5c6ba41 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1196,12 +1196,13 @@ LIBBPF_API struct bpf_map *bpf_map__inner_map(str=
uct bpf_map *map);
>   * @param key_sz size in bytes of key data, needs to match BPF map defin=
ition's **key_size**
>   * @param value pointer to memory in which looked up value will be store=
d
>   * @param value_sz size in byte of value data memory; it has to match BP=
F map
> - * definition's **value_size**. For per-CPU BPF maps value size has to b=
e
> - * a product of BPF map value size and number of possible CPUs in the sy=
stem
> - * (could be fetched with **libbpf_num_possible_cpus()**). Note also tha=
t for
> - * per-CPU values value size has to be aligned up to closest 8 bytes for
> - * alignment reasons, so expected size is: `round_up(value_size, 8)
> - * * libbpf_num_possible_cpus()`.
> + * definition's **value_size**. For per-CPU BPF maps, value size can be
> + * `round_up(value_size, 8)` if **BPF_F_CPU** or **BPF_F_ALL_CPUS** is

nit: if either BPF_F_CPU or BPF_F_ALL_CPUS

> + * specified in **flags**, otherwise a product of BPF map value size and=
 number
> + * of possible CPUs in the system (could be fetched with
> + * **libbpf_num_possible_cpus()**). Note else that for per-CPU values va=
lue

Note *also*? Is that what you were trying to say?


> + * size has to be aligned up to closest 8 bytes, so expected size is:
> + * `round_up(value_size, 8) * libbpf_num_possible_cpus()`.
>   * @flags extra flags passed to kernel for this operation
>   * @return 0, on success; negative error, otherwise
>   *
> @@ -1219,13 +1220,7 @@ LIBBPF_API int bpf_map__lookup_elem(const struct b=
pf_map *map,
>   * @param key pointer to memory containing bytes of the key
>   * @param key_sz size in bytes of key data, needs to match BPF map defin=
ition's **key_size**
>   * @param value pointer to memory containing bytes of the value
> - * @param value_sz size in byte of value data memory; it has to match BP=
F map
> - * definition's **value_size**. For per-CPU BPF maps value size has to b=
e
> - * a product of BPF map value size and number of possible CPUs in the sy=
stem
> - * (could be fetched with **libbpf_num_possible_cpus()**). Note also tha=
t for
> - * per-CPU values value size has to be aligned up to closest 8 bytes for
> - * alignment reasons, so expected size is: `round_up(value_size, 8)
> - * * libbpf_num_possible_cpus()`.
> + * @param value_sz refer to **bpf_map__lookup_elem**'s description.'
>   * @flags extra flags passed to kernel for this operation
>   * @return 0, on success; negative error, otherwise
>   *
> --
> 2.50.1
>


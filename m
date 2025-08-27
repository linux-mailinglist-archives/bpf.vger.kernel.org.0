Return-Path: <bpf+bounces-66746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74DB38F01
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 01:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C8C3BAC08
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA22F3601;
	Wed, 27 Aug 2025 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF+1El6+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E18D239E8B
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336706; cv=none; b=dNBizsHIP8QIgv1GkKCMFAcOoNeqakcafNliY+k4ZqmATu6Drmi4tEJ2JWt2ruoYtaTPpXaYpRoo7Ea2jusrMxeTcqPwO4Y6IBLmQZCpYmE8uy9jieD1OTiB/26H1KDyogzz80c4uLmxKGoe5KfNwjICebRc3muGRmqssMUqdWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336706; c=relaxed/simple;
	bh=dvXpYMsV9BQE6uoKwWoATS0uEpfT/AThy1UR2b697Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Spz5m2UB3ny/h847GyMpEIqGHD0hUJvOaD/Q2NwPiDWdkygcYyQhqi9UGM4U6PC0ZlT5L1O70cKCRUUCf7V5WEQrz6OP0970DSnN5/dxewjVs7ZklY7EY02m0yl8W64pTIf1WK+ZU/01E127PurjpqUO6+eEswCPkhn3sPHDLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF+1El6+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323266d6f57so421429a91.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756336704; x=1756941504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vWdwy9rcvVVgXUPJ4cMaNrEmeh52O2yvCMZNDXnEjw=;
        b=HF+1El6+9ZcZgUWoU705p7B3SgrXZs1mM36uGmIpWd2KMEeh6XsEZPxg+JcMBxenX9
         X4m3HxEfGeVdTYtIjwYPf6m3S9XEyq96NDxydcLLPuH3PG0vkE+B9ZHeEl8JaezY9qoi
         Wdhzl0lgYaEQiMa44xcVkPzIR5vzqyvBWVmi6dbVC+7pgaBaaymWvW/7tIIDETcu5AvV
         ofYzYvIUKrfJmxDd+deIGXRz3Z7/o9hD3NjLe3tkFexIrflhI7k7LkzHCjhcalH4fM8t
         f6Je4qbGs3oCEDRyF97TBDL8dYQlInDF6esytxlrVycICGkInPT39ATYKlPM1qhLNOMl
         1BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336704; x=1756941504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vWdwy9rcvVVgXUPJ4cMaNrEmeh52O2yvCMZNDXnEjw=;
        b=Bhk0fWx/PAwtTu7ZapD+H6VCqUS3zre2HpM7ERM0eqvmXKQiBc/1OYVU/d/ZUDDXSI
         Zu/GoUylVcwSlHfaMZV9Swskhr6w7yrz4wcEwUbMFl9153SKHs5cl4zaTagRNu9d9pvc
         BPvsk9Dg+LiZMBkUKKbKLExdOomTtr6meB4lw5VVMBs1jZWv5sDYGlLig9ahysj4IUcY
         CCtJyqAGYm8OIf3iy546SDjcrK65dRDaXMLPxQ1603Y4lWFVwNbBnCvnNyiwxo5P0dJF
         YizvGXw3SV9zUx83JDDtlUv4SGUUoXfx6qWpjaID5qQkUUfxxJZrGsacMpWpnA+vp0Ta
         Pm8Q==
X-Gm-Message-State: AOJu0YwY2PO3w3YOJ9XEsYRApmf9pjnHbfN6qe2wX0LE4/M19HArkN6m
	jthIPVZGr60BPa5Qv1g/ueRUAN7vBzC5+Zjo6JGkhoyjFuPI6wb5aBnIyZJksP/QZ6gIinAYpGG
	lvZFlifgMLsWLyFX4MvHlUtBaapDW3uw=
X-Gm-Gg: ASbGnctU2VeXI6/e3PTKFD9hcHnELXhWQBV8s06G7Oty7VBznYQ2WC6rikHyaYZMhqu
	gs48WgKaVghfk0IDA/7Kl9kmpuusVvslXTOnx0lvP5XnyPFMGgSLMexNNOGWgHlWCEdFijv3fFT
	YSagXr7/whTDFmTRVtMSxsuvGtjS6Zp4e04mZRzaBcF1mwN47qGR6bjzp3005vAtHw9Co/Gq6Xs
	7quLFGd6hbztTr/DGKW95o=
X-Google-Smtp-Source: AGHT+IEKX9r4HjTZdxKzIbVUpOVL+3uuOSNAyg2BWH7p9rRFVmgWskGluAokBtoTnz6TglRrRjbPNmqzWyfbO9J8uzE=
X-Received: by 2002:a17:90b:51c2:b0:325:e89:e59d with SMTP id
 98e67ed59e1d1-3251774c6d9mr30139183a91.23.1756336704244; Wed, 27 Aug 2025
 16:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827164509.7401-1-leon.hwang@linux.dev> <20250827164509.7401-5-leon.hwang@linux.dev>
In-Reply-To: <20250827164509.7401-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 16:18:05 -0700
X-Gm-Features: Ac12FXz55EMXXsjRhblJ0a09vk_Pa5mnsQfo_7mC1Z5xdpEiv0VRg2bKEXApPTo
Message-ID: <CAEf4BzaheSfrpwVXyk_f2iTVyTdN-ck65Viz31-ygLByiCV4YQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags for percpu_hash and lru_percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:45=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
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
>   APIs.
> * lookup value for specified CPU for both lookup_elem and lookup_batch
>   APIs.
>
> The BPF_F_CPU flag is passed via:
>
> * map_flags along with embedded cpu info.
> * elem_flags along with embedded cpu info.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h  |  4 +-
>  kernel/bpf/hashtab.c | 95 +++++++++++++++++++++++++++-----------------
>  kernel/bpf/syscall.c |  2 +-
>  3 files changed, 63 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index bc44b72129e59..c120b00448a13 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2745,7 +2745,7 @@ int map_set_for_each_callback_args(struct bpf_verif=
ier_env *env,
>                                    struct bpf_func_state *caller,
>                                    struct bpf_func_state *callee);
>
> -int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
> +int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u6=
4 flags);
>  int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
>                           u64 flags);
>  int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
> @@ -3763,6 +3763,8 @@ static inline bool bpf_map_supports_cpu_flags(enum =
bpf_map_type map_type)
>  {
>         switch (map_type) {
>         case BPF_MAP_TYPE_PERCPU_ARRAY:
> +       case BPF_MAP_TYPE_PERCPU_HASH:
> +       case BPF_MAP_TYPE_LRU_PERCPU_HASH:
>                 return true;
>         default:
>                 return false;
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 71f9931ac64cd..031a74c1b7fd7 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -937,24 +937,39 @@ static void free_htab_elem(struct bpf_htab *htab, s=
truct htab_elem *l)
>  }
>
>  static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
> -                           void *value, bool onallcpus)
> +                           void *value, bool onallcpus, u64 map_flags)
>  {
> +       int cpu =3D map_flags & BPF_F_CPU ? map_flags >> 32 : 0;
> +       int current_cpu =3D raw_smp_processor_id();
> +
>         if (!onallcpus) {
>                 /* copy true value_size bytes */
> -               copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
> +               copy_map_value(&htab->map, (map_flags & BPF_F_CPU) && cpu=
 !=3D current_cpu ?
> +                              per_cpu_ptr(pptr, cpu) : this_cpu_ptr(pptr=
), value);

FWIW, I still feel like this_cpu_ptr() micro-optimization is
unnecessary and is just a distraction. This code is called when
user-space updates/looks up per-CPU value, it's not a hot path by any
means where this_cpu_ptr() vs per_cpu_ptr() makes any measurable
difference

>         } else {
>                 u32 size =3D round_up(htab->map.value_size, 8);
> -               int off =3D 0, cpu;
> +               int off =3D 0;
> +
> +               if (map_flags & BPF_F_CPU) {
> +                       copy_map_value_long(&htab->map, cpu !=3D current_=
cpu ?
> +                                           per_cpu_ptr(pptr, cpu) : this=
_cpu_ptr(pptr), value);
> +                       return;
> +               }
>
>                 for_each_possible_cpu(cpu) {
>                         copy_map_value_long(&htab->map, per_cpu_ptr(pptr,=
 cpu), value + off);
> -                       off +=3D size;
> +                       /* same user-provided value is used if
> +                        * BPF_F_ALL_CPUS is specified, otherwise value i=
s
> +                        * an array of per-cpu values.
> +                        */
> +                       if (!(map_flags & BPF_F_ALL_CPUS))
> +                               off +=3D size;
>                 }
>         }

this couldn't have been replaced by bpf_percpu_copy_to_user?.. (and I
just want to emphasize how hard did you make it to review all this by
putting those bpf_percpu_copy_to_user and bpf_percpu_copy_from_user on
its own in patch #2, instead of having a proper refactoring patch...)


[...]


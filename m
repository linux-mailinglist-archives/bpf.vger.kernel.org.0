Return-Path: <bpf+bounces-70451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE3BBFB16
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 00:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 183D34E7735
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 22:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1461EB195;
	Mon,  6 Oct 2025 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuWm++eo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0A23CB
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789759; cv=none; b=Mz4SYlVST3CR0XUBHppD8thsitBKixbRPTxsyorLVxAWYy0o8gurssCoEr+W16818ZlgiiGsJ5x9omnRK3THHVE7J23vlJ4YHIrUEJysEWV69iLdpwK+PvN5iKCMtgKA5y9Nnnw7o2UJXPLPmVCpnkL7Zn3kDQH5e9j4su1hpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789759; c=relaxed/simple;
	bh=fm2OGDZ+kdVdpohDqIMPnUWkcc0FIQaiGv3S2lSnB9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwUh+ba16CLSC1t0dZ/mAEh533n6wpXbMjL8GjuNdiwAgfZLT25FuiF38jIXXg0hIj8L4bS1LC8IUUphhPkZhh7Ow0kAtV9i9ImX2GMFE8Qux3ico7swSSHQvj1hlt+bY9x5Fm/mOB606vQWXzEF3Obuu70pd6e6U37fe9M+u+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuWm++eo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4533374b3a.1
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 15:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759789757; x=1760394557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr8ezD90zFUGBJs2QLRphkUbr0aNamzYK7YdjTCeWDY=;
        b=NuWm++eoC+pSRSkCKiwjSbKqfi7B+dSLxX01/cGlzvjRvrEhh7Bk9XZp4jFMsUkv63
         pwsukU013jPJR3l9UWh0Wuyjq++vCb39hyZTF1xl8U1ZZDu98NCRajQXdbXfVp+2C5tT
         dCkp/lSEro8aXBQTr2ATUnOA9A6WFqKDFyaUzkNhBHUxntChz4vPugX+XDTU2LblDuVf
         hbnrfc0W/BRIK0SYyRVJdCjpbmMYmzPKcQ4sVtH/TmMefDo5UvOpNXvUTEwauNjop3Jq
         QSTBWtClU+3PFJiaDs1E7Q9yklpG/K7BCvv+npxmcEMhhj06tkWAE7mKRWf7b5F0toYk
         b9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789757; x=1760394557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qr8ezD90zFUGBJs2QLRphkUbr0aNamzYK7YdjTCeWDY=;
        b=rNBSKOuoSCv8jL+1V1QlAyWkWmU6v0cpSnH7M+wOy+B44k7GVj/8+bPXAcoC9y8h8g
         ikaFa3jsbVKKnvVejaRMPUUlFjk4v07PI76N+3/9Bya/bSo+Czt9ZkLc1KjvVR8rQ8BB
         DS/q8gFCDWnebGbi9ZFLIr8sB84sq93unNnrKmyYqoswFoBzF0/NeIUSqEtSINcsGU8w
         y9Xh72BBjNXUtiy2qSXUG1RxtsA+IJroTgLWNGIXw1qNw1GzChzRRe9wDd5eJi3At8et
         3M2kdwXm/0F0Ib/5HXc0WELO5ERDqR8xNlaHrqW6wNUYy0BZS+IaG21F6Ffqu3uyFxvZ
         huiw==
X-Gm-Message-State: AOJu0YwlKRIJDg6h4L7JeV9c39Sqic8cUSSVU2cPDZjpDo6g22/hnIW8
	3Fja63KzKk6FIxe6NwZJmfB3/VIqI/Pot6/ejm7Tqi112Fo633qH91uaxcaUSmwNQR52A3GaE2v
	W4WE00b17EIlPNyy0CSDw32E2sHLGLzw=
X-Gm-Gg: ASbGnctYPB++D26rTCPnMWaCX6pvNoDryotQlhOCcXzkGWbowH9fKmBFyuZX4kvnDRx
	XK6x3mSqkZ/iSjd4qHFvEJ4WWM91Ai6kTBwDEQ1PQ3aupNk0k+XBegr3De34eG6IB533fARFn7/
	1ha/weTFPwGGkhJmW+NoiEMeC7AF242RUQOw3J1VKumCBYsY0UGRcN+8xwEvtlmBXJiJ1xhdmIa
	04DJ+uY3KpZMBmw53eZZE0J7y6+6Hd8w1tqdufA45CL4Z0=
X-Google-Smtp-Source: AGHT+IFGC4ed6bzQkEzyx9E5Ncz9R9x/y7v2HQubFP2XS6fXyiK8MpgwoeWeGMiHjZ6UBjCkJlvpkH5abkZJcD2AT0c=
X-Received: by 2002:a05:6a20:394c:b0:2c2:f61b:5ffd with SMTP id
 adf61e73a8af0-32d96ddec37mr1474408637.10.1759789756936; Mon, 06 Oct 2025
 15:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930153942.41781-1-leon.hwang@linux.dev> <20250930153942.41781-5-leon.hwang@linux.dev>
In-Reply-To: <20250930153942.41781-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 15:29:02 -0700
X-Gm-Features: AS18NWCsDlb92AbYfWp6gU7nhXnYNYWERcp82m_7Vf_vIs49Itji1EljsnXTPTg
Message-ID: <CAEf4Bzb5Md09meboYPvdBUPZP3V2ET0AafbQFi89U8Wa3zVfGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:40=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
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
>  kernel/bpf/hashtab.c | 82 +++++++++++++++++++++++++++++---------------
>  kernel/bpf/syscall.c |  2 +-
>  3 files changed, 59 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 31498b445b447..b3d9a584f34e2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2717,7 +2717,7 @@ int map_set_for_each_callback_args(struct bpf_verif=
ier_env *env,
>                                    struct bpf_func_state *caller,
>                                    struct bpf_func_state *callee);
>
> -int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
> +int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u6=
4 flags);
>  int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u=
64 flags);
>  int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
>                            u64 flags);
> @@ -3772,6 +3772,8 @@ static inline bool bpf_map_supports_cpu_flags(enum =
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
> index c2fcd0cd51e51..6fb28ba2406c4 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -945,24 +945,32 @@ static void free_htab_elem(struct bpf_htab *htab, s=
truct htab_elem *l)
>  }
>
>  static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
> -                           void *value, bool onallcpus)
> +                           void *value, bool onallcpus, u64 map_flags)
>  {
>         if (!onallcpus) {
>                 /* copy true value_size bytes */
>                 copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
>         } else {
> -               u32 size =3D round_up(htab->map.value_size, 8);
> -               int off =3D 0, cpu;
> +               u32 size =3D (map_flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) ?
> +                       htab->map.value_size : round_up(htab->map.value_s=
ize, 8);
> +               void *ptr;
> +               int cpu;
> +
> +               if (map_flags & BPF_F_CPU) {
> +                       cpu =3D map_flags >> 32;
> +                       memcpy(per_cpu_ptr(pptr, cpu), value, size);
> +                       return;
> +               }
>
>                 for_each_possible_cpu(cpu) {
> -                       copy_map_value_long(&htab->map, per_cpu_ptr(pptr,=
 cpu), value + off);
> -                       off +=3D size;
> +                       ptr =3D (map_flags & BPF_F_ALL_CPUS) ? value : va=
lue + size * cpu;
> +                       memcpy(per_cpu_ptr(pptr, cpu), ptr, size);

ok, so you fixed the value_size problem and at the same time
introduced blind memcpy() problem?.. Per-CPU maps are allowed to have
some special fields (see BPF_REFCOUNT and BPF_KPTR_* checks in
map_check_btf()), which have to be handled specially inside
copy_map_value[_long](), we cannot just memcpy() blindly

all the other places use copy_map_value[_long](), why did you decide
to switch to memcpy here?

pw-bot: cr

>                 }
>         }
>  }
>

[...]


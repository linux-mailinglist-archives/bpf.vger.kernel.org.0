Return-Path: <bpf+bounces-65221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3612FB1DC60
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10AC3B3C8E
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08A526656F;
	Thu,  7 Aug 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9mzTMAM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3533208
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587239; cv=none; b=cQu8iu5l+XZdoi7rjZKIiEBqvABH/st/Ba/tjRq435Hvt9tPsrih8Da4l7YLoUCYFkv5X+ir0ZVauO3SVLgt5Qioirt030YFu7UHdJMKuoLJtVlQYTMvf+mSYPSqFmoBwSyBu8IU1IFOCO/f6F1jyGW/wz0ujDkuoeJQOBvWLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587239; c=relaxed/simple;
	bh=pul/qZfzpGcmPXy8T2jFD05YNGx6E1CjiTABbhn+TwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nwps52gPcBSIAb32c7oPnu5wo7l2kutFPGj8cc9l+AJx9bQd4xr0YvNVOUddlohRSTpk3ckfk9I5aEy5Hin8rgFl32XPK7nKk0/Iu5F4UDnYorD1ALDZ844BlFowhqECK/6O5bIEDZ5Oa92EMV6PeXSCuMvi1bLh7CQ/VwMnI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9mzTMAM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b783d851e6so1078065f8f.0
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 10:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754587235; x=1755192035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr8uFrlDKDGq3EowuOTZke3ijneQpOh/y+YAjT0MaH4=;
        b=Q9mzTMAM5z0RkwdR9tQpZN4zQzMOgUarAkSFY0EkdSk4RuzZRsQA/qrVwLb406c4g5
         MrqUmAlNP0DW9Wqyqus3X8hURarVYkQJRUPqA4HNOD+zLCY0D6uHGZKiG0OKLGzti1Wo
         Y6mSsyPExyiqoExk1lU+fz5c7y1LTquewUPswvKBKPtZxElkY2ONs853ZAlT9Kz2whUN
         f5r0NDNtkDO6RAVXNK+FOGosiVubslXPPGIV2F7og/oxxDKWQb94fa+SG1mdJqUjMbZA
         YEUkTeUoZn8iqYcQwqLJ8vZeqYO+LdFJSbpiW8Q79a9cZ2LePGU3Z96g86aX1L9ElM0m
         vhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587235; x=1755192035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr8uFrlDKDGq3EowuOTZke3ijneQpOh/y+YAjT0MaH4=;
        b=vEYqXYeqR4YnvQE2n5rJkObrWGKsMQKFDH3nsBb5XwnSeDQ2HOO1tQgN/3iogAC/xm
         iO8KMx6ogzKvowZc3lE4YAblonDPle6EVTomqHOW6B8UohuK4SCCRAygwBldTnphZPbX
         J4YpUXOBL8vrfnqwbg3b1cwWZDH67aktBKmYWyzqrEVu8xNBbGsb5mZpfTeM57yVo2ZL
         8QK/bjzDRB6P1xwfFqEyE9kL8RvWOT93xYlJC0WlFJz8N+woANLNon4c6j5OwX1thN/f
         3hN/dClq7o9jfE4WIYNQeN7TutloY77VAGvcO+V+8sdk9yJTag0g/dx5EGTPo9lmak8x
         SO+A==
X-Gm-Message-State: AOJu0YxT0CwUIIU8dRTjZX1YCKLgI3aRapEQnjZiCPxWKDydg/qiIFMz
	JL7avdrjeZspn5SDKxGx/18M2ROcvP2xKGL6Kxe96TCTcygR5C/UZHN+iK6yMQKi7DdGCxdp0hp
	Tr4qYbmrDxRp0VBRnuiu5BJBMI3lTc5U=
X-Gm-Gg: ASbGncspIeUDV3AHhJcMWA/VkKBuxzyIThxDjqDDDYOKKc17ArGjP+djrtTTrB2ihsS
	rhawqaFLUx29I48AL7CqOAfRvgpdI3DzN0bKk178nz67+Fg67I2f/vPZSWMQT+GYUhS9IGbPVr0
	g/sLpojInBx8DtrDhbu+wgtgNguQa0t7I2N7EzBwU4IekXf3we6rjL8W5dOUeEpL42zpL8Td78u
	dP0G1l58K1ocyY6WzC7Z9NwTMyw/q0X7w==
X-Google-Smtp-Source: AGHT+IEBPUqxPQHrZrDCUrrmCfWkmXnfcqQU12YSNsF5NSHgt/VLEe+p95xwvc6HYr1DQI05Kcbc+TX4Sk8stGtfwWE=
X-Received: by 2002:a05:6000:2502:b0:3a6:f2d7:e22b with SMTP id
 ffacd0b85a97d-3b900b4f08fmr39661f8f.18.1754587234645; Thu, 07 Aug 2025
 10:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805163017.17015-1-leon.hwang@linux.dev> <20250805163017.17015-2-leon.hwang@linux.dev>
In-Reply-To: <20250805163017.17015-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Aug 2025 10:20:20 -0700
X-Gm-Features: Ac12FXwAF5nhQdeo2zSzCJTKP7y1Q1e8VhD3njF8WanrD5-pK9S7I71Hqp7ujoE
Message-ID: <CAADnVQ+Mkmy+9WnepShLsQtMWceFUpfsV-Tw=dMaXP-B15R2yQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 9:30=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> Introduce support for the BPF_F_CPU flag in percpu_array maps to allow
> updating values for specified CPU or for all CPUs with a single value.
>
> This enhancement enables:
>
> * Efficient update of all CPUs using a single value when cpu =3D=3D (u32)=
~0.
> * Targeted update or lookup for a specified CPU otherwise.
>
> The flag is passed via:
>
> * map_flags in bpf_percpu_array_update() along with embedded cpu field.
> * elem_flags in generic_map_update_batch() along with embedded cpu field.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h            |  3 +-
>  include/uapi/linux/bpf.h       |  6 +++
>  kernel/bpf/arraymap.c          | 54 ++++++++++++++++++------
>  kernel/bpf/syscall.c           | 77 +++++++++++++++++++++-------------
>  tools/include/uapi/linux/bpf.h |  6 +++
>  5 files changed, 103 insertions(+), 43 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cc700925b802f..c17c45f797ed9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2691,7 +2691,8 @@ int map_set_for_each_callback_args(struct bpf_verif=
ier_env *env,
>                                    struct bpf_func_state *callee);
>
>  int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
> +                         u64 flags);
>  int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
>                            u64 flags);
>  int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 233de8677382e..67bc35e4d6a8d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1372,6 +1372,12 @@ enum {
>         BPF_NOEXIST     =3D 1, /* create new element if it didn't exist *=
/
>         BPF_EXIST       =3D 2, /* update existing element */
>         BPF_F_LOCK      =3D 4, /* spin_lock-ed map_lookup/map_update */
> +       BPF_F_CPU       =3D 8, /* map_update for percpu_array */

only percpu_array?!
Aren't you doing it for percpu_hash too?

The comment should also say that upper 32-bit of flags is a cpu number.

> +};
> +
> +enum {
> +       /* indicate updating value across all CPUs for percpu maps. */
> +       BPF_ALL_CPUS    =3D (__u32)~0,
>  };

The name is inconsistent with BPF_F_ that was adopted long ago.

Also looking at the implementation that ~0 looks too magical.
imo it's cleaner to add another BPF_F_ALL_CPUS flag.
BPF_F_CPU =3D 8 and upper 32-bit select a cpu.
BPF_F_ALL_CPUS =3D 16 -> all cpus.


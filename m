Return-Path: <bpf+bounces-68587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EF3B7E50E
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4984B582F39
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0292C0F8F;
	Tue, 16 Sep 2025 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q75Jd08+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD402F3627
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066315; cv=none; b=ujQI+6Oozjz0jJSguMDLr0V10oFEtO3KR3RKx/Bh5Tw7h/ekPWN8jbt2uyBfBFj1fyfmAnhZ9IKcC89svP0TMiSctwsrf3GlC3BeUOD1r2a4+rvQ/Zf1VShietsSPSbwmvUHt49/EuweGyUa88gflcxaRiO4QO6AoXDWHPtD1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066315; c=relaxed/simple;
	bh=pE7zS3kx95WjZ6rnVEtQgepsmGAUX+JMFyVuTWtdOkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTX8tkPO9BI/BL9ET136oozJRab5TtadbBLiV4OEg+26uBs0f0qlpYgd8o+12i5a8ikCqSF9UVFZm/byRBNa4hEroddTENQ/DumJOhyMgM6iMLvBEyg9ca1uO9SvZi83EfYFiRPpYB1n+1pMzVZ/ImCkX9StYXL2dSi8QVvFIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q75Jd08+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b523fb676efso4416440a12.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066313; x=1758671113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1HAIF7JzKqDlGdBULaX8baKf9JCju1OiBocB0sBsuY=;
        b=Q75Jd08+KAsFTbUeaX1Z/foQuTlwzpMVqHIYi8YSMprH8Vdbk1BmIsGSaljAK8Gm/D
         ylteJ8QLEF1T4Zm1AQfo3wdlu1dlKizIRykAj1yKVOw/6L9zvHeVQ2OqA1Lkwk+azBzs
         c+OS8j1G8MuNIY3V1D6ODG/Tlb8b89SHlOM4AnaBL+0hmze+Dg7RaQsZ8NXlti2KkZZs
         dxcWcMx2szh2yIksLEFLfBcmLKJl5QqaNwiOz0oSDm459vOayIeGdNhHkqds6Ge9b0Hn
         fVDDAzDqc0qkRE1A8BpD5ywQlGEIbZK8700eY0mzIWZDLYdP9rkNXaRb0Es1L57Efv3c
         B1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066313; x=1758671113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1HAIF7JzKqDlGdBULaX8baKf9JCju1OiBocB0sBsuY=;
        b=PuUC8bMAMgmBxYeXUbCpD1fu+WMYjabx1aLK3VydpHAoTPe56sh2aisG+dHduNTJdo
         H8sSHM4nkgk1WrOnHw7RZuTM+XvI5STtrWVqLFU/+Ch7WM9WpSbtOVuo0plvceiCco+I
         zkKL2AUblrFP+9LewQqJJXP4txN4tdYtk4R6+mvExJzCx883WWmpOLJWvL26k3XRvgxx
         rrMeacYjzIaQRWCc1qOlClrp9enZRj1P5YpRJct2CM8KCtnx0feobFb2/do96WUkInjr
         2yg41hzxUoP/ERdSB0Xh63qyBRDaY+2LzP6YxNRZbYsEPX7Z4R0Ab5a4y2qoHSE6fDLQ
         +aNw==
X-Gm-Message-State: AOJu0YwimGz6Kopjrc+n63VLLWExBDI8Ep7fBMQZFh97FkKgOOZm3fOc
	wUm2gbeyb9dC4fobkk849nGI3kEGzeEJ+t2INLdvk/Or0yTVV+whNtXfG4VKVjB5afX5UXJ/k9U
	jQ8uFD++gE6I5oEbbJM4sb3Z42BTZkrQ=
X-Gm-Gg: ASbGncvHXIs8gvzUPRavth5NSQuwgCRY1sPm7zyesegx0OXjCqxgsev6Ek20sUqYV0h
	Iw7kJYFxw1ENMsw5ufzIi9h12Mbml/Hzm0NiVw31dq7kMFj2TfnDHOq+LtCYbBE4Htzr5Mn2aPL
	eAcpWZKhYU6tsWgysCm9Q9DuM5uU3a6SRoHsu1LMZJxeRZYpWPlSn/Gd0PVaxVhvLLj7CBuW9wE
	wHkxAyxwLdzXf+DbDqg67LqZ5vFvrv6Og==
X-Google-Smtp-Source: AGHT+IH6XepLTIQvlWy+j7EcygvA8IaL1EUCLs5vcNXfqvPn1Ga4L7/tozZH6DMojmnga8+8TBhXX+uJ4TDEl7aR/eg=
X-Received: by 2002:a17:902:f645:b0:24e:e5c9:ed13 with SMTP id
 d9443c01a7336-26813903d86mr741885ad.47.1758066313372; Tue, 16 Sep 2025
 16:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-6-leon.hwang@linux.dev>
In-Reply-To: <20250910162733.82534-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 16:44:47 -0700
X-Gm-Features: AS18NWA4gOX9yarg3J6Ohm0hI-egpQCACuWsG17M8-p3Kx8qfr1phhbtIVE6ltI
Message-ID: <CAEf4BzaknkgAFfxA5WorX-2kZa=MHCB=MNXBvf6tDvQOb36o0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_cgroup_storage maps
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
> Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps to
> allow updating values for all CPUs with a single value for update_elem
> API.
>
> Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to
> allow:
>
> * update value for specified CPU for update_elem API.
> * lookup value for specified CPU for lookup_elem API.
>
> The BPF_F_CPU flag is passed via map_flags along with embedded cpu info.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf-cgroup.h |  4 ++--
>  include/linux/bpf.h        |  1 +
>  kernel/bpf/local_storage.c | 22 +++++++++++++++++++---
>  kernel/bpf/syscall.c       |  2 +-
>  4 files changed, 23 insertions(+), 6 deletions(-)
>

[...]

> @@ -216,7 +222,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *=
_map, void *key,
>         int cpu, off =3D 0;
>         u32 size;
>
> -       if (map_flags !=3D BPF_ANY && map_flags !=3D BPF_EXIST)
> +       if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_AL=
L_CPUS))
>                 return -EINVAL;

shouldn't bpf_map_check_op_flags() be used here to validate cpu number
and BPF_F_CPU and BPF_F_ALL_CPUS exclusivity?..

[...]


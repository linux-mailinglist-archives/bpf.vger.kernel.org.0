Return-Path: <bpf+bounces-21192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DCD849287
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 03:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A5C282B6B
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 02:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359CE79E4;
	Mon,  5 Feb 2024 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmaX184+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437AFAD27
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707101693; cv=none; b=TuUxenh1Qm59FMGxxmQCZfwNPZROjujDk9nFuZGrXaeW78OP3V5b9bknztLidzYtwKYCptE8nlj/Zp8a1dHGPAmxr5jw/iOBZ0ksID14+ygyN8XzdJnH6zhVreJkLMxLPYl/VsLwfZCsOAswRgqygZRpBWFiY7zEZJJV6BlD/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707101693; c=relaxed/simple;
	bh=DaNdSluC3/CNwmougVqoW5prXHaewk7vOQODVIpvp3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+ZxEF7nyEuwbTY6OngiTZMfUBGRvV/5Id4C3oV6rJFy0ZEAoLyc77dYT7FGc13COcDxgaU3YX9/tT5rcKIv+s358ZthJ4xf53CQYlODXqPq7NeHniZupKyVg0Qpq8cZuIfcFY1PM4bgktszc8hK4y8AVWYzc51GN/aP2UE7Ago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmaX184+; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d2e15193bbso2047459241.0
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 18:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707101691; x=1707706491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4BV28F7ukuGZM3OCXtLEcxS37TGffoGwXhgy7gsOok=;
        b=cmaX184+0x6kVk6UVBjTXYtf7EmTOkpQPDtAsX1sSUI7URX4pv2uufr7A8MsfcSPk6
         u4aZdAL3EgQTQlUb3B4Kb+EAbfeUcCdoSbiYse79PD7vk/xTYSPdCO9EhOshL6yWJoPS
         9SxMMUvW2xJpkl5omxalz5dcdLcUK21J+hR8aVGRJn4eVraqjvPnKjcaQc/vwBwIkMMh
         0ICDE/dRcJeQdhM3IMUPdZZxe4eBzV9i9tEOXaAshYrUw4iLskqDIElQ1KKsTobkoDmK
         QJFuhlygQJeVOQ7kT9BP7h0HdvRQMOHLhABNOvMcuA+ksY4ho9dozWeytSQ4mHg34u+n
         KuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707101691; x=1707706491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4BV28F7ukuGZM3OCXtLEcxS37TGffoGwXhgy7gsOok=;
        b=WTRlQQ9OV0rIuEEqpXZl6/R1WedTNZPD9OeWRCG9haK+yok6+SCh7aqm3zGRV+yWHS
         6kh542f/4pG5b1DqLbCvcmXncEXgJ3cmqqqH0/89/pVlMi8iKQSBwhKeum88W7WlPx0G
         bz6uePAicp0/X6C2DCtwFR19MS8hBNFoFRYCxJZ+Y6EjLsqJ+KU5HnJdUJHLHe4LQpO/
         BUBFZ1A2LXh//k1jhmXUGrwkqKlhs33GAYYOfreOyrVtYNqYv2ATBJXz7LmO8Pv8bvgO
         0r/u8tuELDacCAOPRbyCQL0qJ50qUehWM5+ufDYGB6rKUgGLhXnQgMAdZwXfOecrjfju
         Ut3Q==
X-Gm-Message-State: AOJu0Yzz1w5mlAYmaEVIEXEmjRSO8ShnVbnPFj2H3WmzxXZkq1Ie1w60
	4HMzypuO+HeQ5dPcha1a+uOsWgzfmN7+L2+RUOOmOGmXKGsHrkgWBqJib7pqGGCfvybCTf7kBsZ
	Ttrfx8UUsdCfFMWyQEInAFigf+Uo=
X-Google-Smtp-Source: AGHT+IES+lJw85uhTb6uRXJjyXbpwfS2CX+ggSYY81hQIhtRdbNFwfNlt/X7c1qml+bHm06cDSdbhCPU9TVx4ub1hws=
X-Received: by 2002:a67:f645:0:b0:46d:2339:e7c0 with SMTP id
 u5-20020a67f645000000b0046d2339e7c0mr2961990vso.16.1707101691052; Sun, 04 Feb
 2024 18:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204230231.1013964-1-memxor@gmail.com> <20240204230231.1013964-3-memxor@gmail.com>
In-Reply-To: <20240204230231.1013964-3-memxor@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 5 Feb 2024 10:54:15 +0800
Message-ID: <CALOAHbA8_yo_6md13Aye4XW4q3Rp+WpK-VqgWiEA4fKW=rtQ4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for RCU lock
 transfer between subprogs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 7:02=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Add selftests covering the following cases:
> - A static subprog called from within a RCU read section works
> - A static subprog taking an RCU read lock which is released in caller wo=
rks
> - A static subprog releasing the caller's RCU read lock works

Given the global subprog is not allowed,  we'd better add failure
cases for a global subprog.

>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/rcu_read_lock.c  |  3 +
>  .../selftests/bpf/progs/rcu_read_lock.c       | 64 +++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/too=
ls/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> index 3f1f58d3a729..328a25e031d8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> @@ -29,6 +29,9 @@ static void test_success(void)
>         bpf_program__set_autoload(skel->progs.non_sleepable_1, true);
>         bpf_program__set_autoload(skel->progs.non_sleepable_2, true);
>         bpf_program__set_autoload(skel->progs.task_trusted_non_rcuptr, tr=
ue);
> +       bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog, true=
);
> +       bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog_lock,=
 true);
> +       bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog_unloc=
k, true);
>         err =3D rcu_read_lock__load(skel);
>         if (!ASSERT_OK(err, "skel_load"))
>                 goto out;
> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
> index 14fb01437fb8..687df026feb0 100644
> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> @@ -319,3 +319,67 @@ int cross_rcu_region(void *ctx)
>         bpf_rcu_read_unlock();
>         return 0;
>  }
> +
> +__noinline
> +static int static_subprog(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       if (bpf_get_prandom_u32())
> +               return ret + 42;
> +       return ret + bpf_get_prandom_u32();
> +}
> +
> +__noinline
> +static int static_subprog_lock(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       bpf_rcu_read_lock();
> +       if (bpf_get_prandom_u32())
> +               return ret + 42;
> +       return ret + bpf_get_prandom_u32();
> +}
> +
> +__noinline
> +static int static_subprog_unlock(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       bpf_rcu_read_unlock();
> +       if (bpf_get_prandom_u32())
> +               return ret + 42;
> +       return ret + bpf_get_prandom_u32();
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int rcu_read_lock_subprog(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       bpf_rcu_read_lock();
> +       if (bpf_get_prandom_u32())
> +               ret +=3D static_subprog(ctx);
> +       bpf_rcu_read_unlock();
> +       return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int rcu_read_lock_subprog_lock(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       ret +=3D static_subprog_lock(ctx);
> +       bpf_rcu_read_unlock();
> +       return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int rcu_read_lock_subprog_unlock(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       bpf_rcu_read_lock();
> +       ret +=3D static_subprog_unlock(ctx);
> +       return 0;
> +}
> --
> 2.40.1
>
>


--=20
Regards
Yafang


Return-Path: <bpf+bounces-62004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6394BAF04B9
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F407B12DF
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324AA2EE26B;
	Tue,  1 Jul 2025 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uqrxerde"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B802E8E11
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401346; cv=none; b=LQz58aKmq3emREU5HIa0sGF7ZHBDRsC7yF2zoRqHWddZD4JCCQ+hJkixAi1BVvzVCFCuUtKvZNkFQesC6e7mKdYHzup4o8A34oqFfrXo3mszch7/mPytmdszs2QLXjm/90OqBUAZOrza8bVrh0l3KNtBd/YKngiIwwcZ4JLCj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401346; c=relaxed/simple;
	bh=mPuyesa9YhyZF/rd4A2w+rfE1pV1AoEgT8SCbzuGoBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoqUknOVrQ+i259xkg0PUTZOKKueSlwGpuH4fRHUJ3/2pDRNL6PBsMj2suIyT/EJggBvkdFL/ViABZdxCk9QumO1f+sB4ZmhWNMZUhh+uIDB5m6VoSAVwTKVqX+0ewlaZ5E8bIKXm41JH3CYTrMZ2LI3mD8fSo1Xvj4LvSzpyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uqrxerde; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso2709581a91.2
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751401344; x=1752006144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0atNKYqTPWuJ47k+SqLNeniYUs/D8WGass85mgtF54=;
        b=UqrxerdelN2PpTj6IuGU/2yV+7muHBHxsodUzyxIH5+KSanhgScfHAsocfOP1OPAYr
         oF0op3+wAKWUo8f7eXinnQ2PIBymSLGKBXeZ/F+ssudCNKTV5L+sC3uNC9baTLTS18H9
         SJJgQzA1T8+dDO3+AaLnoCAITVFA0tZ7p2ZGFmDrFGjN9Mhur7WttR/b8mHtV+YeBm9X
         I162eZzVFf3ESSy54QeYLh3xP3+pjV3ezi1GknQ7q8x7ZxVisXA7bf4T0oQH57L3ZLFy
         dMqnDjQSu6G4yfiJGKGvSndUjLGHhJG/hbGHEZ9OoVr2UdCE69tUecndjjbq2RmehHK+
         L4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751401344; x=1752006144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0atNKYqTPWuJ47k+SqLNeniYUs/D8WGass85mgtF54=;
        b=Ix8eZFKda+gX9tN6X/Eort4akx76yHcYZlR9G2JSBdM6/RiiiiQytgTv7Xt5uXnuGZ
         NP3ebmVR6FQTmunM8Z5y+7xsUnfttbpBfQCPHbof4KLY7qGXt6nItucBRhGFDs1le+kt
         sFm47etEqdXIT75KDvOe+6J8KckxUJ77TbWzxp2zZkgZoEAlWDOWARffd4LCfS7FrS1f
         /kOgbqomPUutTVxIu963G3bQm37HI2mjx136hWYL+kXLoIoO5u2bbvwfXW7FkT4ZTh0i
         ixrqBNUzj9lb+fPVfNYKf2iYbFXPlImr4No8aCCcmEbCe8wcz37q26pc7XiqEpj2uKpx
         NJgA==
X-Gm-Message-State: AOJu0Yxb3xeae4csimKpzqX553agFr0Suv3LBXuX7xN/SJ8NG/7JSwxy
	lvZ/wpQ8sNrNQxgX0Upds677tw/GeRO2nJiBvX1XRz1Sr+UxS/+8K7BDQdz6YQm0Xk2jrQnaYXX
	DrGt7HJIpEwIgoILnl3qH5GtN3zvynd8=
X-Gm-Gg: ASbGncsM2niHaDgJPJXCquZtA4V1ClSOtCdNNjEn16lbjI8pJdklMUN5fgFtWUZ55zd
	0JHWvBxmChvrAPmkGgh9Tn6dBiRn3z7bUtY2FsSX6iOhCIWdaMAMxlcpipTlb3ZjZ2wNQ0K9jcr
	WYxK1vce4y8uMT3bSbTBXJ4Av+aSx6tcRfx4K6wvkHHJn96OA1TAnGvPKYJ6c=
X-Google-Smtp-Source: AGHT+IGCI1Wr93R5luPutODMqE7KmRJfMkukTcTfIIfWmadXoUc81ubJu85ttkFzvfLv0qaGL3uEVPuRjiAIzIXoadk=
X-Received: by 2002:a17:90b:5788:b0:312:e91c:e340 with SMTP id
 98e67ed59e1d1-31a90c2f8f3mr485609a91.35.1751401344543; Tue, 01 Jul 2025
 13:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624165354.27184-1-leon.hwang@linux.dev> <20250624165354.27184-4-leon.hwang@linux.dev>
In-Reply-To: <20250624165354.27184-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Jul 2025 13:22:09 -0700
X-Gm-Features: Ac12FXw-zCnTlFQFYRGUJozvYULRAmdil0INRerDgTRa095Db2E5cQ-Eb9eg_ow
Message-ID: <CAEf4BzYkqPO-cGVv7FomXZinSYNE5q78+dRoiVZAtWaJ4MNJNg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: Add case to test BPF_F_CPU
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 9:55=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch adds test coverage for the new BPF_F_CPU flag support in
> percpu_array maps. The following APIs are exercised:
>
> * bpf_map_update_batch()
> * bpf_map_lookup_batch()
> * bpf_map_update_elem_opts()
> * bpf_map__update_elem_opts()
> * bpf_map_lookup_elem_opts()
> * bpf_map__lookup_elem_opts()
>
> cd tools/testing/selftests/bpf/
> ./test_progs -t percpu_alloc/cpu_flag_tests
> 251/5   percpu_alloc/cpu_flag_tests:OK
> 251     percpu_alloc:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/percpu_alloc.c   | 169 ++++++++++++++++++
>  .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
>  2 files changed, 193 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
> index 343da65864d6..5727f4601b49 100644
> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> @@ -3,6 +3,7 @@
>  #include "percpu_alloc_array.skel.h"
>  #include "percpu_alloc_cgrp_local_storage.skel.h"
>  #include "percpu_alloc_fail.skel.h"
> +#include "percpu_array_flag.skel.h"
>
>  static void test_array(void)
>  {
> @@ -115,6 +116,172 @@ static void test_failure(void) {
>         RUN_TESTS(percpu_alloc_fail);
>  }
>
> +static void test_cpu_flag(void)
> +{
> +       int map_fd, *keys =3D NULL, value_size, cpu, i, j, nr_cpus, err;
> +       size_t key_sz =3D sizeof(int), value_sz =3D sizeof(u64);
> +       struct percpu_array_flag *skel;
> +       u64 batch =3D 0, *values =3D NULL;
> +       const u64 value =3D 0xDEADC0DE;
> +       u32 count, max_entries;
> +       struct bpf_map *map;
> +       DECLARE_LIBBPF_OPTS(bpf_map_lookup_elem_opts, lookup_opts,
> +                           .flags =3D BPF_F_CPU,
> +                           .cpu =3D 0,
> +       );

use shorter LIBBPF_OPTS macro, please

> +       DECLARE_LIBBPF_OPTS(bpf_map_update_elem_opts, update_opts,
> +                           .flags =3D BPF_F_CPU,
> +                           .cpu =3D 0,
> +       );
> +       DECLARE_LIBBPF_OPTS(bpf_map_batch_opts, batch_opts,
> +                           .elem_flags =3D BPF_F_CPU,
> +                           .flags =3D 0,
> +       );
> +

[...]


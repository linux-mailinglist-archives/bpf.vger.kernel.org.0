Return-Path: <bpf+bounces-63080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E2B0235D
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F06A1C22957
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 18:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0812F2359;
	Fri, 11 Jul 2025 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0EoCzS8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC92F1FF5
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257480; cv=none; b=XMlW2IUdSodU9tBhqHeg+wWN+aU/kWd+S7rfnJWHA3q/QznIRXCfNxA6FIaX4/laYI13VcfQzydS6Mk92PEDkGZwKZmasXzxKAr6z5cUysDhYP7b862yYBuajJYWe+pO2RDMM2xepoZYv2OMVff3CsGCtjdikC1Bvcn3NL+5tcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257480; c=relaxed/simple;
	bh=k09v2TeKgs9sMcVSlOlRdUPhAW/IJBRR812sLaG9PKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMTS1g7wBrnR8blEv05tAgAMzFcsUMjuRgdcn8PLRKf1QQdiRc1jVzUhPp+KW/bUuMWTp1Z2o4tXgfiHsBtXYj3bzH3Puxsdd9xnpLp3z/HWd9ovVLSuCV1CCtO5NGLop8/S4wu/03pIzOhyq6DPfJa9C1aTlOAzLxAFEUVkx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0EoCzS8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso2880236a12.0
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752257478; x=1752862278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8N1oIQvNUXaewTXGfRb8DOMKJJ/rQalxoeJ+M31C1A=;
        b=Y0EoCzS8s5k0F6PqrTWCWPbCYB7Hz8NUt7sOVY+80nfP9rh3uRVZbiJvdccbicVNFF
         mgeEUv+WYbF5lbuZJOadeyCJutQATZ/OydwkTjluZDM2/wDOeeINQHXRzj6/HMXlz/kf
         73JX6hmdxvFjk1UefcU1ShNWpGl7oK3hxOOg0BSQw6JpSAkKtQTGRkHR6QpUlN4gGy5V
         iVvherfGetEib33+w28A/ChnJFcTQ+qlaJePhX6WRdUjIHj6Exp4IGae2UpjMlO0B64G
         XDLvs1zw3Q+Lpfyb04IO1B5alKgXOCZ22idO1Wo+VFk5MRs++4+WhUEOVSa8BvuvKABk
         PTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257478; x=1752862278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8N1oIQvNUXaewTXGfRb8DOMKJJ/rQalxoeJ+M31C1A=;
        b=xHz3o3vpQljVtRtgjYQFah8U8QWIBvdnLBDAZa0Wo6yVpDktGQLNgF2RTeYoqwhRWG
         rjJWxR/j4ryPOeCCHd2dnW9HyWRfvmBL/zI4gZwACpx4kJtv450kPlZXFwAAoIEevLch
         NtaaCJLkd4r/JlXGPQBasy/GHEDjU9EL2mgFoLVRCRSyFAQ8IvwdQnaF98lypLqq+wod
         hPaPCGAym01PAWcb7EfLwGDRZIzC3a4sHjzrWTmfvyKY5SIlJdRalTqZXnuLBUSoZ+k/
         rELuWAcC86HqjZp8emtUDkpzBj5hDgFcRqaEfGSvk8uu2vd7Yepqh5GSt/ehiVMYf7Ai
         dMSQ==
X-Gm-Message-State: AOJu0Yx1FHvKezYAFMkH+0rsP8MBnpaOuvxf9JOI/sT/5AHrkjD/IhY1
	+8ScWnuh77pbww4oqDtLvBRRhgnfGJANPesOaNsFu3ZcLCv6UyutwlKL7YfZM4T/uXmGSMDzktk
	chjIacucA7FmV4buBs3XO3VdU5gDrM7E=
X-Gm-Gg: ASbGncsFSu6LKWd69aQGIG3bz493p51uP4C9v3+B/Lqp8ma7+v49NU+WoBiqTOtWhEr
	HLCRJSiy5LnuVyG4xvFGSUpKk+wate7440cr5+Bk0fwyFQdd10SR0JMi8Ie9JA4lfSZQmu1/FF+
	0YuBgTgmm4Q6UL0O4yhuBUNRfT23RCgS1MyJw9gG/S3JWvW+yR20Lhuq3x9Bsx01AHXjpKVC0hd
	harP2tWKkp5ZA9glfRdHqgx6y83pTOVpQ==
X-Google-Smtp-Source: AGHT+IFmO/WoP11vFtOEcZ0fTsuOzqThEdpk9Bqj0Jb1CEpQfcsfyW675oeu4JSWoJ27LrT5AlDS1Sj536yVz8DHbiY=
X-Received: by 2002:a17:90b:268e:b0:311:fde5:e224 with SMTP id
 98e67ed59e1d1-31c4ca6759dmr5982331a91.6.1752257478175; Fri, 11 Jul 2025
 11:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707160404.64933-1-leon.hwang@linux.dev> <20250707160404.64933-4-leon.hwang@linux.dev>
In-Reply-To: <20250707160404.64933-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Jul 2025 11:11:02 -0700
X-Gm-Features: Ac12FXxqDQaOl6hR93GjGB8nWbRSMfIID-D-iFbHwsIVHcH5nNnw_T1ahCUZnJo
Message-ID: <CAEf4Bzba8RdYsC76Hvn5quXCHrG9K7nqv=k5z0-Ex6hBNLVYgw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 3/3] selftests/bpf: Add case to test BPF_F_CPU
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:04=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
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
> 253/13  percpu_alloc/cpu_flag_tests:OK
> 253     percpu_alloc:OK
> Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/percpu_alloc.c   | 170 ++++++++++++++++++
>  .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
>  2 files changed, 194 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
> index 343da65864d6..6f0d0e6dc76a 100644
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
> @@ -115,6 +116,173 @@ static void test_failure(void) {
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
> +       LIBBPF_OPTS(bpf_map_lookup_elem_opts, lookup_opts,
> +                   .flags =3D BPF_F_CPU,
> +                   .cpu =3D 0,
> +       );
> +       LIBBPF_OPTS(bpf_map_update_elem_opts, update_opts,
> +                   .flags =3D BPF_F_CPU,
> +                   .cpu =3D 0,
> +       );
> +       LIBBPF_OPTS(bpf_map_batch_opts, batch_opts,
> +                   .elem_flags =3D BPF_F_CPU,
> +                   .flags =3D 0,
> +       );
> +
> +       nr_cpus =3D libbpf_num_possible_cpus();
> +       if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
> +               return;
> +
> +       skel =3D percpu_array_flag__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "percpu_array_flag__open_and_load"))
> +               return;
> +
> +       map =3D skel->maps.percpu;
> +       map_fd =3D bpf_map__fd(map);
> +       max_entries =3D bpf_map__max_entries(map);
> +
> +       value_size =3D value_sz * nr_cpus;
> +       values =3D calloc(max_entries, value_size);
> +       keys =3D calloc(max_entries, key_sz);
> +       if (!ASSERT_FALSE(!keys || !values, "calloc keys and values"))

ASSERT_xxx are meant to be meaningful in the case that some condition
fails, so using generic ASSERT_FALSE with some complicated condition
is defeating that purpose. Use two separate ASSERT_OK_PTR checks
instead.

[...]


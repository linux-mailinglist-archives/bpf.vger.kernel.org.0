Return-Path: <bpf+bounces-39348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FAC972369
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F986288303
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50801898E2;
	Mon,  9 Sep 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVdOdASb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137A3CF51;
	Mon,  9 Sep 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912985; cv=none; b=a2C48R23smgF5tfMTO6vNheAsXeMU8P3vyRpL4mprPDuZBNBwYWeMoczvCc606PVFCPdVKnx6pkPXMgdxKIbTQydcKFRfmqLF43hkvxG5CBKLb6vtDso06mhbkDp7k52oWKbUpcYrctuEGffigxkywmOSw//URPYrSzhscBYJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912985; c=relaxed/simple;
	bh=jaoESpawLL7iuXBkT2goezWMX2DX4C5rFbBO2vuBI48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jposvBGM1Eva1sEwYcFD/0oupuVGztii/XQymSJ84YOnAcT4krXJkEVraT1cyr229cE9Vlt74ECF0xrYYdkBHAsnEskyCeFquCVFnaFP0Z520tQrfXxSQC5QkDMxi6Kox87PT5+jR+2CkGcIk77H1YfmihvsoWNR/UA407S6JSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVdOdASb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2068a7c9286so43930795ad.1;
        Mon, 09 Sep 2024 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725912983; x=1726517783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QZ1h3p6NedMt/C4Lg15+kp/0baYGzRHKXjBa3KES4w=;
        b=YVdOdASblfd1BRPjVdDouZy5+BcwH2YBcZthhzQV1qBRpMYIT6RPHNVwT6Q+BNM4Rt
         zjzHNx3LdZDeVwTMV5Ev6qQnoiwJzYtoBPTxKh2N2Pd0EeoGXu8uU5JwU7vN/z1bipga
         uz0pCdejNqF+xLJ7tzbjBZJAoXhO2/O1R+lUwaHa1bRHnPGpviNcONmpbkptEaDmpE3O
         ZoiB6x9VXwvQD0HYmG8Z6zp02zbfKUA4de2KG5Jb1Qe/e4McAP9E+h7JhL+kr6ndztx0
         4nliOiXBEFrguBDbdWd9CE9X1FQUAkHmXCPfWUDlWkr88peyJ/HLcPsPdaf1DC6t8sij
         RSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725912983; x=1726517783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QZ1h3p6NedMt/C4Lg15+kp/0baYGzRHKXjBa3KES4w=;
        b=omt+C5VNVaglmqlxvCn1uroklDwfVjtixzDfF9K3++b/EDFQAFTPyJf5ZAGOBimrUX
         NkOQHI0gBDBwz3os9miv5xAaQGcwyMY4P9V0WGog3gl134yjDW06hEnu451MPRJdcrTi
         HqBG6COOBk8CROP+wImjSiZI4nplNSgUrTviNUmbsRz82ILxzAy1uI0RmX2FI1+G7XRE
         fUgMHZ1imqx3wOpCcAQqb7gHP2pwan6XkNCf5uGFQkh3HBqBRYGf1GwdJkQTXQ4PPjQQ
         6zX/vS1cdFONS0DDNvU2w9UooRfBnHtDntWTDWnSy75QpUbBVOnZxwU/hXqLCMYJe6yz
         S4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWaWdahsVUQQH8mtRAIL74H+gLCCXvmIqztpoX0XsFMNfLYBrhuX8pYLKhWElgQGNzlLmHinIPA9MoluRMX@vger.kernel.org, AJvYcCWdIwLufd0sJBQqfXQG02fWEHrVhwwdtbMr+49dWO76239VZhsJ61iFp8gKvsL/a2lhbNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5waje4SscC/kcXPqMjfmRbmwHbcnhd6djxgoRFswDYVWQA2N
	e8Gtjb7vmBtF5ABgZJmFe/d2C93M3/3VFfDU9DUSQPU1MjG0lpZiXTviAIKVN7hk1OiTvdjpbPn
	6heOB4Tdg9ivqMlWjrekG2QAOLEs=
X-Google-Smtp-Source: AGHT+IF1HuwRYKt2G5eFz/cM4FVjEryQTelxec3bafrAHhhKCxOxpFoqfP763QlkttQIMr2kDy5yOWThIV1NuU5xW+A=
X-Received: by 2002:a17:90a:348e:b0:2d3:d7f4:8ace with SMTP id
 98e67ed59e1d1-2dad4dddd7cmr11970894a91.8.1725912983233; Mon, 09 Sep 2024
 13:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909071346.1300093-1-chen.dylane@gmail.com> <20240909071346.1300093-3-chen.dylane@gmail.com>
In-Reply-To: <20240909071346.1300093-3-chen.dylane@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 13:16:11 -0700
Message-ID: <CAEf4BzZ94RvYGJ6GYib-5o_PLukq3x+ygHinBYMecqvXiEMxLg@mail.gmail.com>
Subject: Re: [v2 PATCH bpf-next 2/2] bpf/selftests: Check errno when percpu
 map value size exceeds
To: Tao Chen <chen.dylane@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hou Tao <houtao1@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jinke han <jinkehan@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:14=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> This test case checks the errno message when percpu map value size
> exceeds PCPU_MIN_UNIT_SIZE.
>
> root@debian:~# ./test_progs -t map_init
>  #160/1   map_init/pcpu_map_init:OK
>  #160/2   map_init/pcpu_lru_map_init:OK
>  #160/3   map_init/pcpu map value size:OK
>  #160     map_init:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> Signed-off-by: jinke han <jinkehan@didiglobal.com>
> ---
>  .../selftests/bpf/prog_tests/map_init.c       | 32 +++++++++++++++++++
>  .../selftests/bpf/progs/test_map_init.c       |  6 ++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_init.c b/tools/te=
sting/selftests/bpf/prog_tests/map_init.c
> index 14a31109dd0e..7f1a6fa3679f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_init.c
> @@ -6,6 +6,7 @@
>
>  #define TEST_VALUE 0x1234
>  #define FILL_VALUE 0xdeadbeef
> +#define PCPU_MIN_UNIT_SIZE 32768
>
>  static int nr_cpus;
>  static int duration;
> @@ -118,6 +119,35 @@ static int check_values_one_cpu(pcpu_map_value_t *va=
lue, map_value_t expected)
>
>         return 0;
>  }
> +/*
> + * percpu map value size is bound by PCPU_MIN_UNIT_SIZE
> + * check the errno when the value exceed PCPU_MIN_UNIT_SIZE
> + */
> +static void test_pcpu_map_value_size(void)
> +{
> +       struct test_map_init *skel;
> +       int err;
> +       int value_sz =3D PCPU_MIN_UNIT_SIZE + 1;
> +       enum bpf_map_type map_types[] =3D { BPF_MAP_TYPE_PERCPU_ARRAY,
> +                                         BPF_MAP_TYPE_PERCPU_HASH,
> +                                         BPF_MAP_TYPE_LRU_PERCPU_HASH };
> +       for (int i =3D 0; i < ARRAY_SIZE(map_types); i++) {
> +               skel =3D test_map_init__open();
> +               if (!ASSERT_OK_PTR(skel, "skel_open"))
> +                       return;
> +               err =3D bpf_map__set_type(skel->maps.hashmap2, map_types[=
i]);
> +               if (!ASSERT_OK(err, "bpf_map__set_type"))
> +                       goto error;
> +               err =3D bpf_map__set_value_size(skel->maps.hashmap2, valu=
e_sz);
> +               if (!ASSERT_OK(err, "bpf_map__set_value_size"))
> +                       goto error;
> +
> +               err =3D test_map_init__load(skel);
> +               ASSERT_EQ(err, -E2BIG, "skel_load");

This is quite an overkill to test map creation. It will be much more
straightforward to just use low-level bpf_map_create() API, can you
please make use of that instead?

pw-bot: cr

> +error:
> +               test_map_init__destroy(skel);
> +       }
> +}
>
>  /* Add key=3D1 elem with values set for all CPUs
>   * Delete elem key=3D1
> @@ -211,4 +241,6 @@ void test_map_init(void)
>                 test_pcpu_map_init();
>         if (test__start_subtest("pcpu_lru_map_init"))
>                 test_pcpu_lru_map_init();
> +       if (test__start_subtest("pcpu map value size"))
> +               test_pcpu_map_value_size();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_map_init.c b/tools/te=
sting/selftests/bpf/progs/test_map_init.c
> index c89d28ead673..7a772cbf0570 100644
> --- a/tools/testing/selftests/bpf/progs/test_map_init.c
> +++ b/tools/testing/selftests/bpf/progs/test_map_init.c
> @@ -15,6 +15,12 @@ struct {
>         __type(value, __u64);
>  } hashmap1 SEC(".maps");
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, __u64);
> +} hashmap2 SEC(".maps");
>
>  SEC("tp/syscalls/sys_enter_getpgid")
>  int sysenter_getpgid(const void *ctx)
> --
> 2.25.1
>


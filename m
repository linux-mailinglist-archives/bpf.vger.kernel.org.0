Return-Path: <bpf+bounces-51891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F58A3AF2D
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B4B16775C
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 01:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE506137C35;
	Wed, 19 Feb 2025 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnYtBMGt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707833E1
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930103; cv=none; b=ZLomFqKgzXrsbeiJFobyo4NEFRQp8DASVFQ9TKnbQLQVy+qNzqqXs/sluxKgBjZokgm+8vw6K2nc+yTPB1zbdGhJsZ03QhhBIa06/3oeVBxaDx4fhoguPwWSL+qp8FYnQhA5NYlEJFa7LD2gtiTLvZT1d4THgpeGXOTIaF7oRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930103; c=relaxed/simple;
	bh=rJgoYdMHgX2F9DaevyOsmWSRg9jdWubeLo1MsoqDG0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw+ak73jG+87dUR0VDYdlBJbCod7nr21ZUFAV6tKDhmLe/9Dye8+azestIU/99OpaW0mcpoCrsIWwH+ROAYPQZE024c79FOp+qyiMHNCva+UsROkPf/e79oSpzz16D2t2Gz/MaQ8K8M+useT1ohILJwWUN2+42K+BMF92Z8HwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnYtBMGt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so2545402f8f.2
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 17:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739930099; x=1740534899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmTpnXBNwdVX/Q6oosvldY6cGSQC47gA9YC5Gb7bd48=;
        b=DnYtBMGtXjeFmfbLT1pDV8Ugtuz9Xr9kTafi+hN6fJtY5cy/Ij1XTAPTP3oj6QHo4T
         +VRZ2aDoNFvgc0GbV2wL2VgcRnRylnyPXM7SN25VabnBKmKNioOSw1WvSsp4j1Bev/IC
         9KaYd4BI5s0VSlT1SXcTFA55bCk+LqjI7RqXp1vbL2gtGjxKaCjWbSOdbZn/hIKQJ7Zl
         lrZvOhItPkfX0bmWgWw73KeXuI9QO+9qvFCa+8Ey3pEHFiNadnp9XS67ib837MNx8cnm
         L9n5nQ8VqYJlc3bsiatYaJ0D0vCdOU6NZy/bw2n3bGrlapxPUk8gWbvnw8j6QmU8FfeB
         ghpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739930099; x=1740534899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmTpnXBNwdVX/Q6oosvldY6cGSQC47gA9YC5Gb7bd48=;
        b=cwLllvzaEdRQHu27TNgMHY4zRJFgdZhV2suI56PXtHn5mrLzQHB+HbjpPvbG35N4QO
         fqtY2PHLdQZktbriv03RmQG/ueYN2SeYdsAjkzl3VaO8vF8zZRng3T28ljTpgZWkUHvl
         c9In9y/M9UVqw/b/5jx/n2X/wl3twdo0eeWl3hUbFrc0zzBkRivUdTTqD6Xo2Q/W7hMb
         oy4VGQ6V1MsMhCc0tfPfbMBkAvueiYOVqpvDt5n6PTuyBCxtJvseYW0su2uIbdPahSC9
         3gdliuU6eWwWfNzuE3AsrAFQtDVCGcxqPbiIj+w1zP6x+pYvz71NwY4w+QasifA6THP/
         8Ieg==
X-Gm-Message-State: AOJu0YzUk6pGQv9d1ecBqo/gepv7uEG73n9KGFzTl/M6SIf4UJz+MBwR
	IoLtTvaUt79Wrns2LZrPyaVjl6gVSeigDWFakVrD5EvFVhWTrn1J5aYqNYhGWVJV73evVU6w8Hl
	n4A21yS99K1nt5SjtQ8MfQV/Jcx0=
X-Gm-Gg: ASbGncuVAlUZS9IrX41+kC6z9jql1x/F4L0mbOHnOOoL19jpVIo5VBi8RCngWfRC7O8
	c5uVZI6xbi4uIGpF1RAY8ja3XS26iBZP7pbmmO2X5eqDvc1eZIdFwJ8cLp7K+5VMTOW7ROpJkwC
	1MMvsXJZP8OAPbNaO6JJVgladCrUxs
X-Google-Smtp-Source: AGHT+IGUVfv2RTuEOTFrDmWvrEnUjgq2kCfB39olmJd2XIJDmhhHcxnG/dPrkLmt2HCGZ2kG06TcU6rsuFqvzNrZPIU=
X-Received: by 2002:a05:6000:402c:b0:38f:3a5d:e62f with SMTP id
 ffacd0b85a97d-38f3a5dea23mr14482891f8f.33.1739930099234; Tue, 18 Feb 2025
 17:54:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213161931.46399-1-leon.hwang@linux.dev> <20250213161931.46399-5-leon.hwang@linux.dev>
In-Reply-To: <20250213161931.46399-5-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Feb 2025 17:54:48 -0800
X-Gm-Features: AWEUYZln0bN9x_BUyYno8aXGGTYX4C10kJMrSR-XbpxPAIsNJgi6DH7xUFyoOws
Message-ID: <CAADnVQKtNg898X-n+LrRQ+1RHnTiEWGTppfm=QLauyjne24-8Q@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v2 4/4] selftests/bpf: Add cases to test
 global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:20=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> If the arch, like s390x, does not support percpu insn, this case won't
> test global percpu data by checking -EOPNOTSUPP after loading prog.
>
> The following APIs have been tested for global percpu data:
> 1. bpf_map__set_initial_value()
> 2. bpf_map__initial_value()
> 3. generated percpu struct pointer pointing to internal map's mmaped
> 4. bpf_map__lookup_elem() for global percpu data map
> 5. bpf_map__is_internal_percpu()
>
> At the same time, the case is also tested with 'bpftool gen skeleton -L'.
>
> 125     global_percpu_data_init:OK
> 126     global_percpu_data_lskel:OK
> Summary: 2/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  .../bpf/prog_tests/global_data_init.c         | 217 +++++++++++++++++-
>  .../bpf/progs/test_global_percpu_data.c       |  20 ++
>  3 files changed, 237 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_=
data.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 0d552bfcfe7da..7991de79d55c5 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -503,7 +503,7 @@ LSKELS :=3D fentry_test.c fexit_test.c fexit_sleep.c =
atomics.c                \
>
>  # Generate both light skeleton and libbpf skeleton for these
>  LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.=
c \
> -       kfunc_call_test_subprog.c
> +       kfunc_call_test_subprog.c test_global_percpu_data.c
>  SKEL_BLACKLIST +=3D $$(LSKELS)
>
>  test_static_linked.skel.h-deps :=3D test_static_linked1.bpf.o test_stati=
c_linked2.bpf.o
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 8466332d7406f..5ace86a0eace7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include "bpf/libbpf_internal.h"
> +#include "test_global_percpu_data.skel.h"
> +#include "test_global_percpu_data.lskel.h"
>
>  void test_global_data_init(void)
>  {
> @@ -8,7 +11,7 @@ void test_global_data_init(void)
>         __u8 *buff =3D NULL, *newval =3D NULL;
>         struct bpf_object *obj;
>         struct bpf_map *map;
> -        __u32 duration =3D 0;
> +       __u32 duration =3D 0;
>         size_t sz;
>
>         obj =3D bpf_object__open_file(file, NULL);
> @@ -60,3 +63,215 @@ void test_global_data_init(void)
>         free(newval);
>         bpf_object__close(obj);
>  }
> +
> +void test_global_percpu_data_init(void)
> +{
> +       struct test_global_percpu_data__percpu init_value, *init_data, *d=
ata, *percpu_data;
> +       int key, prog_fd, err, num_cpus, num_online, comm_fd =3D -1, i;
> +       struct test_global_percpu_data *skel =3D NULL;
> +       __u64 args[2] =3D {0x1234ULL, 0x5678ULL};
> +       size_t elem_sz, init_data_sz;
> +       char buf[] =3D "new_name";
> +       struct bpf_map *map;
> +       bool *online;
> +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> +                   .ctx_in =3D args,
> +                   .ctx_size_in =3D sizeof(args),
> +                   .flags =3D BPF_F_TEST_RUN_ON_CPU,
> +       );
> +
> +       num_cpus =3D libbpf_num_possible_cpus();
> +       if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
> +               return;
> +
> +       err =3D parse_cpu_mask_file("/sys/devices/system/cpu/online",
> +                                 &online, &num_online);
> +       if (!ASSERT_OK(err, "parse_cpu_mask_file"))
> +               return;
> +
> +       elem_sz =3D sizeof(*percpu_data);
> +       percpu_data =3D calloc(num_cpus, elem_sz);
> +       if (!ASSERT_OK_PTR(percpu_data, "calloc percpu_data"))
> +               goto out;
> +
> +       skel =3D test_global_percpu_data__open();
> +       if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
> +               goto out;
> +       if (!ASSERT_OK_PTR(skel->percpu, "skel->percpu"))
> +               goto out;
> +
> +       ASSERT_EQ(skel->percpu->data, -1, "skel->percpu->data");
> +       ASSERT_FALSE(skel->percpu->run, "skel->percpu->run");
> +       ASSERT_EQ(skel->percpu->data2, 0, "skel->percpu->data2");

this will only check the value on cpu0, right?
Let's check it on all ?

> +       map =3D skel->maps.percpu;
> +       if (!ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY, "bp=
f_map__type"))
> +               goto out;
> +       if (!ASSERT_TRUE(bpf_map__is_internal_percpu(map), "bpf_map__is_i=
nternal_percpu"))
> +               goto out;
> +
> +       init_value.data =3D 2;
> +       init_value.run =3D false;
> +       err =3D bpf_map__set_initial_value(map, &init_value, sizeof(init_=
value));
> +       if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
> +               goto out;
> +
> +       init_data =3D bpf_map__initial_value(map, &init_data_sz);
> +       if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
> +               goto out;
> +
> +       ASSERT_EQ(init_data->data, init_value.data, "initial_value data")=
;
> +       ASSERT_EQ(init_data->run, init_value.run, "initial_value run");
> +       ASSERT_EQ(init_data_sz, sizeof(init_value), "initial_value size")=
;
> +       ASSERT_EQ((void *) init_data, (void *) skel->percpu, "skel->percp=
u eq init_data");
> +       ASSERT_EQ(skel->percpu->data, init_value.data, "skel->percpu->dat=
a");
> +       ASSERT_EQ(skel->percpu->run, init_value.run, "skel->percpu->run")=
;
> +
> +       err =3D test_global_percpu_data__load(skel);
> +       if (err =3D=3D -EOPNOTSUPP) {
> +               test__skip();
> +               goto out;
> +       }
> +       if (!ASSERT_OK(err, "test_global_percpu_data__load"))
> +               goto out;
> +
> +       ASSERT_NULL(skel->percpu, "NULL skel->percpu");
> +
> +       err =3D test_global_percpu_data__attach(skel);
> +       if (!ASSERT_OK(err, "test_global_percpu_data__attach"))
> +               goto out;
> +
> +       comm_fd =3D open("/proc/self/comm", O_WRONLY|O_TRUNC);
> +       if (!ASSERT_GE(comm_fd, 0, "open /proc/self/comm"))
> +               goto out;
> +
> +       err =3D write(comm_fd, buf, sizeof(buf));
> +       if (!ASSERT_GE(err, 0, "task rename"))
> +               goto out;
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.update_percpu_data);
> +
> +       /* run on every CPU */
> +       for (i =3D 0; i < num_online; i++) {
> +               if (!online[i])
> +                       continue;
> +
> +               topts.cpu =3D i;
> +               topts.retval =3D 0;
> +               err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +               ASSERT_OK(err, "bpf_prog_test_run_opts");
> +               ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval=
");
> +       }
> +
> +       key =3D 0;
> +       err =3D bpf_map__lookup_elem(map, &key, sizeof(key), percpu_data,
> +                                  elem_sz * num_cpus, 0);
> +       if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
> +               goto out;
> +
> +       for (i =3D 0; i < num_online; i++) {
> +               if (!online[i])
> +                       continue;
> +
> +               data =3D percpu_data + i;
> +               ASSERT_EQ(data->data, 1, "percpu_data->data");
> +               ASSERT_TRUE(data->run, "percpu_data->run");
> +               ASSERT_EQ(data->data2, 0xc0de, "percpu_data->data2");
> +       }
> +
> +out:
> +       close(comm_fd);
> +       test_global_percpu_data__destroy(skel);
> +       if (percpu_data)
> +               free(percpu_data);
> +       free(online);
> +}
> +
> +void test_global_percpu_data_lskel(void)
> +{
> +       int key, prog_fd, map_fd, err, num_cpus, num_online, comm_fd =3D =
-1, i;
> +       struct test_global_percpu_data__percpu *data, *percpu_data;
> +       struct test_global_percpu_data_lskel *lskel =3D NULL;
> +       __u64 args[2] =3D {0x1234ULL, 0x5678ULL};
> +       char buf[] =3D "new_name";
> +       bool *online;
> +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> +                   .ctx_in =3D args,
> +                   .ctx_size_in =3D sizeof(args),
> +                   .flags =3D BPF_F_TEST_RUN_ON_CPU,
> +       );
> +
> +       num_cpus =3D libbpf_num_possible_cpus();
> +       if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
> +               return;
> +
> +       err =3D parse_cpu_mask_file("/sys/devices/system/cpu/online",
> +                                 &online, &num_online);
> +       if (!ASSERT_OK(err, "parse_cpu_mask_file"))
> +               return;
> +
> +       percpu_data =3D calloc(num_cpus, sizeof(*percpu_data));
> +       if (!ASSERT_OK_PTR(percpu_data, "calloc percpu_data"))
> +               goto out;
> +
> +       lskel =3D test_global_percpu_data_lskel__open();
> +       if (!ASSERT_OK_PTR(lskel, "test_global_percpu_data_lskel__open"))
> +               goto out;
> +
> +       err =3D test_global_percpu_data_lskel__load(lskel);
> +       if (err =3D=3D -EOPNOTSUPP) {
> +               test__skip();
> +               goto out;
> +       }
> +       if (!ASSERT_OK(err, "test_global_percpu_data_lskel__load"))
> +               goto out;
> +
> +       err =3D test_global_percpu_data_lskel__attach(lskel);
> +       if (!ASSERT_OK(err, "test_global_percpu_data_lskel__attach"))
> +               goto out;
> +
> +       comm_fd =3D open("/proc/self/comm", O_WRONLY|O_TRUNC);
> +       if (!ASSERT_GE(comm_fd, 0, "open /proc/self/comm"))
> +               goto out;
> +
> +       err =3D write(comm_fd, buf, sizeof(buf));
> +       if (!ASSERT_GE(err, 0, "task rename"))
> +               goto out;

why this odd double run of bpf prog?
First via task_rename and then directly?
Only use bpf_prog_test_run_opts() and avoiding attaching to a tracepoint?

> +
> +       prog_fd =3D lskel->progs.update_percpu_data.prog_fd;
> +
> +       /* run on every CPU */
> +       for (i =3D 0; i < num_online; i++) {
> +               if (!online[i])
> +                       continue;
> +
> +               topts.cpu =3D i;
> +               topts.retval =3D 0;
> +               err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +               ASSERT_OK(err, "bpf_prog_test_run_opts");
> +               ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval=
");
> +       }
> +
> +       key =3D 0;
> +       map_fd =3D lskel->maps.percpu.map_fd;
> +       err =3D bpf_map_lookup_elem(map_fd, &key, percpu_data);
> +       if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> +               goto out;
> +
> +       for (i =3D 0; i < num_online; i++) {
> +               if (!online[i])
> +                       continue;
> +
> +               data =3D percpu_data + i;
> +               ASSERT_EQ(data->data, 1, "percpu_data->data");
> +               ASSERT_TRUE(data->run, "percpu_data->run");
> +               ASSERT_EQ(data->data2, 0xc0de, "percpu_data->data2");
> +       }
> +
> +out:
> +       close(comm_fd);
> +       test_global_percpu_data_lskel__destroy(lskel);
> +       if (percpu_data)
> +               free(percpu_data);
> +       free(online);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c =
b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> new file mode 100644
> index 0000000000000..ada292d3a164c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright Leon Hwang */

Are you sure you can do it in your country?
Often enough copyright belongs to the company you work for.

> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +int data SEC(".percpu") =3D -1;
> +int run SEC(".percpu") =3D 0;
> +int data2 SEC(".percpu");

Pls add u8, array of ints and struct { .. } vars for completeness.

pw-bot: cr


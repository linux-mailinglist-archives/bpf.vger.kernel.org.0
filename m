Return-Path: <bpf+bounces-50573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16296A29DC7
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1BA188888C
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884332907;
	Thu,  6 Feb 2025 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EglqM90X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA5151995
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738800581; cv=none; b=VPISaQAu1Pejo7HbDM6wXVDNMfxEC8sBuLr0yI74VmRanMbqanILH9Ir0LtQj4NkRa+xTcbHSRL49VYEcXCAu3QedTyr3GqwYrNujdAs7uNLYWMangJjI5ofuIANZmKRzW6OwQdQYDRF10jRB2DmKm03MeABv9wmTAYCiiLIF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738800581; c=relaxed/simple;
	bh=xKceQdYSp8vaQoOWByevY8e52sB1mUt9+tPSVyI3I4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cErf2IXR6UYa9zuL7SYnutuvKtBmTgm/dJrK+sdMDnHRxwMav5tRrQPLAVMRxSzx2X8tEx2+vClCTbQqqBRkER+MNilW/BQ1EfFLeZKNs0JdtZlI10jYwqrzraE1YN8LOg5bqLL9H7zqhbVyNwzn1aOufVCTCZKDWRofH2kaS50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EglqM90X; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216728b1836so6959855ad.0
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 16:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738800579; x=1739405379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcaSREMJDTw06CCK1dWo0kcsACiY25fDfNfT61WNNl4=;
        b=EglqM90XOLcNMNhWN1FFtbgO3sCT+Nko2Gq72g3i3/7glAdvMFmZ5fcuzevI55vbmy
         FkftIBSWQp6hG8nbzxJDNf/o2kBxlriJH64sAcc9K0jQGwGpzJkLYjGOMMSEcReyhG/M
         sPAbHZeZH79ovV0l3Ifa8ALwBEA/F8WY6oDB16RFLXWqtSx/G4o+5whc+TKqRAAk+URM
         HAnE0WQOeUCRqmoFkn9Xmuxok1ZOzW+AGiRvgb2MUbuiYTSpjKOAYwZ1/2vR3caqreZ2
         UXgpQxxCjGliVvndfOrZELP1Ktg7LL5EzJ7GSaSfyUk/b2va//8sM7qNsQI8huFtVwBI
         QLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738800579; x=1739405379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcaSREMJDTw06CCK1dWo0kcsACiY25fDfNfT61WNNl4=;
        b=IH49XYs8yYbgKtyOvc2th8Y9xjnlpLeotUZb9AJgcZl0SvRZ9BWnfxjUjp4hHoT4uC
         L7t83dhXQYjfaJLhd90uA9YOoasJQ+qH7hbhoipvp8H/iE7f9pk9zLM5OMQz/ern7EXs
         yKiMzFlq4VG3T0asVHNhf9fwWZh7vR2j1u3Z4wwlDQc8CtvIjXHTJ5M/sVv7u1kjJR6a
         v51pf3bfYEZwHm0mD+DP0KO+/Lqfl61dqiNAVYbeqOJ95KnhjPHwT1V761P9cPkEojIw
         tbHhGAx+8imAQwuwiNme0o2NzOzoIo8xnNrcrSJRe1Q/FexMHtnGeVz6/x/W7w/QDq45
         TYhA==
X-Gm-Message-State: AOJu0YyeBXsXWCHBo50DCx29uc0IopRBA7lZUrAm8sWVeWfJfnRp6jcX
	PbiGzC5jxpGqEpfHo83qjvolQmVGn4tTX0hs6KNr6oMSih2J9DuVS89mrt0X00BKZro1nuroJK1
	4EfizJa5VWzPGQ3TMtUe81E5pN70=
X-Gm-Gg: ASbGnctiFL71ne3ZPt56lxaOpOXdSlIJmVvzDSVd4dVTKJrpYQQv7djjCFxqMkMBnQv
	GWUWo0plXTtDWIAKR+9a0OvWuNyM13bicTpoUjzGT7bv1sL1VedZJJAwAZR9BGhqqW13NNYgsIm
	X6kLsGModUTYFQ
X-Google-Smtp-Source: AGHT+IHkgsNFw9ZX4Eyx3SCuM8WnhJSd3eqSAX502r1TgHZ9sisFbJE8/xl5hq3EQNYHZREh0hvfc60V8HTtMi4+Dw0=
X-Received: by 2002:a05:6a21:9208:b0:1e1:b0df:6cd7 with SMTP id
 adf61e73a8af0-1ede88106fcmr8824611637.5.1738800578671; Wed, 05 Feb 2025
 16:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127162158.84906-1-leon.hwang@linux.dev> <20250127162158.84906-5-leon.hwang@linux.dev>
In-Reply-To: <20250127162158.84906-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 16:09:21 -0800
X-Gm-Features: AWEUYZlaz5gi2on-ZNVqZk2CjVbU7PKFAy9GgljrCv7wO455xtIsZ0oYJH3xRRo
Message-ID: <CAEf4BzYXCQi4HMvegMmsx-ppxprwNVyKohJgka8gY_B+gMy+mQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add a case to test global
 percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> If the arch, like s390x, does not support percpu insn, this case won't
> test global percpu data by checking -EOPNOTSUPP when load prog.
>
> The following APIs have been tested for global percpu data:
> 1. bpf_map__set_initial_value()
> 2. bpf_map__initial_value()
> 3. generated percpu struct pointer that points to internal map's data
> 4. bpf_map__lookup_elem() for global percpu data map
>
> cd tools/testing/selftests/bpf; ./test_progs -t global_percpu_data
> 124     global_percpu_data_init:OK
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  .../bpf/prog_tests/global_data_init.c         | 89 ++++++++++++++++++-
>  .../bpf/progs/test_global_percpu_data.c       | 21 +++++
>  2 files changed, 109 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_=
data.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 8466332d7406f..a5d0890444f67 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include "test_global_percpu_data.skel.h"
>
>  void test_global_data_init(void)
>  {
> @@ -8,7 +9,7 @@ void test_global_data_init(void)
>         __u8 *buff =3D NULL, *newval =3D NULL;
>         struct bpf_object *obj;
>         struct bpf_map *map;
> -        __u32 duration =3D 0;
> +       __u32 duration =3D 0;
>         size_t sz;
>
>         obj =3D bpf_object__open_file(file, NULL);
> @@ -60,3 +61,89 @@ void test_global_data_init(void)
>         free(newval);
>         bpf_object__close(obj);
>  }
> +
> +void test_global_percpu_data_init(void)
> +{
> +       struct test_global_percpu_data *skel =3D NULL;
> +       u64 *percpu_data =3D NULL;

there is that test_global_percpu_data__percpu type you are declaring
in the BPF skeleton, right? We should try using it here.

And for that array access, we should make sure that it's __aligned(8),
so indexing by CPU index works correctly.

Also, you define per-CPU variable as int, but here it is u64, what's
up with that?

> +       struct bpf_map *map;
> +       size_t init_data_sz;
> +       char buff[128] =3D {};
> +       int init_value =3D 2;
> +       int key, value_sz;
> +       int prog_fd, err;
> +       int *init_data;
> +       int num_cpus;
> +

nit: LIBBPF_OPTS below is variable declaration, so there shouldn't be
an empty line here (and maybe group those int variables a bit more
tightly?)

> +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> +                   .data_in =3D buff,
> +                   .data_size_in =3D sizeof(buff),
> +                   .repeat =3D 1,
> +       );
> +
> +       num_cpus =3D libbpf_num_possible_cpus();
> +       if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
> +               return;
> +
> +       percpu_data =3D calloc(num_cpus, sizeof(*percpu_data));
> +       if (!ASSERT_FALSE(percpu_data =3D=3D NULL, "calloc percpu_data"))

ASSERT_OK_PTR()

> +               return;
> +
> +       value_sz =3D sizeof(*percpu_data) * num_cpus;
> +       memset(percpu_data, 0, value_sz);

you calloc()'ed it, it's already zero-initialized


> +
> +       skel =3D test_global_percpu_data__open();
> +       if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
> +               goto out;
> +
> +       ASSERT_EQ(skel->percpu->percpu_data, -1, "skel->percpu->percpu_da=
ta");
> +
> +       map =3D skel->maps.percpu;
> +       err =3D bpf_map__set_initial_value(map, &init_value,
> +                                        sizeof(init_value));
> +       if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
> +               goto out;
> +
> +       init_data =3D bpf_map__initial_value(map, &init_data_sz);
> +       if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
> +               goto out;
> +
> +       ASSERT_EQ(*init_data, init_value, "initial_value");
> +       ASSERT_EQ(init_data_sz, sizeof(init_value), "initial_value size")=
;
> +
> +       if (!ASSERT_EQ((void *) init_data, (void *) skel->percpu, "skel->=
percpu"))
> +               goto out;
> +       ASSERT_EQ(skel->percpu->percpu_data, init_value, "skel->percpu->p=
ercpu_data");
> +
> +       err =3D test_global_percpu_data__load(skel);
> +       if (err =3D=3D -EOPNOTSUPP)
> +               goto out;
> +       if (!ASSERT_OK(err, "test_global_percpu_data__load"))
> +               goto out;
> +
> +       ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY,
> +                 "bpf_map__type");
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.update_percpu_data);
> +       err =3D bpf_prog_test_run_opts(prog_fd, &topts);

at least one of BPF programs (don't remember which one, could be
raw_tp) supports specifying CPU index to run on, it would be nice to
loop over CPUs, triggering BPF program on each one and filling per-CPU
variable with current CPU index. Then we can check that all per-CPU
values have expected values.


> +       ASSERT_OK(err, "update_percpu_data");
> +       ASSERT_EQ(topts.retval, 0, "update_percpu_data retval");
> +
> +       key =3D 0;
> +       err =3D bpf_map__lookup_elem(map, &key, sizeof(key), percpu_data,
> +                                  value_sz, 0);
> +       if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
> +               goto out;
> +
> +       if (!ASSERT_LT(skel->bss->curr_cpu, num_cpus, "curr_cpu"))
> +               goto out;
> +       ASSERT_EQ((int) percpu_data[skel->bss->curr_cpu], 1, "percpu_data=
");
> +       if (num_cpus > 1)
> +               ASSERT_EQ((int) percpu_data[(skel->bss->curr_cpu+1)%num_c=
pus],
> +                         init_value, "init_value");
> +
> +out:
> +       test_global_percpu_data__destroy(skel);
> +       if (percpu_data)
> +               free(percpu_data);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c =
b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> new file mode 100644
> index 0000000000000..731c3214b0bb4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright Leon Hwang */
> +
> +#include <linux/bpf.h>
> +#include <linux/pkt_cls.h>
> +
> +#include <bpf/bpf_helpers.h>
> +
> +int percpu_data SEC(".percpu") =3D -1;
> +int curr_cpu;
> +
> +SEC("tc")
> +int update_percpu_data(struct __sk_buff *skb)
> +{
> +       curr_cpu =3D bpf_get_smp_processor_id();
> +       percpu_data =3D 1;
> +
> +       return TC_ACT_OK;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.47.1
>


Return-Path: <bpf+bounces-53272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F54EA4F455
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E93407A6F79
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630E136E37;
	Wed,  5 Mar 2025 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E04anDf8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD01096F
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140251; cv=none; b=SUbK/b90xFEeJsunlyMJXCgE5WJSFQIpcohgJ2lL/SoLelXiKVCv8mIUyCRgJ9GvjTwMlpD+s83skWJdYcbfhcv0Aavw82r7Lt48ph3XkwlcD+nK3C21rbujJLEi5Er3FiII+mqIUNzlzGKOewxYeh2YoVcFxaosFfEIl+FWZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140251; c=relaxed/simple;
	bh=656dC5P/7FWDYYH24CRj7opHJ8nFpckoOJ7we3YjoTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmwBhK28WNRlLdFdt95bLQ5qIq/3p90GaZAFX+VcyU2VHiiTX3CDX4y0uG2SiNQkajQyuC5G38Sy8un8nnJn/L/o3MgYcm/xzXFsydrfreMenjy+M3Tq09nR9l3+Y7Om/KnQo5kx3k43Zhh/zvRZZYudiJleufkGMhBvusC1npU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E04anDf8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390dd362848so4851397f8f.3
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 18:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741140247; x=1741745047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZNmTDUtxX42qamMfVVC8zVuj2oxGE0G4s59XUASPk8=;
        b=E04anDf8nqfcPRDQdy7GMBfZ5ogvCu07lg/nYkh2a0aph9QVTNWBaSDz6lfwA4uooI
         zq3vEVfHAVRIvJlF2dfeDLBIp5NICLur2cy13ThCvZFOWmckFxk4iCV6OSM6DEguZ1sm
         rBGewwIlf4FxGRGSONNfYRi042qjwlGdW6GZZr0PK65RvCxPFvbjA/AusOahPJYVk/i1
         57vF4vNWDbc0IyCVAkPob6G2aceYwQlkLDg1R3OEFflYr5eAhjFxEkE+m7KOKGF1gj5J
         TZrHBHt7Xhd4T8Kq/WmW7MUOM5ytfpz/aUzdzR7apDCfcDMEzxmGhTmFpq0/FPFn/raB
         HH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140247; x=1741745047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZNmTDUtxX42qamMfVVC8zVuj2oxGE0G4s59XUASPk8=;
        b=abbpcj/DQ2aIlX320cuf0+N3N1dWIFncN1t6gD4tBdlHyvRJ7jhtNpqvpZdzS8RWVV
         /aYCmu+IMz6I9lFjghJPNnKG/X2ZcetPriy5syVGMDHQw1mMZG/hiDc1XyqdyzCFffwl
         snN2B/WWlKNbRxbN3J6g7LuGG6ZGuZINt/HYAAF8A7t0O3/7oRFq+vDm2p3VYOLGW38C
         tuOUbvHOhB9f5ECbyAVwXHq0UlJHyQGPPm5HnQ4DvmPLIeMzSMqq92qVm01hmWl31Lmm
         RHlzLlo9YaWMgiN1qwgsilqKM7GkudBp9CisEmufksdavscb9FGifyc8n/jY9L8bz89i
         DOjA==
X-Gm-Message-State: AOJu0Yy5Ygc93HNevZ0X7toVmxmtX8dnx6u7FCEkZeZNKZyIBd0ekm2X
	tIckrQzIGZHz/f0Say87N+pQle/7XpN8W63qYujWrqMPTfCigmnJXwWb8R7jMCLGoyYNwAOvl+f
	kqLe2w24eslk+ycHoh2fz2Hm4zLI=
X-Gm-Gg: ASbGncuQV/Rp4w4c5vcDg/CvKUWLk+k7s/Ub2PchC5hCwOibtIiRML8Pi2NV2EMi+Bi
	MkA/sOt5T0DXzEbhzLn2bJB23g8ws+EMBa31AJvaxdILz78lZup8xJQfyLiXHgzBFECOLi0qYGD
	pMsildqojXF0jhnnW0PHC4sZxPv4kG4Y+TNG9EqOl6DQ==
X-Google-Smtp-Source: AGHT+IEvTuZc4izXc9dydFPLfUVlqAMVAxdNOSbVFXi4CjNxDauTyL1ByYTlvXQaflJG9+q1hR5ZUNfYvv5YlYPPRMI=
X-Received: by 2002:a05:6000:4185:b0:391:5f:fa4e with SMTP id
 ffacd0b85a97d-3911f7476b5mr527831f8f.29.1741140247293; Tue, 04 Mar 2025
 18:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305011849.1168917-1-memxor@gmail.com> <20250305011849.1168917-4-memxor@gmail.com>
In-Reply-To: <20250305011849.1168917-4-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Mar 2025 18:03:56 -0800
X-Gm-Features: AQ5f1Jqmkp7bU-J0F6B92oFfK0d_CwfvyCUx5a7J3ntAPZNG6tNKusBR_iSnd7c
Message-ID: <CAADnVQ+6snJwWne8ub+Fht1zinDxJZhDxfsfAvPz0Ezfe3dSHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for arena spin lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:18=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Add some basic selftests for qspinlock built over BPF arena using
> cond_break_label macro.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../bpf/prog_tests/arena_spin_lock.c          | 102 ++++++++++++++++++
>  .../selftests/bpf/progs/arena_spin_lock.c     |  51 +++++++++
>  2 files changed, 153 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_loc=
k.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/t=
ools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> new file mode 100644
> index 000000000000..2cc078ed1ddb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include <sys/sysinfo.h>
> +
> +struct qspinlock { int val; };
> +typedef struct qspinlock arena_spinlock_t;
> +
> +struct arena_qnode {
> +       unsigned long next;
> +       int count;
> +       int locked;
> +};
> +
> +#include "arena_spin_lock.skel.h"
> +
> +static long cpu;
> +int *counter;
> +
> +static void *spin_lock_thread(void *arg)
> +{
> +       int err, prog_fd =3D *(u32 *)arg;
> +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> +               .data_in =3D &pkt_v4,
> +               .data_size_in =3D sizeof(pkt_v4),
> +               .repeat =3D 1,
> +       );

Why bother with 'tc' prog type?
Pick syscall type, and above will be shorter:
LIBBPF_OPTS(bpf_test_run_opts, opts);

> +       cpu_set_t cpuset;
> +
> +       CPU_ZERO(&cpuset);
> +       CPU_SET(__sync_fetch_and_add(&cpu, 1), &cpuset);
> +       ASSERT_OK(pthread_setaffinity_np(pthread_self(), sizeof(cpuset), =
&cpuset), "cpu affinity");
> +
> +       while (*READ_ONCE(counter) <=3D 1000) {

READ_ONCE(*counter) ?

but why add this user->kernel switch overhead.
Use .repeat =3D 1000
one bpf_prog_test_run_opts()
and check at the end that *counter =3D=3D 1000 ?

> +               err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +               if (!ASSERT_OK(err, "test_run err"))
> +                       break;
> +               if (!ASSERT_EQ((int)topts.retval, 0, "test_run retval"))
> +                       break;
> +       }
> +       pthread_exit(arg);
> +}
> +
> +static void test_arena_spin_lock_size(int size)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       struct arena_spin_lock *skel;
> +       pthread_t thread_id[16];
> +       int prog_fd, i, err;
> +       void *ret;
> +
> +       if (get_nprocs() < 2) {
> +               test__skip();
> +               return;
> +       }
> +
> +       skel =3D arena_spin_lock__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
> +               return;
> +       if (skel->data->test_skip =3D=3D 2) {
> +               test__skip();
> +               goto end;
> +       }
> +       counter =3D &skel->bss->counter;
> +       skel->bss->cs_count =3D size;
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.prog);
> +       for (i =3D 0; i < 16; i++) {
> +               err =3D pthread_create(&thread_id[i], NULL, &spin_lock_th=
read, &prog_fd);
> +               if (!ASSERT_OK(err, "pthread_create"))
> +                       goto end;
> +       }
> +
> +       for (i =3D 0; i < 16; i++) {
> +               if (!ASSERT_OK(pthread_join(thread_id[i], &ret), "pthread=
_join"))
> +                       goto end;
> +               if (!ASSERT_EQ(ret, &prog_fd, "ret =3D=3D prog_fd"))
> +                       goto end;
> +       }
> +end:
> +       arena_spin_lock__destroy(skel);
> +       return;
> +}
> +
> +void test_arena_spin_lock(void)
> +{
> +       if (test__start_subtest("arena_spin_lock_1"))
> +               test_arena_spin_lock_size(1);
> +       cpu =3D 0;
> +       if (test__start_subtest("arena_spin_lock_1000"))
> +               test_arena_spin_lock_size(1000);
> +       cpu =3D 0;
> +       if (test__start_subtest("arena_spin_lock_10000"))
> +               test_arena_spin_lock_size(10000);
> +       cpu =3D 0;
> +       if (test__start_subtest("arena_spin_lock_100000"))
> +               test_arena_spin_lock_size(100000);
> +       cpu =3D 0;
> +       if (test__start_subtest("arena_spin_lock_500000"))
> +               test_arena_spin_lock_size(500000);

Do 10k and 500k make a difference?
I suspect 1, 1k and 100k would cover the interesting range.

> +}
> diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/=
testing/selftests/bpf/progs/arena_spin_lock.c
> new file mode 100644
> index 000000000000..3e8ce807e028
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "bpf_arena_spin_lock.h"
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARENA);
> +       __uint(map_flags, BPF_F_MMAPABLE);
> +       __uint(max_entries, 100); /* number of pages */
> +#ifdef __TARGET_ARCH_arm64
> +       __ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
> +#else
> +       __ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
> +#endif
> +} arena SEC(".maps");
> +
> +int cs_count;
> +
> +#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CA=
ST)
> +arena_spinlock_t __arena lock;
> +void *ptr;
> +int test_skip =3D 1;
> +#else
> +int test_skip =3D 2;
> +#endif
> +
> +int counter;
> +
> +SEC("tc")
> +int prog(void *ctx)
> +{
> +       int ret =3D -2;
> +
> +#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CA=
ST)
> +       unsigned long flags;
> +
> +       ptr =3D &arena;

Is it really necessary?

> +       if ((ret =3D arena_spin_lock_irqsave(&lock, flags)))
> +               return ret;
> +       WRITE_ONCE(counter, READ_ONCE(counter) + 1);
> +       bpf_repeat(cs_count);
> +       ret =3D 0;
> +       arena_spin_unlock_irqrestore(&lock, flags);
> +#endif
> +       return ret;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.47.1
>


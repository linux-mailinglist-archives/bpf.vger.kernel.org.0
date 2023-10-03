Return-Path: <bpf+bounces-11324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF137B743D
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 5BDBAB207F5
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EBC3E48E;
	Tue,  3 Oct 2023 22:46:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3BA224E8
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 22:46:23 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484808E
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 15:46:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9936b3d0286so267237266b.0
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696373180; x=1696977980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RD3t+2bD9sINKbMAFb5TXmhspMDmIY8nnFWQNSF2ano=;
        b=I1ZYOGgrxJRX2V2WphU3D8m0zr6fWX2SH6sD60i0o18VqBvdtbTqdO0g15K3BgfaIE
         oiXgYXU965ruMMcTJn0S6OGWX1V84Y91dsghjn8fEPptY9tk4Ukej6rZNdvRDiHMJI8e
         xQJqRTrfHOmdys6uRkzlZNww8Vntw42yQRkfpUZ9PMC+bRa5j83xFxY7q3EZxKb59hyC
         FqQhH2s440i8OH4msNz6Zl1g7R2yxhVJ08LOR3B3wqTHeBoO+RaeR3n5tIn/PmyseWLe
         M9oEhXKQg5m13YxWmpW5wI9R6Mcrd0nH/NnfkUHKwfZmp0A56ddJu/pB+BrVuFO127th
         5WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696373180; x=1696977980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RD3t+2bD9sINKbMAFb5TXmhspMDmIY8nnFWQNSF2ano=;
        b=jJeru6XnUKtMn3wecHkMYGGNB1VelKH6xyqaHFWtSRmoafIrPX6SWNVo1V7E6AW5n/
         RAXt13inNeSuYgvwNBtb2M2E4gSj8BINPgGbOhLxLEQWnLWU33UGuBckc/wij/QdPpFE
         stLNIbKzTjbfMb8iFju7Zt5f758f5DFVk+6sVtaQcmtZ4UWnd1XE+QJfFMBQk4C3NSuL
         UqHt4zj5KsGQrO8satem6AY1Z7jt09d2ni9REasMGI6td3xSiCkXeCltvCDUpkG3SR+/
         w2ybIwNDouAWJJnM1tO74JB8El0jDiCoykfcrL/41HX3N9VtiA/62pJLrX8DCTPqdYUs
         x54A==
X-Gm-Message-State: AOJu0YxTZaZ6+3QB4hdhJ1+2T+TeVBD7I6cLSkOAeL+4iOPr9eBolWaC
	RVLhcd4AGEwjg+UR4UB3dcxPbahAAoS0WBWC0fg=
X-Google-Smtp-Source: AGHT+IGpoHyhmMagPshDfd17jpiC9wa2No6QL3WrkRyTQndxqySIVa0tIya0aa1zVE9g73wpbYzEIzy5bfunxtyYVeQ=
X-Received: by 2002:a17:906:310b:b0:9b5:f25d:9261 with SMTP id
 11-20020a170906310b00b009b5f25d9261mr483824ejx.22.1696373179462; Tue, 03 Oct
 2023 15:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002195341.2940874-1-davemarchevsky@fb.com> <20231002195341.2940874-4-davemarchevsky@fb.com>
In-Reply-To: <20231002195341.2940874-4-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Oct 2023 15:46:07 -0700
Message-ID: <CAEf4BzYBDxGFnWVtiO8wZDsyYCBNa+-JB+CptS-DFkNTG=Mmqw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: Add tests for open-coded
 task_vma iter
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 12:53=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb.=
com> wrote:
>
> The open-coded task_vma iter added earlier in this series allows for
> natural iteration over a task's vmas using existing open-coded iter
> infrastructure, specifically bpf_for_each.
>
> This patch adds a test demonstrating this pattern and validating
> correctness. The vma->vm_start and vma->vm_end addresses of the first
> 1000 vmas are recorded and compared to /proc/PID/maps output. As
> expected, both see the same vmas and addresses - with the exception of
> the [vsyscall] vma - which is explained in a comment in the prog_tests
> program.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../testing/selftests/bpf/prog_tests/iters.c  | 71 +++++++++++++++++++
>  .../selftests/bpf/progs/iters_task_vma.c      | 63 ++++++++++++++++
>  2 files changed, 134 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testi=
ng/selftests/bpf/prog_tests/iters.c
> index 10804ae5ae97..7a18fc21f364 100644
> --- a/tools/testing/selftests/bpf/prog_tests/iters.c
> +++ b/tools/testing/selftests/bpf/prog_tests/iters.c
> @@ -8,6 +8,7 @@
>  #include "iters_looping.skel.h"
>  #include "iters_num.skel.h"
>  #include "iters_testmod_seq.skel.h"
> +#include "iters_task_vma.skel.h"
>
>  static void subtest_num_iters(void)
>  {
> @@ -90,6 +91,74 @@ static void subtest_testmod_seq_iters(void)
>         iters_testmod_seq__destroy(skel);
>  }
>
> +static void subtest_task_vma_iters(void)
> +{
> +       unsigned long start, end, bpf_iter_start, bpf_iter_end;
> +       struct iters_task_vma *skel;
> +       char rest_of_line[1000];
> +       unsigned int seen;
> +       int err;
> +       FILE *f;
> +
> +       skel =3D iters_task_vma__open();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       bpf_program__set_autoload(skel->progs.iter_task_vma_for_each, tru=
e);
> +

no need, just drop ? from SEC(). Then you can do shorter
iters_task_vma__open_and_load() in one step.

> +       err =3D iters_task_vma__load(skel);
> +       if (!ASSERT_OK(err, "skel_load"))
> +               goto cleanup;
> +
> +       skel->bss->target_pid =3D getpid();
> +
> +       err =3D iters_task_vma__attach(skel);
> +       if (!ASSERT_OK(err, "skel_attach"))
> +               goto cleanup;
> +
> +       getpgid(skel->bss->target_pid);
> +       iters_task_vma__detach(skel);
> +
> +       if (!ASSERT_GT(skel->bss->vmas_seen, 0, "vmas_seen_gt_zero"))
> +               goto cleanup;
> +
> +       f =3D fopen("/proc/self/maps", "r");
> +       if (!ASSERT_OK_PTR(f, "proc_maps_fopen"))
> +               goto cleanup;
> +
> +       seen =3D 0;
> +       while (fscanf(f, "%lx-%lx %[^\n]\n", &start, &end, rest_of_line) =
=3D=3D 3) {
> +               /* [vsyscall] vma isn't _really_ part of task->mm vmas.
> +                * /proc/PID/maps returns it when out of vmas - see get_g=
ate_vma
> +                * calls in fs/proc/task_mmu.c
> +                */
> +               if (strstr(rest_of_line, "[vsyscall]"))
> +                       continue;
> +
> +               err =3D bpf_map_lookup_elem(bpf_map__fd(skel->maps.vm_sta=
rt),
> +                                         &seen, &bpf_iter_start);
> +               if (!ASSERT_OK(err, "vm_start map_lookup_elem"))
> +                       goto cleanup;
> +
> +               err =3D bpf_map_lookup_elem(bpf_map__fd(skel->maps.vm_end=
),
> +                                         &seen, &bpf_iter_end);
> +               if (!ASSERT_OK(err, "vm_end map_lookup_elem"))
> +                       goto cleanup;
> +
> +               ASSERT_EQ(bpf_iter_start, start, "vma->vm_start match");
> +               ASSERT_EQ(bpf_iter_end, end, "vma->vm_end match");
> +               seen++;
> +       }
> +
> +       fclose(f);

move this into cleanup region (with NULL check, of course), some code
paths won't close the file

> +
> +       if (!ASSERT_EQ(skel->bss->vmas_seen, seen, "vmas_seen_eq"))
> +               goto cleanup;
> +
> +cleanup:
> +       iters_task_vma__destroy(skel);
> +}
> +
>  void test_iters(void)
>  {
>         RUN_TESTS(iters_state_safety);
> @@ -103,4 +172,6 @@ void test_iters(void)
>                 subtest_num_iters();
>         if (test__start_subtest("testmod_seq"))
>                 subtest_testmod_seq_iters();
> +       if (test__start_subtest("task_vma"))
> +               subtest_task_vma_iters();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma.c b/tools/t=
esting/selftests/bpf/progs/iters_task_vma.c
> new file mode 100644
> index 000000000000..1ac7ca0633be
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <limits.h>
> +#include <linux/errno.h>
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +pid_t target_pid =3D 0;
> +unsigned int vmas_seen =3D 0;
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1000);
> +       __type(key, int);
> +       __type(value, unsigned long);
> +} vm_start SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1000);
> +       __type(key, int);
> +       __type(value, unsigned long);
> +} vm_end SEC(".maps");

Very minor point, but just in case you didn't think about it.

This is old school way, I'd just do:

struct { __u64 vm_start, vm_end; } vm_ranges[1000];

It would simplify user space part a bit as well

> +
> +SEC("?raw_tp/sys_enter")
> +int iter_task_vma_for_each(const void *ctx)
> +{
> +       struct task_struct *task =3D bpf_get_current_task_btf();
> +       struct vm_area_struct *vma;
> +       unsigned long *start, *end;
> +       unsigned int seen =3D 0;
> +
> +       if (task->pid !=3D target_pid)
> +               return 0;
> +
> +       if (vmas_seen)
> +               return 0;
> +
> +       bpf_for_each(task_vma, vma, task, 0) {
> +               if (seen >=3D 1000)
> +                       break;
> +
> +               start =3D bpf_map_lookup_elem(&vm_start, &seen);
> +               if (!start)
> +                       break;
> +               *start =3D vma->vm_start;
> +
> +               end =3D bpf_map_lookup_elem(&vm_end, &seen);
> +               if (!end)
> +                       break;
> +               *end =3D vma->vm_end;
> +
> +               seen++;
> +       }
> +
> +       if (!vmas_seen)
> +               vmas_seen =3D seen;
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.34.1
>


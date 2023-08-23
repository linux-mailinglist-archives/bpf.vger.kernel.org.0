Return-Path: <bpf+bounces-8328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AB1784DB6
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23ED52811B4
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E596719A;
	Wed, 23 Aug 2023 00:13:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07867E
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 00:13:28 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9CBCC6
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:13:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-523476e868dso6273151a12.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692749605; x=1693354405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V8lGszY8XDuz4aJBxXoyW4VCL8Y4g/OEFiouT5YaJ4=;
        b=ZdTH+OVpRogNi+QlzA/ohezm+JBQJPB1uS0vESzOYhb01rKYMj+Muyl4YU0RF12Wf7
         r7dKvb6FAf2kjWPjaKdGpSrzxkk16hRI0OXEbMpW2BCbPghcOM4a++Xnf+37R9Aut0Aq
         y675D2yepRodSLFYnp/xK4p1b8WgXMIOuDHjPGQ/ULfma8DiFseldZ9DmIZ8pD53PueH
         14E/oac27OVOGBrRudMjxMhlEzqizoX+j5V19thjxF+Xww+bSof7GHURfy60yHOeP5cH
         BYxiTTmvhI1heLxdRtOFkh+NSgxwM9ev3uE/9LWVaG59so6gITT74Q9mlm/UKpgTEQbw
         PLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692749605; x=1693354405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V8lGszY8XDuz4aJBxXoyW4VCL8Y4g/OEFiouT5YaJ4=;
        b=Vw80CrESRaSehx4hgCK7gYHAYOiZ9vICPXiKAN8yAgBj9lQsJ60hKGIXpewZvAplrY
         Ba7DeRjDkzQCYGcHvz7p4SzEuxG+WwUJ35ryFmlPWVD8CbBaaAh1oLDc9LOG+rWhFVKt
         xaWxSFFgF89wyyjIjvNj2dmCIfy/tHekX/NrzS9zxj1MEio9Q2pUBjXCGMx0Q8Uxne3D
         JGKQKw3FmlrT1gDJRmfWf7XFurnXe8SKubhNJKFbkb/yCiCeN5k/Ti40F0cC8bkOx3Qv
         J9m6/enDZT7gnoLBTSF+czidNB3R4axJ2mQral/H2jL3e3kctnC/MGV0FE+qGzoczqvZ
         HTVQ==
X-Gm-Message-State: AOJu0Yx8UpCFn67R0C5NwfFT+UvRPcHb/xnYs0Z5+yPi89T9VfR96mMp
	Wzepfke/jKDlXWnQt3oxLnxq25SBZ1y050xXP6vUpRXQ
X-Google-Smtp-Source: AGHT+IGm1ZGJk3ox2bxydp+8/wjpHsrQAoM2tv/1YrdblOlHFy8wrHmJpZOI8PXQ5LMbYps+cSK2eFCKvh11aVTmrlA=
X-Received: by 2002:aa7:d69a:0:b0:522:57d9:6553 with SMTP id
 d26-20020aa7d69a000000b0052257d96553mr9827064edr.1.1692749605075; Tue, 22 Aug
 2023 17:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com> <20230822050558.2937659-4-davemarchevsky@fb.com>
In-Reply-To: <20230822050558.2937659-4-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Aug 2023 17:13:13 -0700
Message-ID: <CAEf4BzaFSdJLqN+KTT0=DOTQM1X_ULVnuqwE6ge3mBm4+=DRpg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: Add tests for open-coded
 task_vma iter
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, yonghong.song@linux.dev, 
	sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 10:06=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb=
.com> wrote:
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
>  .../selftests/bpf/progs/iters_task_vma.c      | 56 +++++++++++++++
>  2 files changed, 127 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testi=
ng/selftests/bpf/prog_tests/iters.c
> index 10804ae5ae97..f91f4a49066a 100644
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

why marking prog with SEC("?") just to explicitly enable autoload for
it? Just drop "?" in the first place?

> +
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
> +       iters_task_vma__detach(skel);
> +       getpgid(skel->bss->target_pid);

Is this a trigger for the program? If yes, it's confusing that it
happens after skeleton detach. Is this intentional?

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
> index 000000000000..b961d0a12223
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
> @@ -0,0 +1,56 @@
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
> +
> +SEC("?raw_tp/sys_enter")
> +int iter_task_vma_for_each(const void *ctx)
> +{
> +       struct task_struct *task =3D bpf_get_current_task_btf();
> +       struct vm_area_struct *vma;
> +       unsigned long *start, *end;
> +
> +       if (task->pid !=3D target_pid)
> +               return 0;
> +
> +       bpf_for_each(task_vma, vma, task, 0) {
> +               if (vmas_seen >=3D 1000)
> +                       break;
> +

this test is not idempotent, if there will be more than one syscall,
you'll keep incrementing vmas_seen. This might result in flaky test,
so I'd suggest to recalculate vmas_seen each time, as a local counter,
and then at the end writing it to global var:


int zero;
int vmas_seen;


...


int seen =3D zero;

... all the same logic but using seen as a key ...


vmas_seen =3D seen.

> +               start =3D bpf_map_lookup_elem(&vm_start, &vmas_seen);
> +               if (!start)
> +                       break;
> +               *start =3D vma->vm_start;
> +
> +               end =3D bpf_map_lookup_elem(&vm_end, &vmas_seen);
> +               if (!end)
> +                       break;
> +               *end =3D vma->vm_end;
> +
> +               vmas_seen++;
> +       }
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.34.1
>


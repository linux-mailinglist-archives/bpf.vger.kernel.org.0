Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78BD495673
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 23:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiATWsP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 17:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiATWsP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 17:48:15 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A29C061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 14:48:14 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id y22so8795545iof.7
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 14:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cx3flyL3QcBnLSHIb8If1aNg/Z1kZBmP+dAjnbueDgc=;
        b=H5h0tqWnyr9t6Izinecw+a+CqMzG5C1MMap5EplX4DJAjHQwSO7bQ3H9KhmlKyt/t1
         VsX6GXXDIaDusoA2NxP1NWy8Olckg0iO0a1oPFjDgGYJSagGM4TKsFNScF3j7nH1Y1Pe
         wpCjQAXKHFEP/cGL0nBO+lpqDQi+Rny5U5vGo8GngnfqqCTHH81JjsgufLVbC/cFwWXk
         8b1PVaOMZbaHI57DAWZO/4paUdZ2uMg3Ne171t0JapGBHMQgEm/7672UYoWb70nEnOsG
         lJ8jJK+vlljxdT+tW23fY0jMRRgSI29/btPhQfYrq+41cLBwEBxbIcfUORPgenvqx4wi
         /tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cx3flyL3QcBnLSHIb8If1aNg/Z1kZBmP+dAjnbueDgc=;
        b=phgpH6tjm0Fm2keCCz3B6oXw0YE8wqnb6XA51YIAPi+j8V+GpkOkZssTtRtpy2PqT+
         g9kiUcvXALoWzb4ERm5KIbOC5X8DHR+IxvOYD97iXnrrqk1jnurLCcUeOraVTkGFO5rV
         Gg8e1FrwcfBdSnQABFZmXwxabmL8KSpz/mAAC66VCHWd6ExesMyl9spe3/pkNEZeLw0O
         zo/b37wgZcO8EBZS2Hj45VQA5ceFvfSlEI+UxRF2iiDLsjOK+muCuIyrzsTjRmPy/DUa
         wZ1sDM9dlplBc8XDDeV4y8KtVGOydOMliSxnhORNkFjNm5IKV2NyUFzX755f8q9+ZSFn
         Y6aQ==
X-Gm-Message-State: AOAM533uJxumbb/FMYWCZan/v6O+unYR2y51xuQnGMVpxdPViOzdf7jO
        c26DDXHmRONGOJAaclzz9xwPl/gOh6PigB9QBM4=
X-Google-Smtp-Source: ABdhPJzz9c5aPv/zjZdmjAwaNiw4lpzDU6GoiY6vcjFYdx3SwJjijLmipSAsDDOf0sYeG8lQP/1jph29/b9ic2ODkPE=
X-Received: by 2002:a05:6638:2a7:: with SMTP id d7mr450611jaq.93.1642718894330;
 Thu, 20 Jan 2022 14:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220120172942.246805-1-kennyyu@fb.com>
 <20220120172942.246805-4-kennyyu@fb.com>
In-Reply-To: <20220120172942.246805-4-kennyyu@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Jan 2022 14:48:03 -0800
Message-ID: <CAEf4BzYD-f0g8_zo-wet1Rdz=hKEaOa0NZ=_GjRFntPw2FnbRA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/3] selftests/bpf: Add test for sleepable bpf
 iterator programs
To:     Kenny Yu <kennyyu@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Gabriele <phoenix1987@gmail.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 20, 2022 at 9:30 AM Kenny Yu <kennyyu@fb.com> wrote:
>
> This adds a test for bpf iterator programs to make use of sleepable
> bpf helpers.
>
> Signed-off-by: Kenny Yu <kennyyu@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 19 ++++++++
>  .../selftests/bpf/progs/bpf_iter_task.c       | 47 +++++++++++++++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index b84f859b1267..f6fb4f95513d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -138,6 +138,23 @@ static void test_task(void)
>         bpf_iter_task__destroy(skel);
>  }
>
> +static void test_task_sleepable(void)
> +{
> +       struct bpf_iter_task *skel;
> +
> +       skel = bpf_iter_task__open_and_load();
> +       if (CHECK(!skel, "bpf_iter_task__open_and_load",
> +                 "skeleton open_and_load failed\n"))

Please use ASSERT_OK_PTR() instead.

> +               return;
> +
> +       do_dummy_read(skel->progs.dump_task_sleepable);
> +
> +       ASSERT_GT(skel->bss->num_success_access_process_vm, 0,
> +                 "num_success_access_process_vm");
> +
> +       bpf_iter_task__destroy(skel);
> +}
> +
>  static void test_task_stack(void)
>  {
>         struct bpf_iter_task_stack *skel;
> @@ -1252,6 +1269,8 @@ void test_bpf_iter(void)
>                 test_bpf_map();
>         if (test__start_subtest("task"))
>                 test_task();
> +       if (test__start_subtest("task_sleepable"))
> +               test_task_sleepable();
>         if (test__start_subtest("task_stack"))
>                 test_task_stack();
>         if (test__start_subtest("task_file"))
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> index c86b93f33b32..3fa735af96f7 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2020 Facebook */
>  #include "bpf_iter.h"
>  #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
>
>  char _license[] SEC("license") = "GPL";
>
> @@ -23,3 +24,49 @@ int dump_task(struct bpf_iter__task *ctx)
>         BPF_SEQ_PRINTF(seq, "%8d %8d\n", task->tgid, task->pid);
>         return 0;
>  }
> +
> +int num_success_access_process_vm = 0;
> +
> +SEC("iter.s/task")
> +int dump_task_sleepable(struct bpf_iter__task *ctx)
> +{
> +       struct seq_file *seq = ctx->meta->seq;
> +       struct task_struct *task = ctx->task;
> +       static const char info[] = "    === END ===";
> +       struct pt_regs *regs;
> +       void *ptr;
> +       uint32_t user_data = 0;
> +       int numread;
> +
> +       if (task == (void *)0) {
> +               BPF_SEQ_PRINTF(seq, "%s\n", info);
> +               return 0;
> +       }
> +
> +       regs = (struct pt_regs *)bpf_task_pt_regs(task);
> +       if (regs == (void *)0) {
> +               BPF_SEQ_PRINTF(seq, "%s\n", info);
> +               return 0;
> +       }
> +       ptr = (void *)PT_REGS_IP(regs);
> +
> +       /* Try to read the contents of the task's instruction pointer from the
> +        * remote task's address space.
> +        */
> +       numread = bpf_access_process_vm(&user_data,
> +                                       sizeof(uint32_t),
> +                                       ptr,
> +                                       task,
> +                                       0);

nit: keep it on one line (up to 100 characters is ok)


> +       if (numread != sizeof(uint32_t)) {
> +               BPF_SEQ_PRINTF(seq, "%s\n", info);
> +               return 0;
> +       }
> +       ++num_success_access_process_vm;
> +
> +       if (ctx->meta->seq_num == 0)
> +               BPF_SEQ_PRINTF(seq, "    tgid      gid     data\n");
> +
> +       BPF_SEQ_PRINTF(seq, "%8d %8d %8d\n", task->tgid, task->pid, user_data);
> +       return 0;
> +}
> --
> 2.30.2
>

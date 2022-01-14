Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78248E292
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 03:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiANCjf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 21:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbiANCje (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jan 2022 21:39:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B9FC061574
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 18:39:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso20636089pjo.5
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 18:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jl9/Sp9gINb5hA0cwlAJvDuqDqGiYbvzGd2bxlpFmsU=;
        b=bUeOn9x95d/X0YnnHh5PvRwI40eqv3qz1/bnKHhPTf27whEL+c9LJd6iu41Q/xpj5F
         qJd/77NHtPU55GQ25QxKX1BufUepMmDCRx2VQhyTmQGJ4cT4jmHI5cGb0yMIOen0fRbZ
         4oIFgRZC4+fhFmHMb1iRNWLQQbDGeOEHrsjWgi6McCZfstJu8s5qE4hJeQZO0Kv3If+3
         wXAcycohjznMuRp2AeUidk+Q3y7CfCqMqeaZD02cYVe9BKbNTOte7/5fU2URbSgt2ECv
         DTmMucCchYzuodByQvTHz8dmlA1n0HeJ5nMKxI57fENOYFTOKZhcFrhbDCbz2McElfFm
         EtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jl9/Sp9gINb5hA0cwlAJvDuqDqGiYbvzGd2bxlpFmsU=;
        b=NI8/IKDxHBEVYqtAwVtr5OeyLZk8D2TZfXY5WfIaN2dfdTosnCGj/8pgk/9VLJVt8F
         MCo7QYUZVT9/nXYFjrHIR8cEEIZ/EZ1iSY25cOxbPgsiRhbFsyDlc7c+PJ3J58RUQsc2
         0KU7PwDP5ge20wv+AvGfuLomwkwo806vlmkfmbSiPT38vGjuuV81VnNlo98um7hF8d9g
         iP1lAZFYye+wghTfcQBEGiVYC+zrP0HqKMAS1RlHUgRHv2Q6sERuQLn8cM2yFcHpxcaO
         +yqXXEQ1P1WruDLQI7kR4X9p7WZiu79HMZK3GGJ9ase7fzSnUoIMCrJTkJn2sw02Y5CW
         PMBw==
X-Gm-Message-State: AOAM533afwwQifSOHDURI1k/x7SQtV1XExG1rLXQMUcMpIIU/vkvZcr8
        Vm7ZfNV+pJKFYO3W9HMfWQH87+/kLbRB8q8auIM=
X-Google-Smtp-Source: ABdhPJyTstVlOlK2Pnss3JaDQ0BM7nEj9EzMU2HXFWjaRCz5Ns43tEI/1qSoc8ZHkIi/Ksx10xtGGdpSbBUAiBD5ZJw=
X-Received: by 2002:a17:902:6502:b0:149:1162:f0b5 with SMTP id
 b2-20020a170902650200b001491162f0b5mr7168338plk.126.1642127974171; Thu, 13
 Jan 2022 18:39:34 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220114004900.3756025-1-kennyyu@fb.com>
 <20220114004900.3756025-5-kennyyu@fb.com>
In-Reply-To: <20220114004900.3756025-5-kennyyu@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 13 Jan 2022 18:39:23 -0800
Message-ID: <CAADnVQ+nS1++7NwcAPuwO26CcuvNnPVMQgtwi4FDNcmHQEBm8g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftests/bpf: Add test for sleepable bpf
 iterator programs
To:     Kenny Yu <kennyyu@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 13, 2022 at 4:49 PM Kenny Yu <kennyyu@fb.com> wrote:
>
> This adds a test for bpf iterator programs to make use of sleepable
> bpf helpers.
>
> Signed-off-by: Kenny Yu <kennyyu@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 16 ++++++
>  .../selftests/bpf/progs/bpf_iter_task.c       | 54 +++++++++++++++++++
>  2 files changed, 70 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index b84f859b1267..fcda0ecd8746 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -138,6 +138,20 @@ static void test_task(void)
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
> +               return;
> +
> +       do_dummy_read(skel->progs.dump_task_sleepable);
> +
> +       bpf_iter_task__destroy(skel);
> +}
> +
>  static void test_task_stack(void)
>  {
>         struct bpf_iter_task_stack *skel;
> @@ -1252,6 +1266,8 @@ void test_bpf_iter(void)
>                 test_bpf_map();
>         if (test__start_subtest("task"))
>                 test_task();
> +       if (test__start_subtest("task_sleepable"))
> +               test_task_sleepable();
>         if (test__start_subtest("task_stack"))
>                 test_task_stack();
>         if (test__start_subtest("task_file"))
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> index c86b93f33b32..bb4b63043533 100644
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
> @@ -23,3 +24,56 @@ int dump_task(struct bpf_iter__task *ctx)
>         BPF_SEQ_PRINTF(seq, "%8d %8d\n", task->tgid, task->pid);
>         return 0;
>  }
> +
> +// New helper added
> +static long (*bpf_access_process_vm)(
> +       struct task_struct *tsk,
> +       unsigned long addr,
> +       void *buf,
> +       int len,
> +       unsigned int gup_flags) = (void *)186;

This shouldn't be needed.
Since patch 1 updates tools/include/uapi/linux/bpf.h
it will be in bpf_helper_defs.h automatically.

> +
> +// Copied from include/linux/mm.h
> +#define FOLL_REMOTE 0x2000 /* we are working on non-current tsk/mm */

Please use C style comments only.

> +       numread = bpf_access_process_vm(task,
> +                                       (unsigned long)ptr,
> +                                       (void *)&user_data,
> +                                       sizeof(uint32_t),
> +                                       FOLL_REMOTE);

We probably would need to hide flags like FOLL_REMOTE
inside the helper otherwise prog might confuse the kernel.
In this case I'm not even sure that FOLL_REMOTE is needed.
I suspect gup_flags=0 in all cases will work fine.
We're not doing write here and not pining anything.
fast_gup is not necessary either.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115F8191DC9
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 00:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCXXzM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 19:55:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34258 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgCXXzM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 19:55:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id 10so677482qtp.1;
        Tue, 24 Mar 2020 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4taz7mXl8pptyKy6vTsxg6OtEjU4FBkuE1nJ/DIKuA=;
        b=RoJn6fp1RJn8aZlfOCSg3bf8t0mKDJrGg4m+LHhDBZQFbF20gzLqL9NlP5RqwqGpXz
         evGuJZIK10Jngzmu4bLBPmwZ3Dkj64w0RLl/1nBW31qbA77gaKhyNLsURbDB4cvqcElw
         ijZ2dWBJMsT6oMsn6SM3dawVros6CKVA4P6vJKavXXqvdDvMrlm8RYmgVJ6RRu1Yr4Zd
         bzsz2H29+FhNg+B81wCZ24Ktiv0MnP60a1YY0MpSL+aVEwVsNVlvzdNdDkbORqKoX6G1
         C2bhcN/htFQH6W/2ga0awyd675P1FYrwpGvJczFhWVfbARM8xdaxDjHG2eFCAZljtLoh
         H6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4taz7mXl8pptyKy6vTsxg6OtEjU4FBkuE1nJ/DIKuA=;
        b=C/6q2o2f2Rh1x+KzmRD1ojYLSz7lRkGUSjWIGVcVMvi0oWt7c4dGwCZ/XmthHVEyz2
         L/lmrND9YIqErSEhWfQ3otdcsrcQpFaGsaLYPnN/Cw6Wj5IangbQmKz1eqAp9w3fUw4e
         wGY2dv0FQn1ge2vVCudVYT3+kONOGv7nYbP0MtoLHBP+MF89xXkJEtAhzalMcEZNCsAQ
         hWVmhvNf+wPUhxoWf/GgvYxkeSyh3RVG0RR+FnvpHZxW7DrQZ2QMNk7GYDkayWduwpMD
         mQMmzwvbg8UK49KQ6sWHdzVZ9hsZfJwdcAQvtlg0MmTuT1NKxXm06aqN2puYrocPTsPn
         UsSQ==
X-Gm-Message-State: ANhLgQ2q9zgvRbFUXrPfNlkOCfCIHc2alV3ocdSH6pQJ+aemNcEz5iAG
        7c2OXoP2dnsi/ZzZYWBU9lt+qjRWgEKrS9SA97w=
X-Google-Smtp-Source: ADFU+vvjtuH2GgiZHGdGFZLEpP9ltYzxWBH9++ulCCIuTz1xtjwtmXEQpwGNTPGEc1XYNHIHWCdk5Em7vkw3NQu8ZFM=
X-Received: by 2002:ac8:6f1b:: with SMTP id g27mr431798qtv.117.1585094109999;
 Tue, 24 Mar 2020 16:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-8-kpsingh@chromium.org>
In-Reply-To: <20200323164415.12943-8-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 24 Mar 2020 16:54:59 -0700
Message-ID: <CAEf4BzZCVqpUDqGetxa=Nx1ZC7Q+2yX2D9FMwywWkFDoN8JHDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 7/7] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> * Load/attach a BPF program to the file_mprotect (int) and
>   bprm_committed_creds (void) LSM hooks.
> * Perform an action that triggers the hook.
> * Verify if the audit event was received using a shared global
>   result variable.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> ---
>  tools/testing/selftests/bpf/lsm_helpers.h     |  19 +++
>  .../selftests/bpf/prog_tests/lsm_test.c       | 112 ++++++++++++++++++
>  .../selftests/bpf/progs/lsm_int_hook.c        |  54 +++++++++
>  .../selftests/bpf/progs/lsm_void_hook.c       |  41 +++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/lsm_helpers.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm_int_hook.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm_void_hook.c
>
> diff --git a/tools/testing/selftests/bpf/lsm_helpers.h b/tools/testing/selftests/bpf/lsm_helpers.h
> new file mode 100644
> index 000000000000..3de230df93db
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/lsm_helpers.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +#ifndef _LSM_HELPERS_H
> +#define _LSM_HELPERS_H
> +
> +struct lsm_prog_result {
> +       /* This ensures that the LSM Hook only monitors the PID requested
> +        * by the loader
> +        */
> +       __u32 monitored_pid;
> +       /* The number of calls to the prog for the monitored PID.
> +        */
> +       __u32 count;
> +};
> +

Having this extra header just for this simple struct... On BPF side
it's easier and nicer to just use global variables. Can you please
drop helper and just pass two variables in prog_test part?

> +#endif /* _LSM_HELPERS_H */
> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_test.c b/tools/testing/selftests/bpf/prog_tests/lsm_test.c
> new file mode 100644
> index 000000000000..5fd6b8f569f7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_test.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#include <test_progs.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <malloc.h>
> +#include <stdlib.h>
> +
> +#include "lsm_helpers.h"
> +#include "lsm_void_hook.skel.h"
> +#include "lsm_int_hook.skel.h"
> +
> +char *LS_ARGS[] = {"true", NULL};
> +
> +int heap_mprotect(void)
> +{
> +       void *buf;
> +       long sz;
> +
> +       sz = sysconf(_SC_PAGESIZE);
> +       if (sz < 0)
> +               return sz;
> +
> +       buf = memalign(sz, 2 * sz);
> +       if (buf == NULL)
> +               return -ENOMEM;
> +
> +       return mprotect(buf, sz, PROT_READ | PROT_EXEC);
> +}
> +
> +int exec_ls(struct lsm_prog_result *result)
> +{
> +       int child_pid;
> +
> +       child_pid = fork();
> +       if (child_pid == 0) {
> +               result->monitored_pid = getpid();

monitored_pid needed here only

> +               execvp(LS_ARGS[0], LS_ARGS);
> +               return -EINVAL;
> +       } else if (child_pid > 0)
> +               return wait(NULL);
> +
> +       return -EINVAL;
> +}
> +
> +void test_lsm_void_hook(void)
> +{
> +       struct lsm_prog_result *result;
> +       struct lsm_void_hook *skel = NULL;
> +       int err, duration = 0;
> +
> +       skel = lsm_void_hook__open_and_load();
> +       if (CHECK(!skel, "skel_load", "lsm_void_hook skeleton failed\n"))
> +               goto close_prog;
> +
> +       err = lsm_void_hook__attach(skel);
> +       if (CHECK(err, "attach", "lsm_void_hook attach failed: %d\n", err))
> +               goto close_prog;
> +
> +       result = &skel->bss->result;

if you define variables directly, you'll access them easily as
skel->bss->monitored_pid and skel->bss->count, no problem, right?

> +
> +       err = exec_ls(result);
> +       if (CHECK(err < 0, "exec_ls", "err %d errno %d\n", err, errno))
> +               goto close_prog;
> +
> +       if (CHECK(result->count != 1, "count", "count = %d", result->count))
> +               goto close_prog;
> +
> +       CHECK_FAIL(result->count != 1);
> +
> +close_prog:
> +       lsm_void_hook__destroy(skel);
> +}
> +
> +void test_lsm_int_hook(void)
> +{
> +       struct lsm_prog_result *result;
> +       struct lsm_int_hook *skel = NULL;
> +       int err, duration = 0;
> +
> +       skel = lsm_int_hook__open_and_load();
> +       if (CHECK(!skel, "skel_load", "lsm_int_hook skeleton failed\n"))
> +               goto close_prog;
> +
> +       err = lsm_int_hook__attach(skel);
> +       if (CHECK(err, "attach", "lsm_int_hook attach failed: %d\n", err))
> +               goto close_prog;
> +
> +       result = &skel->bss->result;
> +       result->monitored_pid = getpid();
> +
> +       err = heap_mprotect();
> +       if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
> +                 errno))
> +               goto close_prog;
> +
> +       CHECK_FAIL(result->count != 1);
> +
> +close_prog:
> +       lsm_int_hook__destroy(skel);
> +}
> +
> +void test_lsm_test(void)
> +{
> +       test_lsm_void_hook();
> +       test_lsm_int_hook();

These should be subtests (see test__start_subtest() usage). Also, I'm
not sure why you need two separate BPF programs, why not create one
and use it for two subtests?


> +}
> diff --git a/tools/testing/selftests/bpf/progs/lsm_int_hook.c b/tools/testing/selftests/bpf/progs/lsm_int_hook.c
> new file mode 100644
> index 000000000000..1c5028ddca61
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lsm_int_hook.c

consider it a nit because not every test follows this, but using
progs/test_whatever.c for BPF side and prog_test/whatever.c makes my
life a bit easier.


> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2020 Google LLC.
> + */
> +
> +#include <linux/bpf.h>
> +#include <stdbool.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include  <errno.h>
> +#include "lsm_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct lsm_prog_result result = {
> +       .monitored_pid = 0,
> +       .count = 0,
> +};
> +
> +/*
> + * Define some of the structs used in the BPF program.
> + * Only the field names and their sizes need to be the
> + * same as the kernel type, the order is irrelevant.
> + */
> +struct mm_struct {
> +       unsigned long start_brk, brk;
> +} __attribute__((preserve_access_index));
> +
> +struct vm_area_struct {
> +       unsigned long vm_start, vm_end;
> +       struct mm_struct *vm_mm;
> +} __attribute__((preserve_access_index));

Why not just using vmlinux.h instead?

> +
> +SEC("lsm/file_mprotect")
> +int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
> +            unsigned long reqprot, unsigned long prot, int ret)
> +{
> +       if (ret != 0)
> +               return ret;
> +
> +       __u32 pid = bpf_get_current_pid_tgid();
> +       int is_heap = 0;
> +
> +       is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> +                  vma->vm_end <= vma->vm_mm->brk);
> +
> +       if (is_heap && result.monitored_pid == pid) {
> +               result.count++;
> +               ret = -EPERM;
> +       }
> +
> +       return ret;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/lsm_void_hook.c b/tools/testing/selftests/bpf/progs/lsm_void_hook.c
> new file mode 100644
> index 000000000000..4d01a8536413
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lsm_void_hook.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#include <linux/bpf.h>
> +#include <stdbool.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include  <errno.h>
> +#include "lsm_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct lsm_prog_result result = {
> +       .monitored_pid = 0,
> +       .count = 0,
> +};
> +
> +/*
> + * Define some of the structs used in the BPF program.
> + * Only the field names and their sizes need to be the
> + * same as the kernel type, the order is irrelevant.
> + */
> +struct linux_binprm {
> +       const char *filename;
> +} __attribute__((preserve_access_index));
> +
> +SEC("lsm/bprm_committed_creds")
> +int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
> +{
> +       __u32 pid = bpf_get_current_pid_tgid();
> +       char fmt[] = "lsm(bprm_committed_creds): process executed %s\n";

Try static char fmt[] = "..." instead and then compare BPF assembly
before and after, you'll be amazed ;)

> +
> +       bpf_trace_printk(fmt, sizeof(fmt), bprm->filename);

is this part of test?

> +       if (result.monitored_pid == pid)
> +               result.count++;
> +
> +       return 0;
> +}
> --
> 2.20.1
>

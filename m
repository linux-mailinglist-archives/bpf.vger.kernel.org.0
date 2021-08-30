Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703413FBEFC
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 00:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhH3W3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 18:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbhH3W3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 18:29:36 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8B2C061575;
        Mon, 30 Aug 2021 15:28:42 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r4so31205968ybp.4;
        Mon, 30 Aug 2021 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyAtVf/6yEiE0t0ja+MeKq6vxzNNbDAXD01T20t+3OI=;
        b=LqJperIu1X8LF3VFCx/EcxDLgCvZ6139jR8s59iBi4z5/m2LES766WSJH9AuRE0N19
         Id18eRNZGT6GnuPqJ2wuhnEDDg3NhsyXP+YqXBlXjwjaZJhcowmUggaRmQXQXTja+5TA
         oLyWjiwEM2/ViRhYIlE80/1JJ8urlA+6SSn2qtWP/OOvdTHyxAuDHicAn6Lvs8tioH9q
         eqTqYNPYeGAly1/85C72cj8d78Qbm6NWDR83WtoDzCxDBm85nNulLmMBlmW2/Z9YeEbt
         Y2DIw25KZI9Sns+rwpLP/0cVuk4d/NWSVKDGhF9/KjE0D/m80ocF37zJZUV/9LKRbc53
         hvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyAtVf/6yEiE0t0ja+MeKq6vxzNNbDAXD01T20t+3OI=;
        b=glIPY/JtYFPWtAxu2VwqOJ+eASxMnVLnR3aZ075nFiMlor5byaxlmbtWiPbCRLjJL5
         b/g17JVWm9PazQxNGpyFIKAom8o485wuzqdjmbPwSpk2usXO5gsJwPhYkaU2A/G0W6Wx
         W77Re5pFP1wWPjQgm2GDqu0LMMrkE6yN3qtBN3osZzve/qvtM5fc4OnyUd3QW/QlePZ4
         fyupfWj31nMX5O2NY7S+UsiiszAUIhJfEuMRVIT+xh2IfrD7lNTzjKk9xfXdeo8HzBCQ
         KrbxBseBkzsj4ZV9SiNroVScn1Gt6Mi15Z9VzbCypVSHzJao8iV7OQpY7DJi1gjNqHhy
         cbDQ==
X-Gm-Message-State: AOAM530fU+Ea0whFs3YMIdf30Z13qJMhqXmDCpD982dgDymY6jqZ2X+h
        SbjDlqXge5euxdLCq8Qfp+aMHeyPimUFdTUdzWQ=
X-Google-Smtp-Source: ABdhPJxnsV5k49WkOGTIk4AqnMT2FGa5gFmdARoKd7th+oPOdhiqDFxcjQJflQMV0m8D1H4whYmOVf05B0VOhPuVcXs=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr27641866ybg.347.1630362521228;
 Mon, 30 Aug 2021 15:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210830214106.4142056-1-songliubraving@fb.com> <20210830214106.4142056-4-songliubraving@fb.com>
In-Reply-To: <20210830214106.4142056-4-songliubraving@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Aug 2021 15:28:30 -0700
Message-ID: <CAEf4BzZK4vW0-sP7sF7vo2=fbw=mpvyGLN+v6v7KbkkL9bva9A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add test for bpf_get_branch_snapshot
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 30, 2021 at 2:44 PM Song Liu <songliubraving@fb.com> wrote:
>
> This test uses bpf_get_branch_snapshot from a fexit program. The test uses
> a target kernel function (bpf_fexit_loop_test1) and compares the record
> against kallsyms. If there isn't enough record matching kallsyms, the
> test fails.
>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  net/bpf/test_run.c                            |  15 ++-
>  .../bpf/prog_tests/get_branch_snapshot.c      | 106 ++++++++++++++++++
>  .../selftests/bpf/progs/get_branch_snapshot.c |  41 +++++++
>  tools/testing/selftests/bpf/trace_helpers.c   |  30 +++++
>  tools/testing/selftests/bpf/trace_helpers.h   |   5 +
>  5 files changed, 196 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
>  create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 2eb0e55ef54d2..6cc179a532c9c 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -231,6 +231,18 @@ struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
>         return sk;
>  }
>
> +noinline int bpf_fexit_loop_test1(int n)

We have bpf_testmod as part of selftests now, which allows us to add
whatever in-kernel functionality we need, without polluting the kernel
itself. fentry/fexit attach to kernel functions works as well, so do
you think we can use that here for testing?

> +{
> +       int i, sum = 0;
> +
> +       /* the primary goal of this test is to test LBR. Create a lot of
> +        * branches in the function, so we can catch it easily.
> +        */
> +       for (i = 0; i < n; i++)
> +               sum += i;
> +       return sum;
> +}
> +
>  __diag_pop();
>
>  ALLOW_ERROR_INJECTION(bpf_modify_return_test, ERRNO);
> @@ -293,7 +305,8 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
>                     bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
>                     bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111 ||
>                     bpf_fentry_test7((struct bpf_fentry_test_t *)0) != 0 ||
> -                   bpf_fentry_test8(&arg) != 0)
> +                   bpf_fentry_test8(&arg) != 0 ||
> +                   bpf_fexit_loop_test1(101) != 5050)
>                         goto out;
>                 break;
>         case BPF_MODIFY_RETURN:
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> new file mode 100644
> index 0000000000000..9bb16826418fb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include <test_progs.h>
> +#include "get_branch_snapshot.skel.h"
> +
> +static int *pfd_array;
> +static int cpu_cnt;
> +
> +static int create_perf_events(void)
> +{
> +       struct perf_event_attr attr = {0};
> +       int cpu;
> +
> +       /* create perf event */
> +       attr.size = sizeof(attr);
> +       attr.type = PERF_TYPE_RAW;
> +       attr.config = 0x1b00;
> +       attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
> +       attr.branch_sample_type = PERF_SAMPLE_BRANCH_KERNEL |
> +               PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
> +
> +       cpu_cnt = libbpf_num_possible_cpus();
> +       pfd_array = malloc(sizeof(int) * cpu_cnt);
> +       if (!pfd_array) {
> +               cpu_cnt = 0;
> +               return 1;
> +       }
> +
> +       for (cpu = 0; cpu < libbpf_num_possible_cpus(); cpu++) {

nit: use cpu_cnt from above?

> +               pfd_array[cpu] = syscall(__NR_perf_event_open, &attr,
> +                                        -1, cpu, -1, PERF_FLAG_FD_CLOEXEC);
> +               if (pfd_array[cpu] < 0)
> +                       break;
> +       }
> +
> +       return cpu == 0;
> +}
> +
> +static void close_perf_events(void)
> +{
> +       int cpu = 0;
> +       int fd;
> +
> +       while (cpu++ < cpu_cnt) {
> +               fd = pfd_array[cpu];
> +               if (fd < 0)
> +                       break;
> +               close(fd);
> +       }
> +       free(pfd_array);
> +}
> +
> +void test_get_branch_snapshot(void)
> +{
> +       struct get_branch_snapshot *skel;
> +       int err, prog_fd;
> +       __u32 retval;
> +
> +       if (create_perf_events()) {
> +               test__skip();  /* system doesn't support LBR */
> +               goto cleanup;

Cleanup inside create_perf_events() and just return here. Or at least
initialize skel to NULL above, otherwise __destroy() below will cause
SIGSEGV, most probably.

> +       }
> +
> +       skel = get_branch_snapshot__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "get_branch_snapshot__open_and_load"))
> +               goto cleanup;
> +
> +       err = kallsyms_find("bpf_fexit_loop_test1", &skel->bss->address_low);
> +       if (!ASSERT_OK(err, "kallsyms_find"))
> +               goto cleanup;
> +
> +       err = kallsyms_find_next("bpf_fexit_loop_test1", &skel->bss->address_high);
> +       if (!ASSERT_OK(err, "kallsyms_find_next"))
> +               goto cleanup;
> +
> +       err = get_branch_snapshot__attach(skel);
> +       if (!ASSERT_OK(err, "get_branch_snapshot__attach"))
> +               goto cleanup;
> +
> +       prog_fd = bpf_program__fd(skel->progs.test1);
> +       err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
> +                               NULL, 0, &retval, NULL);
> +
> +       if (!ASSERT_OK(err, "bpf_prog_test_run"))
> +               goto cleanup;
> +
> +       if (skel->bss->total_entries < 16) {
> +               /* too few entries for the hit/waste test */
> +               test__skip();
> +               goto cleanup;
> +       }
> +
> +       ASSERT_GT(skel->bss->test1_hits, 5, "find_test1_in_lbr");
> +
> +       /* Given we stop LBR in software, we will waste a few entries.
> +        * But we should try to waste as few as possibleentries. We are at

s/possibleentries/possible entries/

> +        * about 7 on x86_64 systems.
> +        * Add a check for < 10 so that we get heads-up when something
> +        * changes and wastes too many entries.
> +        */
> +       ASSERT_LT(skel->bss->wasted_entries, 10, "check_wasted_entries");
> +
> +cleanup:
> +       get_branch_snapshot__destroy(skel);
> +       close_perf_events();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/get_branch_snapshot.c b/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
> new file mode 100644
> index 0000000000000..9c944e7480b95
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u64 test1_hits = 0;
> +__u64 address_low = 0;
> +__u64 address_high = 0;
> +int wasted_entries = 0;
> +long total_entries = 0;
> +
> +#define MAX_LBR_ENTRIES 32

see my comment on another patch, if kernel defines this constant as
enum, we'll automatically get it from vmlinux.h.

> +
> +struct perf_branch_entry entries[MAX_LBR_ENTRIES] = {};
> +
> +
> +static inline bool in_range(__u64 val)
> +{
> +       return (val >= address_low) && (val < address_high);
> +}
> +

[...]

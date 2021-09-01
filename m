Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231313FD20B
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 06:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhIAEJ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 00:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIAEJz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 00:09:55 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155EFC061575;
        Tue, 31 Aug 2021 21:08:59 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z18so2560699ybg.8;
        Tue, 31 Aug 2021 21:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4T6MpzYWaQVP7um/e/Du343DWTOvDE+C03sra0qPBIk=;
        b=WGBmb8M/vFrlx3/toZSSDbVUD9cViBwQl1L2jjh9j/wzYwyKMSWmyCreoQBYHhBqJQ
         3BxQaCdVs1AwUVzJzUO63+RJiucH+Q4R3yEvITR0Iaq8iShJUHNsx78n4AwJ8JDVHzfu
         abr9jg1DtNXvOtVUYuzlEHqNtNtz7FxvgdK+WDCjtBJsSTekL/sBf2G2UA30lrKLn3NX
         PQ/kTneSQchfHlpw1zuEO3gtD2WdrhPql0tmp/f5nPTJjodc6jbYLwGRGZm6wYTgnZss
         9l21FjpO2C1HwOpPMYxpNsi0bbwV0/TMCF9CJ95v3GSxtSu5APFulU/+2A+aBIyHVmVB
         Cczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4T6MpzYWaQVP7um/e/Du343DWTOvDE+C03sra0qPBIk=;
        b=cqZojPVL1pQiw986u05RrIX8XBo1RxkbBcK9kJ8mXSHwK2bPo4N3lKxSNV+cY78Jxu
         qks1r3e7Nce7sILB7ZB1Dw4oAf52bFpODCmnAkSC7FkAQDe4COXsErOdbyHqV0w1xC+u
         tzA1bcUWJzKA3y+Znl+OuRtNqzLzpz+LTXE84xEky5l/3nHeNkpMHEbQssYG6ETF/Qp+
         u6VVxpZI9eDOudjnXUYQVS4tALGeEXE+dhsPlkGXaqeqZGXhNwFQvGBl0jbIr36PWLi3
         pwm6l7iup2gAmEWNxnsyYqV32YwKgPo7yuCCKQm1sBxdQs1B2YN15D+tuXmdkenbwHgE
         LwzA==
X-Gm-Message-State: AOAM531OBa52AVoqbwEDinWy0OPQaz8L0Jeno6P9Es3nnUJ9ygTRLRHs
        N8Qb9EbFxT4vlOExOR5JhQ7Wd7jCp5fLYuq83+c=
X-Google-Smtp-Source: ABdhPJx0KQievz8CGByVCBB9wA9HsV7RMN304eYLbOtjjIXRLcrg9gUf8unSMQ0zCkQ6R0wNKFLyjwssmsKlAH8lwWg=
X-Received: by 2002:a25:4941:: with SMTP id w62mr35416729yba.230.1630469338253;
 Tue, 31 Aug 2021 21:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210901003517.3953145-1-songliubraving@fb.com> <20210901003517.3953145-4-songliubraving@fb.com>
In-Reply-To: <20210901003517.3953145-4-songliubraving@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Aug 2021 21:08:47 -0700
Message-ID: <CAEf4BzZrEcZFNSH=YDi_NmT2oqaOhmgQvPv0THXKy4haEzBFvQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: add test for bpf_get_branch_snapshot
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

On Tue, Aug 31, 2021 at 7:01 PM Song Liu <songliubraving@fb.com> wrote:
>
> This test uses bpf_get_branch_snapshot from a fexit program. The test uses
> a target function (bpf_testmod_loop_test) and compares the record against
> kallsyms. If there isn't enough record matching kallsyms, the test fails.
>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---

LGTM, few minor nits below

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  14 ++-
>  .../bpf/prog_tests/get_branch_snapshot.c      | 101 ++++++++++++++++++
>  .../selftests/bpf/progs/get_branch_snapshot.c |  44 ++++++++
>  tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
>  tools/testing/selftests/bpf/trace_helpers.h   |   5 +
>  5 files changed, 200 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
>  create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c
>

[...]

> +
> +void test_get_branch_snapshot(void)
> +{
> +       struct get_branch_snapshot *skel = NULL;
> +       int err;
> +
> +       if (create_perf_events()) {
> +               test__skip();  /* system doesn't support LBR */
> +               goto cleanup;
> +       }
> +
> +       skel = get_branch_snapshot__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "get_branch_snapshot__open_and_load"))
> +               goto cleanup;
> +
> +       err = kallsyms_find("bpf_testmod_loop_test", &skel->bss->address_low);
> +       if (!ASSERT_OK(err, "kallsyms_find"))
> +               goto cleanup;
> +
> +       err = kallsyms_find_next("bpf_testmod_loop_test", &skel->bss->address_high);
> +       if (!ASSERT_OK(err, "kallsyms_find_next"))
> +               goto cleanup;
> +
> +       err = get_branch_snapshot__attach(skel);
> +       if (!ASSERT_OK(err, "get_branch_snapshot__attach"))
> +               goto cleanup;
> +
> +       /* trigger the program */
> +       system("cat /sys/kernel/bpf_testmod > /dev/null 2>& 1");

ugh :( see prog_tests/module_attach.c, we can extract and reuse
trigger_module_test_read() and trigger_module_test_write()

> +
> +       if (skel->bss->total_entries < 16) {
> +               /* too few entries for the hit/waste test */
> +               test__skip();
> +               goto cleanup;
> +       }
> +

[...]

> +SEC("fexit/bpf_testmod_loop_test")
> +int BPF_PROG(test1, int n, int ret)
> +{
> +       long i;
> +
> +       total_entries = bpf_get_branch_snapshot(entries, sizeof(entries), 0);
> +       total_entries /= sizeof(struct perf_branch_entry);
> +
> +       bpf_printk("total_entries %lu\n", total_entries);
> +
> +       for (i = 0; i < PERF_MAX_BRANCH_SNAPSHOT; i++) {
> +               if (i >= total_entries)
> +                       break;
> +               if (in_range(entries[i].from) && in_range(entries[i].to))
> +                       test1_hits++;
> +               else if (!test1_hits)
> +                       wasted_entries++;
> +               bpf_printk("i %d from %llx to %llx", i, entries[i].from,
> +                          entries[i].to);

debug leftovers? this will be polluting trace_pipe unnecessarily; same
for above total_entries bpf_printk()

> +       }
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index e7a19b04d4eaf..5100a169b72b1 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <ctype.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -117,6 +118,42 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
>         return err;
>  }
>

[...]

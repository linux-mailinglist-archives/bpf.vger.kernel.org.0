Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F85A040A
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiHXWbA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiHXWay (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:30:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB915834
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a22so23837682edj.5
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Nwgx2ynzqdPU6CdRwIbzGss6k0QzOq5J9ZUEFliV9Kk=;
        b=oBoI/c4yR0mPHjOHZSE+kvtx+zXzozZjxyJp/fhqNZ0eqo4SwXp3LdrMy/9u4btzw/
         Wku+aBkXvq8Y8PGtYWkr+yYrLoEkdbXaVv6tAN1hWd2xytY16MbSh+PRUi/huePpzdgC
         v6Mh6M1ZP3CX+ml8Z6zSiO5/z1xfzoy11g3CUvdZbXsFD3ZLb0Ns2nx9gRnCqaZKVXCw
         TKsDZQhYnKl67AjMF1H/PFQ985Zut7pKgmHelxPdgwyy4PUXPYVDNbfQtImI78UBjjhv
         MQs31N27WBrX+4lz7zpxsCezIIHbYTt95mefFkP23PMPAjlxORPa5PimvKMQAzEZfSC+
         LSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Nwgx2ynzqdPU6CdRwIbzGss6k0QzOq5J9ZUEFliV9Kk=;
        b=y1TJy+O0IO5ebROpgSQYRjC9PfLqWips2i/YlYDDugGEERT5FTfBhKNizqjxAKUYq6
         CTmFfJbz9dJUL8QEGRExPfbYB8zYpYtewqIUtrcpGCN5ztsekEkk0bxUgowsG2FBmrY0
         kB/sIzIt8QXiqOR9pF7pdoAz8YCuGa+K5ZU94M3Dzcoyx+qkw5pCFtcnmy0yrU6fp+9d
         79agvkuJoBWQHTOmrn1iIIBB0Sku1JMEeIFLN0FiNcrOFHjgWzN6VK/ZzC3OO/DuKWdb
         HYU0F1/HvIUShqT1naGUNE0xcb9+xuWUqB6R8qpwAI1gtB+uTPH6HTQnTfKnuoOTgd2N
         bQ9w==
X-Gm-Message-State: ACgBeo1mj+03wm1+ngrm2NOeY8pXqTZKeyMFKgHcn+5+4ChdGnRavpX1
        VSSoIR4Dg65xMs+aeuuctBSzkKZL9cwU64DIE5mRnxBJ
X-Google-Smtp-Source: AA6agR5B9lovPJPUTXKytJqx5JrGtcaqTXlDNkSS29YdunWXHQiqnoY/wQH0+08htK+nuBiH9oPJHKXdgKJlQJ1XEr0=
X-Received: by 2002:a05:6402:1704:b0:447:811f:1eef with SMTP id
 y4-20020a056402170400b00447811f1eefmr929487edu.14.1661380250161; Wed, 24 Aug
 2022 15:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220819220927.3409575-1-kuifeng@fb.com> <20220819220927.3409575-5-kuifeng@fb.com>
In-Reply-To: <20220819220927.3409575-5-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Aug 2022 15:30:38 -0700
Message-ID: <CAEf4BzYpnp3sYxWe4XWeJZPqi3+NgH4NMqa7X9kbE9y4trs5KQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Test parameterized task
 BPF iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 19, 2022 at 3:09 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Test iterators of vma, files, and tasks of tasks.
>
> Ensure the API works appropriately to visit all tasks,
> tasks in a process, or a particular task.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 284 +++++++++++++++++-
>  .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>  .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
>  .../selftests/bpf/progs/bpf_iter_task_file.c  |   9 +-
>  .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
>  .../bpf/progs/bpf_iter_uprobe_offset.c        |  35 +++
>  6 files changed, 326 insertions(+), 19 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_uprobe_offset.c
>

[...]

> -       do_dummy_read(skel->progs.dump_task);
> +       if (!ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock"))
> +               goto done;
> +       locked = true;
> +
> +       if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
> +                 "pthread_create"))
> +               goto done;
> +
> +

extra empty line

> +       skel->bss->tid = getpid();
> +
> +       do_dummy_read_opts(skel->progs.dump_task, opts);
> +
> +       *num_unknown = skel->bss->num_unknown_tid;
> +       *num_known = skel->bss->num_known_tid;
> +
> +       ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unlock");
> +       locked = false;
> +       ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
> +                    "pthread_join");
>
> +done:
> +       if (locked)

it's a bit of an overkill to expect and handle that
pthread_mutex_lock() might fail, I'd remove those asserts and locked
flag, just assume that lock works (if it's not, it's either test bug
and would be caught early, or something is very broken in the system
anyway)

> +               ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unlock");
>         bpf_iter_task__destroy(skel);
>  }
>

[...]

>  static void test_task_sleepable(void)
>  {
>         struct bpf_iter_task *skel;
> @@ -212,15 +349,13 @@ static void test_task_stack(void)
>         bpf_iter_task_stack__destroy(skel);
>  }
>
> -static void *do_nothing(void *arg)
> -{
> -       pthread_exit(arg);
> -}
> -
>  static void test_task_file(void)
>  {
> +       DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);

DECLARE_LIBBPF_OPTS is discouraged, best to use shorter LIBBPF_OPTS

>         struct bpf_iter_task_file *skel;
> +       union bpf_iter_link_info linfo;
>         pthread_t thread_id;
> +       bool locked = false;
>         void *ret;
>
>         skel = bpf_iter_task_file__open_and_load();
> @@ -229,19 +364,43 @@ static void test_task_file(void)
>
>         skel->bss->tgid = getpid();
>
> -       if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing, NULL),
> +       if (!ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock"))
> +               goto done;
> +       locked = true;

same about failing mutex_lock, it shouldn't and it's fair to expect
that it won't

> +
> +       if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
>                   "pthread_create"))
>                 goto done;
>
> -       do_dummy_read(skel->progs.dump_task_file);
> +       memset(&linfo, 0, sizeof(linfo));
> +       linfo.task.tid = getpid();
> +       opts.link_info = &linfo;
> +       opts.link_info_len = sizeof(linfo);

[...]

> +       link = bpf_program__attach_iter(skel->progs.get_uprobe_offset, opts);
> +       if (!ASSERT_OK_PTR(link, "attach_iter"))
> +               return;
> +
> +       iter_fd = bpf_iter_create(bpf_link__fd(link));
> +       if (!ASSERT_GT(iter_fd, 0, "create_iter"))
> +               goto exit;
> +
> +       while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> +               ;
> +       CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));

no checks, please

> +       buf[15] = 0;
> +       ASSERT_EQ(strcmp(buf, "OK\n"), 0, "strcmp");
> +
> +       ASSERT_EQ(skel->bss->offset, get_uprobe_offset(trigger_func), "offset");
> +       if (one_proc)
> +               ASSERT_EQ(skel->bss->unique_tgid_cnt, 1, "unique_tgid_count");
> +       else
> +               ASSERT_GT(skel->bss->unique_tgid_cnt, 1, "unique_tgid_count");
> +
> +       close(iter_fd);
> +
> +exit:
> +       bpf_link__destroy(link);
> +}
> +
> +static void test_task_uprobe_offset(void)
> +{
> +       LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +       union bpf_iter_link_info linfo;
> +
> +       memset(&linfo, 0, sizeof(linfo));
> +       linfo.task.pid = getpid();
> +       opts.link_info = &linfo;
> +       opts.link_info_len = sizeof(linfo);
> +
> +       test_task_uprobe_offset_common(&opts, true);
> +
> +       linfo.task.pid = 0;
> +       linfo.task.tid = getpid();
> +       test_task_uprobe_offset_common(&opts, true);
> +
> +       test_task_uprobe_offset_common(NULL, false);
> +}
> +
>  void test_bpf_iter(void)
>  {
> +       if (!ASSERT_OK(pthread_mutex_init(&do_nothing_mutex, NULL), "pthread_mutex_init"))
> +               return;
> +

ditto, too paranoid, IMO

>         if (test__start_subtest("btf_id_or_null"))
>                 test_btf_id_or_null();
>         if (test__start_subtest("ipv6_route"))

[...]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_uprobe_offset.c b/tools/testing/selftests/bpf/progs/bpf_iter_uprobe_offset.c
> new file mode 100644
> index 000000000000..825ca86678bd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_uprobe_offset.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#include "bpf_iter.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u32 unique_tgid_cnt = 0;
> +uintptr_t address = 0;
> +uintptr_t offset = 0;
> +__u32 last_tgid = 0;
> +__u32 pid = 0;
> +
> +SEC("iter/task_vma") int get_uprobe_offset(struct bpf_iter__task_vma *ctx)

please keep SEC() on separate line

> +{
> +       struct vm_area_struct *vma = ctx->vma;
> +       struct seq_file *seq = ctx->meta->seq;
> +       struct task_struct *task = ctx->task;
> +
> +       if (task == NULL || vma == NULL)
> +               return 0;
> +
> +       if (last_tgid != task->tgid)
> +               unique_tgid_cnt++;
> +       last_tgid = task->tgid;
> +
> +       if (task->tgid != pid)
> +               return 0;
> +
> +       if (vma->vm_start <= address && vma->vm_end > address) {
> +               offset = address - vma->vm_start + (vma->vm_pgoff << 12);

it's best not to assume page_size is 4K, you can pass actual value
through global variable from user-space (we've previously fixed a
bunch of tests with fixed page_size assumption as they break some
platforms, let's not regress that)

> +               BPF_SEQ_PRINTF(seq, "OK\n");
> +       }
> +       return 0;
> +}
> --
> 2.30.2
>

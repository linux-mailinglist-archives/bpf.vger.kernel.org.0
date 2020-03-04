Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75E71799A6
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 21:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgCDUV3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 15:21:29 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44482 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDUV3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 15:21:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id h16so2396800qtr.11
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 12:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Torqc2hw6eTqzTBLMreD9yKyrOC2qtCB9FiPqIOS1FQ=;
        b=MRVbhvIxUh+RPFiEjW91ktqkipdHMiAcRU5vMgCn8qRG6Yp0EFdjK4P1aNDv+aMV82
         khWQ9Lzlzl3LJitNSTR8G2uEDz98I7yHAPHg6t0l5FYKKKbnr+Y2qXhqa1mQ2mShZ83X
         XvYqfH8Z3sU8+0xTZ4ctny9YhMNXrrClfR9bqK0xb11IoY/KRAaZ9ALcmmlonWotVxJ+
         6V7eHbW8Ri1xXT31O+1pLJBhgWLssSoryOtdhBk40Hm1ceivv0AXOoQDO0qL+49bATZz
         o15+82m73loyJ9JGsZ3Z/y8WHPdN41JInB4Yxvs4FyAoWCU/RVdUS/qKOYwULqU6Oz5L
         oJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Torqc2hw6eTqzTBLMreD9yKyrOC2qtCB9FiPqIOS1FQ=;
        b=hmcdEj2RSm/ML/5Hi0+3yT8CY+i+KKnKICCmRip603qqYJTWT02gzG3CzrrRuKClRy
         E5eWi5xcwCmHW4E5JZWyJ+MgLiZfU2rtsQG93kgl8vsmBbJoMdTOcp80aFL9IM1KtLLv
         6gyT0qzSNLAeYWAISwJqyBsT0MsQh6S85EdgL+YFQYwsXXOStSLcSMb9fZhx7DCa1A7w
         dPX9zdjJBYCoJ1ZFpFwI5/Em76TdGxlc5Yb+ZJNjVginQrGCkZyAKfJ+iNPZ9xaLFOZZ
         UaRRIU4sgfwCkh/NfB6vt+YB3MAD0XfRnmcN9815wx4QRUobaoVERl90fodqK3KIA8Fk
         EGLg==
X-Gm-Message-State: ANhLgQ0sinaeC31pGzQ3SJiWqW2Z4D9mrhWMMPTzECTSFu4+HhlxBLed
        D1H8BoW1wxaJALASO3xP4AqrzCofjc7Yf5wvjJc=
X-Google-Smtp-Source: ADFU+vsabLtjcPcHn2jFQzTu9eYSziklvZtvJ70DfVHnIO7BqJZZXM96IEMMYPz/9xM93BmIJqwLSKPzy8oSVPJfan8=
X-Received: by 2002:ac8:140c:: with SMTP id k12mr4022064qtj.117.1583353286640;
 Wed, 04 Mar 2020 12:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20200304191104.2796444-1-yhs@fb.com> <20200304191105.2796601-1-yhs@fb.com>
In-Reply-To: <20200304191105.2796601-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Mar 2020 12:21:15 -0800
Message-ID: <CAEf4BzaVoMg+gPxFb539jFsHP3A5j-ogbUtGQFOYzHVu5_dnWQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add send_signal_sched_switch test
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 4, 2020 at 11:11 AM Yonghong Song <yhs@fb.com> wrote:
>
> Added one test, send_signal_sched_switch, to test bpf_send_signal()
> helper triggered by sched/sched_switch tracepoint. This test can be used
> to verify kernel deadlocks fixed by the previous commit. The test itself
> is heavily borrowed from Commit eac9153f2b58 ("bpf/stackmap: Fix deadlock
> with rq_lock in bpf_get_stack()").
>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  .../bpf/prog_tests/send_signal_sched_switch.c | 60 +++++++++++++++++++
>  .../bpf/progs/test_send_signal_kern.c         |  6 ++
>  2 files changed, 66 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
> new file mode 100644
> index 000000000000..189a34a7addb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mman.h>
> +#include <pthread.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include "test_send_signal_kern.skel.h"
> +
> +static void sigusr1_handler(int signum)
> +{
> +}
> +
> +#define THREAD_COUNT 100
> +
> +static void *worker(void *p)
> +{
> +       int i;
> +
> +       for ( i = 0; i < 1000; i++)
> +               usleep(1);
> +
> +       return NULL;
> +}
> +
> +void test_send_signal_sched_switch(void)
> +{
> +       struct test_send_signal_kern *skel;
> +       pthread_t threads[THREAD_COUNT];
> +       u32 duration = 0;
> +       int i, err;
> +
> +       signal(SIGUSR1, sigusr1_handler);
> +
> +       skel = test_send_signal_kern__open_and_load();
> +       if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n"))
> +               return;
> +
> +       skel->bss->pid = getpid();
> +       skel->bss->sig = SIGUSR1;
> +
> +       err = test_send_signal_kern__attach(skel);
> +       if (CHECK(err, "skel_attach", "skeleton attach failed\n"))
> +               goto destroy_skel;
> +
> +       for (i = 0; i < THREAD_COUNT; i++) {
> +               err = pthread_create(threads + i, NULL, worker, NULL);
> +               if (CHECK(err, "pthread_create", "Error creating thread, %s\n",
> +                         strerror(errno)))
> +                       goto destroy_skel;
> +       }
> +
> +       for (i = 0; i < THREAD_COUNT; i++)
> +               pthread_join(threads[i], NULL);
> +
> +destroy_skel:
> +       test_send_signal_kern__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> index 1acc91e87bfc..b4233d3efac2 100644
> --- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> @@ -31,6 +31,12 @@ int send_signal_tp(void *ctx)
>         return bpf_send_signal_test(ctx);
>  }
>
> +SEC("tracepoint/sched/sched_switch")
> +int send_signal_tp_sched(void *ctx)
> +{
> +       return bpf_send_signal_test(ctx);
> +}
> +
>  SEC("perf_event")
>  int send_signal_perf(void *ctx)
>  {
> --
> 2.17.1
>

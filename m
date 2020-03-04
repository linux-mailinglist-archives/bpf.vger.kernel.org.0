Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A379179790
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 19:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgCDSJB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 13:09:01 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42702 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDSJB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 13:09:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id e11so2545890qkg.9
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 10:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HQDI8W38B2b+ITmuYUoXj4RE85qyJ6t4qnrDBeqmUs=;
        b=IK1Ob35Q0/yI4KvBkYzF9HrHtf+Tuws1IrNp/hymBLuBj6h6fBrpEZl/8ym7eFB4kF
         fRtHPLtalndVtTRqreAgF8PwKK3awOZZcn0HsMYLBQDkjBlRBD4o9fTD6gmmQDeqNaR4
         Bj5OAVmBBOmhDHiB4eBaB8l0ZMTKfrzZIkXO2u+U4i/mJ/1sXXWe+D04j+WKcpt21NDn
         XzWAQfpHh1sHPL6JmAFWOnVXsNVP3R+0ZXH20VtGvFChsSXmFY19yonftidP8tY8lyts
         ATIiv5jRM/eCbnDWNJjZ+iyvDLDCvq7xV4SCTm8hyfcVfcS2OhB/kyg25TpOIzQRof2W
         +lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HQDI8W38B2b+ITmuYUoXj4RE85qyJ6t4qnrDBeqmUs=;
        b=p7ZXMRi6fxOTzsR2OmGaYhgo0oAajuNSN3tI5rATqqUrpuqyr5LUHBQG73ddwDG1AW
         X7bs76Sw4ISiBiKxxY2MCcXhdJoKVg9emJPuwYwN2u0N1uUgUiixkgAOVc0ih1eQmdt6
         I8xK8faChWQK2HqdYYT47FfsnL9gIgXZqyISamU8TXKZ2jLZH6WVpVp4f63Ef3L6Rkh1
         P8mhEmXuCVlzxCiPZCekl1UdjGmRd37VcC8HmaPX3nRy96a/rAebfShNRsm22qxFhmEj
         XfOsHj3CpYyotXZzqAtpNEqLHaTxpD+9nYokSPMM9dQiPQkXuypXH9GRhmpXYrsc3QPM
         d3AQ==
X-Gm-Message-State: ANhLgQ0ZnfYKhMcB+SQ6RyjV2frKIxyv4ZYiGXNMvTM0+qALwX2kpMLL
        jUbzhg5GpBbi5zVk1eGvz2QTgt8ixxikV2Rtb2GOqDr9NaU=
X-Google-Smtp-Source: ADFU+vvBj4PEpLzh3WDIPRo3UYScobthD5hElGbo3Ieit4Ss8rDvSYH9V7zLHVoITsyW0FcxLaWYZNHvTMulRxnYqsw=
X-Received: by 2002:a05:620a:99d:: with SMTP id x29mr4160118qkx.39.1583345339947;
 Wed, 04 Mar 2020 10:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20200304175310.2389842-1-yhs@fb.com> <20200304175311.2389987-1-yhs@fb.com>
In-Reply-To: <20200304175311.2389987-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Mar 2020 10:08:48 -0800
Message-ID: <CAEf4BzZxwAbdMA+SPNkA_ZoBGd_q0Pr1jC5xT1hPdUq3pC+v3A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: add send_signal_sched_switch test
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

On Wed, Mar 4, 2020 at 9:53 AM Yonghong Song <yhs@fb.com> wrote:
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
>  .../bpf/prog_tests/send_signal_sched_switch.c | 89 +++++++++++++++++++
>  .../bpf/progs/test_send_signal_kern.c         |  6 ++
>  2 files changed, 95 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
> new file mode 100644
> index 000000000000..f5c9dbdeb173
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
> @@ -0,0 +1,89 @@
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
> +static char *filename;
> +
> +static void *worker(void *p)
> +{
> +       int err, fd, i = 0;
> +       u32 duration = 0;
> +       char *pptr;
> +       void *ptr;
> +
> +       fd = open(filename, O_RDONLY);
> +       if (CHECK(fd < 0, "open", "open failed %s\n", strerror(errno)))
> +               return NULL;
> +
> +       while (i < 100) {
> +               struct timespec ts = {0, 1000 + rand() % 2000};
> +
> +               ptr = mmap(NULL, 4096 * 64, PROT_READ, MAP_PRIVATE, fd, 0);
> +               err = errno;
> +               usleep(1);
> +               if (CHECK(ptr == MAP_FAILED, "mmap", "mmap failed: %s\n",
> +                         strerror(err)))
> +                       break;
> +
> +               munmap(ptr, 4096 * 64);
> +               usleep(1);
> +               pptr = malloc(1);
> +               usleep(1);
> +               pptr[0] = 1;
> +               usleep(1);
> +               free(pptr);
> +               usleep(1);
> +               nanosleep(&ts, NULL);
> +               i++;


Any specific reason to do mmap()/munmap() in a loop? Would, say,
getpid syscall work just fine as well to trigger a bunch of context
switches? Or event just usleep(1) alone?

> +       }
> +       close(fd);
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
> +       filename = "/bin/ls";
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

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C733EF22E
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhHQSqD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 14:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhHQSqD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Aug 2021 14:46:03 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B71C061764
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 11:45:29 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z18so136075ybg.8
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+tInrvJ7CUYwlekzzJlKguhzAJobr/3oalPqDBs7G4=;
        b=D0o3z17aVqMG4LSEiL8FoSZtSRFGui5xECGqWncG8ka+Vap+2SoZvH3OgygZ7tofm+
         5A8qHsLq0IxjCWGFWBWfIJ2njBuivca6t2xV0cTqp0no9jZiNjWJlPYCRc/NoDexxo8R
         ZCOHsiAqyQhDg8iVx3qPTwnu2e6RXWGxYEPz4fGMVgeh0srwneKauxcphX+/Q2BNa03U
         jKmfNCQXhou/ZdL4oR25NN7z633sdBFDkxgsAhfQjYnWbPUv73eCFR6b0Lvydie3ApwJ
         oehd6aTSGKh7d1WCU5dk78RlPrrBWX6AiIMh2d984pEO1Cr/iWPdnQ1CXFT+f2J3HaVl
         zBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+tInrvJ7CUYwlekzzJlKguhzAJobr/3oalPqDBs7G4=;
        b=korJeHXKPHw6nxGXaWxKWCwo1kmpwxjAKt0zFFSi7d1aLw37+E3o0SNLMqrC1SDuoT
         hXeSqY8IwuhVULON4txGSRI4pWOjogT4GeQzocElXGcKIagKPx7pRz1OhbyfvQt5lnJq
         Oh2I8PvNA8uclj+ssyw2beUwx5hEUYDQ3VE1WRr+uPFyclTE38oCITeVgkeOn1eAyoIJ
         k/SxOWLlABG2y6wSF9cJwGkLCBI8Rl9mWBjMZPCGvjp0MluXioXDXo7hkNbi8j+6hvk6
         Ziyv/EqiNRk7G4uPm6CHYb1VvCtebRCw1W3vYu3cfNmQPOSMRFJ8VkJ0N77bEQlWd5Zw
         0KCQ==
X-Gm-Message-State: AOAM531se6sV5bOMh4TZz0h+tz6IjiteJbfdcRMbjQP5wF9ehvyRTUB+
        WlxJXiZQpOjO4mQLwIyD6TSWsPhAZEO8TsJvbGk=
X-Google-Smtp-Source: ABdhPJytdPwi/W2kq94Hg44zLubU2zlTKnKN7UTL79x4lbwvUFE/Ytz0DuXqPd2jeXLB7MowFnCEnZVn+vuCEw77qwg=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr6295200ybg.347.1629225929059;
 Tue, 17 Aug 2021 11:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210817171958.2769074-1-yhs@fb.com> <20210817172009.2770161-1-yhs@fb.com>
In-Reply-To: <20210817172009.2770161-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 Aug 2021 11:45:18 -0700
Message-ID: <CAEf4BzbKJH6uyOCUswitC0VL+ayt9br15ppYdPE2JYxe6w_N_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: fix flaky send_signal test
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 17, 2021 at 10:20 AM Yonghong Song <yhs@fb.com> wrote:
>
> libbpf CI has reported send_signal test is flaky although
> I am not able to reproduce it in my local environment.
> But I am able to reproduce with on-demand libbpf CI ([1]).
>
> Through code analysis, the following is possible reason.
> The failed subtest runs bpf program in softirq environment.
> Since bpf_send_signal() only sends to a fork of "test_progs"
> process. If the underlying current task is
> not "test_progs", bpf_send_signal() will not be triggered
> and the subtest will fail.
>
> To reduce the chances where the underlying process is not
> the intended one, this patch boosted scheduling priority to
> -20 (highest allowed by setpriority() call). And I did
> 10 runs with on-demand libbpf CI with this patch and I
> didn't observe any failures.
>
>  [1] https://github.com/libbpf/libbpf/actions/workflows/ondemand.yml
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/send_signal.c    | 33 +++++++++++++++----
>  .../bpf/progs/test_send_signal_kern.c         |  3 +-
>  2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index 41e158ae888e..0701c97456da 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
>  #include "test_send_signal_kern.skel.h"
>
>  int sigusr1_received = 0;
> @@ -10,7 +12,7 @@ static void sigusr1_handler(int signum)
>  }
>
>  static void test_send_signal_common(struct perf_event_attr *attr,
> -                                   bool signal_thread)
> +                                   bool signal_thread, bool allow_skip)
>  {
>         struct test_send_signal_kern *skel;
>         int pipe_c2p[2], pipe_p2c[2];
> @@ -37,12 +39,23 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>         }
>
>         if (pid == 0) {
> +               int old_prio;
> +
>                 /* install signal handler and notify parent */
>                 signal(SIGUSR1, sigusr1_handler);
>
>                 close(pipe_c2p[0]); /* close read */
>                 close(pipe_p2c[1]); /* close write */
>
> +               /* boost with a high priority so we got a higher chance
> +                * that if an interrupt happens, the underlying task
> +                * is this process.
> +                */
> +               errno = 0;
> +               old_prio = getpriority(PRIO_PROCESS, 0);
> +               ASSERT_OK(errno, "getpriority");
> +               ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
> +
>                 /* notify parent signal handler is installed */
>                 ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>
> @@ -58,6 +71,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>                 /* wait for parent notification and exit */
>                 ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>
> +               /* restore the old priority */
> +               ASSERT_OK(setpriority(PRIO_PROCESS, 0, old_prio), "setpriority");
> +
>                 close(pipe_c2p[1]);
>                 close(pipe_p2c[0]);
>                 exit(0);
> @@ -110,11 +126,16 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>                 goto disable_pmu;
>         }
>
> -       ASSERT_EQ(buf[0], '2', "incorrect result");
> -
>         /* notify child safe to exit */
>         ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
>
> +       if (skel->bss->status == 0 && allow_skip) {
> +               printf("%s:SKIP\n", __func__);
> +               test__skip();
> +       } else if (skel->bss->status != 1) {
> +               ASSERT_EQ(buf[0], '2', "incorrect result");
> +       }
> +
>  disable_pmu:
>         close(pmu_fd);
>  destroy_skel:
> @@ -127,7 +148,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>
>  static void test_send_signal_tracepoint(bool signal_thread)
>  {
> -       test_send_signal_common(NULL, signal_thread);
> +       test_send_signal_common(NULL, signal_thread, false);
>  }
>
>  static void test_send_signal_perf(bool signal_thread)
> @@ -138,7 +159,7 @@ static void test_send_signal_perf(bool signal_thread)
>                 .config = PERF_COUNT_SW_CPU_CLOCK,
>         };
>
> -       test_send_signal_common(&attr, signal_thread);
> +       test_send_signal_common(&attr, signal_thread, true);
>  }
>
>  static void test_send_signal_nmi(bool signal_thread)
> @@ -167,7 +188,7 @@ static void test_send_signal_nmi(bool signal_thread)
>                 close(pmu_fd);
>         }
>
> -       test_send_signal_common(&attr, signal_thread);
> +       test_send_signal_common(&attr, signal_thread, true);
>  }
>
>  void test_send_signal(void)
> diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> index b4233d3efac2..59c05c422bbd 100644
> --- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> @@ -18,8 +18,7 @@ static __always_inline int bpf_send_signal_test(void *ctx)
>                         ret = bpf_send_signal_thread(sig);
>                 else
>                         ret = bpf_send_signal(sig);
> -               if (ret == 0)
> -                       status = 1;
> +               status = (ret == 0) ? 1 : 2;

This doesn't make sense to me. status == 0 is the default value, it
will stay 0 even if nothing is triggered, no BPF program is called,
etc.

If we are doing the skipping of the test logic (which I'd honestly
just not do right now to see if we actually fixed the test), then I'd
set status = 3 for the case when signal was triggered, but the current
task is not test_progs. And only skip test if we get status 3. That
is, status 0 and status 2 are bad (either not triggered, or some error
when sending signal), 1 is OK, 3 is SKIP.

But really, skipping a test that we couldn't randomly run doesn't feel
good. Can you please leave the priority boosting part and drop the
skipping part for now?

>         }
>
>         return 0;
> --
> 2.30.2
>

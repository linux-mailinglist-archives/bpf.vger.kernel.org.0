Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD93EF275
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhHQTHV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 15:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhHQTHU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Aug 2021 15:07:20 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79660C061764
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 12:06:47 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id w17so217398ybl.11
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBe266FDNkDkzz+UxrckCLFtTrP3aZShNH5JMkV+JDA=;
        b=jAijsK1MUxcGA1vEqgh7P5BIavr4KOgtlBxpZeuI1g1gZ/FN2o6XwXZs97Oi2Vigd3
         51kqni75WwGghxqHtKVSafiWqfw/hnf10L8l/ikmgrOVrOrSu6ifRHEKvZzKImKxHAxl
         mJEiHB7X8TaMwnI6ga+pr5XKYz5YBSfJz3qkPcRyAp+l7DeWN40KAmDOuHCn4evRz40q
         j9Fk8B4aJdDSnTfrHu2Fd2reXlbk2HHG6USYGXwX+jxRMx5aigNRFJH2i1wp0nXil/hi
         KP1+YExlewN0lu+F7g/IgxEudW5LkYqdSOImQ8ISzVeSc8Xvvnq2HWsF/IPlqxUPEmZV
         YbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBe266FDNkDkzz+UxrckCLFtTrP3aZShNH5JMkV+JDA=;
        b=Joa9KuV540hk4hZ8bmL7/xbTIMoMhp1XlQHLbjpAbnkBzf1dBrWxIp6iw381DSPXfx
         Td41+qI4eOOT82gkYvfSUIY5iafSOzAzAunusLgDITZFOGAZoOyZ1OmsM6UG9RKOdXuM
         V7kB5+WDa5yTPWd8I+4voAcibU+On7o2wxbD3KJGVfyXg46cLQUwBN0mX8qBg9Eh3OAM
         S76Q3b+iomkCMEuRc6bGdMeov6sOfaXl3tFHiVwXQJKMZ56cYB0CbyULPLWiRVlhEb5G
         i5O7eUM6Ipl/fY6ARvl7fWQtECwGSwg//sSSjlfyqNVRqHSbuCpxkxWVeewrRihDY3/T
         GejQ==
X-Gm-Message-State: AOAM531StwVzAXuEZ7I3p6k8kIdbNIAHndVEuHj8aBM1PVI0Hn5Jt6FG
        eCebZz2n9jIZPYrQmdnLMe9Q0mowAxvXfjjtSpg=
X-Google-Smtp-Source: ABdhPJwK5k0VwRD8STs/OVhOku/TPPR0w0Y74h5BS5DqUfElO9/skqnprjUdQAQae0YZNLLWdF3cnL04ZPTR8bjHPJE=
X-Received: by 2002:a25:4091:: with SMTP id n139mr6177656yba.425.1629227206729;
 Tue, 17 Aug 2021 12:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210817171958.2769074-1-yhs@fb.com> <20210817172009.2770161-1-yhs@fb.com>
 <CAEf4BzbKJH6uyOCUswitC0VL+ayt9br15ppYdPE2JYxe6w_N_Q@mail.gmail.com> <00fd2f7d-d19b-d442-5d0e-4c05f65d7d68@fb.com>
In-Reply-To: <00fd2f7d-d19b-d442-5d0e-4c05f65d7d68@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 Aug 2021 12:06:35 -0700
Message-ID: <CAEf4BzYFb1XRng+O=g=YKkZzSAP6Bys8Qgt-4m8DBzAnSyvQPg@mail.gmail.com>
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

On Tue, Aug 17, 2021 at 12:01 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/17/21 11:45 AM, Andrii Nakryiko wrote:
> > On Tue, Aug 17, 2021 at 10:20 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> libbpf CI has reported send_signal test is flaky although
> >> I am not able to reproduce it in my local environment.
> >> But I am able to reproduce with on-demand libbpf CI ([1]).
> >>
> >> Through code analysis, the following is possible reason.
> >> The failed subtest runs bpf program in softirq environment.
> >> Since bpf_send_signal() only sends to a fork of "test_progs"
> >> process. If the underlying current task is
> >> not "test_progs", bpf_send_signal() will not be triggered
> >> and the subtest will fail.
> >>
> >> To reduce the chances where the underlying process is not
> >> the intended one, this patch boosted scheduling priority to
> >> -20 (highest allowed by setpriority() call). And I did
> >> 10 runs with on-demand libbpf CI with this patch and I
> >> didn't observe any failures.
> >>
> >>   [1] https://github.com/libbpf/libbpf/actions/workflows/ondemand.yml
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   .../selftests/bpf/prog_tests/send_signal.c    | 33 +++++++++++++++----
> >>   .../bpf/progs/test_send_signal_kern.c         |  3 +-
> >>   2 files changed, 28 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> >> index 41e158ae888e..0701c97456da 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> >> @@ -1,5 +1,7 @@
> >>   // SPDX-License-Identifier: GPL-2.0
> >>   #include <test_progs.h>
> >> +#include <sys/time.h>
> >> +#include <sys/resource.h>
> >>   #include "test_send_signal_kern.skel.h"
> >>
> >>   int sigusr1_received = 0;
> >> @@ -10,7 +12,7 @@ static void sigusr1_handler(int signum)
> >>   }
> >>
> >>   static void test_send_signal_common(struct perf_event_attr *attr,
> >> -                                   bool signal_thread)
> >> +                                   bool signal_thread, bool allow_skip)
> >>   {
> >>          struct test_send_signal_kern *skel;
> >>          int pipe_c2p[2], pipe_p2c[2];
> >> @@ -37,12 +39,23 @@ static void test_send_signal_common(struct perf_event_attr *attr,
> >>          }
> >>
> >>          if (pid == 0) {
> >> +               int old_prio;
> >> +
> >>                  /* install signal handler and notify parent */
> >>                  signal(SIGUSR1, sigusr1_handler);
> >>
> >>                  close(pipe_c2p[0]); /* close read */
> >>                  close(pipe_p2c[1]); /* close write */
> >>
> >> +               /* boost with a high priority so we got a higher chance
> >> +                * that if an interrupt happens, the underlying task
> >> +                * is this process.
> >> +                */
> >> +               errno = 0;
> >> +               old_prio = getpriority(PRIO_PROCESS, 0);
> >> +               ASSERT_OK(errno, "getpriority");
> >> +               ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
> >> +
> >>                  /* notify parent signal handler is installed */
> >>                  ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
> >>
> >> @@ -58,6 +71,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
> >>                  /* wait for parent notification and exit */
> >>                  ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
> >>
> >> +               /* restore the old priority */
> >> +               ASSERT_OK(setpriority(PRIO_PROCESS, 0, old_prio), "setpriority");
> >> +
> >>                  close(pipe_c2p[1]);
> >>                  close(pipe_p2c[0]);
> >>                  exit(0);
> >> @@ -110,11 +126,16 @@ static void test_send_signal_common(struct perf_event_attr *attr,
> >>                  goto disable_pmu;
> >>          }
> >>
> >> -       ASSERT_EQ(buf[0], '2', "incorrect result");
> >> -
> >>          /* notify child safe to exit */
> >>          ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
> >>
> >> +       if (skel->bss->status == 0 && allow_skip) {
> >> +               printf("%s:SKIP\n", __func__);
> >> +               test__skip();
> >> +       } else if (skel->bss->status != 1) {
> >> +               ASSERT_EQ(buf[0], '2', "incorrect result");
> >> +       }
> >> +
> >>   disable_pmu:
> >>          close(pmu_fd);
> >>   destroy_skel:
> >> @@ -127,7 +148,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
> >>
> >>   static void test_send_signal_tracepoint(bool signal_thread)
> >>   {
> >> -       test_send_signal_common(NULL, signal_thread);
> >> +       test_send_signal_common(NULL, signal_thread, false);
> >>   }
> >>
> >>   static void test_send_signal_perf(bool signal_thread)
> >> @@ -138,7 +159,7 @@ static void test_send_signal_perf(bool signal_thread)
> >>                  .config = PERF_COUNT_SW_CPU_CLOCK,
> >>          };
> >>
> >> -       test_send_signal_common(&attr, signal_thread);
> >> +       test_send_signal_common(&attr, signal_thread, true);
> >>   }
> >>
> >>   static void test_send_signal_nmi(bool signal_thread)
> >> @@ -167,7 +188,7 @@ static void test_send_signal_nmi(bool signal_thread)
> >>                  close(pmu_fd);
> >>          }
> >>
> >> -       test_send_signal_common(&attr, signal_thread);
> >> +       test_send_signal_common(&attr, signal_thread, true);
> >>   }
> >>
> >>   void test_send_signal(void)
> >> diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> >> index b4233d3efac2..59c05c422bbd 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> >> @@ -18,8 +18,7 @@ static __always_inline int bpf_send_signal_test(void *ctx)
> >>                          ret = bpf_send_signal_thread(sig);
> >>                  else
> >>                          ret = bpf_send_signal(sig);
> >> -               if (ret == 0)
> >> -                       status = 1;
> >> +               status = (ret == 0) ? 1 : 2;
> >
> > This doesn't make sense to me. status == 0 is the default value, it
> > will stay 0 even if nothing is triggered, no BPF program is called,
> > etc.
>
> that is true.
>
> >
> > If we are doing the skipping of the test logic (which I'd honestly
> > just not do right now to see if we actually fixed the test), then I'd
> > set status = 3 for the case when signal was triggered, but the current
> > task is not test_progs. And only skip test if we get status 3. That
> > is, status 0 and status 2 are bad (either not triggered, or some error
> > when sending signal), 1 is OK, 3 is SKIP.
>
> Here, we *assume* bpf program always got called which should be the case
> unless softirq/nmi logic goes wrong. so status = 0 means
> pid doesn't match, and status = 1 means good bpf_send_signal happens,
> status = 2 means bpf_send_signal helper fails.

Sorry, I didn't make my point clear. I meant that test shouldn't just
assume that BPF program ran, so I'd add

if ((bpf_get_current_pid_tgid() >> 32) == pid) {
   ...
} else {
    status = 3;
}

Just to capture that we did get bpf_send_signal_test() called, but we
didn't have correct current.

But it doesn't matter for now, I'd like to see if prio games get us to
stable tests with no skipping first.


>
> >
> > But really, skipping a test that we couldn't randomly run doesn't feel
> > good. Can you please leave the priority boosting part and drop the
> > skipping part for now?
>
> Sure. Let me drop skipping part. With the patch, I am expecting in
> *most* cases, we should not observe flakiness.

Yep, thanks!

>
> >
> >>          }
> >>
> >>          return 0;
> >> --
> >> 2.30.2
> >>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4494100B3
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhIQVX4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhIQVX4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:23:56 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741E0C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:22:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t4so21713275qkb.9
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nm8Qi2/1QfC1AY/INtKTGsOhznxmaLST8aLiGERjfhA=;
        b=LL3poBaVMERQ9qcQTGhZvltWvg7Di0QiChczrap98lwwAWxlgsI4mxZA4GlLpoTGwP
         xLUZfLZCADCgOlMip0L0+Tu6ePeEukSptG1F79yKI4UsciFIRwkfUiICaq+M2wPOkl4K
         SEMoF7OuxVHWcP5MFqMMbh/4eVy6+Lfn2JMjm18rS7ilM2Dudsf6WHiP2EboSCglRsmy
         VTXLEwR/Fb3AJJXV1IIJnr2MsxPQACsQ0W08uqcNoWh5PjV95OcAl4KsCqjrE3WxK3nl
         2VWQXDorJRLDFFS+BQZU5+VGilBoK5ZrjwmqQ0Q6MN+p9f68jJba0yoXE7J1T32cvfbV
         /d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nm8Qi2/1QfC1AY/INtKTGsOhznxmaLST8aLiGERjfhA=;
        b=WgJYCJep94x5mQxsGeqI7I7ZuGY0sqDbXF1qOh5gWDD5pzl13IkoUxPF4p+62MHAzq
         WKStjwUoM62jTmXj4j7hxWuBEx6NECPqYxNLy2Re0OMT5hWZ26owvOMz3Y/SLSa6ZM/m
         eb4ZVDieM0AI4JrepkueTzU6IGodmHbE/+8Tc0TdakSGrSpyFOd4Z/Bx1oG0TNXxV9+/
         E9/6M8EZQ0oz1nB4v9g9Sn/jVgtBP5mnQ/CxGnIYhA04y3jDMq7qIzXmSKiZt9JWWNpA
         3FpInfk0+0tCYuvyMFqNioDs+l60IJEQl+zUaOvsWzGgbmZ8BvxSJgdCUhVoeSKbrytb
         MLww==
X-Gm-Message-State: AOAM530gz2kL/IIhDdtbZ4FqoSJpmBWMYLsPaYp4qhFcBaqusQ1YiASm
        KNNZh0bem6d+J4WS0+8NPIrPaWJ/poHVgTVOwE8o4lLf
X-Google-Smtp-Source: ABdhPJwx7+MIcy4hRqspfADcUEVglT2+4/2yvBzbBvMB0tSBD0BRXp3C293fhbgnR0nLk3yi3og0UoTUBrBXs4rtH2w=
X-Received: by 2002:a5b:408:: with SMTP id m8mr16288413ybp.2.1631913752592;
 Fri, 17 Sep 2021 14:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210916032641.1413293-1-fallentree@fb.com> <20210916032641.1413293-4-fallentree@fb.com>
In-Reply-To: <20210916032641.1413293-4-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 14:22:21 -0700
Message-ID: <CAEf4BzZKUAKmoS2zPXSf5GiA+eau9LagQcnXDzengOPdd_qkZQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/3] selftests/bpf: pin some tests to worker 0
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 15, 2021 at 8:26 PM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch modify some tests to provide serial_test_name() instead of
> test_name() to indicate it must run on worker 0. On encountering these tests,
> all other threads will wait on a conditional variable, which worker 0 will
> signal once the tests has finished running.
>
> Additionally, before running the test, thread 0 also check and wait until all
> other threads has finished their current work, to make sure the pinned test
> really are the only test running in the system.
>
> After this change, all tests should pass in '-j' mode.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---

I don't like this approach, it's over-complicated. I see two ways to
do this more simple:

1) Let main process run all the serial tests before even instantiating
workers, then run parallel tests with worker. The benefit of this is
that we can structure code to have main testing loop that in
sequential mode will run both parallel and serial tests, while in
parallel mode will run only serial tests.

2) Teach worker 0 to run all serial tests one by one on start, before
any parallel tests are run. Then we need to teach other workers to
wait for it or teach main process to wait for worker 0 to finish
before dispatching work to worker 1+. I think this is more convoluted
and complicated.

I certainly prefer #1. Additional benefit is that the worker and
server's code would need to work consistently with all the data
structured (preserving error logs until the end), etc. So it's a good
test and forcing function to unify parallel and sequential modes.

WDYT?

>  .../selftests/bpf/prog_tests/bpf_obj_id.c     |   2 +-
>  .../bpf/prog_tests/select_reuseport.c         |   2 +-
>  .../testing/selftests/bpf/prog_tests/timer.c  |   2 +-
>  .../selftests/bpf/prog_tests/xdp_bonding.c    |   2 +-
>  .../selftests/bpf/prog_tests/xdp_link.c       |   2 +-
>  tools/testing/selftests/bpf/test_progs.c      | 112 ++++++++++++++----
>  6 files changed, 95 insertions(+), 27 deletions(-)
>

[...]

> @@ -954,15 +969,42 @@ void *dispatch_thread(void *ctx)
>
>                         test = &prog_test_defs[current_test_idx];
>                         test_to_run = current_test_idx;
> -                       current_test_idx++;
>
> -                       pthread_mutex_unlock(&current_test_lock);
> -               }
> +                       test = &prog_test_defs[test_to_run];

that's the same test as current_test_idx above?...

>
> -               if (!test->should_run) {
> -                       continue;
> -               }
> +                       if (!test->should_run) {
> +                               current_test_idx++;
> +                               pthread_mutex_unlock(&current_test_lock);
> +                               goto next;
> +                       }
> +
> +                       if (is_serial_test(current_test_idx)) {
> +                               if (data->worker_id != 0) {
> +                                       if (env.debug)
> +                                               fprintf(stderr, "[%d]: Waiting for thread 0 to finish serialized test: %d.\n",
> +                                                       data->worker_id, current_test_idx + 1);
> +                                       /* wait for worker 0 to pick this job up and finish */
> +                                       pthread_cond_wait(&wait_for_worker0, &current_test_lock);
> +                                       pthread_mutex_unlock(&current_test_lock);
> +                                       goto next;
> +                               } else {
> +                                       /* wait until all other worker has parked */
> +                                       for (int i = 1; i < env.workers; i++) {
> +                                               if (env.worker_current_test[i] != -1) {
> +                                                       if (env.debug)
> +                                                               fprintf(stderr, "[%d]: Waiting for other threads to finish current test...\n", data->worker_id);
> +                                                       pthread_mutex_unlock(&current_test_lock);
> +                                                       usleep(1 * 1000 * 1000);


hm... I wonder if this contributes to those 20 seconds run time even
for very fast tests...

> +                                                       goto next;
> +                                               }
> +                                       }
> +                               }
> +                       } else {
> +                               current_test_idx++;
> +                       }

[...]

> +       while (!all_finished) {
> +               all_finished = true;
> +               for (int i = 0; i < env.workers; i++) {
> +                       if (!dispatcher_threads[i])
> +                               continue;
> +
> +                       if (pthread_tryjoin_np(dispatcher_threads[i], NULL) == EBUSY) {
> +                               all_finished = false;
> +                               if (!env.debug) continue;
> +                               if (env.worker_current_test[i] == -1)
> +                                       fprintf(stderr, "Still waiting for thread %d (blocked by thread 0).\n", i);
> +                               else
> +                                       fprintf(stderr, "Still waiting for thread %d (test #%d:%s).\n",
> +                                               i, env.worker_current_test[i] + 1,
> +                                               get_test_name(env.worker_current_test[i]));
> +                       } else {
> +                               dispatcher_threads[i] = 0;
> +                       }
>                 }
> +               usleep(10 * 1000 * 1000);

and here you have 10 seconds just waiting doing nothing...

>         }
> +
>         free(dispatcher_threads);
>         free(env.worker_current_test);
>         free(data);
> @@ -1326,6 +1388,12 @@ int main(int argc, char **argv)
>                         test->should_run = true;
>                 else
>                         test->should_run = false;
> +
> +               if (test->run_test == NULL && test->run_serial_test == NULL) {
> +                       fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%sl() defined.\n",

but not both, so let's check !!test->run_test ==
!!test->run_serial_test to make sure that only one is specified

> +                               test->test_num, test->test_name, test->test_name, test->test_name);
> +                       exit(EXIT_ERR_SETUP_INFRA);
> +               }
>         }
>
>         /* ignore workers if we are just listing */
> --
> 2.30.2
>

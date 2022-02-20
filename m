Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688994BCC2F
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 05:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiBTEjg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 23:39:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiBTEjf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 23:39:35 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A565637BEE
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 20:39:15 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id t9so5069997ilf.13
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 20:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C08g1eu04kdHjSgFV+6xBPctE3TS5STUD+QI4LwWJpE=;
        b=AB4AutIcAyen827fJ8HzOFwIsMZvf5LaL8B/mMqjL0R91xGfeSSaw/cedXkRSb78xQ
         QLd7GsI9Ox6ecQdNjVIkGjab7UIWZAXeC4TwQDcX/Wg3De6/M4cCG06TeBmMGaaFFdRv
         u8EVsUoyT8DoK8QucQqxXX3+UaZHT/9iqhBqfKsAqSiHXYPes5WEfl+GfNonNJAMHa8v
         GTVeHADOnena0r9lh7CdoFP6uPNnVzY2NKsin1aN8XLrGrMvxUE2zzYtkIyXQ2RTQvLl
         yWKjVJpq3zRkGr/PuaKHdciAox5W8aEVfPVm8f8e9jY77i8+IzU2lzbNWTE7oZRphUDd
         b96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C08g1eu04kdHjSgFV+6xBPctE3TS5STUD+QI4LwWJpE=;
        b=7GfOjs84ZVbkHs/7iFberur2PcDYA53O+YvJbWrIMzkvwvtGI3Y6e7BHMwpi9ee4Hw
         9nfMTj9czFejd2Gb7Ha3oJeCmuiwwm7+PbnCFMz6AlqbwLn0NeqY9jpyBGvqWCDnE3+B
         AKXUh96+dQV9leLmm7ZVH9TlQJCB6tkhq1ogcv4qfPTe1NBXLA/F/dEVHklSoo3lSMvv
         osT/6hJXKCVGiqmscXeCRF/0yzXjdqKokwaE0TY5naGuFEj8zwn9gX7sgmqsnd6Y6PLq
         0rsASvc6KCSGItVgRcS3D5bXw7RM1G9WEANLSxOMEwfRiuX9Mj5IXwniT9hOoY53KeXK
         DkDw==
X-Gm-Message-State: AOAM5315AW3YC6C/aHFNXEiJJMlY8fy8BcHlikdldUaw+EkuHKIxe+II
        jBsNzZswZQUDLf6x2Fo2rdgpNbzqMopoicNblGADS1LPDzUGZA==
X-Google-Smtp-Source: ABdhPJzE2QaV1xIGe5bk0DYoni7/XUMoa8X167aia1oOI3OXfncI6ec3rZJL0tTk51sp4IVGreadJt5oXPzneL5OXwI=
X-Received: by 2002:a92:d208:0:b0:2c1:1a3c:7b01 with SMTP id
 y8-20020a92d208000000b002c11a3c7b01mr10837359ily.71.1645331955012; Sat, 19
 Feb 2022 20:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20220219003004.1085072-1-mykolal@fb.com>
In-Reply-To: <20220219003004.1085072-1-mykolal@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 19 Feb 2022 20:39:04 -0800
Message-ID: <CAEf4BzahKEObA_quad2M5Rmn42yPCNFAvVUtPVthFi2jPYNpmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 18, 2022 at 4:30 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> In send_signal, replace sleep with dummy cpu intensive computation
> to increase probability of child process being scheduled. Add few
> more asserts.
>
> In find_vma, reduce sample_freq as higher values may be rejected in
> some qemu setups, remove usleep and increase length of cpu intensive
> computation.
>
> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
> higher values may be rejected in some qemu setups
>
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---
>  .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  2 +-
>  tools/testing/selftests/bpf/prog_tests/find_vma.c  |  5 ++---
>  .../selftests/bpf/prog_tests/perf_branches.c       |  4 ++--
>  tools/testing/selftests/bpf/prog_tests/perf_link.c |  2 +-
>  .../testing/selftests/bpf/prog_tests/send_signal.c | 14 ++++++++++----
>  5 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index cd10df6cd0fc..0612e79a9281 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>         attr.type = PERF_TYPE_SOFTWARE;
>         attr.config = PERF_COUNT_SW_CPU_CLOCK;
>         attr.freq = 1;
> -       attr.sample_freq = 4000;
> +       attr.sample_freq = 1000;
>         pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>         if (!ASSERT_GE(pfd, 0, "perf_fd"))
>                 goto cleanup;
> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
> index b74b3c0c555a..acc41223a112 100644
> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
> @@ -30,7 +30,7 @@ static int open_pe(void)
>         attr.type = PERF_TYPE_HARDWARE;
>         attr.config = PERF_COUNT_HW_CPU_CYCLES;
>         attr.freq = 1;
> -       attr.sample_freq = 4000;
> +       attr.sample_freq = 1000;
>         pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>
>         return pfd >= 0 ? pfd : -errno;
> @@ -57,7 +57,7 @@ static void test_find_vma_pe(struct find_vma *skel)
>         if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>                 goto cleanup;
>
> -       for (i = 0; i < 1000000; ++i)
> +       for (i = 0; i < 1000000000; ++i)

1bln seems excessive... maybe 10mln would be enough?

>                 ++j;
>
>         test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */);

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index 776916b61c40..841217bd1df6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -4,11 +4,12 @@
>  #include <sys/resource.h>
>  #include "test_send_signal_kern.skel.h"
>
> -int sigusr1_received = 0;
> +int sigusr1_received;
> +volatile int volatile_variable;

please make them static

>
>  static void sigusr1_handler(int signum)
>  {
> -       sigusr1_received++;
> +       sigusr1_received = 1;
>  }
>
>  static void test_send_signal_common(struct perf_event_attr *attr,
> @@ -42,7 +43,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>                 int old_prio;
>
>                 /* install signal handler and notify parent */
> +               errno = 0;
>                 signal(SIGUSR1, sigusr1_handler);
> +               ASSERT_OK(errno, "signal");

just ASSERT_OK(signal(...), "signal");

>
>                 close(pipe_c2p[0]); /* close read */
>                 close(pipe_p2c[1]); /* close write */
> @@ -63,9 +66,12 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>                 ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>
>                 /* wait a little for signal handler */
> -               sleep(1);
> +               for (int i = 0; i < 1000000000; i++)

same about 1bln

> +                       volatile_variable++;
>
>                 buf[0] = sigusr1_received ? '2' : '0';
> +               ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
> +
>                 ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>
>                 /* wait for parent notification and exit */
> @@ -110,9 +116,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>         ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
>
>         /* trigger the bpf send_signal */
> +       skel->bss->signal_thread = signal_thread;
>         skel->bss->pid = pid;
>         skel->bss->sig = SIGUSR1;
> -       skel->bss->signal_thread = signal_thread;
>
>         /* notify child that bpf program can send_signal now */
>         ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
> --
> 2.30.2
>

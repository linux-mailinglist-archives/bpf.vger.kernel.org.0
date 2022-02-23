Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820104C0A0B
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 04:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiBWDOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 22:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbiBWDOT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 22:14:19 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C4C13E1D
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 19:13:51 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id q4so7456505ilt.0
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 19:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xVWatHenS1HUMDYzJFTWcC9fcj3/hfSNV5VJP5/ifhY=;
        b=MBkc55KP+470rNGvTtCOqr+ng/DMjvaE/K3zSlCFtD/4zCLIHOgDYG5J4eWYKdKukB
         L7+QCBfPjHLo7DMfkgxui1hcuBdPj30ceDHqkUv8VNsxzCBFCpI8YnQz9r9reo4acVsz
         rSCIr5KIdacXT+v9Bl1n44XPNddzgKkOGubFAy0LEv0Ngrm/+xPn9VXqUJYrLoruH4OQ
         O8mc6ZMCK1H4uHjlUi+fySNA/pJixUklWEcIkU0jXusXFZceznIh2Ju2l/oAbwLv5ROr
         fuW8eRNG9PuZM6KgCpfA8ssfLXqAAuQcwSkG2OTIGyxAHdiKch0y95Mv0lrJVmPgeZKf
         YUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xVWatHenS1HUMDYzJFTWcC9fcj3/hfSNV5VJP5/ifhY=;
        b=QT8hzn4FChC9ske5iVZDnuSH1HzqaNjiP4NTDLhLShmdMhZS0lnCtjPBPvGqn3QCfj
         BZPj4LbmEZoQGvKwlHjmY7qlbr5VRn8Wsaf+nFr7+Yxpv2ZZUg4/eWe0/+bspQ5K4IHq
         /5pyIR7Ytay019TB10WdaLYhmi+sLs4RzG+yBDHw6cw64GRinz0luW/t3+5p14DG/M32
         6Gqietoo5MzyQGSAF8vQwL1TB81j7mODn4MnsCe2qMyQzOSKIATh7ScG9yB3LIrgufjT
         xFVU9CW1qbR8BSGHtU+F2IkBzzpv4V/vYZ5HFBCrfhfeloLMquwlBR2wjqc+ReIjIZIJ
         7nmQ==
X-Gm-Message-State: AOAM530xWrhHKY+D2HMz8m/jmtgBGZbaSi20m2kwcEfaiqCkTrxG3/ml
        utXoLKIRK7It5vm1MTgEcRD46JzwGT53eRa112g=
X-Google-Smtp-Source: ABdhPJyzmytS7WgoR7FhzgD1ZlOdp1DdrTzMwK6GCwCSAF8AyzuzxvOOoMTeFK0+zgdPeUIC6R7Nc5bsIGr7vKzgZOk=
X-Received: by 2002:a92:d208:0:b0:2c1:1a3c:7b01 with SMTP id
 y8-20020a92d208000000b002c11a3c7b01mr22236700ily.71.1645586031066; Tue, 22
 Feb 2022 19:13:51 -0800 (PST)
MIME-Version: 1.0
References: <20220219003004.1085072-1-mykolal@fb.com> <CAEf4BzahKEObA_quad2M5Rmn42yPCNFAvVUtPVthFi2jPYNpmg@mail.gmail.com>
 <22435EA9-9336-4978-819A-0F91EFDBEA9E@fb.com>
In-Reply-To: <22435EA9-9336-4978-819A-0F91EFDBEA9E@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Feb 2022 19:13:40 -0800
Message-ID: <CAEf4BzaAr_khs682uyCZ0HhFuNJWwKYDcfqhNE12rWYmU20JOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 22, 2022 at 12:35 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> Thanks for the review Andrii!
>
> > On Feb 19, 2022, at 8:39 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com=
> wrote:
> >
> > On Fri, Feb 18, 2022 at 4:30 PM Mykola Lysenko <mykolal@fb.com> wrote:
> >>
> >> In send_signal, replace sleep with dummy cpu intensive computation
> >> to increase probability of child process being scheduled. Add few
> >> more asserts.
> >>
> >> In find_vma, reduce sample_freq as higher values may be rejected in
> >> some qemu setups, remove usleep and increase length of cpu intensive
> >> computation.
> >>
> >> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
> >> higher values may be rejected in some qemu setups
> >>
> >> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> >> ---
> >> .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  2 +-
> >> tools/testing/selftests/bpf/prog_tests/find_vma.c  |  5 ++---
> >> .../selftests/bpf/prog_tests/perf_branches.c       |  4 ++--
> >> tools/testing/selftests/bpf/prog_tests/perf_link.c |  2 +-
> >> .../testing/selftests/bpf/prog_tests/send_signal.c | 14 ++++++++++----
> >> 5 files changed, 16 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_cookie.c
> >> index cd10df6cd0fc..0612e79a9281 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> >> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *ske=
l)
> >>        attr.type =3D PERF_TYPE_SOFTWARE;
> >>        attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
> >>        attr.freq =3D 1;
> >> -       attr.sample_freq =3D 4000;
> >> +       attr.sample_freq =3D 1000;
> >>        pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FL=
AG_FD_CLOEXEC);
> >>        if (!ASSERT_GE(pfd, 0, "perf_fd"))
> >>                goto cleanup;
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools=
/testing/selftests/bpf/prog_tests/find_vma.c
> >> index b74b3c0c555a..acc41223a112 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
> >> @@ -30,7 +30,7 @@ static int open_pe(void)
> >>        attr.type =3D PERF_TYPE_HARDWARE;
> >>        attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
> >>        attr.freq =3D 1;
> >> -       attr.sample_freq =3D 4000;
> >> +       attr.sample_freq =3D 1000;
> >>        pfd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FL=
AG_FD_CLOEXEC);
> >>
> >>        return pfd >=3D 0 ? pfd : -errno;
> >> @@ -57,7 +57,7 @@ static void test_find_vma_pe(struct find_vma *skel)
> >>        if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> >>                goto cleanup;
> >>
> >> -       for (i =3D 0; i < 1000000; ++i)
> >> +       for (i =3D 0; i < 1000000000; ++i)
> >
> > 1bln seems excessive... maybe 10mln would be enough?
>
> See explanation for send_signal test case below
>
> >
> >>                ++j;
> >>
> >>        test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */=
);
> >
> > [...]
> >
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/to=
ols/testing/selftests/bpf/prog_tests/send_signal.c
> >> index 776916b61c40..841217bd1df6 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> >> @@ -4,11 +4,12 @@
> >> #include <sys/resource.h>
> >> #include "test_send_signal_kern.skel.h"
> >>
> >> -int sigusr1_received =3D 0;
> >> +int sigusr1_received;
> >> +volatile int volatile_variable;
> >
> > please make them static
>
> sure
>
> >
> >>
> >> static void sigusr1_handler(int signum)
> >> {
> >> -       sigusr1_received++;
> >> +       sigusr1_received =3D 1;
> >> }
> >>
> >> static void test_send_signal_common(struct perf_event_attr *attr,
> >> @@ -42,7 +43,9 @@ static void test_send_signal_common(struct perf_even=
t_attr *attr,
> >>                int old_prio;
> >>
> >>                /* install signal handler and notify parent */
> >> +               errno =3D 0;
> >>                signal(SIGUSR1, sigusr1_handler);
> >> +               ASSERT_OK(errno, "signal");
> >
> > just ASSERT_OK(signal(...), "signal");
>
> I am fine to merge signal and ASSERT lines, but will substitute with cond=
ition "signal(SIGUSR1, sigusr1_handler) !=3D SIG_ERR=E2=80=9D, sounds good?
>

Ah, signal is a bit special with return values. Yeah,
ASSERT_NEQ(signal(...), SIG_ERR, "signal") sounds good.

> >
> >>
> >>                close(pipe_c2p[0]); /* close read */
> >>                close(pipe_p2c[1]); /* close write */
> >> @@ -63,9 +66,12 @@ static void test_send_signal_common(struct perf_eve=
nt_attr *attr,
> >>                ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
> >>
> >>                /* wait a little for signal handler */
> >> -               sleep(1);
> >> +               for (int i =3D 0; i < 1000000000; i++)
> >
> > same about 1bln
>
> With 10mln and 100 test runs I got 86 failures
> 100mln - 63 failures
> 1bln - 0 failures on 100 runs
>
> Now, there is performance concern for this test. Running
>
> time sudo  ./test_progs -t send_signal/send_signal_nmi_thread
>
> With 1bln takes ~4s
> 100mln - 1s.
> Unchanged test with sleep(1); takes ~2s.
>
> On the other hand 300mln runs ~2s, and only fails 1 time per 100 runs. As=
 300mln does not regress performance comparing to the current =E2=80=9Cslee=
p(1)=E2=80=9D implementation, I propose to go with it. What do you think?


I think if we need to burn multiple seconds of CPU to make the test
reliable, then we should either rework or disable/remove the test. In
CI those billions of iterations will be much slower. And even waiting
for 4 seconds for just one test is painful.

Yonghong, WDYT? Should we just drop thi test? It has caused us a bunch
of flakiness and maintenance burden without actually catching any
issues. Maybe it's better to just get rid of it?

>
> >
> >> +                       volatile_variable++;
> >>
> >>                buf[0] =3D sigusr1_received ? '2' : '0';
> >> +               ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
> >> +
> >>                ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
> >>
> >>                /* wait for parent notification and exit */
> >> @@ -110,9 +116,9 @@ static void test_send_signal_common(struct perf_ev=
ent_attr *attr,
> >>        ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
> >>
> >>        /* trigger the bpf send_signal */
> >> +       skel->bss->signal_thread =3D signal_thread;
> >>        skel->bss->pid =3D pid;
> >>        skel->bss->sig =3D SIGUSR1;
> >> -       skel->bss->signal_thread =3D signal_thread;
> >>
> >>        /* notify child that bpf program can send_signal now */
> >>        ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
> >> --
> >> 2.30.2
>

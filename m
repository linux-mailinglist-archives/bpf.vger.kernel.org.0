Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E44D226C
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 21:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbiCHUUk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 15:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiCHUUj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 15:20:39 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA9249271
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 12:19:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bt26so41803lfb.3
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 12:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5G0nUjl/KUrTKhsMXBs/MFTWcVX5OA3ZyIM0Ytd/oIs=;
        b=MAglNXJ8Sc+oq2oP8KkAhJpusI6CzFcvHDc3MuNvraLwkwgx5kjelsqaQaPdcnUwN7
         sgSwdLACAvidz7x2TYZ132gY/R46GTDVjRLZIwwCYJhYjhCa+WIZijq1o2ZntwGj8elp
         aY7gXPV2/C9DwCP5WTNNLOTul4mId87R/vnRNbAySP0KbyQfGlnJBvRk7UyJ5NP5duXe
         CU41GQm8QhWDfoWKLulVvHyb4qAY7JmCvFfB+IZcocM3s3O8Zud1xAqfvORXzxxktJQ3
         T85yNLfRTDy5hJdSYiuBSrNChXGwgjvcqyp/H63Digrn7j6NJQ3Vg1bThQjIOGVI+BPe
         oZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5G0nUjl/KUrTKhsMXBs/MFTWcVX5OA3ZyIM0Ytd/oIs=;
        b=mTEfqBWMiPGPlIikSTNPK6BRejCqB7MoO9l3u/b83asj0L3B53oDvtgRj19PzbEH+3
         ckJvX+Z2drTj6ljjG5jUK76oUIfAlnpMSoF8Ii0AWAQKTcpRji6ECzzE5jGR1lP7PWvA
         5FCiedvv+VeVL7xckBwx3h8ym1TNwh4FQKkBWrAQ5NFDbABZLbJh1neNvNRIXrpBvN/U
         tujl97F1u7e4k5oClE1cfprDg7lTZGHXavG0R6jlAC0/dKdOheSt4ylw516GJ8zZiJ2i
         ZzqABgsWLGlCoyFt1PDthm6lymzwWpaOIJNsUhWMP9r03auL5NRU/M8piMcQlrkQoxKV
         tRZQ==
X-Gm-Message-State: AOAM530PExoGMWLD+ifHYulU2y4NXjAMZSOZdO1QI0+R4DT57OaGPbsz
        /wD3QZu+pwC37TgzQbw1hoEBLGBhtxPhidaJ8xCuvXBSG/s=
X-Google-Smtp-Source: ABdhPJzbmwR5Wk1MmV0Bwi0IAdpQRWCYhgfaNGWumrVHQj3DN707JLa5krrjQy9j4T8tUnTLrNfaE3DOLAYHcqGT0O8=
X-Received: by 2002:a05:6512:3242:b0:448:4a8f:6ae1 with SMTP id
 c2-20020a056512324200b004484a8f6ae1mr1628816lfr.665.1646770779424; Tue, 08
 Mar 2022 12:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20220302212735.3412041-1-mykolal@fb.com>
In-Reply-To: <20220302212735.3412041-1-mykolal@fb.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Tue, 8 Mar 2022 12:19:12 -0800
Message-ID: <CAJygYd1X+aYQ1u96bwU+a5wDzADDGMH7f202nq00xZMr+YRScg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
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

On Wed, Mar 2, 2022 at 3:53 PM Mykola Lysenko <mykolal@fb.com> wrote:
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
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_cookie.c       |  2 +-
>  .../testing/selftests/bpf/prog_tests/find_vma.c | 13 ++++++++++---
>  .../selftests/bpf/prog_tests/perf_branches.c    |  4 ++--
>  .../selftests/bpf/prog_tests/perf_link.c        |  2 +-
>  .../selftests/bpf/prog_tests/send_signal.c      | 17 ++++++++++-------
>  .../selftests/bpf/progs/test_send_signal_kern.c |  2 +-
>  6 files changed, 25 insertions(+), 15 deletions(-)
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
> index b74b3c0c555a..7cf4feb6464c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
> @@ -30,12 +30,20 @@ static int open_pe(void)
>         attr.type = PERF_TYPE_HARDWARE;
>         attr.config = PERF_COUNT_HW_CPU_CYCLES;
>         attr.freq = 1;
> -       attr.sample_freq = 4000;
> +       attr.sample_freq = 1000;

I think It's actually better to modify sysctl.
perf_event_max_sample_rate through test_progs, I had a patch do that
before, but Andrii didn't apply it. (I've forgotten why) , but this is
a recurring issue when running in VM in parallel mode.

>         pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>
>         return pfd >= 0 ? pfd : -errno;
>  }

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A0C4E3485
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiCUXiH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiCUXiG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:38:06 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE411D792
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:36:39 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id n16so11399513ile.11
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWeRzxrWPK8f6kVCl8Oou3lVmU3AfVYWjz6HmKK2JaA=;
        b=QX35oZd+krqEzzDC0shvrZVnSa7+NR//8aDxDXSsJAx/MN8d22J//8OZNpW0C37+Nu
         FI3uDwJrunjBQIqcPF8YfjE9+ZxTQtWleL+L6NhtBZQZUBGgstDZRtsGt1N374broe6v
         kPsUQ8A3XHldW4g5ejhxdZdmE/IxtMFyaR5SStkb+p11ao5BuZnQr1SyZ8KzMDBku0eq
         kXkARB+3eFrthMQ1ey2Dug+BSfh+MHTNfMtTfUXxKCkAM6eepHz854ib81PHCrCd04QR
         MnwPjoS9mDoYLR7f3HyTAzuLZkuIRAl4PXV2IxthRrsomV988Q7CvM1YkOnzhzypo42y
         PSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWeRzxrWPK8f6kVCl8Oou3lVmU3AfVYWjz6HmKK2JaA=;
        b=kgMc9bV5QHtUn6Xj0fS95nBigNxK/Q1BsDqt1km2FTl64AwH7ZuTDP+OuC4z4cHF50
         YDah5JQ5wXSAYBLKokiqAKsi9c3UiyMgjGnWXS77Ufuj5XkcDI4WKKTyfPmCQi84U901
         RVMVoq3T0Ena0IzTbgQjDAdzsSvR9LUQg0ltxOnstFL6rynGX3kjqY9IFqUWJvwC+c52
         /BkpF6pnuVJE3X446wcKgLC8sT4t+lgc7BSNX8GWF6TXmowNilwB41q4o+sYL7ejFjXa
         YDwvMOWR//dFULU/8xabwVRrB2o86updnGaS7gF+9C05Hw1NZZpA6HUOQ+EsuSQqFEqw
         hN3A==
X-Gm-Message-State: AOAM530/D5Qjwr9bHQYzv7Uq4C3s6HYPY1ExYSOLzFidvFA2LoiCjrO6
        xRtcOhwOvdTsWEsJTEX4AS32EVAxojxiUtC05WE=
X-Google-Smtp-Source: ABdhPJzYRlucYYBMZbdrFvgvMpkpTkyXtmJNq0tSWlALTtcT1RDlplOGJgwjemXlH6BpA4na9Tf3PFQH1Vvd2RKTMn4=
X-Received: by 2002:a92:ca0c:0:b0:2c7:7983:255f with SMTP id
 j12-20020a92ca0c000000b002c77983255fmr10241428ils.252.1647905799118; Mon, 21
 Mar 2022 16:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-5-kuifeng@fb.com>
In-Reply-To: <20220316004231.1103318-5-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 16:36:28 -0700
Message-ID: <CAEf4BzaaMmv7NXpg4KT9X6-eeRa3Hfi652GRYUPLawVfH1EHog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftest/bpf: The test cses of BPF cookie
 for fentry/fexit/fmod_ret.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Tue, Mar 15, 2022 at 5:44 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Make sure BPF cookies are correct for fentry/fexit/fmod_ret.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_cookie.c     | 61 +++++++++++++++++++
>  .../selftests/bpf/progs/test_bpf_cookie.c     | 24 ++++++++
>  2 files changed, 85 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 0612e79a9281..6d06c5046e9c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -237,6 +237,65 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>         bpf_link__destroy(link);
>  }
>
> +static void tracing_subtest(struct test_bpf_cookie *skel)
> +{
> +       __u64 cookie;
> +       int prog_fd;
> +       int fentry_fd = -1, fexit_fd = -1, fmod_ret_fd = -1;
> +       struct bpf_test_run_opts opts;
> +
> +       skel->bss->fentry_res = 0;
> +       skel->bss->fexit_res = 0;
> +
> +       cookie = 0x100000;
> +       prog_fd = bpf_program__fd(skel->progs.fentry_test1);
> +       if (!ASSERT_GE(prog_fd, 0, "fentry.prog_fd"))
> +               return;

this can't return <= 0 if skeleton was loaded, don't bother doing
these checks, they just distract from the main objective of the test

> +       fentry_fd = bpf_raw_tracepoint_cookie_open(NULL, prog_fd, cookie);
> +       if (!ASSERT_GE(fentry_fd, 0, "fentry.open"))
> +               return;
> +
> +       cookie = 0x200000;
> +       prog_fd = bpf_program__fd(skel->progs.fexit_test1);
> +       if (!ASSERT_GE(prog_fd, 0, "fexit.prog_fd"))
> +               goto cleanup;
> +       fexit_fd = bpf_raw_tracepoint_cookie_open(NULL, prog_fd, cookie);
> +       if (!ASSERT_GE(fexit_fd, 0, "fexit.open"))
> +               goto cleanup;
> +
> +       cookie = 0x300000;
> +       prog_fd = bpf_program__fd(skel->progs.fmod_ret_test);
> +       if (!ASSERT_GE(prog_fd, 0, "fmod_ret.prog_fd"))
> +               goto cleanup;
> +       fmod_ret_fd = bpf_raw_tracepoint_cookie_open(NULL, prog_fd, cookie);
> +       if (!ASSERT_GE(fmod_ret_fd, 0, "fmod_ret.opoen"))
> +               goto cleanup;
> +
> +       bzero(&opts, sizeof(opts));
> +       opts.sz = sizeof(opts);
> +       opts.repeat = 1;

We have LIBBPF_OPTS() macro for working with opts, please use that.
But I think in this case NULL for opts will be equivalent. Seems like
kernel just ignores repeat parameter for tracing programs (and for
others repeat == 0 means repeat == 1).

> +       prog_fd = bpf_program__fd(skel->progs.fentry_test1);
> +       bpf_prog_test_run_opts(prog_fd, &opts);
> +
> +       bzero(&opts, sizeof(opts));
> +       opts.sz = sizeof(opts);
> +       opts.repeat = 1;
> +       prog_fd = bpf_program__fd(skel->progs.fmod_ret_test);
> +       bpf_prog_test_run_opts(prog_fd, &opts);
> +
> +       ASSERT_EQ(skel->bss->fentry_res, 0x100000, "fentry_res");
> +       ASSERT_EQ(skel->bss->fexit_res, 0x200000, "fexit_res");
> +       ASSERT_EQ(skel->bss->fmod_ret_res, 0x300000, "fmod_ret_res");
> +
> +cleanup:
> +       if (fentry_fd >= 0)
> +               close(fentry_fd);
> +       if (fexit_fd >= 0)
> +               close(fexit_fd);
> +       if (fmod_ret_fd >= 0)
> +               close(fmod_ret_fd);
> +}
> +
>  void test_bpf_cookie(void)
>  {
>         struct test_bpf_cookie *skel;
> @@ -255,6 +314,8 @@ void test_bpf_cookie(void)
>                 tp_subtest(skel);
>         if (test__start_subtest("perf_event"))
>                 pe_subtest(skel);
> +       if (test__start_subtest("tracing"))
> +               tracing_subtest(skel);

kprobes are also tracing, but this one is specifically about BPF
trampoline-based programs. Let's use "trampoline" here to
disambiguate.

>
>         test_bpf_cookie__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
> index 2d3a7710e2ce..a9f83f46e7b7 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
> @@ -14,6 +14,9 @@ int uprobe_res;
>  int uretprobe_res;
>  int tp_res;
>  int pe_res;
> +int fentry_res;
> +int fexit_res;
> +int fmod_ret_res;
>
>  static void update(void *ctx, int *res)
>  {
> @@ -82,4 +85,25 @@ int handle_pe(struct pt_regs *ctx)
>         return 0;
>  }
>
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(fentry_test1, int a)
> +{
> +       update(ctx, &fentry_res);
> +       return 0;
> +}
> +
> +SEC("fexit/bpf_fentry_test1")
> +int BPF_PROG(fexit_test1, int a, int ret)
> +{
> +       update(ctx, &fexit_res);
> +       return 0;
> +}
> +
> +SEC("fmod_ret/bpf_modify_return_test")
> +int BPF_PROG(fmod_ret_test, int _a, int *_b, int _ret)
> +{
> +       update(ctx, &fmod_ret_res);
> +       return 1234;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> --
> 2.30.2
>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D9F36FFE0
	for <lists+bpf@lfdr.de>; Fri, 30 Apr 2021 19:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhD3RrI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Apr 2021 13:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhD3RrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Apr 2021 13:47:07 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF20C06174A;
        Fri, 30 Apr 2021 10:46:18 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 130so40342936ybd.10;
        Fri, 30 Apr 2021 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62+jAKHL3iRdRP5891cITslrAksunRH6DgJafoyqJ/0=;
        b=j3FJa11YfEHoJDoQmpb5RK4rezGBYA4RhTplCHBXsyAGgmHADcZZaZKucjcpgwIkFy
         kiJ9M22Z9rJePC/wrSGmQq9aZlivtKetXtlq5Q+OUjCZz0SUmDYBBJSbLpnJlh8kgsyc
         SVy2DEEqrPQM5b6583u5smqhxnABC7Mrmssg1ntcJyDxKl3T5S2FfB2xt9llebVk+boE
         QTlfeIQhwBee688zLcrXOhc5+p2Jjl6xd4x6ipo64nwg2/waOk05QWFxaDGlXCgntRry
         A2ppA54gxR5i2tEdLgWxxOm88EHVfBEmqeWkjt3FhgCrcmZvIigHfyQULkbUSrUyEU3F
         F+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62+jAKHL3iRdRP5891cITslrAksunRH6DgJafoyqJ/0=;
        b=LiPXsH63pSZf+wILTgqMNKMwAgkrSp09mvcIx2ypAWVdK8vB1iEZ9z9IBNb2L7yOUP
         kg7feACdJqJWt5gxmN1RTjCijxKnP8PXvsOhPaAQSJloZ7d59UDNMCfp7uC0V66vvOBS
         DvMtcJq3nYi88IMblYU/m8F9vgwUVWGJSsrpmVBOFVLQjjh48PFvTBjf3Q3oLvCCWfZE
         c5z25ulr523TacM5G/NoFcGQab/0j5DI2kdAy+DWQ/n9Eujcd4DoiFXu7tgwfXX2GFhB
         mOGSUrJIoHHDI5ED6lW3VUiQS/ldWFzgVrhoCtD3KoWGmdvLQ1dSPRmsMQ/8CGjvt7kG
         o8Ew==
X-Gm-Message-State: AOAM533+xp4cp5v1QOLn+XOECupB7RDhmpIe+tT92E+3y5dEmd/clg1B
        4vk3SmRGh2aDOwzAiSppy80JTzLRf0eUog+OhRE=
X-Google-Smtp-Source: ABdhPJz0E+/fzP97L86dhtM5otyrPY8toYlEVj4ynTLivX0Cl7sY4OkIn//Dsbn/lE18s04jQmFtBGpEtJmNUtj6VKw=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr8116760ybf.425.1619804778138;
 Fri, 30 Apr 2021 10:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210428152501.1024509-1-revest@chromium.org>
In-Reply-To: <20210428152501.1024509-1-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Apr 2021 10:46:07 -0700
Message-ID: <CAEf4BzbXqSDL84j3Cb5WOCcghqN=C7eUEPKmw-h8bmN6EyyPwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix the snprintf test
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 28, 2021 at 8:25 AM Florent Revest <revest@chromium.org> wrote:
>
> The BPF program for the snprintf selftest runs on all syscall entries.
> On busy multicore systems this can cause concurrency issues.
>
> For example it was observed that sometimes the userspace part of the
> test reads "    4 0000" instead of "    4 000" (extra '0' at the end)
> which seems to happen just before snprintf on another core sets
> end[-1] = '\0'.
>
> This patch adds a pid filter to the test to ensure that no
> bpf_snprintf() will write over the test's output buffers while the
> userspace reads the values.
>
> Fixes: c2e39c6bdc7e ("selftests/bpf: Add a series of tests for bpf_snprintf")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---

Applied to bpf tree. Thanks.

>  tools/testing/selftests/bpf/prog_tests/snprintf.c | 2 ++
>  tools/testing/selftests/bpf/progs/test_snprintf.c | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> index a958c22aec75..dffbcaa1ec98 100644
> --- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> @@ -43,6 +43,8 @@ void test_snprintf_positive(void)
>         if (!ASSERT_OK_PTR(skel, "skel_open"))
>                 return;
>
> +       skel->bss->pid = getpid();
> +
>         if (!ASSERT_OK(test_snprintf__attach(skel), "skel_attach"))
>                 goto cleanup;
>
> diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
> index 951a0301c553..e35129bea0a0 100644
> --- a/tools/testing/selftests/bpf/progs/test_snprintf.c
> +++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
> @@ -5,6 +5,8 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>
> +__u32 pid = 0;
> +
>  char num_out[64] = {};
>  long num_ret = 0;
>
> @@ -42,6 +44,9 @@ int handler(const void *ctx)
>         static const char str1[] = "str1";
>         static const char longstr[] = "longstr";
>
> +       if ((int)bpf_get_current_pid_tgid() != pid)
> +               return 0;
> +
>         /* Integer types */
>         num_ret  = BPF_SNPRINTF(num_out, sizeof(num_out),
>                                 "%d %u %x %li %llu %lX",
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>

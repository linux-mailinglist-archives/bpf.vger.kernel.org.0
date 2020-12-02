Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526702CB1F3
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 02:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgLBA7T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 19:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgLBA7T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 19:59:19 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD8C061A04;
        Tue,  1 Dec 2020 16:58:10 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id 10so68899ybx.9;
        Tue, 01 Dec 2020 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkXu9Ed2ybTkQIgVvwvasBTjLGza95sliHnsICJRQMI=;
        b=H3MZYH5k6FkItSFWwohnA37oe/t/5Wsaj4sdmB77XBqgQeDarK7aw1Po4m3Cd4VGHr
         vUs0deTQbBTsEQiPxBSpMIV1U2r2S7AqodqaHWdPJN054Aw9ZwyCj+ufHOHUsGmu+Vlv
         I3C4vE0jekW6ZkwRBeC5nLqU78mQhN2wYzTLXYQksxLfj+JoVq+GWWxnj65vji2yOKq1
         4FercnoPjt9cNdcLZIGA0ByWR3Y82Pzz9mp6ssLze/BJJ3/rNQgEa6aajGZeQudjBeZz
         85cYDYsrQx0UX+TmeY8oyX6FBldeKbv5vlTLcR7anaX+qlyXUoFKFZpBcL4CIzBlZJIC
         fmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkXu9Ed2ybTkQIgVvwvasBTjLGza95sliHnsICJRQMI=;
        b=g3cEZBg7RMlJAnxKv28yfXzOspvJCIEGmowWkgML0u58gDtnRdITP/8dy7yTz9AAXF
         EFQRfyB67xjIRBm3Oyh8tWGvK5NHbe1b98rliPxwKKj36AUb2khu1Jq0kpNcuYAIaTUv
         imDISyMi4nK02jC2s6qbD0YTcDOG4camkxSRSwO96APGNUZPDVWp+H/cDJkkj3ye6PDn
         gwhrBtHBypd0URIhJqHaGhR+AoCyuQmrbzXDI37F0uOM5vucX8/iDV/x7mUfOD/0N2Ca
         n7XLl4dkZ5XMuOq5ud4Z27OQ4bxydrOrWfdd/WlK+llaRuEnqos6wW08veVZ2cIcKAiE
         oAnw==
X-Gm-Message-State: AOAM530Q8aTeEASwzuD3INyFvsFST1gKHzBBR6QbEVVFoQEiTdnOgLnB
        njKGNWtT0wfDCL9ZREffFd24oypsOsbWxeIbbOWbi/85esw=
X-Google-Smtp-Source: ABdhPJwY+6CigAXZX+nJC0LAa7eq3iVaNZOpXH+UfMu4jd1PQoFZEPb4Mv305HMDsPvjUB2RBiZwRedhRFCmJFTeSgo=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr102999ybd.27.1606870690253;
 Tue, 01 Dec 2020 16:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20201126165748.1748417-1-revest@google.com> <20201126165748.1748417-2-revest@google.com>
In-Reply-To: <20201126165748.1748417-2-revest@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 16:57:59 -0800
Message-ID: <CAEf4Bzauq=fRxPWRQq6wk9f_LGR6iayr96Fg-hzVB2gL6Pm8=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add bpf_kallsyms_lookup test
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 26, 2020 at 8:59 AM Florent Revest <revest@chromium.org> wrote:
>
> This piggybacks on the existing "ksyms" test because this test also
> relies on a __ksym symbol and requires CONFIG_KALLSYMS.
>
> Signed-off-by: Florent Revest <revest@google.com>
> ---
>  tools/testing/selftests/bpf/config            |  1 +
>  .../testing/selftests/bpf/prog_tests/ksyms.c  | 46 ++++++++++++++++++-
>  .../bpf/progs/test_kallsyms_lookup.c          | 38 +++++++++++++++
>  3 files changed, 84 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_kallsyms_lookup.c
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 365bf9771b07..791a46e5d013 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -43,3 +43,4 @@ CONFIG_IMA=y
>  CONFIG_SECURITYFS=y
>  CONFIG_IMA_WRITE_POLICY=y
>  CONFIG_IMA_READ_POLICY=y
> +CONFIG_KALLSYMS=y

it's already a requirement, but good to codify it ;)

> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> index b295969b263b..0478b67a92ae 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> @@ -3,11 +3,12 @@
>
>  #include <test_progs.h>
>  #include "test_ksyms.skel.h"
> +#include "test_kallsyms_lookup.skel.h"
>  #include <sys/stat.h>
>
>  static int duration;
>
> -void test_ksyms(void)
> +void test_ksyms_variables(void)

now it should be static

>  {
>         const char *btf_path = "/sys/kernel/btf/vmlinux";
>         struct test_ksyms *skel;
> @@ -59,3 +60,46 @@ void test_ksyms(void)
>  cleanup:
>         test_ksyms__destroy(skel);
>  }
> +
> +void test_kallsyms_lookup(void)

static

> +{
> +       struct test_kallsyms_lookup *skel;
> +       int err;
> +
> +       skel = test_kallsyms_lookup__open_and_load();
> +       if (CHECK(!skel, "skel_open", "failed to open and load skeleton\n"))
> +               return;
> +
> +       err = test_kallsyms_lookup__attach(skel);
> +       if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
> +               goto cleanup;
> +
> +       /* trigger tracepoint */
> +       usleep(1);
> +
> +       CHECK(strcmp(skel->bss->name, "schedule"), "name",
> +             "got \"%s\", exp \"schedule\"\n", skel->bss->name);

there is ASSERT_STREQ() that does this nicely and succinctly


> +       CHECK(strcmp(skel->bss->name_truncated, "sched"), "name_truncated",
> +             "got \"%s\", exp \"sched\"\n", skel->bss->name_truncated);
> +       CHECK(strcmp(skel->bss->name_invalid, ""), "name_invalid",
> +             "got \"%s\", exp \"\"\n", skel->bss->name_invalid);
> +       CHECK(strcmp(skel->bss->module_name, ""), "module_name",
> +             "got \"%s\", exp \"\"\n", skel->bss->module_name);
> +       CHECK(skel->bss->schedule_ret != 9, "schedule_ret",
> +             "got %d, exp 0\n", skel->bss->schedule_ret);
> +       CHECK(skel->bss->sched_ret != 9, "sched_ret",
> +             "got %d, exp 0\n", skel->bss->sched_ret);
> +       CHECK(skel->bss->invalid_ret != -EINVAL, "invalid_ret",
> +             "got %d, exp %d\n", skel->bss->invalid_ret, -EINVAL);
> +
> +cleanup:
> +       test_kallsyms_lookup__destroy(skel);
> +}
> +
> +void test_ksyms(void)
> +{
> +       if (test__start_subtest("ksyms_variables"))
> +               test_ksyms_variables();
> +       if (test__start_subtest("kallsyms_lookup"))
> +               test_kallsyms_lookup();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_kallsyms_lookup.c b/tools/testing/selftests/bpf/progs/test_kallsyms_lookup.c
> new file mode 100644
> index 000000000000..4f15f1527ab4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_kallsyms_lookup.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020 Google LLC. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +extern const void schedule __ksym;
> +
> +#define SYMBOL_NAME_LEN                        10
> +char name[SYMBOL_NAME_LEN];
> +char name_invalid[SYMBOL_NAME_LEN];
> +
> +#define SYMBOL_TRUNCATED_NAME_LEN      6
> +char name_truncated[SYMBOL_TRUNCATED_NAME_LEN];
> +
> +#define MODULE_NAME_LEN                        64
> +char module_name[MODULE_NAME_LEN];
> +
> +long schedule_ret;
> +long sched_ret;
> +long invalid_ret;

= 0 or = {} for all the variables

> +
> +SEC("raw_tp/sys_enter")
> +int handler(const void *ctx)
> +{
> +       schedule_ret = bpf_kallsyms_lookup((__u64)&schedule,
> +                                          name, SYMBOL_NAME_LEN,
> +                                          module_name, MODULE_NAME_LEN);
> +       invalid_ret = bpf_kallsyms_lookup(0,
> +                                         name_invalid, SYMBOL_NAME_LEN,
> +                                         module_name, MODULE_NAME_LEN);
> +       sched_ret = bpf_kallsyms_lookup((__u64)&schedule, name_truncated,
> +                                       SYMBOL_TRUNCATED_NAME_LEN,
> +                                       module_name, MODULE_NAME_LEN);
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.29.2.454.gaff20da3a2-goog
>

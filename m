Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E16A361608
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 01:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbhDOXU5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 19:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhDOXU4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 19:20:56 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E76C061574;
        Thu, 15 Apr 2021 16:20:33 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z1so28022736ybf.6;
        Thu, 15 Apr 2021 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7cv1II7ATL1p7rnLX19uxXv/NG365+OJej7Ub+kNWk=;
        b=DCJlXBdfCBZtwG4V0xfAdEryHYlqGRUgb80U7tNdhS5OoWf31VBanPzpY9K/wYdBK9
         Mh0ZS91C/sbo4jlcNHX5wZ8EgI/zLHJzhLjx98KT/8K/h4O1dad8OSWlIYe4pIRjy1bf
         srmDDWVFjFmDsg0CyvZ8EEZ1OMheDjypRN9Yd2gc8LHtt5+UCN3c5eg/azZ6IES/Ey5F
         kzwCBCrSIS+P0uc0bvp7emNO0SC+QS7Rzwc0W/sjDJ9i6Q7beQoW0b+FgcJpbNe+3qPG
         YOf7d78TChAuwrmIKF8hYOycUb8c9gxysm1sbYbVFv9s+55Ia27UqAJeQqnlMrM4MGAg
         gImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7cv1II7ATL1p7rnLX19uxXv/NG365+OJej7Ub+kNWk=;
        b=QXHs0T53wNltF0vrJ52rmPO3dyseipPkuISanctoaN19xkWxvxNplL2uq9JvMcSf0c
         ywROEUObPEcZ0CORgpAy3HDD33uhs0vCe9yeQiCU6kytCbnHNbk72HfcRnkyHflOC02D
         2qMTHjX+93mex8y7M4LViPKHcUS+uPSm4rYaMMezGDCBKe9tBzNt9IqDwvQBxEFrLky7
         3oUgKpYETgsN9OY3hIBv2Nk/me5yWyhUuE4c9PXT2fr4EQcadef6Ci6eua8PpqI9l1qa
         13LvXdtMLGb1+pFqRS01nssAdD6NYFbtIHA0j/9//4Utda7I8AY0EE3RjOGVuNixGF+v
         RVQQ==
X-Gm-Message-State: AOAM533Nym6nMJZLGEojbFO7doeBtwv+Ks0jNmxA6633nPsjLVtf6Ts7
        62CYMZ6Jf4+ZRfgMXhi3DePjKs8ANoZ9pp1erw0=
X-Google-Smtp-Source: ABdhPJxRaMC/DRhWPKqRLBtjFdXAvpOI6e4nSM6fmGjbGh/xSCJ/iuwxzolO+ziSafVe2UgtLsSBxM87X31+0J8Ed2Q=
X-Received: by 2002:a25:3357:: with SMTP id z84mr7824691ybz.260.1618528832490;
 Thu, 15 Apr 2021 16:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210414185406.917890-1-revest@chromium.org> <20210414185406.917890-7-revest@chromium.org>
In-Reply-To: <20210414185406.917890-7-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 15 Apr 2021 16:20:21 -0700
Message-ID: <CAEf4BzYtOOwDLOGmfQ+pF5t-muDXQB_StFB7SQS6Ap78P5FjQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 11:54 AM Florent Revest <revest@chromium.org> wrote:
>
> The "positive" part tests all format specifiers when things go well.
>
> The "negative" part makes sure that incorrect format strings fail at
> load time.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  .../selftests/bpf/prog_tests/snprintf.c       | 124 ++++++++++++++++++
>  .../selftests/bpf/progs/test_snprintf.c       |  73 +++++++++++
>  .../bpf/progs/test_snprintf_single.c          |  20 +++
>  3 files changed, 217 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c
>

[...]

> +/* Loads an eBPF object calling bpf_snprintf with up to 10 characters of fmt */
> +static int load_single_snprintf(char *fmt)
> +{
> +       struct test_snprintf_single *skel;
> +       int ret;
> +
> +       skel = test_snprintf_single__open();
> +       if (!skel)
> +               return -EINVAL;
> +
> +       memcpy(skel->rodata->fmt, fmt, min(strlen(fmt) + 1, 10));
> +
> +       ret = test_snprintf_single__load(skel);
> +       if (!ret)
> +               test_snprintf_single__destroy(skel);

destroy unconditionally?

> +
> +       return ret;
> +}
> +
> +void test_snprintf_negative(void)
> +{
> +       ASSERT_OK(load_single_snprintf("valid %d"), "valid usage");
> +
> +       ASSERT_ERR(load_single_snprintf("0123456789"), "no terminating zero");
> +       ASSERT_ERR(load_single_snprintf("%d %d"), "too many specifiers");
> +       ASSERT_ERR(load_single_snprintf("%pi5"), "invalid specifier 1");
> +       ASSERT_ERR(load_single_snprintf("%a"), "invalid specifier 2");
> +       ASSERT_ERR(load_single_snprintf("%"), "invalid specifier 3");
> +       ASSERT_ERR(load_single_snprintf("\x80"), "non ascii character");
> +       ASSERT_ERR(load_single_snprintf("\x1"), "non printable character");

Some more cases that came up in my mind:

1. %123987129387192387 -- long and unterminated specified
2. similarly %------- or something like that

Do you think they are worth checking?

> +}
> +
> +void test_snprintf(void)
> +{
> +       if (test__start_subtest("snprintf_positive"))
> +               test_snprintf_positive();
> +       if (test__start_subtest("snprintf_negative"))
> +               test_snprintf_negative();
> +}

[...]

> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_snprintf_single.c b/tools/testing/selftests/bpf/progs/test_snprintf_single.c
> new file mode 100644
> index 000000000000..15ccc5c43803
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_snprintf_single.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Google LLC. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +// The format string is filled from the userspace side such that loading fails

C++ style format

> +static const char fmt[10];
> +
> +SEC("raw_tp/sys_enter")
> +int handler(const void *ctx)
> +{
> +       unsigned long long arg = 42;
> +
> +       bpf_snprintf(NULL, 0, fmt, &arg, sizeof(arg));
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.31.1.295.g9ea45b61b8-goog
>

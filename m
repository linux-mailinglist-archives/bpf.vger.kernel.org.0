Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AED314283
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 23:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBHWEa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 17:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhBHWER (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 17:04:17 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD24C061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 14:03:31 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id p193so2418741yba.4
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 14:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvlxNjZ3C61R4ya9ZFRNnaROxPXCPlV0S0x/si9wVyA=;
        b=aUHf7h3W4Z6sTxb5wOHpty+j0LMdpyq3s1KJxjtz6x0Q9TFzKRlVy7JWijHERiYelW
         dyOh2dNuMad5tCeoXkIUW4U/PN6mNV75dvxEydbxuGW06FPytxwBlZT8XrGj5UisDbKv
         WPy4pey/oXCP+f2iTFgvizIUeJqPKz9QBjRGOdXFghfyAZuIrnBqcu2VhnpYSafDTfEH
         K5muVWmRW9kknIOTyyUWLoHvSUnaC6aeHZKm+sYMpXCNw7RrcfEMAWcGN2iuoyTKXVBV
         +6cDxxy4+IgTEmqgMH+x/RhCjkx0MeYqN2e8EblyBB3iS7PlI2TvFFbEC2ZcFgkFMgUZ
         5H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvlxNjZ3C61R4ya9ZFRNnaROxPXCPlV0S0x/si9wVyA=;
        b=jCa/s27qVk4v8GE0azTAqyVlEfBBg/qmZyxtJqsGbVpoundJW1j9Qq20O3VkQYPyfn
         ddZB6SuYT7iN+a5pr9R6/mA2oIH4M/QwlGBLO1J0vLv3nxPTGXbE4dm8ftL2bWI5lym7
         uICachwMWkn4A1u5DW5o48vl1CfJLlS6ryJ/hBi4Nau79Gf6VSYOeoiUqkaMfss4B5S9
         e5aXqGqcuAFLuqo++oNQOg1pJxn68bpJVG3ITb+P0CTr+YDOkhA1cAtj/AbH59yHmbk8
         LbQU8NUo2k5cTudrYIlIVRL6qIp4WuiFCekf1jL8Tp84qrcNii0jiwAznzVUrWahUgqV
         GmGg==
X-Gm-Message-State: AOAM531mE6IPGIKegeKYXkrQnjgagk/5ykUcW5fDA1hhnQe9WavedQvP
        4APOzMWF1Ku82EUin9+YgmUJn8ZOyrlEymzsvVs=
X-Google-Smtp-Source: ABdhPJzAzE1Rf9CW1D/0xcRsseGgO2wizqMCwe8h/tbfUSZ2t3pnvSLfLvF84c+G0ajFfpBeNZpvMDHnUI5hNVcnGCY=
X-Received: by 2002:a25:a183:: with SMTP id a3mr27823430ybi.459.1612821810517;
 Mon, 08 Feb 2021 14:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20210207011027.676572-1-andreimatei1@gmail.com> <20210207011027.676572-5-andreimatei1@gmail.com>
In-Reply-To: <20210207011027.676572-5-andreimatei1@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 14:03:19 -0800
Message-ID: <CAEf4BzaTVc61DTgOJk4JcWLMmvsGUAsx9SDHmLxm+3VYZaU=eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftest/bpf: add test for var-offset
 stack access
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 5:11 PM Andrei Matei <andreimatei1@gmail.com> wrote:
>
> Add a higher-level test (C BPF program) for the new functionality -
> variable access stack reads and writes.
>
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/stack_var_off.c  | 36 ++++++++++++
>  .../selftests/bpf/progs/test_stack_var_off.c  | 56 +++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_var_off.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_stack_var_off.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_var_off.c b/tools/testing/selftests/bpf/prog_tests/stack_var_off.c
> new file mode 100644
> index 000000000000..52e00486b1aa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/stack_var_off.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "test_stack_var_off.skel.h"
> +
> +/* Test read and writes to the stack performed with offsets that are not
> + * statically known.
> + */
> +void test_stack_var_off(void)
> +{
> +       int duration = 0;
> +       struct test_stack_var_off *skel;
> +
> +       skel = test_stack_var_off__open_and_load();
> +       if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> +               return;
> +       if (CHECK(!skel->bss, "check_bss", ".bss wasn't mmap()-ed\n"))
> +               goto cleanup;

can't happen, no need to check for !skel->bss


> +
> +       test_stack_var_off__attach(skel);

check errors (ASSERT_OK is good for this)

> +
> +       /* Give pid to bpf prog so it doesn't trigger for anyone else. */
> +       skel->bss->test_pid = getpid();
> +       /* Initialize the probe's input. */
> +       skel->bss->input[0] = 2;
> +       skel->bss->input[1] = 42;  /* This will be returned in probe_res. */
> +
> +       /* Trigger probe. */
> +       usleep(1);
> +
> +       if (CHECK(skel->bss->probe_res != 42, "check_probe_res",
> +                 "wrong probe res: %d\n", skel->bss->probe_res))
> +               goto cleanup;
> +
> +cleanup:
> +       test_stack_var_off__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_stack_var_off.c b/tools/testing/selftests/bpf/progs/test_stack_var_off.c
> new file mode 100644
> index 000000000000..bd9c8d86cd91
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_stack_var_off.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Facebook

2021 already :) Facebook isn't right here as well, probably?

> +
> +#include <linux/ptrace.h>

don't need this

> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>

and don't need this as well

> +
> +int probe_res;
> +
> +char input[4] = {};
> +int test_pid;
> +
> +SEC("tracepoint/syscalls/sys_enter_nanosleep")
> +int probe(void *ctx)
> +{
> +       /* This BPF program performs variable-offset reads and writes on a
> +        * stack-allocated buffer.
> +        */
> +       char stack_buf[16];
> +       unsigned long len;
> +       unsigned long last;
> +
> +       if (test_pid == 0)
> +               return 0;

can't happen, please remove

> +       if ((bpf_get_current_pid_tgid() >> 32) != test_pid)
> +               return 0;
> +
> +       /* Copy the input to the stack. */
> +       __builtin_memcpy(stack_buf, input, 4);
> +
> +       /* The first byte in the buffer indicates the length. */
> +       len = stack_buf[0] & 0xf;
> +       last = (len - 1) & 0xf;
> +
> +       /* Append something to the buffer. The offset where we write is not
> +        * statically known; this is a variable-offset stack write.
> +        */
> +       stack_buf[len] = 42;
> +
> +       /* Index into the buffer at an unknown offset. This is a
> +        * variable-offset stack read.
> +        *
> +        * Note that if it wasn't for the preceding variable-offset write, this
> +        * read would be rejected because the stack slot cannot be verified as
> +        * being initialized. With the preceding variable-offset write, the
> +        * stack slot still cannot be verified, but the write inhibits the
> +        * respective check on the reasoning that, if there was a
> +        * variable-offset to a higher-or-equal spot, we're probably reading
> +        * what we just wrote.
> +        */
> +       probe_res = stack_buf[last];
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.27.0
>

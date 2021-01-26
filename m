Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0581630354D
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 06:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbhAZFix (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 00:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732145AbhAZCi2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 21:38:28 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74360C06174A
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 18:37:47 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v200so982483ybe.1
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 18:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NJe5WK5Sk1NsrlE0JFCIeyxgxOfnhe4uSSalUBLNO8=;
        b=oF6tFnjblfCY2JD/3DmAI/trsnWHVtioYaTozIn/ZA8xIpG38oh4Bty9XeE+HgKgtI
         i4Hk4hB5GnUqSPPeYnfOJ9wmWDOu3V/jqpRXCXVD2QmfFntiF+Hpyg1oNyfoAcUDOoxN
         Gq9PfUKUUgMJDK9a9jbsXNfDtQuOuQ+682hgIkNWr+l0OLX2TpNvnqibiGTD0/nQJt3J
         Fjw3cmzgdGMl1+7b1IDHKNFF2BdRu/uAriYVxw5OZk76HAg+l86U4Zhjkgnix4KHY4LM
         ONKNGohyYuN87TQi9uiRMKp6OIjbOtW4k89vtEb310rnt+rAVfSxPlqCF91jM4DisY+5
         hZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NJe5WK5Sk1NsrlE0JFCIeyxgxOfnhe4uSSalUBLNO8=;
        b=sNBEyghMBvrJhG8LaTa9kHx7AaNBMbFP+K1GUTn2KzSxxMWEtmXwlFRjZaC6++4NEc
         zn2gMedd865B0+4ZqjarLAco0+20HJUEt9rLlNROpAjoU/jFJDzXuzBeyRQGUa7EGN2F
         ALuhoCxEWm4TuWTvYOB7WBq8UphvTTLrrF9j1HpX3GWqB/IvTB0bBv7Pyho7++kuExcv
         kXCue4mBsnmFpsljWQEisR1pKZSwX2spzRTK5p8LRjccCUXnfaZbxcUaWr7bMGmKPQ9y
         sK8YyRia7hC4YVvp4xdhC4LqmiZ8y1FsN3+ZrMB/p1XbcLighezHFXi6IrvGqEM5CBOA
         ynXQ==
X-Gm-Message-State: AOAM533k6M89VSw9Sbqc+btMLPpWxHiTPK9JBAMMa2EeyLk6YgOobIzc
        8LhwiBictJi3SR8DMNn/3Qo5eqFzUYOBmM76VMI=
X-Google-Smtp-Source: ABdhPJy34BeIm3BfmLmvrg1gOFr5c/6O5ts+0xEVNE7n6VaVZZ/NJXnKMN+60AJBUz0y4iwGnjMVeECPDAYB1SyIy6M=
X-Received: by 2002:a25:1287:: with SMTP id 129mr4990392ybs.27.1611628666797;
 Mon, 25 Jan 2021 18:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20210124194909.453844-1-andreimatei1@gmail.com> <20210124194909.453844-6-andreimatei1@gmail.com>
In-Reply-To: <20210124194909.453844-6-andreimatei1@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Jan 2021 18:37:36 -0800
Message-ID: <CAEf4Bzb3cw1zPfvdpZg2X+N5SS+H-NJJzrsDjW-9xEDFjRKA1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftest/bpf: add test for var-offset
 stack access
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 24, 2021 at 11:54 AM Andrei Matei <andreimatei1@gmail.com> wrote:
>
> Add a higher-level test (C BPF program) for the new functionality -
> variable access stack reads and writes.
>
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/stack_var_off.c  | 56 +++++++++++++++++++
>  .../selftests/bpf/progs/test_stack_var_off.c  | 43 ++++++++++++++
>  2 files changed, 99 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_var_off.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_stack_var_off.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_var_off.c b/tools/testing/selftests/bpf/prog_tests/stack_var_off.c
> new file mode 100644
> index 000000000000..c4c47fb0f0af
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/stack_var_off.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "test_stack_var_off.skel.h"
> +
> +int dummy;
> +
> +noinline void uprobed_function(char *s, int len)
> +{
> +       /* Do something to keep the compiler from removing the function.
> +        */
> +       dummy++;
> +}
> +
> +void test_stack_var_off(void)
> +{
> +       int duration = 0;
> +       struct bpf_link *uprobe_link;
> +       struct test_stack_var_off *skel;
> +       size_t uprobe_offset;
> +       ssize_t base_addr;
> +       char s[100];
> +
> +       base_addr = get_base_addr();
> +       if (CHECK(base_addr < 0, "get_base_addr",
> +                 "failed to find base addr: %zd", base_addr))
> +               return;
> +       uprobe_offset = (size_t)&uprobed_function - base_addr;
> +
> +       skel = test_stack_var_off__open_and_load();
> +       if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> +               return;
> +       if (CHECK(!skel->bss, "check_bss", ".bss wasn't mmap()-ed\n"))
> +               goto cleanup;
> +
> +       uprobe_link = bpf_program__attach_uprobe(skel->progs.uprobe,
> +                                                false /* retprobe */,
> +                                                0 /* self pid */,
> +                                                "/proc/self/exe",
> +                                                uprobe_offset);
> +       if (CHECK(IS_ERR(uprobe_link), "attach_uprobe",
> +                 "err %ld\n", PTR_ERR(uprobe_link)))
> +               goto cleanup;
> +       skel->links.uprobe = uprobe_link;
> +
> +       /* trigger uprobe */
> +       s[0] = 1;
> +       s[1] = 10;
> +       uprobed_function(&s[0], 2);

I don't think uprobe() is essential to this test and just obscured
what is being tested. I'd just use a global variable to pass whatever
input data you need and use usleep(1), just like lots of other tests.

> +
> +       if (CHECK(skel->bss->uprobe_res != 10, "check_uprobe_res",
> +                 "wrong uprobe res: %d\n", skel->bss->uprobe_res))
> +               goto cleanup;
> +
> +cleanup:
> +       test_stack_var_off__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_stack_var_off.c b/tools/testing/selftests/bpf/progs/test_stack_var_off.c
> new file mode 100644
> index 000000000000..44f982684541
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_stack_var_off.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Facebook
> +
> +#include <linux/ptrace.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +int uprobe_res;
> +
> +SEC("uprobe/func")
> +int BPF_KPROBE(uprobe, char *s, int len)
> +{
> +       /* This BPF program performs variable-offset reads and writes on a
> +        * stack-allocated buffer.
> +        */
> +       char buf[16];
> +       unsigned long idx;
> +       char out;
> +
> +       /* Zero-out the buffer so we can read anywhere inside it. */
> +       __builtin_memset(&buf, 0, 16);
> +       /* Copy the contents of s from user-space. */
> +       len &= 0xf;
> +       if (bpf_probe_read_user(&buf, len, s)) {
> +               bpf_printk("error reading user mem\n");
> +               return 1;
> +       }
> +       /* Index into the buffer at an unknown offset that comes from the
> +        * buffer itself. This is a variable-offset stack read.
> +        */
> +       idx = buf[0];
> +       idx &= 0xf;
> +       out = buf[idx];
> +       /* Append something to the buffer. The position where we append it
> +        * is unknown. This is a variable-offset stack write.
> +        */
> +       buf[len] = buf[idx];
> +       uprobe_res = out;
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.27.0
>

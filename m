Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4BF3120B1
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 02:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBGBMq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 20:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhBGBMp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 20:12:45 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC6C06174A
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 17:12:05 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e7so9499845ile.7
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 17:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTZZJ9PXjj7ajAzbIEyuSQsaNTYmkW/dMbmMNqbGyeI=;
        b=SxoSeba3YDFv+O/Z69aJF07DNfVjVZZ/0pt040NFgRnv9Je4Yx+XyWQnFFyh7khmIX
         baHC6WWdReZLwfvUa7JIdmwtbPnGz3bs4l5hFXy4MvosHmMi/JfaliXQBgbDyDXOmrtT
         5paM2SKW0myFnN1+MlKxDOWLVzP0BGb1z6I+KlKR8bGd2VHD58ga+QhS64xaXzdpt+4D
         SeD9/gnyqz1sGp8AkO+nClzweibH2zdGhHLp50KxluyfqIOW+3rLP5GdhNmomEtgRvvq
         FdoCxvW8nR9BmwsPY1ovTzv5aIRj8hL+FPuQ/+WKExWUE1+BUkmK47qglkJ9sJjgRTuP
         qrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTZZJ9PXjj7ajAzbIEyuSQsaNTYmkW/dMbmMNqbGyeI=;
        b=NQZztkq4U4goYKm2fNL7Zcw+LlfkpeWbczJcz9+O3Qnh+KYJVvNbleApfwVfsXlgLb
         1iLDSgMj8KxKL/AZFRjb7zlqlJLZOfd0n+sZj6Otk8KLQDm6umt4ZVlpl6ZLE1rxKKxU
         L5vExw32ixVqD+Gv0KMCCnFKX62f5nPAxiRTSZPfnf9eXWQRpPYJYgU3EcW2P0QgbOHX
         54B5VKJ3a+1uZjHORXSJVaS32NcJPjfa4rwTkcmU2DQHlzq1h7FVDaO4+hfdnq/N2gFY
         sn4IxZCZMpaqsNx/YHQ+9ieUBbRc4cQCxGHTjdKuBN5FARljLERiI+3kRf/bEuS/nCPt
         imDw==
X-Gm-Message-State: AOAM532gX23+9f/HjSDFYXomYIEQWGJxKpMFRY0wwUfmVa/SlCpVXj0l
        B3TR62bxwIH3LhOrbF9/KtRZsHNYOnLXWm9vsDFwZlMGFTA=
X-Google-Smtp-Source: ABdhPJwCmqikP4FeJzlMjZwkloGaxqUgJ4hJ1ZWocT7jTXShXh1JK/5+NsF80kpNvMOts6i5QyuM/zlO5eZiTYVF3jE=
X-Received: by 2002:a92:d851:: with SMTP id h17mr10453636ilq.121.1612660324630;
 Sat, 06 Feb 2021 17:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20210124194909.453844-1-andreimatei1@gmail.com>
 <20210124194909.453844-6-andreimatei1@gmail.com> <CAEf4Bzb3cw1zPfvdpZg2X+N5SS+H-NJJzrsDjW-9xEDFjRKA1g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb3cw1zPfvdpZg2X+N5SS+H-NJJzrsDjW-9xEDFjRKA1g@mail.gmail.com>
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Sat, 6 Feb 2021 20:11:53 -0500
Message-ID: <CABWLseuroZiX1-z6=w2iNRfEpvNbPTdj_qDsbmhqH_KxBDVYBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftest/bpf: add test for var-offset
 stack access
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

done in v3. Thanks!

On Mon, Jan 25, 2021 at 9:37 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Jan 24, 2021 at 11:54 AM Andrei Matei <andreimatei1@gmail.com> wrote:
> >
> > Add a higher-level test (C BPF program) for the new functionality -
> > variable access stack reads and writes.
> >
> > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/stack_var_off.c  | 56 +++++++++++++++++++
> >  .../selftests/bpf/progs/test_stack_var_off.c  | 43 ++++++++++++++
> >  2 files changed, 99 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_var_off.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_stack_var_off.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/stack_var_off.c b/tools/testing/selftests/bpf/prog_tests/stack_var_off.c
> > new file mode 100644
> > index 000000000000..c4c47fb0f0af
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/stack_var_off.c
> > @@ -0,0 +1,56 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include "test_stack_var_off.skel.h"
> > +
> > +int dummy;
> > +
> > +noinline void uprobed_function(char *s, int len)
> > +{
> > +       /* Do something to keep the compiler from removing the function.
> > +        */
> > +       dummy++;
> > +}
> > +
> > +void test_stack_var_off(void)
> > +{
> > +       int duration = 0;
> > +       struct bpf_link *uprobe_link;
> > +       struct test_stack_var_off *skel;
> > +       size_t uprobe_offset;
> > +       ssize_t base_addr;
> > +       char s[100];
> > +
> > +       base_addr = get_base_addr();
> > +       if (CHECK(base_addr < 0, "get_base_addr",
> > +                 "failed to find base addr: %zd", base_addr))
> > +               return;
> > +       uprobe_offset = (size_t)&uprobed_function - base_addr;
> > +
> > +       skel = test_stack_var_off__open_and_load();
> > +       if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> > +               return;
> > +       if (CHECK(!skel->bss, "check_bss", ".bss wasn't mmap()-ed\n"))
> > +               goto cleanup;
> > +
> > +       uprobe_link = bpf_program__attach_uprobe(skel->progs.uprobe,
> > +                                                false /* retprobe */,
> > +                                                0 /* self pid */,
> > +                                                "/proc/self/exe",
> > +                                                uprobe_offset);
> > +       if (CHECK(IS_ERR(uprobe_link), "attach_uprobe",
> > +                 "err %ld\n", PTR_ERR(uprobe_link)))
> > +               goto cleanup;
> > +       skel->links.uprobe = uprobe_link;
> > +
> > +       /* trigger uprobe */
> > +       s[0] = 1;
> > +       s[1] = 10;
> > +       uprobed_function(&s[0], 2);
>
> I don't think uprobe() is essential to this test and just obscured
> what is being tested. I'd just use a global variable to pass whatever
> input data you need and use usleep(1), just like lots of other tests.
>
> > +
> > +       if (CHECK(skel->bss->uprobe_res != 10, "check_uprobe_res",
> > +                 "wrong uprobe res: %d\n", skel->bss->uprobe_res))
> > +               goto cleanup;
> > +
> > +cleanup:
> > +       test_stack_var_off__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_stack_var_off.c b/tools/testing/selftests/bpf/progs/test_stack_var_off.c
> > new file mode 100644
> > index 000000000000..44f982684541
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_stack_var_off.c
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2017 Facebook
> > +
> > +#include <linux/ptrace.h>
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +int uprobe_res;
> > +
> > +SEC("uprobe/func")
> > +int BPF_KPROBE(uprobe, char *s, int len)
> > +{
> > +       /* This BPF program performs variable-offset reads and writes on a
> > +        * stack-allocated buffer.
> > +        */
> > +       char buf[16];
> > +       unsigned long idx;
> > +       char out;
> > +
> > +       /* Zero-out the buffer so we can read anywhere inside it. */
> > +       __builtin_memset(&buf, 0, 16);
> > +       /* Copy the contents of s from user-space. */
> > +       len &= 0xf;
> > +       if (bpf_probe_read_user(&buf, len, s)) {
> > +               bpf_printk("error reading user mem\n");
> > +               return 1;
> > +       }
> > +       /* Index into the buffer at an unknown offset that comes from the
> > +        * buffer itself. This is a variable-offset stack read.
> > +        */
> > +       idx = buf[0];
> > +       idx &= 0xf;
> > +       out = buf[idx];
> > +       /* Append something to the buffer. The position where we append it
> > +        * is unknown. This is a variable-offset stack write.
> > +        */
> > +       buf[len] = buf[idx];
> > +       uprobe_res = out;
> > +       return 0;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > --
> > 2.27.0
> >

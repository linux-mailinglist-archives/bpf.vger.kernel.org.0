Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF19337B1B6
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 00:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEKWpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 18:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKWpg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 18:45:36 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE2FC061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:44:28 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id r8so28422273ybb.9
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYOaIW+w7HzzfF9J3bKUupiWqLwUqVKHO3NhflyX46Y=;
        b=NKXdLof4a3YS71rGlnVnQqo5DbZ9zsJ2hXlsDwToX3SPUyYiago8JYF8sqBmRiaLfJ
         uI3QXZvmUuyqyzgT+mKLQSNQcwYp1IqhcTIvQOkShH8E6mKfBVPinYSj0KFbqxqnykul
         RkJo1RfpbnS33V5LGIDSpztw8jgVRmvF5EvoDBw7/SHUXiNnBsJ4fDS9XCTp0Ho4kfxE
         1Hp9mwmJ0IJb4gb1JwFlRoW3sQmzFroUZ9FxT8CmSRpg0UOYGeuItO9srvPvw6sTejXC
         YjqKYqJgsmBd3mTKAzFB3ru2GTiHPvqiIHKseKcvTKKhSAyNNDA3ivItCHqzs0g2xnZj
         wm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYOaIW+w7HzzfF9J3bKUupiWqLwUqVKHO3NhflyX46Y=;
        b=sR7ZCbgXBTGVsjhLhd26/ocQmZk2Zr1cC9v8ZC6qfkAsiyPGRg7ss36c4dnEHOcRgV
         PIwvKf7jY+7AXyTLYzoo/UrG5MWf3F/bOv/BbZKVBRpJbrg8CE7mGTBJ63CAxTpTEFTU
         6i5ook+RAj49kPfOGksZ/H4Z2EkPXiDwsrmzIodIZTQZmkTN5zG3xdjpTvHrgHIRxlEi
         1g3e2Lrb2lGh1eOM/c2IhURiHmMp919V5oi9abUfjDyq9kGaDQIinhJBbI5VPlRhhZKI
         tqeg7atKer1XVVkfYUa5JqmSYKyRTHEwXE/D98I4Up64kyikg4CG5Gh0FGHhNcWUuTKX
         iQbQ==
X-Gm-Message-State: AOAM5314NEXdMEWgqcOzUdFD77J1lm4dRwPf5bH29u+EwBTW63s4aGjn
        tr3COTqS+L1HH/N8CFkFauJToOf56mhvejhJq+k=
X-Google-Smtp-Source: ABdhPJwqvX/+gx1habiEhQIs4/B4X7/IpKIORfoac/remp/yuy33trxd1dOnd4QeJDI4igKO0ywXxFzGlUY8xPJurqo=
X-Received: by 2002:a25:9942:: with SMTP id n2mr45800282ybo.230.1620773067873;
 Tue, 11 May 2021 15:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
 <20210508034837.64585-6-alexei.starovoitov@gmail.com> <CAEf4BzagS-_nZHJEH0w14BKNiTX-9P-KQFfCphnysrDgQJggeA@mail.gmail.com>
In-Reply-To: <CAEf4BzagS-_nZHJEH0w14BKNiTX-9P-KQFfCphnysrDgQJggeA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 15:44:16 -0700
Message-ID: <CAEf4Bzb4_SEARfBcSpcTNufGRickoHAfuZCNy8cOete-GsZ+Mg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 05/22] selftests/bpf: Test for syscall program type
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 11, 2021 at 3:36 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, May 7, 2021 at 8:48 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > bpf_prog_type_syscall is a program that creates a bpf map,
> > updates it, and loads another bpf program using bpf_sys_bpf() helper.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> One stray CHECK() below, otherwise looks good.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >  .../selftests/bpf/prog_tests/syscall.c        | 49 +++++++++++++
> >  tools/testing/selftests/bpf/progs/syscall.c   | 71 +++++++++++++++++++
> >  2 files changed, 120 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/syscall.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/syscall.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/syscall.c b/tools/testing/selftests/bpf/prog_tests/syscall.c
> > new file mode 100644
> > index 000000000000..fb376c112f0c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/syscall.c
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2021 Facebook */
> > +#include <test_progs.h>
> > +#include "syscall.skel.h"
> > +
> > +struct args {
> > +       __u64 log_buf;
> > +       __u32 log_size;
> > +       int max_entries;
> > +       int map_fd;
> > +       int prog_fd;
> > +};
> > +
> > +void test_syscall(void)
> > +{
> > +       static char verifier_log[8192];
> > +       struct args ctx = {
> > +               .max_entries = 1024,
> > +               .log_buf = (uintptr_t) verifier_log,
> > +               .log_size = sizeof(verifier_log),
> > +       };
> > +       struct bpf_prog_test_run_attr tattr = {
> > +               .ctx_in = &ctx,
> > +               .ctx_size_in = sizeof(ctx),
> > +       };
> > +       struct syscall *skel = NULL;
> > +       __u64 key = 12, value = 0;
> > +       __u32 duration = 0;
> > +       int err;
> > +
> > +       skel = syscall__open_and_load();
> > +       if (CHECK(!skel, "skel_load", "syscall skeleton failed\n"))
>
> ASSERT_OK_PTR?
>
> > +               goto cleanup;
> > +
> > +       tattr.prog_fd = bpf_program__fd(skel->progs.bpf_prog);
> > +       err = bpf_prog_test_run_xattr(&tattr);
> > +       ASSERT_EQ(err, 0, "err");
> > +       ASSERT_EQ(tattr.retval, 1, "retval");
> > +       ASSERT_GT(ctx.map_fd, 0, "ctx.map_fd");
> > +       ASSERT_GT(ctx.prog_fd, 0, "ctx.prog_fd");

closing ctx.map_fd and ctx.prog_fd probably would be a good idea as well?

> > +       ASSERT_OK(memcmp(verifier_log, "processed", sizeof("processed") - 1),
> > +                 "verifier_log");
> > +
> > +       err = bpf_map_lookup_elem(ctx.map_fd, &key, &value);
> > +       ASSERT_EQ(err, 0, "map_lookup");
> > +       ASSERT_EQ(value, 34, "map lookup value");
> > +cleanup:
> > +       syscall__destroy(skel);
> > +}
>
> [...]

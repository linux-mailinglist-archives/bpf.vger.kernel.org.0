Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CEF453F6A
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 05:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhKQEVy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 23:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKQEVy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 23:21:54 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B6C061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:18:56 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id q74so3334839ybq.11
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JuF7rIDzotceMltKWWrENLgYSDo4ya5enVhTAJ7Nzg=;
        b=lPp4h1/WYbCJ1+/Xg44VVloRs6rv6fvV8FhBIwoQAJj36R+iNy6jm5UT/36iqOW2Pu
         cULiH3K6bv9XI/+XLm2WABWYFA5+okIhHp/eWl0beXEY3BZntws/NXYikRYuBuJcB0SL
         nSWhDfsf/KLCyV80de7xCWvLq2nR3QotYvETD7afiB8AB+4RumTwDx3CqTqKEflchhhP
         s0bv12+0LdA7EkyqyyqH2JMBhIijxBjk3kfieU6GGF4PREbeIVmqSNZWnP81PfMiSDRC
         lJgxZ8GyjtWfD55uL7ge2ZoBc3R/JwC9KoTCBN0xdGiJ7nL0MkcPoO/Dm97OwdqqAng9
         u/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JuF7rIDzotceMltKWWrENLgYSDo4ya5enVhTAJ7Nzg=;
        b=nefCO5frUNSTLAk42mBELCbMmHgDd3I1zvNvSH+NZIVG12vGe/qXvlO4D4ZN7NoU2L
         IRJ3BsmzM98NOFWqiaqHxZQWq7voHmzxcoZNlGfLaMHEZelox2Jn77UODaHHlQPezqRY
         8TBoWiJhe76rZSXeksY/liNzZomXGiUlBK4x9ANOdahynRQv33FCSVikH4stNSZPsKqC
         qY9ogErzA4UeU6JKopc8GTyJUn/hfyyiVK+mF9R0TH90jj9KG1gQjlZ9wKPtlG0nfB0T
         z4TcmdwLYMMa6LoL3to4IbA5FatBe7EJjeW0yQdcxvhfnNJqbqRqSTDwjASstdPxjEK1
         kWaQ==
X-Gm-Message-State: AOAM530Vsul41by31kowAXo6bMyK7aZiqxFJW3CRLoFe/9xqHgUhbxvo
        pF1yi67+ycOd3txHqVW8lbFQ0t/cVYklHbvQ7g4=
X-Google-Smtp-Source: ABdhPJy7BquEo94NlKhIJWH3opTSczIcgfzwSB+DzGgfU+sJIXtC8+eagOREpYgKigrVYuPUVerAXeh2n0F4ZzYGc8w=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr13993287ybt.267.1637122735651;
 Tue, 16 Nov 2021 20:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <20211112050230.85640-13-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-13-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 20:18:44 -0800
Message-ID: <CAEf4BzZXFvSn=h3ZgP4U-ydQyrRQXQRQgk0gGPyhjg3vvhRY4A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/12] selftests/bpf: Additional test for
 CO-RE in the kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 9:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Additional test where randmap() function is appended to three different bpf
> programs. That action checks struct bpf_core_relo replication logic and offset
> adjustment.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          |  2 +-
>  .../selftests/bpf/prog_tests/core_kern.c      | 21 +++++++
>  tools/testing/selftests/bpf/progs/core_kern.c | 60 +++++++++++++++++++
>  3 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
>  create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 539a70b3b770..df6a9865b3b5 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -326,7 +326,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h               \
>
>  LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
>         test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
> -       kfunc_call_test_subprog.c map_ptr_kern.c
> +       kfunc_call_test_subprog.c map_ptr_kern.c core_kern.c
>  # Generate both light skeleton and libbpf skeleton for these
>  LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c
>  SKEL_BLACKLIST += $$(LSKELS)
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_kern.c b/tools/testing/selftests/bpf/prog_tests/core_kern.c
> new file mode 100644
> index 000000000000..f64843c5728c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/core_kern.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include "test_progs.h"
> +#include "core_kern.lskel.h"
> +
> +void test_core_kern_lskel(void)
> +{
> +       struct core_kern_lskel *skel;
> +       int err;
> +
> +       skel = core_kern_lskel__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +               goto cleanup;
> +
> +       err = core_kern_lskel__attach(skel);

Why attaching if you are never triggering it? This test is about
testing load, right? Let's drop the attach then.

> +       if (!ASSERT_OK(err, "attach"))
> +               goto cleanup;
> +cleanup:
> +       core_kern_lskel__destroy(skel);
> +}

[...]

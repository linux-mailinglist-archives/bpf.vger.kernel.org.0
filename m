Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140454273BA
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhJHW3W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhJHW3V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:21 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E133EC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:27:25 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id s4so24140962ybs.8
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDUSPLTSk5KNLHuaQgRKmrIVWolvizHoU4xTbolgFRE=;
        b=DITlIpA6tS6uKYhm7J8N4Stit0Z6Hi6GHtKX8fiTEUHnKICt2sKJjbHrB4ICj+GwnQ
         nnR2+VBoURggDB3CoHqf+TBPjaG8hbPP74zfKQAfDa0eAWWs+8w6UL06PalN5rrS97NU
         0ieXhvZ16RVI2i5DUc5W6uCzDYD8Rha5ewhdTtptZO13hhgpnEOUzqvoVAykFNIC2iii
         nQL3kovSXAPh4yepC1TdHyBdwvwIWEz/WBlh+U2718/y1H48DXgW+j0keGGbw3W58aDv
         bd+u6RQUp2kpOZKrJJq+djkz+bTNZKYoSXk+UiMvpyG+qEig7ed6hFcTd+Mu7vfjcBqS
         g6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDUSPLTSk5KNLHuaQgRKmrIVWolvizHoU4xTbolgFRE=;
        b=yyDoav6/TH9veLYNS2UEURLHIt65ayYnyPXdLJx01p3MD4hjaMVFNGOw2Hgnx1CmZs
         incBWKXpDqpnI0OhoBIwojO57fBCEM/iLZdBaLp13WcKEeZN3Ywu/wGzf+B1b5YF4zM3
         aeQXXPsd49EgcIKY6V2hVvW3wj8c2cggxr+6E3xXE0ccNim5tZ6p6wBZGQrfF7m5IMWB
         jf4ArBF7nBKsDLBwB6nBX1y8LsNhLGZCTper/wd+RhT/H7nQYRoxhQ1Yh+Qz7BPBOH9O
         VGclaIEAKtOYpISeI0qKyCvG2m2t/P10KE/JPLaRKEM67VX6sMCpudVe0TF3tQifoPf1
         THzw==
X-Gm-Message-State: AOAM5315xeTynEJ1eof6TRNLwmtnOu8CMplBLvsuA42kE7CT/Or9iNcl
        og3oFMLN3o9m/rJyuNEgbQPnp8CsWLXR3YYSeBc=
X-Google-Smtp-Source: ABdhPJzOqSqRmDkfVTtfDHJQTraMLrEAyqSW+qRiGhK+DC8d5ZzY0X31MBIxge6LLshlDNZGVb5Ru0AHLGNQRIdpjaI=
X-Received: by 2002:a25:1884:: with SMTP id 126mr6294741yby.114.1633732045168;
 Fri, 08 Oct 2021 15:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-10-fallentree@fb.com>
In-Reply-To: <20211006185619.364369-10-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 15:27:13 -0700
Message-ID: <CAEf4BzYO+XD9Aa0o1BWfk8q4vE3Aon12bRWJjvz6RtWrT0o=WA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 09/14] selftests/bpf: Make uprobe tests use
 different attach functions.
To:     Yucong Sun <fallentree@fb.com>, Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> Using same address on different processes of the same binary often fail
> with EINVAL, this patch make these tests use distinct methods, so they
> can run in parallel.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/attach_probe.c | 8 ++++++--
>  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c   | 8 ++++++--
>  tools/testing/selftests/bpf/prog_tests/task_pt_regs.c | 8 ++++++--
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 6c511dcd1465..eff36ba9c148 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -5,6 +5,10 @@
>  /* this is how USDT semaphore is actually defined, except volatile modifier */
>  volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
>
> +static int method() {

wrong style: { should be on separate line

> +       return get_base_addr();

there is nothing special about get_base_addr(), except that it's a
global function in a different file and won't be inlined, while this
method() approach has no such guarantee

I've dropped this patch for now.

But I'm surprised that attaching to the same uprobe few times doesn't
work. Song, is there anything in kernel that could cause this?


> +}
> +
>  void test_attach_probe(void)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> @@ -33,7 +37,7 @@ void test_attach_probe(void)
>         if (CHECK(base_addr < 0, "get_base_addr",
>                   "failed to find base addr: %zd", base_addr))
>                 return;
> -       uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
> +       uprobe_offset = get_uprobe_offset(&method, base_addr);
>
>         ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
>         if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
> @@ -98,7 +102,7 @@ void test_attach_probe(void)
>                 goto cleanup;
>
>         /* trigger & validate uprobe & uretprobe */
> -       get_base_addr();
> +       method();
>
>         if (CHECK(skel->bss->uprobe_res != 3, "check_uprobe_res",
>                   "wrong uprobe res: %d\n", skel->bss->uprobe_res))
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 19c9f7b53cfa..5ebd8ba988e2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -8,6 +8,10 @@
>  #include <test_progs.h>
>  #include "test_bpf_cookie.skel.h"
>
> +static int method() {
> +       return get_base_addr();
> +}
> +
>  static void kprobe_subtest(struct test_bpf_cookie *skel)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
> @@ -66,7 +70,7 @@ static void uprobe_subtest(struct test_bpf_cookie *skel)
>         ssize_t base_addr;
>
>         base_addr = get_base_addr();
> -       uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
> +       uprobe_offset = get_uprobe_offset(&method, base_addr);
>
>         /* attach two uprobes */
>         opts.bpf_cookie = 0x100;
> @@ -99,7 +103,7 @@ static void uprobe_subtest(struct test_bpf_cookie *skel)
>                 goto cleanup;
>
>         /* trigger uprobe && uretprobe */
> -       get_base_addr();
> +       method();
>
>         ASSERT_EQ(skel->bss->uprobe_res, 0x100 | 0x200, "uprobe_res");
>         ASSERT_EQ(skel->bss->uretprobe_res, 0x1000 | 0x2000, "uretprobe_res");
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> index 37c20b5ffa70..4d2f1435be90 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> @@ -3,6 +3,10 @@
>  #include <test_progs.h>
>  #include "test_task_pt_regs.skel.h"
>
> +static int method() {
> +       return get_base_addr();
> +}
> +
>  void test_task_pt_regs(void)
>  {
>         struct test_task_pt_regs *skel;
> @@ -14,7 +18,7 @@ void test_task_pt_regs(void)
>         base_addr = get_base_addr();
>         if (!ASSERT_GT(base_addr, 0, "get_base_addr"))
>                 return;
> -       uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
> +       uprobe_offset = get_uprobe_offset(&method, base_addr);
>
>         skel = test_task_pt_regs__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "skel_open"))
> @@ -32,7 +36,7 @@ void test_task_pt_regs(void)
>         skel->links.handle_uprobe = uprobe_link;
>
>         /* trigger & validate uprobe */
> -       get_base_addr();
> +       method();
>
>         if (!ASSERT_EQ(skel->bss->uprobe_res, 1, "check_uprobe_res"))
>                 goto cleanup;
> --
> 2.30.2
>

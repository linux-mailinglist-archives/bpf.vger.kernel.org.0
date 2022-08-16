Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BD359611F
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 19:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiHPR2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 13:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHPR2h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 13:28:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946AE2B62F
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:28:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r4so14354983edi.8
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hdwZxoRkwL0l3ouppuhbUTQZRN0c+sbZK77bRf7q9VQ=;
        b=P5LZaYgUJOvmxZW3m9/A0L/G8/CoHZXMkp+kr+we9iaYTFl1L3kUETSnAJ56JxPApp
         L9gJAkxjDqP5Fji/wClNcHxhaeTvqC1W9Vf7hBr4yQuyh2CdM5u8u1FJkNTkOM+A5AsO
         xVF5mGoakL2b7u1FEe4vpsa+zHdmJHcnUzDayUieMdu/MjfnxoKM/3H6+zqt0wNuYz3t
         OOPGvjMEoFx8Oy9WBrqEAZvuWR6LX0mtoUmwdJFlbHdalVVGa0CLm0jY6Ydt+M4KQOpf
         FIPtrxelMtOKZk4iTVVmOyEOnOlT7w3bQwWsjCiGbH1/gny1lBrXjtmDBmF5l3lngHIg
         5ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hdwZxoRkwL0l3ouppuhbUTQZRN0c+sbZK77bRf7q9VQ=;
        b=vs6pYTDJ6X6MMUO0j68JTK/nCxHJ/5kMJIDrX8wpPC6rz4Dw9R9t0W4R/NU5XCSIHa
         ry0v5uPnTWIUOfQs2Xy8z/TrmNUftKgxENbDBC9wvsusMmvQ0CXzctk9Ol0IFLOKYRXP
         z6rHVyYZ9jtauHRnciwfIlznGiYrfc/yXtHOMGsQWidGBVGplwIJ8AOoyspUCy0D9sgN
         r8PupoEcBWZyws8LxVyzQq96+sbQ/p7D6cG0cfWk8TN8hHcnMinx2cj8nD82agC21KqS
         peQrj3E5/3GFPfJInY61cy2K6gEKuKmoB5sch1qmXrSDg6CeQXfvNXeNWQENfo4NpbUM
         biyQ==
X-Gm-Message-State: ACgBeo2Jyp4wdYvGdkxJt4PgEN8J2/khGJSq6MQl4GIxoytuQq21bOf+
        kVmUTopdkC48V9Y6VOipmonQ00XaG2plPAOuOEM=
X-Google-Smtp-Source: AA6agR7gfxC0h4VCK7K+qMl7exVq7MsAn8LU6QQSmgbotsHdjgN8i4PNrSau3ibcnKAcZnTPyICYNk+Tb37y1h6o9uU=
X-Received: by 2002:a05:6402:110a:b0:443:225c:6822 with SMTP id
 u10-20020a056402110a00b00443225c6822mr19078794edv.81.1660670913923; Tue, 16
 Aug 2022 10:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220811091526.172610-1-jolsa@kernel.org> <20220811091526.172610-7-jolsa@kernel.org>
 <CAEf4BzbXBsL8zrCDEP-+VsKseEQ1fWTRvUkJtwxX5r8q9hf1OA@mail.gmail.com>
 <YvtAhPyiWDbTzCdA@krava> <YvtvAkcnsrho+Xeq@krava>
In-Reply-To: <YvtvAkcnsrho+Xeq@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Aug 2022 10:28:22 -0700
Message-ID: <CAEf4BzYG77dGWUJ4NqeH-iDb0Zbeise_DDKY93bLSxq6MSyWXg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 6/6] selftests/bpf: Fix get_func_ip offset test
 for CONFIG_X86_KERNEL_IBT
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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

On Tue, Aug 16, 2022 at 3:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Aug 16, 2022 at 09:00:20AM +0200, Jiri Olsa wrote:
> > On Mon, Aug 15, 2022 at 08:25:51PM -0700, Andrii Nakryiko wrote:
> > > On Thu, Aug 11, 2022 at 2:16 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > With CONFIG_X86_KERNEL_IBT enabled the test for kprobe with offset
> > > > won't work because of the extra endbr instruction.
> > > >
> > > > As suggested by Andrii adding CONFIG_X86_KERNEL_IBT detection
> > > > and using appropriate offset value based on that.
> > > >
> > > > Also removing test7 program, because it does the same as test6.
> > > >
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  .../bpf/prog_tests/get_func_ip_test.c         | 62 +++++++++++++++----
> > > >  .../selftests/bpf/progs/get_func_ip_test.c    | 20 +++---
> > > >  2 files changed, 60 insertions(+), 22 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > > > index 938dbd4d7c2f..a4dab2fa2258 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > > > @@ -2,7 +2,9 @@
> > > >  #include <test_progs.h>
> > > >  #include "get_func_ip_test.skel.h"
> > > >
> > > > -void test_get_func_ip_test(void)
> > > > +static int config_ibt;
> > > > +
> > > > +static void test_function_entry(void)
> > > >  {
> > > >         struct get_func_ip_test *skel = NULL;
> > > >         int err, prog_fd;
> > > > @@ -12,14 +14,6 @@ void test_get_func_ip_test(void)
> > > >         if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
> > > >                 return;
> > > >
> > > > -       /* test6 is x86_64 specifc because of the instruction
> > > > -        * offset, disabling it for all other archs
> > > > -        */
> > > > -#ifndef __x86_64__
> > > > -       bpf_program__set_autoload(skel->progs.test6, false);
> > > > -       bpf_program__set_autoload(skel->progs.test7, false);
> > > > -#endif
> > > > -
> > > >         err = get_func_ip_test__load(skel);
> > > >         if (!ASSERT_OK(err, "get_func_ip_test__load"))
> > > >                 goto cleanup;
> > > > @@ -38,16 +32,62 @@ void test_get_func_ip_test(void)
> > > >
> > > >         ASSERT_OK(err, "test_run");
> > > >
> > > > +       config_ibt = skel->bss->config_ibt;
> > >
> > > skel->bss->config_ibt isn't actually necessary, you can just check
> > > skel->kconfig->CONFIG_X86_KERNEL_IBT directly. And you won't need to
> > > trigger BPF program unnecessary, libbpf will fill out kconfig section
> > > during object/skeleton load phase.
> >
> > nice, did not know that ;-) will remove it
>
> actually.. to get kconfig datasec generated in BTF the CONFIG_X86_KERNEL_IBT
> symbol needs to be used.. so I came up with adding unused function:
>
>   int unused(void)
>   {
>         return CONFIG_X86_KERNEL_IBT ? 0 : 1;
>   }
>
> but I wonder having the config_ibt variable is better and more clear
>
> thoughts?
>

seems like it's not allowed to add __attribute__((used)) onto extern
:( I don't know, this unused function is fine with me, even if a bit
ugly (maybe just leave the comment?). I like the fact that you won't
have to run BPF program to get this config, but it's minor either way.
I feel strongly either way.

> thanks,
> jirka

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D9C5960EE
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 19:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiHPRUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiHPRUM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 13:20:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EDF53D0C
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:20:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a89so14357662edf.5
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xQgBiZn7IwdW7wFdIXkpXLjtrzw4eFlDNDUsvwq2u6U=;
        b=dkNjDw0SvzOi5kDflHBXRj7PwCkOHvP8z6UnuHxtQ8soUzjah/QU+If/V/sxuQr87S
         V3QxN7XQGXywPf4P75uuWGB17d7cs2xsx0eWIA/op1vAnCFDJo9J0WEqXIQZ6s5e2HQe
         15cMGlcxam46M8lSHZf9pRPwNt+/neel6rKhPMM0+C+f5dSgWOn2BCWNpHWGP6Y278y7
         W2vpAee3l+ZsKdfvpRawJ2mNVTzyLs0Imml/oxzEj+NZkdLVzTLqZ33rezDltm0rRw2h
         eNViIkksyDZS1SzT0eO2M83fXOaorO4NtyPz+PmmhjIH6bLjv64QQUQ9xIuAaP0fKXCS
         JG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xQgBiZn7IwdW7wFdIXkpXLjtrzw4eFlDNDUsvwq2u6U=;
        b=EN+Sppg7hGGzrihAb9hIzzvIwYdyUUrscdFonpzKSvlOjn/av3cDHxrntNlQxHaxr7
         alrJnLdD53pQR5va0VL1qSlQJ34YGpL0FeFVvuQmXdwiNBmUg4tI0OOLAisk4LsWwIcf
         93OZJHm9UxXfGrQoDgJglPibIX6jxFnpiRu+npTcPK6Xb96CM6WwEEKOWKHWjUCc7R2L
         P1ofjZ5p5x4sv+YsQuKRuF3NOX193WPieV3pq4umP9noVKRIhACw6gUf00QkILjzxsV5
         PYyWlGhG1q4radpkzgThFYmUZ0x/JP+ZiKDIUvSmnbL7z90i7GEBmX/OULga3kEtKtc2
         m2vw==
X-Gm-Message-State: ACgBeo2Xcme/YtzMr+cPG0Qp2UyRYTgDlz6ZEbZ5mUMeskDLmb6zcZ6k
        Zf+fO4ObJROgcPzdmW5H/0CE4LK8z7kbIHzAxKs=
X-Google-Smtp-Source: AA6agR7UypC4PiVrSmKuG1xLlTRBjSgY6sFDmx6W/bjkXzJk5kLAdCP82b6oT+uUCA1chmpVQ1tWhyb+s11r73DRWwo=
X-Received: by 2002:aa7:ccc4:0:b0:43d:9e0e:b7ff with SMTP id
 y4-20020aa7ccc4000000b0043d9e0eb7ffmr20236866edt.14.1660670410001; Tue, 16
 Aug 2022 10:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220811091526.172610-1-jolsa@kernel.org> <20220811091526.172610-7-jolsa@kernel.org>
 <CAEf4BzbXBsL8zrCDEP-+VsKseEQ1fWTRvUkJtwxX5r8q9hf1OA@mail.gmail.com> <YvtAhPyiWDbTzCdA@krava>
In-Reply-To: <YvtAhPyiWDbTzCdA@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Aug 2022 10:19:58 -0700
Message-ID: <CAEf4Bza42KrEL4MLEFjQ4Zh1i1cDeqNSXRQqApzVkjgs56EEEw@mail.gmail.com>
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

On Tue, Aug 16, 2022 at 12:00 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Aug 15, 2022 at 08:25:51PM -0700, Andrii Nakryiko wrote:
> > On Thu, Aug 11, 2022 at 2:16 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > With CONFIG_X86_KERNEL_IBT enabled the test for kprobe with offset
> > > won't work because of the extra endbr instruction.
> > >
> > > As suggested by Andrii adding CONFIG_X86_KERNEL_IBT detection
> > > and using appropriate offset value based on that.
> > >
> > > Also removing test7 program, because it does the same as test6.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  .../bpf/prog_tests/get_func_ip_test.c         | 62 +++++++++++++++----
> > >  .../selftests/bpf/progs/get_func_ip_test.c    | 20 +++---
> > >  2 files changed, 60 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > > index 938dbd4d7c2f..a4dab2fa2258 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > > @@ -2,7 +2,9 @@
> > >  #include <test_progs.h>
> > >  #include "get_func_ip_test.skel.h"
> > >
> > > -void test_get_func_ip_test(void)
> > > +static int config_ibt;
> > > +
> > > +static void test_function_entry(void)
> > >  {
> > >         struct get_func_ip_test *skel = NULL;
> > >         int err, prog_fd;
> > > @@ -12,14 +14,6 @@ void test_get_func_ip_test(void)
> > >         if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
> > >                 return;
> > >
> > > -       /* test6 is x86_64 specifc because of the instruction
> > > -        * offset, disabling it for all other archs
> > > -        */
> > > -#ifndef __x86_64__
> > > -       bpf_program__set_autoload(skel->progs.test6, false);
> > > -       bpf_program__set_autoload(skel->progs.test7, false);
> > > -#endif
> > > -
> > >         err = get_func_ip_test__load(skel);
> > >         if (!ASSERT_OK(err, "get_func_ip_test__load"))
> > >                 goto cleanup;
> > > @@ -38,16 +32,62 @@ void test_get_func_ip_test(void)
> > >
> > >         ASSERT_OK(err, "test_run");
> > >
> > > +       config_ibt = skel->bss->config_ibt;
> >
> > skel->bss->config_ibt isn't actually necessary, you can just check
> > skel->kconfig->CONFIG_X86_KERNEL_IBT directly. And you won't need to
> > trigger BPF program unnecessary, libbpf will fill out kconfig section
> > during object/skeleton load phase.
>
> nice, did not know that ;-) will remove it
>
> >
> > > +       ASSERT_TRUE(config_ibt == 0 || config_ibt == 1, "config_ibt");
> >
> > you won't need this anymore
> >
> > > +       printf("%s:config_ibt %d\n", __func__, config_ibt);
> >
> > and this is just debug leftover
>
> it's intentional to find out quickly what config we are failing on

ASSERT_GE(config_ibt, 0, "config_ibt_lower_bound");
ASSERT_LE(config_ibt, 1, "config_ibt_upper_bound");

Will print out actual value and a bit more meaningful error message if
checks fail. Without polluting output with stray printfs.

>
> >
> > > +
> > >         ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
> > >         ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
> > >         ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
> > >         ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
> > >         ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
> > > +
> >
> > [...]
> >

[...]

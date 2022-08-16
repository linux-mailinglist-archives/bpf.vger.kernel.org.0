Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2315955A3
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiHPIyk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 04:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiHPIyM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 04:54:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1675488
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 00:00:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y3so12299631eda.6
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 00:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=vYSbRkDh7WDNcTFq/f9J5mYyoHioqnJ1nlRmfXFQdbA=;
        b=n59pImx7Tf6JZhDNZYpZ2DCxKjBWues8u8nUZu75fTQUIeZkBxuZ+CXbWP1bshVOLP
         9vpUVfmNMMqvxt0ZZPtcp7cFjh4DpJ3Hz/IbaSXsgYJz1zNkY/cwXfgZBFtSq1TpPrbq
         uezLprjiNnukNBf0DkB2z0Oy20vRsjOYUI5H7ssP0qe0rZdviUPxhGDNKH3ONFi9Fbof
         s1FozsmZFhvI7CPKm5gKOHQTmwfE2w8w05OjqVzdjwPOCcjjOmucMcea0v9tReHgLrpy
         iQ2+d8Ym3FOqAaNohzGDsbEAgk6dY8eT62PuFKX9OrQYKxZb0086MjAeEI7eTxVoZ2Hi
         jbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=vYSbRkDh7WDNcTFq/f9J5mYyoHioqnJ1nlRmfXFQdbA=;
        b=pjgJMDS+rxeyBtZlo2scfRSF+Qrviip/FVuYRKRTbxw6VugUeObNFZRY8nUQ2xEmZE
         55mgE92FJoDTYgbTuQ+yLIVDv8gW0mTZddNJ+VIxNtiOQvDtYCrAp0UBui9pKgs3nnEl
         wFnpa3Pi/6yTxxNkrBX19nFgk7E2mmgrQfMTPvSATcdXLR9gHmpucsfe8gWFPXluux82
         vbd9CxAcgsDk8fraGoTZPF1JQzrVhrpVqER7QwICAZ4PqWgpEp6qszvQc0oI+d6iRsHS
         sMTM1ilBBMHcmra+uVYUKLH9LgJAp05ScGzzgca8TOkgY9nuYzfZYnk8GF+T4trQasFp
         Es7g==
X-Gm-Message-State: ACgBeo0yWgJPzB2rxvHbvrVSGDLnrALTynlDw7WM/ygdZvLUW/4gVpOY
        gMoCVvP4grmw+hVSEg6rlvo=
X-Google-Smtp-Source: AA6agR4tiOgVCNJcw8j/Eh5YsinYUjeYyyDNkaYd4jsvaTdW0h+u2258Mg3lyFpKyPIVM9Kt5piBiA==
X-Received: by 2002:a05:6402:254b:b0:43e:7c6a:f431 with SMTP id l11-20020a056402254b00b0043e7c6af431mr17984031edb.305.1660633222789;
        Tue, 16 Aug 2022 00:00:22 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id x23-20020aa7dad7000000b0043a85d7d15esm7916491eds.12.2022.08.16.00.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 00:00:22 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 16 Aug 2022 09:00:20 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCHv2 bpf-next 6/6] selftests/bpf: Fix get_func_ip offset
 test for CONFIG_X86_KERNEL_IBT
Message-ID: <YvtAhPyiWDbTzCdA@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-7-jolsa@kernel.org>
 <CAEf4BzbXBsL8zrCDEP-+VsKseEQ1fWTRvUkJtwxX5r8q9hf1OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbXBsL8zrCDEP-+VsKseEQ1fWTRvUkJtwxX5r8q9hf1OA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 08:25:51PM -0700, Andrii Nakryiko wrote:
> On Thu, Aug 11, 2022 at 2:16 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > With CONFIG_X86_KERNEL_IBT enabled the test for kprobe with offset
> > won't work because of the extra endbr instruction.
> >
> > As suggested by Andrii adding CONFIG_X86_KERNEL_IBT detection
> > and using appropriate offset value based on that.
> >
> > Also removing test7 program, because it does the same as test6.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/get_func_ip_test.c         | 62 +++++++++++++++----
> >  .../selftests/bpf/progs/get_func_ip_test.c    | 20 +++---
> >  2 files changed, 60 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > index 938dbd4d7c2f..a4dab2fa2258 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > @@ -2,7 +2,9 @@
> >  #include <test_progs.h>
> >  #include "get_func_ip_test.skel.h"
> >
> > -void test_get_func_ip_test(void)
> > +static int config_ibt;
> > +
> > +static void test_function_entry(void)
> >  {
> >         struct get_func_ip_test *skel = NULL;
> >         int err, prog_fd;
> > @@ -12,14 +14,6 @@ void test_get_func_ip_test(void)
> >         if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
> >                 return;
> >
> > -       /* test6 is x86_64 specifc because of the instruction
> > -        * offset, disabling it for all other archs
> > -        */
> > -#ifndef __x86_64__
> > -       bpf_program__set_autoload(skel->progs.test6, false);
> > -       bpf_program__set_autoload(skel->progs.test7, false);
> > -#endif
> > -
> >         err = get_func_ip_test__load(skel);
> >         if (!ASSERT_OK(err, "get_func_ip_test__load"))
> >                 goto cleanup;
> > @@ -38,16 +32,62 @@ void test_get_func_ip_test(void)
> >
> >         ASSERT_OK(err, "test_run");
> >
> > +       config_ibt = skel->bss->config_ibt;
> 
> skel->bss->config_ibt isn't actually necessary, you can just check
> skel->kconfig->CONFIG_X86_KERNEL_IBT directly. And you won't need to
> trigger BPF program unnecessary, libbpf will fill out kconfig section
> during object/skeleton load phase.

nice, did not know that ;-) will remove it

> 
> > +       ASSERT_TRUE(config_ibt == 0 || config_ibt == 1, "config_ibt");
> 
> you won't need this anymore
> 
> > +       printf("%s:config_ibt %d\n", __func__, config_ibt);
> 
> and this is just debug leftover

it's intentional to find out quickly what config we are failing on

> 
> > +
> >         ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
> >         ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
> >         ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
> >         ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
> >         ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
> > +
> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > index 6db70757bc8b..cb8e58183d46 100644
> > --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/bpf.h>
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> > +#include <stdbool.h>
> >
> >  char _license[] SEC("license") = "GPL";
> >
> > @@ -13,12 +14,19 @@ extern const void bpf_modify_return_test __ksym;
> >  extern const void bpf_fentry_test6 __ksym;
> >  extern const void bpf_fentry_test7 __ksym;
> >
> > +extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
> > +
> > +bool config_ibt;
> > +
> >  __u64 test1_result = 0;
> >  SEC("fentry/bpf_fentry_test1")
> >  int BPF_PROG(test1, int a)
> >  {
> >         __u64 addr = bpf_get_func_ip(ctx);
> >
> > +       /* just to propagate config option value to user space */
> > +       config_ibt = CONFIG_X86_KERNEL_IBT;
> > +
> 
> as mentioned above, you shouldn't need it, just read
> CONFIG_X86_KERNEL_IBT directly through skeleton
> 
> >         test1_result = (const void *) addr == &bpf_fentry_test1;
> >         return 0;
> >  }
> > @@ -64,7 +72,7 @@ int BPF_PROG(test5, int a, int *b, int ret)
> >  }
> >
> >  __u64 test6_result = 0;
> > -SEC("kprobe/bpf_fentry_test6+0x5")
> > +SEC("?kprobe/")
> 
> don't leave / at the end (and I thought that libbpf rejects this,
> isn't that a case?...), just SEC("?kprobe")

yes, will remove

thanks,
jirka

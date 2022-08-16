Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE2A5952AA
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 08:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiHPGjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 02:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiHPGjR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 02:39:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92982162E33
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 20:26:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so11869217edd.4
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 20:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Y8tbw2qpZS5I3bS0kR3gjd18wRuqW5eQpj1LMg7fyqM=;
        b=UgknJ0pCdW6WrWW5zTTBYPK/XEgxsWgmOCk49tIjxlwnVUIN2k9AHOdLu/0BTMC014
         2E6dnFF3epLNMfzXdYAbzRtxSixehfN8HrUcOAGeBJ6sdAE0Nz+ZFTfMhdezVM1QwaLa
         XkpyhUPVAKYcYivdN50qxExDBT2QplPG8CvIu1KDSqR5CAihA3Xe7fBqojDmTYP6DD2s
         tLpy8G/PpnAvUzIPmkVsRf8KkGDGb9+y08BDQdB9dJQt7hXqlEvKpXWlOiPnbKNySqbb
         9nS4NlkfaZjnR/5975V7JcRVchVYiDyXQFM7SWwWZRrBALazbkK/MZvPqz7hvuqeZhPf
         OFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Y8tbw2qpZS5I3bS0kR3gjd18wRuqW5eQpj1LMg7fyqM=;
        b=vBSaFTKQ0q/WfYh7kd7nwkGloAwjjm7qkxjjAgwT+vakfwRaLJQ00qGyWbww8bwwmG
         h3Rd9hts9Ue9mftbN/gWZ3pqBNUcrS56cLQTnaE/9o3vi0m7uWjA9anR3+5gaLsNXXzX
         kFcyl9/OT9mNtH0n82AEKwqSO/qDF3+oYN9gUhPGpMU29R0U5FzeVK/YSJmsZ2ZX//Ms
         mT48xb9t3/R/aQ5m0JaUNvHFrLKpVV0Bx2CnQTsEjZ/zX5o98tbIiKX7b0n61lnBtj7D
         6CEN1TSsGWy7JkjhfL+R6J84r6yJQPRPdfhVbmW5ECsaA3wDKWFOFEWQwwQlUgloe8Ni
         690Q==
X-Gm-Message-State: ACgBeo2kMmLOf34BF15IMhH/wImFqa/MwgY3oEYOcqdsLQ6eMT5ecbIa
        V+NlOrxqH8MgMO+DSqyJyrE7CfMT2lKv+x59Vro=
X-Google-Smtp-Source: AA6agR4mPwIeF3rrqNpwWovUy3mUDwYDv1ZvP4oYvPieDall6FAPf7xATJzXdFAKYWgY8qsuOPS1AdELlpusr9hcY4k=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr17387715edb.333.1660620363160; Mon, 15
 Aug 2022 20:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220811091526.172610-1-jolsa@kernel.org> <20220811091526.172610-7-jolsa@kernel.org>
In-Reply-To: <20220811091526.172610-7-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Aug 2022 20:25:51 -0700
Message-ID: <CAEf4BzbXBsL8zrCDEP-+VsKseEQ1fWTRvUkJtwxX5r8q9hf1OA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 6/6] selftests/bpf: Fix get_func_ip offset test
 for CONFIG_X86_KERNEL_IBT
To:     Jiri Olsa <jolsa@kernel.org>
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

On Thu, Aug 11, 2022 at 2:16 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> With CONFIG_X86_KERNEL_IBT enabled the test for kprobe with offset
> won't work because of the extra endbr instruction.
>
> As suggested by Andrii adding CONFIG_X86_KERNEL_IBT detection
> and using appropriate offset value based on that.
>
> Also removing test7 program, because it does the same as test6.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/get_func_ip_test.c         | 62 +++++++++++++++----
>  .../selftests/bpf/progs/get_func_ip_test.c    | 20 +++---
>  2 files changed, 60 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> index 938dbd4d7c2f..a4dab2fa2258 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> @@ -2,7 +2,9 @@
>  #include <test_progs.h>
>  #include "get_func_ip_test.skel.h"
>
> -void test_get_func_ip_test(void)
> +static int config_ibt;
> +
> +static void test_function_entry(void)
>  {
>         struct get_func_ip_test *skel = NULL;
>         int err, prog_fd;
> @@ -12,14 +14,6 @@ void test_get_func_ip_test(void)
>         if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
>                 return;
>
> -       /* test6 is x86_64 specifc because of the instruction
> -        * offset, disabling it for all other archs
> -        */
> -#ifndef __x86_64__
> -       bpf_program__set_autoload(skel->progs.test6, false);
> -       bpf_program__set_autoload(skel->progs.test7, false);
> -#endif
> -
>         err = get_func_ip_test__load(skel);
>         if (!ASSERT_OK(err, "get_func_ip_test__load"))
>                 goto cleanup;
> @@ -38,16 +32,62 @@ void test_get_func_ip_test(void)
>
>         ASSERT_OK(err, "test_run");
>
> +       config_ibt = skel->bss->config_ibt;

skel->bss->config_ibt isn't actually necessary, you can just check
skel->kconfig->CONFIG_X86_KERNEL_IBT directly. And you won't need to
trigger BPF program unnecessary, libbpf will fill out kconfig section
during object/skeleton load phase.

> +       ASSERT_TRUE(config_ibt == 0 || config_ibt == 1, "config_ibt");

you won't need this anymore

> +       printf("%s:config_ibt %d\n", __func__, config_ibt);

and this is just debug leftover

> +
>         ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
>         ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
>         ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
>         ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
>         ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
> +

[...]

> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> index 6db70757bc8b..cb8e58183d46 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> @@ -2,6 +2,7 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> +#include <stdbool.h>
>
>  char _license[] SEC("license") = "GPL";
>
> @@ -13,12 +14,19 @@ extern const void bpf_modify_return_test __ksym;
>  extern const void bpf_fentry_test6 __ksym;
>  extern const void bpf_fentry_test7 __ksym;
>
> +extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
> +
> +bool config_ibt;
> +
>  __u64 test1_result = 0;
>  SEC("fentry/bpf_fentry_test1")
>  int BPF_PROG(test1, int a)
>  {
>         __u64 addr = bpf_get_func_ip(ctx);
>
> +       /* just to propagate config option value to user space */
> +       config_ibt = CONFIG_X86_KERNEL_IBT;
> +

as mentioned above, you shouldn't need it, just read
CONFIG_X86_KERNEL_IBT directly through skeleton

>         test1_result = (const void *) addr == &bpf_fentry_test1;
>         return 0;
>  }
> @@ -64,7 +72,7 @@ int BPF_PROG(test5, int a, int *b, int ret)
>  }
>
>  __u64 test6_result = 0;
> -SEC("kprobe/bpf_fentry_test6+0x5")
> +SEC("?kprobe/")

don't leave / at the end (and I thought that libbpf rejects this,
isn't that a case?...), just SEC("?kprobe")


>  int test6(struct pt_regs *ctx)
>  {
>         __u64 addr = bpf_get_func_ip(ctx);
> @@ -72,13 +80,3 @@ int test6(struct pt_regs *ctx)
>         test6_result = (const void *) addr == 0;
>         return 0;
>  }
> -
> -__u64 test7_result = 0;
> -SEC("kprobe/bpf_fentry_test7+5")
> -int test7(struct pt_regs *ctx)
> -{
> -       __u64 addr = bpf_get_func_ip(ctx);
> -
> -       test7_result = (const void *) addr == 0;
> -       return 0;
> -}
> --
> 2.37.1
>

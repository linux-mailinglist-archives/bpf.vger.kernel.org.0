Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AEC5856CB
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 00:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiG2WQL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 18:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiG2WQK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 18:16:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1251747AE
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 15:16:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i13so7338194edj.11
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Hh3SFY5d+m2395FvB6hTC86X/LhEqfajn1ThyR8QdlQ=;
        b=CHwZMXQEak42UKteDsud9DvgCoJCFH1vJVAwrun4jXDKYbYrzgFXKmQIj94fH+Q+De
         +T8MCaEi5H7ZpBA23zfv53NID8dYqP+BrCyPPvEdNsM7K4yvxfkF0LWkH1lRHZNGJUWy
         rZVVxMV0Ccc0NBvPcJGQp0qcA9fmOaVr/iFuS+XBmDK0oguj3I6eaB50SLsaLfz3RDdp
         y+2znQt+MXsM0s6WIP2wajdIuML9tvsbGieDfTq+TIJ4hKm1OiOSxiEzIT+gIFhOiDcX
         7F+eF1vfP5VcNhguplSVB3wfI5AFFv+7Hcb2ah1sXrmtEhi1VGP0RiYDkr7IIDLN+F0P
         HquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Hh3SFY5d+m2395FvB6hTC86X/LhEqfajn1ThyR8QdlQ=;
        b=SYs6eZSBP84nJUpD2/9NbbKw4/Ev6l5XD/XyYCweDydaKAJ5Q0qNgvvQyxo1yJWqX+
         ogkrwbkeBI8OrD7xKr+1sYWMlRyeZiQtyxF7EdwQnKiXU6s4gJ18Fs1voWEQ6vt7V0D5
         4NISfMC5lL06W+3FB7iwmGVg9JoQXEu/FJoKd6NPsIYoDNro4pC1kfxl516m5W9pouMW
         C2KswlWeQvH4qAvtsht0ps6LPQy79f9B04dOqv0rfTDK511/JS8gsmL6Sb+r1YGHW5rG
         wuHaG8bu9HxxKra6fX91aoBZLGKALtOV2eS+TCZrrN6xJRIzMMEhHW6WRFwCD0nkvlen
         i/BA==
X-Gm-Message-State: AJIora8XfvC/J4owG2lwr4OkoSmfq+mFFz9ErkTUVMiy44QU5Zx8t2wM
        Lo6GChRiZRT1glTA3tnNNZth+0yz5BlzF0fid3scEu0oVik=
X-Google-Smtp-Source: AGRyM1tgdjoxIdUn45xHmZyJGI1puH0yMkO9LjX+SwQeBHpga6WFd6KmN4NuBtASBMxcZ/d2mPFAnP2dGlCui5SxolE=
X-Received: by 2002:a05:6402:1c01:b0:43a:f714:bcbe with SMTP id
 ck1-20020a0564021c0100b0043af714bcbemr5632311edb.14.1659132967350; Fri, 29
 Jul 2022 15:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220724212146.383680-1-jolsa@kernel.org> <20220724212146.383680-5-jolsa@kernel.org>
In-Reply-To: <20220724212146.383680-5-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 Jul 2022 15:15:55 -0700
Message-ID: <CAEf4BzYnG3SLXs1+ebK+x7fM1ZaoPZ8=qH4mqUGhb6Ojf8x3Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Disable kprobe attach test
 with offset for CONFIG_X86_KERNEL_IBT
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 24, 2022 at 2:22 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Attach like 'kprobe/bpf_fentry_test6+0x5' will fail to attach
> when CONFIG_X86_KERNEL_IBT option is enabled because of the
> endbr instruction at the function entry.
>
> We would need to do manual attach with offset calculation based
> on the CONFIG_X86_KERNEL_IBT option, which does not seem worth
> the effort to me.
>
> Disabling these test when CONFIG_X86_KERNEL_IBT is enabled.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/get_func_ip_test.c         | 25 +++++++++++++++----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> index 938dbd4d7c2f..cb0b78fb29df 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> @@ -2,6 +2,24 @@
>  #include <test_progs.h>
>  #include "get_func_ip_test.skel.h"
>
> +/* assume IBT is enabled when kernel configs are not available */
> +#ifdef HAVE_GENHDR
> +# include "autoconf.h"
> +#else
> +#  define CONFIG_X86_KERNEL_IBT 1
> +#endif

this autoconf.h business is something I'd rather avoid, it would be
great to be able to use libbpf's __kconfig support to detect
CONFIG_X86_KERNEL_IBT instead? One way would be to mark test6/test7 as
non-auto-loadable (SEC("?...")). Load only test1-tes5, run tests, in
one of BPF programs propagate __kconfig CONFIG_X86_KERNEL_IBT to
user-space through a global variable. Attach skeleton, trigger
everything, remember whether IBT is enabled or not.

If it is defined, load skeleton again, but now enable test6 and test7
and manually attach them through bpf_program__attach_kprobe()
specifying offset as +5 or +9, depending on IBT. It's certainly a bit
more code, but we'll actually test IBT stuff properly.

WDYT?


> +
> +/* test6 and test7 are x86_64 specific because of the instruction
> + * offset, disabling it for all other archs
> + *
> + * CONFIG_X86_KERNEL_IBT adds endbr instruction at function entry,
> + * so disabling test6 and test7, because the offset is hardcoded
> + * in program section
> + */
> +#if !defined(__x86_64__) || defined(CONFIG_X86_KERNEL_IBT)
> +#define DISABLE_OFFSET_ATTACH 1
> +#endif
> +
>  void test_get_func_ip_test(void)
>  {
>         struct get_func_ip_test *skel = NULL;
> @@ -12,10 +30,7 @@ void test_get_func_ip_test(void)
>         if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
>                 return;
>
> -       /* test6 is x86_64 specifc because of the instruction
> -        * offset, disabling it for all other archs
> -        */
> -#ifndef __x86_64__
> +#if defined(DISABLE_OFFSET_ATTACH)
>         bpf_program__set_autoload(skel->progs.test6, false);
>         bpf_program__set_autoload(skel->progs.test7, false);
>  #endif
> @@ -43,7 +58,7 @@ void test_get_func_ip_test(void)
>         ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
>         ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
>         ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
> -#ifdef __x86_64__
> +#if !defined(DISABLE_OFFSET_ATTACH)
>         ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
>         ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
>  #endif
> --
> 2.35.3
>

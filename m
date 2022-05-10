Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E7952231A
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 19:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348416AbiEJRvh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348431AbiEJRv2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 13:51:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CFC5D18C
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 10:47:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y41so10715790pfw.12
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljQx4fzIgczdq4OX5LUrQFHCGSXxIfneJB7p2R2VJAc=;
        b=Ev8FqoXoXm/WgwfWv1IFNjl5YLMcFkOLJzeSL71XNjKmAk2Pxm4eIuoIJoSB9Z3OTF
         1HNEESJEU6c9Hn7WAQ+OEorKDdRR5cD/2NJB4/Ir8M3VyYXWxTQkrBxIHvN8jo6UDmHR
         8J68hionXAAVQUABgsxG8iCJpu5z/tRF3w+McHiJOTJQQ4QrZ0CG9ASTQGjpGgfA76LI
         FMwi2Ftbs5dRqMpJnMqyDwbERL89eiQUevhU211YA3+BVNJ2tVOIJOAfF9tIlqv5LqN/
         iE4W03FRF8ar2joHm8cMilqjbGCQJiolbj2MUKtYjwH4WcwRcLkJ2ZSpdL0V23ojFqbk
         juYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljQx4fzIgczdq4OX5LUrQFHCGSXxIfneJB7p2R2VJAc=;
        b=a6uedY1W6iSyxKfeNyDHUcvuuuiDQ9mLtS3YKPWk+IQXfrIsWPkN2h3Dyn13YFGqYJ
         rY60d21tB6pjAOo/n/XCM6qQ0caPtIoa5iPlmK48+UCuxhBmyn34uEjJsxls3otG6sU1
         bCCz4u0Sdecdglq5mbEY/0KC1C6aj9i3FDreLNAT7vatXFIQZt+3rGR5z/sR4HYgvXwp
         ov9S5qUQKfBqE0HZOyWlNsMC5YwPOWy/9uJGEWXHQxiFRLljyGn4PLMXi2k4UccRpXvs
         50MY25i5S55uQVWSoXfJvJN6VG9Au0tHi2p2qwAqZj2QyaDtZgU4DjU0LQThL464LQOV
         ByzA==
X-Gm-Message-State: AOAM530KQRappYPtR7k8pSu0wtT5IegxT+QHFXKvG4FRhdgi+GYAkg2q
        ZYevcpaEyZKKKirL1MoHbexcbWENkXJ0gdZLmBAI3K68
X-Google-Smtp-Source: ABdhPJz6i9CTVeWIcg1nkkdQkIpz+2sCXHA8k5ucf/czi7jpNofm7aB+5MUSTY35LwT8zJkBa425xej1cjJHfYFj70w=
X-Received: by 2002:a05:6a00:24d2:b0:510:9f7a:3eec with SMTP id
 d18-20020a056a0024d200b005109f7a3eecmr12465311pfv.57.1652204849889; Tue, 10
 May 2022 10:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220430215727.113472-1-langston.barrett@gmail.com>
In-Reply-To: <20220430215727.113472-1-langston.barrett@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 10 May 2022 10:47:18 -0700
Message-ID: <CAADnVQKZ1ceBodEbwyObd1vd0CbF6n5Ukn4zqKa4QhRytEiLzA@mail.gmail.com>
Subject: Re: [PATCH] bpf: KUnit-based soundness tests for tnums
To:     Langston Barrett <langston.barrett@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 2, 2022 at 1:15 AM Langston Barrett
<langston.barrett@gmail.com> wrote:
>
> Add tests that check that each binary operation on tnums is a valid
> abstraction of the corresponding operation on u64s. This soundness
> condition is an important part of the security of eBPF.
>
> Signed-off-by: Langston Barrett <langston.barrett@gmail.com>
> ---
>
> I also made sure that these tests are meaningful by changing the tnum
> operations or test conditions and ensuring that they fail when such
> erroneous modifications are made.
>
> This is my first time submitting a kernel patch. I've read through the
> documentation on doing so, but apologies in advance if I've missed
> something. Thank you very much for your time.
>
>  kernel/bpf/Kconfig     |   7 ++
>  kernel/bpf/Makefile    |   2 +
>  kernel/bpf/tnum_test.c | 208 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 217 insertions(+)
>  create mode 100644 kernel/bpf/tnum_test.c
>
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index d56ee177d5f8..c1a726f33193 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -36,6 +36,13 @@ config BPF_SYSCALL
>           Enable the bpf() system call that allows to manipulate BPF programs
>           and maps via file descriptors.
>
> +config BPF_TNUM_TEST
> +       tristate "Enable soundness tests for BPF tnums" if !KUNIT_ALL_TESTS
> +       depends on BPF_SYSCALL && KUNIT=y
> +       default KUNIT_ALL_TESTS
> +       help
> +         Enable KUnit-based soundness tests for BPF tnums.
> +
>  config BPF_JIT
>         bool "Enable BPF Just In Time compiler"
>         depends on BPF
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index c1a9be6a4b9f..11d88798a538 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -40,3 +40,5 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
>  obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>  $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
>         $(call if_changed_rule,cc_o_c)
> +
> +obj-$(CONFIG_BPF_TNUM_TEST) += tnum_test.o
> diff --git a/kernel/bpf/tnum_test.c b/kernel/bpf/tnum_test.c
> new file mode 100644
> index 000000000000..168780b648ac
> --- /dev/null
> +++ b/kernel/bpf/tnum_test.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Soundness tests for tnums.
> + *
> + * Its important that tnums (and other BPF verifier analyses) soundly
> + * overapproximate the runtime values of registers. If they fail to do so, then
> + * kernel memory corruption may result (see e.g., CVE-2020-8835 and
> + * CVE-2021-3490 for examples where unsound bounds tracking led to exploitable
> + * bugs).
> + *
> + * The implementations of some tnum arithmetic operations have been proven
> + * sound, see "Sound, Precise, and Fast Abstract Interpretation with Tristate
> + * Numbers" (https://arxiv.org/abs/2105.05398). These tests corroborate these
> + * results on actual machine hardware, protect against regressions if the
> + * implementations change, and provide a template for testing new abstract
> + * operations.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/tnum.h>
> +
> +/* Some number of test cases, particular values not super important but chosen
> + * to be most likely to trigger edge cases.
> + */
> +static u64 interesting_ints[] = { S64_MIN, S32_MIN, -1,             0,
> +                                 1,       2,       U32_MAX, U64_MAX };

Frankly I don't see how running the same test over and over
again will help us discover bugs or catch a regression.
Sorry not applying this.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221182AE798
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 05:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgKKErZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 23:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKErZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 23:47:25 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E315DC0613D1;
        Tue, 10 Nov 2020 20:47:24 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 10so730290ybx.9;
        Tue, 10 Nov 2020 20:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esfIRAjmM0Mp9sLY3w4RGBHXXzudRRDgKKW0gNJ3y4E=;
        b=TIlU4nwg8OWfkEL6qONWu/jdNhdssxyYZd5muFGi7JQln2CUD0gzzqiH0iopA21jPN
         nwvBnUPaQOxfffiwJcJlPIM6Krx2mXBdLJdIZY5toJyFzNtX5TbEXRADjJXlnFLajqRd
         5VIVzSk8x26/2ejcMsWyd/QUoqN5RFqz7vAGO+zY3NT0zW4PiOIdDCFALawW4m/i19KT
         ZEOHckpY9MfG2H92V2KwuvT2wI7pHkfKtvowEkksEHuHXj3QcxbRZxuHYM1fWM3rsH6l
         B9vWNdRWSF7w8AM9l7dpvMS5khAax8URWCI+aak55VVOEqPB1EphBoDJhS3Hd/mr/jEz
         5Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esfIRAjmM0Mp9sLY3w4RGBHXXzudRRDgKKW0gNJ3y4E=;
        b=uCyMyxc2PYcA9aVriVYFW0GxnZ55btw1Dzd7Rc5XBZPitKdrPvT6opkzoY0bfLBArm
         wgu1VNP54AaF9nItkLe7XAqHEJD9jDT0LKG6lrvbEcAfeLYd0JmZU/S0ASK1K0pu3pFB
         7jEzhVPy6D3/thjZjGzFKAEGw7L532IhnSFro4yGvi/wEQq6s7PpN0BqOQqG+l+GLouv
         diaMMWwC1QWP7ZiVQyD1/nXuYCcMfdXZbEh5sjV8rc8TdlSG+Ha1Ls1M2pGVqUGwuzPV
         PQlrQbQR/q4UshLbGXM+JGrvSl0/5RGHFKPDdnBsPYxiHaRSrPqA3SfXI0EQcgcb6jze
         AZWQ==
X-Gm-Message-State: AOAM53122yqxZPFYB1rflF1W1k+0stmNreVjKWP/f3l4czQJlvBQRrKm
        RKcHOA4r3PWLw1CGTV/1FnKnPqZ/d8vaW7bfc28=
X-Google-Smtp-Source: ABdhPJyyG20oNSv0fntjAdtQlqkOofFOG4dgwyl1x1DVvFYvlLCVb0YHU01GvtIWwBQ1YmauV+Ljd6BqyRRoBAmSygg=
X-Received: by 2002:a25:df82:: with SMTP id w124mr3260680ybg.347.1605070044155;
 Tue, 10 Nov 2020 20:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20201110210342.146242-1-me@ubique.spb.ru>
In-Reply-To: <20201110210342.146242-1-me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 20:47:13 -0800
Message-ID: <CAEf4BzZQSJZMRRvfzHUE+dhyMdP2BTkeXaVyrNymFbepymvj5Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: relax return code check for subprograms
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 10, 2020 at 1:03 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> Currently verifier enforces return code checks for subprograms in the
> same manner as it does for program entry points. This prevents returning
> arbitrary scalar values from subprograms. Scalar type of returned values
> is checked by btf_prepare_func_args() and hence it should be safe to
> allow only scalars for now. Relax return code checks for subprograms and
> allow any correct scalar values.
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> Fixes: 51c39bb1d5d10 (bpf: Introduce function-by-function verification)
> ---

Please make sure that your subject has [PATCH bpf-next], if it's
targeted against bpf-next tree.

>  kernel/bpf/verifier.c                         | 26 ++++++++++++++-----
>  .../bpf/prog_tests/test_global_funcs.c        |  1 +
>  .../selftests/bpf/progs/test_global_func8.c   | 25 ++++++++++++++++++
>  3 files changed, 45 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func8.c
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 10da26e55130..c108b19e1fad 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7791,7 +7791,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>         return 0;
>  }
>
> -static int check_return_code(struct bpf_verifier_env *env)
> +static int check_return_code(struct bpf_verifier_env *env, bool is_subprog)
>  {
>         struct tnum enforce_attach_type_range = tnum_unknown;
>         const struct bpf_prog *prog = env->prog;
> @@ -7801,10 +7801,12 @@ static int check_return_code(struct bpf_verifier_env *env)
>         int err;
>
>         /* LSM and struct_ops func-ptr's return type could be "void" */
> -       if ((prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
> -            prog_type == BPF_PROG_TYPE_LSM) &&
> -           !prog->aux->attach_func_proto->type)
> -               return 0;
> +       if (!is_subprog) {

I think just adding `!is_subprog` && to existing if is cleaner and
more succinct.

> +               if ((prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
> +                    prog_type == BPF_PROG_TYPE_LSM) &&
> +                   !prog->aux->attach_func_proto->type)
> +                       return 0;
> +       }
>
>         /* eBPF calling convetion is such that R0 is used
>          * to return the value from eBPF program.
> @@ -7821,6 +7823,16 @@ static int check_return_code(struct bpf_verifier_env *env)
>                 return -EACCES;
>         }
>
> +       reg = cur_regs(env) + BPF_REG_0;
> +       if (is_subprog) {
> +               if (reg->type != SCALAR_VALUE) {
> +                       verbose(env, "At subprogram exit the register R0 is not a scalar value (%s)\n",
> +                               reg_type_str[reg->type]);
> +                       return -EINVAL;
> +               }
> +               return 0;
> +       }
> +

It's not clear why reg->type != SCALAR_VALUE check is done after
prog_type-specific check. Is there any valid case where we'd allow
non-scalar return? Maybe Alexei can chime in here.

If not, then I'd just move the existing SCALAR_VALUE check below up
here, unconditionally for subprog and non-subprog. And then just exit
after that, if we are processing a subprog.

>         switch (prog_type) {
>         case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>                 if (env->prog->expected_attach_type == BPF_CGROUP_UDP4_RECVMSG ||
> @@ -7874,7 +7886,6 @@ static int check_return_code(struct bpf_verifier_env *env)
>                 return 0;
>         }
>
> -       reg = cur_regs(env) + BPF_REG_0;
>         if (reg->type != SCALAR_VALUE) {
>                 verbose(env, "At program exit the register R0 is not a known value (%s)\n",
>                         reg_type_str[reg->type]);
> @@ -9266,6 +9277,7 @@ static int do_check(struct bpf_verifier_env *env)
>         int insn_cnt = env->prog->len;
>         bool do_print_state = false;
>         int prev_insn_idx = -1;
> +       const bool is_subprog = env->cur_state->frame[0]->subprogno;

this can probably be done inside check_return_code(), no?

>
>         for (;;) {
>                 struct bpf_insn *insn;
> @@ -9530,7 +9542,7 @@ static int do_check(struct bpf_verifier_env *env)
>                                 if (err)
>                                         return err;
>
> -                               err = check_return_code(env);
> +                               err = check_return_code(env, is_subprog);
>                                 if (err)
>                                         return err;
>  process_bpf_exit:
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> index 193002b14d7f..32e4348b714b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> @@ -60,6 +60,7 @@ void test_test_global_funcs(void)
>                 { "test_global_func5.o" , "expected pointer to ctx, but got PTR" },
>                 { "test_global_func6.o" , "modified ctx ptr R2" },
>                 { "test_global_func7.o" , "foo() doesn't return scalar" },
> +               { "test_global_func8.o" },
>         };
>         libbpf_print_fn_t old_print_fn = NULL;
>         int err, i, duration = 0;
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func8.c b/tools/testing/selftests/bpf/progs/test_global_func8.c
> new file mode 100644
> index 000000000000..1e9a87f30b7c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_func8.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2020 Facebook */
> +#include <stddef.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +__attribute__ ((noinline))

nit: use __noinline, it's defined in bpf_helpers.h

> +int bar(struct __sk_buff *skb)
> +{
> +       return bpf_get_prandom_u32();
> +}
> +
> +static __always_inline int foo(struct __sk_buff *skb)

foo is not essential, just inline it in test_cls below

> +{
> +       if (!bar(skb))
> +               return 0;
> +
> +       return 1;
> +}
> +
> +SEC("cgroup_skb/ingress")
> +int test_cls(struct __sk_buff *skb)
> +{
> +       return foo(skb);
> +}

I also wonder what happens if __noinline function has return type
void? Do you mind adding another BPF program that uses non-inline
global void function? We might need to handle that case in the
verifier explicitly.


> --
> 2.24.1
>

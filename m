Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9940B604FF2
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 20:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJSSxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 14:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiJSSxK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 14:53:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47451974EA
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:53:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so42079674ejb.13
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EkXwkQ4C7Su3KleEkGzYxv73OZ+U5Li65AI6PFS6w2c=;
        b=oS7zsCA6/3e0sL+xCu4YJfBZniKonWBFd+7Ug5I38hB1Z4zOKCMDZKIMJaLZNMPGlP
         qfn0qIK5vjdKcx5kICZem53N9xn3aYfug0QlgaBWYzpVURFtnwlM6w0cUhWogXuH2qeO
         uZEFIUzoWINXJHJ8+1TWFZlaUAf2oG2aKenFyuKptHwtbN9TezQd/tGW8+pnTvDuubbm
         +TNlmJORsCRubCKkqv4zCBneCVrR9HymQM1J6rXYP1wzUN+HDhh2ehndP34iYf/3bW+f
         bePMz8fWgWrlpTMt+FLHUPDp2aIdbIP+ev45rMnrb0GEmGC9lwEbMsYFTnbd9hLtHF38
         y5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkXwkQ4C7Su3KleEkGzYxv73OZ+U5Li65AI6PFS6w2c=;
        b=tZ2+lkSkiL2OCdMufmhk/IQ8FC4HUTmvav+D75Bq+yg73TWODZV+0B1OlScspHZqrJ
         B+gQ5Offi5+yxHTrLLhSIUFHz2qVqOlEvDS6xMu9WbSbd3Z7jfZsyT1Rd4XtFh96HSlb
         tSy8ixeFNjlPuHQqFMb4/qdZDdEPYj1xLKR+ix1Zl0Erh8le1ZHeRpE+Lfz84DwI6HwU
         v4DF5cGjP3dp/zEZzAevhyspfeuz4sDNWFYT3+7mJzTmXhD3X7oUjTim8prxZqmnMVNq
         CZ0zC2wzmdzxfAVViakR2ql4mzCUICXjbBjTqhvh7VxTddhEEyKn3EOvJZeea0Fay7lT
         nbcw==
X-Gm-Message-State: ACrzQf0Hx7q3rf5sdrzO7cD1jgWiv8VVeFZ9Nq9HKyaW9z31JZZ/g2dC
        w9WK1WdwSQfr8fzjm9uVk62C8gP5l4UQOG0IeNU=
X-Google-Smtp-Source: AMsMyM4o+dYuzb548A/+RKbsp6e7mpVXDlAaLH/aOJgVWVNBodyMdoCI0eRr8k0Q7PTa02e6tgVBa+NdYf6bJRNQdNk=
X-Received: by 2002:a17:907:6e93:b0:78d:dff1:71e3 with SMTP id
 sh19-20020a1709076e9300b0078ddff171e3mr7588152ejc.94.1666205588109; Wed, 19
 Oct 2022 11:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-7-memxor@gmail.com>
In-Reply-To: <20221018135920.726360-7-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Oct 2022 11:52:56 -0700
Message-ID: <CAADnVQL_CWV7auFJFnkTy6wzo28JSN2e8-H7J6AnG79ov9Zjyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/13] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
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

On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Currently, the dynptr function is not checking the variable offset part
> of PTR_TO_STACK that it needs to check. The fixed offset is considered
> when computing the stack pointer index, but if the variable offset was
> not a constant (such that it could not be accumulated in reg->off), we
> will end up a discrepency where runtime pointer does not point to the
> actual stack slot we mark as STACK_DYNPTR.
>
> It is impossible to precisely track dynptr state when variable offset is
> not constant, hence, just like bpf_timer, kptr, bpf_spin_lock, etc.
> simply reject the case where reg->var_off is not constant. Then,
> consider both reg->off and reg->var_off.value when computing the stack
> pointer index.
>
> A new helper dynptr_get_spi is introduced to hide over these details
> since the dynptr needs to be located in multiple places outside the
> process_dynptr_func checks, hence once we know it's a PTR_TO_STACK, we
> need to enforce these checks in all places.
>
> Note that it is disallowed for unprivileged users to have a non-constant
> var_off, so this problem should only be possible to trigger from
> programs having CAP_PERFMON. However, its effects can vary.
>
> Without the fix, it is possible to replace the contents of the dynptr
> arbitrarily by making verifier mark different stack slots than actual
> location and then doing writes to the actual stack address of dynptr at
> runtime.
>
> Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 80 +++++++++++++++----
>  .../testing/selftests/bpf/prog_tests/dynptr.c |  6 +-
>  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
>  3 files changed, 67 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8f667180f70f..0fd73f96c5e2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -610,11 +610,34 @@ static void print_liveness(struct bpf_verifier_env *env,
>                 verbose(env, "D");
>  }
>
> -static int get_spi(s32 off)
> +static int __get_spi(s32 off)
>  {
>         return (-off - 1) / BPF_REG_SIZE;
>  }
>
> +static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +{
> +       int spi;
> +
> +       if (reg->off % BPF_REG_SIZE) {
> +               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> +               return -EINVAL;
> +       }

I think this cannot happen.

> +       if (!tnum_is_const(reg->var_off)) {
> +               verbose(env, "dynptr has to be at the constant offset\n");
> +               return -EINVAL;
> +       }

This part can.

> +       spi = __get_spi(reg->off + reg->var_off.value);
> +       if (spi < 1) {
> +               verbose(env, "cannot pass in dynptr at an offset=%d\n",
> +                       (int)(reg->off + reg->var_off.value));
> +               return -EINVAL;
> +       }
> +       return spi;
> +}

This one is a more conservative (read: redundant) check.
The is_spi_bounds_valid() is doing it better.
How about keeping get_spi(reg) as error free and use it
directly in places where it cannot fail without
defensive WARN_ON_ONCE.
int get_spi(reg)
{ return (-reg->off - reg->var_off.value - 1) / BPF_REG_SIZE; }

While moving tnum_is_const() check into is_spi_bounds_valid() ?

Like is_spi_bounds_valid(state, reg, spi) ?

We should probably remove BPF_DYNPTR_NR_SLOTS since
there are so many other places where dynptr is assumed
to be 16-bytes. That macro doesn't help at all.
It only causes confusion.

I guess we can replace is_spi_bounds_valid() with a differnet
helper that checks and computes spi.
Like get_spi_and_check(state, reg, &spi)
and use it in places where we have get_spi + is_spi_bounds_valid
while using unchecked get_spi where it cannot fail?

If we only have get_spi_and_check() we'd have to add
WARN_ON_ONCE in a few places and that bothers me...
due to defensive programming...
If code is so complex that we cannot think it through
we have to refactor it. Sprinkling WARN_ON_ONCE (just to be sure)
doesn't inspire confidence.

> +
>  static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
>  {
>         int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> @@ -725,7 +748,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>         enum bpf_dynptr_type type;
>         int spi, i, id;
>
> -       spi = get_spi(reg->off);
> +       spi = dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return spi;
>
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return -EINVAL;

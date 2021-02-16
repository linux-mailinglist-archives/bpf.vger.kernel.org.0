Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA531CE16
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBPQbq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 11:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhBPQbp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 11:31:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E059C64DF0
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613493064;
        bh=iyCU3hpc13jFZh1s9sxw12hiCB7/QrDgeQU2aYpbJCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JyTEFAaqN6phYqJmcDEnSXcxnuPjOgdX1pkCgUB7aY9klB5/zQHe0TWSczxnEAkZT
         mMl8JCZZWJOaqzfeFthQMx79rnuCBJ2uU39eTn9y1TsF4GEw+KOMGKWJjJA9btKzA7
         evXr+KuWH9gUDWtRD2DP0B2DiFR8/+Fmzm20Al8c+pnu/ocS1vjV5IM/U57ayABdUQ
         9jf27QQr0WIP97C2Y1tvuGAuENDxKc70q96GB7pik0YxEOOF5VsuhErEcAQBVOBIb0
         qaVMB9s0s5+ExS6+0v4u6zGNvumIvhro686NEGtSNiKJ4lW6M50WWtpKdAvUE1tcwS
         snLvu94NNMrJA==
Received: by mail-lf1-f42.google.com with SMTP id v24so16783605lfr.7
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 08:31:03 -0800 (PST)
X-Gm-Message-State: AOAM531n9/xOK4cPYOMsX/RKwWO4iyB0JJ5oWAH49RXva2xN+W4yG6mD
        WuQ5yUNASlBOKr35hkQJCIiHV1/NiLDNhdwFcKrLbA==
X-Google-Smtp-Source: ABdhPJwcIXrqzTDSzsTTzik9E/Ow81vQBCtmw2BHGwkb4SgxJHuvzvBp/YJBupZNUeJtLe/7+lfrLDh8WkMyF+EelAg=
X-Received: by 2002:ac2:5452:: with SMTP id d18mr12616872lfn.233.1613493062195;
 Tue, 16 Feb 2021 08:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20210216141925.1549405-1-jackmanb@google.com>
In-Reply-To: <20210216141925.1549405-1-jackmanb@google.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 16 Feb 2021 17:30:51 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6QQcD=47bth4WRtxVO0wYSA-j6i2DNfV0RaW1P8tjawA@mail.gmail.com>
Message-ID: <CACYkzJ6QQcD=47bth4WRtxVO0wYSA-j6i2DNfV0RaW1P8tjawA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 16, 2021 at 3:19 PM Brendan Jackman <jackmanb@google.com> wrote:
>
> As pointed out by Ilya and explained in the new comment, there's a
> discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> the value from memory into r0, while x86 only does so when r0 and the
> value in memory are different. The same issue affects s390.
>
> At first this might sound like pure semantics, but it makes a real
> difference when the comparison is 32-bit, since the load will
> zero-extend r0/rax.
>
> The fix is to explicitly zero-extend rax after doing such a
> CMPXCHG. Since this problem affects multiple archs, this is done in
> the verifier by patching in a BPF_ZEXT_REG instruction after every
> 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> can do a look-ahead with insn_is_zext to skip the unnecessary mov.
>
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: KP Singh <kpsingh@kernel.org>

> ---
>
> Difference from v1[1]: Now solved centrally in the verifier instead of
>   specifically for the x86 JIT. Thanks to Ilya and Daniel for the suggestions!
>
> [1] https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
>
>  kernel/bpf/verifier.c                         | 36 +++++++++++++++++++
>  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 +++++++++++++
>  .../selftests/bpf/verifier/atomic_or.c        | 26 ++++++++++++++
>  3 files changed, 87 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 16ba43352a5f..7f4a83d62acc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11889,6 +11889,39 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
>         return 0;
>  }
>
> +/* BPF_CMPXCHG always loads a value into R0, therefore always zero-extends.
> + * However some archs' equivalent instruction only does this load when the
> + * comparison is successful. So here we add a BPF_ZEXT_REG after every 32-bit
> + * CMPXCHG, so that such archs' JITs don't need to deal with the issue. Archs
> + * that don't face this issue may use insn_is_zext to detect and skip the added
> + * instruction.
> + */
> +static int add_zext_after_cmpxchg(struct bpf_verifier_env *env)
> +{
> +       struct bpf_insn zext_patch[2] = { [1] = BPF_ZEXT_REG(BPF_REG_0) };

I was initially confused as to why do we have 2 instructions here for the patch.

> +       struct bpf_insn *insn = env->prog->insnsi;
> +       int insn_cnt = env->prog->len;
> +       struct bpf_prog *new_prog;
> +       int delta = 0; /* Number of instructions added */
> +       int i;
> +
> +       for (i = 0; i < insn_cnt; i++, insn++) {
> +               if (insn->code != (BPF_STX | BPF_W | BPF_ATOMIC) || insn->imm != BPF_CMPXCHG)
> +                       continue;
> +
> +               zext_patch[0] = *insn;

But the patch also needs to have the original instruction, so it makes sense.


> +               new_prog = bpf_patch_insn_data(env, i + delta, zext_patch, 2);
> +               if (!new_prog)
> +                       return -ENOMEM;
> +
> +               delta++;
> +               env->prog = new_prog;
> +               insn = new_prog->insnsi + i + delta;
> +       }
> +
> +       return 0;
> +}
> +
>  static void free_states(struct bpf_verifier_env *env)
>  {
>         struct bpf_verifier_state_list *sl, *sln;
> @@ -12655,6 +12688,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
>         if (ret == 0)
>                 ret = fixup_call_args(env);
>
> +       if (ret == 0)
> +               ret = add_zext_after_cmpxchg(env);
> +
>         env->verification_time = ktime_get_ns() - start_time;
>         print_verification_stats(env);
>
> diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> index 2efd8bcf57a1..6e52dfc64415 100644
> --- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> +++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> @@ -94,3 +94,28 @@
>         .result = REJECT,
>         .errstr = "invalid read from stack",
>

[...]

>
> base-commit: 45159b27637b0fef6d5ddb86fc7c46b13c77960f
> --
> 2.30.0.478.g8a0d178c01-goog
>

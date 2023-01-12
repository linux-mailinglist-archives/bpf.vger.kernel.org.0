Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB2668580
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 22:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbjALVfQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 16:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjALVev (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 16:34:51 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78623C01;
        Thu, 12 Jan 2023 13:24:46 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mp20so1310001ejc.7;
        Thu, 12 Jan 2023 13:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yeksMNOkbmrgHJ4AqWxk7sw5tPdmMMAaJsdHsSRA27Y=;
        b=hJrP2Iz8OyG5R1gO+FWRlS+W8NKiUKvsen/zm8TIJzaVyg6tN+U4OQPxt2raQnFjXU
         psKTbOOUdJPSzav7zHohbStMPSm7pLgGqm6hHjnGlvxKAUEu8D9wD2nFSc4YPW8HYSFz
         PTdJsZHAeESWeGpjEoxr2SXWCxzMCx7+Gl6AFKw6uH4nEedOkH3LtOEMV/dX1gerz2If
         Zr3BRCPlnBKqrDzg0IKONdY6Uj6rVcc3pTsXScvXsgRVBOcroccPnRE9hHO4JbyGmnxd
         4QHfpzN/2Z45uLulknC9T7Dx0QlMQj3VqsD8VyEBVQhQj4aP70/3raZ1Ac0RmVHdR4du
         H/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeksMNOkbmrgHJ4AqWxk7sw5tPdmMMAaJsdHsSRA27Y=;
        b=mEOn/O324guNlokM5CCksOZdRKVW8CipuquqPem01MVpKjV/HGZDqNPK5rXXcnKcBB
         kobQyj3hf7XEoZIXxjlk4vqSJBy2Gwg3fYGiYvpH+OvPTjg0gtd0FgK/KDW2CUuK9vAJ
         Yv0rvDj7hZCgIxc1TUvINRX8QQpdxgotdJ+mw7DzM6Vb1knnoAW+eReCsVEW8/kZ+Xqx
         fT9e8jNO1Jn6EMHqkwAZhvRpSU++FnNjTo2YAjbCFq0E6VKItHRPDxY5uX1AqXNxek9r
         709HRFeRpcmBEjJdX6+iSu/NDILcKSlKW21d63KnCf7ONU5tJPbWraQBrAht6BFq8SU7
         xSGA==
X-Gm-Message-State: AFqh2kr8OrwThtXixZEWanNOtR4A3adHuIOJ89Mf0TtJDk0A6AWDjTP9
        pyIkNdw70l6JNZjEEZLnHtzgRvQjT85q3K+l42E=
X-Google-Smtp-Source: AMrXdXuP55t2ljOrWNp0T39mVI3QnX7074tWlxDcai8A37qWz2L/rRiYy0Lexz3XiZN5XL0/KjrFAg098oDD0QjhlcI=
X-Received: by 2002:a17:906:a18c:b0:7c0:f2cf:3515 with SMTP id
 s12-20020a170906a18c00b007c0f2cf3515mr5429727ejy.327.1673558684971; Thu, 12
 Jan 2023 13:24:44 -0800 (PST)
MIME-Version: 1.0
References: <edc95bad-aada-9cfc-ffe2-fa9bb206583c@cs.fau.de> <20230109150544.41465-1-gerhorst@cs.fau.de>
In-Reply-To: <20230109150544.41465-1-gerhorst@cs.fau.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 12 Jan 2023 13:24:33 -0800
Message-ID: <CAADnVQLFtAC5NvVfakhAisKzEQar+yqhFygG4_n+7FWoSnGuwg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix pointer-leak due to insufficient speculative
 store bypass mitigation
To:     Luis Gerhorst <gerhorst@cs.fau.de>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Piotr Krysiuk <piotras@gmail.com>,
        Benedict Schlueter <benedict.schlueter@rub.de>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        stefan.saecherl@use.startmail.com,
        Henriette Hofmeier <henriette.hofmeier@rub.de>
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

On Mon, Jan 9, 2023 at 7:07 AM Luis Gerhorst <gerhorst@cs.fau.de> wrote:
>
> To mitigate Spectre v4, 2039f26f3aca ("bpf: Fix leakage due to
> insufficient speculative store bypass mitigation") inserts lfence
> instructions after 1) initializing a stack slot and 2) spilling a
> pointer to the stack.
>
> However, this does not cover cases where a stack slot is first
> initialized with a pointer (subject to sanitization) but then
> overwritten with a scalar (not subject to sanitization because the slot
> was already initialized). In this case, the second write may be subject
> to speculative store bypass (SSB) creating a speculative
> pointer-as-scalar type confusion. This allows the program to
> subsequently leak the numerical pointer value using, for example, a
> branch-based cache side channel.
>
> To fix this, also sanitize scalars if they write a stack slot that
> previously contained a pointer. Assuming that pointer-spills are only
> generated by LLVM on register-pressure, the performance impact on most
> real-world BPF programs should be small.
>
> The following unprivileged BPF bytecode drafts a minimal exploit and the
> mitigation:
>
>   [...]
>   // r6 = 0 or 1 (skalar, unknown user input)
>   // r7 = accessible ptr for side channel
>   // r10 = frame pointer (fp), to be leaked
>   //
>   r9 = r10 # fp alias to encourage ssb
>   *(u64 *)(r9 - 8) = r10 // fp[-8] = ptr, to be leaked
>   // lfence added here because of pointer spill to stack.
>   //
>   // Ommitted: Dummy bpf_ringbuf_output() here to train alias predictor
>   // for no r9-r10 dependency.
>   //
>   *(u64 *)(r10 - 8) = r6 // fp[-8] = scalar, overwrites ptr
>   // 2039f26f3aca: no lfence added because stack slot was not STACK_INVALID,
>   // store may be subject to SSB
>   //
>   // fix: also add an lfence when the slot contained a ptr
>   //
>   r8 = *(u64 *)(r9 - 8)
>   // r8 = architecturally a scalar, speculatively a ptr
>   //
>   // leak ptr using branch-based cache side channel:
>   r8 &= 1 // choose bit to leak
>   if r8 == 0 goto SLOW // no mispredict
>   // architecturally dead code if input r6 is 0,
>   // only executes speculatively iff ptr bit is 1
>   r8 = *(u64 *)(r7 + 0) # encode bit in cache (0: slow, 1: fast)
> SLOW:
>   [...]
>
> After running this, the program can time the access to *(r7 + 0) to
> determine whether the chosen pointer bit was 0 or 1. Repeat this 64
> times to recover the whole address on amd64.
>
> In summary, sanitization can only be skipped if one scalar is
> overwritten with another scalar. Scalar-confusion due to speculative
> store bypass can not lead to invalid accesses because the pointer bounds
> deducted during verification are enforced using branchless logic. See
> 979d63d50c0c ("bpf: prevent out of bounds speculation on pointer
> arithmetic") for details.
>
> Do not make the mitigation depend on
> !env->allow_{uninit_stack,ptr_leaks} because speculative leaks are
> likely unexpected if these were enabled. For example, leaking the
> address to a protected log file may be acceptable while disabling the
> mitigation might unintentionally leak the address into the cached-state
> of a map that is accessible to unprivileged processes.
>
> Fixes: 2039f26f3aca ("bpf: Fix leakage due to insufficient speculative store bypass mitigation")

All makes sense to me.
Daniel,

please take a look.

> Signed-off-by: Luis Gerhorst <gerhorst@cs.fau.de>
> Acked-by: Henriette Hofmeier <henriette.hofmeier@rub.de>
> ---
>  kernel/bpf/verifier.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a5255a0dcbb6..5e3aa4a75bd6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3287,7 +3287,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>                 bool sanitize = reg && is_spillable_regtype(reg->type);
>
>                 for (i = 0; i < size; i++) {
> -                       if (state->stack[spi].slot_type[i] == STACK_INVALID) {
> +                       u8 type = state->stack[spi].slot_type[i];
> +                       if (type != STACK_MISC && type != STACK_ZERO) {
>                                 sanitize = true;
>                                 break;
>                         }
> --
> 2.34.1
>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35354FED39
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 04:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiDMC6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 22:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDMC6T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 22:58:19 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C32E3587D
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 19:56:00 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y16so302130ilc.7
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 19:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OUkfw6LAUoVS0CZZGPJCHj+FgHB6BupOycPtwteKo4=;
        b=J78ACzEfuAc2OjC+ItqN98BV1BvoXCnLVORkTvqJb5Z8uPSsyCqzc/5oTI6mMSkNJe
         RM8wLlwZHV4sOPWKmbblfINuqdJqv8PubWXx8o/2uBuuWhkXI7hrf9SW+F5lBv2m+/iw
         ag01Q2rfG71qYYk6HJJfaY5zz/CMP6WkUlXRD55xO5OO/SQHnKKnTT1wz5FOGD4oQQ15
         3RxWYhue/Qj0foaCJ4kBC2vNXP5GL+0wcVOxjS0sU12YOLhpMicqwMceUd1CEGiSb+nv
         hmSEDqRnTk9hCIvJazauapd4ZXOdMy6Bey/89Q64sQHIfByL8B/wPT+Ie7CiWpJK/bwn
         5keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OUkfw6LAUoVS0CZZGPJCHj+FgHB6BupOycPtwteKo4=;
        b=JDCmH7X9nW9RHcY/DzNKkWwLXBYZeGMQWR/TOv6nAbXGRu2j8WyAvtczhIH475rkCt
         XVXHkqIwKYCp+xRkfUTKBD19QECN0AhGOEBjz4LA8wZVp4t3w+yq9CqqSMn4hJXcbm0z
         +5FjjyK1XR4BBpL7dENKf5psZ+jsQmWRhzU7JBDSYG+tmiqWLRnN8GrU+7TpsiGjy4rf
         4sNCfklWGtv2PQKSMOmoRoE3gkGFS9mz188N+FHKF4XwrAr215+Gm1KxrPBv5YcQIzPC
         ss9VZ3qPjPhv10yjWrH+GLeb9yrviQduFONWOTw8qu6ATB5GMEQooTxZj9khegJSKAJ2
         PPJA==
X-Gm-Message-State: AOAM531VctVdbJSUlafZqb7K5nlu+pEBwWCsTxZrHKpodq2b9T+pCMRQ
        JZoGFdah/db4/ZMlN1EKmfQqZfDF4fVG2ISLpSY4P7DcG/I=
X-Google-Smtp-Source: ABdhPJxTXDftBgaDGeAiEYJ1dUFRNFiTeT5oFMblpoTL1/gBaKb31tB1yDhbTto9HWGvb7LEhZPJ0Zykz+GLf5z7Xwg=
X-Received: by 2002:a92:cd8a:0:b0:2ca:9337:2f47 with SMTP id
 r10-20020a92cd8a000000b002ca93372f47mr8472395ilb.252.1649818559425; Tue, 12
 Apr 2022 19:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220412165555.4146407-1-kuifeng@fb.com> <20220412165555.4146407-3-kuifeng@fb.com>
In-Reply-To: <20220412165555.4146407-3-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Apr 2022 19:55:48 -0700
Message-ID: <CAEf4BzZiEAysLb41XNzvZXdHqr4ikgw8ggTbvd8KpsWvqtS5zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/5] bpf, x86: Create bpf_tramp_run_ctx on the
 caller thread's stack
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Tue, Apr 12, 2022 at 9:56 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> BPF trampolines will create a bpf_tramp_run_ctx, a bpf_run_ctx, on
> stacks and set/reset the current bpf_run_ctx before/after calling a
> bpf_prog.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 55 +++++++++++++++++++++++++++++++++++++
>  include/linux/bpf.h         | 17 +++++++++---
>  kernel/bpf/syscall.c        |  7 +++--
>  kernel/bpf/trampoline.c     | 20 +++++++++++---
>  4 files changed, 89 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 4dcc0b1ac770..0f521be68f7b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1766,10 +1766,26 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>  {
>         u8 *prog = *pprog;
>         u8 *jmp_insn;
> +       int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
>         struct bpf_prog *p = l->link.prog;
>
> +       /* mov rdi, 0 */
> +       emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
> +
> +       /* Prepare struct bpf_tramp_run_ctx.
> +        *
> +        * bpf_tramp_run_ctx is already preserved by
> +        * arch_prepare_bpf_trampoline().
> +        *
> +        * mov QWORD PTR [rsp + ctx_cookie_off], rdi
> +        */
> +       EMIT4(0x48, 0x89, 0x7C, 0x24); EMIT1(ctx_cookie_off);
> +
>         /* arg1: mov rdi, progs[i] */
>         emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
> +       /* arg2: mov rsi, rsp (struct bpf_run_ctx *) */
> +       EMIT3(0x48, 0x89, 0xE6);
> +
>         if (emit_call(&prog,
>                       p->aux->sleepable ? __bpf_prog_enter_sleepable :
>                       __bpf_prog_enter, prog))
> @@ -1815,6 +1831,8 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>         emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
>         /* arg2: mov rsi, rbx <- start time in nsec */
>         emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
> +       /* arg3: mov rdx, rsp (struct bpf_run_ctx *) */
> +       EMIT3(0x48, 0x89, 0xE2);
>         if (emit_call(&prog,
>                       p->aux->sleepable ? __bpf_prog_exit_sleepable :
>                       __bpf_prog_exit, prog))
> @@ -2079,6 +2097,16 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>                 }
>         }
>
> +       if (nr_args < 3 && (fentry->nr_links || fexit->nr_links || fmod_ret->nr_links))
> +               EMIT1(0x52);    /* push rdx */

this nr_args < 3 condition is new, maybe leave a comment on why we
need this? Also instead of repeating this whole (fentry->nr_links ||
... || ...) check, why not move if (nr_args < 3) inside the if right
below?

> +
> +       if (fentry->nr_links || fexit->nr_links || fmod_ret->nr_links) {

if (nr_args > 3) here?

> +               /* Prepare struct bpf_tramp_run_ctx.
> +                * sub rsp, sizeof(struct bpf_tramp_run_ctx)
> +                */
> +               EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_tramp_run_ctx));
> +       }
> +
>         if (fentry->nr_links)
>                 if (invoke_bpf(m, &prog, fentry, regs_off,
>                                flags & BPF_TRAMP_F_RET_FENTRY_RET))

[...]

>         if (fmod_ret->nr_links) {
> @@ -2133,6 +2179,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>                         goto cleanup;
>                 }
>
> +       /* pop struct bpf_tramp_run_ctx
> +        * add rsp, sizeof(struct bpf_tramp_run_ctx)
> +        */
> +       if (fentry->nr_links || fexit->nr_links || fmod_ret->nr_links)

well, actually, can it ever be that this condition doesn't hold? That
would mean we are generating empty trampoline for some reason, no? Do
we do that? Checking bpf_trampoline_update() and
bpf_struct_ops_prepare_trampoline() doesn't seem like we ever do this.
So seems like all these checks can be dropped?

> +               EMIT4(0x48, 0x83, 0xC4, sizeof(struct bpf_tramp_run_ctx));
> +
> +       if (nr_args < 3 && (fentry->nr_links || fexit->nr_links || fmod_ret->nr_links))
> +               EMIT1(0x5A); /* pop rdx */

same, move it inside if above?

> +
>         if (flags & BPF_TRAMP_F_RESTORE_REGS)
>                 restore_regs(m, &prog, nr_args, regs_off);
>

[...]

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC294E341F
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiCUXTY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiCUXTQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:19:16 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1337A358BEE
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:08:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h63so18455631iof.12
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pA0jmPNJdkiBCtOky07//LYYPdSCJAPcw2ltmvY1gbU=;
        b=iKCUkD9cH/rWqxdWbwt987yrH8OGql6mtHRreoZZKFHVu0UiqLBBY+ztVZi7jY2LXy
         CcXpIN7qJwToH65RBBray9DBFUrm07Q2q9xwBNh787G2a69SxHVrKu9flG+bNqKXWdyV
         DQZ6yFceBb7mFiYqKRXOtyONOkhNvXXR8Igv/pp2XUEcpFJLAo/b9ygrUBXaJKVWgzjJ
         ttdyQvluPMlZAk27s8eni3ug2ul5aFeWXdquC8YPq3n7e732PEzbDqxkKAiKxKvvDAoG
         mJkeeaU6KWM4DTmreT19uV5vpNBBBJEf9unexW+8tlBoSHkxJIgXM8z1fZSURPpVHBNr
         yV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pA0jmPNJdkiBCtOky07//LYYPdSCJAPcw2ltmvY1gbU=;
        b=jy2CYjbLxuFNMVImwYZjUMNPJFcQJjVY/G4GhwFZ7c1AIc0IQCURW0tfcn1AMYdUfp
         RmsCef6S7tFiRKWcEPIuTRABXDv0BIKG+RuO3puQtfMkQt8HAS/yWJF/i3mcxHYo4c2v
         /zAVNDKdrVRRMhJIJ9BSj9JusoUuaQzel2a8WLHhkKuIttuElP6zTwVmcvHun6qIBwIl
         TeqQm3Cu8gvoluquovnwOeMlCS4+Nqu4iSx5IAXwq0zYvbG5FsfdtVlCSwSwkua8Tg73
         +rIR9Cq6bjTCqaXWUn2Kr2LCvQG0Jn72Q+dasbMW0uaClZv6ygweSm5aRxfquQ3PvgkI
         VsIw==
X-Gm-Message-State: AOAM533QD/ZwvB5/WNXCJmcq3v/5/DS2vHdLCOaT0VLmY7RGStyi6wQO
        RxHarKnRLksXEtYWVPH8hnKsUrPMlkElWbUAY7w=
X-Google-Smtp-Source: ABdhPJy6DAdsOJqy+KFkVZofMOs8OKDhL5m+zgxJpqpTxsSkaa5QJ/jLmOxztl3t0sChIqAoequ85WoiTw5jmoegpRk=
X-Received: by 2002:a6b:6f0c:0:b0:648:ea2d:41fe with SMTP id
 k12-20020a6b6f0c000000b00648ea2d41femr10876736ioc.63.1647904138970; Mon, 21
 Mar 2022 16:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-3-kuifeng@fb.com>
In-Reply-To: <20220316004231.1103318-3-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 16:08:47 -0700
Message-ID: <CAEf4Bzbtcyj-ciXzJVL3QV6mbbyA_6Nec8m_8rgz190dcxH4Yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on the
 caller thread's stack
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Tue, Mar 15, 2022 at 5:44 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> BPF trampolines will create a bpf_trace_run_ctx on their stacks, and
> set/reset the current bpf_run_ctx whenever calling/returning from a
> bpf_prog.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/bpf.h         | 12 ++++++++----
>  kernel/bpf/syscall.c        |  4 ++--
>  kernel/bpf/trampoline.c     | 21 +++++++++++++++++----
>  4 files changed, 59 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 1228e6e6a420..29775a475513 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1748,10 +1748,33 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>  {
>         u8 *prog = *pprog;
>         u8 *jmp_insn;
> +       int ctx_cookie_off = offsetof(struct bpf_trace_run_ctx, bpf_cookie);
>         struct bpf_prog *p = l->prog;
>
> +       EMIT1(0x52);             /* push rdx */
> +
> +       /* mov rdi, 0 */
> +       emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
> +
> +       /* Prepare struct bpf_trace_run_ctx.
> +        * sub rsp, sizeof(struct bpf_trace_run_ctx)
> +        * mov rax, rsp
> +        * mov QWORD PTR [rax + ctx_cookie_off], rdi
> +        */
> +       EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_trace_run_ctx));
> +       EMIT3(0x48, 0x89, 0xE0);
> +       EMIT4(0x48, 0x89, 0x78, ctx_cookie_off);
> +
> +       /* mov rdi, rsp */
> +       EMIT3(0x48, 0x89, 0xE7);
> +       /* mov QWORD PTR [rdi + sizeof(struct bpf_trace_run_ctx)], rax */
> +       emit_stx(&prog, BPF_DW, BPF_REG_1, BPF_REG_0, sizeof(struct bpf_trace_run_ctx));
> +
>         /* arg1: mov rdi, progs[i] */
>         emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
> +       /* arg2: mov rsi, rsp (struct bpf_run_ctx *) */
> +       EMIT3(0x48, 0x89, 0xE6);
> +
>         if (emit_call(&prog,
>                       p->aux->sleepable ? __bpf_prog_enter_sleepable :
>                       __bpf_prog_enter, prog))
> @@ -1797,11 +1820,20 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>         emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
>         /* arg2: mov rsi, rbx <- start time in nsec */
>         emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
> +       /* arg3: mov rdx, rsp (struct bpf_run_ctx *) */
> +       EMIT3(0x48, 0x89, 0xE2);
>         if (emit_call(&prog,
>                       p->aux->sleepable ? __bpf_prog_exit_sleepable :
>                       __bpf_prog_exit, prog))
>                         return -EINVAL;
>
> +       /* pop struct bpf_trace_run_ctx
> +        * add rsp, sizeof(struct bpf_trace_run_ctx)
> +        */
> +       EMIT4(0x48, 0x83, 0xC4, sizeof(struct bpf_trace_run_ctx));
> +
> +       EMIT1(0x5A); /* pop rdx */
> +
>         *pprog = prog;
>         return 0;
>  }
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3dcae8550c21..d20a23953696 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -681,6 +681,8 @@ struct bpf_tramp_links {
>         int nr_links;
>  };
>
> +struct bpf_trace_run_ctx;
> +
>  /* Different use cases for BPF trampoline:
>   * 1. replace nop at the function entry (kprobe equivalent)
>   *    flags = BPF_TRAMP_F_RESTORE_REGS
> @@ -707,10 +709,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *i
>                                 struct bpf_tramp_links *tlinks,
>                                 void *orig_call);
>  /* these two functions are called from generated trampoline */
> -u64 notrace __bpf_prog_enter(struct bpf_prog *prog);
> -void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
> -u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog);
> -void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start);
> +u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx);
> +void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_trace_run_ctx *run_ctx);
> +u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx);
> +void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
> +                                      struct bpf_trace_run_ctx *run_ctx);
>  void notrace __bpf_tramp_enter(struct bpf_tramp_image *tr);
>  void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr);
>
> @@ -1291,6 +1294,7 @@ struct bpf_cg_run_ctx {
>  struct bpf_trace_run_ctx {
>         struct bpf_run_ctx run_ctx;
>         u64 bpf_cookie;
> +       struct bpf_run_ctx *saved_run_ctx;
>  };

oh, and bpf_trace_run_ctx is used for kprobe/uprobe/tracepoint, let's
add a new struct bpf_tramp_run_ctx which would reflect that it is used
for BPF trampoline-based BPF programs. Otherwise it's confusing to
have saved_run_ctx for kprobe where we don't use that. Similarly, if
we move "start" timestamp, it will be a bit off. Not end of the world,
but I think keeping them separate would make sense over long run.

>
>  static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)

[...]

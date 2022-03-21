Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA84E3410
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiCUXRB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiCUXQc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:16:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A1934A107
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:04:46 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 125so5159784iov.10
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGTDhuEGPEHeP1K7vNQYJ2fw7tnnl/qLY9d0nvbmGlg=;
        b=EXr2i3qDS80oA3C8xwJ9XmJ74Z4+fGVDg9lLT5lxsJqWGw0S7ex71x6NZjIcdPe/QX
         Fng8k8gTXGDpMiYnaIGZ2qUjqjGPpPb+S9lqWR5IYvalLe8EQkvnXOTgsd6n8Xjg+57F
         x+fqvZqdrce7uc7h6xY24yg84o2wwgwO9kXGc2r/ygWL9ftBhcZB2uQ6LKdqd1F72mNl
         Z0g12fzXM2DElJ6TQjFTzmOr8tWAqJi5VdQc0qw+ULLhNTMS0NnVsk2vouDXfqbu+04W
         QaRyY8prGA0OHgHoCEynxIl/tPCoW7plhAjtqBSP/6di6rFRyxxyyDwLxhNpmA9VHHlD
         rIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGTDhuEGPEHeP1K7vNQYJ2fw7tnnl/qLY9d0nvbmGlg=;
        b=Xma/NHOHVmHZ3xkVuB6JjQtgLZMMGUs3mWUYSjvd+JFv4Sm5LdX3gIlYZEFSCSEQcJ
         qCqYoSklO1higqSZeKe5h/SzfcOT2kXGtqeAT22JQABxBcXhWJneEnZe546DaxSINqMX
         lFA0NH+W4pdtJm6A4I4TuNm8tkOXVJ1e9MYpR8TIWDtWDj2dIqaHHZp7lUGX9wVokLjd
         Qgz4hz7JuLrhaJAbi0OB4NTgxb27k5t2upzK6dLEb1CgS8boYh9I+hMGgOzo128lLrxx
         0zxvPcTjtWvdjZOX3zMj4dWULHx3b85/u+N5nCMrMbut6czG9afCBh7F4T59DT3V0XAu
         N8MA==
X-Gm-Message-State: AOAM532p3AdzBhdcPsBJ9iQ+WHUFpC3OwTdzhGAfb40pu6c4pMtIKkjf
        hIkJajieDdLyoucqLbKIg9PGEdQIftVVDuvQx6A=
X-Google-Smtp-Source: ABdhPJyfWhyTFRqa9bmTILoRLPewz8eFbvJuIUv5Rln03uebgfuDYPD/54u2UW0fKLf1N8zAOvUoQMId1PLmZGvsEqE=
X-Received: by 2002:a6b:8bd7:0:b0:646:2804:5c73 with SMTP id
 n206-20020a6b8bd7000000b0064628045c73mr10774420iod.112.1647903885083; Mon, 21
 Mar 2022 16:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-3-kuifeng@fb.com>
In-Reply-To: <20220316004231.1103318-3-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 16:04:33 -0700
Message-ID: <CAEf4BzbYb6XOcBCeJCT0_MRZns6L04eYgnuYOm5Hg-5wHFaXEw@mail.gmail.com>
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

[...]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 54c695d49ec9..0b050aa2f159 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -580,9 +580,12 @@ static void notrace inc_misses_counter(struct bpf_prog *prog)
>   * [2..MAX_U64] - execute bpf prog and record execution time.
>   *     This is start time.
>   */
> -u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
> +u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx)
>         __acquires(RCU)
>  {
> +       if (run_ctx)
> +               run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> +

In all current cases we bpf_set_run_ctx() after migrate_disable and
rcu_read_lock, let's keep this consistent (even if I don't remember if
that order matters or not).

>         rcu_read_lock();
>         migrate_disable();
>         if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
> @@ -614,17 +617,23 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
>         }
>  }
>
> -void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
> +void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_trace_run_ctx *run_ctx)
>         __releases(RCU)
>  {
> +       if (run_ctx)
> +               bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> +
>         update_prog_stats(prog, start);
>         __this_cpu_dec(*(prog->active));
>         migrate_enable();
>         rcu_read_unlock();
>  }
>
> -u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
> +u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx)
>  {
> +       if (run_ctx)
> +               run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> +
>         rcu_read_lock_trace();
>         migrate_disable();
>         might_fault();
> @@ -635,8 +644,12 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
>         return bpf_prog_start_time();
>  }
>
> -void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
> +void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
> +                                      struct bpf_trace_run_ctx *run_ctx)

now that we have entire run_ctx, can we move `start` into run_ctx and
simplify __bpf_prog_enter/exit calls a bit? Or extra indirection will
hurt performance and won't be compensated by simpler enter/exit
calling convention?

>  {
> +       if (run_ctx)
> +               bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> +
>         update_prog_stats(prog, start);
>         __this_cpu_dec(*(prog->active));
>         migrate_enable();
> --
> 2.30.2
>

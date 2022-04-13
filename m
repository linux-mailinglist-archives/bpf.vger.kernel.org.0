Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B44FED52
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 05:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiDMDGd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 23:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiDMDGV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 23:06:21 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7A554A1
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 20:04:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k25so478835iok.8
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A8j3sXthfM0/RiYwHcKe/U+wfS9Ps2a8MYpTXnbrLSc=;
        b=KYGREQJtTlBJsAhPblHMfGKt7c8rmLGpVphsDAyezTHRHUJROxqayj6dxkGhsfizz0
         fDefAOLE4jikVWFYFhQToD8L/NCjazgP+kI+1rouE0zvm0psajZezaBx2cZDBbiXLUVb
         n4UrXHfqoaAEuNRkSPl2rJru8bFPvOFR2QMWxb2fFGJrQdf4WdwVqKe6iCe7BCmZKGwN
         nRoB4XjCBEPp8XVrNhD72v8Z1MesSZv+gXpfk9mf2BeOw3CPnXVlvbH/1mTfhvw3B/wi
         dZIsQa4NbOJCmLmZHz88JlKqxoVq94Kvz7KlwbhiHmaXQKmym2eroGTX0ZnMRyMbEDGO
         d8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8j3sXthfM0/RiYwHcKe/U+wfS9Ps2a8MYpTXnbrLSc=;
        b=7uo8syWD0tR/dHk3kMAyNCdc7VqRXplC5t436WaboWIDZV1tD31874/tmctU1Y1zBJ
         1lLDq7gACBmG9Wvlpqy1iuPObGOyDagO+dsLHSk6oGOw9uISq7ZgCUluCvEJsR2osFf0
         QEFIAUMH+9sG2gkMguDSTvpngirUdgN9vtVP/rtUbKcWJvx+8/Tzw15qJ1kDpE6KqK7O
         +IZCVKiLFpc7KpQO2Iq55nWOftOpM+A9fJpnPihTOBAXNXmyO3IeHJIa6jZcCO3H7bV+
         EwwZCjSm6GBs/mHC3zeV8c94LItsRQURuP9BbqZs0/JHndhyDINm1u16jZsM5YTRC4F1
         MVNg==
X-Gm-Message-State: AOAM533l6xE/fwGtmHpnsLHpfRJsvE2pIv82FUXNSADJeKmBkf/Hpa3k
        3Px8S2WrxdX9EuQ6YP+fm6b6LuMs2gL+j9LfWt4=
X-Google-Smtp-Source: ABdhPJyJACI1UVT+NF5XxuZd2p9CokGFFOWEE8HS/Oby3nEnTxawftSZFTY0RQwE9JukEuMdA+0n7XasI1o2+SaLJ+E=
X-Received: by 2002:a05:6638:1696:b0:326:2d59:7b40 with SMTP id
 f22-20020a056638169600b003262d597b40mr7144514jat.103.1649819041036; Tue, 12
 Apr 2022 20:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220412165555.4146407-1-kuifeng@fb.com> <20220412165555.4146407-4-kuifeng@fb.com>
In-Reply-To: <20220412165555.4146407-4-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Apr 2022 20:03:49 -0700
Message-ID: <CAEf4BzYUJk=6h6HxoK99XNmygdX+6AeT27dWaozJMshdAahRSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/5] bpf, x86: Attach a cookie to fentry/fexit/fmod_ret.
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
> Add a bpf_cookie field to struct bpf_tracing_link to attach a cookie
> to a link of a trace hook.  A cookie of a bpf_tracing_link is
> available by calling bpf_get_attach_cookie when running the BPF
> program of the attached link.
>
> The value of a cookie will be set at bpf_tramp_run_ctx by the
> trampoline of the link.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c    | 11 +++++++++--
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  8 ++++++++
>  kernel/bpf/syscall.c           | 27 +++++++++++++++++++++++----
>  kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  7 +++++++
>  6 files changed, 65 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 0f521be68f7b..18d02dcd810a 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1764,13 +1764,20 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>                            struct bpf_tramp_link *l, int stack_size,
>                            bool save_ret)
>  {
> +       u64 cookie = 0;
>         u8 *prog = *pprog;
>         u8 *jmp_insn;
>         int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
>         struct bpf_prog *p = l->link.prog;
>
> -       /* mov rdi, 0 */
> -       emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
> +       if (l->link.type == BPF_LINK_TYPE_TRACING) {
> +               struct bpf_tracing_link *tr_link =
> +                       container_of(l, struct bpf_tracing_link, link);

empty line between variable declaration block and statement

> +               cookie = tr_link->cookie;
> +       }
> +
> +       /* mov rdi, cookie */
> +       emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cookie);
>
>         /* Prepare struct bpf_tramp_run_ctx.
>          *
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d87df049e6b1..49db9c065701 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1062,6 +1062,7 @@ struct bpf_tracing_link {
>         enum bpf_attach_type attach_type;
>         struct bpf_trampoline *trampoline;
>         struct bpf_prog *tgt_prog;
> +       u64 cookie;
>  };
>
>  struct bpf_link_primer {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a4f557338af7..5e901e6d17ea 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1436,6 +1436,7 @@ union bpf_attr {
>         struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
>                 __u64 name;
>                 __u32 prog_fd;
> +               __u64 bpf_cookie;

I thought we are not adding bpf_cookie through RAW_TRACEPOINT_OPEN?

>         } raw_tracepoint;
>
>         struct { /* anonymous struct for BPF_BTF_LOAD */
> @@ -1490,6 +1491,13 @@ union bpf_attr {
>                                 __aligned_u64   addrs;
>                                 __aligned_u64   cookies;
>                         } kprobe_multi;
> +                       struct {
> +                               /* black box user-provided value passed through
> +                                * to BPF program at the execution time and
> +                                * accessible through bpf_get_attach_cookie() BPF helper
> +                                */
> +                               __u64           bpf_cookie;
> +                       } tracing;
>                 };
>         } link_create;
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 56e69a582b21..53d4da5c76b5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2695,9 +2695,10 @@ static const struct bpf_link_ops bpf_tracing_link_lops = {
>         .fill_link_info = bpf_tracing_link_fill_link_info,
>  };
>
> -static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> -                                  int tgt_prog_fd,
> -                                  u32 btf_id)
> +static int bpf_tracing_prog_attach_cookie(struct bpf_prog *prog,
> +                                         int tgt_prog_fd,
> +                                         u32 btf_id,
> +                                         u64 bpf_cookie)

let's keep it as bpf_tracing_prog_attach and just update all the call sites

>  {
>         struct bpf_link_primer link_primer;
>         struct bpf_prog *tgt_prog = NULL;
> @@ -2762,6 +2763,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>         bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
>                       &bpf_tracing_link_lops, prog);
>         link->attach_type = prog->expected_attach_type;
> +       link->cookie = bpf_cookie;
>
>         mutex_lock(&prog->aux->dst_mutex);
>
> @@ -2871,6 +2873,13 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>         return err;
>  }
>
> +static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> +                                  int tgt_prog_fd,
> +                                  u32 btf_id)
> +{
> +       return bpf_tracing_prog_attach_cookie(prog, tgt_prog_fd, btf_id, 0);
> +}
> +

why this wrapper, just add that 0 for all existing
bpf_tracing_prog_attach() invocations


>  struct bpf_raw_tp_link {
>         struct bpf_link link;
>         struct bpf_raw_event_map *btp;
> @@ -3023,7 +3032,7 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
>  }
>  #endif /* CONFIG_PERF_EVENTS */
>
> -#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
> +#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.bpf_cookie
>
>  static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>  {
> @@ -3187,6 +3196,10 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
>                 return BPF_PROG_TYPE_SK_LOOKUP;
>         case BPF_XDP:
>                 return BPF_PROG_TYPE_XDP;
> +       case BPF_TRACE_FENTRY:
> +       case BPF_TRACE_FEXIT:
> +       case BPF_MODIFY_RETURN:
> +               return BPF_PROG_TYPE_TRACING;

can you please split the part that adds ability to create
fentry/fexit/etc links through LINK_CREATE into a separate commit,
separate from wiring the bpf_cookie? It's two logically distinct
changes.

>         default:
>                 return BPF_PROG_TYPE_UNSPEC;
>         }

[...]

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index a4f557338af7..a5ee57f09e04 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1490,6 +1490,13 @@ union bpf_attr {
>                                 __aligned_u64   addrs;
>                                 __aligned_u64   cookies;
>                         } kprobe_multi;
> +                       struct {
> +                               /* black box user-provided value passed through
> +                                * to BPF program at the execution time and
> +                                * accessible through bpf_get_attach_cookie() BPF helper
> +                                */
> +                               __u64           bpf_cookie;

for kprobe_multi we used "cookies", so let's do "cookie" here? We'll
have to keep perf_event.bpf_cookie, of course.

> +                       } tracing;
>                 };
>         } link_create;
>
> --
> 2.30.2
>

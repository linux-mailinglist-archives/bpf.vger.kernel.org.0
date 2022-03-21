Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3434E343A
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiCUXYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiCUXYa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:24:30 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA173480D9
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:18:12 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j15so1218824ila.13
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CK703wSpqqqsiWLRuPaHeJMk/J/O1ZEyg2dW/CMnd5I=;
        b=K+iX0HP48XhLomqvjAH1+n1OZDjXgUqcnf8L7SjlB3NV0s2KkV7hlyNdpVNr39z7Gq
         nCFLszkXl3CGWoYfHCCQ/5te+M5pl0FyOJNKNbRFk+TZybH+kf19uGrvZXPpJS29S+v5
         Hg16klz5NcnZSZV6/kgmEKcN9KSmCia479g4iRUrHKedTwbBgwF1jkKlAecolOSwjm00
         9mWD6qf53Lq9JcPP3XjBUEwaaUj7gR6pKG5yZi6fyvErZB8S7A0kpLjneMQY7yJjDBpm
         lrdyI2SFrO+2FliM7EdzSDn4xdF2QGeRitatBMq4OBElI8rHqbl6LMd7Ein2JIT54Vip
         MEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CK703wSpqqqsiWLRuPaHeJMk/J/O1ZEyg2dW/CMnd5I=;
        b=3QgB1BQZgSmwT9lqT3KLdjqdYjl6IFqMgJO1g75dOQUKMvSj1LKAZJrBkSeBU058cM
         uzRxIAQ27wcrKXRLYBl9NRSsW3D3c4mnEt84m5uh6NAWciMLabEAFkJ1a6eIiolgUJ65
         N9GOt8+ptvTxcpNYVvnktUUUOFF8HW+3e2vmyHX7wMO1JHdnx+f7sPxQP7k3hyfQJB6Y
         U2lC/imREDs6H6yjvmIy02rRAmNdKRPsSdx9C3HHDuk5pbYLy87xpJrp3V1OoWTEsVCo
         li0myadm7gHxseRIz5sven3wUFtXkfu7vLj4gFLq1vMhSgphPgzUmc+tVrxE0zGwzCPw
         eGYA==
X-Gm-Message-State: AOAM5303XwVwrsIWL/M/tSusX0CEnxABsi1138PRHe5JKm9MmHaV+Wo0
        XmoviPcAu2y8uKPm+RaiQly4Sj5M51FnF7ia0QDZxw58
X-Google-Smtp-Source: ABdhPJw5omqmrrhYPnaEFkJyvLEcZErv4VNFR9qIKeTfqu3zpNPMKT0k2IHouoCgvHHbeUEAD4pr8HPPwsMpbpEMNio=
X-Received: by 2002:a92:c568:0:b0:2c8:8dd:e8bf with SMTP id
 b8-20020a92c568000000b002c808dde8bfmr6644190ilj.98.1647904691777; Mon, 21 Mar
 2022 16:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-4-kuifeng@fb.com>
In-Reply-To: <20220316004231.1103318-4-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 16:18:00 -0700
Message-ID: <CAEf4BzYmFUKF0BFnJ62-yayopcwvxGMUogf+Wduwoab3L9m8fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for fentry/fexit/fmod_ret.
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
> Add a bpf_cookie field to attach a cookie to an instance of struct
> bpf_link.  The cookie of a bpf_link will be installed when calling the
> associated program to make it available to the program.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c    |  4 ++--
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           | 11 +++++++----
>  kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  1 +
>  tools/lib/bpf/bpf.c            | 14 ++++++++++++++
>  tools/lib/bpf/bpf.h            |  1 +
>  tools/lib/bpf/libbpf.map       |  1 +
>  9 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 29775a475513..5fab8530e909 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1753,8 +1753,8 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>
>         EMIT1(0x52);             /* push rdx */
>
> -       /* mov rdi, 0 */
> -       emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
> +       /* mov rdi, cookie */
> +       emit_mov_imm64(&prog, BPF_REG_1, (long) l->cookie >> 32, (u32) (long) l->cookie);

why __u64 to long casting? I don't think you need to cast anything at
all, but if you want to make that more explicit than just casting to
(u32) should be fine, no?

>
>         /* Prepare struct bpf_trace_run_ctx.
>          * sub rsp, sizeof(struct bpf_trace_run_ctx)
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d20a23953696..9469f9264b4f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1040,6 +1040,7 @@ struct bpf_link {
>         struct bpf_prog *prog;
>         struct work_struct work;
>         struct hlist_node tramp_hlist;
> +       u64 cookie;

I was a bit hesitant about adding tramp_hlist into generic struct
bpf_link, but now with also cookie there I'm even more convinced that
it's not the right thing to do... Some BPF links won't have cookie,
some (like multi-kprobe) will have lots of them.

Should we create struct bpf_tramp_link {} which will have tramp_hlist
and cookie? As for tramp_hlist, we can probably also keep it back in
bpf_prog_aux and just fetch it through link->prog->aux->tramp_hlist in
trampoline code. This might reduce amount of code churn in patch 1.

Thoughts?

>  };
>
>  struct bpf_link_ops {

[...]

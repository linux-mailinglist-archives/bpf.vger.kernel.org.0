Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9592D47CA2E
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 01:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhLVASa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 19:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLVASa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 19:18:30 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E7C061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 16:18:30 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id x10so689032ioj.9
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 16:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lba8M1hhWIGgwOaEy25uSetaHuT4KftxrMpo0kAIyQo=;
        b=MDKMSqEPNdmxtFnycbFEb4wEU605shFmx041PndMKg0QwkGnMmxk2krbs4FuAJPmTf
         qhMLuVSutvv/nPFq2SlB/U4OvBgh/PepBxMvk4frRwKEpnl7i91BUu7E3+dVbESFPFLd
         GZpvGF+UwEZ40dcJCXqrPWwTcRrtNdb7fxE+fKT64lfhFRdH3lLrlW6mU0/J//pQUQ/7
         JCxWCXmqVlCyg3dm+PJZO30Yr6488BnmO6QlQzLwEtnTg1Tpkexds4849hEgY61tIEG0
         KQhw7Ys4sW5CaZGhA5sV9c2ajE1rq3a8pzmVitTyPivM5QEOCdluFtLingaYd3zcEtWL
         IVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lba8M1hhWIGgwOaEy25uSetaHuT4KftxrMpo0kAIyQo=;
        b=ne/MOhi64YWSWfNClnmdD4QhS66rlrIfIc4XxprjFGymfx0O++rgtR8F3bhuZnOJGZ
         0O4dv9VCv6X3QkHVcdA+48XTGk8XmragaaX/LEMvZl4cwdWW8Enw1W6NBje+JeF+iWO3
         Qn1jnC1+OCV8YJ5p4v/fy3TWaL71L5icH7NNSVlxZxTdsC9rFOHeZjORUM1RTVHjzfok
         faVrg1A27DZZVbC+KZPvxE8j41N6gYPXeUu3sUTrcRFFwju8LbcB+7IxpSkZ+xfC+inn
         3LSCBRtR1MMsTNhR7juOUvltPwFm2Ym4MO+CZbYzBDbCT5VUCvC1dCOL/bcq6ZBCC6YE
         Se3g==
X-Gm-Message-State: AOAM530+ztPa7pCyxZpzwDcyUk01amzJJIa/VskZKqFsXFzCtYH2Bmra
        1jG+8k4rd1T+a082J5smPdoJgrE2d0wi7LDFpOuG7YOo
X-Google-Smtp-Source: ABdhPJyUmHNbzVCtkSsqytVUOLXVVtN3oiTxri7i9XgKwE4Rc/ydIkYlaxUURoaBGY0sPJM6Sf26CgyD0nq9nbKPZbU=
X-Received: by 2002:a5d:9f01:: with SMTP id q1mr275007iot.144.1640132309451;
 Tue, 21 Dec 2021 16:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20211221055312.3371414-1-hengqi.chen@gmail.com> <20211221055312.3371414-2-hengqi.chen@gmail.com>
In-Reply-To: <20211221055312.3371414-2-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Dec 2021 16:18:18 -0800
Message-ID: <CAEf4BzZQy-KUd8D4jj0Th2Po4d8UbQL7xnywRcF3xwy99+127g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL
 macros
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 20, 2021 at 9:53 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add syscall-specific variants of BPF_KPROBE/BPF_KRETPROBE named
> BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL ([0]). These new macros
> hide the underlying way of getting syscall input arguments and
> return values. With these new macros, the following code:
>
>     SEC("kprobe/__x64_sys_close")
>     int BPF_KPROBE(do_sys_close, struct pt_regs *regs)
>     {
>         int fd;
>
>         fd = PT_REGS_PARM1_CORE(regs);
>         /* do something with fd */
>     }
>
> can be written as:
>
>     SEC("kprobe/__x64_sys_close")
>     int BPF_KPROBE_SYSCALL(do_sys_close, int fd)
>     {
>         /* do something with fd */
>     }
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/425
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---

As Yonghong mentioned, let's wait for PT_REGS_PARMx_SYSCALL macros to
land and use those (due to 4th argument quirkiness on x86 arches).

>  tools/lib/bpf/bpf_tracing.h | 45 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index db05a5937105..eb4b567e443f 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -489,4 +489,49 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
>  }                                                                          \
>  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>
> +#define ___bpf_syscall_args0() ctx, regs
> +#define ___bpf_syscall_args1(x) \
> +       ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE(regs)
> +#define ___bpf_syscall_args2(x, args...) \
> +       ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE(regs)
> +#define ___bpf_syscall_args3(x, args...) \
> +       ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE(regs)
> +#define ___bpf_syscall_args4(x, args...) \
> +       ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE(regs)
> +#define ___bpf_syscall_args5(x, args...) \
> +       ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE(regs)
> +#define ___bpf_syscall_args(args...) \
> +       ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)

try keeping each definition on a single line, make them much more
readable and I think still fits in 100 character limit

> +
> +/*
> + * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
> + * tracing syscall functions. It hides the underlying platform-specific

let's add a simple example to explain what kind of tracing syscall
functions we mean.

"tracing syscall functions, like __x64_sys_close." ?

> + * low-level way of getting syscall input arguments from struct pt_regs, and
> + * provides a familiar typed and named function arguments syntax and
> + * semantics of accessing syscall input paremeters.

typo: parameters

> + *
> + * Original struct pt_regs* context is preserved as 'ctx' argument. This might
> + * be necessary when using BPF helpers like bpf_perf_event_output().
> + */
> +#define BPF_KPROBE_SYSCALL(name, args...)                                  \
> +name(struct pt_regs *ctx);                                                 \
> +static __attribute__((always_inline)) typeof(name(0))                      \
> +____##name(struct pt_regs *ctx, struct pt_regs *regs, ##args);             \
> +typeof(name(0)) name(struct pt_regs *ctx)                                  \
> +{                                                                          \
> +       _Pragma("GCC diagnostic push")                                      \
> +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")              \
> +       struct pt_regs *regs = PT_REGS_PARM1(ctx);                          \

please move it out of _Pragma region, no need to guard it

> +       return ____##name(___bpf_syscall_args(args));                       \
> +       _Pragma("GCC diagnostic pop")                                       \
> +}                                                                          \
> +static __attribute__((always_inline)) typeof(name(0))                      \
> +____##name(struct pt_regs *ctx, struct pt_regs *regs, ##args)

I don't think we need to add another magical hidden argument "regs".
Anyone who will need it for something can get it from the hidden ctx
with PT_REGS_PARM1(ctx) anyways.

> +
> +/*
> + * BPF_KRETPROBE_SYSCALL is just an alias to BPF_KRETPROBE,
> + * it provides optional return value (in addition to `struct pt_regs *ctx`)
> + */
> +#define BPF_KRETPROBE_SYSCALL BPF_KRETPROBE
> +

hm... do we even need BPF_KRETPROBE_SYSCALL then? Let's drop it, it
doesn't provide much value, just creates a confusion.


>  #endif
> --
> 2.30.2

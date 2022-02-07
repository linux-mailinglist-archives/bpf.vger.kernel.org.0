Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22D74ACBB6
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 22:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiBGV6q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 16:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiBGV6p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 16:58:45 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E8DC061355
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 13:58:45 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id m8so5792095ilg.7
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 13:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/s/DznC4l93AHWub7AMW1LpDRWlVy3eb1R7FLxngTAk=;
        b=jqumonjbVtZhP59y50ye/BUaQ8wsMoaUCxdTXj7NqP3XRr1a2AwBgASupyXZUWyaKc
         gLDWbQiSlnSxarHgGjpDzM+c/8M8lBUG8nhh6V/UaN43MZULEZ4aD5mUuOk4S7Exbzzs
         9gmK2Oj8egxggvaq1qYkhoiZ+B3Fu+DTIPOdMRu4IQCxEKhT9j1mJqCdtTlD4fzmmmkg
         PHDmQqmmbsh92CV4CWk2pMsigt5CfxFpTUEgdt7wG+2aYL2q/VVUMAjitHFGaXWUp4mL
         VYaNNbUZAQbLPlQF34VeGr1pfB9wNb0uTMmD+tfkCptxInw1w0kXAOJyLmzIsmnzjbsP
         HhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/s/DznC4l93AHWub7AMW1LpDRWlVy3eb1R7FLxngTAk=;
        b=4Hh3132tTeu/Rw3mROToVbit1hIEWJmcWj5829C3mrUdTUgMWG+AdU4chiX7tNz8Fs
         3g5hl1ZPiWwHj3efRGZh8knEY0uqKsKRs+3S2jdYvmBMcd86NhDcUmjWEBb/fa/Yuwoj
         /lHrNeq+X1/D/11hUntylQUe2bRCjn9+uFFBpS/vyT84MfhVz6XAIKRqFtCIr4aPnG+c
         eSb5ZGv+VbdKtrZK98A35TClhWXbvlOSEayKrgec0HiLJUlwh+8NKmA/9x7r85au/q/w
         kWzVFdF9PkJTZSbhI/gGJWnLTOu3dvOuBeBAWOsqODPkMVqFL/SV/FC7K4IfETHCXzq5
         rcpg==
X-Gm-Message-State: AOAM533SPnbvC5VU+Qer28JfUB96Y8CxTU4gYoO7kBIR5X9Dxjo7laFY
        72472z1EjRWWfcVveaKIeuYNpO/MUBG69Z5xsmITRBgS
X-Google-Smtp-Source: ABdhPJxSL4x9R59x9kH3vVFOrzTHSE7WO4HQaJ6NxFZq3V5JLQqtiAdMINLhmqdRwgVDAHQx4QaKSQ83h91nYbrVU0k=
X-Received: by 2002:a05:6e02:2163:: with SMTP id s3mr691953ilv.252.1644271124905;
 Mon, 07 Feb 2022 13:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20220207143134.2977852-1-hengqi.chen@gmail.com> <20220207143134.2977852-2-hengqi.chen@gmail.com>
In-Reply-To: <20220207143134.2977852-2-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 13:58:33 -0800
Message-ID: <CAEf4BzaQvpS+Zh3zEmxqPC0nADXdjPV8UoWW90UJ8F7ZBFhQDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: Add BPF_KPROBE_SYSCALL macro
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
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

On Mon, Feb 7, 2022 at 6:31 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add syscall-specific variant of BPF_KPROBE named BPF_KPROBE_SYSCALL ([0]).
> The new macro hides the underlying way of getting syscall input arguments.
> With the new macro, the following code:
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
>  tools/lib/bpf/bpf_tracing.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index cf980e54d331..7ad9cdea99e1 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -461,4 +461,37 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
>  }                                                                          \
>  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>
> +#define ___bpf_syscall_args0()           ctx
> +#define ___bpf_syscall_args1(x)          ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
> +#define ___bpf_syscall_args2(x, args...) ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
> +#define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
> +#define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
> +#define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
> +#define ___bpf_syscall_args(args...)     ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
> +
> +/*
> + * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
> + * tracing syscall functions, like __x64_sys_close. It hides the underlying
> + * platform-specific low-level way of getting syscall input arguments from
> + * struct pt_regs, and provides a familiar typed and named function arguments
> + * syntax and semantics of accessing syscall input parameters.
> + *
> + * Original struct pt_regs* context is preserved as 'ctx' argument. This might
> + * be necessary when using BPF helpers like bpf_perf_event_output().
> + */

LGTM. Please also mention that this macro relies on CO-RE so that
users are aware.

Unfortunately we had to back out Ilya's patches with
PT_REGS_SYSCALL_REGS() and PT_REGS_PARMx_CORE_SYSCALL(), so we'll need
to wait a bit before merging this.


> +#define BPF_KPROBE_SYSCALL(name, args...)                                  \
> +name(struct pt_regs *ctx);                                                 \
> +static __attribute__((always_inline)) typeof(name(0))                      \
> +____##name(struct pt_regs *ctx, ##args);                                   \
> +typeof(name(0)) name(struct pt_regs *ctx)                                  \
> +{                                                                          \
> +       struct pt_regs *regs = PT_REGS_SYSCALL_REGS(ctx);                   \
> +       _Pragma("GCC diagnostic push")                                      \
> +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")              \
> +       return ____##name(___bpf_syscall_args(args));                       \
> +       _Pragma("GCC diagnostic pop")                                       \
> +}                                                                          \
> +static __attribute__((always_inline)) typeof(name(0))                      \
> +____##name(struct pt_regs *ctx, ##args)
> +
>  #endif
> --
> 2.30.2

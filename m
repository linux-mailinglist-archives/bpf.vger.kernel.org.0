Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926124AB1BE
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 20:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiBFTh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 14:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiBFTh6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 14:37:58 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F87EC06173B
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 11:37:57 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q204so14298417iod.8
        for <bpf@vger.kernel.org>; Sun, 06 Feb 2022 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LctxqSt+bGsruONbdEQi0K+6Fs+bkFBsdnYy/lv7s30=;
        b=gi1YuHCZeqSrLy/N/wbYTekvg1Vrbfhj4Gw37wb41sbe/OU0TmH2vempCXXkZOrFSV
         rctmomPq81xQRuqmGRSxshbo/RMPebZ2bQZ7LENKj50HB0gQ1aA0xgCl30DIhkHLn0wz
         1fm10bBcAnkx+kJZTHXGcUdyuudTaw7zNXD4TN5zMtGHk1U8ERpxhbfyXoOL5XhM8sDu
         VA0vInmRbY2e6BKqGkN+Dof1dnrNkndQfne1XrRc6gJCrRbJiYb3AltLE2RSyrLBLKMh
         nqurZvYlVLP/UYRD0To7VUzPKJGnW10BFXwRCqs14u25nZnDOJdRjDwZbZtVvRf8ORjV
         YePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LctxqSt+bGsruONbdEQi0K+6Fs+bkFBsdnYy/lv7s30=;
        b=e7RHFX0CPCKOiPQlbUUhibYhAUxxv49rp0+S2SWoSyxrG0DdmFog+MPp0Jvn4ax6lE
         w7UKudE97AEVgbgA0lCgdRpbhAWHuWm/dZIh1GvMtzudqmSURkg5zrPJrZ9lQoTCYXpu
         +gn5GIW7ZyxS3u5jnBjguBExPNFQ+Unnz6vT7azqtosgu+aCbOWoMYdUYqkr09NmVU8R
         RQVjLEkZgwwg1PIG4fa2IgunoN3PYzkRs6aLK8He/Vc36ZC2mrzD6T7zg+rru//paNmQ
         2Wgcju7z8ROoV1kjzaH6HVSRP3i/lp4Szu84l9wk5b3EC6L2WPZAjKSaNM/4OLm1UcsI
         mugg==
X-Gm-Message-State: AOAM533JZUE2K0Ok/lAn8aAs7V2koqv1Q4ZGHZrbFhYNIU1eeq7ajm1P
        Cb7scXZKmtjcVre8mXI8QjeoG4zq9Mm2+nlnVQ4=
X-Google-Smtp-Source: ABdhPJwD+NBau7/yK7lkZwXB2AnmB/SvU5ZDLAlxTiMk74PcKS+OL4GTQemCep62hMWXxzX7jpYfH/+Ix/bT5soVos0=
X-Received: by 2002:a5e:8406:: with SMTP id h6mr4202019ioj.144.1644176276887;
 Sun, 06 Feb 2022 11:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20220206134051.721574-1-hengqi.chen@gmail.com> <20220206134051.721574-2-hengqi.chen@gmail.com>
In-Reply-To: <20220206134051.721574-2-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 6 Feb 2022 11:37:46 -0800
Message-ID: <CAEf4BzY1zwN6L5CZAfnw4onF5Zf4OaKdL0XjbdGtL46F=ADiLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Add BPF_KPROBE_SYSCALL macro
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

On Sun, Feb 6, 2022 at 5:41 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add syscall-specific variant of BPF_KPROBE named BPF_KPROBE_SYSCALL ([0]).
> The new macro hides the underlying way of getting syscall input arguments.
> With these new macros, the following code:
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
>  tools/lib/bpf/bpf_tracing.h | 39 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index cf980e54d331..a0b230320335 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -461,4 +461,43 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
>  }                                                                          \
>  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>
> +#define ___bpf_syscall_args0() ctx
> +#define ___bpf_syscall_args1(x) \
> +       ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
> +#define ___bpf_syscall_args2(x, args...) \
> +       ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
> +#define ___bpf_syscall_args3(x, args...) \
> +       ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
> +#define ___bpf_syscall_args4(x, args...) \
> +       ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
> +#define ___bpf_syscall_args5(x, args...) \
> +       ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
> +#define ___bpf_syscall_args(args...) \
> +       ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
> +

please keep each #define on a single line, it's much easier to follow
(and validate) the pattern that way

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
> +#define BPF_KPROBE_SYSCALL(name, args...)                                  \
> +name(struct pt_regs *ctx);                                                 \
> +static __attribute__((always_inline)) typeof(name(0))                      \
> +____##name(struct pt_regs *ctx, ##args);                                   \
> +typeof(name(0)) name(struct pt_regs *ctx)                                  \
> +{                                                                          \
> +       struct pt_regs *regs = (void *)PT_REGS_PARM1(ctx);                  \

See recent Ilya's patch set ([0]), not all architectures need this
unwrapping. We've abstracted this into PT_REGS_SYSCALL() macro, please
use it here.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=611184&state=*

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

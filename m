Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276E94AE998
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiBIF4F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:56:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiBIFyH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:54:07 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ADFC001F5A
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:54:09 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z7so859134ilb.6
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5tjxpD55punmIuvMRPakCFcrI+G+xAlhtL1EMDyNqkM=;
        b=ZQ8m7w/TKqGb1WwTNc0/Ri2VR1gBNyH/SpEvVa3OFAa9Y2fzJhYJE68XZEC/LdNnqc
         A+IGwBHpEp4gfA9MzY82WZAvZ+zf2UCXHo4erfGPfJqma5hxmMdrtZjBKXx/M3erPzDu
         wXeTzT9kWPOms/Pt+/UniVnDU+gEyYhLYICh/geDrFrulb4GdpvYpZ9NT7gLKkDelLH6
         v0ic2Z7uL3twmJGFERgjepYjHcchGtvozLc6tm7ucyTW6k7nyy31pkHm5UlFuxMRAHxY
         lTaTpKvU9YL1za2rkLshWKgjf7NSM+fOqnuuzAFCCl9NiYhAwvuDA2EQ32LL1UjoZEez
         AQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tjxpD55punmIuvMRPakCFcrI+G+xAlhtL1EMDyNqkM=;
        b=JppFJSmPwTyIh1bFsHmPq+0ngnQ/grPFVWiSXm/gBAeTYoPqDKFcAfMN9oQREXifiD
         VIFR2nN+znPJmG5vxL5DbNcQ8FVVtHJpFr/cKFsYOKxTaurMRpcWWU3sC2oHXeG3zoin
         22QQjLTX0vEPvRLNvUY4fx7Db8enEHTfjkhWwOdKAr8gVlFenO250T1XAlOsJ4fnWdKJ
         qQjSWrCDYQSHPi0EvLzQ6Ri0/pvxTDhI9OICHEy5dD1TuCytGpUHyZTpUM/9a/IOybF0
         TI9nH8FL3Jl1WBPlFgd6ZEmfMpE6spy9MABdr8IEU3fDX8QAJ3iLn+TZOsnyMmqhwSpp
         6KHA==
X-Gm-Message-State: AOAM530KISzTsC8oefE8m+LxiGyNB0xT271EeOYlMhE8u0vELBA7QkUT
        iFZVjSzoi1g06ZmCK8F0512Kwam+pMxPmY09Jnd3Cfu+
X-Google-Smtp-Source: ABdhPJx2c7ePsHLw8yx6o5/v8FTRbcNA/A5jiGpoMq6974cmzT96Jl9vF6dIT+KD1A/+kkkv9d5LsutdIVnXkykbQTQ=
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr349637ili.239.1644386046292;
 Tue, 08 Feb 2022 21:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20220207143134.2977852-1-hengqi.chen@gmail.com>
 <20220207143134.2977852-2-hengqi.chen@gmail.com> <CAEf4BzaQvpS+Zh3zEmxqPC0nADXdjPV8UoWW90UJ8F7ZBFhQDQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaQvpS+Zh3zEmxqPC0nADXdjPV8UoWW90UJ8F7ZBFhQDQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 21:53:55 -0800
Message-ID: <CAEf4BzZM_HWA3keM=0FPk2j7G0AVcfCNfBXRx0BJj91uC5g21A@mail.gmail.com>
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

On Mon, Feb 7, 2022 at 1:58 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 7, 2022 at 6:31 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >
> > Add syscall-specific variant of BPF_KPROBE named BPF_KPROBE_SYSCALL ([0]).
> > The new macro hides the underlying way of getting syscall input arguments.
> > With the new macro, the following code:
> >
> >     SEC("kprobe/__x64_sys_close")
> >     int BPF_KPROBE(do_sys_close, struct pt_regs *regs)
> >     {
> >         int fd;
> >
> >         fd = PT_REGS_PARM1_CORE(regs);
> >         /* do something with fd */
> >     }
> >
> > can be written as:
> >
> >     SEC("kprobe/__x64_sys_close")
> >     int BPF_KPROBE_SYSCALL(do_sys_close, int fd)
> >     {
> >         /* do something with fd */
> >     }
> >
> >   [0] Closes: https://github.com/libbpf/libbpf/issues/425
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  tools/lib/bpf/bpf_tracing.h | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index cf980e54d331..7ad9cdea99e1 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -461,4 +461,37 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
> >  }                                                                          \
> >  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
> >
> > +#define ___bpf_syscall_args0()           ctx
> > +#define ___bpf_syscall_args1(x)          ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
> > +#define ___bpf_syscall_args2(x, args...) ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
> > +#define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
> > +#define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
> > +#define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
> > +#define ___bpf_syscall_args(args...)     ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
> > +
> > +/*
> > + * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
> > + * tracing syscall functions, like __x64_sys_close. It hides the underlying
> > + * platform-specific low-level way of getting syscall input arguments from
> > + * struct pt_regs, and provides a familiar typed and named function arguments
> > + * syntax and semantics of accessing syscall input parameters.
> > + *
> > + * Original struct pt_regs* context is preserved as 'ctx' argument. This might
> > + * be necessary when using BPF helpers like bpf_perf_event_output().
> > + */
>
> LGTM. Please also mention that this macro relies on CO-RE so that
> users are aware.
>

Now that Ilya's fixes are in again, added a small note about reliance
on BPF CO-RE and pushed to bpf-next, thanks.


On a relevant note. The whole __x64_sys_close vs sys_close depending
on architecture and kernel version was always super annoying. BCC
makes this transparent to users (AFAIK) and it always bothered me a
little, but I didn't see a clean solution that fits libbpf.

I think I finally found it, though. Instead of guessing whether the
kprobe function is a syscall or not based on "sys_" prefix of a kernel
function, we can use libbpf SEC() handling to do this transparently.
What if we define two new SEC() definitions:

SEC("ksyscall/write") and SEC("kretsyscall/write") (or maybe
SEC("kprobe.syscall/write") and SEC("kretprobe.syscall/write"), not
sure which one is better, voice your opinion, please). And for such
special kprobes, libbpf will perform feature detection of this
ARCH_SYSCALL_WRAPPER (we'll need to see the best way to do this in a
simple and fast way, preferably without parsing kallsyms) and
depending on it substitute either sys_write (or should it be
__se_sys_write, according to Naveen) or __<arch>_sys_write. You get
the idea.

I like that this is still explicit and in the spirit of libbpf, but
offloads the burden of knowing these intricate differences from users.

Thoughts?


> Unfortunately we had to back out Ilya's patches with
> PT_REGS_SYSCALL_REGS() and PT_REGS_PARMx_CORE_SYSCALL(), so we'll need
> to wait a bit before merging this.
>
>
> > +#define BPF_KPROBE_SYSCALL(name, args...)                                  \
> > +name(struct pt_regs *ctx);                                                 \
> > +static __attribute__((always_inline)) typeof(name(0))                      \
> > +____##name(struct pt_regs *ctx, ##args);                                   \
> > +typeof(name(0)) name(struct pt_regs *ctx)                                  \
> > +{                                                                          \
> > +       struct pt_regs *regs = PT_REGS_SYSCALL_REGS(ctx);                   \
> > +       _Pragma("GCC diagnostic push")                                      \
> > +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")              \
> > +       return ____##name(___bpf_syscall_args(args));                       \
> > +       _Pragma("GCC diagnostic pop")                                       \
> > +}                                                                          \
> > +static __attribute__((always_inline)) typeof(name(0))                      \
> > +____##name(struct pt_regs *ctx, ##args)
> > +
> >  #endif
> > --
> > 2.30.2

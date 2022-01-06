Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC941486B12
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 21:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbiAFU1c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 15:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiAFU1c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 15:27:32 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF9C061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 12:27:31 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id r16so1300063ile.8
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifMRp9791W/MHQdlfy7vocuo144aUQUZCxywrdfsmXQ=;
        b=PDXrRXdxgucJ8/VbHHfgA8lPKlG50SRb8KVWQlhMvq5U7J6qB2Eb3yZafEYRJVDuxf
         IGKxnES+XZQH1tQfc2rSShqLAmIh9NmV41Kl9LVXTVcKJz+my55nLEPnWGcz/N09GbXn
         Eq7Nq3sojujyFgNwASKEKaE0FpLSD+fx7vVD9PAHcW5HBqZkdrRfIYRSBD6911iVbQOy
         YqP5YDHW54xc7v+iI7MetZ3HFaDwuscEtwGNPlF8wpGOTFzN+1DRGCWaPr4+kmHW6XCt
         gZzIX/a8RNJSWbWfmZ+pCGv9TvJNS15apfqZWhpmMoGJT7Jeod5k0TtPlPFNP8zenZ3m
         r5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifMRp9791W/MHQdlfy7vocuo144aUQUZCxywrdfsmXQ=;
        b=anYn2OP+mUUhOelpJicuf3YL6NnyLYdlVrCc1CN3K+R4pM4/eD3tgplmtIApfaa7Ts
         4v56sTt5fgUhWxF5YBFn546aa1du3PIkDQZ+N84qeAcXHUtT/JbGIm1pQIj75LDq0/nF
         IeOQgWAWEekXgYaD3JSWKObsJ9LJ59vith3dYiCfKVoZ9AFuN/KqRRvnN267zg5p3B/B
         Cr1NqLlLbblVyWMbH1bfs+gumCCFoSJe5COfRGx0Ap8xy2uc1/E0lCJ1St5WLAJfujqT
         qvgaxx5ZPlvkoiGgr5qiwqqfaykHBQCWxeYgOItWrFFNSZSdBEtg+FbXRtJNyGTWaIq1
         IEqg==
X-Gm-Message-State: AOAM530oX8bhPidH9mSIp3BjYIILEpThMTNn16KdoZVMqFXok/xKaQtZ
        PO2nChBxVp5JOlV2oM83NP9kqrHBVNLpVGL4LCA=
X-Google-Smtp-Source: ABdhPJzEGJHXWXV2PTtM1/nD2DL09B9kx2AzZ9aR8prDdeqwqMVGYTE3tAPkRAzl8gNuf5hv+soxq1lbvbXMSK9nObY=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr29203342ilu.98.1641500851185;
 Thu, 06 Jan 2022 12:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20211221055312.3371414-1-hengqi.chen@gmail.com>
 <20211221055312.3371414-2-hengqi.chen@gmail.com> <CAEf4BzZQy-KUd8D4jj0Th2Po4d8UbQL7xnywRcF3xwy99+127g@mail.gmail.com>
 <fdf24f25-256a-4254-a846-3d77d3d03601@gmail.com>
In-Reply-To: <fdf24f25-256a-4254-a846-3d77d3d03601@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Jan 2022 12:27:19 -0800
Message-ID: <CAEf4BzZwh1OzfEvh4Ofx7VHBSGAKdi0LVQpBuPOXCWQwHYgPww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL
 macros
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 23, 2021 at 4:11 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Hi, Andrii
>
> On 2021/12/22 8:18 AM, Andrii Nakryiko wrote:
> > On Mon, Dec 20, 2021 at 9:53 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> Add syscall-specific variants of BPF_KPROBE/BPF_KRETPROBE named
> >> BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL ([0]). These new macros
> >> hide the underlying way of getting syscall input arguments and
> >> return values. With these new macros, the following code:
> >>
> >>     SEC("kprobe/__x64_sys_close")
> >>     int BPF_KPROBE(do_sys_close, struct pt_regs *regs)
> >>     {
> >>         int fd;
> >>
> >>         fd = PT_REGS_PARM1_CORE(regs);
> >>         /* do something with fd */
> >>     }
> >>
> >> can be written as:
> >>
> >>     SEC("kprobe/__x64_sys_close")
> >>     int BPF_KPROBE_SYSCALL(do_sys_close, int fd)
> >>     {
> >>         /* do something with fd */
> >>     }
> >>
> >>   [0] Closes: https://github.com/libbpf/libbpf/issues/425
> >>
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >
> > As Yonghong mentioned, let's wait for PT_REGS_PARMx_SYSCALL macros to
> > land and use those (due to 4th argument quirkiness on x86 arches).
> >
>
> I see those patches, will wait.

They got merged, feel free to resubmit.

>
> >>  tools/lib/bpf/bpf_tracing.h | 45 +++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 45 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> >> index db05a5937105..eb4b567e443f 100644
> >> --- a/tools/lib/bpf/bpf_tracing.h
> >> +++ b/tools/lib/bpf/bpf_tracing.h
> >> @@ -489,4 +489,49 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
> >>  }                                                                          \
> >>  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
> >>
> >> +#define ___bpf_syscall_args0() ctx, regs
> >> +#define ___bpf_syscall_args1(x) \
> >> +       ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE(regs)
> >> +#define ___bpf_syscall_args2(x, args...) \
> >> +       ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE(regs)
> >> +#define ___bpf_syscall_args3(x, args...) \
> >> +       ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE(regs)
> >> +#define ___bpf_syscall_args4(x, args...) \
> >> +       ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE(regs)
> >> +#define ___bpf_syscall_args5(x, args...) \
> >> +       ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE(regs)
> >> +#define ___bpf_syscall_args(args...) \
> >> +       ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
> >
> > try keeping each definition on a single line, make them much more
> > readable and I think still fits in 100 character limit
> >
>
> This should be addressed by your patch, will build on top of it.
>
> >> +
> >> +/*
> >> + * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
> >> + * tracing syscall functions. It hides the underlying platform-specific
> >
> > let's add a simple example to explain what kind of tracing syscall
> > functions we mean.
> >
> > "tracing syscall functions, like __x64_sys_close." ?
> >
> >> + * low-level way of getting syscall input arguments from struct pt_regs, and
> >> + * provides a familiar typed and named function arguments syntax and
> >> + * semantics of accessing syscall input paremeters.
> >
> > typo: parameters
> >
>
> Ack.
>
> >> + *
> >> + * Original struct pt_regs* context is preserved as 'ctx' argument. This might
> >> + * be necessary when using BPF helpers like bpf_perf_event_output().
> >> + */
> >> +#define BPF_KPROBE_SYSCALL(name, args...)                                  \
> >> +name(struct pt_regs *ctx);                                                 \
> >> +static __attribute__((always_inline)) typeof(name(0))                      \
> >> +____##name(struct pt_regs *ctx, struct pt_regs *regs, ##args);             \
> >> +typeof(name(0)) name(struct pt_regs *ctx)                                  \
> >> +{                                                                          \
> >> +       _Pragma("GCC diagnostic push")                                      \
> >> +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")              \
> >> +       struct pt_regs *regs = PT_REGS_PARM1(ctx);                          \
> >
> > please move it out of _Pragma region, no need to guard it
> >
>
> Ack.
>
> >> +       return ____##name(___bpf_syscall_args(args));                       \
> >> +       _Pragma("GCC diagnostic pop")                                       \
> >> +}                                                                          \
> >> +static __attribute__((always_inline)) typeof(name(0))                      \
> >> +____##name(struct pt_regs *ctx, struct pt_regs *regs, ##args)
> >
> > I don't think we need to add another magical hidden argument "regs".
> > Anyone who will need it for something can get it from the hidden ctx
> > with PT_REGS_PARM1(ctx) anyways.
> >
>
> Yes, this should be removed, otherwise it may conflict with user-defined args.
>
> >> +
> >> +/*
> >> + * BPF_KRETPROBE_SYSCALL is just an alias to BPF_KRETPROBE,
> >> + * it provides optional return value (in addition to `struct pt_regs *ctx`)
> >> + */
> >> +#define BPF_KRETPROBE_SYSCALL BPF_KRETPROBE
> >> +
> >
> > hm... do we even need BPF_KRETPROBE_SYSCALL then? Let's drop it, it
> > doesn't provide much value, just creates a confusion.
> >
>
> OK, will drop it.
>
> >
> >>  #endif
> >> --
> >> 2.30.2
>
> ---
> Hengqi

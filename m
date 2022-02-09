Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF054AF8B1
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 18:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiBIRr4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 12:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiBIRr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 12:47:56 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081D0C05CB88
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 09:47:58 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id z18so2373672iln.2
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0IEMOXIARZSTvPLtDf8TOlc6bO8iOigBKukCcOgFzA=;
        b=T4TKFiiHzOQQCKEgTtgq4u9KlcXv4TzWqRFtqwXsOxyN9PlMhxjTF4EGkytfv4DQTQ
         3o0XydUNpGn+RI8bDrkq3w85HScUbrYWt2eEnQeldyRoT3hQdqKn9pX3ot5/amlPip3X
         yTDtZO5YE/WwqS8dHz2sWQ1j5rVcjzQxld+6AxwjV1zN50nCi6sHPvHExqYYKzFB5rod
         tlOD7ye2R5O7mWwQ+AYkmwf4AetnKvCxhH/SlAPLlvn+TNHDGkNWla4+piNY8c50MSvD
         ZNO7wXaVrpmEJfXzEizOaToy/WJHLb5dA+r6r6Md+hmjzMT8z5UD4q7UXejRRZZqKQoo
         IA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0IEMOXIARZSTvPLtDf8TOlc6bO8iOigBKukCcOgFzA=;
        b=dIa8JxXhEhMCL0N6VthvZoalD9k/PXnL9pVv9cuVvY4o8FhOXoKITf2CbX8RzpW8U8
         19vQbh/Du8FT+xZHVcpZ4uvtnwOuL4ldrI0TxMdXceIVXmJZo//vvWet/VlgfTmiDSlH
         7Re3oNN2w39ZxgrqHTj5FDn6bway4b1C8A6Dwc07Iay5ezQhogukTLmy2/KPGZkWiaLo
         dsiqKz1ZU7z60tjMH+2UozFkrsU28xm/M17DU+oSBH344kXvTdjhvrqhC8RytntsUcpo
         s8WTNdV6nTz9ezQe1HafW0JByOu8V8zyeQFQ/gxfcRhDV+LEaP82M5QMf02HEXfJIJox
         Eynw==
X-Gm-Message-State: AOAM533LO0z/tNVBTOAlovmwse9P8dO5ppOE8VOK40VO1wvAuma3RWl9
        DeIG7nla3ANVsSr5PmZMTnWeCu95AW4XssAOs2NC46vs
X-Google-Smtp-Source: ABdhPJyZyqqeZXWdGYDOo2Ad0OCmhlp8FvmkgJxnam2aVlGVCE/lcicr4/1Q1XcwL7dggSsmwv6KKKBbTHyoIcmgrWM=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr1670761ilu.71.1644428877223;
 Wed, 09 Feb 2022 09:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20220207143134.2977852-1-hengqi.chen@gmail.com>
 <20220207143134.2977852-2-hengqi.chen@gmail.com> <CAEf4BzaQvpS+Zh3zEmxqPC0nADXdjPV8UoWW90UJ8F7ZBFhQDQ@mail.gmail.com>
 <CAEf4BzZM_HWA3keM=0FPk2j7G0AVcfCNfBXRx0BJj91uC5g21A@mail.gmail.com> <CAADnVQK9wUd6OWWL_oPcuy_G=-z8Xq7OP3ej40OM8+xfHLfYdg@mail.gmail.com>
In-Reply-To: <CAADnVQK9wUd6OWWL_oPcuy_G=-z8Xq7OP3ej40OM8+xfHLfYdg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Feb 2022 09:47:46 -0800
Message-ID: <CAEf4BzZiC=f8pqZcmfH+upjMrTxx4970n=uqp1NicWx279AvZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: Add BPF_KPROBE_SYSCALL macro
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, bpf <bpf@vger.kernel.org>,
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

On Wed, Feb 9, 2022 at 8:38 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 9, 2022 at 2:25 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Feb 7, 2022 at 1:58 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Feb 7, 2022 at 6:31 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> > > >
> > > > Add syscall-specific variant of BPF_KPROBE named BPF_KPROBE_SYSCALL ([0]).
> > > > The new macro hides the underlying way of getting syscall input arguments.
> > > > With the new macro, the following code:
> > > >
> > > >     SEC("kprobe/__x64_sys_close")
> > > >     int BPF_KPROBE(do_sys_close, struct pt_regs *regs)
> > > >     {
> > > >         int fd;
> > > >
> > > >         fd = PT_REGS_PARM1_CORE(regs);
> > > >         /* do something with fd */
> > > >     }
> > > >
> > > > can be written as:
> > > >
> > > >     SEC("kprobe/__x64_sys_close")
> > > >     int BPF_KPROBE_SYSCALL(do_sys_close, int fd)
> > > >     {
> > > >         /* do something with fd */
> > > >     }
> > > >
> > > >   [0] Closes: https://github.com/libbpf/libbpf/issues/425
> > > >
> > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/bpf_tracing.h | 33 +++++++++++++++++++++++++++++++++
> > > >  1 file changed, 33 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > > > index cf980e54d331..7ad9cdea99e1 100644
> > > > --- a/tools/lib/bpf/bpf_tracing.h
> > > > +++ b/tools/lib/bpf/bpf_tracing.h
> > > > @@ -461,4 +461,37 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
> > > >  }                                                                          \
> > > >  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
> > > >
> > > > +#define ___bpf_syscall_args0()           ctx
> > > > +#define ___bpf_syscall_args1(x)          ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
> > > > +#define ___bpf_syscall_args2(x, args...) ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
> > > > +#define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
> > > > +#define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
> > > > +#define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
> > > > +#define ___bpf_syscall_args(args...)     ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
> > > > +
> > > > +/*
> > > > + * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
> > > > + * tracing syscall functions, like __x64_sys_close. It hides the underlying
> > > > + * platform-specific low-level way of getting syscall input arguments from
> > > > + * struct pt_regs, and provides a familiar typed and named function arguments
> > > > + * syntax and semantics of accessing syscall input parameters.
> > > > + *
> > > > + * Original struct pt_regs* context is preserved as 'ctx' argument. This might
> > > > + * be necessary when using BPF helpers like bpf_perf_event_output().
> > > > + */
> > >
> > > LGTM. Please also mention that this macro relies on CO-RE so that
> > > users are aware.
> > >
> >
> > Now that Ilya's fixes are in again, added a small note about reliance
> > on BPF CO-RE and pushed to bpf-next, thanks.
> >
> >
> > On a relevant note. The whole __x64_sys_close vs sys_close depending
> > on architecture and kernel version was always super annoying. BCC
> > makes this transparent to users (AFAIK) and it always bothered me a
> > little, but I didn't see a clean solution that fits libbpf.
> >
> > I think I finally found it, though. Instead of guessing whether the
> > kprobe function is a syscall or not based on "sys_" prefix of a kernel
> > function, we can use libbpf SEC() handling to do this transparently.
> > What if we define two new SEC() definitions:
> >
> > SEC("ksyscall/write") and SEC("kretsyscall/write") (or maybe
> > SEC("kprobe.syscall/write") and SEC("kretprobe.syscall/write"), not
> > sure which one is better, voice your opinion, please). And for such
> > special kprobes, libbpf will perform feature detection of this
> > ARCH_SYSCALL_WRAPPER (we'll need to see the best way to do this in a
> > simple and fast way, preferably without parsing kallsyms) and
> > depending on it substitute either sys_write (or should it be
> > __se_sys_write, according to Naveen) or __<arch>_sys_write. You get
> > the idea.
> >
> > I like that this is still explicit and in the spirit of libbpf, but
> > offloads the burden of knowing these intricate differences from users.
> >
> > Thoughts?
>
> I think it will be just as fragile.
> That syscall prefix was changed by the kernel few times now.
> libbpf will be chasing the moving target.
> I think keeping the magic in .h is simpler and less of a maintenance burden.

Absolutely it is simpler, but it only works for selftests (and even
then, when prefix changes again we'll need to adjust selftests). But
the point here is to not require end users to chase this instead. And
in the real world where users want to work on as wide a range of
kernel versions as possible SYS_PREFIX trick doesn't work (which is
why I didn't want to add that to bpf_tracing.h).

It's cheaper (maintenance-wise) to do it in libbpf than require all
the kprobe users to keep track of this, no? And good thing is that
libbpf is part of the kernel repo, so whenever someone changes this in
the kernel we'll get a failing selftest on next net-next -> bpf->next
sync (at least for architectures that we do test), so we'll be able to
fix and adjust quickly.

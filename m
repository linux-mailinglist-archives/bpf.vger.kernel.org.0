Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960B24AF6EB
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 17:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiBIQil (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 11:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiBIQi2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 11:38:28 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61136C05CB96
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 08:38:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u12so1208149plf.13
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 08:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMFiZPkY84ak5gT0WuUt2POaOoOFnhSbETVtPicT8H8=;
        b=bxreEgt4iIxqlKUGuW+2FdgFkdVYggeamPIm8QN5TLQ2RTJR5rh6kLZO/umbeMKW4k
         GJbq8GYsvmqiM0IK2NnzL4UPLnggzWteywXJDhg7xGkMwYYXb5Xcu+4dz/IZ8yd5hk2Y
         PgRaaH0n9vQSzbHPrAxe1wpg81pG0Q8r7EaHRKkEjvUmrrNA+EU9hYxMvnyEDMdSzffU
         wGhwMjlCipAMbQHy1ND1qJOU4NfsZaRrXnMmb8gqc61fzXu7ZrwZOvn9PNluBeiM8t1C
         8kXzd/D326ekYdYyRS1YiC1qoQ/uP7fYRzwwhvS4v2Fmt+Z+Uli4hmegrrStF1ZSHHPK
         4qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMFiZPkY84ak5gT0WuUt2POaOoOFnhSbETVtPicT8H8=;
        b=fKiIKa5MQeVtu2hSlbE4MNbRtjb627fG5KFcM2+p/fW3ZK50p4hZgM7NfDAAI1XTnG
         HJjG2u+0BQUqNPIMDY5U5OA2smf73K0XfB8DdLHb3ss0DEANRMYOLacte+oztH7IC3U2
         fUxCEIAq2p5T7EPSBHTtwIV/f8TPkXUhHDo3dR6PI5kfdbxg+XUjBeU49Q8Mn9awatA1
         GQ1n7a4vLpUx4BHNQ1rVz+jRBsp5aQJkiYrFdDWdeMD1qf2alm9rybzCBxQglsDRt9ne
         8rbqCfm8vhNoriZms/7Y6mUa2HPPHG0KUF9D7axjx6kMs9YJMkLelPzmyLfHQXgK7hxy
         j7ag==
X-Gm-Message-State: AOAM5317MyHohk+sQr8SPHgrI9OWNFJfIVHAlJsJLpSYQonhqp9E0e4E
        LwFid8lW5u9TulLQQyMGtHvReGotitCmOiAEGX+eLpQT
X-Google-Smtp-Source: ABdhPJzCWOq/wQZfNoZrEEjadKHCDB1wPPU4nSEAOXlrh6K3T2bt71Cz7dgtsYfPG6YaCP2zhwsaL4HsPA/iCeMZ9l8=
X-Received: by 2002:a17:902:d4d0:: with SMTP id o16mr2920664plg.116.1644424707675;
 Wed, 09 Feb 2022 08:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20220207143134.2977852-1-hengqi.chen@gmail.com>
 <20220207143134.2977852-2-hengqi.chen@gmail.com> <CAEf4BzaQvpS+Zh3zEmxqPC0nADXdjPV8UoWW90UJ8F7ZBFhQDQ@mail.gmail.com>
 <CAEf4BzZM_HWA3keM=0FPk2j7G0AVcfCNfBXRx0BJj91uC5g21A@mail.gmail.com>
In-Reply-To: <CAEf4BzZM_HWA3keM=0FPk2j7G0AVcfCNfBXRx0BJj91uC5g21A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 9 Feb 2022 08:38:16 -0800
Message-ID: <CAADnVQK9wUd6OWWL_oPcuy_G=-z8Xq7OP3ej40OM8+xfHLfYdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: Add BPF_KPROBE_SYSCALL macro
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Wed, Feb 9, 2022 at 2:25 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 7, 2022 at 1:58 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Feb 7, 2022 at 6:31 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> > >
> > > Add syscall-specific variant of BPF_KPROBE named BPF_KPROBE_SYSCALL ([0]).
> > > The new macro hides the underlying way of getting syscall input arguments.
> > > With the new macro, the following code:
> > >
> > >     SEC("kprobe/__x64_sys_close")
> > >     int BPF_KPROBE(do_sys_close, struct pt_regs *regs)
> > >     {
> > >         int fd;
> > >
> > >         fd = PT_REGS_PARM1_CORE(regs);
> > >         /* do something with fd */
> > >     }
> > >
> > > can be written as:
> > >
> > >     SEC("kprobe/__x64_sys_close")
> > >     int BPF_KPROBE_SYSCALL(do_sys_close, int fd)
> > >     {
> > >         /* do something with fd */
> > >     }
> > >
> > >   [0] Closes: https://github.com/libbpf/libbpf/issues/425
> > >
> > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > ---
> > >  tools/lib/bpf/bpf_tracing.h | 33 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > > index cf980e54d331..7ad9cdea99e1 100644
> > > --- a/tools/lib/bpf/bpf_tracing.h
> > > +++ b/tools/lib/bpf/bpf_tracing.h
> > > @@ -461,4 +461,37 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
> > >  }                                                                          \
> > >  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
> > >
> > > +#define ___bpf_syscall_args0()           ctx
> > > +#define ___bpf_syscall_args1(x)          ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
> > > +#define ___bpf_syscall_args2(x, args...) ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
> > > +#define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
> > > +#define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
> > > +#define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
> > > +#define ___bpf_syscall_args(args...)     ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
> > > +
> > > +/*
> > > + * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
> > > + * tracing syscall functions, like __x64_sys_close. It hides the underlying
> > > + * platform-specific low-level way of getting syscall input arguments from
> > > + * struct pt_regs, and provides a familiar typed and named function arguments
> > > + * syntax and semantics of accessing syscall input parameters.
> > > + *
> > > + * Original struct pt_regs* context is preserved as 'ctx' argument. This might
> > > + * be necessary when using BPF helpers like bpf_perf_event_output().
> > > + */
> >
> > LGTM. Please also mention that this macro relies on CO-RE so that
> > users are aware.
> >
>
> Now that Ilya's fixes are in again, added a small note about reliance
> on BPF CO-RE and pushed to bpf-next, thanks.
>
>
> On a relevant note. The whole __x64_sys_close vs sys_close depending
> on architecture and kernel version was always super annoying. BCC
> makes this transparent to users (AFAIK) and it always bothered me a
> little, but I didn't see a clean solution that fits libbpf.
>
> I think I finally found it, though. Instead of guessing whether the
> kprobe function is a syscall or not based on "sys_" prefix of a kernel
> function, we can use libbpf SEC() handling to do this transparently.
> What if we define two new SEC() definitions:
>
> SEC("ksyscall/write") and SEC("kretsyscall/write") (or maybe
> SEC("kprobe.syscall/write") and SEC("kretprobe.syscall/write"), not
> sure which one is better, voice your opinion, please). And for such
> special kprobes, libbpf will perform feature detection of this
> ARCH_SYSCALL_WRAPPER (we'll need to see the best way to do this in a
> simple and fast way, preferably without parsing kallsyms) and
> depending on it substitute either sys_write (or should it be
> __se_sys_write, according to Naveen) or __<arch>_sys_write. You get
> the idea.
>
> I like that this is still explicit and in the spirit of libbpf, but
> offloads the burden of knowing these intricate differences from users.
>
> Thoughts?

I think it will be just as fragile.
That syscall prefix was changed by the kernel few times now.
libbpf will be chasing the moving target.
I think keeping the magic in .h is simpler and less of a maintenance burden.

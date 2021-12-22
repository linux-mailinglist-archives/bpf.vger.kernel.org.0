Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E393147CD13
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 07:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbhLVGrh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 01:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhLVGrh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Dec 2021 01:47:37 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC20C061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 22:47:36 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id g5so1037709ilj.12
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 22:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W6j18JShMG3Lznh0rcbhjD6kiFwTdL1iMBzebmxFe2M=;
        b=HtgTPcf7i2/vOEVhJOo3OpemV+dEzozuK/5vnjlZYGQF891vTvZfIwPSo1ksTL9h13
         5mE8rXaY57gu9nLuUbeKRyS0DDYLnjqfAv5h015rJ80ntTk/s1KVsqNVUkGsa1ohp2Zk
         hBU+BqyAfTnfeAkI3DL8EBxQXQveDKhDrGg2w6FOOlW6RWbZWOrzltPp7yQihvysW1nq
         awK2Od3gOzjz7QJbY1sWgLbvNVCxBBiSs44ZkXWtR07IRXdox2EZFjlfi6Oc64Z+cUC8
         SVq0BOY+ljcHmEPYJVfMLUia3u5RqraRpVHJcPLPtToUBrlxh23QiZDogkG14K9zkeec
         fEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W6j18JShMG3Lznh0rcbhjD6kiFwTdL1iMBzebmxFe2M=;
        b=10j0Apjelp81uJIr7BukBXQH9Hwez1WBY5rfBh1YJGNxhCV8T+GsS5jG39MZya5yWO
         7a/x/2Kf0mQeueRps43vD/SrKehV/MrZwytHOJBqdQusrH1g99dmnKygRehPSH2UHum0
         /+FgMTJ5YEceUrOuc5D0A9qB5mJbncnrydCHZhv8q/vQlorUh3cM6iPeSJxsZCluqP1D
         db46V1qPtZMnWUrFimOBOpMzMzZUEugUbs9LEts+Jd+BbufP3In8dfdc6h3TRoyzyuBq
         bB+XLhxISeWX45vpmKShH4m2hwRRUXp84KcK64HIUZvSfj9/i4kVsjXNhNYcfqttgA1S
         koLA==
X-Gm-Message-State: AOAM5332lHS149Y+1HTEkl2SsEj+7IuxzWNO34qNRcfHn3yc+uCFAJCr
        zDrzhmrZQ7slAsntaHkFqrNxh6FZ4l1JinpdRzA=
X-Google-Smtp-Source: ABdhPJzSxGn3gdqKopc0WrvIETAvnyIh24J8XEKp7T3F/7Ef7o8mBs1edpulVq/V8kRb2eOzKI2YZVpusQLUwCxjMlA=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr754772ilu.98.1640155656128;
 Tue, 21 Dec 2021 22:47:36 -0800 (PST)
MIME-Version: 1.0
References: <TYCPR01MB59360988D96E23FBA97DAE0AF57C9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
 <0d380bb2-13df-d934-a873-f2f10279dbb2@fb.com> <CAEf4BzaJLZP-Y5deE8fB=YJSNZA-meHT8pgU4G0xvV-aMvV0HA@mail.gmail.com>
 <TYCPR01MB593607100AD90D252D94F8DFF57D9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
 <TYCPR01MB5936D58FCE4F78F89EAAA4B9F57D9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB5936D58FCE4F78F89EAAA4B9F57D9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Dec 2021 22:47:25 -0800
Message-ID: <CAEf4Bzbgfvzz2x+o0ORpNCiVCLpVm-hyLPJfUc2fk=hyxsZK9g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix the incorrect register read for syscalls on x86_64
To:     Kenta.Tada@sony.com
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 21, 2021 at 10:20 PM <Kenta.Tada@sony.com> wrote:
>
> >>
> >> Also, could you add a selftest to use this macro, esp. for parameter 4=
?
>
> I misunderstood this comment.
> I'll just add a test of this new macro.
>
> -----Original Message-----
> From: Tada, Kenta (SGC)
> Sent: Wednesday, December 22, 2021 2:52 PM
> To: Andrii Nakryiko <andrii.nakryiko@gmail.com>; Yonghong Song <yhs@fb.co=
m>
> Cc: Andrii Nakryiko <andrii@kernel.org>; bpf <bpf@vger.kernel.org>; Alexe=
i Starovoitov <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Mar=
tin Lau <kafai@fb.com>; Song Liu <songliubraving@fb.com>; john fastabend <j=
ohn.fastabend@gmail.com>; KP Singh <kpsingh@kernel.org>
> Subject: RE: [PATCH] libbpf: Fix the incorrect register read for syscalls=
 on x86_64
>
> >> Looks like macros only available for x86_64. Can we make it also
> >> available for other architectures so we won't introduce arch specific
> >> codes into bpf program?
> >
> >Yeah, but instead of copy/pasting it for each architecture, let's
> >define PT_REGS_PARM4/PT_REGS_PARM4_CORE for x86-64 (is this the only
> >arch with such inconsistency?) and then after all the architectures
> >defined their macro define
>
> Currently, I think x86_64 is the only arch which causes this issue.
> But I'll add #ifndef to not only the 4th parameter but also all parameter=
s for future extensibility.

Let's not add unnecessary #ifndefs. If we get a case for other args,
we'll add #ifndefs as necessary.

But after looking at your and Hengqi's patches in the last few days,
I've looked at the current state of bpf_tracing.h and felt like there
is too much repetition. So I've refactored it to not require as many
similar macro definitions. I'm going to finish it up and submit it
tomorrow, so please hold on a bit with your additions until then so
that you can base it off the refactored bpf_tracing.h. Thanks.

>
> >>
> >> Also, could you add a selftest to use this macro, esp. for parameter 4=
?
>
> Sure.
> I'll add the same macro to bpf_tracing.h in selftests.
>
> Thanks!
>
> -----Original Message-----
> From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Sent: Wednesday, December 22, 2021 7:58 AM
> To: Yonghong Song <yhs@fb.com>
> Cc: Tada, Kenta (SGC) <Kenta.Tada@sony.com>; Andrii Nakryiko <andrii@kern=
el.org>; bpf <bpf@vger.kernel.org>; Alexei Starovoitov <ast@kernel.org>; Da=
niel Borkmann <daniel@iogearbox.net>; Martin Lau <kafai@fb.com>; Song Liu <=
songliubraving@fb.com>; john fastabend <john.fastabend@gmail.com>; KP Singh=
 <kpsingh@kernel.org>
> Subject: Re: [PATCH] libbpf: Fix the incorrect register read for syscalls=
 on x86_64
>
> On Tue, Dec 21, 2021 at 7:51 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 12/21/21 3:21 AM, Kenta.Tada@sony.com wrote:
> > > Currently, rcx is read as the fourth parameter of syscall on x86_64.
> > > But x86_64 Linux System Call convention uses r10 actually.
> > > This commit adds the wrapper for users who want to access to syscall
> > > params to analyze the user space.
> > >
> > > Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> > > ---
> > >   tools/lib/bpf/bpf_tracing.h | 20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/bpf_tracing.h
> > > b/tools/lib/bpf/bpf_tracing.h index db05a5937105..f6fcccd9b10c
> > > 100644
> > > --- a/tools/lib/bpf/bpf_tracing.h
> > > +++ b/tools/lib/bpf/bpf_tracing.h
> > > @@ -67,10 +67,15 @@
> > >   #if defined(__KERNEL__) || defined(__VMLINUX_H__)
> > >
> > >   #define PT_REGS_PARM1(x) ((x)->di)
> > > +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> > >   #define PT_REGS_PARM2(x) ((x)->si)
> > > +#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
> > >   #define PT_REGS_PARM3(x) ((x)->dx)
> > > +#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
> > >   #define PT_REGS_PARM4(x) ((x)->cx)
> > > +#define PT_REGS_PARM4_SYSCALL(x) ((x)->r10) /* syscall uses r10 */
> >
> > I think this is correct. We have a bcc commit doing similar thing.
> > https://urldefense.com/v3/__https://github.com/iovisor/bcc/commit/c234
> > 48e34ecd3cc9bfc19f0b43f4325f77c2e4cc*diff-c78ffb58f59e85eaba9bf9977b72
> > 02f3e50f17e2a9ee556c36a311f9a9ab5d6e__;Iw!!JmoZiZGBv3RvKRSx!qa2pOQlUSd
> > WfoxmZ7EuPvZpWAlK5IBVP1eC-2d3njBLe3yehAXyV_0wI9mGRF5Q$ [github[.]com]
> >
> > >   #define PT_REGS_PARM5(x) ((x)->r8)
> > > +#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
> > >   #define PT_REGS_RET(x) ((x)->sp)
> > >   #define PT_REGS_FP(x) ((x)->bp)
> > >   #define PT_REGS_RC(x) ((x)->ax)
> > > @@ -78,10 +83,15 @@
> > >   #define PT_REGS_IP(x) ((x)->ip)
> > >
> > >   #define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), di)
> > > +#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> > >   #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), si)
> > > +#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
> > >   #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), dx)
> > > +#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
> > >   #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), cx)
> > > +#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ((x), r10) /*
> > > +syscall uses r10 */
> > >   #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), r8)
> > > +#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
> > >   #define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), sp)
> > >   #define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), bp)
> > >   #define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), ax) @@ -117,10
> > > +127,15 @@
> > >   #else
> > >
> > >   #define PT_REGS_PARM1(x) ((x)->rdi)
> > > +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> > >   #define PT_REGS_PARM2(x) ((x)->rsi)
> > > +#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
> > >   #define PT_REGS_PARM3(x) ((x)->rdx)
> > > +#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
> > >   #define PT_REGS_PARM4(x) ((x)->rcx)
> > > +#define PT_REGS_PARM4_SYSCALL(x) ((x)->r10) /* syscall uses r10 */
> > >   #define PT_REGS_PARM5(x) ((x)->r8)
> > > +#define PT_REGS_PARM5(x) PT_REGS_PARM5(x)
> > >   #define PT_REGS_RET(x) ((x)->rsp)
> > >   #define PT_REGS_FP(x) ((x)->rbp)
> > >   #define PT_REGS_RC(x) ((x)->rax)
> > > @@ -128,10 +143,15 @@
> > >   #define PT_REGS_IP(x) ((x)->rip)
> > >
> > >   #define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), rdi)
> > > +#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> > >   #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), rsi)
> > > +#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
> > >   #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), rdx)
> > > +#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
> > >   #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), rcx)
> > > +#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ((x), r10) /*
> > > +syscall uses r10 */
> > >   #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), r8)
> > > +#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
> > >   #define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), rsp)
> > >   #define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), rbp)
> > >   #define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), rax)
> >
> > Looks like macros only available for x86_64. Can we make it also
> > available for other architectures so we won't introduce arch specific
> > codes into bpf program?
>
> Yeah, but instead of copy/pasting it for each architecture, let's define =
PT_REGS_PARM4/PT_REGS_PARM4_CORE for x86-64 (is this the only arch with suc=
h inconsistency?) and then after all the architectures defined their macro =
define
>
> #define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x) ...
> #ifndef PT_REGS_PARM4_SYSCALL(x)
> #define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x) #endif
>
> That way we'll avoid all the extra "no-op" definitions.
>
>
> >
> > Also, could you add a selftest to use this macro, esp. for parameter 4?
>
> +1

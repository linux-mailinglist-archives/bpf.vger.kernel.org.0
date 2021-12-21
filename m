Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A4A47C972
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 23:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhLUW6Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 17:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhLUW6Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 17:58:25 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C6C061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 14:58:25 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id b187so493513iof.11
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 14:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3H7m2yCaKiGgX+L2sA+OXdw2iPkZIu3ADzAcJ3FlEc=;
        b=a/b3H+eq1es8neUwhWTc59W4wckzVGmhS/JlgRyWnLEutct6dcCC8Rvc7cnRo78Xe1
         IzPo8B1MADMqAWyjpISGlnzstvBkGK1llEV7cKamHyZcongA2iqTrBeI3LU8D2SnQmfT
         nf0K8keLBv+2EFfwBYFrgXCbtoo9LC5VxXlyVO7zQQJwqJcQfsF7i08+6NUJFccyf0/Z
         O5ydNGi181X2ffoU7oVeCax8GsAbVSVOZvLR0hWt64164XZgqVXnnwFXt2Qda3QaDP4D
         Oe3mTR30Q9bLmqzSUOqEW1Qr46qgdpb+7IpWytgpAhSX7Cvux5LCwLUIcL0zMXh0rKwO
         3B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3H7m2yCaKiGgX+L2sA+OXdw2iPkZIu3ADzAcJ3FlEc=;
        b=uio/5RbOYXrR1J7SHRAlmtXSDB8rJnigaOQ1FfCgfIp9Bf/aB0HDcs4m2DG0rJetMr
         27KUtSaYBtRI4R+8sYF5eAwNr/1DvO9m0UqqFK9KoNwyGuNxadm2cotrHuZjFnATYH1n
         k55KQ4ZurDxe37OqTv86qFFzLokLFGSRckNfj8T+WD3H3LNUDIEp1p8QDkcmbIV+Bmog
         f/S+ikEVNtygW1Gf+ePtAGdQEKY/efIhs6A2UI2NPvtKIbIqyxNhp9R/teAHn15UKNW5
         sHY5ceHJmjEOJ+BH7xRXbTHSiMe7mBFRt/4z3ES4Xd84MDMtCQQKot9EEWz0y3q52PP3
         EGGA==
X-Gm-Message-State: AOAM532eDyvkrVsigdtrU9l0uB+ZbRGQ1KnByU6YKe88cHSg4H91NjIS
        i58MdO9RlFaGz4K5ni77DFpjt1CMyRdiSmzBv48=
X-Google-Smtp-Source: ABdhPJzuM1uOrLjZo0nhaPt3jC3koU7UXYzTZjl5qBaA/RC/RsB3X+pz7YYDp6JRDOntRkVtDnByqlJeObl7caQnab0=
X-Received: by 2002:a02:c72e:: with SMTP id h14mr157427jao.103.1640127504484;
 Tue, 21 Dec 2021 14:58:24 -0800 (PST)
MIME-Version: 1.0
References: <TYCPR01MB59360988D96E23FBA97DAE0AF57C9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
 <0d380bb2-13df-d934-a873-f2f10279dbb2@fb.com>
In-Reply-To: <0d380bb2-13df-d934-a873-f2f10279dbb2@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Dec 2021 14:58:13 -0800
Message-ID: <CAEf4BzaJLZP-Y5deE8fB=YJSNZA-meHT8pgU4G0xvV-aMvV0HA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix the incorrect register read for syscalls on x86_64
To:     Yonghong Song <yhs@fb.com>
Cc:     Kenta.Tada@sony.com, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 21, 2021 at 7:51 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 12/21/21 3:21 AM, Kenta.Tada@sony.com wrote:
> > Currently, rcx is read as the fourth parameter of syscall on x86_64.
> > But x86_64 Linux System Call convention uses r10 actually.
> > This commit adds the wrapper for users who want to access to
> > syscall params to analyze the user space.
> >
> > Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> > ---
> >   tools/lib/bpf/bpf_tracing.h | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index db05a5937105..f6fcccd9b10c 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -67,10 +67,15 @@
> >   #if defined(__KERNEL__) || defined(__VMLINUX_H__)
> >
> >   #define PT_REGS_PARM1(x) ((x)->di)
> > +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> >   #define PT_REGS_PARM2(x) ((x)->si)
> > +#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
> >   #define PT_REGS_PARM3(x) ((x)->dx)
> > +#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
> >   #define PT_REGS_PARM4(x) ((x)->cx)
> > +#define PT_REGS_PARM4_SYSCALL(x) ((x)->r10) /* syscall uses r10 */
>
> I think this is correct. We have a bcc commit doing similar thing.
> https://github.com/iovisor/bcc/commit/c23448e34ecd3cc9bfc19f0b43f4325f77c2e4cc#diff-c78ffb58f59e85eaba9bf9977b7202f3e50f17e2a9ee556c36a311f9a9ab5d6e
>
> >   #define PT_REGS_PARM5(x) ((x)->r8)
> > +#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
> >   #define PT_REGS_RET(x) ((x)->sp)
> >   #define PT_REGS_FP(x) ((x)->bp)
> >   #define PT_REGS_RC(x) ((x)->ax)
> > @@ -78,10 +83,15 @@
> >   #define PT_REGS_IP(x) ((x)->ip)
> >
> >   #define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), di)
> > +#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> >   #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), si)
> > +#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
> >   #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), dx)
> > +#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
> >   #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), cx)
> > +#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ((x), r10) /* syscall uses r10 */
> >   #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), r8)
> > +#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
> >   #define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), sp)
> >   #define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), bp)
> >   #define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), ax)
> > @@ -117,10 +127,15 @@
> >   #else
> >
> >   #define PT_REGS_PARM1(x) ((x)->rdi)
> > +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> >   #define PT_REGS_PARM2(x) ((x)->rsi)
> > +#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
> >   #define PT_REGS_PARM3(x) ((x)->rdx)
> > +#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
> >   #define PT_REGS_PARM4(x) ((x)->rcx)
> > +#define PT_REGS_PARM4_SYSCALL(x) ((x)->r10) /* syscall uses r10 */
> >   #define PT_REGS_PARM5(x) ((x)->r8)
> > +#define PT_REGS_PARM5(x) PT_REGS_PARM5(x)
> >   #define PT_REGS_RET(x) ((x)->rsp)
> >   #define PT_REGS_FP(x) ((x)->rbp)
> >   #define PT_REGS_RC(x) ((x)->rax)
> > @@ -128,10 +143,15 @@
> >   #define PT_REGS_IP(x) ((x)->rip)
> >
> >   #define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), rdi)
> > +#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> >   #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), rsi)
> > +#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
> >   #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), rdx)
> > +#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
> >   #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), rcx)
> > +#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ((x), r10) /* syscall uses r10 */
> >   #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), r8)
> > +#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
> >   #define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), rsp)
> >   #define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), rbp)
> >   #define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), rax)
>
> Looks like macros only available for x86_64. Can we make it also
> available for other architectures so we won't introduce arch specific
> codes into bpf program?

Yeah, but instead of copy/pasting it for each architecture, let's
define PT_REGS_PARM4/PT_REGS_PARM4_CORE for x86-64 (is this the only
arch with such inconsistency?) and then after all the architectures
defined their macro define

#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
...
#ifndef PT_REGS_PARM4_SYSCALL(x)
#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
#endif

That way we'll avoid all the extra "no-op" definitions.


>
> Also, could you add a selftest to use this macro, esp. for parameter 4?

+1

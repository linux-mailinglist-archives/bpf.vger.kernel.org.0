Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417944AE593
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 00:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbiBHXne (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 18:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbiBHXne (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 18:43:34 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A2CC061577
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 15:43:33 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n17so1105287iod.4
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 15:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywdaOnEjOeIMT5w5rTz2pcLGJnuoAasgsaUiZwHQS2I=;
        b=NnZy1P0ftS4cd8TLNRZODWpbv3GnxvjR7V+dMRfm+RKPycZtKC3sTyXByRNWqTobiS
         sSxsZMVYFrD1wQdT6bXQrb7Pu8pD2gGMc9jEiJs6G4+qiCppg9XMTa+5CnR240+h2PF5
         BYzV0UDakk7AR47HBUmFG4NPGvmQDIHKceqBHgZJTONU8q1lfSnVQkjC0Fku/Tk5yxBM
         QTosX+3dX0AgyCYf1XJaXpt3ZPvb9BiDFWf+t8t8Zt3Xj5TEdUFh0vIfUNC8f8KsFT1i
         2KABPFKnmCzgO6Z6ldSYalcsg02e03TO0alS1GNmZDjbpAOlXKy4xX+RPVIrHouv9igP
         xv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywdaOnEjOeIMT5w5rTz2pcLGJnuoAasgsaUiZwHQS2I=;
        b=NMqetbnzNHwLqdu9st2nawjDXXynhzLCtDq9hwDDzFMIuNr9oiEL3NVmXcqCZMhDUP
         cG8ss6NItauQSUM3Rc/tKNiwV/8vvabBMq0+dcDBntZRpS+iOv/eICdR7H3Rio73h9SE
         kpvomMnu9QneRyT8VeeLnIJh5tpjqyyT2ekV/Ka5A0W/53DhzUYL8UPMJkL3YDT6qClQ
         IoO9QidDiEWEIDslzIOBHbN0hKrq22Jza8m1huPiZ2G6PRSz6NPjVJSyqxuN3codZayi
         xPApqczYvZhcqgahestU9pdCIxpMVljmEmGFs7SyqloorEG+hMPTJ56c534e94K+Akuh
         apFw==
X-Gm-Message-State: AOAM531TNBdNuvjIyIq0QTBxV3If7STe6fIYrDPqHZobhRK6eEaaUU7J
        fCBLhj1IqG/ugTVYHICYBebbp9RQF9ehTespLBnD3Fmk/h8=
X-Google-Smtp-Source: ABdhPJxhh7hQRGDCnbTcX8SqMGzDgm0HtkEulV4ewx0ajq8aNo610tVzyvYCu1UauxwHfiq4xhAZZn8K+0I3pcV4ZBM=
X-Received: by 2002:a05:6638:d88:: with SMTP id l8mr3373893jaj.234.1644363812742;
 Tue, 08 Feb 2022 15:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20220208051635.2160304-1-iii@linux.ibm.com> <20220208051635.2160304-7-iii@linux.ibm.com>
 <CAEf4BzagHVnAEz+22eFU=EeFuwvBGyGUbfT8XCmv4zF97KdUBA@mail.gmail.com> <aac0bbcaa484df34484eb928af208743167d50dc.camel@linux.ibm.com>
In-Reply-To: <aac0bbcaa484df34484eb928af208743167d50dc.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 15:43:21 -0800
Message-ID: <CAEf4BzaFAkmfJ7CsMrb7hosG5bYMxYt8DLfppUYLJK6Fd2rZ0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/14] libbpf: Add PT_REGS_SYSCALL_REGS macro
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
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

On Tue, Feb 8, 2022 at 3:26 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Tue, 2022-02-08 at 14:08 -0800, Andrii Nakryiko wrote:
> > On Mon, Feb 7, 2022 at 9:16 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > Depending on whether or not an arch has ARCH_HAS_SYSCALL_WRAPPER,
> > > syscall arguments must be accessed through a different set of
> > > registers. Provide PT_REGS_SYSCALL_REGS macro to abstract away
> > > that difference.
> > >
> > > Reported-by: Heiko Carstens <hca@linux.ibm.com>
> > > Co-developed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> >
> > Again, there was nothing wrong with the way you did it in v3, please
> > revert to that one.
>
> I've realized that, even though fully correct, v3 looked somewhat
> ad-hoc: it defined PT_REGS_SYSCALL_REGS for different architectures
> without explaining why this particular arch has this parciular way to
> access syscall arguments.
>
> So I've decided to switch to the existing terminology, as Naveen
> proposed [1]:
>
> - arches that select ARCH_HAS_SYSCALL_WRAPPER in Kconfig get a
>   __BPF_ARCH_HAS_SYSCALL_WRAPPER in bpf_tracing.h
>
> - syscall handler calling convention is (at least partially) determined
>   by whether or not an arch has a sycall wrapper as described in
>   ARCH_HAS_SYSCALL_WRAPPER help text
>
> I can, of course, switch back to v3 - both patches look functionally
> identical - but this one seems to be a bit easier to understand.
>
> [1]
> https://lore.kernel.org/bpf/1643991537.bfyv1b2oym.naveen@linux.ibm.com/#t
>
> >
> > >  tools/lib/bpf/bpf_tracing.h | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/bpf_tracing.h
> > > b/tools/lib/bpf/bpf_tracing.h
> > > index 82f1e935d549..7a015ee8fb11 100644
> > > --- a/tools/lib/bpf/bpf_tracing.h
> > > +++ b/tools/lib/bpf/bpf_tracing.h
> > > @@ -64,6 +64,8 @@
> > >
> > >  #if defined(bpf_target_x86)
> > >
> > > +#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> > > +
> > >  #if defined(__KERNEL__) || defined(__VMLINUX_H__)
> > >
> > >  #define __PT_PARM1_REG di
> > > @@ -114,6 +116,8 @@
> > >
> > >  #elif defined(bpf_target_s390)
> > >
> > > +#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> > > +
> > >  /* s390 provides user_pt_regs instead of struct pt_regs to
> > > userspace */
> > >  #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
> > >  #define __PT_PARM1_REG gprs[2]
> > > @@ -142,6 +146,8 @@
> > >
> > >  #elif defined(bpf_target_arm64)
> > >
> > > +#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> > > +
> > >  /* arm64 provides struct user_pt_regs instead of struct pt_regs to
> > > userspace */
> > >  #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
> > >  #define __PT_PARM1_REG regs[0]
> > > @@ -344,6 +350,17 @@ struct pt_regs;
> > >
> > >  #endif /* defined(bpf_target_defined) */
> > >
> > > +/*
> > > + * When invoked from a syscall handler BPF_KPROBE, returns a
> > > pointer to a
> > > + * struct pt_regs containing syscall arguments, that is suitable
> > > for passing to
> > > + * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().

You can mention ARCH_HAS_SYSCALL_WRAPPER here for documentation
purposes. I like the previous approach because it clearly shows which
architectures deviate from "common" behavior (whatever "common" we
chose as the default). With __BPF_ARCH_HAS_SYSCALL_WRAPPER I'll go and
start grepping what else depends on that, etc. Also,
ARCH_HAS_SYSCALL_WRAPPER can change over time, so it depends on kernel
version just as much as architecture (which with CO-RE we should be
able to handle transparently, btw).

Anyways, the previous one looks cleaner and easier to follow to me,
please use the previous version.

> > > + */
> > > +#ifdef __BPF_ARCH_HAS_SYSCALL_WRAPPER
> > > +#define PT_REGS_SYSCALL_REGS(ctx) ((struct pt_regs
> > > *)PT_REGS_PARM1(ctx))
> > > +#else
> > > +#define PT_REGS_SYSCALL_REGS(ctx) ctx
> > > +#endif
> > > +
> > >  #ifndef ___bpf_concat
> > >  #define ___bpf_concat(a, b) a ## b
> > >  #endif
> > > --
> > > 2.34.1
> > >
>

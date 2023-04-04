Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C97B6D6375
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjDDNj3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjDDNjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 09:39:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5072040F8
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 06:38:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso33934227pjb.3
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680615521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llENXJnfou0jHlwcAitFpF80zmdqqymKntlBX6KuEaQ=;
        b=FPA8lS3Ld7kyxA/NPoVx4VmFI259DulnGq3/aKGnqhSQal98slT+yBh+SodYuqVjzZ
         +FCbV0ArxBQOv5btNRCdRdbIZyCaotK2e6WbI0mb2iYu0t8xulPfxTvq1mmTf7pNP2dG
         rX2mWXujKUkKEPkTfs+hBkka0J7MPLvC1kBN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llENXJnfou0jHlwcAitFpF80zmdqqymKntlBX6KuEaQ=;
        b=IOAEJ9TYBXt9qrK6vlYJpArxQH60DfRw0d5LXd4BFP873ZsGBH0O2GaAu90NQfPrFb
         8X8akzj30egkr4kaInzh0kWXuCGm+Bp8k2+PzALXozwW3yyDZ2EiU0hRTm3wEyNNmRVu
         7MOp4HHr8wzU2z6LJM/tvtVPXKal7KwpPzZbvSNpd1bNOvUtXHpllZQOyIJpCbZnG9z8
         9JdH2BsVZq7iJsmD+6VdcMHCNKNBdcY0YhbbVmQ6ATuUGQnWyMas7MkIcwH6mo3f/aZ2
         YwOAf1enynAhrjtjX8sxvGK8cHf+V+kyYueIW00tBOH0As0ZcqrZywBwkm9RowLzYO+B
         lMtw==
X-Gm-Message-State: AAQBX9cjfvzfnfT96OY+jeAVIkOZQux3njCNZjkkl8v3btlKUm4EJ6NE
        c0U1UQhDs+6kFGsJLmON/QDotIUn1iAOj2cWU3xzAnOzSzCHg2NG
X-Google-Smtp-Source: AKy350b1tmpN2kP03lwA2YUIAI8vuYXWL2d7aNm1yEKP8eq8boem9oM3plC8rDv4swzoK98EZ9sMMLztSt/QkW7+o50=
X-Received: by 2002:a17:90a:a886:b0:23b:36cc:f347 with SMTP id
 h6-20020a17090aa88600b0023b36ccf347mr947229pjq.9.1680615520948; Tue, 04 Apr
 2023 06:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230403113552.2857693-1-revest@chromium.org> <20230403113552.2857693-4-revest@chromium.org>
 <ZCsMQ/6MI49st2oW@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZCsMQ/6MI49st2oW@FVFF77S0Q05N.cambridge.arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 4 Apr 2023 15:38:29 +0200
Message-ID: <CABRcYmJXQ6DpfNJ_P1Aros3QZ9+fZuvF-WgHc=YDRnUSUj__FQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] arm64: ftrace: Add direct call trampoline samples support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 3, 2023 at 7:26=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Mon, Apr 03, 2023 at 01:35:51PM +0200, Florent Revest wrote:
> > The ftrace samples need per-architecture trampoline implementations
> > to save and restore argument registers around the calls to
> > my_direct_func* and to restore polluted registers (eg: x30).
> >
> > These samples also include <asm/asm-offsets.h> which, on arm64, is not
> > necessary and redefines previously defined macros (resulting in
> > warnings) so these includes are guarded by !CONFIG_ARM64.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
>
> Overall this looks pretty good!
>
> I spotted a few bugs below while testing, and I've suggested some fixups =
below.
>
> w.r.t. the asm-offsets include guards. I took a look at fixing arm64's
> asm-offsets.c to not be problematic, but it requires some invasive refact=
oring,
> so I'd like to clean that up as a separate series. I don't think that sho=
uld
> block this series, and I think that the include guards are fine for now.

Sounds great! Thank you Mark :)

> > ---
> >  arch/arm64/Kconfig                          |  2 ++
> >  samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
> >  samples/ftrace/ftrace-direct-multi-modify.c | 38 +++++++++++++++++++++
> >  samples/ftrace/ftrace-direct-multi.c        | 23 +++++++++++++
> >  samples/ftrace/ftrace-direct-too.c          | 26 ++++++++++++++
> >  samples/ftrace/ftrace-direct.c              | 24 +++++++++++++
> >  6 files changed, 147 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index f3503d0cc1b8..c2bf28099abd 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -194,6 +194,8 @@ config ARM64
> >                   !CC_OPTIMIZE_FOR_SIZE)
> >       select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
> >               if DYNAMIC_FTRACE_WITH_ARGS
> > +     select HAVE_SAMPLE_FTRACE_DIRECT
> > +     select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> >       select HAVE_EFFICIENT_UNALIGNED_ACCESS
> >       select HAVE_FAST_GUP
> >       select HAVE_FTRACE_MCOUNT_RECORD
> > diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftr=
ace-direct-modify.c
> > index 25fba66f61c0..98d1b7385f08 100644
> > --- a/samples/ftrace/ftrace-direct-modify.c
> > +++ b/samples/ftrace/ftrace-direct-modify.c
> > @@ -2,7 +2,9 @@
> >  #include <linux/module.h>
> >  #include <linux/kthread.h>
> >  #include <linux/ftrace.h>
> > +#ifndef CONFIG_ARM64
> >  #include <asm/asm-offsets.h>
> > +#endif
> >
> >  extern void my_direct_func1(void);
> >  extern void my_direct_func2(void);
> > @@ -96,6 +98,38 @@ asm (
> >
> >  #endif /* CONFIG_S390 */
> >
> > +#ifdef CONFIG_ARM64
> > +
> > +asm (
> > +"    .pushsection    .text, \"ax\", @progbits\n"
> > +"    .type           my_tramp1, @function\n"
> > +"    .globl          my_tramp1\n"
> > +"   my_tramp1:"
> > +"    bti     c\n"
> > +"    sub     sp, sp, #16\n"
> > +"    stp     x9, x30, [sp]\n"
> > +"    bl      my_direct_func1\n"
> > +"    ldp     x30, x9, [sp]\n"
> > +"    add     sp, sp, #16\n"
> > +"    ret     x9\n"
> > +"    .size           my_tramp1, .-my_tramp1\n"
> > +
> > +"    .type           my_tramp2, @function\n"
> > +"    .globl          my_tramp2\n"
> > +"   my_tramp2:"
> > +"    bti     c\n"
> > +"    sub     sp, sp, #16\n"
> > +"    stp     x9, x30, [sp]\n"
> > +"    bl      my_direct_func2\n"
> > +"    ldp     x30, x9, [sp]\n"
> > +"    add     sp, sp, #16\n"
> > +"    ret     x9\n"
> > +"    .size           my_tramp2, .-my_tramp2\n"
> > +"    .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_ARM64 */
>
> These looks functionally correct, given they'll only be attached to sched=
ule()
> and the direct funcs take no arguments, so there's no arguments to save/r=
estore
> and nothing to shuffle.
>
> As an aside, I believe we'll need to rework the sequences when we add sup=
port
> for RELIABLE_STACKTRACE so that the unwinder can reliably acquire the add=
ress
> of the instrumented function and its caller, but I think for now it's
> preferable to keep this simple and I'm happy to make that a problem for f=
uture
> me.

Ah, interesting. I'd be happy to help when that time comes! :)

> > diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftra=
ce/ftrace-direct-multi-modify.c
> > index f72623899602..e39108eb085d 100644
> > --- a/samples/ftrace/ftrace-direct-multi-modify.c
> > +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> > @@ -2,7 +2,9 @@
> >  #include <linux/module.h>
> >  #include <linux/kthread.h>
> >  #include <linux/ftrace.h>
> > +#ifndef CONFIG_ARM64
> >  #include <asm/asm-offsets.h>
> > +#endif
> >
> >  extern void my_direct_func1(unsigned long ip);
> >  extern void my_direct_func2(unsigned long ip);
> > @@ -103,6 +105,42 @@ asm (
> >
> >  #endif /* CONFIG_S390 */
> >
> > +#ifdef CONFIG_ARM64
> > +
> > +asm (
> > +"    .pushsection    .text, \"ax\", @progbits\n"
> > +"    .type           my_tramp1, @function\n"
> > +"    .globl          my_tramp1\n"
> > +"   my_tramp1:"
> > +"    bti     c\n"
> > +"    sub     sp, sp, #32\n"
> > +"    stp     x9, x30, [sp]\n"
> > +"    str     x0, [sp, #16]\n"
> > +"    bl      my_direct_func1\n"
> > +"    ldp     x30, x9, [sp]\n"
> > +"    ldr     x0, [sp, #16]\n"
> > +"    add     sp, sp, #32\n"
> > +"    ret     x9\n"
> > +"    .size           my_tramp1, .-my_tramp1\n"
> > +
> > +"    .type           my_tramp2, @function\n"
> > +"    .globl          my_tramp2\n"
> > +"   my_tramp2:"
> > +"    bti     c\n"
> > +"    sub     sp, sp, #32\n"
> > +"    stp     x9, x30, [sp]\n"
> > +"    str     x0, [sp, #16]\n"
> > +"    bl      my_direct_func2\n"
> > +"    ldp     x30, x9, [sp]\n"
> > +"    ldr     x0, [sp, #16]\n"
> > +"    add     sp, sp, #32\n"
> > +"    ret     x9\n"
> > +"    .size           my_tramp2, .-my_tramp2\n"
> > +"    .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_ARM64 */
>
> For both of these trampolines we need to pass the trampoline's return add=
ress
> (i.e. where we'll return to in the instrumented function) as the 'ip' arg=
ument
> to my_direct_func{1,2}().
>
> In both cases, just before the 'bl my_direct_func{1,2}' we'll need to add=
:
>
>         mov     x0, x30

Oopsie, yes! Very good catch!

> > diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftra=
ce-direct-multi.c
> > index 1547c2c6be02..5a395d2d2e07 100644
> > --- a/samples/ftrace/ftrace-direct-multi.c
> > +++ b/samples/ftrace/ftrace-direct-multi.c
> > @@ -4,7 +4,9 @@
> >  #include <linux/mm.h> /* for handle_mm_fault() */
> >  #include <linux/ftrace.h>
> >  #include <linux/sched/stat.h>
> > +#ifndef CONFIG_ARM64
> >  #include <asm/asm-offsets.h>
> > +#endif
> >
> >  extern void my_direct_func(unsigned long ip);
> >
> > @@ -66,6 +68,27 @@ asm (
> >
> >  #endif /* CONFIG_S390 */
> >
> > +#ifdef CONFIG_ARM64
> > +
> > +asm (
> > +"    .pushsection    .text, \"ax\", @progbits\n"
> > +"    .type           my_tramp, @function\n"
> > +"    .globl          my_tramp\n"
> > +"   my_tramp:"
> > +"    bti     c\n"
> > +"    sub     sp, sp, #32\n"
> > +"    stp     x9, x30, [sp]\n"
> > +"    str     x0, [sp, #16]\n"
> > +"    bl      my_direct_func\n"
> > +"    ldp     x30, x9, [sp]\n"
> > +"    ldr     x0, [sp, #16]\n"
> > +"    add     sp, sp, #32\n"
> > +"    ret     x9\n"
> > +"    .size           my_tramp, .-my_tramp\n"
> > +"    .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_ARM64 */
> >  static struct ftrace_ops direct;
>
> As with ftrace-direct-multi-modify.c, we need to pass the return address =
of the
> trampoline as the 'ip' argument to my_direct_func1(), so just before the =
'bl
> my_direct_func' we'll need to add:
>
>         mov     x0, x30

Will do :)

> > diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace=
-direct-too.c
> > index f28e7b99840f..6e93c45fea86 100644
> > --- a/samples/ftrace/ftrace-direct-too.c
> > +++ b/samples/ftrace/ftrace-direct-too.c
> > @@ -3,7 +3,9 @@
> >
> >  #include <linux/mm.h> /* for handle_mm_fault() */
> >  #include <linux/ftrace.h>
> > +#ifndef CONFIG_ARM64
> >  #include <asm/asm-offsets.h>
> > +#endif
> >
> >  extern void my_direct_func(struct vm_area_struct *vma,
> >                          unsigned long address, unsigned int flags);
>
> This gets attached to handle_mm_fault(), whose prototype is currently:
>
> vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long addr=
ess,
>                            unsigned int flags, struct pt_regs *regs)
>
> i.e. it has 4 arguments, in x0 to x3.
>
> > @@ -70,6 +72,30 @@ asm (
> >
> >  #endif /* CONFIG_S390 */
> >
> > +#ifdef CONFIG_ARM64
> > +
> > +asm (
> > +"    .pushsection    .text, \"ax\", @progbits\n"
> > +"    .type           my_tramp, @function\n"
> > +"    .globl          my_tramp\n"
> > +"   my_tramp:"
> > +"    bti     c\n"
> > +"    sub     sp, sp, #48\n"
> > +"    stp     x9, x30, [sp]\n"
> > +"    stp     x0, x1, [sp, #16]\n"
> > +"    str     x2, [sp, #32]\n"
> > +"    bl      my_direct_func\n"
> > +"    ldp     x30, x9, [sp]\n"
> > +"    ldp     x0, x1, [sp, #16]\n"
> > +"    ldr     x2, [sp, #32]\n"
>
> So here we need to save+restore x3 also.
>
> We already have the space reserved, so that should just be a matter of us=
ing
> stp/ldp for x2 and x3.

That's also a very good catch. It looks like it's an issue for the
sample trampoline on x86_64 as well, I'll fix it too in a separate
patch as part of v6. (if i understand s390 asm correctly, the stmg
already saves all arg registers in one instruction so s390 doesn't
need to change)

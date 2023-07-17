Return-Path: <bpf+bounces-5138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF088756CC6
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 21:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8842F2811CF
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC6C141;
	Mon, 17 Jul 2023 19:08:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B4253BE
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 19:08:18 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC0DA
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 12:08:16 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-51e526e0fe4so7417821a12.3
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689620895; x=1692212895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiISrPXrpmeIVoXi6hQgJhVqwvx4qybMc/poDuWUkeU=;
        b=b/JBePoTIcfh7k5c+MKgR7zhVH5JUtL8U6Y3eU4yMTmBlifgjtI0u0z/4fObxN67Xw
         4GWmdP8g782O4QrxqdDvZmV8DWqnE/8X0ZoQ4VXqk4WAmammaVxWKzzg1ToEA8oXD1C0
         SEBfS5XBvLpZT1x6ynoC1tvtKZlkenw3VWDFmLE4cenocYpyvx5qTM8c3W6BARkB+ZII
         jeS48u3lseYHZs8x6Q0cKJTL8qQr1+88nivbQyPKBONGkS0+MmHpWNBpk5o1LWUdzEtU
         9ahKCQf3VD88e6MGS4ed9GYWDIODsexDxFwvQB1ytNHQleSPgs+WSi1HpgcpOtn6x3qn
         XyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689620895; x=1692212895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiISrPXrpmeIVoXi6hQgJhVqwvx4qybMc/poDuWUkeU=;
        b=HulxK16qZoeq63qbPtredeT0Nf0KGfJUvo1sbN8c9meNeNKUzuucUK1BD4stN8mQvi
         1SQ/JcDbwlRQE58xmzsuABcf77RRwM9t0V+O+BKlKWAjKqwj8wuhtqu6JJ3wlYVQIxAf
         L0hkEZGs/YaIVY37B+Q3CNZiJH+cJdNNWuYQfJGLw/ObGF1Lorp1bxGaOnANUYgBXU5b
         35MlJjk8fBI6qubVY7mz1FKZEg0NiybtC7aA5fLAc+N0rzDOAJPb+QpdzkD+V59/3KT5
         GEL913hWflD6GQ8dFVr83Iq/B8F/8yyD9gWi3VppWGoQoXuO2y8+5Y9knI5NeDGS1TRE
         6kEg==
X-Gm-Message-State: ABy/qLYeNyGvAvvoWDmheTdCML/kGxfhq9j+RQg+Zsz3HJteCkepqByG
	95JnIo/+0UxghBUkBnpTDBaFwgRf6lqdke105D8=
X-Google-Smtp-Source: APBJJlHeDiRMRaUDA8jfNro3iEDF4iWRIg/fJCBHMTZJXXZiooWAQKW1Ny7eTJN2c/P+wh6nEO5oxU3c9J3x0ZfkIhc=
X-Received: by 2002:a05:6402:199:b0:51d:d5a1:a7f1 with SMTP id
 r25-20020a056402019900b0051dd5a1a7f1mr489694edv.38.1689620894506; Mon, 17 Jul
 2023 12:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-6-memxor@gmail.com>
 <20230714220522.r4w256kkjtqhdued@MacBook-Pro-8.local> <CAP01T76T32mfMmfYSMvVQqKNvtp1MjZQoTRfbi1=vs0VcT3LqQ@mail.gmail.com>
 <CAADnVQJyS=0iui+QyiZZnmjHi+p63314ypKBXPuUynuug2Wusg@mail.gmail.com>
In-Reply-To: <CAADnVQJyS=0iui+QyiZZnmjHi+p63314ypKBXPuUynuug2Wusg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 18 Jul 2023 00:37:34 +0530
Message-ID: <CAP01T775cp1N9qHd+TABbRJyKvJS5JHE9E8pkXNedn0znREu-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 05/10] arch/x86: Implement arch_bpf_stack_walk
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 17 Jul 2023 at 22:59, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 17, 2023 at 9:29=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, 15 Jul 2023 at 03:35, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jul 13, 2023 at 08:02:27AM +0530, Kumar Kartikeya Dwivedi wro=
te:
> > > > The plumbing for offline unwinding when we throw an exception in
> > > > programs would require walking the stack, hence introduce a new
> > > > arch_bpf_stack_walk function. This is provided when the JIT support=
s
> > > > exceptions, i.e. bpf_jit_supports_exceptions is true. The arch-spec=
ific
> > > > code is really minimal, hence it should straightforward to extend t=
his
> > > > support to other architectures as well, as it reuses the logic of
> > > > arch_stack_walk, but allowing access to unwind_state data.
> > > >
> > > > Once the stack pointer and frame pointer are known for the main sub=
prog
> > > > during the unwinding, we know the stack layout and location of any
> > > > callee-saved registers which must be restored before we return back=
 to
> > > > the kernel.
> > > >
> > > > This handling will be added in the next patch.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  arch/x86/net/bpf_jit_comp.c | 21 +++++++++++++++++++++
> > > >  include/linux/filter.h      |  2 ++
> > > >  kernel/bpf/core.c           |  9 +++++++++
> > > >  3 files changed, 32 insertions(+)
> > > >
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_com=
p.c
> > > > index 438adb695daa..d326503ce242 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include <asm/set_memory.h>
> > > >  #include <asm/nospec-branch.h>
> > > >  #include <asm/text-patching.h>
> > > > +#include <asm/unwind.h>
> > > >
> > > >  static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
> > > >  {
> > > > @@ -2660,3 +2661,23 @@ void bpf_jit_free(struct bpf_prog *prog)
> > > >
> > > >       bpf_prog_unlock_free(prog);
> > > >  }
> > > > +
> > > > +bool bpf_jit_supports_exceptions(void)
> > > > +{
> > > > +     return IS_ENABLED(CONFIG_UNWINDER_ORC) || IS_ENABLED(CONFIG_U=
NWINDER_FRAME_POINTER);
> > > > +}
> > > > +
> > > > +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, =
u64 sp, u64 bp), void *cookie)
> > > > +{
> > > > +#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_FRAME_=
POINTER)
> > > > +     struct unwind_state state;
> > > > +     unsigned long addr;
> > > > +
> > > > +     for (unwind_start(&state, current, NULL, NULL); !unwind_done(=
&state);
> > > > +          unwind_next_frame(&state)) {
> > > > +             addr =3D unwind_get_return_address(&state);
> > >
> > > I think these steps will work even with UNWINDER_GUESS.
> > > What is the reason for #ifdef ?
> >
> > I think we require both unwind_state::sp and unwind_state::bp, but
> > arch/x86/include/asm/unwind.h does not include unwind_state::bp when
> > both UNWINDER_ORC and UNWINDER_FRAME_POINTER are unset.
> >
> > Although it might be possible to calculate and save bp offset during
> > JIT in bpf_prog_aux (by adding roundup(stack_depth) + 8 (push rax if
> > tail call reachable) + callee_regs_saved) for the subprog
> > corresponding to a frame. Then we can make it work everywhere.
> > The JIT will abstract get_prog_bp(sp) using an arch specific helper.
> >
> > Let me know if I misunderstood something.
>
> JITed progs always have frames. So we're effectively doing
> unconditional UNWINDER_FRAME_POINTER.
> I think the intended usage of arch_bpf_stack_walk() is to only walk
> bpf frames _in this patch set_, if so the extra #ifdefs are misleading.
> If in follow-ups we're going to unwind through JITed progs _and_
> through kfunc/helpers then this ifdef will be necessary.
> I suspect we might want something like this in the future.

I think we actually do unwind through bpf_throw at the very least, so
we are going through both kernel and BPF frames.

> So the ifdef is ok to have from the start, but the comment is necessary
> to describe what it is for.

I'll add the comment in v2.


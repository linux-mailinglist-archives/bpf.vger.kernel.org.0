Return-Path: <bpf+bounces-5128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67451756A73
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2279E281063
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE85BBA24;
	Mon, 17 Jul 2023 17:29:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC601FD7
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 17:29:45 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF9AE52
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:29:19 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b946602d64so13073831fa.0
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689614957; x=1692206957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLxvy3XZ8xdhbFAKNIa59stD59bwZnKHEO1fg2NkH8U=;
        b=chbCGV42KY4fclH+qjqtpg7UbaEsWZMWJkmaQ8rgajoVT3Y610h/w2XeOfs/IzStZ3
         Mvi4xRUGdypASDBNsVg8vffDiJDmpFFCkEGPIDlMO0o6Z4eq4LaQ0jmpeyTVMQeUV6r9
         NF0nOAnKGkpeBx++XbOTHhrFBKJCKrlPvP8yjhRMsk23K/QLQ6y+lcNNmm9gd0LVttjf
         EHK5tAgl5pPL6VQ35VoFhcxGs3LFpOx0Y5CfxXiNNJrIM7HiZk7qsHNkq9VGRlB987Im
         AnUuQQVOa5OCqNIYOhk0NQPvtYoxWkJA+5FeNqajmX4fTMUQZKAuhs7FgXYOHqCUNeB5
         bqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614957; x=1692206957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLxvy3XZ8xdhbFAKNIa59stD59bwZnKHEO1fg2NkH8U=;
        b=h208TgFhY8vRXotU6Tlb5hUSJc5tvaBoKo5x7GfnFO7YQwU0VKIxUc4UJQ/lhYjvCG
         VBsZ/aagWf1NvOf1VwqmM3OmJV0UykSfnNFPSWsgSmj+qKlaVb8KP0qiv9JBXhu9s5se
         AaERwIFZmWtSJbnvqZlVoU06NUoclV2Tsx9UKtggVpGcCOdMf6v/PaciB4xSNX3IzXDQ
         3S2RYC4ktrBMOIoqr/GzIeqv+qB6uay2itEqYyJwVo8u787T3z0dOh18Atgp5U9TJElI
         z2DvROkajhL5lP0nTieMa2rHkwmJL1XSeaur/1xXwKs86vnM9z3f3dBp8OW8YLeijSY8
         H/pw==
X-Gm-Message-State: ABy/qLaujshEawoqZdaX55HQcYJmLgbKQMBp/eb25tRZg/ipkuUrNoaw
	kPCOC5i2def/TQuzC/Ry9reUhf6OGxCdSpsHT7s=
X-Google-Smtp-Source: APBJJlGYn99Yt/n5GPRZ4Ejq+N9A6Toz4FpKAMQpKz667JQmLGv+YhCZHhmG8YuXxmZcOSiRbAuIBK/wDPEdrx4DUJU=
X-Received: by 2002:a2e:b055:0:b0:2b6:cf6f:159e with SMTP id
 d21-20020a2eb055000000b002b6cf6f159emr8425624ljl.44.1689614956937; Mon, 17
 Jul 2023 10:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-6-memxor@gmail.com>
 <20230714220522.r4w256kkjtqhdued@MacBook-Pro-8.local> <CAP01T76T32mfMmfYSMvVQqKNvtp1MjZQoTRfbi1=vs0VcT3LqQ@mail.gmail.com>
In-Reply-To: <CAP01T76T32mfMmfYSMvVQqKNvtp1MjZQoTRfbi1=vs0VcT3LqQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Jul 2023 10:29:05 -0700
Message-ID: <CAADnVQJyS=0iui+QyiZZnmjHi+p63314ypKBXPuUynuug2Wusg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 05/10] arch/x86: Implement arch_bpf_stack_walk
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 9:29=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 15 Jul 2023 at 03:35, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jul 13, 2023 at 08:02:27AM +0530, Kumar Kartikeya Dwivedi wrote=
:
> > > The plumbing for offline unwinding when we throw an exception in
> > > programs would require walking the stack, hence introduce a new
> > > arch_bpf_stack_walk function. This is provided when the JIT supports
> > > exceptions, i.e. bpf_jit_supports_exceptions is true. The arch-specif=
ic
> > > code is really minimal, hence it should straightforward to extend thi=
s
> > > support to other architectures as well, as it reuses the logic of
> > > arch_stack_walk, but allowing access to unwind_state data.
> > >
> > > Once the stack pointer and frame pointer are known for the main subpr=
og
> > > during the unwinding, we know the stack layout and location of any
> > > callee-saved registers which must be restored before we return back t=
o
> > > the kernel.
> > >
> > > This handling will be added in the next patch.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 21 +++++++++++++++++++++
> > >  include/linux/filter.h      |  2 ++
> > >  kernel/bpf/core.c           |  9 +++++++++
> > >  3 files changed, 32 insertions(+)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.=
c
> > > index 438adb695daa..d326503ce242 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -16,6 +16,7 @@
> > >  #include <asm/set_memory.h>
> > >  #include <asm/nospec-branch.h>
> > >  #include <asm/text-patching.h>
> > > +#include <asm/unwind.h>
> > >
> > >  static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
> > >  {
> > > @@ -2660,3 +2661,23 @@ void bpf_jit_free(struct bpf_prog *prog)
> > >
> > >       bpf_prog_unlock_free(prog);
> > >  }
> > > +
> > > +bool bpf_jit_supports_exceptions(void)
> > > +{
> > > +     return IS_ENABLED(CONFIG_UNWINDER_ORC) || IS_ENABLED(CONFIG_UNW=
INDER_FRAME_POINTER);
> > > +}
> > > +
> > > +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u6=
4 sp, u64 bp), void *cookie)
> > > +{
> > > +#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_FRAME_PO=
INTER)
> > > +     struct unwind_state state;
> > > +     unsigned long addr;
> > > +
> > > +     for (unwind_start(&state, current, NULL, NULL); !unwind_done(&s=
tate);
> > > +          unwind_next_frame(&state)) {
> > > +             addr =3D unwind_get_return_address(&state);
> >
> > I think these steps will work even with UNWINDER_GUESS.
> > What is the reason for #ifdef ?
>
> I think we require both unwind_state::sp and unwind_state::bp, but
> arch/x86/include/asm/unwind.h does not include unwind_state::bp when
> both UNWINDER_ORC and UNWINDER_FRAME_POINTER are unset.
>
> Although it might be possible to calculate and save bp offset during
> JIT in bpf_prog_aux (by adding roundup(stack_depth) + 8 (push rax if
> tail call reachable) + callee_regs_saved) for the subprog
> corresponding to a frame. Then we can make it work everywhere.
> The JIT will abstract get_prog_bp(sp) using an arch specific helper.
>
> Let me know if I misunderstood something.

JITed progs always have frames. So we're effectively doing
unconditional UNWINDER_FRAME_POINTER.
I think the intended usage of arch_bpf_stack_walk() is to only walk
bpf frames _in this patch set_, if so the extra #ifdefs are misleading.
If in follow-ups we're going to unwind through JITed progs _and_
through kfunc/helpers then this ifdef will be necessary.
I suspect we might want something like this in the future.
So the ifdef is ok to have from the start, but the comment is necessary
to describe what it is for.


Return-Path: <bpf+bounces-5117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3479D756923
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DEB2811AB
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F90BE56;
	Mon, 17 Jul 2023 16:30:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6AAD46
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:30:02 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320DE170C
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:29:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-51e566b1774so6151570a12.1
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689611394; x=1692203394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dBuDQLYc/otGeZr/lPetFMOpPtdW108y+vIZ6ipemLo=;
        b=RqP3WK8SHOCYfeEk/xjOORpenyc1GghUuxT5FLM61vbnl/sIYSTNYLeYcilYdXKjqT
         qQ4pynZxQd5+FbUvdN/PhpjA5N6zuxz0JsxR6qIbfaqVaC0xSrDQDhUoBBdFTKEkqxXP
         6uppYqMsmWDjPvQV8N+d+rl1iE1jmb2YVo76WetJWmChaVEqYD3VXbLplLONLrGNerTh
         4W4LP/wqIgE6DR/xPc7ZwBYR0ElVwEb+oA3P+7tIq2W2FIvALnx0oAmLFPCoqftwEQjF
         KJyiahqujFYIbR5Av/XZ6oywHzJalKKSAiNkRi5+BKFog9Rvsr8uf/XkU3s9gnPmsahf
         woog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611394; x=1692203394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBuDQLYc/otGeZr/lPetFMOpPtdW108y+vIZ6ipemLo=;
        b=NlqCFqtUsKNFKia2XT5F5bI2c8OFaVREdktfEEAr2L5kOcFC4RR2Y+fV/92sHCiW0F
         ffEmU7gU0GRjRf6Gm5Kr29dXB57aCG+VXrrCidtZsx8nUAKlMix1pTmjiL/XfDzATMLW
         kDOWzbj8qbQbo70F/Wd4pyU+g6/G4TOlDdCnnseIGkd0/Fj3WJlfe/KQARQKmc/uIRPq
         WJIz9MieNMtzWu1Z3gwE3kzalF66fTBrWRE8l4673O8EOylqpTJ9wh6v3d0O+HB3Y1jb
         hv5CzZKLsb4lRHXs9ZNXxlEklW1CyfnWljIxuRrfUPVcq3Nb4m/KBLJ61SVkxjifVFrS
         vhuw==
X-Gm-Message-State: ABy/qLbEKyY2gPvS0WLuq85jo2Log0f0D/xuiqS379DVIdcDzPUSUOqc
	ekKG8Z5RAAaczqQuo35qbPdTYGyx0GnC06MeZog=
X-Google-Smtp-Source: APBJJlGaUfwAeD15e7NzxN6+qWVXYe2y+drZmzAfv3NYkZDg/eGjvtLv71EeygAYMz45pGY+dzeZ8mFUkpF+5wiFFms=
X-Received: by 2002:a05:6402:7c4:b0:51e:5cab:feb9 with SMTP id
 u4-20020a05640207c400b0051e5cabfeb9mr11486767edy.33.1689611393972; Mon, 17
 Jul 2023 09:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-6-memxor@gmail.com>
 <20230714220522.r4w256kkjtqhdued@MacBook-Pro-8.local>
In-Reply-To: <20230714220522.r4w256kkjtqhdued@MacBook-Pro-8.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 17 Jul 2023 21:59:13 +0530
Message-ID: <CAP01T76T32mfMmfYSMvVQqKNvtp1MjZQoTRfbi1=vs0VcT3LqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 05/10] arch/x86: Implement arch_bpf_stack_walk
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 15 Jul 2023 at 03:35, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 13, 2023 at 08:02:27AM +0530, Kumar Kartikeya Dwivedi wrote:
> > The plumbing for offline unwinding when we throw an exception in
> > programs would require walking the stack, hence introduce a new
> > arch_bpf_stack_walk function. This is provided when the JIT supports
> > exceptions, i.e. bpf_jit_supports_exceptions is true. The arch-specific
> > code is really minimal, hence it should straightforward to extend this
> > support to other architectures as well, as it reuses the logic of
> > arch_stack_walk, but allowing access to unwind_state data.
> >
> > Once the stack pointer and frame pointer are known for the main subprog
> > during the unwinding, we know the stack layout and location of any
> > callee-saved registers which must be restored before we return back to
> > the kernel.
> >
> > This handling will be added in the next patch.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 21 +++++++++++++++++++++
> >  include/linux/filter.h      |  2 ++
> >  kernel/bpf/core.c           |  9 +++++++++
> >  3 files changed, 32 insertions(+)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 438adb695daa..d326503ce242 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -16,6 +16,7 @@
> >  #include <asm/set_memory.h>
> >  #include <asm/nospec-branch.h>
> >  #include <asm/text-patching.h>
> > +#include <asm/unwind.h>
> >
> >  static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
> >  {
> > @@ -2660,3 +2661,23 @@ void bpf_jit_free(struct bpf_prog *prog)
> >
> >       bpf_prog_unlock_free(prog);
> >  }
> > +
> > +bool bpf_jit_supports_exceptions(void)
> > +{
> > +     return IS_ENABLED(CONFIG_UNWINDER_ORC) || IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER);
> > +}
> > +
> > +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
> > +{
> > +#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_FRAME_POINTER)
> > +     struct unwind_state state;
> > +     unsigned long addr;
> > +
> > +     for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
> > +          unwind_next_frame(&state)) {
> > +             addr = unwind_get_return_address(&state);
>
> I think these steps will work even with UNWINDER_GUESS.
> What is the reason for #ifdef ?

I think we require both unwind_state::sp and unwind_state::bp, but
arch/x86/include/asm/unwind.h does not include unwind_state::bp when
both UNWINDER_ORC and UNWINDER_FRAME_POINTER are unset.

Although it might be possible to calculate and save bp offset during
JIT in bpf_prog_aux (by adding roundup(stack_depth) + 8 (push rax if
tail call reachable) + callee_regs_saved) for the subprog
corresponding to a frame. Then we can make it work everywhere.
The JIT will abstract get_prog_bp(sp) using an arch specific helper.

Let me know if I misunderstood something.

>
> > +             if (!addr || !consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp))
> > +                     break;
> > +     }
> > +#endif
> > +}
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index f69114083ec7..21ac801330bb 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -920,6 +920,8 @@ bool bpf_jit_needs_zext(void);
> >  bool bpf_jit_supports_subprog_tailcalls(void);
> >  bool bpf_jit_supports_kfunc_call(void);
> >  bool bpf_jit_supports_far_kfunc_call(void);
> > +bool bpf_jit_supports_exceptions(void);
> > +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
> >  bool bpf_helper_changes_pkt_data(void *func);
> >
> >  static inline bool bpf_dump_raw_ok(const struct cred *cred)
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 5c484b2bc3d6..5e224cf0ec27 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2770,6 +2770,15 @@ int __weak bpf_arch_text_invalidate(void *dst, size_t len)
> >       return -ENOTSUPP;
> >  }
> >
> > +bool __weak bpf_jit_supports_exceptions(void)
> > +{
> > +     return false;
> > +}
> > +
> > +void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
> > +{
> > +}
> > +
> >  #ifdef CONFIG_BPF_SYSCALL
> >  static int __init bpf_global_ma_init(void)
> >  {
> > --
> > 2.40.1
> >


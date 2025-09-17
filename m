Return-Path: <bpf+bounces-68619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D708B7D15C
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4384E1B9C
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 04:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB522F6591;
	Wed, 17 Sep 2025 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnIrSTwa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685C19049B
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081708; cv=none; b=VFZA/7Lb6LaRpmg6XNVfQ4FuvnJb6ZpNr8pAydzfuCFz0nRp+m8NCaLthBWVwUQM9XUx1TLvzPHxCsntklWMB5fFABf7/pORTeOPJbs/TD2iJtwKBnFgK1s/K3Zl+X5tUuPLK10TRc+70awVR0esNlFhFI1QCbN5QWDIa4FL2Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081708; c=relaxed/simple;
	bh=vtLJcE0FhxSNXHEK+Mv3+RpmesFRSMgjvWGmfmQ8X9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efkbaJfVa8ZGjrveLst+cHbwY7uLcpw3YCxWHJHfHO6djDHna6LD26oJG9nPkvCM0+qF8sG0KwyBZETfXToeg8T6mSpDaKx6tfZCqGYl0s3KWdzqNi0fetig/BVRD6LGppi2ntazv0H38CK8CT02Q0MPbjd5HOdf7ba3YwT35Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnIrSTwa; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d603acc23so43889147b3.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 21:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758081706; x=1758686506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jAjjxYeEfJ5UKR89LLGebjU6tcoHpPYET+1mhJaGZuo=;
        b=QnIrSTwaWr1Y5VcRFBi7oC0gFul8SqByCOkJD2BZ9MF13JKcG0lE+Ahc4wllQsvvzL
         gnzKtrDuNVfMrXieDOvdxIC32g7cSuSF9cIoQ4AGAphoNVDz8ZgPuChJ6hi0+3fwlFnT
         jUT3ECMEAaHNPLMqhEW5o+QrSNK9lxCEGTlRJDbBxTd+OIAgJpXgmsXUCfixoHD4A/kE
         5+7UvBI3gtxaZ5xgF/ScEIlTlVrVqoGhBPedLue6n8qHT8MQY6WBPU4E9KrNiSu3uRbh
         6C87HVio/fIcDPDM8NKaax9pCBhJLVRojS5Xat4VGK++iINwu/urPOUyGtESItP4updp
         VDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758081706; x=1758686506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAjjxYeEfJ5UKR89LLGebjU6tcoHpPYET+1mhJaGZuo=;
        b=WkmvGdmQsSRodOxc2DhmODOq/QiF9ix1A2Z3UL1NvQ14VunXHJgTqyBntvJ4PwSHSu
         0f84av8FONifhLPiZzVtE8mmqw7SKeWISn8rd9FyZu/pY0Id3cApEAhYtn0UbczwHDcX
         AJEHntwtBDMs4s7zUOASVXBCNmkT3Dw62u3jpJkiXO4NrhiqBnuRar5mqOFmYqhLlEQp
         Q/vXzKXEHRoLe+NjjL1EgVFuEDWqfaVsXl9JPhL5Ni/HwkcJj4U/utENndM3Bi0slNyP
         o3nt5/gZntH6NkK1KLpIgZOHs74+LhZfD9WUKVt5tyyUM9/qAeN+3nUVAvsk3Af5bFKC
         PWqg==
X-Gm-Message-State: AOJu0YzbcBqyUFOcIcpdZewueOrnFESnU3ytMgOVRXq+SpSdwTK23lvJ
	bhVXOjt4ptfqPlTWY27/tLABuJ3cuvwlk8GqJ0+HiLCVCeLFUAZKysCfLX/8jw1YQ1jWTCyX7xF
	HYoNXqdjE/V7JrDcVgs4wlWTCPHGw4sOLs5ORnJ4=
X-Gm-Gg: ASbGnctBECCvfVbBjegi56sDvb81C7r306auAS0vKFTdZLWapa8GddJMVtgCzPu7f3U
	LNj2t2ZgndVlGTleVkwjJ0b8kWRLaIzVXRi6ayPWI6U3e9Z7hgtPiPv2vV51vy09RJy8+loh+xG
	aNECfZfc55L1GE+3y2q5Rp4nrBV8ZaSZW+VpYMRm8A8CRC/Px+cS+Ywim3w2Y7jESM/KqdmImdj
	oFfY6sU2dPWd+0ZHBcaHqk76BejWMrhX+fHivBz
X-Google-Smtp-Source: AGHT+IFbZnCiOhRjqTv/xDY0q3pz3LHt9tjR2Qazl2ZD0+jl2wGrQsLCz9FgC0NRnjnBdSFAeuVXJddc1CZuJxCnhJ8=
X-Received: by 2002:a05:690c:64ca:b0:726:4b7a:1ec1 with SMTP id
 00721157ae682-73893249140mr5558437b3.47.1758081705866; Tue, 16 Sep 2025
 21:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907230415.289327-1-sidchintamaneni@gmail.com>
 <20250907230415.289327-4-sidchintamaneni@gmail.com> <CAP01T77Ji_5LzakSM_5LdW1cXYw9uCOH9o+hUSz+cO1q_aDS=A@mail.gmail.com>
In-Reply-To: <CAP01T77Ji_5LzakSM_5LdW1cXYw9uCOH9o+hUSz+cO1q_aDS=A@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 16 Sep 2025 21:01:33 -0700
X-Gm-Features: AS18NWCoCyOwWcmYGGdinwQyZhw4wFhOzdPDX20sQYR2HByGrrLOYgn2FcZKo1k
Message-ID: <CAE5sdEg54r5QgFrzqMEPDghp=kBvZO4qnbk_Bohe-YcOmTUDmQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] bpf: runtime part of fast-path termination approach
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, 
	miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, 
	quanzhif@vt.edu, jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com, 
	rjsu26@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 19:11, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Mon, 8 Sept 2025 at 01:04, Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > Update softlock detection logic to detect any stalls due to
> > BPF programs. When softlockup is detected, bpf_die will be
> > added to a workqueue on a CPU. With this implementation termination
> > handler will only get triggered when CONFIG_SOFTLOCKUP_DETECTOR is
> > enabled.
> >
>
> This is probably good for demonstration, but I'm not sure
> piggy-backing off of optional softlockup detection is a good idea.
> In any case, let's focus on the mechanism for now.
>
> > Inside bpf_die, we perform the text_poke to stub helpers/kfuncs.
> > The current implementation handles termination of long running
> > bpf_loop iterators both inlining and non-inlining case.
> >
> > The limitation of this implementation is that the termination handler
> > atleast need a single CPU to run.
>
> Yeah, as discussed in v2, there were other options without this
> limitation, i.e. take some overhead and check a terminate bit that
> doesn't rely on punting work off to a wq to ensure prog is killed.
>

The termination bit approach will work, if we were able to identify
predefined cancellation points in the helpers functions
implementation. The current termination handler implementation can be
easily ported there. We are also thinking of a termination case where
if BPF programs has to run under strict execution time constraints
which might not involve any long running iterators but still execution
of multiple helpers can accrue the cost. In those cases, the workqueue
approach could work. We will extend the current implementation to the
termination bit approach in the next iteration.

> >
> > Signed-off-by: Raj Sahu <rjsu26@gmail.com>
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 132 ++++++++++++++++++++++++++++++++++++
> >  include/linux/bpf.h         |   2 +
> >  include/linux/filter.h      |   6 ++
> >  kernel/bpf/core.c           |  35 +++++++++-
> >  kernel/watchdog.c           |   8 +++
> >  5 files changed, 182 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 107a44729675..4de9a8cdc465 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2606,6 +2606,10 @@ st:                      if (is_imm8(insn->off))
> >                                 if (arena_vm_start)
> >                                         pop_r12(&prog);
> >                         }
> > +                       /* emiting 5 byte nop for non-inline bpf_loop callback */
>
> typo: emitting
>
> > +                       if (bpf_is_subprog(bpf_prog) && bpf_prog->aux->is_bpf_loop_cb_non_inline) {
> > +                               emit_nops(&prog, X86_PATCH_SIZE);
> > +                       }
>
> But this is not the only source of potential stalls, right? E.g. bpf
> iterators can stall (if nested), cond_break, etc.
>

We've just implemented it to work for bpf_loop and honestly didn't
look into other iterators thinking that it should be straight forward.
In the next iteration, we will extend it to the other potential
stalls.

> >                         EMIT1(0xC9);         /* leave */
> >                         emit_return(&prog, image + addrs[i - 1] + (prog - temp));
> >                         break;
> > @@ -3833,6 +3837,8 @@ bool bpf_jit_supports_private_stack(void)
> >         return true;
> >  }
> >
> > +
> > +
> >  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
> >  {
> >  #if defined(CONFIG_UNWINDER_ORC)
> > @@ -3849,6 +3855,132 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
> >  #endif
> >  }
> >
> > +void in_place_patch_bpf_prog(struct bpf_prog *prog)
> > +{
> > +       struct call_aux_states *call_states;
> > +       unsigned long new_target;
> > +       unsigned char *addr;
> > +       u8 ret_jmp_size = 1;
> > +       if (cpu_wants_rethunk()) {
> > +               ret_jmp_size = 5;
> > +       }
> > +       call_states = prog->term_states->patch_call_sites->call_states;
> > +       for (int i = 0; i < prog->term_states->patch_call_sites->call_sites_cnt; i++) {
> > +
> > +               new_target = (unsigned long) bpf_termination_null_func;
> > +               if (call_states[i].is_bpf_loop_cb_inline) {
> > +                       new_target = (unsigned long) bpf_loop_term_callback;
> > +               }
> > +               char new_insn[5];
> > +
> > +               addr = (unsigned char *)prog->bpf_func + call_states->jit_call_idx;
> > +
> > +               unsigned long new_rel = (unsigned long)(new_target - (unsigned long)(addr + 5));
> > +               new_insn[0] = 0xE8;
> > +               new_insn[1] = (new_rel >> 0) & 0xFF;
> > +               new_insn[2] = (new_rel >> 8) & 0xFF;
> > +               new_insn[3] = (new_rel >> 16) & 0xFF;
> > +               new_insn[4] = (new_rel >> 24) & 0xFF;
> > +
> > +               smp_text_poke_batch_add(addr, new_insn, 5 /* call instruction len */, NULL);
> > +       }
> > +
> > +       if (prog->aux->is_bpf_loop_cb_non_inline) {
> > +
> > +               char new_insn[5] = { 0xB8, 0x01, 0x00, 0x00, 0x00 };
> > +               char old_insn[5] = { 0x0F, 0x1F, 0x44, 0x00, 0x00 };
> > +               smp_text_poke_batch_add(prog->bpf_func + prog->jited_len -
> > +                               (1 + ret_jmp_size) /* leave, jmp/ ret */ - 5 /* nop size */, new_insn, 5 /* mov eax, 1 */, old_insn);
> > +       }
> > +
> > +
> > +       /* flush all text poke calls */
> > +       smp_text_poke_batch_finish();
> > +}
> > +
> > +void bpf_die(struct bpf_prog *prog)
> > +{
> > +       u8 ret_jmp_size = 1;
> > +       if (cpu_wants_rethunk()) {
> > +               ret_jmp_size = 5;
> > +       }
> > +
> > +       /*
> > +        * Replacing 5 byte nop in prologue with jmp instruction to ret
> > +        */
> > +       unsigned long jmp_offset = prog->jited_len - (4 /* First endbr is 4 bytes */
> > +                                       + 5 /* noop is 5 bytes */
> > +                                       + ret_jmp_size /* 5 bytes of jmp return_thunk or 1 byte ret*/);
> > +
> > +       char new_insn[5];
> > +       new_insn[0] = 0xE9;
> > +       new_insn[1] = (jmp_offset >> 0) & 0xFF;
> > +       new_insn[2] = (jmp_offset >> 8) & 0xFF;
> > +       new_insn[3] = (jmp_offset >> 16) & 0xFF;
> > +       new_insn[4] = (jmp_offset >> 24) & 0xFF;
> > +
> > +       smp_text_poke_batch_add(prog->bpf_func + 4, new_insn, 5, NULL);
> > +
> > +       if (prog->aux->func_cnt) {
> > +               for (int i = 0; i < prog->aux->func_cnt; i++) {
> > +                       in_place_patch_bpf_prog(prog->aux->func[i]);
> > +               }
> > +       } else {
> > +               in_place_patch_bpf_prog(prog);
> > +       }
> > +
>
> Are you relying on batch finish() inside in_place_patch_bpf_prog()?

Yes

> > +}
> > +
> > +void bpf_prog_termination_deferred(struct work_struct *work)
> > +{
> > +       struct bpf_term_aux_states *term_states = container_of(work, struct bpf_term_aux_states,
> > +                                                work);
> > +       struct bpf_prog *prog = term_states->prog;
> > +
> > +       bpf_die(prog);
> > +}
> > +
> > +static struct workqueue_struct *bpf_termination_wq;
> > +
> > +void bpf_softlockup(u32 dur_s)
> > +{
> > +       unsigned long addr;
> > +       struct unwind_state state;
> > +       struct bpf_prog *prog;
> > +
> > +       for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
> > +            unwind_next_frame(&state)) {
>
> Why not use arch_bpf_stack_walk?

we will reuse it, kinda overlooked it. Also we have a question, is
trampoline text supposed to be identified as is_bpf_text_address?

>
> > +               addr = unwind_get_return_address(&state);
> > +               if (!addr)
> > +                       break;
> > +
> > +               if (!is_bpf_text_address(addr))
> > +                       continue;
> > +
> > +               rcu_read_lock();
> > +               prog = bpf_prog_ksym_find(addr);
> > +               rcu_read_unlock();
> > +               if (bpf_is_subprog(prog))
> > +                       continue;
> > +
> > +               if (atomic_cmpxchg(&prog->term_states->bpf_die_in_progress, 0, 1))
> > +                       break;
> > +
> > +               bpf_termination_wq = alloc_workqueue("bpf_termination_wq", WQ_UNBOUND, 1);
>
> Err, even if you have to, I'd rather go with system_unbound_wq for
> now. We have bpf_wq, and should probably have a dedicated bpf wq for
> all wq executions coming from the BPF subsystem, but that's a
> discussion for later.
>
>

Will look into this.

<SNIP>


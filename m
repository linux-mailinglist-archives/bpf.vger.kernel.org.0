Return-Path: <bpf+bounces-5119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985AF75696E
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1F72811F0
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542521855;
	Mon, 17 Jul 2023 16:44:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C110E7
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:44:45 +0000 (UTC)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7627A10CA
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:44:42 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-4fb41682472so7557385e87.2
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689612281; x=1692204281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+EVr2OTQzDI1HiIMgQ7g8nFUr8NA94Pk+CVVB0ZBpw=;
        b=lnUc/4b48VKaGYgLo3RtdaocP85L2AKUDU7FYaIU6bUQavtAoeY2+Lq3DDSG3gQVLo
         OTFoElXtTwpUkYJ/UdnKTygOWZUzlpR2k9tvaSJFZpZcEueA+ESa33pkD8sS3UikVAXr
         53pnI+IjUAVsrKgXT2ubEcf58uYDxVlhH+9yI2C6B4rvycvj3gsg3BNnb6oYUE99+Kph
         bycgtgCvhh8qP5pfWGG+d1PZoDpgKvU64b6Tb8rXSsuzCQPjdyNemRDEXI/a3fHbFnWm
         NPLWj3DVRln1oBKDwScF0XYLs+6/PjubjiYJRfIUh2fA35otKhxgnstP1c4/szcV03HF
         345w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612281; x=1692204281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+EVr2OTQzDI1HiIMgQ7g8nFUr8NA94Pk+CVVB0ZBpw=;
        b=aACbbEgh7htBldipzL5Aq8Lt/X6S03XY4Vi3uhZnosaTbdDpiROyhECKFBGlpJh0h2
         8M24I+e1/dc031aeeRAbyp/AU+bYATnBrrLRx6BHsF0L188VS3ojwWUQcgxKekxjLjRN
         VH0lyBmPy7f+EebiURiG5GE/OimGXJ5PrkeL7eqickX4AX9zMDrNUQuCJninOGtFO0R5
         Y016RXyI4YWWUBneoxwKgMs1vSm3bQxKDuuVfCN2wDQSUhnRYT6bq+9j3JOZt5+aSBNR
         yylghO6UJvdtF1v4nWc9wfuQurLwPoJQBcVFt0h6M1xWCU/EdybiUXHJE04BqFeomCim
         d2BQ==
X-Gm-Message-State: ABy/qLYme9sxEfYXa2tnaplDDuf80qlTB0GrXCMtkLCypGvlNhIV3rRe
	+cQOh6ZC13VgjvCceLzGZuRERZYsK8Y5tf17mxwAt+Lhffw=
X-Google-Smtp-Source: APBJJlGxGu+wAAxvE9TUyN5slRyjsT+/Z1R2rq/oc5t18J0+P8ytfPSAhGMVmz+LgDAGzsWC49H8Vf0kw7XjlAFDerU=
X-Received: by 2002:a19:6d0b:0:b0:4f8:5940:5c6a with SMTP id
 i11-20020a196d0b000000b004f859405c6amr10872739lfc.31.1689612280180; Mon, 17
 Jul 2023 09:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-7-memxor@gmail.com>
 <20230714223409.lfro5autichrkvvu@MacBook-Pro-8.local>
In-Reply-To: <20230714223409.lfro5autichrkvvu@MacBook-Pro-8.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 17 Jul 2023 22:13:59 +0530
Message-ID: <CAP01T76JRcOxdiU50C33Dnw+eApDOAg=mHQn9kUX7Qg_sHM7uQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/10] bpf: Implement bpf_throw kfunc
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

On Sat, 15 Jul 2023 at 04:04, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 13, 2023 at 08:02:28AM +0530, Kumar Kartikeya Dwivedi wrote:
> > This patch implements BPF exceptions, and introduces a bpf_throw kfunc
> > to allow programs to throw exceptions during their execution at runtime.
> > A bpf_throw invocation is treated as an immediate termination of the
> > program, returning back to its caller within the kernel, unwinding all
> > stack frames.
> >
> > This allows the program to simplify its implementation, by testing for
> > runtime conditions which the verifier has no visibility into, and assert
> > that they are true. In case they are not, the program can simply throw
> > an exception from the other branch.
> >
> > BPF exceptions are explicitly *NOT* an unlikely slowpath error handling
> > primitive, and this objective has guided design choices of the
> > implementation of the them within the kernel (with the bulk of the cost
> > for unwinding the stack offloaded to the bpf_throw kfunc).
> >
> > The implementation of this mechanism requires use of the invent_subprog
>
> Let's come up with a different name than 'invent_subprog'.
> How about 'add_hidden_subprog' ?
>

Sounds good, I will make the change.

> > mechanism introduced in the previous patch, which generates a couple of
> > instructions to zero R0 and exit. The JIT then rewrites the prologue of
> > this subprog to take the stack pointer and frame pointer as inputs and
> > reset the stack frame, popping all callee-saved registers saved by the
> > main subprog. The bpf_throw function then walks the stack at runtime,
> > and invokes this exception subprog with the stack and frame pointers as
> > parameters.
> >
> > Reviewers must take note that currently the main program is made to save
> > all callee-saved registers on x86_64 during entry into the program. This
> > is because we must do an equivalent of a lightweight context switch when
> > unwinding the stack, therefore we need the callee-saved registers of the
> > caller of the BPF program to be able to return with a sane state.
> >
> > Note that we have to additionally handle r12, even though it is not used
> > by the program, because when throwing the exception the program makes an
> > entry into the kernel which could clobber r12 after saving it on the
> > stack. To be able to preserve the value we received on program entry, we
> > push r12 and restore it from the generated subprogram when unwinding the
> > stack.
> >
> > All of this can however be addressed by recording which callee-saved
> > registers are saved for each program, and then restore them from the
> > corresponding stack frames (mapped to each program) when unwinding. This
> > would not require pushing all callee-saved registers on entry into a BPF
> > program. However, this optimization is deferred for a future patch to
> > manage the number of moving pieces within this set.
>
> Let's keep it permanent. Not worth to optimize further.
> bpf progs are getting bigger and they use all 4 regs more often than not.
>

Ack.

> > For now, bpf_throw invocation fails when lingering resources or locks
> > exist in that path of the program. In a future followup, bpf_throw will
> > be extended to perform frame-by-frame unwinding to release lingering
> > resources for each stack frame, removing this limitation.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c                   |  73 +++++++----
> >  include/linux/bpf.h                           |   3 +
> >  include/linux/bpf_verifier.h                  |   4 +
> >  include/linux/filter.h                        |   6 +
> >  kernel/bpf/core.c                             |   2 +-
> >  kernel/bpf/helpers.c                          |  38 ++++++
> >  kernel/bpf/verifier.c                         | 124 ++++++++++++++++--
> >  .../testing/selftests/bpf/bpf_experimental.h  |   6 +
> >  8 files changed, 219 insertions(+), 37 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index d326503ce242..8d97c6a60f9a 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -256,32 +256,36 @@ struct jit_context {
> >  /* Number of bytes that will be skipped on tailcall */
> >  #define X86_TAIL_CALL_OFFSET (11 + ENDBR_INSN_SIZE)
> >
> > -static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
> > +static void push_callee_regs(u8 **pprog, bool *callee_regs_used, bool force)
> >  {
> >       u8 *prog = *pprog;
> >
> > -     if (callee_regs_used[0])
> > +     if (callee_regs_used[0] || force)
> >               EMIT1(0x53);         /* push rbx */
> > -     if (callee_regs_used[1])
> > +     if (force)
> > +             EMIT2(0x41, 0x54);   /* push r12 */
>
> let's make r12 push/pop explicit. In addition to push_callee_regs.
>

Ack (I'm understanding you mean adding a push/pop_r12 and using that).

> > +     if (callee_regs_used[1] || force)
> >               EMIT2(0x41, 0x55);   /* push r13 */
> > -     if (callee_regs_used[2])
> > +     if (callee_regs_used[2] || force)
> >               EMIT2(0x41, 0x56);   /* push r14 */
> > -     if (callee_regs_used[3])
> > +     if (callee_regs_used[3] || force)
> >               EMIT2(0x41, 0x57);   /* push r15 */
>
> Instead of passing extra bool through the call chain how about doing:
>
> if (bpf_prog->aux->seen_exception)
>     memset(callee_regs_used, 1, sizeof(..));
> else
>     detect_reg_usage()
>

Looks good, I will change it.

> >       *pprog = prog;
> >  }
> >
> > -static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
> > +static void pop_callee_regs(u8 **pprog, bool *callee_regs_used, bool force)
> >  {
> >       u8 *prog = *pprog;
> >
> > -     if (callee_regs_used[3])
> > +     if (callee_regs_used[3] || force)
> >               EMIT2(0x41, 0x5F);   /* pop r15 */
> > -     if (callee_regs_used[2])
> > +     if (callee_regs_used[2] || force)
> >               EMIT2(0x41, 0x5E);   /* pop r14 */
> > -     if (callee_regs_used[1])
> > +     if (callee_regs_used[1] || force)
> >               EMIT2(0x41, 0x5D);   /* pop r13 */
> > -     if (callee_regs_used[0])
> > +     if (force)
> > +             EMIT2(0x41, 0x5C);   /* pop r12 */
> > +     if (callee_regs_used[0] || force)
> >               EMIT1(0x5B);         /* pop rbx */
> >       *pprog = prog;
> >  }
> > @@ -292,7 +296,8 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
> >   * while jumping to another program
> >   */
> >  static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
> > -                       bool tail_call_reachable, bool is_subprog)
> > +                       bool tail_call_reachable, bool is_subprog,
> > +                       bool is_exception_cb)
> >  {
> >       u8 *prog = *pprog;
> >
> > @@ -308,8 +313,23 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
> >               else
> >                       EMIT2(0x66, 0x90); /* nop2 */
> >       }
> > -     EMIT1(0x55);             /* push rbp */
> > -     EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
> > +     /* Exception callback receives FP as second parameter */
> > +     if (is_exception_cb) {
> > +             bool regs_used[4] = {};
> > +
> > +             EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
> > +             EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */
> > +             /* The main frame must have seen_exception as true, so we first
> > +              * restore those callee-saved regs from stack, before reusing
> > +              * the stack frame.
> > +              */
> > +             pop_callee_regs(&prog, regs_used, true);
> > +             /* Reset the stack frame. */
> > +             EMIT3(0x48, 0x89, 0xEC); /* mov rsp, rbp */
> > +     } else {
> > +             EMIT1(0x55);             /* push rbp */
> > +             EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
> > +     }
> >
> >       /* X86_TAIL_CALL_OFFSET is here */
> >       EMIT_ENDBR();
> > @@ -468,10 +488,12 @@ static void emit_return(u8 **pprog, u8 *ip)
> >   *   goto *(prog->bpf_func + prologue_size);
> >   * out:
> >   */
> > -static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
> > +static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
> > +                                     u8 **pprog, bool *callee_regs_used,
> >                                       u32 stack_depth, u8 *ip,
> >                                       struct jit_context *ctx)
> >  {
> > +     bool force_pop_all = bpf_prog->aux->seen_exception;
> >       int tcc_off = -4 - round_up(stack_depth, 8);
> >       u8 *prog = *pprog, *start = *pprog;
> >       int offset;
> > @@ -518,7 +540,7 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
> >       offset = ctx->tail_call_indirect_label - (prog + 2 - start);
> >       EMIT2(X86_JE, offset);                    /* je out */
> >
> > -     pop_callee_regs(&prog, callee_regs_used);
> > +     pop_callee_regs(&prog, callee_regs_used, force_pop_all);
> >
> >       EMIT1(0x58);                              /* pop rax */
> >       if (stack_depth)
> > @@ -542,11 +564,13 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
> >       *pprog = prog;
> >  }
> >
> > -static void emit_bpf_tail_call_direct(struct bpf_jit_poke_descriptor *poke,
> > +static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
> > +                                   struct bpf_jit_poke_descriptor *poke,
> >                                     u8 **pprog, u8 *ip,
> >                                     bool *callee_regs_used, u32 stack_depth,
> >                                     struct jit_context *ctx)
> >  {
> > +     bool force_pop_all = bpf_prog->aux->seen_exception;
> >       int tcc_off = -4 - round_up(stack_depth, 8);
> >       u8 *prog = *pprog, *start = *pprog;
> >       int offset;
> > @@ -571,7 +595,7 @@ static void emit_bpf_tail_call_direct(struct bpf_jit_poke_descriptor *poke,
> >       emit_jump(&prog, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
> >                 poke->tailcall_bypass);
> >
> > -     pop_callee_regs(&prog, callee_regs_used);
> > +     pop_callee_regs(&prog, callee_regs_used, force_pop_all);
> >       EMIT1(0x58);                                  /* pop rax */
> >       if (stack_depth)
> >               EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
> > @@ -987,8 +1011,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
> >
> >       emit_prologue(&prog, bpf_prog->aux->stack_depth,
> >                     bpf_prog_was_classic(bpf_prog), tail_call_reachable,
> > -                   bpf_prog->aux->func_idx != 0);
> > -     push_callee_regs(&prog, callee_regs_used);
> > +                   bpf_prog->aux->func_idx != 0, bpf_prog->aux->exception_cb);
> > +     /* Exception callback will clobber callee regs for its own use, and
> > +      * restore the original callee regs from main prog's stack frame.
> > +      */
> > +     push_callee_regs(&prog, callee_regs_used, bpf_prog->aux->seen_exception);
> >
> >       ilen = prog - temp;
> >       if (rw_image)
> > @@ -1557,13 +1584,15 @@ st:                   if (is_imm8(insn->off))
> >
> >               case BPF_JMP | BPF_TAIL_CALL:
> >                       if (imm32)
> > -                             emit_bpf_tail_call_direct(&bpf_prog->aux->poke_tab[imm32 - 1],
> > +                             emit_bpf_tail_call_direct(bpf_prog,
> > +                                                       &bpf_prog->aux->poke_tab[imm32 - 1],
> >                                                         &prog, image + addrs[i - 1],
> >                                                         callee_regs_used,
> >                                                         bpf_prog->aux->stack_depth,
> >                                                         ctx);
> >                       else
> > -                             emit_bpf_tail_call_indirect(&prog,
> > +                             emit_bpf_tail_call_indirect(bpf_prog,
> > +                                                         &prog,
> >                                                           callee_regs_used,
> >                                                           bpf_prog->aux->stack_depth,
> >                                                           image + addrs[i - 1],
> > @@ -1808,7 +1837,7 @@ st:                     if (is_imm8(insn->off))
> >                       seen_exit = true;
> >                       /* Update cleanup_addr */
> >                       ctx->cleanup_addr = proglen;
> > -                     pop_callee_regs(&prog, callee_regs_used);
> > +                     pop_callee_regs(&prog, callee_regs_used, bpf_prog->aux->seen_exception);
> >                       EMIT1(0xC9);         /* leave */
> >                       emit_return(&prog, image + addrs[i - 1] + (prog - temp));
> >                       break;
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 70f212dddfbf..61cdb291311f 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1386,6 +1386,8 @@ struct bpf_prog_aux {
> >       bool tail_call_reachable;
> >       bool xdp_has_frags;
> >       bool invented_prog;
> > +     bool exception_cb;
> > +     bool seen_exception;
> >       /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
> >       const struct btf_type *attach_func_proto;
> >       /* function name for valid attach_btf_id */
> > @@ -1408,6 +1410,7 @@ struct bpf_prog_aux {
> >       int cgroup_atype; /* enum cgroup_bpf_attach_type */
> >       struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
> >       char name[BPF_OBJ_NAME_LEN];
> > +     unsigned int (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp);
> >  #ifdef CONFIG_SECURITY
> >       void *security;
> >  #endif
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 360aa304ec09..e28386fa462f 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -541,7 +541,9 @@ struct bpf_subprog_info {
> >       bool tail_call_reachable;
> >       bool has_ld_abs;
> >       bool invented_prog;
> > +     bool is_cb;
> >       bool is_async_cb;
> > +     bool is_exception_cb;
> >  };
> >
> >  struct bpf_verifier_env;
> > @@ -588,6 +590,7 @@ struct bpf_verifier_env {
> >       u32 used_map_cnt;               /* number of used maps */
> >       u32 used_btf_cnt;               /* number of used BTF objects */
> >       u32 id_gen;                     /* used to generate unique reg IDs */
> > +     int exception_callback_subprog;
> >       bool explore_alu_limits;
> >       bool allow_ptr_leaks;
> >       bool allow_uninit_stack;
> > @@ -596,6 +599,7 @@ struct bpf_verifier_env {
> >       bool bypass_spec_v4;
> >       bool seen_direct_write;
> >       bool invented_prog;
> > +     bool seen_exception;
> >       struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
> >       const struct bpf_line_info *prev_linfo;
> >       struct bpf_verifier_log log;
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index 21ac801330bb..f45a54f8dd7d 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1137,6 +1137,7 @@ const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
> >  bool is_bpf_text_address(unsigned long addr);
> >  int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> >                   char *sym);
> > +struct bpf_prog *bpf_prog_ksym_find(unsigned long addr);
> >
> >  static inline const char *
> >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > @@ -1204,6 +1205,11 @@ static inline int bpf_get_kallsym(unsigned int symnum, unsigned long *value,
> >       return -ERANGE;
> >  }
> >
> > +static inline struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
> > +{
> > +     return NULL;
> > +}
> > +
> >  static inline const char *
> >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> >                  unsigned long *off, char **modname, char *sym)
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 5e224cf0ec27..efbc2f965226 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -723,7 +723,7 @@ bool is_bpf_text_address(unsigned long addr)
> >       return ret;
> >  }
> >
> > -static struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
> > +struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
> >  {
> >       struct bpf_ksym *ksym = bpf_ksym_find(addr);
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 9e80efa59a5d..da1493a1da25 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2402,6 +2402,43 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
> >       rcu_read_unlock();
> >  }
> >
> > +struct bpf_throw_ctx {
> > +     struct bpf_prog_aux *aux;
> > +     u64 sp;
> > +     u64 bp;
> > +     int cnt;
> > +};
> > +
> > +static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
> > +{
> > +     struct bpf_throw_ctx *ctx = cookie;
> > +     struct bpf_prog *prog;
> > +
> > +     if (!is_bpf_text_address(ip))
> > +             return !ctx->cnt;
> > +     prog = bpf_prog_ksym_find(ip);
> > +     ctx->cnt++;
> > +     if (!prog->aux->id)
> > +             return true;
> > +     ctx->aux = prog->aux;
> > +     ctx->sp = sp;
> > +     ctx->bp = bp;
> > +     return false;
> > +}
> > +
> > +__bpf_kfunc void bpf_throw(u64 cookie)
> > +{
> > +     struct bpf_throw_ctx ctx = {};
> > +
> > +     arch_bpf_stack_walk(bpf_stack_walker, &ctx);
> > +     WARN_ON_ONCE(!ctx.aux);
> > +     if (ctx.aux)
> > +             WARN_ON_ONCE(!ctx.aux->seen_exception);
> > +     WARN_ON_ONCE(!ctx.bp);
> > +     WARN_ON_ONCE(!ctx.cnt);
> > +     ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
> > +}
> > +
> >  __diag_pop();
> >
> >  BTF_SET8_START(generic_btf_ids)
> > @@ -2429,6 +2466,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
> >  #endif
> >  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_throw)
> >  BTF_SET8_END(generic_btf_ids)
> >
> >  static const struct btf_kfunc_id_set generic_kfunc_set = {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8ce72a7b4758..61101a87d96b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -542,6 +542,8 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> >  }
> >
> >  static bool is_callback_calling_kfunc(u32 btf_id);
> > +static bool is_forbidden_exception_kfunc_in_cb(u32 btf_id);
> > +static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
> >
> >  static bool is_callback_calling_function(enum bpf_func_id func_id)
> >  {
> > @@ -2864,11 +2866,12 @@ static int check_subprogs(struct bpf_verifier_env *env)
> >               if (i == subprog_end - 1) {
> >                       /* to avoid fall-through from one subprog into another
> >                        * the last insn of the subprog should be either exit
> > -                      * or unconditional jump back
> > +                      * or unconditional jump back or bpf_throw call
> >                        */
> >                       if (code != (BPF_JMP | BPF_EXIT) &&
> > -                         code != (BPF_JMP | BPF_JA)) {
> > -                             verbose(env, "last insn is not an exit or jmp\n");
> > +                         code != (BPF_JMP | BPF_JA) &&
> > +                         !is_bpf_throw_kfunc(insn + i)) {
> > +                             verbose(env, "last insn is not an exit or jmp or bpf_throw call\n");
> >                               return -EINVAL;
> >                       }
> >                       subprog_start = subprog_end;
> > @@ -5625,6 +5628,25 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
> >       for (; i < subprog_end; i++) {
> >               int next_insn, sidx;
> >
> > +             if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off) {
> > +                     bool err = false;
> > +
> > +                     if (!is_forbidden_exception_kfunc_in_cb(insn[i].imm))
>
> Just use is_bpf_throw_kfunc(). No need for another helper.
> The compiler will optimize the redundant checks.

Actually I added this because we also need to check
bpf_set_exception_callback as forbidden (check the later patch
extending the forbidden list). But I can check both separately as
well.

>
> > +                             continue;
> > +                     if (subprog[idx].is_cb)
> > +                             err = true;
> > +                     for (int c = 0; c < frame && !err; c++) {
> > +                             if (subprog[ret_prog[c]].is_cb) {
> > +                                     err = true;
> > +                                     break;
> > +                             }
> > +                     }
> > +                     if (!err)
> > +                             continue;
> > +                     verbose(env, "exception kfunc insn %d cannot be called from callback\n", i);
> > +                     return -EINVAL;
> > +             }
> > +
> >               if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
> >                       continue;
> >               /* remember insn and function to return to */
> > @@ -8734,6 +8756,7 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >        * callbacks
> >        */
> >       if (set_callee_state_cb != set_callee_state) {
> > +             env->subprog_info[subprog].is_cb = true;
> >               if (bpf_pseudo_kfunc_call(insn) &&
> >                   !is_callback_calling_kfunc(insn->imm)) {
> >                       verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
> > @@ -9247,17 +9270,17 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
> >       return 0;
> >  }
> >
> > -static int check_reference_leak(struct bpf_verifier_env *env)
> > +static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
> >  {
> >       struct bpf_func_state *state = cur_func(env);
> >       bool refs_lingering = false;
> >       int i;
> >
> > -     if (state->frameno && !state->in_callback_fn)
> > +     if (!exception_exit && state->frameno && !state->in_callback_fn)
> >               return 0;
> >
> >       for (i = 0; i < state->acquired_refs; i++) {
> > -             if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
> > +             if (!exception_exit && state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
> >                       continue;
> >               verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
> >                       state->refs[i].id, state->refs[i].insn_idx);
> > @@ -9491,7 +9514,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >
> >       switch (func_id) {
> >       case BPF_FUNC_tail_call:
> > -             err = check_reference_leak(env);
> > +             err = check_reference_leak(env, false);
> >               if (err) {
> >                       verbose(env, "tail_call would lead to reference leak\n");
> >                       return err;
> > @@ -10109,6 +10132,7 @@ enum special_kfunc_type {
> >       KF_bpf_dynptr_slice,
> >       KF_bpf_dynptr_slice_rdwr,
> >       KF_bpf_dynptr_clone,
> > +     KF_bpf_throw,
> >  };
> >
> >  BTF_SET_START(special_kfunc_set)
> > @@ -10129,6 +10153,7 @@ BTF_ID(func, bpf_dynptr_from_xdp)
> >  BTF_ID(func, bpf_dynptr_slice)
> >  BTF_ID(func, bpf_dynptr_slice_rdwr)
> >  BTF_ID(func, bpf_dynptr_clone)
> > +BTF_ID(func, bpf_throw)
> >  BTF_SET_END(special_kfunc_set)
> >
> >  BTF_ID_LIST(special_kfunc_list)
> > @@ -10151,6 +10176,7 @@ BTF_ID(func, bpf_dynptr_from_xdp)
> >  BTF_ID(func, bpf_dynptr_slice)
> >  BTF_ID(func, bpf_dynptr_slice_rdwr)
> >  BTF_ID(func, bpf_dynptr_clone)
> > +BTF_ID(func, bpf_throw)
> >
> >  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
> >  {
> > @@ -10464,6 +10490,17 @@ static bool is_callback_calling_kfunc(u32 btf_id)
> >       return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
> >  }
> >
> > +static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
> > +{
> > +     return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
> > +            insn->imm == special_kfunc_list[KF_bpf_throw];
> > +}
> > +
> > +static bool is_forbidden_exception_kfunc_in_cb(u32 btf_id)
> > +{
> > +     return btf_id == special_kfunc_list[KF_bpf_throw];
> > +}
> > +
> >  static bool is_rbtree_lock_required_kfunc(u32 btf_id)
> >  {
> >       return is_bpf_rbtree_api_kfunc(btf_id);
> > @@ -11140,6 +11177,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >       const struct btf_param *args;
> >       const struct btf_type *ret_t;
> >       struct btf *desc_btf;
> > +     bool throw = false;
> >
> >       /* skip for now, but return error when we find this in fixup_kfunc_call */
> >       if (!insn->imm)
> > @@ -11242,6 +11280,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >               }
> >       }
> >
> > +     if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
> > +             if (!bpf_jit_supports_exceptions()) {
> > +                     verbose(env, "JIT does not support calling kfunc %s#%d\n",
> > +                             func_name, meta.func_id);
> > +                     return -EINVAL;
> > +             }
> > +             env->seen_exception = true;
> > +             throw = true;
> > +     }
> > +
> >       for (i = 0; i < CALLER_SAVED_REGS; i++)
> >               mark_reg_not_init(env, regs, caller_saved[i]);
> >
> > @@ -11463,7 +11511,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                       return err;
> >       }
> >
> > -     return 0;
> > +     return throw ? 1 : 0;
>
> I don't like this inband signaling.
> Just check for special_kfunc_list[KF_bpf_throw] when check_func_call() returns with zero.
>

Ack.

> >  }
> >
> >  static bool signed_add_overflows(s64 a, s64 b)
> > @@ -14211,7 +14259,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >        * gen_ld_abs() may terminate the program at runtime, leading to
> >        * reference leak.
> >        */
> > -     err = check_reference_leak(env);
> > +     err = check_reference_leak(env, false);
> >       if (err) {
> >               verbose(env, "BPF_LD_[ABS|IND] cannot be mixed with socket references\n");
> >               return err;
> > @@ -14619,6 +14667,9 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
> >               if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> >                       struct bpf_kfunc_call_arg_meta meta;
> >
> > +                     /* No fallthrough edge to walk, same as BPF_EXIT */
> > +                     if (is_bpf_throw_kfunc(insn))
> > +                             return DONE_EXPLORING;
> >                       ret = fetch_kfunc_meta(env, insn, &meta, NULL);
> >                       if (ret == 0 && is_iter_next_kfunc(&meta)) {
> >                               mark_prune_point(env, t);
> > @@ -16222,6 +16273,7 @@ static int do_check(struct bpf_verifier_env *env)
> >       int prev_insn_idx = -1;
> >
> >       for (;;) {
> > +             bool exception_exit = false;
> >               struct bpf_insn *insn;
> >               u8 class;
> >               int err;
> > @@ -16435,12 +16487,18 @@ static int do_check(struct bpf_verifier_env *env)
> >                                               return -EINVAL;
> >                                       }
> >                               }
> > -                             if (insn->src_reg == BPF_PSEUDO_CALL)
> > +                             if (insn->src_reg == BPF_PSEUDO_CALL) {
> >                                       err = check_func_call(env, insn, &env->insn_idx);
> > -                             else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
> > +                             } else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> >                                       err = check_kfunc_call(env, insn, &env->insn_idx);
> > -                             else
> > +                                     if (err == 1) {
> > +                                             err = 0;
> > +                                             exception_exit = true;
> > +                                             goto process_bpf_exit_full;
> > +                                     }
> > +                             } else {
> >                                       err = check_helper_call(env, insn, &env->insn_idx);
> > +                             }
> >                               if (err)
> >                                       return err;
> >
> > @@ -16467,7 +16525,7 @@ static int do_check(struct bpf_verifier_env *env)
> >                                       verbose(env, "BPF_EXIT uses reserved fields\n");
> >                                       return -EINVAL;
> >                               }
> > -
> > +process_bpf_exit_full:
> >                               if (env->cur_state->active_lock.ptr &&
> >                                   !in_rbtree_lock_required_cb(env)) {
> >                                       verbose(env, "bpf_spin_unlock is missing\n");
> > @@ -16485,10 +16543,23 @@ static int do_check(struct bpf_verifier_env *env)
> >                                * function, for which reference_state must
> >                                * match caller reference state when it exits.
> >                                */
> > -                             err = check_reference_leak(env);
> > +                             err = check_reference_leak(env, exception_exit);
> >                               if (err)
> >                                       return err;
> >
> > +                             /* The side effect of the prepare_func_exit
> > +                              * which is being skipped is that it frees
> > +                              * bpf_func_state. Typically, process_bpf_exit
> > +                              * will only be hit with outermost exit.
> > +                              * copy_verifier_state in pop_stack will handle
> > +                              * freeing of any extra bpf_func_state left over
> > +                              * from not processing all nested function
> > +                              * exits. We also skip return code checks as
> > +                              * they are not needed for exceptional exits.
> > +                              */
> > +                             if (exception_exit)
> > +                                     goto process_bpf_exit;
> > +
> >                               if (state->curframe) {
> >                                       /* exit from nested function */
> >                                       err = prepare_func_exit(env, &env->insn_idx);
> > @@ -17782,6 +17853,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >               func[i]->aux->num_exentries = num_exentries;
> >               func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
> >               func[i]->aux->invented_prog = env->subprog_info[i].invented_prog;
> > +             func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
> > +             if (!i)
> > +                     func[i]->aux->seen_exception = env->seen_exception;
>
> why conditional?
>

We only need to set it for the main subprog, since when we throw,
entry from the kernel happens there (so only that needs to push/pop
all callee-saved registers). This is then later used in the JIT as if
(seen_exception). I should probably rename it to better reflect its
use.

[...]


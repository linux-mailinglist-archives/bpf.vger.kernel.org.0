Return-Path: <bpf+bounces-8306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D128784C04
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B1728114F
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D654834CD9;
	Tue, 22 Aug 2023 21:30:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341C2018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:30:02 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423E3E49
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:29:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b962c226ceso77495131fa.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692739797; x=1693344597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNN/lycK1mnhUhh1yKOuHshUKxIKBcpmDfQym5irQk0=;
        b=n0WrByyEGLbDPhgVEQURC3/V2JO2Jd/cad6BqKQle32TAjJqgUf1N5kwpiFMd4FUmf
         vomAg7TBO+/pEHthS7vvz+La/Kq2YDJpIlBpSPIvugkM9Fo+dQvMklVg0ipKiHp/4R1z
         pP51RylbWYi3oWBNnnfZbxIQHKTFHqBCWUWTSt8fUGsvwaAykXTdhoT8NIRTfEUsRxSA
         JcWl2Q7EwH2wo0iOfl6WmhXIV2xffFjdxNk6gFU3kDPkL3xRWnaM4tt4Fppj7Q86wEc8
         1pkyTjClcmblS6nD/FI7b5bjtegeHnUbtRQqTthiQSe+TMSIwJ94XoEqa5/p1+2OkSXl
         oVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739797; x=1693344597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNN/lycK1mnhUhh1yKOuHshUKxIKBcpmDfQym5irQk0=;
        b=WoOa5d3eIFzYrHihD8jJxekaIU8UvPRUmdsNmMn3SElc5eDATdIzw3fPMcW4tQoMzG
         N4hWi7QoA6i0e/6LDCOp7en5arEkgMdAYasXxVWWX5K6yczCzxO4aQ0zb3RPUXE2FfXG
         ppbXM89aBeed9pwTKowwP+0YwWCNR4hcpDa9gRP2Szs29s9KWyRNE9nfEy5AUThE3t+6
         0EJyoBjLQ+V6w9Zxc0yLJJdfETuXpRIjdEPgNYkvM4RznYA+ZzJG7WpXy7xX3uV6Fb8n
         0xRGOZAXRzrL/huYPjzwO1gZ69PhUlAGesqnMmk/gCkCyUOh6RHV4Y+6GWyNULSK9DQa
         aZpg==
X-Gm-Message-State: AOJu0YxvkhglWtSeYeE4cE3c2MbzonerZkWDgIwXDvoz+CQYHa/4FYnX
	ejClqdw5Y68EUmT77y4B2sLGNJ6gTa3i0Sn1lJw=
X-Google-Smtp-Source: AGHT+IGvrPkbc0tTVjQuEkUkpVt1mgSn8QoOven0LAJtoSSzPXGPwbPsGNjZ/kbuj/c+1aJCaUTvoFIIP0+ufChVYXE=
X-Received: by 2002:a05:6512:108a:b0:4fd:d016:c2e8 with SMTP id
 j10-20020a056512108a00b004fdd016c2e8mr9150372lfg.43.1692739797023; Tue, 22
 Aug 2023 14:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818151216.7686-1-hffilwlqm@gmail.com> <20230818151216.7686-2-hffilwlqm@gmail.com>
 <CAADnVQJQqp0WwGoWdsao8hrmmgyc0Me=Mi3gA=FG-i1GFwOozg@mail.gmail.com> <3778408b-8f79-5139-0662-55b5d7ca463c@gmail.com>
In-Reply-To: <3778408b-8f79-5139-0662-55b5d7ca463c@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 14:29:45 -0700
Message-ID: <CAADnVQ+znCeeCw+fJizb2Kg-+2Zj8ETR5Bpw4kwZw+MrCq9k3w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall infinite loop
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 8:17=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 22/8/23 06:33, Alexei Starovoitov wrote:
> > On Fri, Aug 18, 2023 at 8:12=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com=
> wrote:
> >>
> >> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailc=
all
> >> handling in JIT"), the tailcall on x64 works better than before.
> >>
> >> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprog=
rams
> >> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> >>
> >> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF prog=
ram
> >> to other BPF programs"), BPF program is able to trace other BPF progra=
ms.
> >>
> >> How about combining them all together?
> >>
> >> 1. FENTRY/FEXIT on a BPF subprogram.
> >> 2. A tailcall runs in the BPF subprogram.
> >> 3. The tailcall calls itself.
> >>
> >> As a result, a tailcall infinite loop comes up. And the loop would hal=
t
> >> the machine.
> >>
> >> As we know, in tail call context, the tail_call_cnt propagates by stac=
k
> >> and RAX register between BPF subprograms. So do it in trampolines.
> >>
> >> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> >> ---
> >>  arch/x86/net/bpf_jit_comp.c | 40 +++++++++++++++++++++++++++++-------=
-
> >>  include/linux/bpf.h         |  5 +++++
> >>  kernel/bpf/trampoline.c     |  4 ++--
> >>  kernel/bpf/verifier.c       | 31 +++++++++++++++++++++-------
> >>  4 files changed, 63 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index a5930042139d3..1ad17d7de5eee 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -303,8 +303,12 @@ static void emit_prologue(u8 **pprog, u32 stack_d=
epth, bool ebpf_from_cbpf,
> >>         prog +=3D X86_PATCH_SIZE;
> >>         if (!ebpf_from_cbpf) {
> >>                 if (tail_call_reachable && !is_subprog)
> >> +                       /* When it's the entry of the whole tailcall c=
ontext,
> >> +                        * zeroing rax means initialising tail_call_cn=
t.
> >> +                        */
> >>                         EMIT2(0x31, 0xC0); /* xor eax, eax */
> >>                 else
> >> +                       // Keep the same instruction layout.
> >
> > No c++ style comments please.
>
> Got it.
>
> >
> >>                         EMIT2(0x66, 0x90); /* nop2 */
> >>         }
> >>         EMIT1(0x55);             /* push rbp */
> >> @@ -1018,6 +1022,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg=
, u8 src_reg, bool is64, u8 op)
> >>
> >>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
> >>
> >> +/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> >> +#define RESTORE_TAIL_CALL_CNT(stack)                           \
> >> +       EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
> >> +
> >>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u=
8 *rw_image,
> >>                   int oldproglen, struct jit_context *ctx, bool jmp_pa=
dding)
> >>  {
> >> @@ -1623,9 +1631,7 @@ st:                       if (is_imm8(insn->off)=
)
> >>
> >>                         func =3D (u8 *) __bpf_call_base + imm32;
> >>                         if (tail_call_reachable) {
> >> -                               /* mov rax, qword ptr [rbp - rounded_s=
tack_depth - 8] */
> >> -                               EMIT3_off32(0x48, 0x8B, 0x85,
> >> -                                           -round_up(bpf_prog->aux->s=
tack_depth, 8) - 8);
> >> +                               RESTORE_TAIL_CALL_CNT(bpf_prog->aux->s=
tack_depth);
> >>                                 if (!imm32)
> >>                                         return -EINVAL;
> >>                                 offs =3D 7 + x86_call_depth_emit_accou=
nting(&prog, func);
> >> @@ -2298,7 +2304,9 @@ static int invoke_bpf_mod_ret(const struct btf_f=
unc_model *m, u8 **pprog,
> >>   * push rbp
> >>   * mov rbp, rsp
> >>   * sub rsp, 16                     // space for skb and dev
> >> - * push rbx                        // temp regs to pass start time
> >> + * mov qword ptr [rbp - 40], rbx   // temp regs to pass start time
> >> + * mov rax, 2                      // cache number of argument to rax
> >
> > What does it mean?
>
> I think it's the corresponding instruction to the following code snippet
> in arch_prepare_bpf_trampoline().
>
>         /* Store number of argument registers of the traced function:
>          *   mov rax, nr_regs
>          *   mov QWORD PTR [rbp - nregs_off], rax
>          */
>         emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
>         emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);

Ahh. I see.
The comment on top of arch_prepare_bpf_trampoline() is hopelessly obsolete.
Don't touch it in this patch set. We probably should delete it at some poin=
t
or take an effort to update it thoroughly.
Earlier recommendation to you was to update this comment:
/* Generated trampoline stack layout:

> >
> >> + * mov qword ptr [rbp - 32], rax   // save number of argument to stac=
k
> >
> > Here // is ok since it's inside /* */
>
> Got it.
>
> >
> >>   * mov qword ptr [rbp - 16], rdi   // save skb pointer to stack
> >>   * mov qword ptr [rbp - 8], rsi    // save dev pointer to stack
> >>   * call __bpf_prog_enter           // rcu_read_lock and preempt_disab=
le
> >> @@ -2323,7 +2331,9 @@ static int invoke_bpf_mod_ret(const struct btf_f=
unc_model *m, u8 **pprog,
> >>   * push rbp
> >>   * mov rbp, rsp
> >>   * sub rsp, 24                     // space for skb, dev, return valu=
e
> >> - * push rbx                        // temp regs to pass start time
> >> + * mov qword ptr [rbp - 40], rbx   // temp regs to pass start time
> >> + * mov rax, 2                      // cache number of argument to rax
> >> + * mov qword ptr [rbp - 32], rax   // save number of argument to stac=
k
> >>   * mov qword ptr [rbp - 24], rdi   // save skb pointer to stack
> >>   * mov qword ptr [rbp - 16], rsi   // save dev pointer to stack
> >>   * call __bpf_prog_enter           // rcu_read_lock and preempt_disab=
le
> >> @@ -2400,6 +2410,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp=
_image *im, void *image, void *i
> >>          *                     [ ...        ]
> >>          *                     [ stack_arg2 ]
> >>          * RBP - arg_stack_off [ stack_arg1 ]
> >> +        * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL=
_CTX
> >>          */
> >>
> >>         /* room for return value of orig_call or fentry prog */
> >> @@ -2464,6 +2475,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp=
_image *im, void *image, void *i
> >>         else
> >>                 /* sub rsp, stack_size */
> >>                 EMIT4(0x48, 0x83, 0xEC, stack_size);
> >> +       if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> >> +               EMIT1(0x50);            /* push rax */
> >>         /* mov QWORD PTR [rbp - rbx_off], rbx */
> >>         emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
> >>
> >> @@ -2516,9 +2529,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tram=
p_image *im, void *image, void *i
> >>                 restore_regs(m, &prog, regs_off);
> >>                 save_args(m, &prog, arg_stack_off, true);
> >>
> >> +               if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> >> +                       /* Before calling the original function, resto=
re the
> >> +                        * tail_call_cnt from stack to rax.
> >> +                        */
> >> +                       RESTORE_TAIL_CALL_CNT(stack_size);
> >> +
> >>                 if (flags & BPF_TRAMP_F_ORIG_STACK) {
> >> -                       emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP,=
 8);
> >> -                       EMIT2(0xff, 0xd0); /* call *rax */
> >> +                       emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP,=
 8);
> >> +                       EMIT2(0xff, 0xd3); /* call *rbx */ // FIXME: C=
onfirm 0xd3?
> >
> > please no FIXME like comments.
> > You have to be confident in the code you're submitting.
> > llvm-mc -triple=3Dx86_64 -show-encoding -x86-asm-syntax=3Dintel
> > -output-asm-variant=3D1 <<< 'call rbx'
>
> Got it. Thanks for the guide.
>
> >
> >>                 } else {
> >>                         /* call original function */
> >>                         if (emit_rsb_call(&prog, orig_call, prog)) {
> >> @@ -2569,7 +2588,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tram=
p_image *im, void *image, void *i
> >>                         ret =3D -EINVAL;
> >>                         goto cleanup;
> >>                 }
> >> -       }
> >> +       } else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> >> +               /* Before running the original function, restore the
> >> +                * tail_call_cnt from stack to rax.
> >> +                */
> >> +               RESTORE_TAIL_CALL_CNT(stack_size);
> >> +
> >>         /* restore return value of orig_call or fentry prog back into =
RAX */
> >>         if (save_ret)
> >>                 emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index cfabbcf47bdb8..c8df257ea435d 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -1028,6 +1028,11 @@ struct btf_func_model {
> >>   */
> >>  #define BPF_TRAMP_F_SHARE_IPMODIFY     BIT(6)
> >>
> >> +/* Indicate that current trampoline is in a tail call context. Then, =
it has to
> >> + * cache and restore tail_call_cnt to avoid infinite tail call loop.
> >> + */
> >> +#define BPF_TRAMP_F_TAIL_CALL_CTX      BIT(7)
> >> +
> >>  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit =
is ~50
> >>   * bytes on x86.
> >>   */
> >> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> >> index 78acf28d48732..16ab5da7161f2 100644
> >> --- a/kernel/bpf/trampoline.c
> >> +++ b/kernel/bpf/trampoline.c
> >> @@ -415,8 +415,8 @@ static int bpf_trampoline_update(struct bpf_trampo=
line *tr, bool lock_direct_mut
> >>                 goto out;
> >>         }
> >>
> >> -       /* clear all bits except SHARE_IPMODIFY */
> >> -       tr->flags &=3D BPF_TRAMP_F_SHARE_IPMODIFY;
> >> +       /* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
> >> +       tr->flags &=3D (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_=
CALL_CTX);
> >>
> >>         if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
> >>             tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 4ccca1f6c9981..52ba9b043f16e 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -19246,6 +19246,21 @@ static int check_non_sleepable_error_inject(u=
32 btf_id)
> >>         return btf_id_set_contains(&btf_non_sleepable_error_inject, bt=
f_id);
> >>  }
> >>
> >> +static inline int find_subprog_index(const struct bpf_prog *prog,
> >> +                                    u32 btf_id)
> >> +{
> >> +       struct bpf_prog_aux *aux =3D prog->aux;
> >> +       int i, subprog =3D -1;
> >> +
> >> +       for (i =3D 0; i < aux->func_info_cnt; i++)
> >> +               if (aux->func_info[i].type_id =3D=3D btf_id) {
> >> +                       subprog =3D i;
> >> +                       break;
> >> +               }
> >> +
> >> +       return subprog;
> >> +}
> >> +
> >>  int bpf_check_attach_target(struct bpf_verifier_log *log,
> >>                             const struct bpf_prog *prog,
> >>                             const struct bpf_prog *tgt_prog,
> >> @@ -19254,9 +19269,9 @@ int bpf_check_attach_target(struct bpf_verifie=
r_log *log,
> >>  {
> >>         bool prog_extension =3D prog->type =3D=3D BPF_PROG_TYPE_EXT;
> >>         const char prefix[] =3D "btf_trace_";
> >> -       int ret =3D 0, subprog =3D -1, i;
> >>         const struct btf_type *t;
> >>         bool conservative =3D true;
> >> +       int ret =3D 0, subprog;
> >>         const char *tname;
> >>         struct btf *btf;
> >>         long addr =3D 0;
> >> @@ -19291,11 +19306,7 @@ int bpf_check_attach_target(struct bpf_verifi=
er_log *log,
> >>                         return -EINVAL;
> >>                 }
> >>
> >> -               for (i =3D 0; i < aux->func_info_cnt; i++)
> >> -                       if (aux->func_info[i].type_id =3D=3D btf_id) {
> >> -                               subprog =3D i;
> >> -                               break;
> >> -                       }
> >> +               subprog =3D find_subprog_index(tgt_prog, btf_id);
> >>                 if (subprog =3D=3D -1) {
> >>                         bpf_log(log, "Subprog %s doesn't exist\n", tna=
me);
> >>                         return -EINVAL;
> >> @@ -19559,7 +19570,7 @@ static int check_attach_btf_id(struct bpf_veri=
fier_env *env)
> >>         struct bpf_attach_target_info tgt_info =3D {};
> >>         u32 btf_id =3D prog->aux->attach_btf_id;
> >>         struct bpf_trampoline *tr;
> >> -       int ret;
> >> +       int ret, subprog;
> >>         u64 key;
> >>
> >>         if (prog->type =3D=3D BPF_PROG_TYPE_SYSCALL) {
> >> @@ -19629,6 +19640,12 @@ static int check_attach_btf_id(struct bpf_ver=
ifier_env *env)
> >>         if (!tr)
> >>                 return -ENOMEM;
> >>
> >> +       if (tgt_prog && tgt_prog->aux->tail_call_reachable) {
> >> +               subprog =3D find_subprog_index(tgt_prog, btf_id);
> >> +               tr->flags =3D subprog > 0 && tgt_prog->aux->func[subpr=
og]->is_func ?
> >> +                           BPF_TRAMP_F_TAIL_CALL_CTX : 0;
> >
> > If prog has subprogs all of them will 'is_func', no?
> > What's the point of the search ?
> > Just tgt_prog->aux->tail_call_reachable and func_cnt > 0 would be enoug=
h?
>
> tgt_prog->aux->tail_call_reachable and subprog > 0 would be enough?
> It has to confirm that the attaching target is a subprog of tgt_prog inst=
ead of
> tgt_prog itself.
>
> In tail call context, when 'call' a func, tail_call_cnt will be restored =
to rax.
>
> static int do_jit() {
>                         /* call */
>                 case BPF_JMP | BPF_CALL: {
>                         int offs;
>
>                         func =3D (u8 *) __bpf_call_base + imm32;
>                         if (tail_call_reachable) {
>                                 /* mov rax, qword ptr [rbp - rounded_stac=
k_depth - 8] */
>                                 EMIT3_off32(0x48, 0x8B, 0x85,
>                                             -round_up(bpf_prog->aux->stac=
k_depth, 8) - 8);
>                                 /* ... */
>                         }
> }
>
> As a result, when 'call' a subprog, tail_call_cnt will be transferred by =
rax.
> Do all of subprogs run by 'call', including not-'is_func' subprogs?

Let me ask again. Do you see a subprog that has is_func=3D=3D0 ?


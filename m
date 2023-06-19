Return-Path: <bpf+bounces-2825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A94734A49
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 04:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2945D280FC6
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 02:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92ED1878;
	Mon, 19 Jun 2023 02:32:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4852110F
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 02:32:02 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB26C116;
	Sun, 18 Jun 2023 19:32:00 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-bd744ffc263so3293407276.3;
        Sun, 18 Jun 2023 19:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141920; x=1689733920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5Y+TbAR8gdSMeZtmyLo8011SM9uIQTsKmci9EzgR5I=;
        b=BgiFhzn1DmxZmN6lXRtMhrwXkJFLCficnySK04XnF7wJdzQhdPcjyU/S4IRAqgBYcz
         DZXO/7ectOvYrySipIAjdEWgMHOFn5Acd5Eu9wAezV1f2fnYdmXw+rGElu9mhSn87g10
         Eksu0jJJFgxztFZobNBpYXb7t9AMT3Cr0z09HsOYNimNuDqbD9/ysV6DcJlz96oLemLu
         ROHDISPjaOsOqV/iCj+Fl5ad4HTVmlTaxPmift6pJTPn79zjKJakJwp1xDGuWx3Afkir
         oG77NKxAno4muZSY3iazP3y3AeI3Jebcq4WiVtKZ5xKgUB8sLLlAOmyBbkJ/kBOg4vmr
         qSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141920; x=1689733920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5Y+TbAR8gdSMeZtmyLo8011SM9uIQTsKmci9EzgR5I=;
        b=DSqhFIVWJVoCiNkDaXb1q4Och84Ns9SUsDZdBrbfIcThqqXgr1Vnd//5s+O7fHbeuS
         PBl8/oD6Jrvn+KrzLuKWh/D4ARakTMpSZjZS7jfQLDCcSh9V3/XJ5f+eG9wMrZItyGei
         vB7E+c+hqydCqE8tuRc48uQjf6t/sZI3GW3S02WWLZwZmLnK/BqskOUD1wjUJwMYkWK4
         jvFP6gRgL2usKd3Pc0G4qsWt1ituUOaczO+mJ4FSmTwKziV8cKyOXjcXwCRkZnVdnyQU
         ogromYB8Nd98prgAJzMeny2IxynrMZ02LNn/iO5DwhsoIKTc/cFss5yF0yVFugHASowq
         Vj8g==
X-Gm-Message-State: AC+VfDyy7gTEMB9Ejb4Xacq8aNSzdATGD62Af/9hBFjYv+/Ddc6lSyoF
	HQm/qKfck5xrrHVmXHyAzpOxX2NweQsfjhgAqKA=
X-Google-Smtp-Source: ACHHUZ7EOjsDoY99yNrbfRl8LVQzcB+AUeQskYst1CErKtEnZ1YkD/Gwa0gVR5/+koblq+212umRA279axMs/l4IdOE=
X-Received: by 2002:a25:aba8:0:b0:bd6:ab88:4ee2 with SMTP id
 v37-20020a25aba8000000b00bd6ab884ee2mr5707355ybi.0.1687141919679; Sun, 18 Jun
 2023 19:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613025226.3167956-1-imagedong@tencent.com>
 <20230613025226.3167956-3-imagedong@tencent.com> <ca490974-0c5c-cfe9-0c6f-3ead163e7a7b@meta.com>
In-Reply-To: <ca490974-0c5c-cfe9-0c6f-3ead163e7a7b@meta.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 19 Jun 2023 10:31:48 +0800
Message-ID: <CADxym3bgC2FygnoP1dvUo2p=2bkZi=6FTcS9K0VbyLC2QF-OVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] bpf, x86: allow function arguments up to
 12 for TRACING
To: Yonghong Song <yhs@meta.com>
Cc: alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 7:11=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 6/12/23 7:52 PM, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
> > on the kernel functions whose arguments count less than 6. This is not
> > friendly at all, as too many functions have arguments count more than 6=
.
> >
> > According to the current kernel version, below is a statistics of the
> > function arguments count:
> >
> > argument count | function count
> > 7              | 704
> > 8              | 270
> > 9              | 84
> > 10             | 47
> > 11             | 47
> > 12             | 27
> > 13             | 22
> > 14             | 5
> > 15             | 0
> > 16             | 1
> >
> > Therefore, let's enhance it by increasing the function arguments count
> > allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.
> >
> > For the case that we don't need to call origin function, which means
> > without BPF_TRAMP_F_CALL_ORIG, we need only copy the function arguments
> > that stored in the frame of the caller to current frame. The arguments
> > of arg6-argN are stored in "$rbp + 0x18", we need copy them to
> > "$rbp - regs_off + (6 * 8)".
> >
> > For the case with BPF_TRAMP_F_CALL_ORIG, we need prepare the arguments
> > in stack before call origin function, which means we need alloc extra
> > "8 * (arg_count - 6)" memory in the top of the stack. Note, there shoul=
d
> > not be any data be pushed to the stack before call the origin function.
> > Then, we have to store rbx with 'mov' instead of 'push'.
>
> Please also mention special case related to 16-byte struct argument
> in the comments of save_args().
>
> >
> > We use EMIT3_off32() or EMIT4() for "lea" and "sub". The range of the
> > imm in "lea" and "sub" is [-128, 127] if EMIT4() is used. Therefore,
> > we use EMIT3_off32() instead if the imm out of the range.
> >
> > It works well for the FENTRY/FEXIT/MODIFY_RETURN.
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> > v5:
> > - consider the case of the struct in arguments can't be hold by regs
> > v4:
> > - make the stack 16-byte aligned if passing args on-stack is needed
> > - add the function arguments statistics to the commit log
> > v3:
> > - use EMIT3_off32() for "lea" and "sub" only on necessary
> > - make 12 as the maximum arguments count
> > v2:
> > - instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow
> > - make MAX_BPF_FUNC_ARGS as the maximum argument count
> > ---
> >   arch/x86/net/bpf_jit_comp.c | 221 +++++++++++++++++++++++++++++++----=
-
> >   1 file changed, 195 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index a407fbbffecd..47c699594dd8 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1857,37 +1857,165 @@ st:                  if (is_imm8(insn->off))
> >       return proglen;
> >   }
> >
> > -static void save_regs(const struct btf_func_model *m, u8 **prog, int n=
r_regs,
> > -                   int stack_size)
> > +static inline void clean_stack_garbage(const struct btf_func_model *m,
> > +                                    u8 **pprog, int nr_args_on_stack,
>
> nr_args_on_stack is actually nr_stack_slots, right? Maybe rename to
> nr_stack_slots?
>
> > +                                    int stack_size)
> >   {
> > -     int i;
> > +     int arg_size, off;
> > +     u8 *prog;
> > +
> > +     if (nr_args_on_stack !=3D 1)
> > +             return;
> > +
> > +     /* the size of the last argument */
> > +     arg_size =3D m->arg_size[m->nr_args - 1];
> > +
> > +     /* Generally speaking, the compiler will pass the arguments
> > +      * on-stack with "push" instruction, which will take 8-byte
> > +      * on the stack. On this case, there won't be garbage values
>
> On this case -> In this case. The same for below another case.
>
> > +      * while we copy the arguments from origin stack frame to current
> > +      * in BPF_DW.
> > +      *
> > +      * However, sometimes the compiler will only allocate 4-byte on
> > +      * the stack for the arguments. For now, this case will only
> > +      * happen if there is only one argument on-stack and its size
> > +      * not more than 4 byte. On this case, there will be garbage
> > +      * values on the upper 4-byte where we store the argument on
> > +      * current stack frame.
> > +      *
> > +      * arguments on origin stack:
> > +      *
> > +      * stack_arg_1(4-byte) xxx(4-byte)
> > +      *
> > +      * what we copy:
> > +      *
> > +      * stack_arg_1(8-byte): stack_arg_1(origin) xxx
> > +      *
> > +      * and the xxx is the garbage values which we should clean here.
> > +      */
>
> let us put the above comments before
>  > +    if (nr_args_on_stack !=3D 1)
>  > +            return;
>
>
> > +     if (arg_size <=3D 4) {
> > +             off =3D -(stack_size - 4);
> > +             prog =3D *pprog;
> > +             /* mov DWORD PTR [rbp + off], 0 */
> > +             if (!is_imm8(off))
> > +                     EMIT2_off32(0xC7, 0x85, off);
> > +             else
> > +                     EMIT3(0xC7, 0x45, off);
> > +             EMIT(0, 4);
> > +             *pprog =3D prog;
> > +     }
> > +}
> > +
> > +static void save_args(const struct btf_func_model *m, u8 **prog,
> > +                   int stack_size, bool on_stack)
>
> Rename 'on_stack' to 'for_call_origin'? This should be more
> clear about the use case.
>
> > +{
> > +     int arg_regs, first_off, nr_regs =3D 0, nr_stack =3D 0;
> nr_stack -> nr_stack_slots?
> > +     int i, j;
> >
> >       /* Store function arguments to stack.
> >        * For a function that accepts two pointers the sequence will be:
> >        * mov QWORD PTR [rbp-0x10],rdi
> >        * mov QWORD PTR [rbp-0x8],rsi
> >        */
> > -     for (i =3D 0; i < min(nr_regs, 6); i++)
> > -             emit_stx(prog, BPF_DW, BPF_REG_FP,
> > -                      i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
> > -                      -(stack_size - i * 8));
> > +     for (i =3D 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++)=
 {
> > +             arg_regs =3D (m->arg_size[i] + 7) / 8;
> > +
> > +             /* According to the research of Yonghong, struct members
> > +              * should be all in register or all on the stack.
> > +              * Meanwhile, the compiler will pass the argument on regs
> > +              * if the remained regs can hold the argument.
> remained -> remaining
> > +              *
> > +              * Disorder of the args can happen. For example:
> > +              *
> > +              * struct foo_struct {
> > +              *     long a;
> > +              *     int b;
> > +              * };
> > +              * int foo(char, char, char, char, char, struct foo_struc=
t,
> > +              *         char);
> > +              *
> > +              * the arg1-5,arg7 will be passed by regs, and arg6 will
> > +              * by stack.
> > +              *
> > +              * Therefore, we should keep the same logic as here when
> > +              * we restore the regs in restore_regs.
> > +              */
> > +             if (nr_regs + arg_regs > 6) {
> > +                     /* copy function arguments from origin stack fram=
e
> > +                      * into current stack frame.
> > +                      *
> > +                      * The starting address of the arguments on-stack
> > +                      * is:
> > +                      *   rbp + 8(push rbp) +
> > +                      *   8(return addr of origin call) +
> > +                      *   8(return addr of the caller)
> > +                      * which means: rbp + 24
> > +                      */
> > +                     for (j =3D 0; j < arg_regs; j++) {
> > +                             emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG=
_FP,
> > +                                      nr_stack * 8 + 0x18);
> > +                             emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_RE=
G_0,
> > +                                      -stack_size);
> > +
> > +                             if (!nr_stack)
> > +                                     first_off =3D stack_size;
> > +                             stack_size -=3D 8;
> > +                             nr_stack++;
> > +                     }
> > +             } else {
> > +                     /* Only copy the arguments on-stack to current
> > +                      * 'stack_size' and ignore the regs, used to
> > +                      * prepare the arguments on-stack for orign call.
> > +                      */
> > +                     if (on_stack) {
> > +                             nr_regs +=3D arg_regs;
> > +                             continue;
> > +                     }
> > +
> > +                     /* copy the arguments from regs into stack */
> > +                     for (j =3D 0; j < arg_regs; j++) {
> > +                             emit_stx(prog, BPF_DW, BPF_REG_FP,
> > +                                      nr_regs =3D=3D 5 ? X86_REG_R9 : =
BPF_REG_1 + i,
> > +                                      -stack_size);
> > +                             stack_size -=3D 8;
> > +                             nr_regs++;
> > +                     }
> > +             }
> > +     }
> > +
> > +     clean_stack_garbage(m, prog, nr_stack, first_off);
> >   }
> >
> [...]
> >       /* Generated trampoline stack layout:
> > @@ -2147,7 +2286,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp=
_image *im, void *image, void *i
> >        *
> >        * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
> >        *
> > +      * RBP - rbx_off   [ rbx value       ]  always
> > +      *
> >        * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
> > +      *
> > +      *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
> > +      *                     [ ...        ]
> > +      *                     [ stack_arg2 ]
> > +      * RBP - arg_stack_off [ stack_arg1 ]
> >        */
> >
> >       /* room for return value of orig_call or fentry prog */
> > @@ -2167,9 +2313,25 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp=
_image *im, void *image, void *i
> >
> >       ip_off =3D stack_size;
> >
> > +     stack_size +=3D 8;
> > +     rbx_off =3D stack_size;
> > +
> >       stack_size +=3D (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
> >       run_ctx_off =3D stack_size;
> >
> > +     if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
> > +             stack_size +=3D (nr_regs - 6) * 8;
>
> Please double check. Is this okay for the case below?
>    foo(int, int, int, int, int, 16_byte_struct)
> here, nr_regs is 7, yes, to-be-increased stack size should be 2.
>

You are right, here should be:
  stack_size +=3D (nr_regs - nr_arg_on_regs) * 8

The test case "bpf_testmod_fentry_test_struct1" shouldn't have
passed, and I'll figure out the reason too.

Thank you for the comment above, and I'll change them in
the next version too.

>
> > +             /* make sure the stack pointer is 16-byte aligned if we
> > +              * need pass arguments on stack, which means
> > +              *  [stack_size + 8(rbp) + 8(rip) + 8(origin rip)]
> > +              * should be 16-byte aligned. Following code depend on
> > +              * that stack_size is already 8-byte aligned.
> > +              */
> > +             stack_size +=3D (stack_size % 16) ? 0 : 8;
> > +     }
> > +
> > +     arg_stack_off =3D stack_size;
> > +
> [...]


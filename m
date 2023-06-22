Return-Path: <bpf+bounces-3111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2E73972F
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 08:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700FB281854
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F45239;
	Thu, 22 Jun 2023 06:04:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362F442F
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 06:04:20 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B7BEA;
	Wed, 21 Jun 2023 23:04:19 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-bc476bf5239so6668174276.2;
        Wed, 21 Jun 2023 23:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687413858; x=1690005858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY7xaxsU7G6PIQ1azpoemtJ/auaZ/Od/IRzQqyUCvJ0=;
        b=JMRs3GBOK5pu4VGX6bmp7Z14okw4Zs+nAVLW/d33pMsQNKBCLXoinFsY2J/03zQ/FA
         d+di+dzOFBUjK385C86kRN5wjOt8ge9cC/YFRwlLRgQmElkWY7DuEImsZYiHqQwdGi7a
         8HpI1WhQaHS9FHrB4VcYjAAP1iolEjUfavSiRPrRT0mLnj81VxhZ+OFZyjAnUdTL7H6e
         BFJ7w6bpGxHqIxuGIt/F96wD0yiLc85ELeEh6RdSvDGoHe7u4sGZ6jpeO2tXmcGic6Lm
         oNj+Zcfr5m3BlAX82zUtebSwrqL3FgsoV6WJZYJ08E5v4pwOOZKn1399Ls6hQ8eUf//p
         AeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687413858; x=1690005858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY7xaxsU7G6PIQ1azpoemtJ/auaZ/Od/IRzQqyUCvJ0=;
        b=inZCqfwi4sFAk3+vIrjuiEPzVrENz+rgCuqkM42goGZk6tmMuaa9iMejKHhgq0AnnC
         dc4IlxwfaSSsZBDb1izSn4xnmbddy+z3AVcOXWemu08RqBuWhPyudkowkeL3mERu93xs
         KcJLRGINaxcDw7ABh/B/b7yyDhR2ZYnQ/2SBM0VTbcbsagJs7JJLeDInn/surIjbVtO4
         WZRU3FVnsD7T3SZWYSHK1nOUBpXYOojzyEDMtxYP7KVd8nMJ+GjcUxfe76x7zZlZxF7/
         hQynkcHEfc3cCM1ZkVF2KIPDkDBKXOzdS2nxt1GMnsmU2iq90lkAFTDzXMl548XlcMuC
         SV2Q==
X-Gm-Message-State: AC+VfDzzmSnTrhTdZ/HihutDPy2P0znaP9aqn3XmkQHd/9T1NBPMM7Le
	+aav9evKOKYtC9fAVzm7f3caNf3Vvruq5Wy82/2OEQuuz5Sklg==
X-Google-Smtp-Source: ACHHUZ4sSdVb12LW/JaanhZ4/QhD32NPerQTM/7saqJpv6DcEB1T3p/Wtmul2VpCExO32pLFYyWTxVZt/ms34RIhpmA=
X-Received: by 2002:a0d:cad1:0:b0:570:8e80:5572 with SMTP id
 m200-20020a0dcad1000000b005708e805572mr16341819ywd.34.1687413858190; Wed, 21
 Jun 2023 23:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230619114947.1543848-1-imagedong@tencent.com>
 <20230619114947.1543848-3-imagedong@tencent.com> <ffed1ab2-dec3-ee41-a64b-30dd1113823e@meta.com>
In-Reply-To: <ffed1ab2-dec3-ee41-a64b-30dd1113823e@meta.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 22 Jun 2023 14:04:06 +0800
Message-ID: <CADxym3ai6tWRAJh1MH1zb4pM9Ky+fzu7pqGDdMhKYtDsZqrD0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/3] bpf, x86: allow function arguments up to
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

On Thu, Jun 22, 2023 at 12:44=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 6/19/23 4:49 AM, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
> > on the kernel functions whose arguments count less than 6. This is not
>
> less than or equal to 6, if not considering '> 8 bytes' struct
> argument.
>
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
>
> The 7th and later arguments are stored in "$rbp + 0x18", and they will
> be copied to the stack area following where register values are saved.
>
> >
> > For the case with BPF_TRAMP_F_CALL_ORIG, we need prepare the arguments
> > in stack before call origin function, which means we need alloc extra
> > "8 * (arg_count - 6)" memory in the top of the stack. Note, there shoul=
d
> > not be any data be pushed to the stack before call the origin function.
>
> call -> calling
>
> > Then, we have to store rbx with 'mov' instead of 'push'.
>
> So 'rbx' value will be stored on a stack position higher than
> where stack arguments are stored for BPF_TRAMP_F_CALL_ORIG.
>
> >
> > According to the research of Yonghong, struct members should be all in
> > register or all on the stack. Meanwhile, the compiler will pass the
> > argument on regs if the remaining regs can hold the argument. Therefore=
,
> > we need save the arguments in order. Otherwise, disorder of the args ca=
n
> > happen. For example:
> >
> >    struct foo_struct {
> >        long a;
> >        int b;
> >    };
> >    int foo(char, char, char, char, char, struct foo_struct,
> >            char);
> >
> > the arg1-5,arg7 will be passed by regs, and arg6 will by stack. Therefo=
re,
> > we should save/restore the arguments in the same order with the
> > declaration of foo(). And the args used as ctx in stack will be like th=
is:
> >
> >    reg_arg6   -- copy from regs
> >    stack_arg2 -- copy from stack
> >    stack_arg1
> >    reg_arg5   -- copy from regs
> >    reg_arg4
> >    reg_arg3
> >    reg_arg2
> >    reg_arg1
> >
> > We use EMIT3_off32() or EMIT4() for "lea" and "sub". The range of the
> > imm in "lea" and "sub" is [-128, 127] if EMIT4() is used. Therefore,
> > we use EMIT3_off32() instead if the imm out of the range.
> >
> > It works well for the FENTRY/FEXIT/MODIFY_RETURN.
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
>
> LGTM with some nits for commit messages and below codes.
>

Thank you for correcting these typos! I'll send the
next version with them fixed.

> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> > v6:
> > - introduce get_nr_regs() to get the space that used to pass args on
> >    stack correct
> > - rename some args and fix some spelling mistake
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
> >   arch/x86/net/bpf_jit_comp.c | 238 ++++++++++++++++++++++++++++++++---=
-
> >   1 file changed, 212 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index a407fbbffecd..c0637f2b5398 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1857,37 +1857,181 @@ st:                  if (is_imm8(insn->off))
> >       return proglen;
> >   }
> >
> > -static void save_regs(const struct btf_func_model *m, u8 **prog, int n=
r_regs,
> > -                   int stack_size)
> > +static inline void clean_stack_garbage(const struct btf_func_model *m,
> > +                                    u8 **pprog, int nr_stack_slots,
> > +                                    int stack_size)
>
> Please remove 'inline' here. Let us compiler to decide
> whether inlining is needed or not.
>
> >   {
> > -     int i;
> > +     int arg_size, off;
> > +     u8 *prog;
> > +
> > +     /* Generally speaking, the compiler will pass the arguments
> > +      * on-stack with "push" instruction, which will take 8-byte
> > +      * on the stack. In this case, there won't be garbage values
> > +      * while we copy the arguments from origin stack frame to current
> > +      * in BPF_DW.
> > +      *
> > +      * However, sometimes the compiler will only allocate 4-byte on
> > +      * the stack for the arguments. For now, this case will only
> > +      * happen if there is only one argument on-stack and its size
> > +      * not more than 4 byte. In this case, there will be garbage
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
> > +     if (nr_stack_slots !=3D 1)
> > +             return;
> > +
> > +     /* the size of the last argument */
> > +     arg_size =3D m->arg_size[m->nr_args - 1];
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
> > +/* get the count of the regs that are used to pass arguments * > +stat=
ic inline int get_nr_regs(const struct btf_func_model *m)
>
> Again, remove 'inline' keyword here.
> Also rename function name 'get_nr_regs' to 'get_nr_used_regs'
> to reflect that it counts for the number of registers
> used to pass arguments?
>
> > +{
> > +     int i, arg_regs, nr_regs =3D 0;
>
> nr_regs =3D> nr_used_regs for clarity?
>
> > +
> > +     for (i =3D 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++)=
 {
> > +             arg_regs =3D (m->arg_size[i] + 7) / 8;
> > +             if (nr_regs + arg_regs <=3D 6)
> > +                     nr_regs +=3D arg_regs;
> > +
> > +             if (nr_regs >=3D 6)
> > +                     break;
> > +     }
> > +
> > +     return nr_regs;
> > +}
> > +
> > +static void save_args(const struct btf_func_model *m, u8 **prog,
> > +                   int stack_size, bool for_call_origin)
> > +{
> > +     int arg_regs, first_off, nr_regs =3D 0, nr_stack =3D 0;
>
> To be consistent with clean_stack_garbage(),
> nr_stack -> nr_stack_slots?
>

Sounds great!

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
> > +              * if the remaining regs can hold the argument.
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
>
> The above two line comments are not needed. A similar comments exists
> in restore_regs() already.

Okay!

Thanks!
Menglong Dong


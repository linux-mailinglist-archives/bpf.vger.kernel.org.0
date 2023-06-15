Return-Path: <bpf+bounces-2612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4622D730DD4
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 06:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3311C20DD3
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 04:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525C9655;
	Thu, 15 Jun 2023 04:00:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6F6625
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 04:00:23 +0000 (UTC)
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A5D212C;
	Wed, 14 Jun 2023 21:00:20 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-57015b368c3so11445057b3.3;
        Wed, 14 Jun 2023 21:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686801620; x=1689393620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N6e72A0j9ol+2fklGBfXN9v2PxgCyCZzO7+Ov8GeXM=;
        b=RShO51S5gz251spT1KD7LzAlDulvEClAasVtakx98VsHFPW/8NFQmRJ76K8PmbHz7U
         abpgFjf5cUk+/KdJawhsR7IcjibaonQUcblbd6Pz+56xG0WUkA4BMZIrXiSmwu4TFaQe
         wIRUMYySc4Rb062JOVdtEVHWgb4nmqSEhYbZxvP2qyFYKWUxTOBhrE4Gpj4IwVf1TgGC
         huc9xJM+HRNJJvRsMOcRaBw7A+56OH5xxb1regZ5WyZJrPx5nXFB+cthTKDcEEASTO7q
         kaom3M8V90g9JsoweKh+1zR3n/E/g797WIln6WXjZImuwz03hztqCAl1BLGZuJz/yEJN
         Y3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686801620; x=1689393620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N6e72A0j9ol+2fklGBfXN9v2PxgCyCZzO7+Ov8GeXM=;
        b=gxejHPU4tW12laTLht9E0gW6gINGqFBKfKD78n4PLh0XIiwmZ7SIIl5x6YqxrNa0qU
         x3mK++RiSeFE4efp+leR+D7YPSiEO9vFQHU9dlFL0ALKv5cB5Wq21hl7DPIeSBqJmaTo
         ERlOK0/Zo8R+tnMgwp7wl74CGqWeGScvJX3ok0XLUk7Lqe58zlg/btu8ysZOjOZTFVed
         kl0vo4Ng5DvspwYc5ThS7jg34cScMhLX2mbI9xHjPkvPsHyHQJUnLUZlfVl0SlIUxuqs
         c1v4jhsQ8N0OQkzcaMGPYbirtOpGNtfAO2x1LX53rapCMSZ/c8NRuB/sbaAs90/ik6yg
         nEMg==
X-Gm-Message-State: AC+VfDw+tRoO11H3J7Y63nzoFcArNfUorFNePwUM7tPh3LL9Y8pCxwHN
	yWc/Ug7xgcbh0kUnEEURoiRlCqnsxGxK+k1YUH2ISzGRrWpCagiw
X-Google-Smtp-Source: ACHHUZ46ojkH85GwDfhkiJFD9BlxAh5kwsMTRQl+rwhxXRZSN99JQsFHSXr7ZU+4iaTksewGkzB8nk6hgNuXLvBH6as=
X-Received: by 2002:a81:5bd5:0:b0:56d:376a:6bc5 with SMTP id
 p204-20020a815bd5000000b0056d376a6bc5mr3706128ywb.5.1686801619769; Wed, 14
 Jun 2023 21:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613025226.3167956-1-imagedong@tencent.com> <20230613025226.3167956-3-imagedong@tencent.com>
In-Reply-To: <20230613025226.3167956-3-imagedong@tencent.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 15 Jun 2023 12:00:08 +0800
Message-ID: <CADxym3Z_HELHqnaf5F0fZ0iSw7aiost54SD08iG8_LGkd2i1mQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] bpf, x86: allow function arguments up to
 12 for TRACING
To: yhs@meta.com, alexei.starovoitov@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	benbjiang@tencent.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 10:53=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
> on the kernel functions whose arguments count less than 6. This is not
> friendly at all, as too many functions have arguments count more than 6.
>
> According to the current kernel version, below is a statistics of the
> function arguments count:
>
> argument count | function count
> 7              | 704
> 8              | 270
> 9              | 84
> 10             | 47
> 11             | 47
> 12             | 27
> 13             | 22
> 14             | 5
> 15             | 0
> 16             | 1
>
> Therefore, let's enhance it by increasing the function arguments count
> allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.
>
> For the case that we don't need to call origin function, which means
> without BPF_TRAMP_F_CALL_ORIG, we need only copy the function arguments
> that stored in the frame of the caller to current frame. The arguments
> of arg6-argN are stored in "$rbp + 0x18", we need copy them to
> "$rbp - regs_off + (6 * 8)".
>
> For the case with BPF_TRAMP_F_CALL_ORIG, we need prepare the arguments
> in stack before call origin function, which means we need alloc extra
> "8 * (arg_count - 6)" memory in the top of the stack. Note, there should
> not be any data be pushed to the stack before call the origin function.
> Then, we have to store rbx with 'mov' instead of 'push'.
>
> We use EMIT3_off32() or EMIT4() for "lea" and "sub". The range of the
> imm in "lea" and "sub" is [-128, 127] if EMIT4() is used. Therefore,
> we use EMIT3_off32() instead if the imm out of the range.
>
> It works well for the FENTRY/FEXIT/MODIFY_RETURN.
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v5:
> - consider the case of the struct in arguments can't be hold by regs
> v4:
> - make the stack 16-byte aligned if passing args on-stack is needed
> - add the function arguments statistics to the commit log
> v3:
> - use EMIT3_off32() for "lea" and "sub" only on necessary
> - make 12 as the maximum arguments count
> v2:
> - instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow
> - make MAX_BPF_FUNC_ARGS as the maximum argument count
> ---
>  arch/x86/net/bpf_jit_comp.c | 221 +++++++++++++++++++++++++++++++-----
>  1 file changed, 195 insertions(+), 26 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a407fbbffecd..47c699594dd8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1857,37 +1857,165 @@ st:                    if (is_imm8(insn->off))
>         return proglen;
>  }
>
> -static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_=
regs,
> -                     int stack_size)
> +static inline void clean_stack_garbage(const struct btf_func_model *m,
> +                                      u8 **pprog, int nr_args_on_stack,
> +                                      int stack_size)
>  {
> -       int i;
> +       int arg_size, off;
> +       u8 *prog;
> +
> +       if (nr_args_on_stack !=3D 1)
> +               return;
> +
> +       /* the size of the last argument */
> +       arg_size =3D m->arg_size[m->nr_args - 1];
> +
> +       /* Generally speaking, the compiler will pass the arguments
> +        * on-stack with "push" instruction, which will take 8-byte
> +        * on the stack. On this case, there won't be garbage values
> +        * while we copy the arguments from origin stack frame to current
> +        * in BPF_DW.
> +        *
> +        * However, sometimes the compiler will only allocate 4-byte on
> +        * the stack for the arguments. For now, this case will only
> +        * happen if there is only one argument on-stack and its size
> +        * not more than 4 byte. On this case, there will be garbage
> +        * values on the upper 4-byte where we store the argument on
> +        * current stack frame.
> +        *
> +        * arguments on origin stack:
> +        *
> +        * stack_arg_1(4-byte) xxx(4-byte)
> +        *
> +        * what we copy:
> +        *
> +        * stack_arg_1(8-byte): stack_arg_1(origin) xxx
> +        *
> +        * and the xxx is the garbage values which we should clean here.
> +        */
> +       if (arg_size <=3D 4) {
> +               off =3D -(stack_size - 4);
> +               prog =3D *pprog;
> +               /* mov DWORD PTR [rbp + off], 0 */
> +               if (!is_imm8(off))
> +                       EMIT2_off32(0xC7, 0x85, off);
> +               else
> +                       EMIT3(0xC7, 0x45, off);
> +               EMIT(0, 4);
> +               *pprog =3D prog;
> +       }
> +}
> +
> +static void save_args(const struct btf_func_model *m, u8 **prog,
> +                     int stack_size, bool on_stack)
> +{
> +       int arg_regs, first_off, nr_regs =3D 0, nr_stack =3D 0;
> +       int i, j;
>
>         /* Store function arguments to stack.
>          * For a function that accepts two pointers the sequence will be:
>          * mov QWORD PTR [rbp-0x10],rdi
>          * mov QWORD PTR [rbp-0x8],rsi
>          */
> -       for (i =3D 0; i < min(nr_regs, 6); i++)
> -               emit_stx(prog, BPF_DW, BPF_REG_FP,
> -                        i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
> -                        -(stack_size - i * 8));
> +       for (i =3D 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++)=
 {
> +               arg_regs =3D (m->arg_size[i] + 7) / 8;
> +
> +               /* According to the research of Yonghong, struct members
> +                * should be all in register or all on the stack.
> +                * Meanwhile, the compiler will pass the argument on regs
> +                * if the remained regs can hold the argument.
> +                *
> +                * Disorder of the args can happen. For example:
> +                *
> +                * struct foo_struct {
> +                *     long a;
> +                *     int b;
> +                * };
> +                * int foo(char, char, char, char, char, struct foo_struc=
t,
> +                *         char);
> +                *
> +                * the arg1-5,arg7 will be passed by regs, and arg6 will
> +                * by stack.
> +                *
> +                * Therefore, we should keep the same logic as here when
> +                * we restore the regs in restore_regs.
> +                */
> +               if (nr_regs + arg_regs > 6) {
> +                       /* copy function arguments from origin stack fram=
e
> +                        * into current stack frame.
> +                        *
> +                        * The starting address of the arguments on-stack
> +                        * is:
> +                        *   rbp + 8(push rbp) +
> +                        *   8(return addr of origin call) +
> +                        *   8(return addr of the caller)
> +                        * which means: rbp + 24
> +                        */
> +                       for (j =3D 0; j < arg_regs; j++) {
> +                               emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG=
_FP,
> +                                        nr_stack * 8 + 0x18);
> +                               emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_RE=
G_0,
> +                                        -stack_size);
> +
> +                               if (!nr_stack)
> +                                       first_off =3D stack_size;
> +                               stack_size -=3D 8;
> +                               nr_stack++;
> +                       }
> +               } else {
> +                       /* Only copy the arguments on-stack to current
> +                        * 'stack_size' and ignore the regs, used to
> +                        * prepare the arguments on-stack for orign call.
> +                        */
> +                       if (on_stack) {
> +                               nr_regs +=3D arg_regs;
> +                               continue;
> +                       }
> +
> +                       /* copy the arguments from regs into stack */
> +                       for (j =3D 0; j < arg_regs; j++) {
> +                               emit_stx(prog, BPF_DW, BPF_REG_FP,
> +                                        nr_regs =3D=3D 5 ? X86_REG_R9 : =
BPF_REG_1 + i,

Oops, this should be:

+                                        nr_regs =3D=3D 5 ? X86_REG_R9 :
BPF_REG_1 + nr_regs,

and cause the failure of the testcase tracing_struct.

I'll fix it in the next version.

> +                                        -stack_size);
> +                               stack_size -=3D 8;
> +                               nr_regs++;
> +                       }
> +               }
> +       }
> +
> +       clean_stack_garbage(m, prog, nr_stack, first_off);
>  }
>
> -static void restore_regs(const struct btf_func_model *m, u8 **prog, int =
nr_regs,
> +static void restore_regs(const struct btf_func_model *m, u8 **prog,
>                          int stack_size)
>  {
> -       int i;
> +       int i, j, arg_regs, nr_regs =3D 0;
>
>         /* Restore function arguments from stack.
>          * For a function that accepts two pointers the sequence will be:
>          * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-0x10]
>          * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
> +        *
> +        * The logic here is similar to what we do in save_args()
>          */
> -       for (i =3D 0; i < min(nr_regs, 6); i++)
> -               emit_ldx(prog, BPF_DW,
> -                        i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
> -                        BPF_REG_FP,
> -                        -(stack_size - i * 8));
> +       for (i =3D 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++)=
 {
> +               arg_regs =3D (m->arg_size[i] + 7) / 8;
> +               if (nr_regs + arg_regs <=3D 6) {
> +                       for (j =3D 0; j < arg_regs; j++) {
> +                               emit_ldx(prog, BPF_DW,
> +                                        nr_regs =3D=3D 5 ? X86_REG_R9 : =
BPF_REG_1 + i,

Here too.

> +                                        BPF_REG_FP,
> +                                        -stack_size);
> +                               stack_size -=3D 8;
> +                               nr_regs++;
> +                       }
> +               } else {
> +                       stack_size -=3D 8 * arg_regs;
> +               }
> +
> +               if (nr_regs >=3D 6)
> +                       break;
> +       }
>  }
>
>  static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
> @@ -1915,7 +2043,10 @@ static int invoke_bpf_prog(const struct btf_func_m=
odel *m, u8 **pprog,
>         /* arg1: mov rdi, progs[i] */
>         emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
>         /* arg2: lea rsi, [rbp - ctx_cookie_off] */
> -       EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
> +       if (!is_imm8(-run_ctx_off))
> +               EMIT3_off32(0x48, 0x8D, 0xB5, -run_ctx_off);
> +       else
> +               EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
>
>         if (emit_rsb_call(&prog, bpf_trampoline_enter(p), prog))
>                 return -EINVAL;
> @@ -1931,7 +2062,10 @@ static int invoke_bpf_prog(const struct btf_func_m=
odel *m, u8 **pprog,
>         emit_nops(&prog, 2);
>
>         /* arg1: lea rdi, [rbp - stack_size] */
> -       EMIT4(0x48, 0x8D, 0x7D, -stack_size);
> +       if (!is_imm8(-stack_size))
> +               EMIT3_off32(0x48, 0x8D, 0xBD, -stack_size);
> +       else
> +               EMIT4(0x48, 0x8D, 0x7D, -stack_size);
>         /* arg2: progs[i]->insnsi for interpreter */
>         if (!p->jited)
>                 emit_mov_imm64(&prog, BPF_REG_2,
> @@ -1961,7 +2095,10 @@ static int invoke_bpf_prog(const struct btf_func_m=
odel *m, u8 **pprog,
>         /* arg2: mov rsi, rbx <- start time in nsec */
>         emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
>         /* arg3: lea rdx, [rbp - run_ctx_off] */
> -       EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
> +       if (!is_imm8(-run_ctx_off))
> +               EMIT3_off32(0x48, 0x8D, 0x95, -run_ctx_off);
> +       else
> +               EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
>         if (emit_rsb_call(&prog, bpf_trampoline_exit(p), prog))
>                 return -EINVAL;
>
> @@ -2113,7 +2250,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
>                                 void *func_addr)
>  {
>         int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> -       int regs_off, nregs_off, ip_off, run_ctx_off;
> +       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_=
off;
>         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
>         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
> @@ -2127,8 +2264,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
>                 if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
>                         nr_regs +=3D (m->arg_size[i] + 7) / 8 - 1;
>
> -       /* x86-64 supports up to 6 arguments. 7+ can be added in the futu=
re */
> -       if (nr_regs > 6)
> +       /* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
> +        * are passed through regs, the remains are through stack.
> +        */
> +       if (nr_regs > MAX_BPF_FUNC_ARGS)
>                 return -ENOTSUPP;
>
>         /* Generated trampoline stack layout:
> @@ -2147,7 +2286,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
>          *
>          * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
>          *
> +        * RBP - rbx_off   [ rbx value       ]  always
> +        *
>          * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
> +        *
> +        *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
> +        *                     [ ...        ]
> +        *                     [ stack_arg2 ]
> +        * RBP - arg_stack_off [ stack_arg1 ]
>          */
>
>         /* room for return value of orig_call or fentry prog */
> @@ -2167,9 +2313,25 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
>
>         ip_off =3D stack_size;
>
> +       stack_size +=3D 8;
> +       rbx_off =3D stack_size;
> +
>         stack_size +=3D (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
>         run_ctx_off =3D stack_size;
>
> +       if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
> +               stack_size +=3D (nr_regs - 6) * 8;
> +               /* make sure the stack pointer is 16-byte aligned if we
> +                * need pass arguments on stack, which means
> +                *  [stack_size + 8(rbp) + 8(rip) + 8(origin rip)]
> +                * should be 16-byte aligned. Following code depend on
> +                * that stack_size is already 8-byte aligned.
> +                */
> +               stack_size +=3D (stack_size % 16) ? 0 : 8;
> +       }
> +
> +       arg_stack_off =3D stack_size;
> +
>         if (flags & BPF_TRAMP_F_SKIP_FRAME) {
>                 /* skip patched call instruction and point orig_call to a=
ctual
>                  * body of the kernel function.
> @@ -2189,8 +2351,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
>         x86_call_depth_emit_accounting(&prog, NULL);
>         EMIT1(0x55);             /* push rbp */
>         EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
> -       EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
> -       EMIT1(0x53);             /* push rbx */
> +       if (!is_imm8(stack_size))
> +               /* sub rsp, stack_size */
> +               EMIT3_off32(0x48, 0x81, 0xEC, stack_size);
> +       else
> +               /* sub rsp, stack_size */
> +               EMIT4(0x48, 0x83, 0xEC, stack_size);
> +       /* mov QWORD PTR [rbp - rbx_off], rbx */
> +       emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
>
>         /* Store number of argument registers of the traced function:
>          *   mov rax, nr_regs
> @@ -2208,7 +2376,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
>                 emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
>         }
>
> -       save_regs(m, &prog, nr_regs, regs_off);
> +       save_args(m, &prog, regs_off, false);
>
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {
>                 /* arg1: mov rdi, im */
> @@ -2238,7 +2406,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
>         }
>
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -               restore_regs(m, &prog, nr_regs, regs_off);
> +               restore_regs(m, &prog, regs_off);
> +               save_args(m, &prog, arg_stack_off, true);
>
>                 if (flags & BPF_TRAMP_F_ORIG_STACK) {
>                         emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8)=
;
> @@ -2279,7 +2448,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
>                 }
>
>         if (flags & BPF_TRAMP_F_RESTORE_REGS)
> -               restore_regs(m, &prog, nr_regs, regs_off);
> +               restore_regs(m, &prog, regs_off);
>
>         /* This needs to be done regardless. If there were fmod_ret progr=
ams,
>          * the return value is only updated on the stack and still needs =
to be
> @@ -2298,7 +2467,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
>         if (save_ret)
>                 emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
>
> -       EMIT1(0x5B); /* pop rbx */
> +       emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
>         EMIT1(0xC9); /* leave */
>         if (flags & BPF_TRAMP_F_SKIP_FRAME)
>                 /* skip our return address and return to parent */
> --
> 2.40.1
>


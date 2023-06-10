Return-Path: <bpf+bounces-2306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C5E72A992
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 08:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6981C210CF
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB27492;
	Sat, 10 Jun 2023 06:59:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB016FBE
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 06:59:26 +0000 (UTC)
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8933AA6;
	Fri,  9 Jun 2023 23:59:21 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-565de553de1so36887957b3.0;
        Fri, 09 Jun 2023 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686380361; x=1688972361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4LbmSoVCcXkuPF23nOBx6E9waEGPvL1ezCeqpEcKxM=;
        b=AINBweBFEANXkewwYNuZexQTFlfd8ZI276O4RdA67Tw1Oc+cr5Q1tZrr+Rvs0OK3iB
         1TUjZK5gBZhwLyQSfAcikjDongB/8b1QGkJ8I1ugGJrLruTfJO/XS/PyPnS9ulpt8OCX
         WnlRrQqRdeXbfHVlSD1lHsh/2y0xqekVXYsq2JMAOKmfssyoQJmuNfJKp1DOqYw80vH4
         jxpkjWM6d70L/rLVjx4ajaPREtPtWoENNMr6aH4Ezl9y3WxZ0pe8D1rNbtr1Zf7yh98t
         bbMn2B0nw/n47N6OSJwqPGaTsqolHDiAO9HaQbshHmbXu9Jw4PCNU6qDUvGBdagJOd2x
         1//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686380361; x=1688972361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4LbmSoVCcXkuPF23nOBx6E9waEGPvL1ezCeqpEcKxM=;
        b=hPDy4x5D6if0PGF/16Z3qPLzE+pN9Kf3dBGMagdFyJnrmrSoMbuyMqvHvMdi3l9rZP
         AHZymW7Nga5WQnMXL7OsczIlczjhspVGrRv9pO0eTV+2v0h1OoxzKzhzfGZGlTMHejW4
         RdXv5LVRJ/fMaOlHWrkt7IkwfFvAnLhb99uZsdX0G/VUwTeiKEvEUvCDRjNW8o+Jp7f3
         xVWHmWO6ZTDTTeMS8CCm83lf1GGyHe2Oz2AEYtUiq0yNeTpiibtK5u/6Ae0OVZFkjexF
         quL58iPAe7zN2pr3wYAEJ1lRBAwsupYnIYZnsk1A9HEpYGVYOcNz48S/1SYJCCGk/KjQ
         xpXQ==
X-Gm-Message-State: AC+VfDw+tGXcF0jITn+hKBEqY+y58XeFoNNsRzpRscVPI1eTes41g/ZQ
	m9YmmHPuK4ztcyu7UXeQgA5slFZg48+237OklSM=
X-Google-Smtp-Source: ACHHUZ6IT404tHLeqYrHSbXkzWfC1b2gvNCuNOSsJRodZiRq+ctDlIusMI0IM9hjf0ncJqobOwPs8bAN7Sv+zqNELp4=
X-Received: by 2002:a81:6d57:0:b0:568:e69a:1178 with SMTP id
 i84-20020a816d57000000b00568e69a1178mr5432940ywc.5.1686380361027; Fri, 09 Jun
 2023 23:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230609095653.1406173-1-imagedong@tencent.com>
 <20230609095653.1406173-2-imagedong@tencent.com> <eaafd39e-9c45-98db-9bc7-15712276eec6@meta.com>
In-Reply-To: <eaafd39e-9c45-98db-9bc7-15712276eec6@meta.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 10 Jun 2023 14:59:09 +0800
Message-ID: <CADxym3YBngzS=00qH-FGF2+wOQx0=HyrZdZEkQUC7Vj-SaOORw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf, x86: allow function arguments up to
 12 for TRACING
To: Yonghong Song <yhs@meta.com>
Cc: andrii.nakryiko@gmail.com, alan.maguire@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 10, 2023 at 11:05=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 6/9/23 2:56 AM, menglong8.dong@gmail.com wrote:
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
> >
> > We use EMIT3_off32() or EMIT4() for "lea" and "sub". The range of the
> > imm in "lea" and "sub" is [-128, 127] if EMIT4() is used. Therefore,
> > we use EMIT3_off32() instead if the imm out of the range.
> >
> > It works well for the FENTRY/FEXIT/MODIFY_RETURN, I'm not sure if there
> > are other complicated cases.
>
> Just remove 'I'm not sure if there are other complicated cases'.
> Since MODIFY_RETURN is mentioned. It would be great if you can add
> a test for MODIFY_RETURN.

Right, I'll add corresponding test cases for MODIFY_RETURN.

>
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
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
> >   arch/x86/net/bpf_jit_comp.c | 125 ++++++++++++++++++++++++++++++++---=
-
> >   1 file changed, 111 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 1056bbf55b17..a767e13c8c85 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1868,7 +1868,7 @@ static void save_regs(const struct btf_func_model=
 *m, u8 **prog, int nr_regs,
> >        * mov QWORD PTR [rbp-0x10],rdi
> >        * mov QWORD PTR [rbp-0x8],rsi
> >        */
> > -     for (i =3D 0, j =3D 0; i < min(nr_regs, 6); i++) {
> > +     for (i =3D 0, j =3D 0; i < min(nr_regs, MAX_BPF_FUNC_ARGS); i++) =
{
> >               /* The arg_size is at most 16 bytes, enforced by the veri=
fier. */
> >               arg_size =3D m->arg_size[j];
> >               if (arg_size > 8) {
> > @@ -1876,10 +1876,31 @@ static void save_regs(const struct btf_func_mod=
el *m, u8 **prog, int nr_regs,
> >                       next_same_struct =3D !next_same_struct;
> >               }
> >
> > -             emit_stx(prog, bytes_to_bpf_size(arg_size),
> > -                      BPF_REG_FP,
> > -                      i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
> > -                      -(stack_size - i * 8));
> > +             if (i <=3D 5) {
> > +                     /* copy function arguments from regs into stack *=
/
> > +                     emit_stx(prog, bytes_to_bpf_size(arg_size),
> > +                              BPF_REG_FP,
> > +                              i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
> > +                              -(stack_size - i * 8));
> > +             } else {
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
> > +                     emit_ldx(prog, bytes_to_bpf_size(arg_size),
> > +                              BPF_REG_0, BPF_REG_FP,
> > +                              (i - 6) * 8 + 0x18);
> > +                     emit_stx(prog, bytes_to_bpf_size(arg_size),
> > +                              BPF_REG_FP,
> > +                              BPF_REG_0,
> > +                              -(stack_size - i * 8));
> > +             }
>
> I think we have a corner case which does not work for the above.
>
> $ cat t.c
> struct t {
>    long a, b;
> };
>
> void foo2(int a, int b, int c, int d, int e, struct t);
> void bar(struct t arg) {
>    foo2(1, 2, 3, 4, 5, arg);
> }
> $ cat run.sh
> clang -O2 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -c t.c
> $ ./run.sh
> $ llvm-objdump -d t.o
>
> t.o:    file format elf64-x86-64
>
> Disassembly of section .text:
>
> 0000000000000000 <bar>:
>         0: 48 83 ec 18                   subq    $0x18, %rsp
>         4: 48 89 f0                      movq    %rsi, %rax
>         7: 49 89 f9                      movq    %rdi, %r9
>         a: 48 89 7c 24 08                movq    %rdi, 0x8(%rsp)
>         f: 48 89 74 24 10                movq    %rsi, 0x10(%rsp)
>        14: bf 01 00 00 00                movl    $0x1, %edi
>        19: be 02 00 00 00                movl    $0x2, %esi
>        1e: ba 03 00 00 00                movl    $0x3, %edx
>        23: b9 04 00 00 00                movl    $0x4, %ecx
>        28: 41 b8 05 00 00 00             movl    $0x5, %r8d
>        2e: 50                            pushq   %rax
>        2f: 41 51                         pushq   %r9
>        31: e8 00 00 00 00                callq   0x36 <bar+0x36>
>        36: 48 83 c4 28                   addq    $0x28, %rsp
>        3a: c3                            retq
> $
>
> In this particular case, there is a struct argument (16-bytes).
> Only 5 registers are used to pass arguments instead of normal 6.
> The struct parameter is put on the stack. Basically struct
> members should be all in register or all on the stack.
>

You are right! I tested on both clang and gcc, and verified the
rule "struct members should be all in register or all on the stack".

> Not sure whether the kernel code contains similar instances
> or not (not fully using 6 registers while some parameters on stack).
> If not, I guess we do not need to support the above pattern.
>

I think we'd better support it to avoid any error
in the feature. I'll add this part in the next version.

Thanks!
Menglong Dong
> >
> >               j =3D next_same_struct ? j : j + 1;
> >       }
> > @@ -1913,6 +1934,41 @@ static void restore_regs(const struct btf_func_m=
odel *m, u8 **prog, int nr_regs,
> >       }
> >   }
> >
> > +static void prepare_origin_stack(const struct btf_func_model *m, u8 **=
prog,
> > +                              int nr_regs, int stack_size)
> > +{
> > +     int i, j, arg_size;
> > +     bool next_same_struct =3D false;
> > +
> > +     if (nr_regs <=3D 6)
> > +             return;
> > +
> > +     /* Prepare the function arguments in stack before call origin
> > +      * function. These arguments must be stored in the top of the
> > +      * stack.
> > +      */
> > +     for (i =3D 0, j =3D 0; i < min(nr_regs, MAX_BPF_FUNC_ARGS); i++) =
{
> > +             /* The arg_size is at most 16 bytes, enforced by the veri=
fier. */
> > +             arg_size =3D m->arg_size[j];
> > +             if (arg_size > 8) {
> > +                     arg_size =3D 8;
> > +                     next_same_struct =3D !next_same_struct;
> > +             }
> > +
> > +             if (i > 5) {
> > +                     emit_ldx(prog, bytes_to_bpf_size(arg_size),
> > +                              BPF_REG_0, BPF_REG_FP,
> > +                              (i - 6) * 8 + 0x18);
> > +                     emit_stx(prog, bytes_to_bpf_size(arg_size),
> > +                              BPF_REG_FP,
> > +                              BPF_REG_0,
> > +                              -(stack_size - (i - 6) * 8));
> > +             }
> > +
> > +             j =3D next_same_struct ? j : j + 1;
> > +     }
> > +}
> > +
> >   static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog=
,
> >                          struct bpf_tramp_link *l, int stack_size,
> >                          int run_ctx_off, bool save_ret)
> > @@ -1938,7 +1994,10 @@ static int invoke_bpf_prog(const struct btf_func=
_model *m, u8 **pprog,
> >       /* arg1: mov rdi, progs[i] */
> >       emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
> >       /* arg2: lea rsi, [rbp - ctx_cookie_off] */
> > -     EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
> > +     if (!is_imm8(-run_ctx_off))
> > +             EMIT3_off32(0x48, 0x8D, 0xB5, -run_ctx_off);
> > +     else
> > +             EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
> >
> >       if (emit_rsb_call(&prog, bpf_trampoline_enter(p), prog))
> >               return -EINVAL;
> > @@ -1954,7 +2013,10 @@ static int invoke_bpf_prog(const struct btf_func=
_model *m, u8 **pprog,
> >       emit_nops(&prog, 2);
> >
> >       /* arg1: lea rdi, [rbp - stack_size] */
> > -     EMIT4(0x48, 0x8D, 0x7D, -stack_size);
> > +     if (!is_imm8(-stack_size))
> > +             EMIT3_off32(0x48, 0x8D, 0xBD, -stack_size);
> > +     else
> > +             EMIT4(0x48, 0x8D, 0x7D, -stack_size);
> >       /* arg2: progs[i]->insnsi for interpreter */
> >       if (!p->jited)
> >               emit_mov_imm64(&prog, BPF_REG_2,
> > @@ -1984,7 +2046,10 @@ static int invoke_bpf_prog(const struct btf_func=
_model *m, u8 **pprog,
> >       /* arg2: mov rsi, rbx <- start time in nsec */
> >       emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
> >       /* arg3: lea rdx, [rbp - run_ctx_off] */
> > -     EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
> > +     if (!is_imm8(-run_ctx_off))
> > +             EMIT3_off32(0x48, 0x8D, 0x95, -run_ctx_off);
> > +     else
> > +             EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
> >       if (emit_rsb_call(&prog, bpf_trampoline_exit(p), prog))
> >               return -EINVAL;
> >
> > @@ -2136,7 +2201,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_=
image *im, void *image, void *i
> >                               void *func_addr)
> >   {
> >       int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> > -     int regs_off, nregs_off, ip_off, run_ctx_off;
> > +     int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_=
off;
> >       struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> >       struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> >       struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
> > @@ -2150,8 +2215,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp=
_image *im, void *image, void *i
> >               if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> >                       nr_regs +=3D (m->arg_size[i] + 7) / 8 - 1;
> >
> > -     /* x86-64 supports up to 6 arguments. 7+ can be added in the futu=
re */
> > -     if (nr_regs > 6)
> > +     /* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
> > +      * are passed through regs, the remains are through stack.
> > +      */
> > +     if (nr_regs > MAX_BPF_FUNC_ARGS)
> >               return -ENOTSUPP;
> >
> >       /* Generated trampoline stack layout:
> > @@ -2170,7 +2237,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp=
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
> > @@ -2190,9 +2264,25 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp=
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
> > +             /* make sure the stack pointer is 16-byte aligned if we
> > +              * need pass arguments on stack, which means
> > +              *  [stack_size + 8(rbp) + 8(rip) + 8(origin rip)]
> > +              * should be 16-byte aligned. Following code depend on
> > +              * that stack_size is already 8-byte aligned.
> > +              */
> > +             stack_size +=3D (stack_size % 16) ? 0 : 8;
>
> I think this is correct.
>
> > +     }
> > +
> > +     arg_stack_off =3D stack_size;
> > +
> [...]


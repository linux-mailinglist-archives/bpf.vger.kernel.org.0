Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DC75A0416
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiHXWfs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiHXWfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:35:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02633186C2
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:35:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u6so18808915eda.12
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yeIfQpnmifFCFToCfIsPnxOfpUwOTt5ClVn63zo/it4=;
        b=DX2NUy2a5XxjXjlpivaSVq4AkjkjQBRvyeA7LVdpIrcZBinLKzkhzdX/YTSsvFsknM
         Q8oRweRT+Uw2+vSeFCdEM33lMUUT2gkAicrKs0RpPnNv7fjofXAL18uB7mWRe5W/Abwq
         sbxku1Vx3uHEWqqU4zEQDSW4nBfROd5vEBkftCR8nP7/b73Lh6gHivKLyHYkKKilPeSK
         G3/u7G37v9dRKg6J7PGfK+Pamelx69Lyg0vSAlv9bALZXQBE9fcKiGz5dFhSWmAAZMvN
         5SRn4wwmyTgS94Dfg0XnGW+K27T7Xw2snoRZStHh358iQlvXGRGIbSZTRez2ZwFb+mMT
         nDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yeIfQpnmifFCFToCfIsPnxOfpUwOTt5ClVn63zo/it4=;
        b=gQNpGnE385WwtV4CAOEs57ZpIn6Y4OGG2EWz3mfjqRBc/xiXchr+RFsIapBo5nejEu
         mGmN16yWeE0mHJLk1iqo4gWCv0RgFOqka0f/slRKdAgcyFiVU5AlQaIlg/c+LNOPdEQo
         aeMvIC4faRLe8vIisJ1usGiqVgnZxPrV5+QRTezsOqcn2RWjKT9+9Jh1/jXCY9no5deM
         rTlfFtGEQjZ9yhtop6mp/Nx7/YKh2+DpSYI1FzHxKMiLxTcXRTfk45jtkQnC02wz2KXJ
         hild1seTOXUMAkY2fIveAIMe2GrjNBLWrF3fq7+fzwM1hku23vU7LdaweoZst55YMPpx
         Cbrw==
X-Gm-Message-State: ACgBeo3ql20RqZCshHcNbHhdQROFzOPbQkN7YqkKZ3ro1EL/MuHQmLjj
        2G0+qlssaWOiAPhBjJmTEfNgF1uBaSvpIjpNygKENdMHF6M=
X-Google-Smtp-Source: AA6agR7X3ySSEPHAZfrJK1sbJh2LgVeENJrCPcVskJRfZuUhHlARa95z9/nTauh7Ih8GH62V1bqP2A5vF+7zN2i6DLg=
X-Received: by 2002:a05:6402:27ca:b0:43e:ce64:ca07 with SMTP id
 c10-20020a05640227ca00b0043ece64ca07mr935584ede.66.1661380543399; Wed, 24 Aug
 2022 15:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220812052419.520522-1-yhs@fb.com> <20220812052435.523068-1-yhs@fb.com>
 <CAADnVQKvtxdSo3chBeGtv8KsoQ8drrpa7x=1sOem1kwYKr5iRw@mail.gmail.com>
 <bdb4feae-47c3-80f6-cc10-741f90c28eeb@fb.com> <20220818204428.whsirz2m6prikg7n@MacBook-Pro-3.local>
 <18c8145c-f6fb-865e-ebd7-2c0c694fdb13@fb.com>
In-Reply-To: <18c8145c-f6fb-865e-ebd7-2c0c694fdb13@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 Aug 2022 15:35:32 -0700
Message-ID: <CAADnVQLVuMX4je_4qMruPiDvGf+Uzn80Q1iFcmmunzd9hxFL8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct arguments
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 12:05 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/18/22 1:44 PM, Alexei Starovoitov wrote:
> > On Wed, Aug 17, 2022 at 09:56:23PM -0700, Yonghong Song wrote:
> >>
> >>
> >> On 8/15/22 3:44 PM, Alexei Starovoitov wrote:
> >>> On Thu, Aug 11, 2022 at 10:24 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>
> >>>> In C, struct value can be passed as a function argument.
> >>>> For small structs, struct value may be passed in
> >>>> one or more registers. For trampoline based bpf programs,
> >>>> This would cause complication since one-to-one mapping between
> >>>> function argument and arch argument register is not valid
> >>>> any more.
> >>>>
> >>>> To support struct value argument and make bpf programs
> >>>> easy to write, the bpf program function parameter is
> >>>> changed from struct type to a pointer to struct type.
> >>>> The following is a simplified example.
> >>>>
> >>>> In one of later selftests, we have a bpf_testmod function:
> >>>>       struct bpf_testmod_struct_arg_2 {
> >>>>           long a;
> >>>>           long b;
> >>>>       };
> >>>>       noinline int
> >>>>       bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 b, int c) {
> >>>>           bpf_testmod_test_struct_arg_result = a + b.a + b.b + c;
> >>>>           return bpf_testmod_test_struct_arg_result;
> >>>>       }
> >>>>
> >>>> When a bpf program is attached to the bpf_testmod function
> >>>> bpf_testmod_test_struct_arg_2(), the bpf program may look like
> >>>>       SEC("fentry/bpf_testmod_test_struct_arg_2")
> >>>>       int BPF_PROG(test_struct_arg_3, int a, struct bpf_testmod_struct_arg_2 *b, int c)
> >>>>       {
> >>>>           t2_a = a;
> >>>>           t2_b_a = b->a;
> >>>>           t2_b_b = b->b;
> >>>>           t2_c = c;
> >>>>           return 0;
> >>>>       }
> >>>>
> >>>> Basically struct value becomes a pointer to the struct.
> >>>> The trampoline stack will be increased to store the stack values and
> >>>> the pointer to these values will be saved in the stack slot corresponding
> >>>> to that argument. For x86_64, the struct size is limited up to 16 bytes
> >>>> so the struct can fit in one or two registers. The struct size of more
> >>>> than 16 bytes is not supported now as our current use case is
> >>>> for sockptr_t in the argument. We could handle such large struct's
> >>>> in the future if we have concrete use cases.
> >>>>
> >>>> The main changes are in save_regs() and restore_regs(). The following
> >>>> illustrated the trampoline asm codes for save_regs() and restore_regs().
> >>>> save_regs():
> >>>>       /* first argument */
> >>>>       mov    DWORD PTR [rbp-0x18],edi
> >>>>       /* second argument: struct, save actual values and put the pointer to the slot */
> >>>>       lea    rax,[rbp-0x40]
> >>>>       mov    QWORD PTR [rbp-0x10],rax
> >>>>       mov    QWORD PTR [rbp-0x40],rsi
> >>>>       mov    QWORD PTR [rbp-0x38],rdx
> >>>>       /* third argument */
> >>>>       mov    DWORD PTR [rbp-0x8],esi
> >>>> restore_regs():
> >>>>       mov    edi,DWORD PTR [rbp-0x18]
> >>>>       mov    rsi,QWORD PTR [rbp-0x40]
> >>>>       mov    rdx,QWORD PTR [rbp-0x38]
> >>>>       mov    esi,DWORD PTR [rbp-0x8]
> >>>
> >>> Not sure whether it was discussed before, but
> >>> why cannot we adjust the bpf side instead?
> >>> Technically struct passing between bpf progs was never
> >>> officially supported. llvm generates something.
> >>> Probably always passes by reference, but we can adjust
> >>> that behavior without breaking any programs because
> >>> we don't have bpf libraries. Programs are fully contained
> >>> in one or few files. libbpf can do static linking, but
> >>> without any actual libraries the chance of breaking
> >>> backward compat is close to zero.
> >>
> >> Agree. At this point, we don't need to worry about
> >> compatibility between bpf program and bpf program libraries.
> >>
> >>> Can we teach llvm to pass sizeof(struct) <= 16 in
> >>> two bpf registers?
> >>
> >> Yes, we can. I just hacked llvm and was able to
> >> do that.
> >>
> >>> Then we wouldn't need to have a discrepancy between
> >>> kernel function prototype and bpf fentry prog proto.
> >>> Both will have struct by value in the same spot.
> >>> The trampoline generation will be simpler for x86 and
> >>> its runtime faster too.
> >>
> >> I tested x86 and arm64 both supports two registers
> >> for a 16 byte struct.
> >>
> >>> The other architectures that pass small structs by reference
> >>> can do a bit more work in the trampoline: copy up to 16 byte
> >>> and bpf prog side will see it as they were passed in 'registers'.
> >>> wdyt?
> >>
> >> I know systemz and Hexagon will pass by reference for any
> >> struct size >= 8 bytes. Didn't complete check others.
> >>
> >> But since x86 and arm64 supports direct value passing
> >> with two registers, we should be okay. As you mentioned,
> >> we could support systemz/hexagon style of struct passing
> >> by copying the values to the stack.
> >>
> >>
> >> But I have a problem how to define a user friendly
> >> macro like BPF_PROG for user to use.
> >>
> >> Let us say, we have a program like below:
> >> SEC("fentry/bpf_testmod_test_struct_arg_1")
> >> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 *a, int b,
> >> int c) {
> >> ...
> >> }
> >>
> >> We have BPF_PROG macro definition here:
> >>
> >> #define BPF_PROG(name, args...)     \
> >> name(unsigned long long *ctx);     \
> >> static __always_inline typeof(name(0))     \
> >> ____##name(unsigned long long *ctx, ##args);     \
> >> typeof(name(0)) name(unsigned long long *ctx)     \
> >> {     \
> >>          _Pragma("GCC diagnostic push")      \
> >>          _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
> >>          return ____##name(___bpf_ctx_cast(args));      \
> >>          _Pragma("GCC diagnostic pop")      \
> >> }     \
> >> static __always_inline typeof(name(0))     \
> >> ____##name(unsigned long long *ctx, ##args)
> >>
> >> Some we have static function definition
> >>
> >> int ____test_struct_arg_1(unsigned long long *ctx, struct
> >> bpf_testmod_struct_arg_2 *a, int b, int c);
> >>
> >> But the function call inside the function test_struct_arg_1()
> >> is
> >>    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2]);
> >>
> >> We have two problems here:
> >>    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
> >> does not match the static function declaration.
> >> This is not problem if everything is int/ptr type.
> >> If one of argument is structure type, we will have
> >> type conversion problem. Let us this can be resolved
> >> somehow through some hack.
> >>
> >> More importantly, because some structure may take two
> >> registers,
> >>     ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
> >> may not be correct. In my above example, if the
> >> structure size is 16 bytes,
> >> then the actual call should be
> >>     ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2], ctx[3])
> >> So we need to provide how many extra registers are needed
> >> beyond ##args in the macro. I have not tried how to
> >> resolve this but this extra information in the macro
> >> definite is not user friendly.
> >>
> >> Not sure what is the best way to handle this issue (##args is not precise
> >> and needs addition registers for >8 struct arguments).
> >
> > The kernel is using this trick to cast 8 byte structs to u64:
> > /* cast any integer, pointer, or small struct to u64 */
> > #define UINTTYPE(size) \
> >          __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
> >                     __builtin_choose_expr(size == 2, (u16)2, \
> >                     __builtin_choose_expr(size == 4, (u32)3, \
> >                     __builtin_choose_expr(size == 8, (u64)4, \
> >                                           (void)5)))))
> > #define __CAST_TO_U64(x) ({ \
> >          typeof(x) __src = (x); \
> >          UINTTYPE(sizeof(x)) __dst; \
> >          memcpy(&__dst, &__src, sizeof(__dst)); \
> >          (u64)__dst; })
> >
> > casting 16 byte struct to two u64 can be similar.
> > Ideally we would declare bpf prog as:
> > SEC("fentry/bpf_testmod_test_struct_arg_1")
> > int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 a, int b, int c) {
> > note there is no '*'. It's struct by value.
> > The main challenge is how to do the math in the BPF_PROG macros.
> > Currently it's doing:
> > #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0]
> > #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)ctx[1]
> > #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
> > #define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), (void *)ctx[3]
> >
> > The ctx[index] is one-to-one with argument position.
> > That 'index' needs to be calculated.
> > Maybe something like UINTTYPE() that applies to previous arguments?
> > #define REG_CNT(arg) \
> >          __builtin_choose_expr(sizeof(arg) == 1,  1, \
> >          __builtin_choose_expr(sizeof(arg) == 2,  1, \
> >          __builtin_choose_expr(sizeof(arg) == 4,  1, \
> >          __builtin_choose_expr(sizeof(arg) == 8,  1, \
> >          __builtin_choose_expr(sizeof(arg) == 16,  2, \
> >                                           (void)0)))))
> >
> > #define ___bpf_reg_cnt0()            0
> > #define ___bpf_reg_cnt1(x)          ___bpf_reg_cnt0() + REG_CNT(x)
> > #define ___bpf_reg_cnt2(x, args...) ___bpf_reg_cnt1(args) + REG_CNT(x)
> > #define ___bpf_reg_cnt(args...)    ___bpf_apply(___bpf_reg_cnt, ___bpf_narg(args))(args)
> >
> > This way the macro will calculate the index inside ctx[] array.
> >
> > and then inside ___bpf_ctx_castN macro use ___bpf_reg_cnt.
> > Instead of:
> > ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
> > it will be
> > ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), \
> >    __builtin_choose_expr(sizeof(x) <= 8, (void *)ctx[___bpf_reg_cnt(args)],
> >                          *(typeof(x) *) &ctx[___bpf_reg_cnt(args)])
>
> I tried this approach. The only problem is sizeof(x) <= 8 may also be
> a structure. Since essentially we will have a type conversion like
>     (struct <name))(void *)ctx[...]
> and this won't work.

Right. Just sizeof(x) <= 8 won't work.

> So ideally we want something like
> __builtin_choose_expr(is_struct_type(x), *(typeof(x) *)
> &ctx[___bpf_reg_cnt(args)]
>      (void *)ctx[___bpf_reg_cnt(args)])
> here is_struct_type(x) tells whether the type is a struct type
> or typedef of a struct. Currently we don't have a such a macro/builtin yet.

Got it.
Maybe we can do *(typeof(x) *) &ctx[___bpf_reg_cnt(args)]
unconditionally for all args?
Only endianness will be an issue.

> Note that in order to make sizeof(x) or is_struct_type(x) work, we
> need to separate type and argument name like
>
> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, int,
> b, int, c)

agree.

> Which will make the macro incompatible with existing BPF_PROG macro.

right. we need a new macro regardless.

> >
> > x - is one of the arguments.
> > args - all args before 'x'. Doing __bpf_reg_cnt on them should calculate the index.
> > *(typeof(x) *)& should type cast to struct of 16 bytes.
> >
> > Rough idea, of course.
> >
> > Another alternative is instead of:
> > #define BPF_PROG(name, args...)
> > name(unsigned long long *ctx);
> > do:
> > #define BPF_PROG(name, args...)
> > struct XX {
> >    macro inserts all 'args' here separated by ; so it becomes a proper struct
> > };
> > name(struct XX *ctx);
> >
> > and then instead of doing ___bpf_ctx_castN for each argument
> > do single cast of all of 'u64 ctx[N]' passed from fentry into 'struct XX *'.
> > The problem with this approach that small args like char, short, int needs to
> > be declared in struct XX with __align__(8).
>
> This should work. But since we will change context type from
> "unsigned long long *" to "struct XX *", the code pattern will look like
>
> BPF_PROG2_DECL(test_struct_arg_1);
> SEC("fentry/bpf_testmod_test_struct_arg_1")
> int BPF_PROG2(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a,
> int, b, int, c)
>
> Where BPF_PROG2_DECL will provide a forward declaration like
> #define BPF_PROG2_DECL(name) struct _____##name;
>
> and BPF_PROG2 will look like (not handling zero argument yere)
>
> #define BPF_PROG2(name, args...)                                      \
> name(struct _____##name *ctx);                                        \
> struct _____##name {                                                  \
>         ___bpf_ctx_field(args)                                         \
> };                                                                    \
> static __always_inline typeof(name(0))                                \
> ____##name(struct _____##name *ctx, ___bpf_ctx_decl(args));           \
> typeof(name(0)) name(struct _____##name *ctx)                         \
> {                                                                     \
>         return ____##name(ctx, ___bpf_ctx_arg(args));                  \
> }                                                                     \
> static __always_inline typeof(name(0))                                \
> ____##name(struct _____##name *ctx, ___bpf_ctx_decl(args))
>
> where __bpf_ctx_field(args) will generate
>     struct bpf_testmod_struct_arg_2 a;
>     int b;
>     int c;
>
> ___bpf_ctx_arg(args) will generate
>     ctx->a, ctx->b, ctx->c
>
> and ___bpf_ctx_decl(args) will generate proper argument prototypes
> the same way as in BPF_PROG macro.

Great that 2nd approach works :)
If 1st approach can be made to work we won't need
additional line BPF_PROG2_DECL(test_struct_arg_1);
right?

Either way we can start with 2nd approach and improve on it later.

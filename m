Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7E598E4E
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245074AbiHRUof (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 16:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbiHRUof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 16:44:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB965C88AC
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 13:44:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x23so2467557pll.7
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=UEUfKj9POnwJlUk9SI5X2MucGg92y6+ecaD4KYdICTw=;
        b=TB6SQ2bQdCqMZHHL1EPMWPvaWqwZdRPCHecaAaL4fe54aOkwg0jZStuFFMhzDuYeQ1
         Ac1z7Q/PvXlMQsD2XL0dkkqw3LazgZrJrhtaeZtBPMo2mJiT1CZIt/OgVmNbSM6iGC7/
         m4pnqJWuxTU/yDIxhRC7H4oqEQQp2ClTIziMHyRpZwarI15UnhzeqbJ1kLhJe97O25xJ
         eJb/NjMzs5iQgD3kJGfCdSt2FV6MxOcm9OK0+3PFQuz2sEHLWGr8L+j6ybDVfWkVn/2V
         8vd21SObviQwqUts5JXKrmiAu+7SeDx9hXeEtgHlJxOYyP2P16qm9O5n4I9GVcqZx7Ol
         tfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UEUfKj9POnwJlUk9SI5X2MucGg92y6+ecaD4KYdICTw=;
        b=sxaZp+FZXX0EEUkSWfr9dyYevTZlTEaFhXTkMfIfKPnP0UabwdtstgDnUqXoQ2MjtZ
         J/NKAxWEMAFRKZQCh86ZlDe82slFz9jN3yXsCvVRxNxSD+Fo8mHu2+VPJ5D26JhxRYrB
         rJP43JvK+MN6K7R4Y+oD+4Ekbzk8B3YYQcgkh1cB0R2UItVrnfib4AfaaZ412ws+wqN+
         IL0n5/zXTrCuZMcbhbymVru5CzwLFvjyWteCmRH9n5rqAcFFN7DjvTQF8JLABOt11Ekv
         JdWf++ql8H2Parbc/8htCa18fpOmqC4ri9ZtXnLUQLPWJaLergzakbzYggN0EStqDSAk
         T7yg==
X-Gm-Message-State: ACgBeo0fvg6IdaaTVwVwEiLoZjRbESDxeMHlrYLxFpWKNKGFKxTiH2f4
        UqLv3bT+WlrQGELovsrxoT/Ii+TBj/I=
X-Google-Smtp-Source: AA6agR5xWfCqnYMnPHOP+34RwMeVS8uJHmyddQBMmjMSBzC7tRfkCW1MLMr1jBCWJdFD7Ixou+9U6Q==
X-Received: by 2002:a17:902:b182:b0:16e:e4ad:360c with SMTP id s2-20020a170902b18200b0016ee4ad360cmr4112951plr.21.1660855471499;
        Thu, 18 Aug 2022 13:44:31 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::1:aa5c])
        by smtp.gmail.com with ESMTPSA id n28-20020aa7985c000000b0052e6854e665sm2062955pfq.109.2022.08.18.13.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:44:30 -0700 (PDT)
Date:   Thu, 18 Aug 2022 13:44:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct
 arguments
Message-ID: <20220818204428.whsirz2m6prikg7n@MacBook-Pro-3.local>
References: <20220812052419.520522-1-yhs@fb.com>
 <20220812052435.523068-1-yhs@fb.com>
 <CAADnVQKvtxdSo3chBeGtv8KsoQ8drrpa7x=1sOem1kwYKr5iRw@mail.gmail.com>
 <bdb4feae-47c3-80f6-cc10-741f90c28eeb@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb4feae-47c3-80f6-cc10-741f90c28eeb@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 09:56:23PM -0700, Yonghong Song wrote:
> 
> 
> On 8/15/22 3:44 PM, Alexei Starovoitov wrote:
> > On Thu, Aug 11, 2022 at 10:24 PM Yonghong Song <yhs@fb.com> wrote:
> > > 
> > > In C, struct value can be passed as a function argument.
> > > For small structs, struct value may be passed in
> > > one or more registers. For trampoline based bpf programs,
> > > This would cause complication since one-to-one mapping between
> > > function argument and arch argument register is not valid
> > > any more.
> > > 
> > > To support struct value argument and make bpf programs
> > > easy to write, the bpf program function parameter is
> > > changed from struct type to a pointer to struct type.
> > > The following is a simplified example.
> > > 
> > > In one of later selftests, we have a bpf_testmod function:
> > >      struct bpf_testmod_struct_arg_2 {
> > >          long a;
> > >          long b;
> > >      };
> > >      noinline int
> > >      bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 b, int c) {
> > >          bpf_testmod_test_struct_arg_result = a + b.a + b.b + c;
> > >          return bpf_testmod_test_struct_arg_result;
> > >      }
> > > 
> > > When a bpf program is attached to the bpf_testmod function
> > > bpf_testmod_test_struct_arg_2(), the bpf program may look like
> > >      SEC("fentry/bpf_testmod_test_struct_arg_2")
> > >      int BPF_PROG(test_struct_arg_3, int a, struct bpf_testmod_struct_arg_2 *b, int c)
> > >      {
> > >          t2_a = a;
> > >          t2_b_a = b->a;
> > >          t2_b_b = b->b;
> > >          t2_c = c;
> > >          return 0;
> > >      }
> > > 
> > > Basically struct value becomes a pointer to the struct.
> > > The trampoline stack will be increased to store the stack values and
> > > the pointer to these values will be saved in the stack slot corresponding
> > > to that argument. For x86_64, the struct size is limited up to 16 bytes
> > > so the struct can fit in one or two registers. The struct size of more
> > > than 16 bytes is not supported now as our current use case is
> > > for sockptr_t in the argument. We could handle such large struct's
> > > in the future if we have concrete use cases.
> > > 
> > > The main changes are in save_regs() and restore_regs(). The following
> > > illustrated the trampoline asm codes for save_regs() and restore_regs().
> > > save_regs():
> > >      /* first argument */
> > >      mov    DWORD PTR [rbp-0x18],edi
> > >      /* second argument: struct, save actual values and put the pointer to the slot */
> > >      lea    rax,[rbp-0x40]
> > >      mov    QWORD PTR [rbp-0x10],rax
> > >      mov    QWORD PTR [rbp-0x40],rsi
> > >      mov    QWORD PTR [rbp-0x38],rdx
> > >      /* third argument */
> > >      mov    DWORD PTR [rbp-0x8],esi
> > > restore_regs():
> > >      mov    edi,DWORD PTR [rbp-0x18]
> > >      mov    rsi,QWORD PTR [rbp-0x40]
> > >      mov    rdx,QWORD PTR [rbp-0x38]
> > >      mov    esi,DWORD PTR [rbp-0x8]
> > 
> > Not sure whether it was discussed before, but
> > why cannot we adjust the bpf side instead?
> > Technically struct passing between bpf progs was never
> > officially supported. llvm generates something.
> > Probably always passes by reference, but we can adjust
> > that behavior without breaking any programs because
> > we don't have bpf libraries. Programs are fully contained
> > in one or few files. libbpf can do static linking, but
> > without any actual libraries the chance of breaking
> > backward compat is close to zero.
> 
> Agree. At this point, we don't need to worry about
> compatibility between bpf program and bpf program libraries.
> 
> > Can we teach llvm to pass sizeof(struct) <= 16 in
> > two bpf registers?
> 
> Yes, we can. I just hacked llvm and was able to
> do that.
> 
> > Then we wouldn't need to have a discrepancy between
> > kernel function prototype and bpf fentry prog proto.
> > Both will have struct by value in the same spot.
> > The trampoline generation will be simpler for x86 and
> > its runtime faster too.
> 
> I tested x86 and arm64 both supports two registers
> for a 16 byte struct.
> 
> > The other architectures that pass small structs by reference
> > can do a bit more work in the trampoline: copy up to 16 byte
> > and bpf prog side will see it as they were passed in 'registers'.
> > wdyt?
> 
> I know systemz and Hexagon will pass by reference for any
> struct size >= 8 bytes. Didn't complete check others.
> 
> But since x86 and arm64 supports direct value passing
> with two registers, we should be okay. As you mentioned,
> we could support systemz/hexagon style of struct passing
> by copying the values to the stack.
> 
> 
> But I have a problem how to define a user friendly
> macro like BPF_PROG for user to use.
> 
> Let us say, we have a program like below:
> SEC("fentry/bpf_testmod_test_struct_arg_1")
> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 *a, int b,
> int c) {
> ...
> }
> 
> We have BPF_PROG macro definition here:
> 
> #define BPF_PROG(name, args...)     \
> name(unsigned long long *ctx);     \
> static __always_inline typeof(name(0))     \
> ____##name(unsigned long long *ctx, ##args);     \
> typeof(name(0)) name(unsigned long long *ctx)     \
> {     \
>         _Pragma("GCC diagnostic push")      \
>         _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
>         return ____##name(___bpf_ctx_cast(args));      \
>         _Pragma("GCC diagnostic pop")      \
> }     \
> static __always_inline typeof(name(0))     \
> ____##name(unsigned long long *ctx, ##args)
> 
> Some we have static function definition
> 
> int ____test_struct_arg_1(unsigned long long *ctx, struct
> bpf_testmod_struct_arg_2 *a, int b, int c);
> 
> But the function call inside the function test_struct_arg_1()
> is
>   ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2]);
> 
> We have two problems here:
>   ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
> does not match the static function declaration.
> This is not problem if everything is int/ptr type.
> If one of argument is structure type, we will have
> type conversion problem. Let us this can be resolved
> somehow through some hack.
> 
> More importantly, because some structure may take two
> registers,
>    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
> may not be correct. In my above example, if the
> structure size is 16 bytes,
> then the actual call should be
>    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2], ctx[3])
> So we need to provide how many extra registers are needed
> beyond ##args in the macro. I have not tried how to
> resolve this but this extra information in the macro
> definite is not user friendly.
> 
> Not sure what is the best way to handle this issue (##args is not precise
> and needs addition registers for >8 struct arguments).

The kernel is using this trick to cast 8 byte structs to u64:
/* cast any integer, pointer, or small struct to u64 */
#define UINTTYPE(size) \
        __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
                   __builtin_choose_expr(size == 2, (u16)2, \
                   __builtin_choose_expr(size == 4, (u32)3, \
                   __builtin_choose_expr(size == 8, (u64)4, \
                                         (void)5)))))
#define __CAST_TO_U64(x) ({ \
        typeof(x) __src = (x); \
        UINTTYPE(sizeof(x)) __dst; \
        memcpy(&__dst, &__src, sizeof(__dst)); \
        (u64)__dst; })

casting 16 byte struct to two u64 can be similar.
Ideally we would declare bpf prog as:
SEC("fentry/bpf_testmod_test_struct_arg_1")
int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 a, int b, int c) {
note there is no '*'. It's struct by value.
The main challenge is how to do the math in the BPF_PROG macros.
Currently it's doing:
#define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0]
#define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)ctx[1]
#define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
#define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), (void *)ctx[3]

The ctx[index] is one-to-one with argument position.
That 'index' needs to be calculated.
Maybe something like UINTTYPE() that applies to previous arguments?
#define REG_CNT(arg) \
        __builtin_choose_expr(sizeof(arg) == 1,  1, \
        __builtin_choose_expr(sizeof(arg) == 2,  1, \
        __builtin_choose_expr(sizeof(arg) == 4,  1, \
        __builtin_choose_expr(sizeof(arg) == 8,  1, \
        __builtin_choose_expr(sizeof(arg) == 16,  2, \
                                         (void)0)))))

#define ___bpf_reg_cnt0()            0
#define ___bpf_reg_cnt1(x)          ___bpf_reg_cnt0() + REG_CNT(x)
#define ___bpf_reg_cnt2(x, args...) ___bpf_reg_cnt1(args) + REG_CNT(x)
#define ___bpf_reg_cnt(args...)    ___bpf_apply(___bpf_reg_cnt, ___bpf_narg(args))(args)

This way the macro will calculate the index inside ctx[] array.

and then inside ___bpf_ctx_castN macro use ___bpf_reg_cnt.
Instead of:
___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
it will be
___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), \
  __builtin_choose_expr(sizeof(x) <= 8, (void *)ctx[___bpf_reg_cnt(args)],
                        *(typeof(x) *) &ctx[___bpf_reg_cnt(args)])

x - is one of the arguments.
args - all args before 'x'. Doing __bpf_reg_cnt on them should calculate the index.
*(typeof(x) *)& should type cast to struct of 16 bytes.

Rough idea, of course.

Another alternative is instead of:
#define BPF_PROG(name, args...)
name(unsigned long long *ctx);
do:
#define BPF_PROG(name, args...)
struct XX {
  macro inserts all 'args' here separated by ; so it becomes a proper struct
};
name(struct XX *ctx);

and then instead of doing ___bpf_ctx_castN for each argument
do single cast of all of 'u64 ctx[N]' passed from fentry into 'struct XX *'.
The problem with this approach that small args like char, short, int needs to
be declared in struct XX with __align__(8).

Both approaches may be workable?

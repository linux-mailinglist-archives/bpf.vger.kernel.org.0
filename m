Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAD75A01C7
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 21:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiHXTGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 15:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiHXTGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 15:06:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118DFEE39
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 12:05:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w19so35358050ejc.7
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DqXBBH7vTXr9e67ZBlizfMdbKZIBi8UhWj7ZLQ6FHh8=;
        b=EjZhxMJ51cC3EquU5kzw8knjszICA4SZoQV8X3j7TcqdPnquYHecsIRZdDj+Z3SnRT
         iylXxvQySbW7LWdTgyAtgLTanzRk8gvmsyRLyO2GQDOUIKRLc/YgypT8j8rifHh7/LYX
         OF+78DUhPuOLQ4oa14Kq3q2M6rP5b9U6oCs4PUzHaa1PWhHOLtDJ8GYQPjtNrvijEGW6
         k67iSkNgoW7CwsoY0IsMGyay3vlOBII2B7KuJz2uzB/yZ3sLXvKxaoodVhSVG2UOvEYc
         A5fpzBHECbRhg5R0Hk6A2ssKqtzh+2292Gg/RhZGel/u9K3LsnOyJLnVLBQW+eQcmhO1
         77Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DqXBBH7vTXr9e67ZBlizfMdbKZIBi8UhWj7ZLQ6FHh8=;
        b=d18HNeZJX0LSyuQRlngB3InzzIhR/i8dnU8hrZiTrn+k5f43IiiPbNQ5WkZXEAEXO3
         2oPYCeeCRvmflAbmsnn4ZL/0E3UanLh4rD0sZDajiL/s6rzmJuI1PjEsWIgpkzRnAoze
         dwywehcqn7/zOdM38LFNJPBHvVHNNgOKY+8agMg3tAIAmxytFndy4129YGWn0odrSsIA
         FLXo6L3mKZeFloZzO//LsNIgRYLjU476+CBmY5eKSdxsDBs4u2DaI5wDBJnPG9AKooPe
         7uPS5twEJsWKQji9hmysN+1fo92jXUSZgEBOE4jV0/wr7wXJTkiTq/2MZZFHwUzzrGf2
         7UcQ==
X-Gm-Message-State: ACgBeo1K5t4Htc/BaMDeYMdDYQelAXvNatYHH+wHf5T1n5LhLLmaK8B1
        4RxhNdVBxb6YLtwJqxn0HBUVpd3udbKxD0/79Wc=
X-Google-Smtp-Source: AA6agR5zNXCdwjMAaMfpCCmOZWlGV3tXOcc/br+JpoK8R5nV53jkD4fDSBUWtaI+ZaddmvmyFFTzyynSlDsZNljXrag=
X-Received: by 2002:a17:907:7e9e:b0:73d:ae12:5f11 with SMTP id
 qb30-20020a1709077e9e00b0073dae125f11mr254651ejc.176.1661367957509; Wed, 24
 Aug 2022 12:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220812052419.520522-1-yhs@fb.com> <20220812052435.523068-1-yhs@fb.com>
 <CAADnVQKvtxdSo3chBeGtv8KsoQ8drrpa7x=1sOem1kwYKr5iRw@mail.gmail.com>
 <bdb4feae-47c3-80f6-cc10-741f90c28eeb@fb.com> <20220818204428.whsirz2m6prikg7n@MacBook-Pro-3.local>
In-Reply-To: <20220818204428.whsirz2m6prikg7n@MacBook-Pro-3.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Aug 2022 12:05:46 -0700
Message-ID: <CAEf4BzZOGWFxGOD8hMH9v4gJPGv0tf5464Aa0DivDFrRhenx0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct arguments
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Thu, Aug 18, 2022 at 1:44 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 17, 2022 at 09:56:23PM -0700, Yonghong Song wrote:
> >
> >
> > On 8/15/22 3:44 PM, Alexei Starovoitov wrote:
> > > On Thu, Aug 11, 2022 at 10:24 PM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > > In C, struct value can be passed as a function argument.
> > > > For small structs, struct value may be passed in
> > > > one or more registers. For trampoline based bpf programs,
> > > > This would cause complication since one-to-one mapping between
> > > > function argument and arch argument register is not valid
> > > > any more.
> > > >
> > > > To support struct value argument and make bpf programs
> > > > easy to write, the bpf program function parameter is
> > > > changed from struct type to a pointer to struct type.
> > > > The following is a simplified example.
> > > >
> > > > In one of later selftests, we have a bpf_testmod function:
> > > >      struct bpf_testmod_struct_arg_2 {
> > > >          long a;
> > > >          long b;
> > > >      };
> > > >      noinline int
> > > >      bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 b, int c) {
> > > >          bpf_testmod_test_struct_arg_result = a + b.a + b.b + c;
> > > >          return bpf_testmod_test_struct_arg_result;
> > > >      }
> > > >
> > > > When a bpf program is attached to the bpf_testmod function
> > > > bpf_testmod_test_struct_arg_2(), the bpf program may look like
> > > >      SEC("fentry/bpf_testmod_test_struct_arg_2")
> > > >      int BPF_PROG(test_struct_arg_3, int a, struct bpf_testmod_struct_arg_2 *b, int c)
> > > >      {
> > > >          t2_a = a;
> > > >          t2_b_a = b->a;
> > > >          t2_b_b = b->b;
> > > >          t2_c = c;
> > > >          return 0;
> > > >      }
> > > >
> > > > Basically struct value becomes a pointer to the struct.
> > > > The trampoline stack will be increased to store the stack values and
> > > > the pointer to these values will be saved in the stack slot corresponding
> > > > to that argument. For x86_64, the struct size is limited up to 16 bytes
> > > > so the struct can fit in one or two registers. The struct size of more
> > > > than 16 bytes is not supported now as our current use case is
> > > > for sockptr_t in the argument. We could handle such large struct's
> > > > in the future if we have concrete use cases.
> > > >
> > > > The main changes are in save_regs() and restore_regs(). The following
> > > > illustrated the trampoline asm codes for save_regs() and restore_regs().
> > > > save_regs():
> > > >      /* first argument */
> > > >      mov    DWORD PTR [rbp-0x18],edi
> > > >      /* second argument: struct, save actual values and put the pointer to the slot */
> > > >      lea    rax,[rbp-0x40]
> > > >      mov    QWORD PTR [rbp-0x10],rax
> > > >      mov    QWORD PTR [rbp-0x40],rsi
> > > >      mov    QWORD PTR [rbp-0x38],rdx
> > > >      /* third argument */
> > > >      mov    DWORD PTR [rbp-0x8],esi
> > > > restore_regs():
> > > >      mov    edi,DWORD PTR [rbp-0x18]
> > > >      mov    rsi,QWORD PTR [rbp-0x40]
> > > >      mov    rdx,QWORD PTR [rbp-0x38]
> > > >      mov    esi,DWORD PTR [rbp-0x8]
> > >
> > > Not sure whether it was discussed before, but
> > > why cannot we adjust the bpf side instead?
> > > Technically struct passing between bpf progs was never
> > > officially supported. llvm generates something.
> > > Probably always passes by reference, but we can adjust
> > > that behavior without breaking any programs because
> > > we don't have bpf libraries. Programs are fully contained
> > > in one or few files. libbpf can do static linking, but
> > > without any actual libraries the chance of breaking
> > > backward compat is close to zero.
> >
> > Agree. At this point, we don't need to worry about
> > compatibility between bpf program and bpf program libraries.
> >
> > > Can we teach llvm to pass sizeof(struct) <= 16 in
> > > two bpf registers?
> >
> > Yes, we can. I just hacked llvm and was able to
> > do that.
> >
> > > Then we wouldn't need to have a discrepancy between
> > > kernel function prototype and bpf fentry prog proto.
> > > Both will have struct by value in the same spot.
> > > The trampoline generation will be simpler for x86 and
> > > its runtime faster too.
> >
> > I tested x86 and arm64 both supports two registers
> > for a 16 byte struct.
> >
> > > The other architectures that pass small structs by reference
> > > can do a bit more work in the trampoline: copy up to 16 byte
> > > and bpf prog side will see it as they were passed in 'registers'.
> > > wdyt?
> >
> > I know systemz and Hexagon will pass by reference for any
> > struct size >= 8 bytes. Didn't complete check others.
> >
> > But since x86 and arm64 supports direct value passing
> > with two registers, we should be okay. As you mentioned,
> > we could support systemz/hexagon style of struct passing
> > by copying the values to the stack.
> >
> >
> > But I have a problem how to define a user friendly
> > macro like BPF_PROG for user to use.
> >
> > Let us say, we have a program like below:
> > SEC("fentry/bpf_testmod_test_struct_arg_1")
> > int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 *a, int b,
> > int c) {
> > ...
> > }
> >
> > We have BPF_PROG macro definition here:
> >
> > #define BPF_PROG(name, args...)     \
> > name(unsigned long long *ctx);     \
> > static __always_inline typeof(name(0))     \
> > ____##name(unsigned long long *ctx, ##args);     \
> > typeof(name(0)) name(unsigned long long *ctx)     \
> > {     \
> >         _Pragma("GCC diagnostic push")      \
> >         _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
> >         return ____##name(___bpf_ctx_cast(args));      \
> >         _Pragma("GCC diagnostic pop")      \
> > }     \
> > static __always_inline typeof(name(0))     \
> > ____##name(unsigned long long *ctx, ##args)
> >
> > Some we have static function definition
> >
> > int ____test_struct_arg_1(unsigned long long *ctx, struct
> > bpf_testmod_struct_arg_2 *a, int b, int c);
> >
> > But the function call inside the function test_struct_arg_1()
> > is
> >   ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2]);
> >
> > We have two problems here:
> >   ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
> > does not match the static function declaration.
> > This is not problem if everything is int/ptr type.
> > If one of argument is structure type, we will have
> > type conversion problem. Let us this can be resolved
> > somehow through some hack.
> >
> > More importantly, because some structure may take two
> > registers,
> >    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
> > may not be correct. In my above example, if the
> > structure size is 16 bytes,
> > then the actual call should be
> >    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2], ctx[3])
> > So we need to provide how many extra registers are needed
> > beyond ##args in the macro. I have not tried how to
> > resolve this but this extra information in the macro
> > definite is not user friendly.
> >
> > Not sure what is the best way to handle this issue (##args is not precise
> > and needs addition registers for >8 struct arguments).
>
> The kernel is using this trick to cast 8 byte structs to u64:
> /* cast any integer, pointer, or small struct to u64 */
> #define UINTTYPE(size) \
>         __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
>                    __builtin_choose_expr(size == 2, (u16)2, \
>                    __builtin_choose_expr(size == 4, (u32)3, \
>                    __builtin_choose_expr(size == 8, (u64)4, \
>                                          (void)5)))))
> #define __CAST_TO_U64(x) ({ \
>         typeof(x) __src = (x); \
>         UINTTYPE(sizeof(x)) __dst; \
>         memcpy(&__dst, &__src, sizeof(__dst)); \
>         (u64)__dst; })
>
> casting 16 byte struct to two u64 can be similar.
> Ideally we would declare bpf prog as:
> SEC("fentry/bpf_testmod_test_struct_arg_1")
> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 a, int b, int c) {
> note there is no '*'. It's struct by value.

Agree. So I tried to compile this:

$ git diff
diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c
b/tools/testing/selftests/bpf/progs/test_vmlinux.c
index e9dfa0313d1b..dccb9ae9801f 100644
--- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
+++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
@@ -15,6 +15,16 @@ bool tp_btf_called = false;
 bool kprobe_called = false;
 bool fentry_called = false;

+typedef struct {
+       void *x;
+       int t;
+} sockptr;
+
+static int blah(sockptr x)
+{
+       return x.t;
+}
+
 SEC("tp/syscalls/sys_enter_nanosleep")
 int handle__tp(struct trace_event_raw_sys_enter *args)
 {
@@ -30,7 +40,14 @@ int handle__tp(struct trace_event_raw_sys_enter *args)
                return 0;

        tp_called = true;
-       return 0;
+
+       return blah(({ union {
+               struct { u64 x, y; } z;
+               sockptr s;
+               } tmp = {.z = {0, 1}};
+
+               tmp.s;
+       }));
 }

 SEC("raw_tp/sys_enter")


And it compiled. So I think it's possible to do u64 to struct
conversion using this approach.
We'd have to define two variations of macro -- one for structs <= 8
bytes, another for structs > 8 and <= 16 bytes. One will "consume"
single ctx[] slot, another -- will consume both. And then each variant
knows which other macro to refer to after itself.

A bit of macro hackery, but it should work.


> The main challenge is how to do the math in the BPF_PROG macros.
> Currently it's doing:
> #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0]
> #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)ctx[1]
> #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
> #define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), (void *)ctx[3]
>
> The ctx[index] is one-to-one with argument position.
> That 'index' needs to be calculated.
> Maybe something like UINTTYPE() that applies to previous arguments?
> #define REG_CNT(arg) \
>         __builtin_choose_expr(sizeof(arg) == 1,  1, \
>         __builtin_choose_expr(sizeof(arg) == 2,  1, \
>         __builtin_choose_expr(sizeof(arg) == 4,  1, \
>         __builtin_choose_expr(sizeof(arg) == 8,  1, \
>         __builtin_choose_expr(sizeof(arg) == 16,  2, \
>                                          (void)0)))))
>
> #define ___bpf_reg_cnt0()            0
> #define ___bpf_reg_cnt1(x)          ___bpf_reg_cnt0() + REG_CNT(x)
> #define ___bpf_reg_cnt2(x, args...) ___bpf_reg_cnt1(args) + REG_CNT(x)
> #define ___bpf_reg_cnt(args...)    ___bpf_apply(___bpf_reg_cnt, ___bpf_narg(args))(args)
>
> This way the macro will calculate the index inside ctx[] array.
>
> and then inside ___bpf_ctx_castN macro use ___bpf_reg_cnt.
> Instead of:
> ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
> it will be
> ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), \
>   __builtin_choose_expr(sizeof(x) <= 8, (void *)ctx[___bpf_reg_cnt(args)],
>                         *(typeof(x) *) &ctx[___bpf_reg_cnt(args)])
>
> x - is one of the arguments.
> args - all args before 'x'. Doing __bpf_reg_cnt on them should calculate the index.
> *(typeof(x) *)& should type cast to struct of 16 bytes.
>
> Rough idea, of course.
>
> Another alternative is instead of:
> #define BPF_PROG(name, args...)
> name(unsigned long long *ctx);
> do:
> #define BPF_PROG(name, args...)
> struct XX {
>   macro inserts all 'args' here separated by ; so it becomes a proper struct
> };
> name(struct XX *ctx);
>
> and then instead of doing ___bpf_ctx_castN for each argument
> do single cast of all of 'u64 ctx[N]' passed from fentry into 'struct XX *'.
> The problem with this approach that small args like char, short, int needs to
> be declared in struct XX with __align__(8).
>
> Both approaches may be workable?

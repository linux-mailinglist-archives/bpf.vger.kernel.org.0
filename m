Return-Path: <bpf+bounces-26126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6359E89B2F7
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 18:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE25B22311
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57A33B78B;
	Sun,  7 Apr 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIX3LiWb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013631A89
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507437; cv=none; b=f6UFnUs4di165lSuiz9Jd2hgWapHOr99lwvwIlIk9RgVtaUwK6iGWvXgE5Dn1jtLawkirqsGQoPYM0BhU7sos6m9nEgLBSJCF62pLyHg+825siqoBpk5VSCx5mQ/CuWMml53rWrMcGECr6u8yQJp3aaJ8DI1i398ulknJGcITyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507437; c=relaxed/simple;
	bh=wduzOg2MGbzX72R9tCnhrFjE8vipqd06W6vk2t9cxVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFxDLsPlu0OP+AI0wIAXX39Brr41LZf2E9fvKcSeCBskuk2BYqw3U3WLfsKjlLt/NjOL7rE85KCI5BI+saImmm5gENNuBOSeZLVfPSJNDc8wltzJWHfQTdgpmoW7DXBu3ZdDK8QT2gJAJGexH9qER6NtYFdeEBKoCfoZzBaZ7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIX3LiWb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4162b74f2a1so21933715e9.3
        for <bpf@vger.kernel.org>; Sun, 07 Apr 2024 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712507433; x=1713112233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DA4vh8rRvjZ73432wJy1qSqMX4KYtJJRyVVPFHW8XQ=;
        b=nIX3LiWb+e3rt/WDjequsWyTQRD6ejNlg6yTI3FPdxKumY6kxFqnTDMUL1MpF8fR9f
         6FNefej4/1UakylGtyXSxxH0jF4Xpp5EmIVjhgXluEwDdwe499YaCU9MlHOvx0oM1rPI
         jqzuZ+rzwj1ahBxrxYBBNAjvDBONWNqV5d6AzUnyExy9UbdHNWpLa+7ugdRYR84P2ZI9
         xI/rHE5Bw9IPU3mgbHIWABgI2xvH+6A1VKPCClCJoc3cME/SLf5QyNu/MhVlxojJkZAn
         DnupaUDsFs95Ri5Igma12zqA8+ceizdCrhlJi1id/wVmTuGJYnnPiZLlUM+LfLOCTaxi
         zI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712507433; x=1713112233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DA4vh8rRvjZ73432wJy1qSqMX4KYtJJRyVVPFHW8XQ=;
        b=qy9Ljq1arsN64UiSwQoiLeaezHuCkLb98TJOAl174O77eeBd1l7vOynVW9/JLgg5B0
         aPTZq8qEYE+6r2Nj79qq3PZ72Jk6GpnoyRrLcacLtHlIPZ1Etck0Dl3GxKNHJQYM1AAy
         JITHiKJYHHu7bfhWBeRqdJzp3+Cjsz1HBONtfq3b0NdSqTEkCbZEiovsRAGgqgwL2jdw
         kmqOk2gHe0iOKliiwGDglodKukQ1NMQAsAyy1XnslbyCWSmQQ7Ci2OfKn765d3d5wmhT
         5kmJUch6UCqAIQmkJdb9hIB7qTtnhJex95KRfN6OeP76vcBOaflgb8SjPJ4e5/s1IvDP
         s7ow==
X-Gm-Message-State: AOJu0Ywa4BLHvS7A36Doxt6IO9maEomTfLwRiwWhS8vD1dF6o7AvH0fV
	hsn5XcUEJxsdttXHPaNB+M/eZB2K3ZIO7L9r5jW6YlPZZcyho2sirz8aLYtr+bQVxYxlwi2PG1b
	3aTkaw/Hb15BmBWUpXuK7ibdXR3A=
X-Google-Smtp-Source: AGHT+IHdloIGJusQtBHNmBhW7A5KkNz+OwMGOUZ0zLlnzbXl6e3Hqrl6jQbw1/V+MSes7+lgM/vyV7cSR8PZBlgdofc=
X-Received: by 2002:a05:600c:470d:b0:416:6b95:fc89 with SMTP id
 v13-20020a05600c470d00b004166b95fc89mr684119wmo.1.1712507433119; Sun, 07 Apr
 2024 09:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402152638.31377-1-hffilwlqm@gmail.com> <20240402152638.31377-3-hffilwlqm@gmail.com>
 <CAADnVQ+vJyi6JFsck8KbyxvOuRvmAO5gVTJPwNiyNeBwzsHu9Q@mail.gmail.com> <55442238-33d6-4e7d-9dd1-e36da20f7c90@gmail.com>
In-Reply-To: <55442238-33d6-4e7d-9dd1-e36da20f7c90@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 7 Apr 2024 09:30:21 -0700
Message-ID: <CAADnVQKxnEBS7JxK8YqXaa1C0kZZ=KSyPmqiE79KuZbe8Y_7YA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Pu Lehui <pulehui@huawei.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 4:34=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
>
> On 2024/4/5 09:03, Alexei Starovoitov wrote:
> >>   * Solution changes from percpu tail_call_cnt to tail_call_cnt at tas=
k_struct.
> >
> > Please remind us what was wrong with per-cpu approach?
>
> There are some cases that the per-cpu approach cannot handle properly.
> Especialy, on non-SMP machine, if there are many bpf progs to run with
> tail call simultaneously, MAX_TAIL_CALL_CNT limit is unable to limit the
> tail call expectedly.

That's not a very helpful explanation.
Last, I recall, the concern was that tcc will be a bit off.
The per-cpu tcc will limit recursion sooner when multiple progs
tail_call-ing on the same cpu?
If so, I think it's a trade-off that should be discussed.
tcc in task_struct will have the same issue.
It will limit tailcalls sooner in some cases.

There were some issues with overriding of per-cpu tcc.
The same concerns apply to per-task tcc.

> >
> > Also notice we have pseudo per-cpu bpf insns now,
> > so things might be easier today.
>
> Great to hear that. With pseudo per-cpu bpf insns, it is able to get
> tcc_ptr from task_struct without a function call.
>
> >
> > On Tue, Apr 2, 2024 at 8:27=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com>=
 wrote:
> >>
> >> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailc=
all
> >> handling in JIT"), the tailcall on x64 works better than before.
> > ...
> >>
> >> As a result, the previous tailcall way can be removed totally, includi=
ng
> >>
> >> 1. "push rax" at prologue.
> >> 2. load tail_call_cnt to rax before calling function.
> >> 3. "pop rax" before jumping to tailcallee when tailcall.
> >> 4. "push rax" and load tail_call_cnt to rax at trampoline.
> >
> > Please trim it.
> > It looks like you've been copy pasting it and it's no longer
> > accurate.
> > Short description of the problem will do.
>
> Got it.
>
> >
> >> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handl=
ing in JIT")
> >> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for =
x64 JIT")
> >> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> >> ---
> >>  arch/x86/net/bpf_jit_comp.c | 137 +++++++++++++++++++++--------------=
-
> >>  1 file changed, 81 insertions(+), 56 deletions(-)
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index 3b639d6f2f54d..cd06e02e83b64 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -11,6 +11,7 @@
> >>  #include <linux/bpf.h>
> >>  #include <linux/memory.h>
> >>  #include <linux/sort.h>
> >> +#include <linux/sched.h>
> >>  #include <asm/extable.h>
> >>  #include <asm/ftrace.h>
> >>  #include <asm/set_memory.h>
> >> @@ -18,6 +19,8 @@
> >>  #include <asm/text-patching.h>
> >>  #include <asm/unwind.h>
> >>  #include <asm/cfi.h>
> >> +#include <asm/current.h>
> >> +#include <asm/percpu.h>
> >>
> >>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
> >>
> >> @@ -273,7 +276,7 @@ struct jit_context {
> >>  /* Number of bytes emit_patch() needs to generate instructions */
> >>  #define X86_PATCH_SIZE         5
> >>  /* Number of bytes that will be skipped on tailcall */
> >> -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
> >> +#define X86_TAIL_CALL_OFFSET   (14 + ENDBR_INSN_SIZE)
> >>
> >>  static void push_r12(u8 **pprog)
> >>  {
> >> @@ -403,6 +406,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
> >>         *pprog =3D prog;
> >>  }
> >>
> >> +static int emit_call(u8 **pprog, void *func, void *ip);
> >> +static __used void bpf_tail_call_cnt_init(void);
> >> +
> >>  /*
> >>   * Emit x86-64 prologue code for BPF program.
> >>   * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET byte=
s
> >> @@ -410,9 +416,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
> >>   */
> >>  static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from=
_cbpf,
> >>                           bool tail_call_reachable, bool is_subprog,
> >> -                         bool is_exception_cb)
> >> +                         bool is_exception_cb, u8 *ip)
> >>  {
> >> -       u8 *prog =3D *pprog;
> >> +       u8 *prog =3D *pprog, *start =3D *pprog;
> >>
> >>         emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_ha=
sh);
> >>         /* BPF trampoline can be made to work without these nops,
> >> @@ -421,13 +427,14 @@ static void emit_prologue(u8 **pprog, u32 stack_=
depth, bool ebpf_from_cbpf,
> >>         emit_nops(&prog, X86_PATCH_SIZE);
> >>         if (!ebpf_from_cbpf) {
> >>                 if (tail_call_reachable && !is_subprog)
> >> -                       /* When it's the entry of the whole tailcall c=
ontext,
> >> -                        * zeroing rax means initialising tail_call_cn=
t.
> >> +                       /* Call bpf_tail_call_cnt_init to initilise
> >> +                        * tail_call_cnt.
> >>                          */
> >> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
> >> +                       emit_call(&prog, bpf_tail_call_cnt_init,
> >> +                                 ip + (prog - start));
> >
> > You're repeating the same bug we discussed before.
> > There is nothing in bpf_tail_call_cnt_init() that
> > prevents the compiler from scratching rdi,rsi,...
> > bpf_tail_call_cnt_init() is a normal function from compiler pov
> > and it's allowed to use those regs.
> > Must have been lucky that CI is not showing crashes.
>
> Oh, get it. In order to prevent the compiler from scratching
> rdi,rsi,..., the asm clobbered register list in bpf_tail_call_cnt_init()
> must be "rdi", "rsi", "rdx", "rcx", "r8". I learn it from the GCC doc[0].
>
> static __used void bpf_tail_call_cnt_init(void)
> {
>         /* In short:
>          * current->bpf_tail_call_cnt =3D 0;
>          */
>
>         asm volatile (
>             "addq " __percpu_arg(0) ", %1\n\t"
>             "movq (%1), %1\n\t"
>             "movl $0x0, %c2(%1)\n\t"
>             :
>             : "m" (__my_cpu_var(this_cpu_off)), "r" (&pcpu_hot.current_ta=
sk),
>               "i" (offsetof(struct task_struct, bpf_tail_call_cnt))
>             : "rdi", "rsi", "rdx", "rcx", "r8" /* to avoid scratching the=
se regs */

That will only prevent the compiler from allocating these regs
into "r" constraint, but the compiler can still use them outside of asm.
You need __naked too.

>         );
> }
>
> [0]
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch=
-Registers-1
>
> >
> >>                 else
> >>                         /* Keep the same instruction layout. */
> >> -                       EMIT2(0x66, 0x90); /* nop2 */
> >> +                       emit_nops(&prog, X86_PATCH_SIZE);
> >>         }
> >>         /* Exception callback receives FP as third parameter */
> >>         if (is_exception_cb) {
> >> @@ -452,8 +459,6 @@ static void emit_prologue(u8 **pprog, u32 stack_de=
pth, bool ebpf_from_cbpf,
> >>         /* sub rsp, rounded_stack_depth */
> >>         if (stack_depth)
> >>                 EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8)=
);
> >> -       if (tail_call_reachable)
> >> -               EMIT1(0x50);         /* push rax */
> >>         *pprog =3D prog;
> >>  }
> >>
> >> @@ -589,13 +594,61 @@ static void emit_return(u8 **pprog, u8 *ip)
> >>         *pprog =3D prog;
> >>  }
> >>
> >> +static __used void bpf_tail_call_cnt_init(void)
> >> +{
> >> +       /* The following asm equals to
> >> +        *
> >> +        * u32 *tcc_ptr =3D &current->bpf_tail_call_cnt;
> >> +        *
> >> +        * *tcc_ptr =3D 0;
> >> +        */
> >> +
> >> +       asm volatile (
> >> +           "addq " __percpu_arg(0) ", %1\n\t"
> >> +           "addq %2, %1\n\t"
> >> +           "movq (%1), %1\n\t"
> >> +           "addq %3, %1\n\t"
> >> +           "movl $0, (%1)\n\t"
> >> +           :
> >> +           : "m" (this_cpu_off), "r" (&pcpu_hot),
> >> +             "i" (offsetof(struct pcpu_hot, current_task)),
> >> +             "i" (offsetof(struct task_struct, bpf_tail_call_cnt))
> >> +       );
> >> +}
> >> +
> >> +static __used u32 *bpf_tail_call_cnt_ptr(void)
> >> +{
> >> +       u32 *tcc_ptr;
> >> +
> >> +       /* The following asm equals to
> >> +        *
> >> +        * u32 *tcc_ptr =3D &current->bpf_tail_call_cnt;
> >> +        *
> >> +        * return tcc_ptr;
> >> +        */
> >> +
> >> +       asm volatile (
> >> +           "addq " __percpu_arg(1) ", %2\n\t"
> >> +           "addq %3, %2\n\t"
> >> +           "movq (%2), %2\n\t"
> >> +           "addq %4, %2\n\t"
> >> +           "movq %2, %0\n\t"
> >> +           : "=3Dr" (tcc_ptr)
> >> +           : "m" (this_cpu_off), "r" (&pcpu_hot),
> >> +             "i" (offsetof(struct pcpu_hot, current_task)),
> >> +             "i" (offsetof(struct task_struct, bpf_tail_call_cnt))
> >> +       );
> >> +
> >> +       return tcc_ptr;
> >> +}
> >> +
> >>  /*
> >>   * Generate the following code:
> >>   *
> >>   * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) .=
..
> >>   *   if (index >=3D array->map.max_entries)
> >>   *     goto out;
> >> - *   if (tail_call_cnt++ >=3D MAX_TAIL_CALL_CNT)
> >> + *   if ((*tcc_ptr)++ >=3D MAX_TAIL_CALL_CNT)
> >>   *     goto out;
> >>   *   prog =3D array->ptrs[index];
> >>   *   if (prog =3D=3D NULL)
> >> @@ -608,7 +661,6 @@ static void emit_bpf_tail_call_indirect(struct bpf=
_prog *bpf_prog,
> >>                                         u32 stack_depth, u8 *ip,
> >>                                         struct jit_context *ctx)
> >>  {
> >> -       int tcc_off =3D -4 - round_up(stack_depth, 8);
> >>         u8 *prog =3D *pprog, *start =3D *pprog;
> >>         int offset;
> >>
> >> @@ -630,16 +682,16 @@ static void emit_bpf_tail_call_indirect(struct b=
pf_prog *bpf_prog,
> >>         EMIT2(X86_JBE, offset);                   /* jbe out */
> >>
> >>         /*
> >> -        * if (tail_call_cnt++ >=3D MAX_TAIL_CALL_CNT)
> >> +        * if ((*tcc_ptr)++ >=3D MAX_TAIL_CALL_CNT)
> >>          *      goto out;
> >>          */
> >> -       EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword pt=
r [rbp - tcc_off] */
> >> -       EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL=
_CALL_CNT */
> >> +       /* call bpf_tail_call_cnt_ptr */
> >> +       emit_call(&prog, bpf_tail_call_cnt_ptr, ip + (prog - start));
> >
> > same issue.
>
> I will rewrite it to emit_bpf_tail_call_cnt_ptr(), which will use pseudo
> per-cpu bpf insns to get tcc_ptr from task_struct.
>
> static void emit_bpf_tail_call_cnt_ptr(u8 **pprog)
> {
>         u8 *prog =3D *pprog;
>
>         /* In short:
>          * return &current->bpf_tail_call_cnt;
>          */
>
>         /* mov rax, &pcpu_hot.current_task */
>         EMIT3_off32(0x48, 0xC7, 0xC0, ((u32)(unsigned
> long)&pcpu_hot.current_task));
>
> #ifdef CONFIG_SMP
>         /* add rax, gs:[&this_cpu_off] */
>         EMIT1(0x65);
>         EMIT4_off32(0x48, 0x03, 0x04, 0x25, ((u32)(unsigned long)&this_cp=
u_off));
> #endif
>
>         /* mov rax, qword ptr [rax] */
>         EMIT3(0x48, 0x8B, 0x00);
>         /* add rax, offsetof(struct task_struct, bpf_tail_call_cnt) */
>         EMIT2_off32(0x48, 0x05, ((u32)offsetof(struct task_struct,
> bpf_tail_call_cnt)));
>
>         *pprog =3D prog;
> }

I think it's cleaner to use __naked func with asm volatile
and explicit 'rax'.

The suggestion to consider BPF_ADDR_PERCPU insn was in the context
of generating it in the verifier, so that JITs don't need
to do anything special with tcc.
Like if the verifier emits tcc checks that JIT's
emit_bpf_tail_call_[in]direct() will only deal with the actual call.
That was a bit of an orthogonal optimization/cleanup idea.

>
> >
> >> +       EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);     /* cmp dword ptr [ra=
x], MAX_TAIL_CALL_CNT */
> >>
> >>         offset =3D ctx->tail_call_indirect_label - (prog + 2 - start);
> >>         EMIT2(X86_JAE, offset);                   /* jae out */
> >> -       EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
> >> -       EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rb=
p - tcc_off], eax */
> >> +       EMIT2(0xFF, 0x00);                        /* inc dword ptr [ra=
x] */
> >>
> >>         /* prog =3D array->ptrs[index]; */
> >>         EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + r=
dx * 8 + offsetof(...)] */
> >> @@ -663,7 +715,6 @@ static void emit_bpf_tail_call_indirect(struct bpf=
_prog *bpf_prog,
> >>                         pop_r12(&prog);
> >>         }
> >>
> >> -       EMIT1(0x58);                              /* pop rax */
> >>         if (stack_depth)
> >>                 EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
> >>                             round_up(stack_depth, 8));
> >> @@ -691,21 +742,20 @@ static void emit_bpf_tail_call_direct(struct bpf=
_prog *bpf_prog,
> >>                                       bool *callee_regs_used, u32 stac=
k_depth,
> >>                                       struct jit_context *ctx)
> >>  {
> >> -       int tcc_off =3D -4 - round_up(stack_depth, 8);
> >>         u8 *prog =3D *pprog, *start =3D *pprog;
> >>         int offset;
> >>
> >>         /*
> >> -        * if (tail_call_cnt++ >=3D MAX_TAIL_CALL_CNT)
> >> +        * if ((*tcc_ptr)++ >=3D MAX_TAIL_CALL_CNT)
> >>          *      goto out;
> >>          */
> >> -       EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dwor=
d ptr [rbp - tcc_off] */
> >> -       EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_=
TAIL_CALL_CNT */
> >> +       /* call bpf_tail_call_cnt_ptr */
> >> +       emit_call(&prog, bpf_tail_call_cnt_ptr, ip);
> >
> > and here as well.
>
> Replace with emit_bpf_tail_call_cnt_ptr(), too.
>
> >
> > pw-bot: cr
>
> I would like to send next version with these update.

pw-bot is a special keyword that is recognized by "patchwork bot".
"cr" stands for "changes requested".
It's a patch status in patchwork.
It means that the patch will not be applied as-is.
So it means that you have to make changes and resend.


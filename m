Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A012D2B3B9
	for <lists+bpf@lfdr.de>; Mon, 27 May 2019 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfE0L5v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 May 2019 07:57:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38650 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfE0L5v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 May 2019 07:57:51 -0400
Received: by mail-it1-f194.google.com with SMTP id i63so23703737ita.3
        for <bpf@vger.kernel.org>; Mon, 27 May 2019 04:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JC9rpe2SgfUbgduMlYSwoRs0VR+Ljm2n8cHCtnDq64=;
        b=g1jOPUAL1kp1DLRaavZxYeUg4TrTZybNKJS2Fwkp1EIbFlrxpoOVa9EDoAVBC4sAGD
         exg4P/9aNQaeB/ZmIvaEkXlCp/wfsZc0mcdOA8WLxUQCK7LChrLc86EZ9pwUPh4J2xGf
         DaVVkH2q37LFEXsCk3Eeu7mxeBg9MG1q/1os5HIHmWfcQ7wk+xgvKiRKc9HR3rdZ1u7y
         XG4FUQ1RvzooK/Jli4fsmvL5q2ms0oygx7N3IEJQoXa3JI67xLpbt/5AQDkVJb97LT6l
         OTycnQg5kiEI2vezEFgqDgHYVP/zu+EuhYKTfhvp7aYihfIuBae/S7KneNwZAD0U3U3c
         9IXg==
X-Gm-Message-State: APjAAAVT5zHyS5qiaBtBghyOr5QFlDUeeR8qRsOcrfFkS+9htv1u09lV
        HBa3uu7V7aQS/RiGb47htlesWiOKxxesjXjOpfYFVw==
X-Google-Smtp-Source: APXvYqw8g8dG6RE5zKHdKggi9CdD9XO8KNG9MxeJdoj9aVCzPQHjDRk8W3MnCzxmc6fhpFQwTNzSzxf1dJZ1uvubu28=
X-Received: by 2002:a24:2e8c:: with SMTP id i134mr27908721ita.9.1558958269953;
 Mon, 27 May 2019 04:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <ab047883-69f6-1175-153f-5ad9462c6389@fb.com> <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble> <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble> <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble> <CACPcB9e0mL6jdNWfH-2K-rkvmQiz=G6mtLiZ+AEmp3-V0x+Z8A@mail.gmail.com>
 <20190523172714.6fkzknfsuv2t44se@treble> <CACPcB9dHzht9v9G9_z6oe5AAwgxCTuswRLxTB29vhWphqBO5Ng@mail.gmail.com>
 <20190524232312.upjixcrnidlibikd@treble>
In-Reply-To: <20190524232312.upjixcrnidlibikd@treble>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 27 May 2019 19:57:38 +0800
Message-ID: <CACPcB9cFGQ6OU7Zk=q_c8V8ob6vg3HMaaXGaNjaKn8rvS-wg-g@mail.gmail.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 25, 2019 at 7:23 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, May 24, 2019 at 10:20:52AM +0800, Kairui Song wrote:
> > On Fri, May 24, 2019 at 1:27 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Fri, May 24, 2019 at 12:41:59AM +0800, Kairui Song wrote:
> > > >  On Thu, May 23, 2019 at 11:24 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > > >
> > > > > On Thu, May 23, 2019 at 10:50:24PM +0800, Kairui Song wrote:
> > > > > > > > Hi Josh, this still won't fix the problem.
> > > > > > > >
> > > > > > > > Problem is not (or not only) with ___bpf_prog_run, what actually went
> > > > > > > > wrong is with the JITed bpf code.
> > > > > > >
> > > > > > > There seem to be a bunch of issues.  My patch at least fixes the failing
> > > > > > > selftest reported by Alexei for ORC.
> > > > > > >
> > > > > > > How can I recreate your issue?
> > > > > >
> > > > > > Hmm, I used bcc's example to attach bpf to trace point, and with that
> > > > > > fix stack trace is still invalid.
> > > > > >
> > > > > > CMD I used with bcc:
> > > > > > python3 ./tools/stackcount.py t:sched:sched_fork
> > > > >
> > > > > I've had problems in the past getting bcc to build, so I was hoping it
> > > > > was reproducible with a standalone selftest.
> > > > >
> > > > > > And I just had another try applying your patch, self test is also failing.
> > > > >
> > > > > Is it the same selftest reported by Alexei?
> > > > >
> > > > >   test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap err -1 errno 2
> > > > >
> > > > > > I'm applying on my local master branch, a few days older than
> > > > > > upstream, I can update and try again, am I missing anything?
> > > > >
> > > > > The above patch had some issues, so with some configs you might see an
> > > > > objtool warning for ___bpf_prog_run(), in which case the patch doesn't
> > > > > fix the test_stacktrace_map selftest.
> > > > >
> > > > > Here's the latest version which should fix it in all cases (based on
> > > > > tip/master):
> > > > >
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?h=bpf-orc-fix
> > > >
> > > > Hmm, I still get the failure:
> > > > test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap
> > > > err -1 errno 2
> > > >
> > > > And I didn't see how this will fix the issue. As long as ORC need to
> > > > unwind through the JITed code it will fail. And that will happen
> > > > before reaching ___bpf_prog_run.
> > >
> > > Ok, I was able to recreate by doing
> > >
> > >   echo 1 > /proc/sys/net/core/bpf_jit_enable
> > >
> > > first.  I'm guessing you have CONFIG_BPF_JIT_ALWAYS_ON.
> > >
> >
> > Yes, with JIT off it will be fixed. I can confirm that.
>
> Here's a tentative BPF fix for the JIT frame pointer issue.  It was a
> bit harder than I expected.  Encoding r12 as a base register requires a
> SIB byte, so I had to add support for encoding that.  I also simplified
> the prologue to resemble a GCC prologue, which decreases the prologue
> size quite a bit.
>
> Next week I can work on the corresponding ORC change.  Then I can clean
> all the patches up and submit them properly.
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index afabf597c855..c9b4503558c9 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -104,9 +104,8 @@ static int bpf_size_to_x86_bytes(int bpf_size)
>  /*
>   * The following table maps BPF registers to x86-64 registers.
>   *
> - * x86-64 register R12 is unused, since if used as base address
> - * register in load/store instructions, it always needs an
> - * extra byte of encoding and is callee saved.
> + * RBP isn't used; it needs to be preserved to allow the unwinder to move
> + * through generated code stacks.
>   *
>   * Also x86-64 register R9 is unused. x86-64 register R10 is
>   * used for blinding (if enabled).
> @@ -122,7 +121,7 @@ static const int reg2hex[] = {
>         [BPF_REG_7] = 5,  /* R13 callee saved */
>         [BPF_REG_8] = 6,  /* R14 callee saved */
>         [BPF_REG_9] = 7,  /* R15 callee saved */
> -       [BPF_REG_FP] = 5, /* RBP readonly */
> +       [BPF_REG_FP] = 4, /* R12 readonly */
>         [BPF_REG_AX] = 2, /* R10 temp register */
>         [AUX_REG] = 3,    /* R11 temp register */
>  };
> @@ -139,6 +138,7 @@ static bool is_ereg(u32 reg)
>                              BIT(BPF_REG_7) |
>                              BIT(BPF_REG_8) |
>                              BIT(BPF_REG_9) |
> +                            BIT(BPF_REG_FP) |
>                              BIT(BPF_REG_AX));
>  }
>
> @@ -147,6 +147,11 @@ static bool is_axreg(u32 reg)
>         return reg == BPF_REG_0;
>  }
>
> +static bool is_sib_reg(u32 reg)
> +{
> +       return reg == BPF_REG_FP;
> +}
> +
>  /* Add modifiers if 'reg' maps to x86-64 registers R8..R15 */
>  static u8 add_1mod(u8 byte, u32 reg)
>  {
> @@ -190,15 +195,13 @@ struct jit_context {
>  #define BPF_MAX_INSN_SIZE      128
>  #define BPF_INSN_SAFETY                64
>
> -#define AUX_STACK_SPACE                40 /* Space for RBX, R13, R14, R15, tailcnt */
> -
> -#define PROLOGUE_SIZE          37
> +#define PROLOGUE_SIZE          25
>
>  /*
>   * Emit x86-64 prologue code for BPF program and check its size.
>   * bpf_tail_call helper will skip it while jumping into another program
>   */
> -static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf)
> +static void emit_prologue(u8 **pprog, u32 stack_depth)
>  {
>         u8 *prog = *pprog;
>         int cnt = 0;
> @@ -206,40 +209,67 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf)
>         /* push rbp */
>         EMIT1(0x55);
>
> -       /* mov rbp,rsp */
> +       /* mov rbp, rsp */
>         EMIT3(0x48, 0x89, 0xE5);
>
> -       /* sub rsp, rounded_stack_depth + AUX_STACK_SPACE */
> -       EMIT3_off32(0x48, 0x81, 0xEC,
> -                   round_up(stack_depth, 8) + AUX_STACK_SPACE);
> +       /* push r15 */
> +       EMIT2(0x41, 0x57);
> +       /* push r14 */
> +       EMIT2(0x41, 0x56);
> +       /* push r13 */
> +       EMIT2(0x41, 0x55);
> +       /* push r12 */
> +       EMIT2(0x41, 0x54);
> +       /* push rbx */
> +       EMIT1(0x53);
>
> -       /* sub rbp, AUX_STACK_SPACE */
> -       EMIT4(0x48, 0x83, 0xED, AUX_STACK_SPACE);
> +       /*
> +        * Push the tail call counter (tail_call_cnt) for eBPF tail calls.
> +        * Initialized to zero.
> +        *
> +        * push $0
> +        */
> +       EMIT2(0x6a, 0x00);
>
> -       /* mov qword ptr [rbp+0],rbx */
> -       EMIT4(0x48, 0x89, 0x5D, 0);
> -       /* mov qword ptr [rbp+8],r13 */
> -       EMIT4(0x4C, 0x89, 0x6D, 8);
> -       /* mov qword ptr [rbp+16],r14 */
> -       EMIT4(0x4C, 0x89, 0x75, 16);
> -       /* mov qword ptr [rbp+24],r15 */
> -       EMIT4(0x4C, 0x89, 0x7D, 24);
> +       /*
> +        * R12 is used for the BPF program's FP register.  It points to the end
> +        * of the program's stack area.
> +        *
> +        * mov r12, rsp
> +        */
> +       EMIT3(0x49, 0x89, 0xE4);
>
> -       if (!ebpf_from_cbpf) {
> -               /*
> -                * Clear the tail call counter (tail_call_cnt): for eBPF tail
> -                * calls we need to reset the counter to 0. It's done in two
> -                * instructions, resetting RAX register to 0, and moving it
> -                * to the counter location.
> -                */
> +       /* sub rsp, rounded_stack_depth */
> +       EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
>
> -               /* xor eax, eax */
> -               EMIT2(0x31, 0xc0);
> -               /* mov qword ptr [rbp+32], rax */
> -               EMIT4(0x48, 0x89, 0x45, 32);
> +       BUILD_BUG_ON(cnt != PROLOGUE_SIZE);
>
> -               BUILD_BUG_ON(cnt != PROLOGUE_SIZE);
> -       }
> +       *pprog = prog;
> +}
> +
> +static void emit_epilogue(u8 **pprog)
> +{
> +       u8 *prog = *pprog;
> +       int cnt = 0;
> +
> +       /* lea rsp, [rbp-0x28] */
> +       EMIT4(0x48, 0x8D, 0x65, 0xD8);
> +
> +       /* pop rbx */
> +       EMIT1(0x5B);
> +       /* pop r12 */
> +       EMIT2(0x41, 0x5C);
> +       /* pop r13 */
> +       EMIT2(0x41, 0x5D);
> +       /* pop r14 */
> +       EMIT2(0x41, 0x5E);
> +       /* pop r15 */
> +       EMIT2(0x41, 0x5F);
> +       /* pop rbp */
> +       EMIT1(0x5D);
> +
> +       /* ret */
> +       EMIT1(0xC3);
>
>         *pprog = prog;
>  }
> @@ -277,7 +307,7 @@ static void emit_bpf_tail_call(u8 **pprog)
>         EMIT2(0x89, 0xD2);                        /* mov edx, edx */
>         EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
>               offsetof(struct bpf_array, map.max_entries));
> -#define OFFSET1 (41 + RETPOLINE_RAX_BPF_JIT_SIZE) /* Number of bytes to jump */
> +#define OFFSET1 (35 + RETPOLINE_RAX_BPF_JIT_SIZE) /* Number of bytes to jump */
>         EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
>         label1 = cnt;
>
> @@ -285,13 +315,13 @@ static void emit_bpf_tail_call(u8 **pprog)
>          * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
>          *      goto out;
>          */
> -       EMIT2_off32(0x8B, 0x85, 36);              /* mov eax, dword ptr [rbp + 36] */
> +       EMIT3(0x8B, 0x45, 0xD4);                  /* mov eax, dword ptr [rbp - 44] */
>         EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
> -#define OFFSET2 (30 + RETPOLINE_RAX_BPF_JIT_SIZE)
> +#define OFFSET2 (27 + RETPOLINE_RAX_BPF_JIT_SIZE)
>         EMIT2(X86_JA, OFFSET2);                   /* ja out */
>         label2 = cnt;
>         EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
> -       EMIT2_off32(0x89, 0x85, 36);              /* mov dword ptr [rbp + 36], eax */
> +       EMIT3(0x89, 0x45, 0xD4);                  /* mov dword ptr [rbp - 44], eax */
>
>         /* prog = array->ptrs[index]; */
>         EMIT4_off32(0x48, 0x8B, 0x84, 0xD6,       /* mov rax, [rsi + rdx * 8 + offsetof(...)] */
> @@ -419,8 +449,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>         int proglen = 0;
>         u8 *prog = temp;
>
> -       emit_prologue(&prog, bpf_prog->aux->stack_depth,
> -                     bpf_prog_was_classic(bpf_prog));
> +       emit_prologue(&prog, bpf_prog->aux->stack_depth);
>
>         for (i = 0; i < insn_cnt; i++, insn++) {
>                 const s32 imm32 = insn->imm;
> @@ -767,10 +796,19 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>                 case BPF_ST | BPF_MEM | BPF_DW:
>                         EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>
> -st:                    if (is_imm8(insn->off))
> -                               EMIT2(add_1reg(0x40, dst_reg), insn->off);
> +st:
> +                       if (is_imm8(insn->off))
> +                               EMIT1(add_1reg(0x40, dst_reg));
>                         else
> -                               EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
> +                               EMIT1(add_1reg(0x80, dst_reg));
> +
> +                       if (is_sib_reg(dst_reg))
> +                               EMIT1(add_1reg(0x20, dst_reg));
> +
> +                       if (is_imm8(insn->off))
> +                               EMIT1(insn->off);
> +                       else
> +                               EMIT(insn->off, 4);
>
>                         EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
>                         break;
> @@ -799,11 +837,19 @@ st:                       if (is_imm8(insn->off))
>                         goto stx;
>                 case BPF_STX | BPF_MEM | BPF_DW:
>                         EMIT2(add_2mod(0x48, dst_reg, src_reg), 0x89);
> -stx:                   if (is_imm8(insn->off))
> -                               EMIT2(add_2reg(0x40, dst_reg, src_reg), insn->off);
> +stx:
> +                       if (is_imm8(insn->off))
> +                               EMIT1(add_2reg(0x40, dst_reg, src_reg));
> +                       else
> +                               EMIT1(add_2reg(0x80, dst_reg, src_reg));
> +
> +                       if (is_sib_reg(dst_reg))
> +                               EMIT1(add_1reg(0x20, dst_reg));
> +
> +                       if (is_imm8(insn->off))
> +                               EMIT1(insn->off);
>                         else
> -                               EMIT1_off32(add_2reg(0x80, dst_reg, src_reg),
> -                                           insn->off);
> +                               EMIT(insn->off, 4);
>                         break;
>
>                         /* LDX: dst_reg = *(u8*)(src_reg + off) */
> @@ -825,16 +871,24 @@ stx:                      if (is_imm8(insn->off))
>                 case BPF_LDX | BPF_MEM | BPF_DW:
>                         /* Emit 'mov rax, qword ptr [rax+0x14]' */
>                         EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x8B);
> -ldx:                   /*
> +ldx:
> +                       /*
>                          * If insn->off == 0 we can save one extra byte, but
>                          * special case of x86 R13 which always needs an offset
>                          * is not worth the hassle
>                          */
>                         if (is_imm8(insn->off))
> -                               EMIT2(add_2reg(0x40, src_reg, dst_reg), insn->off);
> +                               EMIT1(add_2reg(0x40, src_reg, dst_reg));
>                         else
> -                               EMIT1_off32(add_2reg(0x80, src_reg, dst_reg),
> -                                           insn->off);
> +                               EMIT1(add_2reg(0x80, src_reg, dst_reg));
> +
> +                       if (is_sib_reg(src_reg))
> +                               EMIT1(add_1reg(0x20, src_reg));
> +
> +                       if (is_imm8(insn->off))
> +                               EMIT1(insn->off);
> +                       else
> +                               EMIT(insn->off, 4);
>                         break;
>
>                         /* STX XADD: lock *(u32*)(dst_reg + off) += src_reg */
> @@ -847,11 +901,19 @@ stx:                      if (is_imm8(insn->off))
>                         goto xadd;
>                 case BPF_STX | BPF_XADD | BPF_DW:
>                         EMIT3(0xF0, add_2mod(0x48, dst_reg, src_reg), 0x01);
> -xadd:                  if (is_imm8(insn->off))
> -                               EMIT2(add_2reg(0x40, dst_reg, src_reg), insn->off);
> +xadd:
> +                       if (is_imm8(insn->off))
> +                               EMIT1(add_2reg(0x40, dst_reg, src_reg));
>                         else
> -                               EMIT1_off32(add_2reg(0x80, dst_reg, src_reg),
> -                                           insn->off);
> +                               EMIT1(add_2reg(0x80, dst_reg, src_reg));
> +
> +                       if (is_sib_reg(dst_reg))
> +                               EMIT1(add_1reg(0x20, dst_reg));
> +
> +                       if (is_imm8(insn->off))
> +                               EMIT1(insn->off);
> +                       else
> +                               EMIT(insn->off, 4);
>                         break;
>
>                         /* call */
> @@ -1040,19 +1102,8 @@ xadd:                    if (is_imm8(insn->off))
>                         seen_exit = true;
>                         /* Update cleanup_addr */
>                         ctx->cleanup_addr = proglen;
> -                       /* mov rbx, qword ptr [rbp+0] */
> -                       EMIT4(0x48, 0x8B, 0x5D, 0);
> -                       /* mov r13, qword ptr [rbp+8] */
> -                       EMIT4(0x4C, 0x8B, 0x6D, 8);
> -                       /* mov r14, qword ptr [rbp+16] */
> -                       EMIT4(0x4C, 0x8B, 0x75, 16);
> -                       /* mov r15, qword ptr [rbp+24] */
> -                       EMIT4(0x4C, 0x8B, 0x7D, 24);
> -
> -                       /* add rbp, AUX_STACK_SPACE */
> -                       EMIT4(0x48, 0x83, 0xC5, AUX_STACK_SPACE);
> -                       EMIT1(0xC9); /* leave */
> -                       EMIT1(0xC3); /* ret */
> +
> +                       emit_epilogue(&prog);
>                         break;
>
>                 default:

Thanks! This looks good to me and passed the self test and bcc test
(with frame pointer unwinder, and JIT enabled):
With bcc's tools/stackcount.py I got the valid stack trace, and the
self test says:
test_stacktrace_map:PASS:compare_map_keys stackid_hmap vs. stackmap 0 nsec

-- 
Best Regards,
Kairui Song

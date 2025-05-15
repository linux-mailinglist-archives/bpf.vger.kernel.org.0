Return-Path: <bpf+bounces-58341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D8AB8E0F
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCF55007FB
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0F4254858;
	Thu, 15 May 2025 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbMStSpa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB201361
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331238; cv=none; b=HyBdk9Eav7UYufjbdKnR+wLGrbtlCLyBIW/Q4ZnJr6AUCgiPQ8eChTXt+qYjVvStHpZzSjKJ8bUAG2pIx2euH2ITEanAa7+fWJv3eTeHsA4mc3tNpbsJzbr4Nqf8BfLhN5RF2MI0xfv+EuhHBnox/nWpnpQwWRzGzQDTTVXByZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331238; c=relaxed/simple;
	bh=qOChIHMIH2+Svh38ky2qXOjb+JFnT9OcLaBtRqwqkNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtW0RxbhCX5wns7uEWjPX/GdB3VBE4qY15W2Q1WleZOSlO2a2l2rHzO6t3bjmYvzoy2iITq2msd/8BO/XcEpyELwS317WBgINX15lExOAXlcSpxie4UCfpC3OWMVO+VCX2AjV3nFkZlscg78XyrIKjExiDX6BxzSqHwKCdHLvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbMStSpa; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30e7e46cb47so73207a91.1
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747331236; x=1747936036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmjYIet15bwyEEnAPIErkAHeLmdkG7DNeHByn4lMsk8=;
        b=RbMStSpaQe5hg4FOjkZFXOS41nHMZv5mx/cJxXR4XGjCZDrIJaleSCcKv2fbj2KmMt
         ue+izfCi0ux/mZwUdAbhn69KBEctHOnZg/qnUB6CLQCuGPttyfRmr09OHXRAc90cGArt
         Hzjfug1y7RzqSv6iFkjncQaDFHKgYgRxIU878aRs32GSv83gAqewjW3JuQfSSNVgEuZq
         2KuhFFSrPqg1fkWR0j1V18XlyF5aZzaN6be71If1dEIibpAhoWltW3zwZzAHuqL5p8cB
         AJsRZqrLpZe39cnxMzhXy2XRxvBIM/pcrTv5bcUOT1IUFqJ8n5x8FGwPptf0mr0BukO2
         23+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747331236; x=1747936036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmjYIet15bwyEEnAPIErkAHeLmdkG7DNeHByn4lMsk8=;
        b=TNdIbSQaJNSFtXGs5/6fQkfdZJTLtRBsR4olUOd/1BFpOt0B8LxY8nSEBYvIGf6tl1
         LTa86idwXXlrF8J9wcn+hF8XIlZIwbzyoxlKfFI2Z6hhbQKJz7GiTolaMnbBNfdWoZDe
         c9vL7uc9cuf2Tb0ORpBAFulVrSmR6mZOyBzZVzNSu3KCfxkqhU8is2cBnlWEGZaHDQaV
         XOgC81jdPK91MzTbkyqJ0QYwlIQo34RDHn7kWTMMtAWP8QpYV4ZRdj77qjvv0jc3W5fV
         MesqAPDBzZENNxDhw9itDv1A7bxLZEsWd4IXMVHikPHyNvdfhfflwd22LGLU7zIV2bMJ
         n6ag==
X-Gm-Message-State: AOJu0YyIWn54db/PzvsgBI0I8k7GV/NTbGMFjeURdLwv5+hzCavxIMH0
	ffCiFgTpTb8hxhiQtEaM6DPtJTkouTAV3A7jHbqoergV0TvizLKPWqDlS4thlff0Qww36u5v0wz
	jg71CsP38izzGs+ldwm+dslyyWjJ4jKw=
X-Gm-Gg: ASbGncskYblkRl0OddI2GRCSSC4ye4Q8oH0m8mndS157z2eBGlcqmq3XfOqAGX8wn8T
	AXmlyy056ubuju+s3gCl1b6gp6sjeN2RNUO4Fhzo24cmgbRVmsdRkNhSLqCLHhVvgQWhqjTHbo0
	OGTPZznCwyk0X7Fr+d9AhBpO/L5APUZ5dHsPvM5THa8Fo4x3C2
X-Google-Smtp-Source: AGHT+IH6q4mYT59G8HlFLBK5nEYRPcO+DGS7TJNe14tOSb+Wub0dq9GR1uUpOqYsQiYL7DViDX0VQKTjQeII+d2/mNU=
X-Received: by 2002:a17:90b:2b8b:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-30e7d5bb691mr352830a91.35.1747331235717; Thu, 15 May 2025
 10:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511162758.281071-1-yonghong.song@linux.dev>
 <CAEf4BzaXB=hJNtpg7aUE67skjhuxDnG_oWHRULnmMNJwc9dRcQ@mail.gmail.com>
 <CAEf4BzbTzvapqEjExcOffOfwV=BKLL=ep1azp6VXdyLBgChZtg@mail.gmail.com> <3097e48c-a1ef-45f5-a445-c2a3c171fa81@linux.dev>
In-Reply-To: <3097e48c-a1ef-45f5-a445-c2a3c171fa81@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 10:47:02 -0700
X-Gm-Features: AX0GCFsLJewEMGMTntWpOlIdJF3fQJW6iGOhZQH2W9HUfjuCsdkTokctdYs7QlM
Message-ID: <CAEf4BzaozHcBLhXzZAfbLRrNmx95d0DsMGjoBM9TvX7SDqujOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not include r10 in precision
 backtracking bookkeeping
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 6:44=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 5/12/25 6:05 AM, Andrii Nakryiko wrote:
> > On Mon, May 12, 2025 at 9:26=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Sun, May 11, 2025 at 9:28=E2=80=AFAM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>> Yi Lai reported an issue ([1]) where the following warning appears
> >>> in kernel dmesg:
> >>>    [   60.643604] verifier backtracking bug
> >>>    [   60.643635] WARNING: CPU: 10 PID: 2315 at kernel/bpf/verifier.c=
:4302 __mark_chain_precision+0x3a6c/0x3e10
> >>>    [   60.648428] Modules linked in: bpf_testmod(OE)
> >>>    [   60.650471] CPU: 10 UID: 0 PID: 2315 Comm: test_progs Tainted: =
G           OE       6.15.0-rc4-gef11287f8289-dirty #327 PREEMPT(full)
> >>>    [   60.654385] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> >>>    [   60.656682] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> >>>    [   60.660475] RIP: 0010:__mark_chain_precision+0x3a6c/0x3e10
> >>>    [   60.662814] Code: 5a 30 84 89 ea e8 c4 d9 01 00 80 3d 3e 7d d8 =
04 00 0f 85 60 fa ff ff c6 05 31 7d d8 04
> >>>                         01 48 c7 c7 00 58 30 84 e8 c4 06 a5 ff <0f> 0=
b e9 46 fa ff ff 48 ...
> >>>    [   60.668720] RSP: 0018:ffff888116cc7298 EFLAGS: 00010246
> >>>    [   60.671075] RAX: 54d70e82dfd31900 RBX: ffff888115b65e20 RCX: 00=
00000000000000
> >>>    [   60.673659] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00=
000000ffffffff
> >>>    [   60.676241] RBP: 0000000000000400 R08: ffff8881f6f23bd3 R09: 1f=
fff1103ede477a
> >>>    [   60.678787] R10: dffffc0000000000 R11: ffffed103ede477b R12: ff=
ff888115b60ae8
> >>>    [   60.681420] R13: 1ffff11022b6cbc4 R14: 00000000fffffff2 R15: 00=
00000000000001
> >>>    [   60.684030] FS:  00007fc2aedd80c0(0000) GS:ffff88826fa8a000(000=
0) knlGS:0000000000000000
> >>>    [   60.686837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>    [   60.689027] CR2: 000056325369e000 CR3: 000000011088b002 CR4: 00=
00000000370ef0
> >>>    [   60.691623] Call Trace:
> >>>    [   60.692821]  <TASK>
> >>>    [   60.693960]  ? __pfx_verbose+0x10/0x10
> >>>    [   60.695656]  ? __pfx_disasm_kfunc_name+0x10/0x10
> >>>    [   60.697495]  check_cond_jmp_op+0x16f7/0x39b0
> >>>    [   60.699237]  do_check+0x58fa/0xab10
> >>>    ...
> >>>
> >>> Further analysis shows the warning is at line 4302 as below:
> >>>
> >>>    4294                         /* static subprog call instruction, w=
hich
> >>>    4295                          * means that we are exiting current =
subprog,
> >>>    4296                          * so only r1-r5 could be still reque=
sted as
> >>>    4297                          * precise, r0 and r6-r10 or any stac=
k slot in
> >>>    4298                          * the current frame should be zero b=
y now
> >>>    4299                          */
> >>>    4300                         if (bt_reg_mask(bt) & ~BPF_REGMASK_AR=
GS) {
> >>>    4301                                 verbose(env, "BUG regs %x\n",=
 bt_reg_mask(bt));
> >>>    4302                                 WARN_ONCE(1, "verifier backtr=
acking bug");
> >>>    4303                                 return -EFAULT;
> >>>    4304                         }
> >>>
> >>> With the below test (also in the next patch):
> >>>    __used __naked static void __bpf_jmp_r10(void)
> >>>    {
> >>>          asm volatile (
> >>>          "r2 =3D 2314885393468386424 ll;"
> >>>          "goto +0;"
> >>>          "if r2 <=3D r10 goto +3;"
> >>>          "if r1 >=3D -1835016 goto +0;"
> >>>          "if r2 <=3D 8 goto +0;"
> >>>          "if r3 <=3D 0 goto +0;"
> >>>          "exit;"
> >>>          ::: __clobber_all);
> >>>    }
> >>>
> >>>    SEC("?raw_tp")
> >>>    __naked void bpf_jmp_r10(void)
> >>>    {
> >>>          asm volatile (
> >>>          "r3 =3D 0 ll;"
> >>>          "call __bpf_jmp_r10;"
> >>>          "r0 =3D 0;"
> >>>          "exit;"
> >>>          ::: __clobber_all);
> >>>    }
> >>>
> >>> The following is the verifier failure log:
> >>>    0: (18) r3 =3D 0x0                      ; R3_w=3D0
> >>>    2: (85) call pc+2
> >>>    caller:
> >>>     R10=3Dfp0
> >>>    callee:
> >>>     frame1: R1=3Dctx() R3_w=3D0 R10=3Dfp0
> >>>    5: frame1: R1=3Dctx() R3_w=3D0 R10=3Dfp0
> >>>    ; asm volatile ("                                 \ @ verifier_pre=
cision.c:184
> >>>    5: (18) r2 =3D 0x20202000256c6c78       ; frame1: R2_w=3D0x2020200=
0256c6c78
> >>>    7: (05) goto pc+0
> >>>    8: (bd) if r2 <=3D r10 goto pc+3        ; frame1: R2_w=3D0x2020200=
0256c6c78 R10=3Dfp0
> >> For stacks spill/fill we use INSN_F_STACK_ACCESS because not just r10
> >> can be used to point to the stack. I wonder if we need to handle r10
> >> more generically here?
> >>
> >> E.g., if here we had something like
> >>
> >> r1 =3D r10
> >> r1 +=3D -8
> >> if r2 <=3D r1 goto pc +3
> >>
> >> is it fine to track r1 as precise or we need to know that r1 is an ali=
as to r10?
> >>
> >> Not sure myself yet, but I thought I'd bring this up as a concern.
>
> In backtrack_insn, we have:
>
>                  } else if (opcode =3D=3D BPF_MOV) {
>                          if (BPF_SRC(insn->code) =3D=3D BPF_X) {
>                                  /* dreg =3D sreg or dreg =3D (s8, s16, s=
32)sreg
>                                   * dreg needs precision after this insn
>                                   * sreg needs precision before this insn
>                                   */
>                                  bt_clear_reg(bt, dreg);
>                                  if (sreg !=3D BPF_REG_FP)
>                                          bt_set_reg(bt, sreg);
>                          } else {
>                                  /* dreg =3D K
>                                   * dreg needs precision after this insn.
>                                   * Corresponding register is already mar=
ked
>                                   * as precise=3Dtrue in this verifier st=
ate.
>                                   * No further markings in parent are nec=
essary
>                                   */
>                                  bt_clear_reg(bt, dreg);
>                          }
>
> So for insn 'r1 =3D r10', even if r1 is marked precise, but based on the =
above
> code r1 will be cleared and r10 will not be added to bt_set_reg due to
> 'sreg !=3D BPF_REG_FP'. So the current implementation should be okay.
>
>
> >>
> > After discussing this with Eduard offline, I think that we should
> > generalize this a bit and not hard-code r10 handling like this.
> >
> > Note how we use INSN_F_STACK_ACCESS to mark LDX and STX instructions
> > as "accesses stack through register", regardless of whether that
> > register is r10 or any other rx after `rX =3D r10; rX +=3D <offset>`. I
> > think we should do the same here more generally for all instructions,
> > especially for conditional jumps.
> >
> > The only complication is that with INSN_F_STACK_ACCESS we have only
> > one possible register within LDX/STX, while with conditional jumps we
> > can have two registers (and both might be PTR_TO_STACK registers!).
> >
> > So I propose we split INSN_F_STACK_ACCESS into INSN_F_STACK_SRC and
> > INSN_F_STACK_DST and use that to mark either src or dst register as
> > being a PTR_TO_STACK. Then we can generically ignore any register that
> > was a PTR_TO_STACK, because any such register is already implicitly
> > precise.
> >
> > We'd need to slightly update existing code to use either
> > INSN_F_STACK_SRC or INSN_F_STACK_DST, depending on LDX or STX, and
> > then generalize all that to conditionals (and, technically, any other
> > instruction).
> >
> > WDYT? Does it make sense?
>
> I tried to prototype based on the above idea. But ultimately I gave up.
> The following are some of my analysis.
>
> The INSN_F_STACK_ACCESS is used for stack access (load and store).
> See:
>
> /* instruction history flags, used in bpf_insn_hist_entry.flags field */
> enum {
>          /* instruction references stack slot through PTR_TO_STACK regist=
er;
>           * we also store stack's frame number in lower 3 bits (MAX_CALL_=
FRAMES is 8)
>           * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK=
 is 512,
>           * 8 bytes per slot, so slot index (spi) is [0, 63])
>           */
>          INSN_F_FRAMENO_MASK =3D 0x7, /* 3 bits */
>
>          INSN_F_SPI_MASK =3D 0x3f, /* 6 bits */
>          INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
>
>          INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */
> };
>
> static int insn_stack_access_flags(int frameno, int spi)
> {
>          return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno=
;
> }
>
> insn_stack_access_flags() is used by check_stack_read_fixed_off()
> and check_stack_write_fixed_off(). For these two functions,
> eventually a push_insn_history()
>     push_insn_history(env, env->cur_state, insn_flags, 0)
> is done to record related insn_flags info. Note that
> insn_flags could be 0 or could be a actual insn_stack_access_flags()
> which depends on other contexts.
>
> For cond op's like 'rX <op> rY', it is similar to other ALU{32,64} operat=
ions.
> The decision can be made on the spot about to either clear or add related
> registers to bt_reg_set.
>
> I understand that it is desirable to avoid explicit checking BPF_REG_FP
> register. But this seems the simplest workable approach without
> involving push_insn_history().
>
> The more complex option is to do push_insn_history() for 'rX <op> rY'
> conditions with information about how to deal with r10 register, e.g.,
> to enforce the register must be one of r0-r9. That way, in backtrack_insn=
,
> the code can simply to
>     if (hist->dst_reg_mask & dreg)
>        bt_set_reg(bt, dreg);
>     if (hist->src_reg_mask & sreg)
>        bt_set_reg(bt, sreg);
>
> But this seems more complex than current simple approach.
>
> WDYT?

Doing the push_insn_history() is exactly what I had in mind from the
very beginning. I'd do that. It's a bit more code, but it sets us up
better for generic handling of  PTR_TO_STACK registers, regardless if
they are r10 or any other rX. This is the general direction we started
on with INSN_F_STACK_ACCESS, so I think it makes sense to take another
step in that direction, instead of reverting back to hacky BPF_REG_FP
handling.

>
>
> >
> >>>    9: (35) if r1 >=3D 0xffe3fff8 goto pc+0         ; frame1: R1=3Dctx=
()
> >>>    10: (b5) if r2 <=3D 0x8 goto pc+0
> >>>    mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1
> >>>    mark_precise: frame1: regs=3Dr2 stack=3D before 9: (35) if r1 >=3D=
 0xffe3fff8 goto pc+0
> >>>    mark_precise: frame1: regs=3Dr2 stack=3D before 8: (bd) if r2 <=3D=
 r10 goto pc+3
> >>>    mark_precise: frame1: regs=3Dr2,r10 stack=3D before 7: (05) goto p=
c+0
> >>>    mark_precise: frame1: regs=3Dr2,r10 stack=3D before 5: (18) r2 =3D=
 0x20202000256c6c78
> >>>    mark_precise: frame1: regs=3Dr10 stack=3D before 2: (85) call pc+2
> >>>    BUG regs 400
> >>>
> >>> The main failure reason is due to r10 in precision backtracking bookk=
eeping.
> >>> Actually r10 is always precise and there is no need to add it the pre=
cision
> >>> backtracking bookkeeping.
> >>>
> >>> This patch fixed the problem by not adding r10 to prevision backtrack=
ing bookkeeping.
> >>>
> >>>    [1] https://lore.kernel.org/bpf/Z%2F8q3xzpU59CIYQE@ly-workstation/
> >>>
> >>> Reported by: Yi Lai <yi1.lai@linux.intel.com>
> >>> Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking bookkee=
ping")
> >>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >>> ---
> >>>   kernel/bpf/verifier.c | 6 ++++--
> >>>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index 28f5a7899bd6..1cb4d80d15c1 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -4413,8 +4413,10 @@ static int backtrack_insn(struct bpf_verifier_=
env *env, int idx, int subseq_idx,
> >>>                           * before it would be equally necessary to
> >>>                           * propagate it to dreg.
> >>>                           */
> >>> -                       bt_set_reg(bt, dreg);
> >>> -                       bt_set_reg(bt, sreg);
> >>> +                       if (dreg !=3D BPF_REG_FP)
> >>> +                               bt_set_reg(bt, dreg);
> >>> +                       if (sreg !=3D BPF_REG_FP)
> >>> +                               bt_set_reg(bt, sreg);
> >>>                  } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> >>>                           /* dreg <cond> K
> >>>                            * Only dreg still needs precision before
> >>> --
> >>> 2.47.1
> >>>
>


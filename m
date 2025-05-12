Return-Path: <bpf+bounces-58059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09847AB4718
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6AF4A2831
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57F25C71F;
	Mon, 12 May 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvtvC2uI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C51AA791
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087522; cv=none; b=BYGdx8RXIA6Mrk8gs+erioX435kOQUmuNXddcIYIsvt4g9HGxBfPQljeBS9PsOZnZAxCG208d9RzdwHf94siAmSl0CQL5R42gYJ7Yw9bhqCaj1ZcilyKfcNn4TQQjeyiz5C+T2zZttmt1IO4sLGDm77epL2JRor5VCO353jXapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087522; c=relaxed/simple;
	bh=QLq+q/UT94LoCmrzdlPe5Iys35aqg2Rm8PR2WRpS4lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qxbo9P6NdioyWoX5Cw7FTjGWmmcTln0xx61iq2FqYu98qZBMaXNZ1rkwYf4ERVsF2dh2U2/0jVCqFWVrj96PhkC9Zo+Waoh1deCflkJPG/yVok/1twIy5002T4brBaM+98UUe9GHDZgbhqqDIHN5Hb7kcUgK4drXRlsIW+CXV94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvtvC2uI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30e0fa34d55so147031a91.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747087520; x=1747692320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDaOT9sEs/BAzfEm3eok3V8CKc4uvAN3rJI7Q84QXhk=;
        b=HvtvC2uImt/T15fAKUZ6J8LJv6kM8UAdY2vl3ReIBTiwfo6bwPJ8oPgCO9qtQC4TRJ
         10IWzJp3mAbYtl/bLGLGtaihcL8oG1TS4l4k8gEHHKl524kCe8pc+IIhCEoKEbQmpE0O
         vIRYgJ68Sw2dOK7+kJrEXmQKjQIwQnc/2rzhkd3aIz/Ll4QJ9u55/E9Jbi58V1G0H0ot
         bqyZC5I0hH5o+0KhKOy4y9UyVM4ikyizgH4jba7+xcLxFCoC25+HsQc7IaxC2mtQ/iox
         KjUT3ob7VK3dgBxnYFMGLrJzyqUKTwF8BDg9V6vH9CbbiTj7f4Z36pSc6cs412fSiBi/
         3nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747087520; x=1747692320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDaOT9sEs/BAzfEm3eok3V8CKc4uvAN3rJI7Q84QXhk=;
        b=HbrlZ8oUBPCFF9uUd1JsPVn7x8sQPTiiaY8JJRQk4V/4i/StUO0KLhxdgIes3NIIDY
         I6oDgagHFxL6oMC/w4jqgNaGIPhFDBN0WOSs9gDahmRs+aTrm7Yqxuw0P+Eaa40wYNB+
         TZsCnoew+XG2QDy5HtDYihHsXO9JxIYm3w/goKkmqK7rGLuKo5l5GtcBT8BT3tlH/P+k
         jI0A4FU45OJUQh0DTfSnOQFxLxGfYWl7cEH1NSn3IefC2qsBWitdcc/m8I1v6q9Psq7H
         Non8z/N9S9ayCsD3J0YKywKCnP5bkZGr12or5tTz8wWkg0GWp3EVM2ARf2vOR48OjP8V
         pv7A==
X-Gm-Message-State: AOJu0YzHyrP5El00v53GY66sb1X7Mwz+VIv+I43ogGtGNe891BcsEKhG
	w4UlLxZpFnJbqPASfgQHsNrtIRjP7WM0yTrPZcl4V0pScRSFPGFI1wysMskVf6XdNSo24FkoDMs
	q2Dl0q6Zm6EUN05c5ufckggQZk+o=
X-Gm-Gg: ASbGnctbkKXzzCxmnE49U49GVhsGqbF47KBnb/4jGWHxEIAbJ6QPm4vcU3mUtraaLn5
	fLJ9eHUaJVMJFVl8aJZ65kD3fkQ9Sj7naloZBxYOY3zzbzgd7OLc8GhvUl9XMvXNaJesl3FHbSI
	VIvhzYxF9yIC576MBD1eb3M3aG8/EimzkmAVMDy36F/M4MF1IU
X-Google-Smtp-Source: AGHT+IGeV58V8LoeogblR4IDHQdZ5hfmud9oI7ztXRp+241Erzdxp/0WA/SJaWbRxW//GxHlkLyDKMdoY7Z8AR9LKKE=
X-Received: by 2002:a17:90b:3509:b0:2ff:7b28:a51a with SMTP id
 98e67ed59e1d1-30c3d3e2408mr25752256a91.17.1747087520147; Mon, 12 May 2025
 15:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511162758.281071-1-yonghong.song@linux.dev> <CAEf4BzaXB=hJNtpg7aUE67skjhuxDnG_oWHRULnmMNJwc9dRcQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaXB=hJNtpg7aUE67skjhuxDnG_oWHRULnmMNJwc9dRcQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 May 2025 15:05:08 -0700
X-Gm-Features: AX0GCFvH6oqRGt8NhpeMJWKVKsF5rwgdzIe_nETtQdZvBIzp_tbwpErtwGGKsus
Message-ID: <CAEf4BzbTzvapqEjExcOffOfwV=BKLL=ep1azp6VXdyLBgChZtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not include r10 in precision
 backtracking bookkeeping
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 9:26=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, May 11, 2025 at 9:28=E2=80=AFAM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> > Yi Lai reported an issue ([1]) where the following warning appears
> > in kernel dmesg:
> >   [   60.643604] verifier backtracking bug
> >   [   60.643635] WARNING: CPU: 10 PID: 2315 at kernel/bpf/verifier.c:43=
02 __mark_chain_precision+0x3a6c/0x3e10
> >   [   60.648428] Modules linked in: bpf_testmod(OE)
> >   [   60.650471] CPU: 10 UID: 0 PID: 2315 Comm: test_progs Tainted: G  =
         OE       6.15.0-rc4-gef11287f8289-dirty #327 PREEMPT(full)
> >   [   60.654385] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> >   [   60.656682] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> >   [   60.660475] RIP: 0010:__mark_chain_precision+0x3a6c/0x3e10
> >   [   60.662814] Code: 5a 30 84 89 ea e8 c4 d9 01 00 80 3d 3e 7d d8 04 =
00 0f 85 60 fa ff ff c6 05 31 7d d8 04
> >                        01 48 c7 c7 00 58 30 84 e8 c4 06 a5 ff <0f> 0b e=
9 46 fa ff ff 48 ...
> >   [   60.668720] RSP: 0018:ffff888116cc7298 EFLAGS: 00010246
> >   [   60.671075] RAX: 54d70e82dfd31900 RBX: ffff888115b65e20 RCX: 00000=
00000000000
> >   [   60.673659] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000=
000ffffffff
> >   [   60.676241] RBP: 0000000000000400 R08: ffff8881f6f23bd3 R09: 1ffff=
1103ede477a
> >   [   60.678787] R10: dffffc0000000000 R11: ffffed103ede477b R12: ffff8=
88115b60ae8
> >   [   60.681420] R13: 1ffff11022b6cbc4 R14: 00000000fffffff2 R15: 00000=
00000000001
> >   [   60.684030] FS:  00007fc2aedd80c0(0000) GS:ffff88826fa8a000(0000) =
knlGS:0000000000000000
> >   [   60.686837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [   60.689027] CR2: 000056325369e000 CR3: 000000011088b002 CR4: 00000=
00000370ef0
> >   [   60.691623] Call Trace:
> >   [   60.692821]  <TASK>
> >   [   60.693960]  ? __pfx_verbose+0x10/0x10
> >   [   60.695656]  ? __pfx_disasm_kfunc_name+0x10/0x10
> >   [   60.697495]  check_cond_jmp_op+0x16f7/0x39b0
> >   [   60.699237]  do_check+0x58fa/0xab10
> >   ...
> >
> > Further analysis shows the warning is at line 4302 as below:
> >
> >   4294                         /* static subprog call instruction, whic=
h
> >   4295                          * means that we are exiting current sub=
prog,
> >   4296                          * so only r1-r5 could be still requeste=
d as
> >   4297                          * precise, r0 and r6-r10 or any stack s=
lot in
> >   4298                          * the current frame should be zero by n=
ow
> >   4299                          */
> >   4300                         if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS)=
 {
> >   4301                                 verbose(env, "BUG regs %x\n", bt=
_reg_mask(bt));
> >   4302                                 WARN_ONCE(1, "verifier backtrack=
ing bug");
> >   4303                                 return -EFAULT;
> >   4304                         }
> >
> > With the below test (also in the next patch):
> >   __used __naked static void __bpf_jmp_r10(void)
> >   {
> >         asm volatile (
> >         "r2 =3D 2314885393468386424 ll;"
> >         "goto +0;"
> >         "if r2 <=3D r10 goto +3;"
> >         "if r1 >=3D -1835016 goto +0;"
> >         "if r2 <=3D 8 goto +0;"
> >         "if r3 <=3D 0 goto +0;"
> >         "exit;"
> >         ::: __clobber_all);
> >   }
> >
> >   SEC("?raw_tp")
> >   __naked void bpf_jmp_r10(void)
> >   {
> >         asm volatile (
> >         "r3 =3D 0 ll;"
> >         "call __bpf_jmp_r10;"
> >         "r0 =3D 0;"
> >         "exit;"
> >         ::: __clobber_all);
> >   }
> >
> > The following is the verifier failure log:
> >   0: (18) r3 =3D 0x0                      ; R3_w=3D0
> >   2: (85) call pc+2
> >   caller:
> >    R10=3Dfp0
> >   callee:
> >    frame1: R1=3Dctx() R3_w=3D0 R10=3Dfp0
> >   5: frame1: R1=3Dctx() R3_w=3D0 R10=3Dfp0
> >   ; asm volatile ("                                 \ @ verifier_precis=
ion.c:184
> >   5: (18) r2 =3D 0x20202000256c6c78       ; frame1: R2_w=3D0x2020200025=
6c6c78
> >   7: (05) goto pc+0
> >   8: (bd) if r2 <=3D r10 goto pc+3        ; frame1: R2_w=3D0x2020200025=
6c6c78 R10=3Dfp0
>
> For stacks spill/fill we use INSN_F_STACK_ACCESS because not just r10
> can be used to point to the stack. I wonder if we need to handle r10
> more generically here?
>
> E.g., if here we had something like
>
> r1 =3D r10
> r1 +=3D -8
> if r2 <=3D r1 goto pc +3
>
> is it fine to track r1 as precise or we need to know that r1 is an alias =
to r10?
>
> Not sure myself yet, but I thought I'd bring this up as a concern.
>

After discussing this with Eduard offline, I think that we should
generalize this a bit and not hard-code r10 handling like this.

Note how we use INSN_F_STACK_ACCESS to mark LDX and STX instructions
as "accesses stack through register", regardless of whether that
register is r10 or any other rx after `rX =3D r10; rX +=3D <offset>`. I
think we should do the same here more generally for all instructions,
especially for conditional jumps.

The only complication is that with INSN_F_STACK_ACCESS we have only
one possible register within LDX/STX, while with conditional jumps we
can have two registers (and both might be PTR_TO_STACK registers!).

So I propose we split INSN_F_STACK_ACCESS into INSN_F_STACK_SRC and
INSN_F_STACK_DST and use that to mark either src or dst register as
being a PTR_TO_STACK. Then we can generically ignore any register that
was a PTR_TO_STACK, because any such register is already implicitly
precise.

We'd need to slightly update existing code to use either
INSN_F_STACK_SRC or INSN_F_STACK_DST, depending on LDX or STX, and
then generalize all that to conditionals (and, technically, any other
instruction).

WDYT? Does it make sense?

> >   9: (35) if r1 >=3D 0xffe3fff8 goto pc+0         ; frame1: R1=3Dctx()
> >   10: (b5) if r2 <=3D 0x8 goto pc+0
> >   mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1
> >   mark_precise: frame1: regs=3Dr2 stack=3D before 9: (35) if r1 >=3D 0x=
ffe3fff8 goto pc+0
> >   mark_precise: frame1: regs=3Dr2 stack=3D before 8: (bd) if r2 <=3D r1=
0 goto pc+3
> >   mark_precise: frame1: regs=3Dr2,r10 stack=3D before 7: (05) goto pc+0
> >   mark_precise: frame1: regs=3Dr2,r10 stack=3D before 5: (18) r2 =3D 0x=
20202000256c6c78
> >   mark_precise: frame1: regs=3Dr10 stack=3D before 2: (85) call pc+2
> >   BUG regs 400
> >
> > The main failure reason is due to r10 in precision backtracking bookkee=
ping.
> > Actually r10 is always precise and there is no need to add it the preci=
sion
> > backtracking bookkeeping.
> >
> > This patch fixed the problem by not adding r10 to prevision backtrackin=
g bookkeeping.
> >
> >   [1] https://lore.kernel.org/bpf/Z%2F8q3xzpU59CIYQE@ly-workstation/
> >
> > Reported by: Yi Lai <yi1.lai@linux.intel.com>
> > Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking bookkeepi=
ng")
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  kernel/bpf/verifier.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 28f5a7899bd6..1cb4d80d15c1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4413,8 +4413,10 @@ static int backtrack_insn(struct bpf_verifier_en=
v *env, int idx, int subseq_idx,
> >                          * before it would be equally necessary to
> >                          * propagate it to dreg.
> >                          */
> > -                       bt_set_reg(bt, dreg);
> > -                       bt_set_reg(bt, sreg);
> > +                       if (dreg !=3D BPF_REG_FP)
> > +                               bt_set_reg(bt, dreg);
> > +                       if (sreg !=3D BPF_REG_FP)
> > +                               bt_set_reg(bt, sreg);
> >                 } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> >                          /* dreg <cond> K
> >                           * Only dreg still needs precision before
> > --
> > 2.47.1
> >


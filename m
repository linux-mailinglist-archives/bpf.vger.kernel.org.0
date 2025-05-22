Return-Path: <bpf+bounces-58755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB24AC1573
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39649E464C
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D7224245;
	Thu, 22 May 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8ttL8re"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6A221FA5
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747945336; cv=none; b=YajnMZy4KlidoBCKUPby8U6Lz6wCvfjLfsnYV4gIFKWp9MNSFsMMjgOD4gJ/5C+Nn8CuwDUAwaXavxshGcxS0O2Np3f8uZJF6Sa7AZTpQsyfEOjTfA3nFZwEvVCkGxWTCz1UZhARxQqiYbnTj+Rts2l+zkfcuBsrdgkgaGylSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747945336; c=relaxed/simple;
	bh=w61jc/f/dK/MFhGnDvTi8GFQxdieF4t8NSZG6PVf7B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvHYfKZUnET1ZKjBmb4s4b+fT8M2fHTxC9MX8Dy2mzaXB7sSTq3AZwGe/FpgTs0QeW/U+ZBzV9kybiicu0/HsXK/qyoq8Z7nzQFUzSYR6tISZ6BXWBXFaqTr0UewgNnIHB2JeTo2t7EG9qGS6iolias6MpTgMM90n43cCcWJY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8ttL8re; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c277331eso217065b3a.1
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747945334; x=1748550134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2H/k6j9UsaZkVQSeIQDXQQZ+h0sTh0PbLmzgJYjGrM=;
        b=L8ttL8re2v+fnMfos2NQp1nfafCeHYu5FxkSfpPCb6p85fGbWfDWAUEKnLrZ3Y5ZSH
         jeP6XSqEUcZ2OpwakVb5y4xR9v9cKNJ7KqNR8Bhaeab+psNvYVlT6OAeu4xFlBcIUG4x
         xScg/ZRpvrwBIjcf/FoOpjeplLHz2gf8EeGonQVn2f1lMfKjCCX6pSrNxwOmiqRZsUqt
         7+82o/kxaCQpBqcaE59e6I3IQvsH9m7CWXs9KGoS3Gj9Qy4SA3mD35hWrAMrICqTyfeb
         lS6g1hR6O6+28BjB9mfNIukJp/OGYTi8EVIinMavuhMzTH0Xd0Hlz/XTxIQG9Jf5bgtl
         cOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747945334; x=1748550134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2H/k6j9UsaZkVQSeIQDXQQZ+h0sTh0PbLmzgJYjGrM=;
        b=A1f0eEbRCk+giRrIox1wxMHRgCRz9utSv5xeNRhuTBQIxqWH7lLINPy3HbRQt6E80z
         uk1sj3anII+4JQdKTYoxmA+91XIXA8uqPEq8wjXOCuecItS7VoJt0DcCRv05KDx0BU/2
         kbjBdUrNGR+lnmppuxpCmWGFLdoLbwieHogDgi4poxg2rpB7b8aQfgPyJXbzpF0RfI7G
         6jAgSBDvjpzLVbQv9ZhbKvUUnrEs0WtmDZtbXSCCs74eVZF0MzG/Ds2//A4nXIDaGPV7
         +KUF1aGdSYxtu6SsZIdxxzRpDURimZhiU9X31mz+2QYXNvZE9rfMldhLAHdv+SwwA9rs
         GeOA==
X-Gm-Message-State: AOJu0YwgJum39w5dhuOYxRW7+u2ClvhJI/va/PQngmFWS/Gn9Y0yIZqW
	F0Uwkp5Jxa51ntAIqc+lHW8R7h5qg0xeaQwSvbcVcd4U+vAZ94C0TOiIavB8i4ksvJImhHytn2o
	bpBgA88sQdo6znBnjevCevdudkxb5vM22+BJFlzo=
X-Gm-Gg: ASbGncvgn5+d6YMj3kMUB9ArKztMQSWdTHF/jSaH5KOJMA81/bYIs4LlxiI97UYXfFO
	vmNWRyBsMxttvqhBw/GLh2gl+7QHKHjheRZa19bU4Z9T6r/XQWaYa0WzTPNOFdm0oM12SVPlTSR
	5qmB8PuHzt01MZ80k3jDwkum9fkE8Xa5uoKotEZCNwVLktiKbuNWPHasIGH/g=
X-Google-Smtp-Source: AGHT+IGJ1GjHOpLDfG3WS2mxBWXZCHMjbRlgxQDdvkCi8Kc8wxhffp59JaBKzq/GyFNXuOtcrQN7zwCymw185+smVgU=
X-Received: by 2002:a17:90b:5350:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-310e88a4bd4mr1219594a91.2.1747945333718; Thu, 22 May 2025
 13:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522050239.2834718-1-yonghong.song@linux.dev>
In-Reply-To: <20250522050239.2834718-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 May 2025 13:22:01 -0700
X-Gm-Features: AX0GCFs6ol42lVlvj3aMWNhKATv3yP7f8jXZrweTXyNscIx0sONETgUX9DVblyc
Message-ID: <CAEf4BzZe2xeCGQn9Lx6UMmhfvViWQYMtWg+Zb4+6pfci0HyMJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Do not include stack ptr register in
 precision backtracking bookkeeping
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:02=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> Yi Lai reported an issue ([1]) where the following warning appears
> in kernel dmesg:
>   [   60.643604] verifier backtracking bug
>   [   60.643635] WARNING: CPU: 10 PID: 2315 at kernel/bpf/verifier.c:4302=
 __mark_chain_precision+0x3a6c/0x3e10
>   [   60.648428] Modules linked in: bpf_testmod(OE)
>   [   60.650471] CPU: 10 UID: 0 PID: 2315 Comm: test_progs Tainted: G    =
       OE       6.15.0-rc4-gef11287f8289-dirty #327 PREEMPT(full)
>   [   60.654385] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
>   [   60.656682] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>   [   60.660475] RIP: 0010:__mark_chain_precision+0x3a6c/0x3e10
>   [   60.662814] Code: 5a 30 84 89 ea e8 c4 d9 01 00 80 3d 3e 7d d8 04 00=
 0f 85 60 fa ff ff c6 05 31 7d d8 04
>                        01 48 c7 c7 00 58 30 84 e8 c4 06 a5 ff <0f> 0b e9 =
46 fa ff ff 48 ...
>   [   60.668720] RSP: 0018:ffff888116cc7298 EFLAGS: 00010246
>   [   60.671075] RAX: 54d70e82dfd31900 RBX: ffff888115b65e20 RCX: 0000000=
000000000
>   [   60.673659] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000=
0ffffffff
>   [   60.676241] RBP: 0000000000000400 R08: ffff8881f6f23bd3 R09: 1ffff11=
03ede477a
>   [   60.678787] R10: dffffc0000000000 R11: ffffed103ede477b R12: ffff888=
115b60ae8
>   [   60.681420] R13: 1ffff11022b6cbc4 R14: 00000000fffffff2 R15: 0000000=
000000001
>   [   60.684030] FS:  00007fc2aedd80c0(0000) GS:ffff88826fa8a000(0000) kn=
lGS:0000000000000000
>   [   60.686837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [   60.689027] CR2: 000056325369e000 CR3: 000000011088b002 CR4: 0000000=
000370ef0
>   [   60.691623] Call Trace:
>   [   60.692821]  <TASK>
>   [   60.693960]  ? __pfx_verbose+0x10/0x10
>   [   60.695656]  ? __pfx_disasm_kfunc_name+0x10/0x10
>   [   60.697495]  check_cond_jmp_op+0x16f7/0x39b0
>   [   60.699237]  do_check+0x58fa/0xab10
>   ...
>
> Further analysis shows the warning is at line 4302 as below:
>
>   4294                 /* static subprog call instruction, which
>   4295                  * means that we are exiting current subprog,
>   4296                  * so only r1-r5 could be still requested as
>   4297                  * precise, r0 and r6-r10 or any stack slot in
>   4298                  * the current frame should be zero by now
>   4299                  */
>   4300                 if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
>   4301                         verbose(env, "BUG regs %x\n", bt_reg_mask(=
bt));
>   4302                         WARN_ONCE(1, "verifier backtracking bug");
>   4303                         return -EFAULT;
>   4304                 }
>
> With the below test (also in the next patch):
>   __used __naked static void __bpf_jmp_r10(void)
>   {
>         asm volatile (
>         "r2 =3D 2314885393468386424 ll;"
>         "goto +0;"
>         "if r2 <=3D r10 goto +3;"
>         "if r1 >=3D -1835016 goto +0;"
>         "if r2 <=3D 8 goto +0;"
>         "if r3 <=3D 0 goto +0;"
>         "exit;"
>         ::: __clobber_all);
>   }
>
>   SEC("?raw_tp")
>   __naked void bpf_jmp_r10(void)
>   {
>         asm volatile (
>         "r3 =3D 0 ll;"
>         "call __bpf_jmp_r10;"
>         "r0 =3D 0;"
>         "exit;"
>         ::: __clobber_all);
>   }
>
> The following is the verifier failure log:
>   0: (18) r3 =3D 0x0                      ; R3_w=3D0
>   2: (85) call pc+2
>   caller:
>    R10=3Dfp0
>   callee:
>    frame1: R1=3Dctx() R3_w=3D0 R10=3Dfp0
>   5: frame1: R1=3Dctx() R3_w=3D0 R10=3Dfp0
>   ; asm volatile ("                                 \ @ verifier_precisio=
n.c:184
>   5: (18) r2 =3D 0x20202000256c6c78       ; frame1: R2_w=3D0x20202000256c=
6c78
>   7: (05) goto pc+0
>   8: (bd) if r2 <=3D r10 goto pc+3        ; frame1: R2_w=3D0x20202000256c=
6c78 R10=3Dfp0
>   9: (35) if r1 >=3D 0xffe3fff8 goto pc+0         ; frame1: R1=3Dctx()
>   10: (b5) if r2 <=3D 0x8 goto pc+0
>   mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1
>   mark_precise: frame1: regs=3Dr2 stack=3D before 9: (35) if r1 >=3D 0xff=
e3fff8 goto pc+0
>   mark_precise: frame1: regs=3Dr2 stack=3D before 8: (bd) if r2 <=3D r10 =
goto pc+3
>   mark_precise: frame1: regs=3Dr2,r10 stack=3D before 7: (05) goto pc+0
>   mark_precise: frame1: regs=3Dr2,r10 stack=3D before 5: (18) r2 =3D 0x20=
202000256c6c78
>   mark_precise: frame1: regs=3Dr10 stack=3D before 2: (85) call pc+2
>   BUG regs 400
>
> The main failure reason is due to r10 in precision backtracking bookkeepi=
ng.
> Actually r10 is always precise and there is no need to add it for the pre=
cision
> backtracking bookkeeping.
>
> One way to fix the issue is to prevent bt_set_reg() if any src/dst reg is
> r10. Andrii suggested to go with push_insn_history() approach to avoid
> explicitly checking r10 in backtrack_insn().
>
> This patch added push_insn_history() support for cond_jmp like 'rX <op> r=
Y'
> operations. In check_cond_jmp_op(), if any of rX or rY is a stack pointer=
,
> push_insn_history() will record such information, and later backtrack_ins=
n()
> will do bt_set_reg() properly for those register(s).
>
>   [1] https://lore.kernel.org/bpf/Z%2F8q3xzpU59CIYQE@ly-workstation/
>
> Reported by: Yi Lai <yi1.lai@linux.intel.com>
> Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking bookkeeping=
")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf_verifier.h | 12 +++++--
>  kernel/bpf/verifier.c        | 68 ++++++++++++++++++++++++++++++++----
>  2 files changed, 70 insertions(+), 10 deletions(-)
>
> Changelogs:
>   v3 -> v4:
>     - v3: https://lore.kernel.org/bpf/20250521170409.2772304-1-yonghong.s=
ong@linux.dev/
>     - Fix an issue in push_cond_jmp_history(). Previously, '!src_reg' was=
 used to
>       check whether insn is 'dreg <op> imm' or not. But actually '!src_re=
g' is always
>       non-NULL. The new fix is using insn directly.
>   v2 -> v3:
>     - v2: https://lore.kernel.org/bpf/20250516161029.962760-1-yonghong.so=
ng@linux.dev/
>     - In v2, I put sreg_flag/dreg_flag into bpf_insn_hist_entry and the i=
nformation
>       includes register numbers. This is not necessary as later insn in b=
acktracking
>       can retrieve the register number. So the new change is remove sreg_=
flag/dreg_flag
>       from bpf_insn_hist_entry and add two bits in bpf_insn_hist_entry.fl=
ags to
>       record whether the registers (cond jump like <reg> op < reg>) are s=
tack pointer
>       or not. Other changes depend on this data structure change.
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20250511162758.281071-1-yonghong.so=
ng@linux.dev/
>     - In v1, we check r10 register explicitly in backtrack_insn() to deci=
de
>       whether we should do bt_set_reg() or not. Andrii suggested to do
>       push_insn_history() instead. Whether a particular register (r10 in =
this case)
>       should be available for backtracking or not is in check_cond_jmp_op=
(),
>       and such information is pushed with push_insn_history(). Later in b=
acktrack_insn(),
>       such info is retrieved to decide whether precision marking should b=
e
>       done or not. This apporach can avoid explicit checking for r10 in b=
acktrack_insn().
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 78c97e12ea4e..e73a910e4ece 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -357,6 +357,10 @@ enum {
>         INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
>
>         INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */

drop this comment, it's now even more misleading than it was before :)

> +
> +       INSN_F_DST_REG_STACK =3D BIT(10), /* dst_reg is PTR_TO_STACK */
> +       INSN_F_SRC_REG_STACK =3D BIT(11), /* src_reg is PTR_TO_STACK */
> +       /* total 12 bits are used now. */
>  };
>
>  static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
> @@ -365,9 +369,11 @@ static_assert(INSN_F_SPI_MASK + 1 >=3D MAX_BPF_STACK=
 / 8);
>  struct bpf_insn_hist_entry {
>         u32 idx;
>         /* insn idx can't be bigger than 1 million */
> -       u32 prev_idx : 22;
> -       /* special flags, e.g., whether insn is doing register stack spil=
l/load */
> -       u32 flags : 10;
> +       u32 prev_idx : 20;
> +       /* special flags, e.g., whether insn is doing register stack spil=
l/load,
> +        * whether dst/src register is PTR_TO_STACK.

we probably don't need to duplicate the list of meanings of those
flags, just mention that these are INSN_F_xxx flags from the above?

> +        */
> +       u32 flags : 12;
>         /* additional registers that need precision tracking when this
>          * jump is backtracked, vector of six 10-bit records
>          */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d5807d2efc92..e295be7754cd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3739,6 +3739,22 @@ static int check_reg_arg(struct bpf_verifier_env *=
env, u32 regno,
>         return __check_reg_arg(env, state->regs, regno, t);
>  }
>
> +static int insn_reg_access_flags(bool dreg_stack_ptr, bool sreg_stack_pt=
r)

"reg_access" isn't really precise, no? I actually don't see much
benefit for this and insn_[sd]reg_stack_ptr() helpers, they literally
set/get singular bits. It's a bit different for STACK_ACCESS one where
we have bit + integer with mask. Let's keep it simple?


> +{
> +       return (dreg_stack_ptr ? INSN_F_DST_REG_STACK : 0) |
> +              (sreg_stack_ptr ? INSN_F_SRC_REG_STACK : 0);
> +}
> +
> +static bool insn_dreg_stack_ptr(int insn_flags)
> +{
> +       return !!(insn_flags & INSN_F_DST_REG_STACK);
> +}
> +
> +static bool insn_sreg_stack_ptr(int insn_flags)
> +{
> +       return !!(insn_flags & INSN_F_SRC_REG_STACK);
> +}
> +
>  static int insn_stack_access_flags(int frameno, int spi)
>  {
>         return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
> @@ -4402,6 +4418,8 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>                          */
>                         return 0;
>                 } else if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> +                       bool dreg_precise, sreg_precise;
> +
>                         if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt=
, sreg))
>                                 return 0;
>                         /* dreg <cond> sreg
> @@ -4410,8 +4428,16 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
>                          * before it would be equally necessary to
>                          * propagate it to dreg.
>                          */
> -                       bt_set_reg(bt, dreg);
> -                       bt_set_reg(bt, sreg);
> +                       if (!hist)
> +                               return 0;

hm... I'd assume that we need hist only if there is some special
condition (PTR_TO_STACK registers), and otherwise we should assume
that registers are not special.

> +                       dreg_precise =3D !insn_dreg_stack_ptr(hist->flags=
);
> +                       sreg_precise =3D !insn_sreg_stack_ptr(hist->flags=
);
> +                       if (!dreg_precise && !sreg_precise)
> +                               return 0;
> +                       if (dreg_precise)
> +                               bt_set_reg(bt, dreg);
> +                       if (sreg_precise)
> +                               bt_set_reg(bt, sreg);

and so with the above we'll have


if (!hist || !(hist->flags & INSN_F_SRC_REG_STACK))
  bt_set_reg(bt, sreg);
if (!hist || !(hist->flags & INSN_F_DST_REG_STACK))
  bt_set_reg(bt, dreg);

That inversion of conditions is a bit unfortunate, but it's pretty
contained and small, so probably just fine


>                 } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
>                          /* dreg <cond> K
>                           * Only dreg still needs precision before
> @@ -16397,6 +16423,29 @@ static void sync_linked_regs(struct bpf_verifier=
_state *vstate, struct bpf_reg_s
>         }
>  }
>
> +static int push_cond_jmp_history(struct bpf_verifier_env *env, struct bp=
f_verifier_state *state,
> +                                struct bpf_insn *insn, struct bpf_reg_st=
ate *dst_reg,
> +                                struct bpf_reg_state *src_reg, u64 linke=
d_regs)
> +{
> +       bool dreg_stack_ptr, sreg_stack_ptr;
> +       int insn_flags;
> +
> +       if (BPF_SRC(insn->code) !=3D BPF_X) {
> +               if (linked_regs)
> +                       return push_insn_history(env, state, 0, linked_re=
gs);
> +               return 0;
> +       }
> +
> +       dreg_stack_ptr =3D dst_reg->type =3D=3D PTR_TO_STACK;
> +       sreg_stack_ptr =3D src_reg->type =3D=3D PTR_TO_STACK;
> +
> +       if (!dreg_stack_ptr && !sreg_stack_ptr && !linked_regs)
> +               return 0;
> +
> +       insn_flags =3D insn_reg_access_flags(dreg_stack_ptr, sreg_stack_p=
tr);
> +       return push_insn_history(env, state, insn_flags, linked_regs);
> +}
> +
>  static int check_cond_jmp_op(struct bpf_verifier_env *env,
>                              struct bpf_insn *insn, int *insn_idx)
>  {
> @@ -16500,6 +16549,9 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
>                     !sanitize_speculative_path(env, insn, *insn_idx + 1,
>                                                *insn_idx))
>                         return -EFAULT;
> +               err =3D push_cond_jmp_history(env, this_branch, insn, dst=
_reg, src_reg, 0);

I think we are "overabstracting" here with additional helper. This
helper has to redo BPF_X special handling and stuff like that, but for
no good reason. Just do similar approach we have in
check_stack_read_fixed_off:

static int check_cond_jmp_op(...)
{
    int insn_flags =3D 0;
    ...


    if (BPF_SRC(insn->code) =3D=3D BPF_X) {
        if (insn->src_reg is PTR_TO_STACK)
            insn_flags |=3D INSN_F_SRC_REG_STACK;
        if (insn->dst_reg is PTR_TO_STACK)
            insn_flags |=3D INSN_F_DST_REG_STACK;
    } else {
        if (insn->src_reg is PTR_TO_STACK)
            insn_flags |=3D INSN_F_SRC_REG_STACK;
   }

   ...
   if (insn_flags) {
       err =3D push_insn_history(env, ..., insn_flags, 0);
       if (err)
           return err;
   }
   if (linked_regs.cnt > 1) {
       err =3D push_insn_history(env, ..., 0, <linked-regs-stuff>);
       ...
   }}

Note, two push_insn_history() should be fine, check env->cur_hist_ent
handling inside it.

All these tiny small and one-time helpers are added cognitive load, so
unless they are really helpful let's avoid them. These flags are
simple enough to not need any of that, IMO.


pw-bot: cr

> +               if (err)
> +                       return err;
>                 if (env->log.level & BPF_LOG_LEVEL)
>                         print_insn_state(env, this_branch, this_branch->c=
urframe);
>                 *insn_idx +=3D insn->off;
> @@ -16514,6 +16566,9 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
>                                                *insn_idx + insn->off + 1,
>                                                *insn_idx))
>                         return -EFAULT;
> +               err =3D push_cond_jmp_history(env, this_branch, insn, dst=
_reg, src_reg, 0);
> +               if (err)
> +                       return err;
>                 if (env->log.level & BPF_LOG_LEVEL)
>                         print_insn_state(env, this_branch, this_branch->c=
urframe);
>                 return 0;
> @@ -16528,11 +16583,10 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>                 collect_linked_regs(this_branch, src_reg->id, &linked_reg=
s);
>         if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
>                 collect_linked_regs(this_branch, dst_reg->id, &linked_reg=
s);
> -       if (linked_regs.cnt > 1) {
> -               err =3D push_insn_history(env, this_branch, 0, linked_reg=
s_pack(&linked_regs));
> -               if (err)
> -                       return err;
> -       }
> +       err =3D push_cond_jmp_history(env, this_branch, insn, dst_reg, sr=
c_reg,
> +                                   linked_regs.cnt > 1 ? linked_regs_pac=
k(&linked_regs) : 0);
> +       if (err)
> +               return err;
>
>         other_branch =3D push_stack(env, *insn_idx + insn->off + 1, *insn=
_idx,
>                                   false);
> --
> 2.47.1
>


Return-Path: <bpf+bounces-58623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB23ABE7F5
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 01:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C42D4C4D5C
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FE0218EA2;
	Tue, 20 May 2025 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEFl1ktL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB366BFC0
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747783001; cv=none; b=LG3BEBNnsCcH9vxHMXkiQIVI4k+KGUaOEGHPDQhk1Lbnd8MjTJ8iQ0plumAM4jPTIig8+pXo92FED2MB4Z5tfQyHEfz0sDgBSiInCLG0aeYbDhyCQus4eGMg7DXmpNjitop0vVNK9JcbrZKSng30pRI8CDYbi/VG2nAJ8ftA7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747783001; c=relaxed/simple;
	bh=saMOY14G/zkB+dzcnPIx10CZdf+IF0JIdKNXF5azZik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvPlizHsQI9s+RCLAN9T4GKBIikOBwpEBfu5cHUzQ43YC0OO0I90Ar3tR7ZQTqg8KpCLKC3pqLl0SANTGPAf6Wz1JoM9x003Zl+BEibdCrM5IP2yCzgZod2+8Mi8tl/TEcPVelheymIH1IF5IOT2aLY40rKqCqFBgF9qm/RBlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEFl1ktL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30e93977f7cso4544720a91.3
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747782999; x=1748387799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcGsWDdbVkkLc+8jhQi+lR9R/2o+sXoVCJl+MXYsy7I=;
        b=mEFl1ktLGXbHFgtJS/C6hJTnHg1pl/ujryfhw4CBc1ZDBIT4sb+jIVDQgSuhuJwdAs
         xvsfC0LF+s1U05c3DDUNa+WIC4u3CQ46tagx5sz3hfpr8flzz94Rr6DBf41eNctWJPTe
         Agx4mzlIIqGAJ1urgpkCz4pvrHnbgZo2sO51p6Ya6573HRoY1f/KHmOY/53i7pKZeavP
         a90zsGw7OcComBkIVw6v0dzs2lsgOrmRc7zezKMnB53dJFdciyL6Z+SyZgtqG+NMUSrs
         FX4oIZ/TF95qOqTBkEJ6pqhfjSeOzL84+4uBwJYuvjie4mkRD4JpxsDIBdEJ/m6tLgRR
         d4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747782999; x=1748387799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcGsWDdbVkkLc+8jhQi+lR9R/2o+sXoVCJl+MXYsy7I=;
        b=EgOnEOyMoyU3W6B/UM7RNaJ8Y8ttw3UF3yhJNJsX5fcv8nurmyqOs3SczmarBpXLvV
         +NDj1ijjiuKD/FADf+H3fP9uUvFoisZAmWLUgy8jOAkZyHnAE/rr1QGtGvtBa8e1cS/d
         4Uahz33Duo2s9Irmnh1obkxMEe5Dh6p5dG9FG4cTabluZZcSFI+Nnj+ZRhg42xYCn9RW
         pWovB6FH7RhpTrs811Zwzq4hL914ip/9OtG8TqH7O4CFYOEe/yUoHzoArPqY9dybaHRV
         JvLKIttkVylF15XZsYQkuXYgxqBb4xHn5BuavLwy2WB7YYvkwBztnExxOVIbhNXV9u0J
         D6rA==
X-Gm-Message-State: AOJu0YxEQ/8bOq4v8Z1utENd0+I11sLCmjfBKtlUIdq9V1AyfG8EhkgI
	Q3vp5zZ0MGE2+mQFkta6jfE9W26KZAKgObsx2aemRYAnJg6NNxhJRyA8xxnHiDevSVV222mQkmB
	mOBOuhmSFdS9TOSlFPU0TrM/RiBAj/XA=
X-Gm-Gg: ASbGncsT9B1Cyp1GQFSGTMnQUOGQTwqmL0C20rcDD91kBr0I5/JtTqioTum0TFGSTM6
	ZhKH7Cqw64t04q1pB1lHLRv/8oTIjYJ8ac9/ou5QR2d5Fqgizvw5kEjYfPUf+UohnvEJN/TkylK
	SDrsuZAC/HWpoqEi5Gn4z4O2O1RD2jubb9gljP8Gb5gMcWU8t+2TiLU2z5N2k=
X-Google-Smtp-Source: AGHT+IHCzkNS0g78I97BlvtP0hNVq2hbRLNisFX4L+iUhO3IjgXWgmSK/XCJ0swanHdXvgYC8eb5TTovJq4o8bQu71A=
X-Received: by 2002:a17:90b:2c8c:b0:30e:823f:ef31 with SMTP id
 98e67ed59e1d1-30e823ff071mr26755390a91.29.1747782999143; Tue, 20 May 2025
 16:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516161029.962760-1-yonghong.song@linux.dev>
In-Reply-To: <20250516161029.962760-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 May 2025 16:16:26 -0700
X-Gm-Features: AX0GCFu5M-TX4x_3BLFYCN43vFHqBroXK6u-Usn_4eE6UmjSAkRpD_TarOGlGYE
Message-ID: <CAEf4Bzb=ajQxWUL82H0sxTd-OxHYWXCVPzzcwv3snEShHiVuQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Do not include r10 in precision
 backtracking bookkeeping
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 9:10=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
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
> Actually r10 is always precise and there is no need to add it the precisi=
on
> backtracking bookkeeping.
>
> One way to fix the issue is to prevent bt_set_reg() if any src/dst reg is
> r10. Andrii suggested to go with push_insn_history() approach to avoid
> explicitly checking r10 in backtrack_insn().
>
> This patch added push_insn_history() support for cond_jmp like 'rX <op> r=
Y'
> operations. In check_cond_jmp_op(), if any of rX or rY is r10, push_insn_=
history()
> will not record that register, and later backtrack_insn() will not do
> bt_set_reg() for those registers.
>
>   [1] https://lore.kernel.org/bpf/Z%2F8q3xzpU59CIYQE@ly-workstation/
>
> Reported by: Yi Lai <yi1.lai@linux.intel.com>
> Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking bookkeeping=
")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  7 ++++
>  kernel/bpf/verifier.c        | 69 +++++++++++++++++++++++++++++-------
>  2 files changed, 64 insertions(+), 12 deletions(-)
>
> Changelogs:
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
> index cedd66867ecf..9d3fdabeeaf4 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -357,6 +357,8 @@ enum {
>         INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
>
>         INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */
> +
> +       INSN_F_REG_ACCESS =3D BIT(4), /* we need 5 bits total */

hm... you are actually clashing with INSN_F_SPI_MASK here, bits 3
through 8 are used to record stack slot index.

I think we should go with

INSN_F_DST_REG_STACK =3D BIT(10), /* dst_reg is PTR_TO_STACK */
INSN_F_SRC_REG_STACK =3D BIT(11), /* src_reg is PTR_TO_STACK */
/* total 12 bits total can used now */

also note that all this stuff needs to fit into
bpf_insn_hist_entry.flags, which is currently set to be 10 bits, and
so now we need two extra bits.

Luckily, prev_idx: 22 doesn't really need 22 bits, so we can steal two
bits there and still be able to express 1 million instructions
indices:

u32 prev_idx : 20;
u32 flags : 12;

pw-bot: cr

>  };
>
>  static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
> @@ -372,6 +374,11 @@ struct bpf_insn_hist_entry {
>          * jump is backtracked, vector of six 10-bit records
>          */
>         u64 linked_regs;
> +       /* special flag, e.g., whether reg is used for non-load/store ins=
ns
> +        * during precision backtracking.
> +        */
> +       u8 sreg_flag;
> +       u8 dreg_flag;

this is not necessary, src_reg and dst_reg number itself is coming
from the bpf_insn itself?

[...]

> @@ -4414,8 +4425,16 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
>                          * before it would be equally necessary to
>                          * propagate it to dreg.
>                          */
> -                       bt_set_reg(bt, dreg);
> -                       bt_set_reg(bt, sreg);
> +                       if (!hist)
> +                               return 0;
> +                       dreg_precise =3D hist->dreg_flag =3D=3D insn_reg_=
with_access_flag(dreg);
> +                       sreg_precise =3D hist->sreg_flag =3D=3D insn_reg_=
with_access_flag(sreg);

As I mentioned above, we don't need to store dst_reg and src_reg
numbers themselves, we are getting them from bpf_insn. We just need
those two flags, INSN_F_DST_REG_STACK and INSN_F_SRC_REG_STACK, to
know which registers were PTR_TO_STACK at the time when we validated
that instruction

> +                       if (!dreg_precise && !sreg_precise)
> +                               return 0;
> +                       if (dreg_precise)
> +                               bt_set_reg(bt, dreg);
> +                       if (sreg_precise)
> +                               bt_set_reg(bt, sreg);
>                 } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
>                          /* dreg <cond> K
>                           * Only dreg still needs precision before
> @@ -5115,7 +5134,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>         }
>
>         if (insn_flags)
> -               return push_insn_history(env, env->cur_state, insn_flags,=
 0);
> +               return push_insn_history(env, env->cur_state, insn_flags,=
 0, 0, 0);
>         return 0;
>  }
>
> @@ -5422,7 +5441,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
>                 insn_flags =3D 0; /* we are not restoring spilled registe=
r */
>         }
>         if (insn_flags)
> -               return push_insn_history(env, env->cur_state, insn_flags,=
 0);
> +               return push_insn_history(env, env->cur_state, insn_flags,=
 0, 0, 0);
>         return 0;
>  }
>
> @@ -16414,6 +16433,27 @@ static void sync_linked_regs(struct bpf_verifier=
_state *vstate, struct bpf_reg_s
>         }
>  }
>
> +static int push_cond_jmp_history(struct bpf_verifier_env *env, struct bp=
f_verifier_state *state,
> +                                struct bpf_insn *insn, u64 linked_regs)
> +{
> +       int err;
> +
> +       if ((BPF_SRC(insn->code) !=3D BPF_X ||
> +            (insn->src_reg =3D=3D BPF_REG_FP && insn->dst_reg =3D=3D BPF=
_REG_FP)) &&

we shouldn't be checking for BPF_REG_FP here either. Look up
bpf_reg_state by insn->src_reg, and check that it's PTR_TO_STACK

> +           !linked_regs)
> +               return 0;
> +
> +       err =3D push_insn_history(env, state, 0, linked_regs,
> +               BPF_SRC(insn->code) =3D=3D BPF_X && insn->src_reg !=3D BP=
F_REG_FP
> +                       ? insn_reg_with_access_flag(insn->src_reg)
> +                       : 0,
> +               BPF_SRC(insn->code) =3D=3D BPF_X && insn->dst_reg !=3D BP=
F_REG_FP
> +                       ? insn_reg_with_access_flag(insn->dst_reg)
> +                       : 0);
> +
> +       return err;
> +}
> +

[...]


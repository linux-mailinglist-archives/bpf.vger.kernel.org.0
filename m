Return-Path: <bpf+bounces-33443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5743691CFD5
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 03:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204D61C20E84
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 01:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28304691;
	Sun, 30 Jun 2024 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxVvOibP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E73EBE;
	Sun, 30 Jun 2024 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719711824; cv=none; b=dKriFPnoMA/s/qFVUlS5g9Qr7h1GV8xdWMDY64EVkdvAX2XHE+G4djIBdJcYNq3nfpD6Kqfi6QHXeSpD0Ox70nVb8qnZDP/m+R4sz7bqWY+5Onssv+8UG7uR+esLl79tWxAePS3qz0OZjrYG4wiQBBOGTV3/7KbaozOuRzhQRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719711824; c=relaxed/simple;
	bh=O/yU9WizPMUCOe8qi26FPcfh2g5Pe63VCVioU9Vfn9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMn6ae8QkBqkk3dftvjrzbdhwCmTc5prvMXnlzGYcXcISbg50LJ/LAJNMOE9yrq8mrS6Gha2WdFJL8QXOmFkWE2bVtGoGm2A5Fw48ADF3K5vgNmNOQ6zo5cFG9Xi3V+McDvLQkzQmn+gu9NkY7rgLH0G71X4ywwg8faznknskRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxVvOibP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C02CC4AF07;
	Sun, 30 Jun 2024 01:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719711823;
	bh=O/yU9WizPMUCOe8qi26FPcfh2g5Pe63VCVioU9Vfn9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RxVvOibPZjRj13r4ZvrUmKs203kYIcbpsBs+51cd9Yr1ql1e6FxM20s7eJRFkTfqI
	 tBwWOA8ZHfPSdyrV8rHR26GiZ6u3tSozk8DuWIPx9D7jl2tgC9b5Z2y8wCHUBihEPo
	 cxGJC57SlPreMnkLrRlLm23qqG/XoBNk3CNTwtWXJLjRBPqf/KGCnr/f36IvcdTn6O
	 uVwSd9Akq4U5McV+I5oi0XQ4/VZLS3DGt4ysJRC0wRe6HG2SJRj4ivEriU3wVQ012N
	 Xm7vTHQwVzY4hIKv4AagS0vzjE36NcmrP8Ng4F+y2S1SX2NLXV7kVxb7DAJ6H0K4Fz
	 CU+vGtLoVwMMw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d044aa5beso2207358a12.2;
        Sat, 29 Jun 2024 18:43:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw49TFWcPDCwHOoM2RzAAPyq34AvNx/VESmu7C15nLqNzGw0I//LGO6t7F0h7CwhVrJG5XjvPgJnHBnbJCA3143QD3PstPCGPJFSMAhK0flLyO5YQ9IV1E1fphel4/d2lo9NywjQLRseOfjIwcP3xCIxVIbOzJMxuZw88SjJgSqb2iAOcC
X-Gm-Message-State: AOJu0YzHoOHT3ooyZMLtfvCPkns+FhzK/O0sUi8oIau+RtvCk8oXPPXy
	j3cZrqrl4j+293x59Fq5Uos2vFrhWrp/jcplkrkNwDmIyf2fopr06rHAc1QiVpXvy46eDULiIy5
	bdb5kfD5iOpeQj24arU9sb/nI7/o=
X-Google-Smtp-Source: AGHT+IF1SqY61BcCy/EByMCU4N+bUc6L3mA6B7pscrTMU4LiHM3tRWPtW6AedSdTHTBUM05m8G42JlbI2ns2KgSH6e8=
X-Received: by 2002:a05:6402:2811:b0:57c:61a2:ed47 with SMTP id
 4fb4d7f45d1cf-5879f5a3739mr1306169a12.24.1719711822199; Sat, 29 Jun 2024
 18:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627173806.GC21813@redhat.com> <37f79351-a051-3fa9-7bfb-960fb2762e27@loongson.cn>
 <20240629133747.GA4504@redhat.com> <CAAhV-H4tCrTuWJa88JE96N93U2O_RUsnA6WAAUMOWR6EzM9Mzw@mail.gmail.com>
 <20240629150313.GB4504@redhat.com>
In-Reply-To: <20240629150313.GB4504@redhat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 30 Jun 2024 09:43:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4HtRkn1i9pxBojEmzWPysqq=mScoP6PYzZ6v29v2WYoQ@mail.gmail.com>
Message-ID: <CAAhV-H4HtRkn1i9pxBojEmzWPysqq=mScoP6PYzZ6v29v2WYoQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: make the users of larch_insn_gen_break() constant
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, andrii.nakryiko@gmail.com, andrii@kernel.org, 
	bpf@vger.kernel.org, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, mhiramat@kernel.org, nathan@kernel.org, 
	rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Oleg,

On Sat, Jun 29, 2024 at 11:05=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> LoongArch defines UPROBE_SWBP_INSN as a function call and this breaks
> arch_uprobe_trampoline() which uses it to initialize a static variable.
>
> Add the new "__builtin_constant_p" helper, __emit_break(), and redefine
> the current users of larch_insn_gen_break() to use it.
>
> The patch adds check_emit_break() into kprobes.c and uprobes.c to test
> this change. They can be removed if LoongArch boots at least once, but
> otoh these 2 __init functions will be discarded by free_initmem().
>
> Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return pr=
obe")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20240614174822.GA1185149@thelio-3990X=
/
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/loongarch/include/asm/inst.h    |  3 +++
>  arch/loongarch/include/asm/uprobes.h |  4 ++--
>  arch/loongarch/kernel/kprobes.c      | 12 ++++++++++--
>  arch/loongarch/kernel/uprobes.c      |  8 ++++++++
>  4 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index c3993fd88aba..944482063f14 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -532,6 +532,9 @@ static inline void emit_##NAME(union loongarch_instru=
ction *insn,   \
>
>  DEF_EMIT_REG0I15_FORMAT(break, break_op)
>
> +/* like emit_break(imm) but returns a constant expression */
> +#define __emit_break(imm)      ((u32)((imm) | (break_op << 15)))
> +
>  #define DEF_EMIT_REG0I26_FORMAT(NAME, OP)                              \
>  static inline void emit_##NAME(union loongarch_instruction *insn,      \
>                                int offset)                              \
> diff --git a/arch/loongarch/include/asm/uprobes.h b/arch/loongarch/includ=
e/asm/uprobes.h
> index c8f59983f702..99a0d198927f 100644
> --- a/arch/loongarch/include/asm/uprobes.h
> +++ b/arch/loongarch/include/asm/uprobes.h
> @@ -9,10 +9,10 @@ typedef u32 uprobe_opcode_t;
>  #define MAX_UINSN_BYTES                8
>  #define UPROBE_XOL_SLOT_BYTES  MAX_UINSN_BYTES
>
> -#define UPROBE_SWBP_INSN       larch_insn_gen_break(BRK_UPROBE_BP)
> +#define UPROBE_SWBP_INSN       __emit_break(BRK_UPROBE_BP)
>  #define UPROBE_SWBP_INSN_SIZE  LOONGARCH_INSN_SIZE
>
> -#define UPROBE_XOLBP_INSN      larch_insn_gen_break(BRK_UPROBE_XOLBP)
> +#define UPROBE_XOLBP_INSN      __emit_break(BRK_UPROBE_XOLBP)
>
>  struct arch_uprobe {
>         unsigned long   resume_era;
> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kpro=
bes.c
> index 17b040bd6067..78cfaac52748 100644
> --- a/arch/loongarch/kernel/kprobes.c
> +++ b/arch/loongarch/kernel/kprobes.c
> @@ -4,8 +4,16 @@
>  #include <linux/preempt.h>
>  #include <asm/break.h>
>
> -#define KPROBE_BP_INSN         larch_insn_gen_break(BRK_KPROBE_BP)
> -#define KPROBE_SSTEPBP_INSN    larch_insn_gen_break(BRK_KPROBE_SSTEPBP)
> +#define KPROBE_BP_INSN         __emit_break(BRK_KPROBE_BP)
> +#define KPROBE_SSTEPBP_INSN    __emit_break(BRK_KPROBE_SSTEPBP)
> +
> +static __init int check_emit_break(void)
> +{
> +       BUG_ON(KPROBE_BP_INSN      !=3D larch_insn_gen_break(BRK_KPROBE_B=
P));
> +       BUG_ON(KPROBE_SSTEPBP_INSN !=3D larch_insn_gen_break(BRK_KPROBE_S=
STEPBP));
> +       return 0;
> +}
> +arch_initcall(check_emit_break);
>
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe);
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> diff --git a/arch/loongarch/kernel/uprobes.c b/arch/loongarch/kernel/upro=
bes.c
> index 87abc7137b73..90462d94c28f 100644
> --- a/arch/loongarch/kernel/uprobes.c
> +++ b/arch/loongarch/kernel/uprobes.c
> @@ -7,6 +7,14 @@
>
>  #define UPROBE_TRAP_NR UINT_MAX
>
> +static __init int check_emit_break(void)
> +{
> +       BUG_ON(UPROBE_SWBP_INSN  !=3D larch_insn_gen_break(BRK_UPROBE_BP)=
);
> +       BUG_ON(UPROBE_XOLBP_INSN !=3D larch_insn_gen_break(BRK_UPROBE_XOL=
BP));
> +       return 0;
> +}
> +arch_initcall(check_emit_break);
Do you mind if I remove the runtime checking after Tiezhu tests the correct=
ness?

Huacai

> +
>  int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
>                              struct mm_struct *mm, unsigned long addr)
>  {
> --
> 2.25.1.362.g51ebf55
>
>


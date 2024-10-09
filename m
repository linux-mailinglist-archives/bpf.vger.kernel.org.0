Return-Path: <bpf+bounces-41505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86866997963
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A021F22218
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 23:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F91E5020;
	Wed,  9 Oct 2024 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds3vIpNC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E91E491B;
	Wed,  9 Oct 2024 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518083; cv=none; b=fay9e5MV39IjOF7e9IpnJPDA6wAJ0Dx6qMx8UeIdFkxdvMf6bxKyY8bXuksRKoQTz8Oj/2PFI8+HX+q+mO22aRZA9TIWMnbyf1O9Jm5ek9iwnEatXl86bWoxu/emysCP4oEMDXfr1TxFW41Mi5gMIQHvxHXBMH1XkZSgJrlc8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518083; c=relaxed/simple;
	bh=C4RxgxGD8npyQ5TKaAsfJ3EgvIXM0eWN4rL7hE/n5TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUxNF734SA2nmDNw+gCN7WYqdCnpJ8YUqd8K7+lILfFIfUv8wozqzh2mxjCjBvpPwZYqBRVCdADR/wyKo+zGJsmET+BFLH+h176mQ41F8QxDmsOOAQDWHhxvDIGLY73Q56c7uzZfK5/dsWuHYFgzQkCU9eKl1pe2QC3hQ4z33sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ds3vIpNC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a83562f9be9so43045966b.0;
        Wed, 09 Oct 2024 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728518079; x=1729122879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4xmhm/VtsFlv3tQGHKk9vIOcQkMuUm999BkbL9givE=;
        b=ds3vIpNCiWkAVqw9bxq/x7ERzn9USl5K00HwWeTBtBsWwftRstHsKP5cfa7n+BMMhr
         7W1TQwMuXOyCE2FCFYl/VMceYl6buB9dlosvq/sMmxlCenNcjGYPdZtHnYk9ZCOi+7cm
         urL557ZnvM6p5CteZJmaa/2G+3Smsitumfc91R8et0PGSR6Bi0M1P8UaJHnAEIu+5RON
         t7N+46n2gC2+D+LpOjJ45LhjixOVX5f/mXq22pOhM166Hqt/kAiCN28GcnqGbunyi6ax
         dGlovFyfZ8sVpr2VmnWIEBmt/xxW/xljKg0XURPvb57bET2pEOFF+SBetGQeadOpkWLg
         UPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518079; x=1729122879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4xmhm/VtsFlv3tQGHKk9vIOcQkMuUm999BkbL9givE=;
        b=eS8hzTPEBvo4BnQcgKLVNeqI0jCvr18e6aN8FmtGPwewGMVHsIMYMBwNuPmD82OUoB
         f9gIQ089wc+wukLcIBJXMnoSkCilDbHLSJUDX+/1Iraypj6D4eAU0vHkg15li/7fTc93
         +JXd++muuKJOjEIGvM1jhkeI4Og0Pex7qH5mutp2hlBtIjNwpBQYV9PgKmelcTT5FITP
         npIh0OtX/sFfTCWo0ozaS97gqWPpn7/4K9+b9xIETqnnJyicWecS4WPNVtHpxe8IfSzo
         oQR/UN+91gZjOEiW80c4vuyVdqwge+0l+PKiptTD2paVNelHdC/Of3KzV1jCDxTbNLrD
         GBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP/Q58qLOp6HoZD+rNx6m+yadMssEM3ZbrZ3HiHNycjKRl1qyNO6ukSKyEiqYD6DcIsDE=@vger.kernel.org, AJvYcCVRYMyeK4BfnBU4nxuysBdZMdLDyp5q/oyjyQHfAhHfhNZcU6mb/MbUMqeMCuDkhzz0QpLvEO1krNyo51q0@vger.kernel.org, AJvYcCVfzO3p4+y55NMwmbZ/Y1bQS/TLioMIOJcb4o35NIGxf3UIQ7LMzCCcLkrKIfP8ienJbWi61+4igKEJC/mLtKQwbvrg@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQoUQnXhoVZ1Fx4WYLd9+mZSbTm+zw0YmlOD6JRKbvxBEN07E
	0aIrOf1/UAWRbSFjjl7rLijlTariMwMID9LFNinpRdm2+GhFb0XsvQDt6WRfKVqnXM2nsoSSMNX
	iZ1r+J6eYKms9htRFKl5LRlmIW/Y=
X-Google-Smtp-Source: AGHT+IG64IU/+X3l3Z/u7NsnGMUvAfPglJCyCiBPGKYHJdUDIIi3RIJBO9KDuSsIy9TgEyssEKuYG83JfyLN8zj/eU4=
X-Received: by 2002:a17:907:e2d9:b0:a93:c1dd:7952 with SMTP id
 a640c23a62f3a-a998d32ef7bmr373405966b.56.1728518079334; Wed, 09 Oct 2024
 16:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909071114.1150053-1-liaochang1@huawei.com>
In-Reply-To: <20240909071114.1150053-1-liaochang1@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 9 Oct 2024 16:54:25 -0700
Message-ID: <CAEf4BzZVUPZHyuyt6zGZVTQ3sB8u64Wxfuks9BGq-HXGM1yp3A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: insn: Simulate nop instruction for better
 uprobe performance
To: Liao Chang <liaochang1@huawei.com>, will@kernel.org, mark.rutland@arm.com
Cc: catalin.marinas@arm.com, ast@kernel.org, puranjay@kernel.org, 
	andrii@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:21=E2=80=AFAM Liao Chang <liaochang1@huawei.com> =
wrote:
>
> v2->v1:
> 1. Remove the simuation of STP and the related bits.
> 2. Use arm64_skip_faulting_instruction for single-stepping or FEAT_BTI
>    scenario.
>
> As Andrii pointed out, the uprobe/uretprobe selftest bench run into a
> counterintuitive result that nop and push variants are much slower than
> ret variant [0]. The root cause lies in the arch_probe_analyse_insn(),
> which excludes 'nop' and 'stp' from the emulatable instructions list.
> This force the kernel returns to userspace and execute them out-of-line,
> then trapping back to kernel for running uprobe callback functions. This
> leads to a significant performance overhead compared to 'ret' variant,
> which is already emulated.
>
> Typicall uprobe is installed on 'nop' for USDT and on function entry
> which starts with the instrucion 'stp x29, x30, [sp, #imm]!' to push lr
> and fp into stack regardless kernel or userspace binary. In order to
> improve the performance of handling uprobe for common usecases. This
> patch supports the emulation of Arm64 equvialents instructions of 'nop'
> and 'push'. The benchmark results below indicates the performance gain
> of emulation is obvious.
>
> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
>
> xol (1 cpus)
> ------------
> uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
>
> emulation (1 cpus)
> -------------------
> uprobe-nop:  1.862 =C2=B1 0.002M/s  (1.862M/prod)
> uprobe-push: 1.743 =C2=B1 0.006M/s  (1.743M/prod)
> uprobe-ret:  1.840 =C2=B1 0.001M/s  (1.840M/prod)
> uretprobe-nop:  0.964 =C2=B1 0.004M/s  (0.964M/prod)
> uretprobe-push: 0.936 =C2=B1 0.004M/s  (0.936M/prod)
> uretprobe-ret:  0.940 =C2=B1 0.001M/s  (0.940M/prod)
>
> As shown above, the performance gap between 'nop/push' and 'ret'
> variants has been significantly reduced. Due to the emulation of 'push'
> instruction needs to access userspace memory, it spent more cycles than
> the other.
>
> As Mark suggested [1], it is painful to emulate the correct atomicity
> and ordering properties of STP, especially when it interacts with MTE,
> POE, etc. So this patch just focus on the simuation of 'nop'. The
> simluation of STP and related changes will be addressed in a separate
> patch.
>
> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02e=
zZ5YruVuQw@mail.gmail.com/
> [1] https://lore.kernel.org/all/Zr3RN4zxF5XPgjEB@J2N7QTR9R3/
>
> CC: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/arm64/include/asm/insn.h            |  6 ++++++
>  arch/arm64/kernel/probes/decode-insn.c   |  9 +++++++++
>  arch/arm64/kernel/probes/simulate-insn.c | 11 +++++++++++
>  arch/arm64/kernel/probes/simulate-insn.h |  1 +
>  4 files changed, 27 insertions(+)
>

I'm curious what's the status of this patch? It received no comments
so far in the last month. Can someone on the ARM64 side of things
please take a look? (or maybe it was applied to some tree and there
was just no notification?)

This is a very useful performance optimization for uprobe tracing on
ARM64, so would be nice to get it in during current release cycle.
Thank you!

> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.=
h
> index 8c0a36f72d6f..dd530d5c3d67 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -549,6 +549,12 @@ static __always_inline bool aarch64_insn_uses_litera=
l(u32 insn)
>                aarch64_insn_is_prfm_lit(insn);
>  }
>
> +static __always_inline bool aarch64_insn_is_nop(u32 insn)
> +{
> +       return aarch64_insn_is_hint(insn) &&
> +              ((insn & 0xFE0) =3D=3D AARCH64_INSN_HINT_NOP);
> +}
> +
>  enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
>  u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 i=
nsn);
>  u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/p=
robes/decode-insn.c
> index 968d5fffe233..be54539e309e 100644
> --- a/arch/arm64/kernel/probes/decode-insn.c
> +++ b/arch/arm64/kernel/probes/decode-insn.c
> @@ -75,6 +75,15 @@ static bool __kprobes aarch64_insn_is_steppable(u32 in=
sn)
>  enum probe_insn __kprobes
>  arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
>  {
> +       /*
> +        * While 'nop' instruction can execute in the out-of-line slot,
> +        * simulating them in breakpoint handling offers better performan=
ce.
> +        */
> +       if (aarch64_insn_is_nop(insn)) {
> +               api->handler =3D simulate_nop;
> +               return INSN_GOOD_NO_SLOT;
> +       }
> +
>         /*
>          * Instructions reading or modifying the PC won't work from the X=
OL
>          * slot.
> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel=
/probes/simulate-insn.c
> index 22d0b3252476..5e4f887a074c 100644
> --- a/arch/arm64/kernel/probes/simulate-insn.c
> +++ b/arch/arm64/kernel/probes/simulate-insn.c
> @@ -200,3 +200,14 @@ simulate_ldrsw_literal(u32 opcode, long addr, struct=
 pt_regs *regs)
>
>         instruction_pointer_set(regs, instruction_pointer(regs) + 4);
>  }
> +
> +void __kprobes
> +simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +       /*
> +        * Compared to instruction_pointer_set(), it offers better
> +        * compatibility with single-stepping and execution in target
> +        * guarded memory.
> +        */
> +       arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> +}
> diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/kernel=
/probes/simulate-insn.h
> index e065dc92218e..efb2803ec943 100644
> --- a/arch/arm64/kernel/probes/simulate-insn.h
> +++ b/arch/arm64/kernel/probes/simulate-insn.h
> @@ -16,5 +16,6 @@ void simulate_cbz_cbnz(u32 opcode, long addr, struct pt=
_regs *regs);
>  void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
>  void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
>  void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)=
;
> +void simulate_nop(u32 opcode, long addr, struct pt_regs *regs);
>
>  #endif /* _ARM_KERNEL_KPROBES_SIMULATE_INSN_H */
> --
> 2.34.1
>


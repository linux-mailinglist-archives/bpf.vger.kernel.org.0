Return-Path: <bpf+bounces-66757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0477B38FBA
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E6717C1D2
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5E5156678;
	Thu, 28 Aug 2025 00:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5wybHsa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719143A1DB
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340582; cv=none; b=t1XDPgU3Cxn+14I5KSnPq2pCLMwfy22DKNUaDqszDEKQbVnPbyTmqYErM+zcBTmyOac49zAeXNN7Oul3oQVwdGVXbaf5YFTDSDwNIZsMp/KRI98xDnfRotLXoOqi2wfzkfeCHWdaHfNzsosjg0zmPKpoQubHle8MJuxq6JAe7Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340582; c=relaxed/simple;
	bh=mbLeTw+LId6pSb1+lK6wPwDXNhAXg0peJjf950JQkgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrqrjuJiq3G4ivpqpzFxLiMi4dN0xnBIRPJWQut2cJqdK7XMb4sDZFfhVhdcD5GUCkIvroZvatoYycJkuE/9qAIRt8sHiDzolySkZv0ba/dOG1rlOPzQkL3HoMfghrheQp4UO9zccAmBk7RAWQB4lYkY5/sgh708PBVOEi2nc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5wybHsa; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-afede1b3d05so50498466b.2
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756340579; x=1756945379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/aWn/pOfazm9clrvI1/AvLb4Fft/EHmunHDSD7BWngI=;
        b=D5wybHsaYjgzUBu4/y0F8HaUkOozM1Lml/ec3gBMXU7W8+MB7J5pNaiRA7jNsDEhDB
         nvPvutjdSD6mVIXPZU54xjhc90R30h/K97q4+RkJ0LL/DI27JpH3oddg4OmYDE66Aztr
         gWx081dXZzuaLuGS37gR5O28blDDpc5eKGS33ynx/S66rgChg5RVsRE1CyC2+YOZRRcl
         kLNIWKMOGlZVjG7xavZNWpy+gRHTKJsL5jRTId7bzrksKz82cNdcdGOo3CmLlCxB7pOR
         4onZo4vyN2WI5EG1vtohRjLhk690iScjzlN1oSgBFl9agbK6QWL0XSmNSfPf8656Enub
         Rw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340579; x=1756945379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aWn/pOfazm9clrvI1/AvLb4Fft/EHmunHDSD7BWngI=;
        b=jHoI66TKEkhK9wJqfHZ1SMaVFlIkp9McC6O288kCU0wMbp+ivfyuu0B6pz+jJuHeAZ
         +kmr+XM0N4Eu04IWNrS7xmMHmbH4ZaiiRwwN2QVo2iv1jAZGWRWBFXczDcKMNyVyqJG2
         EaCMaSv0XYsn3Cj7OQ2d4txsoOrqNN+ppnvRPaq2g1ZxSkkYyfco6S3Nb50Pn+kWDEfl
         IMWtXVgcIM0sFBUC+trV9nN/xdn7zmzJcsprLIX02bR+beEBd4UTB+UXBfprsTYR5+Z9
         3P4LU3D4jTZMon8W81fOztEH/X5o7Qa4R3Ac/X1PU88M0cxwxDchFbTPdnGt8hmc3yDD
         M7QA==
X-Forwarded-Encrypted: i=1; AJvYcCWaqljUoV2yKEbjlEJyEu0NNrBgx5PKZnFP90Gkt4uOMlGII6aAO+i8IQfzVJQtbre70JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbLo+Um2al2+fhyxWvSFcTSuRwyLBc/iPeLqum6vEAUCnjWUG
	p85RLVLMcIFIgI1ijrCqw9qkVePI0j+KBoVSe5d3IlxpOopZYKwPEkUsNs7DzWnXLoaTRgb6g8C
	naELawL94mC09mXXQ/7WWz6AGX0L5OTw=
X-Gm-Gg: ASbGnctyDh2+8r25PYjhCrAlNIv3joy1okfQ9+Ldlj5d7Jkp7zmv0Bv4Pz824kXi376
	XY1W/Dc1bkkXH3PUuDtYRKuDdGXyTfx8wjWv6kQNWUjQw0FJ/+NOp2Fja1xdRnal3ewcapD0xT/
	Sm8Jslbs3ZSSjEsgNdCiqJqsiZ1wUIINmg1knSLyv87OHhFPAwT53ppbu3+MMRr74q7g7yHbVSa
	2jprwNvmPYvDa5mPtuXC7DoJDoYCmihbBogPgsG
X-Google-Smtp-Source: AGHT+IEvM367u2NHWCHkBPVbnd+qIh9zJeAU+51Ys/jlp2xyr7ClbLXADmR8Cecgjmn5A/aagMxbgaKMwyULD8scIXg=
X-Received: by 2002:a17:907:970c:b0:afe:af04:33e4 with SMTP id
 a640c23a62f3a-afeaf0449bbmr642936666b.11.1756340578441; Wed, 27 Aug 2025
 17:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827153728.28115-1-puranjay@kernel.org> <20250827153728.28115-3-puranjay@kernel.org>
In-Reply-To: <20250827153728.28115-3-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Aug 2025 02:22:21 +0200
X-Gm-Features: Ac12FXzKS3sewJwRGyumXbWTZPw_DYw6CDujXWyHeKygtZXn8NZm62rNYV6bhNY
Message-ID: <CAP01T75ajCxNOPLyJzpAb9bnOJLyKFNDAgXqnEQZpGdXOp6CFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Report arena faults to BPF stderr
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 17:37, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Begin reporting arena page faults and the faulting address to BPF
> program's stderr, this patch adds support in the arm64 and x86-64 JITs,
> support for other archs can be added later.
>
> The fault handlers receive the 32 bit address in the arena region so
> the upper 32 bits of user_vm_start is added to it before printing the
> address. This is what the user would expect to see as this is what is
> printed by bpf_printk() is you pass it an address returned by
> bpf_arena_alloc_pages();
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 52 +++++++++++++++++++++++
>  arch/x86/net/bpf_jit_comp.c   | 79 +++++++++++++++++++++++++++++++++--
>  include/linux/bpf.h           |  5 +++
>  kernel/bpf/arena.c            | 20 +++++++++
>  4 files changed, 152 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 42643fd9168fc..5083886d6e66b 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1066,6 +1066,30 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
>         emit(A64_RET(A64_LR), ctx);
>  }
>
> +/*
> + * Metadata encoding for exception handling in JITed code.
> + *
> + * Format of `fixup` field in `struct exception_table_entry`:
> + *
> + * Bit layout of `fixup` (32-bit):
> + *
> + * +-----------+--------+-----------+-----------+----------+
> + * |   31-27   | 26-22  |     21    |   20-16   |   15-0   |
> + * |           |        |           |           |          |
> + * | FIXUP_REG | Unused | ARENA_ACC | ARENA_REG |  OFFSET  |
> + * +-----------+--------+-----------+-----------+----------+
> + *
> + * - OFFSET (16 bits): Offset used to compute address for Load/Store instruction.
> + * - ARENA_REG (5 bits): Register that is used to calculate the address for load/store when
> + *                       accessing the arena region.
> + * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
> + * - FIXUP_REG (5 bits): Destination register for the load instruction (cleared on fault) or set to
> + *                       DONT_CLEAR if it is a store instruction.
> + */
> +
> +#define BPF_FIXUP_OFFSET_MASK      GENMASK(15, 0)
> +#define BPF_FIXUP_ARENA_REG_MASK   GENMASK(20, 16)
> +#define BPF_ARENA_ACCESS           BIT(21)
>  #define BPF_FIXUP_REG_MASK     GENMASK(31, 27)
>  #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
>
> @@ -1073,11 +1097,22 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>                     struct pt_regs *regs)
>  {
>         int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
> +       s16 off = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
> +       int arena_reg = FIELD_GET(BPF_FIXUP_ARENA_REG_MASK, ex->fixup);
> +       bool is_arena = !!(ex->fixup & BPF_ARENA_ACCESS);
> +       bool is_write = (dst_reg == DONT_CLEAR);
> +       unsigned long addr;
>
>         if (dst_reg != DONT_CLEAR)
>                 regs->regs[dst_reg] = 0;
>         /* Skip the faulting instruction */
>         regs->pc += AARCH64_INSN_SIZE;
> +
> +       if (is_arena) {
> +               addr = regs->regs[arena_reg] + off;

What happens when arena_reg == dst_reg?

> +               bpf_prog_report_arena_violation(is_write, addr);
> +       }
> +
>         return true;
>  }
>
> @@ -1087,6 +1122,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>                                  int dst_reg)
>  {
>         off_t ins_offset;
> +       s16 off = insn->off;
> +       bool is_arena;
> +       int arena_reg;
>         unsigned long pc;
>         struct exception_table_entry *ex;
>
> @@ -1100,6 +1138,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>                                 BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>                 return 0;
>
> +       is_arena = (BPF_MODE(insn->code) == BPF_PROBE_MEM32) ||
> +                  (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC);
> +
>         if (!ctx->prog->aux->extable ||
>             WARN_ON_ONCE(ctx->exentry_idx >= ctx->prog->aux->num_exentries))
>                 return -EINVAL;
> @@ -1131,6 +1172,17 @@ static int add_exception_handler(const struct bpf_insn *insn,
>
>         ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>
> +       if (is_arena) {
> +               ex->fixup |= BPF_ARENA_ACCESS;
> +               if (BPF_CLASS(insn->code) == BPF_LDX)
> +                       arena_reg = bpf2a64[insn->src_reg];
> +               else
> +                       arena_reg = bpf2a64[insn->dst_reg];
> +
> +               ex->fixup |=  FIELD_PREP(BPF_FIXUP_OFFSET_MASK, off) |
> +                             FIELD_PREP(BPF_FIXUP_ARENA_REG_MASK, arena_reg);
> +       }
> +
>         ex->type = EX_TYPE_BPF;
>
>         ctx->exentry_idx++;
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 7e3fca1646203..b75dea55df5a2 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -8,6 +8,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/filter.h>
>  #include <linux/if_vlan.h>
> +#include <linux/bitfield.h>
>  #include <linux/bpf.h>
>  #include <linux/memory.h>
>  #include <linux/sort.h>
> @@ -1388,16 +1389,67 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
>         return 0;
>  }
>
> +/*
> + * Metadata encoding for exception handling in JITed code.
> + *
> + * Format of `fixup` and `data` fields in `struct exception_table_entry`:
> + *
> + * Bit layout of `fixup` (32-bit):
> + *
> + * +-----------+--------+-----------+---------+----------+
> + * | 31        | 30-24  |   23-16   |   15-8  |    7-0   |
> + * |           |        |           |         |          |
> + * | ARENA_ACC | Unused | ARENA_REG | DST_REG | INSN_LEN |
> + * +-----------+--------+-----------+---------+----------+
> + *
> + * - INSN_LEN (8 bits): Length of faulting insn (max x86 insn = 15 bytes (fits in 8 bits)).
> + * - DST_REG  (8 bits): Offset of dst_reg from reg2pt_regs[] (max offset = 112 (fits in 8 bits)).
> + *                      This is set to DONT_CLEAR if the insn is a store.
> + * - ARENA_REG (8 bits): Offset of the register that is used to calculate the
> + *                       address for load/store when accessing the arena region.
> + * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
> + *
> + * Bit layout of `data` (32-bit):
> + *
> + * +--------------+--------+--------------+
> + * |   31-16     |  15-8  |     7-0      |
> + * |              |       |              |
> + * | ARENA_OFFSET | Unused |  EX_TYPE_BPF |
> + * +--------------+--------+--------------+
> + *
> + * - ARENA_OFFSET (16 bits): Offset used to calculate the address for load/store when
> + *                           accessing the arena region.
> + */
> +
>  #define DONT_CLEAR 1
> +#define FIXUP_INSN_LEN_MASK    GENMASK(7, 0)
> +#define FIXUP_REG_MASK         GENMASK(15, 8)
> +#define FIXUP_ARENA_REG_MASK   GENMASK(23, 16)
> +#define FIXUP_ARENA_ACCESS     BIT(31)
> +#define DATA_ARENA_OFFSET_MASK GENMASK(31, 16)
>
>  bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
>  {
> -       u32 reg = x->fixup >> 8;
> +       u32 reg = FIELD_GET(FIXUP_REG_MASK, x->fixup);
> +       u32 insn_len = FIELD_GET(FIXUP_INSN_LEN_MASK, x->fixup);
> +       bool is_arena = !!(x->fixup & FIXUP_ARENA_ACCESS);
> +       bool is_write = (reg == DONT_CLEAR);
> +       unsigned long addr;
> +       s16 off;
> +       u32 arena_reg;
>
>         /* jump over faulting load and clear dest register */
>         if (reg != DONT_CLEAR)
>                 *(unsigned long *)((void *)regs + reg) = 0;
> -       regs->ip += x->fixup & 0xff;
> +       regs->ip += insn_len;
> +
> +       if (is_arena) {
> +               arena_reg = FIELD_GET(FIXUP_ARENA_REG_MASK, x->fixup);
> +               off = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
> +               addr = *(unsigned long *)((void *)regs + arena_reg) + off;

Same question. I faintly remember I spent a few hours when I
implemented this, wondering why the reported address was always zeroed
out for x86 before realizing they can be the same.
It would be good to add a test for this condition.
And also, to work around this, the address needs to be captured before
the destination register is cleared.

> [...]


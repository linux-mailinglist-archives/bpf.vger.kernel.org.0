Return-Path: <bpf+bounces-67773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B3B498A7
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 20:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D39204413
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A37A31C588;
	Mon,  8 Sep 2025 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRy6Qrnk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219C315D25
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357235; cv=none; b=lXXoq9AVb51lmry8OA5zoIjwXUD3M2H0wJAKWb4otd0WNJDYgljgxc3keFMD5pzXAicn5CDWr53gucXSzhIkqXk2Ch4mvbEzjUdhxx2rlrJhogDpMDAzaNOEjGy6J+orG80anPI88JGQdu7l2ZGLTaCxGjp4TuKooTnJv/ZWf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357235; c=relaxed/simple;
	bh=85HxNiRIYrFMrSjAovn/opprPwuRYuujdqFgGNjP2qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1LBksy1zeoPX84HvLnZ0RJ73VwpARRBO7ok5lB9/3zbJYSbXlFQAYZSyWrRqc7mTZ0ISPxEqW/dMMLJx4fvwJysxPICMQrtifr9cLvNxo8jxLK6seJXRxk8Y+o5AkcQKI+hMrSqLfkQufx7Pr+50AB9nO8rxuHRGuMui+VWSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRy6Qrnk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3df3be0e098so2622416f8f.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357231; x=1757962031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGdBUSkS/X9KW2hF16LRR+hymYJxjiFILhSq3+IEyAc=;
        b=nRy6QrnkIuzTZXFy3iICrQ2AKm0+G/6+X3Nx3O5MoEUzgIt3fl70svd3jaNpFkto1B
         GnzIg7+2WV5gnrjnG0/kT3keLW4zEAD/M0Wc3s3BcBHBGl/6/jG1ZpKusNgRQxBkRgFS
         R7jcSNPuEzQp8uxF12gAyubk7z8YEKRTgIX1Rh4LRF9zMAz1VrO6U4bsIznqcXkMhJ7F
         N1Y5y4PL7kYsvLThIxVtTOyx/Y3SsXcKpFH5YremVwXytSDWRlMVix52suz+2qJknJYj
         udUB6zKMKhp5oWqBfWf88l/QVIi6Y/5fW9s2LDsN6vfEBb+d0neWfW459EfbiiZVaIH4
         mSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357231; x=1757962031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGdBUSkS/X9KW2hF16LRR+hymYJxjiFILhSq3+IEyAc=;
        b=sHpZIwJDzDBo/M0rJ6apQ+Je8ynuXqNW5Pf5imOtZfHP0pUee2DOiSc0kzmS5zHFHs
         PynsUioG8ax0igyLuiUBG+izxEyfrFD0lnLsMAkc1+uCiJ1JTIw6sPSjuePx2FU8NBCu
         Qzb0fMZUsYtSd2l1YuRok12wF/V55pOAH8yAEH85laUr2uexFTnYRUgGt3EnaUtTJbh+
         gyrwipcXBVqh3jBGIYuxuF/SlhsurN6Ycis5vrX8ukq+sDFnf/+Z1IMVPb8K/Smlwgll
         YYfEJb6HHYEuwTOMy+DR7/305pb202xclEqwwjZESu0H8T37TeAre+pAhYaufSrnBxMk
         iqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ80ID4FjQqwIHVq/yXlpczY6MwMdirBylj1BkgzDiI+vEpM4XcvqO1CGDT1RZJgWzalk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ESklAEZ4nnTGvzrmnNu+86EihwGYlwlI7EqvqgsaIdl39cxn
	lUzAFYpg5ifhdR9QW7q9ujeR6Rk/HfC6rWSdAeo+rS1WS37DrlehV+wNXGHBu4fW2ZAeHCUzp87
	KJSAmjBv1nG/NpghU5IbDoRceuQvmH5Y=
X-Gm-Gg: ASbGncuT2kuO55Ud9P7PBc0S8DH+Nq9+ihemMRlm6wRa+QTB87gCbrfBfPxZpLeL7ik
	43jXh4whLeawkf/PiY6jdOcX7bE4fcWa1dLAoA47MLWXS/R/Gr5foQ99PPgNO5Sr4cu59xtmt3I
	F5tTg0C1CFFbyM8cA/zpOwxpeIiewEDJilWrppczMi/khqFU9Xahea7S3l1OEjNnNbn/irq12lr
	6fJPIWeYly2xeqXpXyR+q1kRLFn8dCfBhqu4pqPGjuIpv0=
X-Google-Smtp-Source: AGHT+IGvfknETmRhk4dTUGV/7Dtr/Jlo7r/rDXCq7tV5sfqjqWYP+YamzIuaRMq6n6rTml/7o5xcFxyAsNWC4eOIfjg=
X-Received: by 2002:a5d:64c3:0:b0:3d3:5cb3:5950 with SMTP id
 ffacd0b85a97d-3e6429ce979mr4883484f8f.21.1757357230980; Mon, 08 Sep 2025
 11:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908163638.23150-1-puranjay@kernel.org> <20250908163638.23150-4-puranjay@kernel.org>
In-Reply-To: <20250908163638.23150-4-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 11:46:59 -0700
X-Gm-Features: AS18NWBm83E-uaMGEK1kfVK85P_XTFzO-UxiOuW3Y6vLOI9N_eSSAdWoKlfwDmE
Message-ID: <CAADnVQLEYqMeMmBvafc4WGUXc3HK=LN8uV2MVL52c1nuQNnT_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/5] bpf: Report arena faults to BPF stderr
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:37=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
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
>  arch/arm64/net/bpf_jit_comp.c | 52 ++++++++++++++++++++++++
>  arch/x86/net/bpf_jit_comp.c   | 76 ++++++++++++++++++++++++++++++++---
>  include/linux/bpf.h           |  6 +++
>  kernel/bpf/arena.c            | 30 ++++++++++++++
>  4 files changed, 159 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index e6d1fdc1e6f52..556ab2fd222d8 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1066,6 +1066,30 @@ static void build_epilogue(struct jit_ctx *ctx, bo=
ol was_classic)
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
> + * - OFFSET (16 bits): Offset used to compute address for Load/Store ins=
truction.
> + * - ARENA_REG (5 bits): Register that is used to calculate the address =
for load/store when
> + *                       accessing the arena region.
> + * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction=
 accessed the arena region.
> + * - FIXUP_REG (5 bits): Destination register for the load instruction (=
cleared on fault) or set to
> + *                       DONT_CLEAR if it is a store instruction.
> + */
> +
> +#define BPF_FIXUP_OFFSET_MASK      GENMASK(15, 0)
> +#define BPF_FIXUP_ARENA_REG_MASK   GENMASK(20, 16)
> +#define BPF_ARENA_ACCESS           BIT(21)
>  #define BPF_FIXUP_REG_MASK     GENMASK(31, 27)
>  #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
>
> @@ -1073,11 +1097,22 @@ bool ex_handler_bpf(const struct exception_table_=
entry *ex,
>                     struct pt_regs *regs)
>  {
>         int dst_reg =3D FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
> +       s16 off =3D FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
> +       int arena_reg =3D FIELD_GET(BPF_FIXUP_ARENA_REG_MASK, ex->fixup);
> +       bool is_arena =3D !!(ex->fixup & BPF_ARENA_ACCESS);
> +       bool is_write =3D (dst_reg =3D=3D DONT_CLEAR);
> +       unsigned long addr;
> +
> +       if (is_arena) {
> +               addr =3D regs->regs[arena_reg] + off;
> +               bpf_prog_report_arena_violation(is_write, addr, regs->pc)=
;
> +       }
>
>         if (dst_reg !=3D DONT_CLEAR)
>                 regs->regs[dst_reg] =3D 0;
>         /* Skip the faulting instruction */
>         regs->pc +=3D AARCH64_INSN_SIZE;
> +
>         return true;
>  }
>
> @@ -1087,6 +1122,9 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
>                                  int dst_reg)
>  {
>         off_t ins_offset;
> +       s16 off =3D insn->off;
> +       bool is_arena;
> +       int arena_reg;
>         unsigned long pc;
>         struct exception_table_entry *ex;
>
> @@ -1100,6 +1138,9 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
>                                 BPF_MODE(insn->code) !=3D BPF_PROBE_ATOMI=
C)
>                 return 0;
>
> +       is_arena =3D (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32) ||
> +                  (BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC);
> +
>         if (!ctx->prog->aux->extable ||
>             WARN_ON_ONCE(ctx->exentry_idx >=3D ctx->prog->aux->num_exentr=
ies))
>                 return -EINVAL;
> @@ -1131,6 +1172,17 @@ static int add_exception_handler(const struct bpf_=
insn *insn,
>
>         ex->fixup =3D FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>
> +       if (is_arena) {
> +               ex->fixup |=3D BPF_ARENA_ACCESS;
> +               if (BPF_CLASS(insn->code) =3D=3D BPF_LDX)
> +                       arena_reg =3D bpf2a64[insn->src_reg];
> +               else
> +                       arena_reg =3D bpf2a64[insn->dst_reg];

I think this is correct, since insn->src/dst_reg is the register
before the adjustment of:
emit(A64_ADD(1, tmp2, src, arena_vm_base)

so ex handler doing regs->regs[arena_reg]
should read 64-bit with upper 32-bit being zero.
right?
If so, please add a comment describing this subtle logic.

> +
> +               ex->fixup |=3D  FIELD_PREP(BPF_FIXUP_OFFSET_MASK, off) |
> +                             FIELD_PREP(BPF_FIXUP_ARENA_REG_MASK, arena_=
reg);
> +       }
> +
>         ex->type =3D EX_TYPE_BPF;
>
>         ctx->exentry_idx++;
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 7e3fca1646203..007c273f3deea 100644
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
> @@ -1388,16 +1389,67 @@ static int emit_atomic_ld_st_index(u8 **pprog, u3=
2 atomic_op, u32 size,
>         return 0;
>  }
>
> +/*
> + * Metadata encoding for exception handling in JITed code.
> + *
> + * Format of `fixup` and `data` fields in `struct exception_table_entry`=
:
> + *
> + * Bit layout of `fixup` (32-bit):
> + *
> + * +-----------+--------+-----------+---------+----------+
> + * | 31        | 30-24  |   23-16   |   15-8  |    7-0   |
> + * |           |        |           |         |          |
> + * | ARENA_ACC | Unused | ARENA_REG | DST_REG | INSN_LEN |
> + * +-----------+--------+-----------+---------+----------+
> + *
> + * - INSN_LEN (8 bits): Length of faulting insn (max x86 insn =3D 15 byt=
es (fits in 8 bits)).
> + * - DST_REG  (8 bits): Offset of dst_reg from reg2pt_regs[] (max offset=
 =3D 112 (fits in 8 bits)).
> + *                      This is set to DONT_CLEAR if the insn is a store=
.
> + * - ARENA_REG (8 bits): Offset of the register that is used to calculat=
e the
> + *                       address for load/store when accessing the arena=
 region.
> + * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction=
 accessed the arena region.
> + *
> + * Bit layout of `data` (32-bit):
> + *
> + * +--------------+--------+--------------+
> + * |   31-16     |  15-8  |     7-0      |
> + * |              |       |              |
> + * | ARENA_OFFSET | Unused |  EX_TYPE_BPF |
> + * +--------------+--------+--------------+
> + *
> + * - ARENA_OFFSET (16 bits): Offset used to calculate the address for lo=
ad/store when
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
>  bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_reg=
s *regs)
>  {
> -       u32 reg =3D x->fixup >> 8;
> +       u32 reg =3D FIELD_GET(FIXUP_REG_MASK, x->fixup);
> +       u32 insn_len =3D FIELD_GET(FIXUP_INSN_LEN_MASK, x->fixup);
> +       bool is_arena =3D !!(x->fixup & FIXUP_ARENA_ACCESS);
> +       bool is_write =3D (reg =3D=3D DONT_CLEAR);
> +       unsigned long addr;
> +       s16 off;
> +       u32 arena_reg;
> +
> +       if (is_arena) {
> +               arena_reg =3D FIELD_GET(FIXUP_ARENA_REG_MASK, x->fixup);
> +               off =3D FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
> +               addr =3D *(unsigned long *)((void *)regs + arena_reg) + o=
ff;
> +               bpf_prog_report_arena_violation(is_write, addr, regs->ip)=
;
> +       }
>
>         /* jump over faulting load and clear dest register */
>         if (reg !=3D DONT_CLEAR)
>                 *(unsigned long *)((void *)regs + reg) =3D 0;
> -       regs->ip +=3D x->fixup & 0xff;
> +       regs->ip +=3D insn_len;
> +
>         return true;
>  }
>
> @@ -2070,6 +2122,7 @@ st:                       if (is_imm8(insn->off))
>                         {
>                                 struct exception_table_entry *ex;
>                                 u8 *_insn =3D image + proglen + (start_of=
_ldx - temp);
> +                               u32 arena_reg, fixup_reg;
>                                 s64 delta;
>
>                                 if (!bpf_prog->aux->extable)
> @@ -2089,8 +2142,20 @@ st:                      if (is_imm8(insn->off))
>
>                                 ex->data =3D EX_TYPE_BPF;
>
> -                               ex->fixup =3D (prog - start_of_ldx) |
> -                                       ((BPF_CLASS(insn->code) =3D=3D BP=
F_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 8);
> +                               if (BPF_CLASS(insn->code) =3D=3D BPF_LDX)=
 {
> +                                       arena_reg =3D reg2pt_regs[src_reg=
];
> +                                       fixup_reg =3D reg2pt_regs[dst_reg=
];
> +                               } else {
> +                                       arena_reg =3D reg2pt_regs[dst_reg=
];
> +                                       fixup_reg =3D DONT_CLEAR;
> +                               }

here it's probably also correct, since x86 jit is using r12 to add
kern_vm_start.
A comment is necessary.

> +
> +                               ex->fixup =3D FIELD_PREP(FIXUP_INSN_LEN_M=
ASK, prog - start_of_ldx) |
> +                                           FIELD_PREP(FIXUP_ARENA_REG_MA=
SK, arena_reg) |
> +                                           FIELD_PREP(FIXUP_REG_MASK, fi=
xup_reg);
> +                               ex->fixup |=3D FIXUP_ARENA_ACCESS;
> +
> +                               ex->data |=3D FIELD_PREP(DATA_ARENA_OFFSE=
T_MASK, insn->off);
>                         }
>                         break;
>
> @@ -2208,7 +2273,8 @@ st:                       if (is_imm8(insn->off))
>                                  * End result: x86 insn "mov rbx, qword p=
tr [rax+0x14]"
>                                  * of 4 bytes will be ignored and rbx wil=
l be zero inited.
>                                  */
> -                               ex->fixup =3D (prog - start_of_ldx) | (re=
g2pt_regs[dst_reg] << 8);
> +                               ex->fixup =3D FIELD_PREP(FIXUP_INSN_LEN_M=
ASK, prog - start_of_ldx) |
> +                                           FIELD_PREP(FIXUP_REG_MASK, re=
g2pt_regs[dst_reg]);
>                         }
>                         break;
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d133171c4d2a9..41f776071ff51 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2881,6 +2881,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, v=
oid *data,
>                      enum bpf_dynptr_type type, u32 offset, u32 size);
>  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>  void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
> +void bpf_prog_report_arena_violation(bool write, unsigned long addr, uns=
igned long fault_ip);
>
>  #else /* !CONFIG_BPF_SYSCALL */
>  static inline struct bpf_prog *bpf_prog_get(u32 ufd)
> @@ -3168,6 +3169,11 @@ static inline void bpf_dynptr_set_null(struct bpf_=
dynptr_kern *ptr)
>  static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
>  {
>  }
> +
> +static inline void bpf_prog_report_arena_violation(bool write, unsigned =
long addr,
> +                                                  unsigned long fault_ip=
)
> +{
> +}
>  #endif /* CONFIG_BPF_SYSCALL */
>
>  static __always_inline int
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 5b37753799d20..d0b31b40d3826 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -633,3 +633,33 @@ static int __init kfunc_init(void)
>         return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kf=
unc_set);
>  }
>  late_initcall(kfunc_init);
> +
> +void bpf_prog_report_arena_violation(bool write, unsigned long addr, uns=
igned long fault_ip)
> +{
> +       struct bpf_stream_stage ss;
> +       struct bpf_prog *prog;
> +       u64 user_vm_start;
> +
> +       /*
> +        * The RCU read lock is held to safely traverse the latch tree, b=
ut we
> +        * don't need its protection when accessing the prog, since it wi=
ll not
> +        * disappear while we are handling the fault.
> +        */
> +       rcu_read_lock();
> +       prog =3D bpf_prog_ksym_find(fault_ip);
> +       rcu_read_unlock();
> +       if (!prog)
> +               return;
> +
> +       /* Use main prog for stream access */
> +       prog =3D prog->aux->main_prog_aux->prog;
> +
> +       user_vm_start =3D bpf_arena_get_user_vm_start(prog->aux->arena);
> +       addr +=3D (user_vm_start >> 32) << 32;

in arena.c we already have:
static u64 clear_lo32(u64 val)
{
        return val & ~(u64)~0U;
}

pls use it.

pw-bot: cr


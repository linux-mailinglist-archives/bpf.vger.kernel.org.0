Return-Path: <bpf+bounces-66825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 946E6B39CC4
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 14:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1983B1C82B25
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2D30F817;
	Thu, 28 Aug 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbjNrs0S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76B264630
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383289; cv=none; b=HFQ6OMQMBFh+KqWcsGSZQxuvuTJrg548iY5Ne7AiXjgyvOGWGFMzmB24v7DtPQLjb8lST4PUb8xxabQG3qzz2yN/SoJ6lkQiHM14b1mUfQqwhaBkDpCJXykiOfWYqvQVReEqmSzqwAb4zkvm55XYnZbGbN72/Qe+V9UpjGTO2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383289; c=relaxed/simple;
	bh=dTZ2Seq16DTO+ELJRani0xytlkvZj/aGRhuiBieQa8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sr/XnjqOcpT3KzC74EGRMU0AlPD/gM6ADo6jzyuF7US2UDXrVr/a3QXGFMkSiicwo1Cz5/4ELxy6I9oT3RliFG5akmMYkmx9fuXlza7Xh8oVSiwezI3/E+hG5yZa/8+mB3GARZC5vGZXyRL692+03uWeDHZ7hDZUYl562zjCC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbjNrs0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5D3C4CEEB;
	Thu, 28 Aug 2025 12:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756383289;
	bh=dTZ2Seq16DTO+ELJRani0xytlkvZj/aGRhuiBieQa8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BbjNrs0SSsgldk5JvrNIWZBE3pI9qglPnfY0QFOB85Tjkk1o1N5e9vY9CzZiBWxc2
	 1mVwAcCQmlZTdNqwu/5B1OwZX/Qu0YvV+PX4TYOfQECP47WXvgYWTBWEsWkLc2nXH5
	 0MK84aKqzXJYk8ciInQtMwlpAqpEzRr3dvrRCEZx6KHCCjfNU2u1Fj28kHToMvqCFA
	 oA+daw9O9ywY+aC4skqWnh8l4wh2HhxXt8ThI0e/vzUzrTFUW+gwgxhelTdvWk1rSe
	 3T8ucW2bJm2Br970wOdvOCTYAaTIeTaY/Dj1JUaEHtDRO8GpsDWUR+Glmwq/rQWdD5
	 NV992a0cr9IQg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Report arena faults to BPF stderr
In-Reply-To: <CAP01T75ajCxNOPLyJzpAb9bnOJLyKFNDAgXqnEQZpGdXOp6CFw@mail.gmail.com>
References: <20250827153728.28115-1-puranjay@kernel.org>
 <20250827153728.28115-3-puranjay@kernel.org>
 <CAP01T75ajCxNOPLyJzpAb9bnOJLyKFNDAgXqnEQZpGdXOp6CFw@mail.gmail.com>
Date: Thu, 28 Aug 2025 12:14:46 +0000
Message-ID: <mb61pecsvmymh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Wed, 27 Aug 2025 at 17:37, Puranjay Mohan <puranjay@kernel.org> wrote:
>>
>> Begin reporting arena page faults and the faulting address to BPF
>> program's stderr, this patch adds support in the arm64 and x86-64 JITs,
>> support for other archs can be added later.
>>
>> The fault handlers receive the 32 bit address in the arena region so
>> the upper 32 bits of user_vm_start is added to it before printing the
>> address. This is what the user would expect to see as this is what is
>> printed by bpf_printk() is you pass it an address returned by
>> bpf_arena_alloc_pages();
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>  arch/arm64/net/bpf_jit_comp.c | 52 +++++++++++++++++++++++
>>  arch/x86/net/bpf_jit_comp.c   | 79 +++++++++++++++++++++++++++++++++--
>>  include/linux/bpf.h           |  5 +++
>>  kernel/bpf/arena.c            | 20 +++++++++
>>  4 files changed, 152 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 42643fd9168fc..5083886d6e66b 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -1066,6 +1066,30 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
>>         emit(A64_RET(A64_LR), ctx);
>>  }
>>
>> +/*
>> + * Metadata encoding for exception handling in JITed code.
>> + *
>> + * Format of `fixup` field in `struct exception_table_entry`:
>> + *
>> + * Bit layout of `fixup` (32-bit):
>> + *
>> + * +-----------+--------+-----------+-----------+----------+
>> + * |   31-27   | 26-22  |     21    |   20-16   |   15-0   |
>> + * |           |        |           |           |          |
>> + * | FIXUP_REG | Unused | ARENA_ACC | ARENA_REG |  OFFSET  |
>> + * +-----------+--------+-----------+-----------+----------+
>> + *
>> + * - OFFSET (16 bits): Offset used to compute address for Load/Store instruction.
>> + * - ARENA_REG (5 bits): Register that is used to calculate the address for load/store when
>> + *                       accessing the arena region.
>> + * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
>> + * - FIXUP_REG (5 bits): Destination register for the load instruction (cleared on fault) or set to
>> + *                       DONT_CLEAR if it is a store instruction.
>> + */
>> +
>> +#define BPF_FIXUP_OFFSET_MASK      GENMASK(15, 0)
>> +#define BPF_FIXUP_ARENA_REG_MASK   GENMASK(20, 16)
>> +#define BPF_ARENA_ACCESS           BIT(21)
>>  #define BPF_FIXUP_REG_MASK     GENMASK(31, 27)
>>  #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
>>
>> @@ -1073,11 +1097,22 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>>                     struct pt_regs *regs)
>>  {
>>         int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
>> +       s16 off = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
>> +       int arena_reg = FIELD_GET(BPF_FIXUP_ARENA_REG_MASK, ex->fixup);
>> +       bool is_arena = !!(ex->fixup & BPF_ARENA_ACCESS);
>> +       bool is_write = (dst_reg == DONT_CLEAR);
>> +       unsigned long addr;
>>
>>         if (dst_reg != DONT_CLEAR)
>>                 regs->regs[dst_reg] = 0;
>>         /* Skip the faulting instruction */
>>         regs->pc += AARCH64_INSN_SIZE;
>> +
>> +       if (is_arena) {
>> +               addr = regs->regs[arena_reg] + off;
>
> What happens when arena_reg == dst_reg?
>
>> +               bpf_prog_report_arena_violation(is_write, addr);
>> +       }
>> +
>>         return true;
>>  }
>>
>> @@ -1087,6 +1122,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>                                  int dst_reg)
>>  {
>>         off_t ins_offset;
>> +       s16 off = insn->off;
>> +       bool is_arena;
>> +       int arena_reg;
>>         unsigned long pc;
>>         struct exception_table_entry *ex;
>>
>> @@ -1100,6 +1138,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>                                 BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>>                 return 0;
>>
>> +       is_arena = (BPF_MODE(insn->code) == BPF_PROBE_MEM32) ||
>> +                  (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC);
>> +
>>         if (!ctx->prog->aux->extable ||
>>             WARN_ON_ONCE(ctx->exentry_idx >= ctx->prog->aux->num_exentries))
>>                 return -EINVAL;
>> @@ -1131,6 +1172,17 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>
>>         ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>>
>> +       if (is_arena) {
>> +               ex->fixup |= BPF_ARENA_ACCESS;
>> +               if (BPF_CLASS(insn->code) == BPF_LDX)
>> +                       arena_reg = bpf2a64[insn->src_reg];
>> +               else
>> +                       arena_reg = bpf2a64[insn->dst_reg];
>> +
>> +               ex->fixup |=  FIELD_PREP(BPF_FIXUP_OFFSET_MASK, off) |
>> +                             FIELD_PREP(BPF_FIXUP_ARENA_REG_MASK, arena_reg);
>> +       }
>> +
>>         ex->type = EX_TYPE_BPF;
>>
>>         ctx->exentry_idx++;
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 7e3fca1646203..b75dea55df5a2 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/netdevice.h>
>>  #include <linux/filter.h>
>>  #include <linux/if_vlan.h>
>> +#include <linux/bitfield.h>
>>  #include <linux/bpf.h>
>>  #include <linux/memory.h>
>>  #include <linux/sort.h>
>> @@ -1388,16 +1389,67 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
>>         return 0;
>>  }
>>
>> +/*
>> + * Metadata encoding for exception handling in JITed code.
>> + *
>> + * Format of `fixup` and `data` fields in `struct exception_table_entry`:
>> + *
>> + * Bit layout of `fixup` (32-bit):
>> + *
>> + * +-----------+--------+-----------+---------+----------+
>> + * | 31        | 30-24  |   23-16   |   15-8  |    7-0   |
>> + * |           |        |           |         |          |
>> + * | ARENA_ACC | Unused | ARENA_REG | DST_REG | INSN_LEN |
>> + * +-----------+--------+-----------+---------+----------+
>> + *
>> + * - INSN_LEN (8 bits): Length of faulting insn (max x86 insn = 15 bytes (fits in 8 bits)).
>> + * - DST_REG  (8 bits): Offset of dst_reg from reg2pt_regs[] (max offset = 112 (fits in 8 bits)).
>> + *                      This is set to DONT_CLEAR if the insn is a store.
>> + * - ARENA_REG (8 bits): Offset of the register that is used to calculate the
>> + *                       address for load/store when accessing the arena region.
>> + * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
>> + *
>> + * Bit layout of `data` (32-bit):
>> + *
>> + * +--------------+--------+--------------+
>> + * |   31-16     |  15-8  |     7-0      |
>> + * |              |       |              |
>> + * | ARENA_OFFSET | Unused |  EX_TYPE_BPF |
>> + * +--------------+--------+--------------+
>> + *
>> + * - ARENA_OFFSET (16 bits): Offset used to calculate the address for load/store when
>> + *                           accessing the arena region.
>> + */
>> +
>>  #define DONT_CLEAR 1
>> +#define FIXUP_INSN_LEN_MASK    GENMASK(7, 0)
>> +#define FIXUP_REG_MASK         GENMASK(15, 8)
>> +#define FIXUP_ARENA_REG_MASK   GENMASK(23, 16)
>> +#define FIXUP_ARENA_ACCESS     BIT(31)
>> +#define DATA_ARENA_OFFSET_MASK GENMASK(31, 16)
>>
>>  bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
>>  {
>> -       u32 reg = x->fixup >> 8;
>> +       u32 reg = FIELD_GET(FIXUP_REG_MASK, x->fixup);
>> +       u32 insn_len = FIELD_GET(FIXUP_INSN_LEN_MASK, x->fixup);
>> +       bool is_arena = !!(x->fixup & FIXUP_ARENA_ACCESS);
>> +       bool is_write = (reg == DONT_CLEAR);
>> +       unsigned long addr;
>> +       s16 off;
>> +       u32 arena_reg;
>>
>>         /* jump over faulting load and clear dest register */
>>         if (reg != DONT_CLEAR)
>>                 *(unsigned long *)((void *)regs + reg) = 0;
>> -       regs->ip += x->fixup & 0xff;
>> +       regs->ip += insn_len;
>> +
>> +       if (is_arena) {
>> +               arena_reg = FIELD_GET(FIXUP_ARENA_REG_MASK, x->fixup);
>> +               off = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
>> +               addr = *(unsigned long *)((void *)regs + arena_reg) + off;
>
> Same question. I faintly remember I spent a few hours when I
> implemented this, wondering why the reported address was always zeroed
> out for x86 before realizing they can be the same.
> It would be good to add a test for this condition.
> And also, to work around this, the address needs to be captured before
> the destination register is cleared.

Thanks for catching this!

I will capture the address and then zero out the destination register
int the next version.

Thanks,
Puranjay


Return-Path: <bpf+bounces-64036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CFB0D8EC
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2D31898A01
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 12:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71AB2309BE;
	Tue, 22 Jul 2025 12:04:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284423ED63;
	Tue, 22 Jul 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185887; cv=none; b=Poo31KytzbhFxK/e7jiLJDNvuNWnP+eD/dTs/32Rxy913tWSSpkTl97/cRz4QtmuxR8Q4tWwIhKXFA0dFrC+kfYRUR+0Q2NzODOlsxCngPqV6VQLb7sq/jw5yunuRGniI8S1oMfPOOM1rJ4FoUtIlCEKd6wZgqzbiTJ4t5Co0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185887; c=relaxed/simple;
	bh=1e86FHXECSA7B/9He/EyVQ3vWyUCvZTev6yfI/xG+ZA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KABaFYDU1Y81ogSDnQ3RZy5W9S2AvcANF9u0MGoh45TU3Rxji8ggMgWOMJPJ2Qn4VxFz1fzWU8w7rkmRYKYpdMa4+26X+TFTDbECqJ3oi4qYt81Wxfx9A9Y0tDJCWDAl07A0XjWAIyH2tHmUiu2evzMlpa7TNjV0ry35ZceKP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmbY71RNbzKHLt7;
	Tue, 22 Jul 2025 20:04:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E218E1A14F6;
	Tue, 22 Jul 2025 20:04:41 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgC3gBFYfn9oFJ1yBA--.23985S2;
	Tue, 22 Jul 2025 20:04:41 +0800 (CST)
Message-ID: <490b965b-21eb-46a2-b3d5-f49271fd7542@huaweicloud.com>
Date: Tue, 22 Jul 2025 20:04:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 3/3] arm64/cfi,bpf: Support kCFI + BPF on
 arm64
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org,
 Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Maxwell Bland <mbland@motorola.com>, Puranjay Mohan <puranjay12@gmail.com>,
 Dao Huang <huangdao1@oppo.com>
References: <20250721202015.3530876-5-samitolvanen@google.com>
 <20250721202015.3530876-8-samitolvanen@google.com>
 <74bd0822-c8c1-47cc-b816-78036abff8ee@huaweicloud.com>
In-Reply-To: <74bd0822-c8c1-47cc-b816-78036abff8ee@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3gBFYfn9oFJ1yBA--.23985S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw18AFy5JFyfXr18tF4Utwb_yoW3uryxpF
	ykGF45GrWkJr1xJFWUJr1UAFy5Kw4kA3W7Jry8Za45KF12gr10gF15WrWj9rW5ArW8tw1x
	JF1qqrnF9a1UJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/22/2025 11:44 AM, Xu Kuohai wrote:
> On 7/22/2025 4:20 AM, Sami Tolvanen wrote:
>> From: Puranjay Mohan <puranjay12@gmail.com>
>>
>> Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
>> calling BPF programs from this interface doesn't cause CFI warnings.
>>
>> When BPF programs are called directly from C: from BPF helpers or
>> struct_ops, CFI warnings are generated.
>>
>> Implement proper CFI prologues for the BPF programs and callbacks and
>> drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
>> prologue when a struct_ops trampoline is being prepared.
>>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> Co-developed-by: Maxwell Bland <mbland@motorola.com>
>> Signed-off-by: Maxwell Bland <mbland@motorola.com>
>> Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
>> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>> Tested-by: Dao Huang <huangdao1@oppo.com>
>> Acked-by: Will Deacon <will@kernel.org>
>> ---
>>   arch/arm64/include/asm/cfi.h  |  7 +++++++
>>   arch/arm64/net/bpf_jit_comp.c | 22 +++++++++++++++++++---
>>   2 files changed, 26 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/cfi.h
>>
>> diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
>> new file mode 100644
>> index 000000000000..ab90f0351b7a
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/cfi.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_ARM64_CFI_H
>> +#define _ASM_ARM64_CFI_H
>> +
>> +#define __bpfcall
>> +
>> +#endif /* _ASM_ARM64_CFI_H */
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 89b1b8c248c6..f4a98c1a1583 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/arm-smccc.h>
>>   #include <linux/bitfield.h>
>>   #include <linux/bpf.h>
>> +#include <linux/cfi.h>
>>   #include <linux/filter.h>
>>   #include <linux/memory.h>
>>   #include <linux/printk.h>
>> @@ -166,6 +167,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
>>           emit(insn, ctx);
>>   }
>> +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
>> +{
>> +    if (IS_ENABLED(CONFIG_CFI_CLANG))
>> +        emit(hash, ctx);
> 
> I guess this won't work on big-endian cpus, since arm64 instructions
> are always stored in little-endian, but data not.
>

There is indeed an issue. I built a big-endian kernel with this patch
and tested it on qemu, a CFI failure is triggered on kernel booting:

CFI failure at kern_sys_bpf+0x2d4/0x4f0 (target: bpf_prog_dc1d7467ed3b3c17___loader.prog+0x0/0x6dc; expected type: 0xd9421881)
Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
Modules linked in:
CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc6-ge72c32d6c27a-dirty #10 NONE
Hardware name: linux,dummy-virt (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kern_sys_bpf+0x2d4/0x4f0
lr : kern_sys_bpf+0x290/0x4f0
sp : ffff8000844e7320
x29: ffff8000844e7390 x28: ffff80008436f000 x27: 1fffe00018268040
x26: ffff8000844e7400 x25: ffff8000844e77c0 x24: 0000000000000030
x23: 1ffff0001089ce68 x22: dfff800000000000 x21: ffff80008455b030
x20: ffff0000c1340200 x19: ffff80008455b000 x18: ffffffff00000000
x17: 00000000d9421881 x16: 00000000811842d9 x15: 0000000000000001
x14: 0000000000000001 x13: ffff0001b5b947f4 x12: 1fffe0001807a001
x11: 0000000000000001 x10: 0000000000000000 x9 : 1ffff000108ab606
x8 : ffff800084979894 x7 : ffff8000805a5ce8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000010
x2 : 0000000000000000 x1 : ffff80008455b048 x0 : ffff0000c1340200
Call trace:
  kern_sys_bpf+0x2d4/0x4f0 (P)
  load+0x324/0x7a4
  do_one_initcall+0x1e8/0x7a0
  do_initcall_level+0x180/0x36c
  do_initcalls+0x60/0xa4
  do_basic_setup+0x9c/0xb0
  kernel_init_freeable+0x270/0x390
  kernel_init+0x2c/0x1c8
  ret_from_fork+0x10/0x20
Code: 72831031 72bb2851 6b11021f 54000040 (d4304500)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops - CFI: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x1000,000800d0,02000800,0400420b
Memory Limit: none
---[ end Kernel panic - not syncing: Oops - CFI: Fatal exception ]---


And the failure can be fixed with the following change:

--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -107,6 +107,14 @@ static inline void emit(const u32 insn, struct jit_ctx *ctx)
         ctx->idx++;
  }

+static inline void emit_u32_data(const u32 data, struct jit_ctx *ctx)
+{
+       if (ctx->image != NULL && ctx->write)
+               ctx->image[ctx->idx] = data;
+
+       ctx->idx++;
+}
+
  static inline void emit_a64_mov_i(const int is64, const int reg,
                                   const s32 val, struct jit_ctx *ctx)
  {
@@ -170,7 +178,7 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
  static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
  {
         if (IS_ENABLED(CONFIG_CFI_CLANG))
-               emit(hash, ctx);
+               emit_u32_data(hash, ctx);
  }

>> +}
>> +
>>   /*
>>    * Kernel addresses in the vmalloc space use at most 48 bits, and the
>>    * remaining bits are guaranteed to be 0x1. So we can compose the address
>> @@ -476,7 +483,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>>       const bool is_main_prog = !bpf_is_subprog(prog);
>>       const u8 fp = bpf2a64[BPF_REG_FP];
>>       const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
>> -    const int idx0 = ctx->idx;
>>       int cur_offset;
>>       /*
>> @@ -502,6 +508,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>>        *
>>        */
>> +    emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
>> +    const int idx0 = ctx->idx;
> 
> move the idx0 definition back to its original position to match the
> coding style of the rest of the file?
> 
>> +
>>       /* bpf function may be invoked by 3 instruction types:
>>        * 1. bl, attached via freplace to bpf prog via short jump
>>        * 2. br, attached via freplace to bpf prog via long jump
>> @@ -2055,9 +2064,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>           jit_data->ro_header = ro_header;
>>       }
>> -    prog->bpf_func = (void *)ctx.ro_image;
>> +    prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
>>       prog->jited = 1;
>> -    prog->jited_len = prog_size;
>> +    prog->jited_len = prog_size - cfi_get_offset();
>>       if (!prog->is_func || extra_pass) {
>>           int i;
>> @@ -2426,6 +2435,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>>       /* return address locates above FP */
>>       retaddr_off = stack_size + 8;
>> +    if (flags & BPF_TRAMP_F_INDIRECT) {
>> +        /*
>> +         * Indirect call for bpf_struct_ops
>> +         */
>> +        emit_kcfi(cfi_get_func_hash(func_addr), ctx);
>> +    }
>>       /* bpf trampoline may be invoked by 3 instruction types:
>>        * 1. bl, attached to bpf prog or kernel function via short jump
>>        * 2. br, attached to bpf prog or kernel function via long jump
>> @@ -2942,6 +2957,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>>                          sizeof(jit_data->header->size));
>>               kfree(jit_data);
>>           }
>> +        prog->bpf_func -= cfi_get_offset();
>>           hdr = bpf_jit_binary_pack_hdr(prog);
>>           bpf_jit_binary_pack_free(hdr, NULL);
>>           WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
> 
> 



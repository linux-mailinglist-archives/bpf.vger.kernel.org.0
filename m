Return-Path: <bpf+bounces-63994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EECB0D080
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 05:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908FD5445AB
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C5628B7DF;
	Tue, 22 Jul 2025 03:44:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC181E377F;
	Tue, 22 Jul 2025 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155874; cv=none; b=uVzZchLREFM6UVcregPVFzD+zpTAIOvBzQWXUlxYsf7dLFmS4U8iMnApvd+6JHCWCRsMPrvw9AnFqMUnZZuH886B9h+FFQuRFTRDQL+JFf3aslAm5ZTkicmVgnHcDzM+zokbuxPUrd0MJdlWR+Rc4T0bEzEy2SANs7h+8/UXz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155874; c=relaxed/simple;
	bh=kHwOVlFifXCfrgKKhCMxrCpl162cURg5l1HE1aghawc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFgmly5k2sLTtrfZns7PY46HRf5tejobgZrseEGv8/CtwjC0BidjssBxb2rw5VRuYlSr+uyIGut7NdHv9Y1rTOGKSZ7JlreJoQYPi6us+p2ijc3dh9XQTV6k017zmiCc15UVc5G1wJzjFcuZNK+9PK7uIBAR9jWfBWR+8g2Uf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmNRx5Vb6zKHMw6;
	Tue, 22 Jul 2025 11:44:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 75A1B1A1373;
	Tue, 22 Jul 2025 11:44:28 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgB3NbcaCX9oTy09BA--.44017S2;
	Tue, 22 Jul 2025 11:44:28 +0800 (CST)
Message-ID: <74bd0822-c8c1-47cc-b816-78036abff8ee@huaweicloud.com>
Date: Tue, 22 Jul 2025 11:44:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 3/3] arm64/cfi,bpf: Support kCFI + BPF on
 arm64
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
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250721202015.3530876-8-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB3NbcaCX9oTy09BA--.44017S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1rZw1kZFWfGw4rJrW7XFb_yoWruF1fpa
	yDu3WrCr4kXry7GFWUJ3WavF15Kw4kXF1YkryUu34Ykr9F9rykGFn0gr98uFWrCrW09w4r
	Xa4q9rn09a1DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 7/22/2025 4:20 AM, Sami Tolvanen wrote:
> From: Puranjay Mohan <puranjay12@gmail.com>
> 
> Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
> calling BPF programs from this interface doesn't cause CFI warnings.
> 
> When BPF programs are called directly from C: from BPF helpers or
> struct_ops, CFI warnings are generated.
> 
> Implement proper CFI prologues for the BPF programs and callbacks and
> drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
> prologue when a struct_ops trampoline is being prepared.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Co-developed-by: Maxwell Bland <mbland@motorola.com>
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Tested-by: Dao Huang <huangdao1@oppo.com>
> Acked-by: Will Deacon <will@kernel.org>
> ---
>   arch/arm64/include/asm/cfi.h  |  7 +++++++
>   arch/arm64/net/bpf_jit_comp.c | 22 +++++++++++++++++++---
>   2 files changed, 26 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm64/include/asm/cfi.h
> 
> diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
> new file mode 100644
> index 000000000000..ab90f0351b7a
> --- /dev/null
> +++ b/arch/arm64/include/asm/cfi.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_CFI_H
> +#define _ASM_ARM64_CFI_H
> +
> +#define __bpfcall
> +
> +#endif /* _ASM_ARM64_CFI_H */
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 89b1b8c248c6..f4a98c1a1583 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -10,6 +10,7 @@
>   #include <linux/arm-smccc.h>
>   #include <linux/bitfield.h>
>   #include <linux/bpf.h>
> +#include <linux/cfi.h>
>   #include <linux/filter.h>
>   #include <linux/memory.h>
>   #include <linux/printk.h>
> @@ -166,6 +167,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
>   		emit(insn, ctx);
>   }
>   
> +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
> +{
> +	if (IS_ENABLED(CONFIG_CFI_CLANG))
> +		emit(hash, ctx);

I guess this won't work on big-endian cpus, since arm64 instructions
are always stored in little-endian, but data not.

> +}
> +
>   /*
>    * Kernel addresses in the vmalloc space use at most 48 bits, and the
>    * remaining bits are guaranteed to be 0x1. So we can compose the address
> @@ -476,7 +483,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>   	const bool is_main_prog = !bpf_is_subprog(prog);
>   	const u8 fp = bpf2a64[BPF_REG_FP];
>   	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
> -	const int idx0 = ctx->idx;
>   	int cur_offset;
>   
>   	/*
> @@ -502,6 +508,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>   	 *
>   	 */
>   
> +	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
> +	const int idx0 = ctx->idx;

move the idx0 definition back to its original position to match the
coding style of the rest of the file?

> +
>   	/* bpf function may be invoked by 3 instruction types:
>   	 * 1. bl, attached via freplace to bpf prog via short jump
>   	 * 2. br, attached via freplace to bpf prog via long jump
> @@ -2055,9 +2064,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   		jit_data->ro_header = ro_header;
>   	}
>   
> -	prog->bpf_func = (void *)ctx.ro_image;
> +	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
>   	prog->jited = 1;
> -	prog->jited_len = prog_size;
> +	prog->jited_len = prog_size - cfi_get_offset();
>   
>   	if (!prog->is_func || extra_pass) {
>   		int i;
> @@ -2426,6 +2435,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	/* return address locates above FP */
>   	retaddr_off = stack_size + 8;
>   
> +	if (flags & BPF_TRAMP_F_INDIRECT) {
> +		/*
> +		 * Indirect call for bpf_struct_ops
> +		 */
> +		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
> +	}
>   	/* bpf trampoline may be invoked by 3 instruction types:
>   	 * 1. bl, attached to bpf prog or kernel function via short jump
>   	 * 2. br, attached to bpf prog or kernel function via long jump
> @@ -2942,6 +2957,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>   					   sizeof(jit_data->header->size));
>   			kfree(jit_data);
>   		}
> +		prog->bpf_func -= cfi_get_offset();
>   		hdr = bpf_jit_binary_pack_hdr(prog);
>   		bpf_jit_binary_pack_free(hdr, NULL);
>   		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));



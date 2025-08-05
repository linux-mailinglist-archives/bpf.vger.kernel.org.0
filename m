Return-Path: <bpf+bounces-65050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB2B1B29D
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0105318A1288
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CBC24886E;
	Tue,  5 Aug 2025 11:28:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240615A8
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754393302; cv=none; b=q7Aw/Y+cMFJxEongnLKCPgzB/3jIJ0+vy2flF0yOy86o2YO0aUOILYrz+/Ns6rym4jZ0h3Jf6ben5Y0UZ1Nn78w4xF2OpopUffHTpE33Zixbx86Vv6XdiOA4QDbMmwrRcaKCxf6hCotVpaOE6nCfv7qPUBg5UXbdsMQKT1cjV+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754393302; c=relaxed/simple;
	bh=ARgbB7aXDM2i2Fth/ejElNAljX8KIT0UkeSbVRRLPGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EcU4eZSKRhc2lqtaXdN6RfkXzAYL1msSFz14claDRAriXevyUOlEkSh3vMyM/5n0IVZR7nunYNeVebG6S03l2Rf/9Gdnkswr/cwJrpoJe+eH2chkKgbbFh6qZsCPGRvAZ70O5ae99uFP3gP+gKbCMGJOHtpHiLgDW9nvDRvXuGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bxB4Y65V0zKHMmb
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 19:28:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DEFF71A16C6
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 19:28:12 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCXYBHL6pFoTdSaCg--.26831S2;
	Tue, 05 Aug 2025 19:28:12 +0800 (CST)
Message-ID: <ecf88f6e-1941-4278-815c-e003dd7b9621@huaweicloud.com>
Date: Tue, 5 Aug 2025 19:28:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf, arm64: Add JIT support for timed
 may_goto
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
References: <20250724125443.26182-1-puranjay@kernel.org>
 <20250724125443.26182-2-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250724125443.26182-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXYBHL6pFoTdSaCg--.26831S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1kCrWDCFy7WF1rGFyUWrg_yoWrWF4Dpw
	4rurnakr4kW3yrJr93t3W7ZFy5Ca1kXa12vryxKrWFyFy2qas3GF45K3s8Ar4YkF18Za15
	XrWj9F9xC3WDJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/24/2025 8:54 PM, Puranjay Mohan wrote:
> When verifier sees a timed may_goto instruction, it emits a call to
> arch_bpf_timed_may_goto() with a stack offset in BPF_REG_AX (arm64 r9)
> and expects a count value to be returned in the same register. The
> verifier doesn't save or restore any registers before emitting this
> call.
> 
> arch_bpf_timed_may_goto() should act as a trampoline to call
> bpf_check_timed_may_goto() with AAPCS64 calling convention.
> 
> To support this custom calling convention, implement
> arch_bpf_timed_may_goto() in assembly and make sure BPF caller saved
> registers are saved and restored, call bpf_check_timed_may_goto with
> arm64 calling convention where first argument and return value both are
> in x0, then put the result back into BPF_REG_AX before returning.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/arm64/net/Makefile             |  2 +-
>   arch/arm64/net/bpf_jit_comp.c       | 13 ++++++++++-
>   arch/arm64/net/bpf_timed_may_goto.S | 36 +++++++++++++++++++++++++++++
>   3 files changed, 49 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm64/net/bpf_timed_may_goto.S
> 
> diff --git a/arch/arm64/net/Makefile b/arch/arm64/net/Makefile
> index 5c540efb7d9b9..3ae382bfca879 100644
> --- a/arch/arm64/net/Makefile
> +++ b/arch/arm64/net/Makefile
> @@ -2,4 +2,4 @@
>   #
>   # ARM64 networking code
>   #
> -obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
> +obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 89b1b8c248c62..6c954b36f57ea 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1505,7 +1505,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   		if (ret < 0)
>   			return ret;
>   		emit_call(func_addr, ctx);
> -		emit(A64_MOV(1, r0, A64_R(0)), ctx);
> +		/*
> +		 * Call to arch_bpf_timed_may_goto() is emitted by the
> +		 * verifier and called with custom calling convention with
> +		 * first argument and return value in BPF_REG_AX (x9).
> +		 */
> +		if (func_addr != (u64)arch_bpf_timed_may_goto)
> +			emit(A64_MOV(1, r0, A64_R(0)), ctx);
>   		break;
>   	}
>   	/* tail call */
> @@ -2914,6 +2920,11 @@ bool bpf_jit_bypass_spec_v4(void)
>   	return true;
>   }
>   
> +bool bpf_jit_supports_timed_may_goto(void)
> +{
> +	return true;
> +}
> +
>   bool bpf_jit_inlines_helper_call(s32 imm)
>   {
>   	switch (imm) {
> diff --git a/arch/arm64/net/bpf_timed_may_goto.S b/arch/arm64/net/bpf_timed_may_goto.S
> new file mode 100644
> index 0000000000000..45f80e752345c
> --- /dev/null
> +++ b/arch/arm64/net/bpf_timed_may_goto.S
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Puranjay Mohan <puranjay@kernel.org> */
> +
> +#include <linux/linkage.h>
> +
> +SYM_FUNC_START(arch_bpf_timed_may_goto)
> +	/* Allocate stack space and emit frame record */
> +	stp     x29, x30, [sp, #-64]!
> +	mov     x29, sp
> +
> +	/* Save BPF registers R0 - R5 (x7, x0-x4)*/
> +	stp	x7, x0, [sp, #16]
> +	stp	x1, x2, [sp, #32]
> +	stp	x3, x4, [sp, #48]
> +
> +	/*
> +	 * Stack depth was passed in BPF_REG_AX (x9), add it to the BPF_FP
> +	 * (x25) to get the pointer to count and timestamp and pass it as the
> +	 * first argument in x0.
> +	 */
> +	add	x0, x9, x25

Whether BPF_REG_FP (x25) is set up by the arm64 jit depends on whether
the jit detects any bpf instruction using it. Before generating the
call to arch_bpf_timed_may_goto, the verifier generates a load
instruction using FP, i.e. AX = *(u64 *)(FP - stack_off_cnt),
so FP is always set up in this case.

It seems a bit subtle. Maybe we should add a comment here?

> +	bl	bpf_check_timed_may_goto
> +	/* BPF_REG_AX(x9) will be stored into count, so move return value to it. */
> +	mov	x9, x0
> +
> +

Nit: one extra blank line

> +	/* Restore BPF registers R0 - R5 (x7, x0-x4) */
> +	ldp	x7, x0, [sp, #16]
> +	ldp	x1, x2, [sp, #32]
> +	ldp	x3, x4, [sp, #48]
> +
> +	/* Restore FP and LR */
> +	ldp     x29, x30, [sp], #64
> +
> +	ret
> +SYM_FUNC_END(arch_bpf_timed_may_goto)



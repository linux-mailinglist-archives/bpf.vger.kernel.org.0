Return-Path: <bpf+bounces-65199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF5B1D903
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 15:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F7D584CE0
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCD725BF16;
	Thu,  7 Aug 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgvDcnj0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3225B31B
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573259; cv=none; b=Ye0UuDWRUchbUnhyhvvlHHGwvezVaInZynqsUwvRnmzZTtoQw3ImnkidgTUjzEi3cOUzbONcEEmJ5hzGqdARaCEjTu20Zp/RTgFkbPC4hIWhYYPt1btKm5U/SF4ipW780DrHyuXDsA6wkc9pv08rkyyc6+vpqzwIHgRtemjQA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573259; c=relaxed/simple;
	bh=jSZsPRD4nzGq6hD0NeGuq2Y6Cs6g5pB3pbl8hOrCHYw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HmZ9zNZJC7j3p6+05le09JcfyXdIomhUq9zN+SptNRwlIOta9F4j3/wTrd4bizBDeS3Oq2P8alPlEfx2+47RN8p5LU5A0X/BHOldBJTMB4TVfUWrkhJrVHhqAI7dh1xkw6sr9XQELs4+DQVKAHi6ZxbN27+SdglkZWsq7e02tU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgvDcnj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496EBC4CEEB;
	Thu,  7 Aug 2025 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754573258;
	bh=jSZsPRD4nzGq6hD0NeGuq2Y6Cs6g5pB3pbl8hOrCHYw=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=RgvDcnj0u1V9Qv/FyyVNt+LFbjmJW9kZcdZDxLeIcHU4AwVZFmU1XvJ9VCcn3QTtP
	 Zjz2JysMkbQVWnbDTFzYOPDVWuqTxaWzCr9Gv+tnLJLFEcG3BIdJ2ssYK13im2B88e
	 bPvMHn4dUo6KP5FJPuMOkBo27pu2bBmSKomhE39YE0zgNkq5sqPQFCRc5Jb8jxUUMi
	 LGUl4rKEtcPlrs5uOW+MTgFDLUcXG0pSaaWtP1uAoIjYpGe6z/G7VJuqY4CFNzWuNA
	 fmqnX7idsmvtjit/NVI9DqljZXVHTsv6MZQ1LFisONuVSS4edrsjSBavlpO+rKU3bc
	 KX1Q28VuOXcSA==
From: <puranjay@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf, arm64: Add JIT support for timed
 may_goto
In-Reply-To: <ecf88f6e-1941-4278-815c-e003dd7b9621@huaweicloud.com>
References: <20250724125443.26182-1-puranjay@kernel.org>
 <20250724125443.26182-2-puranjay@kernel.org>
 <ecf88f6e-1941-4278-815c-e003dd7b9621@huaweicloud.com>
Date: Thu, 07 Aug 2025 13:27:34 +0000
Message-ID: <mb61pectngt2x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> On 7/24/2025 8:54 PM, Puranjay Mohan wrote:
>> When verifier sees a timed may_goto instruction, it emits a call to
>> arch_bpf_timed_may_goto() with a stack offset in BPF_REG_AX (arm64 r9)
>> and expects a count value to be returned in the same register. The
>> verifier doesn't save or restore any registers before emitting this
>> call.
>> 
>> arch_bpf_timed_may_goto() should act as a trampoline to call
>> bpf_check_timed_may_goto() with AAPCS64 calling convention.
>> 
>> To support this custom calling convention, implement
>> arch_bpf_timed_may_goto() in assembly and make sure BPF caller saved
>> registers are saved and restored, call bpf_check_timed_may_goto with
>> arm64 calling convention where first argument and return value both are
>> in x0, then put the result back into BPF_REG_AX before returning.
>> 
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>   arch/arm64/net/Makefile             |  2 +-
>>   arch/arm64/net/bpf_jit_comp.c       | 13 ++++++++++-
>>   arch/arm64/net/bpf_timed_may_goto.S | 36 +++++++++++++++++++++++++++++
>>   3 files changed, 49 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/arm64/net/bpf_timed_may_goto.S
>> 
>> diff --git a/arch/arm64/net/Makefile b/arch/arm64/net/Makefile
>> index 5c540efb7d9b9..3ae382bfca879 100644
>> --- a/arch/arm64/net/Makefile
>> +++ b/arch/arm64/net/Makefile
>> @@ -2,4 +2,4 @@
>>   #
>>   # ARM64 networking code
>>   #
>> -obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
>> +obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 89b1b8c248c62..6c954b36f57ea 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -1505,7 +1505,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>>   		if (ret < 0)
>>   			return ret;
>>   		emit_call(func_addr, ctx);
>> -		emit(A64_MOV(1, r0, A64_R(0)), ctx);
>> +		/*
>> +		 * Call to arch_bpf_timed_may_goto() is emitted by the
>> +		 * verifier and called with custom calling convention with
>> +		 * first argument and return value in BPF_REG_AX (x9).
>> +		 */
>> +		if (func_addr != (u64)arch_bpf_timed_may_goto)
>> +			emit(A64_MOV(1, r0, A64_R(0)), ctx);
>>   		break;
>>   	}
>>   	/* tail call */
>> @@ -2914,6 +2920,11 @@ bool bpf_jit_bypass_spec_v4(void)
>>   	return true;
>>   }
>>   
>> +bool bpf_jit_supports_timed_may_goto(void)
>> +{
>> +	return true;
>> +}
>> +
>>   bool bpf_jit_inlines_helper_call(s32 imm)
>>   {
>>   	switch (imm) {
>> diff --git a/arch/arm64/net/bpf_timed_may_goto.S b/arch/arm64/net/bpf_timed_may_goto.S
>> new file mode 100644
>> index 0000000000000..45f80e752345c
>> --- /dev/null
>> +++ b/arch/arm64/net/bpf_timed_may_goto.S
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2025 Puranjay Mohan <puranjay@kernel.org> */
>> +
>> +#include <linux/linkage.h>
>> +
>> +SYM_FUNC_START(arch_bpf_timed_may_goto)
>> +	/* Allocate stack space and emit frame record */
>> +	stp     x29, x30, [sp, #-64]!
>> +	mov     x29, sp
>> +
>> +	/* Save BPF registers R0 - R5 (x7, x0-x4)*/
>> +	stp	x7, x0, [sp, #16]
>> +	stp	x1, x2, [sp, #32]
>> +	stp	x3, x4, [sp, #48]
>> +
>> +	/*
>> +	 * Stack depth was passed in BPF_REG_AX (x9), add it to the BPF_FP
>> +	 * (x25) to get the pointer to count and timestamp and pass it as the
>> +	 * first argument in x0.
>> +	 */
>> +	add	x0, x9, x25
>
> Whether BPF_REG_FP (x25) is set up by the arm64 jit depends on whether
> the jit detects any bpf instruction using it. Before generating the
> call to arch_bpf_timed_may_goto, the verifier generates a load
> instruction using FP, i.e. AX = *(u64 *)(FP - stack_off_cnt),
> so FP is always set up in this case.
>
> It seems a bit subtle. Maybe we should add a comment here?

Yes, a comment would be useful. I will add it in the next version.

>> +	bl	bpf_check_timed_may_goto
>> +	/* BPF_REG_AX(x9) will be stored into count, so move return value to it. */
>> +	mov	x9, x0
>> +
>> +
>
> Nit: one extra blank line
>

Thanks,
Puranjay


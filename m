Return-Path: <bpf+bounces-68667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3AAB7FF40
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7657527C0F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5D2EAB6A;
	Wed, 17 Sep 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAJB4THK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965017A318
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118569; cv=none; b=P+eR67FrePvSjWjbSvz9q7fqnSKjikdNuugOkJ0CxscQjJkBLOrfHDjWruNthR0nmb7xzc8zsykBty43oW7ZO20BPVH1y8sCT0EvnMFq/1RCfsjLDekYskgj+lKTfiGIFA+UeyoqMkpn6TNrNqQoxgfQqXx6jxnGv1ouwoyZiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118569; c=relaxed/simple;
	bh=iPkF3fBHAQEobxvFhgppI9SLXWce+/sge5vgk2U3sE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CEumlAKkoibr4+ElfamX4rO4ttGksksaPxWuB50qopY2x0cBNyXGSHrSZaMpimOqzya0tW8xdEiq+RmBfzrAaDDDUmrGypLwkTgruESizPXujFdqJlBGLDnmuLx5EU3K/FJwdWMdHjgvwXT5Yl/F0va9TjJd9xPQ7JKKSuX/Hr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAJB4THK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3B4C4CEE7;
	Wed, 17 Sep 2025 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758118569;
	bh=iPkF3fBHAQEobxvFhgppI9SLXWce+/sge5vgk2U3sE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PAJB4THKFVMjTEY1PxvcWw1iVEiH69xABpTYdtLQy8pIGMTSHJkrqAbgVBlfzY3Cx
	 zkykCL3mnmaQo9e/c5pEaWCLYvSFQbaJsKf7Y9srB93w6cFkwvcBxQoOJQ4UzPk0qD
	 ZFbKCoKyheK5HeMiaRu45uN3S01ikYXahif1LcRurCVg7S1p/KoMC+Q0FCbkkcH6u4
	 Ym0wrSMhm4Ya6HmI8MLFip8P7NueZHe9e9rbHzdkbH38jxl8ipeT4ar5HjhFD3urNN
	 4W4Q+X5xDclEliJWOTdNPxY+0EyDX7XnyPFTJNqFXTzAsU8zWmoxoSDU4NDyRkNcSM
	 /4r4uOg66gVkA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, kernel-team@meta.com, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf, x86: Add support for signed arena
 loads
In-Reply-To: <ba84c72f4732b0fe180b2ba40cc66577c78c177b.camel@gmail.com>
References: <20250915162848.54282-1-puranjay@kernel.org>
 <20250915162848.54282-2-puranjay@kernel.org>
 <ba84c72f4732b0fe180b2ba40cc66577c78c177b.camel@gmail.com>
Date: Wed, 17 Sep 2025 14:16:06 +0000
Message-ID: <mb61p4it1qi55.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Mon, 2025-09-15 at 16:28 +0000, Puranjay Mohan wrote:
>
> [...]
>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 008273a53e04..f2b85a10add2 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -3064,6 +3064,11 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>>  		if (!bpf_atomic_is_load_store(insn) &&
>>  		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
>>  			return false;
>> +		break;
>> +	case BPF_LDX | BPF_MEMSX | BPF_B:
>> +	case BPF_LDX | BPF_MEMSX | BPF_H:
>> +	case BPF_LDX | BPF_MEMSX | BPF_W:
>> +		return false;
>>  	}
>>  	return true;
>>  }
>
> Is the same hunk necessary in riscv/net/bpf_jit_comp64.c?

Yes, will add in next version.

> [...]
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 8d34a9400a5e..a6550da34268 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1152,11 +1152,38 @@ static void emit_ldx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 i
>>  	*pprog = prog;
>>  }
>>  
>> +static void emit_ldsx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 index_reg, int off)
>> +{
>> +	u8 *prog = *pprog;
>> +
>> +	switch (size) {
>> +	case BPF_B:
>> +		/* movsx rax, byte ptr [rax + r12 + off] */
>> +		EMIT3(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x0F, 0xBE);
>> +		break;
>> +	case BPF_H:
>> +		/* movsx rax, word ptr [rax + r12 + off] */
>> +		EMIT3(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x0F, 0xBF);
>> +		break;
>> +	case BPF_W:
>> +		/* movsx rax, dword ptr [rax + r12 + off] */
>> +		EMIT2(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x63);
>> +		break;
>> +	}
>> +	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
>> +	*pprog = prog;
>> +}
>> +
>
> Encoding looks correct.
>
> [...]
>
>> @@ -2109,13 +2136,19 @@ st:			if (is_imm8(insn->off))
>>  		case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
>>  		case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
>>  		case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
>> +		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
>> +		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
>> +		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
>>  		case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
>>  		case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
>>  		case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
>>  		case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
>>  			start_of_ldx = prog;
>>  			if (BPF_CLASS(insn->code) == BPF_LDX)
>> -				emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>> +				if (BPF_MODE(insn->code) == BPF_PROBE_MEM32SX)
>> +					emit_ldsx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>> +				else
>> +					emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>>  			else
>>  				emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>
> Heh, apparently this is correct C code. Dangling else is associated
> with the closest 'if' statement. Didn't know that.

This code goes against kernel coding style, I should have used braces.
Will fix it in next version.


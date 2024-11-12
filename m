Return-Path: <bpf+bounces-44670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2049C6398
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 22:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F761F2543B
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 21:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429EF21A4B9;
	Tue, 12 Nov 2024 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NA2Lq0HC"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC321A4DC
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447592; cv=none; b=Nho9i+oqMuknvQPtzGJrZpWyPq3Fzca6y+4FlPhzJ9xP2FfugL51vgYci/WrVs036J5+th7YVj5rvwf+hrzXdvGttoClKiXOgf4Pb+egC44Tp9jh5qxNIN0r+wxCO/XjVSjNFa9nMNXtHSdfoqJ1CSIBTOzSPqH8wQTYtB+iO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447592; c=relaxed/simple;
	bh=d6f4lA1r0xQi6UbXl1JtagULlL2fryp8GyissnZelNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXBC1A5aLlApwY7AlD3GY62Ks07Cqc1zAmgBE5JyM3u9jhEdFWdmEZLCp4VNOm/w1LVRRfe2AHfYBMzpe61g4KJPYzRKI28QkOx3vvPBEf+C8Ws+HHqHeAuSH5P/b3rk+OivzOJUHfewCr1HOvgsUCP+OdLmcGvneMzD0uJlf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NA2Lq0HC; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03bcf4ca-5e6f-4523-9661-46102b4f02b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731447587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYR0jEruLvqq3I7rz6FYgZHSWYmanNVkspVvG01y8TY=;
	b=NA2Lq0HCqhWg8oYks9BLU+wWX6TZn/xZHFt6XE+Suwg/SY6GBqCVoEIk1qv5EWGECT3NDH
	bAapEPw8zNICVChuvkOtcIm2htt77DTPLwax184c/sLDn8bB4bz1dExRD5ZCRdtox1FBjz
	Hy9YA2QbdBCTPu7ABEORxL/yQvZY/TM=
Date: Tue, 12 Nov 2024 21:39:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Eduard Zingerman <eddyz87@gmail.com>, Vadim Fedorenko <vadfed@meta.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>
Cc: x86@kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20241109004158.2259301-1-vadfed@meta.com>
 <cd904b908d0d84c4f8454683495977f64d081004.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <cd904b908d0d84c4f8454683495977f64d081004.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/11/2024 21:21, Eduard Zingerman wrote:
> On Fri, 2024-11-08 at 16:41 -0800, Vadim Fedorenko wrote:
>> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
>> it into rdtsc ordered call. Other architectures will get JIT
>> implementation too if supported. The fallback is to
>> __arch_get_hw_counter().
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
> 
> Aside from a note below, I think this patch is in good shape.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 06b080b61aa5..4f78ed93ee7f 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -2126,6 +2126,26 @@ st:			if (is_imm8(insn->off))
>>   		case BPF_JMP | BPF_CALL: {
>>   			u8 *ip = image + addrs[i - 1];
>>   
>> +			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>> +			    imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
>> +				/* Save RDX because RDTSC will use EDX:EAX to return u64 */
>> +				emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
>> +				if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
>> +					EMIT_LFENCE();
>> +				EMIT2(0x0F, 0x31);
>> +
>> +				/* shl RDX, 32 */
>> +				maybe_emit_1mod(&prog, BPF_REG_3, true);
>> +				EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
>> +				/* or RAX, RDX */
>> +				maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
>> +				EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
>> +				/* restore RDX from R11 */
>> +				emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
> 
> Note: The default implementation of this kfunc uses __arch_get_hw_counter(),
>        which is implemented as `(u64)rdtsc_ordered() & S64_MAX`.
>        Here we don't do `& S64_MAX`.
>        The masking in __arch_get_hw_counter() was added by this commit:
>        77750f78b0b3 ("x86/vdso: Fix gettimeofday masking").

I think we already discussed it with Alexey in v1, we don't really need
any masking here for BPF case. We can use values provided by CPU
directly. It will never happen that within one BPF program we will have
inlined and non-inlined implementation of this helper, hence the values
to compare will be of the same source.

>        Also, the default implementation does not issue `lfence`.
>        Not sure if this makes any real-world difference.

Well, it actually does. rdtsc_ordered is translated into `lfence; rdtsc`
or `rdtscp` (which is rdtsc + lfence + u32 cookie) depending on the cpu
features.

>> +
>> +				break;
>> +			}
>> +
>>   			func = (u8 *) __bpf_call_base + imm32;
>>   			if (tail_call_reachable) {
>>   				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
> 
> [...]
> 
>> @@ -20488,6 +20510,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   						node_offset_reg, insn, insn_buf, cnt);
>>   	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
>>   		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>> +		if (!verifier_inlines_kfunc_call(env, imm)) {
>> +			verbose(env, "verifier internal error: kfunc id %d is not defined in checker\n",
>> +				desc->func_id);
>> +			return -EFAULT;
>> +		}
>> +
> 
> Nit: still think that moving this check as the first conditional would
>       have been better:
> 
>       if (verifier_inlines_kfunc_call(env, imm)) {
>          if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
>             desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>             // ...
>          } else {
>             // report error
>          }
>       } else if (...) {
>         // ... rest of the cases
>       }

I can change it in the next iteration (if it's needed) if you insist

>>   		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>>   		*cnt = 1;
>>   	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
> 
> 



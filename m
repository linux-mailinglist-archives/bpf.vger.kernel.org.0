Return-Path: <bpf+bounces-22069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E606B85602A
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 11:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF300B367F2
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 10:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D012F5AC;
	Thu, 15 Feb 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rNo7gT1n"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3912F59A
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993520; cv=none; b=iflrHzRtGyFDUEIO1LPGCbWWEM7PlQ63TRUnI2VxXaNKnbV5KMIARyaRQakcRg0EIzRf6aPM2d6bOQxqAu2yX3rIdnuDkrwyoRpzfwOXCQ9yNVNOKfwH/zynIiyIj9VNwiRTh8o3KW3UX3rSxdTDwwsG6Y9mgN3/yvCpMmX/z6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993520; c=relaxed/simple;
	bh=Ihu6OcNR/sSL0DX6rmpWTPtLW7k0sx45e4gmL+Daibk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iW7uIF2522G6dVZDDiRGR10L1hzNagHEFq4Xawujlkj5peeVTnEJux5cMCBJZvCeXL5hh4LAIvPTzcvRcJrg2OElbCY21amAx11X3YT2ltJ6apzFPxkLmjT1dxxsSADUrNiPPpI1qp/p5a8kJUaD2rHWPKWLz9O0Spzs4gDOc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rNo7gT1n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FAbRv4022340;
	Thu, 15 Feb 2024 10:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6H8CoKRMRlXvbgSaMwCasmUHfPcV+nOtz9nK1USeSaE=;
 b=rNo7gT1nM0dc7VDeFaEtF0uK3UkzqMmZi10l7b3nXTII87VhytUZVV19+rFcxOh6cg/c
 E30tRmEEg47qBNpnrJzCq6gCmoppoBnJQZz971420oEcRA38NinFJIw6gjAFhLEIJfzi
 dUC6gG3tV/ao5OMJLX1UU+WEM/wIxCdgYIXn8OgKp848Q3OOqt7MSqCZ/N+/vRwHekEJ
 pTAJF4SKKIjalX+4MWVMvuWL2g2ToeOqJi5C8e7GYmOvhnleOfwB5RWXJIBtpPzIOzMC
 L5/drCSXYou+Mdt1RVXjnR3g8ksrrhaVNf1uXm4iPGyWat4LqQvnRVpvl4yJio70I7FU DQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9h12r0rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:38:04 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41F9VKvq010063;
	Thu, 15 Feb 2024 10:38:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npm3r3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:38:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FAc0Pa6554360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 10:38:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B532004B;
	Thu, 15 Feb 2024 10:38:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6B720040;
	Thu, 15 Feb 2024 10:37:57 +0000 (GMT)
Received: from [9.43.101.252] (unknown [9.43.101.252])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 10:37:57 +0000 (GMT)
Message-ID: <143ba45f-1507-4ea8-a2db-64b6011128fc@linux.ibm.com>
Date: Thu, 15 Feb 2024 16:07:56 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] powerpc/bpf: ensure module addresses are supported
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
References: <20240201171249.253097-1-hbathini@linux.ibm.com>
 <077afac5-6247-4377-aa45-0b9441a9e1c1@csgroup.eu>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <077afac5-6247-4377-aa45-0b9441a9e1c1@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bOUjt_mSaaUzMRladmm_-GAbjUuCcIHF
X-Proofpoint-ORIG-GUID: bOUjt_mSaaUzMRladmm_-GAbjUuCcIHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150084



On 13/02/24 1:23 pm, Christophe Leroy wrote:
> 
> 
> Le 01/02/2024 à 18:12, Hari Bathini a écrit :
>> Currently, bpf jit code on powerpc assumes all the bpf functions and
>> helpers to be kernel text. This is false for kfunc case, as function
>> addresses are mostly module addresses in that case. Ensure module
>> addresses are supported to enable kfunc support.
>>
>> Assume kernel text address for programs with no kfunc call to optimize
>> instruction sequence in that case. Add a check to error out if this
>> assumption ever changes in the future.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>
>> Changes in v2:
>> * Using bpf_prog_has_kfunc_call() to decide whether to use optimized
>>     instruction sequence or not as suggested by Naveen.
>>
>>
>>    arch/powerpc/net/bpf_jit.h        |   5 +-
>>    arch/powerpc/net/bpf_jit_comp.c   |   4 +-
>>    arch/powerpc/net/bpf_jit_comp32.c |   8 ++-
>>    arch/powerpc/net/bpf_jit_comp64.c | 109 ++++++++++++++++++++++++------
>>    4 files changed, 97 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
>> index cdea5dccaefe..fc56ee0ee9c5 100644
>> --- a/arch/powerpc/net/bpf_jit.h
>> +++ b/arch/powerpc/net/bpf_jit.h
>> @@ -160,10 +160,11 @@ static inline void bpf_clear_seen_register(struct codegen_context *ctx, int i)
>>    }
>>    
>>    void bpf_jit_init_reg_mapping(struct codegen_context *ctx);
>> -int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func);
>> +int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func,
>> +			       bool has_kfunc_call);
>>    int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
>>    		       u32 *addrs, int pass, bool extra_pass);
>> -void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
>> +void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx, bool has_kfunc_call);
>>    void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
>>    void bpf_jit_realloc_regs(struct codegen_context *ctx);
>>    int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
>> index 0f9a21783329..7b4103b4c929 100644
>> --- a/arch/powerpc/net/bpf_jit_comp.c
>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>> @@ -163,7 +163,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>>    	 * update ctgtx.idx as it pretends to output instructions, then we can
>>    	 * calculate total size from idx.
>>    	 */
>> -	bpf_jit_build_prologue(NULL, &cgctx);
>> +	bpf_jit_build_prologue(NULL, &cgctx, bpf_prog_has_kfunc_call(fp));
>>    	addrs[fp->len] = cgctx.idx * 4;
>>    	bpf_jit_build_epilogue(NULL, &cgctx);
>>    
>> @@ -192,7 +192,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>>    		/* Now build the prologue, body code & epilogue for real. */
>>    		cgctx.idx = 0;
>>    		cgctx.alt_exit_addr = 0;
>> -		bpf_jit_build_prologue(code_base, &cgctx);
>> +		bpf_jit_build_prologue(code_base, &cgctx, bpf_prog_has_kfunc_call(fp));
>>    		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
>>    				       extra_pass)) {
>>    			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
>> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
>> index 2f39c50ca729..447747e51a58 100644
>> --- a/arch/powerpc/net/bpf_jit_comp32.c
>> +++ b/arch/powerpc/net/bpf_jit_comp32.c
>> @@ -123,7 +123,7 @@ void bpf_jit_realloc_regs(struct codegen_context *ctx)
>>    	}
>>    }
>>    
>> -void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>> +void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx, bool has_kfunc_call)
>>    {
>>    	int i;
>>    
>> @@ -201,7 +201,8 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>>    }
>>    
>>    /* Relative offset needs to be calculated based on final image location */
>> -int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
>> +int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func,
>> +			       bool has_kfunc_call)
>>    {
>>    	s32 rel = (s32)func - (s32)(fimage + ctx->idx);
>>    
>> @@ -1054,7 +1055,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>>    				EMIT(PPC_RAW_STW(bpf_to_ppc(BPF_REG_5), _R1, 12));
>>    			}
>>    
>> -			ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
>> +			ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr,
>> +							 bpf_prog_has_kfunc_call(fp));
>>    			if (ret)
>>    				return ret;
>>    
>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
>> index 79f23974a320..385a5df1670c 100644
>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>> @@ -122,12 +122,17 @@ void bpf_jit_realloc_regs(struct codegen_context *ctx)
>>    {
>>    }
>>    
>> -void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>> +void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx, bool has_kfunc_call)
>>    {
>>    	int i;
>>    
>>    #ifndef CONFIG_PPC_KERNEL_PCREL
>> -	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
>> +	/*
>> +	 * If the program doesn't have a kfunc call, all BPF helpers are part of kernel text
>> +	 * and all BPF programs/functions utilize the kernel TOC. So, optimize the
>> +	 * instruction sequence by using kernel toc in r2 for that case.
>> +	 */
>> +	if (!has_kfunc_call && IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
>>    		EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
>>    #endif
>>    
>> @@ -202,12 +207,17 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>>    	EMIT(PPC_RAW_BLR());
>>    }
>>    
>> -static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u64 func)
>> +static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u64 func,
>> +				      bool has_kfunc_call)
>>    {
>>    	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
>>    	long reladdr;
>>    
>> -	if (WARN_ON_ONCE(!core_kernel_text(func_addr)))
>> +	/*
>> +	 * If the program doesn't have a kfunc call, all BPF helpers are assumed to be part of
>> +	 * kernel text. Don't proceed if that assumption ever changes in future.
>> +	 */
>> +	if (!has_kfunc_call && WARN_ON_ONCE(!core_kernel_text(func_addr)))
>>    		return -EINVAL;
>>    
>>    	if (IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {
>> @@ -225,30 +235,55 @@ static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u
>>    		EMIT(PPC_RAW_BCTR());
>>    
>>    	} else {
>> -		reladdr = func_addr - kernel_toc_addr();
>> -		if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
>> -			pr_err("eBPF: address of %ps out of range of kernel_toc.\n", (void *)func);
>> -			return -ERANGE;
>> -		}
>> +		if (has_kfunc_call) {
>> +#ifdef PPC64_ELF_ABI_v1
> 
> I can't see a reason for a #ifdef here, why not use IS_ENABLED() like
> other places ?
> 
>> +			/* func points to the function descriptor */
>> +			PPC_LI64(b2p[TMP_REG_2], func);
>> +			/* Load actual entry point from function descriptor */
>> +			PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_2], 0);
>> +			/* ... and move it to CTR */
>> +			EMIT(PPC_RAW_MTCTR(b2p[TMP_REG_1]));
>> +			/*
>> +			 * Load TOC from function descriptor at offset 8.
>> +			 * We can clobber r2 since we get called through a
>> +			 * function pointer (so caller will save/restore r2)
>> +			 * and since we don't use a TOC ourself.
>> +			 */
>> +			PPC_BPF_LL(2, b2p[TMP_REG_2], 8);
>> +#else
>> +			/* We can clobber r12 */
>> +			PPC_LI64(12, func);
>> +			EMIT(PPC_RAW_MTCTR(12));
>> +#endif
>> +		} else {
>> +			reladdr = func_addr - kernel_toc_addr();
>> +			if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
>> +				pr_err("eBPF: address of %ps out of range of kernel_toc.\n",
>> +				       (void *)func);
>> +				return -ERANGE;
>> +			}
>>    
>> -		EMIT(PPC_RAW_ADDIS(_R12, _R2, PPC_HA(reladdr)));
>> -		EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
>> -		EMIT(PPC_RAW_MTCTR(_R12));
>> +			EMIT(PPC_RAW_ADDIS(_R12, _R2, PPC_HA(reladdr)));
>> +			EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
>> +			EMIT(PPC_RAW_MTCTR(_R12));
>> +		}
>>    		EMIT(PPC_RAW_BCTRL());
>>    	}
>>    
>>    	return 0;
>>    }
>>    
>> -int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
>> +int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func,
>> +			       bool has_kfunc_call)
>>    {
>>    	unsigned int i, ctx_idx = ctx->idx;
>>    
>> -	if (WARN_ON_ONCE(func && is_module_text_address(func)))
>> +	if (WARN_ON_ONCE(func && !has_kfunc_call && is_module_text_address(func)))
>>    		return -EINVAL;
>>    
>>    	/* skip past descriptor if elf v1 */
>> -	func += FUNCTION_DESCR_SIZE;
>> +	if (!has_kfunc_call)
>> +		func += FUNCTION_DESCR_SIZE;
>>    
>>    	/* Load function address into r12 */
>>    	PPC_LI64(_R12, func);
>> @@ -267,13 +302,28 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>>    		for (i = ctx->idx - ctx_idx; i < 5; i++)
>>    			EMIT(PPC_RAW_NOP());
>>    
>> +#ifdef PPC64_ELF_ABI_v1
> 
> I can't see a reason for a #ifdef here, why not use IS_ENABLED() like
> other places ?

Will update.

> 
> 
>> +	if (has_kfunc_call) {
>> +		/*
>> +		 * Load TOC from function descriptor at offset 8.
>> +		 * We can clobber r2 since we get called through a
>> +		 * function pointer (so caller will save/restore r2)
>> +		 * and since we don't use a TOC ourself.
>> +		 */
>> +		PPC_BPF_LL(2, 12, 8);
>> +		/* Load actual entry point from function descriptor */
>> +		PPC_BPF_LL(12, 12, 0);
>> +	}
>> +#endif
>> +
>>    	EMIT(PPC_RAW_MTCTR(_R12));
>>    	EMIT(PPC_RAW_BCTRL());
>>    
>>    	return 0;
>>    }
>>    
>> -static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
>> +static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out,
>> +				  bool has_kfunc_call)
>>    {
>>    	/*
>>    	 * By now, the eBPF program has already setup parameters in r3, r4 and r5
>> @@ -285,7 +335,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>>    	int b2p_index = bpf_to_ppc(BPF_REG_3);
>>    	int bpf_tailcall_prologue_size = 8;
>>    
>> -	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
>> +	if (!has_kfunc_call && IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
>>    		bpf_tailcall_prologue_size += 4; /* skip past the toc load */
>>    
>>    	/*
>> @@ -325,8 +375,20 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>>    
>>    	/* goto *(prog->bpf_func + prologue_size); */
>>    	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), offsetof(struct bpf_prog, bpf_func)));
>> -	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1),
>> -			FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
>> +	if (has_kfunc_call) {
>> +#ifdef PPC64_ELF_ABI_v1
> 
> I can't see a reason for a #ifdef here, why not use IS_ENABLED() like
> other places ?
> 
>> +		/* skip past the function descriptor */
>> +		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1),
>> +				FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
>> +#else
>> +		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1),
>> +				bpf_tailcall_prologue_size));
>> +#endif
>> +	} else {
>> +		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1),
>> +				FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
>> +	}
>> +
>>    	EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_1)));
>>    
>>    	/* tear down stack, restore NVRs, ... */
>> @@ -365,6 +427,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>>    		       u32 *addrs, int pass, bool extra_pass)
>>    {
>>    	enum stf_barrier_type stf_barrier = stf_barrier_type_get();
>> +	bool has_kfunc_call = bpf_prog_has_kfunc_call(fp);
>>    	const struct bpf_insn *insn = fp->insnsi;
>>    	int flen = fp->len;
>>    	int i, ret;
>> @@ -993,9 +1056,11 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>>    				return ret;
>>    
>>    			if (func_addr_fixed)
>> -				ret = bpf_jit_emit_func_call_hlp(image, ctx, func_addr);
>> +				ret = bpf_jit_emit_func_call_hlp(image, ctx, func_addr,
>> +								 has_kfunc_call);
> 
> Doesn't this fit on a single line ?
> 
>>    			else
>> -				ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
>> +				ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr,
>> +								 has_kfunc_call);
> 
> Same. Nowadays lines up to 100 chars are the norm.

Goes beyond 100 chars.

> 
>>    
>>    			if (ret)
>>    				return ret;
>> @@ -1204,7 +1269,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>>    		 */
>>    		case BPF_JMP | BPF_TAIL_CALL:
>>    			ctx->seen |= SEEN_TAILCALL;
>> -			ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
>> +			ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1], has_kfunc_call);
>>    			if (ret < 0)
>>    				return ret;
>>    			break;

Thanks
Hari


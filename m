Return-Path: <bpf+bounces-56141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB29A91FDD
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 16:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC47F19E7E73
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1A4252288;
	Thu, 17 Apr 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mC3i1rfp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E125178D;
	Thu, 17 Apr 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900634; cv=none; b=RoHOu/jsSGCBGlgXYstEmdzCpjzWsSugaWi+dwr/YSZfwOV0qziMuXhxhb4jkOqfPhUWEH+cMehmq1N3ewsgPJJ7R93SFUXC2VNvekHzRJxoCrOvsn022e3sXdqzfcrgXECze+b+ijwsKkkmXkBBCWWrXJocT2PtfdJrsZuW+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900634; c=relaxed/simple;
	bh=pKJ3IQr15hjwmz7ksPBHdhNvMjMpoPO2CPdZR1f9kBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okfAW2qUJo7m8iuh6jdBiRhZgFp11WJX9KEz/mVvloLN1B0Pdn+PtP3Bhe6lcYWoJSEIuvItvhqiJroxCjfrA7zsr594CDubrQ1aR9dtivB2LSyCvwvqxy8N7tm+a1mIox9ipKIZVaPqHDFTgWDrzPvJZI68A+D2s4tu1cvDqjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mC3i1rfp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H7ueGT018096;
	Thu, 17 Apr 2025 14:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uk/KzP
	KtZlYzbu4tHDiYZIDCA83mFg/mBq8oFeo8img=; b=mC3i1rfp3gykRoD1p6h9dl
	LBXcHmnzPuJCq/KNt8jIMhyoW8CWd+5lzsry/X4knIcAlJlrDqkUTE+iXqshjc9T
	xUdf+bGXKEDG/EcdvO3pbqt3C5KI/FsHTyqUeczHRZ6+OzXS6Frf5HyLLblCDnKO
	u+sE9lj5g/hUx/bGqgZYQDQ45r5cROfUPWxw+kOg8rEU64fWFwcFqUmdRVhrV3rv
	pR19Jeo3xPPPRC63isUzhrULZg2edOwy5hn9ukwN2fraeY7J16hN9581pbohdXcC
	xD2k113q2cnbMGArcgbjW+BT2HsW1w7hlPxHrJC/P9tKL5dBxqm4uLZAT19/2EhQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu45pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 14:36:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53HEXijm011067;
	Thu, 17 Apr 2025 14:36:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu45pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 14:36:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBcuiH010392;
	Thu, 17 Apr 2025 14:36:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qkdtq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 14:36:37 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53HEaZNu43581736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 14:36:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97DBC58059;
	Thu, 17 Apr 2025 14:36:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA3C65804B;
	Thu, 17 Apr 2025 14:36:31 +0000 (GMT)
Received: from [9.61.245.161] (unknown [9.61.245.161])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Apr 2025 14:36:31 +0000 (GMT)
Message-ID: <93efae34-796f-48a6-9ea7-44d20a67d0d8@linux.ibm.com>
Date: Thu, 17 Apr 2025 20:06:30 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc64/bpf: fix JIT code size calculation of bpf
 trampoline
Content-Language: en-GB
To: Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Naveen N. Rao" <naveen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, stable@vger.kernel.org
References: <20250416194037.204424-1-hbathini@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250416194037.204424-1-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Hvd2G1TS c=1 sm=1 tr=0 ts=680111f6 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=CiTnoRQfHxluCWF7Iu0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zCOOQn0vX--s_pR9DSoai1pYUhoBsMgM
X-Proofpoint-GUID: -O5iP8pAnfkRdu6nRdVfNjM_DUzhpiyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=852 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170109


On 17/04/25 1:10 am, Hari Bathini wrote:
> arch_bpf_trampoline_size() provides JIT size of the BPF trampoline
> before the buffer for JIT'ing it is allocated. The total number of
> instructions emitted for BPF trampoline JIT code depends on where
> the final image is located. So, the size arrived at with the dummy
> pass in arch_bpf_trampoline_size() can vary from the actual size
> needed in  arch_prepare_bpf_trampoline().  When the instructions
> accounted in  arch_bpf_trampoline_size() is less than the number of
> instructions emitted during the actual JIT compile of the trampoline,
> the below warning is produced:
>
>    WARNING: CPU: 8 PID: 204190 at arch/powerpc/net/bpf_jit_comp.c:981 __arch_prepare_bpf_trampoline.isra.0+0xd2c/0xdcc
>
> which is:
>
>    /* Make sure the trampoline generation logic doesn't overflow */
>    if (image && WARN_ON_ONCE(&image[ctx->idx] >
>    			(u32 *)rw_image_end - BPF_INSN_SAFETY)) {
>
> So, during the dummy pass, instead of providing some arbitrary image
> location, account for maximum possible instructions if and when there
> is a dependency with image location for JIT'ing.
>
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6168bfc8-659f-4b5a-a6fb-90a916dde3b3@linux.ibm.com/
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> Changes since v1:
> - Pass NULL for image during intial pass and account for max. possible
>    instruction during this pass as Naveen suggested.
>
>
>   arch/powerpc/net/bpf_jit.h        | 20 ++++++++++++++++---
>   arch/powerpc/net/bpf_jit_comp.c   | 33 ++++++++++---------------------
>   arch/powerpc/net/bpf_jit_comp64.c |  9 +++++++++
>   3 files changed, 36 insertions(+), 26 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 6beacaec63d3..4c26912c2e3c 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -51,8 +51,16 @@
>   		EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));					\
>   	} while (0)
>   
> -/* Sign-extended 32-bit immediate load */
> +/*
> + * Sign-extended 32-bit immediate load
> + *
> + * If this is a dummy pass (!image), account for
> + * maximum possible instructions.
> + */
>   #define PPC_LI32(d, i)		do {					      \
> +	if (!image)							      \
> +		ctx->idx += 2;						      \
> +	else {								      \
>   		if ((int)(uintptr_t)(i) >= -32768 &&			      \
>   				(int)(uintptr_t)(i) < 32768)		      \
>   			EMIT(PPC_RAW_LI(d, i));				      \
> @@ -60,10 +68,15 @@
>   			EMIT(PPC_RAW_LIS(d, IMM_H(i)));			      \
>   			if (IMM_L(i))					      \
>   				EMIT(PPC_RAW_ORI(d, d, IMM_L(i)));	      \
> -		} } while(0)
> +		}							      \
> +	} } while (0)
>   
>   #ifdef CONFIG_PPC64
> +/* If dummy pass (!image), account for maximum possible instructions */
>   #define PPC_LI64(d, i)		do {					      \
> +	if (!image)							      \
> +		ctx->idx += 5;						      \
> +	else {								      \
>   		if ((long)(i) >= -2147483648 &&				      \
>   				(long)(i) < 2147483648)			      \
>   			PPC_LI32(d, i);					      \
> @@ -84,7 +97,8 @@
>   			if ((uintptr_t)(i) & 0x000000000000ffffULL)	      \
>   				EMIT(PPC_RAW_ORI(d, d, (uintptr_t)(i) &       \
>   							0xffff));             \
> -		} } while (0)
> +		}							      \
> +	} } while (0)
>   #define PPC_LI_ADDR	PPC_LI64
>   
>   #ifndef CONFIG_PPC_KERNEL_PCREL
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 2991bb171a9b..c0684733e9d6 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -504,10 +504,11 @@ static int invoke_bpf_prog(u32 *image, u32 *ro_image, struct codegen_context *ct
>   	EMIT(PPC_RAW_ADDI(_R3, _R1, regs_off));
>   	if (!p->jited)
>   		PPC_LI_ADDR(_R4, (unsigned long)p->insnsi);
> -	if (!create_branch(&branch_insn, (u32 *)&ro_image[ctx->idx], (unsigned long)p->bpf_func,
> -			   BRANCH_SET_LINK)) {
> -		if (image)
> -			image[ctx->idx] = ppc_inst_val(branch_insn);
> +	/* Account for max possible instructions during dummy pass for size calculation */
> +	if (image && !create_branch(&branch_insn, (u32 *)&ro_image[ctx->idx],
> +				    (unsigned long)p->bpf_func,
> +				    BRANCH_SET_LINK)) {
> +		image[ctx->idx] = ppc_inst_val(branch_insn);
>   		ctx->idx++;
>   	} else {
>   		EMIT(PPC_RAW_LL(_R12, _R25, offsetof(struct bpf_prog, bpf_func)));
> @@ -889,7 +890,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   			bpf_trampoline_restore_tail_call_cnt(image, ctx, func_frame_offset, r4_off);
>   
>   		/* Reserve space to patch branch instruction to skip fexit progs */
> -		im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
> +		if (ro_image) /* image is NULL for dummy pass */
> +			im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
>   		EMIT(PPC_RAW_NOP());
>   	}
>   
> @@ -912,7 +914,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   		}
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
> +		if (ro_image) /* image is NULL for dummy pass */
> +			im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
>   		PPC_LI_ADDR(_R3, im);
>   		ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
>   						 (unsigned long)__bpf_tramp_exit);
> @@ -973,25 +976,9 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   			     struct bpf_tramp_links *tlinks, void *func_addr)
>   {
>   	struct bpf_tramp_image im;
> -	void *image;
>   	int ret;
>   
> -	/*
> -	 * Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> -	 * This will NOT cause fragmentation in direct map, as we do not
> -	 * call set_memory_*() on this buffer.
> -	 *
> -	 * We cannot use kvmalloc here, because we need image to be in
> -	 * module memory range.
> -	 */
> -	image = bpf_jit_alloc_exec(PAGE_SIZE);
> -	if (!image)
> -		return -ENOMEM;
> -
> -	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
> -					    m, flags, tlinks, func_addr);
> -	bpf_jit_free_exec(image);
> -
> +	ret = __arch_prepare_bpf_trampoline(&im, NULL, NULL, NULL, m, flags, tlinks, func_addr);
>   	return ret;
>   }
>   
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 233703b06d7c..91f9efe8b8d7 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -225,6 +225,15 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   	}
>   
>   #ifdef CONFIG_PPC_KERNEL_PCREL
> +	/*
> +	 * If fimage is NULL (the initial pass to find image size),
> +	 * account for the maximum no. of instructions possible.
> +	 */
> +	if (!fimage) {
> +		ctx->idx += 7;
> +		return 0;
> +	}
> +
>   	reladdr = func_addr - local_paca->kernelbase;
>   
>   	if (reladdr < (long)SZ_8G && reladdr >= -(long)SZ_8G) {


Above patch fixes the reported issue. Ran the test( ./test_progs) for 
three times, and issue is not seen. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



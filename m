Return-Path: <bpf+bounces-54752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C799FA71876
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39252168DCC
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8D21EBFE6;
	Wed, 26 Mar 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G0k3uA9y"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0CF4A29;
	Wed, 26 Mar 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999243; cv=none; b=XpYId4M56QIk93rflHFN2OeGvIWlzXfRNEeGUDPI7tltUR3gh8U3ssmYqhRb8vb0TOjpaxUbQDqIQg6Y/9PuyqzF8DlYNWbxiZpYCMLZ9zReOE4SkwF8E6gdOJEDb+QMoRgG+JJnzuwGaA7EGRl26uJ0mnbmsD9F/2a22PcNuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999243; c=relaxed/simple;
	bh=/ZTYXxLZLmI/3Zl22WN5QwsezgsJ7SdB97yP/oUhulc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bIqfhfIJ+HmFleVM32AFBDVxXDVPL+8s26ikxjWa1qMIvRR3n+GOPyESPy5xvrsnJlcP3UHtcCM7UkxK+scF21c1cwKUK1zXg4SX0d+8U1Rbe0ebV9BSpD8h4mXyZLM0gjBfbvNuBRUalQndAjQLpqmt1YOwz5sMVMnQSK+xATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G0k3uA9y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QE3GX9007910;
	Wed, 26 Mar 2025 14:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DttbU1
	mhrlgqDl7CIiI442+YIwV7ZeTeOKpje6c5Vaw=; b=G0k3uA9yfRA1ZE7UFxx7ff
	7lz7upYes5Wz9m6I2ofOZEz9CZ+jirYBMVlSrMzDzEDKzX6NoMysTMAciKgayogZ
	YgZjEQuDvWWeXU+2tXC555UMVCP711u9ovugmEHofROo4aDFjoOob5HxXnlttQ5f
	B5HP9H7RHV+pkYiKmm8O7XGGPANRs4/Dr1/QSdZ7G0e+Sd4iW1kLdrdLveOtWsGQ
	Uqe20G0OEOAzOQ+MJKHKo+CfsXsAGRRoaK2Upm3NI93dxrwJQ4akddHRK0GKyinh
	GxWxJA1LOh7a3k6QJ82UHJLWJICJtB7itDjEr74eAt0PCvSMpsNQ2OdDJAXpWSvg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mk0q8512-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:26:56 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QEJePi017476;
	Wed, 26 Mar 2025 14:26:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mk0q84yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:26:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QDXdg0030330;
	Wed, 26 Mar 2025 14:26:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htgwq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:26:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QEQahQ46793170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 14:26:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38D0E2004B;
	Wed, 26 Mar 2025 14:26:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DC0020040;
	Wed, 26 Mar 2025 14:26:33 +0000 (GMT)
Received: from [9.43.113.131] (unknown [9.43.113.131])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 14:26:33 +0000 (GMT)
Message-ID: <f1ff432f-a807-4d78-9687-589f3bc2e962@linux.ibm.com>
Date: Wed, 26 Mar 2025 19:56:27 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc64/bpf: fix JIT code size calculation of bpf
 trampoline
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, stable@vger.kernel.org
References: <20250326120800.1141056-1-hbathini@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250326120800.1141056-1-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vWbU4eSWyMp8C3NN4h0Gev7zBSHcjT4a
X-Proofpoint-ORIG-GUID: gjnpnOiFYqAorgHbwl-PVJXW4BgABysh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=742 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260088



On 26/03/25 5:38 pm, Hari Bathini wrote:
> The JIT compile of ldimm instructions can be anywhere between 1-5
> instructions long depending on the value being loaded.
> 
> arch_bpf_trampoline_size() provides JIT size of the BPF trampoline
> before the buffer for JIT'ing it is allocated. BPF trampoline JIT
> code has ldimm instructions that need to load the value of pointer
> to struct bpf_tramp_image. But this pointer value is not same while
> calling arch_bpf_trampoline_size() & arch_prepare_bpf_trampoline().
> So, the size arrived at using arch_bpf_trampoline_size() can vary
> from the size needed in arch_prepare_bpf_trampoline(). When the
> number of ldimm instructions emitted in arch_bpf_trampoline_size()
> is less than the number of ldimm instructions emitted during the
> actual JIT compile of trampoline, the below warning is produced:
> 
>    WARNING: CPU: 8 PID: 204190 at arch/powerpc/net/bpf_jit_comp.c:981 __arch_prepare_bpf_trampoline.isra.0+0xd2c/0xdcc
> 
> which is:
> 
>    /* Make sure the trampoline generation logic doesn't overflow */
>    if (image && WARN_ON_ONCE(&image[ctx->idx] >
> 			(u32 *)rw_image_end - BPF_INSN_SAFETY)) {
> 
> Pass NULL as the first argument to __arch_prepare_bpf_trampoline()
> call from arch_bpf_trampoline_size() function, to differentiate it
> from how arch_prepare_bpf_trampoline() calls it and ensure maximum
> possible instructions are emitted in arch_bpf_trampoline_size() for
> ldimm instructions that load a different value during the actual JIT
> compile of BPF trampoline.
> 
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6168bfc8-659f-4b5a-a6fb-90a916dde3b3@linux.ibm.com/
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 31 ++++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 2991bb171a9b..49d7e9a8d17c 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -686,7 +686,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   	 *                              [                   ] --
>   	 * LR save area                 [ r0 save (64-bit)  ]   | header
>   	 *                              [ r0 save (32-bit)  ]   |

> -	 * dummy frame for unwind       [ back chain 1      ] --
> +	 /* dummy frame for unwind       [ back chain 1      ] --

Sorry. a redundant '/' there.
Will resend..

>   	 *                              [ padding           ] align stack frame
>   	 *       r4_off                 [ r4 (tailcallcnt)  ] optional - 32-bit powerpc
>   	 *       alt_lr_off             [ real lr (ool stub)] optional - actual lr
> @@ -833,7 +833,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   	EMIT(PPC_RAW_STL(_R26, _R1, nvr_off + SZL));
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		PPC_LI_ADDR(_R3, (unsigned long)im);
> +		/*
> +		 * Emit maximum possible instructions while getting the size of
> +		 * bpf trampoline to ensure trampoline JIT code doesn't overflow.
> +		 */
> +		PPC_LI_ADDR(_R3, im ? (unsigned long)im :
> +				(unsigned long)(~(1UL << (BITS_PER_LONG - 1))));
>   		ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
>   						 (unsigned long)__bpf_tramp_enter);
>   		if (ret)
> @@ -889,7 +894,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   			bpf_trampoline_restore_tail_call_cnt(image, ctx, func_frame_offset, r4_off);
>   
>   		/* Reserve space to patch branch instruction to skip fexit progs */
> -		im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
> +		if (im)
> +			im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
>   		EMIT(PPC_RAW_NOP());
>   	}
>   
> @@ -912,8 +918,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   		}
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
> -		PPC_LI_ADDR(_R3, im);
> +		if (im)
> +			im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
> +		/*
> +		 * Emit maximum possible instructions while getting the size of
> +		 * bpf trampoline to ensure trampoline JIT code doesn't overflow.
> +		 */
> +		PPC_LI_ADDR(_R3, im ? (unsigned long)im :
> +				(unsigned long)(~(1UL << (BITS_PER_LONG - 1))));
>   		ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
>   						 (unsigned long)__bpf_tramp_exit);
>   		if (ret)
> @@ -972,7 +984,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   			     struct bpf_tramp_links *tlinks, void *func_addr)
>   {
> -	struct bpf_tramp_image im;
>   	void *image;
>   	int ret;
>   
> @@ -988,7 +999,13 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   	if (!image)
>   		return -ENOMEM;
>   
> -	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
> +	/*
> +	 * Pass NULL as bpf_tramp_image pointer to differentiate the intent to get the
> +	 * buffer size for trampoline here. This differentiation helps in accounting for
> +	 * maximum possible instructions if the JIT code size is likely to vary during
> +	 * the actual JIT compile of the trampoline.
> +	 */
> +	ret = __arch_prepare_bpf_trampoline(NULL, image, image + PAGE_SIZE, image,
>   					    m, flags, tlinks, func_addr);
>   	bpf_jit_free_exec(image);
>   



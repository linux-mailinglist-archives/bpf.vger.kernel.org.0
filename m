Return-Path: <bpf+bounces-55382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3364A7D453
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 08:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF523AAD2A
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 06:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F362253EF;
	Mon,  7 Apr 2025 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AmuKN0rt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F152221DAB;
	Mon,  7 Apr 2025 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007982; cv=none; b=mRIDy6sw+Cjy8wa7u2cvUjUKOPuiRSiOnamVPEZ2AymNrp/L49FGUazGYAff3yfxPebIPjghviIebbAH6ihnwxkQo+aZbawjL36qPq0zSzv8fjePshtEEGJc5j6r8PGsNvclW3kqHMvL+EUy73J5BiJX5pv+3Ys3z+OFD8gtdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007982; c=relaxed/simple;
	bh=BowyC9nf9J2U86YpG/G87b2HyU4OcQEK07y7QJxMsSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eI5E6B+mur0s67CGmN9GJBR72JzCSycszXIisqMAG1BGzQPSYs+2hM3x2XoEusNCw+i8k1QWhjv14Z9/pN9loRJvloVMHdr2j3RY0Nb+Nz5RUTkGeNv2+bQAdHsjuwwJ8+nGpiDnTO9zrj2DvFD8s9p4ShVOsDGjSObcSVC17WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AmuKN0rt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 536E3IHj017563;
	Mon, 7 Apr 2025 06:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iYR6ek
	4pfv+/kDLkKB+1ikP67IGJ/jf+qLHsZFWG9oU=; b=AmuKN0rtH3n1i4MCD8peZQ
	sdjxPQOvQkvrfpWTZbsnzVJRlkp4SjemqhWOmyOmI+O+YXZ3OXJh8Xnz89BUQCFv
	2hVFLq6L2C0Ndyd7JIOAIfwsZd6vfd4ViGI/XBVppEKLH8tYjf+cVgwP8OnYtUv9
	GHw0morv8CmD5qJRq6KuxJKBUpwjF869JBtVYroPt5gR/lXj1rubYpN3XASgZyfn
	Gp5M5fr5qlpkAWJQIKXggxEZcgcvwa1kYVrN1IhVFCwm3QXkWB1IusZkyTBCG9vz
	SFLQM9VQ3KDeT91y7G93xmShzunJy8Bcl9arrgu5jQMGb2h/D5lvBIUVikCDWH2Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45uu1pjser-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 06:39:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5376RYab016375;
	Mon, 7 Apr 2025 06:39:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45uu1pjsen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 06:39:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5375YMC0013932;
	Mon, 7 Apr 2025 06:39:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufuncm78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 06:39:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5376d1E727197960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 06:39:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF5BD20043;
	Mon,  7 Apr 2025 06:39:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 448A120040;
	Mon,  7 Apr 2025 06:38:59 +0000 (GMT)
Received: from [9.203.115.62] (unknown [9.203.115.62])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Apr 2025 06:38:59 +0000 (GMT)
Message-ID: <fc929d7a-76e3-45f6-a05f-e77e9cc8e1aa@linux.ibm.com>
Date: Mon, 7 Apr 2025 12:08:57 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] powerpc64/bpf: fix JIT code size calculation of
 bpf trampoline
To: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, stable@vger.kernel.org
References: <20250326143422.1158383-1-hbathini@linux.ibm.com>
 <5ufbeu7staczxfhdd3uepqnkzxozlhxus2hfpxiiqllid2l4vs@n63eyfgosatl>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <5ufbeu7staczxfhdd3uepqnkzxozlhxus2hfpxiiqllid2l4vs@n63eyfgosatl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MDipPyJFmAbbBp8P3_sLBx1fSeAEK4PJ
X-Proofpoint-ORIG-GUID: s7VjZgcZkNfBQNywLOw8xGcDGSGor0OW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=976 spamscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504070045

Hi Naveen,

Thanks for the review.

On 03/04/25 9:15 pm, Naveen N Rao wrote:
> On Wed, Mar 26, 2025 at 08:04:22PM +0530, Hari Bathini wrote:
>> The JIT compile of ldimm instructions can be anywhere between 1-5
>> instructions long depending on the value being loaded.
>>
>> arch_bpf_trampoline_size() provides JIT size of the BPF trampoline
>> before the buffer for JIT'ing it is allocated. BPF trampoline JIT
>> code has ldimm instructions that need to load the value of pointer
>> to struct bpf_tramp_image. But this pointer value is not same while
>> calling arch_bpf_trampoline_size() & arch_prepare_bpf_trampoline().
>> So, the size arrived at using arch_bpf_trampoline_size() can vary
>> from the size needed in arch_prepare_bpf_trampoline(). When the
>> number of ldimm instructions emitted in arch_bpf_trampoline_size()
>> is less than the number of ldimm instructions emitted during the
>> actual JIT compile of trampoline, the below warning is produced:
>>
>>    WARNING: CPU: 8 PID: 204190 at arch/powerpc/net/bpf_jit_comp.c:981 __arch_prepare_bpf_trampoline.isra.0+0xd2c/0xdcc
>>
>> which is:
>>
>>    /* Make sure the trampoline generation logic doesn't overflow */
>>    if (image && WARN_ON_ONCE(&image[ctx->idx] >
>> 			(u32 *)rw_image_end - BPF_INSN_SAFETY)) {
>>
>> Pass NULL as the first argument to __arch_prepare_bpf_trampoline()
>> call from arch_bpf_trampoline_size() function, to differentiate it
>> from how arch_prepare_bpf_trampoline() calls it and ensure maximum
>> possible instructions are emitted in arch_bpf_trampoline_size() for
>> ldimm instructions that load a different value during the actual JIT
>> compile of BPF trampoline.
>>
>> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://lore.kernel.org/all/6168bfc8-659f-4b5a-a6fb-90a916dde3b3@linux.ibm.com/
>> Cc: stable@vger.kernel.org # v6.13+
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>
>> * Removed a redundant '/' accidently added in a comment and resending.
>>
>>   arch/powerpc/net/bpf_jit_comp.c | 29 +++++++++++++++++++++++------
>>   1 file changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
>> index 2991bb171a9b..c94717ccb2bd 100644
>> --- a/arch/powerpc/net/bpf_jit_comp.c
>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>> @@ -833,7 +833,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>>   	EMIT(PPC_RAW_STL(_R26, _R1, nvr_off + SZL));
>>   
>>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>> -		PPC_LI_ADDR(_R3, (unsigned long)im);
>> +		/*
>> +		 * Emit maximum possible instructions while getting the size of
>> +		 * bpf trampoline to ensure trampoline JIT code doesn't overflow.
>> +		 */
>> +		PPC_LI_ADDR(_R3, im ? (unsigned long)im :
>> +				(unsigned long)(~(1UL << (BITS_PER_LONG - 1))));
> 
> We generally rely on  a NULL 'image' to detect a dummy pass. See commit
> d3921cbb6cd6 ("powerpc/bpf: Only pad length-variable code at initial
> pass"), for instance. Have you considered updating PPC_LI64() and
> PPC_LI32() to simply emit a fixed number of nops if image is NULL?

Did want to use image as NULL for the dummy pass but decided to do it
as a clean up later with bpf_jit_emit_func_call_rel(), PPC_LI64(),
PPC_LI32() and create_branch() needing it. But on second thoughts,
we are probably better off by accounting for max possible instructions
for all those cases (in the dummy pass) as part of this fix itself.
Will send a V2 soon...

Thanks
Hari


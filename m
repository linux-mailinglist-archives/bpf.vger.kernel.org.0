Return-Path: <bpf+bounces-41559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274229982B5
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0381F21CB1
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830AD33CE8;
	Thu, 10 Oct 2024 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c85pzuTy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F071A0AF1;
	Thu, 10 Oct 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553623; cv=none; b=bVRpo/JbIyAwELkItjBtFLAXEY00v1Hq5vIUfRGL1su61pQpWsUmvcF6iZsLlNWWzHjSp+DaTG3eWM9q2/BPNv7+T9m6edeKZ+nd7kPePoSfkBiF8e4nHgDP4772TCi/qmYumEDjqZU801js/CzkfQF9c5gE6y63Soa6EI4UWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553623; c=relaxed/simple;
	bh=aB2O6RLTiOfYNuP04p1EnaHo4E4PRsZTJTz7/htV9V4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQiOaAfUj4891Oyn1Yhe3dwv4oP3f4RBMsoZJR34QAKjv+cYdOTMQpigmCIM85lDuSTT3xPkS+HeOub4S4ahs0Kk/fYsBtvl8OnD/KmRuLCP0NgDF/catP158N9dAkEfcMo4Cpill64yIY2MG0M92zvk29oTLQywkT2GXiCeNP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c85pzuTy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A9JVPg000410;
	Thu, 10 Oct 2024 09:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	BterrWOXz6RbsFdUQwzWlQ/tsGwOKvoD4Fd5Pc0Z+M0=; b=c85pzuTyvH/E6pWK
	he9hJdKudrRjZCkNyt8bT2Vx/o/n9fJAoprHFOLdYyIhVhOCiKWnpfRUt+WUHxJc
	/S8oX6c/2A3FRYmHD7mdRoORHSMinaH41kM7qVX71KtqFZS8F03vBWz0VK0DYlkl
	V5838FNLR6n/SpRHWlIs+ui9fvU/3q4tETEFtNWJJMiFUnp8b7PCnHnQyP5zW3Bo
	2xlf8d0He8CmGe0D50RVKY5oV5vPaI8pmAo69VyOJ9COh0nqC6UHbG8ByTXRZiV2
	g3YRA6KFy9nZE7glqqAJG2+KBow6D8T6C216HxRbpnEsIv3ePSwN6TOCbSOmz6or
	xnTRxw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426c6fr436-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 09:46:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A9fcnh013158;
	Thu, 10 Oct 2024 09:46:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426c6fr432-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 09:46:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A9T3fE022632;
	Thu, 10 Oct 2024 09:46:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9k6x26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 09:46:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49A9kMGF40305150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 09:46:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D92620040;
	Thu, 10 Oct 2024 09:46:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53B052004E;
	Thu, 10 Oct 2024 09:46:17 +0000 (GMT)
Received: from [9.43.111.131] (unknown [9.43.111.131])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Oct 2024 09:46:17 +0000 (GMT)
Message-ID: <a00df08a-605f-41c9-ba0d-2060e0d1e8b4@linux.ibm.com>
Date: Thu, 10 Oct 2024 15:16:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/17] powerpc64/bpf: Add support for bpf trampolines
From: Hari Bathini <hbathini@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf <bpf@vger.kernel.org>,
        linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Naveen N. Rao" <naveen@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20240915205648.830121-1-hbathini@linux.ibm.com>
 <20240915205648.830121-18-hbathini@linux.ibm.com>
 <CAADnVQL60XXW95tgwKn3kVgSQAN7gr1STy=APuO1xQD7mz-aXA@mail.gmail.com>
 <32249e74-633d-4757-8931-742b682a63d3@linux.ibm.com>
 <CAADnVQKfSH_zkP0-TwOB_BLxCBH9efot9mk03uRuooCTMmWnWA@mail.gmail.com>
 <7afc9cc7-95cd-45c7-b748-28040206d9a0@linux.ibm.com>
 <CAADnVQJjqnSVqq2n70-uqfrYRHH3n=5s9=t3D2AMooxxAHYfJQ@mail.gmail.com>
 <875xq07qv6.fsf@mail.lhotse>
 <28d39117-c512-4165-b082-4ca54da7ba6c@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <28d39117-c512-4165-b082-4ca54da7ba6c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4BZXRvYqLwjtB52HRBSl84dnnhbmreHK
X-Proofpoint-GUID: KRtK3293tfzCxCEIysNW578ME7sT4khl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_05,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100062



On 10/10/24 3:09 pm, Hari Bathini wrote:
> 
> 
> On 10/10/24 5:48 am, Michael Ellerman wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>> On Tue, Oct 1, 2024 at 12:18 AM Hari Bathini <hbathini@linux.ibm.com> 
>>> wrote:
>>>> On 30/09/24 6:25 pm, Alexei Starovoitov wrote:
>>>>> On Sun, Sep 29, 2024 at 10:33 PM Hari Bathini 
>>>>> <hbathini@linux.ibm.com> wrote:
>>>>>> On 17/09/24 1:20 pm, Alexei Starovoitov wrote:
>>>>>>> On Sun, Sep 15, 2024 at 10:58 PM Hari Bathini 
>>>>>>> <hbathini@linux.ibm.com> wrote:
>>>>>>>>
>>>>>>>> +
>>>>>>>> +       /*
>>>>>>>> +        * Generated stack layout:
>>>>>>>> +        *
>>>>>>>> +        * func prev back chain         [ back chain        ]
>>>>>>>> +        *                              [                   ]
>>>>>>>> +        * bpf prog redzone/tailcallcnt [ ...               ] 64 
>>>>>>>> bytes (64-bit powerpc)
>>>>>>>> +        *                              [                   ] --
>>>>>>> ...
>>>>>>>> +
>>>>>>>> +       /* Dummy frame size for proper unwind - includes 64- 
>>>>>>>> bytes red zone for 64-bit powerpc */
>>>>>>>> +       bpf_dummy_frame_size = STACK_FRAME_MIN_SIZE + 64;
>>>>>>>
>>>>>>> What is the goal of such a large "red zone" ?
>>>>>>> The kernel stack is a limited resource.
>>>>>>> Why reserve 64 bytes ?
>>>>>>> tail call cnt can probably be optional as well.
>>>>>>
>>>>>> Hi Alexei, thanks for reviewing.
>>>>>> FWIW, the redzone on ppc64 is 288 bytes. BPF JIT for ppc64 was using
>>>>>> a redzone of 80 bytes since tailcall support was introduced [1].
>>>>>> It came down to 64 bytes thanks to [2]. The red zone is being used
>>>>>> to save NVRs and tail call count when a stack is not setup. I do
>>>>>> agree that we should look at optimizing it further. Do you think
>>>>>> the optimization should go as part of PPC64 trampoline enablement
>>>>>> being done here or should that be taken up as a separate item, maybe?
>>>>>
>>>>> The follow up is fine.
>>>>> It just odd to me that we currently have:
>>>>>
>>>>> [   unused red zone ] 208 bytes protected
>>>>>
>>>>> I simply don't understand why we need to waste this much stack space.
>>>>> Why can't it be zero today ?
>>>>
>>>> The ABI for ppc64 has a redzone of 288 bytes below the current
>>>> stack pointer that can be used as a scratch area until a new
>>>> stack frame is created. So, no wastage of stack space as such.
>>>> It is just red zone that can be used before a new stack frame
>>>> is created. The comment there is only to show how redzone is
>>>> being used in ppc64 BPF JIT. I think the confusion is with the
>>>> mention of "208 bytes" as protected. As not all of that scratch
>>>> area is used, it mentions the remaining as unused. Essentially
>>>> 288 bytes below current stack pointer is protected from debuggers
>>>> and interrupt code (red zone). Note that it should be 224 bytes
>>>> of unused red zone instead of 208 bytes as red zone usage in
>>>> ppc64 BPF JIT come down from 80 bytes to 64 bytes since [2].
>>>> Hope that clears the misunderstanding..
>>>
>>> I see. That makes sense. So it's similar to amd64 red zone,
>>> but there we have an issue with irqs, hence the kernel is
>>> compiled with -mno-red-zone.
>>
>> I assume that issue is that the interrupt entry unconditionally writes
>> some data below the stack pointer, disregarding the red zone?
>>
>>> I guess ppc always has a different interrupt stack and
>>> it's not an issue?
>>
>> No, the interrupt entry allocates a frame that is big enough to cover
>> the red zone as well as the space it needs to save registers.
>>
>> See STACK_INT_FRAME_SIZE which includes KERNEL_REDZONE_SIZE:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 
>> tree/arch/powerpc/include/asm/ptrace.h? 
>> commit=8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b#n165
>>
>> Which is renamed to INT_FRAME_SIZE in asm-offsets.c and then is used in
>> the interrupt entry here:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 
>> tree/arch/powerpc/kernel/exceptions-64s.S? 
>> commit=8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b#n497
> 
> Thanks for clarifying that, Michael.
> Only async interrupt handlers use different interrupt stacks, right?

... and separate emergency stack for some special cases...

Thanks
Hari


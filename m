Return-Path: <bpf+bounces-40813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A742798E966
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 07:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171F6B23DEA
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 05:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D903C463;
	Thu,  3 Oct 2024 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nKnywCZN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C82232A;
	Thu,  3 Oct 2024 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933701; cv=none; b=TnZAlFRTfhh+8tTpPcj26KOl6U55mg4yTljMVhxQhnvBNBcS7XXbeh2sNjrLl7jxjBgpd+BE1SDqEtXKnErb+8T1vI+VHtW6ToN6eVPvBOQXpmBzvi277Hp+nXxLddnG3p8/zkL3K7mzNiimI5/QRikuqWajZjd0L3IsD96WN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933701; c=relaxed/simple;
	bh=ypy85dcDy01BH1W/Dxx238ctF+Gv2SOQmYIlzDayQXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTA/q2zDeL+ZgLPFwyhgy54xBl1nLO82v97ifw+tlDCrpxYkhmXkjc6X/5ZztPw4o6MY92vNFWrFkW0QuTpegBxkRaR5juR7UoKCzXYWuBDztN9YPdYSCwAC8Ret4Pu7EREcFDxgSfksgiROkB8lfi3r/2OOhbECihozwihvAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nKnywCZN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4935NeYB029655;
	Thu, 3 Oct 2024 05:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=D
	U2EVq/dJRHq3kbfnrGZl+Z6bZudmAtCY8KaXHsKQKU=; b=nKnywCZNvHuWuJeNp
	JvE0Noncqn8uGVyji3dy61l31fH4SBnGRHLx5cy//eCoTlz8j2RsdBEd8RoYszp3
	GwNWgerApi3F3VllB30HglkF0KIznGE2zBjW9Rx4NLpKF4O4Aq8HA6RUtAd1rqAB
	G7GWUjfSjLIiN/R3/yREVa05TYXXvWnBL1RjSoOKB3BAYQoLYlsPVbRpdi/ULF4f
	M4IOMuZEzJaIe9tqJz1VYx4Js6qqgB+dGhC0aBrHv82GppxSoNnf89ppRoFaddIN
	9qaVkifnlXhgUKJsVZGPRPSuuo0B4cnWjBRxjE03F2jhYKLr8YAGtJfUyUMTfXX3
	5lf5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421n2q00xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 05:34:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4935Y0mG021923;
	Thu, 3 Oct 2024 05:34:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421n2q00xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 05:34:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49313JW6013047;
	Thu, 3 Oct 2024 05:33:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbjny5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 05:33:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4935Xu4M53477772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 05:33:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 306CC2004B;
	Thu,  3 Oct 2024 05:33:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E5E20040;
	Thu,  3 Oct 2024 05:33:52 +0000 (GMT)
Received: from [9.43.34.175] (unknown [9.43.34.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Oct 2024 05:33:52 +0000 (GMT)
Message-ID: <0b10ef55-bb70-4000-b028-2f38c1879b4a@linux.ibm.com>
Date: Thu, 3 Oct 2024 11:03:51 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/17] powerpc64/bpf: Add support for bpf trampolines
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAADnVQJjqnSVqq2n70-uqfrYRHH3n=5s9=t3D2AMooxxAHYfJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nfk4x77q3uIih6IxVoMQw5vL6RKfZNVa
X-Proofpoint-ORIG-GUID: AOTm3W-XTbmLTZO3OzmfxPQdAdP4Ygbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_04,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=907 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030035



On 01/10/24 8:23 pm, Alexei Starovoitov wrote:
> On Tue, Oct 1, 2024 at 12:18 AM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>
>>
>>
>> On 30/09/24 6:25 pm, Alexei Starovoitov wrote:
>>> On Sun, Sep 29, 2024 at 10:33 PM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 17/09/24 1:20 pm, Alexei Starovoitov wrote:
>>>>> On Sun, Sep 15, 2024 at 10:58 PM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>>>>>
>>>>>> +
>>>>>> +       /*
>>>>>> +        * Generated stack layout:
>>>>>> +        *
>>>>>> +        * func prev back chain         [ back chain        ]
>>>>>> +        *                              [                   ]
>>>>>> +        * bpf prog redzone/tailcallcnt [ ...               ] 64 bytes (64-bit powerpc)
>>>>>> +        *                              [                   ] --
>>>>> ...
>>>>>> +
>>>>>> +       /* Dummy frame size for proper unwind - includes 64-bytes red zone for 64-bit powerpc */
>>>>>> +       bpf_dummy_frame_size = STACK_FRAME_MIN_SIZE + 64;
>>>>>
>>>>> What is the goal of such a large "red zone" ?
>>>>> The kernel stack is a limited resource.
>>>>> Why reserve 64 bytes ?
>>>>> tail call cnt can probably be optional as well.
>>>>
>>>> Hi Alexei, thanks for reviewing.
>>>> FWIW, the redzone on ppc64 is 288 bytes. BPF JIT for ppc64 was using
>>>> a redzone of 80 bytes since tailcall support was introduced [1].
>>>> It came down to 64 bytes thanks to [2]. The red zone is being used
>>>> to save NVRs and tail call count when a stack is not setup. I do
>>>> agree that we should look at optimizing it further. Do you think
>>>> the optimization should go as part of PPC64 trampoline enablement
>>>> being done here or should that be taken up as a separate item, maybe?
>>>
>>> The follow up is fine.
>>> It just odd to me that we currently have:
>>>
>>> [   unused red zone ] 208 bytes protected
>>>
>>> I simply don't understand why we need to waste this much stack space.
>>> Why can't it be zero today ?
>>>
>>
>> The ABI for ppc64 has a redzone of 288 bytes below the current
>> stack pointer that can be used as a scratch area until a new
>> stack frame is created. So, no wastage of stack space as such.
>> It is just red zone that can be used before a new stack frame
>> is created. The comment there is only to show how redzone is
>> being used in ppc64 BPF JIT. I think the confusion is with the
>> mention of "208 bytes" as protected. As not all of that scratch
>> area is used, it mentions the remaining as unused. Essentially
>> 288 bytes below current stack pointer is protected from debuggers
>> and interrupt code (red zone). Note that it should be 224 bytes
>> of unused red zone instead of 208 bytes as red zone usage in
>> ppc64 BPF JIT come down from 80 bytes to 64 bytes since [2].
>> Hope that clears the misunderstanding..
> 
> I see. That makes sense. So it's similar to amd64 red zone,
> but there we have an issue with irqs, hence the kernel is
> compiled with -mno-red-zone.
> 
> I guess ppc always has a different interrupt stack and
> it's not an issue?

Yeah. On ppc64, kernel also uses redzone.
Interrupts use a different stack..

Thanks
Hari



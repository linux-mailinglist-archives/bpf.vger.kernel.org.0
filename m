Return-Path: <bpf+bounces-40650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9B98B556
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 09:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E8728295A
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 07:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A161BD035;
	Tue,  1 Oct 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UhhulmnP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921323307B;
	Tue,  1 Oct 2024 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767180; cv=none; b=Cz6i5mqJlV4dIb1nouU7Maf6dM6VbruBA27XclqZ4lY6T4VZTbGSPMVv9TV0t1IDoHnl+2RpbSKGABxbOUS2udU5ZggKArgdVFlNcfVM1cJhKVR27601E5D7QFSQKxB/q7KM4bwL/O+H4LVD1KJJnLBqcs1YA/TIqECXARBMdU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767180; c=relaxed/simple;
	bh=n01BNZbF9ejiB2KdEN2OeP8SsSt6kV6tDAX9IasD2yo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fB61RRR9GnXvwlI9sE5PIHfDssw1m/xE3ZVWRXxW+CCgnZMIrwEfsZ2alj1EiGSpq7SrTwlq0J4ZYV3zEKr9rsbBAlDiO0XI57Vqk4GlrjZFi6z9Tnh4o3XqLzWgI7qj2oW9/MMdVQ+ojFaKiNXYLtxXQvpEY/TCz2kDRoAxZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UhhulmnP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4916L9ex011324;
	Tue, 1 Oct 2024 07:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	nVeO7YF2qI6ks2gsAqC/25H4gdCxGkd3m/X2UTY0ILY=; b=UhhulmnPyVi7zDDc
	MiYTsb4EjCA9S5khRljvKZZFH+E7fNMDN/hsqh3bppnsfIWUAQWeIQoheidbuzTC
	C9587f7+VgsgnppBNvYrGnbRho16NiNMkAKA0n6LyMqRB4vc0khuf3l5NxfaZfXg
	WuUMnEPcuRphLF0t7r/yv+NXtuXgsGJkF9AQYHAgmlJxBNJ+zbjRp+UBpaVakpBQ
	phraW1hlwDGw57HpLVSjA1zTEeYKNHpJn/WsiAQbqakshqgizGwfNKnMCdR/g5Gz
	lBgL1rYbPDmJGd50Mw+lqiJXd8WkqOqPSNBlnbW6uQIWdMLcV/HqDCoxQAGB2VLP
	I7sPig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420bqs08jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 07:18:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4917IgPY005898;
	Tue, 1 Oct 2024 07:18:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420bqs08jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 07:18:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4915MFix007994;
	Tue, 1 Oct 2024 07:18:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxu0xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 07:18:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4917IbaV50332034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 07:18:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88C8820040;
	Tue,  1 Oct 2024 07:18:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E6E320043;
	Tue,  1 Oct 2024 07:18:33 +0000 (GMT)
Received: from [9.203.115.143] (unknown [9.203.115.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 07:18:33 +0000 (GMT)
Message-ID: <7afc9cc7-95cd-45c7-b748-28040206d9a0@linux.ibm.com>
Date: Tue, 1 Oct 2024 12:48:32 +0530
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
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAADnVQKfSH_zkP0-TwOB_BLxCBH9efot9mk03uRuooCTMmWnWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SM-pZFexbR8K0U23khEKm2Gk2BFix6Vn
X-Proofpoint-ORIG-GUID: o8_9c23Vj1cySEYDs0mB8nQmYzb-zRAw
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
 definitions=2024-10-01_04,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxlogscore=950
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010048



On 30/09/24 6:25 pm, Alexei Starovoitov wrote:
> On Sun, Sep 29, 2024 at 10:33 PM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>
>>
>>
>> On 17/09/24 1:20 pm, Alexei Starovoitov wrote:
>>> On Sun, Sep 15, 2024 at 10:58 PM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>>>
>>>> +
>>>> +       /*
>>>> +        * Generated stack layout:
>>>> +        *
>>>> +        * func prev back chain         [ back chain        ]
>>>> +        *                              [                   ]
>>>> +        * bpf prog redzone/tailcallcnt [ ...               ] 64 bytes (64-bit powerpc)
>>>> +        *                              [                   ] --
>>> ...
>>>> +
>>>> +       /* Dummy frame size for proper unwind - includes 64-bytes red zone for 64-bit powerpc */
>>>> +       bpf_dummy_frame_size = STACK_FRAME_MIN_SIZE + 64;
>>>
>>> What is the goal of such a large "red zone" ?
>>> The kernel stack is a limited resource.
>>> Why reserve 64 bytes ?
>>> tail call cnt can probably be optional as well.
>>
>> Hi Alexei, thanks for reviewing.
>> FWIW, the redzone on ppc64 is 288 bytes. BPF JIT for ppc64 was using
>> a redzone of 80 bytes since tailcall support was introduced [1].
>> It came down to 64 bytes thanks to [2]. The red zone is being used
>> to save NVRs and tail call count when a stack is not setup. I do
>> agree that we should look at optimizing it further. Do you think
>> the optimization should go as part of PPC64 trampoline enablement
>> being done here or should that be taken up as a separate item, maybe?
> 
> The follow up is fine.
> It just odd to me that we currently have:
> 
> [   unused red zone ] 208 bytes protected
> 
> I simply don't understand why we need to waste this much stack space.
> Why can't it be zero today ?
> 

The ABI for ppc64 has a redzone of 288 bytes below the current
stack pointer that can be used as a scratch area until a new
stack frame is created. So, no wastage of stack space as such.
It is just red zone that can be used before a new stack frame
is created. The comment there is only to show how redzone is
being used in ppc64 BPF JIT. I think the confusion is with the
mention of "208 bytes" as protected. As not all of that scratch
area is used, it mentions the remaining as unused. Essentially
288 bytes below current stack pointer is protected from debuggers
and interrupt code (red zone). Note that it should be 224 bytes
of unused red zone instead of 208 bytes as red zone usage in
ppc64 BPF JIT come down from 80 bytes to 64 bytes since [2].
Hope that clears the misunderstanding..

>> [1]
>> https://lore.kernel.org/all/40b65ab2bb3a48837ab047a70887de3ccd70c56b.1474661927.git.naveen.n.rao@linux.vnet.ibm.com/
>> [2] https://lore.kernel.org/all/20180503230824.3462-11-daniel@iogearbox.net/
>>

Thanks
Hari


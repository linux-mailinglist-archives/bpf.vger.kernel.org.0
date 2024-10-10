Return-Path: <bpf+bounces-41560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89FA9982F9
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7DA1F21034
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 09:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC81BDA9B;
	Thu, 10 Oct 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UOwMQKqp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA41BD4FD;
	Thu, 10 Oct 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554226; cv=none; b=OfA8+5HcrGeJnOsTaLzOXo/an1JYK+mRc+i91N4+IvtZVbm5lQYNwGwVb+vQ4cc3Pl2yOAcvRaX/+twqHj7btnDS+dKzYNwns5EwqeNq9GOgsxpi7udlSb6u5EDVPTMHVt5b0RLuNADe2/NcfqrDZj48+PL+gQE6GgjRwZwlTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554226; c=relaxed/simple;
	bh=kRmVVIgkpdixHmWX5SCJ3zY9KWPpXi7W0q1pwrlcqow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNSGdaKrJhWX7GGPXUf4TnWWTTyD/Wy1oZQntP8FsYb6XY1n/wYPX7LffMsYaYBj+BPt0kxI2VeXhix/Y+WAf9bV7lKEnFxl6YrkmfnSzRRELVuXqmszn/yuicwJeKOSv6LakkEAWDfPyBZj4ybRPZqEyrLe5/zlXEL2k8mQrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UOwMQKqp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A9J5mA032450;
	Thu, 10 Oct 2024 09:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=q
	3Ar17ZnhePlLQfTjr+lorYL7JqJXclVExDnbtijseI=; b=UOwMQKqpQucUEgWDZ
	sqhqcNShv+z9VerWOPQtuRkXQmw3Zq1de00G2T2hTBWdilQ/0tB/LJbX1eDP7ZkT
	QIV2gxeDNJOD7lsWh66OWYSqQlQwFcw8iyzDa4eTtVc2eXdZMH2E11LxfV7LzcVb
	YxN2r8rY7uxJrtWe/D59OqABmFdBvwowTICQxQoNvvfValqiD7JfH2YRmnT6MKaI
	ZfM0wicahL0oeQn+SkY3KGY7n+DZ9sRTX77+DRMVSkkmjbUBt29+0tUUvl0X9flm
	tpMRyGo6iEaz/MXdiT7hvccGOD/5BBgNvXoD+cCeeap/2GFyyqwEt/cb1VFUtVWM
	86oEw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426c6fr589-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 09:56:40 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A9ud5X009096;
	Thu, 10 Oct 2024 09:56:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426c6fr585-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 09:56:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A7IHed022867;
	Thu, 10 Oct 2024 09:56:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg16qqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 09:56:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49A9uYsT37159264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 09:56:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADE732004B;
	Thu, 10 Oct 2024 09:56:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37A2720040;
	Thu, 10 Oct 2024 09:56:31 +0000 (GMT)
Received: from [9.43.111.131] (unknown [9.43.111.131])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Oct 2024 09:56:30 +0000 (GMT)
Message-ID: <beeea05a-7dfc-4506-9f20-7c8a4d1f4c85@linux.ibm.com>
Date: Thu, 10 Oct 2024 15:26:30 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] kbuild: Add generic hook for architectures to
 use before the final vmlinux link
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Naveen N. Rao" <naveen@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20240915205648.830121-1-hbathini@linux.ibm.com>
 <20240915205648.830121-12-hbathini@linux.ibm.com>
 <CAK7LNAS9LPPxVOU55t2C_vkXYXK-8_2bHCVPWVxYdwrSrxCduw@mail.gmail.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAK7LNAS9LPPxVOU55t2C_vkXYXK-8_2bHCVPWVxYdwrSrxCduw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7IbZoMAePHWk5dsGsKv-k9M1do2Lo13b
X-Proofpoint-GUID: StUHlrh169O9lS9A_wENg5YC2q5GXph6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_07,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100065


On 09/10/24 8:53 pm, Masahiro Yamada wrote:
> On Mon, Sep 16, 2024 at 5:58 AM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>
>> From: Naveen N Rao <naveen@kernel.org>
>>
>> On powerpc, we would like to be able to make a pass on vmlinux.o and
>> generate a new object file to be linked into vmlinux. Add a generic pass
>> in Makefile.vmlinux that architectures can use for this purpose.
>>
>> Architectures need to select CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX and must
>> provide arch/<arch>/tools/Makefile with .arch.vmlinux.o target, which
>> will be invoked prior to the final vmlinux link step.
>>
>> Signed-off-by: Naveen N Rao <naveen@kernel.org>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>
>> Changes in v5:
>> * Intermediate files named .vmlinux.arch.* instead of .arch.vmlinux.*
>>
>>
>>   arch/Kconfig             | 6 ++++++
>>   scripts/Makefile.vmlinux | 7 +++++++
>>   scripts/link-vmlinux.sh  | 7 ++++++-
>>   3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 975dd22a2dbd..ef868ff8156a 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -1643,4 +1643,10 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
>>   config ARCH_NEED_CMPXCHG_1_EMU
>>          bool
>>
>> +config ARCH_WANTS_PRE_LINK_VMLINUX
>> +       def_bool n
> 
> 
> Redundant default. This line should be "bool".
> 
> 
> 
> 
> 
> 
>> +       help
>> +         An architecture can select this if it provides arch/<arch>/tools/Makefile
>> +         with .arch.vmlinux.o target to be linked into vmlinux.
>> +
>>   endmenu
>> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
>> index 49946cb96844..edf6fae8d960 100644
>> --- a/scripts/Makefile.vmlinux
>> +++ b/scripts/Makefile.vmlinux
>> @@ -22,6 +22,13 @@ targets += .vmlinux.export.o
>>   vmlinux: .vmlinux.export.o
>>   endif
>>
>> +ifdef CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX
>> +vmlinux: arch/$(SRCARCH)/tools/.vmlinux.arch.o
> 
> If you move this to arch/*/tools/, there is no reason
> to make it a hidden file.

Thanks for reviewing and the detailed comments, Masahiro.

> 
> 
> vmlinux: arch/$(SRCARCH)/tools/vmlinux.arch.o
> 
> 
> 
> 
>> +arch/$(SRCARCH)/tools/.vmlinux.arch.o: vmlinux.o
> 
> FORCE is missing.


I dropped FORCE as it was rebuilding vmlinux on every invocation
of `make` irrespective of whether vmlinux.o changed or not..
Just curious if the changes you suggested makes FORCE necessary
or FORCE was expected even without the other changes you suggested?

Thanks
Hari


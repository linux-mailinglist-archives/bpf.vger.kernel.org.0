Return-Path: <bpf+bounces-63700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1B9B09DF2
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 10:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EC2A4697C
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 08:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E76291C0F;
	Fri, 18 Jul 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GVpca6Hp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5432253A1;
	Fri, 18 Jul 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827342; cv=none; b=XjzyHfpCqy07RjU0/tfydaZq3QpAzTOlI1kXEfQzZ077hdsWNIImxzj2fPvyHfnu+FVu4dr1v1Btq+My218IMuivdZT62COtrfY1im6tQ2xK8WLyY5yHlLAdNXcNAnnuGFN6EhBSoDPZ8PUNb6NkQDfR1t6OVcBk3EbrfxEer2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827342; c=relaxed/simple;
	bh=An+QLoB26vrwmylv7R5nbNxLfWknzHLJzo8x0RFfRj0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tfKsoEtIyZ6r6hAzTdKaMa4NdkyhyT0AnlXM7hSW37iylamVYfBFsVYbp7PL8Ah/EdCSFI78mae+bqL9D+Z04kqD+QNlBBUJfZMbh0QH3D3RzOoP/7gUQ+4kXSIjF8iCSJaa0peK6wtwgBAqVT6hppezmRNjwWCTRwutqaVUMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GVpca6Hp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7AXiX016701;
	Fri, 18 Jul 2025 08:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P7zv2f
	2/pQ2JjPIX25pzVf7Fi9ExE+OaUp8IOBF1wYk=; b=GVpca6HpyCTHbO5QzbbcH1
	Hza8zv+C6i44zb0E3HS4ZVHe+QAjdM75aBs9kMvmA7Ka7NgzX7jgiUus4GTFMYH7
	SUsmdiodPaV2QS+YXVzhoJD6mkK5dCXeAxF6yH0I0m8zGGbmcRhqPOemSbpMI3zb
	gDGQY7OQNlwFcubh5Qdpfvwdj1t7Z68bbcUj6nBqv+zA2cfQR52QQavkUNmNbGPY
	qg84iZ9/4LvunHQTZjAOP+Qws/SCCxo3En/6+MF+TvlZYyM8RZjLt9UTTsQlkP3K
	9IqdnndnjrXWGLWRPdClZlq9kPoEvTfh1rRWDjqWXS1aiZ/osNy9ndSDupu8nP9Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamub9nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:28:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56I4kGYP008154;
	Fri, 18 Jul 2025 08:28:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e10hfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:28:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56I8SYGI52232472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 08:28:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E58B32004D;
	Fri, 18 Jul 2025 08:28:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44F620040;
	Fri, 18 Jul 2025 08:28:32 +0000 (GMT)
Received: from [9.111.132.145] (unknown [9.111.132.145])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 08:28:32 +0000 (GMT)
Message-ID: <fb9ee560-d449-4d46-9fb1-19780ff28e65@linux.ibm.com>
Date: Fri, 18 Jul 2025 10:28:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 07/16] unwind_user: Enable archs that do not
 necessarily save RA
From: Jens Remus <jremus@linux.ibm.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-8-jremus@linux.ibm.com>
 <xgbpe46th7rbpslybo5xdt57ushlgwr5xyrq4epuft5nfrqms3@izeojto3wzu4>
 <b5121d71-f916-45ea-9e6c-b74a27f90dcd@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <b5121d71-f916-45ea-9e6c-b74a27f90dcd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lyAFuwjgrMh-HnhCNOaWMxfetyzxvEaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA2NCBTYWx0ZWRfX4VemN82g5i3Q 6Si28PDiYEycUkdY/Ocy02ALDx2nMJRqExPdL+wYLjxTVRCZIxU6wrJmfS+gRHHCNy/J7m0M5hP C8ot0n6ST50PUHYFYkOiYBK6VYmHajP5+rPCD5gq0YcCmDxmWwmAWgvETgVbBUvm2l/foWLIcWG
 r/jDHcjgtSr85ROj3GfUFCo6GFpF8b0h+lsQYYFS6/1+lhbiNW+mQeFgDhbY76G/iuEKmfjSBVS 03S8+2b71+o7gP8AftOJ1Qf9bnxObS61VrUJiokLdxyldD/ZLezU1pXs/A4Bi8V6u3He8vK31th 36iyzY56tQ3IHkCKTV2yDDC1bQ/081XwBwl4RUaoQE5qCPtSvOzm2xAp8P7g7b/qPgz7aGFDWM3
 lQxqseKFSVXGvJvHJyVIPSfy84Ik4b94Ch0enLMAYjvCYlzaFMehWp0Wd2w9qJx9QEPs1q2P
X-Proofpoint-ORIG-GUID: lyAFuwjgrMh-HnhCNOaWMxfetyzxvEaR
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=687a05b7 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=edDyEtEh5DHdOHvQ2iMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180064

On 17.07.2025 13:09, Jens Remus wrote:
> On 17.07.2025 01:01, Josh Poimboeuf wrote:
>> On Thu, Jul 10, 2025 at 06:35:13PM +0200, Jens Remus wrote:
>>> +++ b/arch/Kconfig
>>> @@ -450,6 +450,11 @@ config HAVE_UNWIND_USER_SFRAME
>>>  	bool
>>>  	select UNWIND_USER
>>>  
>>> +config HAVE_USER_RA_REG
>>> +	bool
>>> +	help
>>> +	  The arch passes the return address (RA) in user space in a register.
>>
>> How about "HAVE_UNWIND_USER_RA_REG" so it matches the existing
>> namespace?
> 
> Ok.  I am open to any improvements.

Thinking about this again I realized that the config option actually
serves two purposes:

1. Enable code (e.g. unwind user) to determine the presence of the new
   user_return_address().  That is where I derived the name from.
2. Enable unwind user (sframe) to behave differently, if an architecture
   has/uses a RA register (unlike x86, which solely uses the stack).

I think the primary notion is that an architecture has/uses a register
for the return address and thus provides user_return_address().  What
consumers such as unwind user do with that info is secondary.

Thoughts?

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/



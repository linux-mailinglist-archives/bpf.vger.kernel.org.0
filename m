Return-Path: <bpf+bounces-63585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF0FB08947
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1099616E523
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5A8289E2D;
	Thu, 17 Jul 2025 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TzSnh1CD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABDC2F850;
	Thu, 17 Jul 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744558; cv=none; b=dYLjZk1TJQwbD/KFL3YvOQADUBWexxP2YYzlCTXWt5A3Jgp2NA8stLNk2CU/Zqsm50VJC0avUnSOhWaUvhSKL5/OFiFQKv4xnLLyGuk0xbygfUs5fs6HFY2bb/rhwusp0Ipa2PkApSSkXDgQxoIxVB9lGjKwVfqwe6iqgFGDFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744558; c=relaxed/simple;
	bh=mH+YbEAXlJWH++eCVNxLYsOB6N+PZNhGYfFFQiF6ApQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZrT5nAcaL2ZSShRN/HXVAAzsfox6DJx2rLYZXvKlDAlGcy6YI59doOLlSYJhHs4NwRbex9MH2lxlYZPmEfyoaPxaObcS8CcgzM0fV7bJrc7dBCMXvACqUlgYg1zYPY7D0TyDFg8CZrMQGEB7D6FUKLdUWyO6/3b4fuzqZ+PN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TzSnh1CD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GNPV9v017572;
	Thu, 17 Jul 2025 09:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rVXK4n
	jLLzFaBFUpR2DnrCCgtkl777amkMgNdy1I+X8=; b=TzSnh1CDfxpUyn7niuL0kC
	EAe8Yf1AioeVZg/z7AgxUjU+PpEaupV8mJ1gijnVJlTUxVSTifuIF1soAekTWOwP
	qzapAK3Y2tFu3b2H1PsS7RKV9GEZ+Wy028lHJCadERruYP7Iz5sKAC8u9XaThLjB
	7QOaOofM9yE3hLXTzSNh1Hs0bO3hEWivP659NPTcGioIBdHaas4l3Ttv5ZjDY1XY
	aEZ6Ry8UAaOiocuw+rYHX1hNOLiffXArkQmTRaA0srIb7YtXPWncSqWrT56/ojTy
	GjK/m+dzUud6fWHEWTaKX1JIsr6PIP/4B92axHDSMiny9pVwJGvdyRAHQki4GKww
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47xh9036bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 09:27:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56H5o3HJ032738;
	Thu, 17 Jul 2025 09:27:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48mb8gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 09:27:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56H9RjBJ51970528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 09:27:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C24022004B;
	Thu, 17 Jul 2025 09:27:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66F1720043;
	Thu, 17 Jul 2025 09:27:45 +0000 (GMT)
Received: from [9.152.222.105] (unknown [9.152.222.105])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Jul 2025 09:27:45 +0000 (GMT)
Message-ID: <ae46c02a-d871-4b26-97f4-bd82361ab8bc@linux.ibm.com>
Date: Thu, 17 Jul 2025 11:27:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 06/16] unwind_user: Enable archs that define CFA =
 SP_callsite + offset
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
 <20250710163522.3195293-7-jremus@linux.ibm.com>
 <qoiocmdhuuaox5v5ig2ui67qbuxkvzl4z3ft4gdp7p3c4b4zfq@trjthmmculkf>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <qoiocmdhuuaox5v5ig2ui67qbuxkvzl4z3ft4gdp7p3c4b4zfq@trjthmmculkf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wI6VvsJ2a1WoW6x-eSHjn4DVuGGhuHDT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA4MSBTYWx0ZWRfX2N4VbSkkUJ+I 9cJVvw34fHHv54+bWz4zYmKeqIZcvd9/SNPFA81lvMJSVkgKu414+bQPjp/CmWO/Cu6DU6A2gLv OJTDTwuM7asaj2e17olpfwqnOnaL32q26Mg68t9WGlTOlqsbYVRSwrmVPhQ8/1ZBNoB3zA/X3bu
 95m98IXpxEh//nrPV9walN6zrqVdUMvfa/OkGixU3ikn5k1+FbkERHn3uIJ1diNEZwUSWNxRyMO tta/GFjbXz4mX/v3ZkpuYq2cZU7OM/bsYWtP6nFUHdEBGfDtYds3QhEFmbl9sc/RBkuQ0TZvyNU BaG1AaC/AuRv/wAmPjqU3aoZmHmtoh/qMth/W1kyfE9xAsFRj/DzE3tjhQQ0BvRy6lgzmJ3S6Xe
 1QjNcRXC7LJ4bLWidPzMQ3TlwtdLfaneHCG0YeFFJ7cPggJ38pZbr4PuhBVZJV3jzcQC5fTx
X-Proofpoint-GUID: wI6VvsJ2a1WoW6x-eSHjn4DVuGGhuHDT
X-Authority-Analysis: v=2.4 cv=C43pyRP+ c=1 sm=1 tr=0 ts=6878c216 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=rJ7-DNekCqM9-0Bz_MUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=757 mlxscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170081

On 16.07.2025 23:32, Josh Poimboeuf wrote:
> On Thu, Jul 10, 2025 at 06:35:12PM +0200, Jens Remus wrote:
>> Most architectures define their CFA as the value of the stack pointer
>> (SP) at the call site in the previous frame, as suggested by the DWARF
>> standard:
>>
>>   CFA = <SP at call site>
>>
>> Enable unwinding of user space for architectures, such as s390, which
>> define their CFA as the value of the SP at the call site in the previous
>> frame with an offset:
>>
>>   CFA = <SP at call site> + offset
> 
> This is a bit confusing, as the comment and code define it as
> 
>     SP = CFA + offset
> 
> Should the commit log be updated to match that?

I agree that the commit message is confusing. Would it help if I replace
it with the following:

Most architectures define their CFA as the value of the stack pointer
(SP) at the call site in the previous frame, as suggested by the DWARF
standard.  Therefore the SP at call site can be unwound using an
implicitly assumed value offset from CFA rule with an offset of zero:

  .cfi_val_offset <SP>, 0

As a result the SP at call site computes as follows:

  SP = CFA

Enable unwinding of user space for architectures, such as s390, which
define their CFA as the value of the SP at the call site in the previous
frame with an offset.  Do so by enabling architectures to override the
default SP value offset from CFA of zero with an architecture-specific
one:

  .cfi_val_offset <SP>, offset
  
So that the SP at call site computes as follows:

  SP = CFA + offset

>> +++ b/arch/x86/include/asm/unwind_user.h
>> @@ -8,6 +8,7 @@
>>  	.cfa_off	= (s32)sizeof(long) *  2,				\
>>  	.ra_off		= (s32)sizeof(long) * -1,				\
>>  	.fp_off		= (s32)sizeof(long) * -2,				\
>> +	.sp_val_off	= (s32)0,						\
> 
> IIUC, this is similar to ra_off and fp_off in that its an offset from
> the CFA.  Can we call it "sp_off"?

My intent was to use the terminology from DWARF CFI (i.e. "offset(N)"
and "val_offset(N)") and the related assembler CFI directives:

  .cfi_offset register, offset:  Previous value of register is saved at
                                 offset from CFA.

  .cfi_val_offset register, offset:  Previous value of register is
                                     CFA + offset. 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/



Return-Path: <bpf+bounces-62929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F4B00782
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 17:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D185E4A1B4D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A6274B3F;
	Thu, 10 Jul 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W2jihqNv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22682737FD;
	Thu, 10 Jul 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162135; cv=none; b=Eu6vDqyvn2HSbUXcGNX+xN1EbL2C4BXTn+JhqJdyZ0A2Q+yLtz4ysXYVkuzNKhF/YassuE6CsVD6E3iwRsjfFXzXwHf/zSB8lwzuEI5+QDchu/RCNmqJomvWZEEZVoPiisFBge3maUcgItHyusDZyVq0YWGbHx9G144pcaspuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162135; c=relaxed/simple;
	bh=Q84wSa4gEiDFfH5yarasNKbMrTnTs8J/rs21cprCxRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhtmmph4Pi6ZfbXGD3/GTm2UGu7+6wGxfPKVGrwT2MsPgvGkp37irZRflChXOTIgdJVyJHgsJq8Vs+k1k8xLt9VWHLMdy4mpP+bS4NIwNrTAdo+yetqx2iKrXqz/KwvLTv17+8SYU1+uGuZIq6XmBnKezNlVuXuvbrHGhc3M3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W2jihqNv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AD02oc015626;
	Thu, 10 Jul 2025 15:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n8/DCH
	MtAXp3jd5yExP8Ei4NE6gz/N3w4heWlrqsi10=; b=W2jihqNvVWwlsNr7axABBr
	XoNj8uYk41n3fiZU5SakE73Ff2ek7MFAzEycYgaOZ+sVi79ZEiycaMp/iaN8Nzv3
	sRpsXA/qjBRIJPY6s7yB5Djvvz2SZg0QxdIIo6Z9bObnddVY3OGq9N3o98LgKb8E
	ML+fO4TzQekHh/48mxF/PPgMtaNQrKLawfJN5PcrUpaIBM5/4GDVJ7mXCnDLubaE
	9i5qThpcqPOKtCRS/AsBK7tKvEIaGa03I9LgQDQ39A6DIRrPc2YtRtBdXDfZpu/5
	81dhoAbnqml6KEWV2lH5dPjQgAT+z2BTsupbl8/uB4IqDeJVOyZSrPZjfSKnBGew
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjrcsas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 15:41:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADaNt8021525;
	Thu, 10 Jul 2025 15:41:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectxgwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 15:41:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AFfcoi9765272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:41:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E66E2004B;
	Thu, 10 Jul 2025 15:41:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED8F420040;
	Thu, 10 Jul 2025 15:41:36 +0000 (GMT)
Received: from [9.111.128.203] (unknown [9.111.128.203])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 15:41:36 +0000 (GMT)
Message-ID: <155f22cb-b986-4d22-a853-6de49a1c2e03@linux.ibm.com>
Date: Thu, 10 Jul 2025 17:41:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/14] unwind_user: Add frame pointer support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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
        Sam James <sam@gentoo.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20250708012239.268642741@kernel.org>
 <20250708012357.982692711@kernel.org>
 <d3279556-9bb6-429d-a037-fe279c5e3c67@linux.ibm.com>
 <20250710112147.41585f6a@batman.local.home>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250710112147.41585f6a@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686fdf37 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Ezl6U-oBbhCAbrAPatEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FStG2Q_hrPMgrV8gJgqFEHt6JVvS2wm5
X-Proofpoint-GUID: FStG2Q_hrPMgrV8gJgqFEHt6JVvS2wm5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzMSBTYWx0ZWRfX/4n5NhYYMKhz 1+763M4hf6Hs2QXAAgoE8F9Jcf5jgsbsyJS2hhqoW6SVZvTGvfNdTHk4JR4BU8QaZhLPaOmJ8DR SSGMn4P2jydvFLuzXrhCW1mzroBYwEYBixa7czLCdNL0R6bDjKrXVgVbaYathXNO4vzXkYxMneR
 n2PXutd93IpZvn392VBOtYZGv9sFzWCreb4YbfBBCzts4wlhA/EXa3/i1Bhn3N3nZTPGFkUmjX2 lLz4eJJnEajUinA4HYbI7cXF0fj3J3C0C1ymeMGZlL7k7oiD64AxH9fJy2Pe6SU3qnaWJsRAp64 86ljQU9deCDyX52tjFnurSGDgR7qA7vxfp+/jt2cqHxIDg9FPTbuSeZJWTCCPqIkP5WrOP4mJuQ
 6MDeae/MWbyAL+5jmB6GHPBYSn9o3DysrjXveSn8si6o5Rx9Yb1Atl9OTo/bEAJaMICrm61d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100131

On 10.07.2025 17:21, Steven Rostedt wrote:
> On Wed, 9 Jul 2025 12:01:14 +0200
> Jens Remus <jremus@linux.ibm.com> wrote:

>>> +	if (frame->use_fp) {
>>> +		if (state->fp < state->sp)  
>>
>> 		if (state->fp <= state->sp)
>>
>> I meanwhile came to the conclusion that for architectures, such as s390,
>> where SP at function entry == SP at call site, the FP may be equal to
>> the SP.  At least for the brief period where the FP has been setup and
>> stack allocation did not yet take place.  For most architectures this
>> can probably only occur in the topmost frame.  For s390 the FP is setup
>> after static stack allocation, so --fno-omit-frame-pointer would enforce
>> FP==SP in any frame that does not perform dynamic stack allocation.
> 
> From your latest email, I take it I can ignore the above?

Correct.

>>> +	/* Make sure that the address is word aligned */
>>> +	shift = sizeof(long) == 4 ? 2 : 3;
>>> +	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
>>> +		goto done;  
>>
>> Do all architectures/ABI mandate register stack save slots to be aligned?
>> s390 does.
> 
> I believe so.
> 
>>
>>> +
>>> +	/* Find the Return Address (RA) */
>>> +	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
>>> +		goto done;
>>> +  
>>
>> Why not validate the FP stack save slot address as well?
> 
> You mean to validate cfa + frame->fp_off?

Yes.

> Isn't cfa the only real variable here? That is, if cfa + frame->ra_off
> works, wouldn't the same go for frame->fp_off, as both frame->ra_off
> and frame->fp_off are constants set by the architecture, and should be
> word aligned.

cfa + frame->ra_off could be aligned by chance.  So could
cfa + frame->fp_off be as well of course.

On s390 the CFA must be aligned (as the SP must be aligned) and the
FP and RA offsets from CFA must be aligned, as pointer / 64-bit integers
(such as 64-bit register values) must be aligned as well.

So the CFA (and/or offset), FP offset, and RA offset could be validated
individually.  Not sure if that would be over engineering though.

>>> +	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
>>> +		goto done;

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



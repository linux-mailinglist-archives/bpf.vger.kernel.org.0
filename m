Return-Path: <bpf+bounces-62916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA0B001B8
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 14:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30225A3581
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 12:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801262561D9;
	Thu, 10 Jul 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SUKrbUkr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A922512D5;
	Thu, 10 Jul 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150518; cv=none; b=gjn563bye2mgQv6BDRoSPsWg57GFdukp3KIEoeRiUT9TdFq3EIZnXuySm7Z3aMje6HiNpB2gDvphI39zBnPEp2Ao0ZAX22DlegqA+VgVAVvrpXcbv5WScHqUTJEWPc82erfRReZuYUaBOyMADlrXOWJifHdt6QrYegHCwfrY1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150518; c=relaxed/simple;
	bh=uVwWozQdm8dl9zMzLnAU4GJ3N1SGHAS9efDRdRXlv60=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZYsOel3JOB4L3VIJQXYPxaTweN780kHVp/M6FyGK0I9VmcM2wAud77hRkf7eCExe4xin39pEZ3lN1qw/KfSe4660oy+c7WHh5Kn//lcgbwbPwCDdbSjemCzVmqxPyZB+qnfScP7UYZ1Eox+qMk0rbvJUW8sr9HYazC3lW3Mxxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SUKrbUkr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A61rJS010735;
	Thu, 10 Jul 2025 12:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W7y3iB
	FzU3kHVk3xzJUXtgMnwiA/4a2QpmH4yjepWvY=; b=SUKrbUkrRBEJAY2i7SeKnV
	OAVGrjYoMGG/+NvnESJ2V87mm3+R9BgR6ih/nKy5wJAn6Tj3n6T0k1jrbYYOmt8r
	NBvYt2qHBM/POWlJigBknGW+SkWCvln5UpSe1MtPCBGl/zgTqbcl/F2qFifH1LVn
	5y0h5uEnztMPiiPZccSUj4HWPjRVwY0jD1wrorOtOB+sKrVfFq8yaTcIjt053XvX
	mhKfO+Hm4J5Uiqn2b6WkqL2ImTWBlEfsuKMUQ7H+3Pm0ARuIlp9TAu+dLNDVHxfT
	dy4t7+IeLsB4e7QmDo74nTNYBUNeY1vQhg1pmX4+NVDY7P/Mq3F9rOAsqtGZjWDw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnkqdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:28:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56ABpQSE024311;
	Thu, 10 Jul 2025 12:28:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32nabn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:28:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ACS76l56492344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 12:28:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E47220043;
	Thu, 10 Jul 2025 12:28:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B969520040;
	Thu, 10 Jul 2025 12:28:06 +0000 (GMT)
Received: from [9.152.222.235] (unknown [9.152.222.235])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 12:28:06 +0000 (GMT)
Message-ID: <70803af5-369c-4de2-af30-70d74f1e6256@linux.ibm.com>
Date: Thu, 10 Jul 2025 14:28:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/14] unwind_user: Add frame pointer support
From: Jens Remus <jremus@linux.ibm.com>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
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
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <d3279556-9bb6-429d-a037-fe279c5e3c67@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=686fb1dc cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=xGKi6vjhqkjxjNt39fsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sJrvX2rJR0n-3zeimi9EkXiwKcJZV73C
X-Proofpoint-ORIG-GUID: sJrvX2rJR0n-3zeimi9EkXiwKcJZV73C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNSBTYWx0ZWRfX9WHaz58xiiaQ iRbl9JwMZP3iJc8BmTDuvRm/P5xYrBk6TpSmXbjn9US8P1z7yL11slNTW400otCXgES/8sVRC0A uX5PG7sYhxMazuFbu39xr2ua+aSvmCmPEzvDlU4zfRnDo0x7JjPdSuWgI3ecdC3c6RMhwM6/ry1
 ZPaZqY9ZQH1Q6C5ry4QRBgTr6IJ8ZkxKlVMjAtiCUeSCiFKlWtop7N4cvJoztRQxkjKNRnOKTVh 7dCDjgVGhaUAQbICdmuIeMPhvhFe73bwR4cMvaZ8qXdVWy+FnsIrFgmYsilWB0xpVaSU3KTQdp6 YrGjwdWQzvs8uLmwzIFwFQYfZW3aFMRvLinXFQV8LMcLOKx3D6cP3UzVL1jbAudVCBa78VG4Lv+
 UwDwsPDsi0DDdACXzQlg21M4yCvhA6lio85mkq4tR6r3dhEC6u11yhUcYZAG2HwDjRY3hGKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100105

On 09.07.2025 12:01, Jens Remus wrote:
> On 08.07.2025 03:22, Steven Rostedt wrote:
>> From: Josh Poimboeuf <jpoimboe@kernel.org>

>> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c

>>  static int unwind_user_next(struct unwind_user_state *state)
>>  {
>> -	/* no implementation yet */
>> +	struct unwind_user_frame *frame;
>> +	unsigned long cfa = 0, fp, ra = 0;
>> +	unsigned int shift;
>> +
>> +	if (state->done)
>> +		return -EINVAL;
>> +
>> +	if (fp_state(state))
>> +		frame = &fp_frame;
>> +	else
>> +		goto done;
>> +
>> +	if (frame->use_fp) {
>> +		if (state->fp < state->sp)

The initial check above is correct.  I got the logic wrong.  Sorry for
the fuss!  Do not change the check to what I came up with yesterday:

> 		if (state->fp <= state->sp)
> 

Below s390 particularity, that FP may be equal to FP in any frame,
is only allowed with the initial check.

> I meanwhile came to the conclusion that for architectures, such as s390,
> where SP at function entry == SP at call site, the FP may be equal to
> the SP.  At least for the brief period where the FP has been setup and
> stack allocation did not yet take place.  For most architectures this
> can probably only occur in the topmost frame.  For s390 the FP is setup
> after static stack allocation, so --fno-omit-frame-pointer would enforce
> FP==SP in any frame that does not perform dynamic stack allocation.
> 
>> +			goto done;
>> +		cfa = state->fp;
>> +	} else {
>> +		cfa = state->sp;
>> +	}

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



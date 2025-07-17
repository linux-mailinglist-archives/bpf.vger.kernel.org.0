Return-Path: <bpf+bounces-63591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51616B08B8D
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 13:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E4F562D27
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45D29AB12;
	Thu, 17 Jul 2025 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zl5vFhZX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40864262FC2;
	Thu, 17 Jul 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752750641; cv=none; b=D0hBoYMbqR/6qsDAmvoyDMCWXD7qau9xiNW2r7pA1i05Taqhyg3JKZjAUny6ec/bazKztuFjWyW4TKUXptZ+n0UlV30feP2Y/KAWFoCN7qYdeydXbWM7lMqqv/nofdHkVbA9YGK0kXj3JdcoT50cZ0pUC1roJL9C2i4Hy+olFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752750641; c=relaxed/simple;
	bh=EWFl6shmU2zXxv7iAdUpoBEoZHn97NDn8y/skqYlOGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIUAgWXqjGnjQJ97EWN8KRUB2b77Vtfnlj4lvbkbFB34Ns5g+6M+CSXdDgOtDSLSqcaneSQg5AcJY6axENOStN9JHzkmJjvWPvhPCCZ+GG9jBpKj9+RZSGCxIwZXwsz95pf6vnX/RVNy8/pdHmsTcopDh3dE5+jYU2dCpkqJPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zl5vFhZX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H8ShWI004602;
	Thu, 17 Jul 2025 11:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2CzZTk
	QfcLO+g8E9ozYuUqDsF0V+r5NipF1gMiNv1zE=; b=Zl5vFhZXfpGTkZaFj1mcSP
	Xa5AcqP444y819/uasfzbe+bijSWDMBfszHjB17fxzY1NCjFwY98soGG41aBIROG
	GzZFdyb2U2x/YmrjGiLI3HZPggT4YPvQDtoDqnBOSHhj/z0S88cWUihqFWUGT+xy
	J1r7+7KqEBvf+JRqeetZnD9d5Zn5MtE8il6nnsIOsmoHFDitZdebX7qAPNebYtmo
	cC3xzGvsLf2+vUD9+Tx3rl4W+g0X1CSn4E9o0Lv2Dma21WOgrocNlkmGWYPANQQv
	45hP1O11wbbhHHeISzsH7+Ic4Z5+L/oPapKBTlrHqlRLC45KpfICOXvCyQmcDgEg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc7a8ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 11:09:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HAU0wZ021890;
	Thu, 17 Jul 2025 11:09:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r3bhk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 11:09:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HB9ldt32834162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 11:09:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0E272004E;
	Thu, 17 Jul 2025 11:09:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4424B2004B;
	Thu, 17 Jul 2025 11:09:47 +0000 (GMT)
Received: from [9.152.222.105] (unknown [9.152.222.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Jul 2025 11:09:47 +0000 (GMT)
Message-ID: <b5121d71-f916-45ea-9e6c-b74a27f90dcd@linux.ibm.com>
Date: Thu, 17 Jul 2025 13:09:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 07/16] unwind_user: Enable archs that do not
 necessarily save RA
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
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <xgbpe46th7rbpslybo5xdt57ushlgwr5xyrq4epuft5nfrqms3@izeojto3wzu4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=6878da00 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Tut4zIY26HbeGpenRGoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA5NSBTYWx0ZWRfX9EsHMfQaa05K SSF51bv8yBrxeU38D+wK6AOmryBinIF5ONZirCqa/gNYLPuco+DTrWgKswI6evnqONxMSiNcFj9 Aq8NzBmIexei13+uvLKO7sn8rfiT3whVzrMY6b0KsQqW2akwDWHyuKjRXhzumhSuNlpBNWfOHqb
 re6wWBbnzzmIARgVsC3r1UwPqEVKDsSzKFoJAMNFJLwfNcGkj3qYunmlYtX1gVznqcVC/hUVpZv wJyRxV/oyDvi0TI624dc4QHWEEC6WjDD9IuDw6aXb6KdL/VXkz5tjHYldq3k8VfNLgxVlwj6iCP 8pNeCHwZvAd3Su2aIWNPyqHPny8lb1jfpBbHGCvuPPwc3qxdlwiZaV78G4VHkrsW2UhptYMYDXf
 +wp/SGs3geOCZ55bbLPabITJ8wlGJJjW8ZdPRcuBxfIJ1+nBrNgu6I7ooML+syzGVS4OHjK4
X-Proofpoint-GUID: fRg2GABNH87s1fipgqSKkT5r6ME2NxOt
X-Proofpoint-ORIG-GUID: fRg2GABNH87s1fipgqSKkT5r6ME2NxOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170095

On 17.07.2025 01:01, Josh Poimboeuf wrote:
> On Thu, Jul 10, 2025 at 06:35:13PM +0200, Jens Remus wrote:
>> +++ b/arch/Kconfig
>> @@ -450,6 +450,11 @@ config HAVE_UNWIND_USER_SFRAME
>>  	bool
>>  	select UNWIND_USER
>>  
>> +config HAVE_USER_RA_REG
>> +	bool
>> +	help
>> +	  The arch passes the return address (RA) in user space in a register.
> 
> How about "HAVE_UNWIND_USER_RA_REG" so it matches the existing
> namespace?

Ok.  I am open to any improvements.

>> @@ -310,6 +307,12 @@ static __always_inline int __find_fre(struct sframe_section *sec,
>>  		return -EINVAL;
>>  	fre = prev_fre;
>>  
>> +	if ((!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost) && !fre->ra_off) {
>> +		dbg_sec_uaccess("fde addr 0x%x: zero ra_off\n",
>> +				fde->start_addr);
>> +		return -EINVAL;
>> +	}
> 
> The topmost frame doesn't necessarily (or even likely) come from before
> the prologue, or from a leaf function, so this check would miss the case
> where a non-leaf function wrongly has !ra_off after its prologue.
>
> Which in reality is probably fine, as there are other guardrails in
> place to catch such bad sframe data.

On s390 the compiler may intermingle prologue instructions with function
body instructions.  As a result !ra_off is valid as long as the RA
register value from function entry has not been destroyed.  Furthermore
the compiler may decide to save RA only if it is actually about to
destroy the RA register value (e.g. due to a function call).

Note that it is valid to restore the RA register value anywhere in a
function and represent that in SFrame.  Following is an example from
Glibc libc.so psignal() on s390x.  The RA rule changes back to "u"
(= undefined; !ra_off) multiple times, whenever the RA register has
its value from function entry again.

  func idx [589]: pc = 0x6c530, size = 250 bytes <psignal>
  STARTPC         CFA       FP        RA
  000000000006c530  sp+160    u         u
  000000000006c536  sp+160    c-72      c-48
  000000000006c53c  sp+328    c-72      c-48
  000000000006c5b4  sp+160    u         u
  000000000006c5b6  sp+328    c-72      c-48
  000000000006c60c  sp+160    u         u
  000000000006c60e  sp+328    c-72      c-48

> But then do we think the !ra_off check is still worth the effort?  It
> would be simpler to just always assume !ra_off is valid for the
> CONFIG_HAVE_USER_RA_REG case.

It is only valid in the topmost frame.  Otherwise something is wrong.

> I think I prefer the simplicity of removing the check, as the error
> would be rare, and corrupt sframe would be caught in other ways.

But I am fine with removing it in user unwind sframe (above), as
user unwind performs the same check (see below).

>> @@ -86,18 +88,28 @@ static int unwind_user_next(struct unwind_user_state *state)
>>  
>>  	/* Get the Stack Pointer (SP) */
>>  	sp = cfa + frame->sp_val_off;
>> -	/* Make sure that stack is not going in wrong direction */
>> -	if (sp <= state->sp)
>> +	/*
>> +	 * Make sure that stack is not going in wrong direction.  Allow SP
>> +	 * to be unchanged for the topmost frame, by subtracting topmost,
>> +	 * which is either 0 or 1.
>> +	 */
>> +	if (sp <= state->sp - topmost)
>>  		goto done;
>>  
>> -	/* Make sure that the address is word aligned */
>> -	shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
>> -	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
>> -		goto done;
>>  
>>  	/* Get the Return Address (RA) */
>> -	if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
>> -		goto done;
>> +	if (frame->ra_off) {
>> +		/* Make sure that the address is word aligned */
>> +		shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
>> +		if ((cfa + frame->ra_off) & ((1 << shift) - 1))
>> +			goto done;
>> +		if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
>> +			goto done;
>> +	} else {
>> +		if (!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost)
>> +			goto done;
> 
> I think this check is redundant with the one in __find_fre()?

Correct.  This one needs to stay, as it is at the topmost level (user
unwind checks the unwind info obtained from user unwind sframe or any
other method).

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



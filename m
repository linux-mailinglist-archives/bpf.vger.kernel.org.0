Return-Path: <bpf+bounces-63599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE7B08CBD
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AAE17BF28
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 12:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ABB2BD01E;
	Thu, 17 Jul 2025 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d4ykoyMn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2C29E11A;
	Thu, 17 Jul 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754841; cv=none; b=gn7wIb1jbIuvDfjDefrhkbB3XDME0abj+939fUmb/o2+RYTIcyhMCjeDdktRq/qaB/POQeXpWrtAxIxsYAR5/rx5jiTs+Kb/9Wfxnocqw2Cp6d2ITVirsyWjKWKBOX5raabYugsQjleSsIrzQbpacX5WklwaVH9/JepkohhzpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754841; c=relaxed/simple;
	bh=ZS+XMyc2OjepWm/2n+Z4UnBBTiA/16wHSV4qkGBitFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9vno+GAVEVZdZySaPXZubn28GYK1L99+7sk8is7MuaEFW8Y5DUI4DBTtgyUyDLRd7k/P8IqQICYVpQ6jRgRyBPV8SMRTaQQhq2D6S/bDqKfU0ZCaujBS5pgJV0M1/3A73Nqo2hdejjcnlJlDJH7JZSREd6sTDs9AYixnaoeeiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d4ykoyMn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H2nWat014315;
	Thu, 17 Jul 2025 12:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vxDa4d
	saVKf1GSqQa3TGwafIsFgUbHZVRPNoZEvaQpY=; b=d4ykoyMnkEYUiew+h+FNYL
	XgPWYrspWuj7irGTKHLYMojbTh+uBi4hcfrFjPLHT3E9j8CZMOiPp+tATAuxdUbB
	+o7t+pTda+Cqm287xXKRWekSCDKqWi1wr46pZ0KwBM+08ZLCSGO2N0pMoPXS2brv
	b+CSxCfd7/LJxuKCz+aL7YW1HNV367bohxadUphTaFPk8HftZBfyGTgWacOM7wry
	e5Ek2ZTbnxoJ2SVVoGtJHpBE5o47arGx21+R6oBBSuJrVje2djeFSRwnbasa1I/H
	dDF4jLpRE3zo1mb9vM0Uc5nZ4hJM2ij78xcG47/qWPezNAS8QGi9NBISNO2tzmsQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7davr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 12:20:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HA4q3E021906;
	Thu, 17 Jul 2025 12:20:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r3bskb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 12:20:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HCKCIF58196372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:20:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A55D42004D;
	Thu, 17 Jul 2025 12:20:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39E6B20043;
	Thu, 17 Jul 2025 12:20:12 +0000 (GMT)
Received: from [9.152.222.105] (unknown [9.152.222.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Jul 2025 12:20:12 +0000 (GMT)
Message-ID: <63665c54-db44-452f-b321-1162ff6c3fe4@linux.ibm.com>
Date: Thu, 17 Jul 2025 14:20:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 12/16] unwind_user/backchain: Introduce back chain
 user space unwinding
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
 <20250710163522.3195293-13-jremus@linux.ibm.com>
 <a4dd5okskro2h45zmqgg3etj6uwici2hoop2uaf6iqrlaej7yh@xlduwjqke4ec>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <a4dd5okskro2h45zmqgg3etj6uwici2hoop2uaf6iqrlaej7yh@xlduwjqke4ec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bGZpIMXx8PT6QA5CtiYS_BsveqaVeW6H
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=6878ea81 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=cok-IRdpjc9kUBDcOJQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bGZpIMXx8PT6QA5CtiYS_BsveqaVeW6H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEwOCBTYWx0ZWRfX8BBSj3WS42T7 0aRkTrkXm8KXg5FDZHT/gE4rF9kq3K7UGnmb+TriNxppRXxmRRLH3ZKVI/KCBhob9uaQjhoi4Ta hEXAcBJu13WcGh+yUHs6j+oRVSGHGX4G5d5ZZ8FYn1qRRfAXGLbNaYFOmGeI6LKHpfclExQGjdw
 fHraFQDQ9qBI8dB8hCU8IJldsx60BMThPBF+20NtKHsUBE5hybbcXzQMB4V3fCbSueuJ1KLYYmh NAcNzH8MJTbHE79O8kn3ji4sBuQX7vi5s2ZsUWq4tgerS9ImOBN0tmr915mSnvcGNW4nZb1qrva a1CYg9IMbKdjF34YKN1lUZW42eVS9Y0bhM9Aj15wYWE8ZkWi4jsQUDkm0xOpbHXCYf1/dFLdp/b
 kBWTvaVFbCs5Nl1ozg/spKxWQIbJsCsZ7wRVo1uvKRyksFNqg/AJC4NGnonUeUMs6KgofrgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170108

On 17.07.2025 04:06, Josh Poimboeuf wrote:
> On Thu, Jul 10, 2025 at 06:35:18PM +0200, Jens Remus wrote:
>> @@ -66,12 +73,20 @@ static int unwind_user_next(struct unwind_user_state *state)
>>  		/* sframe expects the frame to be local storage */
>>  		frame = &_frame;
>>  		if (sframe_find(state->ip, frame, topmost)) {
>> -			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
>> -				goto done;
>> -			frame = &fp_frame;
>> +			if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP)) {
>> +				frame = &fp_frame;
>> +			} else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_BACKCHAIN)) {
>> +				if (unwind_user_backchain_next(state))
>> +					goto done;
>> +				goto done_backchain;
>> +			}
>>  		}
>>  	} else if (fp_state(state)) {
>>  		frame = &fp_frame;
>> +	} else if (backchain_state(state)) {
>> +		if (unwind_user_backchain_next(state))
>> +			goto done;
>> +		goto done_backchain;
>>  	} else {
>>  		goto done;
>>  	}
>> @@ -153,6 +168,7 @@ static int unwind_user_next(struct unwind_user_state *state)
>>  
>>  	arch_unwind_user_next(state);
>>  
>> +done_backchain:
>>  	state->topmost = false;
>>  	return 0;
> 
> This feels very grafted on, is there not some way to make it more
> generic, i.e., to just work with CONFIG_HAVE_UNWIND_USER_FP?

I agree.  It could probably be made to compute the cfa_off and ra.offset
or ra.regnum.  Let me explore that, provided there would be any acceptance
for unwind user backchain at all. Note that Power is using backchain as
well, so they may want to build on that as well.

> Also, if distros aren't even compiling with -mbackchain, I wonder if we
> can just not do this altogether :-)

My original intent was to use unwind user's for_each_user_frame() to
replace the exiting stack tracing logic in arch_stack_walk_user_common()
in arch/s390/kernel/stacktrace.c, which currently supports backchain.
Given that for_each_user_frame() was made private in the latest unwind
user series version hinders me.  The use was also low, because the
currentl arch_stack_walk_user_common() implementation does not support
page faults, so that the attempt to use unwind user sframe would always
fail and fallback to unwind user backchain.  My hope was that somebody
with more Kernel skills could give me a few hints at how it could be
made to support deferred unwind. :-)

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



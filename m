Return-Path: <bpf+bounces-64903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B13B18541
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E0A3BDC4E
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78627AC34;
	Fri,  1 Aug 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="guLTm5sF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00226E6FE;
	Fri,  1 Aug 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063376; cv=none; b=INAAB0aaQg8y9iddDaRUTPrjYHm4E0lnY8ujCa+u7Cbo75xIuYiH4svjBTVszZc9XENw+I3aikqATAihKfb6W/hpwZIrZe7LN3YB9RY3BRYkEraolbM5YOc1jDP9Dz7BCIGONxh58Ats7/uY+rX7fM77FrjR+hV7dwY5RWt4BzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063376; c=relaxed/simple;
	bh=QCoPCjltl5sUkHOT3VzZASPBoUk/YTB/c3vKnEC8KYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDF42q17jXswOKVmx6tbWwJyofw48VUag+sVrQOlgeKHDvAeopFyKbyQ08FEGbVB+o2qYcScCSe7Kum+hBcbOirMgGWi36eXfYzG9pwSNLz/xdjMtka6+ctCT0iCoNKaTHKPBoMazxxFONY9Zd1+ppyEjmlSgWAt+CIxHzIlSqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=guLTm5sF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571CBjeu027598;
	Fri, 1 Aug 2025 15:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F8PjZu
	tGaWkAyc2XStkiJTfqdK/6vprYEQgpgAOqe0A=; b=guLTm5sFtB4N2LvFuGq795
	9hkypR+OayLHHy8Qv88R/4FTG+Mc1n3nxW2D2c51gtzU/xQxG/xXV4oJK+gMwruV
	uPyvKpazsCqQPW9UpYcwTUz0z7wBNQaiqOleChypRmzuMfgpfPeE+f6uvVBPW0vQ
	IsN2sgALpcV+Z+LVjttj4TQCe7FMhqUDQaQJJWpxtOOxEq9NKe8Vg36WbbiXuYkk
	9aKEhpSqzH1tRiNXzIFlGdICCqztsL8JS/haXC0UF5CNLIF2zuR9W9MYicf9+PXh
	SGYChlecXVKni9SkUNKSxYvrCvOw9TEhfOp8GVue3TBqGnktWsUKVKwni1SWGdIA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 487bu0f35q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 15:49:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 571DvM3C018312;
	Fri, 1 Aug 2025 15:49:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485abpj08x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 15:49:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571FnAJe53019096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 15:49:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BEBE20043;
	Fri,  1 Aug 2025 15:49:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBE6320040;
	Fri,  1 Aug 2025 15:49:08 +0000 (GMT)
Received: from [9.111.205.109] (unknown [9.111.205.109])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Aug 2025 15:49:08 +0000 (GMT)
Message-ID: <2b0d0133-3156-47d8-b046-f93ea6cd40fd@linux.ibm.com>
Date: Fri, 1 Aug 2025 17:49:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 12/16] unwind_user/backchain: Introduce back chain
 user space unwinding
To: Heiko Carstens <hca@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
 <63665c54-db44-452f-b321-1162ff6c3fe4@linux.ibm.com>
 <ddwondzj74rr3fgvsdnkch7trrcwltasb236hvvx5tnywf2lhu@vo47rcoyu2nc>
 <20250801123647.9905A43-hca@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250801123647.9905A43-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZNPXmW7b c=1 sm=1 tr=0 ts=688ce1fb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=saB0obKPUKYBhUFmqKIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TfHxs6ezsH5a6J-EX8IXssNmsml7JaqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEyMSBTYWx0ZWRfXzTYt6I3J49MX
 8bKiaxhUBy0wbPPaSCj0dMwdakpE/Mwo7cOqnnDjqUx9fqvwRxow/MhyN2W8XPyUGRQHwYPZOU4
 Mb1xs+K7iRCX6TymGTr5a3MnTevdSeIQk0izi6OM3THayyvdFvtkNSUPLsifAe0mtGw6x5nSW3/
 aFg9V3K+pM4XmBkOCFRAv22UEP9ibKCgY+ScwktqJVs1UOZXaMAX7LbfrAdSegwxxab/NBYuwwR
 fYBKkwMuRGsY2Oh6tQEgpDLX6P2kjclmoZekUnFB/mPuA1oXQNebVX1/BHeglKBZNu+Rs8Bh8lH
 mDASzmTtmJjF+/rSqpIYE8pvKiOD8QlwijypLU9wbRLfnZNE0r7PNZOF6lQIl7qiUO4lrFcA/VJ
 CqdL6r42pXpHNl+iKiZtLlCg+vYjfbI1wQ4vhzLqJwKXimFh6QkaoiKFNACHX1akPc/i53Tw
X-Proofpoint-GUID: TfHxs6ezsH5a6J-EX8IXssNmsml7JaqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_05,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=968 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010121

On 8/1/2025 2:36 PM, Heiko Carstens wrote:
> On Thu, Jul 17, 2025 at 10:19:54PM -0700, Josh Poimboeuf wrote:
>> On Thu, Jul 17, 2025 at 02:20:12PM +0200, Jens Remus wrote:

>> I believe stack_trace_save_user() is only used by ftrace, and that will
>> no longer be needed once ftrace starts using unwind_user.
>>
>> Maybe Heiko knows if that backchain user stacktrace code has any users?
>>
>> If distros aren't building with -mbackchain, maybe backchain support can
>> be considered obsoleted by sframe, and we can get away with not
>> implementing it.
> 
> I guess that's a valid option. I know only of some special cases where
> users compile everything on their own with -mbackchain to make this
> work on a per-case basis. It shouldn't cause to much pain for them to
> switch to sframe, as soon as that is available.

Let me have another stab at a cleaner implementation.  Shouldn't be too
much effort.  We can then decide whether to leave it out or not.

Will be away from keyboard for a few weeks.

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



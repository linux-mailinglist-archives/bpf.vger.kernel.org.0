Return-Path: <bpf+bounces-62310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6B4AF7DBB
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1FB189A551
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C88324C07F;
	Thu,  3 Jul 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nPjVjOhH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B383157E99;
	Thu,  3 Jul 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559722; cv=none; b=MOgwN9AvWCQtJJmipMhPUK57HGeMlQCpwXFBE4sUanMWcpRqAbUUsbElFYVk5z0MVAdijW8TYRmFtOu5D8PBcnMkY1tqm048p0+t4k1Jn/AeG7X4/keSPlL2X1dLQcOPK07u3OlyPodr6BAmssY1qq7h8bVkXeKU030uEOvIGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559722; c=relaxed/simple;
	bh=qsElSjws3oA4dpN+ZkpRfZW49vQ5t5xw1uuPlsuVDnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxZSr1a06y2dTuv2EynDD75NOrEhb4f9k+WRpJQmxrS41QPEYARgHpuV8/uvL6+kzw0KZNLMVJDgPqStIIIt9DoAXCiqA7paXqrAuLDFFOVv+SA3h5jomVZfdOwZMXWrd2M/BTt+Vm3f9K8C+XzWE1ea9qolBkbjFlfkmUyo6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nPjVjOhH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563BMSVt001883;
	Thu, 3 Jul 2025 16:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i8NkVe
	LpEBDLuD6THW1Trv/bMVVo2C2v0DHjwQo3bG8=; b=nPjVjOhH5nq/W9IrKkYFwE
	yFP0QDNtTxXvm0SbaV+ruC9KKFuXRmsUQjZgM3XIljJMTig51wjj9HGddeV9urDg
	MvLcOHE/yQHBEvm7FGyeU3qu5YGtdd7FKC8cIGTim87eQsBRWI2pEnalw6h8pr8C
	9lJuMhSO3KLP2Kia3b67Kq07PSpTcir+F9HlPkkQ0+VivUv7/OMX1xk/TRltepGm
	C2nfj2kDzcDkHh/gE58CVD66eZPRmVyCp/QJxd3csmEOWqW1cnk7uqtvAraZEwln
	C0pzjf1KtO+ZPrLncSFrgs1Y3KjEnqxw1qL6SbIxw211yeiTQyOPaBwZMidA19rQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dn1d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 16:21:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 563EQ8r2012027;
	Thu, 3 Jul 2025 16:21:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7n5qsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 16:21:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 563GLCAi34800222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 16:21:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E9EB2004D;
	Thu,  3 Jul 2025 16:21:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A78D72004B;
	Thu,  3 Jul 2025 16:21:11 +0000 (GMT)
Received: from [9.152.222.224] (unknown [9.152.222.224])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 16:21:11 +0000 (GMT)
Message-ID: <d4fb9d4c-13d6-41fc-8c17-dee6cc0a77eb@linux.ibm.com>
Date: Thu, 3 Jul 2025 18:21:10 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/14] unwind_user: Add frame pointer support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
References: <20250701005321.942306427@goodmis.org>
 <20250701005450.888492528@goodmis.org>
 <CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
 <20250630225603.72c84e67@gandalf.local.home>
 <a6a460e6-8cff-4353-a9e1-2e071d28e993@linux.ibm.com>
 <20250702195058.7ebb026d@gandalf.local.home>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250702195058.7ebb026d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vzwp24uTChfZOwCfiOSdmh2MJX-g-FDG
X-Proofpoint-GUID: vzwp24uTChfZOwCfiOSdmh2MJX-g-FDG
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=6866adfb cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEzNCBTYWx0ZWRfX4i3gZy03aGTn +UyaW6pjuXxS9HBDjaXxdAFGU2vVeZTksbcysv33oK/sWDQiXVcfPLUmrHJ4m69D+GZQp/TQGAl L9+GhDLjrIf41Wf8l5R2ONu7t+KnAs+ozcDvq/JU5vtji49/+InHQdseR7XeJRxgVsVtNtFV++n
 ZkeJMIg6Kv7Ay9NJUIoGxlQOVi9VHpJcEFSm5DmPKBN/b6RZHFUs58w/eva3KqFPaveo0JNcRfA zVNoWYABKaDb+7MSOPgCRSgzbWW15BkLouqf6ZGH5oyX67uUgWM9ib5vqlnuBXcumVgNPxbgTfv 8GUUHRsvaF4Ep1gxGTv5DLl3aPKwTSEWupRD4rVB3HRppt/dTgeZTcJ/FiWtZVgNSKVeZTbA6Xp
 lidc9L96tzI29OyW8iKor/pKr2quVuuhpdWeU/V3Stzrl7VPzuoqvL1ubSs9uymwtbMgZZLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030134

On 03.07.2025 01:50, Steven Rostedt wrote:
> On Tue, 1 Jul 2025 17:36:55 +0200
> Jens Remus <jremus@linux.ibm.com> wrote:
> 
>> On s390 the prev_frame_sp may be equal to curr_frame_sp for the topmost
>> frame, as long as the topmost function did not allocate any stack.  For
>> instance when early in the prologue or when in a leaf function that does
>> not require any stack space.  My s390 sframe support patches would
>> therefore currently change above check to:
>>
>> 	/* stack going in wrong direction? */
>> 	if (sp <= state->sp - topmost)
>> 		goto done;
> 
> How do you calculate "topmost" then?
> 
> Is it another field you add to "state"?

Correct.  It is a boolean set to true in unwind_user_start() and set to
false in unwind_user_next() when updating the state.

I assume most architectures need above change, as their SP at function
entry should be equal to the SP at call site (unlike x86-64 due to CALL).

s390 also needs this information to allow restoring of FP/RA saved in
other registers (instead of on the stack) only for the topmost frame.
For any other frame arbitrary register contents would not be available,
as user unwind only unwinds SP, FP, and RA.

I would post my s390 sframe support patches as RFC once you have
provided a merged sframe branch as discussed in:
https://lore.kernel.org/all/20250702124737.565934b5@batman.local.home/

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



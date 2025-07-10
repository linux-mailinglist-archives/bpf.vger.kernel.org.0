Return-Path: <bpf+bounces-62902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845EAFFE06
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 11:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5425917B9F5
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3207B296165;
	Thu, 10 Jul 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j5MCLfwm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF91293B70;
	Thu, 10 Jul 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139609; cv=none; b=F73yKqQ+aIefzxQDe9zn5+Rk8+hy/fXck5dHxBC3JUU4qEeXqc2vgAQO2d0GqW684UYwtYD98rUmfaoUMlEMS4W7UFpjse7+wekO0/AADHHG2zg522lHrx1pyiB/63Jyee0znuc11GCcxp5BM8CFcOS7l4JqwrraTN2I5H0VUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139609; c=relaxed/simple;
	bh=kIKp3Gsy4qp5Ac/VOuMRe7AuX/Ux88/cWFZbJ0cxPMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cvu6E+JUEwhcv8BcnAINTcT9E31KYgqXzKx//MUebIOi24fDOFdYf2BrK8Dkeup2ndjNPuit3MhkwkfqME9e7GoyceRbADWKomkTh7FdEJ1WueUTHnL9l4AACXHsRaqdHN4I7ooeHCmyW/jgRNbHxWpd1WOrfYKMoiqDz26FR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j5MCLfwm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A10DjP009207;
	Thu, 10 Jul 2025 09:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0prFwd
	hdgQT8WWTWLkwH2Bc9DrjL6QjOoGmwYgTo5BA=; b=j5MCLfwm+NagId5+yxBPHp
	10K1l/aCXRzOKn1RSh8ErwQ4j3MABPN+Nk8R1s7eLxkWPm5ZXBiS4pi95j9eflip
	cmIdtKecBfxWR23BhCXuO8JIPj9LKWXjbV3Sfz3FWzCmkrxU3/x6kdKNgmAZ8vfY
	rJIkZ8a9Y8sBLjrenkrRKZ5Y2uWJtkarPS9eXzUkBKV2QxOdm4tl4lCFgq8IY5LQ
	ZPH0enG8jxQVnwrUICyqO8TlUOKC7wGILBk6X8jS+An4pzD144j9OOJiVO1Vj4DH
	61KLX1V7YtFRLw2IVNLzrL93t50qqBSlAMDffpufArHDHFJ0rlvgmjrKXve7HP8g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb245x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 09:26:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A7WksD013562;
	Thu, 10 Jul 2025 09:26:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkm4q0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 09:26:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56A9QK2729229776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 09:26:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA0512004E;
	Thu, 10 Jul 2025 09:26:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D3AD20043;
	Thu, 10 Jul 2025 09:26:20 +0000 (GMT)
Received: from [9.152.222.235] (unknown [9.152.222.235])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 09:26:20 +0000 (GMT)
Message-ID: <768363f9-a04b-4c54-ba1c-bb48f17b76da@linux.ibm.com>
Date: Thu, 10 Jul 2025 11:26:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>,
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
References: <20250708021115.894007410@kernel.org>
 <20250708021159.386608979@kernel.org>
 <d7d840f6-dc79-471e-9390-a58da20b6721@efficios.com>
 <20250708161124.23d775f4@gandalf.local.home>
 <a52c508c-2596-49d1-bbe8-8a92599714f6@linux.ibm.com>
 <39cf3aab-7073-443b-8876-9de65f4c315e@efficios.com>
 <7250b957-2139-4c03-9566-a6ed9713584e@efficios.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <7250b957-2139-4c03-9566-a6ed9713584e@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3OSBTYWx0ZWRfX8Q6Bb6cv7NDA UWxUZt2tuOAOqNXYAHQSDX1cEWdOfFbdz2vxPZBt5zsXp9thPBZJdZYaiddw6v0MVm7An+YB95E XOLjvoeQmQMk69h7tdjnQYHJtr5K98rIR13em3hzP99jqFmsoGKQiXde4Pa+tLXWdmbiVkHyy5w
 cpmSC2pcbD7A21IvgEY4UD030QxFAi2OF4JQCPtBxWLU7KdPPLwm0cu4GTfmpr5bAyXb0wACDxH pXqXAHjDaZWSPkp9t8aVhjdnKGVGcJM6DFycZfJ6VB0IUjNtkg2Fe2E13Cyvc7SZQryteyRHY7Q quGs2UhfHQLfk5h3ak1ntn7TLMVB/egAxbfC2u0HCfA5OQtjTJVesVbgSursNWIR+tdE0OdgPiy
 5LF2S7zqwIQOJ+b4CtvoCjRwnLlQwdtvwWCpq9S4YP9jJo+npgncgwzi4Bdugwprlio849vP
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=686f8741 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=a9L8gB4W95wxkTyvaYMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: R2U_44eD1JowVai17296PMbh11yOz0sB
X-Proofpoint-GUID: R2U_44eD1JowVai17296PMbh11yOz0sB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100079

On 09.07.2025 15:51, Mathieu Desnoyers wrote:
> On 2025-07-09 09:46, Mathieu Desnoyers wrote:
>> I concur with Jens. I think we should keep track of both:
>>
>> 1) available unwind methods,
>>
>> 2) unwind method used for the current frame.
>>
>> E.g.:
>>
>> /*
>>   * unwind types, listed in priority order: lower numbers are
>>   * attempted first if available.
>>   */
>> enum unwind_user_type_bits {
>>          UNWIND_USER_TYPE_SFRAME_BIT = 0,
>>          UNWIND_USER_TYPE_FP_BIT = 1,
>>          UNWIND_USER_TYPE_COMPAT_FP_BIT = 2,
>>
>>      _NR_UNWIND_USER_TYPE_BITS,
>> };
>>
>> enum unwind_user_type {
>>          UNWIND_USER_TYPE_NONE = 0,
>>          UNWIND_USER_TYPE_SFRAME = (1U << UNWIND_USER_TYPE_SFRAME_BIT),
>>          UNWIND_USER_TYPE_FP = (1U << UNWIND_USER_TYPE_FP_BIT),
>>          UNWIND_USER_TYPE_COMPAT_FP = (1U <<  UNWIND_USER_TYPE_COMPAT_FP_BIT),
>> };
>>
>> And have the following fields in struct unwind_user_state:
>>
>> /* Unwind time used for the most recent unwind traversal iteration. */
>> enum unwind_user_type current_type;
>>
>> /* Unwind types available in the current context. Bitmask of enum unwind_user_type. */
>> unsigned int available_types;
>>
>> So as we end up adding stuff like registered JIT unwind info, we will
>> want to expand the "available types". And it makes sense to both keep
>> track of all available types (as a way to quickly know which mechanisms
>> we need to query for the current task) *and* to let the caller know
>> which unwind type was used for the current frame.
>>
>> And AFAIU we'd be inserting a "jit unwind info" type between SFRAME and FP in
>> the future, because the jit unwind info would be more reliable than FP. This
>> would require that we bump the number for FP and COMPAT_FP, but that would
>> be OK because this is not ABI.
>>
>> Thoughts ?
> 
> One use-case for giving the "current_type" to iteration callers is to
> let end users know whether they should trust the frame info. If it
> comes from sframe, then it should be pretty solid. However, if it comes
> from frame pointers used as a fallback on a system that omits frame
> pointers, the user should consider the resulting data with a high level
> of skepticism.

The current_type may be different for every unwind step (frame).  So
struct unwind_stacktrace would probably need the following added:

	/* Unwind types used for taking the stack trace.  */ 
	unsigned int used_types;

So that the user of unwind_user() could decide whether to trust the
stack trace.  But as Steve suggested in his reply, all of this could
be added later, once there is a need.

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



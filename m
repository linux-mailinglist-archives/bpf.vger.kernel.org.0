Return-Path: <bpf+bounces-62760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29405AFE1B1
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 09:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC4D541CF6
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D4427281C;
	Wed,  9 Jul 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pPGc7GW9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0FC271464;
	Wed,  9 Jul 2025 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047959; cv=none; b=rd5mKwBPnnB9YDEbJEIc8yzfiTD2sOHM/fZ6jGjbsnVKdftA5YTIEYLvDK8EWIlSMNxwQRqfdXo3ojqLYDr0swxokWMfzIAjgdDd9YieNsDMaua+A8zW70rj+SFgY+Mrgt0PtKFnaZBRuDyag1E84B2TsVC3G4w20ZwmbZHC6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047959; c=relaxed/simple;
	bh=gcfgyLAt80HK/pFOXuXIO8wiE3yov6zxZfRmn+8IgOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPuAvCsMVDKnFiVRGR9f4cYqBB4eY+ouo5Nv/O5QW6g9Wr3ypJB55GB3iYM/RM14//Ja16AGoG4/5+v5hr4XmLLFQ1abiAIGb+/RyeACniWodX6g8T1IqeWCNdxZ2coxAGPFh3T66Z5X6wJhoK2lIEJ9Vdq1FyB20HEMJqgEvto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pPGc7GW9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5691UWR5025387;
	Wed, 9 Jul 2025 07:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BGDxJ/
	vaABH2yJY8NkAWRS+OBoiLIlvFOmvSPzHwh/U=; b=pPGc7GW9J/r8Yin7foadsO
	KVLf5c6MeISFRV9pudsSZNHsHZZdOjqQrkMIZJAW0gLk9U2hQZX9NSlI1aVys2XB
	qSsOMRTLFqvaJClckpby2RtycDgzWOGvh4X/C0Q7qlM2+fdMW7GaVPgws5G1eYma
	cU5SKyYYQ4LcgfWyGAQ2wffepO/PQCfupqEAAU6WKsA60jfqFM93VuF63J+FtWc2
	dVjw8j87ffSUnh18TC27NyyC388/Q0oqV/4pHfkgcNk90p1otqQflfqK7NdGmrk5
	dWqPcCmQnCrwgTxpdNbiSPJVhXGvQEVqMRfwaXBZi7E3GIYkr8voqwVDmuP6uk1w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjr465u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 07:58:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5696NDbL021561;
	Wed, 9 Jul 2025 07:58:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectqbbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 07:58:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5697wR4F50856282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 07:58:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56EE52004E;
	Wed,  9 Jul 2025 07:58:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0472720040;
	Wed,  9 Jul 2025 07:58:27 +0000 (GMT)
Received: from [9.152.222.224] (unknown [9.152.222.224])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 07:58:26 +0000 (GMT)
Message-ID: <a52c508c-2596-49d1-bbe8-8a92599714f6@linux.ibm.com>
Date: Wed, 9 Jul 2025 09:58:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
To: Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250708161124.23d775f4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686e2127 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=7d_E57ReAAAA:8 a=ezEACFAaqmIMAGQNZSwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=jhqOcbufqs7Y1TYCrUUU:22
X-Proofpoint-ORIG-GUID: abKXwT1nh7gGYsYoZqNEmy3ES5wU0kxS
X-Proofpoint-GUID: abKXwT1nh7gGYsYoZqNEmy3ES5wU0kxS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA2OSBTYWx0ZWRfX7YFzwhXEa6ZN ZXPc45+PZV593iqYXOZ5NAgBq+ZWeEYbL7U0jcki8AZjG1Gvx/sf+EDUiduC+oP15J8wc4uBQNH Hqaux42jGKvGA/4xOCEGNYMrZxO8ic0fPxIv7lk49qxi0HnBbPjNpGwvdyuQIDNr5MRg3nvbwig
 A9XOsWQpDE30CyZqsons2GTQB8lqclaU0QjtGho5/4aoqEAn/zSMRkR2jI238AtCMWQq0EEEt3s SbjmNnUrhcsXrTkAnAO1ywXvozYwNcJ8pcRi3YrwxDf7MWFxgWjVspBSs/vt/i3p9qPwkp4Mzjj Aomhp4B5lvL+djzIwKv/+6CbnZpcE/XuiKQ4UxlOAUlHVHMYvDEC7oILd5TURkbgt2iUXT1TuGj
 l5q3LVvlUGvg0bSX56/fl3ODMcnFVlJFkRWjN7b6ngZ/MIQwZkpQ8FEEeny/S1DyVHIToa7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=882
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090069

On 08.07.2025 22:11, Steven Rostedt wrote:
> On Tue, 8 Jul 2025 15:58:56 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> @@ -111,6 +128,8 @@ static int unwind_user_start(struct unwind_user_state *state)
>>>   
>>>   	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
>>>   		state->type = UNWIND_USER_TYPE_COMPAT_FP;
>>> +	else if (current_has_sframe())
>>> +		state->type = UNWIND_USER_TYPE_SFRAME;  
>>
>> I think you'll want to update the state->type during the
>> traversal (in next()), because depending on whether
>> sframe is available for a given memory area of code
>> or not, the next() function can use either frame pointers
>> or sframe during the same traversal. It would be good
>> to know which is used after each specific call to next().
> 
> From my understanding this sets up what is available for the task at the
> beginning.
> 
> So once we say "this task has sframes" it will try to use it every time. In
> next we have:
> 
> 	if (compat_fp_state(state)) {
> 		frame = &compat_fp_frame;
> 	} else if (sframe_state(state)) {
> 		/* sframe expects the frame to be local storage */
> 		frame = &_frame;
> 		if (sframe_find(state->ip, frame)) {
> 			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
> 				goto done;
> 			frame = &fp_frame;
> 		}
> 	} else if (fp_state(state)) {
> 		frame = &fp_frame;
> 	} else {
> 		goto done;
> 	}
> 
> Where if sframe_find() fails and we switch over to frame pointers, if frame
> pointers works, we can continue. But the next iteration, where the frame
> pointer finds the previous ip, that ip may be in the sframe section again.
> 
> I've seen this work with my trace_printk()s. A function from code that is
> running sframes calls into a library function that has frame pointers. The
> walk walks through the frame pointers in the library, and when it hits the
> code that has sframes, it starts using that again.

I think Mathieu has a point, as unwind_user_next() calls the optional
architecture-specific arch_unwind_user_next() at the end.  The x86
implementation does state->type specific processing (for
UNWIND_USER_TYPE_COMPAT_FP).

> If we switched the state to just FP, it will never try to use sframes.
> 
> So this state is more about "what does this task have" than what was used
> per iteration.

While there is currently no fallback to UNWIND_USER_TYPE_COMPAT_FP that
would strictly require this, it could be useful to have both information.

Or the logic in unwind_user_start(), unwind_user_next(), and *_state()
may need to be adjusted so that state->type reflects the currently used
method, which unwind_user_next() determines and sets anew for every step.

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



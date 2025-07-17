Return-Path: <bpf+bounces-63596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6121FB08C85
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7960316AE3F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2B629DB9B;
	Thu, 17 Jul 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HS2k0NC/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841A29DB71;
	Thu, 17 Jul 2025 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754065; cv=none; b=UIM0g+muH8krRQMMflFkaTcS/IvJy8CQh+1yhU9/n2Dbxauna8Y4wXlL25bylwlINcGNWBY6AN5irdnEg9m11N5XsbeykkoAGAfizvwrkXJNBsZ2q4YC56ZW2JKrABrsoGJfTyGTCMkrwEvCQx9cJl+wiSIZigkrmjfuV8FWPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754065; c=relaxed/simple;
	bh=NaywgpXUfmk808d08shCS5CpSipsDBCVSUhV6te/H0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxQ/z3UPBpH+XXNXrXm+vqbmisbX6AVPjgf3nNOnbnvchbKlz75cIm/dUmvkaYyKXflDxxoxksZ5bVnHnhJTRYK5kbePldUY5qMFUBBHk3HQUmLwl0TP0AG1Z2KTV87ayFGp2FGusWRigSyq50m51kXf/nzHn8gBgKwDxsDx+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HS2k0NC/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H84OqQ009892;
	Thu, 17 Jul 2025 12:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fkQ5nh
	/pNLG66i3iwDVG1pCnJzB4owT2W6b4rH84xsQ=; b=HS2k0NC/Bu3MbmmmT+Qo4M
	nZ0s6vjkEdoeoSlXfinFFJKia4l5kgOVjy4pAfpDMj71QSdN2AEKJVOqFMfsGmS0
	fCIt9pllF9cRzN75Z1Y7ARrNav3+nxR3rlV91WEWRBx9ebvhJrW9gGXcuPsgi3nw
	49eY4BffeE1gM4boI7LjgJA0ST0m3M3JGuV70KFjkh1BAfxQhZap8b4sftdeo8dm
	J9bw19mi8/wTMompTfy4CicYD55XamimmBrGUIAQ4nZ6C0iGcThh4g3joauF7vB8
	mUgzWv1WkWaKjMnI2nGda3JlEtXwT1Cvc4JyB3pp/tEvad7cLfVCtEIHDxAvuI9Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7dasyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 12:07:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56H81xAt008135;
	Thu, 17 Jul 2025 12:07:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e0v700-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 12:07:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HC76Bf51446218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:07:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7C152004B;
	Thu, 17 Jul 2025 12:07:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B9F620043;
	Thu, 17 Jul 2025 12:07:05 +0000 (GMT)
Received: from [9.152.222.105] (unknown [9.152.222.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Jul 2025 12:07:05 +0000 (GMT)
Message-ID: <94e27f70-58f6-431d-9623-9c349a5977ff@linux.ibm.com>
Date: Thu, 17 Jul 2025 14:07:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 08/16] unwind_user: Enable archs that save RA/FP in
 other registers
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
 <20250710163522.3195293-9-jremus@linux.ibm.com>
 <oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
 <3he7rlcdchkwjtpbdt5khqflg4dipuvkneydhju2jjgs2ujqoh@2rpb6dutdogx>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <3he7rlcdchkwjtpbdt5khqflg4dipuvkneydhju2jjgs2ujqoh@2rpb6dutdogx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cxwyZyQTHxquzH2YNFyzrV9PufD81870
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=6878e770 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=6cQHZidUprn78mSFta8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cxwyZyQTHxquzH2YNFyzrV9PufD81870
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEwMyBTYWx0ZWRfX/xbY89F61XhH u9TKTO5Z7WdIW2tp4yZUU2qxmPvZay+5pA40IX5LdLJ3PREcXzfk6oeaFXhh+2RRWT19g0Vrbg0 DnZvvid7TXGiZfEwANAJGEsN4Two2xlU40Dhfl2LXUF74W3oOmAjA4xQX+y7Jb3qODSuFtFZ1Uy
 i4qgUJYTU+xYCvVklIaaoNU/yGmv69eI6jjr/5GkQ3BE5c5CkNJIwMf6/fivghJYa6/7DSTcwYE u+l2baK66DvWRkMYqRYFRn/B6adm3D3sKCVFZ23H+vo1Z3WphzXBnwGqP7F8ZIOkxUIWbL5a86u NLdWY4GjrAt3kTu0dEHrVAjJfzS+9j6fqKeba0XD6sFdEfbgZObA4v2vEfeVLZfkbmvwBA9p4uZ
 DopXQkANBPE+H6Q8bBxR4DIorUNhn5mwve6qFGjveJfgv5kT2Vf/GxSd1SXsYrRI/YBoNlkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170103

On 17.07.2025 04:50, Josh Poimboeuf wrote:
> On Wed, Jul 16, 2025 at 07:01:09PM -0700, Josh Poimboeuf wrote:
>>>  	state->ip = ra;
>>>  	state->sp = sp;
>>> -	if (frame->fp_off)
>>> +	if (frame->fp.loc != UNWIND_USER_LOC_NONE)
>>>  		state->fp = fp;
>>
>> Instead of the extra conditional here, can fp be initialized to zero?
>> Either at the top of the function or in the RA switch statement?

No, but fp could be initialized to state->fp, so that it retains its
value.

> So it's been a while since I looked at the original code, but I actually
> think there's a bug here.
> 
> There's a subtlety in the original code:
> 
> 	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
> 		goto done;
> 
> 	state->ip = ra;
> 	state->sp = cfa;
> 	if (frame->fp_off)
> 		state->fp = fp;
> 
> 	arch_unwind_user_next(state);
> 
> Note that unlike !frame->ra_off, !frame->fp_off does NOT end the unwind.
> That only means the FP offset is unknown for the current frame.  Which
> is a perfectly valid condition, e.g. if the function doesn't have frame
> pointers or if it's before the prologue.
> 
> In that case, the unwind should continue, and state->fp's existing value
> should be preserved, as it might already have a valid value from a
> previous frame.

I fully agree with all of the above.

> So the following is wrong:
> 
> 	case UNWIND_USER_LOC_STACK:
> 		if (!frame->fp.frame_off)
> 			goto done;
> 		if (unwind_get_user_long(fp, cfa + frame->fp.frame_off, state))
> 			goto done;
> 		break;
> 
> Instead of having !fp.frame_off stopping the unwind, it should just
> break out of the switch statement and keep going.

If frame->fp.loc is UNWIND_USER_LOC_STACK then frame->fp.frame_off must
have a value != 0.  At least if we keep the original semantic.

We can omit this check, if we assume all producers of frame behave
correctly.  For instance user unwind sframe would not produce that
(see below).  Could it somehow be made a debug-config-only check?

> And that means the following is also wrong:
> 
> 	state->ip = ra;
> 	state->sp = sp;
> 	if (frame->fp.loc != UNWIND_USER_LOC_NONE)
> 		state->fp = fp;
> 
> because state->fp needs to preserved for the STACK+!fp.frame_off case.

unwind user sframe will not produce that:

static inline void
sframe_init_reginfo(struct unwind_user_reginfo *reginfo, s32 offset)
{
	if (offset) {
		reginfo->loc = UNWIND_USER_LOC_STACK;
		reginfo->frame_off = offset;
	} else {
		reginfo->loc = UNWIND_USER_LOC_NONE;
	}
}

> So, something like this?
> 
> 	bool preserve_fp = false;
> 	...
> 
> 	/* Get the Frame Pointer (FP) */
> 	switch (frame->fp.loc) {
> 	case UNWIND_USER_LOC_NONE:
> 		preserve_fp = true;
> 		break;
> 	case UNWIND_USER_LOC_STACK:
> 		if (!frame->fp.frame_off) {
> 			preserve_fp = true;
> 			break;
> 		}
> 	...
> 
> 	state->ip = ra;
> 	state->sp = sp;
> 	if (!preserve_fp)
> 		state->fp = fp;

I don't think all of this is necessary.

frame->fp.loc == UNWIND_USER_LOC_NONE already indicates the state->fp
retains it's previous value.

> BTW, I would suggest renaming "frame_off" to "offset",
> "frame->fp.offset" reads better and is more compact.

Makes sense.  I'll change that.

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



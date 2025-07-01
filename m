Return-Path: <bpf+bounces-61955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EDCAEFE78
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56257A7621
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E96279DC3;
	Tue,  1 Jul 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hHyPz1B6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E41D5CC6;
	Tue,  1 Jul 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384268; cv=none; b=JxzN2ENVsrMX2pO6GHoSMsOp5JIhMhsmL/tEzPgm0v6c4c84SH94jhmbcvrmIbV/IjvjJU/SxxK7tVXI2WfLy/GuIFejah3WD6C944x/ObtJnalCH0nq815pxrTcxNzyYEeX5ygMH69v2Qcsnko/4ctu/SjV9LlUaDa6sqAy6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384268; c=relaxed/simple;
	bh=6wpryRMnDDKE/BFoP1AMkmw4nwDmAcGdbzoxKihmxa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBTfJhAB1Fg1MLbGEW0khBauq4tqZLWEJuSTBmP3TLaklopdECFgKM/Xf0Wta0Md7eoHhMYyMyPw9b4ZS3GQki5CmaEpcIm+stb/4yfIJZ7dtqgegRe6y9as92/edIeRVH9X8AiwkPnCahCB7DvNcinZtWdpIi6nrhcK0r8wrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hHyPz1B6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5617vJwl011661;
	Tue, 1 Jul 2025 15:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VnE8i7
	yDxme1281Y1pM272CwOTDiAbnhtGrHAcwV+dc=; b=hHyPz1B6avLBceIjtvg9Kn
	q5xbk1g3CqPg5gjuOWQPCoI9yUZWwmFJUSioqG2m404229+ZVGRcRKnM8J/Ya3kt
	UWp7CP4ycU/pXR3fLLK5j3BsCis9TMI88zz9+tRDE0G1XxQhoPae1gZRiEm69zsF
	jfyadm24hDGZ//Tob5nMjo1aqoh2xVQ2tv7QA13QTWpBZ5qRLQmL4zT17cwfWXcz
	ysgNysRjJPY8QZHD91q2HwQ19FGK5u3+CLPrGfaKfiv27OujovwACDTOAwpqviUo
	jU82A7o6xyTyIHEvqbzJspkP1L9qBPIJs+NhwoD5B2fqHj0GhLacLEBrvLGtL5oQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt8fyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 15:36:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 561DQJMN006928;
	Tue, 1 Jul 2025 15:36:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxmb2k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 15:36:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 561Fau6L45285742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 15:36:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0B2D2004E;
	Tue,  1 Jul 2025 15:36:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97E7920040;
	Tue,  1 Jul 2025 15:36:55 +0000 (GMT)
Received: from [9.152.222.224] (unknown [9.152.222.224])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 15:36:55 +0000 (GMT)
Message-ID: <a6a460e6-8cff-4353-a9e1-2e071d28e993@linux.ibm.com>
Date: Tue, 1 Jul 2025 17:36:55 +0200
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
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250630225603.72c84e67@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w9P4LMOdrWvgUUiT1PmRvsOe-G0TuFI1
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=6864009a cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=meVymXHHAAAA:8 a=_rDHVYAfWBUfgVP2reoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: w9P4LMOdrWvgUUiT1PmRvsOe-G0TuFI1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwMiBTYWx0ZWRfX4HgmYsLgk8Tr Y1S0lgg/l5m69uuVIXMDBqiBHdHcgY2Dk062312vnmRzTq0vweBM23ZnNNZnYnFj6S1/dsoUfAM jN5u6qncBB/ZifDdPmLetZPlOEwkjakEnR40VS2lBNutnIeBCK0oK2nMULsjX3Ek1gZCN+ngcMh
 fGIf6wnmJN08DzsIY88L607PIZUmGU9ASZwLzXcUWb92FfGo9wvR+Qr5IvjdGRhWDjBK8dJ3TIu At2afKWiD2PbTQUp1WDSPVg2Z4o++vPzSYLTP+p40nxDX3OjHYAb0kaX+rt0uDR7A5uF/BjKK+D aungzY52rPiFivbayioxpzuYS6jln6Q33eWpBdToKNmNSSNImDEM0Gge4mKpBvhk4blQ499a+sn
 vF0Cw7kpY5mqeUsDTEo0Y6synTOXPs8gAdjE1JP2P25/+6ezHZCxTq+6yNMsGmVFSD+ooOpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010102

On 01.07.2025 04:56, Steven Rostedt wrote:
> On Mon, 30 Jun 2025 19:10:09 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>> +       /* stack going in wrong direction? */
>>> +       if (cfa <= state->sp)
>>> +               goto done;  
>>
>> I suspect this should do a lot more testing.
> 
> Sure.

The above assumes:

	curr_frame_sp = state->sp
	prev_frame_sp = cfa   // for arches that define CFA as SP at call site

On s390 the prev_frame_sp may be equal to curr_frame_sp for the topmost
frame, as long as the topmost function did not allocate any stack.  For
instance when early in the prologue or when in a leaf function that does
not require any stack space.  My s390 sframe support patches would
therefore currently change above check to:

	/* stack going in wrong direction? */
	if (sp <= state->sp - topmost)
		goto done;

I assume that should be the case for all architectures whose function
call instruction does not modify the SP, unlike x86-64's CALL does.

>>> +       if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
>>> +               goto done;  
>>
>> .. and this should check the frame for validity too.  At a minimum it
>> should be properly aligned, but things like "it had better be above
>> the current frame" to avoid having some loop would seem to be a good
>> idea.
> 
> Makes sense.

On s390 the FP (register) value does not necessarily need to be above
the SP value, as the s390x ELF ABI does only designate a "preferred" FP
register, so that the FP register may be used for other purposes, when a
FP is not required in a function.

So the output FP value cannot be checked on s390.  But the input FP
value could probably be checked as follows before computing the CFA:

	if (frame->use_fp && state->fp < state->sp)
		goto done;

	/* Get the Canonical Frame Address (CFA) */
	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;

>> Maybe even check that it's the same vma?
> 
> Hmm, I call on to Jens Remus and ask if s390 can do anything whacky here?
> Where something that isn't allowed on other architectures may be allowed
> there? I know s390 has some strange type of stack usage.

On s390, if a FP is required for dynamic stack allocation, it is only
initialized as late as possible, that is usually after static stack
allocation.  Therefore SP == FP is rather seldom the case.

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



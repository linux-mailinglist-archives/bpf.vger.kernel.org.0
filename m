Return-Path: <bpf+bounces-63592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6FB08BB9
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 13:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0240717037E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84829AB13;
	Thu, 17 Jul 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lLMOqasw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E428935C;
	Thu, 17 Jul 2025 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751743; cv=none; b=jS9nE24oHWs3NO3yxgwXdflXL8PCFqBRMLtUwxe2i1O1ivl0RVZhGieN2QQqNU+lrgnElNt/auPsTx3SL1s+3C9HAG6ZM9y+c23IcYDcVJewNHQTQCS0iIf5yb/tdngksoKX6+Es/xwGZeWr3SrIrDlcp9dbahMzDnkO+VMO4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751743; c=relaxed/simple;
	bh=kzGkY7JKL+oPheWyIxkry6TqelxZeSbXNtwbYiwWVqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYutSzU73NUNx3wDHoiW+gH0QUSxDS6/YIao8xokHNrEGZu88EM9inQA7k4548RlGSwawhpIR5Us+9uwTw/sI2rhyQCsGsEiWFLkd+Mq47S78bTJCEa2IS6h4ST9CT61kcLJduoOKnu2gmdhppT/MRUfe9m03DXtGc2jOgmZByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lLMOqasw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9HNVG027865;
	Thu, 17 Jul 2025 11:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MsiVpe
	WOpoqOr99vGViu11zWrWDu+pDv0+cXEOGDnDA=; b=lLMOqaswnb/V6aJdecA8Y7
	jwEAbfPK2wToS7/HnWfBtD5XklyH+rjlOLGD4ZLvQUqQ0xKNArtPchzhhbq9BAJP
	MilY6Ii1q85bSQoI1+CDega1SA7Knn0IEPZMggBccSPhOB4vbe+bWPfr76M2nb7d
	6hTyoOYWp1IPeEeIf1xfUCLR6EXmLQkBV5R68zCsfxSeh+HFKFVrGiAMJJ46P1Iq
	DekgAWjLLYiOlXE84Fyc6kPS7XFbljvbyv8VIhjLff/9wvhJoNyvxNnf2XzdZmoV
	5a0EMHd8QGQ7wVB2ktlSVxCH9xgJ4YpPIigvz5brRrCWVnmxr7mdIOIBMXJFm7bw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamu5v9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 11:28:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56H819rt031903;
	Thu, 17 Jul 2025 11:28:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21uc4fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 11:28:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HBSQcK52691366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 11:28:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1735020043;
	Thu, 17 Jul 2025 11:28:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7C8120040;
	Thu, 17 Jul 2025 11:28:25 +0000 (GMT)
Received: from [9.152.222.105] (unknown [9.152.222.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Jul 2025 11:28:25 +0000 (GMT)
Message-ID: <6285a2b1-eb9b-4315-b960-cfaa99513ac1@linux.ibm.com>
Date: Thu, 17 Jul 2025 13:28:25 +0200
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
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9f1MEs6w3D4ZFzesLbcAi0V8sz3Q2bTy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA5OSBTYWx0ZWRfX39WTLE7dfTTI SZ93ysZqnVGO+28E4EPb93MAEDLhb0WhtUYgJ97KhWM3eIRzhMvSF7RrG2GRXB3s9+5Kbj6O4E1 Z0M2Z3WIYxk/9DEWaxkT6C8xCT2S0Pg1ehLXR/7ND3XE3YAC0+Isj2ozfBs65K3fUGWITW3heDU
 s3abHg17zlWeNBYsds7reMCubFFbt7kYpxkCOCI5IHR3T9HrTjd9jpFeyUnMu2pf4Xy7mtV4gps eG30geSbXNpCCiRrtcLg2cIq0WyosTqML+wX3P4uKDj0R2rLRIc6QTS4bpm2eYI03RZoo0Ls/23 nB2amcPpD4yOB5bAqtwADY0/hPRhlnqTI39dYfM3gksaQRQ69CpS7BOpRX5cSyLOvabhFIVrAHP
 CDPAnsQ7UqVCsDO2L/kkqHDUVN9y54y6DKThR1eNWubagUAOVtkk1lAeMLh+c3z3/S7i4MX2
X-Proofpoint-ORIG-GUID: 9f1MEs6w3D4ZFzesLbcAi0V8sz3Q2bTy
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=6878de5f cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=o1T9f-mJ__uqyuaix_cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170099

On 17.07.2025 04:01, Josh Poimboeuf wrote:
> On Thu, Jul 10, 2025 at 06:35:14PM +0200, Jens Remus wrote:
>> +#ifndef unwind_user_get_reg
>> +
>> +/**
>> + * generic_unwind_user_get_reg - Get register value.
>> + * @val: Register value.
>> + * @regnum: DWARF register number to obtain the value from.
>> + *
>> + * Returns zero if successful. Otherwise -EINVAL.
>> + */
>> +static inline int generic_unwind_user_get_reg(unsigned long *val, int regnum)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +#define unwind_user_get_reg generic_unwind_user_get_reg
>> +
>> +#endif /* !unwind_user_get_reg */
> 
> I believe the traditional way to do this is to give the function the
> same name as the define:
> 
> #ifndef unwind_user_get_reg
> static inline int unwind_user_get_reg(unsigned long *val, int regnum)
> {
> 	return -EINVAL;
> }
> #define unwind_user_get_reg unwind_user_get_reg
> #endif

Thanks!  I will use use suggestion.

>> +/**
>> + * generic_sframe_set_frame_reginfo - Populate info to unwind FP/RA register
>> + * from SFrame offset.
>> + * @reginfo: Unwind info for FP/RA register.
>> + * @offset: SFrame offset value.
>> + *
>> + * A non-zero offset value denotes a stack offset from CFA and indicates
>> + * that the register is saved on the stack. A zero offset value indicates
>> + * that the register is not saved.
>> + */
>> +static inline void generic_sframe_set_frame_reginfo(
>> +	struct unwind_user_reginfo *reginfo,
>> +	s32 offset)
>> +{
>> +	if (offset) {
>> +		reginfo->loc = UNWIND_USER_LOC_STACK;
>> +		reginfo->frame_off = offset;
>> +	} else {
>> +		reginfo->loc = UNWIND_USER_LOC_NONE;
>> +	}
>> +}
> 
> This just inits the reginfo struct, can we call it sframe_init_reginfo()?
> 
> Also the function comment seems completely superfluous as the function
> is completely obvious.
> 
> Also the signature should match kernel style, something like:
> 
> static inline void
> sframe_init_reginfo(struct unwind_user_reginfo *reginfo, s32 offset)

Ditto.

>> @@ -98,26 +98,57 @@ static int unwind_user_next(struct unwind_user_state *state)
>>  
>>  
>>  	/* Get the Return Address (RA) */
>> -	if (frame->ra_off) {
>> +	switch (frame->ra.loc) {
>> +	case UNWIND_USER_LOC_NONE:
>> +		if (!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost)
>> +			goto done;
>> +		ra = user_return_address(task_pt_regs(current));
>> +		break;
>> +	case UNWIND_USER_LOC_STACK:
>> +		if (!frame->ra.frame_off)
>> +			goto done;
>>  		/* Make sure that the address is word aligned */
>>  		shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
>> -		if ((cfa + frame->ra_off) & ((1 << shift) - 1))
>> +		if ((cfa + frame->ra.frame_off) & ((1 << shift) - 1))
>>  			goto done;
>> -		if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
>> +		if (unwind_get_user_long(ra, cfa + frame->ra.frame_off, state))
>>  			goto done;
>> -	} else {
>> -		if (!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost)
>> +		break;
>> +	case UNWIND_USER_LOC_REG:
>> +		if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_LOC_REG) || !topmost)
>>  			goto done;
>> -		ra = user_return_address(task_pt_regs(current));
>> +		if (unwind_user_get_reg(&ra, frame->ra.regnum))
>> +			goto done;
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		goto done;
> 
> The default case will never happen, can we make it a BUG()?

Whatever Steve and you agree on.  I am new to Kernel development.

>>  	}
>>  
>>  	/* Get the Frame Pointer (FP) */
>> -	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
>> +	switch (frame->fp.loc) {
>> +	case UNWIND_USER_LOC_NONE:
>> +		break;
> 
> The UNWIND_USER_LOC_NONE behavior is different here compared to above.

See my comments below.

> Do we also need UNWIND_USER_LOC_PT_REGS?

Sorry, I cannot follow.  Do you suggest to rename UNWIND_USER_LOC_REG to
UNWIND_USER_LOC_PT_REGS?

>> +	case UNWIND_USER_LOC_STACK:
>> +		if (!frame->fp.frame_off)
>> +			goto done;
>> +		if (unwind_get_user_long(fp, cfa + frame->fp.frame_off, state))
>> +			goto done;
>> +		break;
>> +	case UNWIND_USER_LOC_REG:
>> +		if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_LOC_REG) || !topmost)
>> +			goto done;
> 
> The topmost checking is *really* getting cumbersome, I do hope we can
> get rid of that.

Restoring from arbitrary registers is only valid in the topmost frame,
as their values (i.e. task_pt_regs(current)) are only available there.
For other frames only SP, FP, and RA register values are available.

I think this test makes sense.  Is this test really that expensive?

>> +		if (unwind_user_get_reg(&fp, frame->fp.regnum))
>> +			goto done;
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>>  		goto done;
>> +	}
> 
> BUG(1) here as well.

Same as for other WARN_ON_ONCE() vs. BUG().

>>  	state->ip = ra;
>>  	state->sp = sp;
>> -	if (frame->fp_off)
>> +	if (frame->fp.loc != UNWIND_USER_LOC_NONE)
>>  		state->fp = fp;
> 
> Instead of the extra conditional here, can fp be initialized to zero?
> Either at the top of the function or in the RA switch statement?

No.  But fp could be initialized to state->fp, so that when it is not
saved and thus not restored it keeps it previous value.

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



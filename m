Return-Path: <bpf+bounces-76288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48CCAD9E1
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 16:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C8FF30450B3
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E747A2C237F;
	Mon,  8 Dec 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ab6JqRi4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985C26FA57;
	Mon,  8 Dec 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208335; cv=none; b=Lr2U2Vf5astyWV9ioNlzHqud2gEIfcWQh4AUAdwiAr/qshZSX1yOSDYQiSTCFG+4qeG7JHjlMcBU2S/iMXksimlb3SmHayn7IWZPbTrOVuFoM4bAdINXVTlAazDdnjnydri+r1VVRwRLAgcxHiCUVVhZ3D4BtDl4Zu0N6SzXNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208335; c=relaxed/simple;
	bh=pkL1PGlWK6kWiB9mGkCiNgzfBCMk+SB9F42d4ZU4ctU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTENy8uKOMvu6gp7IqzaoMAAcuZ5w/mz9j1yGR8dEPFDJaTXa6Ghc6UAzdb0WWI/0TRBgfJpsw2A2zErpAbIxGUA3b7TYq2T339NU8gt6cN3AQW8/i7B29/jM3UokiGsvGW2AMPryGP/lE1LR4O3hPsuJvuUpVRo+My8fTTJLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ab6JqRi4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B85Dlre024537;
	Mon, 8 Dec 2025 15:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8du7Uo
	GnN7LbZDj2cDJ1DGYJrS5D2TMQb4FpDdleGeY=; b=Ab6JqRi4t6h+RrKMjCEfRd
	jUx/dkMOZ5N90KIc1A5GMbOCAwAm8FHGzmMwnjE/5Lzk5iCmxyC5P0Gp6c1cWCwH
	U7vOYjP13p3wA/1s9d/+afUQc27dMvWjtVtbkOawAo5mE+NYTgvwztEmBDaoMADQ
	1Z43BJ4Dl0xalJ1E603ybSjodoVWifF7pZFRVcJ0uIbByUUqr/iEK9Cv2OvC9mM5
	cA5lbyIeAIvB6xYWIP0SZ1KaYYSRvuQ1YIGRzwRgwjIetLSpUwy7WA5jSQf7RO3Y
	x/VX7qBOJ6o5Xx9fpWowGRFMsyycij4UYkZKR0FPGwvD7GIQ4+lOdINnGsfgutcw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc618f62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 15:38:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8FCpTD011780;
	Mon, 8 Dec 2025 15:38:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc618f5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 15:38:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8EWkBD028147;
	Mon, 8 Dec 2025 15:38:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6xpf3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 15:38:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8FcIP534603340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 15:38:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E75D520040;
	Mon,  8 Dec 2025 15:38:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CC0C2004E;
	Mon,  8 Dec 2025 15:38:16 +0000 (GMT)
Received: from [9.111.221.3] (unknown [9.111.221.3])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 15:38:16 +0000 (GMT)
Message-ID: <11b2438c-ef1f-423f-96c9-3005a75ec008@linux.ibm.com>
Date: Mon, 8 Dec 2025 16:38:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 14/15] unwind_user/backchain: Introduce back chain
 user space unwinding
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
References: <20251205171446.2814872-1-jremus@linux.ibm.com>
 <20251205171446.2814872-15-jremus@linux.ibm.com>
 <iidpbjmxnjf3zu4fa3atiubgb365yonv4gymaj76l6jvuxy67s@2y5o4txs4vhr>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <iidpbjmxnjf3zu4fa3atiubgb365yonv4gymaj76l6jvuxy67s@2y5o4txs4vhr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX1grYLRgFzTZ3
 6Bw2Y4KLfWHcTiIY8Y+q/40vMo5DISBPf6WqrACaJC3lTWr3YuNditWdGBvOE50K7FO18iHLYkL
 N+q1ZC8XPnvBwcoqJfdSAfOGem02OMhjdPnKO9MI5Q4zgIbhTpkemspxKuBdCj4Rn+eiIOB8Yug
 jzP2KFajjhB9mPqExO/heQEaiD1fkTNaF8pi8h7StawqzRXDb1VLiLurUW5jffw4zQ7RphSGH1I
 RKL6ciLTTZexBxhJFh2Vzgqal3IQxN6ZvqlZg9zUV7SQs/00pUWBtai9/7H44N4lhMqA9k3B8S8
 bJmFNkhIDZLiqxjQtuzK0ZoGuhwf72Ycxn8DUippxtkLbYsSlQaT2WQfb6j1OwwfDq9Fqo4uFQ9
 H0mnb1/3gsQqmX0zZDtlGk2SX3uRDA==
X-Proofpoint-GUID: DXuAST9Co_tE0Nz77KIRNVh0G2HS3M53
X-Proofpoint-ORIG-GUID: J4Duk8KbAVtSEM7aBteiKz0qR3AIXoxE
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=6936f0f0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Hello Josh,

thank you for your feedback!

On 12/7/2025 4:10 PM, Josh Poimboeuf wrote:
> On Fri, Dec 05, 2025 at 06:14:45PM +0100, Jens Remus wrote:
>> @@ -159,6 +165,10 @@ static int unwind_user_next(struct unwind_user_state *state)
>>  			if (!unwind_user_next_fp(state))
>>  				return 0;
>>  			continue;
>> +		case UNWIND_USER_TYPE_BACKCHAIN:
>> +			if (!unwind_user_next_backchain(state))
>> +				return 0;
>> +			continue;		/* Try next method. */
>>  		default:
>>  			WARN_ONCE(1, "Undefined unwind bit %d", bit);
>>  			break;
>> @@ -187,6 +197,8 @@ static int unwind_user_start(struct unwind_user_state *state)
>>  		state->available_types |= UNWIND_USER_TYPE_SFRAME;
>>  	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
>>  		state->available_types |= UNWIND_USER_TYPE_FP;
>> +	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_BACKCHAIN))
>> +		state->available_types |= UNWIND_USER_TYPE_BACKCHAIN;
> 
> Any reason not to just use the existing CONFIG_HAVE_UNWIND_USER_FP hook
> here rather than create the new BACKCHAIN one?

At first I thought this would not be a good idea, as my unwind user
backchain implementation relies on being standalone without using
unwind_user_next_common().  Mainly because s390 back chain unwinding
does not have fixed CFA, FP, and RA offsets/locations.  But then I gave
it a try and it does not look that bad actually.

I'll send a RFC v3 soon.

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



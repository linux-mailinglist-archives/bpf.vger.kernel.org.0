Return-Path: <bpf+bounces-63916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4E6B0C63F
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 16:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8BE162F20
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94ED2DA77B;
	Mon, 21 Jul 2025 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BfM3j+Bz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FBA288CBC;
	Mon, 21 Jul 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107986; cv=none; b=i7x5rBlx1P0YF9wLYfX6crhqh607JT05Gfyc0PATXC8fnMDVoFc4tNov7SVsGzbk+XA6ihRAtVVumlSxxGd6wgjiGAmpTmkCsXIlvHpl/Lb8sFK8EMEDYf7Lnp/NTSHaXaQmR50nDSotMwS4S39Y+8wteWulk0vtgOmBt3GGt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107986; c=relaxed/simple;
	bh=mXqf4kZRhWIYimloxKUca5CW3PISaQyAM6BHPB0FIng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjYtUENGbWbHFi/LazE4wwikbhXtXP2JWuJeJxARkV3S3MHemzyQK1XMnrA1e1P+OjuBGyhxmP3RcrFve0j0vowU/NYdRpWNFZQm8g+5DMLiF6M3wluTdD+mMX9/UhkldIKUOFh7hFc55brn/b2g5n/XmvcpINWddGoVOCp++L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BfM3j+Bz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LD1qg2004118;
	Mon, 21 Jul 2025 14:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DpXEFm
	psL/uejUaSCqDsLguZE4hM1Juw7P/LXkKLY7w=; b=BfM3j+Bz3vOjW5nbjzzlnt
	UjVpX116beOqq1yVBjfJAKVtIqDEbA3gLnnEyeU7vL+HA0xfNFmGxhejD2NJ8x2v
	lYMDlDPP9eLN8r43ujvECZlG+uzTIsqNNyryW05TlhGxR9gOqNMoynXn1Eb5FSWc
	OtLhSa2d7DOMJ+EXH/dGNTKnkbsJUNR3hfMp8F9KUgk/IAFDBNz7yBBMyvcPuBoP
	mXdlzCUFzjRilp+WmsaKcLsCHDJ4bk4KT0UPrqZT4MArvigwqo0w0uGRP+vkI0u+
	YIkE+0+GZGksP2QEBW+14ue7/buheoThM5mpH1vWj4n8InazeDvJttLSTHjlzp9A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqs37v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:25:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LDZbtV024697;
	Mon, 21 Jul 2025 14:25:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd269b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:25:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56LEPKTk56492416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 14:25:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ECE320043;
	Mon, 21 Jul 2025 14:25:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 553DA20040;
	Mon, 21 Jul 2025 14:25:19 +0000 (GMT)
Received: from [9.111.162.57] (unknown [9.111.162.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Jul 2025 14:25:19 +0000 (GMT)
Message-ID: <535441e9-598b-4e9b-a58c-f71665fdf604@linux.ibm.com>
Date: Mon, 21 Jul 2025 16:25:18 +0200
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
 <b5121d71-f916-45ea-9e6c-b74a27f90dcd@linux.ibm.com>
 <fb9ee560-d449-4d46-9fb1-19780ff28e65@linux.ibm.com>
 <v6gwx63cd5divimoadofeuz2vn72uw7zrlcjacufaedeuxbvjc@qmobatrxo66u>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <v6gwx63cd5divimoadofeuz2vn72uw7zrlcjacufaedeuxbvjc@qmobatrxo66u>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TmUSIRmYBWDVV6mXmC9vpUJ7TEsV9EHb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEyNiBTYWx0ZWRfXwXGSz/OGE1Gc
 1k5YjKok9cgPK0KyR7m1Er0gmQoSDEdjKI1ykCVFeuR9Xbi9ql12cgWRagl2AByS3oI6BA1VkK2
 3B7NMtqUvDCzxNjBB1PYflhBRNkVWymehiAyORcGDG7YDjkhUiECoBG4kEBMX4GMT2hRAHZPyai
 kj003kRcBkNXHqABYa7i1bHEwAXxjTWEMf4XuX7qaGPsBn0XLjqiOqADhhI2tsfchH43ufrcO6+
 90FPojzFgpiyImeJpul5n7cUDPowGzt1E4E6QA95XFuzY6lNw5WhNfR0+p0qDvkHL/Pg4gvO2Kb
 F8J2M+Nyj6cMASoQWtqs/cO0KBu5I9oQ0FbU/xDwlY1xKsqeA/xxC4nBb7WKJcm6WZfYyIL1gZF
 p+kKY5p2uCeXCMdgo83nTz5shjY5xRdlMy+3c1LAjfHNnLdk8Qy2yQcB6CG1xDw/vCVsGCFz
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687e4dd5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=9wLNxxeGkzmh2-3Zz7cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TmUSIRmYBWDVV6mXmC9vpUJ7TEsV9EHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210126

Hello Josh,

thank you very much for your valuable feedback!

On 18.07.2025 18:59, Josh Poimboeuf wrote:
> On Fri, Jul 18, 2025 at 10:28:32AM +0200, Jens Remus wrote:
>> On 17.07.2025 13:09, Jens Remus wrote:
>>> On 17.07.2025 01:01, Josh Poimboeuf wrote:
>>>> On Thu, Jul 10, 2025 at 06:35:13PM +0200, Jens Remus wrote:
>>>>> +++ b/arch/Kconfig
>>>>> @@ -450,6 +450,11 @@ config HAVE_UNWIND_USER_SFRAME
>>>>>  	bool
>>>>>  	select UNWIND_USER
>>>>>  
>>>>> +config HAVE_USER_RA_REG
>>>>> +	bool
>>>>> +	help
>>>>> +	  The arch passes the return address (RA) in user space in a register.
>>>>
>>>> How about "HAVE_UNWIND_USER_RA_REG" so it matches the existing
>>>> namespace?
>>>
>>> Ok.  I am open to any improvements.
>>
>> Thinking about this again I realized that the config option actually
>> serves two purposes:
>>
>> 1. Enable code (e.g. unwind user) to determine the presence of the new
>>    user_return_address().  That is where I derived the name from.
>> 2. Enable unwind user (sframe) to behave differently, if an architecture
>>    has/uses a RA register (unlike x86, which solely uses the stack).
> 
> The sframe CONFIG_HAVE_USER_RA_REG check is redundant with the
> unwind_user one, no?  I'm thinking it's better for sframe to just decode
> the entry as it is, and then let unwind_user validate things.

Ok.  Makes sense.

>> I think the primary notion is that an architecture has/uses a register
>> for the return address and thus provides user_return_address().  What
>> consumers such as unwind user do with that info is secondary.
>>
>> Thoughts?
> 
> user_return_address() only has the single user, and is not all that
> generically useful anyway (e.g., it warns on x86), so let's keep it
> encapsulated in include/linux/unwind_user.h and give it the
> "unwind_user" prefix.

Ok.  I was hesitating to add it to ptrace.h.  Given it falls into the
same category as user_stack_pointer() and frame_pointer() I was
astonished it did not yet exist.  But given unwind user would be the
single user I agree that it is better to do as you suggest.

> Also, "RA_REG" is a bit ambiguous, it sounds almost like that other
> option which spills RA to another register.  Conceptually, it's a link
> register, so can we rename that to CONFIG_HAVE_UNWIND_USER_LINK_REG and
> unwind_user_get_link_reg() or so?

The terminology in DWARF and SFrame is return address (RA) register.
AArch64 uses link register (LR). s390 uses RA register. x86 uses return
address.  While I am open to use your suggestion, I wonder what others
would prefer.

In fact the whole option is not required, if using '#define fname fname'
instead (that you suggest not to down below).  user_unwind.c would then
contain the following as default for architectures that do not define
their custom implementation (or link_reg instead of ra_reg):

#ifndef unwind_user_get_ra_reg
int unwind_user_get_ra_reg(unsigned long *val)
{
	WARN_ON_ONCE(1);
	return -EINVAL;
}
#define unwind_user_get_ra_reg unwind_user_get_ra_reg
#endif

The commit subject should better be changed to one of the following
(with the commit message reworded accordingly):

unwind_user: Enable archs that have a RA register
  or
unwind_user: Enable archs that have a link register

> Similarly, CONFIG_HAVE_UNWIND_USER_LOC_REG isn't that descriptive, how
> about CONFIG_HAVE_UNWIND_USER_LINK_REG_SPILL?

Are you perhaps mixing up two of the new config options introduced by
this and the subsequent patch?

HAVE_USER_RA_REG (introduced by this patch): Indicates the architecture
has/uses a RA/LR register.  I would be fine to rename this to
"CONFIG_HAVE_UNWIND_USER_LINK_REG" (as you suggest), provided "link
register" is the terminology we can all agree on, although DWARF and
SFrame use "return address register".  Otherwise
"CONFIG_HAVE_UNWIND_USER_RA_REG" or even omit, if there is no need for
the option at all.

CONFIG_HAVE_UNWIND_USER_LOC_REG (introduced by the subsequent patch):
Indicates that the architecture may save registers in other registers.
Those support UNWIND_USER_LOC_REG (location register) in addition to
UNWIND_USER_LOC_STACK (location stack).  Note that this applies to
both FP and RA.

> Also we can get rid of the '#define func_name func_name' things and just
> guard those functions with their corresponding CONFIG options in
> inclide/linux/unwind_user.h.
> 
> Also those two functions should have similar naming and prototypes.
> 
> For example, in include/linux/unwind_user.h:
> 
> #ifndef CONFIG_HAVE_UNWIND_USER_LINK_REG
> int unwind_user_get_link_reg(unsigned long *val)
> {
> 	WARN_ON_ONCE(1);
> 	return -EINVAL;
> }
> #endif
> 
> #ifndef CONFIG_HAVE_UNWIND_USER_LINK_REG_SPILL
> int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
> {
> 	WARN_ON_ONCE(1);
> 	return -EINVAL;
> }
> #endif

Is a config option actually required (see above)?  The reason I added
them was to perform checks, that you suggest to omit.  Your below code
suggestion would no longer required the config options at all.  What
is preferable?  The config option would ensure a build error if an
architecture enables the option without providing the arch-specific
implementations.

> Then the code can be simplified (assuming no topmost checks):
> 
> 	/* Get the Return Address (RA) */
> 	switch (frame->ra.loc) {
> 	case UNWIND_USER_LOC_NONE:
> 		if (unwind_user_get_link_reg(&ra))
> 			goto done;
> 		break;
> 	...
> 	case UNWIND_USER_LOC_REG:
> 		if (unwind_user_get_reg(&ra, frame->ra.regnum))
> 			goto done;
> 		break;
> 	...

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/



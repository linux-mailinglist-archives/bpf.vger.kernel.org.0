Return-Path: <bpf+bounces-76527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D0BCB873A
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 10:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE17D305DCFB
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD53126BE;
	Fri, 12 Dec 2025 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GLV1uZB0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ECE311973;
	Fri, 12 Dec 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531331; cv=none; b=fqE5wOxLb7r05zVooTVTaJg0b1wYmVh0KzMVbl8I/ybzkkZ2DyfA4OyxLGcGAUJu/LRuzF5CbsgBZudFXqRwS3BWa5a6W8vvTEJ/+g4ZNuoD7ESFOgV8JQUQ9w0AfgumGqnDQr9S8yv9NZNLB0+NzFCpLgZVxf/IC/has38DJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531331; c=relaxed/simple;
	bh=G4/Ro5h/dXWSgGT4bi8LaimRNYvzCb1QNsi4W/ft1OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0VD1miETHZV6YhLtBroEd6tSNzn3EV5Gwj0DJphHpFM9moGYzKceb+MARgF9+BskAmN3n7qfheUpv5arbt0uwlLB5QsRLebxrQjICfuEKd2EN4DNBbqEfiCWXRr7pHuqhYjYDFI1oKP0QXgk+7KKeDHiUjtHXw+aiEgJMf6ZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GLV1uZB0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC92JKO022802;
	Fri, 12 Dec 2025 09:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1SVc7R
	vjSkKvbeeSy9JkHiRgrtVWX/MI2JfZ5mhQsHM=; b=GLV1uZB063h2nQkRdH909x
	cTkKipDeehdUcjcKGosyWCnUtzFaLW1brhgVI/mMGZ2HBuLbry/Kka3d0B4CciGQ
	66sDRrdItBK9Ek/+d0LIQyj9xi40iCji2aBulSfU+okbX3Z5bFn3LFv9QZbBcuNq
	c4GPp/8F9RNG+9mhNplXfnhe6nRfSHmhLfL4xdm1PO9pNQspRmEBdDp/EMivnnyd
	H9KF+k1YftPqWbvvQnwTHfJNpErZ1AloKL5cBbmq5s/qwNJGhl7r/j9GqZdcU6Nt
	7J6kt9/FtLi+MrdK4+OzanOih/X4A8MdLjOrxBE9eGsToIwz5EG67dN2mezD55zw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww3v0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 09:21:45 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BC9FG02018648;
	Fri, 12 Dec 2025 09:21:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww3v0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 09:21:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC6bscd008391;
	Fri, 12 Dec 2025 09:21:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytnb461-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 09:21:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BC9LecK42598670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 09:21:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEA702004D;
	Fri, 12 Dec 2025 09:21:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81E4020040;
	Fri, 12 Dec 2025 09:21:38 +0000 (GMT)
Received: from [9.111.169.84] (unknown [9.111.169.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Dec 2025 09:21:38 +0000 (GMT)
Message-ID: <e38c0be1-52af-49a0-8bbc-1148ad3cc32e@linux.ibm.com>
Date: Fri, 12 Dec 2025 10:21:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 17/17] s390/unwind_user/fp: Enable back chain
 unwinding of user space
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
 <20251208171559.2029709-18-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251208171559.2029709-18-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rDt31-Fuxu1pHN2xDfNuEfS8dlGf87xF
X-Proofpoint-ORIG-GUID: k-yP8sNeYnLD5LApFVd7kYBCz2H_w0ye
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=693bdea9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=fMs-5SPQQjTgPQFwRbIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX4c9yzRJsDN42
 DlLvmi1NfoNTQqS3/EBrFWyYMHUOtEeZefS7FiMSrxjNBXUAiLC1i8wjUeV1Afeknakgy15aik6
 5Ad6iK0+6hT92W7DdYOCWOPS/lhu+gPyKMsC0gdVjdS8N1lTPTvZB0QhWGXf7SKnEBGWseZAn5N
 xDTY2yvqL909dItjqM/Y2UyLuTl3ExBperl6clM9VcH6k5sdQOHe79bha8u4iatWulKPXdg6hg9
 +SRd/RZNXdfk3p/AeiagwCHisSiENN5XAlu/8W0mVMEUAj/gsUWwT2ho1yfNPJeja152dt0cst6
 uox36ag20AXgddYPV8aakcmuMJC3SzRRgMKPrRVW3moFXm5cioXa3gpCsyKJlE2uOGwtR7WvauD
 QepDFf9f26HRZhxQJ27LuNAV+kDnOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

On 12/8/2025 6:15 PM, Jens Remus wrote:

...

> Leverage the unwind user fp infrastructure to enable unwinding of user
> space using back chain.  Enable HAVE_UNWIND_USER_FP and provide a s390-
> specific implementation of unwind_user_fp_get_frame(), which uses the
> back chain.

> diff --git a/arch/s390/include/asm/unwind_user.h b/arch/s390/include/asm/unwind_user.h

> +static inline int unwind_user_fp_get_frame(struct unwind_user_state *state,
> +					   struct unwind_user_frame *frame)
> +{
> +	struct stack_frame_user __user *sf;
> +	unsigned long __user *ra_addr;
> +	unsigned long sp;
> +
> +	sf = (void __user *)state->sp;
> +
> +	/*
> +	 * In topmost frame check whether IP in early prologue, RA and SP
> +	 * registers saved, and no new stack frame allocated.
> +	 */
> +	if (state->topmost) {
> +		unsigned long ra, ra_reg;
> +
> +		ra_addr = (unsigned long __user *)&sf->gprs[8];
> +		if (__get_user(ra, ra_addr))
> +			return -EINVAL;
> +		if (__get_user(sp, (unsigned long __user *)&sf->gprs[9]))
> +			return -EINVAL;
> +		if (unwind_user_get_ra_reg(&ra_reg))
> +			return -EINVAL;
> +		if (ra == ra_reg && sp == state->sp)
> +			goto done;
> +	}

I realized that this additional heuristic is flawed:

The topmost function may be past prologue, have allocated a new stack
frame, and called a function.  The callee may have saved its RA and SP
registers in the current stack frame, so that after the return from
function call, the heuristic would erroneously assume that the topmost
function is in early prologue and use the callee's RA and SP.

Instead of erroneously skipping the caller it might erroneously insert
a callee as caller.  I'll remove it again in the next version.

> +
> +	if (__get_user(sp, (unsigned long __user *)&sf->back_chain))
> +		return -EINVAL;
> +	if (!sp && ip_within_vdso(state->ip)) {
> +		/*
> +		 * Assume non-standard vDSO user wrapper stack frame.
> +		 * See vDSO user wrapper code for details.
> +		 */
> +		struct stack_frame_vdso_wrapper *sf_vdso = (void __user *)sf;
> +
> +		ra_addr = (unsigned long __user *)&sf_vdso->return_address;
> +		sf = (void __user *)((unsigned long)sf + STACK_FRAME_VDSO_OVERHEAD);
> +		if (__get_user(sp, (unsigned long __user *)&sf->back_chain))
> +			return -EINVAL;
> +	} else if (!sp) {
> +		/*
> +		 * Assume outermost frame reached. unwind_user_next_common()
> +		 * disregards all other fields in outermost frame.
> +		 */
> +		frame->outermost = false;

		frame->outermost = true;

> +		return 0;
> +	} else {
> +		/*
> +		 * Assume IP past prologue and new stack frame allocated.
> +		 * Follow back chain, which then equals the SP at entry.
> +		 * Skips caller if wrong in topmost frame.
> +		 */
> +		sf = (void __user *)sp;
> +		ra_addr = (unsigned long __user *)&sf->gprs[8];
> +	}
> +
> +done:
> +	frame->cfa_off = sp - state->sp + 160;
> +	frame->sp_off = -160;
> +	frame->fp.loc = UNWIND_USER_LOC_UNKNOWN;	/* Cannot unwind FP. */
> +	frame->use_fp = false;
> +	frame->ra.loc = UNWIND_USER_LOC_STACK;
> +	frame->ra.offset = (unsigned long)ra_addr - (state->sp + frame->cfa_off);
> +	frame->outermost = false;
> +
> +	return 0;
> +}
> +#define unwind_user_fp_get_frame unwind_user_fp_get_frame
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



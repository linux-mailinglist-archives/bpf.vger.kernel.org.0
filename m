Return-Path: <bpf+bounces-62779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865EBAFE4D9
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 12:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F2D3A75F4
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BDE28853D;
	Wed,  9 Jul 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vs+hFX9e"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352D2874F3;
	Wed,  9 Jul 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055327; cv=none; b=rKDEZcTcyfODUVZAbRjK5ANaP1nn1ljy/xOIRoTCdeU+rmGB0hy/UOM0HZ7aluLg852fdaa3mF2l9+hscVWcL38BCGh0rD/PAaZvw0y+raZrtkU5ewPKQ8m/UIGfiMpeWrXtxd60Ywx+LdRFxdhE+P31rVpj1BxeRcpGR0QW+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055327; c=relaxed/simple;
	bh=mFf2lXciUCUy0DWeK8EaWfhZiWoiX1K1u9dq8jPS26Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BnaiU/XAQA1trN/w1vTQJH76R0r41oKqwNRACRIh9wWwDLWTHDN+oHQZyQ7v8maxVksKDKjSZC6ia0WMBjeaze/KHL5dHjueVAj+288aR/NXbefaqR+eB0ehix9JSJb914AneM5R22R91yiOYihmdqu3DYYelZ4QpvgSFOE3V88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vs+hFX9e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5699tBrZ025920;
	Wed, 9 Jul 2025 10:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dPEJWo
	wSApW3ihOeZAzPSmPZW963DAdzR9LVDUMg73w=; b=Vs+hFX9exPiNGKbU50lWyn
	/4G5HJQabRgvG/45timEAl/TJB1PAONKQ+Muxis2rVrb7D7LuqS2gi2dw1L9vL3I
	OAG8iA5NBvFjbwBL2ER+YJGH7BNg0vFeIom5Nglvo+EVs6J9eTf5vBnC+NHYsNjd
	qE2+dkygUgeTjobtPfQ62q+bUzSdwiJ+Fjku9tMH1VkUd6t1ogVgUXVboVC+SJi1
	XkzzMeDUzHR0SMjZBiFQNO8cZdzxxWrbcXSYSqNLVsl9xD0ZXd5xD0CnjS5w6B0q
	eaa0s7nJlTy0bJYBfdUudwky5dQDH2R7xm+kdiiJ9KtjWKQgWt4gR7koIP6mhd9g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss5h40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 10:01:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5698U7XC024678;
	Wed, 9 Jul 2025 10:01:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32f9gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 10:01:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569A1FIr35324652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 10:01:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC0772004D;
	Wed,  9 Jul 2025 10:01:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BE8120049;
	Wed,  9 Jul 2025 10:01:15 +0000 (GMT)
Received: from [9.152.222.224] (unknown [9.152.222.224])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 10:01:15 +0000 (GMT)
Message-ID: <d3279556-9bb6-429d-a037-fe279c5e3c67@linux.ibm.com>
Date: Wed, 9 Jul 2025 12:01:14 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [PATCH v13 02/14] unwind_user: Add frame pointer support
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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
References: <20250708012239.268642741@kernel.org>
 <20250708012357.982692711@kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250708012357.982692711@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686e3df0 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=_CACeNGGoOMxVHxd7LAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: Gmo4rqtPTAQXrEYEpkkFAP_k6cwoLgOD
X-Proofpoint-ORIG-GUID: Gmo4rqtPTAQXrEYEpkkFAP_k6cwoLgOD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA4NyBTYWx0ZWRfX2P9D659LQTcK WKxc+m3p7CZdR6XikHfTqXjxBviNPfD1Dtf3cWdkRB2h+6GejEBru+1KoSO7JLGWmjcd7VQpd2c r70cVWkv7z8hLB/Toef9nszBxTD0eSOqbLoDNIAypS7UgVGwaGQMMFf9GCNJXEvt73u+XMZY7fc
 /OIqPNLqT4/lleOVwzMMTYo9YdB4OOR6wStuo3PyOV0SbLv4cW2ONnD4MfqEcVFafpWhH2unRlr 365MELt2IQ9apjY26Z8gllYE0Q5Y20s8tEFQzTf2ZAkWRznnACBQ6AVR3RpXOyepAjK4/YUJ2OJ VjQFDppaDCGOl9OfjiqZshxbapNT85ScJabDsBcsdt5UvYyMnVWAM/L/WIpTepDmTqcfXdPkPza
 NcW8GjUsmTVjhpN3mWe95XSfKAqdor6ONOvyHQh77xwxSD4SJumNkf7SFfwMhoAEvlWZOBj+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090087

On 08.07.2025 03:22, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Add optional support for user space frame pointer unwinding.  If
> supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_FP and
> define ARCH_INIT_USER_FP_FRAME.
> 
> By encoding the frame offsets in struct unwind_user_frame, much of this
> code can also be reused for future unwinder implementations like sframe.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c

> @@ -6,13 +6,71 @@
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/unwind_user.h>
> +#include <linux/uaccess.h>
> +
> +static struct unwind_user_frame fp_frame = {
> +	ARCH_INIT_USER_FP_FRAME
> +};
> +
> +static inline bool fp_state(struct unwind_user_state *state)
> +{
> +	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
> +	       state->type == UNWIND_USER_TYPE_FP;
> +}
>  
>  #define for_each_user_frame(state) \
>  	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
>  
>  static int unwind_user_next(struct unwind_user_state *state)
>  {
> -	/* no implementation yet */
> +	struct unwind_user_frame *frame;
> +	unsigned long cfa = 0, fp, ra = 0;
> +	unsigned int shift;
> +
> +	if (state->done)
> +		return -EINVAL;
> +
> +	if (fp_state(state))
> +		frame = &fp_frame;
> +	else
> +		goto done;
> +
> +	if (frame->use_fp) {
> +		if (state->fp < state->sp)

		if (state->fp <= state->sp)

I meanwhile came to the conclusion that for architectures, such as s390,
where SP at function entry == SP at call site, the FP may be equal to
the SP.  At least for the brief period where the FP has been setup and
stack allocation did not yet take place.  For most architectures this
can probably only occur in the topmost frame.  For s390 the FP is setup
after static stack allocation, so --fno-omit-frame-pointer would enforce
FP==SP in any frame that does not perform dynamic stack allocation.

> +			goto done;
> +		cfa = state->fp;
> +	} else {
> +		cfa = state->sp;
> +	}
> +
> +	/* Get the Canonical Frame Address (CFA) */
> +	cfa += frame->cfa_off;
> +
> +	/* stack going in wrong direction? */
> +	if (cfa <= state->sp)
> +		goto done;
> +
> +	/* Make sure that the address is word aligned */
> +	shift = sizeof(long) == 4 ? 2 : 3;
> +	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
> +		goto done;

Do all architectures/ABI mandate register stack save slots to be aligned?
s390 does.

> +
> +	/* Find the Return Address (RA) */
> +	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> +		goto done;
> +

Why not validate the FP stack save slot address as well?

> +	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
> +		goto done;
> +
> +	state->ip = ra;
> +	state->sp = cfa;
> +	if (frame->fp_off)
> +		state->fp = fp;
> +
> +	return 0;
> +
> +done:
> +	state->done = true;
>  	return -EINVAL;
>  }

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



Return-Path: <bpf+bounces-64533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15714B13E3C
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E34189FFBF
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711672621;
	Mon, 28 Jul 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SU1snmtV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAAD2905;
	Mon, 28 Jul 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716351; cv=none; b=mwRrORkGk/iCPa4KB5yaUJHk5fwKMH6tkjjzecA898FSoqeJAiFz0/ZBEENGmIUjIDBDy3CH7OtZ+wHZsMVlvfKKFlePQCsDtIOY7dRCDiq5Y8rTCMAJg4/Wfo3JO5x0RUdwUYRpOolV5xgddYCFMsnQ2R4E4EmCikHCRfvhEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716351; c=relaxed/simple;
	bh=ExEAhEcPgRQ7bap6YF8+1uVGMr/RRG+T/6x2VRhXXxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b36uxtlbqs/QxrvYufq5co+rvsJZSeVdQKNlwrPo+FjwEBaM0n/RsZRIL8JBZcsAOTzYDY1ejoyvUt57G5K358aVGucX/ijOzfylwRUyIcq1o51t8cOiYOpqiKP2MBDa9UFTnRS3VCQqhjgB4KEWZBQDIt4LSDhpjeVudRm/nOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SU1snmtV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S9Xxkb018554;
	Mon, 28 Jul 2025 15:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1TdeY3
	8yvx2pkN17RGtrmown7LStkd9BlLsganOGKko=; b=SU1snmtV3tJrfwHLzN28CB
	/d0bLoxvbH+DwDL7gFeoiiIP4YjG2N08RJjzvgM4fxbt75KytqMCOV0Rwm+dFxQy
	vg5YdQy+DAlYb9p1rwllwn2AkTzTInuSCnclIZRGghYl+3MXbjoswRC6kIdOTDhh
	eA8UWw2OXbZlEJUU15isOLWsA322LJoYUOPpUbjF8YcDtfNwzF55mlCa9m5MZz6W
	LyPigDAqTgs4XDh6O/eC2L6ONFOHZ5Y+pANg1xsYBGK4Yl/YRcN5V68lFOC00jJ/
	TsTLkJvwBU/ZS7arF8+2JYLpBoJDfAOWUDzRU4WPpARKHlnO+4oRXimpAwDcmR3Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd59u3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 15:24:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56SEsfG7006179;
	Mon, 28 Jul 2025 15:24:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjkx5xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 15:24:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56SFOsEa35521220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 15:24:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C2DC2004B;
	Mon, 28 Jul 2025 15:24:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18F6C20043;
	Mon, 28 Jul 2025 15:24:53 +0000 (GMT)
Received: from [9.111.164.146] (unknown [9.111.164.146])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 15:24:53 +0000 (GMT)
Message-ID: <5fb8ada0-d90c-4a58-a38d-97b3d0787554@linux.ibm.com>
Date: Mon, 28 Jul 2025 17:24:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/10] unwind_user: Add user space unwinding API with
 frame pointer support
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>
References: <20250725185512.673587297@kernel.org>
 <20250725185739.233988371@kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250725185739.233988371@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDExMSBTYWx0ZWRfX0YmiIuWmXQbI
 8n6DNChCzjzPjbZzxVksO0bcz7n0HVBmovQBhdtiwSzAXzvKBb1B2EqdA1gWr2BlYOwlJxJJ10G
 F2JMy2Evq8llS1mxuIvkhvku6kw+yRHgi8QM9Pokb/Mg7VNApYPRSAvLBv1jHDngSfYE4AmwECA
 fzS42tBkTxrXk9K3QtZGfldG694Nr2LqmPfNVS6ZwqNWF+0hJGVKUFip3Snj2A6axk5uHVRokIR
 ZBLhS0bCDPN4eujKjj0Sxq+X4v49QO6/dEnBp+MFusoxqMPTdsBT6T8nRymTebg2II/8YZKiODO
 r05KWY44atF/Eid9tLSKLI3R5AXle8RZTQVw9q08fZPp2Zc2LxCfTIMwDLqZJE7265YfLPyMStn
 CJWwSP3QN88PgvVwTjKh4enDf7fT/tBr1b5fzp1QVFkbeKjLfq7Ww0tKHmkcwKqA+qy0dIO+
X-Proofpoint-ORIG-GUID: blmFy9mm8Rzf3-Dx_ISYFmMlRBq_EMfh
X-Authority-Analysis: v=2.4 cv=B9q50PtM c=1 sm=1 tr=0 ts=68879649 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=7d_E57ReAAAA:8
 a=VnNF1IyMAAAA:8 a=meVymXHHAAAA:8 a=Mwpwro7nxz-gx4yFV5sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: blmFy9mm8Rzf3-Dx_ISYFmMlRBq_EMfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280111

On 25.07.2025 20:55, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Introduce a generic API for unwinding user stacks.
> 
> In order to expand user space unwinding to be able to handle more complex
> scenarios, such as deferred unwinding and reading user space information,
> create a generic interface that all architectures can use that support the
> various unwinding methods.
> 
> This is an alternative method for handling user space stack traces from
> the simple stack_trace_save_user() API. This does not replace that
> interface, but this interface will be used to expand the functionality of
> user space stack walking.
> 
> None of the structures introduced will be exposed to user space tooling.
> 
> Support for frame pointer unwinding is added. For an architecture to
> support frame pointer unwinding it needs to enable
> CONFIG_HAVE_UNWIND_USER_FP and define ARCH_INIT_USER_FP_FRAME.
> 
> By encoding the frame offsets in struct unwind_user_frame, much of this
> code can also be reused for future unwinder implementations like sframe.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Link: https://lore.kernel.org/all/20250710164301.3094-2-mathieu.desnoyers@efficios.com/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Jens Remus <jremus@linux.ibm.com>

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c

> +static int unwind_user_next_fp(struct unwind_user_state *state)
> +{
> +	struct unwind_user_frame *frame = &fp_frame;

Optional: Pointer to const?

> +	unsigned long cfa, fp, ra = 0;

Nit: Is initialization of ra really required?  I don't see where ra
would be getting used without being set beforehand.

> +	unsigned int shift;
> +
> +	if (frame->use_fp) {
> +		if (state->fp < state->sp)
> +			return -EINVAL;
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
> +		return -EINVAL;
> +
> +	/* Make sure that the address is word aligned */
> +	shift = sizeof(long) == 4 ? 2 : 3;
> +	if (cfa & ((1 << shift) - 1))
> +		return -EINVAL;
> +
> +	/* Find the Return Address (RA) */
> +	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> +		return -EINVAL;
> +
> +	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
> +		return -EINVAL;
> +
> +	state->ip = ra;
> +	state->sp = cfa;
> +	if (frame->fp_off)
> +		state->fp = fp;
> +	return 0;
> +}

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



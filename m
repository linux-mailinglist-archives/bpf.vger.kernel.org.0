Return-Path: <bpf+bounces-72114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AEDC06DF4
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 17:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C5794F44DF
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17CC322557;
	Fri, 24 Oct 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FhmK00P2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056E1EEA5F;
	Fri, 24 Oct 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318570; cv=none; b=rshCRHVG+kuNpYVcHtYKROr7ir0ZGK/SJlFUp9PHqJPkxBQIDZL3EP0ZpXMttWjSEg0Vqz01GfFtWktG5hsexvYdCAMZJqLHJ0Y5fuJ9fQJ/7rMpUcBTVYDbUQWrA/t8vsk6u27GkDVDW7o/IX+P910EaHpzaJoTX+iyaK9DzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318570; c=relaxed/simple;
	bh=2VNR8XoIOwaf624U2b/YCYF0muysmE7tCqlFX4iKGG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCz7lB/LqBV+qqU2bxOSGkjbR+pawwvFTCrdvWtZQriLtylw0iLpkum6sKXJ5H8AVO9m/HeA04xsYdTKdgiuATufJv8dGvs/mC0uqVnVvhHbtIMG8Bdm+3e1Mwp8OOFeb3iSOhXFYm8aB+hXGGkO3OQFFgM1TaLdc+i6PE0nh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FhmK00P2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O8Zp3P019199;
	Fri, 24 Oct 2025 15:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LBjQJ/
	Qnf0ZzsMSALsPsTqlreILwQzI4kb8r29WtHgg=; b=FhmK00P2wmxxDiyFTny8WA
	mFWfhavQDahSLS8lDETkg9Af4vH7YvcVdbK6BQ/moFEowb7sCOz+Yc78K1IJo/td
	wfm9y/Y8znEc/ONPLx3j7S5sMmZCmKZwvUvADxlmTk95gw2mLiY1soVK9dN0RoLQ
	RTXsLZoAEenokSl/ovLBeDJI0dEger1wviTPBYF/wymFNZDih/YiKAPUdGUrMbrc
	NPeQmEzy4WTZWOYM2InZS8r+cdF/CMD7lYCMrROw4K0nkymkuWkLx5jcWiKT5Zgg
	I0x+xo652sSe1VpLty7al27nd3/yYkNO7bFytSjlcX6wBqLeu5WEvDf40nxsjqkQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hx906-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 15:09:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OECZuQ024940;
	Fri, 24 Oct 2025 15:09:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqkbjtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 15:09:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59OF94Qw38863354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 15:09:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91EF920040;
	Fri, 24 Oct 2025 15:09:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D4482004D;
	Fri, 24 Oct 2025 15:09:03 +0000 (GMT)
Received: from [9.111.177.85] (unknown [9.111.177.85])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 15:09:03 +0000 (GMT)
Message-ID: <acacc4b6-9f4a-48f0-9660-035f0ed4b0fd@linux.ibm.com>
Date: Fri, 24 Oct 2025 17:09:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
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
        Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
        Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251024092926.GI4068168@noisy.programming.kicks-ass.net>
 <20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
 <a59509f0-5888-4663-9e82-98e27fc3e813@linux.ibm.com>
 <20251024140815.GE3245006@noisy.programming.kicks-ass.net>
 <20251024145156.GM4068168@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251024145156.GM4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwn0ztPV6VCxx
 mqVtDnwJFCw+Xsx9IAYSbseHdCQBXPvtnqmjBY8QIrMKUgP9jGlp6NRTs4sWoDl6C7RpS4aTnal
 wr5zFyUdGTinrNTdrtKxQ65kQf71gMnXEMPd0688fJ4XeZL2nmHY6YC9FoGHCsvMmxfgCjv6WBd
 WOB73t2iRdWvdye4u6ojtPjhRo/bSo5pgbGp2YBiGy7F/VFQg8Gkfj1Re63ckZp4TtDdft47Err
 ZH8ukwr9M25nSREABzr0L1zajEZGIqyiBZPgMa7hbYae3IP88Fm4DvzgL+bmFjq0Grfv0CHMEzq
 pUJk6nvDvP5oVoFSX2SZmdCyh66HwOqRpW7GPV58BC6fWXAPVTRg2i+A2pMYbTJaGA32r0qDAhw
 HCS9eeSSIurkolEx/cNNQz8gZUeY1A==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fb9695 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=hbS3uXWvOy2FqYBBbSQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: IiTz9DjyHpRsceOsENGaYzwdwiYzzKw-
X-Proofpoint-ORIG-GUID: IiTz9DjyHpRsceOsENGaYzwdwiYzzKw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Hello Peter,

very nice!

On 10/24/2025 4:51 PM, Peter Zijlstra wrote:

> Subject: unwind_user/x86: Teach FP unwind about start of function
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Oct 24 12:31:10 CEST 2025
> 
> When userspace is interrupted at the start of a function, before we
> get a chance to complete the frame, unwind will miss one caller.
> 
> X86 has a uprobe specific fixup for this, add bits to the generic
> unwinder to support this.
> 
> Suggested-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> +++ b/kernel/unwind/user.c

> +static int unwind_user_next_fp(struct unwind_user_state *state)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +
> +	const struct unwind_user_frame fp_frame = {
> +		ARCH_INIT_USER_FP_FRAME(state->ws)
> +	};
> +	const struct unwind_user_frame fp_entry_frame = {
> +		ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
> +	};
> +
> +	if (state->topmost && unwind_user_at_function_start(regs))
> +		return unwind_user_next_common(state, &fp_entry_frame);

IIUC this will cause kernel/unwind/user.c to fail compile on
architectures that will support HAVE_UNWIND_USER_SFRAME but not
HAVE_UNWIND_USER_FP (such as s390), and thus do not need to implement
unwind_user_at_function_start().

Either s390 would need to supply a dummy unwind_user_at_function_start()
or the unwind user sframe series needs to address this and supply
a dummy one if FP is not enabled, so that the code compiles with only
SFRAME enabled.

What do you think?

> +
> +	return unwind_user_next_common(state, &fp_frame);
> +}
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



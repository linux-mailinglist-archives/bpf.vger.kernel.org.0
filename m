Return-Path: <bpf+bounces-64536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6215FB13F22
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 17:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B882B18C1190
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A85273D84;
	Mon, 28 Jul 2025 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XKwouImz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DBB272E55;
	Mon, 28 Jul 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717627; cv=none; b=JbP2zJNh4soC0nQGHKFrnexCthYGUjWiecHFaiaxKrUFHn0JUWxi2xjCnXm5hbnz1gLvVXt594Ebmd6Fz4WbZ6APBcqC4umA0yYP0dKfl6nwMpDr+X/HqP6RQU4juEE5vZqf3c0eXldmmylLRchsi2Oajg5sGjMvvW77WQ5XNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717627; c=relaxed/simple;
	bh=J+l9cKMuczm50aEB9ARRWFUk5tTOBOkHrqIwWDYaHHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7rKE+p5+0EvXmKI1Q0zy7aBZBhO2yCUJoBwwZFYVbBTeU5D/vb1kqg5fYY6pf7rOmeJcNkUliNUzGkAwxijbkIHdxuDINehebGGUbbLisbwCwDIp2RPxppK5iDQ34BtsKPM4oEsAilM22ZQw3OswqPA69uRFy2yN0r3efXiqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XKwouImz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SED6eu017476;
	Mon, 28 Jul 2025 15:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wYshrD
	h2UwgehPPuM4B8pmbV/cHnjYZjBFsSXFvAlYg=; b=XKwouImzMPhCwWlsYqt3/d
	D+iAdckJwis7TUif3fGZ1MxYW0nIPok2+HiQpwCcaSsVWpLjWhNNPJA74Def+cUc
	GxfG6mq0JcaHunv180U+FBLWIMYkiiKv8CYLJH75nphKktHroE8yG95ia+BYk9Oq
	fNl5N4524yY16b/ZoPfeUOSGzonUgDeGoVW4M83TLyIzB/k8s7qZB5iphLndEBFZ
	PAFZUsEWotJ8bQUMOIj5jRpWbX1v4OPmd2BEbuvgPfqOqib1qIGzIA0djq5d8Ksr
	8Q106GY6GYy14cwctF2MlcdrL1R3apcMyYYW2xBSLGIV+fSvX59I7bk/uWRLM30w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd59x1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 15:46:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDWBvU017965;
	Mon, 28 Jul 2025 15:46:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859btek3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 15:46:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56SFkitU41484774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 15:46:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A99E520043;
	Mon, 28 Jul 2025 15:46:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D38E20040;
	Mon, 28 Jul 2025 15:46:43 +0000 (GMT)
Received: from [9.111.164.146] (unknown [9.111.164.146])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 15:46:43 +0000 (GMT)
Message-ID: <a0f9a3ef-f32a-4bff-8ab1-4181ad61780f@linux.ibm.com>
Date: Mon, 28 Jul 2025 17:46:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 03/10] unwind_user/deferred: Add unwind cache
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
 <20250725185739.573388765@kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250725185739.573388765@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDExNSBTYWx0ZWRfX9qU48vydE0dS
 JBRrL8veboa1wlAgSDHF+4kJiOxxLTcbs5BZU5keUEvEVaIe8bnpEfzXRDC22Zc3UgxLZhskGqK
 Ahwf5vi2hFkbHn33aeHv9dYNE3NifgN1T41MQNrnllYSzhSWvF5W/OnTZc5MUqh7je+AD8558CL
 J+NzqTTW80cNUswEs6SPQPOms5aitGL3lr+O05p+98nYVXTwaOr1OSTdPqarJ8iqx5iItXCQoA2
 I4bcHcxI2WSDaydUrIy+Nsw8HxdtFA5ImLC68fOC1jSw2rWp/Cb77nXdc5gkj23hqD/rJsMsY6e
 HcGN62v+6RtorGaUQBmqAzFHzK1rn5MTs+3FU2ffsNYmbkuP8rTl6icjqNM0j2GfMaYpmbWFvi8
 rWyQLLHq046rnF/4pV2zCqYl9gZzqpF9wOUyBfPeY5K9Xl9/xDwFVZ7tnDm1Xkxr7V9Z8QQ0
X-Proofpoint-ORIG-GUID: dHqk4bDI5YrCLzXj-a9OmVFGaIXVMvZO
X-Authority-Analysis: v=2.4 cv=B9q50PtM c=1 sm=1 tr=0 ts=68879b67 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=m_kX8qD_ECJkvHzc4wwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: dHqk4bDI5YrCLzXj-a9OmVFGaIXVMvZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280115

On 25.07.2025 20:55, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Cache the results of the unwind to ensure the unwind is only performed
> once, even when called by multiple tracers.
> 
> The cache nr_entries gets cleared every time the task exits the kernel.
> When a stacktrace is requested, nr_entries gets set to the number of
> entries in the stacktrace. If another stacktrace is requested, if
> nr_entries is not zero, then it contains the same stacktrace that would be
> retrieved so it is not processed again and the entries is given to the
> caller.
> 
> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Jens Remus <jremus@linux.ibm.com>

> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c

> +	cache = info->cache;
> +	trace->entries = cache->entries;
> +
> +	if (cache->nr_entries) {
> +		/*
> +		 * The user stack has already been previously unwound in this
> +		 * entry context.  Skip the unwind and use the cache.
> +		 */
> +		trace->nr = cache->nr_entries;
> +		return 0;
> +	}
> +
>  	trace->nr = 0;
> -	trace->entries = info->entries;
>  	unwind_user(trace, UNWIND_MAX_ENTRIES);
>  
> +	cache->nr_entries = trace->nr;
> +

Would the following alternative to above excerpt be easier to read?

	/* Use the cache, if the user stack has already been previously
	 * unwound in this entry context.  If not this will initialize
	 * trace->nr to zero to trigger the unwind now.
	 */
	cache = info->cache;
	trace->nr = cache->nr_entries;
	trace->entries = cache->entries;

	if (!trace->nr) {
		unwind_user(trace, UNWIND_MAX_ENTRIES);
		cache->nr_entries = trace->nr;
	}

>  	return 0;
>  }

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



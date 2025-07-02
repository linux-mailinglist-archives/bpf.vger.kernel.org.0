Return-Path: <bpf+bounces-62112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E984AF1580
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1111892E92
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED8026D4F1;
	Wed,  2 Jul 2025 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BDM7WFDA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323AC1DF27F;
	Wed,  2 Jul 2025 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459040; cv=none; b=krGU4WSgWOUQIsQvc/N4FhVUsEXvxq1YjlYDbZ5SuMUOOO8fWlhc5gQusPQWGkBJSssNinYqm1LxGvTcL1PmB6pk2frn/onVuQkQRiKvndNb7Pqx8fB0g+fJtk41sV9UIaBRVLygIXHp9XfBkJTsTShco7hWVpCexKS4GZUlPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459040; c=relaxed/simple;
	bh=7MXsvefg93WoDNxgQrzmnxeJinMCDTf4uZTRkhJS/pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyU0JjqkrhA9gkWFC+kk/tDC2GZjjt2A8d/eCZb0yIpv/qx1IHQ5Ia9RGKFVBy3IYKpHk3HeK5Y3BZY51oJrCF+22e/uVbFlCTm7jF0vHpUxZ17MhaZ8f/BhYdluRfSmHhTBCaEA1/R11caEl0zTwLslzVFNyLpA7Dmp85t2PPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BDM7WFDA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5629TjxU013644;
	Wed, 2 Jul 2025 12:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UdBAqe
	jzoUw+UgaBlhXeMSEbuN5A8uBlJuHZIqvXh4A=; b=BDM7WFDAb1M1owrIjk0IoQ
	I60vhnYcmtOvIXIBdsOnySMhNbLlJHwf805Eq353MhEg+Y7tIbYooSqqvW0jOLEe
	KBEtuu//NN29vPtL+EhJufYXhnScDRqjtBp5OdGm/w7kLNZnHj4tP23WKLBGIo/A
	uQNM6zkmLE4hGVZFTt4p5SmnhlS97FSbl0zvkQLACXE2utH7sOouoDcl14b16Yyn
	TMl1wfc4SqrtJ/OXSVbGpkXGGRiHbLldjTtZvSlst+3UVoxaq5PMK7TnabOL6MJy
	HwEdblujIDPYD4w9aUqpAaGTn7eP7k6opl4eHkrWcGl7q31gxq51Sl78NRaqYRiQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u1w3xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 12:23:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5629JcjL021078;
	Wed, 2 Jul 2025 12:23:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqufmps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 12:23:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562CNPnv44106226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 12:23:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 369572004E;
	Wed,  2 Jul 2025 12:23:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9FCF20043;
	Wed,  2 Jul 2025 12:23:24 +0000 (GMT)
Received: from [9.152.222.224] (unknown [9.152.222.224])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 12:23:24 +0000 (GMT)
Message-ID: <51903e66-56bc-42a4-b80c-9c3223e2a48a@linux.ibm.com>
Date: Wed, 2 Jul 2025 14:23:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/11] perf tools: Minimal CALLCHAIN_DEFERRED support
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
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
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20250701180410.755491417@goodmis.org>
 <20250701180456.884974538@goodmis.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250701180456.884974538@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: axbO-Vk8p0TWJ0uevcQWCloOnJFQGtqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwMCBTYWx0ZWRfX+YfD2C4mM3TP DZMmJfN2CnKikoPEdppg5lNczoasu01L0XpLgqT29WXQqORGJOfKEA4/RMU4qfS7FJ+rZD4MfZT G2YhSgzJDw43PYZ6JRdXV6PaPUgJXQpBzsEhi+QPCFIyXZdNHkg1USkvdmXFkBkI9wzLtRRLGDw
 hd8OgRTJCsNpjQ//sBw41BpoMycktdAKXZMMPlLFIxVfuvbydDA3OCkvl4Z2soQYmmmXzoWyTsV UVm3VJ+3mo6NhF1n2QLsykDOeNKaaUsISjtTV131z/LqFVL+NOniBs5w/31JpJa1AkBcXM77VUh bYztdFIZCsr2K+U9QZaqy5t3RLuiQPNud++2dMoXqmVeIQNMyFjhT6EakrQ7eNFTMaQCd7KU4h4
 /M5swsKeo4rwEK/UdU28Au3O8KW+v1LSSNbnDOkGRwzAACV4dyySrniFg0xb1yfbjcg5dZMN
X-Proofpoint-GUID: axbO-Vk8p0TWJ0uevcQWCloOnJFQGtqY
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=686524c2 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020100

Hello Steve!

On 01.07.2025 20:04, Steven Rostedt wrote:
> From: Namhyung Kim <namhyung@kernel.org>
> 
> Add a new event type for deferred callchains and a new callback for the
> struct perf_tool.  For now it doesn't actually handle the deferred
> callchains but it just marks the sample if it has the PERF_CONTEXT_
> USER_DEFFERED in the callchain array.

> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h

> @@ -151,6 +151,12 @@ struct perf_record_switch {
>  	__u32			 next_prev_tid;
>  };
>  
> +struct perf_record_callchain_deferred {
> +	struct perf_event_header header;

At minimum the timestamp field added to perf with "[PATCH v12 07/11]
perf: Support deferred user callchains for per CPU events" needs to be
added here as well:

	__u64			 timestamp;

Otherwise this and any subsequent enhancements of the perf tools do no
longer work at all.  But probably the timestamp field also needs to be
used for some purpose?

> +	__u64			 nr;
> +	__u64			 ips[];
> +};
> +

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



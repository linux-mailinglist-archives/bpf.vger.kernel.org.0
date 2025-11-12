Return-Path: <bpf+bounces-74284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5800EC51902
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 11:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3B4188715A
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C22FE573;
	Wed, 12 Nov 2025 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EP9mZzAw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DAD2FD1D5;
	Wed, 12 Nov 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942020; cv=none; b=KrKg6jTbOlPl+n2H2Nqw4nrpqxyoljFZjGuyKgt/gsbcEI6mVpWC0g5iMClw2yNIeaKHTbbJHAJPOTqaWygCX7J0OF0x9Puj1zOqVguNI2fLYyFmJp+jRbKYLmvVfpCkNVMCBCui/exftxO7A0/HMR5w6/7OGVGbiPc7qplBQvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942020; c=relaxed/simple;
	bh=hTysW8ldnhzhr1+7+t+schbzT3i7HS0zbqEdHYIEosg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uq26eWTBGkPaY61F6XyctzArByFELThLcH1Poi4px+Ea68BbaC4wWuzT5Pg+f3GUHtGIsrz1JPQg9pLlXs/OV/MrrujKS2XmA25zrOp4umjWX5z4fZKci1tmRMFiVVD9YpZW2S+DCcK1I6+/kluaNdfxiHBkQCAGtisLhfMURCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EP9mZzAw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC3V5lS007136;
	Wed, 12 Nov 2025 10:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TfObaI
	bP9JQo5NnryYlf8giRFUtoQnidA+p6jOSi7ME=; b=EP9mZzAw73DpsHbsLG++k/
	xXfWO4ScFdBcq5TQPrUeFfE/+gRILlrK5tbMQhTE/IpYXzCNIcpbeWPMDryjoVzC
	jeMH5Nm0ufUz7Nhpm0S7PDb8eSNcdSZXGMLvGss1bOET6NcOxaZVXyDUUKduMGBO
	xoz2236w1LtOlpyrDse9LkFlSQMHL9Hfpm3ay7zO2YGbytauaEcGAYzATT9Ytpsj
	XxKc9KgYQc5N5a/2oE9YE6XJGURT9DcZMvJ08I6byeNUAFHeXqnlf4I1uaFVwNnM
	Evx3UkqlXVmx27lAqBcaAyOv7V7jZpfU/pjYo+laDo4rlUweQ/NqAdAUa9O+EN6w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgx0fhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 10:06:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC6LvA6014755;
	Wed, 12 Nov 2025 10:06:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpk7ged-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 10:06:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACA605039125464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 10:06:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B178B20076;
	Wed, 12 Nov 2025 10:06:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1550220074;
	Wed, 12 Nov 2025 10:06:00 +0000 (GMT)
Received: from [9.155.200.37] (unknown [9.155.200.37])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 10:06:00 +0000 (GMT)
Message-ID: <f543231e-a71c-4600-9cf3-f999ca104d86@linux.ibm.com>
Date: Wed, 12 Nov 2025 11:05:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 4/4] perf tools: Merge deferred user callchains
To: Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
        Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20250908175319.841517121@kernel.org>
 <20250908175430.639412649@kernel.org>
 <20251002134938.756db4ef@gandalf.local.home>
 <20251024130203.GC3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251024130203.GC3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L_7sfh61mwnig6fGCcLLmEZrHnaQHDuI
X-Proofpoint-ORIG-GUID: L_7sfh61mwnig6fGCcLLmEZrHnaQHDuI
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69145c0b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=Vs_kanKWfxrV1IkLjT4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX9yuxxvyN78Og
 69SPfChu8C26Ui7EH/rN9p/nPA8ApOGKgjl3fx4SMJtdZ0NkHEHvL573DxDpej4bUkc6Vw25+pC
 xFy74vg0QORXjXqQekG6shZ5IPcDavRtDxY/8MtXSt4ph69AFwTGBPpqT6yzyfdRmFR01xD2Gtv
 bk0il8sBGlxnJURQW0pvPa4JYOnzSlYKi4e+WVOxwIPof/1+ziwe4hQvuofMRrwzPdyglHF3H02
 IchSUpkPcjvPuZbbO3veyqynNcwRL0bm3Wu5qtA3YPJdvmMdQvF/je4LMDkPbF3wDpGNVt1fWrZ
 sbc6etbnf9FULaU1o/N91tHnSOrqVYnzRNOuF4b3hG4lU8ye/hYDRu+qvgNNY8Oefwg8OiQEFjA
 Y60tXmEVofdQJHIkppKmjPZhQv8f5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

Hello Namhyung,

could you please adapt your patches from this series to Peter's latest
changes to unwind user and related perf support, especially his new
version c69993ecdd4d ("perf: Support deferred user unwind") available
at:

git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

On 10/24/2025 3:02 PM, Peter Zijlstra wrote:
> On Thu, Oct 02, 2025 at 01:49:38PM -0400, Steven Rostedt wrote:
>> On Mon, 08 Sep 2025 13:53:23 -0400
>> Steven Rostedt <rostedt@kernel.org> wrote:
>>
>>> +static int evlist__deliver_deferred_samples(struct evlist *evlist,
>>> +					    const struct perf_tool *tool,
>>> +					    union  perf_event *event,
>>> +					    struct perf_sample *sample,
>>> +					    struct machine *machine)
>>> +{
>>> +	struct deferred_event *de, *tmp;
>>> +	struct evsel *evsel;
>>> +	int ret = 0;
>>> +
>>> +	if (!tool->merge_deferred_callchains) {
>>> +		evsel = evlist__id2evsel(evlist, sample->id);
>>> +		return tool->callchain_deferred(tool, event, sample,
>>> +						evsel, machine);
>>> +	}
>>> +
>>> +	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
>>> +		struct perf_sample orig_sample;
>>
>> orig_sample is not initialized and can then contain junk.
>>
>>> +
>>> +		ret = evlist__parse_sample(evlist, de->event, &orig_sample);
>>> +		if (ret < 0) {
>>> +			pr_err("failed to parse original sample\n");
>>> +			break;
>>> +		}
>>> +
>>> +		if (sample->tid != orig_sample.tid)
>>> +			continue;
>>> +
>>> +		if (event->callchain_deferred.cookie == orig_sample.deferred_cookie)
>>> +			sample__merge_deferred_callchain(&orig_sample, sample);
>>
>> The sample__merge_deferred_callchain() initializes both
>> orig_sample.deferred_callchain and the callchain. But now that it's not
>> being called, it can cause the below free to happen with junk as the
>> callchain. This needs:
>>
>> 		else
>> 			orig_sample.deferred_callchain = false;
> 
> Ah, so I saw crashes from here and just deleted both free()s and got on
> with things ;-)

This needs to be properly resolved.  In the meantime I am using Steven's
suggestion above to continue my work on unwind user sframe (s390).

> 
>>> +
>>> +		evsel = evlist__id2evsel(evlist, orig_sample.id);
>>> +		ret = evlist__deliver_sample(evlist, tool, de->event,
>>> +					     &orig_sample, evsel,> machine); +
>>> +		if (orig_sample.deferred_callchain)
>>> +			free(orig_sample.callchain);
>>> +
>>> +		list_del(&de->list);
>>> +		free(de);
>>> +
>>> +		if (ret)
>>> +			break;
>>> +	}
>>> +	return ret;
>>> +}
>>
>> -- Steve

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



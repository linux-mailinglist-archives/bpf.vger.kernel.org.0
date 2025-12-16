Return-Path: <bpf+bounces-76700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE7CC1CEC
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 10:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE8D53058846
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549AC3375D3;
	Tue, 16 Dec 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OniCZkuc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A16E32E13D;
	Tue, 16 Dec 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765877428; cv=none; b=rPFQko7AISg38WU66czKFy2tnlLsvcyRl3Z8jITYT0T4TXk/fc2svLdOkw0QEG77OHPVS92KpPGTciDxbX8c74RibFdkhXHW3+uWZzxn3D3QagS+xz4ef/C2wXgZ9c2Pf0/WxuSSIslmk7+nKFvk9lbjDzRx396Ki3qVXM2FoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765877428; c=relaxed/simple;
	bh=9B9fL9zQ8qnpaJErs1fVIQqV/HGDDzxTb5bppDM/LNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5n1mUrxVWMo4Vz6Sa+DHn+7nRf564Pw9+4us00kLtAOE152vLNGRQwKSb6FR5TgXtFpUmieJYr9Z7N37WT/gsCo+0a2QPZX+MFpS2yTyuBYiuLU2cDyVMeoF4SK32HmQCnKgF8K2n47lSawWrRZ9BxH4bmrtTnV7wzsTYNJlv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OniCZkuc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFNWofX001735;
	Tue, 16 Dec 2025 09:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/f30n5
	Ql5+zqGKmNBlm+fXaMqRlBT/rSwX8VxTEqBuk=; b=OniCZkucWongtxlAi3ZvVJ
	5JwSsXlQ5mxDnYEForvgj1ywcCxr78HxB6TRDRAzZyGV1ZOGHx1who66ffsAdid3
	DPycevH/thepPY96Y2il1agRBYQH0imZe1oXA7M7pcHQMGdGY67m4nBI0nUxei4z
	uhsFzxHUevePlEe8hN0gkKFmYp6DbXXcO0OChth0Bw061EQkAF1XGJn1yljmZB39
	2boAxzuFZzYrrSxealg1VLXvhRye3uQ9jm8J3Boy1p0ZpDoJVfD2YFLXa+eIl5NA
	lQ5VYeuMmn6CUT0oQ9dAhY2zc8lqngeN6zviuWnJ0SIFIkRxjj0qel/7r8aKKtTQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv685c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 09:29:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BG9Qvk9021825;
	Tue, 16 Dec 2025 09:29:34 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv6859-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 09:29:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG8mfdA026803;
	Tue, 16 Dec 2025 09:29:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfsbkp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 09:29:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BG9TTfK42140010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 09:29:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5834720040;
	Tue, 16 Dec 2025 09:29:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0214720043;
	Tue, 16 Dec 2025 09:29:29 +0000 (GMT)
Received: from [9.52.200.193] (unknown [9.52.200.193])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Dec 2025 09:29:28 +0000 (GMT)
Message-ID: <024b7bb4-731e-4da4-8480-4789f5912977@linux.ibm.com>
Date: Tue, 16 Dec 2025 10:29:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] perf script: Display
 PERF_RECORD_CALLCHAIN_DEFERRED
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20251120234804.156340-1-namhyung@kernel.org>
 <20251120234804.156340-5-namhyung@kernel.org>
 <9fe12698-2fd5-41fe-8505-735d73eae0a2@linux.ibm.com>
 <aUDkpsW-WH3IPIhh@google.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <aUDkpsW-WH3IPIhh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX/XlN0FngC9fC
 AW1o5ed63hU5GBPaWI3aP40oDTdUtoWkYSH2yGuVwXu+chjPnqhdsolwlLuLEpp1uOD72XYF/+9
 FRAaga8EQZ0OUEOezPieO2icte4r5/ET8E/Gqx/tD0BiPkdsHhQMaVVjLAOLp449PtsVRzraCGc
 UivoQiFWu/HhkYnLdjjpfUH45Z229qUfmuNxNSjS/+ZdZ10zwxqnC8GuLhaah7mwZkaNG4zh7dX
 A2VxMbug2/kdBkZCEsISglzsDi8cZMAn/DTZKEJ4s8cUB8vU9HoaJtrmNVL2RM7sTCcUGbrrFor
 goqJ+ZxaVybVVgqKXdX4PD/Y6PczOAu2EctmBzzkESI7vPpoBi9v/x3o8ydsCkD2Agctw/enRIR
 +qBip+1YFQ+SeHvLPSbEOwDpeZ1lgg==
X-Proofpoint-ORIG-GUID: JJT289aWiYLsJKcs2q0Ec5udR-biyz3H
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=6941267f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=zGLf65y6ZfpCdAT4qmQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: itQ1wkfx0CwiNgQT9LDmeEL1J0-yMivu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

Hello Namhyung!

On 12/16/2025 5:48 AM, Namhyung Kim wrote:
> On Fri, Dec 12, 2025 at 01:11:38PM +0100, Jens Remus wrote:

>> following is an observation from my attempt to enable unwind user fp on
>> s390 using s390 back chain instead of frame pointer and relaxing the
>> s390-specific IP validation check.
>>
>> When capturing call graphs of a Java application the list of "unwound"
>> user space IPs may contain invalid entries, such as 0x0, 0xdeaddeaf,
>> and 0xffffffffffffff.  IPs that exceed PERF_CONTEXT_MAX, such as the
>> latter, cause perf not to display any deferred (or merged) call chain.
>> Note that this is not caused by your patch series.
> 
> Right, it's not a real IP so perf ABI treats them as a magic context.
> 
>>
>> While re-adding the s390-specific IP checks would "hide" those, I found
>> that the call graphs look good otherwise.  That is the back chain seems
>> to be intact.  It is just the user space application (e.g. Java JRE) not
>> correctly adhering to the ABI and saving the return address to the
>> specified location on the stack, causing bogus IPs to be reported.
>>
>> Could perf be improved to handle those user space IPs that exceed
>> PERF_CONTEXT_MAX?
> 
> Ideally we should not have them in the first place.  Is it a JRE issue
> or your s390 unwinder issue?  Is it possible to ignore them in the
> unwinder?

Stack tracing using frame pointer is virtually impossible on s390, as
the ABI does not designate a specific register as FP register, does not
specify a fixed register save area layout, nor does mandate a FP to be
setup early.  Compilers usually setup a FP late, that is after static
stack allocation.

An alternative is the s390-specific back chain, which is basically a
frame pointer on stack.  The ABI specifics that *(SP+0) has the pointer
to the previous frame and *(BC-48) has the return address (RA), if a
back chain is used (e.g. compiler option -mbackchain is used).  This is
why I implemented unwind user fp on s390 using back chain.  Note that
the back chain can be correctly followed, even if the saved RAs are
bogus.  That is what can be observed in case of this specific Java JRE.
Apparently it correctly maintains the back chain stack slot, but does
not correctly maintain the RA stack slot.  So the RA stack save slot may
contain any random value.

The s390-implementation of unwind user fp could check whether the return
address is a valid IP.  This is how it is implemented in the existing
stack tracer in arch/s390/kernel/stacktrace.c:

static inline bool ip_invalid(unsigned long ip)
{
	/* ABI requires IPs to be 2-byte aligned */
	if (ip & 1)
		return true;
	if (ip < mmap_min_addr)
		return true;
	if (ip >= current->mm->context.asce_limit)
		return true;
	return false;
}

It could then either stop or return some magic value
(e.g. PERF_CONTEXT_MAX - 1) to indicate that the IP is invalid and
continue.  Actually I would prefer to continue so that a user an see
that there is something odd with the stack trace.

Alternatively such a check could possibly also be implemented in the
common undwind user, if the address space limits are known in common
code, or as an architecture-specific hook.  In general I tend to at
least add a check whether the IP is zero, as this is used on several
architectures as indication for outermost frames (usually in
combination with a FP of zero).

>>
>> Is there otherwise guidance how unwind user and/or the s390
>> implementation should deal with such IPs?  Should it stop taking the
>> deferred calltrace?  Should it substitute those with e.g 0, so that
>> perf can display them?


>> Sample for IP == ffffffffffffff (perf does not display any call chain):
...
>> # perf report -D
>> ...
>> 44004346257 0x17718 [0x40]: PERF_RECORD_SAMPLE(IP, 0x2): 1082/1084: 0x3ffa3e413aa period: 1001001 addr: 0
>> ... FP chain: nr:2
>> .....  0: fffffffffffffd80
>> .....  1: 0000000400000079
>> ...... (deferred)
>>  ... thread: java:1084
>>  ...... dso: /tmp/perf-1082.map
>>
>> 0x17758@perf.data [0xd0]: event: 22
>> .
>> . ... raw event: size 208 bytes
...
>>
>> 44004348864 0x17758 [0xd0]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 1082/1084: 0x400000079
>> ... FP chain: nr:21
>> .....  0: 000003ffa3e413aa
>> .....  1: 000003ff3809e2d0
>> .....  2: 000003ff3809e130
>> .....  3: 000003ffb95fdf68
>> .....  4: 0000000000000000
>> .....  5: 000003ffb95fe128
>> .....  6: 000003ffb95fe1d0
>> .....  7: 005780888e7647a5
>> .....  8: 000003ffa3e437f2
>> .....  9: ffffffffffffffff <-- !
>> ..... 10: 000003ffa3e4a1fc
>> ..... 11: 0000000000000000
>> ..... 12: 000003ffa3e37900
>> ..... 13: 000003ffa3e41080
>> ..... 14: 000003ffb9dd11de
>> ..... 15: 000003ffb9e8df92
>> ..... 16: 000003ffb9e90e86
>> ..... 17: 000003ffbab8b07e
>> ..... 18: 000003ffbab8e040
>> ..... 19: 000003ffba8abbd8
>> ..... 20: 000003ffba92b950
>> : unhandled!
>>
>> ...
>> [next entry]
>>
>>
>> On 11/21/2025 12:48 AM, Namhyung Kim wrote:

>>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>>
>>> +static int process_deferred_sample_event(const struct perf_tool *tool,
>>> +					 union perf_event *event,
>>> +					 struct perf_sample *sample,
>>> +					 struct evsel *evsel,
>>> +					 struct machine *machine)
>>> +{
>>
>>> +	perf_sample__fprintf_start(scr, sample, al.thread, evsel,
>>> +				   PERF_RECORD_CALLCHAIN_DEFERRED, fp);
>>> +	fprintf(fp, "DEFERRED CALLCHAIN [cookie: %llx]",
>>> +		(unsigned long long)event->callchain_deferred.cookie);
>>> +
>>> +	if (PRINT_FIELD(IP)) {
>>> +		struct callchain_cursor *cursor = NULL;
>>> +
>>> +		if (symbol_conf.use_callchain && sample->callchain) {
>>> +			cursor = get_tls_callchain_cursor();
>>> +			if (thread__resolve_callchain(al.thread, cursor, evsel,
>>> +						      sample, NULL, NULL,
>>> +						      scripting_max_stack)) {
>>
>> thread__resolve_callchain()
>> calls __thread__resolve_callchain()
>> calls thread__resolve_callchain_sample():
>>
>>         for (i = first_call, nr_entries = 0;
>>              i < chain_nr && nr_entries < max_stack; i++) {
>> ...
>>                 ip = chain->ips[j];
>>                 if (ip < PERF_CONTEXT_MAX)   <-- IP=ff..ff is greater than PERF_CONTEXT_MAX
>>                        ++nr_entries;
> 
> Right.
> 
>> ...
>>                 err = add_callchain_ip(thread, cursor, parent,
>>                                        root_al, &cpumode, ip,
>>                                        false, NULL, NULL, 0, symbols);
>>
>>                 if (err)
>>                         return (err < 0) ? err : 0;
>>
>> calls add_callchain_ip:
>>
>>                if (ip >= PERF_CONTEXT_MAX) {
>>                        switch (ip) {
>>                        case PERF_CONTEXT_HV:
>>                                *cpumode = PERF_RECORD_MISC_HYPERVISOR;
>>                                break;
>>                        case PERF_CONTEXT_KERNEL:
>>                                *cpumode = PERF_RECORD_MISC_KERNEL;
>>                                break;
>>                        case PERF_CONTEXT_USER:
>>                        case PERF_CONTEXT_USER_DEFERRED:
>>                                *cpumode = PERF_RECORD_MISC_USER;
>>                                break;
>>                        default:
>>                                pr_debug("invalid callchain context: "  <-- IP=ff..ff reaches default case
>>                                         "%"PRId64"\n", (s64) ip);
> 
> We may skip -1 if it's Java and *cpumode is already USER and it's s390.
> But I'd like to understand the situation first.

Let's better not add any weird architecture-specific handling.  This is
also not limited to -1 (and 0), as Java may have used the stack save
area in any way, so it may be any random value.

>>                                /*
>>                                 * It seems the callchain is corrupted.
>>                                 * Discard all.
>>                                 */
>>                                callchain_cursor_reset(cursor);
>>                                err = 1;
>>                                goto out;
>>                        }
>>
>>> +				pr_info("cannot resolve deferred callchains\n");
>>> +				cursor = NULL;
>>> +			}
>>> +		}
>>> +
>>> +		fputc(cursor ? '\n' : ' ', fp);
>>> +		sample__fprintf_sym(sample, &al, 0, output[type].print_ip_opts,
>>> +				    cursor, symbol_conf.bt_stop_list, fp);
>>> +	}

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



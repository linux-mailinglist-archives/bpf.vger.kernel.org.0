Return-Path: <bpf+bounces-76532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB5CB8C5B
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 13:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9271430A6B15
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 12:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239D322B63;
	Fri, 12 Dec 2025 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fDAVup1R"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B7322A28;
	Fri, 12 Dec 2025 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765541529; cv=none; b=D5AzolhES17N7hMSs7JL0SVUdywYbtsp1RgBEwn/ltX81hCpSwPorQF0lWDfbV5TT4GNpBG4VufFolJ5ANwu5N5L3K/iNwyxyYvik0DwrUhg5qmicBfabup8VLlDOJB/S+p4rF4n5bRLx3wx8netsANGCNCC4WUOdg6MWx//dOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765541529; c=relaxed/simple;
	bh=foAusVFap6OEAATVXE3eXSDGyCXMzKlEA8gOWBKtikA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWdOzkn+TYD3Qi6jz/8rflMMZoORd/GXTzgWvsXyhdUIJh4O3pP13MDg3UF51IynM61hTd9r02Y7w0N6M/JsQnExDD4O5/ejvbvQ69ihuJyc3D11y9HS+xN6CuFSOA1kZ4XIFxL8oY5wWdAG6XVkYZJpuKpegd/rgw3TBvy1szg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fDAVup1R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC3L2hT028098;
	Fri, 12 Dec 2025 12:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FdW60g
	79uoqxiKd/U0BYbbO7pl08+bXI8SvPQhe1PyU=; b=fDAVup1RF6Qc6jBwNShFjw
	/2bUqGDtBINOKuOcTa09ikwNHxhNw0BS6zzSFzsQn9RDh+DHqbfuu90Wt0jYkAri
	ifbqCUVRJ+hmn9AFVmwNZWKZBQa1myegHAYHjZRynQwtJa6mXrzoP7FIz0fclWB3
	L9KZwlS+1BE2vO2HU3FD225qCrkJwV/BZQVn8bmB4DAMfBuftwjX1os7XoMsQZft
	itot91S2V2h0Whs+UJqV5y5vSzoowdMNSCvBf3YHxfOgwwbSSn+hzaCPUcOqJJxx
	/EhMGRfeZzSdguPK1MciUltRemXt0vSRVq3gamIWvTKwpflepNi+S2qerEVlRnBQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53vaun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 12:11:44 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCC2ei0011254;
	Fri, 12 Dec 2025 12:11:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53vauh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 12:11:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCA4hPJ028147;
	Fri, 12 Dec 2025 12:11:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6ybv3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 12:11:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BCCBdh451970336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 12:11:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85A6E20040;
	Fri, 12 Dec 2025 12:11:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D36720049;
	Fri, 12 Dec 2025 12:11:38 +0000 (GMT)
Received: from [9.111.169.84] (unknown [9.111.169.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Dec 2025 12:11:38 +0000 (GMT)
Message-ID: <9fe12698-2fd5-41fe-8505-735d73eae0a2@linux.ibm.com>
Date: Fri, 12 Dec 2025 13:11:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] perf script: Display
 PERF_RECORD_CALLCHAIN_DEFERRED
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
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
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251120234804.156340-5-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX0PXv8E3Ro1oC
 b+bQwnVcS0b4wLCm8zUWigeMHioG6fQRCmmdXF+T9S+Pkjddv2p3zXmu5wZNWY6li65qlS2iuId
 oqkSdpzWNKEpiV+Hu31mFo+0hB5rifKIxg2YVIPmq47uOs73KqGQmGggOYAxdAibCXhLIFaERno
 6YcvTdLYjSg0UNBD5jh7R4RdqOj43bE51587elSubrSswmjF1nd+VaLv2iEHC5m3zjAWOBB+Gfr
 WA5uCLNndLN7a6n9Fpi7qMwxQGpwghmaWwXcZP+kqBafYJirFMeyxhaWsRLJbUDVnR9eJWOyKCB
 cz1l87OmHEfvQe1pJXRT6EdT00noKR7CnF+3Y9lVWftmT65xUShJywF/zd5uoUtv2Nih0TOATwj
 RFcsDMn9+IQrd6+4hs8cezjlrd1AoA==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693c0680 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=asER20gIid3tD00tBEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zFkCM8i_PSWywjV260R3mkzA9B-J5SZl
X-Proofpoint-GUID: QkVAc1x0kDr-QE_caiPsHe33Ir4Z7586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Hello Namhyung,

following is an observation from my attempt to enable unwind user fp on
s390 using s390 back chain instead of frame pointer and relaxing the
s390-specific IP validation check.

When capturing call graphs of a Java application the list of "unwound"
user space IPs may contain invalid entries, such as 0x0, 0xdeaddeaf,
and 0xffffffffffffff.  IPs that exceed PERF_CONTEXT_MAX, such as the
latter, cause perf not to display any deferred (or merged) call chain.
Note that this is not caused by your patch series.

While re-adding the s390-specific IP checks would "hide" those, I found
that the call graphs look good otherwise.  That is the back chain seems
to be intact.  It is just the user space application (e.g. Java JRE) not
correctly adhering to the ABI and saving the return address to the
specified location on the stack, causing bogus IPs to be reported.

Could perf be improved to handle those user space IPs that exceed
PERF_CONTEXT_MAX?

Is there otherwise guidance how unwind user and/or the s390
implementation should deal with such IPs?  Should it stop taking the
deferred calltrace?  Should it substitute those with e.g 0, so that
perf can display them?


Sample for IP == deaddeaf (perf displays this correctly):

java    1084    33.086790: DEFERRED CALLCHAIN [cookie: 2000001f9]
             3ff983f071c java.lang.String CryptoBench.crypt(java.lang.String)+0x89c (/tmp/perf-1082.map)
             3ff983ff894 void CryptoBench.execute()+0x94 (/tmp/perf-1082.map)
       ! -->    deaddeaf [unknown] ([unknown])
             3ff97e37900 StubRoutines (initial stubs)+0x80 (/tmp/perf-1082.map)
             3ff97e41080 Interpreter+0x3300 (/tmp/perf-1082.map)
             3ffae2d11de JavaCalls::call(JavaValue*, methodHandle const&, JavaCallArguments*, JavaThread*)+0x3e (/usr/lib/jvm/.../libjvm.so)
             3ffae38df92 jni_invoke_static(JNIEnv_*, JavaValue*, _jobject*, JNICallType, _jmethodID*, JNI_ArgumentPusher*, JavaThread*) [clone .constprop.1]+0x242 (/usr/lib/jvm/.../libjvm.so)
             3ffae390e86 jni_CallStaticVoidMethod+0x116 (/usr/lib/jvm/.../libjvm.so)
             3ffaf08b07e JavaMain+0x113e (/usr/lib/jvm/.../libjli.so)
             3ffaf08e040 ThreadJavaMain+0x20 (/usr/lib/jvm/.../libjli.so)
             3ffaedabbd8 start_thread+0x198 (/usr/lib64/libc.so.6)
             3ffaee2b950 thread_start+0x10 (/usr/lib64/libc.so.6)


Sample for IP == 0 (perf displays this correctly):

java    1084    33.021987: DEFERRED CALLCHAIN [cookie: 20000017b]
             3ff983f067c java.lang.String CryptoBench.crypt(java.lang.String)+0x7fc (/tmp/perf-1082.map)
             3ff9098aa88 void CryptoBench.execute()+0x748 (/tmp/perf-1082.map)
       ! -->           0 [unknown] ([unknown])
             3ff97e37900 StubRoutines (initial stubs)+0x80 (/tmp/perf-1082.map)
             3ff97e41080 Interpreter+0x3300 (/tmp/perf-1082.map)
             3ffae2d11de JavaCalls::call(JavaValue*, methodHandle const&, JavaCallArguments*, JavaThread*)+0x3e (/usr/lib/jvm/.../libjvm.so)
             3ffae38df92 jni_invoke_static(JNIEnv_*, JavaValue*, _jobject*, JNICallType, _jmethodID*, JNI_ArgumentPusher*, JavaThread*) [clone .constprop.1]+0x242 (/usr/lib/jvm/.../libjvm.so)
             3ffae390e86 jni_CallStaticVoidMethod+0x116 (/usr/lib/jvm/.../libjvm.so)
             3ffaf08b07e JavaMain+0x113e (/usr/lib/jvm/.../libjli.so)
             3ffaf08e040 ThreadJavaMain+0x20 (/usr/lib/jvm/.../libjli.so)
             3ffaedabbd8 start_thread+0x198 (/usr/lib64/libc.so.6)
             3ffaee2b950 thread_start+0x10 (/usr/lib64/libc.so.6)

Note that for the IP==0 case I am thinking about adding a common unwind
user check, to stop taking the deferred calltrace.


Sample for IP == ffffffffffffff (perf does not display any call chain):

# perf script
...
java    1084    44.004346:    1001001 task-clock:ppp:

...
[next entry]

# perf script --no-merge-callchain
...
java    1084    44.004346:    1001001 task-clock:ppp:
               400000079 (cookie) ([unknown])

java    1084    44.004348: DEFERRED CALLCHAIN [cookie: 400000079]

...
[next entry]

# perf report -D
...
44004346257 0x17718 [0x40]: PERF_RECORD_SAMPLE(IP, 0x2): 1082/1084: 0x3ffa3e413aa period: 1001001 addr: 0
... FP chain: nr:2
.....  0: fffffffffffffd80
.....  1: 0000000400000079
...... (deferred)
 ... thread: java:1084
 ...... dso: /tmp/perf-1082.map

0x17758@perf.data [0xd0]: event: 22
.
. ... raw event: size 208 bytes
.  0000:  00 00 00 16 00 02 00 d0 00 00 00 04 00 00 00 79  ...............y
.  0010:  00 00 00 00 00 00 00 15 00 00 03 ff a3 e4 13 aa  ................
.  0020:  00 00 03 ff 38 09 e2 d0 00 00 03 ff 38 09 e1 30  ....8.......8..0
.  0030:  00 00 03 ff b9 5f df 68 00 00 00 00 00 00 00 00  ....._.h........
.  0040:  00 00 03 ff b9 5f e1 28 00 00 03 ff b9 5f e1 d0  ....._.(....._..
.  0050:  00 57 80 88 8e 76 47 a5 00 00 03 ff a3 e4 37 f2  .W...vG.......7.
.  0060:  ff ff ff ff ff ff ff ff 00 00 03 ff a3 e4 a1 fc  ................
.  0070:  00 00 00 00 00 00 00 00 00 00 03 ff a3 e3 79 00  ..............y.
.  0080:  00 00 03 ff a3 e4 10 80 00 00 03 ff b9 dd 11 de  ................
.  0090:  00 00 03 ff b9 e8 df 92 00 00 03 ff b9 e9 0e 86  ................
.  00a0:  00 00 03 ff ba b8 b0 7e 00 00 03 ff ba b8 e0 40  .......~.......@
.  00b0:  00 00 03 ff ba 8a bb d8 00 00 03 ff ba 92 b9 50  ...............P
.  00c0:  00 00 04 3a 00 00 04 3c 00 00 00 0a 3e dd 13 c0  ...:...<....>...

44004348864 0x17758 [0xd0]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 1082/1084: 0x400000079
... FP chain: nr:21
.....  0: 000003ffa3e413aa
.....  1: 000003ff3809e2d0
.....  2: 000003ff3809e130
.....  3: 000003ffb95fdf68
.....  4: 0000000000000000
.....  5: 000003ffb95fe128
.....  6: 000003ffb95fe1d0
.....  7: 005780888e7647a5
.....  8: 000003ffa3e437f2
.....  9: ffffffffffffffff <-- !
..... 10: 000003ffa3e4a1fc
..... 11: 0000000000000000
..... 12: 000003ffa3e37900
..... 13: 000003ffa3e41080
..... 14: 000003ffb9dd11de
..... 15: 000003ffb9e8df92
..... 16: 000003ffb9e90e86
..... 17: 000003ffbab8b07e
..... 18: 000003ffbab8e040
..... 19: 000003ffba8abbd8
..... 20: 000003ffba92b950
: unhandled!

...
[next entry]


On 11/21/2025 12:48 AM, Namhyung Kim wrote:
> Handle the deferred callchains in the script output.
> 
>   $ perf script
>   ...
>   pwd    2312   121.163435:     249113 cpu/cycles/P:
>           ffffffff845b78d8 __build_id_parse.isra.0+0x218 ([kernel.kallsyms])
>           ffffffff83bb5bf6 perf_event_mmap+0x2e6 ([kernel.kallsyms])
>           ffffffff83c31959 mprotect_fixup+0x1e9 ([kernel.kallsyms])
>           ffffffff83c31dc5 do_mprotect_pkey+0x2b5 ([kernel.kallsyms])
>           ffffffff83c3206f __x64_sys_mprotect+0x1f ([kernel.kallsyms])
>           ffffffff845e6692 do_syscall_64+0x62 ([kernel.kallsyms])
>           ffffffff8360012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])
>                  b00000006 (cookie) ([unknown])
> 
>   pwd    2312   121.163447: DEFERRED CALLCHAIN [cookie: b00000006]
>               7f18fe337fa7 mprotect+0x7 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>               7f18fe330e0f _dl_sysdep_start+0x7f (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>               7f18fe331448 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c

> +static int process_deferred_sample_event(const struct perf_tool *tool,
> +					 union perf_event *event,
> +					 struct perf_sample *sample,
> +					 struct evsel *evsel,
> +					 struct machine *machine)
> +{

> +	perf_sample__fprintf_start(scr, sample, al.thread, evsel,
> +				   PERF_RECORD_CALLCHAIN_DEFERRED, fp);
> +	fprintf(fp, "DEFERRED CALLCHAIN [cookie: %llx]",
> +		(unsigned long long)event->callchain_deferred.cookie);
> +
> +	if (PRINT_FIELD(IP)) {
> +		struct callchain_cursor *cursor = NULL;
> +
> +		if (symbol_conf.use_callchain && sample->callchain) {
> +			cursor = get_tls_callchain_cursor();
> +			if (thread__resolve_callchain(al.thread, cursor, evsel,
> +						      sample, NULL, NULL,
> +						      scripting_max_stack)) {

thread__resolve_callchain()
calls __thread__resolve_callchain()
calls thread__resolve_callchain_sample():

        for (i = first_call, nr_entries = 0;
             i < chain_nr && nr_entries < max_stack; i++) {
...
                ip = chain->ips[j];
                if (ip < PERF_CONTEXT_MAX)   <-- IP=ff..ff is greater than PERF_CONTEXT_MAX
                       ++nr_entries;
...
                err = add_callchain_ip(thread, cursor, parent,
                                       root_al, &cpumode, ip,
                                       false, NULL, NULL, 0, symbols);

                if (err)
                        return (err < 0) ? err : 0;

calls add_callchain_ip:

               if (ip >= PERF_CONTEXT_MAX) {
                       switch (ip) {
                       case PERF_CONTEXT_HV:
                               *cpumode = PERF_RECORD_MISC_HYPERVISOR;
                               break;
                       case PERF_CONTEXT_KERNEL:
                               *cpumode = PERF_RECORD_MISC_KERNEL;
                               break;
                       case PERF_CONTEXT_USER:
                       case PERF_CONTEXT_USER_DEFERRED:
                               *cpumode = PERF_RECORD_MISC_USER;
                               break;
                       default:
                               pr_debug("invalid callchain context: "  <-- IP=ff..ff reaches default case
                                        "%"PRId64"\n", (s64) ip);
                               /*
                                * It seems the callchain is corrupted.
                                * Discard all.
                                */
                               callchain_cursor_reset(cursor);
                               err = 1;
                               goto out;
                       }

> +				pr_info("cannot resolve deferred callchains\n");
> +				cursor = NULL;
> +			}
> +		}
> +
> +		fputc(cursor ? '\n' : ' ', fp);
> +		sample__fprintf_sym(sample, &al, 0, output[type].print_ip_opts,
> +				    cursor, symbol_conf.bt_stop_list, fp);
> +	}
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



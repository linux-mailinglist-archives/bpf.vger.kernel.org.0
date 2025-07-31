Return-Path: <bpf+bounces-64790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299DEB16EB1
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73BB3A929E
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9CB215773;
	Thu, 31 Jul 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tDdSCEj+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA38F4FA;
	Thu, 31 Jul 2025 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954308; cv=none; b=sdNGzRtdIJS9yHN1jXgbjgNL6wPZECQXy+LyNcgVDnzto4/Vp5HX+8DMhXudFH/pZIW0DPpHPrLCtjIkp5tW1raQz92nywNsaF1GSpiaWFUCdfksVwTcp909koRo+9QatvNkLg3SQjMf9gIgMF40JdSphmAX6qvX49o8WpDabig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954308; c=relaxed/simple;
	bh=e5sOtBQSTprA4SsSB6HQtOMPvByN0onydcdwMvxuACc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZBW6VnJ4K3/Tu+URHVQPh5EcjO1PA9Odlmp/qZWIww62YPhnrE2/K8OMiM6yLAjHXovETHCbG7Xgn12qRlvCtwOYpIWmXMByZdQCR3u4kWrJSeFjJFPIHL93ZqlWzlzLcLAFWrUNURw+KZePaOK0cIPw0X2XuBdkogz0Nz6Qh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tDdSCEj+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UMaG39001913;
	Thu, 31 Jul 2025 09:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/fVo2N
	MXAQw6f63nmVjGuH6LUcMRchhuA8Vuxr7kpFk=; b=tDdSCEj+SyF5OuOp/AOUwA
	HnA5gI5zHBk4sT/8ouz2R4WaIfb7D+RngapblF/2gUXwHqVJqTdiig7kCt4M4xPl
	fN7B4h2awg972x4zaCZi+iYI6KLLpEEcYwEFgNnk7BHK/WW0jqx5hGQa4JXMF7Ut
	cyqkFyIeJE5hIPmSByDUhgwOjrOv1A9L3Mqn+6c9AIQEYWlgYPRZdG8QXsRas1YV
	tKdJiJWoICtFEJC0f6/OssQAYroGSroPfICsKuFAhWB8O02ubUFGZm67WgpuaClz
	WV9Swm/I4/dxcOO7ClS8411RUGkdrtXsFZmWUKi5sEdF9y54DEqQoKIJ8WiIADVQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hyu2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 09:31:41 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56V9IZXG031235;
	Thu, 31 Jul 2025 09:31:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hyu2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 09:31:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56V6bQbn017464;
	Thu, 31 Jul 2025 09:31:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859r0bx3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 09:31:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56V9VZN054788562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 09:31:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2ABE20043;
	Thu, 31 Jul 2025 09:31:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61D3120040;
	Thu, 31 Jul 2025 09:31:35 +0000 (GMT)
Received: from [9.152.212.130] (unknown [9.152.212.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Jul 2025 09:31:35 +0000 (GMT)
Message-ID: <24ee5468-176a-49d3-ae5f-347486072d0d@linux.ibm.com>
Date: Thu, 31 Jul 2025 11:31:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/s390: Regression: Move uid filtering to BPF
 filters
To: Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, andriin@fb.com,
        irogers@google.com, bpf@vger.kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com, Jiri Olsa <jolsa@redhat.com>
References: <20250728144340.711196-1-tmricht@linux.ibm.com>
 <6018b52aec24000a751165f816dbd4522be8d06d.camel@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <6018b52aec24000a751165f816dbd4522be8d06d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mWdBZK73Pmw_2brn43IyR1wn_68TJvlf
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=688b37fd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=FOH2dFAWAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=N1nwZ7cdkbh0L4KVqbEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eeV0ChkMZu9r_nqhRF40meWKABlqWaWu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2NCBTYWx0ZWRfX3w+qr4+T1Ixu
 WG/n2JJbyzJxie4celnrVqph8R3sElt/TowoPvwdOxTt1YtvB2Dk3b+SIzee9eXjBZ7elnlcPtw
 DKpJlfTIbS6PdAn8bC0JZ5q2yZih3Hgxtk4ySf7q8whIpL47Ppi8NDUuNIdwFkSBU6YmOpG3Pdw
 nDvuycJjNpLNIIjjF74Mcs6mJrb7dxWUzApTcJnJZtLlNLJtPfa/GXQNxlYBqbVUxhn5NSC8gJH
 J9SMsBmtfzazsCd5nsNlJSvZyv8qWDpTXfuX+NNQ+TACpyfC5QEREji0lycnmSv9uJw0wKhloeN
 3WQ/GosV57FhKnyQcl+Hx1FxtbGI0JvZkMLfnHRQDJRew1NUvqhvsUxcJ4/t8zE1XJQU1ZolXgi
 Dq9L7QlIVSJFTkdiEJ1RYwLaObTckYPiy2PFbHt5SuL79qaJvjmkjSvG/fJqetG1DJS9ksex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310064

On 7/31/25 10:38, Ilya Leoshkevich wrote:
> On Mon, 2025-07-28 at 16:43 +0200, Thomas Richter wrote:
>> V1 --> V2: Added Jiri Olsa's suggestion and introduced
>>            member bpf_perf_event_opts::no_ioctl_enable.
>>
>> On linux-next
>> commit b4c658d4d63d61 ("perf target: Remove uid from target")
>> introduces a regression on s390. In fact the regression exists
>> on all platforms when the event supports auxiliary data gathering.
>>
>> Command
>>    # ./perf record -u 0 -aB --synth=no -- ./perf test -w thloop
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.011 MB perf.data ]
>>    # ./perf report --stats | grep SAMPLE
>>    #
>>
>> does not generate samples in the perf.data file.
>> On x86 command
>>   # sudo perf record -e intel_pt// -u 0 ls
>> is broken too.
>>
>> Looking at the sequence of calls in 'perf record' reveals this
>> behavior:
>> 1. The event 'cycles' is created and enabled:
>>    record__open()
>>    +-> evlist__apply_filters()
>>        +-> perf_bpf_filter__prepare()
>> 	   +-> bpf_program.attach_perf_event()
>> 	       +-> bpf_program.attach_perf_event_opts()
>> 	           +-> __GI___ioctl(..., PERF_EVENT_IOC_ENABLE, ...)
>>    The event 'cycles' is enabled and active now. However the event's
>>    ring-buffer to store the samples generated by hardware is not
>>    allocated yet. This happens now after enabling the event:
>>
>> 2. The event's fd is mmap() to create the ring buffer:
>>    record__open()
>>    +-> record__mmap()
>>        +-> record__mmap_evlist()
>> 	   +-> evlist__mmap_ex()
>> 	       +-> perf_evlist__mmap_ops()
>> 	           +-> mmap_per_cpu()
>> 	               +-> mmap_per_evsel()
>> 	                   +-> mmap__mmap()
>> 	                       +-> perf_mmap__mmap()
>> 	                           +-> mmap()
>>
>>    This allocates the ring-buffer for the event 'cycles'.  With
>> mmap()
>>    the kernel creates the ring buffer:
>>
>>    perf_mmap(): kernel function to create the event's ring
>>    |            buffer to save the sampled data.
>>    |
>>    +-> ring_buffer_attach(): Allocates memory for ring buffer.
>>        |        The PMU has auxiliary data setup function. The
>>        |        has_aux(event) condition is true and the PMU's
>>        |        stop() is called to stop sampling. It is not
>>        |        restarted:
>>        |        if (has_aux(event))
>>        |                perf_event_stop(event, 0);
>>        |
>>        +-> cpumsf_pmu_stop():
>>
>>    Hardware sampling is stopped. No samples are generated and saved
>>    anymore.
>>
>> 3. After the event 'cycles' has been mapped, the event is enabled a
>>    second time in:
>>    __cmd_record()
>>    +-> evlist__enable()
>>        +-> __evlist__enable()
>> 	   +-> evsel__enable_cpu()
>> 	       +-> perf_evsel__enable_cpu()
>> 	           +-> perf_evsel__run_ioctl()
>> 	               +-> perf_evsel__ioctl()
>> 	                   +-> __GI___ioctl(.,
>> PERF_EVENT_IOC_ENABLE, .)
>>    The second
>>       ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
>>    is just a NOP in this case. The first invocation in (1.) sets the
>>    event::state to PERF_EVENT_STATE_ACTIVE. The kernel functions
>>    perf_ioctl()
>>    +-> _perf_ioctl()
>>        +-> _perf_event_enable()
>>            +-> __perf_event_enable() returns immediately because
>> 	              event::state is already set to
>> 		      PERF_EVENT_STATE_ACTIVE.
>>
>> This happens on s390, because the event 'cycles' offers the
>> possibility
>> to save auxilary data. The PMU call backs setup_aux() and
>> free_aux() are defined. Without both call back functions,
>> cpumsf_pmu_stop() is not invoked and sampling continues.
>>
>> To remedy this, remove the first invocation of
>>    ioctl(..., PERF_EVENT_IOC_ENABLE, ...).
>> in step (1.) Create the event in step (1.) and enable it in step (3.)
>> after the ring buffer has been mapped.
>> Make the change backward compatible and introduce a new structure
>> member bpf_perf_event_opts::no_ioctl_enable. It defaults to false and
>> only
>> bpf_program__attach_perf_event() sets it to true. This way only
>> perf tool invocation do not enable the sampling event.
>>
>> Output after:
>>  # ./perf record -aB --synth=no -u 0 -- ./perf test -w thloop 2
>>  [ perf record: Woken up 3 times to write data ]
>>  [ perf record: Captured and wrote 0.876 MB perf.data ]
>>  # ./perf  report --stats | grep SAMPLE
>>               SAMPLE events:      16200  (99.5%)
>>               SAMPLE events:      16200
>>  #
>>
>> The software event succeeded before and after the patch:
>>  # ./perf record -e cpu-clock -aB --synth=no -u 0 -- \
>> 					  ./perf test -w thloop 2
>>  [ perf record: Woken up 7 times to write data ]
>>  [ perf record: Captured and wrote 2.870 MB perf.data ]
>>  # ./perf  report --stats | grep SAMPLE
>>               SAMPLE events:      53506  (99.8%)
>>               SAMPLE events:      53506
>>  #
>>
>> Fixes: 63f2f5ee856ba ("libbpf: add ability to attach/detach BPF
>> program to perf event")
>> To: Andrii Nakryiko <andriin@fb.com>
>> To: Ian Rogers <irogers@google.com>
>> To: Ilya Leoshkevich <iii@linux.ibm.com>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Suggested-by: Jiri Olsa <jolsa@redhat.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 19 +++++++++++++------
>>  tools/lib/bpf/libbpf.h |  3 ++-
>>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> What do you think about rather calling the new field ioctl_enable?
> So that we don't get double negations in the API users and
> implementation - they are sometimes unnecessarily confusing.
> 
> I also think enablement should be the default in
> bpf_program__attach_perf_event(), and perf should now call
> bpf_program__attach_perf_event_opts() instead.
> 
> Based on your request in v1, I can offer to take over the patch and
> send a v3 with the changes I suggested above.

Yes Ilya, please go ahead.
Thanks very much for your support.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB29B3F8368
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhHZH5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 03:57:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232223AbhHZH5K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 03:57:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17Q7Z47A022345;
        Thu, 26 Aug 2021 03:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7Q2AaaJXjIMTtU6+1p90x6r2vzBYuL/tBVO/xxaX9+U=;
 b=TUdcfoFqnX6mfTUtiMHRkn1fM/vSc4eFqIQx6/O2mbvmVHsSS4s1EdCkL5nfhPihTExx
 rdqanEJYZsy9eZlkvnWfYKEEEj3vdcMgO/I+PqSLDzhCNIzQmZG0c0QfH1tyFQX/RE9r
 Mw/yrLWP6l5Cby2zKDsLDG3GsplEJASvz5peOrQxCI004DSfhzSdS0xuXswPn3oMPQ03
 RORQ7YKnSNPIB/y4jNV6FCXipnObnGSWf4vAyoXwXe95/8fyDaCCctkboj2KqS3aZOLJ
 9WTdn+E0AYdviQqCOEpdIKL2JjG6F4Wb6kigRE85kgDT+Tap8I13nBTE/LXRVp3NtMIB DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ap4n93g94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 03:56:14 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17Q7ZF0f023904;
        Thu, 26 Aug 2021 03:56:14 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ap4n93g8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 03:56:14 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17Q7qiNY007845;
        Thu, 26 Aug 2021 07:56:13 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3ajs4e5fx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 07:56:13 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17Q7uCv330081440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 07:56:12 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92D8F28059;
        Thu, 26 Aug 2021 07:56:12 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 484B828058;
        Thu, 26 Aug 2021 07:56:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.48.53])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 26 Aug 2021 07:56:09 +0000 (GMT)
Subject: Re: [PATCH bpf-next 1/3] perf: enable branch record for software
 events
To:     Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
References: <20210824060157.3889139-1-songliubraving@fb.com>
 <20210824060157.3889139-2-songliubraving@fb.com>
 <YSYy87ta1GpXCCzk@hirez.programming.kicks-ass.net>
 <19CA9F65-E45B-4AE5-9742-3D89ECF0CEF4@fb.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <71cdc0ec-1b58-69c1-eaca-631800774c13@linux.ibm.com>
Date:   Thu, 26 Aug 2021 13:26:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <19CA9F65-E45B-4AE5-9742-3D89ECF0CEF4@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SzTNvCcQHNKfoxd3tWSdv54057XNCK1N
X-Proofpoint-GUID: zZUBHF8Q1fw4nIqs53Luu1esjNjqa7r-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-26_01:2021-08-25,2021-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108260044
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/25/21 8:52 PM, Song Liu wrote:
> 
> 
>> On Aug 25, 2021, at 5:09 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Mon, Aug 23, 2021 at 11:01:55PM -0700, Song Liu wrote:
>>
>>> arch/x86/events/intel/core.c |  5 ++++-
>>> arch/x86/events/intel/lbr.c  | 12 ++++++++++++
>>> arch/x86/events/perf_event.h |  2 ++
>>> include/linux/perf_event.h   | 33 +++++++++++++++++++++++++++++++++
>>> kernel/events/core.c         | 28 ++++++++++++++++++++++++++++
>>> 5 files changed, 79 insertions(+), 1 deletion(-)
>>
>> No PowerPC support :/
> 
> I don't have PowerPC system for testing at the moment. I guess we can decide
> the overall framework now, and ask PowerPC folks' help on PowerPC support
> later? 

Hi Song,
   I will look at powerpc side to enable this.

Thanks,
Kajol Jain

> 
>>
>>> +void intel_pmu_snapshot_branch_stack(void)
>>> +{
>>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>> +
>>> +	intel_pmu_lbr_disable_all();
>>> +	intel_pmu_lbr_read();
>>> +	memcpy(this_cpu_ptr(&perf_branch_snapshot_entries), cpuc->lbr_entries,
>>> +	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
>>> +	*this_cpu_ptr(&perf_branch_snapshot_size) = x86_pmu.lbr_nr;
>>> +	intel_pmu_lbr_enable_all(false);
>>> +}
>>
>> Still has the layering violation and issues vs PMI.
> 
> Yes, this is the biggest change after I test with this more. I tested with 
> perf_[disable|enable]_pmu(), and function pointer in "struct pmu". However,
> all these logic consumes LBR entries. In one of the version, 22 out of the
> 32 LBR entries are branches after the fexit event. Most of them are from
> perf_disable_pmu(). And each function pointer consumes 1 or 2 entries. 
> This would be worse for systems with fewer LBR entries. 
> 
> On the other hand, I think current version was not too bad. It may corrupt
> some samples when there is collision between this and PMI. But it should not
> cause serious issues. Did I miss anything more serious? 
> 
>>
>>> +#ifdef CONFIG_HAVE_STATIC_CALL
>>> +DECLARE_STATIC_CALL(perf_snapshot_branch_stack,
>>> +		    perf_default_snapshot_branch_stack);
>>> +#else
>>> +extern void (*perf_snapshot_branch_stack)(void);
>>> +#endif
>>
>> That's weird, static call should work unconditionally, and fall back to
>> a regular function pointer exactly like you do here. Search for:
>> "Generic Implementation" in include/linux/static_call.h
> 
> Thanks for the pointer. Let me look into it. 
>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 011cc5069b7ba..b42cc20451709 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>
>>> +#ifdef CONFIG_HAVE_STATIC_CALL
>>> +DEFINE_STATIC_CALL(perf_snapshot_branch_stack,
>>> +		   perf_default_snapshot_branch_stack);
>>> +#else
>>> +void (*perf_snapshot_branch_stack)(void) = perf_default_snapshot_branch_stack;
>>> +#endif
>>
>> Idem.
>>
>> Something like:
>>
>> DEFINE_STATIC_CALL_NULL(perf_snapshot_branch_stack, void (*)(void));
>>
>> with usage like: static_call_cond(perf_snapshot_branch_stack)();
>>
>> Should unconditionally work.
>>
>>> +int perf_read_branch_snapshot(void *buf, size_t len)
>>> +{
>>> +	int cnt;
>>> +
>>> +	memcpy(buf, *this_cpu_ptr(&perf_branch_snapshot_entries),
>>> +	       min_t(u32, (u32)len,
>>> +		     sizeof(struct perf_branch_entry) * MAX_BRANCH_SNAPSHOT));
>>> +	cnt =  *this_cpu_ptr(&perf_branch_snapshot_size);
>>> +
>>> +	return (cnt > 0) ? cnt : -EOPNOTSUPP;
>>> +}
>>
>> Doesn't seem used at all..
> 
> At the moment, we only use this from BPF side (see 2/3). We sure can use it
> from perf side, but that would require discussions on the user interface. 
> How about we have that discussion later? 
> 
> Thanks,
> Song
> 

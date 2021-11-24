Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCB45B626
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 09:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbhKXIGs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 03:06:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48218 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233552AbhKXIGp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 03:06:45 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4Hcgf025927;
        Wed, 24 Nov 2021 08:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tQZPgisxY8eFDaoQ79EXgG/GivVXmlg6047GWXWgzyc=;
 b=B4+1zb1l+j2ICThgJQVcgw9I1Kb1t9r7wzQ6JzAYtwo8mMPZR0R6t1KGlh4f4eNd7iOh
 wFS9ZtRrUGel1BpJWnEz/k0KDLl0cKT+TPCuRHCiudIeMvYwtbaD+0uyI8g1qDt6iv/W
 wk/u1PNeSfE02WFTiFnHx2v3avZfdnqymDjYVDMRod/UzJcIa+n7W4AgJSh3Lr3ZUt1o
 XgPpy1MNjyNUEQjoqDQORV/CCn+tnInhktc9npHHiNHGTLWahNpUYBkgQdFhGvPq7ZDQ
 F5r8deUTLBKuPa4WAair8OhD6WgBbJDe8R7W5ERP/NAbNYYfJX50NEyWEW4DCcBeS44/ wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3che853ka5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 08:02:54 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AO81X2x024913;
        Wed, 24 Nov 2021 08:02:54 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3che853k9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 08:02:53 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AO7mcUd028533;
        Wed, 24 Nov 2021 08:02:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3cern9nccd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 08:02:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AO82mOb38666720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 08:02:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62F2A11CE16;
        Wed, 24 Nov 2021 08:02:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6200A11CDEF;
        Wed, 24 Nov 2021 08:02:42 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.71.39])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Nov 2021 08:02:42 +0000 (GMT)
Subject: Re: [PATCH v3] bpf: Remove config check to enable bpf support for
 branch records
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, peterz@infradead.org, songliubraving@fb.com,
        andrii@kernel.org, kafai@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, davem@davemloft.net, kpsingh@kernel.org,
        hawk@kernel.org, kuba@kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        rnsastry@linux.ibm.com, andrii.nakryiko@gmail.com
References: <20211123095104.54330-1-kjain@linux.ibm.com>
 <d5436a4c-f4dc-7d6c-f521-505e35c57fb5@iogearbox.net>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <511fb009-74cf-fd15-5f03-e1bbef296681@linux.ibm.com>
Date:   Wed, 24 Nov 2021 13:32:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <d5436a4c-f4dc-7d6c-f521-505e35c57fb5@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MgXOcIoPr3bzeaJ-Xb7Y74WdmntZcInV
X-Proofpoint-GUID: _F7egUO9JzV_jx1TkgrqLXn8DGMWwgCN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_02,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240042
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/21 5:33 PM, Daniel Borkmann wrote:
> On 11/23/21 10:51 AM, Kajol Jain wrote:
>> Branch data available to bpf programs can be very useful to get
>> stack traces out of userspace application.
>>
>> Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
>> added bpf support to capture branch records in x86. Enable this feature
>> for other architectures as well by removing check specific to x86.
>>
>> Incase any architecture doesn't support branch records,
>> bpf_read_branch_records still have appropriate checks and it
>> will return error number -EINVAL in that scenario. But based on
>> documentation there in include/uapi/linux/bpf.h file, incase of
>> unsupported archs, this function should return -ENOENT. Hence update
>> the appropriate checks to return -ENOENT instead.
>>
>> Selftest 'perf_branches' result on power9 machine which has branch stacks
>> support.
>>
>> Before this patch changes:
>> [command]# ./test_progs -t perf_branches
>>   #88/1 perf_branches/perf_branches_hw:FAIL
>>   #88/2 perf_branches/perf_branches_no_hw:OK
>>   #88 perf_branches:FAIL
>> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
>>
>> After this patch changes:
>> [command]# ./test_progs -t perf_branches
>>   #88/1 perf_branches/perf_branches_hw:OK
>>   #88/2 perf_branches/perf_branches_no_hw:OK
>>   #88 perf_branches:OK
>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Selftest 'perf_branches' result on power9 machine which doesn't
>> have branch stack report.
>>
>> After this patch changes:
>> [command]# ./test_progs -t perf_branches
>>   #88/1 perf_branches/perf_branches_hw:SKIP
>>   #88/2 perf_branches/perf_branches_no_hw:OK
>>   #88 perf_branches:OK
>> Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED
>>
>> Fixes: fff7b64355eac ("bpf: Add bpf_read_branch_records() helper")
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>
>> Tested this patch changes on power9 machine using selftest
>> 'perf branches' which is added in commit 67306f84ca78 ("selftests/bpf:
>> Add bpf_read_branch_records()")
>>
>> Changelog:
>> v2 -> v3
>> - Change the return error number for bpf_read_branch_records
>>    function from -EINVAL to -ENOENT for appropriate checks
>>    as suggested by Daniel Borkmann.
>>
>> - Link to the v2 patch: https://lkml.org/lkml/2021/11/18/510
>>
>> v1 -> v2
>> - Inorder to add bpf support to capture branch record in
>>    powerpc, rather then adding config for powerpc, entirely
>>    remove config check from bpf_read_branch_records function
>>    as suggested by Peter Zijlstra
>>
>> - Link to the v1 patch: https://lkml.org/lkml/2021/11/14/434
>>
>>   kernel/trace/bpf_trace.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 7396488793ff..b94a00f92759 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1402,18 +1402,15 @@ static const struct bpf_func_proto
>> bpf_perf_prog_read_value_proto = {
>>   BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern
>> *, ctx,
>>          void *, buf, u32, size, u64, flags)
>>   {
>> -#ifndef CONFIG_X86
>> -    return -ENOENT;
>> -#else
>>       static const u32 br_entry_size = sizeof(struct perf_branch_entry);
>>       struct perf_branch_stack *br_stack = ctx->data->br_stack;
>>       u32 to_copy;
>>         if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
>> -        return -EINVAL;
>> +        return -ENOENT;
> 
> What's the rationale for also changing the above? Invalid/unsupported
> flags should
> still return -EINVAL as they did before ...

Thanks for pointing it, I will make this change in the next version.

Thanks,
Kajol Jain

> 
>>       if (unlikely(!br_stack))
>> -        return -EINVAL;
>> +        return -ENOENT;
> 
> ... meaning only this one here was necessary.
> 
>>       if (flags & BPF_F_GET_BRANCH_RECORDS_SIZE)
>>           return br_stack->nr * br_entry_size;
>> @@ -1425,7 +1422,6 @@ BPF_CALL_4(bpf_read_branch_records, struct
>> bpf_perf_event_data_kern *, ctx,
>>       memcpy(buf, br_stack->entries, to_copy);
>>         return to_copy;
>> -#endif
>>   }
>>     static const struct bpf_func_proto bpf_read_branch_records_proto = {
>>
> 

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F805456C63
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 10:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhKSJit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 04:38:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229633AbhKSJit (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Nov 2021 04:38:49 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ9UBZO027172;
        Fri, 19 Nov 2021 09:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Xug8Gy6TD6znYTxUHQl+mdaGuaFAbHiD9jNinLp3BUU=;
 b=fgngt3xr9zMArB1p4ik8ppXrcWCAIGKyMDEUOLzXsnurmgUHJscoe95+YB6KBF31PHFL
 5ffAyjDGmqit9wEJIL7oyzDN2Bya4aei+M97AzenqKZp0pkcJp52dM4lhgz7RiuLfj56
 +2TFHbfGug0q7Nil6vciuT9Te29FJGqp8iIKpc+cEZL9FVwxo56vgfEy9uGFFLyJP9tf
 55AsBOCjLjOc0bAe64gIMPRW9ssfd1qC9utHhkQSjvHXQNUaN9liMwiG29MCfHK/jOsw
 9vGyKXoHCErY/rHZjFPaDmaW6NS9It58UGkhB/AcGnIrhM+R6R+FKNzn/pgtTkBh4uwk Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce9bqr212-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 09:35:27 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJ9W6Bl031001;
        Fri, 19 Nov 2021 09:35:26 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce9bqr201-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 09:35:26 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ9Xi40006804;
        Fri, 19 Nov 2021 09:35:23 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3ca50d4p7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 09:35:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJ9ZKBa63701344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 09:35:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D38B54204D;
        Fri, 19 Nov 2021 09:35:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5003142049;
        Fri, 19 Nov 2021 09:35:15 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.68.135])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Nov 2021 09:35:15 +0000 (GMT)
Subject: Re: [PATCH v2] bpf: Remove config check to enable bpf support for
 branch records
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        KP Singh <kpsingh@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        rnsastry@linux.ibm.com
References: <20211118130507.170154-1-kjain@linux.ibm.com>
 <CAEf4BzbDgCVLj0r=3iponPp81aVAGokhGti8WLfWKhHuTLdA8w@mail.gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <ce150f51-ef50-de85-fc52-0f2ee3a3000f@linux.ibm.com>
Date:   Fri, 19 Nov 2021 15:05:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAEf4BzbDgCVLj0r=3iponPp81aVAGokhGti8WLfWKhHuTLdA8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BTMwSCzJdMjSFUlVn9qfWIWBcFRxr229
X-Proofpoint-GUID: ItR1F47NJwouHmlHhT9qCJamckrdlKdd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_08,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111190052
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/19/21 4:18 AM, Andrii Nakryiko wrote:
> On Thu, Nov 18, 2021 at 5:10 AM Kajol Jain <kjain@linux.ibm.com> wrote:
>>
>> Branch data available to bpf programs can be very useful to get
>> stack traces out of userspace application.
>>
>> Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
>> added bpf support to capture branch records in x86. Enable this feature
>> for other architectures as well by removing check specific to x86.
>> Incase any platform didn't support branch stack, it will return with
>> -EINVAL.
>>
>> Selftest 'perf_branches' result on power9 machine with branch stacks
>> support.
>>
>> Before this patch changes:
>> [command]# ./test_progs -t perf_branches
>>  #88/1 perf_branches/perf_branches_hw:FAIL
>>  #88/2 perf_branches/perf_branches_no_hw:OK
>>  #88 perf_branches:FAIL
>> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
>>
>> After this patch changes:
>> [command]# ./test_progs -t perf_branches
>>  #88/1 perf_branches/perf_branches_hw:OK
>>  #88/2 perf_branches/perf_branches_no_hw:OK
>>  #88 perf_branches:OK
>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Selftest 'perf_branches' result on power9 machine which doesn't
>> support branch stack
>>
>> After this patch changes:
>> [command]# ./test_progs -t perf_branches
>>  #88/1 perf_branches/perf_branches_hw:SKIP
>>  #88/2 perf_branches/perf_branches_no_hw:OK
>>  #88 perf_branches:OK
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
>> v1 -> v2
>> - Inorder to add bpf support to capture branch record in
>>   powerpc, rather then adding config for powerpc, entirely
>>   remove config check from bpf_read_branch_records function
>>   as suggested by Peter Zijlstra
> 
> what will be returned for architectures that don't support branch
> records? Will it be zero instead of -ENOENT?
> 

Hi Andrii,
     Incase any architecture doesn't support branch records and if it
tries to do branch sampling with sample type as
PERF_SAMPLE_BRANCH_STACK, perf_event_open itself will fail.

And even if, perf_event_open succeeds  we have appropriate checks in
bpf_read_branch_records function, which will return -EINVAL for those
architectures.

Reference from linux/kernel/trace/bpf_trace.c

Here, br_stack will be empty, for unsupported architectures.

BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
	   void *, buf, u32, size, u64, flags)
{
.....
	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
		return -EINVAL;

	if (unlikely(!br_stack))
		return -EINVAL;
....
}

Thanks,
Kajol Jain

>>
>> - Link to the v1 patch: https://lkml.org/lkml/2021/11/14/434
>>
>>  kernel/trace/bpf_trace.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 7396488793ff..5e445985c6b4 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1402,9 +1402,6 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
>>  BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>>            void *, buf, u32, size, u64, flags)
>>  {
>> -#ifndef CONFIG_X86
>> -       return -ENOENT;
>> -#else
>>         static const u32 br_entry_size = sizeof(struct perf_branch_entry);
>>         struct perf_branch_stack *br_stack = ctx->data->br_stack;
>>         u32 to_copy;
>> @@ -1425,7 +1422,6 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>>         memcpy(buf, br_stack->entries, to_copy);
>>
>>         return to_copy;
>> -#endif
>>  }
>>
>>  static const struct bpf_func_proto bpf_read_branch_records_proto = {
>> --
>> 2.27.0
>>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34499459CFE
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 08:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhKWHrs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 02:47:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234323AbhKWHrr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 02:47:47 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN4NmBY022251;
        Tue, 23 Nov 2021 07:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7Izikt7bjG0cERrkxtMGGYIUF55KdaFWdipbuzLRGmM=;
 b=bOAot3E6AnxIcv9A94dzcHKMqUnoa625+oMLbt38nIypt2ITZZgfmLp7AfDOK6fYjL8f
 0lvnpwkFLiMiA/CeHAGg39pz8B9qLmir/mXIX2q0P/3upOSoVaY/Q5+cCoOk+r5hZifr
 gV2Bcnqyk1RrhsJyhVuAIsCGEGDvKSJhHvFSll6EzpZllhO2t0WrfOoMIcIhV3M2EFFe
 wKLMyeoAz3OiRApaR551NU2dGYP5ZDmiDF/Q84KYRjDiR14U2iRA9OPpJE9asMR6h4IK
 jd25Sm3osEVSWT8NITC/Au6UyDZXnEQynhNMt1jkz08CyazF8QGi4inE2hiUvDW5UUPl hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgs7tb00q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 07:44:18 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AN7YoVA006748;
        Tue, 23 Nov 2021 07:44:18 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgs7tb002-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 07:44:17 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AN7gGd8029841;
        Tue, 23 Nov 2021 07:44:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3cern9m0cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 07:44:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AN7b3BK62783776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 07:37:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0172A405C;
        Tue, 23 Nov 2021 07:44:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8203BA4054;
        Tue, 23 Nov 2021 07:44:05 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.21.81])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Nov 2021 07:44:05 +0000 (GMT)
Subject: Re: [PATCH v2] bpf: Remove config check to enable bpf support for
 branch records
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
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
 <ce150f51-ef50-de85-fc52-0f2ee3a3000f@linux.ibm.com>
 <859f8b57-7ae2-3c68-5642-93bec7a59a20@iogearbox.net>
 <CAEf4BzbP0hAJYr-dahNZqKe9wyYL6hD9FayS-qdQV+Lmyi_VTQ@mail.gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <814c0e79-b8fd-38f1-bf17-cbf0993479bf@linux.ibm.com>
Date:   Tue, 23 Nov 2021 13:14:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbP0hAJYr-dahNZqKe9wyYL6hD9FayS-qdQV+Lmyi_VTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v7ir4QnkF6C65nsvbPFNGOpgqbtQ1UTr
X-Proofpoint-ORIG-GUID: zuk4d111fp2t7655P5cJAQxqKC5sido5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_02,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230038
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/21 4:15 AM, Andrii Nakryiko wrote:
> On Fri, Nov 19, 2021 at 8:08 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 11/19/21 10:35 AM, kajoljain wrote:
>>> On 11/19/21 4:18 AM, Andrii Nakryiko wrote:
>>>> On Thu, Nov 18, 2021 at 5:10 AM Kajol Jain <kjain@linux.ibm.com> wrote:
>>>>>
>>>>> Branch data available to bpf programs can be very useful to get
>>>>> stack traces out of userspace application.
>>>>>
>>>>> Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
>>>>> added bpf support to capture branch records in x86. Enable this feature
>>>>> for other architectures as well by removing check specific to x86.
>>>>> Incase any platform didn't support branch stack, it will return with
>>>>> -EINVAL.
>>>>>
>>>>> Selftest 'perf_branches' result on power9 machine with branch stacks
>>>>> support.
>>>>>
>>>>> Before this patch changes:
>>>>> [command]# ./test_progs -t perf_branches
>>>>>   #88/1 perf_branches/perf_branches_hw:FAIL
>>>>>   #88/2 perf_branches/perf_branches_no_hw:OK
>>>>>   #88 perf_branches:FAIL
>>>>> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
>>>>>
>>>>> After this patch changes:
>>>>> [command]# ./test_progs -t perf_branches
>>>>>   #88/1 perf_branches/perf_branches_hw:OK
>>>>>   #88/2 perf_branches/perf_branches_no_hw:OK
>>>>>   #88 perf_branches:OK
>>>>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>>>>
>>>>> Selftest 'perf_branches' result on power9 machine which doesn't
>>>>> support branch stack
>>>>>
>>>>> After this patch changes:
>>>>> [command]# ./test_progs -t perf_branches
>>>>>   #88/1 perf_branches/perf_branches_hw:SKIP
>>>>>   #88/2 perf_branches/perf_branches_no_hw:OK
>>>>>   #88 perf_branches:OK
>>>>> Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED
>>>>>
>>>>> Fixes: fff7b64355eac ("bpf: Add bpf_read_branch_records() helper")
>>>>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>>>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>>>> ---
>>>>>
>>>>> Tested this patch changes on power9 machine using selftest
>>>>> 'perf branches' which is added in commit 67306f84ca78 ("selftests/bpf:
>>>>> Add bpf_read_branch_records()")
>>>>>
>>>>> Changelog:
>>>>> v1 -> v2
>>>>> - Inorder to add bpf support to capture branch record in
>>>>>    powerpc, rather then adding config for powerpc, entirely
>>>>>    remove config check from bpf_read_branch_records function
>>>>>    as suggested by Peter Zijlstra
>>>>
>>>> what will be returned for architectures that don't support branch
>>>> records? Will it be zero instead of -ENOENT?
>>>
>>> Hi Andrii,
>>>       Incase any architecture doesn't support branch records and if it
>>> tries to do branch sampling with sample type as
>>> PERF_SAMPLE_BRANCH_STACK, perf_event_open itself will fail.
>>>
>>> And even if, perf_event_open succeeds  we have appropriate checks in
>>> bpf_read_branch_records function, which will return -EINVAL for those
>>> architectures.
>>>
>>> Reference from linux/kernel/trace/bpf_trace.c
>>>
>>> Here, br_stack will be empty, for unsupported architectures.
>>>
>>> BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>>>          void *, buf, u32, size, u64, flags)
>>> {
>>> .....
>>>       if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
>>>               return -EINVAL;
>>>
>>>       if (unlikely(!br_stack))
>>>               return -EINVAL;
>>
>> In that case for unsupported archs we should probably bail out with -ENOENT here
>> as helper doc says '**-ENOENT** if architecture does not support branch records'
>> (see bpf_read_branch_records() doc in include/uapi/linux/bpf.h).
> 
> Yep, I think so too.
> 

Hi Andrii/Daniel,
     I agree, changing return type to -ENOENT make sense, I will update
in next version of this patch.

Thanks,
Kajol Jain

>>
>>> ....
>>> }
>>>
>>> Thanks,
>>> Kajol Jain

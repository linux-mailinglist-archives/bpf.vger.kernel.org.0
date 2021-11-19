Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE8457267
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 17:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhKSQLx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 11:11:53 -0500
Received: from www62.your-server.de ([213.133.104.62]:59818 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhKSQLw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 11:11:52 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mo6RT-000EZh-K4; Fri, 19 Nov 2021 17:08:47 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mo6RT-000BTW-6J; Fri, 19 Nov 2021 17:08:47 +0100
Subject: Re: [PATCH v2] bpf: Remove config check to enable bpf support for
 branch records
To:     kajoljain <kjain@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <859f8b57-7ae2-3c68-5642-93bec7a59a20@iogearbox.net>
Date:   Fri, 19 Nov 2021 17:08:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ce150f51-ef50-de85-fc52-0f2ee3a3000f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26358/Fri Nov 19 10:19:46 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/19/21 10:35 AM, kajoljain wrote:
> On 11/19/21 4:18 AM, Andrii Nakryiko wrote:
>> On Thu, Nov 18, 2021 at 5:10 AM Kajol Jain <kjain@linux.ibm.com> wrote:
>>>
>>> Branch data available to bpf programs can be very useful to get
>>> stack traces out of userspace application.
>>>
>>> Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
>>> added bpf support to capture branch records in x86. Enable this feature
>>> for other architectures as well by removing check specific to x86.
>>> Incase any platform didn't support branch stack, it will return with
>>> -EINVAL.
>>>
>>> Selftest 'perf_branches' result on power9 machine with branch stacks
>>> support.
>>>
>>> Before this patch changes:
>>> [command]# ./test_progs -t perf_branches
>>>   #88/1 perf_branches/perf_branches_hw:FAIL
>>>   #88/2 perf_branches/perf_branches_no_hw:OK
>>>   #88 perf_branches:FAIL
>>> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
>>>
>>> After this patch changes:
>>> [command]# ./test_progs -t perf_branches
>>>   #88/1 perf_branches/perf_branches_hw:OK
>>>   #88/2 perf_branches/perf_branches_no_hw:OK
>>>   #88 perf_branches:OK
>>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>>
>>> Selftest 'perf_branches' result on power9 machine which doesn't
>>> support branch stack
>>>
>>> After this patch changes:
>>> [command]# ./test_progs -t perf_branches
>>>   #88/1 perf_branches/perf_branches_hw:SKIP
>>>   #88/2 perf_branches/perf_branches_no_hw:OK
>>>   #88 perf_branches:OK
>>> Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED
>>>
>>> Fixes: fff7b64355eac ("bpf: Add bpf_read_branch_records() helper")
>>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>> ---
>>>
>>> Tested this patch changes on power9 machine using selftest
>>> 'perf branches' which is added in commit 67306f84ca78 ("selftests/bpf:
>>> Add bpf_read_branch_records()")
>>>
>>> Changelog:
>>> v1 -> v2
>>> - Inorder to add bpf support to capture branch record in
>>>    powerpc, rather then adding config for powerpc, entirely
>>>    remove config check from bpf_read_branch_records function
>>>    as suggested by Peter Zijlstra
>>
>> what will be returned for architectures that don't support branch
>> records? Will it be zero instead of -ENOENT?
> 
> Hi Andrii,
>       Incase any architecture doesn't support branch records and if it
> tries to do branch sampling with sample type as
> PERF_SAMPLE_BRANCH_STACK, perf_event_open itself will fail.
> 
> And even if, perf_event_open succeeds  we have appropriate checks in
> bpf_read_branch_records function, which will return -EINVAL for those
> architectures.
> 
> Reference from linux/kernel/trace/bpf_trace.c
> 
> Here, br_stack will be empty, for unsupported architectures.
> 
> BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
> 	   void *, buf, u32, size, u64, flags)
> {
> .....
> 	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
> 		return -EINVAL;
> 
> 	if (unlikely(!br_stack))
> 		return -EINVAL;

In that case for unsupported archs we should probably bail out with -ENOENT here
as helper doc says '**-ENOENT** if architecture does not support branch records'
(see bpf_read_branch_records() doc in include/uapi/linux/bpf.h).

> ....
> }
> 
> Thanks,
> Kajol Jain

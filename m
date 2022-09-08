Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02C45B12CD
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 05:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIHDIF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 23:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIHDIE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 23:08:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FDE24F01;
        Wed,  7 Sep 2022 20:08:03 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MNPCK2xDPzHnfp;
        Thu,  8 Sep 2022 11:06:05 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 11:08:00 +0800
Received: from [10.67.109.184] (10.67.109.184) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 11:08:00 +0800
Subject: Re: [PATCH bpf-next 1/2] bpf, cgroup: Fix attach flags being assigned
 to effective progs
To:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220820120234.2121044-1-pulehui@huawei.com>
 <20220820120234.2121044-2-pulehui@huawei.com>
 <6305451ee5e7e_292a82086e@john.notmuch>
From:   Pu Lehui <pulehui@huawei.com>
Message-ID: <e726439f-0592-25c4-53e3-ce248940a736@huawei.com>
Date:   Thu, 8 Sep 2022 11:07:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6305451ee5e7e_292a82086e@john.notmuch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/8/24 5:22, John Fastabend wrote:
> Pu Lehui wrote:
>> Attach flags is only valid for attached progs of this layer cgroup,
>> but not for effective progs. We know that the attached progs is at
>> the beginning of the effective progs array, so we can just populate
>> the elements in front of the prog_attach_flags array.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> Trying to parse above, could you add a bit more detail on why this is
> problem so readers don't need to track it down.
> 
>> ---
>>   kernel/bpf/cgroup.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 59b7eb60d5b4..9adf72e99907 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -1091,11 +1091,14 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
>>   		}
>>   
> 
> Because we are looking at it let me try to understand. There are two
> paths that set cnt relative bits here,
> 

Hi John,

Thanks for your review. The reason is that:
For the following cgroup tree:
    root
     |
    cg1
     |
    cg2

I attached prog1 and prog2 to root cgroup with MULTI attach type, 
attached prog3 to cg1 with OVERRIDE attach type, and then used bpftool
to show this cgroup tree with effective query flag:

$ bpftool cgroup tree /sys/fs/cgroup effective
CgroupPath
ID       AttachType      AttachFlags     Name
/sys/fs/cgroup
1        sysctl          multi           sysctl_tcp_mem
2        sysctl          multi           sysctl_tcp_mem
/sys/fs/cgroup/cg1
3        sysctl          override        sysctl_tcp_mem
1        sysctl          override        sysctl_tcp_mem <- wrong
2        sysctl          override        sysctl_tcp_mem <- wrong
/sys/fs/cgroup/cg1/cg2
3        sysctl                          sysctl_tcp_mem
1        sysctl                          sysctl_tcp_mem
2        sysctl                          sysctl_tcp_mem

For cg1, obviously, the attach flags of prog1 and prog2 can not be 
OVERRIDE, and the attach flags of prog1 and prog2 is meaningless for 
cg1. We only need to care the attach flags of prog which attached to 
cg1, other progs attach flags should be omit.

>    if (attr->query.query_flags & BPF_F_QUERY_EFFECTIVE) {
>        ...
>        cnt = min_t(int, bpf_prog_array_length(effective), total_cnt);
>        ...
>    } else {
>       ...
>       progs = &cgrp->bpf.progs[atype];
>       cnt = min_t(int, prog_list_length(progs), total_cnt);
>       ...
>    }
> 
> And the docs claim
> 
>   *              **BPF_F_QUERY_EFFECTIVE**
>   *                      Only return information regarding programs which are
>   *                      currently effective at the specified *target_fd*.
> 
> so in the EFFECTIVE case should we be reporting flags at all if the
> commit message says "attach flags is only valid for attached progs
> of this layer cgroup, but not for effective progs."
> 
> And then in the else branch the change is what you have in the diff anyways correct?
> 
>>   		if (prog_attach_flags) {
>> +			int progs_cnt = prog_list_length(&cgrp->bpf.progs[atype]);
>>   			flags = cgrp->bpf.flags[atype];
>>   
>> -			for (i = 0; i < cnt; i++)
> 
> Do we need to min with total_cnt here so we don't walk off a short user list?
> 

We should limit it, will fix it in v2. For query without effective flag, 
progs_cnt will equal to cnt, and for effective flag situation, progs_cnt 
only calculate prog count which attached to this cgroup layer.

>> +			/* attach flags only for attached progs, but not effective progs */
>> +			for (i = 0; i < progs_cnt; i++)
>>   				if (copy_to_user(prog_attach_flags + i, &flags, sizeof(flags)))
>>   					return -EFAULT;
>> +
>>   			prog_attach_flags += cnt;
>>   		}
>>   
>> -- 
>> 2.25.1
>>
> .
> 

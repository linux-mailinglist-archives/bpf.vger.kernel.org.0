Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF25B6E74
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiIMNfv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiIMNfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 09:35:47 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844F57565;
        Tue, 13 Sep 2022 06:35:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MRkvH1V6Cz6PmRg;
        Tue, 13 Sep 2022 21:33:47 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP2 (Coremail) with SMTP id Syh0CgB3FG4ghyBjZ10pAw--.6868S2;
        Tue, 13 Sep 2022 21:35:37 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 0/2] Fix cgroup attach flags being assigned to
 effective progs
To:     sdf@google.com, John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20220908145304.3436139-1-pulehui@huaweicloud.com>
 <YxomJlABk3fzQ9bQ@google.com>
From:   Pu Lehui <pulehui@huaweicloud.com>
Message-ID: <bfafd1a1-4cc1-a7b7-f64e-bb8d16c94442@huaweicloud.com>
Date:   Tue, 13 Sep 2022 21:35:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YxomJlABk3fzQ9bQ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3FG4ghyBjZ10pAw--.6868S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy5KryDZFy3Jr43Cr1kAFb_yoW5ury5pF
        WkJF1Ut345Wry8JrWUJ34jqFy8Jr4xJw1jyr1DJF1UAr17tr10qry7Xw1vgr17Zr4xGr4r
        Zr15AFyUuw45t3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/9/9 1:28, sdf@google.com wrote:
> On 09/08, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
> 
>> When root-cgroup attach multi progs and sub-cgroup attach a
>> override prog, bpftool will display incorrectly for the attach
>> flags of the sub-cgroup’s effective progs:
> 
>> $ bpftool cgroup tree /sys/fs/cgroup effective
>> CgroupPath
>> ID       AttachType      AttachFlags     Name
>> /sys/fs/cgroup
>> 6        cgroup_sysctl   multi           sysctl_tcp_mem
>> 13       cgroup_sysctl   multi           sysctl_tcp_mem
>> /sys/fs/cgroup/cg1
>> 20       cgroup_sysctl   override        sysctl_tcp_mem
>> 6        cgroup_sysctl   override        sysctl_tcp_mem <- wrong
>> 13       cgroup_sysctl   override        sysctl_tcp_mem <- wrong
>> /sys/fs/cgroup/cg1/cg2
>> 20       cgroup_sysctl                   sysctl_tcp_mem
>> 6        cgroup_sysctl                   sysctl_tcp_mem
>> 13       cgroup_sysctl                   sysctl_tcp_mem
> 
>> For cg1, obviously, the attach flags of prog6 and prog13 can not be
>> OVERRIDE, and the attach flags of prog6 and prog13 is meaningless for
>> cg1. We only need to care the attach flags of prog which attached to
>> cg1, other progs attach flags should be omit. After these patches,
>> the above situation will show as bellow:
> 
>> $ bpftool cgroup tree /sys/fs/cgroup effective
>> CgroupPath
>> ID       AttachType      AttachFlags     Name
>> /sys/fs/cgroup
>> 6        cgroup_sysctl   multi           sysctl_tcp_mem
>> 13       cgroup_sysctl   multi           sysctl_tcp_mem
>> /sys/fs/cgroup/cg1
>> 20       cgroup_sysctl   override        sysctl_tcp_mem
>> 6        cgroup_sysctl                   sysctl_tcp_mem
>> 13       cgroup_sysctl                   sysctl_tcp_mem
>> /sys/fs/cgroup/cg1/cg2
>> 20       cgroup_sysctl                   sysctl_tcp_mem
>> 6        cgroup_sysctl                   sysctl_tcp_mem
>> 13       cgroup_sysctl                   sysctl_tcp_mem
> 
>> v2:
>> - Limit prog_cnt to avoid overflow. (John)
>> - Add more detail message.
> 
> John also raised a good question in v1: the flags don't seem to
> make sense when requesting effective list. So maybe not export them
> at all?
> 

Misunderstood John's meaning. will remove the attach flags when query 
with EFFECTIVE in next version. Thanks all.

>> v1:
>> https://lore.kernel.org/bpf/20220820120234.2121044-1-pulehui@huawei.com
> 
>> Pu Lehui (2):
>>    bpf, cgroup: Fix attach flags being assigned to effective progs
>>    bpftool: Fix cgroup attach flags being assigned to effective progs
> 
>>   kernel/bpf/cgroup.c        | 5 ++++-
>>   tools/bpf/bpftool/cgroup.c | 9 +++------
>>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
>> -- 
>> 2.25.1
> 


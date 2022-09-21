Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3F5BF3A2
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 04:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiIUClb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 22:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiIUClQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 22:41:16 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B115F7EA;
        Tue, 20 Sep 2022 19:41:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MXN0L3y39z6TBmr;
        Wed, 21 Sep 2022 10:39:14 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP1 (Coremail) with SMTP id cCh0CgAnHjLGeSpjr0NmBA--.31580S2;
        Wed, 21 Sep 2022 10:41:11 +0800 (CST)
Subject: Re: [PATCH bpf v4 0/2] Fix wrong cgroup attach flags being assigned
 to effective progs
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
References: <20220920154233.1494352-1-pulehui@huaweicloud.com>
From:   Pu Lehui <pulehui@huaweicloud.com>
Message-ID: <35405b07-76db-1d34-fdf2-9066ad21d142@huaweicloud.com>
Date:   Wed, 21 Sep 2022 10:41:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220920154233.1494352-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAnHjLGeSpjr0NmBA--.31580S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrWw1xXFWrCF1UAFWfAFb_yoW5GFyrpF
        WkA3WYywn5Wr9xJrWSk34jqayrtr48Aw1jyasrJr48ZFyxKry0yr17C3y0yr12vFsFkr4x
        ZF15uF98Gw45ta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/9/20 23:42, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When root-cgroup attach multi progs and sub-cgroup attach a
> override prog, bpftool will display incorrectly for the attach
> flags of the sub-cgroup’s effective progs:
> 
> $ bpftool cgroup tree /sys/fs/cgroup effective
> CgroupPath
> ID       AttachType      AttachFlags     Name
> /sys/fs/cgroup
> 6        cgroup_sysctl   multi           sysctl_tcp_mem
> 13       cgroup_sysctl   multi           sysctl_tcp_mem
> /sys/fs/cgroup/cg1
> 20       cgroup_sysctl   override        sysctl_tcp_mem
> 6        cgroup_sysctl   override        sysctl_tcp_mem <- wrong
> 13       cgroup_sysctl   override        sysctl_tcp_mem <- wrong
> /sys/fs/cgroup/cg1/cg2
> 20       cgroup_sysctl                   sysctl_tcp_mem
> 6        cgroup_sysctl                   sysctl_tcp_mem
> 13       cgroup_sysctl                   sysctl_tcp_mem
> 
> For cg1, obviously, the attach flags of prog6 and prog13 can not be
> OVERRIDE. And for query with EFFECTIVE flags, exporting attach flags
> does not make sense. So let's remove the AttachFlags field and the
> associated logic. After these patches, the above effective cgroup
> tree will show as bellow:
> 
> # bpftool cgroup tree /sys/fs/cgroup effective
> CgroupPath
> ID       AttachType      Name
> /sys/fs/cgroup
> 6        cgroup_sysctl   sysctl_tcp_mem
> 13       cgroup_sysctl   sysctl_tcp_mem
> /sys/fs/cgroup/cg1
> 20       cgroup_sysctl   sysctl_tcp_mem
> 6        cgroup_sysctl   sysctl_tcp_mem
> 13       cgroup_sysctl   sysctl_tcp_mem
> /sys/fs/cgroup/cg1/cg2
> 20       cgroup_sysctl   sysctl_tcp_mem
> 6        cgroup_sysctl   sysctl_tcp_mem
> 13       cgroup_sysctl   sysctl_tcp_mem
> 
> v4:
> - Reject prog_attach_flags array when effective query. (Martin)
> - Target to bpf tree. (Martin)
> 
> v3:
> https://lore.kernel.org/bpf/20220914161742.3180731-1-pulehui@huaweicloud.com
> - Don't show attach flags when effective query. (John, sdf, Martin)
> 
> v2:
> https://lore.kernel.org/bpf/20220908145304.3436139-1-pulehui@huaweicloud.com
> - Limit prog_cnt to avoid overflow. (John)
> - Add more detail message.
> 
> v1:
> https://lore.kernel.org/bpf/20220820120234.2121044-1-pulehui@huawei.com
> 
> Pu Lehui (2):
>    bpf, cgroup: Reject prog_attach_flags array when effective query
>    bpftool: Fix wrong cgroup attach flags being assigned to effective
>      progs
> 
>   include/uapi/linux/bpf.h       |  7 +++--
>   kernel/bpf/cgroup.c            | 28 +++++++++++-------
>   tools/bpf/bpftool/cgroup.c     | 54 ++++++++++++++++++++++++++++++----
>   tools/include/uapi/linux/bpf.h |  7 +++--
>   4 files changed, 77 insertions(+), 19 deletions(-)
> 

selftest no pass, sorry, will fix.
https://github.com/kernel-patches/bpf/actions/runs/3088351905/jobs/4995009382


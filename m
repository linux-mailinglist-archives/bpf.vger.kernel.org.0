Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431006BF741
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 02:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjCRBlX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 21:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRBlW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 21:41:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D4236FF9
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 18:41:21 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PdkDn4YbxzHwcD;
        Sat, 18 Mar 2023 09:39:05 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 18 Mar 2023 09:41:18 +0800
Subject: Re: bpf_timer memory utilization
To:     Chris Lai <chrlai@riotgames.com>
CC:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <CAAFY1_4a5MC0-BkGcRx-5n-vdXZbjjrjEukwur+n4AOXFhMHFw@mail.gmail.com>
 <CAADnVQLcqDOzXPSUUNyFE=UJHBP-ZgOEqFfaGynTUL-jQnw-=w@mail.gmail.com>
 <CAAFY1_66-b063v+edsHPBbK6iuiE=KoY38=kr0FVzVLg5gkE_w@mail.gmail.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <af9d6b81-b3d4-9f48-5ec2-da00c084bf28@huawei.com>
Date:   Sat, 18 Mar 2023 09:41:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAAFY1_66-b063v+edsHPBbK6iuiE=KoY38=kr0FVzVLg5gkE_w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/18/2023 12:40 AM, Chris Lai wrote:
> Might be a bug using bpf_timer on Hashmap?
> With same setups using bpf_timer but with LRU_Hashmap, the memory
> usage is way better: see following
>
> with LRU_Hashmap
> 16M capacity, 1 minute bpf_timer callback/cleanup..  (pre-allocation
> ~5G),  memory usage peaked ~7G (Flat and does not fluctuate - unlike
> Hashmap)
> 32M capacity, 1 minute bpf_timer callback/cleanup..  (pre-allocation
> ~8G),  memory usage peaked ~12G (Flat and does not fluctuate - unlike
> Hashmap)
In your setup, LRU hash map is preallocated and normal hash map is not
preallocated (aka BPF_F_NO_PREALLOC), right ? If it is true, could you please
test the memory usage of preallocated hash map ? Also could you please  share
the version of used Linux kernel and the way on how to create hash map and
operate on hash map ?
>
>
>
> On Thu, Mar 16, 2023 at 6:22 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Thu, Mar 16, 2023 at 12:18 PM Chris Lai <chrlai@riotgames.com> wrote:
>>> Hello,
>>> Using BPF Hashmap with bpf_timer for each entry value and callback to
>>> delete the entry after 1 minute.
>>> Constantly creating load to insert elements onto the map, we have
>>> observed the following:
>>> -3M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
>>> peaked around 5GB
>>> -16M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
>>> peaked around 34GB
>>> -24M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
>>> peaked around 55GB
>>> Wondering if this is expected and what is causing the huge increase in
>>> memory as we increase the number of elements inserted onto the map.
>>> Thank you.
Do the addition and deletion of hash map entry happen on different CPU ? If it
is true and bpf memory allocator is used (kernel version >= 6.1), the memory
blow-up may be explainable. Because the new allocation can not reuse the memory
freed by entry deletion, so the memory usage will increase rapidly. I had tested
such case and also written one selftest for such case, but it seems it only can
be mitigated [1], because RCU tasks trace GP is slow. If your setup is sticking
to non-preallocated hash map, you could first try to add
"rcupdate.rcu_task_enqueue_lim=nr_cpus" in kernel bootcmd to mitigate the problem.

[1] https://lore.kernel.org/bpf/20221209010947.3130477-1-houtao@huaweicloud.com/
>> That's not normal. Do you have a small reproducer?
> .


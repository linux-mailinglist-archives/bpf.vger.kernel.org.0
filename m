Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916656F6226
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 01:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjECXjV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 19:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjECXjT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 19:39:19 -0400
Received: from out-25.mta0.migadu.com (out-25.mta0.migadu.com [IPv6:2001:41d0:1004:224b::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD02B93C5
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 16:39:13 -0700 (PDT)
Message-ID: <145d1fb6-93c7-ac5d-7818-9a9cca542dbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683157152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7ynl3jqVYivKR9YEmZJ1lJNS+VkBvVVXvmf4GfceU0=;
        b=GJSfYpr/Hfm9rkIm14ub0D+piJ/gcBnwtr3OMvaGJ79Ya2rpunZpylqQ8JJ9+u29UTe4HG
        myzButaGCJ4NwAsrrDsHEZOSs0RGiVXz03aNB+0lVaKI3Nn3SMDIB/ocz0Z655g3/GXhJY
        1LpApCJtrhDCKMP9BgPxUQYBo3Tq7MA=
Date:   Wed, 3 May 2023 16:39:01 -0700
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 3/6] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com>
 <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
 <0fc99af7-fa0d-c5c7-00c4-3f446a5ad77b@linux.dev>
 <20230503230603.auijigbydnifxah5@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230503230603.auijigbydnifxah5@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/3/23 4:06 PM, Alexei Starovoitov wrote:
> On Wed, May 03, 2023 at 02:57:03PM -0700, Martin KaFai Lau wrote:
>> On 5/3/23 11:48 AM, Alexei Starovoitov wrote:
>>> What it means that sleepable progs using hashmap will be able to avoid uaf with bpf_rcu_read_lock().
>>> Without explicit bpf_rcu_read_lock() it's still safe and equivalent to existing behavior of bpf_mem_alloc.
>>> (while your proposed BPF_MA_FREE_AFTER_RCU_GP flavor is not safe to use in hashtab with sleepable progs)
>>>
>>> After that we can unconditionally remove rcu_head/call_rcu from bpf_cpumask and improve usability of bpf_obj_drop.
>>> Probably usage of bpf_mem_alloc in local storage can be simplified as well.
>>> Martin wdyt?
>>
>> If the bpf prog always does a bpf_rcu_read_lock() before accessing the
>> (e.g.) task local storage, it can remove the reuse_now conditions in the
>> bpf_local_storage and directly call the bpf_mem_cache_free().
>>
>> The only corner use case is when the bpf_prog or syscall does
>> bpf_task_storage_delete() instead of having the task storage stays with the
>> whole lifetime of the task_struct. Using REUSE_AFTER_RCU_GP will be a change
>> of this uaf guarantee to the sleepable program but it is still safe because
>> it is freed after tasks_trace gp. We could take this chance to align this
>> behavior of the local storage map to the other bpf maps.
>>
>> For BPF_MA_FREE_AFTER_RCU_GP, there are cases that the bpf local storage
>> knows it can be freed without waiting tasks_trace gp. However, only
>> task/cgroup storages are in bpf ma and I don't believe this optimization
>> matter much for them. I would rather focus on the REUSE_AFTER_RCU_GP first.
> 
> I'm confused which REUSE_AFTER_RCU_GP you meant.
> What I proposed above is REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace

Regarding REUSE_AFTER_RCU_GP, I meant 
REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace.

> 
> Hou's proposals: 1. BPF_MA_REUSE_AFTER_two_RCUs_GP 2. BPF_MA_FREE_AFTER_single_RCU_GP

It probably is where the confusion is. I thought Hou's BPF_MA_REUSE_AFTER_RCU_GP 
is already REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace. From the commit 
message:

" ... So introduce BPF_MA_REUSE_AFTER_RCU_GP to solve these problems. For
BPF_MA_REUSE_AFTER_GP, the freed objects are reused only after one RCU
grace period and may be returned back to slab system after another
RCU-tasks-trace grace period. ..."

[I assumed BPF_MA_REUSE_AFTER_GP is just a typo of BPF_MA_REUSE_AFTER_"RCU"_GP]

> 
> If I'm reading bpf_local_storage correctly it can remove reuse_now logic
> in all conditions with REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace.

Right, for smap->bpf_ma == true (cgroup and task storage), all reuse_now logic 
can be gone and directly use the bpf_mem_cache_free(). Potentially the sk/inode 
can also move to bpf_ma after running some benchmark. This will simplify things 
a lot. For sk storage, the reuse_now was there to avoid the unnecessary 
tasks_trace gp because performance impact was reported on sk storage where 
connections can be open-and-close very frequently.

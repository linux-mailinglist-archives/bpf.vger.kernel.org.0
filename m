Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6305ED82E
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 10:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiI1IsG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 04:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiI1Iri (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 04:47:38 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EDE543EE
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 01:46:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Mcqlz17JSz6S5GJ
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 16:43:59 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgB3FG7HCTRjItgUBg--.50379S2;
        Wed, 28 Sep 2022 16:46:03 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220926012535.badx76iwtftyhq6m@MacBook-Pro-4.local>
 <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
 <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
 <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com>
 <CAADnVQL_fMx3P24wzw2LMON-SqYgRKYziUHg6+mYH0i6kpvJcA@mail.gmail.com>
 <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com>
 <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <2dda66a7-40f5-e595-48cf-b8588c70197a@huaweicloud.com>
Date:   Wed, 28 Sep 2022 16:45:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgB3FG7HCTRjItgUBg--.50379S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1DJr47XF4fZr47uw17Jrb_yoW3uFy3pr
        1fJr1UJryUJr18Aw1UKr1UJry7Jr1UXw4UXr15JF1UAr1UJr1jqr1UXr1jgr1UJr4rJF1U
        Jr1UJr1jv347JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/28/2022 9:08 AM, Alexei Starovoitov wrote:
> On Tue, Sep 27, 2022 at 7:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
SNIP
>> I can not reproduce the phenomenon that call_rcu consumes 100% of all cpus in my
>> local environment, could you share the setup for it ?
>>
>> The following is the output of perf report (--no-children) for "./map_perf_test
>> 4 72 10240 100000" on a x86-64 host with 72-cpus:
>>
>>     26.63%  map_perf_test    [kernel.vmlinux]                             [k]
>> alloc_htab_elem
>>     21.57%  map_perf_test    [kernel.vmlinux]                             [k]
>> htab_map_update_elem
> Looks like the perf is lost on atomic_inc/dec.
> Try a partial revert of mem_alloc.
> In particular to make sure
> commit 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map.")
> is reverted and call_rcu is in place,
> but percpu counter optimization is still there.
> Also please use 'map_perf_test 4'.
> I doubt 1000 vs 10240 will make a difference, but still.
>
I have tried the following two setups:
(1) Don't use bpf_mem_alloc in hash-map and use per-cpu counter in hash-map
# Samples: 1M of event 'cycles:ppp'
# Event count (approx.): 1041345723234
#
# Overhead  Command          Shared Object                                Symbol
# ........  ...............  ........................................... 
...............................................
#
    10.36%  map_perf_test    [kernel.vmlinux]                             [k]
bpf_map_get_memcg.isra.0
     9.82%  map_perf_test    [kernel.vmlinux]                             [k]
bpf_map_kmalloc_node
     4.24%  map_perf_test    [kernel.vmlinux]                             [k]
check_preemption_disabled
     2.86%  map_perf_test    [kernel.vmlinux]                             [k]
htab_map_update_elem
     2.80%  map_perf_test    [kernel.vmlinux]                             [k]
__kmalloc_node
     2.72%  map_perf_test    [kernel.vmlinux]                             [k]
htab_map_delete_elem
     2.30%  map_perf_test    [kernel.vmlinux]                             [k]
memcg_slab_post_alloc_hook
     2.21%  map_perf_test    [kernel.vmlinux]                             [k]
entry_SYSCALL_64
     2.17%  map_perf_test    [kernel.vmlinux]                             [k]
syscall_exit_to_user_mode
     2.12%  map_perf_test    [kernel.vmlinux]                             [k] jhash
     2.11%  map_perf_test    [kernel.vmlinux]                             [k]
syscall_return_via_sysret
     2.05%  map_perf_test    [kernel.vmlinux]                             [k]
alloc_htab_elem
     1.94%  map_perf_test    [kernel.vmlinux]                             [k]
_raw_spin_lock_irqsave
     1.92%  map_perf_test    [kernel.vmlinux]                             [k]
preempt_count_add
     1.92%  map_perf_test    [kernel.vmlinux]                             [k]
preempt_count_sub
     1.87%  map_perf_test    [kernel.vmlinux]                             [k]
call_rcu


(2) Use bpf_mem_alloc & per-cpu counter in hash-map, but no batch call_rcu
optimization
By revert the following commits:

9f2c6e96c65e bpf: Optimize rcu_barrier usage between hash map and bpf_mem_alloc.
bfc03c15bebf bpf: Remove usage of kmem_cache from bpf_mem_cache.
02cc5aa29e8c bpf: Remove prealloc-only restriction for sleepable bpf programs.
dccb4a9013a6 bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
96da3f7d489d bpf: Remove tracing program restriction on map types
ee4ed53c5eb6 bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
4ab67149f3c6 bpf: Add percpu allocation support to bpf_mem_alloc.
8d5a8011b35d bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
7c266178aa51 bpf: Adjust low/high watermarks in bpf_mem_cache
0fd7c5d43339 bpf: Optimize call_rcu in non-preallocated hash map.

     5.17%  map_perf_test    [kernel.vmlinux]                             [k]
check_preemption_disabled
     4.53%  map_perf_test    [kernel.vmlinux]                             [k]
__get_obj_cgroup_from_memcg
     2.97%  map_perf_test    [kernel.vmlinux]                             [k]
htab_map_update_elem
     2.74%  map_perf_test    [kernel.vmlinux]                             [k]
htab_map_delete_elem
     2.62%  map_perf_test    [kernel.vmlinux]                             [k]
kmem_cache_alloc_node
     2.57%  map_perf_test    [kernel.vmlinux]                             [k]
memcg_slab_post_alloc_hook
     2.34%  map_perf_test    [kernel.vmlinux]                             [k] jhash
     2.30%  map_perf_test    [kernel.vmlinux]                             [k]
entry_SYSCALL_64
     2.25%  map_perf_test    [kernel.vmlinux]                             [k]
obj_cgroup_charge
     2.23%  map_perf_test    [kernel.vmlinux]                             [k]
alloc_htab_elem
     2.17%  map_perf_test    [kernel.vmlinux]                             [k]
memcpy_erms
     2.17%  map_perf_test    [kernel.vmlinux]                             [k]
syscall_exit_to_user_mode
     2.16%  map_perf_test    [kernel.vmlinux]                             [k]
syscall_return_via_sysret
     2.14%  map_perf_test    [kernel.vmlinux]                             [k]
_raw_spin_lock_irqsave
     2.13%  map_perf_test    [kernel.vmlinux]                             [k]
preempt_count_add
     2.12%  map_perf_test    [kernel.vmlinux]                             [k]
preempt_count_sub
     2.00%  map_perf_test    [kernel.vmlinux]                             [k]
percpu_counter_add_batch
     1.99%  map_perf_test    [kernel.vmlinux]                             [k]
alloc_bulk
     1.97%  map_perf_test    [kernel.vmlinux]                             [k]
call_rcu
     1.52%  map_perf_test    [kernel.vmlinux]                             [k]
mod_objcg_state
     1.36%  map_perf_test    [kernel.vmlinux]                             [k]
allocate_slab

In both of these two setups, the overhead of call_rcu is about 2% and it is not
the biggest overhead.

Maybe add a not-immediate-reuse flag support to bpf_mem_alloc is reason. What do
you think ?


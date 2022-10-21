Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE7E606D65
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 04:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJUCGT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 22:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJUCGS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 22:06:18 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A9C1ABA28
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 19:06:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mtnp270qDzl8hF
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 10:04:10 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgD36jGR_lFjUQO2AA--.49964S2;
        Fri, 21 Oct 2022 10:06:13 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: Support for setting numa node in bpf memory
 allocator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221020142247.1682009-1-houtao@huaweicloud.com>
 <CA+khW7jE_inL9-66Cb_WAPey6YkY+yf1H+q2uASTQujNXbRF=Q@mail.gmail.com>
 <212fbd46-7371-c3f9-e900-3a49d9fafab8@huaweicloud.com>
 <20221021014807.pvjppg433lucybui@macbook-pro-4.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <b20aa49f-61ee-6275-3f8b-aa2b5e950874@huaweicloud.com>
Date:   Fri, 21 Oct 2022 10:06:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221021014807.pvjppg433lucybui@macbook-pro-4.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgD36jGR_lFjUQO2AA--.49964S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWxGFWfZF1UuF43Aw4UXFb_yoW8tF1kpF
        WxKa45Cr1qqF1xGwn2vwsFka4Fyw4UKr42gw4Uur1q93sIqr93Gw4xJFn5WFZ5Cr4xA3W5
        JFWjgF13ZFZ5AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/21/2022 9:48 AM, Alexei Starovoitov wrote:
> On Fri, Oct 21, 2022 at 09:43:08AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 10/21/2022 2:01 AM, Hao Luo wrote:
>>> On Thu, Oct 20, 2022 at 6:57 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Since commit fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc."),
>>>> numa node setting for non-preallocated hash table is ignored. The reason
>>>> is that bpf memory allocator only supports NUMA_NO_NODE, but it seems it
>>>> is trivial to support numa node setting for bpf memory allocator.
>>>>
>>>> So adding support for setting numa node in bpf memory allocator and
>>>> updating hash map accordingly.
>>>>
>>>> Fixes: fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc.")
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>> ---
SNIP
>> How about the following comments ?
>>
>>  * For per-cpu allocator (percpu=true), the only valid value of numa_node is
>>  * NUMA_NO_NODE. For non-per-cpu allocator, if numa_node is NUMA_NO_NODE, the
>>  * preferred memory allocation node is the numa node where the allocating CPU
>>  * is located, else the preferred node is the specified numa_node.
> No. This patch doesn't make sense to me.
> As far as I can see it can only make things worse.
> Why would you want a cpu to use non local memory?
For pre-allocated hash table, the numa node setting is honored. And I think the
reason is that there are bpf progs which are pinned on specific CPUs or numa
nodes and accessing local memory will be good for performance. And in my
understanding, the bpf memory allocator is trying to replace pre-allocated hash
table to save memory, if the numa node setting is ignored, the above use cases
may be work badly. Also I am trying to test whether or not there is visible
performance improvement for the above assumed use case.

>
> The commit log:
> " is that bpf memory allocator only supports NUMA_NO_NODE, but it seems it
>   is trivial to support numa node setting for bpf memory allocator."
> got it wrong.
>
> See the existing comment:
>                 /* irq_work runs on this cpu and kmalloc will allocate
>                  * from the current numa node which is what we want here.
>                  */
>                 alloc_bulk(c, c->batch, NUMA_NO_NODE);


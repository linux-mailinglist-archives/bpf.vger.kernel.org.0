Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1836EBDD9
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 10:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjDWIDl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDWIDk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 04:03:40 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B18CCC;
        Sun, 23 Apr 2023 01:03:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q413n2SkVz4f403Q;
        Sun, 23 Apr 2023 16:03:33 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgCH4BpV5kRkmKD5HQ--.8129S2;
        Sun, 23 Apr 2023 16:03:35 +0800 (CST)
Subject: Re: [RFC bpf-next v2 1/4] selftests/bpf: Add benchmark for bpf memory
 allocator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
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
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
 <20230408141846.1878768-2-houtao@huaweicloud.com>
 <20230422025930.fwoodzn6jlqe2jt5@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <7f5062a2-f235-6cf2-f10c-9fcb5dfcb5db@huaweicloud.com>
Date:   Sun, 23 Apr 2023 16:03:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230422025930.fwoodzn6jlqe2jt5@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgCH4BpV5kRkmKD5HQ--.8129S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF43Cr4rJw18tr4UWr48Zwb_yoW5XF4xpa
        y8Ga4UZ3Z8JwnY9348Xw4vqrW8Xw48Gw47tr4jyryqk3sxur1fK3yfKF48WFW8GFy3GFyY
        qw4Du3y7Z3WruFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 4/22/2023 10:59 AM, Alexei Starovoitov wrote:
> On Sat, Apr 08, 2023 at 10:18:43PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The benchmark could be used to compare the performance of hash map
>> operations and the memory usage between different flavors of bpf memory
>> allocator (e.g., no bpf ma vs bpf ma vs reuse-after-gp bpf ma). It also
>> could be used to check the performance improvement or the memory saving
>> of bpf memory allocator optimization and check whether or not a specific
>> use case is suitable for bpf memory allocator.
>>
>> The benchmark creates a non-preallocated hash map which uses bpf memory
>> allocator and shows the operation performance and the memory usage of
>> the hash map under different use cases:
>> (1) no_op
>> Only create the hash map and there is no operations on hash map. It is
>> used as the baseline. When each CPUs complete the iteartion of
>> nonoverlapping part of hash map, the loop count is increased.
>> (2) overwrite
>> Each CPU overwrites nonoverlapping part of hash map. When each CPU
>> completes one round of iteration, the loop count is increased.
>> (3) batch_add_batch_del
>> Each CPU adds then deletes nonoverlapping part of hash map in batch.
>> When each CPU completes one round of iteration, the loop count is
>> increased.
>> (4) add_del_on_diff_cpu
>> Each two CPUs add and delete nonoverlapping part of map concurrently.
>> When each CPU completes one round of iteration, the loop count is
>> increased.
>>
>> The following benchmark results show that bpf memory allocator doesn't
>> handle add_del_on_diff_cpu scenario very well. Because map deletion
>> always happen on a different CPU than the map addition and the freed
>> memory can never be reused.
SNIP
>> +
>> +SEC("?tp/syscalls/sys_enter_getpgid")
>> +int add_del_on_diff_cpu(void *ctx)
>> +{
>> +	struct update_ctx update;
>> +	unsigned int from;
>> +
>> +	from = bpf_get_smp_processor_id();
>> +	update.from = from / 2;
>> +	update.step = nr_thread / 2;
>> +	update.max = nr_entries;
>> +
>> +	if (from & 1)
>> +		bpf_loop(update.max, newwrite_htab, &update, 0);
>> +	else
>> +		bpf_loop(update.max, del_htab, &update, 0);
> This is oddly shaped test.
> deleter cpu may run ahead of newwrite_htab.
> deleter will try to delete elems that don't exist.
> Loop of few thousand iterations is not a lot for one cpu to run ahead.
>
> Each loop will run 16k times and every time you step += 4.
> So 3/4 of these 16k runs it will be hitting if (ctx->from >= ctx->max) condition.
> What are you measuring?
I think it would be better to synchronize between deletion CPU and addition CPU.
Will fix it.
>
>> +
>> +	__sync_fetch_and_add(&loop_cnt, 1);
>> +	return 0;
>> +}
>> -- 
>> 2.29.2
>>
> .


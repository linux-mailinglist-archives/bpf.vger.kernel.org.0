Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E50F5A409B
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 03:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiH2BTT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 21:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH2BTT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 21:19:19 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35348240BD
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 18:19:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGCGn3NCWzKGTh
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 09:17:37 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgAXaXIRFAxjIqlIAA--.28624S2;
        Mon, 29 Aug 2022 09:19:16 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Propagate error from
 htab_lock_bucket() to userspace
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220827100134.1621137-1-houtao@huaweicloud.com>
 <20220827100134.1621137-2-houtao@huaweicloud.com>
 <CACYkzJ7r_i9+XaE-WJzJao2J4=1fH39Xb4u4o733ZtLwxh0WPg@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <06504cf0-8d2e-ee0d-adce-e3bc6a327689@huaweicloud.com>
Date:   Mon, 29 Aug 2022 09:19:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACYkzJ7r_i9+XaE-WJzJao2J4=1fH39Xb4u4o733ZtLwxh0WPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAXaXIRFAxjIqlIAA--.28624S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryUuF4kZFy5Kr1DZryxKrg_yoW8Xw4fpr
        W8Ga47Ga10qr92vas3XF4xtryYvw1jgr4UGr4UJ34Fvr1qvr9a9348K3WaqFyFvryakr4F
        vr42v3WFva45AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWwZcUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/28/2022 8:24 AM, KP Singh wrote:
> On Sat, Aug 27, 2022 at 11:43 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> In __htab_map_lookup_and_delete_batch() if htab_lock_bucket() returns
>> -EBUSY, it will go to next bucket. Going to next bucket may not only
>> skip the elements in current bucket silently, but also incur
>> out-of-bound memory access or expose kernel memory to userspace if
>> current bucket_cnt is greater than bucket_size or zero.
>>
>> Fixing it by stopping batch operation and returning -EBUSY when
>> htab_lock_bucket() fails, and the application can retry or skip the busy
>> batch as needed.
>>
>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Please add a Fixes tag here
Will add "Fixes: 20b6cc34ea74 ("bpf: Avoid hashtab deadlock with map_locked")"
in v3.
>
>> ---
>>  kernel/bpf/hashtab.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 6fb3b7fd1622..eb1263f03e9b 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -1704,8 +1704,11 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>         /* do not grab the lock unless need it (bucket_cnt > 0). */
>>         if (locked) {
>>                 ret = htab_lock_bucket(htab, b, batch, &flags);
>> -               if (ret)
>> -                       goto next_batch;
>> +               if (ret) {
>> +                       rcu_read_unlock();
>> +                       bpf_enable_instrumentation();
>> +                       goto after_loop;
>> +               }
>>         }
>>
>>         bucket_cnt = 0;
>> --
>> 2.29.2
>>
> .


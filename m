Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9291558D1B8
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 03:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiHIB0d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 21:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHIB0d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 21:26:33 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF136CE27
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 18:26:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M1wNf2t6Bz6T8Jk
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 09:25:06 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgDXYTrBt_Fiq_ljAA--.22570S2;
        Tue, 09 Aug 2022 09:26:27 +0800 (CST)
Subject: Re: [PATCH bpf 8/9] selftests/bpf: Add write tests for sk storage map
 iterator
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-9-houtao@huaweicloud.com>
 <eb3836ee-2830-83a9-2081-4527fa4141d0@fb.com>
From:   houtao <houtao@huaweicloud.com>
Message-ID: <19412193-a426-8d00-5c2f-c7cc8febe130@huaweicloud.com>
Date:   Tue, 9 Aug 2022 09:26:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <eb3836ee-2830-83a9-2081-4527fa4141d0@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgDXYTrBt_Fiq_ljAA--.22570S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8ArW5WFWxuF1xKr47twb_yoW8WFy5pF
        n7trWYkrWrAws3CrnIq3W2yry3Jw1ftw1DGrs7JF45Jr4qvrWYgr17WF1v9Fy5Jw40qr1f
        Ars0va43u3srAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IUbPEf5UUUUU==
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

On 8/8/2022 11:27 PM, Yonghong Song wrote:
>
>
> On 8/6/22 12:40 AM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Add test to validate the overwrite of sock storage map value in map
>> iterator and another one to ensure out-of-bound value writing is
>> rejected.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> One nit below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
>> ---
>>   .../selftests/bpf/prog_tests/bpf_iter.c       | 20 +++++++++++++++++--
>>   .../bpf/progs/bpf_iter_bpf_sk_storage_map.c   | 20 ++++++++++++++++++-
>>   2 files changed, 37 insertions(+), 3 deletions(-)
>>
SNIP
>>     SEC("iter/bpf_sk_storage_map")
>> -int dump_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
>> +int rw_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
>>   {
>>       struct sock *sk = ctx->sk;
>>       __u32 *val = ctx->value;
>> @@ -30,5 +31,22 @@ int dump_bpf_sk_storage_map(struct
>> bpf_iter__bpf_sk_storage_map *ctx)
>>           ipv6_sk_count++;
>>         val_sum += *val;
>> +
>> +    *val += to_add_val;
>> +
>> +    return 0;
>> +}
>> +
>> +SEC("iter/bpf_sk_storage_map")
>> +int oob_write_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
>> +{
>> +    struct sock *sk = ctx->sk;
>> +    __u32 *val = ctx->value;
>> +
>> +    if (sk == (void *)0 || val == (void *)0)
>
> Newer bpf_helpers.h provides NULL for (void *)0, you can use NULL now.
Thanks. Will fix in v2.
>
>> +        return 0;
>> +
>> +    *(val + 1) = 0xdeadbeef;
>> +
>>       return 0;
>>   }


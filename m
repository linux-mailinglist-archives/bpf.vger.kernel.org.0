Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015975ED3D0
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 06:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiI1EO4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 00:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiI1EOy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 00:14:54 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DBE8FD6B
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 21:14:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4McjlM4dl3zl3K4
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 12:13:03 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgCXEEg1yjNjlYR4BQ--.60395S2;
        Wed, 28 Sep 2022 12:14:49 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 08/13] bpftool: Add support for qp-trie map
To:     Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220924133620.4147153-9-houtao@huaweicloud.com>
 <896ae326-125b-5d23-2870-aeaa95341c64@isovalent.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <f46cefeb-2572-ec8a-f5ee-82dc1988137e@huaweicloud.com>
Date:   Wed, 28 Sep 2022 12:14:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <896ae326-125b-5d23-2870-aeaa95341c64@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgCXEEg1yjNjlYR4BQ--.60395S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy5JryfKw1UAFWkZryDtrb_yoW5Jr1kpa
        yUKa40vF4kJr47Krs3tF48CFWYkr4kGw17GF95K34rAw4qq3s3WF10gFWruF9Yqwn3Ww1Y
        yw1YgFZ7J3Wjv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/27/2022 7:24 PM, Quentin Monnet wrote:
> Sat Sep 24 2022 14:36:15 GMT+0100 (British Summer Time) ~ Hou Tao
> <houtao@huaweicloud.com>
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Support lookup/update/delete/iterate/dump operations for qp-trie in
>> bpftool. Mainly add two functions: one function to parse dynptr key and
>> another one to dump dynptr key. The input format of dynptr key is:
>> "key [hex] size BYTES" and the output format of dynptr key is:
>> "size BYTES".
>>
>> The following is the output when using bpftool to manipulate
>> qp-trie:
>>
>>   $ bpftool map pin id 724953 /sys/fs/bpf/qp
>>   $ bpftool map show pinned /sys/fs/bpf/qp
>>   724953: qp_trie  name qp_trie  flags 0x1
>>           key 16B  value 4B  max_entries 2  memlock 65536B  map_extra 8
>>           btf_id 779
>>           pids test_qp_trie.bi(109167)
>>   $ bpftool map dump pinned /sys/fs/bpf/qp
>>   [{
>>           "key": {
>>               "size": 4,
>>               "data": ["0x0","0x0","0x0","0x0"
>>               ]
>>           },
>>           "value": 0
>>       },{
>>           "key": {
>>               "size": 4,
>>               "data": ["0x0","0x0","0x0","0x1"
>>               ]
>>           },
>>           "value": 2
>>       }
>>   ]
>>   $ bpftool map lookup pinned /sys/fs/bpf/qp key 4 0 0 0 1
>>   {
>>       "key": {
>>           "size": 4,
>>           "data": ["0x0","0x0","0x0","0x1"
>>           ]
>>       },
>>       "value": 2
>>   }
> The bpftool patch looks good, thanks! I have one comment on the syntax
> for the keys, I don't find it intuitive to have the size as the first
> BYTE. It makes it awkward to understand what the command does if we read
> it in the wild without knowing the map type. I can see two alternatives,
> either adding a keyword (e.g., "key_size 4 key 0 0 0 1"), or changing
> parse_bytes() to make it able to parse as much as it can then count the
> bytes, when we don't know in advance how many we get.
The suggestion is reasonable, but there is also reason for the current choice (
I should written it down in commit message). For dynptr-typed key, these two
proposed suggestions will work. But for key with embedded dynptrs as show below,
both explict key_size keyword and implicit key_size in BYTEs can not express the
key correctly.

struct map_key {
unsigned int cookie;
struct bpf_dynptr name;
struct bpf_dynptr addr;
unsigned int flags;
};

I also had thought about adding another key word "dynptr_key" (or "dyn_key") to
support dynptr-typed key or key with embedded dynptr, and the format will still
be: "dynptr_key size [BYTES]". But at least we can tell it is different with
"key" which is fixed size. What do you think ?
>
> Thanks,
> Quentin
>
> .


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB73C5EDAB2
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiI1K5M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiI1K4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 06:56:39 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99518C018
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 03:55:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mctcm3x6Gzl8l9
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 18:52:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgA3BSnvJzRjaYPOBQ--.725S2;
        Wed, 28 Sep 2022 18:54:42 +0800 (CST)
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
 <f46cefeb-2572-ec8a-f5ee-82dc1988137e@huaweicloud.com>
 <0fa70b47-5d06-d99a-c3cf-635a33f3f38d@isovalent.com>
 <a68a07b9-063d-e83f-b6cf-5cdc86d77d97@huaweicloud.com>
 <e6aadeaf-b73b-c277-5801-0fdaf57e51b6@isovalent.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <3df24978-7d53-68cd-0bee-7db886af8471@huaweicloud.com>
Date:   Wed, 28 Sep 2022 18:54:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e6aadeaf-b73b-c277-5801-0fdaf57e51b6@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgA3BSnvJzRjaYPOBQ--.725S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1xZw1fWr4kWF4DJrWrKrg_yoW5Aw43pa
        yrGay0kan7JFy2yw42qF48XrWSvr48Gw1UWryUJrW5Ja4qvFn3WF48KFy5uFyqgrn3J345
        tr40qFy3u3WDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/28/2022 5:23 PM, Quentin Monnet wrote:
> Wed Sep 28 2022 10:05:55 GMT+0100 (British Summer Time) ~ Hou Tao
> <houtao@huaweicloud.com>
>> Hi,
>>
>> On 9/28/2022 4:40 PM, Quentin Monnet wrote:
>>> Wed Sep 28 2022 05:14:45 GMT+0100 (British Summer Time) ~ Hou Tao
>>> <houtao@huaweicloud.com>
>>>> Hi,
>>>>
>>>> On 9/27/2022 7:24 PM, Quentin Monnet wrote:
>>>>> Sat Sep 24 2022 14:36:15 GMT+0100 (British Summer Time) ~ Hou Tao
>>>>> <houtao@huaweicloud.com>
>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>
>>>>>> Support lookup/update/delete/iterate/dump operations for qp-trie in
>>>>>> bpftool. Mainly add two functions: one function to parse dynptr key and
>>>>>> another one to dump dynptr key. The input format of dynptr key is:
>>>>>> "key [hex] size BYTES" and the output format of dynptr key is:
>>>>>> "size BYTES".
>> SNIP
>>>>> The bpftool patch looks good, thanks! I have one comment on the syntax
>>>>> for the keys, I don't find it intuitive to have the size as the first
>>>>> BYTE. It makes it awkward to understand what the command does if we read
>>>>> it in the wild without knowing the map type. I can see two alternatives,
>>>>> either adding a keyword (e.g., "key_size 4 key 0 0 0 1"), or changing
>>>>> parse_bytes() to make it able to parse as much as it can then count the
>>>>> bytes, when we don't know in advance how many we get.
>>>> The suggestion is reasonable, but there is also reason for the current choice (
>>>> I should written it down in commit message). For dynptr-typed key, these two
>>>> proposed suggestions will work. But for key with embedded dynptrs as show below,
>>>> both explict key_size keyword and implicit key_size in BYTEs can not express the
>>>> key correctly.
>>>>
>>>> struct map_key {
>>>> unsigned int cookie;
>>>> struct bpf_dynptr name;
>>>> struct bpf_dynptr addr;
>>>> unsigned int flags;
>>>> };
>>> I'm not sure I follow. I don't understand the difference for dealing
>>> internally with the key between "key_size N key BYTES" and "key N BYTES"
>>> (or for parsing then counting). Please could you give an example telling
>>> how you would you express the key from the structure above, with the
>>> syntax you proposed?
>> In my understand, if using "key_size N key BYTES" to represent map_key, it can
>> not tell the exact size of "name" and "addr" and it only can tell the total size
>> of name and addr. If using "key BYTES" to do that, it has the similar problem.
>> But if using "key size BYTES" format, map_key can be expressed as follows:
>>
>> key c c c c [name_size] n n n [addr_size] a a  f f f f
> OK thanks I get it now, you can have multiple sizes within the key, one
> for each field. Yes, let's use a new keyword in that case please. Can
> you also provide more details in the man page, and ideally add a new
> example to the list?
Forget to mention that the map key with embedded dynptr is not supported yet and
now only support using dynptr as the map key. So will add a new keyword "dynkey"
in v3 to support operations on qp-trie.
>
> Thanks,
> Quentin
>
> .


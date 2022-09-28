Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D595ED866
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 11:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiI1JGF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 05:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiI1JGE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 05:06:04 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903DD24BD4
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 02:06:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4McrCJ71QXzl9S6
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 17:04:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgBnAmxzDjRjwY8VBg--.33844S2;
        Wed, 28 Sep 2022 17:05:59 +0800 (CST)
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
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <a68a07b9-063d-e83f-b6cf-5cdc86d77d97@huaweicloud.com>
Date:   Wed, 28 Sep 2022 17:05:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0fa70b47-5d06-d99a-c3cf-635a33f3f38d@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgBnAmxzDjRjwY8VBg--.33844S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4rJF45ur43WFyUWr47twb_yoW5XFyxpF
        W5Ka48KFs7Gry2yw42yF48ZrWS9r4kGw1DWryxJ3y5Ja1qqF93Wr48KFW5uFyqgwn3X3y5
        Jr40vF9xu3Wqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
        1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
        XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
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

On 9/28/2022 4:40 PM, Quentin Monnet wrote:
> Wed Sep 28 2022 05:14:45 GMT+0100 (British Summer Time) ~ Hou Tao
> <houtao@huaweicloud.com>
>> Hi,
>>
>> On 9/27/2022 7:24 PM, Quentin Monnet wrote:
>>> Sat Sep 24 2022 14:36:15 GMT+0100 (British Summer Time) ~ Hou Tao
>>> <houtao@huaweicloud.com>
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Support lookup/update/delete/iterate/dump operations for qp-trie in
>>>> bpftool. Mainly add two functions: one function to parse dynptr key and
>>>> another one to dump dynptr key. The input format of dynptr key is:
>>>> "key [hex] size BYTES" and the output format of dynptr key is:
>>>> "size BYTES".
SNIP
>>> The bpftool patch looks good, thanks! I have one comment on the syntax
>>> for the keys, I don't find it intuitive to have the size as the first
>>> BYTE. It makes it awkward to understand what the command does if we read
>>> it in the wild without knowing the map type. I can see two alternatives,
>>> either adding a keyword (e.g., "key_size 4 key 0 0 0 1"), or changing
>>> parse_bytes() to make it able to parse as much as it can then count the
>>> bytes, when we don't know in advance how many we get.
>> The suggestion is reasonable, but there is also reason for the current choice (
>> I should written it down in commit message). For dynptr-typed key, these two
>> proposed suggestions will work. But for key with embedded dynptrs as show below,
>> both explict key_size keyword and implicit key_size in BYTEs can not express the
>> key correctly.
>>
>> struct map_key {
>> unsigned int cookie;
>> struct bpf_dynptr name;
>> struct bpf_dynptr addr;
>> unsigned int flags;
>> };
> I'm not sure I follow. I don't understand the difference for dealing
> internally with the key between "key_size N key BYTES" and "key N BYTES"
> (or for parsing then counting). Please could you give an example telling
> how you would you express the key from the structure above, with the
> syntax you proposed?
In my understand, if using "key_size N key BYTES" to represent map_key, it can
not tell the exact size of "name" and "addr" and it only can tell the total size
of name and addr. If using "key BYTES" to do that, it has the similar problem.
But if using "key size BYTES" format, map_key can be expressed as follows:

key c c c c [name_size] n n n [addr_size] a a  f f f f
>
>> I also had thought about adding another key word "dynptr_key" (or "dyn_key") to
>> support dynptr-typed key or key with embedded dynptr, and the format will still
>> be: "dynptr_key size [BYTES]". But at least we can tell it is different with
>> "key" which is fixed size. What do you think ?
> If the other suggestions do not work, then yes, using a dedicated
> keyword (Just "dynkey"? We can detail in the docs) sounds better to me.


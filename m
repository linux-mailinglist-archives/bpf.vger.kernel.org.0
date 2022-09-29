Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD0D5EEB73
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 04:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiI2CLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 22:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiI2CLW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 22:11:22 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C595172B44
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 19:11:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MdGy06zp7z6PlPc
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 10:09:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgB3EWvB_jRjMDw6Bg--.826S2;
        Thu, 29 Sep 2022 10:11:17 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 03/13] bpf: Support bpf_dynptr-typed map key
 in bpf syscall
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com,
        Joanne Koong <joannelkoong@gmail.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220924133620.4147153-4-houtao@huaweicloud.com>
 <CAEf4Bza79XbtYF_04MhdcN0o4Akot0VpWaR+mOoGwXsz7yT=xg@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <e099e816-d271-ec75-b6aa-3671cfc5b8f9@huaweicloud.com>
Date:   Thu, 29 Sep 2022 10:11:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bza79XbtYF_04MhdcN0o4Akot0VpWaR+mOoGwXsz7yT=xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgB3EWvB_jRjMDw6Bg--.826S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15uF1rGr1rZF4DXrykuFg_yoWrGrW3pa
        yrGa4Sgw4kJry7Ar1xXa1xXrWFvw48Ww1UGr93t3yUCFyDuF93ur18KayYkFnakryxJ3yj
        qr4UAryrG34rZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 9/29/2022 8:16 AM, Andrii Nakryiko wrote:
> On Sat, Sep 24, 2022 at 6:18 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Userspace application uses bpf syscall to lookup or update bpf map. It
>> passes a pointer of fixed-size buffer to kernel to represent the map
>> key. To support map with variable-length key, introduce bpf_dynptr_user
>> to allow userspace to pass a pointer of bpf_dynptr_user to specify the
>> address and the length of key buffer. And in order to represent dynptr
>> from userspace, adding a new dynptr type: BPF_DYNPTR_TYPE_USER. Because
>> BPF_DYNPTR_TYPE_USER-typed dynptr is not available from bpf program, so
>> no verifier update is needed.
>>
>> Add dynptr_key_off in bpf_map to distinguish map with fixed-size key
>> from map with variable-length. dynptr_key_off is less than zero for
>> fixed-size key and can only be zero for dynptr key.
>>
>> For dynptr-key map, key btf type is bpf_dynptr and key size is 16, so
>> use the lower 32-bits of map_extra to specify the maximum size of dynptr
>> key.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
> This is a great feature and you've put lots of high-quality work into
> this! Looking forward to have qp-trie BPF map available. Apart from
> your discussion with Alexie about locking and memory
> allocation/reused, I have questions about this dynptr from user-space
> interface. Let's discuss it in this patch to not interfere.
>
> I'm trying to understand why there should be so many new concepts and
> interfaces just to allow variable-sized keys. Can you elaborate on
> that? Like why do we even need BPF_DYNPTR_TYPE_USER? Why user can't
> just pass a void * (casted to u64) pointer and size of the memory
> pointed to it, and kernel will just copy necessary amount of data into
> kvmalloc'ed temporary region?
The main reason is that map operations from syscall and bpf program use the same
ops in bpf_map_ops (e.g. map_update_elem). If only use dynptr_kern for bpf
program, then
have to define three new operations for bpf program. Even more, after defining
two different map ops for the same operation from syscall and bpf program, the
internal  implementation of qp-trie still need to convert these two different
representations of variable-length key into bpf_qp_trie_key. It introduces
unnecessary conversion, so I think it may be a good idea to pass dynptr_kern to
qp-trie even for bpf syscall.

And now in bpf_attr, for BPF_MAP_*_ELEM command, there is no space to pass an
extra key size. It seems bpf_attr can be extend, but even it is extented, it
also means in libbpf we need to provide a new API group to support operationg on
dynptr key map, because the userspace needs to pass the key size as a new argument.
>
> It also seems like you want to allow key (and maybe value as well, not
> sure) to be a custom user-defined type where some of the fields are
> struct bpf_dynptr. I think it's a big overcomplication, tbh. I'd say
> it's enough to just say that entire key has to be described by a
> single bpf_dynptr. Then we can have bpf_map_lookup_elem_dynptr(map,
> key_dynptr, flags) new helper to provide variable-sized key for
> lookup.
For qp-trie, it will only support a single dynptr as the map key. In the future
maybe other map will support map key with embedded dynptrs. Maybe Joanne can
share some vision about such use case.
>
> I think it would keep it much simpler. But if I'm missing something,
> it would be good to understand that. Thanks!
>
>
>>  include/linux/bpf.h            |   8 +++
>>  include/uapi/linux/bpf.h       |   6 ++
>>  kernel/bpf/map_in_map.c        |   3 +
>>  kernel/bpf/syscall.c           | 121 +++++++++++++++++++++++++++------
>>  tools/include/uapi/linux/bpf.h |   6 ++
>>  5 files changed, 125 insertions(+), 19 deletions(-)
>>
> [...]
> .


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72E35FE7D8
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 06:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJNECN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 00:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJNECL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 00:02:11 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C567FED9B4
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:02:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MpXhk2pLRz6S5PN
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 11:59:50 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgBnaMo730hjUET4AA--.9408S2;
        Fri, 14 Oct 2022 12:02:07 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 03/13] bpf: Support bpf_dynptr-typed map key
 in bpf syscall
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
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
 <20220924133620.4147153-4-houtao@huaweicloud.com>
 <CAEf4Bza79XbtYF_04MhdcN0o4Akot0VpWaR+mOoGwXsz7yT=xg@mail.gmail.com>
 <e099e816-d271-ec75-b6aa-3671cfc5b8f9@huaweicloud.com>
 <CAEf4BzZyfUOfGkQP67urmG9=7pqUF-5E9LjZf-Y0sL9nbcHFww@mail.gmail.com>
 <670cee24-8667-31c9-fe91-368b683d586e@huaweicloud.com>
 <CAEf4BzZY5=nGF6HfcKeaZ39bK6dYxJm03zqAzBzzs28MRszVdw@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <13e2f2f0-1610-4c21-5478-3a3413ef88be@huaweicloud.com>
Date:   Fri, 14 Oct 2022 12:02:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZY5=nGF6HfcKeaZ39bK6dYxJm03zqAzBzzs28MRszVdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgBnaMo730hjUET4AA--.9408S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy3Xr1rGFWDCrWDury3Arb_yoWxGF1Dpa
        yrK3WxKFWkJ348uw1vvw4xZa4Sqr18Xw1UGr98ta4rCFyqgr9a9r1jqFWY9FySkr4xtw42
        vr4qvryxZ345A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/14/2022 2:04 AM, Andrii Nakryiko wrote:
> On Fri, Oct 7, 2022 at 7:40 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 10/1/2022 5:35 AM, Andrii Nakryiko wrote:
>>> On Wed, Sep 28, 2022 at 7:11 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> SNP
>>>>> I'm trying to understand why there should be so many new concepts and
>>>>> interfaces just to allow variable-sized keys. Can you elaborate on
>>>>> that? Like why do we even need BPF_DYNPTR_TYPE_USER? Why user can't
>>>>> just pass a void * (casted to u64) pointer and size of the memory
>>>>> pointed to it, and kernel will just copy necessary amount of data into
>>>>> kvmalloc'ed temporary region?
>>>> The main reason is that map operations from syscall and bpf program use the same
>>>> ops in bpf_map_ops (e.g. map_update_elem). If only use dynptr_kern for bpf
>>>> program, then
>>>> have to define three new operations for bpf program. Even more, after defining
>>>> two different map ops for the same operation from syscall and bpf program, the
>>>> internal  implementation of qp-trie still need to convert these two different
>>>> representations of variable-length key into bpf_qp_trie_key. It introduces
>>>> unnecessary conversion, so I think it may be a good idea to pass dynptr_kern to
>>>> qp-trie even for bpf syscall.
>>>>
>>>> And now in bpf_attr, for BPF_MAP_*_ELEM command, there is no space to pass an
>>>> extra key size. It seems bpf_attr can be extend, but even it is extented, it
>>>> also means in libbpf we need to provide a new API group to support operationg on
>>>> dynptr key map, because the userspace needs to pass the key size as a new argument.
>>> You are right that the current assumption of implicit key/value size
>>> doesn't work for these variable-key/value-length maps. But I think the
>>> right answer is actually to make sure that we have a map_update_elem
>>> callback variant that accepts key/value size explicitly. I still think
>>> that the syscall interface shouldn't introduce a concept of dynptr.
>>> >From user-space's point of view dynptr is just a memory pointer +
>>> associated memory size. Let's keep it simple. And yes, it will be a
>>> new libbpf API for bpf_map_lookup_elem/bpf_map_update_elem. That's
>>> fine.
>> Is your point that dynptr is too complicated for user-space and may lead to
>> confusion between dynptr in kernel space ? How about a different name or a
> No, dynptr is just an unnecessary concept for user-space, because
> fundamentally it's just a memory region, which in UAPI is represented
> by a pointer + size. So why inventing new concepts when existing ones
> are covering it?
But the problem is pointer + explicit size is not being covered by any existing
APIs and we need to add support for it. Using dnyptr is one option and directly
using pointer + explicit size is another one.
>
>> simple definition just like bpf_lpm_trie_key ? It will make both the
>> implementation and the usage much simpler, because the implementation and the
>> user can still use the same APIs just like fixed sized map.
>>
>> Not just lookup/update/delete, we also need to define a new op for
>> get_next_key/lookup_and_delete_elem. And also need to define corresponding new
>> bpf helpers for bpf program. And you said "explict key/value size", do you mean
>> something below ?
>>
>> int (*map_update_elem)(struct bpf_map *map, void *key, u32 key_size, void
>> *value, u32 value_size, u64 flags);
> Yes, something like that. The problem is that up until now we assume
> that key_size is fixed and can be derived from map definition. We are
> trying to change that, so there needs to be a change in internal APIs.
Will need to change both the UAPIs and internal APIs. Should I add variable-size
map value into consideration this time ? I am afraid that it may be little
over-designed. Maybe I should hack a demo out firstly to check the work-load and
the complexity.
>
>>>
>>>>> It also seems like you want to allow key (and maybe value as well, not
>>>>> sure) to be a custom user-defined type where some of the fields are
>>>>> struct bpf_dynptr. I think it's a big overcomplication, tbh. I'd say
>>>>> it's enough to just say that entire key has to be described by a
>>>>> single bpf_dynptr. Then we can have bpf_map_lookup_elem_dynptr(map,
>>>>> key_dynptr, flags) new helper to provide variable-sized key for
>>>>> lookup.
>>>> For qp-trie, it will only support a single dynptr as the map key. In the future
>>>> maybe other map will support map key with embedded dynptrs. Maybe Joanne can
>>>> share some vision about such use case.
>>> My point was that instead of saying that key is some fixed-size struct
>>> in which one of the fields is dynptr (and then when comparing you have
>>> to compare part of struct, then dynptr contents, then the other part
>>> of struct?), just say that entire key is represented by dynptr,
>>> implicitly (it's just a blob of bytes). That seems more
>>> straightforward.
>> I see. But I still think there is possible user case for struct with embedded
>> dynptr. For bpf map in kernel, byte blob is OK. But If it is also a blob of
>> bytes for the bpf program or userspace application, the application may need to
>> marshaling and un-marshaling between the bytes blob and a meaningful struct type
>> each time before using it.
>>> .
> I'm not sure what you mean by "blob of bytes for userspace
> application"? You mean a pointer pointing to some process' memory (not
> a kernel memory)? How is that going to work if BPF program can run and
> access such blob in any context, not just in the context of original
> user-space app that set this value?
>
> If you mean that blob needs to be interpreted as some sort of struct,
> then yes, it's easy, we have bpf_dynptr_data() and `void *` -> `struct
> my_custom_struct` casting in C.
Yes. I mean we need to cast the blob to a meaning struct before using it. If
there are one variable-length field in the struct, how would the directly
castling work as shown below ?

struct my_custom_struct {
           struct {
               unsigned int len;
               char *data;
           } name;
           unsigned int pt_code;
};
>
> Or did I miss your point?


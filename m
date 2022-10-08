Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7D5F827C
	for <lists+bpf@lfdr.de>; Sat,  8 Oct 2022 04:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiJHCk4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 22:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJHCkz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 22:40:55 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460F9082D
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 19:40:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MkqB90C4Lzl9Ds
        for <bpf@vger.kernel.org>; Sat,  8 Oct 2022 10:38:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgD3uIgu40Bj44nJBw--.11376S2;
        Sat, 08 Oct 2022 10:40:50 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 03/13] bpf: Support bpf_dynptr-typed map key
 in bpf syscall
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
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
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220924133620.4147153-4-houtao@huaweicloud.com>
 <CAEf4Bza79XbtYF_04MhdcN0o4Akot0VpWaR+mOoGwXsz7yT=xg@mail.gmail.com>
 <e099e816-d271-ec75-b6aa-3671cfc5b8f9@huaweicloud.com>
 <CAEf4BzZyfUOfGkQP67urmG9=7pqUF-5E9LjZf-Y0sL9nbcHFww@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <670cee24-8667-31c9-fe91-368b683d586e@huaweicloud.com>
Date:   Sat, 8 Oct 2022 10:40:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZyfUOfGkQP67urmG9=7pqUF-5E9LjZf-Y0sL9nbcHFww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgD3uIgu40Bj44nJBw--.11376S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8Gw1xWryfuF48urWDtwb_yoWrWw4kpa
        yrKa4fK3WkJ34xuw1kZw4xXFWS9w18Jw1UG3s5t3y8CryDWryS9r1YqayYkF1Skr1xt3yj
        qw4qyryfX345ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/1/2022 5:35 AM, Andrii Nakryiko wrote:
> On Wed, Sep 28, 2022 at 7:11 PM Hou Tao <houtao@huaweicloud.com> wrote:
SNP
>>> I'm trying to understand why there should be so many new concepts and
>>> interfaces just to allow variable-sized keys. Can you elaborate on
>>> that? Like why do we even need BPF_DYNPTR_TYPE_USER? Why user can't
>>> just pass a void * (casted to u64) pointer and size of the memory
>>> pointed to it, and kernel will just copy necessary amount of data into
>>> kvmalloc'ed temporary region?
>> The main reason is that map operations from syscall and bpf program use the same
>> ops in bpf_map_ops (e.g. map_update_elem). If only use dynptr_kern for bpf
>> program, then
>> have to define three new operations for bpf program. Even more, after defining
>> two different map ops for the same operation from syscall and bpf program, the
>> internal  implementation of qp-trie still need to convert these two different
>> representations of variable-length key into bpf_qp_trie_key. It introduces
>> unnecessary conversion, so I think it may be a good idea to pass dynptr_kern to
>> qp-trie even for bpf syscall.
>>
>> And now in bpf_attr, for BPF_MAP_*_ELEM command, there is no space to pass an
>> extra key size. It seems bpf_attr can be extend, but even it is extented, it
>> also means in libbpf we need to provide a new API group to support operationg on
>> dynptr key map, because the userspace needs to pass the key size as a new argument.
> You are right that the current assumption of implicit key/value size
> doesn't work for these variable-key/value-length maps. But I think the
> right answer is actually to make sure that we have a map_update_elem
> callback variant that accepts key/value size explicitly. I still think
> that the syscall interface shouldn't introduce a concept of dynptr.
> >From user-space's point of view dynptr is just a memory pointer +
> associated memory size. Let's keep it simple. And yes, it will be a
> new libbpf API for bpf_map_lookup_elem/bpf_map_update_elem. That's
> fine.
Is your point that dynptr is too complicated for user-space and may lead to
confusion between dynptr in kernel space ? How about a different name or a
simple definition just like bpf_lpm_trie_key ? It will make both the
implementation and the usage much simpler, because the implementation and the
user can still use the same APIs just like fixed sized map.

Not just lookup/update/delete, we also need to define a new op for
get_next_key/lookup_and_delete_elem. And also need to define corresponding new
bpf helpers for bpf program. And you said "explict key/value size", do you mean
something below ?

int (*map_update_elem)(struct bpf_map *map, void *key, u32 key_size, void
*value, u32 value_size, u64 flags);

>
>
>>> It also seems like you want to allow key (and maybe value as well, not
>>> sure) to be a custom user-defined type where some of the fields are
>>> struct bpf_dynptr. I think it's a big overcomplication, tbh. I'd say
>>> it's enough to just say that entire key has to be described by a
>>> single bpf_dynptr. Then we can have bpf_map_lookup_elem_dynptr(map,
>>> key_dynptr, flags) new helper to provide variable-sized key for
>>> lookup.
>> For qp-trie, it will only support a single dynptr as the map key. In the future
>> maybe other map will support map key with embedded dynptrs. Maybe Joanne can
>> share some vision about such use case.
> My point was that instead of saying that key is some fixed-size struct
> in which one of the fields is dynptr (and then when comparing you have
> to compare part of struct, then dynptr contents, then the other part
> of struct?), just say that entire key is represented by dynptr,
> implicitly (it's just a blob of bytes). That seems more
> straightforward.
I see. But I still think there is possible user case for struct with embedded
dynptr. For bpf map in kernel, byte blob is OK. But If it is also a blob of
bytes for the bpf program or userspace application, the application may need to
marshaling and un-marshaling between the bytes blob and a meaningful struct type
each time before using it.
> .


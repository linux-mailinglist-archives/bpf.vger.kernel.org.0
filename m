Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB506E8A6C
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 08:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjDTGcz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 02:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjDTGcy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 02:32:54 -0400
Received: from out0-197.mail.aliyun.com (out0-197.mail.aliyun.com [140.205.0.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B1246B8
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 23:32:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=amy.saq@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.SLDPi4._1681972364;
Received: from 30.230.62.44(mailfrom:amy.saq@antgroup.com fp:SMTPD_---.SLDPi4._1681972364)
          by smtp.aliyun-inc.com;
          Thu, 20 Apr 2023 14:32:45 +0800
Message-ID: <59e93ac7-9baf-48b1-809b-e935ecfbff03@antgroup.com>
Date:   Thu, 20 Apr 2023 14:32:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC] A new bpf map type for fuzzy matching key
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "=?UTF-8?B?5ZGo5by6KOS4reiIqik=?=" <shuze.zq@antgroup.com>,
        "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
        "=?UTF-8?B?5byg57uq5bOwKOS6keS8ryk=?=" <yunbo.zxf@antgroup.com>
References: <303b5895-319d-2bb7-9909-10fec3323df2@antgroup.com>
 <CAADnVQ+3y0mbORnvCYNLdSGZ7hV5Qxskc3L-mTg0SmVpfwHFYQ@mail.gmail.com>
From:   "=?UTF-8?B?5rKI5a6J55CqKOWHm+eOpSk=?=" <amy.saq@antgroup.com>
In-Reply-To: <CAADnVQ+3y0mbORnvCYNLdSGZ7hV5Qxskc3L-mTg0SmVpfwHFYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2023/4/17 上午2:23, Alexei Starovoitov 写道:
> On Sat, Apr 15, 2023 at 9:32 PM 沈安琪(凛玥) <amy.saq@antgroup.com> wrote:
>>
>> Hi everyone,
>>
>> For supporting fuzzy matching in bpf map as described in the original
>> question [0], we come up with a proposal that would like to have some
>> advice or comments from bpf thread. Thanks a lot for all the feedback :)
>>
>> We plan to implement a new bpf map type, naming BPF_FM_MAP, standing for
>> fuzzy matching map.
>> The basic idea is implementing a trie-tree using map of map runtime
>> structure.
>>
>> The number of tree levels equals to the number of fields in the key
>> struct. Assuming that the key struct has M fields, the first (M-1) level
>> of tree nodes will be hash maps with key as the value of (M-1)-th field
>> and entry as the fd of next level map. The last level, regarded as leaf
>> nodes, will be hash maps with key as the value of M-th field and entry
>> as user-defined entry for this BPF_FM_MAP.
>>
>> To support fuzzy matching, we add a special value -1 as (M-1)-th field
>> key if (M-1)-th field is set as general match.
>>
>> When looking up a target key in BPF_FM_MAP, it will lookup the first
>> level hashmap, matching the entry with the same value on this field and
>> with -1 if exists. Then it will lookup the next-level hashmap, whose fd
>> is the value it get from the previous level hashmap. It will go through
>> all the levels of tree and get a set of leaf nodes it matches. Finally,
>> it will sort the set of matched leaf nodes based on their priority,
>> which is defined in BPF_FM_MAP entry struct, and return the
>> corresponding return value also defined in BPF_FM_MAP entry struct.
>>
>>
>> Given a user-defined key struct and entry struct as following:
>>
>> struct fm_key {
>>       int a;
>>       int b;
>>       int c;
>> }
>>
>> struct fm_entry {
>>       int priority;
>>       int value;
>> }
>>
>> and declare a BPF_FM_MAP DEMO_MAP to store incoming key-value pair:
>>
>> struct {
>>       __uint(type, BPF_FM_MAP);
>>       __type(key, struct fm_key);
>>       __type(value, struct fm_entry);
>>       __uint(pinning, LIBBPF_PIN_BY_NAME);
>>       __uint(max_entries, 1024);
>>       __uint(map_flags, BPF_F_NO_PREALLOC);
>> } DEMO_MAP SEC(".maps");
>>
>> Now, we add the following three key-value pairs into DEMO_MAP:
>>
>> |a    |b    |c    |priority    |value    |
>> |-    |-    |1    |1           |1        |
>> |-    |2    |1    |2           |2        |
>> |3    |2    |1    |3           |3        |
>>
>> The tree will be constructed as following:
>>
>> field a             field b               field c
>>
>>                                             fd = 3
>>                                        ---->| key | (prioriy, value) |
>>                                       |     |  1  |       (1, 1) |
>>                                       |
>>                       fd = 1          |
>>                    -->| key | val |   |
>>                   |   | -1  |  3  |----     fd = 4
>>                   |   |  2  |  4  |-------->| key | (prioriy, value) |
>>    fd = 0         |                         |  1  |       (2, 2) |
>> | key | val |   |
>> | -1  |  1  |----
>> |  3  |  2  |----
>>                   |   fd = 2
>>                    -->| key | val |         fd = 5
>>                       |  2  |  5  |-------->| key | (prioriy, value) |
>>                                             |  1  |       (3, 3) |
>>
>>
>> After updating the tree, we have three target tuples to lookup in DEMO_MAP.
>>
>> struct fm_key t1 = {
>>       .a = 6,
>>       .b = 4,
>>       .c = 1
>> };
>>
>> struct fm_key t2 = {
>>       .a = 5,
>>       .b = 2,
>>       .c = 1
>> };
>>
>> struct fm_key t3 = {
>>       .a = 3,
>>       .b = 2,
>>       .c = 1
>> };
>>
>> // map lookup order: 0 -> 1 -> 3
>> // matched leaf nodes: (1, 1)
>> // picked return value: 1
>> map_lookup_elem(&DEMO_MAP, &t1) == 1
>>
>> // map loopup order: 0 -> 1 -> (3, 4)
>> // matched leaf nodes: (1, 1), (2, 2)
>> // picked return value: 2
>> map_lookup_elem(&DEMO_MAP, &t2) == 2
>>
>> // map lookup order: 0 -> (1, 2) -> (3, 4, 5)
>> // matched leaf nodes: (1, 1), (2, 2), (3, 3)
>> // picked return value: 3
>> map_loopup_elem(&DEMO_MAP, &t3) == 3
>>
>>
>> Thanks a lot for reviewing this proposal and we really appreciate any
>> feedback here.
> This sounds like several hash maps chained together with a custom logic.
> If so it's not clear why a new map type is necessary.
> Just let bpf prog lookup multiple hash maps.


Dear Alexei,

Thanks for reviewing the proposal.

We have several motivation to have a new bpf map type to support fuzzy 
matching.

First of all, we find that fuzzy matching a N-element tuple is quite a 
common scenario, especially in networking. With current bpf map types, 
developers need to modify the target tuple's field and lookup the map 
several times if they want to find all fuzzy-matched entries. Or, they 
need to implement some runtime structures such as the one mentioned in 
proposal each time to support fuzzy matching, which is quite time-consuming.

Another reason is that this new bpf map type can provide better 
performance than looking up maps several times to find all fuzzy matched 
entries. Saying that we have a 3-element tuple(a, b, c), and each field 
has m possible values. If we use a bpf hashmap, it will have m*m*m 
entries. If a developer want to do fuzzy matching on each field, he/she 
needs to do map lookup over m*m*m entries three times. With the bpf 
fuzzy matching map as proposed, he/she needs to do map lookup over m 
entries three times, which will give some performance benefit when m is 
large.

These are the two main reasons we have to implement a new bpf map type. 
If there is better way to do so or any other comments, we are more than 
happy to have further discussion in the thread.

Sincerely,
Amy


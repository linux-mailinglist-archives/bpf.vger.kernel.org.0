Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D100A6E34F2
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 06:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDPE0u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Apr 2023 00:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDPE0t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Apr 2023 00:26:49 -0400
Received: from out0-205.mail.aliyun.com (out0-205.mail.aliyun.com [140.205.0.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890AE271C
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 21:26:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047206;MF=amy.saq@antgroup.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---.SHIYFT9_1681619201;
Received: from 30.13.169.194(mailfrom:amy.saq@antgroup.com fp:SMTPD_---.SHIYFT9_1681619201)
          by smtp.aliyun-inc.com;
          Sun, 16 Apr 2023 12:26:42 +0800
Message-ID: <303b5895-319d-2bb7-9909-10fec3323df2@antgroup.com>
Date:   Sun, 16 Apr 2023 12:26:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
To:     bpf@vger.kernel.org
Cc:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>,
        "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "=?UTF-8?B?5ZGo5by6KOS4reiIqik=?=" <shuze.zq@antgroup.com>,
        "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
        "=?UTF-8?B?5byg57uq5bOwKOS6keS8ryk=?=" <yunbo.zxf@antgroup.com>
From:   "=?UTF-8?B?5rKI5a6J55CqKOWHm+eOpSk=?=" <amy.saq@antgroup.com>
Subject: [RFC] A new bpf map type for fuzzy matching key
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi everyone,

For supporting fuzzy matching in bpf map as described in the original 
question [0], we come up with a proposal that would like to have some 
advice or comments from bpf thread. Thanks a lot for all the feedback :)

We plan to implement a new bpf map type, naming BPF_FM_MAP, standing for 
fuzzy matching map.
The basic idea is implementing a trie-tree using map of map runtime 
structure.

The number of tree levels equals to the number of fields in the key 
struct. Assuming that the key struct has M fields, the first (M-1) level 
of tree nodes will be hash maps with key as the value of (M-1)-th field 
and entry as the fd of next level map. The last level, regarded as leaf 
nodes, will be hash maps with key as the value of M-th field and entry 
as user-defined entry for this BPF_FM_MAP.

To support fuzzy matching, we add a special value -1 as (M-1)-th field 
key if (M-1)-th field is set as general match.

When looking up a target key in BPF_FM_MAP, it will lookup the first 
level hashmap, matching the entry with the same value on this field and 
with -1 if exists. Then it will lookup the next-level hashmap, whose fd 
is the value it get from the previous level hashmap. It will go through 
all the levels of tree and get a set of leaf nodes it matches. Finally, 
it will sort the set of matched leaf nodes based on their priority, 
which is defined in BPF_FM_MAP entry struct, and return the 
corresponding return value also defined in BPF_FM_MAP entry struct.


Given a user-defined key struct and entry struct as following:

struct fm_key {
     int a;
     int b;
     int c;
}

struct fm_entry {
     int priority;
     int value;
}

and declare a BPF_FM_MAP DEMO_MAP to store incoming key-value pair:

struct {
     __uint(type, BPF_FM_MAP);
     __type(key, struct fm_key);
     __type(value, struct fm_entry);
     __uint(pinning, LIBBPF_PIN_BY_NAME);
     __uint(max_entries, 1024);
     __uint(map_flags, BPF_F_NO_PREALLOC);
} DEMO_MAP SEC(".maps");

Now, we add the following three key-value pairs into DEMO_MAP:

|a    |b    |c    |priority    |value    |
|-    |-    |1    |1           |1        |
|-    |2    |1    |2           |2        |
|3    |2    |1    |3           |3        |

The tree will be constructed as following:

field a             field b               field c

                                           fd = 3
                                      ---->| key | (prioriy, value) |
                                     |     |  1  |       (1, 1) |
                                     |
                     fd = 1          |
                  -->| key | val |   |
                 |   | -1  |  3  |----     fd = 4
                 |   |  2  |  4  |-------->| key | (prioriy, value) |
  fd = 0         |                         |  1  |       (2, 2) |
| key | val |   |
| -1  |  1  |----
|  3  |  2  |----
                 |   fd = 2
                  -->| key | val |         fd = 5
                     |  2  |  5  |-------->| key | (prioriy, value) |
                                           |  1  |       (3, 3) |


After updating the tree, we have three target tuples to lookup in DEMO_MAP.

struct fm_key t1 = {
     .a = 6,
     .b = 4,
     .c = 1
};

struct fm_key t2 = {
     .a = 5,
     .b = 2,
     .c = 1
};

struct fm_key t3 = {
     .a = 3,
     .b = 2,
     .c = 1
};

// map lookup order: 0 -> 1 -> 3
// matched leaf nodes: (1, 1)
// picked return value: 1
map_lookup_elem(&DEMO_MAP, &t1) == 1

// map loopup order: 0 -> 1 -> (3, 4)
// matched leaf nodes: (1, 1), (2, 2)
// picked return value: 2
map_lookup_elem(&DEMO_MAP, &t2) == 2

// map lookup order: 0 -> (1, 2) -> (3, 4, 5)
// matched leaf nodes: (1, 1), (2, 2), (3, 3)
// picked return value: 3
map_loopup_elem(&DEMO_MAP, &t3) == 3


Thanks a lot for reviewing this proposal and we really appreciate any 
feedback here.

[0]: 
https://lore.kernel.org/bpf/2172a7a7-323b-9798-f990-00df69b136d0@antgroup.com/T/#u

Sincerely,
Amy


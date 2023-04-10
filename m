Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2456DC6E2
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 14:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDJMs7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 08:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDJMs5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 08:48:57 -0400
Received: from out0-207.mail.aliyun.com (out0-207.mail.aliyun.com [140.205.0.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51895261
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 05:48:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=amy.saq@antgroup.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---.SC2IBoi_1681130930;
Received: from 30.177.20.28(mailfrom:amy.saq@antgroup.com fp:SMTPD_---.SC2IBoi_1681130930)
          by smtp.aliyun-inc.com;
          Mon, 10 Apr 2023 20:48:50 +0800
Message-ID: <2172a7a7-323b-9798-f990-00df69b136d0@antgroup.com>
Date:   Mon, 10 Apr 2023 20:48:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
To:     bpf@vger.kernel.org
From:   "=?UTF-8?B?5rKI5a6J55CqKOWHm+eOpSk=?=" <amy.saq@antgroup.com>
Subject: [Question] Does/Will bpf map support fuzzy matching?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,


We are working on an ebpf project that needs packet filtering based on 
user-defined networking policy and wonder whether there is or will be a 
bpf map type that supports fuzzy matching.


Fuzzy matching here means that the key of the map, which is a 
multi-field structure, can have some fields as general matching, like 
'*' in regex.

For example, we set up a map with key-value pair as (struct demo, int 
value), where struct demo has three fields: a, b, c.

struct demo {

     int a;

     int b;

     int c;

};

struct {
     __uint(type, SOME_TYPE_OF_BPF_MAP);
     __type(key, struct demo);
     __type(value, int);

     ......

} DEMO_MAP SEC(".maps");

Then we insert a key-value pair into the map, where the key only has two 
fields set, leaving the third field as general matching:

struct demo key1;

key1.a = 1;

key1.b = 1;

int value1 = 1;

map_update_elem(&DEMO_MAP, &key1, &value1,...);

After inserting the entry, we now have a target key that needs to find 
whether there is a match in DEMO_MAP. Saying that the target key is 
key_target and when we do map lookup, it can match key-value pair (key1, 
value1) even though key1's field c is not set.

struct demo key_target;

key_target.a = 1;

key_target.b = 1;

key_target.c = 3;

map_lookup_elem(&DEMO_MAP, &key_target) == 1

If we have another key_target_2 with a = 1, b = 1, c = 5, it can also 
match (key1, value1).


This feature is very helpful when setting network policies that we have 
some specific port/identity/protocol to take one action and other 
general policies to take another action. This feature is also similar to 
what DPDK Networking ACL provides: 
https://doc.dpdk.org/guides/prog_guide/packet_classif_access_ctrl.html.


We really appreciate any suggestion/discussion here :)


Thanks so much,

Amy


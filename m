Return-Path: <bpf+bounces-52707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC9A4718B
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 02:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC531895D9C
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 01:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B141B4223;
	Thu, 27 Feb 2025 01:32:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618814AD3F
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619970; cv=none; b=dqLgwayRn5LJneo+cY7kHLO9F+xUUVTX8i6CKBnGYjMTCHuowxNiVgT66CwFl6ShXGAMl1KJabssR9R6R0byV3niUxQgqeIjHwrs4t6f9TZfAypz2uRGOV8vIBIUt0P5HqGVRCjUutOu4sh/KrcBzIAQpDVoU8WsEqdbXaVqlV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619970; c=relaxed/simple;
	bh=dKngIrOLO39YaCDK5qXHLn/a0CjxWGyojifeBm+7M7s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rv4blAYmkbLo/ghfpNeL+EvzDGYK2gNapxvAr9Gv0JyJ7/S1jVWYXx5o99drGuiJoBQpfFBG39c0epo0kaJf3IUtMNAXhm2b32pJTndqfcYzt2ArzVYSvqL192KAqe5SbRsQ8lvxNDkYuwYLblv8tqYxkAtYxsbXk2uXJIi7vY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z3DNV0CPwz4f3jt8
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 09:32:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8CD451A0196
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 09:32:42 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBH5sC3wL9nHJTCEw--.47841S2;
	Thu, 27 Feb 2025 09:32:42 +0800 (CST)
Subject: Re: [PATCH] bpf: fix possible endless loop in BPF map iteration
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
References: <Z7zsLsjrldJAISJY@bkammerd-mobl>
 <ed150c6e-7987-4729-8a6b-e1e9e38823cb@linux.dev>
 <c19ee119-a463-f4bb-d15d-b7fae0a1ff4a@huaweicloud.com>
 <Z73svxvnH4dW9PZH@bkammerd-mobl>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <07491b89-cf95-b467-e670-dddd470bd572@huaweicloud.com>
Date: Thu, 27 Feb 2025 09:32:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z73svxvnH4dW9PZH@bkammerd-mobl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBH5sC3wL9nHJTCEw--.47841S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4kZr4DKryxZFyUZryrWFg_yoW7tw4Upr
	Z5KFyUJry5Jr1kXr1jqr18JryUtr15Jw1DXr1DJFyUJrZ8tr12qr1UZr1qgr1UAr4rJr1U
	tr1jqr13ZryUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/26/2025 12:15 AM, Brandon Kammerdiener wrote:
> On Tue, Feb 25, 2025 at 08:26:17PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 2/25/2025 3:13 PM, Martin KaFai Lau wrote:
>>> On 2/24/25 2:01 PM, Brandon Kammerdiener wrote:
>>>> This patch fixes an endless loop condition that can occur in
>>>> bpf_for_each_hash_elem, causing the core to softlock. My
>>>> understanding is
>>>> that a combination of RCU list deletion and insertion introduces the new
>>>> element after the iteration cursor and that there is a chance that an
>>>> RCU
>>> new element is added to the head of the bucket, so the first thought
>>> is it should not extend the list beyond the current iteration point...
>>>
>>>> reader may in fact use this new element in iteration. The patch uses a
>>>> _safe variant of the macro which gets the next element to iterate before
>>>> executing the loop body for the current element. The following simple
>>>> BPF
>>>> program can be used to reproduce the issue:
>>>>
>>>>      #include "vmlinux.h"
>>>>      #include <bpf/bpf_helpers.h>
>>>>      #include <bpf/bpf_tracing.h>
>>>>
>>>>      #define N (64)
>>>>
>>>>      struct {
>>>>          __uint(type,        BPF_MAP_TYPE_HASH);
>>>>          __uint(max_entries, N);
>>>>          __type(key,         __u64);
>>>>          __type(value,       __u64);
>>>>      } map SEC(".maps");
>>>>
>>>>      static int cb(struct bpf_map *map, __u64 *key, __u64 *value,
>>>> void *arg) {
>>>>          bpf_map_delete_elem(map, key);
>>>>          bpf_map_update_elem(map, &key, &val, 0);
>>> I suspect what happened in this reproducer is,
>>> there is a bucket with more than one elem(s) and the deleted elem gets
>>> immediately added back to the bucket->head.
>>> Something like this, '[ ]' as the current elem.
>>>
>>> 1st iteration     (follow bucket->head.first): [elem_1] ->  elem_2
>>>                                   delete_elem:  elem_2
>>>                                   update_elem: [elem_1] ->  elem_2
>>> 2nd iteration (follow elem_1->hash_node.next):  elem_1  -> [elem_2]
>>>                                   delete_elem:  elem_1
>>>                                   update_elem: [elem_2] -> elem_1
>>> 3rd iteration (follow elem_2->hash_node.next):  elem_2  -> [elem_1]
>>>                   loop.......
>>>
>> Yes. The above procedure is exactly the test case tries to do (except
>> the &key and &val typos).
> Yes, apologies for the typos I must have introduced when minifying the
> example. Should just use key and val sans the &.

OK
>
>>> don't think "_safe" covers all cases though. "_safe" may solve this
>>> particular reproducer which is shooting itself in the foot by deleting
>>> and adding itself when iterating a bucket.
>> Yes, if the bpf prog could delete and re-add the saved next entry, there
>> will be dead loop as well. It seems __htab_map_lookup_elem() may suffer
>> from the same problem just as bpf_for_each_hash_elem(). The problem is
>> mainly due to the immediate reuse of deleted element. Maybe we need to
>> add a seqlock to the htab_elem and retry the traversal if the seqlock is
>> not stable.

The seqlock + restart traversal way doesn't work, because the seq-count
for each element will add 2 after the re-insert and the loop will always
try to restart the traversal. I have another idea: how about add an
per-bucket incremental id for each element in the bucket and during the
traversal, the traversal will ignore the element with id greater than
the id of current element, so it will ignore the newly-added element.
For example, there are three elements in a bucket list: head -> A [id=3]
-> B[id=2] -> C[id=1]

(1) pass A to cb
current id = 3
cb deletes A and inserts A again
head -> A[4] -> B[2] -> C[1]

(2) pass B to cb
current id=2
cb deletes B and inserts B again
head -> B[5] -> A[4] -> C[1]

the id of A is greater than current id, so it is skipped.

>>> [ btw, I don't think the test code can work as is. At least the "&key"
>>> arg of the bpf_map_update_elem looks wrong. ]
>>>
>>>>          return 0;
>>>>      }
>>>>
>>>>      SEC("uprobe//proc/self/exe:test")
>>>>      int BPF_PROG(test) {
>>>>          __u64 i;
>>>>
>>>>          bpf_for(i, 0, N) {
>>>>              bpf_map_update_elem(&map, &i, &i, 0);
>>>>          }
>>>>
>>>>          bpf_for_each_map_elem(&map, cb, NULL, 0);
>>>>
>>>>          return 0;
>>>>      }
>>>>
>>>>      char LICENSE[] SEC("license") = "GPL";
>>>>
>>>> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
>>>>
>>>> ---
>>>>   kernel/bpf/hashtab.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>> index 4a9eeb7aef85..43574b0495c3 100644
>>>> --- a/kernel/bpf/hashtab.c
>>>> +++ b/kernel/bpf/hashtab.c
>>>> @@ -2224,7 +2224,7 @@ static long bpf_for_each_hash_elem(struct
>>>> bpf_map *map, bpf_callback_t callback_
>>>>           b = &htab->buckets[i];
>>>>           rcu_read_lock();
>>>>           head = &b->head;
>>>> -        hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
>>>> +        hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
>>>>               key = elem->key;
>>>>               if (is_percpu) {
>>>>                   /* current cpu value for percpu map */
>>>> --
>>>> 2.48.1
>>>>
>>>
>>> .
> .



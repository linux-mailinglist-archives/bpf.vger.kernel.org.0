Return-Path: <bpf+bounces-52500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8782A43F60
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 13:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491973B961E
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F252686B1;
	Tue, 25 Feb 2025 12:26:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28527264A7C
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486391; cv=none; b=C+PE2CvLL82uNUdpKBjSbot7TLo8LX9Lhrscp/DlrXLS18cL51ej9TglvWyblot7cV3T4VtOC/jHXYib8Rcs7tQwSGOIZwNEtDRErffvgPBOvp1Xzef05zc5eKuP9TPYzyiMzH4g4yMx9uUKN9IMqEpIsxzdtO1hOKS9eAojR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486391; c=relaxed/simple;
	bh=TGc7xH2HX6AVaXCQ/cpE3kPXi4xRPw//JyynBqaIkkg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=feM54oE2eLz7XHFuomsPw2XA9Rg3XaZvDQmDvhQgxW4lDKgeAde+zgYLCxI+bQA+Pmi27liULA0F8KTwlVIi/YaFq0THrdrnNJHFbfp4TCY7tuDe6SmDm+mAc4OXnE3Mf6KsHZNCk7/TA2+MEZ4EiMdsHjHVQN0GgDrmVmY7Jbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z2GzW2hwGz4f3jrs
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 20:25:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 311271A111D
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 20:26:21 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgD3p3jptr1n+p4vEw--.8744S2;
	Tue, 25 Feb 2025 20:26:21 +0800 (CST)
Subject: Re: [PATCH] bpf: fix possible endless loop in BPF map iteration
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Cc: bpf@vger.kernel.org
References: <Z7zsLsjrldJAISJY@bkammerd-mobl>
 <ed150c6e-7987-4729-8a6b-e1e9e38823cb@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <c19ee119-a463-f4bb-d15d-b7fae0a1ff4a@huaweicloud.com>
Date: Tue, 25 Feb 2025 20:26:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ed150c6e-7987-4729-8a6b-e1e9e38823cb@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgD3p3jptr1n+p4vEw--.8744S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1UJFW7GFW5Cw4kGw1xKrg_yoWrtFyxpF
	4kKFyUJry5Jrn7Xr1UJr18JryUJr15Jw1UJryDJFyUJr4UJr1jqr1UXr1jgr1UAr48Jr18
	tr1jqr13Zr1UGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/25/2025 3:13 PM, Martin KaFai Lau wrote:
> On 2/24/25 2:01 PM, Brandon Kammerdiener wrote:
>> This patch fixes an endless loop condition that can occur in
>> bpf_for_each_hash_elem, causing the core to softlock. My
>> understanding is
>> that a combination of RCU list deletion and insertion introduces the new
>> element after the iteration cursor and that there is a chance that an
>> RCU
>
> new element is added to the head of the bucket, so the first thought
> is it should not extend the list beyond the current iteration point...
>
>> reader may in fact use this new element in iteration. The patch uses a
>> _safe variant of the macro which gets the next element to iterate before
>> executing the loop body for the current element. The following simple
>> BPF
>> program can be used to reproduce the issue:
>>
>>      #include "vmlinux.h"
>>      #include <bpf/bpf_helpers.h>
>>      #include <bpf/bpf_tracing.h>
>>
>>      #define N (64)
>>
>>      struct {
>>          __uint(type,        BPF_MAP_TYPE_HASH);
>>          __uint(max_entries, N);
>>          __type(key,         __u64);
>>          __type(value,       __u64);
>>      } map SEC(".maps");
>>
>>      static int cb(struct bpf_map *map, __u64 *key, __u64 *value,
>> void *arg) {
>>          bpf_map_delete_elem(map, key);
>>          bpf_map_update_elem(map, &key, &val, 0);
>
> I suspect what happened in this reproducer is,
> there is a bucket with more than one elem(s) and the deleted elem gets
> immediately added back to the bucket->head.
> Something like this, '[ ]' as the current elem.
>
> 1st iteration     (follow bucket->head.first): [elem_1] ->  elem_2
>                                   delete_elem:  elem_2
>                                   update_elem: [elem_1] ->  elem_2
> 2nd iteration (follow elem_1->hash_node.next):  elem_1  -> [elem_2]
>                                   delete_elem:  elem_1
>                                   update_elem: [elem_2] -> elem_1
> 3rd iteration (follow elem_2->hash_node.next):  elem_2  -> [elem_1]
>                   loop.......
>

Yes. The above procedure is exactly the test case tries to do (except
the &key and &val typos).

> don't think "_safe" covers all cases though. "_safe" may solve this
> particular reproducer which is shooting itself in the foot by deleting
> and adding itself when iterating a bucket.

Yes, if the bpf prog could delete and re-add the saved next entry, there
will be dead loop as well. It seems __htab_map_lookup_elem() may suffer
from the same problem just as bpf_for_each_hash_elem(). The problem is
mainly due to the immediate reuse of deleted element. Maybe we need to
add a seqlock to the htab_elem and retry the traversal if the seqlock is
not stable.
>
> [ btw, I don't think the test code can work as is. At least the "&key"
> arg of the bpf_map_update_elem looks wrong. ]
>
>>          return 0;
>>      }
>>
>>      SEC("uprobe//proc/self/exe:test")
>>      int BPF_PROG(test) {
>>          __u64 i;
>>
>>          bpf_for(i, 0, N) {
>>              bpf_map_update_elem(&map, &i, &i, 0);
>>          }
>>
>>          bpf_for_each_map_elem(&map, cb, NULL, 0);
>>
>>          return 0;
>>      }
>>
>>      char LICENSE[] SEC("license") = "GPL";
>>
>> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
>>
>> ---
>>   kernel/bpf/hashtab.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 4a9eeb7aef85..43574b0495c3 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -2224,7 +2224,7 @@ static long bpf_for_each_hash_elem(struct
>> bpf_map *map, bpf_callback_t callback_
>>           b = &htab->buckets[i];
>>           rcu_read_lock();
>>           head = &b->head;
>> -        hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
>> +        hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
>>               key = elem->key;
>>               if (is_percpu) {
>>                   /* current cpu value for percpu map */
>> -- 
>> 2.48.1
>>
>
>
> .



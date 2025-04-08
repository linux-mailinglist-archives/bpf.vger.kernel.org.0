Return-Path: <bpf+bounces-55433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD7A7F2BC
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 04:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00460179A48
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 02:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70A21CA0D;
	Tue,  8 Apr 2025 02:36:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEBB5661
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079793; cv=none; b=rCgpQ4UIm9Nwn59uchYN2I6SHw9xDyixizYmBU3X9IlpvXp3Uk7fmCwSBAm2jE3x5S3zhhJkDfQitCb3DiE2ksNlJ/1Yi+gmXbzXDazUMjnzpZnD0sttpgG4Ixs07GuRumBHUSvX/nfBOdXDxpMmNjEBg7huvplncl8owWls+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079793; c=relaxed/simple;
	bh=zd59siPUInUllJFFdmVRYSh/obC4WubWAQLW0i8PY3s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S0fA0HXCHB0TGvW3fxS70zMOyoYHYsn4y/kFwXQhakHeyZ62MHuGEouQErmX/GYZtj9CamTBMXgH40Mq/UVweuCHQ7VzDBgbDPIvsPlyeR1Tv5SjXk1UuafnervBshqImonakaCHl/yTJbcp6vgBdei5W87AbTvcdVdMW6K0Ch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZWqvP4pZxz4f3lWG
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 10:36:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 968011A13BA
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 10:36:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgA36Hini_RnQwTQIg--.57968S2;
	Tue, 08 Apr 2025 10:36:26 +0800 (CST)
Subject: Re: [PATCH] bpf: fix possible endless loop in BPF map iteration
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <Z7zsLsjrldJAISJY@bkammerd-mobl>
 <ed150c6e-7987-4729-8a6b-e1e9e38823cb@linux.dev>
 <c19ee119-a463-f4bb-d15d-b7fae0a1ff4a@huaweicloud.com>
 <Z73svxvnH4dW9PZH@bkammerd-mobl>
 <07491b89-cf95-b467-e670-dddd470bd572@huaweicloud.com>
 <CAADnVQLSgTDyddxANS76M0ctf_gSz-pGCCZhqfM9v32GGtUh6A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3ac9ead3-8ad7-cb90-f16f-06ddcc89e5ec@huaweicloud.com>
Date: Tue, 8 Apr 2025 10:36:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLSgTDyddxANS76M0ctf_gSz-pGCCZhqfM9v32GGtUh6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgA36Hini_RnQwTQIg--.57968S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4xXrW7WrWfCw1xGrWkXrb_yoWrZr13pF
	WrKFWUGr1kJry7Zr4Iv39Yqr1FyryrJw4UXr95Jry5A3s0gF1fJr1xC3WUKF98ArsxJr1I
	vr4293y3Za4UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Brandon,

On 2/27/2025 10:07 AM, Alexei Starovoitov wrote:
> On Wed, Feb 26, 2025 at 5:45 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 2/26/2025 12:15 AM, Brandon Kammerdiener wrote:
>>> On Tue, Feb 25, 2025 at 08:26:17PM +0800, Hou Tao wrote:
>>>> Hi,
>>>>
>>>> On 2/25/2025 3:13 PM, Martin KaFai Lau wrote:
>>>>> On 2/24/25 2:01 PM, Brandon Kammerdiener wrote:
>>>>>> This patch fixes an endless loop condition that can occur in
>>>>>> bpf_for_each_hash_elem, causing the core to softlock. My
>>>>>> understanding is
>>>>>> that a combination of RCU list deletion and insertion introduces the new
>>>>>> element after the iteration cursor and that there is a chance that an
>>>>>> RCU
>>>>> new element is added to the head of the bucket, so the first thought
>>>>> is it should not extend the list beyond the current iteration point...
>>>>>
>>>>>> reader may in fact use this new element in iteration. The patch uses a
>>>>>> _safe variant of the macro which gets the next element to iterate before
>>>>>> executing the loop body for the current element. The following simple
>>>>>> BPF
>>>>>> program can be used to reproduce the issue:
>>>>>>
>>>>>>      #include "vmlinux.h"
>>>>>>      #include <bpf/bpf_helpers.h>
>>>>>>      #include <bpf/bpf_tracing.h>
>>>>>>
>>>>>>      #define N (64)
>>>>>>
>>>>>>      struct {
>>>>>>          __uint(type,        BPF_MAP_TYPE_HASH);
>>>>>>          __uint(max_entries, N);
>>>>>>          __type(key,         __u64);
>>>>>>          __type(value,       __u64);
>>>>>>      } map SEC(".maps");
>>>>>>
>>>>>>      static int cb(struct bpf_map *map, __u64 *key, __u64 *value,
>>>>>> void *arg) {
>>>>>>          bpf_map_delete_elem(map, key);
>>>>>>          bpf_map_update_elem(map, &key, &val, 0);
>>>>> I suspect what happened in this reproducer is,
>>>>> there is a bucket with more than one elem(s) and the deleted elem gets
>>>>> immediately added back to the bucket->head.
>>>>> Something like this, '[ ]' as the current elem.
>>>>>
>>>>> 1st iteration     (follow bucket->head.first): [elem_1] ->  elem_2
>>>>>                                   delete_elem:  elem_2
>>>>>                                   update_elem: [elem_1] ->  elem_2
>>>>> 2nd iteration (follow elem_1->hash_node.next):  elem_1  -> [elem_2]
>>>>>                                   delete_elem:  elem_1
>>>>>                                   update_elem: [elem_2] -> elem_1
>>>>> 3rd iteration (follow elem_2->hash_node.next):  elem_2  -> [elem_1]
>>>>>                   loop.......
>>>>>
>>>> Yes. The above procedure is exactly the test case tries to do (except
>>>> the &key and &val typos).
>>> Yes, apologies for the typos I must have introduced when minifying the
>>> example. Should just use key and val sans the &.

Could you please resend the patch after fixing the typos in the patch ?
It will be better to add a new selftest for the fix.
>> OK
>>>>> don't think "_safe" covers all cases though. "_safe" may solve this
>>>>> particular reproducer which is shooting itself in the foot by deleting
>>>>> and adding itself when iterating a bucket.
>>>> Yes, if the bpf prog could delete and re-add the saved next entry, there
>>>> will be dead loop as well. It seems __htab_map_lookup_elem() may suffer
>>>> from the same problem just as bpf_for_each_hash_elem(). The problem is
>>>> mainly due to the immediate reuse of deleted element. Maybe we need to
>>>> add a seqlock to the htab_elem and retry the traversal if the seqlock is
>>>> not stable.
>> The seqlock + restart traversal way doesn't work, because the seq-count
>> for each element will add 2 after the re-insert and the loop will always
>> try to restart the traversal. I have another idea: how about add an
>> per-bucket incremental id for each element in the bucket and during the
>> traversal, the traversal will ignore the element with id greater than
>> the id of current element, so it will ignore the newly-added element.
>> For example, there are three elements in a bucket list: head -> A [id=3]
>> -> B[id=2] -> C[id=1]
>>
>> (1) pass A to cb
>> current id = 3
>> cb deletes A and inserts A again
>> head -> A[4] -> B[2] -> C[1]
>>
>> (2) pass B to cb
>> current id=2
>> cb deletes B and inserts B again
>> head -> B[5] -> A[4] -> C[1]
>>
>> the id of A is greater than current id, so it is skipped.
> This looks like unnecessary overhead that attempts
> to reinvent nulls logic.
>
> At present I'm not convinced that lookup_nulls_elem_raw() is broken.
> The only issue with bpf_for_each_hash_elem() that loops forever
> in this convoluted case and _safe() is the right fix for it.
>
> .



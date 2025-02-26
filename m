Return-Path: <bpf+bounces-52613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBDEA45442
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 05:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05CF16D049
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 04:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FA4253F05;
	Wed, 26 Feb 2025 04:05:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC233DF;
	Wed, 26 Feb 2025 04:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542753; cv=none; b=B7Tt2MSk3xlBtSG0Q4YXmMs4ljntQpxsuwL+VGyWyDFl+tqUVYbOEFMkI6kc/3Z5OZLfeu4sxE3hXMiYSleEvdZstEro3bBzDjQ8vsniowkKhAGXFO+MC/iwJW2j2USHOmgKrPihofqvotxJi/bqhueKGagDRRDhtFmoIa49IDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542753; c=relaxed/simple;
	bh=dXlDjg2pNVnOI7c52EzxCpiStSzswa9gIBOFh2fPjwk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YWamOf5Gr5K7QmmujTk04DJ3qId8lGFnNe3CCFAZrmcrwuqi9eMknpNVqS+qeSowG0TCwB8DHyvtDnNbycFVVSHiERLGfDpuVK4u0nPnXsyPwQVyreUTTeZY+p0vUB+/EeIHEEB/peJQrBC8lxgWdBHaxpPOAbC656eShjuiaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z2gqL2wzFz4f3jrs;
	Wed, 26 Feb 2025 12:05:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3B45A1A10B0;
	Wed, 26 Feb 2025 12:05:40 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDXOV4Nk75nguOvEw--.31068S2;
	Wed, 26 Feb 2025 12:05:37 +0800 (CST)
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in hash
 map atomically
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 bpf <bpf@vger.kernel.org>, rcu@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>,
 Cody Haas <chaas@riotgames.com>, Hou Tao <hotforest@gmail.com>
References: <20250204082848.13471-1-hotforest@gmail.com>
 <20250204082848.13471-3-hotforest@gmail.com>
 <cca6daf2-48f4-57b9-59a9-75578bb755b9@huaweicloud.com>
 <8734gr3yht.fsf@toke.dk>
 <d191084a-4ab4-8269-640f-1ecf269418a6@huaweicloud.com>
 <CAADnVQKD94q-G4N=w9PJU+k6gPhM8GmUYcyfj=33B_mKX6Qbjw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <6a84a878-0728-0a19-73d2-b5871e10e120@huaweicloud.com>
Date: Wed, 26 Feb 2025 12:05:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKD94q-G4N=w9PJU+k6gPhM8GmUYcyfj=33B_mKX6Qbjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDXOV4Nk75nguOvEw--.31068S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4xWrW8GFyfGF4xKFyDJrb_yoWrtFy3pr
	WrKF1jyF4DJa4j9wn2ywnruFWayrs3t3y8Xr1Dtry5Arn8Krn3Ar4Ika109ryrAr1rGr1Y
	qw1jqrZIkayjkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/26/2025 11:24 AM, Alexei Starovoitov wrote:
> On Sat, Feb 8, 2025 at 2:17 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi Toke,
>>
>> On 2/6/2025 11:05 PM, Toke Høiland-Jørgensen wrote:
>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>
>>>> +cc Cody Haas
>>>>
>>>> Sorry for the resend. I sent the reply in the HTML format.
>>>>
>>>> On 2/4/2025 4:28 PM, Hou Tao wrote:
>>>>> Currently, the update of existing element in hash map involves two
>>>>> steps:
>>>>> 1) insert the new element at the head of the hash list
>>>>> 2) remove the old element
>>>>>
>>>>> It is possible that the concurrent lookup operation may fail to find
>>>>> either the old element or the new element if the lookup operation starts
>>>>> before the addition and continues after the removal.
>>>>>
>>>>> Therefore, replacing the two-step update with an atomic update. After
>>>>> the change, the update will be atomic in the perspective of the lookup
>>>>> operation: it will either find the old element or the new element.
> I'm missing the point.
> This "atomic" replacement doesn't really solve anything.
> lookup will see one element.
> That element could be deleted by another thread.
> bucket lock and either two step update or single step
> don't change anything from the pov of bpf prog doing lookup.

The point is that overwriting an existed element may lead to concurrent
lookups return ENOENT as demonstrated by the added selftest and the
patch tried to "fix" that. However, it seems using
hlist_nulls_replace_rcu() for the overwriting update is still not
enough. Because when the lookup procedure found the old element, the old
element may be reusing, the comparison of the map key may fail, and the
lookup procedure may still return ENOENT.
>
>>>>> Signed-off-by: Hou Tao <hotforest@gmail.com>
>>>>> ---
>>>>>  kernel/bpf/hashtab.c | 14 ++++++++------
>>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>>> index 4a9eeb7aef85..a28b11ce74c6 100644
>>>>> --- a/kernel/bpf/hashtab.c
>>>>> +++ b/kernel/bpf/hashtab.c
>>>>> @@ -1179,12 +1179,14 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>>>>>             goto err;
>>>>>     }
>>>>>
>>>>> -   /* add new element to the head of the list, so that
>>>>> -    * concurrent search will find it before old elem
>>>>> -    */
>>>>> -   hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>>>>> -   if (l_old) {
>>>>> -           hlist_nulls_del_rcu(&l_old->hash_node);
>>>>> +   if (!l_old) {
>>>>> +           hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>>>>> +   } else {
>>>>> +           /* Replace the old element atomically, so that
>>>>> +            * concurrent search will find either the new element or
>>>>> +            * the old element.
>>>>> +            */
>>>>> +           hlist_nulls_replace_rcu(&l_new->hash_node, &l_old->hash_node);
>>>>>
>>>>>             /* l_old has already been stashed in htab->extra_elems, free
>>>>>              * its special fields before it is available for reuse. Also
>>>>>
>>>> After thinking about it the second time, the atomic list replacement on
>>>> the update side is enough to make lookup operation always find the
>>>> existing element. However, due to the immediate reuse, the lookup may
>>>> find an unexpected value. Maybe we should disable the immediate reuse
>>>> for specific map (e.g., htab of maps).
>>> Hmm, in an RCU-protected data structure, reusing the memory before an
>>> RCU grace period has elapsed is just as wrong as freeing it, isn't it?
>>> I.e., the reuse logic should have some kind of call_rcu redirection to
>>> be completely correct?
>> Not for all cases. There is SLAB_TYPESAFE_BY_RCU-typed slab. For hash
>> map, the reuse is also tricky (e.g., the goto again case in
>> lookup_nulls_elem_raw), however it can not prevent the lookup procedure
>> from returning unexpected value. I had post a patch set [1] to "fix"
>> that, but Alexei said it is "a known quirk". Here I am not sure about
>> whether it is reasonable to disable the reuse for htab of maps only. I
>> will post a v2 for the patch set.
>>
>> [1]:
>> https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
> yes. we still have to keep prealloc as default for now :(
> Eventually bpf_mem_alloc is replaced with fully re-entrant
> and safe kmalloc, then we can do fully re-entrant and safe
> kfree_rcu. Then we can talk about closing this quirk.
> Until then the prog has to deal with immediate reuse.
> That was the case for a decade already.

I see. In v2 I will fallback to the original idea: adding a standalone
update procedure for htab of maps in which it will atomically overwrite
the map_ptr just like array of maps does.



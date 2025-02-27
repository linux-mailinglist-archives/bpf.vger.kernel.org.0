Return-Path: <bpf+bounces-52715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6CA47327
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 03:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC07161316
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 02:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13B3161321;
	Thu, 27 Feb 2025 02:43:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3D13A3F2;
	Thu, 27 Feb 2025 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740624204; cv=none; b=kJH9kTtzOxWvcz2IdgPPywJMESUp08/s7dIKgbvueTExaCpDmiABrpz8mnuWMLmzvA4JqxmcKiFG7kbLXfrZRsejZ3uRTS4dzmjGxshz+Pbc5CyRIq/nEOWce92F1g7lfBm+oQGdNwipcjzkzoXi9LAu/eBzt6sO2rVw5XCSJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740624204; c=relaxed/simple;
	bh=8vevpucxLxLEPsjp10JL+kflvH+M8z2SoxeLU1uMX+k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U/6Wk86bmTWWjP1YS3EbJ0cZ1TKmE3KizcVkTrmz9paYoMTc7AURYyq6t1G1ObBxVxn4K+jMFN3xuPSN+b+Z62S3Rc0D5Ns8c0o/3QcP+XOWSuKkAq4u5qpI/O6GQPqCjSUEzIRQ3gUlfwD2w70uL7iNhsNwtQBLYD37BhJY3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z3Fxr4qdLz4f3jt4;
	Thu, 27 Feb 2025 10:42:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 34DC01A07B6;
	Thu, 27 Feb 2025 10:43:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB32V070b9nv7wLFA--.4476S2;
	Thu, 27 Feb 2025 10:43:11 +0800 (CST)
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in hash
 map atomically
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Zvi Effron <zeffron@riotgames.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
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
 <6a84a878-0728-0a19-73d2-b5871e10e120@huaweicloud.com>
 <CAADnVQLrJBOSXP41iO+-FtH+XC9AmuOne7xHzvgXop3DUC5KjQ@mail.gmail.com>
 <CAC1LvL0ntdrWh_1y0EcVR6C1_WyqOQ15EhihfQRs=ai7pcE-Sw@mail.gmail.com>
 <7e614d80-b45b-e2f9-5a39-39086c2392dc@huaweicloud.com>
 <CAADnVQJU9OWAWFk89P6i1RK6vXkuee5s76suHjF+uP+V4iepqQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e1b65f13-a426-d707-0319-f57e8b15575a@huaweicloud.com>
Date: Thu, 27 Feb 2025 10:43:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJU9OWAWFk89P6i1RK6vXkuee5s76suHjF+uP+V4iepqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB32V070b9nv7wLFA--.4476S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWUuFy3Kw48ur4DtFyUtrb_yoWxCrWkpF
	WrKF1UKrWDJ34xtwn2vw1xZFyYyrs3J34UXrn8Jry5Ar98Kr1SgrWxZF4j9FyUAr4rJr1j
	qr4Ut3yfZa9rua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2/27/2025 9:59 AM, Alexei Starovoitov wrote:
> On Wed, Feb 26, 2025 at 5:48 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 2/27/2025 7:17 AM, Zvi Effron wrote:
>>> On Tue, Feb 25, 2025 at 9:42 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>> On Tue, Feb 25, 2025 at 8:05 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On 2/26/2025 11:24 AM, Alexei Starovoitov wrote:
>>>>>> On Sat, Feb 8, 2025 at 2:17 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>>>>> Hi Toke,
>>>>>>>
>>>>>>> On 2/6/2025 11:05 PM, Toke Høiland-Jørgensen wrote:
>>>>>>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>>>>>>
>>>>>>>>> +cc Cody Haas
>>>>>>>>>
>>>>>>>>> Sorry for the resend. I sent the reply in the HTML format.
>>>>>>>>>
>>>>>>>>> On 2/4/2025 4:28 PM, Hou Tao wrote:
>>>>>>>>>> Currently, the update of existing element in hash map involves two
>>>>>>>>>> steps:
>>>>>>>>>> 1) insert the new element at the head of the hash list
>>>>>>>>>> 2) remove the old element
>>>>>>>>>>
>>>>>>>>>> It is possible that the concurrent lookup operation may fail to find
>>>>>>>>>> either the old element or the new element if the lookup operation starts
>>>>>>>>>> before the addition and continues after the removal.
>>>>>>>>>>
>>>>>>>>>> Therefore, replacing the two-step update with an atomic update. After
>>>>>>>>>> the change, the update will be atomic in the perspective of the lookup
>>>>>>>>>> operation: it will either find the old element or the new element.
>>>>>> I'm missing the point.
>>>>>> This "atomic" replacement doesn't really solve anything.
>>>>>> lookup will see one element.
>>>>>> That element could be deleted by another thread.
>>>>>> bucket lock and either two step update or single step
>>>>>> don't change anything from the pov of bpf prog doing lookup.
>>>>> The point is that overwriting an existed element may lead to concurrent
>>>>> lookups return ENOENT as demonstrated by the added selftest and the
>>>>> patch tried to "fix" that. However, it seems using
>>>>> hlist_nulls_replace_rcu() for the overwriting update is still not
>>>>> enough. Because when the lookup procedure found the old element, the old
>>>>> element may be reusing, the comparison of the map key may fail, and the
>>>>> lookup procedure may still return ENOENT.
>>>> you mean l_old == l_new ? I don't think it's possible
>>>> within htab_map_update_elem(),
>>>> but htab_map_delete_elem() doing hlist_nulls_del_rcu()
>>>> then free_htab_elem, htab_map_update_elem, alloc, hlist_nulls_add_head_rcu
>>>> and just deleted elem is reused to be inserted
>>>> into another bucket.
>> No. I mean the following procedure in which the lookup procedure finds
>> the old element and tries to match its key, one update procedure has
>> already deleted the old element, and another update procedure is reusing
>> the old element:
>>
>> lookup procedure A
>> A: find the old element (instead of the new old)
>>
>>               update procedure B
>>               B: delete the old element
>>               update procedure C on the same CPU:
>>               C: reuse the old element (overwrite its key and insert in
>> the same bucket)
>>
>> A: the key is mismatched and return -ENOENT.
> This is fine. It's just normal reuse.
> Orthogonal to 'update as insert+delete' issue.

OK. However, it will break the lookup procedure because it expects it
will return an valid result instead of -ENOENT.
>
>> It can be reproduced by increasing ctx.loop in the selftest.
>>>> I'm not sure whether this new hlist_nulls_replace_rcu()
>>>> primitive works with nulls logic.
>>>>
>>>> So back to the problem statement..
>>>> Are you saying that adding new to a head while lookup is in the middle
>>>> is causing it to miss an element that
>>>> is supposed to be updated assuming atomicity of the update?
>>>> While now update_elem() is more like a sequence of delete + insert?
>>>>
>>>> Hmm.
>>> Yes, exactly that. Because update_elem is actually a delete + insert (actually
>>> an insert + delete, I think?), it is possible for a concurrent lookup to see no
>>> element instead of either the old or new value.
>> Yep.
>>>>> I see. In v2 I will fallback to the original idea: adding a standalone
>>>>> update procedure for htab of maps in which it will atomically overwrite
>>>>> the map_ptr just like array of maps does.
>>>> hold on. is this only for hash-of-maps ?
>>> I believe this was also replicated for hash as well as hash-of-maps. Cody can
>>> confirm, or use the reproducer he has to test that case.
>> The fix for hash-of-maps will be much simpler and the returned map
>> pointer will be correct. For other types of hash map, beside switching
>> to hlist_nulls_replace_rcu(),
> It's been a long time since I looked into rcu_nulls details.
> Pls help me understand that this new replace_rcu_nulls()
> is correct from nulls pov,
> If it is then this patch set may be the right answer to non-atomic update.

If I understand correctly, only the manipulations of ->first pointer and
->next pointer need to take care of nulls pointer.
>
> And for the future, please please focus on "why" part in
> the cover letter and commit logs instead of "what".
>
> Since the only thing I got from the log was:
> "Currently, the update is not atomic
> because the overwrite of existing element happens in a two-steps way,
> but the support of atomic update is feasible".
>
> "is feasible" doesn't explain "why".
>
> Link to xdp-newbie question is nice for additional context,
> but reviewers should not need to go and read some thread somewhere
> to understand "why" part.
> All of it should be in the commit log.

OK. My original thought is that is a reported problem, so an extra link
will be enough. Will try to add more context next time.
>
>> map may still be incorrect (as shown long time ago [1]), so I think
>> maybe for other types of map, the atomic update doesn't matter too much.
>>
>> [1]:
>> https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
> A thread from 3 years ago ?! Sorry, it's not helpful to ask
> people to page-in such an old context with lots of follow ups
> that may or may not be relevant today.
Let me reuse part of the diagram above to explain how does the lookup
procedure may return a incorrect value:

lookup procedure A
A: find the old element (instead of the new element)


              update procedure B
              B: delete the old element
              update procedure C on the same CPU:


A: the key is matched and return the value in the element

              C: reuse the old element (overwrite its key and value)

A: read the value (it is incorrect, because it has been reused and
overwritten)




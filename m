Return-Path: <bpf+bounces-52717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EBBA473F2
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 05:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D543AD5C2
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 04:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561FE198A1A;
	Thu, 27 Feb 2025 04:08:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6199A59;
	Thu, 27 Feb 2025 04:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629321; cv=none; b=R47oU43/nuzje5eqTvwEm1nPpUN7RrNYm7GbCKMtkjxI1uqgEiE7XqsivZh1RKAxhokv+mMfBWVadOhtN+2cJ92FQs7vbY8R8Q+9OO3EMjcm1Pb/WB3x5k+9oerimlq19QSDqVnuu75qXsL0bkm7vUE6COcbqZYDRglODEnbovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629321; c=relaxed/simple;
	bh=jDpqDV+f3f+gTNoOjls2eh9JGcqzPxReFnyDScLUcn0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aZnViP3TjbXbeDsmkfVH1OqYOaEII0kgIzApZb4WHNEXz0DD/n25pioBaYKMnJTT6s73kQwwdBrG909MNgW7QFmBOKXPKoHgrr558joeTEBRRvEyxW69jklInAm8KqYzz5foltO8FaZDLxqiqGSUPybKlPDvexfymmTOGPP69e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z3Hr93YYNz4f3l26;
	Thu, 27 Feb 2025 12:08:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C2FE81A166E;
	Thu, 27 Feb 2025 12:08:32 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDnSF065b9n0WYRFA--.15782S2;
	Thu, 27 Feb 2025 12:08:30 +0800 (CST)
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
 <e1b65f13-a426-d707-0319-f57e8b15575a@huaweicloud.com>
 <CAADnVQLev2V-ARjPc9EPYaSssCev_87Lc0NWkLvL-5tuy=3Veg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <6b70aa4e-68c4-20de-b042-c549efd6a901@huaweicloud.com>
Date: Thu, 27 Feb 2025 12:08:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLev2V-ARjPc9EPYaSssCev_87Lc0NWkLvL-5tuy=3Veg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDnSF065b9n0WYRFA--.15782S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww1UJr1DuF43Aw1ruFyrXrb_yoW7KF4DpF
	WfKF18trWkJ34Ivwn29w1xX34Ykrs3t34UJrn5GryUCwn8Kr1SvFWSvF4Y9F4UZrs5GF1q
	qr4UK393Zan8uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2/27/2025 11:17 AM, Alexei Starovoitov wrote:
> On Wed, Feb 26, 2025 at 6:43 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> lookup procedure A
>>>> A: find the old element (instead of the new old)
>>>>
>>>>               update procedure B
>>>>               B: delete the old element
>>>>               update procedure C on the same CPU:
>>>>               C: reuse the old element (overwrite its key and insert in
>>>> the same bucket)
>>>>
>>>> A: the key is mismatched and return -ENOENT.
>>> This is fine. It's just normal reuse.
>>> Orthogonal to 'update as insert+delete' issue.
>> OK. However, it will break the lookup procedure because it expects it
>> will return an valid result instead of -ENOENT.
> What do you mean 'breaks the lookup' ?
> lookup_elem_raw() matches hash, and then it memcmp(key),
> if the element is reused anything can happen.
> Either it succeeds in memcmp() and returns an elem,
> or miscompares in memcmp().
> Both are expected, because elems are reused in place.
>
> And this behavior is expected and not-broken,
> because bpf prog that does lookup on one cpu and deletes
> the same element on the other cpu is asking for trouble.

It seems I mislead you in the above example. It is also possible for
doing lookup in one CPU and updating the same element in other CPU. So
does such concurrence also look insane ?

lookup procedure A
A: find the old element (instead of the new old)

              update procedure B
              B: overwrite the same element and free the old element
              update procedure C on the same CPU:
              C: reuse the old element (overwrite its key and insert in
the same bucket)

A: the key is mismatched and return -ENOENT.

> bpf infra guarantees the safety of the kernel.
> It doesn't guarantee that bpf progs are sane.
>
>>> It's been a long time since I looked into rcu_nulls details.
>>> Pls help me understand that this new replace_rcu_nulls()
>>> is correct from nulls pov,
>>> If it is then this patch set may be the right answer to non-atomic update.
>> If I understand correctly, only the manipulations of ->first pointer and
>> ->next pointer need to take care of nulls pointer.
> hmm. I feel we're still talking past each other.
> See if (get_nulls_value() == ...) in lookup_nulls_elem_raw().
> It's there because of reuse. The lookup can start in one bucket
> and finish in another.

Yes. I noticed that.  However, it happens when the deleted element is
reused and inserted to a different bucket, right ? For
replace_rcu_nulls(), the reuse of old element is possible only after
replace_rcu_nulls() completes, so I think it is irrelevant.

>If it is then this patch set may be the right answer to non-atomic update.

I also didn't follow that. Due to the immediate reuse, the lookup
procedure may still return -ENOENT when there is concurrent overwriting
of the same element as show above, so I think it only reduce the
possibility. I still prefer to implement a separated update procedure of
htab of maps to fix the atomic update problem completely for htab of
maps first.


>
>>> And for the future, please please focus on "why" part in
>>> the cover letter and commit logs instead of "what".
>>>
>>> Since the only thing I got from the log was:
>>> "Currently, the update is not atomic
>>> because the overwrite of existing element happens in a two-steps way,
>>> but the support of atomic update is feasible".
>>>
>>> "is feasible" doesn't explain "why".
>>>
>>> Link to xdp-newbie question is nice for additional context,
>>> but reviewers should not need to go and read some thread somewhere
>>> to understand "why" part.
>>> All of it should be in the commit log.
>> OK. My original thought is that is a reported problem, so an extra link
>> will be enough. Will try to add more context next time.
>>>> map may still be incorrect (as shown long time ago [1]), so I think
>>>> maybe for other types of map, the atomic update doesn't matter too much.
>>>>
>>>> [1]:
>>>> https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
>>> A thread from 3 years ago ?! Sorry, it's not helpful to ask
>>> people to page-in such an old context with lots of follow ups
>>> that may or may not be relevant today.
>> Let me reuse part of the diagram above to explain how does the lookup
>> procedure may return a incorrect value:
>>
>> lookup procedure A
>> A: find the old element (instead of the new element)
>>
>>
>>               update procedure B
>>               B: delete the old element
>>               update procedure C on the same CPU:
>>
>>
>> A: the key is matched and return the value in the element
>>
>>               C: reuse the old element (overwrite its key and value)
>>
>> A: read the value (it is incorrect, because it has been reused and
>> overwritten)
> ... and it's fine. It's by design. It's an element reuse behavior.
>
> Long ago hashmap had two modes: prealloc (default) and
> NO_PREALLOC (call_rcu + kfree)
>
> The call_rcu part was there to make things safe.
> The memory cannot be kfree-ed to the kernel until RCU GP.
> With bpf_mem_alloc hashmap elements are freed back to bpf_ma
> right away. Hashmap is doing bpf_mem_cache_free()
> (instead of bpf_mem_cache_free_rcu()) because users need speed.
> So since 2022 both prealloc and no_prealloc reuse elements.
> We can consider a new flag for the hash map like F_REUSE_AFTER_RCU_GP
> that will use _rcu() flavor of freeing into bpf_ma,
> but it has to have a strong reason.
> And soon as we add it the default with prealloc would need
> to use call_rcu() too, right?
> and that becomes nightmare, since bpf prog can easily DoS the system.
> Even if we use bpf_mem_cache_free_rcu() only, the DoS is a concern.
> Unlike new things like bpf_obj_new/obj_drop the hashmap
> is unpriv, so concerns are drastically different.
>
> .

I see. Thanks for the detailed explanation. And that is part of the
reason why I proposed adding a seq-counter in the htab-element and
checking the seq-counter during lookup, so at least the lookup will not
return -ENOENT for the concurrent overwriting procedure.



Return-Path: <bpf+bounces-52709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBC9A471D0
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 02:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5122718915DD
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 01:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6734136351;
	Thu, 27 Feb 2025 01:48:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD7171A7;
	Thu, 27 Feb 2025 01:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620901; cv=none; b=T0l0A8p0M0/7DtNX2vGXbMiVqAdnLPL6sU08Qahu1EchHOS9hVLEEN+an/T0RkRsRlQoRUwWW4FnQHokn0xXySLKx0y8dFtdEcEPEH/Xr80eRecDne9CVO4scsVyzFBDpdAeobRaCcknz0yHD6aSkvCLLMbK/H6l8OeZKpkb1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620901; c=relaxed/simple;
	bh=hXCpgkhn+skhmHAhl4wNgROyDP88FR/s5XtSXYcjl7M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fAXpFfr62FMkX5nFGIHrennZFnE23IjNgZDg5Wgg8rMEbKGueBbu/XzarrJK+CiI0SU2EqnsZdRVJIF+Vbk0cdvyhzTOHJDrjCYQJmxkJgXdbCqUrzY+A9Cdb2fsXIR2c9En45//mrLSnXeVNTndUzOHyAMurG6W93Aw9TiRM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z3DkF6TwJz4f3kvt;
	Thu, 27 Feb 2025 09:47:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 365681A183A;
	Thu, 27 Feb 2025 09:48:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBH5sBWxL9nbZjDEw--.49894S2;
	Thu, 27 Feb 2025 09:48:10 +0800 (CST)
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in hash
 map atomically
To: Zvi Effron <zeffron@riotgames.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <6a84a878-0728-0a19-73d2-b5871e10e120@huaweicloud.com>
 <CAADnVQLrJBOSXP41iO+-FtH+XC9AmuOne7xHzvgXop3DUC5KjQ@mail.gmail.com>
 <CAC1LvL0ntdrWh_1y0EcVR6C1_WyqOQ15EhihfQRs=ai7pcE-Sw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7e614d80-b45b-e2f9-5a39-39086c2392dc@huaweicloud.com>
Date: Thu, 27 Feb 2025 09:48:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC1LvL0ntdrWh_1y0EcVR6C1_WyqOQ15EhihfQRs=ai7pcE-Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBH5sBWxL9nbZjDEw--.49894S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1kKr1xArWDGw4fZFWxCrg_yoW7XFyUpF
	WrKF1UKrWDJ340qwn2yr1xZFWYyrn3Jw1jqr1DJFy5Arn8Kr1Sqr4xZa1F9F1UAr4rJr1j
	vr17t3y3Z3ZrJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/27/2025 7:17 AM, Zvi Effron wrote:
> On Tue, Feb 25, 2025 at 9:42 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Tue, Feb 25, 2025 at 8:05 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Hi,
>>>
>>> On 2/26/2025 11:24 AM, Alexei Starovoitov wrote:
>>>> On Sat, Feb 8, 2025 at 2:17 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>>> Hi Toke,
>>>>>
>>>>> On 2/6/2025 11:05 PM, Toke Høiland-Jørgensen wrote:
>>>>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>>>>
>>>>>>> +cc Cody Haas
>>>>>>>
>>>>>>> Sorry for the resend. I sent the reply in the HTML format.
>>>>>>>
>>>>>>> On 2/4/2025 4:28 PM, Hou Tao wrote:
>>>>>>>> Currently, the update of existing element in hash map involves two
>>>>>>>> steps:
>>>>>>>> 1) insert the new element at the head of the hash list
>>>>>>>> 2) remove the old element
>>>>>>>>
>>>>>>>> It is possible that the concurrent lookup operation may fail to find
>>>>>>>> either the old element or the new element if the lookup operation starts
>>>>>>>> before the addition and continues after the removal.
>>>>>>>>
>>>>>>>> Therefore, replacing the two-step update with an atomic update. After
>>>>>>>> the change, the update will be atomic in the perspective of the lookup
>>>>>>>> operation: it will either find the old element or the new element.
>>>> I'm missing the point.
>>>> This "atomic" replacement doesn't really solve anything.
>>>> lookup will see one element.
>>>> That element could be deleted by another thread.
>>>> bucket lock and either two step update or single step
>>>> don't change anything from the pov of bpf prog doing lookup.
>>> The point is that overwriting an existed element may lead to concurrent
>>> lookups return ENOENT as demonstrated by the added selftest and the
>>> patch tried to "fix" that. However, it seems using
>>> hlist_nulls_replace_rcu() for the overwriting update is still not
>>> enough. Because when the lookup procedure found the old element, the old
>>> element may be reusing, the comparison of the map key may fail, and the
>>> lookup procedure may still return ENOENT.
>> you mean l_old == l_new ? I don't think it's possible
>> within htab_map_update_elem(),
>> but htab_map_delete_elem() doing hlist_nulls_del_rcu()
>> then free_htab_elem, htab_map_update_elem, alloc, hlist_nulls_add_head_rcu
>> and just deleted elem is reused to be inserted
>> into another bucket.

No. I mean the following procedure in which the lookup procedure finds
the old element and tries to match its key, one update procedure has
already deleted the old element, and another update procedure is reusing
the old element:

lookup procedure A
A: find the old element (instead of the new old)
                                        
              update procedure B
              B: delete the old element
              update procedure C on the same CPU:
              C: reuse the old element (overwrite its key and insert in
the same bucket)

A: the key is mismatched and return -ENOENT.

It can be reproduced by increasing ctx.loop in the selftest.
>>
>> I'm not sure whether this new hlist_nulls_replace_rcu()
>> primitive works with nulls logic.
>>
>> So back to the problem statement..
>> Are you saying that adding new to a head while lookup is in the middle
>> is causing it to miss an element that
>> is supposed to be updated assuming atomicity of the update?
>> While now update_elem() is more like a sequence of delete + insert?
>>
>> Hmm.
> Yes, exactly that. Because update_elem is actually a delete + insert (actually
> an insert + delete, I think?), it is possible for a concurrent lookup to see no
> element instead of either the old or new value.

Yep.
>
>>> I see. In v2 I will fallback to the original idea: adding a standalone
>>> update procedure for htab of maps in which it will atomically overwrite
>>> the map_ptr just like array of maps does.
>> hold on. is this only for hash-of-maps ?
> I believe this was also replicated for hash as well as hash-of-maps. Cody can
> confirm, or use the reproducer he has to test that case.

The fix for hash-of-maps will be much simpler and the returned map
pointer will be correct. For other types of hash map, beside switching
to hlist_nulls_replace_rcu(),  I think we also need to detect the reuse
of element during the loop: if the element has been reused, the lookup
should restart from the head again. However, even withing the above two
fixes, the value returned by lookup procedure for other types of hash
map may still be incorrect (as shown long time ago [1]), so I think
maybe for other types of map, the atomic update doesn't matter too much.

[1]:
https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
>
>> How that non-atomic update manifested in real production?
>>
> See [1] (in the cover letter for this series, also replicated below).
>
> [1] : https://lore.kernel.org/xdp-newbies/07a365d8-2e66-2899-4298-b8b158a928fa@huaweicloud.com/T/#m06fcd687c6cfdbd0f9b643b227e69b479fc8c2f6



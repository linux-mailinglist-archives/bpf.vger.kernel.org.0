Return-Path: <bpf+bounces-50852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75472A2D570
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC816A07E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745A61A5B86;
	Sat,  8 Feb 2025 10:17:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904023C8D4;
	Sat,  8 Feb 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739009833; cv=none; b=EVmib5FBbwJNknYH1DXn17/rbOZY3tKQiQ8ncATLgvdo4lh0cxghZ6Ca0qNJmPrBS9NZR4m4BvhbMtytoIfj1oAMdQY8j7fvicTBKPDQ13fJ1UtEXS5a2tMOCQckAFK0a28oiHP8dC72lPBbDvDtqeSc8SWCUCRun4IEJRfFeUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739009833; c=relaxed/simple;
	bh=F5uUm7xNthdJlFWPzhW5FgGDAiMNjnlSrHx+bDSldUI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P4d44aMfOej2mQq9WpmhMOK9difONtEWm/leXvHaD312W9XOvJ7QxdmTH/SD1vkZ+4QnsYzQrdn+ImbhVl901Wr4Al9eiLxNrNWWIeLPkgE2qIhvTpxkAJiCziCGlUTm9/ZNRliIgZmxMkxs4BEEtrOrX5IeBHDtF1zwMHqb76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YqmwB59KVz4f3jMB;
	Sat,  8 Feb 2025 18:16:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4AC471A14E2;
	Sat,  8 Feb 2025 18:17:05 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDn8GMbL6dnymX1DA--.5837S2;
	Sat, 08 Feb 2025 18:17:03 +0800 (CST)
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in hash
 map atomically
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 bpf@vger.kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <d191084a-4ab4-8269-640f-1ecf269418a6@huaweicloud.com>
Date: Sat, 8 Feb 2025 18:16:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8734gr3yht.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDn8GMbL6dnymX1DA--.5837S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWrArWDuw4UGF4xXw1kZrb_yoW5Cw45pr
	WrKF1jyF4kAa4j9w4IywsxuFWakrs3try8Jr4DJryrAwn0gr97Arn2ka1SgFyrAr4rJF1F
	qw42qrnIkayjkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi Toke,

On 2/6/2025 11:05 PM, Toke Høiland-Jørgensen wrote:
> Hou Tao <houtao@huaweicloud.com> writes:
>
>> +cc Cody Haas
>>
>> Sorry for the resend. I sent the reply in the HTML format.
>>
>> On 2/4/2025 4:28 PM, Hou Tao wrote:
>>> Currently, the update of existing element in hash map involves two
>>> steps:
>>> 1) insert the new element at the head of the hash list
>>> 2) remove the old element
>>>
>>> It is possible that the concurrent lookup operation may fail to find
>>> either the old element or the new element if the lookup operation starts
>>> before the addition and continues after the removal.
>>>
>>> Therefore, replacing the two-step update with an atomic update. After
>>> the change, the update will be atomic in the perspective of the lookup
>>> operation: it will either find the old element or the new element.
>>>
>>> Signed-off-by: Hou Tao <hotforest@gmail.com>
>>> ---
>>>  kernel/bpf/hashtab.c | 14 ++++++++------
>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index 4a9eeb7aef85..a28b11ce74c6 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>> @@ -1179,12 +1179,14 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>>>  		goto err;
>>>  	}
>>>  
>>> -	/* add new element to the head of the list, so that
>>> -	 * concurrent search will find it before old elem
>>> -	 */
>>> -	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>>> -	if (l_old) {
>>> -		hlist_nulls_del_rcu(&l_old->hash_node);
>>> +	if (!l_old) {
>>> +		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>>> +	} else {
>>> +		/* Replace the old element atomically, so that
>>> +		 * concurrent search will find either the new element or
>>> +		 * the old element.
>>> +		 */
>>> +		hlist_nulls_replace_rcu(&l_new->hash_node, &l_old->hash_node);
>>>  
>>>  		/* l_old has already been stashed in htab->extra_elems, free
>>>  		 * its special fields before it is available for reuse. Also
>>>
>> After thinking about it the second time, the atomic list replacement on
>> the update side is enough to make lookup operation always find the
>> existing element. However, due to the immediate reuse, the lookup may
>> find an unexpected value. Maybe we should disable the immediate reuse
>> for specific map (e.g., htab of maps).
> Hmm, in an RCU-protected data structure, reusing the memory before an
> RCU grace period has elapsed is just as wrong as freeing it, isn't it?
> I.e., the reuse logic should have some kind of call_rcu redirection to
> be completely correct?

Not for all cases. There is SLAB_TYPESAFE_BY_RCU-typed slab. For hash
map, the reuse is also tricky (e.g., the goto again case in
lookup_nulls_elem_raw), however it can not prevent the lookup procedure
from returning unexpected value. I had post a patch set [1] to "fix"
that, but Alexei said it is "a known quirk". Here I am not sure about
whether it is reasonable to disable the reuse for htab of maps only. I
will post a v2 for the patch set.

[1]:
https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
> -Toke



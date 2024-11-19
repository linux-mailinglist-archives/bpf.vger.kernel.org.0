Return-Path: <bpf+bounces-45131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 142119D1CED
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 02:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5045B211B8
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB4552F88;
	Tue, 19 Nov 2024 01:08:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08903481B7
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978511; cv=none; b=K/HGbE1uHuFM/2cdsS8I9cZwxzQJzRSHwT1u4BRvuSsCqvHNuJv81Mdeq6wdKnV6LCqKWZgpXn5PDgVeE7lRMsRw9/kEtTvLOjdZIN9t8QPNfFjm4CaJhUgvypVTvkVdu+G+Oeja21l8fax4/rwAPZysTDfK4laqakYOcVb0hRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978511; c=relaxed/simple;
	bh=mC488IqFJQ4iN3pU1fuE2mjrqOWq/I1+sZfmUD7TgUk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VXAWTAu9Zo0LzdUHdbAIX4HQU3kQT6vHRuPzf442eOxUNMEnQObuIgdX7I3ZF2T41njrbK87G/5Y0aQIGGxOK2pF6oNs72N4uJF3T0yAin41jaDDc7LqQIlHGldpxlxITEYJegFLPRlMlUDSP9nF4c+CJrknJt43kIHoD4C+pyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XsmZh0Z9Nz4f3kkd
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:08:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 759F11A08DC
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:08:25 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCng4cI5TtnnPLACA--.15682S2;
	Tue, 19 Nov 2024 09:08:25 +0800 (CST)
Subject: Re: [PATCH bpf-next 03/10] bpf: Handle BPF_EXIST and BPF_NOEXIST for
 LPM trie
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas.weissschuh@linutronix.de>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-4-houtao@huaweicloud.com>
 <20241118143028-304ae6cf-d766-4604-8663-49887a02e06e@linutronix.de>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1aa2c2ff-ff8a-c936-74cc-5629a8a53282@huaweicloud.com>
Date: Tue, 19 Nov 2024 09:08:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241118143028-304ae6cf-d766-4604-8663-49887a02e06e@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCng4cI5TtnnPLACA--.15682S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kCw48Gry8Gr43AF13urg_yoW8Zw1xpr
	WSkFW5CF4qqF17Cw4Svas5JryYgry0kr4j9FyxJa42yFWvkF93KF1UWw4YgFs8tr4UZrWr
	ZF4YqFyqgryvkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU07PEDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Thomas,

On 11/18/2024 9:39 PM, Thomas Weißschuh wrote:
> On Mon, Nov 18, 2024 at 09:08:01AM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> There is exact match during the update of LPM trie, therefore, add the
>> missed handling for BPF_EXIST and BPF_NOEXIST flags.
> "There is" can be interpreted as "this can be true" and "this will
> always be true".
>
> Maybe:
>
> Add the currently missing handling for the BPF_EXIST and BPF_NOEXIST
> flags, as these can be specified by users.

Will fix it in v2. Thanks.
>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/lpm_trie.c | 23 ++++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
>> index c6f036e3044b..4300bd51ec6e 100644
>> --- a/kernel/bpf/lpm_trie.c
>> +++ b/kernel/bpf/lpm_trie.c
>> @@ -375,6 +375,10 @@ static long trie_update_elem(struct bpf_map *map,
>>  	 * simply assign the @new_node to that slot and be done.
>>  	 */
>>  	if (!node) {
>> +		if (flags == BPF_EXIST) {
>> +			ret = -ENOENT;
>> +			goto out;
>> +		}
>>  		rcu_assign_pointer(*slot, new_node);
>>  		goto out;
>>  	}
>> @@ -383,18 +387,31 @@ static long trie_update_elem(struct bpf_map *map,
>>  	 * which already has the correct data array set.
>>  	 */
>>  	if (node->prefixlen == matchlen) {
>> +		if (!(node->flags & LPM_TREE_NODE_FLAG_IM)) {
>> +			if (flags == BPF_NOEXIST) {
>> +				ret = -EEXIST;
>> +				goto out;
>> +			}
>> +			trie->n_entries--;
>> +		} else if (flags == BPF_EXIST) {
>> +			ret = -ENOENT;
>> +			goto out;
>> +		}
>> +
>>  		new_node->child[0] = node->child[0];
>>  		new_node->child[1] = node->child[1];
>>  
>> -		if (!(node->flags & LPM_TREE_NODE_FLAG_IM))
>> -			trie->n_entries--;
>> -
>>  		rcu_assign_pointer(*slot, new_node);
>>  		free_node = node;
>>  
>>  		goto out;
>>  	}
>>  
>> +	if (flags == BPF_EXIST) {
>> +		ret = -ENOENT;
>> +		goto out;
>> +	}
>> +
>>  	/* If the new node matches the prefix completely, it must be inserted
>>  	 * as an ancestor. Simply insert it between @node and *@slot.
>>  	 */
>> -- 
>> 2.29.2
>>



Return-Path: <bpf+bounces-53777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A371BA5B50E
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 01:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD48F7A8164
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 00:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C61DE2CE;
	Tue, 11 Mar 2025 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B8/xZIoV"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA2A1EB3D
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653974; cv=none; b=XwYeBBf4MZhAgTpUuoLK3c2BBeXNprD07Yb7/AM6FomsIIiNx+0940WFqxkUMIbtlUfYst6kAJdF9tZ6A6on92lW4IrsWE0yWq91n6+K1PgOpKc1KMZJ7vHj+isdFTvNp9ph1yjI3WwrLT4Nc+l80Gdda3HhNu/BereIqdcKH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653974; c=relaxed/simple;
	bh=KfeZPvyIXPU9DBlzbfsIc6bpAtz0C0Wzqm0VtesCYDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPd39Ul0lOh1XNk6i11/PS1EAnMuzLJQTUGeVWZ2VhYxWY5QIFAFejiYWig0UjIBEI8bCV9dUoZ2aCTroyr7iKzpzsXIHfI/dcBo1RJcIHTpmQcaa5mG0tS7l0livr+zoQV+y6xuZAntEbARXWg4jMo56066UE3sEHdonBzLdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B8/xZIoV; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff1562e2-b9c7-4747-9953-75c3e8a60c99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741653970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTfwQ1pfoRoRpyYqPQNeAPPhuLkty3IVLj6VlX3VrQs=;
	b=B8/xZIoVSeT2xwK2zWt9Bouk/oq25Z592Jq7VaWHwkWOatH9mGYysRv5bAFGwxzqb9mWFU
	9k5AVxHl9inqnrWtoBgy74QgtD47mEuGIK+ssHDspwz4b7ri24lAkqyP8Spq85BFN5kEjQ
	J3OEySYIApOUtopu7mGn3Ckj3Y0JwN4=
Date: Mon, 10 Mar 2025 17:46:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?Q?Re=3A_=5BRESEND=5D_Fwd=3A_=5BBUG=5D_list_corruption_in_?=
 =?UTF-8?B?X19icGZfbHJ1X25vZGVfbW92ZSAoKSDjgJAgYnVnIGZvdW5kIGFuZCBzdWdnZXN0?=
 =?UTF-8?Q?ions_for_fixing_it=E3=80=91?=
To: Hou Tao <houtao@huaweicloud.com>, Strforexc yn <strforexc@gmail.com>
Cc: "Alexei Starovoitov," <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <263a77e4-9ba8-f9e2-4aaf-5e2854d487e5@huaweicloud.com>
 <2e946e29-ccd3-3a12-d6b4-d44d778c9223@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <2e946e29-ccd3-3a12-d6b4-d44d778c9223@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/9/25 7:19 PM, Hou Tao wrote:
> Resend due to the HTML part in the reply. Sorry for the inconvenience.
> 
> Hi,
> 
> On 3/5/2025 9:28 PM, Strforexc yn wrote:
>> Hi Maintainers,
>>
>> When using our customized Syzkaller to fuzz the latest Linux kernel,
>> the following crash was triggered.
>> Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.config
>>
>> A kernel BUG was reported due to list corruption during BPF LRU node movement.
>> The issue occurs when the node being moved is the sole element in its list and
>> also the next_inactive_rotation candidate. After moving, the list became empty,
>> but next_inactive_rotation incorrectly pointed to the moved node, causing later
>> operations to corrupt the list.
> 
> The list being pointed by next_inactive_rotation is a doubly linked list
> (aka, struct list_head), therefore, there are at least two nodes in the
> non-empty list: the head of the list and the sole element. When the node
> is the last element in the list, next_inactive_rotation will be pointed
> to the head of the list after the move. So I don't think the analysis
> and the fix below is correct.
>>
>> Here is my fix suggestion:
>> The fix checks if the node was the only element before adjusting
>> next_inactive_rotation. If so, it sets the pointer to NULL, preventing invalid
>> access.
>>
>> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
>> index XXXXXXX..XXXXXXX 100644
>> --- a/kernel/bpf/bpf_lru_list.c
>> +++ b/kernel/bpf/bpf_lru_list.c
>> @@ -119,8 +119,13 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
>>    * move the next_inactive_rotation pointer also.
>>    */
>>    if (&node->list == l->next_inactive_rotation)
>> - l->next_inactive_rotation = l->next_inactive_rotation->prev;
>> -
>> + {
>> + if (l->next_inactive_rotation->prev == &node->list) {

I don't think it is the right fix. I don't see how both this new "if" and the 
above "if (&node->list == l->next_inactive_rotation)" can be true together. If 
it fixed the issue, the root cause should be somewhere else.

I tried to simulate a one node inactive list and then rotate to the active list. 
I cannot reproduce it.

Can you share the syzkaller reproducer that you have used to test this fix?

Is it something that you have seen recently and something that you can bisect?

>> + l->next_inactive_rotation = NULL;
>> + } else {
>> + l->next_inactive_rotation = l->next_inactive_rotation->prev;
>> + }
>> + }
>>    list_move(&node->list, &l->lists[tgt_type]);
>>   }
>>
>> -- 2.34.1 Our knowledge of the kernel is somewhat limited, and we'd
>> appreciate it if you could determine if there is such an issue. If
>> this issue doesn't have an impact, please ignore it ☺. If you fix this
>> issue, please add the following tag to the commit: Reported-by:
>> Zhizhuo Tang strforexctzzchange@foxmail.com, Jianzhou Zhao
>> xnxc22xnxc22@qq.com, Haoran Liu <cherest_san@163.com> Last is my
>> report： vmalloc memory list_add corruption. next->prev should be prev
>> (ffffe8ffac433e40), but was 50ffffe8ffac433e. (next=ffffe8ffac433e41).
>> ------------[ cut here ]------------ kernel BUG at
>> lib/list_debug.c:29! Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> PTI CPU: 0 UID: 0 PID: 14524 Comm: syz.0.285 Not tainted
>> 6.14.0-rc5-00013-g99fa936e8e4f #1 Hardware name: QEMU Standard PC
>> (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014 RIP:
>> 0010:__list_add_valid_or_report+0xfc/0x1a0 lib/list_debug.c:29
> 
> I suspect that the content of lists[BPF_LRU_LIST_T_ACTIVE].next has been
> corrupted, because the pointer itself should be at least 8-bytes
> aligned, but its value is 0xffffe8ffac433e41. Also only the last bit of

It is more puzzling. Instead of the inactive list, the active list's head is 
corrupted in the last bit of its next. I don't see the lru code path is reusing 
the last bit of the next pointer. It is not a hlist_nulls... We need the 
syzkaller reproducer to understand it better.

> the next pointer is different with the address of
> list[BPF_LRU_LIST_T_ACTIVE] itelse (aka 0xffffe8ffac433e40).


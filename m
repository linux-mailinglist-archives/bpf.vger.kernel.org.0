Return-Path: <bpf+bounces-39311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867D9718ED
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 14:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BAA283E79
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C81F1B5EDE;
	Mon,  9 Sep 2024 12:08:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE7B29CE8
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883699; cv=none; b=Z18lj1XAeods03DXk3XBtPGKQxclroa9EpzLg721L9b194itnZinElJZpVdK7biJwid3iS65NBYF0+lhti/ODRfZnbXqvRPmDO0vMI/jfN1KT8mGQe/icvIlHcyN2LWUwDuVmxeaFT9gN02a7hULqPYcgPkhctwor0yAQy3c3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883699; c=relaxed/simple;
	bh=B9eaUrfVHfqM4h4DnAyw7ffTPPKszgOqg7jIZqgIWNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bocPFL8FcABx+/Wyij0LMQ1LK0tQ5yNjiJnSj+atHcFml6wiD2JzSIbKdUpfo9qE5Amg9nIzpm+Vz83RzBSGe0CiXk67Jsv+hD3MnRFuQ4oNhvYYeq0Xmt/VBAnsBg2qZLBVtrHLIlFkHHrItZa8hJxS2aEx61eIazfpO+4MI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2QZf5tdtz4f3jkV
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 20:07:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5C9A01A018D
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 20:08:05 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgA3Yy8k5d5miw5CAw--.54961S2;
	Mon, 09 Sep 2024 20:08:05 +0800 (CST)
Message-ID: <0fc08a50-8812-4932-bb85-9d81cedf142a@huaweicloud.com>
Date: Mon, 9 Sep 2024 20:08:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 eddyz87@gmail.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240901133856.64367-1-leon.hwang@linux.dev>
 <20240901133856.64367-3-leon.hwang@linux.dev>
 <fb6ed3e4-7ef2-4b7d-af7e-bf928d835fe9@linux.dev>
 <64c3f174-1dfb-409b-bc11-d7379c09e0ae@huaweicloud.com>
 <cac838d2-9590-4bef-bb58-b56f97881fde@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <cac838d2-9590-4bef-bb58-b56f97881fde@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3Yy8k5d5miw5CAw--.54961S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8ur15ZrW8JFW7AF1fWFg_yoWrKF15pF
	y8X3ZxJFZ8Xr92yw42qr40qryayw4kJwn8Xr95W34rAr9FvrnF9FWUWryj9F98ur4rGr1j
	qr1jgrZ3urW8Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 9/9/2024 6:38 PM, Leon Hwang wrote:
> 
> 
> On 9/9/24 17:02, Xu Kuohai wrote:
>> On 9/8/2024 9:01 PM, Leon Hwang wrote:
>>>
>>>
>>> On 1/9/24 21:38, Leon Hwang wrote:
>>>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the same
>>>> issue happens on arm64, too.
>>>>
>>>> For example:
>>>>
>>>> tc_bpf2bpf.c:
>>>>
>>>> // SPDX-License-Identifier: GPL-2.0
>>>> \#include <linux/bpf.h>
>>>> \#include <bpf/bpf_helpers.h>
>>>>
>>>> __noinline
>>>> int subprog_tc(struct __sk_buff *skb)
>>>> {
>>>>      return skb->len * 2;
>>>> }
>>>>
>>>> SEC("tc")
>>>> int entry_tc(struct __sk_buff *skb)
>>>> {
>>>>      return subprog(skb);
>>>> }
>>>>
>>>> char __license[] SEC("license") = "GPL";
>>>>
>>>> tailcall_bpf2bpf_hierarchy_freplace.c:
>>>>
>>>> // SPDX-License-Identifier: GPL-2.0
>>>> \#include <linux/bpf.h>
>>>> \#include <bpf/bpf_helpers.h>
>>>>
>>>> struct {
>>>>      __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>>>>      __uint(max_entries, 1);
>>>>      __uint(key_size, sizeof(__u32));
>>>>      __uint(value_size, sizeof(__u32));
>>>> } jmp_table SEC(".maps");
>>>>
>>>> int count = 0;
>>>>
>>>> static __noinline
>>>> int subprog_tail(struct __sk_buff *skb)
>>>> {
>>>>      bpf_tail_call_static(skb, &jmp_table, 0);
>>>>      return 0;
>>>> }
>>>>
>>>> SEC("freplace")
>>>> int entry_freplace(struct __sk_buff *skb)
>>>> {
>>>>      count++;
>>>>      subprog_tail(skb);
>>>>      subprog_tail(skb);
>>>>      return count;
>>>> }
>>>>
>>>> char __license[] SEC("license") = "GPL";
>>>>
>>>> The attach target of entry_freplace is subprog_tc, and the tail callee
>>>> in subprog_tail is entry_tc.
>>>>
>>>> Then, the infinite loop will be entry_tc -> entry_tc ->
>>>> entry_freplace ->
>>>> subprog_tail --tailcall-> entry_tc, because tail_call_cnt in
>>>> entry_freplace will count from zero for every time of entry_freplace
>>>> execution.
>>>>
>>>> This patch fixes the issue by avoiding touching tail_call_cnt at
>>>> prologue when it's subprog or freplace prog.
>>>>
>>>> Then, when freplace prog attaches to entry_tc, it has to initialize
>>>> tail_call_cnt and tail_call_cnt_ptr, because its target is main prog and
>>>> its target's prologue hasn't initialize them before the attach hook.
>>>>
>>>> So, this patch uses x7 register to tell freplace prog that its target
>>>> prog is main prog or not.
>>>>
>>>> Meanwhile, while tail calling to a freplace prog, it is required to
>>>> reset x7 register to prevent re-initializing tail_call_cnt at freplace
>>>> prog's prologue.
>>>>
>>>> Fixes: 1c123c567fb1 ("bpf: Resolve fext program type when checking
>>>> map compatibility")
>>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>>> ---
>>>>    arch/arm64/net/bpf_jit_comp.c | 44 +++++++++++++++++++++++++++++++----
>>>>    1 file changed, 39 insertions(+), 5 deletions(-)
>>>>
>>> Hi Puranjay and Kuohai,
>>>
>>> As it's not recommended to introduce arch_bpf_run(), this is my approach
>>> to fix the niche case on arm64.
>>>
>>> Do you have any better idea to fix it?
>>>
>>
>> IIUC, the recommended appraoch is to teach verifier to reject the
>> freplace + tailcall combination. If this combiation is allowed, we
>> will face more than just this issue. For example, what happens if
>> a freplace prog is attached to tail callee? The freplace prog is not
>> reachable through the tail call, right?
>>
> 
> It's to reject the freplace + tailcall combination partially, see "bpf,
> x64: Fix tailcall infinite loop caused by freplace". (Oh, I should
> separate the rejection to a standalone patch.)
> It rejects the case that freplace prog has tailcall and its attach
> target has no tailcall.
> 
> As for your example, it depends on:
> 
>                  freplace       target    reject?
> Has tailcall?     YES            NO        YES
> Has tailcall?     YES            YES       NO
> Has tailcall?     NO             YES       NO
> Has tailcall?     NO             YES       NO
> 
> Then, freplace prog can be tail callee always. I haven't seen any bad
> case when freplace prog is tail callee.
>

Here is a concrete case. prog1 tail calls prog2, and prog2_new is
attached to prog2 via freplace.

SEC("tc")
int prog1(struct __sk_buff *skb)
{
         bpf_tail_call_static(skb, &progs, 0); // tail call prog2
         return 0;
}

SEC("tc")
int prog2(struct __sk_buff *skb)
{
         return 0;
}

SEC("freplace")
int prog2_new(struct __sk_buff *skb) // target is prog2
{
         return 0;
}

In this case, prog2_new is not reachable, since the tail call
target in prog2 is start address of prog2  + TAIL_CALL_OFFSET,
which locates behind freplace/fentry callsite of prog2.

> I'm not planning to disable freplace + tailcall combination totally,
> because I use this combination in an in-house XDP project of my company.
> 
> Thanks,
> Leon



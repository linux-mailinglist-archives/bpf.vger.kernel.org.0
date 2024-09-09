Return-Path: <bpf+bounces-39297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192929712CE
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 11:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA862285354
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C60A1B29B3;
	Mon,  9 Sep 2024 09:02:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154511AC88E
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872557; cv=none; b=fBFmT6GCGfYuUR/JlKt27o+FnE1K9k+6UoatLsHMgsyUqGOPRlMp18qQ3CuK0+69aazvl7oZc/Wda30YyTQOoNNded2fiL5RG1nREOdmkxio78SCoT5g46zM1bRJ1oTcO+2KESrTsOv5H6yTajzIQ5vXkgSpMv7ketFilBJseDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872557; c=relaxed/simple;
	bh=FCevUX17CVGwEO9ENeJMsVxNoZjIFtxsray4RsGn8Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Db5g48NJ54cqLfhMxvHAXpDmTFDicV397fo3dLl9OOSwLbVWMiJEzwOJMawE1PaiGTWrfeuf+12j8lhabgwOBSlRE5K+27ePDdDUtUNdNqXVNnoatcKZKs781ia3AS+YzhSzPjx1pTFqn5iMbOCqtJV4F7iHJhn7TVxwY9DIYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X2LSL2HRVz4f3jsD
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 17:02:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 474DA1A0568
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 17:02:25 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgCXGV+fud5m4l5MAw--.63835S2;
	Mon, 09 Sep 2024 17:02:25 +0800 (CST)
Message-ID: <64c3f174-1dfb-409b-bc11-d7379c09e0ae@huaweicloud.com>
Date: Mon, 9 Sep 2024 17:02:28 +0800
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
 xukuohai@huaweicloud.com, eddyz87@gmail.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
References: <20240901133856.64367-1-leon.hwang@linux.dev>
 <20240901133856.64367-3-leon.hwang@linux.dev>
 <fb6ed3e4-7ef2-4b7d-af7e-bf928d835fe9@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <fb6ed3e4-7ef2-4b7d-af7e-bf928d835fe9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCXGV+fud5m4l5MAw--.63835S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8Zw4kZF18GFyDtw1rXrb_yoW5Cryrpa
	47uanxKF4DXr9rtw4aqw4xZFWavw4kXrn8Jr93Ww1Fyr92qr929FWUGFWY9FZxur1jkw1j
	vF129FZ5CrW8Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 9/8/2024 9:01 PM, Leon Hwang wrote:
> 
> 
> On 1/9/24 21:38, Leon Hwang wrote:
>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the same
>> issue happens on arm64, too.
>>
>> For example:
>>
>> tc_bpf2bpf.c:
>>
>> // SPDX-License-Identifier: GPL-2.0
>> \#include <linux/bpf.h>
>> \#include <bpf/bpf_helpers.h>
>>
>> __noinline
>> int subprog_tc(struct __sk_buff *skb)
>> {
>> 	return skb->len * 2;
>> }
>>
>> SEC("tc")
>> int entry_tc(struct __sk_buff *skb)
>> {
>> 	return subprog(skb);
>> }
>>
>> char __license[] SEC("license") = "GPL";
>>
>> tailcall_bpf2bpf_hierarchy_freplace.c:
>>
>> // SPDX-License-Identifier: GPL-2.0
>> \#include <linux/bpf.h>
>> \#include <bpf/bpf_helpers.h>
>>
>> struct {
>> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>> 	__uint(max_entries, 1);
>> 	__uint(key_size, sizeof(__u32));
>> 	__uint(value_size, sizeof(__u32));
>> } jmp_table SEC(".maps");
>>
>> int count = 0;
>>
>> static __noinline
>> int subprog_tail(struct __sk_buff *skb)
>> {
>> 	bpf_tail_call_static(skb, &jmp_table, 0);
>> 	return 0;
>> }
>>
>> SEC("freplace")
>> int entry_freplace(struct __sk_buff *skb)
>> {
>> 	count++;
>> 	subprog_tail(skb);
>> 	subprog_tail(skb);
>> 	return count;
>> }
>>
>> char __license[] SEC("license") = "GPL";
>>
>> The attach target of entry_freplace is subprog_tc, and the tail callee
>> in subprog_tail is entry_tc.
>>
>> Then, the infinite loop will be entry_tc -> entry_tc -> entry_freplace ->
>> subprog_tail --tailcall-> entry_tc, because tail_call_cnt in
>> entry_freplace will count from zero for every time of entry_freplace
>> execution.
>>
>> This patch fixes the issue by avoiding touching tail_call_cnt at
>> prologue when it's subprog or freplace prog.
>>
>> Then, when freplace prog attaches to entry_tc, it has to initialize
>> tail_call_cnt and tail_call_cnt_ptr, because its target is main prog and
>> its target's prologue hasn't initialize them before the attach hook.
>>
>> So, this patch uses x7 register to tell freplace prog that its target
>> prog is main prog or not.
>>
>> Meanwhile, while tail calling to a freplace prog, it is required to
>> reset x7 register to prevent re-initializing tail_call_cnt at freplace
>> prog's prologue.
>>
>> Fixes: 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>   arch/arm64/net/bpf_jit_comp.c | 44 +++++++++++++++++++++++++++++++----
>>   1 file changed, 39 insertions(+), 5 deletions(-)
>>
> Hi Puranjay and Kuohai,
> 
> As it's not recommended to introduce arch_bpf_run(), this is my approach
> to fix the niche case on arm64.
> 
> Do you have any better idea to fix it?
>

IIUC, the recommended appraoch is to teach verifier to reject the
freplace + tailcall combination. If this combiation is allowed, we
will face more than just this issue. For example, what happens if
a freplace prog is attached to tail callee? The freplace prog is not
reachable through the tail call, right?

> Thanks,
> Leon
> 
> 



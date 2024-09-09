Return-Path: <bpf+bounces-39305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A897157F
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4331F23B61
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 10:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40721B3B06;
	Mon,  9 Sep 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k9W0ZSrJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3DE2AD00
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878351; cv=none; b=aEm/96m78vl9UTyCT6eH2I2vH8MmcY9cWBwjFuDgCZYgVixIMvfDORoxEcLNYOcFrkUI15DOV2uFj/5BVtDgEvH+8534FwykYWleBEcTxpa9u9Tn/zyGJ1jq7xrLeaqGj2UotZjqCFdhUe9MQ6HdiuNTtHMZHUkPBhjBCY3GTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878351; c=relaxed/simple;
	bh=1RSRnXYpWPPgP17Ij576TqSv/DpIP3OSs19czS1hNI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ha2/qwwsf3OP1qtLSQdImdBIv9mv64ppcClU4fMH4b3MJaXM1eEZ6pY/3s202agd5i0qlDdlk5udjfbsbZKx9GOSCVbk+/Rk1I0re3OKSJIi+hXbcOJAx8/QpCBeOOyul9QJXAB5NvQ5Cpz/GypjDF1uvLQxZOrm5uOiB713vVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k9W0ZSrJ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cac838d2-9590-4bef-bb58-b56f97881fde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725878346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Olpa6AUS4EwrY5DS2KYpBJ0Hfx5jyh98m0Wyc9/Pzic=;
	b=k9W0ZSrJzEjC8WYqLCCjBJ7J21fVBLW1WFT+c0D6ral++xMGX0kUYfS7GkEFEhxs34NW5l
	IA1DrsB2M3uDbGvLro4qykQxUKLisM44k9gddV1a98LjlHLyYfZyJHOQCK5rdZxg8SkkrW
	sLCBgGycS3CQIKqK8egj+v8I9rhjo3A=
Date: Mon, 9 Sep 2024 18:38:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 eddyz87@gmail.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240901133856.64367-1-leon.hwang@linux.dev>
 <20240901133856.64367-3-leon.hwang@linux.dev>
 <fb6ed3e4-7ef2-4b7d-af7e-bf928d835fe9@linux.dev>
 <64c3f174-1dfb-409b-bc11-d7379c09e0ae@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <64c3f174-1dfb-409b-bc11-d7379c09e0ae@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/9/24 17:02, Xu Kuohai wrote:
> On 9/8/2024 9:01 PM, Leon Hwang wrote:
>>
>>
>> On 1/9/24 21:38, Leon Hwang wrote:
>>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the same
>>> issue happens on arm64, too.
>>>
>>> For example:
>>>
>>> tc_bpf2bpf.c:
>>>
>>> // SPDX-License-Identifier: GPL-2.0
>>> \#include <linux/bpf.h>
>>> \#include <bpf/bpf_helpers.h>
>>>
>>> __noinline
>>> int subprog_tc(struct __sk_buff *skb)
>>> {
>>>     return skb->len * 2;
>>> }
>>>
>>> SEC("tc")
>>> int entry_tc(struct __sk_buff *skb)
>>> {
>>>     return subprog(skb);
>>> }
>>>
>>> char __license[] SEC("license") = "GPL";
>>>
>>> tailcall_bpf2bpf_hierarchy_freplace.c:
>>>
>>> // SPDX-License-Identifier: GPL-2.0
>>> \#include <linux/bpf.h>
>>> \#include <bpf/bpf_helpers.h>
>>>
>>> struct {
>>>     __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>>>     __uint(max_entries, 1);
>>>     __uint(key_size, sizeof(__u32));
>>>     __uint(value_size, sizeof(__u32));
>>> } jmp_table SEC(".maps");
>>>
>>> int count = 0;
>>>
>>> static __noinline
>>> int subprog_tail(struct __sk_buff *skb)
>>> {
>>>     bpf_tail_call_static(skb, &jmp_table, 0);
>>>     return 0;
>>> }
>>>
>>> SEC("freplace")
>>> int entry_freplace(struct __sk_buff *skb)
>>> {
>>>     count++;
>>>     subprog_tail(skb);
>>>     subprog_tail(skb);
>>>     return count;
>>> }
>>>
>>> char __license[] SEC("license") = "GPL";
>>>
>>> The attach target of entry_freplace is subprog_tc, and the tail callee
>>> in subprog_tail is entry_tc.
>>>
>>> Then, the infinite loop will be entry_tc -> entry_tc ->
>>> entry_freplace ->
>>> subprog_tail --tailcall-> entry_tc, because tail_call_cnt in
>>> entry_freplace will count from zero for every time of entry_freplace
>>> execution.
>>>
>>> This patch fixes the issue by avoiding touching tail_call_cnt at
>>> prologue when it's subprog or freplace prog.
>>>
>>> Then, when freplace prog attaches to entry_tc, it has to initialize
>>> tail_call_cnt and tail_call_cnt_ptr, because its target is main prog and
>>> its target's prologue hasn't initialize them before the attach hook.
>>>
>>> So, this patch uses x7 register to tell freplace prog that its target
>>> prog is main prog or not.
>>>
>>> Meanwhile, while tail calling to a freplace prog, it is required to
>>> reset x7 register to prevent re-initializing tail_call_cnt at freplace
>>> prog's prologue.
>>>
>>> Fixes: 1c123c567fb1 ("bpf: Resolve fext program type when checking
>>> map compatibility")
>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>> ---
>>>   arch/arm64/net/bpf_jit_comp.c | 44 +++++++++++++++++++++++++++++++----
>>>   1 file changed, 39 insertions(+), 5 deletions(-)
>>>
>> Hi Puranjay and Kuohai,
>>
>> As it's not recommended to introduce arch_bpf_run(), this is my approach
>> to fix the niche case on arm64.
>>
>> Do you have any better idea to fix it?
>>
> 
> IIUC, the recommended appraoch is to teach verifier to reject the
> freplace + tailcall combination. If this combiation is allowed, we
> will face more than just this issue. For example, what happens if
> a freplace prog is attached to tail callee? The freplace prog is not
> reachable through the tail call, right?
> 

It's to reject the freplace + tailcall combination partially, see "bpf,
x64: Fix tailcall infinite loop caused by freplace". (Oh, I should
separate the rejection to a standalone patch.)
It rejects the case that freplace prog has tailcall and its attach
target has no tailcall.

As for your example, it depends on:

                freplace       target    reject?
Has tailcall?     YES            NO        YES
Has tailcall?     YES            YES       NO
Has tailcall?     NO             YES       NO
Has tailcall?     NO             YES       NO

Then, freplace prog can be tail callee always. I haven't seen any bad
case when freplace prog is tail callee.

I'm not planning to disable freplace + tailcall combination totally,
because I use this combination in an in-house XDP project of my company.

Thanks,
Leon


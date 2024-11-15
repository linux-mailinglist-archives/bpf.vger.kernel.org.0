Return-Path: <bpf+bounces-44929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865239CD6B7
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 06:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1486BB247EB
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 05:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08357176AB5;
	Fri, 15 Nov 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OD+nDQay"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336C1547CC
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649824; cv=none; b=BJbYhRxKTGulvh7teV6o4Eus9p/T5U2uIOXCNF2OQvRiKyFnT+LQVJsA8tGBWd1LYtCuJM4/m7JvfzNua4PwBNPL1mw6uOM830QtTv32M3Yzv2zBAJ0tqq3nUXXICjyeUA67dcR0Od0WzXBmDEq1okBaMsuj/YuRzqwzIqt3ZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649824; c=relaxed/simple;
	bh=jPTKJ/KqFOsNBliyCLELBhHbZJbXXHgYniZ8d1WrSNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SC0As5qfhTJBCHWUgcuBobHkqU1NI2UMliMDcwisFMwfYvBni69+oRfSW0Qi1GVgfWE4y1K9AJAD0KM0ZdaSKuVYIJ86DWsOGAmoaGWs8ld6c7kWe9cJMryK7mIwJYPy/FnmmUL1hj/lOZcnt0YHjtb28ONWbKPQeeVcaQeMzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OD+nDQay; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3fca10b1-8445-4919-96fd-b6a67982f1d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731649820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hO0v4EuObITGpxOJ3mNTTYv8nNKmylKqwOWoKnuAKQ=;
	b=OD+nDQayhx8rw6jGZ+rNsYS80nzjspdd4rAadq/kpnbiia5q37XDUM/BH7UNNVoBBUPjPo
	9eXc38m1ZW/AiRFG2l/369x5aFmMB2wKq/HNgm5Fu0ppWbWZVkm4PUnITLIIr/46gZKDVi
	+uH4BOBF7hyLE+cPqSz/BQGUeY+v5RI=
Date: Thu, 14 Nov 2024 21:50:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add necessary migrate_{disable,enable} in
 bpf arena
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20241115035257.2181074-1-yonghong.song@linux.dev>
 <CAADnVQJpvMjD3B4BvDZZybPvhakMOxjOAo_HmVOnmvkgTKPOiw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJpvMjD3B4BvDZZybPvhakMOxjOAo_HmVOnmvkgTKPOiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/14/24 9:08 PM, Alexei Starovoitov wrote:
> On Thu, Nov 14, 2024 at 7:53 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> When running bpf selftest (./test_progs -j), the following warnings
>> showed up:
>>
>>    $ ./test_progs -t arena_atomics
>>    ...
>>    BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u19:0/12501
>>    caller is bpf_mem_free+0x128/0x330
>>    ...
>>    Call Trace:
>>     <TASK>
>>     dump_stack_lvl
>>     check_preemption_disabled
>>     bpf_mem_free
>>     range_tree_destroy
>>     arena_map_free
>>     bpf_map_free_deferred
>>     process_scheduled_works
>>     ...
>>
>> For selftests arena_htab and arena_list, similar smp_process_id() BUGs are
>> dumped, and the following are two stack trace:
>>
>>     <TASK>
>>     dump_stack_lvl
>>     check_preemption_disabled
>>     bpf_mem_alloc
>>     range_tree_set
>>     arena_map_alloc
>>     map_create
>>     ...
>>
>>     <TASK>
>>     dump_stack_lvl
>>     check_preemption_disabled
>>     bpf_mem_alloc
>>     range_tree_clear
>>     arena_vm_fault
>>     do_pte_missing
>>     handle_mm_fault
>>     do_user_addr_fault
>>     ...
>>
>> Adding migrate_{disable,enable}() around related arena_*() calls can fix the issue.
>>
>> Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/arena.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 3e1dfe349ced..9a55d18032a4 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>> @@ -134,7 +134,9 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>>          INIT_LIST_HEAD(&arena->vma_list);
>>          bpf_map_init_from_attr(&arena->map, attr);
>>          range_tree_init(&arena->rt);
>> +       migrate_disable();
>>          range_tree_set(&arena->rt, 0, attr->max_entries);
>> +       migrate_enable();
>>          mutex_init(&arena->lock);
>>
>>          return &arena->map;
>> @@ -185,7 +187,9 @@ static void arena_map_free(struct bpf_map *map)
>>          apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
>>                                       KERN_VM_SZ - GUARD_SZ, existing_page_cb, NULL);
>>          free_vm_area(arena->kern_vm);
>> +       migrate_disable();
>>          range_tree_destroy(&arena->rt);
>> +       migrate_enable();
>>          bpf_map_area_free(arena);
>>   }
>>
>> @@ -276,7 +280,9 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>                  /* User space requested to segfault when page is not allocated by bpf prog */
>>                  return VM_FAULT_SIGSEGV;
>>
>> +       migrate_disable();
>>          ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
>> +       migrate_enable();
> Thanks for the fix.
> I thought I had all debug configs enabled :(
>
> Could you please add migrate_disable/enable into range_tree.c
> around bpf_mem_alloc/free calls instead ?
> range_tree user shouldn't need to worry about this internal details.

Sure. Will send v2 shortly.

>
> pw-bot: cr



Return-Path: <bpf+bounces-20543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423B83FDC1
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 06:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59BD283CC7
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 05:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971BF446C4;
	Mon, 29 Jan 2024 05:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hqoIOg4p"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38FA446A3
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706506422; cv=none; b=qn16vN6Mqhl1EXHwUgfqILGQgl0GZdl4lhMcfpH3v5S20SYfYHUX7Rpfi/zRZaKEyIf4PAe6bQnDg0mm8rY3cpoNxAL25UoevkyTJZfdXwU6W1ALfTsODHZnR6io5V5mdDgx3hL0puaFDbmR+m37cxiK+yEakiryJxuLs+npoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706506422; c=relaxed/simple;
	bh=CnaOGwQTfPc2sm02KmO/bl3Cn4hTT0O2pUJp/EQwwrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkSWPFUDqkmjbNnBlWlwOdpQ9mR2gbS9Ebcxstbm/Ont/XQh/1rv540vXhtw8ZSdjzvKwtoqYYkKzUgHLa9LdoYGd7IUG035tlNWEEG8X0vFc9UJ8vp+Nh0e7yZ1gKBLXEHTApMkVTDKVJFPtHtSScXri4R3/A0XxUfVuQOwEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hqoIOg4p; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <04efa2a3-ca81-42c3-883f-5b91917f2bde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706506416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aYxlxwbwkWDNGPf5iQeUyMuXxHM7/7mk1aJ2GFzbxs=;
	b=hqoIOg4ptBecYGkMkpwNMvg6NydSswS8iTAVtVFcBLaknrBR9yKkT2IE839LpPp2bzuKLg
	teCYUNVQZ+fPlDgW49D+qq08nFy01szQJDTHnE2RXO7QIXZf9G3ZEciQc/C9rR4kbrRSDL
	FU33NBZoT49vkzs3dxP4hJfVawjs7dU=
Date: Sun, 28 Jan 2024 21:33:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF selftests and strict aliasing
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
 david.faust@oracle.com, cupertino.miranda@oracle.com,
 Yonghong Song <yhs@meta.com>
References: <87plxmsg37.fsf@oracle.com>
 <b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev> <87a5opskz0.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87a5opskz0.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/28/24 4:25 AM, Jose E. Marchesi wrote:
>> On 1/27/24 11:59 AM, Jose E. Marchesi wrote:
>>> Hello.
>>> The following BPF selftests perform type-punning:
>>>
>>>     progs/bind4_prog.c
>>>     136 |         user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[0] << 0;
>>>
>>>     progs/bind6_prog.c
>>>     149 |                 user_ip6 |= ((volatile __u16 *)&ctx->user_ip6[i])[0] << 0;
>>>
>>>     progs/dynptr_fail.c
>>>     549 |         val = *(int *)&ptr;
>>>
>>>     progs/linked_list_fail.c
>>>     318 |         return *(int *)&f->head;
>>>     329 |         *(int *)&f->head = 0;
>>>     338 |         f = bpf_obj_new(typeof(*f));
>>>     341 |         return *(int *)&f->node2;
>>>     349 |         f = bpf_obj_new(typeof(*f));
>>>     352 |         *(int *)&f->node2 = 0;
>>>
>>>     progs/map_kptr_fail.c
>>>      34 |         *(u32 *)&v->unref_ptr = 0;
>>>
>>>     progs/syscall.c
>>>     172 |         attr->map_id = ((struct bpf_map *)&outer_array_map)->id;
>>>
>>>     progs/test_pkt_md_access.c
>>>      13 |                 TYPE tmp = *(volatile TYPE *)&skb->FIELD;               \
>>>
>>>     progs/test_sk_lookup.c
>>>      31 |         (((__u16 *)&(value))[LSE_INDEX((index), sizeof(value) / 2)])
>>>     427 |         val_u32 = *(__u32 *)&ctx->remote_port;
>>>
>>>     progs/timer_crash.c
>>>      38 |         *(void **)&value = (void *)0xdeadcaf3;
>>>
>>> This results in GCC warnings with -Wall but violating strict aliasing
>>> may also result in the compiler incorrectly optimizing something.
>>>
>>> There are some alternatives to deal with this:
>>>
>>> a) To rewrite the tests to conform to strict aliasing rules.
>>>
>>> b) To build these tests using -fno-strict-aliasing to make sure the
>>>      compiler will not rely on strict aliasing while optimizing.
>>>
>>> c) To add pragmas to these test files to avoid the warning:
>>>      _Pragma("GCC diagnostic ignored \"-Wstrict-aliasing\"")
>>>
>>> I think b) is probably the best way to go, because it will avoid the
>>> warnings, will void potential problems with optimizations triggered by
>>> strict aliasing, and will not require to rewrite the tests.
>> I tried with latest clang with -fstrict-aliasing:
>>
>> [~/work/bpf-next/tools/testing/selftests/bpf (master)]$ cat run.sh
>> clang -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian
>> -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include \
>>    -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi
>>    -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include
>>    -idirafter /home/yhs/work/llvm-project/llvm/build.19/install/lib/clang/19/include
>>    -idirafter /usr/local/include -idirafter /usr/include   -Wno-compare-distinct-pointer-types
>>    -DENABLE_ATOMICS_TESTS -O2 -fstrict-aliasing --target=bpf -c progs/bind4_prog.c -mcpu=v3
>>    -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/bind4_prog.bpf.o
>> [~/work/bpf-next/tools/testing/selftests/bpf (master)]$ ./run.sh
>> [~/work/bpf-next/tools/testing/selftests/bpf (master)]$
>>
>> I does not have compilation failure. I am wondering why -fstrict-aliasing won't have warning in clang side
>> but have warning in gcc side.
>> Your suggestion 'b' seems okay or we could even add -fno-strict-aliasing into common compilation flags,
>> but I would like to understand more about -fstrict-aliasing difference between gcc and clang.
> It may be that GCC is just better than clang detecting and reporting
> strict aliasing rules violations.  Or it may be that clang doesn't
> assume strict aliasing when optimizing with the specified level.
>
> In any case:
>
>    progs/bind4_progs.c
>      type punning from __u32 to __u16.  These are not compatible types.
>
>    progs/bind6
>      type punning from __u32 to __u16.  These are not compatible types.
>
>    progs/dynptr_fail.c
>      type punning from struct bpf_dynptr to int.  These are not
>      compatible types.

I tried below example with the above prog/dynptr_fail.c case with gcc 11.4
for native x86 target and didn't trigger the warning. Maybe this requires
latest gcc? Or test C file is not sufficient enough to trigger the warning?

[~/tmp1]$ cat t.c
struct t {
   char a;
   short b;
   int c;
};
void init(struct t *);
long foo() {
   struct t dummy;
   init(&dummy);
   return *(int *)&dummy;
}
[~/tmp1]$ gcc -Wall -Werror -O2 -g -Wno-compare-distinct-pointer-types -c t.c
[~/tmp1]$ gcc --version
gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2)
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

>
>    progs/linked_list_fail.c
>      type punning from struct bpf_list_head to int.  These are not
>      compatible types.
>
>    progs/map_kptr_fail.c
>      type punning from struct prog_test_ref_kfunc to __u32.  These are
>      not compatible types.
>
>    ...
>
> And so on.
>
>>> Provided [1] gets applied, I can prepare a patch that adds the following
>>> to selftests/bpf/Makefile:
>>>
>>>     progs/bin4_prog.c-CFLAGS := -fno-strict-aliasing
>>>     progs/bind6_prog.c-CFLAGS := -fno-strict-aliasing
>>>     progs/dynptr_fail.cw-CFLAGS := -fno-strict-aliasing
>>>     progs/linked_list_fail.c-CFLAGS := -fno-strict-aliasing
>>>     progs/map_kptr_fail.c-CFLAGS := -fno-strict-aliasing
>>>     progs/syscall.c-CFLAGS := -fno-strict-aliasing
>>>     progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
>>>     progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
>>>     progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
>>>
>>> [1] https://lore.kernel.org/bpf/20240127100702.21549-1-jose.marchesi@oracle.com/T/#u
>>>


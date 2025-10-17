Return-Path: <bpf+bounces-71254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E733BEB63E
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E8FA4E8646
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943772FFDC8;
	Fri, 17 Oct 2025 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUr+wZZP"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2E3BB5A
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729441; cv=none; b=XLqPjoWkcT905zMg10u8g272T15NOoKlXOaowu9Z557T+L9y3UtjzJHWBtosFtkW5QZg9XTn4bRIgBhGP4+nicaoRABYdpEZnZ/x9tu9PLNA6OmuzuHarIQOWcETxY3yMv+03+5zPeID3LlMF6ojt7ZNGbP64ZShRtVDFR+SnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729441; c=relaxed/simple;
	bh=kvE7pmfrS2RNBBoX/Wnuf5xF/ISgYBsPlbzo1uSyMPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfCMls7imyMYBVYCzQEWNoltezjsK8kTm/dJzOH9RGGUy75GmbfvK5Hk5kHDw8nmNyTQo4op2SbXx6IheHIBSzEXW3hf+aZe5HPj2woG0QUnuPSWeeYKesox8zPJfaZxYsryHTvzO6GsrricemM1gYdeQ4sLgzdct4pcEQpmCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUr+wZZP; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d3ed749d-246e-4e83-b3f4-8c899e4f2e0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760729432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5D0EyK3xeLFEpV1TGPdMS1l2DAniu7698uZ5NBzcRbY=;
	b=QUr+wZZP1uvs0VZDhqbU3J0s87Aurdy5sN7+SzBticBs14xe8tMPlyhrTc7l3WxJXaw53M
	uT1KtgihuLfpsCHRkinvSesKxM0wf2wVOkACTc75zqcjXq4OvjGwmCuo7xLVTFieYzmyU9
	XweO01FGy5/r9xbaJXP82r7yqOq0QZk=
Date: Fri, 17 Oct 2025 12:30:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix list_del() in arena list
Content-Language: en-GB
To: Puranjay Mohan <puranjay12@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, kernel-team@meta.com
References: <20251017141727.51355-1-puranjay@kernel.org>
 <42bc3b8552fa2dec468747fc3e81a6b011222b84.camel@gmail.com>
 <CANk7y0jgRC3W6hQzJjfX0NX1PrttcDxSZLcXdB1jo_qxTFTVZg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CANk7y0jgRC3W6hQzJjfX0NX1PrttcDxSZLcXdB1jo_qxTFTVZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/17/25 12:09 PM, Puranjay Mohan wrote:
> On Fri, Oct 17, 2025 at 8:35 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Fri, 2025-10-17 at 14:17 +0000, Puranjay Mohan wrote:
>>> The __list_del fuction doesn't set the previous node's next pointer to
>>> the next node of the node to be deleted. It just updates the local variable
>>> and not the actual pointer in the previous node.
>>>
>>> The test was passing up till now because the bpf code is doing bpf_free()
>>> after list_del and therfore reading head->first from the userspace will
>>> read all zeroes. But after arena_list_del() is finished, head->first should
>>> point to NULL;
>>>
>>> If you remove the bpf_free() call in arena_list_del(), the test will start
>>> crashing because now the userpsace will read 0x100 (LIST_POISON1) in
>>> head->first and segfault.
>> I tried commenting out bpf_free() in arena_list_del() but the test
>> passes for me even w/o this patch.  Is there a way to modify the test
>> case, so that logic of the list_del() is checked more thoroughly?
>>
> For me after commenting bpf_free() in arena_list_del() I get:
>
> [root@localhost bpf]# ./test_progs -a arena_list
> #5       arena_list:FAIL
> Caught signal #11!
> Stack trace:
> ./test_progs(crash_handler+0x1c)[0x956fd4]
> linux-vdso.so.1(__kernel_rt_sigreturn+0x0)[0xffff885b7820]
> ./test_progs[0x559f00]
> ./test_progs[0x55a728]
> ./test_progs(test_arena_list+0x28)[0x55aa7c]
> ./test_progs[0x957624]
> ./test_progs(main+0x6a0)[0x959298]
> /lib64/libc.so.6(+0x30558)[0xffff87e62558]
> /lib64/libc.so.6(__libc_start_main+0x9c)[0xffff87e6263c]
> ./test_progs(_start+0x30)[0x5522f0]
>
> I pushed it to the CI so you can see it fail:
> https://github.com/kernel-patches/bpf/actions/runs/18602175717/job/53043507792

Just FYI, I tried and can reproduce the above crash with bpf_free() removed:

[root@arch-fb-vm1 bpf]# ./test_progs -t arena_list
#5       arena_list:FAIL
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x1f)[0x55e64108298f]
/usr/lib/libc.so.6(+0x3e710)[0x7fc0ac8f0710]
./test_progs(+0x2ea4a)[0x55e640c71a4a]
./test_progs(+0x2e5fe)[0x55e640c715fe]
./test_progs(test_arena_list+0x20)[0x55e640c70d60]
./test_progs(+0x441488)[0x55e641084488]
./test_progs(main+0x579)[0x55e641083419]
/usr/lib/libc.so.6(+0x27cd0)[0x7fc0ac8d9cd0]
/usr/lib/libc.so.6(__libc_start_main+0x8a)[0x7fc0ac8d9d8a]
./te[  161.118394] test_progs[2006]: segfault at 100 ip 000055e640c71a4a sp 00007ffeaa9775e0 error 4 in test_progs[2ea4a,55e6)
st_progs(_start+[  161.123449] Code: 8b 45 80 48 89 45 d0 48 8b 45 d0 48 89 45 f0 48 c7 45 e0 00 00 00 00 31 c0 48 83 7d f0 05
0x25)[0x55e640c697b5]
Segmentation fault (core dumped)

>
> Another thing you can do in addition to commenting bpf_free() is to also comment
>
> //n->next = LIST_POISON1;
> //n->pprev = LIST_POISON2;
>
> and now the test will not crash but fail like:
>
> test_arena_list_add_del:FAIL:sum of list elems after del unexpected
> sum of list elems after del: actual 499500 != expected 0
>
>
> This is because __list_del is a no-op, and after the poisoning logic
> is commented list_del() becomes a no-op.
> The list stays intact after arena_list_del() finishes.
>
> Thanks,
> Puranjay
>



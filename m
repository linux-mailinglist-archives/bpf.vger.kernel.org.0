Return-Path: <bpf+bounces-59900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DB6AD0746
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5D23AB56E
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812428A707;
	Fri,  6 Jun 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dAllqopc"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27FF28A417
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230137; cv=none; b=lAbUaaz4VBmvQerWuFfDS+4L/FPYDbJ63+i58h1wfsKYJhyB3eK61c7EOLzA2hwyU0EgeKsd2I1sJ+rnphm2ERU9KwxVUZUcKeT/8hxGlmySAZUlnQUXnemnuafnuLtKOw01z+OskFSCTHRkyIcRkHKhFk9I8YV/O5xbKtJ7E2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230137; c=relaxed/simple;
	bh=u5Gd8GHV0iC6gym31kXe0nghd+ml+hyQjpfqmmqfm+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaWHFcS7LgHmApevefGkisI/H4cGyazGppoj0ExqOCKrnazS6JXNsdOuRrcytQtJRyRd99ygpbYChBrChCsf2PIUuacT1nV4snYTcxxkICdTXWMHBQdup9E2tHsENL7tHFGbvoK2ywBTY7lecxwPrs4VbeOWZ/Fgz3k0zi3grkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dAllqopc; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4d010777-ecce-4cf5-933f-121e1dde6bf2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749230132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYYEXdkvG03YWv2E8lrvpbB1HiR3OAbrWIjMS3MTW7M=;
	b=dAllqopcmv3pePnW+wb/oA90Vx3bGE5iziRWVbewJdBT8M+ijU3Kre2XrtvpR5qOXhsz0Q
	9m6dpTI5fKefzrTcYWqPo7UflByplrzwQyyfO/ICMBj7r05mGjFYzgDKP1vFAsg+vnyDua
	iJe7GnDXoziD/JIDa07Amx+9tiHySxs=
Date: Fri, 6 Jun 2025 10:15:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix a few test failures with
 arm64 64KB page
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250606032309.444401-1-yonghong.song@linux.dev>
 <CAEf4Bzb+rPo6bfYe71vOzAsqQb4JM6Gu-Hi66qPj0ioF=PFF9g@mail.gmail.com>
 <8ff0934e-3073-4535-9ec1-f9ee1379ff4e@linux.dev>
 <9e9d08a4-6e27-4cab-959d-e730cacd75f4@linux.dev>
 <CAEf4BzYDkYiJdBJyPv4P_3jYJg8JegkvDOYWTam-vBgDQHOQtA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYDkYiJdBJyPv4P_3jYJg8JegkvDOYWTam-vBgDQHOQtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/6/25 9:57 AM, Andrii Nakryiko wrote:
> On Fri, Jun 6, 2025 at 9:49 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 6/6/25 9:43 AM, Yonghong Song wrote:
>>>
>>>
>>> On 6/6/25 9:30 AM, Andrii Nakryiko wrote:
>>>> On Thu, Jun 5, 2025 at 8:23 PM Yonghong Song <yonghong.song@linux.dev>
>>>> wrote:
>>>>> My local arm64 host has 64KB page size and the VM to run test_progs
>>>>> also has 64KB page size. There are a few self tests assuming 4KB page
>>>>> and hence failed in my envorinment. Patch 1 tries to reduce long assert
>>>> typo: environment
>>>>
>>>>> logs when tail failed. Patches 2-4 fixed three selftest failures.
>>>> How come our BPF CI doesn't catch this on aarch64?.. Ihor, any thoughts?
>>>
>>> In CI for aarch64, the page size is 4KB. For example, for this link:
>>>
>>> https://github.com/kernel-patches/bpf/actions/runs/15482212552/
>>> job/43590176563?pr=9053
>>>
>>> Find the kconfig, and we have
>>>
>>>     CONFIG_ARM64_4K_PAGES=y
>>>     # CONFIG_ARM64_16K_PAGES is not set
>>>     # CONFIG_ARM64_64K_PAGES is not set
>>>
>>> and for 4K page, all these tests are fine, but not for 64K page.
>>
>> Ah right, I just realized the host pagesize doesn't matter, the kernel
>> we are running tests against needs to be re-compiled with the right
>> config.
>>
>> If this is important to test on CI, it can be another matrix dimension
>> with customized kconfig. Do we want to do that?
>>
> 
> Can we just use 64KB page size for aarch64 (no 4KB variant for arm64)?

We certainly can, but *not* testing 4k pages on any arch seems like a
bad idea to me.

If we think a step further, there are many permutations of important
configs that we do not test. And it's impractical to test *everything*
for each pending patch.

What we could do is split BPF CI into two domains:
* test most important configurations on every patch like we do now
* test other config permutations on base branches (bpf-next, bpf) 
*sometimes*

We have reserved hardware that is often idle when there is low
activity on the list, and it could be used to run other things:
older/newer compilers, different page sizes, particular kconfigs etc.

This way we would catch problems earlier without overloading/expanding
the CI infra.

It's an effort to setup of course, but that's how I would approach it
if we're serious about testing uncommon things.


>>
>>>
>>>
>>>>
>>>>> Yonghong Song (4):
>>>>>     selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
>>>>>     selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page
>>>>> size
>>>>>     selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB
>>>>>       page size
>>>>>     selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
>>>>>
>>>>>    .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
>>>>>    .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
>>>>>    .../selftests/bpf/prog_tests/user_ringbuf.c    |  6 ++++--
>>>>>    .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++------
>>>>>    .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
>>>>>    5 files changed, 23 insertions(+), 13 deletions(-)
>>>>>
>>>>> --
>>>>> 2.47.1
>>>>>
>>>
>>



Return-Path: <bpf+bounces-59911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EF9AD07E5
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 20:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2DF1672C4
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D569A28BAB8;
	Fri,  6 Jun 2025 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I/65WUlr"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C27418FDDB
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749233495; cv=none; b=pOZZHE6CmOHrqPKY7tXI5E1zokmA9zoTQF4AJuuKspMFdhV1Fhl4i9Co/XVKBwOGFC5xK7cotFfvt1HN/0XDFxy3QIaZQpLJT2MUrrslH5uBKlmh1x+cXAWEV+wfjYLngyM5fVuUZA/yYMpIyd6WrDBwOSf1/icwPEYZRYKMAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749233495; c=relaxed/simple;
	bh=pp1nhSmT7oSKL8fiuMjFHc7WZj5BDr3n5M8eCIuMTGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBAbKEVeGwBpV94/2k7L+4TuF2xuDZMRzK4q3uoyU9YFoWu1vZhWtX6xmEpM5SpkBqOS/kyMD4n+raRbMIT2Hsc0Kj/s4UfeYNnkBVBJgyVO/E9mj80UXD1tt6q+NkHAjbdssCuMDcm1G/vHHjRgEOG8fhj2mCQIFO5RWTvym3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I/65WUlr; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ca8317b-015f-4fe4-a189-5748b3e98542@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749233490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyXDA6+9P4LoOZa6xH58LNU9XNtrjwkLwEbjlQzc2KI=;
	b=I/65WUlr7u1lqzdJf4lUnxu6y6iO4WLfvmDPWtu+NkOgvQh17bWxHc7UOfbrHrZqsretv/
	63y4kGnfC4P99NfRe77LSUy52gsv1KUxVxNNB4BMDooltBwFXhNYj465/YWAMnflu/3kNt
	gUFXcFPnmlZlmxk1DJOGZROUccAJa30=
Date: Fri, 6 Jun 2025 11:11:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix a few test failures with
 arm64 64KB page
Content-Language: en-GB
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250606032309.444401-1-yonghong.song@linux.dev>
 <CAEf4Bzb+rPo6bfYe71vOzAsqQb4JM6Gu-Hi66qPj0ioF=PFF9g@mail.gmail.com>
 <8ff0934e-3073-4535-9ec1-f9ee1379ff4e@linux.dev>
 <9e9d08a4-6e27-4cab-959d-e730cacd75f4@linux.dev>
 <dc7f1234-598e-46a5-afd0-a0de8fba3de9@linux.dev>
 <766f97fa-0b28-4dcd-ba49-3adee4fe2e80@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <766f97fa-0b28-4dcd-ba49-3adee4fe2e80@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/6/25 10:19 AM, Ihor Solodrai wrote:
> On 6/6/25 10:03 AM, Yonghong Song wrote:
>>
>>
>> On 6/6/25 9:49 AM, Ihor Solodrai wrote:
>>> On 6/6/25 9:43 AM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 6/6/25 9:30 AM, Andrii Nakryiko wrote:
>>>>> On Thu, Jun 5, 2025 at 8:23 PM Yonghong Song 
>>>>> <yonghong.song@linux.dev> wrote:
>>>>>> My local arm64 host has 64KB page size and the VM to run test_progs
>>>>>> also has 64KB page size. There are a few self tests assuming 4KB 
>>>>>> page
>>>>>> and hence failed in my envorinment. Patch 1 tries to reduce long 
>>>>>> assert
>>>>> typo: environment
>>>>>
>>>>>> logs when tail failed. Patches 2-4 fixed three selftest failures.
>>>>> How come our BPF CI doesn't catch this on aarch64?.. Ihor, any 
>>>>> thoughts?
>>>>
>>>> In CI for aarch64, the page size is 4KB. For example, for this link:
>>>>
>>>> https://github.com/kernel-patches/bpf/actions/runs/15482212552/ 
>>>> job/43590176563?pr=9053
>>>>
>>>> Find the kconfig, and we have
>>>>
>>>>    CONFIG_ARM64_4K_PAGES=y
>>>>    # CONFIG_ARM64_16K_PAGES is not set
>>>>    # CONFIG_ARM64_64K_PAGES is not set
>>>>
>>>> and for 4K page, all these tests are fine, but not for 64K page.
>>>
>>> Ah right, I just realized the host pagesize doesn't matter, the kernel
>>> we are running tests against needs to be re-compiled with the right
>>> config.
>>
>> Actually, the host pagesize matters too.
>>
>> For example, for trace_printk.lskel.h which is used to build bpf 
>> binary at
>> an aarch64 host and that aarch64 host is 64KB page.
>> In trace_printk.lskel.h, we have
>>     ...
>>     skel->bss = skel_finalize_map_data(&skel->maps.bss.initial_value,
>>         65536, PROT_READ | PROT_WRITE, skel->maps.bss.map_fd);
>>     ...
>>
>> Note that the number '65536' is used here to do mmap.
>>
>> For an x86 host, the number will be 4096 (4KB) instead of 64KB.
>>
>> For this bpf prog on aarch64, if the VM has page size 4KB,
>> something could go wrong.
>>
>> So the best is to have the same page size for host and VM for selftests.
>
> If the host/vm page size difference only impacts certain tests, we

For an arm64 host with 64KB page size,
I tested with VM with 4KB and 64KB page size.
Using 4KB page in VM will have 10 more test failures
compared to 64KB page in VM.


> could denylist them. But if it makes the kernel or selftests more
> unstable in general, then we'll have to switch the hosts.
>
> I don't know how difficult it is to get a 64k page machine on AWS,
> could be a challenge.

I agreed with Andrii. It would be great if we can replace a machine
with 64KB so we won't increase capacity and have one more page
size to test. Not sure how difficult it is.

>
>>
>>
>>>
>>> If this is important to test on CI, it can be another matrix dimension
>>> with customized kconfig. Do we want to do that?
>>>
>>>
>>>>
>>>>
>>>>>
>>>>>> Yonghong Song (4):
>>>>>>    selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
>>>>>>    selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB 
>>>>>> page size
>>>>>>    selftests/bpf: Fix ringbuf/ringbuf_write test failure with 
>>>>>> arm64 64KB
>>>>>>      page size
>>>>>>    selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page 
>>>>>> size
>>>>>>
>>>>>>   .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
>>>>>>   .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
>>>>>>   .../selftests/bpf/prog_tests/user_ringbuf.c    |  6 ++++--
>>>>>>   .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 +++++++++++ 
>>>>>> +------
>>>>>>   .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
>>>>>>   5 files changed, 23 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> -- 
>>>>>> 2.47.1
>>>>>>
>>>>
>>>
>>
>



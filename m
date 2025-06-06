Return-Path: <bpf+bounces-59901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3365AD074D
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708373AEF7A
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC9E289E29;
	Fri,  6 Jun 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RlrFKfFr"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C527288CA0
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230389; cv=none; b=Gq7Y1M527pWX+wwlzHXa+NA9XZxeUd/ODtOjucYvhVa2tGEh5GCL31oxobUuAkbdlv1iMbrtsfa6FsFIKdezcR5gPzR5OTR5BnBNX+DlgHClFDsNUMq2eYn6XmbHDcL7StZVZLQXxP+h2Uy46zcJmd9r8tEX+CAyWtrrAUzIaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230389; c=relaxed/simple;
	bh=kgQ6NZHf48OXBh/kWi1nyRh0LMF+Cpmxi3mlN/qCjT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSSTZggQ3wqbFcnkr1WcaU2xyuyFe4NxGlAjaPHG3UhwtHAUI78rrkkUBbsNpmOhZJq3nQEMrMcBXGhNeXDDXYQwuSzMUTnS7ipu8msK9F/OkHPL4wouj1YVM5svPNs6auNDO5pgUHaW3lnEBz6Oqk3f3OqqMz95dxRQx1L6aEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RlrFKfFr; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <766f97fa-0b28-4dcd-ba49-3adee4fe2e80@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749230385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/gQb1TkrMP9mU3dCN1P6thZzFneio0TO0TZ5+pF5tk=;
	b=RlrFKfFrUh88LzeMPA3NT9XYPTgKY0czPQsUtvq25YThiz49izLOgUowzuI9noS//p/LUf
	NJglizIeTW6Qz96QsOysdSJTuD89Yt5VNc7B7pv1gNJsvBJS/pWw7mH8CwFD/F3vhua70p
	BhNsNTUqVWbwNUCWiMvN4CtOMgUSFNM=
Date: Fri, 6 Jun 2025 10:19:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix a few test failures with
 arm64 64KB page
To: Yonghong Song <yonghong.song@linux.dev>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250606032309.444401-1-yonghong.song@linux.dev>
 <CAEf4Bzb+rPo6bfYe71vOzAsqQb4JM6Gu-Hi66qPj0ioF=PFF9g@mail.gmail.com>
 <8ff0934e-3073-4535-9ec1-f9ee1379ff4e@linux.dev>
 <9e9d08a4-6e27-4cab-959d-e730cacd75f4@linux.dev>
 <dc7f1234-598e-46a5-afd0-a0de8fba3de9@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <dc7f1234-598e-46a5-afd0-a0de8fba3de9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/6/25 10:03 AM, Yonghong Song wrote:
> 
> 
> On 6/6/25 9:49 AM, Ihor Solodrai wrote:
>> On 6/6/25 9:43 AM, Yonghong Song wrote:
>>>
>>>
>>> On 6/6/25 9:30 AM, Andrii Nakryiko wrote:
>>>> On Thu, Jun 5, 2025 at 8:23 PM Yonghong Song 
>>>> <yonghong.song@linux.dev> wrote:
>>>>> My local arm64 host has 64KB page size and the VM to run test_progs
>>>>> also has 64KB page size. There are a few self tests assuming 4KB page
>>>>> and hence failed in my envorinment. Patch 1 tries to reduce long 
>>>>> assert
>>>> typo: environment
>>>>
>>>>> logs when tail failed. Patches 2-4 fixed three selftest failures.
>>>> How come our BPF CI doesn't catch this on aarch64?.. Ihor, any 
>>>> thoughts?
>>>
>>> In CI for aarch64, the page size is 4KB. For example, for this link:
>>>
>>> https://github.com/kernel-patches/bpf/actions/runs/15482212552/ 
>>> job/43590176563?pr=9053
>>>
>>> Find the kconfig, and we have
>>>
>>>    CONFIG_ARM64_4K_PAGES=y
>>>    # CONFIG_ARM64_16K_PAGES is not set
>>>    # CONFIG_ARM64_64K_PAGES is not set
>>>
>>> and for 4K page, all these tests are fine, but not for 64K page.
>>
>> Ah right, I just realized the host pagesize doesn't matter, the kernel
>> we are running tests against needs to be re-compiled with the right
>> config.
> 
> Actually, the host pagesize matters too.
> 
> For example, for trace_printk.lskel.h which is used to build bpf binary at
> an aarch64 host and that aarch64 host is 64KB page.
> In trace_printk.lskel.h, we have
>     ...
>     skel->bss = skel_finalize_map_data(&skel->maps.bss.initial_value,
>         65536, PROT_READ | PROT_WRITE, skel->maps.bss.map_fd);
>     ...
> 
> Note that the number '65536' is used here to do mmap.
> 
> For an x86 host, the number will be 4096 (4KB) instead of 64KB.
> 
> For this bpf prog on aarch64, if the VM has page size 4KB,
> something could go wrong.
> 
> So the best is to have the same page size for host and VM for selftests.

If the host/vm page size difference only impacts certain tests, we
could denylist them. But if it makes the kernel or selftests more
unstable in general, then we'll have to switch the hosts.

I don't know how difficult it is to get a 64k page machine on AWS,
could be a challenge.

> 
> 
>>
>> If this is important to test on CI, it can be another matrix dimension
>> with customized kconfig. Do we want to do that?
>>
>>
>>>
>>>
>>>>
>>>>> Yonghong Song (4):
>>>>>    selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
>>>>>    selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB 
>>>>> page size
>>>>>    selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 
>>>>> 64KB
>>>>>      page size
>>>>>    selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
>>>>>
>>>>>   .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
>>>>>   .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
>>>>>   .../selftests/bpf/prog_tests/user_ringbuf.c    |  6 ++++--
>>>>>   .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 +++++++++++ 
>>>>> +------
>>>>>   .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
>>>>>   5 files changed, 23 insertions(+), 13 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.47.1
>>>>>
>>>
>>
> 



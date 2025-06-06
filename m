Return-Path: <bpf+bounces-59887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E888BAD06FD
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9187717B742
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B382228981F;
	Fri,  6 Jun 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pwEXaIoi"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9071B040D
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228557; cv=none; b=DRTQI3JIRB7mSf34c8HsZYxDKuz1ZHRE5dLxZ8naAqf11Xu2nzFkFnuh7GEdinQfVUFw8MJmkvK3cRqG4bUXwBtwtnx42GJt0dEg1R4kD3zDAKPtxUzpjuwJDXmAJbOkeT/56JdAMZeTclIKOZy+0aBuquRLtGqQIJi5aIEssMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228557; c=relaxed/simple;
	bh=GTj7lfOSX7gBxkirO8/AUfKMWytxVNvDVBsKlYAE+Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzzNtXWdpXhlkbpeDgvGMT3B3hnQmw0N39FBhyFh7xiyySLa91QI1cB1xUC3V2LXx9G1KWz2BYCz2v70+tJHL/wDvhK/ZmSXUW72P3zZ1WgxCGRNksGo5yccK8QfPTsmpwI3YMvOEKhB2YzyGGb3KVGzVa3IEQ/9GnyPVzwTPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pwEXaIoi; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9e9d08a4-6e27-4cab-959d-e730cacd75f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749228552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fd6usMOE933aT8yNlisrsRmepTy7bll5BQySzCKWTk8=;
	b=pwEXaIoiu1yNRJF+Tk9mhv7EmniOtyPmqFGqwtoqaK6a2ujX6ZZcB+0d4bvLxEWVt5azZx
	BKzJuwLdcZ12CQxZZtv+wBCGvLtMdvZ4+k0tgzgz9Q6u7T1EvnMdFnc0WdNlKdsMKLUWuU
	8mNaetKULd4SfnR7ews0RcH3bETqjsM=
Date: Fri, 6 Jun 2025 09:49:06 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <8ff0934e-3073-4535-9ec1-f9ee1379ff4e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/6/25 9:43 AM, Yonghong Song wrote:
> 
> 
> On 6/6/25 9:30 AM, Andrii Nakryiko wrote:
>> On Thu, Jun 5, 2025 at 8:23 PM Yonghong Song <yonghong.song@linux.dev> 
>> wrote:
>>> My local arm64 host has 64KB page size and the VM to run test_progs
>>> also has 64KB page size. There are a few self tests assuming 4KB page
>>> and hence failed in my envorinment. Patch 1 tries to reduce long assert
>> typo: environment
>>
>>> logs when tail failed. Patches 2-4 fixed three selftest failures.
>> How come our BPF CI doesn't catch this on aarch64?.. Ihor, any thoughts?
> 
> In CI for aarch64, the page size is 4KB. For example, for this link:
> 
> https://github.com/kernel-patches/bpf/actions/runs/15482212552/ 
> job/43590176563?pr=9053
> 
> Find the kconfig, and we have
> 
>    CONFIG_ARM64_4K_PAGES=y
>    # CONFIG_ARM64_16K_PAGES is not set
>    # CONFIG_ARM64_64K_PAGES is not set
> 
> and for 4K page, all these tests are fine, but not for 64K page.

Ah right, I just realized the host pagesize doesn't matter, the kernel
we are running tests against needs to be re-compiled with the right
config.

If this is important to test on CI, it can be another matrix dimension
with customized kconfig. Do we want to do that?


> 
> 
>>
>>> Yonghong Song (4):
>>>    selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
>>>    selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page 
>>> size
>>>    selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB
>>>      page size
>>>    selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
>>>
>>>   .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
>>>   .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
>>>   .../selftests/bpf/prog_tests/user_ringbuf.c    |  6 ++++--
>>>   .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++------
>>>   .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
>>>   5 files changed, 23 insertions(+), 13 deletions(-)
>>>
>>> -- 
>>> 2.47.1
>>>
> 



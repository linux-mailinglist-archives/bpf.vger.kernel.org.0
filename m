Return-Path: <bpf+bounces-59886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A6AD06DD
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA8B3AD570
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854628A1C8;
	Fri,  6 Jun 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WA/odC84"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EB19882B
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228221; cv=none; b=hulodvpm6xVeU1rTSnOIFlRQmFON8412P/bkIvMOicR3hxmOgs8bESVSUe8zsd7fwIjAQ/GBtiMnT32juKj+rY7TEsESGvhywdnZlfBbC0KF1H+wgz3f+SQLHvhypXeeoCYFl0P6bqnI14GDZRfyPcukZGaTiUPaEf9CBgUyLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228221; c=relaxed/simple;
	bh=SA+VaqzzwZ+Xe48LCoL/REYNjEK942FdeU9AkcNHp7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk2IYiQq+8hkyeLeh7CAGCqbK5mYFIUaS0MhtrcIzAGTj5aitlMaQajU+Ck+BWW890WSi1kLhev9itVQ9BmcQ8gv/O+kn9cGrvS55odJNPYsrYjCYucIDQeWWpzNLEshC3v1EExSmzNraPeSKrhvnBdFBapcrLdDN5NMqa17SCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WA/odC84; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ff0934e-3073-4535-9ec1-f9ee1379ff4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749228216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mty8BfC9ifAtC5+8W0C117DENdn2dHifUyFnd05kxVE=;
	b=WA/odC84ojqigw8uj4yg0lalimLMrBOPDxpi99BevKZZOREMtSpHC92z5Y1WHgMp79tpJf
	3w4iUqaNwMmUfJIbvsMrJYE0QFAr9aItcntr0i7xXROHPhjUIJNuQGXcsf5kcguDcaVrJl
	QdpwSs5b8cwnSGi2fcaYav0gm5aVxOg=
Date: Fri, 6 Jun 2025 09:43:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix a few test failures with
 arm64 64KB page
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250606032309.444401-1-yonghong.song@linux.dev>
 <CAEf4Bzb+rPo6bfYe71vOzAsqQb4JM6Gu-Hi66qPj0ioF=PFF9g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzb+rPo6bfYe71vOzAsqQb4JM6Gu-Hi66qPj0ioF=PFF9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/6/25 9:30 AM, Andrii Nakryiko wrote:
> On Thu, Jun 5, 2025 at 8:23 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> My local arm64 host has 64KB page size and the VM to run test_progs
>> also has 64KB page size. There are a few self tests assuming 4KB page
>> and hence failed in my envorinment. Patch 1 tries to reduce long assert
> typo: environment
>
>> logs when tail failed. Patches 2-4 fixed three selftest failures.
> How come our BPF CI doesn't catch this on aarch64?.. Ihor, any thoughts?

In CI for aarch64, the page size is 4KB. For example, for this link:

https://github.com/kernel-patches/bpf/actions/runs/15482212552/job/43590176563?pr=9053

Find the kconfig, and we have

   CONFIG_ARM64_4K_PAGES=y
   # CONFIG_ARM64_16K_PAGES is not set
   # CONFIG_ARM64_64K_PAGES is not set

and for 4K page, all these tests are fine, but not for 64K page.


>
>> Yonghong Song (4):
>>    selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
>>    selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page size
>>    selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB
>>      page size
>>    selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
>>
>>   .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
>>   .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
>>   .../selftests/bpf/prog_tests/user_ringbuf.c    |  6 ++++--
>>   .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++------
>>   .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
>>   5 files changed, 23 insertions(+), 13 deletions(-)
>>
>> --
>> 2.47.1
>>



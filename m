Return-Path: <bpf+bounces-21166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCCA84900F
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 20:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93B41F2384B
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6C6250EC;
	Sun,  4 Feb 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G7fehI6f"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221A250EA
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707074405; cv=none; b=T3EdSwzhLX0V5Lhtzl1/obXhdcAXj8+1/DI+45K1xSGTjGRyCYBKXOn1u2YCscelIE1+WYlCAl7R/TsjbHTZwLJBlVAZA+G84WlbsUH1S2dS0BvY/ljJLYCnWxUBbE5tDpT1NByAJMS9BzPr6pkliTI6tidTvHun6Ii7A1kgGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707074405; c=relaxed/simple;
	bh=jy3L3slsBvA+qD/r81vGled26nxAGGHFv+Jc7iCQ+rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8jnUsnoY1PSKjibJyqgSqsUBmEnbBxm3KL/nlPV5Yf/unDcejM4kWdLZi8f7IO9lcxlJEw21O1OB2qr8GzZqQoCZGbQXopbe8NKFCHKlb3kygobEKzo6cOUBEEnyLFQ9dK4DPRdQB8ICsa81QwSjrzBEOSxo7D6XPdw/JBplPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G7fehI6f; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a910fc94-47cd-419e-baf9-5c00140cbc60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707074401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pD6uq8KSVTHx6BMduUbEumYY42Zow4xEpIeHUMlQWO4=;
	b=G7fehI6fRJJQ2OJJ1+TfW+GkPbOpYvJXfi5c3DxZenJ8TldAGlOBZTJG0EJ/Z5VKDVz3aX
	E0N2AMM1MvnbS5QMhTP/v/bqlW9YiXXCl5bIeCGNjFpAhazsw+yMz0sTWawe1p0b4qsiKM
	J/M0V7MjJSbFc4BoFbOIJLVTrO+6yq8=
Date: Sun, 4 Feb 2024 11:19:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/2] bpf: Add generic kfunc bpf_ffs64()
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
References: <20240131155607.51157-1-hffilwlqm@gmail.com>
 <CAEf4BzYsYHi1s_7PZ5QknUg+Oe9drN0OSXbxT06WDB57o0Ju9w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYsYHi1s_7PZ5QknUg+Oe9drN0OSXbxT06WDB57o0Ju9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/2/24 2:18 PM, Andrii Nakryiko wrote:
> On Wed, Jan 31, 2024 at 7:56 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>> This patchset introduces a new generic kfunc bpf_ffs64(). This kfunc
>> allows bpf to reuse kernel's __ffs64() function to improve ffs
>> performance in bpf.
>>
> The downside of using kfunc for this is that the compiler will assume
> that R1-R5 have to be spilled/filled, because that's function call
> convention in BPF.
>
> If this was an instruction, though, it would be much more efficient
> and would avoid this problem. But I see how something like ffs64 is
> useful. I think it would be good to also have popcnt instruction and a
> few other fast bit manipulation operations as well.
>
> Perhaps we should think about another BPF ISA extension to add fast
> bit manipulation instructions?

Sounds a good idea to start the conversion. Besides popcnt, lzcnt
is also a candidate. From llvm perspective, it would be hard to
generate ffs64/popcnt/lzcnt etc. from source generic implementation.
So most likely, inline asm will be used. libbpf could define
some macros to make adoption easier. Verifier and JIT will do
proper thing, either using corresponding arch insns directly or
verifier will rewrite so JIT won't be aware of these insns.

>
>> In patch "bpf: Add generic kfunc bpf_ffs64()", there is some data to
>> confirm that this kfunc is able to save around 10ns for every time on
>> "Intel(R) Xeon(R) Silver 4116 CPU @ 2.10GHz" CPU server, by comparing
>> with bpf-implemented __ffs64().
>>
>> However, it will be better when convert this kfunc to "rep bsf" in
>> JIT on x86, which is able to avoid a call. But, I haven't figure out the
>> way.
>>
>> Leon Hwang (2):
>>    bpf: Add generic kfunc bpf_ffs64()
>>    selftests/bpf: Add testcases for generic kfunc bpf_ffs64()
>>
>>   kernel/bpf/helpers.c                          |  7 +++
>>   .../testing/selftests/bpf/prog_tests/bitops.c | 54 +++++++++++++++++++
>>   tools/testing/selftests/bpf/progs/bitops.c    | 21 ++++++++
>>   3 files changed, 82 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bitops.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/bitops.c
>>
>>
>> base-commit: c5809f0c308111adbcdbf95462a72fa79eb267d1
>> --
>> 2.42.1
>>


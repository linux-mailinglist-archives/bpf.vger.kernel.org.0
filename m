Return-Path: <bpf+bounces-51200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1CCA31B8D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 02:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256ED18876B8
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 01:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044A878F20;
	Wed, 12 Feb 2025 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QYK681TN"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC912AAE2
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325080; cv=none; b=BVGEr4Bw6Drr9vfHb3S+r9r0OiPXFfNTnBt4qdJJpnOEHRSF8H0PtA9Ro36c+bXqS2hQghsIVOZGZx19Fmos3Ey+aZX5DS9wu9nNSZuhyQQVbKCzoznmNHgXwZV2lYpmR2RY8aqqq7NS7o9FoT7r1SHJ9KqUpbF2iN5SjG3vv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325080; c=relaxed/simple;
	bh=KcE47gvgrXBbSf3cPN3o7jIx57wqqpteI6FATzln9AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHWdU0FGEkV8iYnD+Co2tmW1beddaLxy4G43BTDGKepJOPOZmjTDBLAihvspTNLPl4Pv3nOqRnGtVXmphSD5aaxMXz/iPFdQ8oovvSqh3C+rhfPhqy1AvAtdlQNVnKgYNGIPMKbTpmoAF9ZuzXfC8ZF7HLQkTjMofDhRuuwVIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QYK681TN; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c1023107-421a-49fa-9125-904394f600eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739325073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwrP8y2qc5O/HtoQZICN1zbaCx6201o/J/Mk3SpsZTU=;
	b=QYK681TNd86wr6wo5k2ot3jvRCyQthnSqvyFHNkCMcATjFcZpC6PZ2+HL8Byg5prDcns/i
	DhR2lsFihjmz7WhKK9Z87PnVh/ERDcvJRsyu+EgqYaw/2aBYN3nIh1ALS07h0LkF2Z+Xuk
	4u4E95Is7pgYg8NxvNddSqZIOF7d3Bg=
Date: Wed, 12 Feb 2025 09:50:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add a case to test global
 percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250127162158.84906-1-leon.hwang@linux.dev>
 <20250127162158.84906-5-leon.hwang@linux.dev>
 <CAEf4BzYXCQi4HMvegMmsx-ppxprwNVyKohJgka8gY_B+gMy+mQ@mail.gmail.com>
 <8e25e1e9-37a0-4d4c-8af9-c2d5e12af65f@linux.dev>
 <CAEf4BzYeKcaYH8ZYpMo0XRyS4UYWaSZB5bMJ6FK0pUX1SUmgqg@mail.gmail.com>
 <cab242ad-a557-430f-a466-7816811aea5e@linux.dev>
 <CAEf4BzanEFT8fq2iRp0C4E3dqXue3hZ2YHGxvLMo0RAi07V1rA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzanEFT8fq2iRp0C4E3dqXue3hZ2YHGxvLMo0RAi07V1rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/2/25 08:15, Andrii Nakryiko wrote:
> On Mon, Feb 10, 2025 at 1:52 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 8/2/25 03:48, Andrii Nakryiko wrote:
>>> On Fri, Feb 7, 2025 at 2:00 AM Leon Hwang <leon.hwang@linux.dev> wrote:

[...]

>>
>> Yes, I've generated it. But it should not add '__aligned(8)' to it. Or
>> bpf_map__set_initial_value() will fails because the aligned size is
>> different from the actual spec's value size.
>>
>> If the actual value size is not __aligned(8), how should we lookup
>> element from percpu_array map?
> 
> for .percpu libbpf can ensure that map is created with correct value
> size that matches __aligned(8) size? It's an error-prone corner case
> to non-multiple-of-8 size anyways (for per-CPU data), so just prevent
> the issue altogether?...
> 

Ack.

I'll update value size of .percpu maps to match __aligned(8) size, and
add '__aligned(8)' to the generated .percpu types.

>>
>> The doc[0] does not provide a good practice for this case.
>>
>> [0] https://docs.kernel.org/bpf/map_array.html#bpf-map-type-percpu-array
>>
>>>>
>>>>> And for that array access, we should make sure that it's __aligned(8),
>>>>> so indexing by CPU index works correctly.
>>>>>
>>>>
>>>> Ack.
>>>>
>>>>> Also, you define per-CPU variable as int, but here it is u64, what's
>>>>> up with that?
>>>>>
>>>>
>>>> Like __aligned(8), it's to make sure 8-bytes aligned. It's better to use
>>>> __aligned(8).
>>>
>>> It's hacky, and it won't work correctly on big-endian architectures.
>>> But you shouldn't need that if we have a struct representing this
>>> .percpu memory image. Just make sure that struct has 8 byte alignment
>>> (from bpftool side during skeleton generation, probably).
>>>
>>> [...]
>>>
>>>>> at least one of BPF programs (don't remember which one, could be
>>>>> raw_tp) supports specifying CPU index to run on, it would be nice to
>>>>> loop over CPUs, triggering BPF program on each one and filling per-CPU
>>>>> variable with current CPU index. Then we can check that all per-CPU
>>>>> values have expected values.
>>>>>
>>>>
>>>> Do you mean prog_tests/perf_buffer.c::trigger_on_cpu()?
>>>>
>>>
>>> No, look at `cpu` field of `struct bpf_test_run_opts`. We should have
>>> a selftest using it, so you can work backwards from that.
>>>
>>
>> By referencing raw_tp, which uses `opts.cpu`, if use it to test global
>> percpu data, it will fail to test on non-zero CPU, because
>> bpf_prog_test_run_skb() disallows setting `opts.cpu`.
>>
>> Then, when `setaffinity` like perf_buffer.c::trigger_on_cpu(), it's OK
>> to run the adding selftests on all CPUs.
>>
>> So, should I use `setaffinity` or change the bpf prog type from tc to
>> raw_tp to use `opts.cpu`?
> 
> Is it a problem to use raw_tp (we do it a lot)? If not, I'd go with
> raw_tp and opts.cpu.
> 

There's no problem to use raw_tp. Let us use raw_tp and opts.cpu.

Thanks,
Leon




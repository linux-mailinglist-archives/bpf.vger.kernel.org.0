Return-Path: <bpf+bounces-50942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18169A2E83D
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89523AAD70
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D21C4A3D;
	Mon, 10 Feb 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e88z9G9o"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0A1C3C01
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181138; cv=none; b=a+AtPV6g6miNdEQVVh4C2E39TsOh8OayMe8xP2QcjRMEp/R47WpxHiSTx0IHgDe0+QXLjJBBmtflnO8RALo5IrDXhvQCflnqZGEu5s3ETdrAcxfpzFSjMnOQobYrLQwkcXWfapelMJew/wzeSLMCOsCR4JF5Ls7lIf7BQyXpJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181138; c=relaxed/simple;
	bh=P60Kw+OR6zriXJSiWU6Hv8qIi6HKuFYjIN/3vPgnxBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EObcZ5ceg/FxNV3JYW9MQ2Bt4XbbemJUk6F2iTUvChDfYK7IMpZ694CaIiAy/WADRQTu4KDVCJVTitPgIrLhTtePgFzQUx2AEz2/ylh3BWmotZzfrPA8BIoH8f/EAw/B4QEF4lWvXtvqhfgbfKh1d2SeKfjKUaKIJrGQhrUBBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e88z9G9o; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cab242ad-a557-430f-a466-7816811aea5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739181133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibN7Jj0+hwmBjtQoAuQl+WQFsKbvCJchMXagUxPNO2E=;
	b=e88z9G9owdctVh8azehu8uqhgL0HL7jrcKXakHsuAKh7mULX+KyEjGMYXZDNaVlMeJnVHf
	vd1isdGATbkAlBbLxkOL8eSyORA686prhzXf8R5MK5NaXHW0JbHSzP6x06Iqxw/CR/tTUf
	/DS0SozQ33arSTuBZq1pNS0Plw54q5A=
Date: Mon, 10 Feb 2025 17:52:04 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYeKcaYH8ZYpMo0XRyS4UYWaSZB5bMJ6FK0pUX1SUmgqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/2/25 03:48, Andrii Nakryiko wrote:
> On Fri, Feb 7, 2025 at 2:00 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 6/2/25 08:09, Andrii Nakryiko wrote:
>>> On Mon, Jan 27, 2025 at 8:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>

[...]

>>>> +void test_global_percpu_data_init(void)
>>>> +{
>>>> +       struct test_global_percpu_data *skel = NULL;
>>>> +       u64 *percpu_data = NULL;
>>>
>>> there is that test_global_percpu_data__percpu type you are declaring
>>> in the BPF skeleton, right? We should try using it here.
>>>
>>
>> No. bpftool does not generate test_global_percpu_data__percpu. The
>> struct for global variables is embedded into skeleton struct.
>>
>> Should we generate type for global variables?
> 
> we already have custom skeleton-specific type for .data, .rodata,
> .bss, so we should provide one for .percpu as well, yes
> 

Yes, I've generated it. But it should not add '__aligned(8)' to it. Or
bpf_map__set_initial_value() will fails because the aligned size is
different from the actual spec's value size.

If the actual value size is not __aligned(8), how should we lookup
element from percpu_array map?

The doc[0] does not provide a good practice for this case.

[0] https://docs.kernel.org/bpf/map_array.html#bpf-map-type-percpu-array

>>
>>> And for that array access, we should make sure that it's __aligned(8),
>>> so indexing by CPU index works correctly.
>>>
>>
>> Ack.
>>
>>> Also, you define per-CPU variable as int, but here it is u64, what's
>>> up with that?
>>>
>>
>> Like __aligned(8), it's to make sure 8-bytes aligned. It's better to use
>> __aligned(8).
> 
> It's hacky, and it won't work correctly on big-endian architectures.
> But you shouldn't need that if we have a struct representing this
> .percpu memory image. Just make sure that struct has 8 byte alignment
> (from bpftool side during skeleton generation, probably).
> 
> [...]
> 
>>> at least one of BPF programs (don't remember which one, could be
>>> raw_tp) supports specifying CPU index to run on, it would be nice to
>>> loop over CPUs, triggering BPF program on each one and filling per-CPU
>>> variable with current CPU index. Then we can check that all per-CPU
>>> values have expected values.
>>>
>>
>> Do you mean prog_tests/perf_buffer.c::trigger_on_cpu()?
>>
> 
> No, look at `cpu` field of `struct bpf_test_run_opts`. We should have
> a selftest using it, so you can work backwards from that.
> 

By referencing raw_tp, which uses `opts.cpu`, if use it to test global
percpu data, it will fail to test on non-zero CPU, because
bpf_prog_test_run_skb() disallows setting `opts.cpu`.

Then, when `setaffinity` like perf_buffer.c::trigger_on_cpu(), it's OK
to run the adding selftests on all CPUs.

So, should I use `setaffinity` or change the bpf prog type from tc to
raw_tp to use `opts.cpu`?

Thanks,
Leon



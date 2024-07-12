Return-Path: <bpf+bounces-34711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79193026F
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 01:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355B9283A99
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03361311A7;
	Fri, 12 Jul 2024 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jsYmjfrz"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F773501
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720827755; cv=none; b=uVmHHpKFRrIYK/8QTm/DnDBn0n573jzJUWeqb6UKTfFNytrilbgEeTG6mXKo2TH7yxLs4CIuoQaq+sOvC70V04yNq7xzC8KjuxzOePspn2FL9H5TWl4DCzW/H+db5i/+he9fW7kol4ZnKRSo3IXJFe+heF6I2h33oVOYoulX6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720827755; c=relaxed/simple;
	bh=lz5/FhGoQ0eYf+oL2x29PoWGmW1i4wIt0FBFEYsJPsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXsNtpiBq5RGnLXYt+UeVyLrhedgluDRQBqZRaet7x05gy8A5XwjwMphO4WccmGuMyGfBzwwEFDifEwLZcutISDVRmguJOPuayEGH6m5qlWzb/pCqYV59zfaSSd7vN1MIMMiYxrjPHSXV7uueG93elHYiW8O2HBlLNelEtqYXe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jsYmjfrz; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: andrii.nakryiko@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720827750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ky4Ml6S3FrvmQsQF2sZ3gKnO5yYJrqTE0CYZknIrhkE=;
	b=jsYmjfrzVjjAbSee1hWu96mgws4v/xLNjK9j2UbG0qOTf7NDKGTxN9RHJhace9SbUNqxD+
	zhdGHw2U9HZHwB+9XIztddDE3EUuTOdxrTPavAidIYawaD8mloMuc/KhORui0ICkLvlpFp
	mGIfUwkdYDkIbLrIbZnUFzC1kIHR7bE=
X-Envelope-To: alexei.starovoitov@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <baca8e9e-58cd-407d-b4d0-d15d3c41237e@linux.dev>
Date: Fri, 12 Jul 2024 16:42:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240711164204.1657880-1-yonghong.song@linux.dev>
 <20240711164209.1658101-1-yonghong.song@linux.dev>
 <CAADnVQKnWJM7mGqpHn4wy25+VJuh9KGGK9tf75qgC2Zk8+ojBA@mail.gmail.com>
 <d57143f9-de6c-49e8-af34-848ad9f19838@linux.dev>
 <CAEf4Bzao0X9Pwg4D40P8cO_42ZQabMnYs2zHZNgO36hR45VnGA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzao0X9Pwg4D40P8cO_42ZQabMnYs2zHZNgO36hR45VnGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/12/24 2:47 PM, Andrii Nakryiko wrote:
> On Fri, Jul 12, 2024 at 1:48 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 7/12/24 1:16 PM, Alexei Starovoitov wrote:
>>> On Thu, Jul 11, 2024 at 9:42 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> It is clear that the main overhead is the push/pop r9 for
>>>> three calls.
>>>>
>>>> Five runs of the benchmarks:
>>>>
>>>> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
>>>> no-private-stack:    0.662 ± 0.019M/s (drops 0.000 ± 0.000M/s)
>>>> private-stack:       0.673 ± 0.017M/s (drops 0.000 ± 0.000M/s)
>>>> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
>>>> no-private-stack:    0.684 ± 0.005M/s (drops 0.000 ± 0.000M/s)
>>>> private-stack:       0.676 ± 0.008M/s (drops 0.000 ± 0.000M/s)
>>>> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
>>>> no-private-stack:    0.673 ± 0.017M/s (drops 0.000 ± 0.000M/s)
>>>> private-stack:       0.683 ± 0.006M/s (drops 0.000 ± 0.000M/s)
>>>> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
>>>> no-private-stack:    0.680 ± 0.011M/s (drops 0.000 ± 0.000M/s)
>>>> private-stack:       0.626 ± 0.050M/s (drops 0.000 ± 0.000M/s)
>>>> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
>>>> no-private-stack:    0.686 ± 0.007M/s (drops 0.000 ± 0.000M/s)
>>>> private-stack:       0.683 ± 0.003M/s (drops 0.000 ± 0.000M/s)
>>>>
>>>> The performance is very similar between private-stack and no-private-stack.
>>> I'm not so sure.
>>> What is the "perf report" before/after?
>>> Are you sure that bench spends enough time inside the program itself?
>>> By the look of it it seems that most of the time will be in hashmap
>>> and syscall overhead.
>>>
>>> You need that batch's one that uses for loop and attached to a helper.
>>> See commit 7df4e597ea2c ("selftests/bpf: add batched, mostly in-kernel
>>> BPF triggering benchmarks")
>> Okay, I see. The current approach is one trigger, one prog run where
>> each prog run exercise 3 syscalls. I should add a loop to the bpf
>> program to make bpf program spends majority of time. Will do this
>> in the next revision, plus running 'perf report'.
> please also benchmark on real hardware, VM will not give reliable results

Sure. Will do.

>
>>> I think the next version doesn't need RFC tag. patch 1 lgtm.


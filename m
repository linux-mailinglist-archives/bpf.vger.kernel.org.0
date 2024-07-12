Return-Path: <bpf+bounces-34691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E0930155
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E21CB22B39
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278F93B298;
	Fri, 12 Jul 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AwBduTGT"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF61BDE6
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817335; cv=none; b=e/PY0DKSN2bmiCY7I8l9t+Uxv3usy3cu7+EH/anQpXbO0QVymqLxeJM+7dCp1PFsG6n1GLtIT8IZ+Q+7bZSSO50bAi/lwP8Nzb7RUjkwRdWmU8WzJjxyzvHsXcdUTL/I7xSzzl/1WcO0guDp08PdibluvQhqiGrzrucGTpxaAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817335; c=relaxed/simple;
	bh=cSth8vU0+XpzioIuYa39cAtgoEQ9DUQT6H1joixKWeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMDv54j1yT7z7oy1r0sg9D4l9/gmck7Fu12iscwiV0kTYZZDWpGz5pm05JLmmbcmCPKWcU9xmkv6uaAw2mnyqM3nkcu3kUYG4noGHBU8XPBDuiMJAjX/iB+cVN4UNulZeTMuBT7BoILbruoJWrQPg2YqpdDTQU2TS8zGe+m66x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AwBduTGT; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720817331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VcFVxGt6Joy9KTkA/cadXwWoOCooicoKw9gG8N3jQI=;
	b=AwBduTGTfDBEJRI/8xedI7iJHw6yWReACxh9XDsfRC0GSQSZs3rL1GxzgFygcSbdAxlY2r
	Fxd6YgPx2dlB4kmYHIPcwIv0U+aPvSJtnN/7deDuJnlv69pwn782+sGT89PnJS0sf83B7Y
	DoemOW0vXvUxFO5ywefQ+GDEXbk0540=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <d57143f9-de6c-49e8-af34-848ad9f19838@linux.dev>
Date: Fri, 12 Jul 2024 13:48:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240711164204.1657880-1-yonghong.song@linux.dev>
 <20240711164209.1658101-1-yonghong.song@linux.dev>
 <CAADnVQKnWJM7mGqpHn4wy25+VJuh9KGGK9tf75qgC2Zk8+ojBA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKnWJM7mGqpHn4wy25+VJuh9KGGK9tf75qgC2Zk8+ojBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/12/24 1:16 PM, Alexei Starovoitov wrote:
> On Thu, Jul 11, 2024 at 9:42 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> It is clear that the main overhead is the push/pop r9 for
>> three calls.
>>
>> Five runs of the benchmarks:
>>
>> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
>> no-private-stack:    0.662 ± 0.019M/s (drops 0.000 ± 0.000M/s)
>> private-stack:       0.673 ± 0.017M/s (drops 0.000 ± 0.000M/s)
>> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
>> no-private-stack:    0.684 ± 0.005M/s (drops 0.000 ± 0.000M/s)
>> private-stack:       0.676 ± 0.008M/s (drops 0.000 ± 0.000M/s)
>> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
>> no-private-stack:    0.673 ± 0.017M/s (drops 0.000 ± 0.000M/s)
>> private-stack:       0.683 ± 0.006M/s (drops 0.000 ± 0.000M/s)
>> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
>> no-private-stack:    0.680 ± 0.011M/s (drops 0.000 ± 0.000M/s)
>> private-stack:       0.626 ± 0.050M/s (drops 0.000 ± 0.000M/s)
>> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
>> no-private-stack:    0.686 ± 0.007M/s (drops 0.000 ± 0.000M/s)
>> private-stack:       0.683 ± 0.003M/s (drops 0.000 ± 0.000M/s)
>>
>> The performance is very similar between private-stack and no-private-stack.
> I'm not so sure.
> What is the "perf report" before/after?
> Are you sure that bench spends enough time inside the program itself?
> By the look of it it seems that most of the time will be in hashmap
> and syscall overhead.
>
> You need that batch's one that uses for loop and attached to a helper.
> See commit 7df4e597ea2c ("selftests/bpf: add batched, mostly in-kernel
> BPF triggering benchmarks")

Okay, I see. The current approach is one trigger, one prog run where
each prog run exercise 3 syscalls. I should add a loop to the bpf
program to make bpf program spends majority of time. Will do this
in the next revision, plus running 'perf report'.

>
> I think the next version doesn't need RFC tag. patch 1 lgtm.


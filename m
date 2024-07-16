Return-Path: <bpf+bounces-34924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B039932F4B
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 19:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C80B2826D1
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141361A01AA;
	Tue, 16 Jul 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K+ZjZ++F"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CC54BD4
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721151961; cv=none; b=ObkaUR+wUK7h79VIKe6P9ZbMKEU5shzBqThRsCPlbSyw3FITCDV3nJ49n8Ez9y9QONJOfFIWUhHIkTWSKoCnFn6sf1ugAbg9eT3Az8N1e85LPNQ4DpK7w1P2FIs2QsfVwyS9yicDg3kfgcukYkZ2gVqxmB4xVmP2rOGUmYzrZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721151961; c=relaxed/simple;
	bh=IeHylN+qlEeCXj9SBRN32vnfBB+HBypsHK7w1AVSZ1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POoFHeqsJklJ2CLl+gKOOCy6M6tuT3MrpH4LvJDVnnNfOLMLlWR4zjGay0KsLyOKCVrP5dr0PnpgwHb6wOe3IpC8VMwNoM/3TpVWAsPIJ75mKD3rsKAzwznTmW3jDlK3Q9ccbJadHo3WCml4Ua6NaLf+p5p14FUIopZ5vscGUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K+ZjZ++F; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721151956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GAjRnhA4RV05r4+LcCZNcJ2Za0v8G5A3ad/T0YF8ZKg=;
	b=K+ZjZ++FMTqBKI/5zEnbJu/WQFieUoAHBKryu19YomzmkTJKwY6WvvufcAKBPGYcJNGDV8
	SzL5I42+gqWx8Cpm3GRbDDtkbQAgY6KpfvZgQ2oVfdIE+zUbuyf2rztccD94ig3UsU2e8K
	vCLk9uogeItrLEPhg70BH5oFriLfCao=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <ec461a41-6bd4-4d8b-9cce-950aeae704c7@linux.dev>
Date: Tue, 16 Jul 2024 10:45:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240716011647.811746-1-yonghong.song@linux.dev>
 <20240716011652.811985-1-yonghong.song@linux.dev>
 <CAADnVQ+t0zEXwtrw9oCZN0bxOLTbNVkgz5u8yU+kqaTB3TL6bA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+t0zEXwtrw9oCZN0bxOLTbNVkgz5u8yU+kqaTB3TL6bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/15/24 6:35 PM, Alexei Starovoitov wrote:
> On Mon, Jul 15, 2024 at 6:17 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With 4096 loop ierations per program run, I got
>>    $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=4096 no-private-stack
>>      27.89%  bench    [kernel.vmlinux]                  [k] htab_map_hash
>>      21.55%  bench    [kernel.vmlinux]                  [k] _raw_spin_lock
>>      11.51%  bench    [kernel.vmlinux]                  [k] htab_map_delete_elem
>>      10.26%  bench    [kernel.vmlinux]                  [k] htab_map_update_elem
>>       4.85%  bench    [kernel.vmlinux]                  [k] __pcpu_freelist_push
>>       4.34%  bench    [kernel.vmlinux]                  [k] alloc_htab_elem
>>       3.50%  bench    [kernel.vmlinux]                  [k] memcpy_orig
>>       3.22%  bench    [kernel.vmlinux]                  [k] __pcpu_freelist_pop
>>       2.68%  bench    [kernel.vmlinux]                  [k] bcmp
>>       2.52%  bench    [kernel.vmlinux]                  [k] __htab_map_lookup_elem
>
> so the prog itself is not even in the top 10 which means
> that the test doesn't measure anything meaningful about the private
> stack itself.
> It just benchmarks hash map and overhead of extra push/pop is invisible.
>
>> +SEC("tp/syscalls/sys_enter_getpgid")
>> +int stack0(void *ctx)
>> +{
>> +       struct data_t key = {}, value = {};
>> +       struct data_t *pvalue;
>> +       int i;
>> +
>> +       hits++;
>> +       key.d[10] = 5;
>> +       value.d[8] = 10;
>> +
>> +       for (i = 0; i < batch_iters; i++) {
>> +               pvalue = bpf_map_lookup_elem(&htab, &key);
>> +               if (!pvalue)
>> +                       bpf_map_update_elem(&htab, &key, &value, 0);
>> +               bpf_map_delete_elem(&htab, &key);
>> +       }
> Instead of calling helpers that do a lot of work the test should
> call global subprograms or noinline static functions that are nops.
> Only then we might see the overhead of push/pop r9.
>
> Once you do that you'll see that
> +SEC("tp/syscalls/sys_enter_getpgid")
> approach has too much overhead.
> (you don't see right now since hashmap dominates).
> Pls use an approach I mentioned earlier by fentry-ing into
> a helper and another prog calling that helper in for() loop.

Thanks for suggestion. Will use fentry program with empty functions
to test maximum worst performance.

>
> pw-bot: cr


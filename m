Return-Path: <bpf+bounces-63188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E5DB03F00
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E8B168F22
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46857248F5A;
	Mon, 14 Jul 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U8gci8tf"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D40246335
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497394; cv=none; b=Wei4S9El4vUQnMlkh362Twv6lqBvLA2FjTfpYxSNQDOKCwKSfaHvra/TnIOc4JM9u4bAmQN3u/srBgg8MtOD0+D1glBie+HEdpKmyblpQ3af1+AwbOpKts5bYFCMHviZO8YK4GaMasFMwNoP2nJIwyiCtbBtefLYOTGaI66hNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497394; c=relaxed/simple;
	bh=yhbm/4yp6Bv71xaE/MR/q2nl+NpyxNXZXr2YLzBgZyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hjlfizm1ifgWEXZJGYee1VEOxq6gl49FkuVqmyuU0gGSU0xZXrEPth/TUN0nXnvzxwYr5mBMrbWoDGXqmO2fZ6i1iTwpcAHSLP3fXDfjq9UjLBFS1Jn0Fa9tmKpc7cPhBMywnv+G5PhrRnXacR5MZtCP/ERUqKY0AlFKxEZa0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U8gci8tf; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b17379a-9b1f-4086-aced-49c7ed0477f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752497391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cz0m5G+oQsi+mALnXwweLhshKT4OvQzm9z7PVppKzSw=;
	b=U8gci8tf08olnhUfg5FRw6B/MfID2FRdzQppQ5JkFuKMbBatgID2W+9i8nE16ooUN3Oy1S
	xWUXVyFCd25CAgT7AOb94hHqg1rTV21YlG7+mTpaYcXYwlbwIZSZx7Ky5ygioDa7zyWavi
	Jb6h9TfZcGXeCj1DNf9AnzkPP+Kegmc=
Date: Mon, 14 Jul 2025 20:49:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 3/3] selftests/bpf: Add case to test
 BPF_F_CPU
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net
References: <20250707160404.64933-1-leon.hwang@linux.dev>
 <20250707160404.64933-4-leon.hwang@linux.dev>
 <CAEf4Bzba8RdYsC76Hvn5quXCHrG9K7nqv=k5z0-Ex6hBNLVYgw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzba8RdYsC76Hvn5quXCHrG9K7nqv=k5z0-Ex6hBNLVYgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/12 02:11, Andrii Nakryiko wrote:
> On Mon, Jul 7, 2025 at 9:04 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch adds test coverage for the new BPF_F_CPU flag support in
>> percpu_array maps. The following APIs are exercised:
>>
>> * bpf_map_update_batch()
>> * bpf_map_lookup_batch()
>> * bpf_map_update_elem_opts()
>> * bpf_map__update_elem_opts()
>> * bpf_map_lookup_elem_opts()
>> * bpf_map__lookup_elem_opts()
>>
>> cd tools/testing/selftests/bpf/
>> ./test_progs -t percpu_alloc/cpu_flag_tests
>> 253/13  percpu_alloc/cpu_flag_tests:OK
>> 253     percpu_alloc:OK
>> Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  .../selftests/bpf/prog_tests/percpu_alloc.c   | 170 ++++++++++++++++++
>>  .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
>>  2 files changed, 194 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
>> index 343da65864d6..6f0d0e6dc76a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
>> @@ -3,6 +3,7 @@
>>  #include "percpu_alloc_array.skel.h"
>>  #include "percpu_alloc_cgrp_local_storage.skel.h"
>>  #include "percpu_alloc_fail.skel.h"
>> +#include "percpu_array_flag.skel.h"
>>
>>  static void test_array(void)
>>  {
>> @@ -115,6 +116,173 @@ static void test_failure(void) {
>>         RUN_TESTS(percpu_alloc_fail);
>>  }
>>
>> +static void test_cpu_flag(void)
>> +{
>> +       int map_fd, *keys = NULL, value_size, cpu, i, j, nr_cpus, err;
>> +       size_t key_sz = sizeof(int), value_sz = sizeof(u64);
>> +       struct percpu_array_flag *skel;
>> +       u64 batch = 0, *values = NULL;
>> +       const u64 value = 0xDEADC0DE;
>> +       u32 count, max_entries;
>> +       struct bpf_map *map;
>> +       LIBBPF_OPTS(bpf_map_lookup_elem_opts, lookup_opts,
>> +                   .flags = BPF_F_CPU,
>> +                   .cpu = 0,
>> +       );
>> +       LIBBPF_OPTS(bpf_map_update_elem_opts, update_opts,
>> +                   .flags = BPF_F_CPU,
>> +                   .cpu = 0,
>> +       );
>> +       LIBBPF_OPTS(bpf_map_batch_opts, batch_opts,
>> +                   .elem_flags = BPF_F_CPU,
>> +                   .flags = 0,
>> +       );
>> +
>> +       nr_cpus = libbpf_num_possible_cpus();
>> +       if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
>> +               return;
>> +
>> +       skel = percpu_array_flag__open_and_load();
>> +       if (!ASSERT_OK_PTR(skel, "percpu_array_flag__open_and_load"))
>> +               return;
>> +
>> +       map = skel->maps.percpu;
>> +       map_fd = bpf_map__fd(map);
>> +       max_entries = bpf_map__max_entries(map);
>> +
>> +       value_size = value_sz * nr_cpus;
>> +       values = calloc(max_entries, value_size);
>> +       keys = calloc(max_entries, key_sz);
>> +       if (!ASSERT_FALSE(!keys || !values, "calloc keys and values"))
> 
> ASSERT_xxx are meant to be meaningful in the case that some condition
> fails, so using generic ASSERT_FALSE with some complicated condition
> is defeating that purpose. Use two separate ASSERT_OK_PTR checks
> instead.
> 

Got it.

Thanks,
Leon




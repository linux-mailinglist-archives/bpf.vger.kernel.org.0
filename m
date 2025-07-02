Return-Path: <bpf+bounces-62170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C6CAF6001
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48073B28F8
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39781301156;
	Wed,  2 Jul 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kr1IjXAm"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD63253351
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477379; cv=none; b=FtoD9/qCawWzMRGXBqeJADg2Wgim1hIQ9kotYs8TPbHYReP2QCvpS4ujQY1HFscB9FvrR97XtdAOh0A3RiMIUCxtPp2PPfbPpMnsS/ogCEWCNzcu4Uh1wNCqt720BqhVYPvpbySBnMSxvwv2720TsW85Np8JBUSaDia8lpuDMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477379; c=relaxed/simple;
	bh=pg1Av2E6D/3YwDG8DMrj0bSFdT034Xi2IyphEiMj9cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9hRzc0zu08LaqbSKgA4mYL69Zv+SbeQEDTGIb5QJPUDI9P5ULr9cJ1z5ZhTjKB+7bq6oJoNeTMqtse9NjaH0w19FOJwWryDevf660pQn96jgFM8/C0rtzuVqybxF9S1zGx6aYSK4ea4XRxo/pOxggEvV7OmeaUDg6+92GmvWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kr1IjXAm; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <23502034-2a8c-4ab0-b23d-be8878e8d04a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751477373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjOUbqkmYmPzNslH6gh7lYifWx4kyrVvLtxs6Ogmww8=;
	b=Kr1IjXAmToAYN8ryicrI/UR626BiUepKEhrnY+Wc/9Mj135JUkIQofzc2r3I/va343Dm1i
	tq9yaRmilmw/ecEvPvGFAYA0Lq9AN8z4hkydtnoPELjh9hSP1CNCNKFvINN6Vt3GHWJLxr
	k/4SvT931H+I+17nPNyIVxUv/J4nUiw=
Date: Thu, 3 Jul 2025 01:29:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: Add case to test
 BPF_F_CPU
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net
References: <20250624165354.27184-1-leon.hwang@linux.dev>
 <20250624165354.27184-4-leon.hwang@linux.dev>
 <CAEf4BzYkqPO-cGVv7FomXZinSYNE5q78+dRoiVZAtWaJ4MNJNg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYkqPO-cGVv7FomXZinSYNE5q78+dRoiVZAtWaJ4MNJNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/2 04:22, Andrii Nakryiko wrote:
> On Tue, Jun 24, 2025 at 9:55 AM Leon Hwang <leon.hwang@linux.dev> wrote:
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
>> 251/5   percpu_alloc/cpu_flag_tests:OK
>> 251     percpu_alloc:OK
>> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  .../selftests/bpf/prog_tests/percpu_alloc.c   | 169 ++++++++++++++++++
>>  .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
>>  2 files changed, 193 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
>> index 343da65864d6..5727f4601b49 100644
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
>> @@ -115,6 +116,172 @@ static void test_failure(void) {
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
>> +       DECLARE_LIBBPF_OPTS(bpf_map_lookup_elem_opts, lookup_opts,
>> +                           .flags = BPF_F_CPU,
>> +                           .cpu = 0,
>> +       );
> 
> use shorter LIBBPF_OPTS macro, please
> 

Ack.

[...]

Thanks,
Leon




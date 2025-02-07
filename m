Return-Path: <bpf+bounces-50755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E94A2C015
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 11:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDDC3A391F
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7549D1D63EB;
	Fri,  7 Feb 2025 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GMLJn49r"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612318FDD8
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922426; cv=none; b=Lz4Ne2R8mMQdARXVNkdDWmPslYfKVXaUOW+YjFLWXXjDDqBEh879uvE2G/g0XVtfuFMC9MNEBmRHvzoR1Plo4QNSMWEyBTvzv4s7tK7lxJoC7jICqV5hJvqQ1hjtN1sozNvd7y60S404WZE6aghoRiR+4bp/eQJTvB/6uyedTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922426; c=relaxed/simple;
	bh=NAuXT/JMwzWMgYCXMuUTtoJ019ZU6m9hBh2ollc//ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWOMiGN+Mt3KByegD+5+6BbbB0BmDcyqNNrGNQy3e22uvh7w2bioY8S/HUJRLlQpnnwcyLyjtIMQ5vJRmS5SS5tuj2+vDg4IWJ6GUIPIm7/Dr7CCvJChrJxfuQQv0sGkKeQ1rJ+7G37z4PRhkNqdy/NmDjgpejY2L0dl/NOd4rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GMLJn49r; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8e25e1e9-37a0-4d4c-8af9-c2d5e12af65f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738922419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VQy07xF3mUJXO3v99TsIHqW0uzkTmTb6YWZTO7bx1s=;
	b=GMLJn49rJqY2SoFUCo9m8jPZJEZV0CXzmN27aaDNnh7Imd7TmyARKNF/nCLwh3vFQc96OD
	OJNzqGm3oDJWbdeO/ONcquEu6g/2Ecjxj+h8Gi08x06POp35TW/gqCc9vHim1YKBtZB7M5
	caQOynq6sWMv3hIMT2zo39wEvz74a50=
Date: Fri, 7 Feb 2025 18:00:05 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYXCQi4HMvegMmsx-ppxprwNVyKohJgka8gY_B+gMy+mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/2/25 08:09, Andrii Nakryiko wrote:
> On Mon, Jan 27, 2025 at 8:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> If the arch, like s390x, does not support percpu insn, this case won't
>> test global percpu data by checking -EOPNOTSUPP when load prog.
>>
>> The following APIs have been tested for global percpu data:
>> 1. bpf_map__set_initial_value()
>> 2. bpf_map__initial_value()
>> 3. generated percpu struct pointer that points to internal map's data
>> 4. bpf_map__lookup_elem() for global percpu data map
>>
>> cd tools/testing/selftests/bpf; ./test_progs -t global_percpu_data
>> 124     global_percpu_data_init:OK
>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  .../bpf/prog_tests/global_data_init.c         | 89 ++++++++++++++++++-
>>  .../bpf/progs/test_global_percpu_data.c       | 21 +++++
>>  2 files changed, 109 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index 8466332d7406f..a5d0890444f67 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include <test_progs.h>
>> +#include "test_global_percpu_data.skel.h"
>>
>>  void test_global_data_init(void)
>>  {
>> @@ -8,7 +9,7 @@ void test_global_data_init(void)
>>         __u8 *buff = NULL, *newval = NULL;
>>         struct bpf_object *obj;
>>         struct bpf_map *map;
>> -        __u32 duration = 0;
>> +       __u32 duration = 0;
>>         size_t sz;
>>
>>         obj = bpf_object__open_file(file, NULL);
>> @@ -60,3 +61,89 @@ void test_global_data_init(void)
>>         free(newval);
>>         bpf_object__close(obj);
>>  }
>> +
>> +void test_global_percpu_data_init(void)
>> +{
>> +       struct test_global_percpu_data *skel = NULL;
>> +       u64 *percpu_data = NULL;
> 
> there is that test_global_percpu_data__percpu type you are declaring
> in the BPF skeleton, right? We should try using it here.
> 

No. bpftool does not generate test_global_percpu_data__percpu. The
struct for global variables is embedded into skeleton struct.

Should we generate type for global variables?

> And for that array access, we should make sure that it's __aligned(8),
> so indexing by CPU index works correctly.
> 

Ack.

> Also, you define per-CPU variable as int, but here it is u64, what's
> up with that?
> 

Like __aligned(8), it's to make sure 8-bytes aligned. It's better to use
__aligned(8).

>> +       struct bpf_map *map;
>> +       size_t init_data_sz;
>> +       char buff[128] = {};
>> +       int init_value = 2;
>> +       int key, value_sz;
>> +       int prog_fd, err;
>> +       int *init_data;
>> +       int num_cpus;
>> +
> 
> nit: LIBBPF_OPTS below is variable declaration, so there shouldn't be
> an empty line here (and maybe group those int variables a bit more
> tightly?)
> 

Ack.

>> +       LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +                   .data_in = buff,
>> +                   .data_size_in = sizeof(buff),
>> +                   .repeat = 1,
>> +       );
>> +
>> +       num_cpus = libbpf_num_possible_cpus();
>> +       if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
>> +               return;
>> +
>> +       percpu_data = calloc(num_cpus, sizeof(*percpu_data));
>> +       if (!ASSERT_FALSE(percpu_data == NULL, "calloc percpu_data"))
> 
> ASSERT_OK_PTR()
> 

Ack.

>> +               return;
>> +
>> +       value_sz = sizeof(*percpu_data) * num_cpus;
>> +       memset(percpu_data, 0, value_sz);
> 
> you calloc()'ed it, it's already zero-initialized
> 

Ack. Thanks. I should check "man calloc" to use it.

> 
>> +
>> +       skel = test_global_percpu_data__open();
>> +       if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
>> +               goto out;
>> +
>> +       ASSERT_EQ(skel->percpu->percpu_data, -1, "skel->percpu->percpu_data");
>> +
>> +       map = skel->maps.percpu;
>> +       err = bpf_map__set_initial_value(map, &init_value,
>> +                                        sizeof(init_value));
>> +       if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
>> +               goto out;
>> +
>> +       init_data = bpf_map__initial_value(map, &init_data_sz);
>> +       if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
>> +               goto out;
>> +
>> +       ASSERT_EQ(*init_data, init_value, "initial_value");
>> +       ASSERT_EQ(init_data_sz, sizeof(init_value), "initial_value size");
>> +
>> +       if (!ASSERT_EQ((void *) init_data, (void *) skel->percpu, "skel->percpu"))
>> +               goto out;
>> +       ASSERT_EQ(skel->percpu->percpu_data, init_value, "skel->percpu->percpu_data");
>> +
>> +       err = test_global_percpu_data__load(skel);
>> +       if (err == -EOPNOTSUPP)
>> +               goto out;
>> +       if (!ASSERT_OK(err, "test_global_percpu_data__load"))
>> +               goto out;
>> +
>> +       ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY,
>> +                 "bpf_map__type");
>> +
>> +       prog_fd = bpf_program__fd(skel->progs.update_percpu_data);
>> +       err = bpf_prog_test_run_opts(prog_fd, &topts);
> 
> at least one of BPF programs (don't remember which one, could be
> raw_tp) supports specifying CPU index to run on, it would be nice to
> loop over CPUs, triggering BPF program on each one and filling per-CPU
> variable with current CPU index. Then we can check that all per-CPU
> values have expected values.
> 

Do you mean prog_tests/perf_buffer.c::trigger_on_cpu()?

Your suggestion looks good to me. I'll do it.

> 
>> +       ASSERT_OK(err, "update_percpu_data");
>> +       ASSERT_EQ(topts.retval, 0, "update_percpu_data retval");
>> +
>> +       key = 0;
>> +       err = bpf_map__lookup_elem(map, &key, sizeof(key), percpu_data,
>> +                                  value_sz, 0);
>> +       if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
>> +               goto out;
>> +

[...]

Thanks,
Leon




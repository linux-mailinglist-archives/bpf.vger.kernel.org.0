Return-Path: <bpf+bounces-67711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD1CB48F4C
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4072F3A86CD
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B452C30ACF6;
	Mon,  8 Sep 2025 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S42IIeaY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4002F0C6E
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337702; cv=none; b=K9GxdjWjTzy6bMhSYqTESTM0SxYRrhRWmTqkCBZ/G+QqUs4R1tUZoHcG9zRcrp2sG/MIemsqvFl1AAxmy4I4a8NjfAiMm1L6ruWS8rP6Icsc1rXR+d3dfmJIvy/uzv4H8EXGKfY8OF84byuZZQQUiVKGXs05i21wkKarN8l5qBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337702; c=relaxed/simple;
	bh=wMobiXS+llmRFQtHQdpu084l2oqxJ1/TZWDFzbSUvf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMJOrBxqsE/3J6WMHWCI+aBcKZxbr7wM5UOMoXKMFAi1mtjVAyvKVm0F21/33EmS6DDs82rLHvCA7ZB5Vr+lT6L7e7GW0SjGU5k/9z1A/Mq9ovb0K8Z3PIvXacnyI4jA1QvgrAp3Hawn64S6rSkF0PkSPcj5rXe4Y/LWeuNOIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S42IIeaY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e014bf8ec1so3082405f8f.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757337699; x=1757942499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlydmuhN3b0kYubSBHUuzRlWmW3hZscKKK1AGktyDl0=;
        b=S42IIeaYNj60uCMvr7Uf7zHROPQLwtHnzTRwfwLQVZvDhONJbX1agjhgG089/y8b5A
         9IPMRrNGXop+Sd8rexnvNcYyIoMz/qvUowb2ENUBgWz8E3bSJOm0Sfou3QsI/DP8C5Er
         kwrr1goelUWjzynxUFOYq0lL2v72WxVBnhG4YS4EzRnFOrOFptrcwOvAP4eKDvQUa6zp
         ZlcBYNdse3k0vanp4kjMOunu2RwAZvxDKmv4KuqMBH/ilDVUjd6dWoxpAUmsabxHPI9y
         BCsQyo+I4nspr9h4rGqGGdDCNcJ3Ytb4wlB2tTXmNVHALHDtmjBvAHfEXlO9p2F249JX
         J5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337699; x=1757942499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlydmuhN3b0kYubSBHUuzRlWmW3hZscKKK1AGktyDl0=;
        b=BCLmtOrJsjvdCXrnXioM24terhd04wP6uWWImt4+vPphk79hMSkOXtP3j6Vq4B8EpJ
         h/s76xzEM20dNs6LMcntoLKuLNto9yU0iG3eerKn2veoMvHikmMMJ96zepgtJ4cWbnik
         12sgYUeRQFru3uDI1Tk3Jsbv7vGGyhENu2HfFfZz+WZAqhmSBPBg4U1kcgR1jfMCXLOJ
         wFKbxLp2Rl9nxulCJ1bV00ipy6RhbWEeqboGko6CTx/YE6kaRh9hHWfwHb7AP6jYMYIP
         K+U8DAS3CHKcmMY5KPBiyMu2qdu1lKhSwhb3kINAS/nqO8PRs54lJiJx4FrSx0s+gSoH
         DTWw==
X-Forwarded-Encrypted: i=1; AJvYcCUNOc15bWrKehwMGfD3b9xSKQynEbB0AIPema8Afbwy6cTjtCzWCz4jsRlpTEhAe7LKsGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzet7WesifvddocfvQzGSI7CVskXCVSVdowITKwRNxPWPrWAnL2
	9n6Clj6HdVoFvu6uzYXGYkX+HJ/mBRb1PLlk7MFdX+HXkI/a0WhKj7hu
X-Gm-Gg: ASbGnctLE77hY1FIESX4idVYxEf08CoxGFEOVIQsTD5pSXkUssRew8lL4pnRcabtVwR
	cogVBzXdZNhl0RCZMiN8qYesD1HBzw/khr3OetgFzPpQ1XAxOTzw8ueQ56a1wxAPpKndu4fJ0/x
	hishFzJz/FREc/Mwyd5DJIZJTqsvNwzypKXfa8ROXPyGffe8QQMZtUKOuuHithvO9y7FgpkBDH0
	XREIu9JA43zmrl0r2oAGlBkJTewWIfhUzUJLbMfjQv6xmdDchKNR1vmIEnNKXG0ZBgR1x3bG/H7
	EwD3IlQ3w3XoFHlmugKymbfu+CsFsjpESC41CfqFknI4Afs7Aa2JbP3TVYqBa8qI8zi+/RUTZiz
	N5WhKsHOna/xOp4A+19GZZ5gZuifIp3S2eCnX3qo87xMm9jybx/HArkpb/NUDf/HMmhDvtUwAjx
	SuJSKdV5+o
X-Google-Smtp-Source: AGHT+IEj7Ijxi8G1wTZEW3sxA77a4kqC5tqlRUPXqKujtNMZ3yPcfhJum3WaSXJfAQ4LO/fCJ1Bdtg==
X-Received: by 2002:a05:6000:401f:b0:3e7:4991:87c4 with SMTP id ffacd0b85a97d-3e749918b76mr2220276f8f.61.1757337698472;
        Mon, 08 Sep 2025 06:21:38 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:3b00:aa66:6df5:e693? ([2620:10d:c092:500::5:c63f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e70d463163sm8398854f8f.22.2025.09.08.06.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:21:38 -0700 (PDT)
Message-ID: <e42913c0-811c-43bb-a570-9f903529ad91@gmail.com>
Date: Mon, 8 Sep 2025 14:21:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 7/7] selftests/bpf: BPF task work scheduling
 tests
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-8-mykyta.yatsenko5@gmail.com>
 <6bc24eca4d2abdec108f2013c2e414e24d48642f.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <6bc24eca4d2abdec108f2013c2e414e24d48642f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 08:43, Eduard Zingerman wrote:
> On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introducing selftests that check BPF task work scheduling mechanism.
>> Validate that verifier does not accepts incorrect calls to
>> bpf_task_work_schedule kfunc.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> The test cases in this patch check functional correctness, but there
> is no attempt to do some stress testing of the state machine.
> E.g. how hard/feasible would it be to construct a test that attempts
> to exercise both branches of the (state == BPF_TW_SCHEDULED) in the
> bpf_task_work_cancel_and_free()?
Good point, I have stress test, but did not include it in the patches, 
as it takes longer to run.
I had to add logs in the kernel code to make sure cancellation/freeing 
branches are hit.
https://github.com/kernel-patches/bpf/commit/86408b074ab0a2d290977846c3e99a07443ac604
>
>>   .../selftests/bpf/prog_tests/test_task_work.c | 149 ++++++++++++++++++
>>   tools/testing/selftests/bpf/progs/task_work.c | 108 +++++++++++++
>>   .../selftests/bpf/progs/task_work_fail.c      |  98 ++++++++++++
>>   3 files changed, 355 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>> new file mode 100644
>> index 000000000000..9c3c7a46a827
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>> @@ -0,0 +1,149 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +#include <test_progs.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include "task_work.skel.h"
>> +#include "task_work_fail.skel.h"
>> +#include <linux/bpf.h>
>> +#include <linux/perf_event.h>
>> +#include <sys/syscall.h>
>> +#include <time.h>
>> +
>> +static int perf_event_open(__u32 type, __u64 config, int pid)
>> +{
>> +	struct perf_event_attr attr = {
>> +		.type = type,
>> +		.config = config,
>> +		.size = sizeof(struct perf_event_attr),
>> +		.sample_period = 100000,
>> +	};
>> +
>> +	return syscall(__NR_perf_event_open, &attr, pid, -1, -1, 0);
>> +}
>> +
>> +struct elem {
>> +	char data[128];
>> +	struct bpf_task_work tw;
>> +};
>> +
>> +static int verify_map(struct bpf_map *map, const char *expected_data)
>> +{
>> +	int err;
>> +	struct elem value;
>> +	int processed_values = 0;
>> +	int k, sz;
>> +
>> +	sz = bpf_map__max_entries(map);
>> +	for (k = 0; k < sz; ++k) {
>> +		err = bpf_map__lookup_elem(map, &k, sizeof(int), &value, sizeof(struct elem), 0);
>> +		if (err)
>> +			continue;
>> +		if (!ASSERT_EQ(strcmp(expected_data, value.data), 0, "map data")) {
>> +			fprintf(stderr, "expected '%s', found '%s' in %s map", expected_data,
>> +				value.data, bpf_map__name(map));
>> +			return 2;
>> +		}
>> +		processed_values++;
>> +	}
>> +
>> +	return processed_values == 0;
> Nit: check for exact number of expected values here?
>
>> +}
>> +
>> +static void task_work_run(const char *prog_name, const char *map_name)
>> +{
>> +	struct task_work *skel;
>> +	struct bpf_program *prog;
>> +	struct bpf_map *map;
>> +	struct bpf_link *link;
>> +	int err, pe_fd = 0, pid, status, pipefd[2];
>> +	char user_string[] = "hello world";
>> +
>> +	if (!ASSERT_NEQ(pipe(pipefd), -1, "pipe"))
>> +		return;
>> +
>> +	pid = fork();
> Nit: check for negative return value?
>
>> +	if (pid == 0) {
>> +		__u64 num = 1;
>> +		int i;
>> +		char buf;
>> +
>> +		close(pipefd[1]);
>> +		read(pipefd[0], &buf, sizeof(buf));
>> +		close(pipefd[0]);
>> +
>> +		for (i = 0; i < 10000; ++i)
>> +			num *= time(0) % 7;
>> +		(void)num;
>> +		exit(0);
>> +	}
>> +	skel = task_work__open();
>> +	if (!ASSERT_OK_PTR(skel, "task_work__open"))
>> +		return;
>> +
>> +	bpf_object__for_each_program(prog, skel->obj) {
>> +		bpf_program__set_autoload(prog, false);
>> +	}
>> +
>> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
>> +	if (!ASSERT_OK_PTR(prog, "prog_name"))
>> +		goto cleanup;
>> +	bpf_program__set_autoload(prog, true);
>> +	bpf_program__set_type(prog, BPF_PROG_TYPE_PERF_EVENT);
> Nit: this is not really necessary, the programs are already defined as
>       SEC("perf_event").
>
>> +	skel->bss->user_ptr = (char *)user_string;
>> +
>> +	err = task_work__load(skel);
>> +	if (!ASSERT_OK(err, "skel_load"))
>> +		goto cleanup;
> [...]



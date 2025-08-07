Return-Path: <bpf+bounces-65168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66BB1CFA7
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 02:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C195675CC
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 00:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C282E36F7;
	Thu,  7 Aug 2025 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RKbhILfH"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAAB38B
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754525062; cv=none; b=TMH/br/rVsPcJG6YFztd66ykjdwJSI45SR+uu3fKtHKEdWbmC7kfaPmc+uOTgOIVatHhTNoQo/iTcssxYMG2S3dcLveoNOe6OXOy/QUX9542/40ezZD0lGTlzlnhRqs/KfE5hiS3DkVRoWRrovBwKePB0UfQPWuy5pxX9rJ1K+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754525062; c=relaxed/simple;
	bh=u9kr1aqM3y+cZidOGnU996KeK1axlGaIlmnbnIEialE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k5oTnqs29tGPcmigRSa0m6otvUmBWMXyWOL50i78WB5taCvWIcrnEi5RPZsA95CceQLjgyC9zbTbiZkJuk4Ktj5Jv+2FHVe8DnWN3bZR7QuGp34SZ/mt5TVl6Pv70LXK2/2z84269t7nISBeEPCZFzGtxuPYaZ28KQTdFYbayFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RKbhILfH; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34ce4521-6dac-4f78-a049-e6bc928cbd28@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754525055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opGXJ8X3/uO9DzkcFZyR4GjTzRVdhm2PquEHtSssYqc=;
	b=RKbhILfHgzAMEKqy6gVysTfWwtXWP0iBUYCZCVPZAYYFwqj1Kjbb0d6V1VZfZvvYvWQkLR
	qSXwri4Mo7YWIZHu1k0QnBpWR6JwNtmH2P/nEYBPTMtt28D4MMygzIllDfOZe0dmqsoCP5
	NOP5k1+IIkFOntQFr2QYyJ89V9ZwLMA=
Date: Wed, 6 Aug 2025 17:04:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add tests for arena fault
 reporting
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
References: <20250806085847.18633-1-puranjay@kernel.org>
 <20250806085847.18633-4-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250806085847.18633-4-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 1:58 AM, Puranjay Mohan wrote:
> Add selftests for testing the reporting of arena page faults through BPF
> streams. Two new bpf programs are added that read and write to an
> unmapped arena address and the fault reporting is verified in the
> userspace through streams.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   .../testing/selftests/bpf/prog_tests/stream.c | 24 ++++++++++++
>   tools/testing/selftests/bpf/progs/stream.c    | 37 +++++++++++++++++++
>   2 files changed, 61 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
> index d9f0185dca61b..4bdde56de35b1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> @@ -41,6 +41,22 @@ struct {
>   		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>   		"|[ \t]+[^\n]+\n)*",
>   	},
> +	{
> +		offsetof(struct stream, progs.stream_arena_read_fault),
> +		"ERROR: Arena READ access at unmapped address 0x.*\n"
> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> +		"Call trace:\n"
> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> +		"|[ \t]+[^\n]+\n)*",
> +	},
> +	{
> +		offsetof(struct stream, progs.stream_arena_write_fault),
> +		"ERROR: Arena WRITE access at unmapped address 0x.*\n"
> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> +		"Call trace:\n"
> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> +		"|[ \t]+[^\n]+\n)*",
> +	},
>   };
>   
>   static int match_regex(const char *pattern, const char *string)
> @@ -85,6 +101,14 @@ void test_stream_errors(void)
>   			continue;
>   		}
>   #endif
> +#if !defined(__x86_64__) && !defined(__aarch64__)
> +		ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
> +		if (i == 2 || i == 3) {
> +			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
> +			ASSERT_EQ(ret, 0, "stream read");
> +			continue;
> +		}
> +#endif
>   
>   		ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
>   		ASSERT_GT(ret, 0, "stream read");
> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
> index 35790897dc879..58ebff60cd96a 100644
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
> @@ -1,10 +1,15 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#define BPF_NO_KFUNC_PROTOTYPES

Do we have to defineBPF_NO_KFUNC_PROTOTYPES in the above? Without the above, we do not need 
below extern bpf_res_spin_lock and bpf_res_spin_unlock.

>   #include <vmlinux.h>
>   #include <bpf/bpf_tracing.h>
>   #include <bpf/bpf_helpers.h>
>   #include "bpf_misc.h"
>   #include "bpf_experimental.h"
> +#include "bpf_arena_common.h"
> +
> +extern int bpf_res_spin_lock(struct bpf_res_spin_lock *lock) __weak __ksym;
> +extern void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock) __weak __ksym;
>   
>   struct arr_elem {
>   	struct bpf_res_spin_lock lock;
> @@ -17,6 +22,12 @@ struct {
>   	__type(value, struct arr_elem);
>   } arrmap SEC(".maps");
>   
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 1); /* number of pages */
> +} arena SEC(".maps");
> +
>   #define ENOSPC 28
>   #define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
>   
> @@ -76,4 +87,30 @@ int stream_syscall(void *ctx)
>   	return 0;
>   }
>   
> +SEC("syscall")
> +__success __retval(0)
> +int stream_arena_write_fault(void *ctx)
> +{
> +	unsigned char __arena *page;
> +
> +	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	bpf_arena_free_pages(&arena, page, 1);
> +
> +	*(page + 0xbeef) = 1;
> +
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__success __retval(0)
> +int stream_arena_read_fault(void *ctx)
> +{
> +	unsigned char __arena *page;
> +
> +	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	bpf_arena_free_pages(&arena, page, 1);
> +
> +	return *(page + 0xbeef);
> +}
> +
>   char _license[] SEC("license") = "GPL";



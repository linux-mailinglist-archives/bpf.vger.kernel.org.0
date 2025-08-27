Return-Path: <bpf+bounces-66708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546DCB38A87
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09507361842
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B2A2D24B2;
	Wed, 27 Aug 2025 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pedpDSIh"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9230CDA1
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324514; cv=none; b=WMs0TxlMPXJZgQ5gyQ1WmJdn4cbD1dHpNKrWLu8H2klEsNofdAQ0gB3Oo17yEZ+suUGQhWT+6VKPutq/jvHl+ubN9qaY9NDZ7SJaIiO52lsIAhbNT48+a741uAxk2xcejNdZv1DfULMOetB1zPs2q4rWxchYYVVuTZ9MGeb3qaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324514; c=relaxed/simple;
	bh=knVDv2gHjeFCpsZrkdAVD95y84M7Y5b/LgXbDA+wWMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=km/nq0I6CjeVnfVA8qotFg/2jizzdD6V0/1mDPTVU9xw0ckY2UxDUEbIhyfOav+9KKBcq7hhQqKiMQ4kBxSz/AWECaaoByWAKKC05YVYkc6a2VLJdvBHfFTD8R5aQVOGzPWLkrhgoxtlCoRfdp5ln43bg+ppuKVIdCRVFRxYBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pedpDSIh; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <543975dd-6173-455d-a1a0-aca7806c2b31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756324509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cky024Mih/Q5fhHYTBZfoqgSTqM8t9yxQ8BaNSiayyg=;
	b=pedpDSIh+/e6A5b7hRw/+guAFejzA+CMJPNlMCJCq7A4gWwxc2TNe+gULbLqsNPuMBVEcP
	siGZEh/bPhBPO/oNobH8aMq7px8dr0w/O1mcx8jBaBujexcyHJzdfaX6PudtYUREG4YXZQ
	kqXQAhgJ8e/sFg1sUQLoV9G3epfcopo=
Date: Wed, 27 Aug 2025 12:54:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add tests for arena fault
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
References: <20250827153728.28115-1-puranjay@kernel.org>
 <20250827153728.28115-4-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250827153728.28115-4-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/27/25 8:37 AM, Puranjay Mohan wrote:
> Add selftests for testing the reporting of arena page faults through BPF
> streams. Two new bpf programs are added that read and write to an
> unmapped arena address and the fault reporting is verified in the
> userspace through streams.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   .../testing/selftests/bpf/prog_tests/stream.c | 33 +++++++++++++++-
>   tools/testing/selftests/bpf/progs/stream.c    | 39 +++++++++++++++++++
>   2 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
> index 36a1a1ebde692..8fdc83260ea14 100644
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
> @@ -63,6 +79,7 @@ void test_stream_errors(void)
>   	struct stream *skel;
>   	int ret, prog_fd;
>   	char buf[1024];
> +	char fault_addr[64] = {0};

You can replace '{0}' to '{}' so the whole array will be initialized.

>   
>   	skel = stream__open_and_load();
>   	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> @@ -85,6 +102,14 @@ void test_stream_errors(void)
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
> @@ -92,8 +117,14 @@ void test_stream_errors(void)
>   		buf[ret] = '\0';
>   
>   		ret = match_regex(stream_error_arr[i].errstr, buf);
> -		if (!ASSERT_TRUE(ret == 1, "regex match"))
> +		if (ret && (i == 2 || i == 3)) {
> +			sprintf(fault_addr, "0x%lx", skel->bss->fault_addr);
> +			ret = match_regex(fault_addr, buf);
> +		}
> +		if (!ASSERT_TRUE(ret == 1, "regex match")) {
>   			fprintf(stderr, "Output from stream:\n%s\n", buf);
> +			fprintf(stderr, "Fault Addr: 0x%lx\n", skel->bss->fault_addr);

This will fault addr even for i == 0 or i == 1 and those address may be confusing
for test 0/1.

> +		}
>   	}
>   
>   	stream__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
> index 35790897dc879..9de015ac3ced5 100644
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
> @@ -5,6 +5,7 @@
>   #include <bpf/bpf_helpers.h>
>   #include "bpf_misc.h"
>   #include "bpf_experimental.h"
> +#include "bpf_arena_common.h"
>   
>   struct arr_elem {
>   	struct bpf_res_spin_lock lock;
> @@ -17,10 +18,17 @@ struct {
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
>   int size;
> +u64 fault_addr;
>   
>   SEC("syscall")
>   __success __retval(0)
> @@ -76,4 +84,35 @@ int stream_syscall(void *ctx)
>   	return 0;
>   }
>   
> +SEC("syscall")
> +__success __retval(0)
> +int stream_arena_write_fault(void *ctx)
> +{
> +	struct bpf_arena *ptr = (void *)&arena;
> +	u64 user_vm_start;
> +
> +	barrier_var(ptr);

Do we need this barrier_var()? I tried llvm20 and it works fine without the
above barrier_var().

> +	user_vm_start =  ptr->user_vm_start;
> +

Remove this line.

> +	fault_addr = user_vm_start + 0xbeef;
> +	*(u32 __arena *)(user_vm_start + 0xbeef) = 1;

Simplify to *(u32 __arena *)fault = 1;

> +

Remove this line.

> +	return 0;
> +}
> +
> +SEC("syscall")
> +__success __retval(0)
> +int stream_arena_read_fault(void *ctx)
> +{
> +	struct bpf_arena *ptr = (void *)&arena;
> +	u64 user_vm_start;
> +
> +	barrier_var(ptr);

Is this necessary?

> +	user_vm_start =  ptr->user_vm_start;
> +

Remove this line.

> +	fault_addr = user_vm_start + 0xbeef;
> +

Remove this line.

> +	return *(u32 __arena *)(user_vm_start + 0xbeef);

return*(u32 __arena *)fault_addr.

> +}
> +
>   char _license[] SEC("license") = "GPL";



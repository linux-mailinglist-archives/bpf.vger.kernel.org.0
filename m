Return-Path: <bpf+bounces-35707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EBC93CE10
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 08:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205A2281F17
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 06:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F00E17334E;
	Fri, 26 Jul 2024 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BsxghaV/"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D4A2A
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974604; cv=none; b=ftBpfZxfJ6pnYcAkmJBExmsyl2Cp3pXzq0CxfTUzV5QAoRklOIpB2RILTs0mrvPvyZbAPFgCLzNDE3nioGxCLC6lVNd1gCVLguNWOBh6t9nBoSq6M4Am9yU2VEqlq0l1pmejoMb72uY80BHo1WH/zta3qWum6cAyVA5GaDYlWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974604; c=relaxed/simple;
	bh=ls5/zZvJVFzgVwY5XKQ3hy3KCEu3Puw+UaGV6cOEjMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WousGCNWVh0BqedjgU24Ph9SUJ7ZLlUUWwlR7rthKOGwPse8G7uZn1Ni6BM+R6+WOu8O7M6WyZEPiV+nxwvb4TB4E2MBmuEDUIrYasddzR9aTyphwi5htW/gqX4K5l9WZOKofhBpLLYgo17+SV+WejhsrrD4DCCtGk6txg3ers8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BsxghaV/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb964de3-1a07-49a3-9d26-68777e1fc1cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721974600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFk2Cu5udvnV2eaHK7fvFGxZYw/OjSXogUPZPtG1TzM=;
	b=BsxghaV/hTkr9Rl5jmBkTuSRdBOMje20hO8l7QkhTF+5unOAXrnVwlugZBn1TFidnWV7tW
	8DOX7E/K8mCOMt8GUOFFtmb/rpjLHxxau/wI2Xy/x4EI4Qm8jDtesBVkrtSicBei2zcR9C
	SfExPiSXvjx6zcindHinqX8FywuUjiw=
Date: Thu, 25 Jul 2024 23:16:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add testcase for updating
 attached freplace prog to PROG_ARRAY map
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
References: <20240725003251.37855-1-leon.hwang@linux.dev>
 <20240725003251.37855-3-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240725003251.37855-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/24/24 5:32 PM, Leon Hwang wrote:
> Add a selftest to confirm the issue, which gets -EINVAL when update
> attached freplace prog to PROG_ARRAY map, has been fixed.
>
> cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
> 327/25  tailcalls/tailcall_freplace:OK
> 327     tailcalls:OK
> Summary: 1/25 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   .../selftests/bpf/prog_tests/tailcalls.c      | 76 ++++++++++++++++++-
>   .../selftests/bpf/progs/tailcall_freplace.c   | 33 ++++++++
>   .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 23 ++++++
>   3 files changed, 131 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
>   create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
>
[...]
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_freplace.c b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
> new file mode 100644
> index 0000000000000..80b5fa386ed9c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_legacy.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +	__uint(max_entries, 1);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +} jmp_table SEC(".maps");
> +
> +int count = 0;
> +
> +__noinline
> +int subprog(struct __sk_buff *skb)
> +{
> +	count++;
> +
> +	bpf_tail_call_static(skb, &jmp_table, 0);
> +
> +	return count;
> +}
> +
> +SEC("freplace")
> +int entry(struct __sk_buff *skb)
> +{
> +	return subprog(skb);
> +}
> +
> +char __license[] SEC("license") = "GPL";
> +

extra line in the above.

> diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
> new file mode 100644
> index 0000000000000..4810961554585
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_legacy.h"
> +
> +__noinline
> +int subprog(struct __sk_buff *skb)
> +{
> +	volatile int ret = 1;
> +
> +	asm volatile (""::"r+"(ret));
> +	return ret;
> +}
> +
> +SEC("tc")
> +int entry(struct __sk_buff *skb)
> +{
> +	return subprog(skb);
> +}
> +
> +char __license[] SEC("license") = "GPL";
> +

extra line in the above.



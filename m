Return-Path: <bpf+bounces-47160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 375EE9F5C2A
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 02:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12C418928A8
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBB935947;
	Wed, 18 Dec 2024 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F6q28UA0"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCB517C91
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484659; cv=none; b=buBQVjGVXmRUeG1pVQSQcw/AOsfd6dl2kFgNFKcs2fEwCc/QSYusi0l55Mq+PPEwHpd/LsYXcxaKzsxpXbebWqbtNbrDp7DhKBBl4q2BPPFUN/fN4/y/dbrqvVFo1CVPYOCiikJpHY6KPhVzHITY8EufBdphPBtUISeu7yo5zuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484659; c=relaxed/simple;
	bh=Zuw7hhg9RZftvi6A6T4cCTpLz/VwZ/kfKNU3DTMTYzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDk2E/TotkccI/VDBm+QhH5vzvGPyT81Nf9eqaymdHQrlhnZ+T+6qO+htXFKDsNoFuU6CiBnX6ewVKwgausqWGOP8BPbFezdUe8ATErMrMsg7ShWjaMr3e/T7xuT5bLft1oVGbVE6MtdLKr6CXpWOaKoc2cgSM9YbA5yBoBWcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F6q28UA0; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <455a554d-fe8f-4c9e-b1d9-654897da92ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734484655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yIbVoKISKD4E2y+6Uz6GlSqMEVXzJDO7HFKRGxrSj8A=;
	b=F6q28UA0nzi0H7mSZ76q1SRSg+2nOTIe8YwbbtaLMM3lcu17UQJHreq4F39U8YAc40y3JB
	uiYQ7M6znzCDeYWrm7qj5BQoGt89dqoYns9HKzjkc7ZeXc1RQD1P4lzeh5XHKE0Ea05BrD
	YNlTIbFzeT7U6PtORsBGDknN4I/LShw=
Date: Tue, 17 Dec 2024 17:17:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 02/13] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 ameryhung@gmail.com
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-3-amery.hung@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241213232958.2388301-3-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 3:29 PM, Amery Hung wrote:

> +void test_struct_ops_refcounted(void)
> +{
> +	if (test__start_subtest("refcounted"))
> +		refcounted();
> +	if (test__start_subtest("refcounted_fail__ref_leak"))
> +		refcounted_fail__ref_leak();

test_loader.c could make writing this test easier and it can also test the 
verifier failure message. e.g. for the ref_leak test, the following should do:

	RUN_TESTS(struct_ops_refcounted_fail__ref_leak);

The same for the other subtests in this patch.
	
> +	if (test__start_subtest("refcounted_fail__global_subprog"))
> +		refcounted_fail__global_subprog();
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c
> new file mode 100644
> index 000000000000..6e82859eb187
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c
> @@ -0,0 +1,17 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") = "GPL";
> +

+#include "bpf_misc.h"

+__failure __msg("Unreleased reference")
> +SEC("struct_ops/test_refcounted")
> +int BPF_PROG(test_refcounted, int dummy,
> +	     struct task_struct *task)
> +{
> +	return 0;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_ref_acquire = {
> +	.test_refcounted = (void *)test_refcounted,
> +};

[ I will stop here for today and will continue the rest tomorrow. ]


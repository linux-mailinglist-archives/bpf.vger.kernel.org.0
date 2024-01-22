Return-Path: <bpf+bounces-19990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B86835B01
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 07:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC75281037
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 06:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CD63C2F;
	Mon, 22 Jan 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cq5jQMg4"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3578F9C4
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905060; cv=none; b=qlaf9lM5nm3ihagpM/SLj8iqtVkVSP65ZDWPyG6XDYR3jSgghfYW2uTRzLfnwjjROepqROf8v+gJlavUhIcvbGnz3W0H/gFOmBNAKxBsBkKQrpBy8pyNC4RRg2F6slUkGKeOgpwdaXKbTm0+gJimwWiYWe/uTdS7cgfms6E6gMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905060; c=relaxed/simple;
	bh=SScfUi//C5ZYNhcwl0wIXUFZfCGhL7nQm00JYt9e7N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e21uKTeoN0VbtDxwyCUb1Pd1d2dRY+8UYzLM1QZALVK9XTVDT2vp25Ta30s7LfwqfRQjE0jEbkVIB2ELebgLvUVngGQmc5wEGVdCvhmSE0bJMov6gu8hXCqv9twvCm8zdHdH3cu8pvKlqS40sqBf8EewS2CktvqMqWKtNPiPzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cq5jQMg4; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f227d88b-963a-4df0-a6bc-ad3b12abe6dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705905056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nytfd9cYSxIzkyb46ALEhPTR7VNtLMYQD9eRRWGEn5M=;
	b=Cq5jQMg4ZAFODSMDK8JV6WQCwADbpvDLfmKgEX2Y0ozYYBbkUg1H49x4UX2VfSlpBADREq
	/3pVQI0QX4ct7hXCJor0Bc7A+RRVpi4IB4UCuybNxiDK39jl9Y0asN9MfMtKYt7Vj3rnEt
	8PWV7KEym7GDqQZlf3iTcTFJZX2cyHo=
Date: Sun, 21 Jan 2024 22:30:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 3/3] selftest/bpf: Test the read of vsyscall page
 under x86-64
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, x86@kernel.org, bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
 Jann Horn <jannh@google.com>, houtao1@huawei.com
References: <20240119073019.1528573-1-houtao@huaweicloud.com>
 <20240119073019.1528573-4-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240119073019.1528573-4-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/18/24 11:30 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Using bpf_probe_read_kernel{_str}() or bpf_probe_read{_str}() to read
> from vsyscall page under x86-64 will trigger oops, so add one test case
> to ensure that the problem is fixed.
>
> Beside those four bpf helpers mentioned above, testing the read of
> vsyscall page by using bpf_probe_read_user{_str} and
> bpf_copy_from_user{_task}() as well.
>
> vsyscall page could be disabled by CONFIG_LEGACY_VSYSCALL_NONE or
> vsyscall=none boot cmd-line, but it doesn't affect the reproduce of the
> problem and the returned error codes.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   .../selftests/bpf/prog_tests/read_vsyscall.c  | 61 +++++++++++++++++++
>   .../selftests/bpf/progs/read_vsyscall.c       | 45 ++++++++++++++
>   2 files changed, 106 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
>   create mode 100644 tools/testing/selftests/bpf/progs/read_vsyscall.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> new file mode 100644
> index 0000000000000..d9247cc89cf3e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2024. Huawei Technologies Co., Ltd */
> +#include "test_progs.h"
> +#include "read_vsyscall.skel.h"
> +
> +#if defined(__x86_64__)
> +/* For VSYSCALL_ADDR */
> +#include <asm/vsyscall.h>
> +#else
> +/* To prevent build failure on non-x86 arch */
> +#define VSYSCALL_ADDR 0UL
> +#endif
> +
> +struct read_ret_desc {
> +	const char *name;
> +	int ret;
> +} all_read[] = {
> +	{ .name = "probe_read_kernel", .ret = -ERANGE },
> +	{ .name = "probe_read_kernel_str", .ret = -ERANGE },
> +	{ .name = "probe_read", .ret = -ERANGE },
> +	{ .name = "probe_read_str", .ret = -ERANGE },
> +	/* __access_ok() will fail */
> +	{ .name = "probe_read_user", .ret = -EFAULT },
> +	/* __access_ok() will fail */
> +	{ .name = "probe_read_user_str", .ret = -EFAULT },
> +	/* access_ok() will fail */
> +	{ .name = "copy_from_user", .ret = -EFAULT },
> +	/* both vma_lookup() and expand_stack() will fail */
> +	{ .name = "copy_from_user_task", .ret = -EFAULT },

The above comments are not clear enough. For example,
'__access_ok() will fail', user will need to
check the source code where __access_ok() is and
this could be hard e.g., for probe_read_user_str().
Another example, 'both vma_lookup() and expand_stack() will fail',
where is vma_lookup()/expand_stack()? User needs to further
check to make sense.

I suggest remove the above comments and add more
detailed explanation in commit messages with callstack
indicating where the fail/error return happens.

> +};
> +
> +void test_read_vsyscall(void)
> +{
> +	struct read_vsyscall *skel;
> +	unsigned int i;
> +	int err;
> +
> +#if !defined(__x86_64__)
> +	test__skip();
> +	return;
> +#endif
> +	skel = read_vsyscall__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "read_vsyscall open_load"))
> +		return;
> +
> +	skel->bss->target_pid = getpid();
> +	err = read_vsyscall__attach(skel);
> +	if (!ASSERT_EQ(err, 0, "read_vsyscall attach"))
> +		goto out;
> +
> +	/* userspace may don't have vsyscall page due to LEGACY_VSYSCALL_NONE,
> +	 * but it doesn't affect the returned error codes.
> +	 */
> +	skel->bss->user_ptr = (void *)VSYSCALL_ADDR;
> +	usleep(1);
> +
> +	for (i = 0; i < ARRAY_SIZE(all_read); i++)
> +		ASSERT_EQ(skel->bss->read_ret[i], all_read[i].ret, all_read[i].name);
> +out:
> +	read_vsyscall__destroy(skel);
> +}
[...]


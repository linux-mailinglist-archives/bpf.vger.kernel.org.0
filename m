Return-Path: <bpf+bounces-43666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D09B838E
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 20:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A59828241C
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5901CC142;
	Thu, 31 Oct 2024 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D1QXhBo5"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A11CBE80
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403480; cv=none; b=W9AKBRaVxmcjCxZeBjNpHn8onEyeHtgKKSAbq+Ogczbawdt82Bzgb/LiGsXacM3MbaFd/Ys4JKDSAbXxmm5wAcHLXFcOgSdLOYmy9iw4jq2+JBrOBwhKjYJhD2xfIGCsQPl9AnXHzdVasNmuhqVB7+KLuxT7FN+CEUPWqhylhUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403480; c=relaxed/simple;
	bh=x3h1fyJ1pPUqVVooqLk6efGUiBoxUPNsWMyaTYfAU3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mN2J/ptMmUGydHdttHHmx7wtZ1l1+nlgHKfeYZBnAVpjzFzfREaLRnObkP1MmtOpq7bLC3caPvY9Alw+Lm0NdphJvavMc889nBDcu8peysCG8dPT0QP6ejkyFODtV1B8MYgL2NH46EBU6snS57g50kk6pV3xJzQ8Es8bN4qMNNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D1QXhBo5; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f138388c-8622-4bac-a5cc-32a753873ddd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730403475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3Vqd+6ytwKqJBpySLmemH518mQd2fj60NRRUY0Z3vE=;
	b=D1QXhBo5nQU23RhztBFl+SSGqglICWx/mH5VNv/6fCjwvLaVgssT4j+0MPMd/svq8C37xW
	ao0eE2/smQewM3pS2l7n2wjT4ZVA2mPwi4CDCQuhsk6pT+xNOlGGtfVfo8pHMWZLsaF6iR
	jolRukZVWN8bS/+0GCuaamNqbIcynmg=
Date: Thu, 31 Oct 2024 12:37:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 9/9] selftests/bpf: Add struct_ops prog
 private stack tests
To: Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20241029221637.264348-1-yonghong.song@linux.dev>
 <20241029221723.268595-1-yonghong.song@linux.dev>
 <ZyLBR8cM_UhrFOBO@slm.duckdns.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZyLBR8cM_UhrFOBO@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/30/24 4:29 PM, Tejun Heo wrote:
> Hello,
>
> On Tue, Oct 29, 2024 at 03:17:23PM -0700, Yonghong Song wrote:
>> The third test is the same callback function recursing itself. At run time,
>> the jit trampoline recursion check kicks in to prevent the recursion.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  94 ++++++++++++++++
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
>>   .../bpf/prog_tests/struct_ops_private_stack.c | 106 ++++++++++++++++++
>>   .../bpf/progs/struct_ops_private_stack.c      |  62 ++++++++++
>>   .../bpf/progs/struct_ops_private_stack_fail.c |  62 ++++++++++
>>   .../progs/struct_ops_private_stack_recur.c    |  50 +++++++++
>>   6 files changed, 379 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> index 8835761d9a12..eb761645551a 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> ...
>> +__bpf_kfunc void bpf_testmod_ops3_call_test_1(void)
>> +{
>> +	st_ops3->test_1();
>> +}
> ...
>> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
>> new file mode 100644
>> index 000000000000..4006879ca3fe
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> ...
>> +static void test_private_stack_recur(void)
>> +{
>> +	struct struct_ops_private_stack_recur *skel;
>> +	struct bpf_link *link;
>> +	int err;
>> +
>> +	skel = struct_ops_private_stack_recur__open();
>> +	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_recur__open"))
>> +		return;
>> +
>> +	if (skel->data->skip) {
>> +		test__skip();
>> +		goto cleanup;
>> +	}
>> +
>> +	err = struct_ops_private_stack_recur__load(skel);
>> +	if (!ASSERT_OK(err, "struct_ops_private_stack_recur__load"))
>> +		goto cleanup;
>> +
>> +	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
>> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
>> +		goto cleanup;
>> +
>> +	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
>> +
>> +	ASSERT_EQ(skel->bss->val_j, 3, "val_j");
>> +
>> +	bpf_link__destroy(link);
>> +
>> +cleanup:
>> +	struct_ops_private_stack_recur__destroy(skel);
>> +}
> ...
>> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
>> new file mode 100644
>> index 000000000000..15d4e914dc92
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
>> @@ -0,0 +1,50 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "../bpf_testmod/bpf_testmod.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +#if defined(__TARGET_ARCH_x86)
>> +bool skip __attribute((__section__(".data"))) = false;
>> +#else
>> +bool skip = true;
>> +#endif
>> +
>> +void bpf_testmod_ops3_call_test_1(void) __ksym;
>> +
>> +int val_i, val_j;
>> +
>> +__noinline static int subprog2(int *a, int *b)
>> +{
>> +	return val_i + a[10] + b[20];
>> +}
>> +
>> +__noinline static int subprog1(int *a)
>> +{
>> +	/* stack size 400 bytes */
>> +	int b[100] = {};
>> +
>> +	b[20] = 2;
>> +	return subprog2(a, b);
>> +}
>> +
>> +
>> +SEC("struct_ops")
>> +int BPF_PROG(test_1)
>> +{
>> +	/* stack size 400 bytes */
>> +	int a[100] = {};
>> +
>> +	a[10] = 1;
>> +	val_j += subprog1(a);
>> +	bpf_testmod_ops3_call_test_1();
>> +	return 0;
>> +}
>> +
>> +SEC(".struct_ops")
>> +struct bpf_testmod_ops3 testmod_1 = {
>> +	.test_1 = (void *)test_1,
>> +};
> This is delta, and, while this shouldn't happen for SCX, it'd be great if
> SCX can tell BPF to call a function when recursion check triggers and
> ignores a call, so that SCX can trigger error, report it and eject the
> scheduler.

I had an offline discussion with Tejun. A callback function like
   prog->aux->recursion_skipped(prog)
will be provided and if not null the function will be called whenever
a recursion skip happens.

The subsystem requires to define recursion_skipped
callback function and assign it to prog->aux->recursion_skipped if necessary,
if it want to get some error information back.

>
> Thanks.
>


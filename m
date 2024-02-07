Return-Path: <bpf+bounces-21449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9C84D5E5
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43BA1C23164
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A711D54C;
	Wed,  7 Feb 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jlfxs0kz"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC061D54B
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345508; cv=none; b=cB85HxpwCCHf8QTt96wW2Qg++heZ2Id2W/mrOn5XGFZCHCCn8uUoSPplx2r5npm5CoL798DJUFwumI9GHULboCVHhDDv934bXMFfZJzu0/M3BpZWbOjwclyD2aUfaFtydOOSKH7aLqcZjGZnwkP0j1j69tL/F4+hyD+57tIp9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345508; c=relaxed/simple;
	bh=Sq1BgQMHhgNqabqTBlx5F2q9Vvbcx4XLuFe1GIi4YLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLZCpOGCEoAKaIz/NZv5WaTBu0VCBy2uwiMVRCynBC0DgC0cOAn3JEmyNPWxrQUfU2aQpRzhtwJMVGoISjDKjSCPTAipsjFbmzjx4PXa/HqDoSM/DEUOIzhb2+L3LCd9u2klhS6kF/8MPa7VCTjdjsaCu6lKH+04Kxf/w5Srv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jlfxs0kz; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cec9564d-ea2d-4d18-9b79-e312d1af1a25@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707345503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzJc7CdWHSvwE8xRn2KXJMjgjQY6bTtiPKy96pSJZGQ=;
	b=Jlfxs0kz0Mm+WyzioP5XPBYW0wsz0+IGtQW6xCw3B9ssslQthglrTNkFVWPGyLu7nwX6nU
	93zIPGL7KJSLJ3924RJjPtnT7X0nqpvnS4+ApJDLdpWYqJyBId0JEb1Eud7n+lI1LCfIGt
	W4SPEBLwC3y1SN4OqHh34yXx16DhRkM=
Date: Wed, 7 Feb 2024 14:38:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Test PTR_MAYBE_NULL
 arguments of struct_ops operators.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com
References: <20240206063833.2520479-1-thinker.li@gmail.com>
 <20240206063833.2520479-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240206063833.2520479-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/5/24 10:38 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Test if the verifier verifies nullable pointer arguments correctly for BPF
> struct_ops programs.
> 
> "test_maybe_null" in struct bpf_testmod_ops is the operator defined for the
> test cases here. It has several pointer arguments to various types. These
> pointers are majorly classified to 3 categories; pointers to struct types,
> pointers to scalar types, and pointers to array types. They are handled
> sightly differently.

The commit message needs an update. probably make sense to skip what pointer 
type is supported because this patch set does not change that.

> 
> A BPF program should check a pointer for NULL beforehand to access the
> value pointed by the nullable pointer arguments, or the verifier should
> reject the programs. The test here includes two parts; the programs
> checking pointers properly and the programs not checking pointers
> beforehand. The test checks if the verifier accepts the programs checking
> properly and rejects the programs not checking at all.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 12 ++++-
>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  7 +++
>   .../prog_tests/test_struct_ops_maybe_null.c   | 47 +++++++++++++++++++
>   .../bpf/progs/struct_ops_maybe_null.c         | 31 ++++++++++++
>   .../bpf/progs/struct_ops_maybe_null_fail.c    | 25 ++++++++++
>   5 files changed, 121 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index a06daebc75c9..891a2b5f422c 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -555,7 +555,10 @@ static int bpf_dummy_reg(void *kdata)
>   {
>   	struct bpf_testmod_ops *ops = kdata;
>   
> -	ops->test_2(4, 3);
> +	if (ops->test_maybe_null)
> +		ops->test_maybe_null(0, NULL);

afaict, the "static void maybe_null(void)" test below does not exercise this 
line of change.

> +	else
> +		ops->test_2(4, 3);
>   
>   	return 0;
>   }
> @@ -573,9 +576,16 @@ static void bpf_testmod_test_2(int a, int b)
>   {
>   }
>   
> +static int bpf_testmod_ops__test_maybe_null(int dummy,
> +					    struct task_struct *task__nullable)
> +{
> +	return 0;
> +}
> +
>   static struct bpf_testmod_ops __bpf_testmod_ops = {
>   	.test_1 = bpf_testmod_test_1,
>   	.test_2 = bpf_testmod_test_2,
> +	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
>   };
>   
>   struct bpf_struct_ops bpf_bpf_testmod_ops = {
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> index 537beca42896..c51580c9119d 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> @@ -5,6 +5,8 @@
>   
>   #include <linux/types.h>
>   
> +struct task_struct;
> +
>   struct bpf_testmod_test_read_ctx {
>   	char *buf;
>   	loff_t off;
> @@ -28,9 +30,14 @@ struct bpf_iter_testmod_seq {
>   	int cnt;
>   };
>   
> +typedef u32 (*ar_t)[2];
> +typedef u32 (*ar2_t)[];

They are not needed in v5.

> +
>   struct bpf_testmod_ops {
>   	int (*test_1)(void);
>   	void (*test_2)(int a, int b);
> +	/* Used to test nullable arguments. */
> +	int (*test_maybe_null)(int dummy, struct task_struct *task);
>   };
>   
>   #endif /* _BPF_TESTMOD_H */
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
> new file mode 100644
> index 000000000000..1c057c62d893
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <time.h>

Why time.h?

> +
> +#include "struct_ops_maybe_null.skel.h"
> +#include "struct_ops_maybe_null_fail.skel.h"
> +
> +/* Test that the verifier accepts a program that access a nullable pointer
> + * with a proper check.
> + */
> +static void maybe_null(void)
> +{
> +	struct struct_ops_maybe_null *skel;
> +
> +	skel = struct_ops_maybe_null__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
> +		return;
> +
> +	struct_ops_maybe_null__destroy(skel);
> +}
> +
> +/* Test that the verifier rejects a program that access a nullable pointer
> + * without a check beforehand.
> + */
> +static void maybe_null_fail(void)
> +{
> +	struct struct_ops_maybe_null_fail *skel;
> +
> +	skel = struct_ops_maybe_null_fail__open_and_load();
> +	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
> +		return;
> +
> +	struct_ops_maybe_null_fail__destroy(skel);
> +}
> +
> +void test_struct_ops_maybe_null(void)
> +{
> +	/* The verifier verifies the programs at load time, so testing both
> +	 * programs in the same compile-unit is complicated. We run them in
> +	 * separate objects to simplify the testing.
> +	 */
> +	if (test__start_subtest("maybe_null"))
> +		maybe_null();
> +	if (test__start_subtest("maybe_null_fail"))
> +		maybe_null_fail();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
> new file mode 100644
> index 000000000000..c5769c742900
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +u64 tgid = 0;

u64 here.

> +
> +/* This is a test BPF program that uses struct_ops to access an argument
> + * that may be NULL. This is a test for the verifier to ensure that it can
> + * rip PTR_MAYBE_NULL correctly. There are tree pointers; task, scalar, and
> + * ar. They are used to test the cases of PTR_TO_BTF_ID, PTR_TO_BUF, and array.
> + */
> +SEC("struct_ops/test_maybe_null")
> +int BPF_PROG(test_maybe_null, int dummy,
> +	     struct task_struct *task)
> +{
> +	if (task)
> +		tgid = task->tgid;
> +
> +	return 0;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_1 = {
> +	.test_maybe_null = (void *)test_maybe_null,
> +};
> +
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
> new file mode 100644
> index 000000000000..566be47fb40b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int tgid = 0;

but int here.

understand that it does not matter and not the focus of this test but still 
better be consistent and use the correct one.

> +
> +SEC("struct_ops/test_maybe_null_struct_ptr")
> +int BPF_PROG(test_maybe_null_struct_ptr, int dummy,
> +	     struct task_struct *task)
> +{
> +	tgid = task->tgid;
> +
> +	return 0;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_struct_ptr = {
> +	.test_maybe_null = (void *)test_maybe_null_struct_ptr,
> +};
> +



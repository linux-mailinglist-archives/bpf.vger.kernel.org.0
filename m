Return-Path: <bpf+bounces-38225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82300961B37
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 02:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E675BB229F0
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 00:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84F1804E;
	Wed, 28 Aug 2024 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EpJorEit"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A31799F
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724806692; cv=none; b=TrtFb4Gt6ARuhvXRRnDe3Q7GgyknZ4TnCTj058O4ceMgr6FViuu1sREIgM9yO73jTYp5hagryNldl/+2WXQYg06maLd0AW8Ie4Bm0B/0jJQ4xQ/b0m6M0wv7eNyJXDQozisBlzZgNNDti+2wwjwNnFznjQn3/IgeZbZE30Jw0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724806692; c=relaxed/simple;
	bh=HRUGPHqmTQ09K6ejDEx9rD1WyZD5A/vP6wyun3EtVAs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XmvnecQ06IP1J5sAAwrJsF+5s0pFSKC3QzLhXzCGmd3KbJweO/XMr7jdiuauC8Xrul4H+m1RTHWBhzkYffmACV2n1sfIBnb9vvHytrfWXNCRiGhDDHac7lUXLIMd69mHbVivgPcSfiORdh36JK+wnGzY2R/+bNauAl6a/E7/ZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EpJorEit; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08bc097d-6e95-4fc9-8899-1c0c69712005@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724806687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qJ93lsVlBqFwX1+8vyRl3Z5+3nHfwsO2a2mqmRUjVk=;
	b=EpJorEitko4ig3uYoFvFl8LaXKT5CsIZkFA5IuK5dBmlmvqtM1NpWdRVJ44xJpWqmeyfY7
	WFOX9KW4bbBD2z/jvpCHC5nQ7dADA2J02xGFdQ6MwnPgQh+tPDsJ8MN7BVR8KfLaoIpX3o
	M6oZxNI2dDEL0EhpKG/bAIxXuIoGlNQ=
Date: Tue, 27 Aug 2024 17:58:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 9/9] selftests/bpf: Test epilogue patching
 when the main prog has multiple BPF_EXIT
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Amery Hung <ameryhung@gmail.com>, kernel-team@meta.com
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827194834.1423815-10-martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240827194834.1423815-10-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/27/24 12:48 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> This patch tests the epilogue patching when the main prog has
> multiple BPF_EXIT. The verifier should have patched the 2nd (and
> later) BPF_EXIT with a BPF_JA that goes back to the earlier
> patched epilogue instructions.
> 
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>   .../selftests/bpf/prog_tests/pro_epilogue.c   |  2 +
>   .../selftests/bpf/progs/epilogue_exit.c       | 78 +++++++++++++++++++
>   2 files changed, 80 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/epilogue_exit.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
> index b2e467cf15fe..58c18529a802 100644
> --- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
> +++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
> @@ -6,6 +6,7 @@
>   #include "pro_epilogue_kfunc.skel.h"
>   #include "epilogue_tailcall.skel.h"
>   #include "pro_epilogue_goto_start.skel.h"
> +#include "epilogue_exit.skel.h"
>   
>   struct st_ops_args {
>   	int a;
> @@ -47,6 +48,7 @@ void test_pro_epilogue(void)
>   	RUN_TESTS(pro_epilogue_subprog);
>   	RUN_TESTS(pro_epilogue_kfunc);
>   	RUN_TESTS(pro_epilogue_goto_start);
> +	RUN_TESTS(epilogue_exit);
>   	if (test__start_subtest("tailcall"))
>   		test_tailcall();
>   }
> diff --git a/tools/testing/selftests/bpf/progs/epilogue_exit.c b/tools/testing/selftests/bpf/progs/epilogue_exit.c
> new file mode 100644
> index 000000000000..8c03256c7491
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/epilogue_exit.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "../bpf_testmod/bpf_testmod.h"
> +#include "../bpf_testmod/bpf_testmod_kfunc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__success
> +/* save __u64 *ctx to stack */
> +__xlated("0: *(u64 *)(r10 -8) = r1")
> +/* main prog */
> +__xlated("1: r1 = *(u64 *)(r1 +0)")
> +__xlated("2: r2 = *(u32 *)(r1 +0)")
> +__xlated("3: if r2 == 0x0 goto pc+10")
> +__xlated("4: r0 = 0")
> +__xlated("5: *(u32 *)(r1 +0) = 0")
> +/* epilogue */
> +__xlated("6: r1 = *(u64 *)(r10 -8)")
> +__xlated("7: r1 = *(u64 *)(r1 +0)")
> +__xlated("8: r6 = *(u32 *)(r1 +0)")
> +__xlated("9: w6 += 10000")
> +__xlated("10: *(u32 *)(r1 +0) = r6")
> +__xlated("11: w0 = w6")
> +__xlated("12: w0 *= 2")
> +__xlated("13: exit")
> +/* 2nd part of the main prog after the first exit */
> +__xlated("14: *(u32 *)(r1 +0) = 1")
> +__xlated("15: r0 = 1")
> +/* Clear the r1 to ensure it does not have
> + * off-by-1 error and ensure it jumps back to the
> + * beginning of epilogue which initializes
> + * the r1 with the ctx ptr.
> + */
> +__xlated("16: r1 = 0")
> +__xlated("17: gotol pc-12")
> +SEC("struct_ops/test_epilogue_exit")
> +__naked int test_epilogue_exit(void)
> +{
> +	asm volatile (
> +	"r1 = *(u64 *)(r1 +0);"
> +	"r2 = *(u32 *)(r1 +0);"
> +	"if r2 == 0 goto +3;"
> +	"r0 = 0;"
> +	"*(u32 *)(r1 + 0) = 0;"

llvm17 cannot take "*(u32 *)(r1 +0) = 0".

Instead:

r3 = 0;
*(u32 *)(r1 + 0) = r3;

The above solved the llvm17 error:
https://github.com/kernel-patches/bpf/actions/runs/10586206183/job/29334690461

However, there is still a zext with s390 that added extra insn and failed the 
__xlated check. will try an adjustment in the tests to avoid the zext.

pw-bot: cr


> +	"exit;"
> +	"*(u32 *)(r1 + 0) = 1;"
> +	"r0 = 1;"
> +	"r1 = 0;"
> +	"exit;"
> +	::: __clobber_all);
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_st_ops epilogue_exit = {
> +	.test_epilogue = (void *)test_epilogue_exit,
> +};
> +
> +SEC("syscall")
> +__retval(20000)
> +int syscall_epilogue_exit0(void *ctx)
> +{
> +	struct st_ops_args args = { .a = 1 };
> +
> +	return bpf_kfunc_st_ops_test_epilogue(&args);
> +}
> +
> +SEC("syscall")
> +__retval(20002)
> +int syscall_epilogue_exit1(void *ctx)
> +{
> +	struct st_ops_args args = {};
> +
> +	return bpf_kfunc_st_ops_test_epilogue(&args);
> +}



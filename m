Return-Path: <bpf+bounces-38426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849B8964CE9
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2CB285A66
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1781B5EA0;
	Thu, 29 Aug 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OV/9FqoS"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E27C3A8F0
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952948; cv=none; b=gHz6oeiLMBIh2DL8yhHQLgjz+5KMDKtkhqNBFh990/KW8ltyGh4BYue1HesEnlLqeDYQRVieILZ0PkmfrOBorXQpZ6yOSf6/gLsRQcjd7P/DRzAnfWW6pJwMidhfPtGFZKxCXuIBly53rN4uDjsf2b3GDljIFXiPx9MwWKfHeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952948; c=relaxed/simple;
	bh=Br66uzxqt5wE0FYYxrjYrtfafEBkW5HjXGMuRTgXvg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJP76a3QKlVJF0XGtW3RH8/6f1Eiy8/y2+fHli2epMDadNTigo5jKpq1/iTh/swYE+LYloNenQDyZeUS7U0jytnbbpFT3q4rtE1SjEbHSUqCqZGpmMRpA7PoTQMAt9ny1Qq+JgYq914TGOcfRvKlACbQaUWSnMOoog8kSvZMHa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OV/9FqoS; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b81ecdb-779a-445f-ba2f-22147e635f6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724952943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71hv2gv2vW/C2aPVCbmvjWaxHVZqjM9s6x7PByhtxmw=;
	b=OV/9FqoSOjjDY1cIZpNd6Ffs7boJPKfQV9s2eT4Q/97D5ZQVu5mMEENQRT7ejoMyft9LNC
	k2zmPI2fBZWqxIlfH66fvShLiJXnFFW/HQ74tOx/5jrSomLS8bGQAqx+VTcDT6WDcKDTJA
	dJuREEcP/M0E/o0Q/ZtK2MVvob+4ziI=
Date: Thu, 29 Aug 2024 10:35:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 6/9] selftests/bpf: Test gen_prologue and
 gen_epilogue
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 kernel-team@meta.com
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827194834.1423815-7-martin.lau@linux.dev>
 <12566dccdcf9b39cf6b9eda88104451719d18676.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <12566dccdcf9b39cf6b9eda88104451719d18676.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/29/24 12:27 AM, Eduard Zingerman wrote:
> On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> This test adds a new struct_ops "bpf_testmod_st_ops" in bpf_testmod.
>> The ops of the bpf_testmod_st_ops is triggered by new kfunc calls
>> "bpf_kfunc_st_ops_test_*logue". These new kfunc calls are
>> primarily used by the SEC("syscall") program. The test triggering
>> sequence is like:
>>      SEC("syscall")
>>      syscall_prologue_subprog(struct st_ops_args *args)
>>          bpf_kfunc_st_op_test_prologue(args)
>> 	    st_ops->test_prologue(args)
>>
>> .gen_prologue adds 1000 to args->a
>> .gen_epilogue adds 10000 to args->a
>> .gen_epilogue will also set the r0 to 2 * args->a.
>>
>> The .gen_prologue and .gen_epilogue of the bpf_testmod_st_ops
>> will test the prog->aux->attach_func_name to decide if
>> it needs to generate codes.
>>
>> The main programs of the pro_epilogue_subprog.c will call a subprog()
>> which does "args->a += 1".
>>
>> The main programs of the pro_epilogue_kfunc.c will call a
>> new kfunc bpf_kfunc_st_ops_inc10 which does "args->a += 10".
>>
>> This patch uses the test_loader infra to check the __xlated
>> instructions patched after gen_prologue and/or gen_epilogue.
>> The __xlated check is based on Eduard's example (Thanks!) in v1.
>>
>> args->a is returned by the struct_ops prog (either the main prog
>> or the epilogue). Thus, the __retval of the SEC("syscall") prog
>> is checked. For example, when triggering the ops in the
>> 'SEC("struct_ops/test_epilogue_subprog") int test_epilogue_subprog'
>> The expected args->a is +1 (subprog call) + 10000 (.gen_epilogue) = 10001.
>> The expected return value is 2 * 10001 (.gen_epilogue).
>>
>> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c b/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
>> new file mode 100644
>> index 000000000000..7d1124cf4942
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
>> @@ -0,0 +1,156 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "bpf_misc.h"
>> +#include "../bpf_testmod/bpf_testmod.h"
>> +#include "../bpf_testmod/bpf_testmod_kfunc.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +void __kfunc_btf_root(void)
>> +{
>> +	struct st_ops_args args = {};
>> +
>> +	bpf_kfunc_st_ops_inc10(&args);
> 
> Nit: 'bpf_kfunc_st_ops_inc10(0);' would also work.

sgtm. I think it will make it obvious that it won't be executed also.

> 
>> +}
> 
> As a side note, I think that kfunc and subprog sets of tests could be
> combined in order to have less code. Probably does not matter.

ok. I will drop the _subprog.c and only keep the _kfunc.c.

The _kfunc.c calls a subprog and a kfunc which should have already covered the 
_subprog.c cases.



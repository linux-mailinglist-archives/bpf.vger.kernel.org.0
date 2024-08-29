Return-Path: <bpf+bounces-38438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C28964D8E
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0271C20D98
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807661B6539;
	Thu, 29 Aug 2024 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B32tRl4V"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEFC4DA14
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955365; cv=none; b=Lyx3wHuHJGqpQ+3uRNQk9o3MAC2P22DZqCspBJDOEyoiV48bWqdin4yxpFNaPe4rx1kFsm8DG6XFZMN9Tb1skxZqHaAb0iGaakPdEo1J+92L2AyAUawrZYxWZtAPGAFtR2kNwnzKD3OVyl4o3jr0uZLSl/v+4NGn/fKP233BeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955365; c=relaxed/simple;
	bh=KkzUpb83qE0fANTCtuTB0douS2O2pLVIIa8jKF4w2XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSB7R9HGO+lGa9lczy5OS4axPKgtsE1UlAkJwuwc4D0h5vxJ26PXi9wCK8+A+hlt72qbSEf+uejhQYpp6HsdshFRZqQK0waAhmHnBFL/9MRIwl6CkQlwhimFOp6/Ayfcx8tGZ7Rryv56txETiV0xI7/rIBT7VSF1ZtLdPUpxe1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B32tRl4V; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7033d812-39ed-487e-8cea-068acec8c132@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724955360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSagsDqA7CAx48NUVMk0thmE8Vrrx4HInRIKqbrcwLM=;
	b=B32tRl4VMIMEZ6VsELnwzJEQlU4Fl0h7PWCaQkBpmsm58voGWJnpiOhsU6GWyx4RssI5DS
	BrRDsR1QHLknyP9giDYKXD71RWMGDPeJMeHGF9xpLZ+wDJ8OYduJUo8lKRqIusrBL1GZ8t
	4uXuaHseV4PDQ9ng6Bi0yCYGvOWW/3Q=
Date: Thu, 29 Aug 2024 11:15:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 7/9] selftests/bpf: Add tailcall epilogue test
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 kernel-team@meta.com
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827194834.1423815-8-martin.lau@linux.dev>
 <5ef794cd921623dd8e0e6e350b6ad8ffd1aa7c26.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5ef794cd921623dd8e0e6e350b6ad8ffd1aa7c26.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/24 11:16 PM, Eduard Zingerman wrote:
> On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> This patch adds a gen_epilogue test to test a main prog
>> using a bpf_tail_call.
>>
>> A non test_loader test is used. The tailcall target program,
>> "test_epilogue_subprog", needs to be used in a struct_ops map
>> before it can be loaded. Another struct_ops map is also needed
>> to host the actual "test_epilogue_tailcall" struct_ops program
>> that does the bpf_tail_call. The earlier test_loader patch
>> will attach all struct_ops maps but the bpf_testmod.c does
>> not support >1 attached struct_ops.
>>
>> The earlier patch used the test_loader which has already covered
>> checking for the patched pro/epilogue instructions. This is done
>> by the __xlated tag.
>>
>> This patch goes for the regular skel load and syscall test to do
>> the tailcall test that can also allow to directly pass the
>> the "struct st_ops_args *args" as ctx_in to the
>> SEC("syscall") program.
>>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
>> +static void test_tailcall(void)
>> +{
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
>> +	struct epilogue_tailcall *skel;
>> +	struct st_ops_args args;
>> +	int err, prog_fd;
>> +
>> +	skel = epilogue_tailcall__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "epilogue_tailcall__open_and_load"))
>> +		return;
>> +
>> +	topts.ctx_in = &args;
>> +	topts.ctx_size_in = sizeof(args);
>> +
>> +	skel->links.epilogue_tailcall =
>> +		bpf_map__attach_struct_ops(skel->maps.epilogue_tailcall);
>> +	if (!ASSERT_OK_PTR(skel->links.epilogue_tailcall, "attach_struct_ops"))
>> +		goto done;
>> +
> 
> Nitpick:
> Both test_epilogue_tailcall and test_epilogue_subprog would be
> augmented with epilogue, and we know that tail call run as expected
> because only test_epilogue_subprog does +1, right?

Yes. and also the epilogue of the test_epilogue_subprog is executed.

> 
> If above is true, could you please update the comment a bit, e.g.:
> 
> /* Both test_epilogue_tailcall and test_epilogue_subprog are
>   * augmented with epilogue. When syscall_epilogue_tailcall()
>   * is run test_epilogue_tailcall() is triggered,
>   * it executes a tail call and control is transferred to
>   * test_epilogue_subprog(). Only test_epilogue_subprog()
>   * does args->a += 1, thus final args.a value of 10001
>   * guarantees that tail call was executed as expected.
>   */

Added. I massaged the wordings a little.



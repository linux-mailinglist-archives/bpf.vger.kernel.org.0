Return-Path: <bpf+bounces-62215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CE8AF67A7
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 04:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41C11C28755
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 02:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C62B1D5161;
	Thu,  3 Jul 2025 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YvjKG8v8"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3D10E5
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508195; cv=none; b=XREftrRNEoz+nm1FKRtujbq9OBsqkBBpO3b4Us7XhtBF2nTFB2ENTrxtjZzy9s+tq833isWeK+7BQxrZ3r30SraeECsUNqTMYcbwWttJnBXSDA7jmp3ygKbDvTmiukoiUkr+u/s4MZ3Sq+PZLbbFq0WrPufbKr2rZOroGuPcFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508195; c=relaxed/simple;
	bh=YWjeEpvvZJnJWww6IL7jMbkA5JGSp5e6BXiVqCRSiw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlXvC6iXWlL5iM3mIWDHJAc4b+T53K0uy5GfpaUxzaGiEca0/+wGu1STvRwLu+cf02clCUO89zCK79Ywsyg0Kv40tJqhPn7Dlc5GmS84vJ1a83BrCgO2YaGpIMiuvlgP32DluHQvR4sieI/4zESRL9tmB1P+FRAggT9bpyasans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YvjKG8v8; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0003e790-c835-4f38-9cea-4f66fb39d3f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751508191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua1SgqZTXM4TmpWqo9K6YlDggxCDtb1pBdH6lD7fDic=;
	b=YvjKG8v8khyn4WfYZm+EdqP4rzB/Wt6qWqVoEsoORmagGb9H36mI4jzHW4U4wxi6zAKXNa
	2UGb2Azj9wSNZXsqXjBEeLe713OzohZ/MmWCmnzFIoETEBhk6qW+3Xeeze9DGv1HkZKGpF
	SYDy2UDNngGtzMpqdWTTuIXhm+Q5jy4=
Date: Wed, 2 Jul 2025 19:02:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Reduce stack frame size by using
 env->insn_buf for bpf insns
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>
References: <20250702171134.2370432-1-yonghong.song@linux.dev>
 <20250702171144.2370681-1-yonghong.song@linux.dev>
 <3f7f3c4f80d0deb51432b098f5ae30d5c68de085.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3f7f3c4f80d0deb51432b098f5ae30d5c68de085.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/2/25 1:33 PM, Eduard Zingerman wrote:
> On Wed, 2025-07-02 at 10:11 -0700, Yonghong Song wrote:
>> Arnd Bergmann reported an issue ([1]) where clang compiler (less than
>> llvm18) may trigger an error where the stack frame size exceeds the limit.
>> I can reproduce the error like below:
>>    kernel/bpf/verifier.c:24491:5: error: stack frame size (2552) exceeds limit (1280) in 'bpf_check'
>>        [-Werror,-Wframe-larger-than]
>>    kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds limit (1280) in 'do_check'
>>        [-Werror,-Wframe-larger-than]
>>
>> Use env->insn_buf for bpf insns instead of putting these insns on the
>> stack. This can resolve the above 'bpf_check' error. The 'do_check' error
>> will be resolved in the next patch.
>>
>>    [1] https://lore.kernel.org/bpf/20250620113846.3950478-1-arnd@kernel.org/
>>
>> Reported-by: Arnd Bergmann <arnd@kernel.org>
>> Tested-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>>   kernel/bpf/verifier.c | 189 ++++++++++++++++++++----------------------
>>   1 file changed, 91 insertions(+), 98 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8b0a25851089..ef53e313d841 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -21010,7 +21010,9 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
>>   static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>>   					 const union bpf_attr *attr)
>>   {
>> -	struct bpf_insn *patch, zext_patch[2], rnd_hi32_patch[4];
>> +	struct bpf_insn *patch;
>> +	struct bpf_insn *zext_patch = env->insn_buf;
>> +	struct bpf_insn *rnd_hi32_patch = &env->insn_buf[2];
> Nit: I'd add a comment here, something along the lines:
>       "use env->insn_buf as two independent buffers"

Ack. Sounds a good idea.

>
>>   	struct bpf_insn_aux_data *aux = env->insn_aux_data;
>>   	int i, patch_len, delta = 0, len = env->prog->len;
>>   	struct bpf_insn *insns = env->prog->insnsi;
> [...]



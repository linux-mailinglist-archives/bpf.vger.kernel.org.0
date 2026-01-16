Return-Path: <bpf+bounces-79174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463FD2A323
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 03:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA870303A3A8
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 02:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C64332EC5;
	Fri, 16 Jan 2026 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZiBvWwUE"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C001EB5E3;
	Fri, 16 Jan 2026 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530987; cv=none; b=NUVP16ZMlm54jGey/I6NOfJ/mpY6VJTAHm3i/ff31L5jPivzGfVTB8r5nYS3PWh+cGfuoVLha/2ZU2lWvuwQJBRTSKDEiq8y2iixJP31gRr4BQYxQkX8flKCAzdBTC11EwjzNpp8EwmHzRVwhFXzXbjm4IQfkYeEQ0XqsmOGLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530987; c=relaxed/simple;
	bh=4tox12TvY01XkinR3qR2f14kAw5oHKUBHiOoqkiuC7Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RWyDP+r1UELtpN17hXdH1HxZtczgqCNK3fKx9dONYATcN/nFaxMshIK8SdN4oZ5rCV6997nnK8P254PbSupCkPuijaD3gRPfqPi9bT+UO/gqUXYMUMDmqA2G1G8IrSMRDr8vpo8vUDdDfEF/tlfn/Gqb32LYy8dgBLFLsgKpRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZiBvWwUE; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b6d3095-7a41-4cae-83dc-affdebf67e76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768530982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9cDS9m1nZ1szbTkIYyKmfQqt0kbdscR0QYUQVQmnbk=;
	b=ZiBvWwUEe2LBUogI3lApDC70qf59Tyy0/U5Jl+Yqi/6wx+FaH1lVp6PSNGXHoSekt0vY+T
	LAf8VeWyMusuuD/Tgfz58YMsVSrUQQP7t3630aRgfXAQDepmam8IfMaZ8QIrP81+pbUCzB
	b62MEIxZWOeBSwAGhRKR5xytiZh8+8o=
Date: Thu, 15 Jan 2026 18:36:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf_encoder: Fix a verbose output issue
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260116020206.2154622-1-yonghong.song@linux.dev>
In-Reply-To: <20260116020206.2154622-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/15/26 6:02 PM, Yonghong Song wrote:
> For the following test.c:
>    $ cat test.c
>    unsigned tar(int a);
>    __attribute__((noinline)) static int foo(int a, int b)
>    {
>      return tar(a) + tar(a + 1);
>    }
>    __attribute__((noinline)) int bar(int a)
>    {
>      foo(a, 1);
>      return 0;
>    }
> The llvm compilation:
>    $ clang -O2 -g -c test.c
> And then
>    $ pahole -JV test.o
>    btf_encoder__new: 'test.o' doesn't have '.data..percpu' sectio  n
>    File test.o:
>    [1] INT unsigned int size=4 nr_bits=32 encoding=(none)
>    [2] INT int size=4 nr_bits=32 encoding=SIGNED
>    search cu 'test.c' for percpu global variables.
>    [3] FUNC_PROTO (anon) return=2 args=(2 a, [4] FUNC bar type_id=3
>    [5] FUNC_PROTO (anon) return=2 args=(2 a, 2 b, [6] FUNC foo type_id=5
>
> The above confused format is due to btf_encoder__add_func_proto_for_state().
> The "is_last = param_idx == nr_params" is always false since param_idx
> starts from 0. The below change fixed the issue:
>    is_last = param_idx == (nr_params - 1)
>
> With the fix, 'pahole -JV test.o' will produce the following:
>    ...
>    [3] FUNC_PROTO (anon) return=2 args=(2 a)
>    [4] FUNC bar type_id=3
>    [5] FUNC_PROTO (anon) return=2 args=(2 a, 2 b)
>    [6] FUNC foo type_id=5
>    ...
>
> In addition, in btf_encoder__add_func_proto_for_ftype(), we have
>    ++param_idx;
>    if (ftype->unspec_parms) { ... }
> This is correct but it is misleading since '++param_idx' is only needed
> inside the above 'if' condition. So put '++param_idx' inside the
> 'if' condition to make code cleaner.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   btf_encoder.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index b37ee7f..ec6933e 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -865,10 +865,11 @@ static int32_t btf_encoder__add_func_proto_for_ftype(struct btf_encoder *encoder
>   			return -1;
>   	}
>   
> -	++param_idx;
> -	if (ftype->unspec_parms)
> +	if (ftype->unspec_parms) {
> +		++param_idx;
>   		if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
>   			return -1;
> +	}
>   
>   	return id;
>   }
> @@ -895,7 +896,7 @@ static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder
>   	for (param_idx = 0; param_idx < nr_params; param_idx++) {
>   		p = &state->parms[param_idx];
>   		name = btf__name_by_offset(btf, p->name_off);
> -		is_last = param_idx == nr_params;
> +		is_last = param_idx == (nr_params - 1);
>   
>   		/* adding BTF data may result in a move of the
>   		 * name string memory, so make a temporary copy.

Sorry. The tag should be '[PATCH dwarves v2]' instead of '[PATCH bpf-next v2]'.



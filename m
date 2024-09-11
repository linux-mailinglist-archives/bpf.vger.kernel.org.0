Return-Path: <bpf+bounces-39641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38D997596E
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20321B2621C
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B11D1B29C9;
	Wed, 11 Sep 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xmf8yDVz"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660F1AC8AA;
	Wed, 11 Sep 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075848; cv=none; b=oiZxMXLlMrKrrlLLkgkNQkiwQKPD1ASZSDPmBENXM84l/qSCb5hYGXUej8DWCdxeucuePrAGQNqiYgGf77eK/c6P6nzB87++yfECap1TBc0lXrqgwvM4nd7X5fTGYOVpJHK0KLnerMAa7d0cdsYpvcBQq9EwR0KVsWFLdGTHtxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075848; c=relaxed/simple;
	bh=l1Upy7XrmB9UBM+BJiQVMme9YiNZuLukgnwErS690GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8waeATBfTf+MOGZ7jEvL8uYoIcsPwpjQFs5SogY/uOtMKFO0mSgb7p/Q98XVOjII8NT1ulKSF6QcJCkP4JHfcehZj/MBa6yIpT/BWCTzps/kxrOafvzUklYRtbiJLvuCTd4yF9nc+Yln4pXI4iLKq/uqkOviOY5PU4oU+1RDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xmf8yDVz; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c5974d0f-0636-470e-87ef-b2936d54cd87@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726075842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2doHaDLybrvva11Biu2GeRSbEa9P9PAas2ldszHt6Vg=;
	b=Xmf8yDVzIy+6eJnTOsfrb4yvMC8zHjpJm7xQibwzW4YlxIT6jpLPh95qt3N/sg2hLCV7B1
	bQnOkv8mWf+6vk4MdO75VClmSE6wRKCGpj7qq6XHY30M6vzwoKReb5+rMalNHizCiYzuEf
	l+oS0vIhCrHLxh2exrOBs/NllTjeJiY=
Date: Wed, 11 Sep 2024 10:30:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Support __nullable argument suffix
 for tp_btf
To: Philo Lu <lulie@linux.alibaba.com>
Cc: edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 thinker.li@gmail.com, juntong.deng@outlook.com, jrife@google.com,
 alan.maguire@oracle.com, davemarchevsky@fb.com, dxu@dxuuu.xyz,
 vmalik@redhat.com, cupertino.miranda@oracle.com, mattbobrowski@google.com,
 xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20240911033719.91468-1-lulie@linux.alibaba.com>
 <20240911033719.91468-2-lulie@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240911033719.91468-2-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/10/24 8:37 PM, Philo Lu wrote:
> Pointers passed to tp_btf were trusted to be valid, but some tracepoints
> do take NULL pointer as input, such as trace_tcp_send_reset(). Then the
> invalid memory access cannot be detected by verifier.
> 
> This patch fix it by add a suffix "__nullable" to the unreliable
> argument. The suffix is shown in btf, and PTR_MAYBE_NULL will be added
> to nullable arguments. Then users must check the pointer before use it.
> 
> A problem here is that we use "btf_trace_##call" to search func_proto.
> As it is a typedef, argument names as well as the suffix are not
> recorded. To solve this, I use bpf_raw_event_map to find
> "__bpf_trace##template" from "btf_trace_##call", and then we can see the
> suffix.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>   kernel/bpf/btf.c      |  9 +++++++++
>   kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++----
>   2 files changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1e29281653c62..d1ea38d08f301 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6385,6 +6385,12 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
>   	}
>   }
>   
> +static bool prog_arg_maybe_null(const struct bpf_prog *prog, const struct btf *btf,

The "prog" arg is not used, so the following nit...


> +				const struct btf_param *arg)
> +{
> +	return btf_param_match_suffix(btf, arg, "__nullable");
> +}
> +
>   int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
>   		       u32 arg_no)
>   {
> @@ -6554,6 +6560,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>   	if (prog_args_trusted(prog))
>   		info->reg_type |= PTR_TRUSTED;
>   
> +	if (prog_arg_maybe_null(prog, btf, &args[arg]))

... I changed it to directly use
btf_param_match_suffix(btf, &args[arg], "__nullable"),

and removed the new prog_arg_maybe_null(). There are already a few 
is_kfunc_arg_{nullable, ...} helpers in verifier.c. Maybe we can consider 
refactoring them (if) there are more use cases like this in the future.



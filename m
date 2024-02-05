Return-Path: <bpf+bounces-21253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F09C84A7DD
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 22:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E64F1F2B5F0
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD63131743;
	Mon,  5 Feb 2024 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aJiEaxs4"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F60495E4
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164274; cv=none; b=QJm82f5rt4yEtiozfUEt0aJyL/e40Y/Ld3muURe8OhLcaUcBbWaVnFRpsO914neRWTs7p1BcE233/S6T9olRQnAUNpRJusxnsKtKAMCoKxTR61Wd515GKTdmjmiFHnHwQw5d3YnuaAIhvHHKHBjsk8PyHWA7o+/vHYCEWtTIkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164274; c=relaxed/simple;
	bh=EfaFMGQMvGVzuTDgWDfIptDwe3mTlCBqOtH/w2ej0mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBrutbvX5j5pII1virzo6zBa5CTa6Y2dRVba6vNDyia+HZyAISo/Mmx/gfU5ZzhXLrenbWAc0mB7pJgTbutc6h2uN9+KS9+FRKNp+SrIlj+STVmGFjfr/Yfgzb19N6hR8RV3ZunKXiTsDNvU7Isr4oRi20vzxRkO1tIgnylzK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aJiEaxs4; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7da8d735-f648-439d-9a82-1bce0d81676d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707164270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SGwGXhuNKohRnL644Ua9B09Q1vv3QXgbRspoO9HBAs=;
	b=aJiEaxs41s1Kmdmddme4ly/0o7v76sDzjWvJ9eCn1OFaRRvYyheLzBTsm4OwCl6CKKn4Cv
	+eSHeOOj7qEIrIVnB6+tYwwSmJebtl2sInECzLi3eun1CxqUGzGbqq2u4bqTBQzbP5Zzm9
	NTlZ0zMhFkuqOzVZURYmyA1d08DuoBQ=
Date: Mon, 5 Feb 2024 12:17:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: allow bpf_skb_load_bytes in tracing prog
Content-Language: en-US
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 alibuda@linux.alibaba.com, guwen@linux.alibaba.com, hengqi@linux.alibaba.com
References: <20240205121038.41344-1-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240205121038.41344-1-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/5/24 4:10 AM, Philo Lu wrote:
> Allow using helper bpf_skb_load_bytes with BPF_PROG_TYPE_TRACING, which
> is useful for skb parsing in raw_tp/fentry/fexit, especially for
> non-linear paged skb data.
> 
> Selftests will be added if this patch is acceptable.
> 
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>   kernel/trace/bpf_trace.c |  3 +++
>   net/core/filter.c        | 13 +++++++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 241ddf5e3895..4b928d929962 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1945,6 +1945,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_raw_tp = {
>   extern const struct bpf_func_proto bpf_skb_output_proto;
>   extern const struct bpf_func_proto bpf_xdp_output_proto;
>   extern const struct bpf_func_proto bpf_xdp_get_buff_len_trace_proto;
> +extern const struct bpf_func_proto bpf_skb_load_bytes_trace_proto;
>   
>   BPF_CALL_3(bpf_get_stackid_raw_tp, struct bpf_raw_tracepoint_args *, args,
>   	   struct bpf_map *, map, u64, flags)
> @@ -2048,6 +2049,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_get_socket_ptr_cookie_proto;
>   	case BPF_FUNC_xdp_get_buff_len:
>   		return &bpf_xdp_get_buff_len_trace_proto;
> +	case BPF_FUNC_skb_load_bytes:
> +		return &bpf_skb_load_bytes_trace_proto;

It is not safe for all BPF_PROG_TYPE_TRACING hooks. e.g. fexit/__kfree_skb.

It is pretty much only safe for BPF_TRACE_RAW_TP (i.e. "tp_btf"). Take a look at 
prog_args_trusted(). Instead of making the bpf_skb_load_bytes() helper available 
to "tp_btf", I would suggest to 1) make bpf_dynptr_from_skb() kfunc available to 
"tp_btf", 2) enforce KF_TRUSTED_ARGS and 3) ensure it is rdonly (take a look at 
bpf_dynptr_from_skb_rdonly). Together with bpf_dynptr_slice() kfunc, it should 
be equivalent to the bpf_skb_load_bytes().


>   #endif
>   	case BPF_FUNC_seq_printf:
>   		return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9f806cfbc654..ec5622ae8770 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1764,6 +1764,19 @@ static const struct bpf_func_proto bpf_skb_load_bytes_proto = {
>   	.arg4_type	= ARG_CONST_SIZE,
>   };
>   
> +BTF_ID_LIST_SINGLE(bpf_skb_load_bytes_btf_ids, struct, sk_buff)
> +
> +const struct bpf_func_proto bpf_skb_load_bytes_trace_proto = {
> +	.func		= bpf_skb_load_bytes,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_BTF_ID,
> +	.arg1_btf_id	= &bpf_skb_load_bytes_btf_ids[0],
> +	.arg2_type	= ARG_ANYTHING,
> +	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
> +	.arg4_type	= ARG_CONST_SIZE,
> +};
> +
>   int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to, u32 len)
>   {
>   	return ____bpf_skb_load_bytes(skb, offset, to, len);



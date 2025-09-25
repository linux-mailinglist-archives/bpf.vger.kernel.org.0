Return-Path: <bpf+bounces-69783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E8BA1B64
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE6D740AE0
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 21:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65EC27B34C;
	Thu, 25 Sep 2025 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oZjPrux9"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863914A8E
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837508; cv=none; b=ulq96jdD2TFO4vA8J0r1ciBnhoLIGkBSs1iPBDyVYVfx+y6d3ABQuMUarCBNJZQJ7SN17uY58d5YAzSHE2NrkxKvwcseO4qSur2NxDIT1VCrL/wqxOJB8pvrDjfzPy+02zZu9IwUVMAiFqnjKU8O0KlDOd1qoUFndGvxQCz6K18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837508; c=relaxed/simple;
	bh=cToozM6ezO+LQr3pSe4C/JWreMuOsGdBuu32DliRvYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJ4afmJhNrKpSw894+4OK2H0yMVJ54WJsnwKJU/IF6wPMWezdFWmRERqAWz5pvq44ve/uvW8Ayw3COAdyOKHspO0j4N56H2SrDtl9AaVatyfpC1rNb/JgeFabK4fqE1+o/Dh17ixodwEBvQgtnC8vBn9xVQDiflNcgMEsuEOw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oZjPrux9; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87a79618-cd71-4f4f-ad65-b492e571ade5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758837503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Da1AnYFKZOYbydtOENlbTwNXKCnTdbj62v3042MjlAw=;
	b=oZjPrux9myXDIybzr3Vb2r3jkYsQMpallQPCY1TmDjwAtt5p37XKogi8PxZqnid5Pa2pKW
	knMsUR77+khyiAPqdsbHaMij7MUoQJSeHm8u97sffD3Gp0+k+Z7jhunqEssLivqe5pKcF7
	cx4OkwPxjZbXs7HlSIyWzBoYtXnSqbg=
Date: Thu, 25 Sep 2025 14:58:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test changing packet data
 from global functions with a kfunc
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20250925170013.1752561-1-ameryhung@gmail.com>
 <20250925170013.1752561-2-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250925170013.1752561-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/25/25 10:00 AM, Amery Hung wrote:
> The verifier should invalidate all packet pointers after a packet data
> changing kfunc is called. So, similar to commit 3f23ee5590d9
> ("selftests/bpf: test for changing packet data from global functions"),
> test changing packet data from global functions to make sure packet
> pointers are indeed invalidated.

Applied. Thanks.

> +__noinline
> +long xdp_pull_data2(struct xdp_md *x, __u32 len)
> +{
> +	return bpf_xdp_pull_data(x, len);

This tested the mark_subprog_changes_pkt_data() in visit_insn().

afaik, it does not test the clear_all_pkt_pointers() in check_"k"func_call(). 
Unlike the existing "changes_data" helpers, it is the first kfunc doing it. 
Although we know that it should work after fixing the xdp_native.bpf.c :), it is 
still good to have a regression test for it. Probably another xdp prog in 
verifier_sock.c that does bpf_xdp_pull_data() in the main prog. Please follow up.


> +}
> +
> +__noinline
> +long xdp_pull_data1(struct xdp_md *x, __u32 len)
> +{
> +	return xdp_pull_data2(x, len);
> +}
> +
> +/* global function calls bpf_xdp_pull_data(), which invalidates packet
> + * pointers established before global function call.
> + */
> +SEC("xdp")
> +__failure __msg("invalid mem access")
> +int invalidate_xdp_pkt_pointers_from_global_func(struct xdp_md *x)
> +{
> +	int *p = (void *)(long)x->data;
> +
> +	if ((void *)(p + 1) > (void *)(long)x->data_end)
> +		return TCX_DROP;
> +	xdp_pull_data1(x, 0);
> +	*p = 42; /* this is unsafe */
> +	return TCX_PASS;

I fixed this to XDP_PASS as we discussed offline.

> +}
> +
>   __noinline
>   int tail_call(struct __sk_buff *sk)
>   {



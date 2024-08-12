Return-Path: <bpf+bounces-36895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FC94F147
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9F31C22133
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89B217ADF8;
	Mon, 12 Aug 2024 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cJ2DZ/Fp"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9014C5A4
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475268; cv=none; b=sXAwiFsJuvNWTwyvmUGtfaG+D92+cxAOIUMrSa4ieJAM+MxMZ3NT8gYA3oMOpdR0WtyfskxS5UBrpGruR2l3AEbQl3ahZI206ZrrllkUdkZZ2cDdQOpg8qL+B9mdYmbi9YJDaWYzyWep6R9QyM2NFMFSipDrmemBuQbisNVStCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475268; c=relaxed/simple;
	bh=K/q3n/CNCZwBS9xWx0H0cWFnQ//5j5lY5zz3/cCPXfs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=laBpUyFFucdPctCYdKu1xyPEc35WtXSdbDFxevyNmLno6Dq+DuCcpkLyERlSmLmVbrAX5cHHDjBWifeoFycKGYXs7stTcjuuCaoXcboARtu0DMirHNuwV0Im0Nf9QGQdteJ1kQrxy0J5NDPfFfC092mw4ncxHbQG54PyBBX6bRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cJ2DZ/Fp; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da2f4b7a-0284-4af2-bc45-d924de809ae9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723475263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOfYUoNo3pHd+N/HbBofwK7i6p6hqm1x5OO3b2ZlBPU=;
	b=cJ2DZ/Fp5nvNz+38T9XFX46102Ci/dL6PqecPqsDPaSDaxQ0mfbk0DEtL23afzWTgoJQBs
	f/QmSMVf47jJ7Ir7wAY1sUL/m0Jf5+e48eoi7XxUCPhYp7fLJhXECXJKucUZTRQOHWFW8N
	tJcmUZjh5wbhoXYqgfeiwhBfKcM+cqc=
Date: Mon, 12 Aug 2024 08:07:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add a test to verify previous
 stacksafe() fix
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
 <20240812052112.3980530-1-yonghong.song@linux.dev>
Content-Language: en-GB
In-Reply-To: <20240812052112.3980530-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/11/24 10:21 PM, Yonghong Song wrote:
> A selftest is added such that without the previous patch,
> a crash can happen. With the previous patch, the test can
> run successfully. The new test is written in a way which
> mimics original crash case:
>    main_prog
>      static_prog_1
>        static_prog_2
> where static_prog_1 has different paths to static_prog_2
> and some path has stack allocated and some other path
> does not. A stacksafe() checking in static_prog_2()
> triggered the crash.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   tools/testing/selftests/bpf/progs/iters.c | 54 +++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
> index 16bdc3e25591..8d3b75147617 100644
> --- a/tools/testing/selftests/bpf/progs/iters.c
> +++ b/tools/testing/selftests/bpf/progs/iters.c
> @@ -1432,4 +1432,58 @@ int iter_arr_with_actual_elem_count(const void *ctx)
>   	return sum;
>   }
>   
> +__u32 upper, select_n, result;
> +__u64 global;
> +
> +static __noinline bool nest_2(char *str, int len)

Argument 'len' is not needed here. I can make the change after some
additional comments.

> +{
> +	/* some insns (including branch insns) to ensure stacksafe() is triggered
> +	 * in nest_2(). This way, stacksafe() can compare frame associated with nest_1().
> +	 */
> +	if (str[0] == 't')
> +		return true;
> +	if (str[1] == 'e')
> +		return true;
> +	if (str[2] == 's')
> +		return true;
> +	if (str[3] == 't')
> +		return true;
> +	return false;
> +}
> +
> +static __noinline bool nest_1(int n)
> +{
> +	/* case 0: allocate stack, case 1: no allocate stack */
> +	switch (n) {
> +	case 0: {
> +		char comm[16];
> +
> +		if (bpf_get_current_comm(comm, 16))
> +			return false;
> +		return nest_2(comm, 16);
> +	}
> +	case 1:
> +		return nest_2((char *)&global, sizeof(global));
> +	default:
> +		return false;
> +	}

To triger the failure, we rely on 'case 0' is explored by the verifier first
and 'case 1' is explored later. This seems the case for llvm18 and llvm20.

> +}
> +
> +SEC("raw_tp")
> +__success
> +int iter_subprog_check_stacksafe(const void *ctx)
> +{
> +	long i;
> +
> +	bpf_for(i, 0, upper) {
> +		if (!nest_1(select_n)) {
> +			result = 1;
> +			return 0;
> +		}
> +	}
> +
> +	result = 2;
> +	return 0;
> +}
> +
>   char _license[] SEC("license") = "GPL";


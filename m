Return-Path: <bpf+bounces-70688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB8EBCA66A
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 19:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E81E4813CB
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2542459F7;
	Thu,  9 Oct 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="evTktM3G"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFE245010
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031490; cv=none; b=bGmazn00vzkawwOZG4x5s77bEuy4FALWwmLRi5wH36Vi9VhTZbZasMMDCzoiD9C5wgpbKKxlvEJgPE6pNcUkxK+VScaqleOtq9O+VXha6IOkNOBpbHBjIz7xDqUm1FxrFrSutSGkFQaExm9f/RmuP2iptuw/4DbYt0mxB4+HBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031490; c=relaxed/simple;
	bh=RCzUOBjmXeu8xhJmK6vsVBk853blOOZ7uWn/lLz2bYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWvtl5t1YAjE+jgk5zY8Km3tJlh2Q+NTeXJFoGfyU16gIcdIumB/O0frxMvdnuNL7nQwgLaMy/Oa9UlUYzvgR3ONsR9gs2/i1llTBOs3FGtx1NmEtTCzQA9bTPpsqM10NhFkjZ7Z2xH6DkRd/BpmyqFTJ2t6hIyC+OqTrCpYM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=evTktM3G; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ea048fd-3ffc-4706-ba69-f77e92338b0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760031484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfDnU5FvwtevcBcWvg28PDMOAB5oSRs06zJNkMTtrjk=;
	b=evTktM3Gy3gaoqz/+fDi0julgdqBpiQFw4tDX+e2/f1uiNVuu3dq9stWu54MCd4pI/wuTp
	l1rNfJDmwuCzYVCKzk8xp1NMCZePPEUAXf+6nm1K8cZ+HWblHtXZlu7jO2J4PyYR9U3stY
	N2z3hYwCjIVWvoy95fhvNp+2IYwG398=
Date: Thu, 9 Oct 2025 10:37:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 4/5] selftests/bpf: Support non-linear flag in
 test loader
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org
References: <cover.1760015985.git.paul.chaignon@gmail.com>
 <0c44ad0d1f4899cbfd745ab654a2ad86e3737d37.1760015985.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <0c44ad0d1f4899cbfd745ab654a2ad86e3737d37.1760015985.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/9/25 7:02 AM, Paul Chaignon wrote:
> @@ -633,6 +635,11 @@ static int parse_test_spec(struct test_loader *tester,
>   					      &spec->unpriv.stdout);
>   			if (err)
>   				goto cleanup;
> +		} else if (str_has_pfx(s, TEST_TAG_LINEAR_SIZE)) {
> +			val = s + sizeof(TEST_TAG_LINEAR_SIZE) - 1;
> +			err = parse_int(val, &spec->linear_sz, "test linear size");
> +			if (err)
> +				goto cleanup;
>   		}
>   	}
>   
> @@ -1007,10 +1014,11 @@ static bool is_unpriv_capable_map(struct bpf_map *map)
>   	}
>   }
>   
> -static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
> +static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts, int linear_sz)
>   {
>   	__u8 tmp_out[TEST_DATA_LEN << 2] = {};
>   	__u8 tmp_in[TEST_DATA_LEN] = {};
> +	struct __sk_buff ctx = {};

since it needs a re-spin...

not all prog type uses "struct __sk_buff". linear_sz could be useful for xdp 
also but it also needs a different struct. This is pretty much "tc" and 
"cgroup_skb" only for now. How about error out earlier in the parse_test_spec? I 
think the bpf_program__type() should already be available at the parse_test_spec().

>   	int err, saved_errno;
>   	LIBBPF_OPTS(bpf_test_run_opts, topts,
>   		.data_in = tmp_in,
> @@ -1020,6 +1028,12 @@ static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
>   		.repeat = 1,
>   	);
>   
> +	if (linear_sz) {
> +		ctx.data_end = linear_sz;
> +		topts.ctx_in = &ctx;
> +		topts.ctx_size_in = sizeof(ctx);
> +	}
> +



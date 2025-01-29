Return-Path: <bpf+bounces-50075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189F6A226F5
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FF816478D
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 23:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AC11E47D6;
	Wed, 29 Jan 2025 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vo+Si3W2"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECAB1E2606;
	Wed, 29 Jan 2025 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738193514; cv=none; b=COVNQ9SSLAPOdqpZyXyM8qQX3sB6BhEZszOfLESbIpJobMjjwO+t1SJJgxdjTFFU7dCBUMfnFCAjomx4Qjz0IgLOqkwUdjpCBVMN2oPUl6+rl2Sm1Ivvzdw1+mF5eYZ0sQkjmpBcPR5/8T/kGYPyMBhlaa/RjFGICGPTMOoQcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738193514; c=relaxed/simple;
	bh=EvZhqhdp0KgilG/ttj3XlPldQ0qVlVRPO2WDeZb0yZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNkuW70gO0e7XyIQxCaa2/x36MJOsuFZSMzpCMtjiyGeOYeGh5gpoTiE1cdRXBO3Fg21BpAyxQVsd+YpEvZFNO8oo75zi7mXOi4mPA/ma7oVMaWFdH3dRlrZNo6/9PK+r5vtgquXeVyIjXHAzQEh3ewT4eu2xOMskVIc/RdH4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vo+Si3W2; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11d72466-f2b2-4133-beb8-056ebc589bc9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738193504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXgV59M3uOBb8XpGXetGwJpBThzmfvgmfY8nPAFTeaE=;
	b=Vo+Si3W2vDYN9iKZWK4O0gYKwwJ6U1O+ISFY6OzxYgTWq5vxafCa+T/+Uh83GGxQUydkH2
	ub5V9P+FwTJry9xzbAcOWiHAsNRL1DGUfWOPe1Rg5H+viaKr5OHJfwpbwlSlIa0kXLSD0x
	kqTDR7r7m2uJ7xHkqWIv5gJP+X1y6WI=
Date: Wed, 29 Jan 2025 15:31:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] add selftest for TCP_ULP in bpf_setsockopt
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, yanan@huawei.com, wuchangye@huawei.com,
 xiesongyang@huawei.com, liuxin350@huawei.com, liwei883@huawei.com,
 tianmuyang@huawei.com
References: <20250127090724.3168791-1-zhangmingyi5@huawei.com>
 <20250127090724.3168791-3-zhangmingyi5@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250127090724.3168791-3-zhangmingyi5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/27/25 1:07 AM, zhangmingyi wrote:
> This case invokes bpf_setsockopt and bpf_getsockopt to set ulp.
> The existing smc_ulp_ops of the kernel is used as a test case to test
> whether the setting and get operations can be performed normally.
> 
> Signed-off-by: zhangmingyi <zhangmingyi5@huawei.com>
> ---
>   .../selftests/bpf/progs/setget_sockopt.c      | 21 ++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> index 6dd4318debbf..dcdf26ef41c4 100644
> --- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
> +++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> @@ -327,6 +327,18 @@ static int test_tcp_maxseg(void *ctx, struct sock *sk)
>   	return 0;
>   }
>   
> +static int test_tcp_ulp(void *ctx, struct sock *sk)
> +{
> +	__u8 saved_syn[20];
> +
> +	if (sk->sk_state == TCP_SYN_SENT)
> +		return bpf_setsockopt(ctx, IPPROTO_TCP, TCP_ULP,
> +						"smc", sizeof("smc"));

The test_progs/setget_sockopt.c is using "tls" in a setsockopt(TCP_ULP) call. I 
would rather not to introduce another ulp in this selftest. Let stay with "tls".

btw, the indentation is off...

> +
> +	return bpf_getsockopt(ctx, IPPROTO_TCP, TCP_ULP,
> +			    saved_syn, sizeof(saved_syn));

same here on indentation.

Also, the getsockopt test should ensure it gets the same ulp name back (i.e. 
"tls"). Take a look at bpf_strncmp.

> +}
> +
>   static int test_tcp_saved_syn(void *ctx, struct sock *sk)
>   {
>   	__u8 saved_syn[20];
> @@ -395,16 +407,19 @@ int skops_sockopt(struct bpf_sock_ops *skops)
>   		break;
>   	case BPF_SOCK_OPS_TCP_CONNECT_CB:
>   		nr_connect += !(bpf_test_sockopt(skops, sk) ||
> -				test_tcp_maxseg(skops, sk));
> +				test_tcp_maxseg(skops, sk) ||
> +				test_tcp_ulp(skops, sk));

For other optnames, it makes sense to reuse the existing "skops_sockopt" BPF 
program. For ulp, it could change the sendmsg, recvmsg, and a few other 
behaviors. I would prefer to separate it out into its own BPF program to avoid 
future surprises on the existing tests in prog_tests/setget_sockopt.c. Keep the 
new BPF program simple, e.g. implement a new BPF program for 
"lsm_cgroup/socket_post_create" and only check for bpf_set/getsockopt(TCP_ULP).

Please tag the set for bpf-next. The "ipv4" in the patch 1's subject is not 
accurate also. afaik, ulp is not specific to ipv4.

Also, the bpf CI complains that the test cannot compile.

pw-bot: cr

>   		break;
>   	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
>   		nr_active += !(bpf_test_sockopt(skops, sk) ||
> -			       test_tcp_maxseg(skops, sk));
> +			       test_tcp_maxseg(skops, sk) ||
> +				   test_tcp_ulp(skops, sk));
>   		break;
>   	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
>   		nr_passive += !(bpf_test_sockopt(skops, sk) ||
>   				test_tcp_maxseg(skops, sk) ||
> -				test_tcp_saved_syn(skops, sk));
> +				test_tcp_saved_syn(skops, sk) ||
> +				test_tcp_ulp(skops, sk));
>   		flags = skops->bpf_sock_ops_cb_flags | BPF_SOCK_OPS_STATE_CB_FLAG;
>   		bpf_setsockopt(skops, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS, &flags, sizeof(flags));
>   		break;



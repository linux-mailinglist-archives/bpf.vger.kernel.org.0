Return-Path: <bpf+bounces-41362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35F19960A8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EE11C222B8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A217C21E;
	Wed,  9 Oct 2024 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="afl4Jm0x"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03B158DB2
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458369; cv=none; b=i7WpncuD1tsfcNnKzicap+mkJiZp9i+whidmryU+DnSQ8r8z3SVyevMz6hDQUpk/GdFyUKDJnc7v5ZHJl5Hors8qK7/nsvj7ePkfuiS62fQHKeHW3PGL4dLITtE8ZUQFHR94NyfXsj7TVzgMjy7A+cIU7Ar/DB6YJ0yZkhmq/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458369; c=relaxed/simple;
	bh=fiTKaLYnk2N+K7YtREEaty2l1wAEuWmaETfj5Oi8Jhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2QjqVuAp+ZmGLaEbQq8grE197Y4cD2E2MJmbyTL0+kZARA7JJJyLJY3zds3MMJ0JcEppBjQ3vYo/kb15F+2pNLsMiAVn4ArdwqFnFZqxcxivR5kNjecZlYHzlnH/Loz677zURa1fSkw1Z9LTQqy9S++CIAnss3umoszn5KlVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=afl4Jm0x; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d5dce58-c019-48b3-8815-b9e0f9d4e8cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728458364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7D1cLhC0H0BdEs8wP77uRQRSDHt70rq5UM6c5/x9BA=;
	b=afl4Jm0xzQfHtHS4ymCCKAU/paRo8ZenfPfRA3RnPgsYgqGVD7xVP2BuQKTrTBruRZGWRv
	kPd2AtbtAY7VCPRBjRi5DyEvDMFIfTMMisnlwoSVI4VE9RLH6FMidR8a7CrsvoYJf+5dbQ
	sxxhC6pdbVQnKZKvsQ5IvTOp6TisBss=
Date: Wed, 9 Oct 2024 00:19:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 7/9] net-timestamp: open gate for bpf_setsockopt
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-8-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241008095109.99918-8-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/8/24 2:51 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Now we allow users to set tsflags through bpf_setsockopt. What I
> want to do is passing SOF_TIMESTAMPING_RX_SOFTWARE flag, so that
> we can generate rx timestamps the moment the skb traverses through
> driver.
> 
> Here is an example:
> 
> case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
> case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
> 	sock_opt = SOF_TIMESTAMPING_RX_SOFTWARE;
> 	bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING,
> 		       &sock_opt, sizeof(sock_opt));
> 	break;
> 
> In this way, we can use bpf program that help us generate and report
> rx timestamp.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   net/core/filter.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bd0d08bf76bb..9ce99d320571 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5225,6 +5225,9 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>   		break;
>   	case SO_BINDTODEVICE:
>   		break;
> +	case SO_TIMESTAMPING_NEW:
> +	case SO_TIMESTAMPING_OLD:

I believe this change was proposed before. It will change the user expectation 
on the sk_error_queue. It needs some bits/fields/knobs for bpf. I think this 
point is similar to other's earlier comments in this thread.

I only have a chance to briefly look at it. I think it is useful. This 
bpf/timestamp feature request has come up before.

A high level comment. The current timestamp should work for non tcp sock? The 
bpf/timestamp solution should be able to also.

sockops is tcp centric. From looking at patch 9 that needs to initialize 4 args, 
this interface feels old and not sure we want to extend to other sock types.
This needs some thoughts.

> +		break;
>   	default:
>   		return -EINVAL;
>   	}



Return-Path: <bpf+bounces-1562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDA719268
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 07:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80130280BD7
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 05:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281755C8B;
	Thu,  1 Jun 2023 05:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E623BD
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 05:39:23 +0000 (UTC)
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB551734
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 22:38:45 -0700 (PDT)
Message-ID: <5bc1ac0d-cea8-19e5-785a-cd72140d8cdb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685597879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8KKClr4mwxkP83/QvliDYMt02i03s7p/NNDdJNcids=;
	b=fH3TdsVq8CEbPsRnt5077VpAg6MQuK/X+xLlj3QRaXIQmwgx1k9xXsw7S0z3/lDuo8eJXV
	qu+8Mf1VW6lISAHxq1ruB7QBTi3ywmuixstKQ9twPtpS+JwXvZ0z3bHYPVbbe3qqIP8jR/
	m6OLSlJDITn/dx3ZdC6dtrQWoZFOrRQ=
Date: Wed, 31 May 2023 22:37:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: getsockopt hook to get optval without
 checking kernel retval
Content-Language: en-US
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/31/23 7:49 PM, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> Remove the judgment on retval and pass bpf ctx by default. The
> advantage of this is that it is more flexible. Bpf getsockopt can
> support the new optname without using the module to call the
> nf_register_sockopt to register.
> 
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>   kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
>   1 file changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 5b2741aa0d9b..ebad5442d8bb 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1896,30 +1896,21 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>   	if (max_optlen < 0)
>   		return max_optlen;
>   
> -	if (!retval) {
> -		/* If kernel getsockopt finished successfully,
> -		 * copy whatever was returned to the user back
> -		 * into our temporary buffer. Set optlen to the
> -		 * one that kernel returned as well to let
> -		 * BPF programs inspect the value.
> -		 */
> -
> -		if (get_user(ctx.optlen, optlen)) {
> -			ret = -EFAULT;
> -			goto out;
> -		}
> +	if (get_user(ctx.optlen, optlen)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
>   
> -		if (ctx.optlen < 0) {
> -			ret = -EFAULT;
> -			goto out;
> -		}
> -		orig_optlen = ctx.optlen;
> +	if (ctx.optlen < 0) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +	orig_optlen = ctx.optlen;
>   
> -		if (copy_from_user(ctx.optval, optval,
> -				   min(ctx.optlen, max_optlen)) != 0) {
> -			ret = -EFAULT;
> -			goto out;
> -		}
> +	if (copy_from_user(ctx.optval, optval,
> +				min(ctx.optlen, max_optlen)) != 0) {
What is in optval that is useful to copy from if the kernel didn't handle the 
optname?

and there is no selftest also.

> +		ret = -EFAULT;
> +		goto out;
>   	}
>   
>   	lock_sock(sk);



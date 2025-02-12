Return-Path: <bpf+bounces-51326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42035A333AA
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 00:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09D6188B665
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31E2261391;
	Wed, 12 Feb 2025 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IaZYZg/j"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1483825EF86
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739404199; cv=none; b=SxvU2oSfA8C/iyJNqWsx3lLGw3bCPfbTccZrk8tt86fN8Sdq96hKYGsPVq7U3ZDl7Mck5rRD7ndnh3SsykxH7YUkih4bjc7tlyA+LLX124GnovUQoe7vajlv4LrJYm6UzBKSMndm1jGKCLFn6fSkb5kVCKy1aYedrN2ZflyTYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739404199; c=relaxed/simple;
	bh=peYx2iUmtjMumKtOMWeAdImuFFqD3MNQvxjR6krGFc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crh4TwKWMuAQvqxRzkAiDGWVLWuMsfTpS1Z6qvx1IBHYDZ/irlTkA1py0nbqjb1PA5IVsotjpWEamPT6Pm+Ba9u15tIRPyteySmi6MzBa0Z7Rp/MzbU8z4xc5kRLt928f31loWDrGXd58E3t1+TbRblgnoPBxwxK1CL57dSq/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IaZYZg/j; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb579932-e85e-4241-bfe7-6e0d780ee9d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739404194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TE3FTTNYmqhgXuLyPN3E/uy2Ry2GyYmbl0qHeeKrB7Y=;
	b=IaZYZg/jAxPXGKpYIljJL6Ihc48B5SyBLHO/oELrGPRbJ0ENmJRtXc3OQuYX9BtrErePFF
	dM5T7ljr/P9IuYNkek/U74ttnfDF9z6a1bEc59XhjiAlvyewf91m6GacOcrR6Yjvw/j1+E
	kVwVv3l3O7fZJbK/Z7snARfYVGN3BTc=
Date: Wed, 12 Feb 2025 15:49:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 11/12] bpf: support selective sampling for
 bpf timestamping
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-12-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250212061855.71154-12-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/11/25 10:18 PM, Jason Xing wrote:
> Add the bpf_sock_ops_enable_tx_tstamp kfunc to allow BPF programs to
> selectively enable TX timestamping on a skb during tcp_sendmsg().
> 
> For example, BPF program will limit tracking X numbers of packets
> and then will stop there instead of tracing all the sendmsgs of
> matched flow all along. It would be helpful for users who cannot
> afford to calculate latencies from every sendmsg call probably
> due to the performance or storage space consideration.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   kernel/bpf/btf.c  |  1 +
>   net/core/filter.c | 32 +++++++++++++++++++++++++++++++-
>   2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9433b6467bbe..740210f883dc 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8522,6 +8522,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
>   	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>   	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>   	case BPF_PROG_TYPE_CGROUP_SYSCTL:
> +	case BPF_PROG_TYPE_SOCK_OPS:
>   		return BTF_KFUNC_HOOK_CGROUP;
>   	case BPF_PROG_TYPE_SCHED_ACT:
>   		return BTF_KFUNC_HOOK_SCHED_ACT;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7f56d0bbeb00..36793c68b125 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12102,6 +12102,26 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
>   #endif
>   }
>   
> +__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
> +					      u64 flags)
> +{
> +	struct sk_buff *skb;
> +	struct sock *sk;
> +
> +	if (skops->op != BPF_SOCK_OPS_TS_SND_CB)
> +		return -EOPNOTSUPP;

It still needs to test the "flags" such that it can be used in the future....

	if (flags)
		return -EINVAL;

> +
> +	skb = skops->skb;
> +	sk = skops->sk;
> +	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
> +	if (sk_is_tcp(sk)) {

Unnecessary check like this will only confuse reader. Remove it and revisit when 
UDP will be supported.

> +		TCP_SKB_CB(skb)->txstamp_ack |= TSTAMP_ACK_BPF;
> +		skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> +	}
> +
> +	return 0;
> +}
> +
>   __bpf_kfunc_end_defs();
>   
>   int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> @@ -12135,6 +12155,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
>   BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
>   BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
>   
> +BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
> +BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
> +
>   static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
>   	.owner = THIS_MODULE,
>   	.set = &bpf_kfunc_check_set_skb,
> @@ -12155,6 +12179,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
>   	.set = &bpf_kfunc_check_set_tcp_reqsk,
>   };
>   
> +static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
> +	.owner = THIS_MODULE,
> +	.set = &bpf_kfunc_check_set_sock_ops,
> +};
> +
>   static int __init bpf_kfunc_init(void)
>   {
>   	int ret;
> @@ -12173,7 +12202,8 @@ static int __init bpf_kfunc_init(void)
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
>   					       &bpf_kfunc_set_sock_addr);
> -	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> +	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
>   }
>   late_initcall(bpf_kfunc_init);
>   



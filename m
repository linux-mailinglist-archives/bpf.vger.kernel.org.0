Return-Path: <bpf+bounces-51115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13E2A304B4
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92F43A5DD1
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044871EE008;
	Tue, 11 Feb 2025 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aa+HQy3O"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642B71EE00E
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259730; cv=none; b=r85pPkxGWrIU9VRnNsn/cFTrsTscL3ezDJUjH41WJFItFTv3P+cS3wxCr8Q1AwrauyAdzj3GDjtPyzg1ct84ZhPbcBEIcE0N89Bi/lgJeXT636PzxomjYQCsZ+6qfBrUybrRwAUQ0j804LMsc0678h2GH3zmiDYmEQgchawJ7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259730; c=relaxed/simple;
	bh=wqPEFEJXhPEgjqvvQPs60/jcXvpEwF4YVlTJ2HH8uGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHS3QboODFs9TGVIydJWxMHvr+OynAs7c6bdqwjS4y5BxdhqdUgLIxA3kgtD6WokHjvE+HO96Uzqe2wHBtwp/7pkTo8ZGpJDbAmU+WOKs95Oxrp2CPnLZ95GJwAbPQ5dtJyUQLqeiVJFY4E00MMXj9D9r8PwbQT99w1iNQsChA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aa+HQy3O; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e419521b-c38e-41e0-a4da-93dcbb820486@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739259716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IK3saGkhNUN12X4MEcIQMxeGOn/ySxBzESpOffbZkYk=;
	b=aa+HQy3OJeJqCqRsPbZP0SYjMFY+g9LHtxvV6MKruPh3Iz0kKvu5GfIizpKUJCEdaF0YyZ
	F0NSVxv5wkTjVTUhA7vyYpomOLRMNEmi8CotroixHi1ksHiEbQQbypMSsLhlJqISyXh4/A
	2oFRHe3vFaCmr6TsMnZc/+Gc5Y8F+S8=
Date: Mon, 10 Feb 2025 23:41:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 11/12] bpf: support selective sampling for bpf
 timestamping
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-12-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250208103220.72294-12-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/25 2:32 AM, Jason Xing wrote:
> Use __bpf_kfunc feature to allow bpf prog dynamically and selectively

s/Use/Add/

Remove "dynamically". A kfunc can only be called dynamically at runtime.

Like:

"Add the bpf_sock_ops_enable_tx_tstamp kfunc to allow BPF programs to 
selectively enable TX timestamping on a skb during tcp_sendmsg..."

> to sample/track the skb. For example, the bpf prog will limit tracking
> X numbers of packets and then will stop there instead of tracing
> all the sendmsgs of matched flow all along.
 > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   kernel/bpf/btf.c  |  1 +
>   net/core/filter.c | 27 ++++++++++++++++++++++++++-
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8396ce1d0fba..a65e2eeffb88 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8535,6 +8535,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
>   	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>   	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>   	case BPF_PROG_TYPE_CGROUP_SYSCTL:
> +	case BPF_PROG_TYPE_SOCK_OPS:
>   		return BTF_KFUNC_HOOK_CGROUP;
>   	case BPF_PROG_TYPE_SCHED_ACT:
>   		return BTF_KFUNC_HOOK_SCHED_ACT;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7f56d0bbeb00..db20a947e757 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12102,6 +12102,21 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
>   #endif
>   }
>   
> +__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops)

I am ok to always enable txstamp_ack here. Please still add a second "u64 flags" 
argument such that future disable/enable is still possible.

> +{
> +	struct sk_buff *skb;
> +
> +	if (skops->op != BPF_SOCK_OPS_TS_SND_CB)
 > +		return -EOPNOTSUPP;> +
> +	skb = skops->skb;
> +	TCP_SKB_CB(skb)->txstamp_ack = 2;

Willem (thanks!) has already mentioned there is a bug.

This also brought up that a test is missing: the bpf timestamping and user 
space's SO_TIMESTAMPING can work without interfering others. The current test 
only has SK_BPF_CB_TX_TIMESTAMPING on. A test is needed when both 
SK_BPF_CB_TX_TIMESTAMPING and the user space's SO_TIMESTAMPING are on. The 
expectation is both of them will work together.

> +	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
> +	skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> +
> +	return 0;
> +}
> +
>   __bpf_kfunc_end_defs();
>   
>   int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> @@ -12135,6 +12150,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
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
> @@ -12155,6 +12174,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
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
> @@ -12173,7 +12197,8 @@ static int __init bpf_kfunc_init(void)
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
>   					       &bpf_kfunc_set_sock_addr);
> -	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> +	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
>   }
>   late_initcall(bpf_kfunc_init);
>   



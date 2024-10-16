Return-Path: <bpf+bounces-42114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C34A99FCCC
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 02:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA044B24617
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 00:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F4B3C0B;
	Wed, 16 Oct 2024 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="okK7cxd+"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA24A02
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037410; cv=none; b=WzPA3aCJGporI5mkp9vPLEnfT0BJ5FfCYbp6/lxRT0tzPrrrvjwsGZQmdk1MvbuTi0ISHhv8P09Axqy0E6Sq98UGc5d7XnAKwAzAaUY/6SUUjnKqf9VuNmxm/eEQNPy5AUZyN8l4owQErupqCgmhxv5e/0D38kFHJ+mlbSnbIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037410; c=relaxed/simple;
	bh=p3bZseUDVA/nDqe1n2tXXoOhsEQBXev8IiHrPGGG05E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHZrA18gBy6YD4ur4LZpFwWrbdI80KLhpJTVM8xjrICyj/3RbPGfnSI/zYGXWFK1Q0xDhvYPcQgjhDNKcHEa1Vf6yRRfBtdQoFUT/36YTaqVvJfCKsGXBsDs4unTZiXore6ZVVZt+Tu8IKeTherz9uhGDyVR375n2cuM+cGuCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=okK7cxd+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729037405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzvOFbzdSfD6Z9mVAB7PkbmqAiWN+492BN4iUDdHU9A=;
	b=okK7cxd+vFjlgzPmhm1/ZuN26yx5A49IRNvX9wwM6PO1z1hdk1hA3hZNbXTto0k9jrdlrZ
	unPJG/hmuaKkljdZ7n+PoKIYd4UJKrkDHJex7jRziZxu3ScFK+JiU+cBe01ormP65KtVAX
	y3DgBnML1XAFep4UeKvciyWz+1gzsj0=
Date: Tue, 15 Oct 2024 17:09:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241012040651.95616-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/11/24 9:06 PM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Willem suggested that we use a static key to control. The advantage
> is that we will not affect the existing applications at all if we
> don't load BPF program.
> 
> In this patch, except the static key, I also add one logic that is
> used to test if the socket has enabled its tsflags in order to
> support bpf logic to allow both cases to happen at the same time.
> Or else, the skb carring related timestamp flag doesn't know which
> way of printing is desirable.
> 
> One thing important is this patch allows print from both applications
> and bpf program at the same time. Now we have three kinds of print:
> 1) only BPF program prints
> 2) only application program prints
> 3) both can print without side effect
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/net/sock.h |  1 +
>   net/core/filter.c  |  3 +++
>   net/core/skbuff.c  | 38 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 42 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 66ecd78f1dfe..b7c51b95c92d 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2889,6 +2889,7 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
>   void sock_def_readable(struct sock *sk);
>   
>   int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
> +DECLARE_STATIC_KEY_FALSE(bpf_tstamp_control);
>   void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
>   int sock_get_timestamping(struct so_timestamping *timestamping,
>   			  sockptr_t optval, unsigned int optlen);
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 996426095bd9..08135f538c99 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5204,6 +5204,8 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
>   	.arg1_type      = ARG_PTR_TO_CTX,
>   };
>   
> +DEFINE_STATIC_KEY_FALSE(bpf_tstamp_control);
> +
>   static int bpf_sock_set_timestamping(struct sock *sk,
>   				     struct so_timestamping *timestamping)
>   {
> @@ -5217,6 +5219,7 @@ static int bpf_sock_set_timestamping(struct sock *sk,
>   		return -EINVAL;
>   
>   	WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
> +	static_branch_enable(&bpf_tstamp_control);

Not sure when is a good time to do static_branch_disable().

The bpf prog may be detached also. (IF) it ends up staying with the 
cgroup/sockops interface, it should depend on the existing static key in 
cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one.

>   
>   	return 0;
>   }
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index f36eb9daa31a..d0f912f1ff7b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5540,6 +5540,29 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>   }
>   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
>   
> +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int tstype)

sk is unused.

> +{
> +	u32 testflag;
> +
> +	switch (tstype) {
> +	case SCM_TSTAMP_SCHED:

Instead of doing this translation,
is it easier to directly store the bpf prog desired ts"type" (i.e. the 
SCM_TSTAMP_*) in the sk->sk_tsflags_bpf?
or there is a specific need to keep the SOF_TIMESTAMPING_* value in
sk->sk_tsflags_bpf?

> +		testflag = SOF_TIMESTAMPING_TX_SCHED;
> +		break;
> +	case SCM_TSTAMP_SND:
> +		testflag = SOF_TIMESTAMPING_TX_SOFTWARE;
> +		break;
> +	case SCM_TSTAMP_ACK:
> +		testflag = SOF_TIMESTAMPING_TX_ACK;
> +		break;
> +	default:
> +		return false;
> +	}
> +	if (tsflags & testflag)
> +		return true;
> +
> +	return false;
> +}
> +
>   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>   				 const struct sk_buff *ack_skb,
>   				 struct skb_shared_hwtstamps *hwtstamps,
> @@ -5558,6 +5581,9 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>   	if (!skb_may_tx_timestamp(sk, tsonly))
>   		return;
>   
> +	if (!sk_tstamp_tx_flags(sk, tsflags, tstype))

This is a new test. tsflags is the sk->sk_tsflags here if I read it correctly.

My understanding is the sendmsg can provide SOF_TIMESTAMPING_* for individual 
skb. Would it break? Is it the similar case on the skb tx_flags that Willem has 
mentioned in the patch 0's thread?

> +		return;
> +
>   	if (tsonly) {
>   #ifdef CONFIG_INET
>   		if ((tsflags & SOF_TIMESTAMPING_OPT_STATS) &&
> @@ -5593,6 +5619,15 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>   	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
>   }
>   
> +static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype)
> +{
> +	u32 tsflags;
> +
> +	tsflags = READ_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);
> +	if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> +		return;
> +}
> +
>   void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   		     const struct sk_buff *ack_skb,
>   		     struct skb_shared_hwtstamps *hwtstamps,
> @@ -5601,6 +5636,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   	if (!sk)
>   		return;
>   
> +	if (static_branch_unlikely(&bpf_tstamp_control))
> +		bpf_skb_tstamp_tx_output(sk, tstype);
> +
>   	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
>   }
>   EXPORT_SYMBOL_GPL(__skb_tstamp_tx);



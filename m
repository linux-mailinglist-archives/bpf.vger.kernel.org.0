Return-Path: <bpf+bounces-41291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D5D99578C
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 21:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBCC1F2749B
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A70213ED5;
	Tue,  8 Oct 2024 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a6yidexo"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0571E0E1F
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415124; cv=none; b=K06+zhsCjm7hqGWuLmqo9sJs86YQSTcEKnJZFnR7KifSbKJa2PXLEYrAr0fIJvCnkh7GenURaLEaLYsNzigEEzvcGJSBZF0n8RsLMp9j6+TWVU4ucs4CFt5GrYSTL8BftX/mL58Xu9WxrycoVmDNSl0fzfCSlS2qkgsS/kujOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415124; c=relaxed/simple;
	bh=4e3ZyJ946/a8IGayyyot71L35q/b0H/g/kBrvtYyG44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSM7PYMVeyuarh0bny5EkghfkSwlbcEIYNosEFx93Sa6YpJWr8xB2O0v+6Ooteu/E42wVOMwXpvxosZMl4mot7Cb7XtTtNyv2UdwezX9fUbHGP5s5PMBqpvdjCtm+LOCMZP4PRINaB1/irQyS1Qja31ssVqZpAypYTesWC3dF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a6yidexo; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b82d7025-188d-41dc-a70c-06aa0fb26d24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728415119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SWVg3zL/h4T62buX0koYHwbo1qzAZs3fNEWdA/s+Rg=;
	b=a6yidexo/IsQR0NNdg08OHlwU7PVyt6yn7LR6l3kb0gvlm/Du5S3HvT6JQJEqAEleBBlMx
	8SonDdEO0Jczk/A24jGBlz6wo52EKSyeod2R4TaYndTJV/PhIttnw+j0LpZWMF8ZZvKgJq
	BnNdyT6dGO6LYlz5LQRvANu+jyieyoc=
Date: Tue, 8 Oct 2024 20:18:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 5/9] net-timestamp: ready to turn on the button
 to generate tx timestamps
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-6-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241008095109.99918-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/10/2024 10:51, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Once we set BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG flag here, there
> are three points in the previous patches where generating timestamps
> works. Let us make the basic bpf mechanism for timestamping feature
>   work finally.
> 
> We can use like this as a simple example in bpf program:
> __section("sockops")
> 
> case BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB:
> 	dport = bpf_ntohl(skops->remote_port);
> 	sport = skops->local_port;
> 	skops->reply = SOF_TIMESTAMPING_TX_SCHED;
> 	bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG);
> case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> 	bpf_printk(...);
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/uapi/linux/bpf.h       |  8 ++++++++
>   net/ipv4/tcp.c                 | 27 ++++++++++++++++++++++++++-
>   tools/include/uapi/linux/bpf.h |  8 ++++++++
>   3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1b478ec18ac2..6bf3f2892776 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7034,6 +7034,14 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TX_TS_OPT_CB,	/* Called when the last skb from
> +					 * sendmsg is going to push when
> +					 * SO_TIMESTAMPING feature is on.
> +					 * Let user have a chance to switch
> +					 * on BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG
> +					 * flag for other three tx timestamp
> +					 * use.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 82cc4a5633ce..ddf4089779b5 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -477,12 +477,37 @@ void tcp_init_sock(struct sock *sk)
>   }
>   EXPORT_SYMBOL(tcp_init_sock);
>   
> +static u32 bpf_tcp_tx_timestamp(struct sock *sk)
> +{
> +	u32 flags;
> +
> +	flags = tcp_call_bpf(sk, BPF_SOCK_OPS_TX_TS_OPT_CB, 0, NULL);
> +	if (flags <= 0)
> +		return 0;
> +
> +	if (flags & ~SOF_TIMESTAMPING_MASK)
> +		return 0;
> +
> +	if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
> +		return 0;
> +
> +	return flags;
> +}
> +
>   static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>   {
>   	struct sk_buff *skb = tcp_write_queue_tail(sk);
>   	u32 tsflags = sockc->tsflags;
> +	u32 flags;
> +
> +	if (!skb)
> +		return;
> +
> +	flags = bpf_tcp_tx_timestamp(sk);
> +	if (flags)
> +		tsflags = flags;

In this case it's impossible to clear timestamping flags from bpf
program, but it may be very useful. Consider providing flags from
socket cookie to the program or maybe add an option to combine them?

>   
> -	if (tsflags && skb) {
> +	if (tsflags) {
>   		struct skb_shared_info *shinfo = skb_shinfo(skb);
>   		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
>   
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index fc9b94de19f2..d3bf538846da 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7033,6 +7033,14 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TX_TS_OPT_CB,	/* Called when the last skb from
> +					 * sendmsg is going to push when
> +					 * SO_TIMESTAMPING feature is on.
> +					 * Let user have a chance to switch
> +					 * on BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG
> +					 * flag for other three tx timestamp
> +					 * use.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect



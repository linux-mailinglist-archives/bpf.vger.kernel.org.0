Return-Path: <bpf+bounces-42136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3A399FDBE
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 03:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C3E1C27C31
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 01:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6497B15B10E;
	Wed, 16 Oct 2024 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p9sncRBS"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01015478E
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040501; cv=none; b=nerEd2xFQZ7RMkwrKI2K7lCOWmczWFuDnVdNrOVhXdbl95jqhdpF3A2ZcsbPXoct2Sad3pYWBs0QdTPVp+Mtg/5i6hu9v71H3rx6lQoQeCp3vVxljw/Dgt7IWV5cg6e/pwnzJRCwAqmnoy9cWKfl3B3ENEMDdOoIJWVrWXwmBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040501; c=relaxed/simple;
	bh=UhJQ20276+wCQLVdmkTazIjsjskEUth8Bgtwk9llFLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvrlwAQxaieS0ovHFKXhDfHS3jmX3lQekDpHzD5Oq6ipodc16TKNfqhMkiJt4uufd2yJFoC9AHf4DJfNaLV89wQzN6gi+IoNNiQvKz0YV8/tvmX1DSjuPWNeefckm8TVxy9PZREmQFJa263LuXoA3YiP71QhgCApQC4PP6Aq2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p9sncRBS; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4767fab-9c61-49f0-8185-6445349ae30b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729040496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPdwG9pHPiWTE2rtTkLbAlDmqGXFuooyI1m6EGMgO0s=;
	b=p9sncRBSDIhBgnM8NZh2IyDcXXKtRjpGgU0dNMfqSXvJrptAsuPt9jBbDEACpqUzkporAk
	EEcLKecuKQGhZiGYEu3kg+2dlwaLmPpfY/dT/GRLwPidXNnM1m1nxjSnzsJH9wU0jscGVP
	A8qVIx1wKZ+kXIfzp0guN7mLr6up6+8=
Date: Tue, 15 Oct 2024 18:01:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 06/12] net-timestamp: introduce
 TS_SCHED_OPT_CB to generate dev xmit timestamp
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-7-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241012040651.95616-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/11/24 9:06 PM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Introduce BPF_SOCK_OPS_TS_SCHED_OPT_CB flag so that we can decide to
> print timestamps when the skb just passes the dev layer.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/uapi/linux/bpf.h       |  5 +++++
>   net/core/skbuff.c              | 17 +++++++++++++++--
>   tools/include/uapi/linux/bpf.h |  5 +++++
>   3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 157e139ed6fc..3cf3c9c896c7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7019,6 +7019,11 @@ enum {
>   					 * by the kernel or the
>   					 * earlier bpf-progs.
>   					 */
> +	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
> +					 * dev layer when SO_TIMESTAMPING
> +					 * feature is on. It indicates the
> +					 * recorded timestamp.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 3a4110d0f983..16e7bdc1eacb 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5632,8 +5632,21 @@ static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype)
>   		return;
>   
>   	tp = tcp_sk(sk);
> -	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG))
> -		return;
> +	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)) {
> +		struct timespec64 tstamp;
> +		u32 cb_flag;
> +
> +		switch (tstype) {
> +		case SCM_TSTAMP_SCHED:
> +			cb_flag = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> +			break;
> +		default:
> +			return;
> +		}
> +
> +		tstamp = ktime_to_timespec64(ktime_get_real());
> +		tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_nsec);

There is bpf_ktime_get_*() helper. The bpf prog can directly call the 
bpf_ktime_get_* helper and use whatever clock it sees fit instead of enforcing 
real clock here and doing an extra ktime_to_timespec64. Right now the 
bpf_ktime_get_*() does not have real clock which I think it can be added.

I think overall the tstamp reporting interface does not necessarily have to 
follow the socket API. The bpf prog is running in the kernel. It could pass 
other information to the bpf prog if it sees fit. e.g. the bpf prog could also 
get the original transmitted tcp skb if it is useful.

> +	}
>   }
>   
>   void __skb_tstamp_tx(struct sk_buff *orig_skb,
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 93853d9d4922..d60675e1a5a0 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7018,6 +7018,11 @@ enum {
>   					 * by the kernel or the
>   					 * earlier bpf-progs.
>   					 */
> +	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
> +					 * dev layer when SO_TIMESTAMPING
> +					 * feature is on. It indicates the
> +					 * recorded timestamp.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect



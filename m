Return-Path: <bpf+bounces-51325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E985A33349
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 00:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06513A6943
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5046211715;
	Wed, 12 Feb 2025 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lsVVkrl5"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2A2063F4
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402441; cv=none; b=nZktLT79bVciN4PuzQxa1MQf3SQCbfwfsvKe/MxcY9wtOqwS/JTFf/PfsVO5Vhu64fQ9I2CVZ4PVfDABKKsa1HEFxZOnBdhHdvRvteyOaIHpK7xliU9AyhW2mkkhrkouP1E5O3oe4eMqR4F8EFEbzfTh6r5mJlri8n6MLjWZsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402441; c=relaxed/simple;
	bh=me9sUFzzKiqtmzMmiRW/89bjMW7AZjjPF5usrFDkPpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpqJ5HMt5SfW+G6bJlPydhGw/Dno1j/52x7xr2NY3p7JaUg8a6+l8J/lBI0MjVODkcZqCfuEQo38v9qay6NHxwG+EeGuemgzniSbl9+uafFIiNVFUpUOZM/ZbmekHRJgfDLH6EgYJxIMHiZnuPX0fTrQxgN2QZMUOQafdLNYxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lsVVkrl5; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <216c663c-1a7a-4db7-9973-afba485f797e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739402427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4CqDO5gqWThJvaT5uK1DRJu+QuHZ7pSZV6mBfZAlhM=;
	b=lsVVkrl5lYPuFqEB00iU1qwfYDHyYHuTJyNS1JLStFo+E1RlJNlkCABqGzE7JMmntTgRSQ
	MtvPRyCakoq9mDehvDxXr8HSm9DbSBwsVwpROkz3tX9S185kLRmcXm/0rIFPYbCrTt9tvZ
	+0lCb+2dFWEmHxVRstr5kRq78G1T8Ns=
Date: Wed, 12 Feb 2025 15:20:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB
 callback
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-9-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250212061855.71154-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/11/25 10:18 PM, Jason Xing wrote:
> Support hw SCM_TSTAMP_SND case for bpf timestamping.
> 
> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> callback will occur at the same timestamping point as the user
> space's hardware SCM_TSTAMP_SND. The BPF program can use it to
> get the same SCM_TSTAMP_SND timestamp without modifying the
> user-space application.
> 
> To avoid increase the code complexity, replace SKBTX_HW_TSTAMP
> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
> from driver side using SKBTX_HW_TSTAMP. The new definition of
> SKBTX_HW_TSTAMP means the combination tests of socket timestamping
> and bpf timestamping. After this patch, drivers can work under the
> bpf timestamping.
> 
> Considering some drivers doesn't assign the skb with hardware
> timestamp, this patch do the assignment and then BPF program
> can acquire the hwstamp from skb directly.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/linux/skbuff.h         | 4 +++-
>   include/uapi/linux/bpf.h       | 4 ++++
>   net/core/skbuff.c              | 6 +++---
>   tools/include/uapi/linux/bpf.h | 4 ++++
>   4 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 76582500c5ea..0b4f1889500d 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -470,7 +470,7 @@ struct skb_shared_hwtstamps {
>   /* Definitions for tx_flags in struct skb_shared_info */
>   enum {
>   	/* generate hardware time stamp */
> -	SKBTX_HW_TSTAMP = 1 << 0,
> +	SKBTX_HW_TSTAMP_NOBPF = 1 << 0,
>   
>   	/* generate software time stamp when queueing packet to NIC */
>   	SKBTX_SW_TSTAMP = 1 << 1,
> @@ -494,6 +494,8 @@ enum {
>   	SKBTX_BPF = 1 << 7,
>   };
>   
> +#define SKBTX_HW_TSTAMP		(SKBTX_HW_TSTAMP_NOBPF | SKBTX_BPF)
> +
>   #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
>   				 SKBTX_SCHED_TSTAMP | \
>   				 SKBTX_BPF)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b3bd92281084..f70edd067edf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7043,6 +7043,10 @@ enum {
>   					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
>   					 * feature is on.
>   					 */
> +	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
> +					 * SK_BPF_CB_TX_TIMESTAMPING feature
> +					 * is on.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d80d2137692f..4930c43ee77b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5547,7 +5547,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
>   	case SCM_TSTAMP_SCHED:
>   		return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
>   	case SCM_TSTAMP_SND:
> -		return skb_shinfo(skb)->tx_flags & (hwts ? SKBTX_HW_TSTAMP :
> +		return skb_shinfo(skb)->tx_flags & (hwts ? SKBTX_HW_TSTAMP_NOBPF :
>   						    SKBTX_SW_TSTAMP);
>   	case SCM_TSTAMP_ACK:
>   		return TCP_SKB_CB(skb)->txstamp_ack;
> @@ -5568,9 +5568,9 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
>   		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>   		break;
>   	case SCM_TSTAMP_SND:
> +		op = hwts ? BPF_SOCK_OPS_TS_HW_OPT_CB : BPF_SOCK_OPS_TS_SW_OPT_CB;

Remove this "hwts" test.

>   		if (hwts)

Reuse this and do everything in this "if else" statement.

> -			return;
> -		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
> +			*skb_hwtstamps(skb) = *hwts;
>   		break;
>   	default:
>   		return;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 9bd1c7c77b17..7b9652ce7e3c 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7033,6 +7033,10 @@ enum {
>   					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
>   					 * feature is on.
>   					 */
> +	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
> +					 * SK_BPF_CB_TX_TIMESTAMPING feature
> +					 * is on.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect



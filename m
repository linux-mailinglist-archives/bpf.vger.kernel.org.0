Return-Path: <bpf+bounces-64572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297E2B1458A
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 03:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5185417C2CF
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 01:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661871946AA;
	Tue, 29 Jul 2025 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5+sfeZd"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD03C38
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751147; cv=none; b=hbu30NYTgu3IRql0A1oxNkcqhx4OBjxZltg6XfP1Tz+CB8U2eTwF48F8Hd6WMpJfGcOmTGTxJn+vnt4ax9K0YPNcOF392xFApUvKuvvv6MtC7AVYYKC6igsNu3e6gvuWrR5dQf9Fmi/JborDcJCMcpNLit+HBru2bJ8XLjwlTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751147; c=relaxed/simple;
	bh=7VKZ22ymvE1qR2Je4hYimjGdZHOaHj6ErYIB16GKhT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwEM29G49UbOy7PVQzk8odXRom1Cb6zIK7r2JpEVNGS5nspxv7XR44wH2PJLN6hh5gfqkK2+FHck4RGpsSC+8DhRrFrLToa8gu0NTTx14/e8h5A2p1UX88GQ49qONohonLQu5IX7iHUH4umoh0Bjq2x4MAtw2G5y1g+mY9N1ryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5+sfeZd; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3f25e61-7b0c-4576-baae-9b498c3b8748@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753751133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IYY06TwHJU1yH0y4CfYISRGqhDcJ8AL5MaZbCvCfeA=;
	b=C5+sfeZdfJYiqsUIVtzNbtOitLfUP0dsF/S2g34I0zqcTQJxNDmTjxNlTwkldEu2DKXz+S
	FtE4wg+Ldb7KzrvNDfFWfb4g7ki3YCVA44vM/8jGQ5PFEBGrMKI8IPHC5X/gx4jPUxrqJo
	SVu9k2n8jeVvsmM+3N3KtrueN1SWB1s=
Date: Mon, 28 Jul 2025 18:05:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/4] bpf: add bpf_icmp_send_unreach cgroup_skb
 kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
 fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 pablo@netfilter.org, lkp@intel.com
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <20250728094345.46132-4-mahe.tardy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250728094345.46132-4-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/28/25 2:43 AM, Mahe Tardy wrote:
> This is needed in the context of Tetragon to provide improved feedback
> (in contrast to just dropping packets) to east-west traffic when blocked
> by policies using cgroup_skb programs.
> 
> This reuse concepts from netfilter reject target codepath with the
> differences that:
> * Packets are cloned since the BPF user can still return SK_PASS from
>    the cgroup_skb progs and the current skb need to stay untouched

This needs more details. Which field(s) of the skb are changed by the kfunc, the 
skb_dst_set in ip[6]_route_reply_fetch_dst() and/or the code path in the 
icmp[v6]_send() ?

>    (cgroup_skb hooks only allow read-only skb payload).
> * Since cgroup_skb programs are called late in the stack, checksums do
>    not need to be computed or verified, and IPv4 fragmentation does not
>    need to be checked (ip_local_deliver should take care of that
>    earlier).
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>   net/core/filter.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7a72f766aacf..050872324575 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -85,6 +85,10 @@
>   #include <linux/un.h>
>   #include <net/xdp_sock_drv.h>
>   #include <net/inet_dscp.h>
> +#include <linux/icmp.h>
> +#include <net/icmp.h>
> +#include <net/route.h>
> +#include <net/ip6_route.h>
> 
>   #include "dev.h"
> 
> @@ -12148,6 +12152,53 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
>   	return 0;
>   }
> 
> +__bpf_kfunc int bpf_icmp_send_unreach(struct __sk_buff *__skb, int code)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)__skb;
> +	struct sk_buff *nskb;
> +
> +	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
> +		if (code < 0 || code > NR_ICMP_UNREACH)
> +			return -EINVAL;
> +
> +		nskb = skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (ip_route_reply_fetch_dst(nskb) < 0) {
> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		icmp_send(nskb, ICMP_DEST_UNREACH, code, 0);
> +		kfree_skb(nskb);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> +			return -EINVAL;
> +
> +		nskb = skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (ip6_route_reply_fetch_dst(nskb) < 0) {

 From a very quick look at icmpv6_send(), it does its own route lookup. I 
haven't looked at the v4 yet.

I am likely missing some details. Can you explain why it needs to do a lookup 
before calling icmpv6_send()?

> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);
> +		kfree_skb(nskb);
> +		break;
> +#endif
> +	default:
> +		return -EPROTONOSUPPORT;
> +	}
> +
> +	return SK_DROP;
> +}
> +


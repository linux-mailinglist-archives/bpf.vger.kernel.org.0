Return-Path: <bpf+bounces-55117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B550A78629
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 03:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331B13ADE7D
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 01:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8763BA4A;
	Wed,  2 Apr 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dUJcYfMI"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ADED299
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743557665; cv=none; b=B9Y7rhJXE862W/HTASTD+wZEerk6vd8+LPNcfDa4CZ4ZNHqJvjXtAZSIrtoMHh7focL6lgtWH9lx64QoCyaEhgCVNJh5mMaAoRkKhRXklM5mz8MbYAQx6ANOIzPXI+/Q1qxD3mww10Kehglw7He8LYkqw+bRUehDX5ZNFH5xAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743557665; c=relaxed/simple;
	bh=1XEg1ZhOSo3mMFVechjXZ0RH9HpqB+kMrUaW/IfuaDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hp7/cO9zPAVOnln1OZfATkt6aAH7HLdIoBo0DbVYNJ0Q9FlxZSnrGyGPaP9s42AMg2RxQFlIPBnzb1Bf6AsOqpxE01PJLaHb2w7j2aikir80Csx958MPLeZ7Ye7Fm52AXwGqIugHDPCBwAFaBt6uTaNh5eqgMARFjUBAPp3T/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dUJcYfMI; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3546b79d-a09b-4971-abd7-ce18696a9536@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743557649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfFIVO3LbH6/ZMehcO0cLuktmDdTAMYFlXMK39kPKXk=;
	b=dUJcYfMIJHabzGwG+QpRtGFpzzuIW2ucosZcwl0apviYUxR18ZWND+kfVl8IX3BKuKIozj
	+MdU4dMZkh4gcMT7oxTGq6f1h9EWBt58kJ9fSdyEwXkQs8PIoPXorAUTlqrsCEO5XL0ibJ
	PuyC5j0Ujk+9J9XX8FJ/qAU4HwwoZo0=
Date: Tue, 1 Apr 2025 18:34:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] [RFC] Bluetooth: enable bpf TX timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 kerneljasonxing@gmail.com
References: <cover.1743337403.git.pav@iki.fi>
 <bbd7fa454ed03ebba9bfe79590fb78a75d4f07db.1743337403.git.pav@iki.fi>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <bbd7fa454ed03ebba9bfe79590fb78a75d4f07db.1743337403.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/30/25 5:23 AM, Pauli Virtanen wrote:
> Emit timestamps also for BPF timestamping.
> 
> ***
> 
> The tskey management here is not quite right: see cover letter.
> ---
>   include/net/bluetooth/bluetooth.h |  1 +
>   net/bluetooth/hci_conn.c          | 21 +++++++++++++++++++--
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index bbefde319f95..3b2e59cedd2d 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -383,6 +383,7 @@ struct bt_sock {
>   	struct list_head accept_q;
>   	struct sock *parent;
>   	unsigned long flags;
> +	atomic_t bpf_tskey;
>   	void (*skb_msg_name)(struct sk_buff *, void *, int *);
>   	void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
>   };
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 95972fd4c784..7430df1c5822 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -28,6 +28,7 @@
>   #include <linux/export.h>
>   #include <linux/debugfs.h>
>   #include <linux/errqueue.h>
> +#include <linux/bpf-cgroup.h>
>   
>   #include <net/bluetooth/bluetooth.h>
>   #include <net/bluetooth/hci_core.h>
> @@ -3072,6 +3073,7 @@ void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
>   			    const struct sockcm_cookie *sockc)
>   {
>   	struct sock *sk = skb ? skb->sk : NULL;
> +	bool have_tskey = false;
>   
>   	/* This shall be called on a single skb of those generated by user
>   	 * sendmsg(), and only when the sendmsg() does not return error to
> @@ -3096,6 +3098,20 @@ void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
>   
>   			skb_shinfo(skb)->tskey = key - 1;
>   		}
> +		have_tskey = true;
> +	}
> +
> +	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
> +		struct bt_sock *bt_sk = container_of(sk, struct bt_sock, sk);
> +		int key = atomic_inc_return(&bt_sk->bpf_tskey);

I don't think it needs to add "atomic_t bpf_tskey". Allow the bpf to decide what 
the skb_shinfo(skb)->tskey should be if it is not set by the userspace.

> +
> +		if (!have_tskey)
> +			skb_shinfo(skb)->tskey = key - 1;
> +
> +		bpf_skops_tx_timestamping(sk, skb,
> +					  BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
> +
>   	}
>   }
>   




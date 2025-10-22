Return-Path: <bpf+bounces-71722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CE3BFC1D7
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF7375688A8
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50E3446CB;
	Wed, 22 Oct 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="aThXpps5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3B3128D6
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138758; cv=none; b=K2wPsKeWo7BQF29qSOcrlP4iSckcCt2PXwqvI+0twJqMGQstjcq8mX7qL/FzPgQB2ePYIeK6KDL+ZtEnqbca8Kpa69v1Bt+7Zdz2tVqoSZ+RNH1dpS9RkbCRew8RsqTQsXjlGYPChICGk09JNT0SPg7QYZKNbr9H/XsJQPBBLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138758; c=relaxed/simple;
	bh=j3EF8nNJ/B9fiL+MTyUTkLmXu0Vakq9P0w0wWMyl9+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fd6YqxVpabXpwC6Y/gsbMJDRu0qfGlQ7rEbq+ndSSrze/gzI9WfV9/mMDXy0rLkDPJEC/dLNRkoZQpm+4hvKYLTxztw5dpbU9WsbeUbgS2zGhxFGB9G8vMA3Dzx9satdJH7LtZCB8D6HLwGIedKJmyfI6cc5ouSeLXkNDNgpv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=aThXpps5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso1227951066b.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761138755; x=1761743555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHTN18Q7bf9HuEpGxM5gwgS8Ai9rdnBZqd+2bHozBZM=;
        b=aThXpps5L9E6ExVx3fEdflsV0FLaA6cQe59+bAFCgHBONlgm36R0rwVb/EtAT4lxRa
         lNnNRNCX4xiserq3VnDP6Bxt63oCbThMlD+xRNOFEd53J9YK0rQ6gUltOeck8A3vMoDd
         1NuNy3z6cNes4e2SmhVHFDv5ByhKNlZLjk39aKlQWXU2ftTK03cEHU/MCV5ds37zdICl
         HqpuyM84qyg+55ixTn5id2LGhuRd96HjTcX5rXY5pLC9ZZp3x/X5lEZpglRmBas7MeE7
         ANQWMwEla3PYkB2DgiK5NowW+mRH3S1480Q2tOreFq91VqNxq+P0R/FL44wonNoFhSXn
         nNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138755; x=1761743555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHTN18Q7bf9HuEpGxM5gwgS8Ai9rdnBZqd+2bHozBZM=;
        b=YPanpPobWE6F96xxFoj3VvWwcVe2q+TuxqmyhBNQ3otgY1x20VyLMbIssJrZJhhTTF
         BbKcIDAqVrr/8HYaDycI9E70uDNeNAkzH/+bf8W2gqxkgGFRlekRbPo6Zeo86UzvjiVa
         3dn/Vr3vZJ/zdwX/twk1zvvAURNrBm89NhFgmJlfYGV+cQFdi4M7g+pOEkuFtgtMhFAb
         wVmQ7bdjwqgErA0r+rbtW+yTWxU5c9B/pcMEsy2DBPBWY8dDWC14/hEfHe8tCcorEl3e
         KNbieUxdGZZ5F0kG6ZoPaYzOFhq5TgIEh6gnZdTDHjlYJ6tAAlyHD95c+ngHy1BaIw/+
         0Qqg==
X-Gm-Message-State: AOJu0YzgSbeil3Ts5sOJXvB0V0Zn3Gkv1VdhJF8qqIFIcTNGLWvdMvyq
	zrYpQTgW6zznrNkAbPi0ZJ1e8rNApkek6PNdyopwvx3csj84/c487srCz6w7wbRLY/8=
X-Gm-Gg: ASbGncslyil/i9oDh7LNVnxxaePrwsKbJfibk25Xj+jZBURXfSMDpwdN0aQI8TnN1U0
	etrpxSFStbDUMGfznKcFaTvfixd3+2uCQwevEyNHsynumxgduGgds7Z4s8Mm6vZa5JXh5jxqNzM
	slkhYHU67lm1mGECuS/hSe/2OzMgLPudljc6if+vpGLpqrRpXzqqwzRJl8mpaZSYM+mZ3SQb6vI
	8jKgVywzvDXXimHL5ozxJv2i1Bh52+qSSD76wqOGFpUdHQN0O4jH10w+NtxFOMFWlLdBijijV1F
	adOJGtC8VMIe57yMqn0Groleid/IdKHbr8Zj8Hso5es/NxXuXWh1cfOmDzEMfi2VUh83tDxHHi/
	+eKuR/3sa1U87kTp8Z4FT7l0m3HjG7Eh38Ql9YlMC/qNG/l3L/mNxzqVa36NkKvwEhC9cbLBWJE
	UHjveAkK9dWXPjE/SW8fcoGf6jCUZ+JDUQPmydUol4fLY=
X-Google-Smtp-Source: AGHT+IGIuQw+jehYddpwQvtKHW8rXdJQLVUZLJZVXiNyMP5WwTi0mnqaJMU6oX4sCssI/dhS5MT2IA==
X-Received: by 2002:a17:907:7f8a:b0:b62:2352:5043 with SMTP id a640c23a62f3a-b6474940cd5mr2349929466b.46.1761138754630;
        Wed, 22 Oct 2025 06:12:34 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da2c5dsm1317274766b.15.2025.10.22.06.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:12:34 -0700 (PDT)
Message-ID: <57fb7b81-2ba9-4899-a110-10b4e3e637c9@blackwall.org>
Date: Wed, 22 Oct 2025 16:12:33 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 14/15] netkit: Add io_uring zero-copy support
 for TCP
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-15-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-15-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> This adds the last missing bit to netkit for supporting io_uring with
> zero-copy mode [0]. Up until this point it was not possible to consume
> the latter out of containers or Kubernetes Pods where applications are
> in their own network namespace.
> 
> Thus, as a last missing bit, implement ndo_queue_get_dma_dev() in netkit
> to return the physical device of the real rxq for DMA. This allows memory
> providers like io_uring zero-copy or devmem to bind to the physically
> mapped rxq in netkit.
> 
> io_uring example with eth0 being a physical device with 16 queues where
> netkit is bound to the last queue, iou-zcrx.c is binary from selftests.
> Flow steering to that queue is based on the service VIP:port of the
> server utilizing io_uring:
> 
>   # ethtool -X eth0 start 0 equal 15
>   # ethtool -X eth0 start 15 equal 1 context new
>   # ethtool --config-ntuple eth0 flow-type tcp4 dst-ip 1.2.3.4 dst-port 5000 action 15
>   # ip netns add foo
>   # ip link add type netkit peer numrxqueues 2
>   # ./pyynl/cli.py --spec ~/netlink/specs/netdev.yaml \
>                    --do bind-queue \
>                    --json "{"src-ifindex": $(ifindex eth0), "src-queue-id": 15, \
>                             "dst-ifindex": $(ifindex nk0), "queue-type": "rx"}"
>   {'dst-queue-id': 1}
>   # ip link set nk0 netns foo
>   # ip link set nk1 up
>   # ip netns exec foo ip link set lo up
>   # ip netns exec foo ip link set nk0 up
>   # ip netns exec foo ip addr add 1.2.3.4/32 dev nk0
>   [ ... setup routing etc to get external traffic into the netns ... ]
>   # ip netns exec foo ./iou-zcrx -s -p 5000 -i nk0 -q 1
> 
> Remote io_uring client:
> 
>   # ./iou-zcrx -c -h 1.2.3.4 -p 5000 -l 12840 -z 65536
> 
> We have tested the above against a Broadcom BCM957504 (bnxt_en)
> 100G NIC, supporting TCP header/data split.
> 
> Similarly, this also works for devmem which we tested using ncdevmem:
> 
>   # ip netns exec foo ./ncdevmem -s 1.2.3.4 -l -p 5000 -f nk0 -t 1 -q 1
> 
> And on the remote client:
> 
>   # ./ncdevmem -s 1.2.3.4 -p 5000 -f eth0
> 
> For Cilium, the plan is to open up support for the various memory providers
> for regular Kubernetes Pods when Cilium is configured with netkit datapath
> mode.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://kernel-recipes.org/en/2024/schedule/efficient-zero-copy-networking-using-io_uring [0]
> ---
>  drivers/net/netkit.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 75b57496b72e..a281b39a1047 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -282,6 +282,21 @@ static const struct ethtool_ops netkit_ethtool_ops = {
>  	.get_channels		= netkit_get_channels,
>  };
>  
> +static struct device *netkit_queue_get_dma_dev(struct net_device *dev, int idx)
> +{
> +	struct netdev_rx_queue *rxq, *peer_rxq;
> +	unsigned int peer_idx;
> +
> +	rxq = __netif_get_rx_queue(dev, idx);
> +	if (!rxq->peer)
> +		return NULL;
> +
> +	peer_rxq = rxq->peer;
> +	peer_idx = get_netdev_rx_queue_index(peer_rxq);
> +
> +	return netdev_queue_get_dma_dev(peer_rxq->dev, peer_idx);
> +}
> +
>  static int netkit_queue_create(struct net_device *dev)
>  {
>  	struct netkit *nk = netkit_priv(dev);
> @@ -307,7 +322,8 @@ static int netkit_queue_create(struct net_device *dev)
>  }
>  
>  static const struct netdev_queue_mgmt_ops netkit_queue_mgmt_ops = {
> -	.ndo_queue_create = netkit_queue_create,
> +	.ndo_queue_get_dma_dev		= netkit_queue_get_dma_dev,
> +	.ndo_queue_create		= netkit_queue_create,
>  };
>  
>  static struct net_device *netkit_alloc(struct nlattr *tb[],

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



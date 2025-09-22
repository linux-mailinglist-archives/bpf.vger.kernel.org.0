Return-Path: <bpf+bounces-69170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7873B8ED8A
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 05:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1B01896571
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 03:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C467C2ED14E;
	Mon, 22 Sep 2025 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmXD75D9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2F1E502
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758511092; cv=none; b=t0lAnUhRNfMzvJVF6dMZRoWyqPo+TiTZn/GBFmmNsWlXEh1SRjuRSZOV1f6y1TzQeaP91mFf+LOMObH5lYIJigadUh216a/3Z3re2DrRAZ5ejdwVIMwShbMjGgBf8w4HYM1+26jYn1cWfRSf4mGUT2sEVR4RBOcG5jZU6ATVakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758511092; c=relaxed/simple;
	bh=Ph+uWLCGKD1bmbxe+LAztGIQgFBCw27dZmlB5mwFZEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmuIxDGXOJetTvUMcTD8i9S/TbR00v0gPRDso0mU8ktxcFkmCt5or7zjwfdNLuibYdny3XtRziTvdlP+vv9LyXnVCA5pVP6rbXtJcQyMkl8NxGOwc77dSaLtcXiMQB9sT3TNrPbKKCIVgHr9/Opfm7qtCKPMh+VQeBcfvEuWsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmXD75D9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77e87003967so1145660b3a.1
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 20:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758511090; x=1759115890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iUHvODxkooLDweHKcKr09A7x667bzyJgI9c4VZRR8c=;
        b=kmXD75D9h7NMwdYw2Ki473o8cvnseFC82uhYIabkQw9tEpMRU+eJdhOiGBU5wFfnxX
         HaYpdlgAG0aFYkcZJO/zskpn8VN+re3GwAp5oZuCv9Jn5RgaL9lxJnc6gr7TkaA1abC7
         eUVXG3k/tb3TVbCkZjS30l9c/6BObztGZCfeMtjT2LFS+9PV7mFJ8FCNnUwHOqCezmqB
         1yleWjEOVg9nYCha9qO5Vp+bwkMpOO3oKNHS3LIkY3TJ3Rr1pr1wqZCUcIa7GCu+j8P+
         Q/I9fpUDsYYcqpwDl/ANWgjTlIx/mi6UEyUJEj9Op9SpColIJwGNPCxlGRNLpYmXWCnk
         zQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758511090; x=1759115890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9iUHvODxkooLDweHKcKr09A7x667bzyJgI9c4VZRR8c=;
        b=A9tI2xmfErKmHlTY65g0sMdjcd70zkQ/K6JZiZn2K1ApkMtpSqLEFBARGYVd2t7yhb
         A2CAbYleSxJON1k9VCn49IR+sievm7ZEoZ8FaZ4kWR7HziE/R2cQuYhvZBcl8Sj6ulri
         +Cl0MSX+CpYVUw4MHdOLYwlUOD76gZhLuFwHX1X8gRFYYTIoxXfE5bcM11qoldYkPzQY
         XOrWBQSSBPkOk7nIxMEKsuyc0yEc5E/20lnQI5G2ar6PDh/uSDFDK1BytkcTtyveuzTX
         HDgCGViMYoWe8IdCJ6ubhBFHDjHmxhY8qFdtm2Ap5P5jJxcLh+V0iaPWje/+xj5qJwKl
         zluA==
X-Gm-Message-State: AOJu0Yzbvm7HfWzbZHARxFsTyxXE2rAdjC1gl87R2eRBtKtM7Ll4PS1Q
	Kvw5K759zMm/sR657GeMKYihQz0yNHK9OCJUPmz2gShdc5ZQ75F+606i
X-Gm-Gg: ASbGncuFlZYTElF8J3ZZwIdQ3C7/duVMMZdCQO2bbAmBCR1ePpEVjaspwEghRyS9D1L
	ldZzzTlm5n/FLlZ/GloJ30Tk5ivMxB/whiZroMV1I17NykChiL9sCbZeoY4Ex0whdQaidt4qLo3
	yyaDIWofAXDPlu+q0n5RlTkfs0YghLSddq4e5lyN647JRowTqgvwqzUk6sIQEIhnbvTO2fMaWld
	F++aDdhcjDHn0YxOJXoxpXslLvB+gCtSxdn4Oqy/9YI1pcQBV6pUfjt3dfAfS4FYRiY0oQIygfD
	SNOb31vuXZxR3xUf+t2wIB/NMT5AYDACDbVyQoSA8zb+n40hjkEYz0mfgNjZddg1Pw4grD5ryox
	SjC738MThuB/8TCd0SAMIxRP7GOhfhf5Ro6s3BC0=
X-Google-Smtp-Source: AGHT+IGUnMuLX3CNPC3ftc8Zb06YGwLfjdbggPZFbtgpkuBBMPjAa4g7U8vjDP3D7ofMhRCkhG/1uQ==
X-Received: by 2002:a05:6a00:1143:b0:772:a5c:6eea with SMTP id d2e1a72fcca58-77e4e5c36ccmr15525849b3a.17.1758511090059;
        Sun, 21 Sep 2025 20:18:10 -0700 (PDT)
Received: from [100.82.110.62] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24739fsm11010663b3a.28.2025.09.21.20.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 20:18:09 -0700 (PDT)
Message-ID: <e9c6903c-e440-46b3-860e-8782bfe4efb2@gmail.com>
Date: Mon, 22 Sep 2025 11:17:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 18/20] netkit: Add io_uring zero-copy support for
 TCP
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>, yangzhenze@bytedance.com,
 Dongdong Wang <wangdongdong.6@bytedance.com>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-19-daniel@iogearbox.net>
From: zf <zf15750701@gmail.com>
In-Reply-To: <20250919213153.103606-19-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/9/20 05:31, Daniel Borkmann 写道:
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
>    # ethtool -X eth0 start 0 equal 15
>    # ethtool -X eth0 start 15 equal 1 context new
>    # ethtool --config-ntuple eth0 flow-type tcp4 dst-ip 1.2.3.4 dst-port 5000 action 15
>    # ip netns add foo
>    # ip link add numrxqueues 2 type netkit
>    # ynl-bind eth0 15 nk0
>    # ip link set nk0 netns foo
>    # ip link set nk1 up
>    # ip netns exec foo ip link set lo up
>    # ip netns exec foo ip link set nk0 up
>    # ip netns exec foo ip addr add 1.2.3.4/32 dev nk0
>    [ ... setup routing etc to get external traffic into the netns ... ]
>    # ip netns exec foo ./iou-zcrx -s -p 5000 -i nk0 -q 1
> 
> Remote io_uring client:
> 
>    # ./iou-zcrx -c -h 1.2.3.4 -p 5000 -l 12840 -z 65536
> 
> We have tested the above against a dual-port Nvidia ConnectX-6 (mlx5)
> 100G NIC as well as Broadcom BCM957504 (bnxt_en) 100G NIC, both
> supporting TCP header/data split. For Cilium, the plan is to open
> up support for io_uring in zero-copy mode for regular Kubernetes Pods
> when Cilium is configured with netkit datapath mode.
> 

 From what we have learned, mlx supports TCP header/data split starting 
from CX7, relying on the hw rx gro. I would like to ask, can CX6 use TCP 
header/data split? Can you share your CX6's mlx driver information and 
FW information? I will test it. If CX6 can support, this one is even 
better for me. Thanks.


> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://kernel-recipes.org/en/2024/schedule/efficient-zero-copy-networking-using-io_uring [0]
> ---
>   drivers/net/netkit.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 27ff84833f28..5129b27a7c3c 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -274,6 +274,21 @@ static const struct ethtool_ops netkit_ethtool_ops = {
>   	.get_channels		= netkit_get_channels,
>   };
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
>   static int netkit_queue_create(struct net_device *dev)
>   {
>   	struct netkit *nk = netkit_priv(dev);
> @@ -299,7 +314,8 @@ static int netkit_queue_create(struct net_device *dev)
>   }
>   
>   static const struct netdev_queue_mgmt_ops netkit_queue_mgmt_ops = {
> -	.ndo_queue_create = netkit_queue_create,
> +	.ndo_queue_get_dma_dev		= netkit_queue_get_dma_dev,
> +	.ndo_queue_create		= netkit_queue_create,
>   };
>   
>   static struct net_device *netkit_alloc(struct nlattr *tb[],



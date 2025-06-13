Return-Path: <bpf+bounces-60563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23527AD8085
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 03:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D146817FB1E
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC71DFE0B;
	Fri, 13 Jun 2025 01:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WbLF8tKE"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17592F4317;
	Fri, 13 Jun 2025 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779486; cv=none; b=VHuISwreBBL+bT8Wk8pU1+Zeho51ldKKGqYGd3h0Wkkuu4s1/rI424KEmUCMOvpnNvsHJNheja+j8q68C2GF7YMbXwrpdhzaQqEfzCfFauADytq5ix6DvM7HU8duzdryWkJFjdNhkprTqTC/hvkJfaNxtqgt8MdV5TVlEi8x2cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779486; c=relaxed/simple;
	bh=ZcmbzzIH8NfdZu2s5rxXHIEvUaPQzWN18XnMuRodkYo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=KJkYMdbIMwsGTLM7i/c+Nu0rq0RGrhYqmFPLzXeFTw9DyWP5wt9k/M8gdbmmqYLrmjxG1/gxBlznmW2JZrKuKIL6obEWQKWtyg7YXNTBoniHn+LCR+HItGBv060y/QEwGJincVLKoBpqWP7O+nYXmY1rPGFX7F+bnT5na4MB/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WbLF8tKE; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749779475; h=Message-ID:Subject:Date:From:To;
	bh=yDetjs0aIvL2AA6xb/B29yP5noh604GTkuav4SUpDZ0=;
	b=WbLF8tKET5waC7Zn6vhD/R1c7T7+n8h6quL13kTU4Eb80ihqCKf1CNWpoX9DGsrqDFlFY7M3PHRPBdiGo6g5L1je6AhARkvnTpVEsOocVJV/Y9VhxE54zvx7JqNBMVb0WV/5obOODdk/a0pGTHYS4TB2roOhe2Jxcljvn4XXVBI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wdik-bu_1749779474 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Jun 2025 09:51:15 +0800
Message-ID: <1749779468.7241242-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
Date: Fri, 13 Jun 2025 09:51:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 stable@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue,  3 Jun 2025 22:06:13 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. This commit instead returns
> XDP_DROP in that case.
>
> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..4c35324d6e5b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>  	ret = XDP_PASS;
>  	rcu_read_lock();
>  	prog = rcu_dereference(rq->xdp_prog);
> -	/* TODO: support multi buffer. */
> -	if (prog && num_buf == 1)
> -		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
> +	if (prog) {
> +		/* TODO: support multi buffer. */
> +		if (num_buf == 1)
> +			ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
> +						  stats);
> +		else
> +			ret = XDP_DROP;
> +	}
>  	rcu_read_unlock();
>
>  	switch (ret) {
> --
> 2.43.0
>


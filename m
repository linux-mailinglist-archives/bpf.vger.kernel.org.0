Return-Path: <bpf+bounces-61354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39FFAE5F2F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 10:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A2C16DFA7
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A58B259C98;
	Tue, 24 Jun 2025 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xq+e0shC"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9925178E;
	Tue, 24 Jun 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753618; cv=none; b=t7Qa11ztwit2T4SpkvORHYPuoZo3KdV98cq+sEq1V81hfKIYZX3uOdapuqA35hAh1lt/62BfflBxrLQVXrKO3XFNthYo3CX9d25HTHQW/m0o0R53P6SnDhrFRpi6dp02GhSXFGqaQQyOQlkCYf9mWS7NzzCIJCms61u5+x2aZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753618; c=relaxed/simple;
	bh=sGsf4i3YBdkKLiqYjEz90SpoxBUWvcqZ/WqYvmvx/Fg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=iAh4oXr4ErmhW39qMuGkMY6BAGcROVXh+SxWzyUuncvg6rRK6FWszRa/UxJ0PlpJl9nUrNzsK6iKQmTAfFK0ay7w57nHjff8vOVikyIw3u+iEGw3LUZPBlf9InP4pdOslJUa5MX1l1c5QmcrqstUOwkcGHiFX9IIlC6YNy50x2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xq+e0shC; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750753607; h=Message-ID:Subject:Date:From:To;
	bh=qETiyRDq01cZyiTdnYUireDBSsJWh8qcYkIgG1vIyng=;
	b=xq+e0shCKgtWhi3tEpP9KtOlwLTnHucP6OlrfyOpoNvh2XiqhpDpMRLdynbvfCAC9j9IjaLqsweTTXTS0wbg9hjd9gwYzf4r07OJSrLYrNKJtYlIQnM6qi5NtVic02umxj1ZJAjB8+2acmlb+Xfo/WT1ouJXAMh0X5YIpEnzwNk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Weg0EcI_1750753606 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Jun 2025 16:26:46 +0800
Message-ID: <1750753518.4877846-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 1/2] virtio-net: xsk: rx: fix the frame's length check
Date: Tue, 24 Jun 2025 16:25:18 +0800
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
 netdev@vger.kernel.org
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
 <20250621144952.32469-2-minhquangbui99@gmail.com>
In-Reply-To: <20250621144952.32469-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Sat, 21 Jun 2025 21:49:51 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> When calling buf_to_xdp, the len argument is the frame data's length
> without virtio header's length (vi->hdr_len). We check that len with
>
> 	xsk_pool_get_rx_frame_size() + vi->hdr_len
>
> to ensure the provided len does not larger than the allocated chunk
> size. The additional vi->hdr_len is because in virtnet_add_recvbuf_xsk,
> we use part of XDP_PACKET_HEADROOM for virtio header and ask the vhost
> to start placing data from
>
> 	hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
> not
> 	hard_start + XDP_PACKET_HEADROOM
>
> But the first buffer has virtio_header, so the maximum frame's length in
> the first buffer can only be
>
> 	xsk_pool_get_rx_frame_size()
> not
> 	xsk_pool_get_rx_frame_size() + vi->hdr_len
>
> like in the current check.
>
> This commit adds an additional argument to buf_to_xdp differentiate
> between the first buffer and other ones to correctly calculate the maximum
> frame's length.
>
> Fixes: a4e7ba702701 ("virtio_net: xsk: rx: support recv small mode")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..1eb237cd5d0b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1127,15 +1127,29 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  	}
>  }
>
> +/* Note that @len is the length of received data without virtio header */
>  static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> -				   struct receive_queue *rq, void *buf, u32 len)
> +				   struct receive_queue *rq, void *buf,
> +				   u32 len, bool first_buf)
>  {
>  	struct xdp_buff *xdp;
>  	u32 bufsize;
>
>  	xdp = (struct xdp_buff *)buf;
>
> -	bufsize = xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->hdr_len;
> +	/* In virtnet_add_recvbuf_xsk, we use part of XDP_PACKET_HEADROOM for
> +	 * virtio header and ask the vhost to fill data from
> +	 *         hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
> +	 * The first buffer has virtio header so the remaining region for frame
> +	 * data is
> +	 *         xsk_pool_get_rx_frame_size()
> +	 * While other buffers than the first one do not have virtio header, so
> +	 * the maximum frame data's length can be
> +	 *         xsk_pool_get_rx_frame_size() + vi->hdr_len
> +	 */
> +	bufsize = xsk_pool_get_rx_frame_size(rq->xsk_pool);
> +	if (!first_buf)
> +		bufsize += vi->hdr_len;
>
>  	if (unlikely(len > bufsize)) {
>  		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> @@ -1260,7 +1274,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>
>  		u64_stats_add(&stats->bytes, len);
>
> -		xdp = buf_to_xdp(vi, rq, buf, len);
> +		xdp = buf_to_xdp(vi, rq, buf, len, false);
>  		if (!xdp)
>  			goto err;
>
> @@ -1358,7 +1372,7 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
>
>  	u64_stats_add(&stats->bytes, len);
>
> -	xdp = buf_to_xdp(vi, rq, buf, len);
> +	xdp = buf_to_xdp(vi, rq, buf, len, true);
>  	if (!xdp)
>  		return;
>
> --
> 2.43.0
>


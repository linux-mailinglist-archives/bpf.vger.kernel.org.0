Return-Path: <bpf+bounces-55729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FFEA85DC6
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 14:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06F94E1AF0
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3B29DB6F;
	Fri, 11 Apr 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0bsYJyj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0A32367A4;
	Fri, 11 Apr 2025 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375558; cv=none; b=AIQH18Sg7bsFsPnVZkm0+Xbu7Z5FZ4xR7WriywCvelvRa3B35FYVqlYtju/ccBxuxCDVlYzBWHHCC5xRzAk2Q4GWIG+nh1/1qt/0U2a5n7EdK0OhXkif9TV2V1c/Vv8SMiAuoXYytYPlCrJrXJ63nABpiNbz00j5XSCoruoWb6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375558; c=relaxed/simple;
	bh=bSkPJ8/qWTjbtZdQV0b4Ft+vswd3/SD+ilwd5rK67a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuLQ54nEWUQ5YP2l1aiMbzVLk4kVuO8vQYN5sj1Qque7251KsSDyY4xUrWbRycf644QH9j2OvN5Inhwv/rFKNyI60MF7j7UpHSRr3chu1+MuVUsD4B+w914apG8dW+fAtm/jXUqQtKjrKj4wUUPovqz1cZ9y6OmZ8o0DAOxlRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0bsYJyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB121C4CEE2;
	Fri, 11 Apr 2025 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744375558;
	bh=bSkPJ8/qWTjbtZdQV0b4Ft+vswd3/SD+ilwd5rK67a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0bsYJyjeDr9QW2mZZ3pV5saI4j9fo0xqa97uz79HGZBMkxoTgYk8nyw4f9v7aK2+
	 zx5kYjCTAUQfsy7jmjqNYGoo/KoxPQQ/efMl2NB+zfHOOEBF0bZgYW2BtXu0y9yXdi
	 3d/CWlRenZw10eItUKw19Ly3qXvFsp/7LsDs0ExnXke6Db/RfHKroC6kypj/r4pso5
	 2WYHv4FBCQUinvpYJJysQGsdlf0JNCQA9HSCg5YHcWvNGo/4Sk2Jo/hb1dTImuTr7I
	 XFGnVCu5nIFjz8a8Hn0ZKVP+Id/Js8xsSARIe/3umGPlH3Cju8AyVzkYioTRKfxE5t
	 G7EAsVfXEgiug==
Date: Fri, 11 Apr 2025 13:45:53 +0100
From: Simon Horman <horms@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org, tom@herbertland.com,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
	kernel-team@cloudflare.com
Subject: Re: [PATCH net-next V2 1/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
Message-ID: <20250411124553.GD395307@horms.kernel.org>
References: <174412623473.3702169.4235683143719614624.stgit@firesoul>
 <174412627898.3702169.3326405632519084427.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174412627898.3702169.3326405632519084427.stgit@firesoul>

On Tue, Apr 08, 2025 at 05:31:19PM +0200, Jesper Dangaard Brouer wrote:
> In production, we're seeing TX drops on veth devices when the ptr_ring
> fills up. This can occur when NAPI mode is enabled, though it's
> relatively rare. However, with threaded NAPI - which we use in
> production - the drops become significantly more frequent.
> 
> The underlying issue is that with threaded NAPI, the consumer often runs
> on a different CPU than the producer. This increases the likelihood of
> the ring filling up before the consumer gets scheduled, especially under
> load, leading to drops in veth_xmit() (ndo_start_xmit()).
> 
> This patch introduces backpressure by returning NETDEV_TX_BUSY when the
> ring is full, signaling the qdisc layer to requeue the packet. The txq
> (netdev queue) is stopped in this condition and restarted once
> veth_poll() drains entries from the ring, ensuring coordination between
> NAPI and qdisc.
> 
> Backpressure is only enabled when a qdisc is attached. Without a qdisc,
> the driver retains its original behavior - dropping packets immediately
> when the ring is full. This avoids unexpected behavior changes in setups
> without a configured qdisc.
> 
> With a qdisc in place (e.g. fq, sfq) this allows Active Queue Management
> (AQM) to fairly schedule packets across flows and reduce collateral
> damage from elephant flows.
> 
> A known limitation of this approach is that the full ring sits in front
> of the qdisc layer, effectively forming a FIFO buffer that introduces
> base latency. While AQM still improves fairness and mitigates flow
> dominance, the latency impact is measurable.
> 
> In hardware drivers, this issue is typically addressed using BQL (Byte
> Queue Limits), which tracks in-flight bytes needed based on physical link
> rate. However, for virtual drivers like veth, there is no fixed bandwidth
> constraint - the bottleneck is CPU availability and the scheduler's ability
> to run the NAPI thread. It is unclear how effective BQL would be in this
> context.
> 
> This patch serves as a first step toward addressing TX drops. Future work
> may explore adapting a BQL-like mechanism to better suit virtual devices
> like veth.
> 
> Reported-by: Yan Zhai <yan@cloudflare.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Thanks Jesper,

It's very nice to see backpressure support being added here.

...

> @@ -874,9 +909,16 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct veth_xdp_tx_bq *bq,
>  			struct veth_stats *stats)
>  {
> +	struct veth_priv *priv = netdev_priv(rq->dev);
> +	int queue_idx = rq->xdp_rxq.queue_index;
> +	struct netdev_queue *peer_txq;
> +	struct net_device *peer_dev;
>  	int i, done = 0, n_xdpf = 0;
>  	void *xdpf[VETH_XDP_BATCH];
>  
> +	peer_dev = priv->peer;

I think you need to take into account RCU here.

Sparse says:

  .../veth.c:919:18: warning: incorrect type in assignment (different address spaces)
  .../veth.c:919:18:    expected struct net_device *peer_dev
  .../veth.c:919:18:    got struct net_device [noderef] __rcu *peer



> +	peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
> +
>  	for (i = 0; i < budget; i++) {
>  		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>  

...


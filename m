Return-Path: <bpf+bounces-60339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D666AAD5B5A
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E1417B7C5
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E41E25E8;
	Wed, 11 Jun 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sihKVevr"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DE5D8F0
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657672; cv=none; b=cQ3eMQUvSz3dtIiL/DZBq/cHAfoyfE6zvvYUQ1NS9kh36suoVFiwJeTfVy5KnjDMle6Xyzkc+Df2c83DTC05ct2TixsAyAKaTnCoSjlcqxmt94EOojwdpYIpsvDl74vDGlFkQAryWKSIh1uGr4TQZM0dMhAkl9FxrN2HoUlk0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657672; c=relaxed/simple;
	bh=TtsDf/QJtlDN97fwoDr+yit/yyQ3hDoNpMF9dQzmtRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oErmxw8+dtzcBH7NKO4jHOmlAM1yRMDgynfE1R7efTD1EEczWkQD1dvjh/JIReGl3PqYqvUbssZfkArMzdbKebqiF5P2zzSRYz5vHkfMhGCBTChd/M+oosGX2FAMTXKHz5cCCz62f8g4w9ftOr9TCIakgUF8vgdtNGfraxtcKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sihKVevr; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3beaf713-a08d-42d9-8543-c6df4ce4215b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749657658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSLOy4Sh83qorJq2r4e1MAb74f+zk1NYPpgD2kVl1Sk=;
	b=sihKVevrQ7PdW+C7Hw8Wv/FGhnuPkd3YnU6gwCfN1Fk/K7fEgK8hwYw9HYomfvbNFBcqBG
	/ooZF9aYWviHW0O/XeU24ldbHSTFrglgV6zII4SltjYMXYDNWHqG1juL703X8/ewvY+QFK
	KtsXZOeOwEU5pWOJB8+xBabuvVvL2Ec=
Date: Wed, 11 Jun 2025 09:00:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net V1] veth: prevent NULL pointer dereference in
 veth_xdp_rcv
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
References: <da1f2506-5cb0-446c-b623-dc8f74c53462@kernel.org>
 <174964557873.519608.10855046105237280978.stgit@firesoul>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <174964557873.519608.10855046105237280978.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/11/25 5:40 AM, Jesper Dangaard Brouer wrote:
> The veth peer device is RCU protected, but when the peer device gets
> deleted (veth_dellink) then the pointer is assigned NULL (via
> RCU_INIT_POINTER).
> 
> This patch adds a necessary NULL check in veth_xdp_rcv when accessing
> the veth peer net_device.
> 
> This fixes a bug introduced in commit dc82a33297fc ("veth: apply qdisc
> backpressure on full ptr_ring to reduce TX drops"). The bug is a race
> and only triggers when having inflight packets on a veth that is being
> deleted.
> 
> Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Closes: https://lore.kernel.org/all/fecfcad0-7a16-42b8-bff2-66ee83a6e5c4@linux.dev/
> Reported-by: syzbot+c4c7bf27f6b0c4bd97fe@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/683da55e.a00a0220.d8eae.0052.GAE@google.com/
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> Commit dc82a33297fc have reached Linus'es tree in v6.16-rc1~132^2~208^2.
> Thus, we can correct this before the release of v6.16.
> 
>   drivers/net/veth.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index e58a0f1b5c5b..a3046142cb8e 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -909,7 +909,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>   
>   	/* NAPI functions as RCU section */
>   	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
> -	peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
> +	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
>   
>   	for (i = 0; i < budget; i++) {
>   		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
> @@ -959,7 +959,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>   	rq->stats.vs.xdp_packets += done;
>   	u64_stats_update_end(&rq->stats.syncp);
>   
> -	if (unlikely(netif_tx_queue_stopped(peer_txq)))
> +	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
>   		netif_tx_wake_queue(peer_txq);
>   
>   	return done;
> 
> 

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thank you!


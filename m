Return-Path: <bpf+bounces-71936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE15C01F53
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3B319A7395
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961133858F;
	Thu, 23 Oct 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsf0rUtB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28AA33374C;
	Thu, 23 Oct 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231583; cv=none; b=EwA2+gky1HFSOvpSeVX6yhmkObaPVxrQzL2EWTndh9Gi29obz7oOV7dOFPJfEUMGe7HU6YXP5SHdMYoLRhL8jIkjjzPfciQD+2aIr7Lv5aAHWGSoXBs63XFmJ1x+g+Wm5m6wV82pR6APfLYqiqZMi35NZWbTpGxvt8q/BuV+oD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231583; c=relaxed/simple;
	bh=lKMjZEnsBGbGIh61081vB9iPnEfQ8hKP8DiN0/8/FAE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELvSgUy/l6wmlwldzg0F0JBr4BksBFAcpsZQJDFqNwaW0eGmkO1tOmLYP1kgTykyai7GE8eejcsd/7CxD8xc1sDh6rGrvR62JltexP0kp8YY43x4WX1Pt9MuBo17FZfZZloJVCJfReyZbR2U6F4f0JrvieINyVLqGVOIa832BmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsf0rUtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E47C4CEF7;
	Thu, 23 Oct 2025 14:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761231583;
	bh=lKMjZEnsBGbGIh61081vB9iPnEfQ8hKP8DiN0/8/FAE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Bsf0rUtBwndgCmheoDpUJxTbWvR9oRoTTg7Z+jlOqSqK1RT/G4me0KKU0FbTZa+Tf
	 6jCwD61Vvg6S/v8YQm2RoBOKO6qV45UkpNYqHXJ8xWdFabHWoOurODznbGV29o+Abx
	 pjfMDTTtl6oFx8rjOzdykWbQJst11EGPKWx54V4xaZiPuVzAit8mU0dPey9OtWPcUR
	 FuqdKgoOrnySQIxoG2dZtLGvYeTfYlXIBGdjxnpbmwrePoK52q1kEXEYIuvc5lwS/t
	 Ew0sT9U8M2WU7/Xarx9S6XSADA0cW16KabHx1HLhdnBNiXa1u5b0SuQFHBZwOIf6OP
	 tyiq4cZS+FKgQ==
Subject: [PATCH net V1 2/3] veth: stop and start all TX queue in netdev
 down/up
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, makita.toshiaki@lab.ntt.co.jp
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Date: Thu, 23 Oct 2025 16:59:37 +0200
Message-ID: <176123157775.2281302.5972243809904783041.stgit@firesoul>
In-Reply-To: <176123150256.2281302.7000617032469740443.stgit@firesoul>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The veth driver started manipulating TXQ states in commit
dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring
to reduce TX drops").

Other drivers manipulating TXQ states takes care of stopping
and starting TXQs in NDOs.  Thus, adding this to veth .ndo_open
and .ndo_stop.

Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 7b1a9805b270..3976ddda5fb8 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1404,6 +1404,9 @@ static int veth_open(struct net_device *dev)
 			return err;
 	}
 
+	netif_tx_start_all_queues(dev);
+	netif_tx_start_all_queues(peer);
+
 	if (peer->flags & IFF_UP) {
 		netif_carrier_on(dev);
 		netif_carrier_on(peer);
@@ -1423,6 +1426,10 @@ static int veth_close(struct net_device *dev)
 	if (peer)
 		netif_carrier_off(peer);
 
+	netif_tx_stop_all_queues(dev);
+	if (peer)
+		netif_tx_stop_all_queues(peer);
+
 	if (priv->_xdp_prog)
 		veth_disable_xdp(dev);
 	else if (veth_gro_requested(dev))




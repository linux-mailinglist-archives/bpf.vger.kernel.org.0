Return-Path: <bpf+bounces-78998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 012E7D23199
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 09:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8398E3018353
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA233469D;
	Thu, 15 Jan 2026 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CQvRYhVo"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A533067D;
	Thu, 15 Jan 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465590; cv=none; b=Icd9NwH9Igbg7a35qS0aXP5sRnkeb/495okbbVTWJbbKGx8Ohb79HPmzwtH2oo6ZdDSKnc4s1GIwHeRymW+XOaLvXpPROIj+7M+HPxW5Ms/YtEsEBxALhLJa9zrSwWp+nBrMj5paE0xDMS3DJTlueXGwQh+pOih12I/dMxkrFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465590; c=relaxed/simple;
	bh=X+fAQJYCVFN/4wjBtCV86TZygAIvlo9LSPEDfFQqNME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDh/DlLLI0t0+qpTjf2/lDm4H2xboKEt7BjYXMJrayDQgBmf3p3UsmannWDZG6PUW3BeISeFVIOKSXQouf+ZB5HWR5iEoHuTmOsC+ai2gIkz2xs7meuZJovNjjZof/sP84a0rLcbHz3fSjCT9U57MjZPireeQMl6SWd62s1TEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CQvRYhVo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kngns6zpPdIxPNPnaH5dVrul36nkFpnoz3iHrioC83Q=; b=CQvRYhVoIQXW9WPcoHHrK/3J1x
	GEFGOvc6FE2ibQxENAEXY593DvJGHX8AB+DxLwIU+beOWgUeM1IMdY/ht0bvLqhZl7Yivz66ZAZi6
	+A5vlzvjila8yhD0dQNjZTyFGYFX7SQE24cd2Oibq9bLKRzhSHGWjTWUnvGDDNy2KNIOW9t9dx89P
	AiMmo8z5hWp+P95kzPvJ6kp2H5eNg+FScpgVjk2gRBFIt0RzZychQDjlbS+o4j76tWbdqMLZIWDLI
	gAeWMPR00hMuBF05pXMgJg2tF6tzHERDv/wGbTKW6ZhU2RjgYAAD6mpxjyGxrrvAgFtczGaIwYlno
	WRNfF1ZQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vgIgH-000NqH-0g;
	Thu, 15 Jan 2026 09:26:13 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v7 07/16] xsk: Extend xsk_rcv_check validation
Date: Thu, 15 Jan 2026 09:25:54 +0100
Message-ID: <20260115082603.219152-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115082603.219152-1-daniel@iogearbox.net>
References: <20260115082603.219152-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27881/Thu Jan 15 08:25:08 2026)

xsk_rcv_check tests for inbound packets to see whether they match
the bound AF_XDP socket. Refactor the test into a small helper
xsk_dev_queue_valid and move the validation against xs->dev and
xs->queue_id there.

The fast-path case stays in place and allows for quick return in
xsk_dev_queue_valid. If it fails, the validation is extended to
check whether the AF_XDP socket is bound against a leased queue,
and if the case then the test is redone.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 410297b4ab48..15e54bb9f372 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -324,14 +324,37 @@ static bool xsk_is_bound(struct xdp_sock *xs)
 	return false;
 }
 
+static bool xsk_dev_queue_valid(const struct xdp_sock *xs,
+				const struct xdp_rxq_info *info)
+{
+	struct net_device *dev = xs->dev;
+	u32 queue_index = xs->queue_id;
+	struct netdev_rx_queue *rxq;
+
+	if (info->dev == dev &&
+	    info->queue_index == queue_index)
+		return true;
+
+	if (queue_index < dev->real_num_rx_queues) {
+		rxq = READ_ONCE(__netif_get_rx_queue(dev, queue_index)->lease);
+		if (!rxq)
+			return false;
+
+		dev = rxq->dev;
+		queue_index = get_netdev_rx_queue_index(rxq);
+
+		return info->dev == dev &&
+		       info->queue_index == queue_index;
+	}
+	return false;
+}
+
 static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	if (!xsk_is_bound(xs))
 		return -ENXIO;
-
-	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
+	if (!xsk_dev_queue_valid(xs, xdp->rxq))
 		return -EINVAL;
-
 	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
 		xs->rx_dropped++;
 		return -ENOSPC;
-- 
2.43.0



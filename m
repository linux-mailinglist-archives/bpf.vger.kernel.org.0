Return-Path: <bpf+bounces-78388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB6FD0C508
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D31307AF8B
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4233EB0E;
	Fri,  9 Jan 2026 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mtmQnUIB"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A633D4EC;
	Fri,  9 Jan 2026 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994024; cv=none; b=SNSg99Oqj+Z3n4pCmomYhvHIiV93nkAxMbDYHVamqG07OJBaQ/s/K1kPd9g1tL7bb6Lmy4gqxYfkTpP7rIg/7NPnNKTvkZ096M4yLpsi8whwVFs+u7P0b6K7KaXck6aM5oQwcfAsljyEPg2IgsyfJ20SmO96vvaoBPnZ5YpNshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994024; c=relaxed/simple;
	bh=1Tj2cU78U6Uqvupeim/+6m/jr/f90sGQupkBeHHca+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsMYNwrHvIx0pYV6dAe5fAS4iEeIQL0mvUQJBRjBoefSXvJ9mm3Z7MC8I755Ay4sXDfJV2c6rMXIphfVfyyEYOaQWw8JB4hcXDn/lVaV86nVY6FGw3SKEKbJbl4wZPtSwWstTSY4HjaRsv9/GF6aOCEVVzK5won4Jo2aj+g3rBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mtmQnUIB; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uXdCZyoZVljtyNiSMpjIWzZRgp0/tQVh+jDLIVX7swA=; b=mtmQnUIBDXegCjZfkGpBUTzHNp
	Unz+mDEy7y90S1AsBExgljeq5FfMjahc6L2meaguNOY5V2DNhcqa69TEPKPjjNL7Q0EJJb6F0ruyF
	cFvZ287bB2+ceE2HI3qzw9ChsMBTwRj9HaizcZWXaHH7F8UzjmGtHd1mwvycK/u+BbtcXZGub1LW6
	3kqUIJo0mBWR0yichNn8UsSY16HbitkdOywqwVAitlP/Vo4HFw0/bqcaEuBrskrbB+bTCB4Yh795i
	RCGPGYzco9dw+4tPwVPHNZG22+OPr3SJuMJoIukNa14rDTLw0D4KiRfOvd7KWauOVeLIk6l8xx09E
	ISxRrPKA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1veK0I-00053n-19;
	Fri, 09 Jan 2026 22:26:42 +0100
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
Subject: [PATCH net-next v5 07/16] xsk: Extend xsk_rcv_check validation
Date: Fri,  9 Jan 2026 22:26:23 +0100
Message-ID: <20260109212632.146920-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109212632.146920-1-daniel@iogearbox.net>
References: <20260109212632.146920-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27875/Fri Jan  9 08:26:02 2026)

xsk_rcv_check tests for inbound packets to see whether they match the bound
AF_XDP socket. Refactor the test into a small helper xsk_dev_queue_valid and
move the validation against xs->dev and xs->queue_id there. The fast-path
case stays in place and allows for quick return in xsk_dev_queue_valid. If
it fails, the validation is extended to check whether the AF_XDP socket is
bound against a leased queue, and if the case then the test is redone.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 410297b4ab48..d95c481338c6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -324,14 +324,31 @@ static bool xsk_is_bound(struct xdp_sock *xs)
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
+	rxq = READ_ONCE(__netif_get_rx_queue(dev, queue_index)->lease);
+	if (!rxq)
+		return false;
+
+	return info->dev == rxq->dev &&
+	       info->queue_index == get_netdev_rx_queue_index(rxq);
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



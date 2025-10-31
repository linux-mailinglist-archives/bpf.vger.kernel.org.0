Return-Path: <bpf+bounces-73190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F349C27010
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCBA424552
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B979C3148AC;
	Fri, 31 Oct 2025 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MJmD1kJu"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8A30CD98;
	Fri, 31 Oct 2025 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945693; cv=none; b=ogOvPae8qex7fnBbkjJ2N280SWJRdsqBBpl2STAHrVBU92rX2x5l6NtP0MLasT7NQz+zGPgTMV0bzlRqkNd6b2RSHOsVWwpQc/bsAkqjotqKjTTnwCXlIh0v9mke4jJ3N/pGNd2GFAE/DkHoh6zPfi/Hh262E+h9TtQ8BZ9JENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945693; c=relaxed/simple;
	bh=Wu73lsr+AIZIozIAMk5uGbZq6C/TZ5dikIj4bVrKwFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEbWUMGkkhHDQnqZ46woR/LiVi7OrDiWfHtVFcpQJoPmXhQcJu+o3SXjBcjw+LFZ7z5kGtPUPhPyz7Avbxw6YU9kZFt1+Z6Fbzb4o/+JvEvNrkJRhInHkXmvwl1/MJEH4EcXbGJwKbrbMHk5zLvWesTypu7dUtHFC+Lcfp0DT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MJmD1kJu; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CC9GnH+IgpH+RWxzO9qvI21eQ7uf77c7n05WM9K2QGo=; b=MJmD1kJujGikbxfuFpQ2iEMPZR
	cJymLatYgM+CX+BeD+LF8trau0VYcwVtXx1MRbJoBNHHz7JCHgn65LSTJxnQSrI8uLpn9JbedeLnJ
	P4E5Jj+bb59PHIcIg6Dmt7mzaF8Y6i0cywnqdmre2QJHPyt39kHaEF4i4BYLm/zFxjMPtTOFdlR6f
	wbEg5vVCA/DbPB4+wpFWQaXQXdSIlCoexwPG98lDrAV0eUvXfHJmTw2FxYjsAWCZ8EumJwD+UoatF
	yt/Gq7wfzsfvXO9A0s7HRjLnDcaQiBLc4EM+4TdRSBnsPeEgdtLa08j7Sg7Z+LcCJwqTTXXDVLV4G
	zHoC9rkA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vEwYb-0005dH-11;
	Fri, 31 Oct 2025 22:21:13 +0100
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
Subject: [PATCH net-next v4 07/14] xsk: Extend xsk_rcv_check validation
Date: Fri, 31 Oct 2025 22:20:56 +0100
Message-ID: <20251031212103.310683-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031212103.310683-1-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27809/Fri Oct 31 10:42:21 2025)

xsk_rcv_check tests for inbound packets to see whether they match the bound
AF_XDP socket. Refactor the test into a small helper xsk_dev_queue_valid and
move the validation against xs->dev and xs->queue_id there. The fast-path
case stays in place and allows for quick return in xsk_dev_queue_valid. If
it fails, the validation is extended to check whether the AF_XDP socket is
bound against a peered queue, and if the case then the test is redone.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..6ae9ad5f27ad 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -331,14 +331,31 @@ static bool xsk_is_bound(struct xdp_sock *xs)
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
+	rxq = READ_ONCE(__netif_get_rx_queue(dev, queue_index)->peer);
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



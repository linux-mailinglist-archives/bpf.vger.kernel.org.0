Return-Path: <bpf+bounces-68989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EED5B8B66C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B37586E9D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE982D0617;
	Fri, 19 Sep 2025 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Z0L1yV1y"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46778209F43;
	Fri, 19 Sep 2025 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318644; cv=none; b=iGVjWg4zBGeCd1ZN171OCM7CZB31vodJFBpCICoweok4Sh16sf7cKHvn7FJSd7uIpUy4vAKQ2WQd8QboRPpcKwmXsjTXOGKc6wybhwZvtUHhk0k3uctH82ivyzRBlcUVXFTwux9i0xrF8LAJpJQ4HFhb3asSQgndhPn9minZsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318644; c=relaxed/simple;
	bh=z9+hnyLJBUgu0U/b4gQ6lL7NNVe/sk0pWDnqr/mCnY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX1rljHUwel5fhzVUm7oh7z7hZKLIVfQFu2h1iHewv79/uITZuiMgTVjTTDOwQtgp1P9z1Ky2Glu9UttBYRQgJRThv+YOcNAuF9yUQuzJpioAuRgX+qUE6iwQCZItOPmwr9xQFDZkef5Ns8oHNyFKZFq5S1TOgOdX5XDybqLr18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Z0L1yV1y; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FlJcHzf71ys8Z2SXuvZHqp61w0ciIQAC4/Tht+5NKT4=; b=Z0L1yV1y7obAQIbosA2mWslP5d
	Vk0DxfnQAKe4vgxcCBatv4OwN77DRI/Te571YOBiKII3oAkRlY9Utwft9a46B98o0m/6J8PixfNE5
	I6r82Cu2mKwXKCByY9CAE+jqZD4DFyEtLVYyp47R+EfZFZuht2UfG76zkFMnTT82ZbQb28d9Je3GN
	smBjl9ov/4DKhg3gOdhQPIMR0ND9Y6elRszvKNiSSkrBRJzGfCzKmzCfYS5jy03OAffp1hz1JWU35
	6x9EA42JHxFCRcurPGNm8BZlvUcbh3WrDU3zxIT3VZuZdEu0kGnDEQqJJlt40ya6JIUZXZxpa2bdg
	QfKcWDPg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzii6-000Ns3-10;
	Fri, 19 Sep 2025 23:32:06 +0200
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
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 12/20] xsk: Change xsk_rcv_check to check netdev/queue_id from pool
Date: Fri, 19 Sep 2025 23:31:45 +0200
Message-ID: <20250919213153.103606-13-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

Change the xsk_rcv_check test for inbound packets to use the xs->pool->netdev
and xs->pool->queue_id of the bound socket rather than xs->dev and xs->queue_id
since the latter could point to a virtual device with mapped rxq rather than
the physical backing device of the pool.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 82ad89f6ba35..cf40c70ee59f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -340,15 +340,13 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	if (!xsk_is_bound(xs))
 		return -ENXIO;
-
-	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
+	if (xs->pool->netdev   != xdp->rxq->dev ||
+	    xs->pool->queue_id != xdp->rxq->queue_index)
 		return -EINVAL;
-
 	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
 		xs->rx_dropped++;
 		return -ENOSPC;
 	}
-
 	return 0;
 }
 
-- 
2.43.0



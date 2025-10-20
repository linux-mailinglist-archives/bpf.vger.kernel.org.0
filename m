Return-Path: <bpf+bounces-71421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88630BF2659
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E10A34DEB4
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D5E289374;
	Mon, 20 Oct 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UeyGgnf3"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505F294A10;
	Mon, 20 Oct 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977464; cv=none; b=WSRscCZFF1tY5FIjBH4BFP1cTfKsUoHqMI3Bx6R4KqnEJD0/B+ZXCu7A89JmtKtyCLMrszOT3zxi63NL1iDndueCJP9Cyovt1eAWuxgwGe8K/Qm+EW84ls6r5LRmYTDf6UbwsOQnj3Okqsul3z4sFmesasFNBXh/oSEdhkD46UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977464; c=relaxed/simple;
	bh=OdkcLCeD99XL5md1owpcPM+ldZS5obh3dUjtpEqzPgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuD/FXT+GkcPAZdDYg/a5qCNCuRf+lzLiSPQL14hEUM0D1Ssem1Mh3Z8R1uQ126I3M0Z/1w4qCmFFUga2PVyNKIhlXQ7RFpVgRN8JVuLUAM1XOkzO309W5I4mR28AEQ9AHCtMWSuksUBsfpFydma9O0K8XjbO0VndlCBUemxJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UeyGgnf3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VOU8YA/WLiVWqyna2qWF3IA/KUiduL+6BE5o8MojQjI=; b=UeyGgnf3isUTKthb+dV+a9rjn2
	JZCJ5mCcM7GyalnNRV5Mb0e0d/e1lAVHzHT3BvL6xWtJnMJ6MKLRbm9fiTAwUdIsDX5RfT0vHwA/L
	U9wyhVdV8u9Nb1YFGL57L7P5q6ICFsy4xbj9v9w/RifrhQFb18avt4d7XRwT4PW/D39QkAvS5z17Q
	7dcFS0n6cPsgIl776sEDBSJ3PyhMbHradgumNU3+Mtq9aAPOe7ozQWLvKppcdUgGK86EoD44EC44i
	i7d8nc7HwkFtwIYVdW5fwtseX8/2/OqG0zzUGO1XAFbsCxHLgy+v6gAMRIrT7gOxhg7pXj04QjrsC
	12jrLmGQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAsg2-000Jkw-2d;
	Mon, 20 Oct 2025 18:24:06 +0200
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
Subject: [PATCH net-next v3 09/15] xsk: Change xsk_rcv_check to check netdev/queue_id from pool
Date: Mon, 20 Oct 2025 18:23:49 +0200
Message-ID: <20251020162355.136118-10-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020162355.136118-1-daniel@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27798/Mon Oct 20 11:37:28 2025)

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
index 0e9a385f5680..985e0cac965d 100644
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


